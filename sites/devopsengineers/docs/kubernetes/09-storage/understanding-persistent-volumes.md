---
sidebar_position: 1
title: Understanding Persistent Volumes
---

# Understanding Persistent Volumes: Hotel Storage Facilities

**Persistent Volumes are like hotel storage facilities. Persistent storage. Survives pod restarts. Available to all rooms. That's Persistent Volumes.**

## 🎯 The Big Picture

Think of Persistent Volumes like hotel storage facilities. Storage that persists. Survives room changes (pod restarts). Available to all rooms (pods). That's Persistent Volumes.

**Persistent Volumes provide persistent storage. Survives pod lifecycle. Cluster-wide. Essential for stateful applications.**

## The Hotel Storage Facilities Analogy

**Think of Persistent Volumes like hotel storage facilities:**

**PersistentVolume (PV):** Storage facility
- Cluster-wide storage
- Available to all
- Persistent

**PersistentVolumeClaim (PVC):** Storage request
- Request for storage
- Bound to PV
- Used by pods

**Storage Class:** Storage type
- Different storage types
- Different performance
- Different cost

**Once you see it this way, Persistent Volumes make perfect sense.**

## What is a Persistent Volume?

**PersistentVolume definition:**
- Cluster-wide storage
- Persistent storage
- Lifecycle independent of pods
- Available to all pods

**Think of it as:** Hotel storage facility. Persistent. Available to all.

## Why Persistent Volumes?

**Problems without Persistent Volumes:**
- Data lost when pod restarts
- No persistence
- Can't share data
- Stateful apps fail

**Solutions with Persistent Volumes:**
- Data persists
- Survives pod restarts
- Can share data
- Stateful apps work

**Real example:** I once ran database without Persistent Volume. Pod restarted. Data lost. With Persistent Volume, data persists. Never going back.

**Persistent Volumes aren't optional for stateful apps. They're essential.**

## PersistentVolume vs PersistentVolumeClaim

**Relationship:**

**PersistentVolume (PV):**
- Cluster resource
- Storage available
- Created by admin

**PersistentVolumeClaim (PVC):**
- Request for storage
- User creates
- Binds to PV

**Think of it as:** Storage facility (PV). Storage request (PVC). Request gets facility.

## Static Provisioning

**Admin creates PVs:**

**Create PV:**
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: hotel-storage
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: standard
  hostPath:
    path: /data/hotel
```

**Create PVC:**
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: hotel-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
  storageClassName: standard
```

**What happens:**
- PVC created
- Binds to PV
- Storage available

**Think of it as:** Request storage. Gets facility. Storage available.

## Dynamic Provisioning

**Automatic PV creation:**

**Storage Class:**
```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast-ssd
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp3
  fsType: ext4
```

**Create PVC:**
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: hotel-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 20Gi
  storageClassName: fast-ssd
```

**What happens:**
- PVC created
- Storage Class provisions PV
- Automatic binding

**Think of it as:** Request storage. Automatic facility creation. Storage available.

## Access Modes

**Storage access:**

**ReadWriteOnce (RWO):**
- Single node read/write
- One pod at a time
- Most common

**ReadOnlyMany (ROX):**
- Multiple nodes read-only
- Many pods can read
- Shared read

**ReadWriteMany (RWX):**
- Multiple nodes read/write
- Many pods can write
- Shared storage

**Think of it as:** Storage access. Single user. Read-only share. Read-write share.

## Real-World Example: Complete Storage Setup

**Step 1: Create Storage Class:**
```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: standard
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp3
```

**Step 2: Create PVC:**
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: db-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 50Gi
  storageClassName: standard
```

**Step 3: Use in Pod:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: db
spec:
  containers:
  - name: db
    image: postgres:16-alpine
    volumeMounts:
    - name: db-storage
      mountPath: /var/lib/postgresql/data
  volumes:
  - name: db-storage
    persistentVolumeClaim:
      claimName: db-pvc
```

**That's complete storage setup. Working.**

## My Take: Persistent Volume Strategy

**Here's what I do:**

**Stateful apps:**
- Always use Persistent Volumes
- Appropriate access mode
- Right size
- Backup strategy

**Stateless apps:**
- No Persistent Volumes
- Ephemeral storage
- No persistence needed

**The key:** Use Persistent Volumes for stateful. Not for stateless. Right tool.

## Memory Tip: The Hotel Storage Facilities Analogy

**Persistent Volumes = Hotel storage facilities**

**PV:** Storage facility
**PVC:** Storage request
**Storage Class:** Storage type
**Access modes:** Access rules

**Once you see it this way, Persistent Volumes make perfect sense.**

## Common Mistakes

1. **Not using for stateful apps**: Data loss
2. **Wrong access mode**: Can't access
3. **Too small**: Out of space
4. **No backup**: Data loss risk
5. **Not understanding lifecycle**: Confusion

## Key Takeaways

1. **Persistent Volumes provide persistence** - Survives pod restarts
2. **PVC requests storage** - Binds to PV
3. **Storage Classes enable dynamic provisioning** - Automatic
4. **Access modes matter** - RWO, ROX, RWX
5. **Essential for stateful apps** - Can't work without

## What's Next?

Now that you understand Persistent Volumes, let's learn about Storage Classes. Next: [Storage Classes](/docs/kubernetes/09-storage/storage-classes).

---

> **Remember**: Persistent Volumes are like hotel storage facilities. Persistent storage. Survives pod restarts. Essential for stateful apps. Use appropriately.

