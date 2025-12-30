---
sidebar_position: 1
title: Troubleshooting Methodology
---

# Kubernetes Troubleshooting: The Systematic Approach

**Troubleshooting Kubernetes isn't about knowing every command. It's about having a systematic approach. A methodology. A way to find problems when you don't know where to look.**

## 🎯 The Big Picture

Think of troubleshooting Kubernetes like being a detective. You don't start by guessing. You start by gathering evidence. You follow leads. You eliminate possibilities. You find the truth.

**That's troubleshooting. It's systematic. It's methodical. It works.**

## The Troubleshooting Mindset

**Rule #1: Don't panic.**

Problems happen. They always do. Panicking doesn't help. A systematic approach does.

**Rule #2: Start from the top.**

Start with the big picture. Then narrow down. Don't jump to conclusions.

**Rule #3: Use the tools.**

Kubernetes gives you tools. Use them. `kubectl describe`. `kubectl logs`. `kubectl get events`. They're your friends.

## The Troubleshooting Methodology

Here's the systematic approach I use:

### 1. Understand the Problem

**What's the symptom?**
- Pods not starting?
- Services not accessible?
- Applications crashing?
- Resources exhausted?

**What changed?**
- Recent deployment?
- Configuration change?
- Cluster update?
- New workload?

**When did it start?**
- After a specific action?
- Gradual degradation?
- Sudden failure?

### 2. Check the Obvious First

**Is the cluster healthy?**
```bash
kubectl get nodes
kubectl get pods --all-namespaces
```

**Are resources available?**
```bash
kubectl top nodes
kubectl top pods
```

**Are there recent events?**
```bash
kubectl get events --sort-by='.lastTimestamp'
```

### 3. Narrow Down the Scope

**Which namespace?**
```bash
kubectl get pods -n <namespace>
```

**Which pod?**
```bash
kubectl get pods
kubectl describe pod <pod-name>
```

**What's the status?**
- Pending?
- CrashLoopBackOff?
- ImagePullBackOff?
- Running but not working?

### 4. Gather Information

**Pod details:**
```bash
kubectl describe pod <pod-name>
```

**Pod logs:**
```bash
kubectl logs <pod-name>
kubectl logs <pod-name> --previous  # Previous container instance
```

**Container logs:**
```bash
kubectl logs <pod-name> -c <container-name>
```

**Events:**
```bash
kubectl get events --field-selector involvedObject.name=<pod-name>
```

### 5. Analyze the Information

**Look for:**
- Error messages
- Resource constraints
- Image pull issues
- Configuration problems
- Network issues
- Storage problems

**Common patterns:**
- "ImagePullBackOff" → Image/registry issue
- "CrashLoopBackOff" → Application crashing
- "Pending" → Resource/scheduling issue
- "Error" → Check events and logs

### 6. Form a Hypothesis

**Based on the evidence, what's the likely cause?**

- Image doesn't exist?
- Application is crashing?
- Resources insufficient?
- Configuration wrong?
- Network problem?

### 7. Test the Hypothesis

**Try a fix:**
- Correct the image name
- Fix the application code
- Increase resources
- Fix the configuration
- Check network policies

### 8. Verify the Fix

**Did it work?**
```bash
kubectl get pods
kubectl logs <pod-name>
```

**Is the application working?**
- Test the endpoint
- Check the logs
- Verify functionality

## The Essential Commands

These are the commands you'll use most:

### Information Gathering

```bash
# Get all resources
kubectl get all

# Describe a resource
kubectl describe pod <pod-name>
kubectl describe node <node-name>
kubectl describe service <service-name>

# Get logs
kubectl logs <pod-name>
kubectl logs <pod-name> -f  # Follow logs
kubectl logs <pod-name> --previous  # Previous instance

# Get events
kubectl get events
kubectl get events --sort-by='.lastTimestamp'
kubectl get events --field-selector involvedObject.name=<pod-name>
```

### Resource Inspection

```bash
# Get YAML
kubectl get pod <pod-name> -o yaml
kubectl get deployment <deployment-name> -o yaml

# Get JSON
kubectl get pod <pod-name> -o json

# Get wide output
kubectl get pods -o wide
```

### Debugging

```bash
# Execute command in pod
kubectl exec -it <pod-name> -- /bin/sh
kubectl exec -it <pod-name> -c <container> -- /bin/sh

# Port forward
kubectl port-forward <pod-name> <local-port>:<pod-port>

# Get resource usage
kubectl top nodes
kubectl top pods
```

## Common Problem Patterns

### Pattern 1: Pod Won't Start

**Symptoms:**
- Pod status: Pending
- No containers running

**Debugging:**
```bash
kubectl describe pod <pod-name>
# Look for:
# - Events (scheduling issues)
# - Resource constraints
# - Node affinity/taints
```

### Pattern 2: Pod Crashes Immediately

**Symptoms:**
- Pod status: CrashLoopBackOff
- Containers restarting

**Debugging:**
```bash
kubectl logs <pod-name>
kubectl logs <pod-name> --previous
kubectl describe pod <pod-name>
# Look for:
# - Application errors
# - Configuration issues
# - Resource limits
```

### Pattern 3: Image Won't Pull

**Symptoms:**
- Pod status: ImagePullBackOff
- Image pull errors

**Debugging:**
```bash
kubectl describe pod <pod-name>
# Look for:
# - Image name correct?
# - Registry accessible?
# - Authentication required?
```

### Pattern 4: Service Not Accessible

**Symptoms:**
- Service exists but not reachable
- Connection refused

**Debugging:**
```bash
kubectl get svc
kubectl describe svc <service-name>
kubectl get endpoints <service-name>
# Look for:
# - Selectors match pods?
# - Ports correct?
# - Endpoints exist?
```

## Real-World Example: The Production Incident

I once had a production incident. Here's how I troubleshooted it:

**1. Symptom:** Application was down. Users couldn't access it.

**2. Check cluster:**
```bash
kubectl get nodes
# All nodes healthy
```

**3. Check pods:**
```bash
kubectl get pods
# Pods were CrashLoopBackOff
```

**4. Check logs:**
```bash
kubectl logs <pod-name>
# Application error: "Database connection failed"
```

**5. Check configuration:**
```bash
kubectl describe pod <pod-name>
# Found: Database host was wrong
```

**6. Fix:**
- Updated ConfigMap with correct database host
- Restarted deployment

**7. Verify:**
```bash
kubectl get pods
# Pods running
# Application accessible
```

**Total time:** 15 minutes. **Systematic approach works.**

## My Take: The Troubleshooting Mindset

I used to panic when things broke. I'd try random fixes. I'd guess. I'd hope.

Then I learned a systematic approach. **Now I'm methodical. I gather evidence. I follow leads. I find problems.**

**That's the difference. It's not about knowing everything. It's about having a process.**

## Memory Tip: The Detective Analogy

Troubleshooting is like being a detective:

1. **Understand the crime** (symptom)
2. **Gather evidence** (logs, events, describe)
3. **Follow leads** (check resources, configurations)
4. **Form hypothesis** (likely cause)
5. **Test theory** (try fix)
6. **Verify solution** (confirm it works)

Once you see it this way, troubleshooting becomes systematic.

## Common Mistakes

1. **Jumping to conclusions**: Don't guess. Gather evidence first.
2. **Not checking logs**: Logs tell you what's wrong.
3. **Ignoring events**: Events show what happened.
4. **Not describing resources**: `kubectl describe` is your best friend.
5. **Panicking**: Stay calm. Be systematic.

## Key Takeaways

1. **Have a methodology** - Systematic approach works
2. **Start from the top** - Big picture first, then narrow down
3. **Use the tools** - `kubectl describe`, `logs`, `events`
4. **Gather evidence** - Don't guess, investigate
5. **Test hypotheses** - Try fixes, verify results

## What's Next?

Now that you understand the methodology, let's apply it to real problems. Next: [Pod Troubleshooting: CrashLoopBackOff](/docs/kubernetes/27-troubleshooting/pod-troubleshooting-crashloopbackoff).

---

> **Remember**: Troubleshooting isn't about knowing everything. It's about having a systematic approach. Follow the process. It works.

