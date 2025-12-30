---
sidebar_position: 5
title: Ingress Troubleshooting
---

# Ingress Troubleshooting: When Entrance Has Problems

**Ingress fails. Entrance has problems. That's reality. But we can fix them. That's troubleshooting.**

## 🎯 The Big Picture

Think of Ingress troubleshooting like fixing hotel entrance problems. Entrance not working (Ingress not routing). Security broken (TLS issues). Wrong routing (rules wrong). That's Ingress troubleshooting.

**Ingress troubleshooting is systematic. Check controller. Check Ingress. Check services. Find the problem. Fix it.**

## The Entrance Problem Analogy

**Think of Ingress problems like entrance problems:**

**Not routing:** Entrance not working
**TLS issues:** Security broken
**Wrong routing:** Routes to wrong floor
**Controller down:** Security system down
**Service issues:** Floor service broken

**Once you see it this way, troubleshooting makes perfect sense.**

## Systematic Troubleshooting Approach

**Step-by-step process:**

**Step 1: Check Ingress Controller**
```bash
kubectl get pods -n ingress-nginx
kubectl describe pod -n ingress-nginx <controller-pod>
```

**Step 2: Check Ingress**
```bash
kubectl get ingress
kubectl describe ingress <ingress-name>
```

**Step 3: Check Services**
```bash
kubectl get services
kubectl describe service <service-name>
```

**Step 4: Check Endpoints**
```bash
kubectl get endpoints <service-name>
```

**Step 5: Check Pods**
```bash
kubectl get pods -l app=<app-label>
```

**Think of it as:** Systematic inspection. Check everything. Find problem.

## Common Ingress Problems

### Problem 1: Ingress Not Routing

**Symptoms:**
- Ingress created
- No routing
- 404 or connection refused

**Troubleshooting:**
```bash
# Check Ingress
kubectl describe ingress <ingress-name>

# Check controller
kubectl get pods -n ingress-nginx

# Check service
kubectl get service <service-name>

# Check endpoints
kubectl get endpoints <service-name>
```

**Common causes:**
- Controller not running
- Service not found
- No endpoints
- Wrong selector

**Solution:**
- Start controller
- Create service
- Fix selector
- Check endpoints

**Think of it as:** Entrance not working. Check security system. Check services.

### Problem 2: TLS Issues

**Symptoms:**
- Certificate errors
- HTTPS not working
- Certificate expired

**Troubleshooting:**
```bash
# Check certificate
kubectl get certificate
kubectl describe certificate <cert-name>

# Check secret
kubectl get secret <tls-secret>
kubectl describe secret <tls-secret>

# Check cert-manager
kubectl get pods -n cert-manager
```

**Common causes:**
- Certificate not created
- Wrong secret name
- Certificate expired
- DNS not configured

**Solution:**
- Create certificate
- Fix secret name
- Renew certificate
- Configure DNS

**Think of it as:** Security broken. Check certificate. Fix issues.

### Problem 3: Wrong Routing

**Symptoms:**
- Routes to wrong service
- Path not matching
- Host not matching

**Troubleshooting:**
```bash
# Check Ingress rules
kubectl get ingress <ingress-name> -o yaml

# Check path matching
# Verify pathType
# Verify path order

# Test routing
curl -H "Host: <host>" http://<ingress-ip><path>
```

**Common causes:**
- Wrong path
- Wrong pathType
- Path order wrong
- Host mismatch

**Solution:**
- Fix path
- Fix pathType
- Reorder paths
- Fix host

**Think of it as:** Routes to wrong floor. Check routing rules. Fix.

## Real-World Example: Complete Troubleshooting

**Scenario: Ingress not routing**

**Step 1: Check Ingress:**
```bash
kubectl get ingress
```

**Output:**
```
NAME           CLASS   HOSTS                ADDRESS   PORTS   AGE
hotel-ingress  nginx   hotel.example.com             80      5m
```

**Problem:** No ADDRESS. Controller not assigned.

**Step 2: Check controller:**
```bash
kubectl get pods -n ingress-nginx
```

**Output:**
```
NAME                                        READY   STATUS    RESTARTS   AGE
ingress-nginx-controller-xxxxx              0/1     Pending   0          5m
```

**Problem:** Controller pending.

**Step 3: Describe controller:**
```bash
kubectl describe pod -n ingress-nginx ingress-nginx-controller-xxxxx
```

**Found:** Insufficient resources.

**Step 4: Fix:**
```bash
# Add more nodes or increase resources
# Or use different node
```

**Step 5: Verify:**
```bash
kubectl get ingress
# ADDRESS now assigned
```

**That's troubleshooting. Systematic. Effective.**

## Troubleshooting Tools

### kubectl describe ingress

**Best friend for troubleshooting:**
```bash
kubectl describe ingress <ingress-name>
```

**Shows:**
- Ingress status
- Rules
- Events
- Backend services

**Think of it as:** Complete entrance inspection. Everything visible.

### Check Controller Logs

**View controller logs:**
```bash
kubectl logs -n ingress-nginx <controller-pod>
```

**Shows:**
- Request processing
- Routing decisions
- Errors
- Warnings

**Think of it as:** Security system log. See what happened.

### Test Routing

**Test from outside:**
```bash
curl -H "Host: hotel.example.com" http://<ingress-ip>/
```

**Test from inside:**
```bash
kubectl run test --image=curlimages/curl --rm -it --restart=Never -- curl http://hotel-service
```

**Think of it as:** Test entrance. From outside. From inside.

## My Take: Troubleshooting Strategy

**Here's what I do:**

**When Ingress fails:**
1. Check controller status
2. Check Ingress status
3. Check services
4. Check endpoints
5. Check pods
6. Test routing
7. Fix and verify

**The key:** Systematic approach. Check everything. Find root cause. Fix it.

## Memory Tip: The Entrance Problem Analogy

**Ingress troubleshooting = Fixing entrance problems**

**Not routing:** Entrance not working
**TLS issues:** Security broken
**Wrong routing:** Routes to wrong floor
**Controller down:** Security system down

**Once you see it this way, troubleshooting makes perfect sense.**

## Common Mistakes

1. **Not checking controller**: Missing controller issues
2. **Not checking services**: Missing service issues
3. **Not checking endpoints**: Missing pod issues
4. **Not testing routing**: Don't know if works
5. **Not systematic**: Random troubleshooting

## Key Takeaways

1. **Troubleshooting is systematic** - Follow a process
2. **Check controller first** - Required component
3. **Check Ingress status** - Know the state
4. **Check services and endpoints** - Backend health
5. **Test routing** - Verify it works
6. **Most problems are fixable** - Don't give up

## What's Next?

Congratulations! You've completed the Ingress Controllers & Load Balancing module. Now let's learn about ConfigMaps and Secrets. Next: [Understanding ConfigMaps](/docs/kubernetes/08-configmaps-secrets/understanding-configmaps).

---

> **Remember**: Ingress troubleshooting is like fixing entrance problems. Systematic. Check controller. Check Ingress. Check services. Find problem. Fix it. Most problems are fixable.

