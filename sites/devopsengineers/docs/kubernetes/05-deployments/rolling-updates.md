---
sidebar_position: 4
title: Rolling Updates
---

# Rolling Updates: Room Renovation Without Interruption

**Rolling updates are like room renovation. Update rooms gradually. No interruption. Guests never notice. That's rolling updates.**

## 🎯 The Big Picture

Think of rolling updates like room renovation. Update rooms one by one. Guests move to renovated rooms. Old rooms closed. No interruption. That's rolling updates.

**Rolling updates update deployments gradually. Create new pods. Terminate old pods. Zero downtime. Smooth transition.**

## The Room Renovation Analogy

**Think of rolling updates like room renovation:**

**Update request:** Renovation needed
- New room design
- Update required
- Smooth transition

**New ReplicaSet:** New floor design
- New rooms created
- New design
- Gradual migration

**Old ReplicaSet:** Old floor design
- Old rooms still available
- Gradual closure
- No interruption

**Gradual migration:** Guests move gradually
- New rooms ready
- Old rooms close
- Smooth transition

**Once you see it this way, rolling updates make perfect sense.**

## Why Rolling Updates?

**Problems without rolling updates:**
- Downtime during updates
- All pods updated at once
- Service interruption
- Risk of failure

**Solutions with rolling updates:**
- Zero downtime
- Gradual update
- Service continues
- Automatic rollback

**Real example:** I once updated all pods at once. Service down. Users affected. With rolling updates, zero downtime. Never going back.

**Rolling updates aren't optional. They're essential.**

## How Rolling Updates Work

**Complete update process:**

**Step 1: Update triggered**
- New image version
- Deployment updated
- Update started

**Step 2: New ReplicaSet created**
- Deployment creates new ReplicaSet
- New ReplicaSet creates new pods
- Old ReplicaSet still running

**Step 3: New pods become ready**
- New pods start
- Health checks pass
- Ready to serve traffic

**Step 4: Old pods terminated**
- Traffic moves to new pods
- Old pods terminated
- Gradual replacement

**Step 5: Update complete**
- All new pods running
- Old ReplicaSet scaled to 0
- Update complete

**Think of it as:** Room renovation. New rooms. Gradual migration. Old rooms close. Smooth.

## Update Strategy Configuration

**Rolling update strategy:**
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
  template:
    spec:
      containers:
      - name: app
        image: hotel-app:2.0.0
```

**What this means:**
- `maxSurge: 2` - Can have 2 extra pods during update
- `maxUnavailable: 1` - Maximum 1 pod unavailable
- Gradual update
- Controlled pace

**Think of it as:** Renovation pace. How many rooms at once. Controlled.

## Complete Update Journey

**Let's trace a complete rolling update using hotel analogy:**

### Step 1: Renovation Request (Update Triggered)

**What happens:**
- Hotel manager (deployment) receives renovation request
- New room design (new image version)
- Update needed

**Kubernetes:**
```bash
kubectl set image deployment/hotel-management app=hotel-app:2.0.0
```

**Think of it as:** Renovation request. New design. Update needed.

### Step 2: New Floor Created (New ReplicaSet)

**What happens:**
- Hotel manager creates new floor (new ReplicaSet)
- New rooms with new design (new pods)
- Old floor still operational

**Kubernetes:**
- Deployment creates new ReplicaSet
- New ReplicaSet creates new pods
- Old ReplicaSet still running

**Think of it as:** New floor created. New rooms. Old floor still available.

### Step 3: First New Room Ready (First New Pod Ready)

**What happens:**
- First new room ready (first new pod ready)
- Guest can move in (traffic can route)
- Renovation progressing

**Kubernetes:**
- New pod starts
- Health checks pass
- Pod ready
- Traffic routes to new pod

**Think of it as:** First new room ready. Guest moves. Progress.

### Step 4: Gradual Migration (Pods Replaced)

**What happens:**
- Guests gradually move to new rooms
- Old rooms gradually closed
- No interruption

**Kubernetes:**
- New pods become ready
- Old pods terminated
- Gradual replacement
- Traffic shifts gradually

**Think of it as:** Gradual migration. No interruption. Smooth.

### Step 5: Renovation Complete (Update Complete)

**What happens:**
- All guests in new rooms
- All old rooms closed
- Renovation complete

**Kubernetes:**
- All new pods running
- Old ReplicaSet scaled to 0
- Deployment updated
- Update complete

**Think of it as:** Renovation complete. All new. Smooth transition.

## Update Commands

**Trigger update:**

**Set image:**
```bash
kubectl set image deployment/hotel-management app=hotel-app:2.0.0
```

**Edit deployment:**
```bash
kubectl edit deployment hotel-management
# Change image version
```

**Apply updated YAML:**
```bash
kubectl apply -f deployment.yaml
```

**Think of it as:** Different ways to request renovation. All work.

## Monitoring Updates

**Watch update progress:**

**Check deployment:**
```bash
kubectl get deployment hotel-management
```

**Output:**
```
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
hotel-management  5/5     3            5           5m
```

**Check rollout status:**
```bash
kubectl rollout status deployment/hotel-management
```

**Output:**
```
Waiting for rollout to finish: 2 of 5 new replicas have been updated...
Waiting for rollout to finish: 4 of 5 new replicas have been updated...
deployment "hotel-management" successfully rolled out
```

**Watch pods:**
```bash
kubectl get pods -l app=hotel-app -w
```

**Think of it as:** Monitor renovation. See progress. Know status.

## Real-World Example: Complete Rolling Update

**Step 1: Current state:**
```bash
kubectl get deployment
# 5 replicas, image: hotel-app:1.0.0
```

**Step 2: Trigger update:**
```bash
kubectl set image deployment/hotel-management app=hotel-app:2.0.0
```

**Step 3: Monitor:**
```bash
kubectl rollout status deployment/hotel-management
```

**Step 4: Watch progress:**
```bash
kubectl get pods -l app=hotel-app
# See new pods (2.0.0) and old pods (1.0.0)
```

**Step 5: Verify complete:**
```bash
kubectl get deployment
# All replicas updated
# Image: hotel-app:2.0.0
```

**That's complete rolling update. Zero downtime. Smooth.**

## My Take: Rolling Update Strategy

**Here's what I do:**

**Update strategy:**
- Use RollingUpdate
- Set appropriate maxSurge/maxUnavailable
- Monitor progress
- Test rollback

**The key:** Use rolling updates. Zero downtime. Monitor. Test rollback.

## Memory Tip: The Room Renovation Analogy

**Rolling updates = Room renovation**

**Update request:** Renovation needed
**New ReplicaSet:** New floor
**Gradual migration:** Guests move
**Update complete:** All new

**Once you see it this way, rolling updates make perfect sense.**

## Common Mistakes

1. **Not using rolling updates**: Downtime
2. **Wrong strategy settings**: Too fast or too slow
3. **Not monitoring**: Don't know progress
4. **No health checks**: Unhealthy pods serve traffic
5. **Not testing rollback**: Don't know if works

## Key Takeaways

1. **Rolling updates enable zero downtime** - Gradual update
2. **New ReplicaSet created** - Old still running
3. **Gradual pod replacement** - Smooth transition
4. **Monitor progress** - Know status
5. **Test rollback** - Be prepared

## What's Next?

Now that you understand rolling updates, let's learn about rollback strategies. Next: [Rollback Strategies](/docs/kubernetes/05-deployments/rollback-strategies).

---

> **Remember**: Rolling updates are like room renovation. Update gradually. No interruption. Zero downtime. Monitor progress. Smooth transition.

