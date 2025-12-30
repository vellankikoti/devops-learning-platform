---
sidebar_position: 5
title: Verifying Cluster
---

# Verifying Cluster: Is Your Hotel Ready?

**You've set up your cluster. But is it ready? Let's verify. Check everything. Ensure it works.**

## 🎯 The Big Picture

Think of verifying cluster like hotel inspection. Check rooms (pods). Check services (services). Check everything works. That's verification.

**Verifying cluster ensures everything works. Nodes. Components. Connectivity. All checked. All verified.**

## The Hotel Inspection Analogy

**Think of cluster verification like hotel inspection:**

**Check rooms:** Verify pods work
**Check services:** Verify services work
**Check connectivity:** Verify communication works
**Check everything:** Complete inspection

**Once you see it this way, verification makes perfect sense.**

## Basic Verification

### Check Nodes

**List nodes:**
```bash
kubectl get nodes
```

**Expected output:**
```
NAME       STATUS   ROLES           AGE   VERSION
minikube   Ready    control-plane   5m    v1.28.0
```

**Check node details:**
```bash
kubectl describe node minikube
```

**What to verify:**
- Status: Ready
- Roles: control-plane
- Version: Kubernetes version
- Conditions: All healthy

### Check Cluster Info

**Cluster information:**
```bash
kubectl cluster-info
```

**Expected output:**
```
Kubernetes control plane is running at https://127.0.0.1:6443
CoreDNS is running at https://127.0.0.1:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
```

**What to verify:**
- Control plane running
- CoreDNS running
- Endpoints accessible

### Check System Pods

**System pods:**
```bash
kubectl get pods -n kube-system
```

**Expected output:**
```
NAME                               READY   STATUS    RESTARTS   AGE
coredns-5d78c9869d-xxxxx           1/1     Running   0          5m
etcd-minikube                      1/1     Running   0          5m
kube-apiserver-minikube            1/1     Running   0          5m
kube-controller-manager-minikube   1/1     Running   0          5m
kube-proxy-xxxxx                   1/1     Running   0          5m
kube-scheduler-minikube            1/1     Running   0          5m
```

**What to verify:**
- All pods Running
- All pods Ready (1/1)
- No restarts (unless expected)
- CoreDNS running

## Functional Verification

### Test Pod Creation

**Create test pod:**
```bash
kubectl run test-pod --image=nginx:alpine --port=80
```

**Check pod:**
```bash
kubectl get pods
```

**Expected:**
```
NAME       READY   STATUS    RESTARTS   AGE
test-pod   1/1     Running   0          30s
```

**Verify pod details:**
```bash
kubectl describe pod test-pod
```

**What to verify:**
- Pod created
- Pod running
- Container ready
- No errors

### Test Service Creation

**Create service:**
```bash
kubectl expose pod test-pod --port=80 --name=test-service
```

**Check service:**
```bash
kubectl get services
```

**Expected:**
```
NAME           TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
test-service   ClusterIP   10.96.xxx.xxx   <none>        80/TCP    10s
```

**Test service:**
```bash
kubectl run test-client --image=curlimages/curl --rm -it --restart=Never -- curl http://test-service
```

**What to verify:**
- Service created
- Service has ClusterIP
- Service accessible
- DNS resolution works

### Test Deployment

**Create deployment:**
```bash
kubectl create deployment test-deployment --image=nginx:alpine --replicas=3
```

**Check deployment:**
```bash
kubectl get deployments
kubectl get pods -l app=test-deployment
```

**Expected:**
```
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
test-deployment   3/3     3            3           30s
```

**What to verify:**
- Deployment created
- Replicas running (3/3)
- All pods ready
- Deployment healthy

## Complete Verification Checklist

**✅ Nodes:**
- [ ] Nodes in Ready state
- [ ] Control plane node present
- [ ] Node resources available

**✅ System Components:**
- [ ] API server running
- [ ] etcd running
- [ ] Scheduler running
- [ ] Controller manager running
- [ ] kube-proxy running
- [ ] CoreDNS running

**✅ Functionality:**
- [ ] Can create pods
- [ ] Can create services
- [ ] Can create deployments
- [ ] DNS resolution works
- [ ] Service discovery works

**✅ Networking:**
- [ ] Pod-to-pod communication
- [ ] Service networking
- [ ] DNS working

## Real-World Example: Complete Verification

**Step 1: Check nodes:**
```bash
kubectl get nodes
# Should show: Ready
```

**Step 2: Check system pods:**
```bash
kubectl get pods -n kube-system
# All should be: Running
```

**Step 3: Create test pod:**
```bash
kubectl run test --image=nginx:alpine
kubectl get pods
# Should show: Running
```

**Step 4: Create test service:**
```bash
kubectl expose pod test --port=80 --name=test-svc
kubectl get svc
# Should show: ClusterIP assigned
```

**Step 5: Test connectivity:**
```bash
kubectl run client --image=curlimages/curl --rm -it --restart=Never -- curl http://test-svc
# Should return: nginx HTML
```

**That's complete verification. Everything working.**

## Troubleshooting Verification

**If verification fails:**

**Check node status:**
```bash
kubectl describe node
# Look for conditions, issues
```

**Check pod events:**
```bash
kubectl describe pod <pod-name>
# Look for events, errors
```

**Check logs:**
```bash
kubectl logs <pod-name>
# Look for errors
```

**Check cluster events:**
```bash
kubectl get events --sort-by=.metadata.creationTimestamp
# Look for errors, warnings
```

## My Take: Verification Strategy

**Here's what I do:**

**After setup:**
- Check nodes
- Check system pods
- Create test pod
- Create test service
- Test connectivity

**Regular checks:**
- Monitor node health
- Monitor system pods
- Test functionality
- Verify networking

**The key:** Verify after setup. Regular checks. Know what's working.

## Memory Tip: The Hotel Inspection Analogy

**Cluster verification = Hotel inspection**

**Check rooms:** Pods
**Check services:** Services
**Check connectivity:** Networking
**Check everything:** Complete

**Once you see it this way, verification makes perfect sense.**

## Common Mistakes

1. **Not verifying after setup**: Don't know if works
2. **Only checking nodes**: Missing components
3. **Not testing functionality**: Assuming works
4. **Ignoring errors**: Missing issues
5. **Not regular checks**: Don't know health

## Key Takeaways

1. **Verify after setup** - Ensure everything works
2. **Check nodes and components** - System health
3. **Test functionality** - Pods, services, deployments
4. **Verify networking** - Communication works
5. **Regular checks** - Monitor health

## What's Next?

Now that your cluster is verified and working, let's learn about pods. Next: [Understanding Pods](/docs/kubernetes/04-pods/understanding-pods).

---

> **Remember**: Verifying cluster is like hotel inspection. Check rooms. Check services. Check connectivity. Check everything. Ensure it works. Then use it.

