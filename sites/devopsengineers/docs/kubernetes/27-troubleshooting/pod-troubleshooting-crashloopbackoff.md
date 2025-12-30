---
sidebar_position: 2
title: "Pod Troubleshooting: CrashLoopBackOff"
---

# CrashLoopBackOff: Why Pods Crash and How to Fix Them

**CrashLoopBackOff is the most common Kubernetes error. It's also the most frustrating. Your pod starts. It crashes. It restarts. It crashes again. It's a loop. Here's how to break it.**

## 🎯 The Big Picture

Think of CrashLoopBackOff like a car that won't start. You turn the key. The engine tries to start. It fails. You try again. It fails again. **The problem isn't that it's trying. The problem is why it's failing.**

**CrashLoopBackOff means your container is starting, crashing, and Kubernetes is restarting it. The loop continues until you fix the root cause.**

## What is CrashLoopBackOff?

**CrashLoopBackOff is a pod state that means:**
1. Container started
2. Container crashed (exited with error)
3. Kubernetes waited (backoff period)
4. Kubernetes restarted the container
5. Container crashed again
6. Repeat (with increasing backoff time)

**The backoff time increases:** 10s → 20s → 40s → 80s → 160s (max 300s)

## Understanding the CrashLoopBackOff State

**Pod states you'll see:**
```
CrashLoopBackOff  ← Final state (waiting before retry)
    ↓
Error             ← Container crashed
    ↓
Running           ← Container started (briefly)
    ↓
CrashLoopBackOff  ← Back to waiting
```

**The cycle continues until you fix the problem.**

## Step-by-Step Debugging Process

### Step 1: Identify the Problem Pod

```bash
kubectl get pods
```

**Look for:**
- Status: `CrashLoopBackOff`
- Restarts: High number (10+, 100+)

**Example output:**
```
NAME                    READY   STATUS             RESTARTS   AGE
my-app-abc123           0/1     CrashLoopBackOff   15         5m
```

### Step 2: Describe the Pod

```bash
kubectl describe pod <pod-name>
```

**Look for:**
- **Events**: What happened?
- **Last State**: Why did it exit?
- **Exit Code**: What error code?
- **Reason**: Why did it crash?

**Key sections to check:**
```yaml
Events:
  Warning  BackOff    2m ago   kubelet  Back-off restarting failed container
  Normal   Pulled     2m ago   kubelet  Container image "my-app:v1" already present
  Warning  Failed     2m ago   kubelet  Error: container failed to start

Last State:     Terminated
  Reason:       Error
  Exit Code:    1
  Started:      ...
  Finished:     ...
```

### Step 3: Check Container Logs

```bash
# Current container logs
kubectl logs <pod-name>

# Previous container instance (often more useful)
kubectl logs <pod-name> --previous

# Follow logs in real-time
kubectl logs <pod-name> -f
```

**The logs tell you WHY it crashed.**

**Common log patterns:**
- Application errors
- Configuration issues
- Missing files
- Permission problems
- Connection failures

### Step 4: Check Specific Container Logs

If you have multiple containers:

```bash
kubectl logs <pod-name> -c <container-name>
kubectl logs <pod-name> -c <container-name> --previous
```

### Step 5: Execute into the Container (If It Stays Up Long Enough)

```bash
kubectl exec -it <pod-name> -- /bin/sh
```

**If the container crashes too fast, this won't work. Use logs instead.**

## Common Causes and Solutions

### Cause 1: Application Error

**Symptoms:**
- Exit code: 1 (or non-zero)
- Logs show application errors
- Application code issue

**Example logs:**
```
Error: Cannot connect to database
at app.js:25
```

**Solutions:**
1. **Fix the application code**
2. **Check application configuration**
3. **Verify dependencies are installed**
4. **Check environment variables**

**Debugging:**
```bash
kubectl logs <pod-name> --previous
# Look for stack traces, error messages
```

### Cause 2: Missing Configuration

**Symptoms:**
- Exit code: 1
- Logs: "Configuration file not found"
- Missing ConfigMap or Secret

**Example logs:**
```
Error: Config file /app/config.json not found
```

**Solutions:**
1. **Check if ConfigMap exists:**
   ```bash
   kubectl get configmap
   kubectl describe configmap <configmap-name>
   ```

2. **Check if Secret exists:**
   ```bash
   kubectl get secret
   kubectl describe secret <secret-name>
   ```

3. **Verify volume mounts:**
   ```bash
   kubectl describe pod <pod-name>
   # Check Volumes and Volume Mounts sections
   ```

4. **Fix the deployment:**
   - Add missing ConfigMap/Secret
   - Fix volume mount paths
   - Verify mount points

### Cause 3: Wrong Command or Entrypoint

**Symptoms:**
- Exit code: 127 (command not found)
- Logs: "command not found"
- Wrong command in container spec

**Example logs:**
```
/bin/sh: 1: mycommand: not found
```

**Solutions:**
1. **Check the command:**
   ```bash
   kubectl get pod <pod-name> -o yaml
   # Look for command, args, or container command
   ```

2. **Verify the command exists in the image:**
   ```bash
   docker run <image> <command>
   ```

3. **Fix the deployment:**
   - Correct the command
   - Use full path to executable
   - Check entrypoint in Dockerfile

### Cause 4: Resource Limits Too Low

**Symptoms:**
- Exit code: 137 (killed by OOM)
- Logs: "Out of memory"
- Pod evicted

**Example logs:**
```
Killed
```

**Solutions:**
1. **Check resource limits:**
   ```bash
   kubectl describe pod <pod-name>
   # Look for Limits and Requests
   ```

2. **Check node resources:**
   ```bash
   kubectl top nodes
   kubectl describe node
   ```

3. **Increase limits:**
   ```yaml
   resources:
     requests:
       memory: "256Mi"
       cpu: "250m"
     limits:
       memory: "512Mi"  # Increase this
       cpu: "500m"
   ```

### Cause 5: Health Check Failing

**Symptoms:**
- Exit code: varies
- Liveness/readiness probe failing
- Pod marked as unhealthy

**Solutions:**
1. **Check probe configuration:**
   ```bash
   kubectl describe pod <pod-name>
   # Look for Liveness and Readiness
   ```

2. **Test the probe endpoint:**
   ```bash
   kubectl exec -it <pod-name> -- curl localhost:<probe-port><probe-path>
   ```

3. **Fix the probe:**
   - Adjust timeout
   - Fix endpoint path
   - Increase initial delay
   - Check probe command

### Cause 6: Permission Issues

**Symptoms:**
- Exit code: 1
- Logs: "Permission denied"
- File system permissions

**Example logs:**
```
Permission denied: /app/data/file.txt
```

**Solutions:**
1. **Check file permissions:**
   ```bash
   kubectl exec -it <pod-name> -- ls -la /app
   ```

2. **Fix in Dockerfile:**
   ```dockerfile
   RUN chmod +x /app/script.sh
   RUN chown -R appuser:appuser /app
   ```

3. **Use securityContext:**
   ```yaml
   securityContext:
     runAsUser: 1000
     runAsGroup: 1000
     fsGroup: 1000
   ```

## Real-World Example: The Database Connection

**Problem:**
Pod in CrashLoopBackOff. Logs show:
```
Error: connect ECONNREFUSED 127.0.0.1:5432
```

**Debugging:**
1. **Checked logs:** Database connection refused
2. **Checked ConfigMap:** Database host was `localhost` (wrong!)
3. **Fixed ConfigMap:** Changed to service name `postgres-service`
4. **Restarted deployment:** Pod started successfully

**Solution:**
```yaml
# ConfigMap
data:
  DB_HOST: "postgres-service"  # Not localhost!
  DB_PORT: "5432"
```

## Hands-On Exercise: Debug a CrashLoopBackOff

**Create a pod that will crash:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: crash-pod
spec:
  containers:
  - name: app
    image: busybox
    command: ["/bin/sh", "-c", "exit 1"]  # Will crash!
```

**Apply it:**
```bash
kubectl apply -f crash-pod.yaml
```

**Debug it:**
1. Check pod status: `kubectl get pods`
2. Describe pod: `kubectl describe pod crash-pod`
3. Check logs: `kubectl logs crash-pod`
4. Fix the issue (change command to something that works)

**This is how you learn. Break things. Fix them.**

## My Take: CrashLoopBackOff Debugging

CrashLoopBackOff used to frustrate me. I'd see it and panic. I'd try random fixes.

Then I learned the systematic approach:
1. **Describe the pod** - See what happened
2. **Check logs** - See why it crashed
3. **Identify the cause** - Application, config, resources?
4. **Fix the root cause** - Not the symptom

**Now I fix CrashLoopBackOff in minutes, not hours.**

## Memory Tip: The Car Analogy

CrashLoopBackOff is like a car that won't start:
- **You turn the key** (container starts)
- **Engine tries** (application runs)
- **Engine fails** (application crashes)
- **You try again** (Kubernetes restarts)
- **Engine fails again** (crash loop)

**The problem isn't the trying. It's why it's failing. Find the root cause.**

## Common Mistakes

1. **Not checking logs**: Logs tell you why it crashed
2. **Not using --previous**: Current logs might be empty
3. **Fixing symptoms, not causes**: Address the root issue
4. **Not checking events**: Events show what Kubernetes saw
5. **Panicking**: Stay calm, be systematic

## Key Takeaways

1. **CrashLoopBackOff means container is crashing** - Find why
2. **Check logs first** - They tell you the problem
3. **Use --previous flag** - Previous instance logs are often more useful
4. **Describe the pod** - Events show what happened
5. **Fix the root cause** - Not just restart

## What's Next?

Now that you understand CrashLoopBackOff, let's tackle another common issue. Next: [Pod Troubleshooting: ImagePullBackOff](/docs/kubernetes/27-troubleshooting/pod-troubleshooting-imagepullbackoff).

---

> **Remember**: CrashLoopBackOff isn't the problem. It's the symptom. The logs tell you the real problem. Always check the logs.

