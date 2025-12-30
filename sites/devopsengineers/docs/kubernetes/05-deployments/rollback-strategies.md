---
sidebar_position: 5
title: Rollback Strategies
---

# Rollback Strategies: Reverting Room Renovation

**Rollback is like reverting room renovation. New design failed? Go back to previous. Quick recovery. That's rollback.**

## 🎯 The Big Picture

Think of rollback like reverting room renovation. New room design failed? Guests unhappy? Revert to previous design. Quick recovery. That's rollback.

**Rollback reverts deployment to previous version. Quick recovery. Automatic or manual. Essential for production.**

## The Renovation Reversion Analogy

**Think of rollback like reverting renovation:**

**Update failed:** New design failed
- Guests unhappy
- Problems occurred
- Need to revert

**Rollback:** Revert to previous
- Previous design restored
- Quick recovery
- Service restored

**Automatic rollback:** Automatic reversion
- Health checks fail
- Automatic revert
- Quick recovery

**Once you see it this way, rollback makes perfect sense.**

## Why Rollback?

**Problems without rollback:**
- Stuck with broken version
- Manual recovery
- Long downtime
- Service disruption

**Solutions with rollback:**
- Quick recovery
- Automatic or manual
- Previous version restored
- Service restored

**Real example:** I once deployed broken version. No rollback. Manual fix took hours. With rollback, seconds. Never again.

**Rollback isn't optional. It's essential.**

## Automatic Rollback

**How it works:**

**Health checks:**
- Monitor pod health
- Detect failures
- Trigger rollback

**Configuration:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hotel-management
spec:
  replicas: 5
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 2
      maxUnavailable: 1
  minReadySeconds: 30
  progressDeadlineSeconds: 600
  template:
    spec:
      containers:
      - name: app
        image: hotel-app:2.0.0
        livenessProbe:
          httpGet:
            path: /health
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 10
          failureThreshold: 3
```

**What happens:**
- Health checks fail
- Deployment detects failure
- Automatic rollback
- Previous version restored

**Think of it as:** Automatic renovation reversion. Health checks fail. Auto-revert.

## Manual Rollback

**How to rollback:**

**Rollback command:**
```bash
kubectl rollout undo deployment/hotel-management
```

**What happens:**
- Previous ReplicaSet restored
- New ReplicaSet scaled to 0
- Previous version active

**Think of it as:** Manual renovation reversion. Command. Previous restored.

**Check rollback:**
```bash
kubectl rollout status deployment/hotel-management
```

## Rollback History

**View rollout history:**
```bash
kubectl rollout history deployment/hotel-management
```

**Output:**
```
REVISION  CHANGE-CAUSE
1         <none>
2         kubectl set image deployment/hotel-management app=hotel-app:2.0.0
3         kubectl set image deployment/hotel-management app=hotel-app:3.0.0
```

**Rollback to specific revision:**
```bash
kubectl rollout undo deployment/hotel-management --to-revision=1
```

**Think of it as:** Renovation history. Previous designs. Choose which to revert to.

## Complete Rollback Journey

**Let's trace a complete rollback using hotel analogy:**

### Step 1: Problem Detected (Health Checks Fail)

**What happens:**
- New room design has problems
- Guests complaining
- Health checks failing

**Kubernetes:**
- Health checks fail
- Deployment detects
- Rollback triggered

**Think of it as:** Problem detected. Health checks fail. Rollback needed.

### Step 2: Rollback Triggered (Revert Request)

**What happens:**
- Hotel manager (deployment) receives revert request
- Previous design needed
- Rollback started

**Kubernetes:**
```bash
kubectl rollout undo deployment/hotel-management
```

**Think of it as:** Revert request. Previous design. Rollback started.

### Step 3: Previous Floor Restored (Previous ReplicaSet)

**What happens:**
- Previous floor (previous ReplicaSet) restored
- Previous rooms (previous pods) created
- New floor (new ReplicaSet) scaled down

**Kubernetes:**
- Previous ReplicaSet scaled up
- New ReplicaSet scaled to 0
- Previous version active

**Think of it as:** Previous floor restored. Previous rooms. New floor closed.

### Step 4: Gradual Migration (Pods Replaced)

**What happens:**
- Guests gradually move back to previous rooms
- New rooms gradually closed
- No interruption

**Kubernetes:**
- Previous pods become ready
- New pods terminated
- Gradual replacement
- Traffic shifts back

**Think of it as:** Gradual migration back. No interruption. Smooth.

### Step 5: Rollback Complete (Previous Version Active)

**What happens:**
- All guests in previous rooms
- All new rooms closed
- Rollback complete

**Kubernetes:**
- All previous pods running
- New ReplicaSet scaled to 0
- Previous version active
- Rollback complete

**Think of it as:** Rollback complete. Previous design. Service restored.

## Real-World Example: Complete Rollback

**Scenario: Update failed**

**Step 1: Update deployed:**
```bash
kubectl set image deployment/hotel-management app=hotel-app:2.0.0
```

**Step 2: Problem detected:**
```bash
kubectl get pods
# Pods crashing
kubectl logs <pod-name>
# Application errors
```

**Step 3: Rollback:**
```bash
kubectl rollout undo deployment/hotel-management
```

**Output:**
```
deployment.apps/hotel-management rolled back
```

**Step 4: Verify:**
```bash
kubectl rollout status deployment/hotel-management
kubectl get pods
# Previous version running
```

**Step 5: Confirm:**
```bash
kubectl get deployment hotel-management -o yaml | grep image
# Image: hotel-app:1.0.0 (previous version)
```

**That's complete rollback. Quick recovery. Service restored.**

## Best Practices

### Always Test Rollback

**Why:**
- Know it works
- Quick recovery
- Confidence

**Test:**
- Deploy test update
- Rollback
- Verify works

### Monitor Health Checks

**Why:**
- Detect failures early
- Trigger automatic rollback
- Quick recovery

**Monitor:**
- Liveness probes
- Readiness probes
- Application health

### Keep Rollout History

**Why:**
- Know what changed
- Rollback to specific version
- Audit trail

**Keep:**
- Revision history
- Change causes
- Documentation

## My Take: Rollback Strategy

**Here's what I do:**

**Always:**
- Test rollback
- Monitor health checks
- Keep history
- Document changes

**When needed:**
- Quick rollback
- Verify recovery
- Investigate issue
- Fix and redeploy

**The key:** Always test rollback. Monitor health. Quick recovery.

## Memory Tip: The Renovation Reversion Analogy

**Rollback = Reverting renovation**

**Update failed:** New design failed
**Rollback:** Revert to previous
**Automatic:** Auto-revert
**Manual:** Command revert

**Once you see it this way, rollback makes perfect sense.**

## Common Mistakes

1. **Not testing rollback**: Don't know if works
2. **No health checks**: Can't detect failures
3. **Not keeping history**: Can't rollback to specific version
4. **Delaying rollback**: Longer downtime
5. **Not monitoring**: Don't know when to rollback

## Key Takeaways

1. **Rollback enables quick recovery** - Revert to previous version
2. **Automatic or manual** - Health checks or command
3. **Keep rollout history** - Know what changed
4. **Test rollback** - Know it works
5. **Monitor health checks** - Detect failures early

## What's Next?

Now that you understand rollback strategies, let's learn about deployment troubleshooting. Next: [Deployment Troubleshooting](/docs/kubernetes/05-deployments/deployment-troubleshooting).

---

> **Remember**: Rollback is like reverting renovation. New design failed? Revert to previous. Quick recovery. Test rollback. Monitor health. Essential for production.

