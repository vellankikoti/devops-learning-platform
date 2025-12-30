---
sidebar_position: 1
title: kubectl Commands
---

# kubectl Commands: Hotel Management Commands

**kubectl commands are like hotel management commands. Check rooms. Manage guests. Control operations. That's kubectl commands.**

## 🎯 The Big Picture

Think of kubectl commands like hotel management commands. Check room status (get pods). Manage guests (manage pods). Control operations (deploy, update). That's kubectl commands.

**kubectl is Kubernetes command-line tool. All operations. Get, create, delete, describe. Essential for Kubernetes operations.**

## The Hotel Management Commands Analogy

**Think of kubectl commands like hotel management commands:**

**kubectl get:** Check status
- Check rooms (pods)
- Check services
- Check everything

**kubectl create:** Create resources
- Create rooms (pods)
- Create services
- Create everything

**kubectl describe:** Detailed information
- Room details
- Service details
- Everything

**Once you see it this way, kubectl commands make perfect sense.**

## Essential kubectl Commands

### Get Resources

**Get pods:**
```bash
kubectl get pods
kubectl get pods -n production
kubectl get pods -l app=my-app
```

**Get services:**
```bash
kubectl get services
kubectl get svc
```

**Get deployments:**
```bash
kubectl get deployments
kubectl get deploy
```

**Get all:**
```bash
kubectl get all
kubectl get all -n production
```

**Think of it as:** Check status. Rooms. Services. Everything.

### Describe Resources

**Describe pod:**
```bash
kubectl describe pod my-pod
kubectl describe pod my-pod -n production
```

**Describe service:**
```bash
kubectl describe service my-service
```

**Describe deployment:**
```bash
kubectl describe deployment my-deployment
```

**Think of it as:** Detailed information. Everything visible.

### Create Resources

**Create from file:**
```bash
kubectl apply -f pod.yaml
kubectl apply -f deployment.yaml
```

**Create imperatively:**
```bash
kubectl create deployment my-app --image=nginx:alpine
kubectl run my-pod --image=nginx:alpine
```

**Think of it as:** Create resources. From file or command.

### Delete Resources

**Delete resource:**
```bash
kubectl delete pod my-pod
kubectl delete deployment my-deployment
kubectl delete -f pod.yaml
```

**Delete all:**
```bash
kubectl delete all --all
kubectl delete all --all -n production
```

**Think of it as:** Delete resources. Individual or all.

### Logs and Debugging

**View logs:**
```bash
kubectl logs my-pod
kubectl logs -f my-pod
kubectl logs my-pod --previous
```

**Execute commands:**
```bash
kubectl exec -it my-pod -- /bin/sh
kubectl exec my-pod -- ps aux
```

**Port forward:**
```bash
kubectl port-forward pod/my-pod 8080:80
kubectl port-forward svc/my-service 8080:80
```

**Think of it as:** Debug tools. Logs. Execute. Port forward.

## Complete Command Reference

**Resource Management:**
```bash
# Get
kubectl get <resource>
kubectl get pods,services,deployments

# Describe
kubectl describe <resource> <name>

# Create
kubectl create -f <file>
kubectl apply -f <file>

# Delete
kubectl delete <resource> <name>
kubectl delete -f <file>

# Edit
kubectl edit <resource> <name>
```

**Debugging:**
```bash
# Logs
kubectl logs <pod>
kubectl logs -f <pod>

# Exec
kubectl exec -it <pod> -- /bin/sh

# Port forward
kubectl port-forward <pod> <port>

# Events
kubectl get events
```

**That's essential commands. Complete. Useful.**

## My Take: kubectl Strategy

**Here's what I do:**

**Daily use:**
- kubectl get (check status)
- kubectl describe (detailed info)
- kubectl logs (view logs)
- kubectl exec (debug)

**Deployment:**
- kubectl apply (deploy)
- kubectl rollout (updates)
- kubectl scale (scaling)

**The key:** Learn essential commands. Use daily. Master kubectl.

## Memory Tip: The Hotel Management Commands Analogy

**kubectl commands = Hotel management commands**

**get:** Check status
**describe:** Detailed info
**create/apply:** Create resources
**delete:** Remove resources

**Once you see it this way, kubectl commands make perfect sense.**

## Common Mistakes

1. **Not using kubectl get**: Don't know status
2. **Not using describe**: Missing details
3. **Wrong namespace**: Wrong context
4. **Not using logs**: Can't debug
5. **Not learning commands**: Inefficient

## Key Takeaways

1. **kubectl is essential** - All Kubernetes operations
2. **Learn essential commands** - get, describe, logs, exec
3. **Use daily** - Practice makes perfect
4. **Master kubectl** - Essential skill
5. **Use help** - `kubectl <command> --help`

## What's Next?

Now that you understand kubectl commands, you've completed the kubectl Commands module. Next: [Understanding Advanced Networking](/docs/kubernetes/23-advanced-networking/advanced-networking).

---

> **Remember**: kubectl commands are like hotel management commands. Check status. Manage resources. Debug issues. Essential for Kubernetes. Learn. Practice. Master.

