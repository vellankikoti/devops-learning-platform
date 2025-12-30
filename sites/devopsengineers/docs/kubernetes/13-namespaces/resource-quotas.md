---
sidebar_position: 2
title: Resource Quotas
---

# Resource Quotas: Section Capacity Limits

**Resource Quotas are like section capacity limits. Maximum rooms per section. Maximum resources per section. That's Resource Quotas.**

## 🎯 The Big Picture

Think of Resource Quotas like section capacity limits. Production section can have maximum 50 rooms (pods). Maximum 100 CPU. Maximum 200Gi memory. That's Resource Quotas.

**Resource Quotas limit resources per namespace. CPU. Memory. Pods. Storage. Essential for resource management.**

## The Section Capacity Analogy

**Think of Resource Quotas like section capacity limits:**

**Quota:** Section capacity
- Maximum rooms (pods)
- Maximum resources
- Section limits

**CPU quota:** Processing capacity
- Maximum CPU
- Per section
- Limit

**Memory quota:** Storage capacity
- Maximum memory
- Per section
- Limit

**Once you see it this way, Resource Quotas make perfect sense.**

## What is a Resource Quota?

**ResourceQuota definition:**
- Limits resources per namespace
- CPU, memory, pods
- Storage, objects
- Hard limits

**Think of it as:** Section capacity. Limits. Hard limits.

## Why Resource Quotas?

**Problems without quotas:**
- Resource exhaustion
- One namespace uses all
- No limits
- Cluster issues

**Solutions with quotas:**
- Resource limits
- Fair distribution
- Prevent exhaustion
- Cluster stability

**Real example:** I once had no quotas. Dev namespace used all resources. Production affected. With quotas, limits. Fair. Never going back.

**Resource Quotas aren't optional. They're essential.**

## Creating Resource Quota

**Basic quota:**
```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: production-quota
  namespace: production
spec:
  hard:
    requests.cpu: "10"
    requests.memory: 20Gi
    limits.cpu: "20"
    limits.memory: 40Gi
    pods: "50"
    persistentvolumeclaims: "10"
    services: "10"
```

**What this does:**
- Limits CPU requests to 10
- Limits memory requests to 20Gi
- Limits pods to 50
- Hard limits

**Think of it as:** Section capacity. Maximum resources. Hard limits.

## Complete Production Quota

**Production-ready quota:**
```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: production-quota
  namespace: production
spec:
  hard:
    # Compute resources
    requests.cpu: "20"
    requests.memory: 40Gi
    limits.cpu: "40"
    limits.memory: 80Gi
    
    # Object counts
    pods: "100"
    services: "20"
    persistentvolumeclaims: "20"
    secrets: "50"
    configmaps: "50"
    
    # Storage
    requests.storage: 500Gi
    persistentvolumeclaims: "20"
```

**What this provides:**
- Complete resource limits
- Object count limits
- Storage limits
- Production-ready

**That's a complete quota. Production-ready.**

## Real-World Example: Complete Quota Setup

**Step 1: Create namespace:**
```bash
kubectl create namespace production
```

**Step 2: Create quota:**
```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: prod-quota
  namespace: production
spec:
  hard:
    requests.cpu: "10"
    requests.memory: 20Gi
    limits.cpu: "20"
    limits.memory: 40Gi
    pods: "50"
```

**Step 3: Verify:**
```bash
kubectl get resourcequota -n production
kubectl describe resourcequota prod-quota -n production
```

**Step 4: Test:**
```bash
# Try to create pod exceeding quota
kubectl run test --image=nginx -n production --requests=cpu=100
# Error: exceeded quota
```

**That's complete quota setup. Working. Enforced.**

## My Take: Quota Strategy

**Here's what I do:**

**Production:**
- Higher quotas
- More resources
- Essential services

**Development:**
- Lower quotas
- Limited resources
- Cost-effective

**Testing:**
- Minimal quotas
- Basic resources
- Cost-effective

**The key:** Set appropriate quotas. Production higher. Dev lower. Monitor usage.

## Memory Tip: The Section Capacity Analogy

**Resource Quotas = Section capacity limits**

**Quota:** Section capacity
**CPU quota:** Processing limit
**Memory quota:** Storage limit

**Once you see it this way, quotas make perfect sense.**

## Common Mistakes

1. **No quotas**: Resource exhaustion
2. **Too restrictive**: Can't deploy
3. **Not monitoring**: Don't know usage
4. **Wrong limits**: Over or under
5. **Not adjusting**: Stale quotas

## Key Takeaways

1. **Resource Quotas limit resources** - Per namespace
2. **Hard limits** - Can't exceed
3. **Set appropriately** - Production higher, dev lower
4. **Monitor usage** - Know consumption
5. **Essential for multi-tenant** - Fair distribution

## What's Next?

Now that you understand Resource Quotas, you've completed the Namespaces module. Next: [Understanding RBAC](/docs/kubernetes/14-rbac/understanding-rbac).

---

> **Remember**: Resource Quotas are like section capacity limits. Maximum resources per section. Hard limits. Set appropriately. Monitor usage. Essential for resource management.

