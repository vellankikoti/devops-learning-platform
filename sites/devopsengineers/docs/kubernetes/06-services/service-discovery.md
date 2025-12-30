---
sidebar_position: 5
title: Service Discovery
---

# Service Discovery: The Hotel Phone Directory

**Service discovery is like hotel phone directory. Find room service by name. Automatic resolution. That's service discovery.**

## 🎯 The Big Picture

Think of service discovery like hotel phone directory. Need room service? Look up name. Get number. Call. Automatic. That's service discovery.

**Service discovery enables pods to find services by name. DNS-based. Automatic resolution. Essential for microservices.**

## The Hotel Phone Directory Analogy

**Think of service discovery like hotel phone directory:**

**Service name:** Room service name
- Easy to remember
- Human-readable
- Stable

**DNS resolution:** Directory lookup
- Name → IP
- Automatic
- Transparent

**Service discovery:** Find service
- Use name
- Automatic resolution
- No hardcoding

**Once you see it this way, service discovery makes perfect sense.**

## What is Service Discovery?

**Service discovery:**
- Finding services by name
- DNS-based resolution
- Automatic
- Transparent

**Think of it as:** Phone directory. Name to number. Automatic.

## Why Service Discovery?

**Problems without service discovery:**
- Hardcode IP addresses
- IPs change
- Manual updates
- Brittle

**Solutions with service discovery:**
- Use service names
- Automatic resolution
- No hardcoding
- Resilient

**Real example:** I once hardcoded IP addresses. Pods restarted. IPs changed. Connections broke. With service discovery, names. Never going back.

**Service discovery isn't optional. It's essential.**

## DNS-Based Discovery

**How it works:**

**Service name:**
```
hotel-service
```

**DNS resolution:**
```
hotel-service.default.svc.cluster.local
```

**Automatic:**
- CoreDNS resolves
- Name → ClusterIP
- Transparent

**Think of it as:** Phone directory. Name. Resolves. Automatic.

## Service Name Format

**Full DNS name:**
```
<service-name>.<namespace>.svc.cluster.local
```

**Short name (same namespace):**
```
<service-name>
```

**Short name (different namespace):**
```
<service-name>.<namespace>
```

**Example:**
```bash
# Same namespace
curl http://hotel-service

# Different namespace
curl http://hotel-service.production

# Full name
curl http://hotel-service.default.svc.cluster.local
```

**Think of it as:** Phone directory. Short name. Full name. Both work.

## Complete Discovery Journey

**Let's trace service discovery using hotel analogy:**

### Step 1: Need Service (Client Needs Service)

**What happens:**
- Guest (client pod) needs room service
- Knows service name
- Wants to call

**Kubernetes:**
```bash
# Client pod makes request
curl http://hotel-service:80
```

**Think of it as:** Guest needs service. Knows name. Wants to call.

### Step 2: DNS Lookup (Directory Lookup)

**What happens:**
- Guest looks up name in directory (DNS lookup)
- Directory finds number (resolves to ClusterIP)
- Gets number

**Kubernetes:**
- CoreDNS receives query
- Resolves service name
- Returns ClusterIP

**Think of it as:** Directory lookup. Name to number. Automatic.

### Step 3: Connection (Call Service)

**What happens:**
- Guest calls number (connects to ClusterIP)
- Call routes to room service (service routes)
- Connection established

**Kubernetes:**
- Client connects to ClusterIP
- Service routes to pod
- Connection established

**Think of it as:** Call service. Routes. Connected.

### Step 4: Service Responds (Service Answers)

**What happens:**
- Room service answers (service responds)
- Request processed
- Response returned

**Kubernetes:**
- Service receives request
- Routes to pod
- Pod processes
- Response returned

**Think of it as:** Service answers. Processes. Responds.

## CoreDNS: The Directory System

**What it is:**
- Kubernetes DNS server
- Resolves service names
- Automatic
- Cluster-wide

**Think of it as:** Hotel directory system. Resolves names. Automatic.

**How it works:**
- Watches services
- Creates DNS records
- Resolves queries
- Automatic updates

## Real-World Example: Complete Discovery

**Step 1: Create service:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: hotel-service
spec:
  selector:
    app: hotel-app
  ports:
  - port: 80
```

**Step 2: Create client pod:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: client
spec:
  containers:
  - name: client
    image: curlimages/curl
    command: ['sh', '-c', 'sleep 3600']
```

**Step 3: Test discovery:**
```bash
kubectl exec -it client -- curl http://hotel-service
```

**Step 4: Test DNS:**
```bash
kubectl exec -it client -- nslookup hotel-service
```

**Output:**
```
Name:      hotel-service
Address:   10.96.xxx.xxx
```

**That's service discovery. Automatic. Working.**

## Environment Variables

**Legacy discovery (still works):**

**Kubernetes injects:**
```
HOTEL_SERVICE_SERVICE_HOST=10.96.xxx.xxx
HOTEL_SERVICE_SERVICE_PORT=80
```

**Use:**
```bash
curl http://$HOTEL_SERVICE_SERVICE_HOST:$HOTEL_SERVICE_SERVICE_PORT
```

**Think of it as:** Old directory. Still works. DNS is better.

**Why DNS is better:**
- Automatic updates
- No environment variables
- Simpler
- Standard

## Best Practices

### Use Service Names

**Always:**
- Use service names
- Not IP addresses
- DNS resolution
- Automatic

**Don't:**
- Hardcode IPs
- Use environment variables (legacy)
- Manual updates

### Use Short Names

**When same namespace:**
```
hotel-service
```

**When different namespace:**
```
hotel-service.production
```

**Think of it as:** Short names. Simple. Works.

## My Take: Service Discovery Strategy

**Here's what I do:**

**Always:**
- Use service names
- DNS resolution
- Short names when possible
- Full names when needed

**Never:**
- Hardcode IPs
- Use environment variables
- Manual updates

**The key:** Use service names. DNS. Automatic. Simple.

## Memory Tip: The Hotel Phone Directory Analogy

**Service discovery = Hotel phone directory**

**Service name:** Room service name
**DNS resolution:** Directory lookup
**Automatic:** Transparent
**CoreDNS:** Directory system

**Once you see it this way, service discovery makes perfect sense.**

## Common Mistakes

1. **Hardcoding IPs**: Brittle, breaks when IPs change
2. **Not using DNS**: Missing automatic resolution
3. **Wrong service name**: Can't find service
4. **Namespace issues**: Wrong namespace
5. **Not understanding format**: Confusing names

## Key Takeaways

1. **Service discovery uses DNS** - Automatic resolution
2. **Use service names** - Not IP addresses
3. **Short names work** - Same namespace
4. **CoreDNS resolves** - Automatic
5. **Essential for microservices** - Service communication

## What's Next?

Congratulations! You've completed the Services & Service Discovery module. Now let's learn about ConfigMaps and Secrets. Next: [Understanding ConfigMaps](/docs/kubernetes/08-configmaps-secrets/understanding-configmaps).

---

> **Remember**: Service discovery is like hotel phone directory. Find service by name. DNS resolves. Automatic. Use service names. Never hardcode IPs. Essential for microservices.

