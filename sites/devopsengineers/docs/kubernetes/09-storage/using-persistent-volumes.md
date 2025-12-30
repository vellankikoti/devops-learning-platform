---
sidebar_position: 3
title: Using Persistent Volumes
---

# Using Persistent Volumes: Accessing Hotel Storage

**Using Persistent Volumes is like accessing hotel storage. Request storage (PVC). Get storage (PV). Mount to room (pod). That's using Persistent Volumes.**

## 🎯 The Big Picture

Think of using Persistent Volumes like accessing hotel storage. Guest requests storage (PVC). Gets storage facility (PV). Storage mounted to room (pod). That's using Persistent Volumes.

**Using Persistent Volumes involves creating PVCs. Binding to PVs. Mounting to pods. Accessing storage. Essential for stateful apps.**

## The Hotel Storage Access Analogy

**Think of using Persistent Volumes like accessing hotel storage:**

**PVC:** Storage request
- Guest requests storage
- Specify requirements
- Request submitted

**PV binding:** Get storage facility
- Request approved
- Storage assigned
- Facility available

**Pod mount:** Mount to room
- Storage mounted to room
- Guest can use
- Persistent

**Once you see it this way, using Persistent Volumes makes perfect sense.**

## Complete Workflow

**Step-by-step process:**

**Step 1: Create PVC**
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: hotel-storage
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
  storageClassName: standard
```

**Step 2: PVC binds to PV**
- Storage Class provisions PV
- PVC binds to PV
- Storage available

**Step 3: Use in Pod**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: app
spec:
  containers:
  - name: app
    image: hotel-app:1.0
    volumeMounts:
    - name: storage
      mountPath: /data
  volumes:
  - name: storage
    persistentVolumeClaim:
      claimName: hotel-storage
```

**Think of it as:** Request storage. Get facility. Mount to room.

## Using in Deployments

**Deployment with Persistent Volume:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: database
spec:
  replicas: 1
  selector:
    matchLabels:
      app: db
  template:
    metadata:
      labels:
        app: db
    spec:
      containers:
      - name: db
        image: postgres:16-alpine
        volumeMounts:
        - name: db-storage
          mountPath: /var/lib/postgresql/data
        env:
        - name: PGDATA
          value: /var/lib/postgresql/data/pgdata
      volumes:
      - name: db-storage
        persistentVolumeClaim:
          claimName: db-pvc
```

**What this does:**
- Deployment uses PVC
- Storage mounted
- Data persists

**Think of it as:** Room management uses storage. Mounted. Persistent.

## Using in StatefulSets

**StatefulSet with Persistent Volume:**
```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: db
spec:
  serviceName: db
  replicas: 3
  selector:
    matchLabels:
      app: db
  template:
    metadata:
      labels:
        app: db
    spec:
      containers:
      - name: db
        image: postgres:16-alpine
        volumeMounts:
        - name: db-storage
          mountPath: /var/lib/postgresql/data
  volumeClaimTemplates:
  - metadata:
      name: db-storage
    spec:
      accessModes:
      - ReadWriteOnce
      resources:
        requests:
          storage: 10Gi
      storageClassName: standard
```

**What this does:**
- StatefulSet creates PVC per pod
- Each pod gets own storage
- Ordered creation

**Think of it as:** Each room gets own storage. Individual. Persistent.

## Real-World Example: Database with Persistent Storage

**Complete setup:**

**Step 1: Create Storage Class:**
```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: db-storage
provisioner: ebs.csi.aws.com
parameters:
  type: gp3
  encrypted: "true"
```

**Step 2: Create PVC:**
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: postgres-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 50Gi
  storageClassName: db-storage
```

**Step 3: Create Deployment:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgres
spec:
  replicas: 1
  selector:
    matchLabels:
      app: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
      - name: postgres
        image: postgres:16-alpine
        env:
        - name: POSTGRES_PASSWORD
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: password
        volumeMounts:
        - name: postgres-storage
          mountPath: /var/lib/postgresql/data
      volumes:
      - name: postgres-storage
        persistentVolumeClaim:
          claimName: postgres-pvc
```

**Step 4: Verify:**
```bash
kubectl get pvc
kubectl get pv
kubectl exec postgres -- df -h /var/lib/postgresql/data
```

**That's complete setup. Database with persistent storage.**

## My Take: Using Persistent Volumes Strategy

**Here's what I do:**

**Stateful apps:**
- Always use Persistent Volumes
- Appropriate size
- Right access mode
- Backup strategy

**Stateless apps:**
- No Persistent Volumes
- Ephemeral storage
- No persistence

**The key:** Use for stateful. Not for stateless. Right tool.

## Memory Tip: The Hotel Storage Access Analogy

**Using Persistent Volumes = Accessing hotel storage**

**PVC:** Storage request
**PV binding:** Get facility
**Pod mount:** Mount to room

**Once you see it this way, using Persistent Volumes makes perfect sense.**

## Common Mistakes

1. **Using for stateless apps**: Unnecessary
2. **Wrong access mode**: Can't access
3. **Too small**: Out of space
4. **Not backing up**: Data loss risk
5. **Not understanding lifecycle**: Confusion

## Key Takeaways

1. **Create PVC** - Request storage
2. **PVC binds to PV** - Get storage
3. **Mount to pod** - Use storage
4. **Data persists** - Survives restarts
5. **Essential for stateful** - Can't work without

## What's Next?

Now that you understand using Persistent Volumes, let's learn about volume expansion. Next: [Volume Expansion](/docs/kubernetes/09-storage/volume-expansion).

---

> **Remember**: Using Persistent Volumes is like accessing hotel storage. Request (PVC). Get (PV). Mount (pod). Data persists. Essential for stateful apps.

