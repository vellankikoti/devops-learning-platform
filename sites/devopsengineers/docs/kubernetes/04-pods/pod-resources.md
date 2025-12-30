---
sidebar_position: 5
title: Pod Resources
---

# Pod Resources: Room Capacity and Limits

**Pod resources are like room capacity. Requests are minimum. Limits are maximum. That's pod resources.**

## 🎯 The Big Picture

Think of pod resources like room capacity. Requests are minimum room size needed. Limits are maximum room size allowed. That's pod resources.

**Pod resources define CPU and memory. Requests guarantee minimum. Limits prevent maximum. Essential for resource management.**

## The Room Capacity Analogy

**Think of pod resources like room capacity:**

**Requests:** Minimum room size
- Guaranteed space
- Always available
- Scheduling consideration

**Limits:** Maximum room size
- Can't exceed
- Prevents overuse
- Hard limit

**CPU:** Processing power
- Room amenities
- How much power
- Processing capacity

**Memory:** Storage space
- Room storage
- How much space
- Memory capacity

**Once you see it this way, pod resources make perfect sense.**

## Resource Requests

**What they are:**
- Minimum resources needed
- Guaranteed resources
- Scheduling consideration

**Why important:**
- Ensures resources available
- Helps scheduling
- Prevents overcommitment

**Think of it as:** Minimum room size. Guaranteed. Always available.

**Example:**
```yaml
resources:
  requests:
    memory: "256Mi"
    cpu: "250m"
```

**What this means:**
- Guaranteed 256Mi memory
- Guaranteed 250m CPU
- Scheduler ensures available

## Resource Limits

**What they are:**
- Maximum resources allowed
- Hard limit
- Prevents overuse

**Why important:**
- Prevents resource exhaustion
- Protects other pods
- Ensures fairness

**Think of it as:** Maximum room size. Can't exceed. Hard limit.

**Example:**
```yaml
resources:
  limits:
    memory: "512Mi"
    cpu: "500m"
```

**What this means:**
- Can't use more than 512Mi
- Can't use more than 500m CPU
- Hard limit enforced

## Complete Resource Definition

**Production-ready resources:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: resource-room
spec:
  containers:
  - name: app
    image: my-app:1.0
    resources:
      requests:
        memory: "256Mi"
        cpu: "250m"
      limits:
        memory: "512Mi"
        cpu: "500m"
```

**What this provides:**
- Guaranteed minimum
- Maximum limit
- Resource protection
- Fair scheduling

**Think of it as:** Complete room capacity. Minimum. Maximum. Protected.

## CPU Resources

**CPU units:**
- `1` = 1 CPU core
- `500m` = 0.5 CPU core
- `250m` = 0.25 CPU core

**Example:**
```yaml
resources:
  requests:
    cpu: "250m"  # 0.25 CPU
  limits:
    cpu: "500m"  # 0.5 CPU
```

**Think of it as:** Room processing power. Minimum. Maximum.

## Memory Resources

**Memory units:**
- `1Gi` = 1024 MiB
- `512Mi` = 512 MiB
- `256Mi` = 256 MiB

**Example:**
```yaml
resources:
  requests:
    memory: "256Mi"
  limits:
    memory: "512Mi"
```

**Think of it as:** Room storage. Minimum. Maximum.

## Resource Requests and Scheduling

**How scheduler uses requests:**

**Scheduler considers:**
- Node available resources
- Pod resource requests
- Finds suitable node

**Example:**
- Node has 2 CPU, 4Gi memory
- Pod requests 1 CPU, 2Gi memory
- Scheduler can place pod

**Think of it as:** Room assignment. Check available. Assign if fits.

## Resource Limits and Enforcement

**How limits are enforced:**

**CPU limits:**
- Throttled if exceeds
- Not killed
- Slowed down

**Memory limits:**
- Killed if exceeds
- OOMKilled
- Container restarted

**Think of it as:** Room capacity. CPU throttled. Memory killed.

## Multi-Container Resources

**Resources per container:**

**Each container:**
- Has own requests
- Has own limits
- Independent

**Pod total:**
- Sum of all containers
- Total pod resources
- Scheduler considers total

**Example:**
```yaml
containers:
- name: app
  resources:
    requests:
      memory: "256Mi"
      cpu: "250m"
    limits:
      memory: "512Mi"
      cpu: "500m"
- name: sidecar
  resources:
    requests:
      memory: "64Mi"
      cpu: "100m"
    limits:
      memory: "128Mi"
      cpu: "200m"
```

**Pod total:**
- Requests: 320Mi memory, 350m CPU
- Limits: 640Mi memory, 700m CPU

**Think of it as:** Suite resources. Each guest. Total suite.

## Real-World Example: Production Resources

**Complete production pod:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: production-room
spec:
  containers:
  - name: app
    image: my-app:1.0.0
    resources:
      requests:
        memory: "512Mi"
        cpu: "500m"
      limits:
        memory: "1Gi"
        cpu: "1000m"
    livenessProbe:
      httpGet:
        path: /health
        port: 8080
      initialDelaySeconds: 30
      periodSeconds: 10
    readinessProbe:
      httpGet:
        path: /ready
        port: 8080
      initialDelaySeconds: 5
      periodSeconds: 5
```

**That's production resources. Appropriate. Protected.**

## Best Practices

### Always Set Resources

**Why:**
- Prevents overcommitment
- Helps scheduling
- Protects cluster

**Always:**
- Set requests
- Set limits
- Both important

### Right-Size Resources

**How:**
- Profile application
- Measure usage
- Set appropriately

**Don't:**
- Over-provision
- Under-provision
- Guess

### Monitor Resource Usage

**Why:**
- Know actual usage
- Adjust if needed
- Optimize

**Monitor:**
- CPU usage
- Memory usage
- Adjust resources

## My Take: Resource Strategy

**Here's what I do:**

**Development:**
- Lower resources
- Quick testing
- Basic limits

**Production:**
- Appropriate resources
- Based on profiling
- Protected limits

**The key:** Always set resources. Right-size. Monitor. Adjust.

## Memory Tip: The Room Capacity Analogy

**Pod resources = Room capacity**

**Requests:** Minimum size
**Limits:** Maximum size
**CPU:** Processing power
**Memory:** Storage space

**Once you see it this way, resources make perfect sense.**

## Common Mistakes

1. **Not setting resources**: Overcommitment, poor scheduling
2. **Wrong sizing**: Over or under provisioned
3. **Only limits**: Missing requests
4. **Only requests**: Missing limits
5. **Not monitoring**: Don't know actual usage

## Key Takeaways

1. **Always set resources** - Requests and limits
2. **Requests guarantee minimum** - Scheduling consideration
3. **Limits prevent maximum** - Resource protection
4. **Right-size resources** - Based on profiling
5. **Monitor usage** - Adjust as needed

## What's Next?

Congratulations! You've completed the Pods module. Now let's learn about deployments. Next: [Understanding Deployments](/docs/kubernetes/05-deployments/understanding-deployments).

---

> **Remember**: Pod resources are like room capacity. Requests are minimum. Limits are maximum. Always set both. Right-size. Monitor. Essential for resource management.

