---
sidebar_position: 6
title: Deployment Troubleshooting
---

# Deployment Troubleshooting: When Room Management Has Problems

**Deployments fail. Room management has problems. That's reality. But we can fix them. That's troubleshooting.**

## 🎯 The Big Picture

Think of deployment troubleshooting like fixing hotel room management problems. Rooms not created (pods not created). Update failed (renovation failed). Rooms crashing (pods crashing). That's deployment troubleshooting.

**Deployment troubleshooting is systematic. Check deployment. Check ReplicaSet. Check pods. Find the problem. Fix it.**

## The Hotel Room Management Problem Analogy

**Think of deployment problems like room management problems:**

**Pods not created:** Rooms not created
**Update stuck:** Renovation stuck
**Pods crashing:** Rooms have problems
**ReplicaSet issues:** Floor manager problems
**Resource issues:** Not enough capacity

**Once you see it this way, troubleshooting makes perfect sense.**

## Systematic Troubleshooting Approach

**Step-by-step process:**

**Step 1: Check Deployment Status**
```bash
kubectl get deployment hotel-management
```

**Step 2: Describe Deployment**
```bash
kubectl describe deployment hotel-management
```

**Step 3: Check ReplicaSet**
```bash
kubectl get replicaset -l app=hotel-app
kubectl describe replicaset <replicaset-name>
```

**Step 4: Check Pods**
```bash
kubectl get pods -l app=hotel-app
kubectl describe pod <pod-name>
```

**Step 5: Check Logs**
```bash
kubectl logs <pod-name>
kubectl logs <pod-name> --previous
```

**Step 6: Check Events**
```bash
kubectl get events --sort-by=.metadata.creationTimestamp
```

**Think of it as:** Systematic inspection. Check everything. Find problem.

## Common Deployment Problems

### Problem 1: Deployment Not Creating Pods

**Symptoms:**
- Deployment created
- No pods running
- Desired > Available

**Troubleshooting:**
```bash
# Check deployment
kubectl describe deployment hotel-management

# Check ReplicaSet
kubectl get replicaset -l app=hotel-app

# Check events
kubectl get events
```

**Common causes:**
- Selector mismatch
- Resource constraints
- Node taints
- Image pull issues

**Solution:**
- Fix selector
- Add resources
- Remove taints
- Fix image

**Think of it as:** Room management created. But no rooms. Check why.

### Problem 2: Update Stuck

**Symptoms:**
- Update in progress
- Not completing
- Pods not updating

**Troubleshooting:**
```bash
# Check rollout status
kubectl rollout status deployment/hotel-management

# Check deployment
kubectl describe deployment hotel-management

# Check pods
kubectl get pods -l app=hotel-app
```

**Common causes:**
- Health checks failing
- Resource constraints
- Image pull issues
- Application errors

**Solution:**
- Fix health checks
- Add resources
- Fix image
- Fix application

**Think of it as:** Renovation stuck. Not completing. Check why.

### Problem 3: Pods Crashing

**Symptoms:**
- Pods created
- Immediately crash
- CrashLoopBackOff

**Troubleshooting:**
```bash
# Check pods
kubectl get pods -l app=hotel-app

# Check logs
kubectl logs <pod-name>
kubectl logs <pod-name> --previous

# Describe pod
kubectl describe pod <pod-name>
```

**Common causes:**
- Application errors
- Configuration errors
- Missing dependencies
- Resource limits

**Solution:**
- Fix application
- Fix configuration
- Add dependencies
- Adjust limits

**Think of it as:** Rooms created. But guests can't stay. Check why.

### Problem 4: ReplicaSet Issues

**Symptoms:**
- ReplicaSet not creating pods
- Pods not matching selector
- ReplicaSet scaling issues

**Troubleshooting:**
```bash
# Check ReplicaSet
kubectl describe replicaset <replicaset-name>

# Check selector
kubectl get replicaset <replicaset-name> -o yaml | grep selector

# Check pods
kubectl get pods --show-labels
```

**Common causes:**
- Selector mismatch
- Template issues
- Resource constraints

**Solution:**
- Fix selector
- Fix template
- Add resources

**Think of it as:** Floor manager problems. Can't manage rooms. Check why.

## Real-World Example: Complete Troubleshooting

**Scenario: Deployment update stuck**

**Step 1: Check deployment:**
```bash
kubectl get deployment hotel-management
```

**Output:**
```
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
hotel-management  3/5     2            3           10m
```

**Problem:** Update stuck. Only 2 of 5 updated.

**Step 2: Check rollout status:**
```bash
kubectl rollout status deployment/hotel-management
```

**Output:**
```
Waiting for rollout to finish: 2 of 5 new replicas have been updated...
```

**Step 3: Check new pods:**
```bash
kubectl get pods -l app=hotel-app
```

**Output:**
```
NAME                              READY   STATUS    RESTARTS   AGE
hotel-management-xxxxx (old)      1/1     Running   0          10m
hotel-management-yyyyy (old)      1/1     Running   0          10m
hotel-management-zzzzz (old)      1/1     Running   0          10m
hotel-management-aaaaa (new)      0/1     CrashLoopBackOff  3    2m
hotel-management-bbbbb (new)      0/1     CrashLoopBackOff  3    2m
```

**Problem:** New pods crashing.

**Step 4: Check logs:**
```bash
kubectl logs hotel-management-aaaaa
```

**Output:**
```
Error: Cannot connect to database
```

**Problem:** Database connection issue.

**Step 5: Check configuration:**
```bash
kubectl describe pod hotel-management-aaaaa | grep -A 10 Env
```

**Found:** Missing DATABASE_URL environment variable.

**Step 6: Fix:**
```yaml
# Update deployment
env:
- name: DATABASE_URL
  valueFrom:
    secretKeyRef:
      name: db-secret
      key: url
```

**Step 7: Apply fix:**
```bash
kubectl apply -f deployment.yaml
```

**Step 8: Verify:**
```bash
kubectl rollout status deployment/hotel-management
kubectl get pods -l app=hotel-app
# All pods running
```

**That's troubleshooting. Systematic. Effective.**

## Troubleshooting Tools

### kubectl describe deployment

**Best friend for troubleshooting:**
```bash
kubectl describe deployment hotel-management
```

**Shows:**
- Deployment status
- ReplicaSet status
- Pod status
- Events
- Conditions

**Think of it as:** Complete management inspection. Everything visible.

### kubectl rollout status

**Monitor rollout:**
```bash
kubectl rollout status deployment/hotel-management
```

**Shows:**
- Rollout progress
- Current state
- Completion status

**Think of it as:** Renovation progress. See status.

### kubectl rollout history

**View history:**
```bash
kubectl rollout history deployment/hotel-management
```

**Shows:**
- Revision history
- Change causes
- Rollback options

**Think of it as:** Renovation history. Previous designs.

## My Take: Troubleshooting Strategy

**Here's what I do:**

**When deployment fails:**
1. Check deployment status
2. Describe deployment
3. Check ReplicaSet
4. Check pods
5. Check logs
6. Check events
7. Fix and verify

**The key:** Systematic approach. Check everything. Find root cause. Fix it.

## Memory Tip: The Hotel Room Management Problem Analogy

**Deployment troubleshooting = Fixing room management problems**

**Pods not created:** Rooms not created
**Update stuck:** Renovation stuck
**Pods crashing:** Rooms have problems
**ReplicaSet issues:** Floor manager problems

**Once you see it this way, troubleshooting makes perfect sense.**

## Common Mistakes

1. **Not checking deployment**: Missing deployment-level issues
2. **Not checking ReplicaSet**: Missing ReplicaSet issues
3. **Not checking pods**: Missing pod-level issues
4. **Not checking logs**: Missing application errors
5. **Not systematic**: Random troubleshooting

## Key Takeaways

1. **Troubleshooting is systematic** - Follow a process
2. **Check deployment first** - Know the state
3. **Check ReplicaSet** - Foundation level
4. **Check pods** - Execution level
5. **Check logs** - Application level
6. **Most problems are fixable** - Don't give up

## What's Next?

Congratulations! You've completed the Deployments & ReplicaSets module. Now let's learn about services. Next: [Understanding Services](/docs/kubernetes/06-services/understanding-services).

---

> **Remember**: Deployment troubleshooting is like fixing room management problems. Systematic. Check deployment. Check ReplicaSet. Check pods. Find problem. Fix it. Most problems are fixable.

