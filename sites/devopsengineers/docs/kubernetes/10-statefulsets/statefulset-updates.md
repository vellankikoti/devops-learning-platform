---
sidebar_position: 4
title: StatefulSet Updates
---

# StatefulSet Updates: Updating Ordered Rooms

**StatefulSet updates are like updating ordered hotel rooms. Update rooms one by one. In order. No interruption. That's StatefulSet updates.**

## 🎯 The Big Picture

Think of StatefulSet updates like updating ordered hotel rooms. Update room 101 first. Then 102. Then 103. In order. No interruption. That's StatefulSet updates.

**StatefulSet updates update pods. Ordered updates. One at a time. Rolling updates. Essential for stateful apps.**

## The Ordered Room Update Analogy

**Think of StatefulSet updates like ordered room updates:**

**Update request:** Renovation needed
- New room design
- Update required
- Ordered update

**Ordered update:** Update in order
- Room 101 first
- Room 102 second
- Room 103 third
- Sequential

**Rolling update:** One at a time
- Update room 101
- Wait for ready
- Update room 102
- Gradual

**Once you see it this way, StatefulSet updates make perfect sense.**

## Update Strategies

**Two strategies:**

**RollingUpdate:**
- Update one pod at a time
- Ordered
- Zero downtime

**OnDelete:**
- Update only when pod deleted
- Manual control
- Full control

**Example:**
```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: database
spec:
  updateStrategy:
    type: RollingUpdate
    rollingUpdate:
      partition: 0
  template:
    spec:
      containers:
      - name: db
        image: postgres:16-alpine  # New version
```

**Think of it as:** Update method. Rolling or manual. Choose strategy.

## Rolling Update

**How it works:**

**Update process:**
- Update pod 0 first
- Wait for ready
- Update pod 1
- Wait for ready
- Update pod 2
- Sequential

**Partition:**
- Controls update
- partition: 0 updates all
- partition: 2 updates only pod 2, 3
- Canary updates

**Think of it as:** Update rooms. In order. Partition controls.

## Complete Update Journey

**Let's trace an update using hotel analogy:**

### Step 1: Update Request (Renovation Needed)

**What happens:**
- Hotel manager (StatefulSet) receives update
- New room design (new image)
- Update needed

**Kubernetes:**
```bash
kubectl set image statefulset/database db=postgres:17-alpine
```

**Think of it as:** Renovation request. New design. Update needed.

### Step 2: Update Room 101 (Update Pod 0)

**What happens:**
- Room 101 updated first
- New design applied
- Guest moves temporarily
- Room ready

**Kubernetes:**
- Pod database-0 updated
- New image pulled
- Pod restarted
- Pod ready

**Think of it as:** Update room 101. New design. Ready.

### Step 3: Update Room 102 (Update Pod 1)

**What happens:**
- Room 102 updated second
- New design applied
- Guest moves temporarily
- Room ready

**Kubernetes:**
- Pod database-1 updated
- New image pulled
- Pod restarted
- Pod ready

**Think of it as:** Update room 102. New design. Ready.

### Step 4: Update Room 103 (Update Pod 2)

**What happens:**
- Room 103 updated third
- New design applied
- Guest moves temporarily
- Room ready

**Kubernetes:**
- Pod database-2 updated
- New image pulled
- Pod restarted
- Pod ready

**Think of it as:** Update room 103. New design. Ready.

### Step 5: Update Complete (All Updated)

**What happens:**
- All rooms updated
- All new design
- Update complete

**Kubernetes:**
- All pods updated
- New image running
- Update complete

**Think of it as:** Update complete. All new. Smooth.

## Partition Updates (Canary)

**Update specific pods:**

**Set partition:**
```bash
kubectl patch statefulset database -p '{"spec":{"updateStrategy":{"rollingUpdate":{"partition":2}}}}'
```

**What this does:**
- Only pods 2, 3 updated
- Pods 0, 1 unchanged
- Canary update

**Think of it as:** Update specific rooms. Test new design. Canary.

## Real-World Example: Complete Update

**Step 1: Current state:**
```bash
kubectl get statefulset database
# Image: postgres:16-alpine
```

**Step 2: Update:**
```bash
kubectl set image statefulset/database db=postgres:17-alpine
```

**Step 3: Monitor:**
```bash
kubectl rollout status statefulset/database
```

**Step 4: Watch update:**
```bash
kubectl get pods -l app=database -w
```

**Output shows:**
- database-0 updated
- database-0 ready
- database-1 updated
- database-1 ready
- database-2 updated
- database-2 ready
- Sequential

**Step 5: Verify:**
```bash
kubectl get statefulset database -o yaml | grep image
# Image: postgres:17-alpine
```

**That's complete update. Ordered. Sequential. Smooth.**

## My Take: Update Strategy

**Here's what I do:**

**Production:**
- Use RollingUpdate
- Monitor closely
- Test updates
- Have rollback plan

**Canary:**
- Use partition
- Update subset
- Test
- Then update all

**The key:** Use RollingUpdate. Monitor. Test. Have rollback plan.

## Memory Tip: The Ordered Room Update Analogy

**StatefulSet updates = Ordered room updates**

**Update request:** Renovation needed
**Ordered update:** Update in order
**Rolling update:** One at a time
**Partition:** Canary updates

**Once you see it this way, updates make perfect sense.**

## Common Mistakes

1. **Not using RollingUpdate**: Downtime
2. **Not monitoring**: Don't know progress
3. **No rollback plan**: Stuck if fails
4. **Not testing**: Update may fail
5. **Wrong partition**: Updates wrong pods

## Key Takeaways

1. **RollingUpdate for zero downtime** - Sequential updates
2. **Partition for canary** - Update subset first
3. **Ordered updates** - Always sequential
4. **Monitor updates** - Know progress
5. **Have rollback plan** - Be prepared

## What's Next?

Now that you understand StatefulSet updates, let's learn about StatefulSet deletion. Next: [StatefulSet Deletion](/docs/kubernetes/10-statefulsets/statefulset-deletion).

---

> **Remember**: StatefulSet updates are like ordered room updates. Update in order. One at a time. Rolling updates. Monitor. Have rollback plan. Essential for stateful apps.

