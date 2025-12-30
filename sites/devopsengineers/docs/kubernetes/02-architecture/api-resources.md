---
sidebar_position: 4
title: API Resources
---

# API Resources: The Hotel's Resource Catalog

**Kubernetes API resources are like a hotel's resource catalog. Pods are rooms. Services are room service. Deployments are room management. That's API resources.**

## 🎯 The Big Picture

Think of API resources like a hotel's resource catalog. Different types of resources. Different purposes. All managed through the API. That's API resources.

**Kubernetes API resources are objects you can create and manage. Pods. Services. Deployments. ConfigMaps. Secrets. All resources.**

## What are API Resources?

**API resources are Kubernetes objects:**

**What they are:**
- Objects you create
- Managed by Kubernetes
- Defined in YAML/JSON
- Stored in etcd

**Think of it as:** Hotel resource catalog. Different types. Different purposes.

## Core Resources

### Pods: Hotel Rooms

**What they are:**
- Smallest deployable unit
- One or more containers
- Shared network and storage

**Think of it as:** Hotel rooms. Contain guests (containers). Basic unit.

**Example:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-room
spec:
  containers:
  - name: guest
    image: nginx:alpine
```

### Services: Room Service

**What they are:**
- Stable network endpoint
- Load balancing
- Service discovery

**Think of it as:** Room service. Stable endpoint. Routes to rooms (pods).

**Example:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: room-service
spec:
  selector:
    app: my-app
  ports:
  - port: 80
```

### Deployments: Room Management

**What they are:**
- Manage pod replicas
- Rolling updates
- Rollback capability

**Think of it as:** Room management. Manages multiple rooms (pods). Handles updates.

**Example:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: room-management
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: app
        image: nginx:alpine
```

## Configuration Resources

### ConfigMaps: Hotel Information Board

**What they are:**
- Configuration data
- Key-value pairs
- Non-sensitive

**Think of it as:** Hotel information board. Configuration. Public information.

**Example:**
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: hotel-info
data:
  hotel-name: "Luxury Hotel"
  check-in-time: "3:00 PM"
```

### Secrets: Hotel Safe

**What they are:**
- Sensitive data
- Encrypted at rest
- Base64 encoded

**Think of it as:** Hotel safe. Sensitive information. Secure storage.

**Example:**
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: hotel-safe
type: Opaque
data:
  password: <base64-encoded>
```

## Storage Resources

### PersistentVolumes: Hotel Storage

**What they are:**
- Persistent storage
- Cluster-wide
- Lifecycle independent of pods

**Think of it as:** Hotel storage. Persistent. Available to all rooms.

### PersistentVolumeClaims: Storage Request

**What they are:**
- Request for storage
- Bound to PersistentVolume
- Used by pods

**Think of it as:** Storage request. Requests storage. Gets assigned.

## Workload Resources

### ReplicaSets: Room Replication

**What they are:**
- Maintains pod replicas
- Ensures desired count
- Used by Deployments

**Think of it as:** Room replication. Maintains multiple rooms. Ensures availability.

### StatefulSets: Ordered Rooms

**What they are:**
- Stateful applications
- Ordered deployment
- Stable network identity

**Think of it as:** Ordered rooms. Stateful. Stable identity.

### DaemonSets: Floor Service

**What they are:**
- Runs on every node
- System services
- Node-level operations

**Think of it as:** Floor service. On every floor. System services.

### Jobs: One-Time Tasks

**What they are:**
- One-time execution
- Runs to completion
- Batch processing

**Think of it as:** One-time tasks. Runs once. Completes.

### CronJobs: Scheduled Tasks

**What they are:**
- Scheduled execution
- Cron-like syntax
- Recurring tasks

**Think of it as:** Scheduled tasks. Recurring. Automated.

## The Hotel Resource Catalog Analogy

**Think of API resources like hotel resource catalog:**

**Pods:** Rooms
**Services:** Room service
**Deployments:** Room management
**ConfigMaps:** Information board
**Secrets:** Safe
**PersistentVolumes:** Storage
**ReplicaSets:** Room replication
**StatefulSets:** Ordered rooms
**DaemonSets:** Floor service
**Jobs:** One-time tasks
**CronJobs:** Scheduled tasks

**Once you see it this way, API resources make perfect sense.**

## Resource Categories

**Workloads:**
- Pods
- Deployments
- ReplicaSets
- StatefulSets
- DaemonSets
- Jobs
- CronJobs

**Service:**
- Services
- Ingress

**Configuration:**
- ConfigMaps
- Secrets

**Storage:**
- PersistentVolumes
- PersistentVolumeClaims
- StorageClasses

**And more:**
- Namespaces
- ServiceAccounts
- RBAC resources

## Real-World Example: Complete Application

**Complete application resources:**

**1. Namespace:**
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: hotel-app
```

**2. ConfigMap:**
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  env: production
```

**3. Secret:**
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secret
type: Opaque
data:
  password: <base64>
```

**4. Deployment:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app
spec:
  replicas: 3
  template:
    spec:
      containers:
      - name: app
        image: my-app:1.0
```

**5. Service:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: app-service
spec:
  selector:
    app: my-app
  ports:
  - port: 80
```

**That's a complete application. Multiple resources. Working together.**

## My Take: API Resources Strategy

**Here's what I think:**

**Understanding resources:**
- Essential for Kubernetes
- Know what resources exist
- Understand their purpose
- Use appropriately

**The key:** Learn resources progressively. Start with core. Add advanced. Use appropriately.

## Memory Tip: The Hotel Resource Catalog Analogy

**API resources = Hotel resource catalog**

**Pods:** Rooms
**Services:** Room service
**Deployments:** Management
**ConfigMaps:** Information
**Secrets:** Safe

**Once you see it this way, API resources make perfect sense.**

## Common Mistakes

1. **Not understanding resources**: Confusing types
2. **Using wrong resource**: Wrong choice
3. **Not knowing purpose**: Missing understanding
4. **Over-complicating**: Too many resources
5. **Not learning progressively**: Skipping fundamentals

## Key Takeaways

1. **API resources are Kubernetes objects** - Different types, different purposes
2. **Core resources are essential** - Pods, Services, Deployments
3. **Configuration resources manage config** - ConfigMaps, Secrets
4. **Storage resources manage data** - PersistentVolumes, Claims
5. **Learn progressively** - Start with core, add advanced

## What's Next?

Now that you understand API resources, let's learn about etcd. Next: [etcd Deep Dive](/docs/kubernetes/02-architecture/etcd-deep-dive).

---

> **Remember**: API resources are like hotel resource catalog. Pods are rooms. Services are room service. Deployments are management. Different types. Different purposes. All managed through API.

