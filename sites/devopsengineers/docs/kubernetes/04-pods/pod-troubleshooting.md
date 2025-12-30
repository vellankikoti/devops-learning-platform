---
sidebar_position: 6
title: Pod Troubleshooting
---

# Pod Troubleshooting: When Hotel Rooms Have Problems

**Pods fail. Rooms have problems. That's reality. But we can fix them. That's troubleshooting.**

## 🎯 The Big Picture

Think of pod troubleshooting like fixing hotel room problems. Room won't open (pod won't start). Guest can't check in (container fails). Room service broken (application error). That's pod troubleshooting.

**Pod troubleshooting is systematic. Check status. Check logs. Check events. Find the problem. Fix it.**

## The Hotel Room Problem Analogy

**Think of pod problems like hotel room problems:**

**Pod won't start:** Room won't open
**Container crashes:** Guest can't check in
**Application error:** Room service broken
**Resource issues:** Room too small
**Network issues:** Phone doesn't work

**Once you see it this way, troubleshooting makes perfect sense.**

## Systematic Troubleshooting Approach

**Step-by-step process:**

**Step 1: Check Pod Status**
```bash
kubectl get pods
```

**Step 2: Describe Pod**
```bash
kubectl describe pod <pod-name>
```

**Step 3: Check Logs**
```bash
kubectl logs <pod-name>
```

**Step 4: Check Events**
```bash
kubectl get events --field-selector involvedObject.name=<pod-name>
```

**Step 5: Debug Container**
```bash
kubectl exec -it <pod-name> -- /bin/sh
```

**Think of it as:** Systematic inspection. Check everything. Find problem.

## Common Pod Problems

### Problem 1: CrashLoopBackOff

**What it is:**
- Pod starts
- Container crashes
- Restarts
- Crashes again
- Loop continues

**Think of it as:** Guest checks in. Immediately leaves. Checks in again. Leaves again. Loop.

**Troubleshooting:**
```bash
# Check pod status
kubectl get pods

# Check logs
kubectl logs <pod-name>

# Check previous container logs
kubectl logs <pod-name> --previous

# Describe pod
kubectl describe pod <pod-name>
```

**Common causes:**
- Application error
- Missing dependencies
- Configuration error
- Resource limits

**Solution:**
- Fix application code
- Add missing dependencies
- Fix configuration
- Adjust resource limits

### Problem 2: ImagePullBackOff

**What it is:**
- Can't pull image
- Pod can't start
- Image not found or access denied

**Think of it as:** Guest reservation invalid. Can't find guest. Can't check in.

**Troubleshooting:**
```bash
# Check pod status
kubectl describe pod <pod-name>

# Check image name
kubectl get pod <pod-name> -o yaml | grep image

# Try pulling manually
docker pull <image-name>
```

**Common causes:**
- Image doesn't exist
- Wrong image name
- Private registry authentication
- Network issues

**Solution:**
- Verify image name
- Check image exists
- Configure image pull secrets
- Fix network

### Problem 3: Pending

**What it is:**
- Pod created
- Not scheduled
- Waiting for resources

**Think of it as:** Room reserved. But not assigned. Waiting for floor.

**Troubleshooting:**
```bash
# Check pod status
kubectl describe pod <pod-name>

# Check node resources
kubectl describe nodes

# Check for taints
kubectl describe nodes | grep Taint
```

**Common causes:**
- Insufficient resources
- Node taints
- No suitable nodes
- Resource requests too high

**Solution:**
- Add more nodes
- Remove taints
- Reduce resource requests
- Check node capacity

### Problem 4: ErrImagePull

**What it is:**
- Error pulling image
- Authentication failed
- Network error

**Think of it as:** Can't get guest information. Access denied. Network problem.

**Troubleshooting:**
```bash
# Check pod events
kubectl describe pod <pod-name>

# Check image pull secrets
kubectl get secrets

# Verify registry access
docker login <registry>
```

**Common causes:**
- Authentication failed
- Network issues
- Registry unavailable
- Wrong credentials

**Solution:**
- Create image pull secret
- Fix network
- Verify registry
- Update credentials

## Real-World Example: Troubleshooting CrashLoopBackOff

**Scenario: Pod in CrashLoopBackOff**

**Step 1: Check status**
```bash
kubectl get pods
```

**Output:**
```
NAME    READY   STATUS             RESTARTS   AGE
my-pod  0/1     CrashLoopBackOff  5          2m
```

**Step 2: Check logs**
```bash
kubectl logs my-pod
```

**Output:**
```
Error: Cannot connect to database
```

**Step 3: Check previous logs**
```bash
kubectl logs my-pod --previous
```

**Step 4: Describe pod**
```bash
kubectl describe pod my-pod
```

**Output shows:**
- Events: Container failed
- Last state: Terminated
- Reason: Error

**Step 5: Check configuration**
```bash
kubectl get pod my-pod -o yaml | grep -A 10 env
```

**Found:** Missing DATABASE_URL environment variable

**Step 6: Fix**
```yaml
# Add environment variable
env:
- name: DATABASE_URL
  value: "postgres://db:5432/mydb"
```

**Step 7: Verify**
```bash
kubectl get pods
# Pod now Running
```

**That's troubleshooting. Systematic. Effective.**

## Troubleshooting Tools

### kubectl describe

**Best friend for troubleshooting:**
```bash
kubectl describe pod <pod-name>
```

**Shows:**
- Pod status
- Container status
- Events
- Conditions
- Resource usage

**Think of it as:** Complete room inspection. Everything visible.

### kubectl logs

**View container logs:**
```bash
# Current logs
kubectl logs <pod-name>

# Previous container logs
kubectl logs <pod-name> --previous

# Follow logs
kubectl logs -f <pod-name>

# Specific container
kubectl logs <pod-name> -c <container-name>
```

**Think of it as:** Room service log. See what happened.

### kubectl exec

**Debug inside container:**
```bash
# Interactive shell
kubectl exec -it <pod-name> -- /bin/sh

# Run command
kubectl exec <pod-name> -- ps aux

# Check environment
kubectl exec <pod-name> -- env
```

**Think of it as:** Enter room. See what's inside.

### kubectl get events

**View cluster events:**
```bash
# All events
kubectl get events

# Pod-specific events
kubectl get events --field-selector involvedObject.name=<pod-name>

# Recent events
kubectl get events --sort-by=.metadata.creationTimestamp
```

**Think of it as:** Hotel event log. See what happened.

## My Take: Troubleshooting Strategy

**Here's what I do:**

**When pod fails:**
1. Check status (`kubectl get pods`)
2. Describe pod (`kubectl describe pod`)
3. Check logs (`kubectl logs`)
4. Check events (`kubectl get events`)
5. Debug container (`kubectl exec`)
6. Fix and verify

**The key:** Systematic approach. Check everything. Find root cause. Fix it.

## Memory Tip: The Hotel Room Problem Analogy

**Pod troubleshooting = Fixing hotel room problems**

**CrashLoopBackOff:** Guest can't stay
**ImagePullBackOff:** Can't find guest
**Pending:** Room not assigned
**ErrImagePull:** Can't get guest info

**Once you see it this way, troubleshooting makes perfect sense.**

## Common Mistakes

1. **Not checking logs**: Missing obvious errors
2. **Not describing pod**: Missing events
3. **Not checking previous logs**: Missing crash reason
4. **Giving up too soon**: Problems are fixable
5. **Not systematic**: Random troubleshooting

## Key Takeaways

1. **Troubleshooting is systematic** - Follow a process
2. **Check status first** - Know the state
3. **Describe pod** - See events and conditions
4. **Check logs** - See what happened
5. **Debug inside container** - See what's wrong
6. **Most problems are fixable** - Don't give up

## What's Next?

Now that you understand pod troubleshooting, you're ready for more advanced troubleshooting scenarios. Next: [Troubleshooting Methodology](/docs/kubernetes/27-troubleshooting/troubleshooting-methodology).

---

> **Remember**: Pod troubleshooting is like fixing hotel room problems. Systematic. Check status. Check logs. Check events. Find problem. Fix it. Most problems are fixable.

