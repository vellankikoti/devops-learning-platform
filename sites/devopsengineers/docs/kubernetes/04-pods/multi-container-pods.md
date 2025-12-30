---
sidebar_position: 4
title: Multi-Container Pods
---

# Multi-Container Pods: Suite Rooms

**Multi-container pods are like suite rooms. Multiple guests. Share room resources. Work together. That's multi-container pods.**

## 🎯 The Big Picture

Think of multi-container pods like suite rooms. Multiple guests (containers) in same suite (pod). Share suite resources (network, storage). Work together. That's multi-container pods.

**Multi-container pods have multiple containers. Share network namespace. Share storage volumes. Work together as a unit.**

## The Suite Room Analogy

**Think of multi-container pods like suite rooms:**

**Pod:** Suite room
- Multiple guests can stay
- Share suite resources
- Work together

**Containers:** Suite guests
- Different guests (containers)
- Different purposes
- Share suite

**Network:** Suite phone
- Shared by all guests
- Same network namespace
- localhost communication

**Storage:** Suite storage
- Shared by all guests
- Same volumes
- Common data

**Once you see it this way, multi-container pods make perfect sense.**

## Why Multi-Container Pods?

**Use cases:**

**Sidecar containers:**
- Helper containers
- Logging, monitoring
- Support main container

**Init containers:**
- Setup tasks
- Run before main
- One-time initialization

**Adapter containers:**
- Transform data
- Format conversion
- Data processing

**Think of it as:** Suite guests. Main guest. Helper guests. Support staff.

## Sidecar Pattern

**Most common pattern:**

**What it is:**
- Main container + sidecar
- Sidecar supports main
- Shared resources

**Example:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: suite-room
spec:
  containers:
  - name: main-guest
    image: my-app:1.0
    ports:
    - containerPort: 8080
    volumeMounts:
    - name: shared-logs
      mountPath: /var/log
  - name: log-sidecar
    image: fluentd:latest
    volumeMounts:
    - name: shared-logs
      mountPath: /var/log
  volumes:
  - name: shared-logs
    emptyDir: {}
```

**Think of it as:** Main guest + helper. Helper supports main. Share resources.

**Why use:**
- Logging
- Monitoring
- Proxy
- Helper services

## Init Containers

**Run before main containers:**

**What they do:**
- Setup tasks
- Initialize data
- Wait for dependencies
- Run to completion

**Example:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: init-suite
spec:
  initContainers:
  - name: setup
    image: busybox
    command: ['sh', '-c', 'echo "Setting up..." && sleep 5']
  - name: wait-for-db
    image: busybox
    command: ['sh', '-c', 'until nc -z db 5432; do sleep 1; done']
  containers:
  - name: main-guest
    image: my-app:1.0
```

**Think of it as:** Setup staff. Prepare suite. Wait for services. Then main guest arrives.

**Why use:**
- Database migration
- Wait for dependencies
- Setup configuration
- Initialize data

## Adapter Pattern

**Transform data:**

**What it does:**
- Transform output
- Format conversion
- Data processing

**Example:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: adapter-suite
spec:
  containers:
  - name: app
    image: my-app:1.0
    volumeMounts:
    - name: shared-data
      mountPath: /data
  - name: adapter
    image: adapter:latest
    volumeMounts:
    - name: shared-data
      mountPath: /data
    command: ['sh', '-c', 'while true; do transform /data; sleep 10; done']
  volumes:
  - name: shared-data
    emptyDir: {}
```

**Think of it as:** Main guest produces. Adapter transforms. Shared data.

## Container Communication

**How containers communicate:**

**localhost:**
- Same network namespace
- Use localhost
- Direct communication

**Example:**
```yaml
containers:
- name: app
  image: my-app:1.0
  # App listens on localhost:8080
- name: proxy
  image: nginx:alpine
  # Proxy forwards to localhost:8080
```

**Think of it as:** Suite guests. Same phone line. Call each other via localhost.

## Shared Volumes

**How containers share data:**

**Volume mounts:**
- Same volume
- Different mount points
- Shared data

**Example:**
```yaml
containers:
- name: app
  image: my-app:1.0
  volumeMounts:
  - name: shared
    mountPath: /app/data
- name: sidecar
  image: sidecar:latest
  volumeMounts:
  - name: shared
    mountPath: /sidecar/data
volumes:
- name: shared
  emptyDir: {}
```

**Think of it as:** Suite storage. Shared by all guests. Common data.

## Real-World Example: Complete Multi-Container Pod

**Production-ready multi-container pod:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: production-suite
  labels:
    app: hotel-app
spec:
  initContainers:
  - name: migrate-db
    image: migrate:1.0
    command: ['sh', '-c', 'migrate up']
    env:
    - name: DATABASE_URL
      valueFrom:
        secretKeyRef:
          name: db-secret
          key: url
  containers:
  - name: app
    image: hotel-app:1.0.0
    ports:
    - containerPort: 8080
    env:
    - name: NODE_ENV
      value: "production"
    volumeMounts:
    - name: config
      mountPath: /app/config
    - name: logs
      mountPath: /var/log
    resources:
      requests:
        memory: "256Mi"
        cpu: "250m"
      limits:
        memory: "512Mi"
        cpu: "500m"
  - name: log-collector
    image: fluentd:latest
    volumeMounts:
    - name: logs
      mountPath: /var/log
    resources:
      requests:
        memory: "64Mi"
        cpu: "100m"
      limits:
        memory: "128Mi"
        cpu: "200m"
  - name: metrics
    image: prometheus-exporter:latest
    ports:
    - containerPort: 9090
    volumeMounts:
    - name: config
      mountPath: /metrics/config
  volumes:
  - name: config
    configMap:
      name: app-config
  - name: logs
    emptyDir: {}
```

**That's a complete multi-container pod. Production-ready. Comprehensive.**

## Best Practices

### Use Sidecars Wisely

**When to use:**
- Logging
- Monitoring
- Proxy
- Helper services

**When not to use:**
- Separate concerns
- Independent scaling
- Different lifecycles

### Init Containers for Setup

**Use for:**
- Database migration
- Wait for dependencies
- Setup tasks
- One-time initialization

**Don't use for:**
- Long-running tasks
- Main application logic
- Services

### Resource Management

**Set resources for all:**
- Each container needs resources
- Total pod resources = sum
- Plan accordingly

**Think of it as:** Suite resources. All guests need resources. Total matters.

## My Take: Multi-Container Strategy

**Here's what I do:**

**Use sidecars for:**
- Logging
- Monitoring
- Helper services

**Use init containers for:**
- Setup tasks
- Wait for dependencies
- Initialization

**The key:** Use when makes sense. Don't over-complicate. Keep it simple.

## Memory Tip: The Suite Room Analogy

**Multi-container pods = Suite rooms**

**Pod:** Suite
**Containers:** Suite guests
**Network:** Suite phone
**Storage:** Suite storage
**Sidecar:** Helper guest
**Init:** Setup staff

**Once you see it this way, multi-container pods make perfect sense.**

## Common Mistakes

1. **Over-using multi-container**: Unnecessary complexity
2. **Not setting resources**: Resource issues
3. **Wrong communication**: Not using localhost
4. **Not sharing volumes**: Can't share data
5. **Ignoring init containers**: Missing setup

## Key Takeaways

1. **Multi-container pods share resources** - Network, storage
2. **Sidecar pattern is common** - Helper containers
3. **Init containers for setup** - Run before main
4. **localhost communication** - Same network namespace
5. **Shared volumes** - Common data

## What's Next?

Now that you understand multi-container pods, let's learn about pod resources. Next: [Pod Resources](/docs/kubernetes/04-pods/pod-resources).

---

> **Remember**: Multi-container pods are like suite rooms. Multiple guests. Share resources. Work together. Use sidecars wisely. Init containers for setup.

