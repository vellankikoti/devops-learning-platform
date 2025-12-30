---
sidebar_position: 7
title: Deployment Troubleshooting
---

# Deployment Troubleshooting: When Deployments Don't Work

**Deployment issues are frustrating. Your deployment exists. But pods aren't starting. Replicas aren't matching. Here's how to fix it.**

## 🎯 The Big Picture

Think of deployment issues like hotel room management. The rooms should be ready. But they're not. **The problem isn't that the deployment exists. The problem is why pods aren't working.**

**Deployment troubleshooting involves checking replicas, pod status, rollout status, and resource constraints. Here's how to fix it.**

## Common Deployment Issues

**Symptoms:**
- Replicas not matching desired
- Pods not starting
- Rollout stuck
- Deployment not updating

## Step-by-Step Debugging Process

### Step 1: Check Deployment Status

```bash
kubectl get deployments
kubectl describe deployment <deployment-name>
```

**Look for:**
- Desired vs available replicas
- Replica set status
- Events
- Conditions

### Step 2: Check ReplicaSets

```bash
kubectl get replicasets
kubectl describe replicaset <rs-name>
```

**Look for:**
- Desired vs ready replicas
- Pod status
- Events

### Step 3: Check Pods

```bash
kubectl get pods -l app=<app-label>
kubectl describe pod <pod-name>
```

**Look for:**
- Pod status
- Events
- Resource constraints
- Image pull issues

## Common Causes and Solutions

### Cause 1: Replicas Not Matching

**Symptoms:**
- Desired: 3, Available: 1
- Pods not starting
- Replicas not scaling

**Solutions:**
1. **Check deployment:**
   ```bash
   kubectl describe deployment <deployment-name>
   # Look for Replicas section
   ```

2. **Check pod status:**
   ```bash
   kubectl get pods -l app=<app-label>
   # Check why pods aren't starting
   ```

3. **Check resource constraints:**
   ```bash
   kubectl top nodes
   kubectl describe nodes
   ```

4. **Fix resource issues:**
   - Reduce resource requests
   - Add more nodes
   - Fix pod issues

### Cause 2: Rollout Stuck

**Symptoms:**
- Deployment updating
- Rollout not completing
- New pods not ready

**Solutions:**
1. **Check rollout status:**
   ```bash
   kubectl rollout status deployment/<deployment-name>
   ```

2. **Check new pods:**
   ```bash
   kubectl get pods -l app=<app-label>
   # Check new replica set pods
   ```

3. **Check readiness probe:**
   ```bash
   kubectl describe pod <pod-name>
   # Look for Readiness section
   ```

4. **Fix readiness probe:**
   ```yaml
   readinessProbe:
     httpGet:
       path: /health
       port: 8080
     initialDelaySeconds: 10  # Increase if needed
     periodSeconds: 5
   ```

### Cause 3: Image Pull Issues

**Symptoms:**
- Pods in ImagePullBackOff
- Deployment not updating
- New pods can't start

**Solutions:**
1. **Check pod status:**
   ```bash
   kubectl get pods -l app=<app-label>
   # Look for ImagePullBackOff
   ```

2. **Check image:**
   ```bash
   kubectl describe pod <pod-name>
   # Look for image pull errors
   ```

3. **Fix image:**
   - Correct image name
   - Fix authentication
   - Check registry access

### Cause 4: Resource Constraints

**Symptoms:**
- Pods pending
- Deployment not scaling
- Insufficient resources

**Solutions:**
1. **Check node resources:**
   ```bash
   kubectl top nodes
   kubectl describe nodes
   ```

2. **Check pod requests:**
   ```bash
   kubectl describe deployment <deployment-name>
   # Look for resource requests
   ```

3. **Reduce resource requests:**
   ```yaml
   resources:
     requests:
       cpu: "100m"      # Reduce if too high
       memory: "128Mi"  # Reduce if too high
   ```

4. **Or add nodes:**
   - Scale cluster
   - Use cluster autoscaler

### Cause 5: Health Check Failures

**Symptoms:**
- Pods restarting
- Deployment not updating
- Liveness/readiness failing

**Solutions:**
1. **Check probe status:**
   ```bash
   kubectl describe pod <pod-name>
   # Look for Liveness and Readiness
   ```

2. **Test probe endpoint:**
   ```bash
   kubectl exec -it <pod-name> -- curl localhost:8080/health
   ```

3. **Fix probe:**
   ```yaml
   livenessProbe:
     httpGet:
       path: /health
       port: 8080
     initialDelaySeconds: 30  # Increase if app needs time
     periodSeconds: 10
   
   readinessProbe:
     httpGet:
       path: /ready
       port: 8080
     initialDelaySeconds: 5
     periodSeconds: 5
   ```

## Real-World Example: Rollout Stuck

**Problem:**
Deployment rollout stuck. New pods not becoming ready.

**Debugging:**
1. **Checked rollout:**
   ```bash
   kubectl rollout status deployment/my-app
   # Waiting for rollout to finish
   ```

2. **Checked new pods:**
   ```bash
   kubectl get pods -l app=my-app
   # New pods: 0/1 Ready
   ```

3. **Checked readiness probe:**
   ```bash
   kubectl describe pod <new-pod>
   # Readiness probe failing
   ```

4. **Tested endpoint:**
   ```bash
   kubectl exec -it <pod> -- curl localhost:8080/health
   # Endpoint works but takes 20 seconds
   ```

5. **Fixed probe:**
   ```yaml
   readinessProbe:
     httpGet:
       path: /health
       port: 8080
     initialDelaySeconds: 20  # Increased from 5
     periodSeconds: 5
   ```

6. **Rollout completed:** Pods became ready

**Solution:** Readiness probe initial delay too short. Increased delay. Rollout completed.

## Hands-On Exercise: Debug Deployment

**Create deployment with high resource requests:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: test-deployment
spec:
  replicas: 3
  template:
    spec:
      containers:
      - name: app
        image: nginx:alpine
        resources:
          requests:
            cpu: "100"  # Too high!
            memory: "1000Gi"  # Too high!
```

**Debug it:**
1. Check deployment: `kubectl get deployment test-deployment`
2. Check pods: `kubectl get pods -l app=test-deployment`
3. Describe pods: `kubectl describe pod <pod-name>`
4. Fix the issue (reduce resource requests)

**This is how you learn. Break things. Fix them.**

## My Take: Deployment Troubleshooting

Deployment issues used to confuse me. I'd see deployments but pods weren't working.

Then I learned the systematic approach:
1. **Check deployment status** - Desired vs available
2. **Check replica sets** - Are they creating pods?
3. **Check pod status** - Why aren't pods starting?
4. **Check resource constraints** - Enough resources?
5. **Check health probes** - Are they configured correctly?

**Now I fix deployment issues in minutes, not hours.**

## Memory Tip: The Hotel Room Management Analogy

Deployment issues are like hotel room management:
- **Rooms should be ready** (Pods should be ready)
- **Wrong room type** (Resource constraints)
- **Room key doesn't work** (Image pull issues)
- **Room not ready** (Health check failures)
- **Can't access room** (Rollout stuck)

**Check each component. Find the issue.**

## Common Mistakes

1. **Not checking replica sets**: RS shows pod creation status
2. **Ignoring pod status**: Pods tell you why they're not ready
3. **Wrong resource requests**: Too high = pending
4. **Health probes too aggressive**: App needs time to start
5. **Not checking events**: Events show what happened

## Key Takeaways

1. **Check deployment status** - Desired vs available replicas
2. **Check replica sets** - Are pods being created?
3. **Check pod status** - Why aren't pods ready?
4. **Check resource constraints** - Enough resources?
5. **Check health probes** - Configured correctly?

## What's Next?

Now that you understand deployment troubleshooting, let's create a comprehensive troubleshooting guide. Next: [Complete Troubleshooting Guide](/docs/kubernetes/27-troubleshooting/complete-troubleshooting-guide).

---

> **Remember**: Deployment issues are usually pod issues or resource constraints. Check deployment status. Check pods. Check resources. Fix the root cause.

