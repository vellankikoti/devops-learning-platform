---
sidebar_position: 6
title: Storage Troubleshooting
---

# Storage Troubleshooting: When Volumes Don't Work

**Storage issues are frustrating. Your pods need storage. PVCs exist. But volumes don't mount. Here's how to fix it.**

## 🎯 The Big Picture

Think of storage issues like hotel storage rooms. The rooms exist. The keys exist. But you can't access them. **The problem isn't that things exist. The problem is why they're not accessible.**

**Storage troubleshooting involves checking PVCs, PVs, storage classes, and volume mounts. Here's how to fix it.**

## Common Storage Issues

**Symptoms:**
- PVC pending
- Volume mount failures
- Permission denied
- Storage not accessible

## Step-by-Step Debugging Process

### Step 1: Check PVC Status

```bash
kubectl get pvc
kubectl describe pvc <pvc-name>
```

**Look for:**
- Status: Pending, Bound, Lost
- Storage class
- Access modes
- Capacity

### Step 2: Check PV Status

```bash
kubectl get pv
kubectl describe pv <pv-name>
```

**Look for:**
- Status: Available, Bound, Released
- Storage class
- Access modes
- Reclaim policy

### Step 3: Check Storage Class

```bash
kubectl get storageclass
kubectl describe storageclass <sc-name>
```

**Look for:**
- Provisioner
- Parameters
- Default class

## Common Causes and Solutions

### Cause 1: PVC Pending

**Symptoms:**
- PVC status: Pending
- No PV created
- Storage not provisioned

**Solutions:**
1. **Check storage class:**
   ```bash
   kubectl get storageclass
   kubectl describe storageclass <sc-name>
   ```

2. **Check provisioner:**
   - Is provisioner running?
   - Are there errors?

3. **Check events:**
   ```bash
   kubectl get events --sort-by='.lastTimestamp'
   # Look for storage-related events
   ```

4. **Fix storage class:**
   ```yaml
   apiVersion: storage.k8s.io/v1
   kind: StorageClass
   metadata:
     name: fast-ssd
   provisioner: kubernetes.io/aws-ebs
   parameters:
     type: gp3
   ```

### Cause 2: Volume Mount Failures

**Symptoms:**
- Pod can't start
- Volume mount error
- Permission denied

**Solutions:**
1. **Check volume mount:**
   ```bash
   kubectl describe pod <pod-name>
   # Look for Volume Mounts section
   ```

2. **Check PVC:**
   ```bash
   kubectl get pvc
   kubectl describe pvc <pvc-name>
   ```

3. **Fix volume mount:**
   ```yaml
   volumes:
   - name: data
     persistentVolumeClaim:
       claimName: my-pvc
   volumeMounts:
   - name: data
     mountPath: /data
   ```

### Cause 3: Permission Issues

**Symptoms:**
- Volume mounted
- Permission denied
- Can't write to volume

**Solutions:**
1. **Check security context:**
   ```yaml
   securityContext:
     fsGroup: 1000
     runAsUser: 1000
     runAsGroup: 1000
   ```

2. **Fix permissions:**
   ```yaml
   initContainers:
   - name: volume-permissions
     image: busybox
     command: ["sh", "-c", "chown -R 1000:1000 /data"]
     volumeMounts:
     - name: data
       mountPath: /data
   ```

### Cause 4: Storage Class Not Found

**Symptoms:**
- Error: "storage class not found"
- PVC can't be created
- No default storage class

**Solutions:**
1. **Check storage classes:**
   ```bash
   kubectl get storageclass
   ```

2. **Set default storage class:**
   ```bash
   kubectl patch storageclass <sc-name> \
     -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
   ```

3. **Or specify in PVC:**
   ```yaml
   apiVersion: v1
   kind: PersistentVolumeClaim
   spec:
     storageClassName: fast-ssd  # Specify explicitly
     accessModes:
     - ReadWriteOnce
     resources:
       requests:
         storage: 10Gi
   ```

### Cause 5: Access Mode Mismatch

**Symptoms:**
- PVC exists
- PV exists
- But can't bind
- Access mode mismatch

**Solutions:**
1. **Check PVC access mode:**
   ```bash
   kubectl get pvc <pvc-name> -o yaml | grep accessModes
   ```

2. **Check PV access mode:**
   ```bash
   kubectl get pv <pv-name> -o yaml | grep accessModes
   ```

3. **Fix access modes:**
   ```yaml
   # PVC
   accessModes:
   - ReadWriteOnce  # Must match PV
   
   # PV
   accessModes:
   - ReadWriteOnce  # Must match PVC
   ```

## Real-World Example: PVC Pending

**Problem:**
PVC in Pending state. No storage provisioned.

**Debugging:**
1. **Checked PVC:**
   ```bash
   kubectl describe pvc my-pvc
   # Status: Pending
   # Events: Waiting for volume to be created
   ```

2. **Checked storage class:**
   ```bash
   kubectl get storageclass
   # No storage class found
   ```

3. **Created storage class:**
   ```yaml
   apiVersion: storage.k8s.io/v1
   kind: StorageClass
   metadata:
     name: local-storage
   provisioner: kubernetes.io/no-provisioner
   volumeBindingMode: WaitForFirstConsumer
   ```

4. **Updated PVC:**
   ```yaml
   spec:
     storageClassName: local-storage
   ```

5. **PVC bound:** Storage provisioned successfully

**Solution:** No storage class. Created storage class. PVC bound.

## Hands-On Exercise: Debug Storage

**Create PVC without storage class:**
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: test-pvc
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  # No storageClassName - will be pending
```

**Debug it:**
1. Check PVC: `kubectl get pvc test-pvc`
2. Describe PVC: `kubectl describe pvc test-pvc`
3. Check storage classes: `kubectl get storageclass`
4. Fix the issue (create storage class or specify one)

**This is how you learn. Break things. Fix them.**

## My Take: Storage Troubleshooting

Storage issues used to confuse me. I'd see PVCs but volumes didn't work.

Then I learned the systematic approach:
1. **Check PVC status** - Pending, Bound, Lost?
2. **Check storage class** - Does it exist?
3. **Check PV** - Is it bound?
4. **Check access modes** - Do they match?
5. **Check volume mounts** - Are they correct?

**Now I fix storage issues in minutes, not hours.**

## Memory Tip: The Hotel Storage Rooms Analogy

Storage issues are like hotel storage rooms:
- **Room exists** (PVC exists)
- **Key exists** (PV exists)
- **Wrong key** (Access mode mismatch)
- **Room locked** (Permission issues)
- **No room available** (No storage class)

**Check each component. Find the mismatch.**

## Common Mistakes

1. **Not checking PVC status**: Pending = issue
2. **No storage class**: PVC can't be provisioned
3. **Access mode mismatch**: PVC and PV must match
4. **Permission issues**: Check security context
5. **Not checking events**: Events show what happened

## Key Takeaways

1. **Check PVC status first** - Pending = issue
2. **Verify storage class exists** - Required for dynamic provisioning
3. **Check access modes** - Must match between PVC and PV
4. **Check permissions** - Use security context
5. **Check events** - Show what happened

## What's Next?

Now that you understand storage troubleshooting, let's tackle deployment issues. Next: [Deployment Troubleshooting](/docs/kubernetes/27-troubleshooting/deployment-troubleshooting).

---

> **Remember**: Storage issues are usually PVC pending or access mode mismatches. Check PVC status. Verify storage class. Check access modes. Fix the mismatch.

