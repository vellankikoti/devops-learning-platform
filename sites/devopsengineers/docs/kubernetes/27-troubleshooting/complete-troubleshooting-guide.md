---
sidebar_position: 8
title: Complete Troubleshooting Guide
---

# Complete Troubleshooting Guide: Your Kubernetes Debugging Playbook

**This is your complete troubleshooting playbook. Everything you need to debug Kubernetes issues. Systematic. Methodical. Effective.**

## 🎯 The Big Picture

Think of this guide like a hotel operations manual. When something goes wrong, you have a process. You follow steps. You find the problem. **That's troubleshooting.**

**This guide combines all troubleshooting knowledge into one comprehensive resource. Use it. Reference it. Master it.**

## The Troubleshooting Framework

**Follow this framework for any issue:**

1. **Understand the problem** - What's the symptom?
2. **Check the obvious** - Cluster health, resources, events
3. **Narrow down** - Which namespace? Which pod? Which service?
4. **Gather information** - Describe, logs, events
5. **Analyze** - What's the pattern? What's the cause?
6. **Form hypothesis** - What's likely wrong?
7. **Test fix** - Try the solution
8. **Verify** - Did it work?

## Quick Reference: Common Issues

### Pod Issues

**CrashLoopBackOff:**
```bash
kubectl describe pod <pod-name>
kubectl logs <pod-name> --previous
# Check: Application errors, config issues, resource limits
```

**ImagePullBackOff:**
```bash
kubectl describe pod <pod-name>
# Check: Image name, registry, authentication
```

**Pending:**
```bash
kubectl describe pod <pod-name>
# Check: Resources, affinity, taints, storage
```

### Service Issues

**Service not accessible:**
```bash
kubectl get endpoints <service-name>
kubectl get svc <service-name> -o yaml | grep selector
kubectl get pods --show-labels
# Check: Selectors, endpoints, ports
```

### Storage Issues

**PVC pending:**
```bash
kubectl describe pvc <pvc-name>
kubectl get storageclass
# Check: Storage class, provisioner, events
```

### Deployment Issues

**Rollout stuck:**
```bash
kubectl rollout status deployment/<deployment-name>
kubectl get pods -l app=<app-label>
kubectl describe pod <pod-name>
# Check: Readiness probe, resource constraints, image pull
```

## Essential Commands Cheat Sheet

### Information Gathering

```bash
# Get all resources
kubectl get all
kubectl get all -n <namespace>

# Describe resources
kubectl describe pod <pod-name>
kubectl describe node <node-name>
kubectl describe svc <service-name>
kubectl describe deployment <deployment-name>

# Get logs
kubectl logs <pod-name>
kubectl logs <pod-name> -f  # Follow
kubectl logs <pod-name> --previous  # Previous instance
kubectl logs <pod-name> -c <container>  # Multi-container

# Get events
kubectl get events
kubectl get events --sort-by='.lastTimestamp'
kubectl get events --field-selector involvedObject.name=<pod-name>

# Get YAML/JSON
kubectl get pod <pod-name> -o yaml
kubectl get pod <pod-name> -o json
kubectl get pod <pod-name> -o wide
```

### Debugging

```bash
# Execute into pod
kubectl exec -it <pod-name> -- /bin/sh
kubectl exec <pod-name> -- <command>

# Port forward
kubectl port-forward pod/<pod-name> <local-port>:<pod-port>
kubectl port-forward svc/<service-name> <local-port>:<service-port>

# Resource usage
kubectl top nodes
kubectl top pods
kubectl top pods --containers
```

### Service Debugging

```bash
# Check service
kubectl get svc
kubectl describe svc <service-name>

# Check endpoints
kubectl get endpoints <service-name>
kubectl describe endpoints <service-name>

# Check selectors
kubectl get svc <service-name> -o yaml | grep selector
kubectl get pods --show-labels
```

### Storage Debugging

```bash
# Check PVC
kubectl get pvc
kubectl describe pvc <pvc-name>

# Check PV
kubectl get pv
kubectl describe pv <pv-name>

# Check storage class
kubectl get storageclass
kubectl describe storageclass <sc-name>
```

## Troubleshooting Scenarios

### Scenario 1: Application Not Accessible

**Symptoms:**
- Application not responding
- Connection refused
- Timeout errors

**Debugging steps:**
1. Check pods: `kubectl get pods`
2. Check service: `kubectl get svc`
3. Check endpoints: `kubectl get endpoints`
4. Check pod logs: `kubectl logs <pod-name>`
5. Check service selectors: Match pod labels?
6. Check ports: Service port vs pod port?
7. Test from pod: `kubectl exec -it <pod> -- curl localhost:8080`

### Scenario 2: Pods Not Starting

**Symptoms:**
- Pods in Pending or CrashLoopBackOff
- Deployment not scaling
- Replicas not matching

**Debugging steps:**
1. Check pod status: `kubectl get pods`
2. Describe pod: `kubectl describe pod <pod-name>`
3. Check events: Look for errors
4. Check logs: `kubectl logs <pod-name> --previous`
5. Check resources: `kubectl top nodes`
6. Check image: Is it correct?
7. Check storage: PVC bound?

### Scenario 3: Deployment Not Updating

**Symptoms:**
- Deployment not rolling out
- Old pods still running
- New pods not starting

**Debugging steps:**
1. Check rollout: `kubectl rollout status deployment/<name>`
2. Check replica sets: `kubectl get replicasets`
3. Check new pods: `kubectl get pods -l app=<label>`
4. Check pod status: Why aren't new pods ready?
5. Check readiness probe: Is it configured?
6. Check image: Is new image correct?
7. Check resources: Enough resources?

## Real-World Troubleshooting Flow

**Here's how I troubleshoot production issues:**

**Step 1: Understand the problem**
- What's the symptom?
- When did it start?
- What changed?

**Step 2: Check cluster health**
```bash
kubectl get nodes
kubectl get pods --all-namespaces
kubectl top nodes
```

**Step 3: Narrow down**
- Which namespace?
- Which pod?
- Which service?

**Step 4: Gather information**
```bash
kubectl describe pod <pod-name>
kubectl logs <pod-name> --previous
kubectl get events --sort-by='.lastTimestamp'
```

**Step 5: Analyze**
- What's the error?
- What's the pattern?
- What's likely wrong?

**Step 6: Fix**
- Apply the fix
- Monitor the result

**Step 7: Verify**
```bash
kubectl get pods
kubectl logs <pod-name>
# Test the application
```

## My Take: The Troubleshooting Mindset

I used to panic when things broke. I'd try random fixes. I'd guess.

Then I learned the systematic approach:
1. **Stay calm** - Panic doesn't help
2. **Follow the process** - Systematic approach works
3. **Gather evidence** - Don't guess, investigate
4. **Fix root cause** - Not just symptoms
5. **Verify** - Make sure it works

**Now I fix issues in minutes, not hours. The process works.**

## Memory Tip: The Detective Analogy

Troubleshooting is like being a detective:
1. **Understand the crime** (symptom)
2. **Gather evidence** (logs, events, describe)
3. **Follow leads** (check resources, configurations)
4. **Form hypothesis** (likely cause)
5. **Test theory** (try fix)
6. **Verify solution** (confirm it works)

**Once you see it this way, troubleshooting becomes systematic.**

## Key Takeaways

1. **Have a framework** - Systematic approach works
2. **Gather information** - Don't guess, investigate
3. **Use the tools** - kubectl describe, logs, events
4. **Fix root cause** - Not just symptoms
5. **Verify** - Make sure it works

## What's Next?

Now that you have the complete troubleshooting guide, you're ready to debug any Kubernetes issue. Practice. Use this guide. Master troubleshooting.

---

> **Remember**: Troubleshooting isn't about knowing everything. It's about having a systematic approach. Follow the process. It works.

