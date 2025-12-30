---
sidebar_position: 2
title: Creating StatefulSets
---

# Creating StatefulSets: Setting Up Ordered Rooms

**Creating StatefulSets is like setting up ordered hotel rooms. Define room requirements. Create ordered rooms. Stable identity. That's creating StatefulSets.**

## 🎯 The Big Picture

Think of creating StatefulSets like setting up ordered hotel rooms. Define room requirements (YAML). Create ordered rooms (StatefulSet). Stable room numbers (stable identity). That's creating StatefulSets.

**Creating StatefulSets defines stateful application specifications. YAML or kubectl. Headless service required. Volume claim templates. Essential for stateful apps.**

## The Ordered Room Setup Analogy

**Think of creating StatefulSets like setting up ordered rooms:**

**YAML definition:** Room requirements
- Define room specifications
- Ordered room management
- Stable identity

**Headless Service:** Room directory
- Required for StatefulSet
- DNS entries
- Stable names

**Volume Claim Templates:** Storage per room
- Each room gets storage
- Individual PVCs
- Persistent

**Once you see it this way, creating StatefulSets makes perfect sense.**

## Prerequisites: Headless Service

**Create headless service first:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: db
spec:
  clusterIP: None  # Headless
  selector:
    app: database
  ports:
  - port: 5432
    name: postgres
```

**Why required:**
- DNS entries
- Stable identity
- Pod discovery

**Think of it as:** Room directory. Required. Creates DNS.

## Creating StatefulSet

**Basic StatefulSet:**
```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: database
spec:
  serviceName: db  # Must match headless service
  replicas: 3
  selector:
    matchLabels:
      app: database
  template:
    metadata:
      labels:
        app: database
    spec:
      containers:
      - name: db
        image: postgres:16-alpine
        ports:
        - containerPort: 5432
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
          storage: 20Gi
      storageClassName: standard
```

**What this does:**
- Creates 3 database pods
- Ordered deployment
- Individual storage per pod
- Stable identity

**Think of it as:** Ordered room management. 3 rooms. Ordered. Individual storage.

## Complete Production StatefulSet

**Production-ready StatefulSet:**
```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: production-db
  namespace: production
  labels:
    app: database
    env: production
spec:
  serviceName: db
  replicas: 3
  podManagementPolicy: OrderedReady
  updateStrategy:
    type: RollingUpdate
    rollingUpdate:
      partition: 0
  selector:
    matchLabels:
      app: database
      env: production
  template:
    metadata:
      labels:
        app: database
        env: production
    spec:
      containers:
      - name: postgres
        image: postgres:16-alpine
        ports:
        - containerPort: 5432
          name: postgres
        env:
        - name: POSTGRES_PASSWORD
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: password
        - name: PGDATA
          value: /var/lib/postgresql/data/pgdata
        volumeMounts:
        - name: db-storage
          mountPath: /var/lib/postgresql/data
        resources:
          requests:
            memory: "512Mi"
            cpu: "500m"
          limits:
            memory: "2Gi"
            cpu: "2000m"
        livenessProbe:
          exec:
            command:
            - pg_isready
            - -U
            - postgres
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          exec:
            command:
            - pg_isready
            - -U
            - postgres
          initialDelaySeconds: 5
          periodSeconds: 5
  volumeClaimTemplates:
  - metadata:
      name: db-storage
    spec:
      accessModes:
      - ReadWriteOnce
      resources:
        requests:
          storage: 50Gi
      storageClassName: fast-ssd
```

**That's a complete StatefulSet. Production-ready. Comprehensive.**

## Real-World Example: Complete Creation

**Step 1: Create headless service:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: db
spec:
  clusterIP: None
  selector:
    app: database
  ports:
  - port: 5432
```

**Step 2: Create StatefulSet:**
```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: database
spec:
  serviceName: db
  replicas: 3
  selector:
    matchLabels:
      app: database
  template:
    metadata:
      labels:
        app: database
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
          storage: 20Gi
```

**Step 3: Verify:**
```bash
kubectl get statefulset database
kubectl get pods -l app=database
```

**Output:**
```
NAME       READY   STATUS    RESTARTS   AGE
database-0 1/1     Running   0          1m
database-1 1/1     Running   0          2m
database-2 1/1     Running   0          3m
```

**Step 4: Check storage:**
```bash
kubectl get pvc
```

**Output:**
```
NAME              STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
db-storage-db-0   Bound    pv-xxx   20Gi       RWO            standard       1m
db-storage-db-1   Bound    pv-yyy   20Gi       RWO            standard       2m
db-storage-db-2   Bound    pv-zzz   20Gi       RWO            standard       3m
```

**That's complete creation. StatefulSet working. Individual storage.**

## My Take: StatefulSet Creation Strategy

**Here's what I do:**

**Always:**
- Create headless service first
- Use volume claim templates
- Set appropriate replicas
- Use health checks

**Production:**
- Complete definitions
- Resource limits
- Health checks
- Backup strategy

**The key:** Headless service first. Volume claim templates. Health checks. Production-ready.

## Memory Tip: The Ordered Room Setup Analogy

**Creating StatefulSets = Setting up ordered rooms**

**Headless Service:** Room directory
**StatefulSet:** Ordered rooms
**Volume templates:** Storage per room

**Once you see it this way, creating StatefulSets makes perfect sense.**

## Common Mistakes

1. **No headless service**: DNS won't work
2. **Wrong serviceName**: Doesn't match
3. **No volume claim templates**: No persistent storage
4. **Not understanding ordering**: Confusion
5. **Using for stateless**: Wrong tool

## Key Takeaways

1. **Create headless service first** - Required for StatefulSet
2. **Use volume claim templates** - Individual storage per pod
3. **serviceName must match** - Critical requirement
4. **Ordered deployment** - Sequential creation
5. **Use for stateful apps** - Databases, queues

## What's Next?

Now that you understand creating StatefulSets, let's learn about StatefulSet scaling. Next: [StatefulSet Scaling](/docs/kubernetes/10-statefulsets/statefulset-scaling).

---

> **Remember**: Creating StatefulSets is like setting up ordered rooms. Headless service first. Volume claim templates. Stable identity. Use for stateful apps. Essential.

