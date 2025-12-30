---
sidebar_position: 5
title: Service Troubleshooting
---

# Service Troubleshooting: When Services Don't Work

**Service issues are frustrating. Your pods are running. Your service exists. But nothing works. Here's how to fix it.**

## 🎯 The Big Picture

Think of service issues like a hotel phone system. The phones exist. The rooms exist. But calls aren't connecting. **The problem isn't that things exist. The problem is why they're not connecting.**

**Service troubleshooting involves checking selectors, endpoints, ports, and network policies. Here's how to fix it.**

## Common Service Issues

**Symptoms:**
- Service exists but not accessible
- Connection refused
- Timeout errors
- Service not routing traffic

## Step-by-Step Debugging Process

### Step 1: Check Service Status

```bash
kubectl get svc
kubectl describe svc <service-name>
```

**Look for:**
- Service type
- ClusterIP/NodePort/LoadBalancer
- Selectors
- Ports

### Step 2: Check Endpoints

```bash
kubectl get endpoints <service-name>
kubectl describe endpoints <service-name>
```

**Key check:**
- Are endpoints empty? → Selectors don't match pods
- Are endpoints correct? → Verify pod IPs

**Example:**
```
NAME         ENDPOINTS                    AGE
my-service   10.244.1.5:8080,10.244.2.3:8080   5m
```

### Step 3: Check Pod Selectors

```bash
kubectl get pods --show-labels
kubectl get svc <service-name> -o yaml | grep selector
```

**Key check:**
- Do pod labels match service selectors?
- Are labels correct?

## Common Causes and Solutions

### Cause 1: Selector Mismatch

**Symptoms:**
- Service has no endpoints
- Endpoints list is empty
- Pods exist but not connected

**Solutions:**
1. **Check service selectors:**
   ```bash
   kubectl get svc <service-name> -o yaml
   # Look for selector section
   ```

2. **Check pod labels:**
   ```bash
   kubectl get pods --show-labels
   ```

3. **Fix selector or labels:**
   ```yaml
   # Service
   apiVersion: v1
   kind: Service
   spec:
     selector:
       app: my-app  # Must match pod labels
   
   # Pod
   metadata:
     labels:
       app: my-app  # Must match service selector
   ```

### Cause 2: Wrong Port

**Symptoms:**
- Service exists
- Endpoints exist
- Connection refused

**Solutions:**
1. **Check service port:**
   ```bash
   kubectl get svc <service-name>
   # Check PORT(S) column
   ```

2. **Check pod port:**
   ```bash
   kubectl describe pod <pod-name>
   # Look for container port
   ```

3. **Fix port mapping:**
   ```yaml
   apiVersion: v1
   kind: Service
   spec:
     ports:
     - port: 80        # Service port
       targetPort: 8080  # Pod port (must match)
   ```

### Cause 3: Pods Not Ready

**Symptoms:**
- Endpoints exist
- Pods are running
- But not receiving traffic

**Solutions:**
1. **Check pod readiness:**
   ```bash
   kubectl get pods
   # Check READY column (should be 1/1)
   ```

2. **Check readiness probe:**
   ```bash
   kubectl describe pod <pod-name>
   # Look for Readiness section
   ```

3. **Fix readiness probe:**
   ```yaml
   readinessProbe:
     httpGet:
       path: /health
       port: 8080
     initialDelaySeconds: 5
     periodSeconds: 10
   ```

### Cause 4: Network Policies

**Symptoms:**
- Everything looks correct
- But traffic blocked
- Network policy blocking

**Solutions:**
1. **Check network policies:**
   ```bash
   kubectl get networkpolicies
   kubectl describe networkpolicy <policy-name>
   ```

2. **Check if policy blocks traffic:**
   - Review ingress rules
   - Review egress rules
   - Check pod selectors

3. **Fix or adjust policy:**
   ```yaml
   apiVersion: networking.k8s.io/v1
   kind: NetworkPolicy
   spec:
     podSelector:
       matchLabels:
         app: my-app
     ingress:
     - from:
       - podSelector:
           matchLabels:
             app: client
     egress:
     - {}  # Allow all egress
   ```

### Cause 5: Service Type Issues

**Symptoms:**
- Service exists
- Can't access from outside
- Wrong service type

**Solutions:**
1. **Check service type:**
   ```bash
   kubectl get svc
   # Check TYPE column
   ```

2. **Use correct type:**
   ```yaml
   # ClusterIP (internal only)
   apiVersion: v1
   kind: Service
   spec:
     type: ClusterIP
   
   # NodePort (external access)
   spec:
     type: NodePort
     ports:
     - port: 80
       nodePort: 30080
   
   # LoadBalancer (cloud)
   spec:
     type: LoadBalancer
   ```

## Real-World Example: Selector Mismatch

**Problem:**
Service exists but no endpoints. Can't access application.

**Debugging:**
1. **Checked service:**
   ```bash
   kubectl get svc my-service
   # Service exists
   ```

2. **Checked endpoints:**
   ```bash
   kubectl get endpoints my-service
   # Endpoints: <none>
   ```

3. **Checked selectors:**
   ```bash
   kubectl get svc my-service -o yaml | grep selector
   # selector: app: my-app
   
   kubectl get pods --show-labels
   # Labels: app: myapplication  # Mismatch!
   ```

4. **Fixed labels:**
   ```yaml
   # Updated pod labels to match service selector
   metadata:
     labels:
       app: my-app  # Changed from myapplication
   ```

5. **Verified:**
   ```bash
   kubectl get endpoints my-service
   # Endpoints now populated
   ```

**Solution:** Selector mismatch. Fixed labels. Service working.

## Hands-On Exercise: Debug Service

**Create service with wrong selector:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: test-service
spec:
  selector:
    app: wrong-label  # Won't match pods
  ports:
  - port: 80
    targetPort: 8080
```

**Create pod with different label:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: test-pod
  labels:
    app: correct-label  # Doesn't match service
spec:
  containers:
  - name: app
    image: nginx:alpine
    ports:
    - containerPort: 80
```

**Debug it:**
1. Check service: `kubectl get svc test-service`
2. Check endpoints: `kubectl get endpoints test-service`
3. Check selectors: Compare service selector with pod labels
4. Fix the issue (match labels or selector)

**This is how you learn. Break things. Fix them.**

## My Take: Service Troubleshooting

Service issues used to confuse me. I'd see services but nothing worked.

Then I learned the systematic approach:
1. **Check endpoints** - Are they populated?
2. **Check selectors** - Do they match pod labels?
3. **Check ports** - Are they correct?
4. **Check readiness** - Are pods ready?
5. **Check network policies** - Are they blocking?

**Now I fix service issues in minutes, not hours.**

## Memory Tip: The Hotel Phone System Analogy

Service issues are like hotel phone system:
- **Phones exist** (Service exists)
- **Rooms exist** (Pods exist)
- **Wrong room number** (Selector mismatch)
- **Wrong extension** (Port mismatch)
- **Phone off hook** (Pod not ready)
- **Call blocked** (Network policy)

**Check each component. Find the mismatch.**

## Common Mistakes

1. **Not checking endpoints**: Empty endpoints = selector mismatch
2. **Port mismatch**: Service port vs pod port
3. **Labels don't match**: Selector vs pod labels
4. **Not checking readiness**: Pods not ready
5. **Ignoring network policies**: Policies might block

## Key Takeaways

1. **Check endpoints first** - Empty = selector issue
2. **Verify selectors match labels** - Must be exact
3. **Check ports** - Service port vs pod port
4. **Check readiness** - Pods must be ready
5. **Check network policies** - Might be blocking

## What's Next?

Now that you understand service troubleshooting, let's tackle storage issues. Next: [Storage Troubleshooting](/docs/kubernetes/27-troubleshooting/storage-troubleshooting).

---

> **Remember**: Service issues are usually selector mismatches or port issues. Check endpoints first. Verify selectors. Check ports. Fix the mismatch.

