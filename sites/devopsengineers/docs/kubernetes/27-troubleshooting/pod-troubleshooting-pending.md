---
sidebar_position: 4
title: "Pod Troubleshooting: Pending Pods"
---

# Pending Pods: When Pods Can't Be Scheduled

**Pending pods are frustrating. Your pod is created. It's waiting. It's not starting. Kubernetes can't schedule it. Here's how to fix it.**

## 🎯 The Big Picture

Think of Pending pods like a guest waiting for a room. The guest is here. The room isn't ready. **The problem isn't that the guest is waiting. The problem is why the room isn't ready.**

**Pending means Kubernetes can't schedule the pod. No resources. Node affinity. Taints. Here's how to fix it.**

## What is Pending?

**Pending is a pod state that means:**
1. Pod is created
2. Kubernetes can't schedule it
3. Pod is waiting
4. No container is running

**Common reasons:**
- No nodes available
- Insufficient resources
- Node affinity/taints
- Storage issues
- Network issues

## Understanding the Pending State

**Pod states you'll see:**
```
Pending  ← Pod waiting to be scheduled
    ↓
(No change until scheduled)
```

**The pod stays Pending until the issue is resolved.**

## Step-by-Step Debugging Process

### Step 1: Identify the Problem Pod

```bash
kubectl get pods
```

**Look for:**
- Status: `Pending`
- Age: How long has it been pending?

**Example output:**
```
NAME                    READY   STATUS    RESTARTS   AGE
my-app-abc123           0/1     Pending   0          10m
```

### Step 2: Describe the Pod

```bash
kubectl describe pod <pod-name>
```

**Look for:**
- **Events**: Why can't it be scheduled?
- **Conditions**: What's the issue?
- **Node**: Which node should it run on?

**Key sections to check:**
```yaml
Events:
  Warning  FailedScheduling  5m ago   default-scheduler  
    0/3 nodes are available: 3 Insufficient cpu.
  
Conditions:
  Type           Status
  PodScheduled   False
  Reason:        Unschedulable
```

### Step 3: Check Node Resources

```bash
kubectl top nodes
kubectl describe nodes
```

**Look for:**
- Available CPU
- Available memory
- Node capacity
- Allocatable resources

## Common Causes and Solutions

### Cause 1: Insufficient Resources

**Symptoms:**
- Error: "Insufficient cpu" or "Insufficient memory"
- Nodes don't have enough resources
- Resource requests too high

**Solutions:**
1. **Check node resources:**
   ```bash
   kubectl top nodes
   kubectl describe nodes
   ```

2. **Check pod resource requests:**
   ```bash
   kubectl describe pod <pod-name>
   # Look for Requests section
   ```

3. **Reduce resource requests:**
   ```yaml
   resources:
     requests:
       cpu: "100m"      # Reduce if too high
       memory: "128Mi"  # Reduce if too high
   ```

4. **Add more nodes:**
   ```bash
   # Scale cluster
   # Or use cluster autoscaler
   ```

### Cause 2: Node Affinity Rules

**Symptoms:**
- Error: "node(s) didn't match node selector"
- Pod has affinity rules
- No nodes match

**Solutions:**
1. **Check node affinity:**
   ```bash
   kubectl get pod <pod-name> -o yaml | grep -A 10 affinity
   ```

2. **Check node labels:**
   ```bash
   kubectl get nodes --show-labels
   ```

3. **Fix affinity rules:**
   ```yaml
   # Remove or adjust affinity
   affinity:
     nodeAffinity:
       requiredDuringSchedulingIgnoredDuringExecution:
         nodeSelectorTerms:
         - matchExpressions:
           - key: zone
             operator: In
             values:
             - us-east-1a
   ```

### Cause 3: Node Taints

**Symptoms:**
- Error: "node(s) had taint"
- Nodes have taints
- Pod doesn't have toleration

**Solutions:**
1. **Check node taints:**
   ```bash
   kubectl describe node <node-name>
   # Look for Taints section
   ```

2. **Add toleration to pod:**
   ```yaml
   tolerations:
   - key: "key1"
     operator: "Equal"
     value: "value1"
     effect: "NoSchedule"
   ```

3. **Or remove taint from node:**
   ```bash
   kubectl taint nodes <node-name> key1=value1:NoSchedule-
   ```

### Cause 4: Storage Issues

**Symptoms:**
- Error: "persistentvolumeclaim not found"
- Error: "volume binding failed"
- PVC doesn't exist or can't bind

**Solutions:**
1. **Check PVC:**
   ```bash
   kubectl get pvc
   kubectl describe pvc <pvc-name>
   ```

2. **Check storage class:**
   ```bash
   kubectl get storageclass
   ```

3. **Fix PVC:**
   - Create missing PVC
   - Fix storage class
   - Check available storage

### Cause 5: No Nodes Available

**Symptoms:**
- Error: "0/X nodes are available"
- All nodes are unschedulable
- Cluster has no nodes

**Solutions:**
1. **Check nodes:**
   ```bash
   kubectl get nodes
   ```

2. **Check node status:**
   ```bash
   kubectl describe nodes
   ```

3. **Fix nodes:**
   - Uncordon nodes: `kubectl uncordon <node-name>`
   - Add nodes to cluster
   - Fix node issues

## Real-World Example: Resource Constraints

**Problem:**
Pod in Pending. Error:
```
0/3 nodes are available: 3 Insufficient cpu.
```

**Debugging:**
1. **Checked node resources:**
   ```bash
   kubectl top nodes
   # All nodes at 100% CPU
   ```

2. **Checked pod requests:**
   ```bash
   kubectl describe pod <pod-name>
   # Requesting 2 CPU
   ```

3. **Reduced resource requests:**
   ```yaml
   resources:
     requests:
       cpu: "500m"  # Reduced from 2
       memory: "256Mi"
   ```

4. **Restarted deployment:** Pod scheduled successfully

**Solution:** Resource requests too high. Reduced requests. Pod scheduled.

## Hands-On Exercise: Debug Pending Pod

**Create a pod with high resource requests:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pending-test
spec:
  containers:
  - name: app
    image: nginx:alpine
    resources:
      requests:
        cpu: "100"  # Too high! Will be pending
        memory: "1000Gi"  # Too high!
```

**Apply it:**
```bash
kubectl apply -f pending-test.yaml
```

**Debug it:**
1. Check pod status: `kubectl get pods`
2. Describe pod: `kubectl describe pod pending-test`
3. Check events: Look for scheduling errors
4. Fix the issue (reduce resource requests)

**This is how you learn. Break things. Fix them.**

## My Take: Pending Pod Debugging

Pending pods used to confuse me. I'd see them and not know why.

Then I learned the systematic approach:
1. **Describe the pod** - See why it can't be scheduled
2. **Check events** - Error message tells you why
3. **Check resources** - CPU, memory, storage
4. **Check affinity/taints** - Node selection rules
5. **Fix the root cause** - Not just wait

**Now I fix Pending pods in minutes, not hours.**

## Memory Tip: The Guest Waiting Analogy

Pending pods are like a guest waiting for a room:
- **Guest is here** (Pod is created)
- **Room not ready** (Can't be scheduled)
- **No rooms available** (No resources)
- **Wrong room type** (Affinity/taints)
- **Room key missing** (Storage issues)

**The error message tells you why. Read it carefully.**

## Common Mistakes

1. **Not checking events**: Events tell you why
2. **Too high resource requests**: Request what you need
3. **Wrong affinity rules**: Check node labels
4. **Ignoring taints**: Add tolerations or remove taints
5. **Not checking storage**: PVC might not exist

## Key Takeaways

1. **Pending means can't schedule** - Find why
2. **Check events** - Error message tells you why
3. **Check resources** - CPU, memory, storage
4. **Check affinity/taints** - Node selection rules
5. **Fix the root cause** - Not just wait

## What's Next?

Now that you understand Pending pods, let's tackle service discovery issues. Next: [Service Troubleshooting](/docs/kubernetes/27-troubleshooting/service-troubleshooting).

---

> **Remember**: Pending isn't the problem. It's the symptom. The events tell you why. Read them carefully. Fix the root cause.

