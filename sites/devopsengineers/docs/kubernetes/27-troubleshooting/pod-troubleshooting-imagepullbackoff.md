---
sidebar_position: 3
title: "Pod Troubleshooting: ImagePullBackOff"
---

# ImagePullBackOff: When Kubernetes Can't Pull Your Image

**ImagePullBackOff is frustrating. Your pod can't start because Kubernetes can't pull the container image. It's trying. It's failing. It's waiting. Here's how to fix it.**

## 🎯 The Big Picture

Think of ImagePullBackOff like a delivery truck that can't find your address. The truck is trying. It's looking. It can't find it. **The problem isn't that it's trying. The problem is why it can't find it.**

**ImagePullBackOff means Kubernetes can't pull the container image. Wrong name. Wrong registry. Authentication issue. Network problem. Here's how to fix it.**

## What is ImagePullBackOff?

**ImagePullBackOff is a pod state that means:**
1. Kubernetes tries to pull image
2. Image pull fails
3. Kubernetes waits (backoff period)
4. Kubernetes tries again
5. Image pull fails again
6. Repeat (with increasing backoff time)

**The backoff time increases:** 10s → 20s → 40s → 80s → 160s (max 300s)

## Understanding the ImagePullBackOff State

**Pod states you'll see:**
```
ImagePullBackOff  ← Final state (waiting before retry)
    ↓
ErrImagePull      ← Image pull failed
    ↓
ImagePullBackOff  ← Back to waiting
```

**The cycle continues until you fix the problem.**

## Step-by-Step Debugging Process

### Step 1: Identify the Problem Pod

```bash
kubectl get pods
```

**Look for:**
- Status: `ImagePullBackOff` or `ErrImagePull`
- Image pull errors

**Example output:**
```
NAME                    READY   STATUS             RESTARTS   AGE
my-app-abc123           0/1     ImagePullBackOff   0          2m
```

### Step 2: Describe the Pod

```bash
kubectl describe pod <pod-name>
```

**Look for:**
- **Events**: Image pull errors
- **Image**: What image is it trying to pull?
- **Error message**: Why did it fail?

**Key sections to check:**
```yaml
Events:
  Warning  Failed     2m ago   kubelet  Failed to pull image "my-app:v1": 
    rpc error: code = Unknown desc = Error response from daemon: 
    pull access denied for my-app, repository does not exist or may require 'docker login'
  
  Warning  Failed     2m ago   kubelet  Error: ErrImagePull
```

### Step 3: Check the Image Name

**Common issues:**
- Wrong image name
- Wrong tag
- Missing tag (defaults to `:latest`)
- Wrong registry

**Check the deployment:**
```bash
kubectl get deployment <deployment-name> -o yaml
# Look for image field
```

## Common Causes and Solutions

### Cause 1: Image Doesn't Exist

**Symptoms:**
- Error: "repository does not exist"
- Error: "manifest unknown"
- Image name is wrong

**Solutions:**
1. **Verify image exists:**
   ```bash
   docker pull <image-name>:<tag>
   # Or check Docker Hub/registry
   ```

2. **Check image name:**
   ```bash
   kubectl get pod <pod-name> -o yaml | grep image
   ```

3. **Fix the deployment:**
   - Correct the image name
   - Use correct tag
   - Verify registry

**Example fix:**
```yaml
# Wrong
image: my-app:v1

# Correct
image: myusername/my-app:v1.0.0
```

### Cause 2: Wrong Registry

**Symptoms:**
- Error: "repository does not exist"
- Image is in different registry
- Private registry not specified

**Solutions:**
1. **Specify full registry path:**
   ```yaml
   # Wrong
   image: my-app:v1
   
   # Correct (Docker Hub)
   image: docker.io/myusername/my-app:v1
   
   # Correct (Private registry)
   image: registry.example.com/my-app:v1
   ```

2. **Check registry accessibility:**
   ```bash
   docker pull registry.example.com/my-app:v1
   ```

### Cause 3: Authentication Required

**Symptoms:**
- Error: "pull access denied"
- Error: "unauthorized"
- Private registry requires login

**Solutions:**
1. **Create image pull secret:**
   ```bash
   kubectl create secret docker-registry regcred \
     --docker-server=<registry-url> \
     --docker-username=<username> \
     --docker-password=<password> \
     --docker-email=<email>
   ```

2. **Add secret to pod spec:**
   ```yaml
   apiVersion: v1
   kind: Pod
   spec:
     imagePullSecrets:
     - name: regcred
     containers:
     - name: app
       image: registry.example.com/my-app:v1
   ```

3. **Or add to service account:**
   ```yaml
   apiVersion: v1
   kind: ServiceAccount
   metadata:
     name: my-sa
   imagePullSecrets:
   - name: regcred
   ```

### Cause 4: Network Issues

**Symptoms:**
- Error: "network timeout"
- Error: "connection refused"
- Can't reach registry

**Solutions:**
1. **Check network connectivity:**
   ```bash
   kubectl run test --image=busybox --rm -it -- ping registry.example.com
   ```

2. **Check DNS:**
   ```bash
   kubectl run test --image=busybox --rm -it -- nslookup registry.example.com
   ```

3. **Check firewall rules:**
   - Ensure registry is accessible
   - Check network policies
   - Verify proxy settings

### Cause 5: Wrong Image Tag

**Symptoms:**
- Error: "manifest unknown"
- Tag doesn't exist
- Using `:latest` but image has no latest tag

**Solutions:**
1. **Check available tags:**
   ```bash
   # Docker Hub
   curl https://hub.docker.com/v2/repositories/<username>/<image>/tags/
   
   # Or use registry API
   ```

2. **Use correct tag:**
   ```yaml
   # Wrong
   image: my-app:latest
   
   # Correct
   image: my-app:v1.0.0
   ```

3. **Always specify tags:**
   - Avoid `:latest` in production
   - Use specific versions
   - Tag your images properly

### Cause 6: Image Pull Policy

**Symptoms:**
- Image not updating
- Using cached image
- `Always` policy not working

**Solutions:**
1. **Set image pull policy:**
   ```yaml
   containers:
   - name: app
     image: my-app:v1
     imagePullPolicy: Always  # Always pull
     # Or: IfNotPresent (default)
     # Or: Never (use local only)
   ```

2. **For production:**
   - Use `Always` for latest images
   - Use specific tags with `IfNotPresent`
   - Never use `Never` in production

## Real-World Example: Private Registry Authentication

**Problem:**
Pod in ImagePullBackOff. Error:
```
pull access denied for registry.example.com/my-app, repository does not exist or may require 'docker login'
```

**Debugging:**
1. **Checked image name:** Correct
2. **Checked registry:** Private registry requires authentication
3. **Created image pull secret:**
   ```bash
   kubectl create secret docker-registry regcred \
     --docker-server=registry.example.com \
     --docker-username=myuser \
     --docker-password=mypassword \
     --docker-email=my@email.com
   ```
4. **Updated deployment:**
   ```yaml
   spec:
     imagePullSecrets:
     - name: regcred
     containers:
     - name: app
       image: registry.example.com/my-app:v1
   ```
5. **Restarted deployment:** Pod started successfully

**Solution:** Authentication was required. Created secret. Added to pod spec. Fixed.

## Hands-On Exercise: Debug ImagePullBackOff

**Create a pod with wrong image:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: image-pull-test
spec:
  containers:
  - name: app
    image: this-image-does-not-exist:v999  # Will fail!
```

**Apply it:**
```bash
kubectl apply -f image-pull-test.yaml
```

**Debug it:**
1. Check pod status: `kubectl get pods`
2. Describe pod: `kubectl describe pod image-pull-test`
3. Check events: Look for image pull errors
4. Fix the issue (use correct image name)

**This is how you learn. Break things. Fix them.**

## My Take: ImagePullBackOff Debugging

ImagePullBackOff used to confuse me. I'd see it and not know why.

Then I learned the systematic approach:
1. **Describe the pod** - See the error message
2. **Check image name** - Is it correct?
3. **Check registry** - Is it accessible?
4. **Check authentication** - Is login required?
5. **Fix the root cause** - Not just retry

**Now I fix ImagePullBackOff in minutes, not hours.**

## Memory Tip: The Delivery Truck Analogy

ImagePullBackOff is like a delivery truck that can't find your address:
- **Truck is trying** (Kubernetes is trying)
- **Can't find address** (Image doesn't exist or wrong name)
- **Wrong address** (Wrong image name/registry)
- **Need key** (Authentication required)
- **Road blocked** (Network issue)

**The error message tells you why. Read it carefully.**

## Common Mistakes

1. **Not reading error message**: Error message tells you why
2. **Wrong image name**: Check spelling, registry, tag
3. **Missing authentication**: Private registries need secrets
4. **Using :latest**: Can cause issues, use specific tags
5. **Not checking network**: Registry might be unreachable

## Key Takeaways

1. **ImagePullBackOff means can't pull image** - Find why
2. **Check error message** - It tells you the problem
3. **Verify image exists** - Check name, tag, registry
4. **Check authentication** - Private registries need secrets
5. **Fix the root cause** - Not just retry

## What's Next?

Now that you understand ImagePullBackOff, let's tackle another common issue. Next: [Pod Troubleshooting: Pending Pods](/docs/kubernetes/27-troubleshooting/pod-troubleshooting-pending).

---

> **Remember**: ImagePullBackOff isn't the problem. It's the symptom. The error message tells you why. Read it carefully. Fix the root cause.

