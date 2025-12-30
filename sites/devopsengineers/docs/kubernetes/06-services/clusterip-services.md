---
sidebar_position: 2
title: ClusterIP Services
---

# ClusterIP Services: Internal Room Service

**ClusterIP services are like internal room service. Only hotel guests can call. Not accessible from outside. That's ClusterIP services.**

## 🎯 The Big Picture

Think of ClusterIP services like internal room service. Stable phone number (ClusterIP). Only hotel guests can call (internal only). Routes to rooms (pods). That's ClusterIP services.

**ClusterIP services provide internal-only access. Stable IP address. Load balancing. Service discovery. Default service type.**

## The Internal Room Service Analogy

**Think of ClusterIP services like internal room service:**

**Service:** Internal room service desk
- Stable phone number (ClusterIP)
- Only hotel guests can call
- Routes to rooms (pods)

**ClusterIP:** Internal phone number
- Only accessible from cluster
- Not exposed externally
- Internal communication

**Load Balancing:** Call distribution
- Distributes calls evenly
- Routes to available rooms
- Handles failures

**Once you see it this way, ClusterIP services make perfect sense.**

## What is ClusterIP?

**ClusterIP service:**
- Default service type
- Internal-only access
- Stable IP address
- Load balancing

**Think of it as:** Internal room service. Default. Internal only.

## Why ClusterIP?

**Use cases:**
- Internal service communication
- Service-to-service
- Not exposed externally
- Default choice

**Why:**
- Secure (internal only)
- Simple
- Default
- Most common

**Think of it as:** Internal room service. Secure. Simple. Default.

## Creating ClusterIP Service

**Basic ClusterIP service:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: internal-service
  labels:
    app: hotel-app
spec:
  type: ClusterIP  # Default, can omit
  selector:
    app: hotel-app
  ports:
  - port: 80
    targetPort: 8080
    protocol: TCP
```

**What this does:**
- Creates ClusterIP service
- Routes to pods with app=hotel-app
- Port 80 → targetPort 8080

**Think of it as:** Internal room service. Routes to rooms. Port mapping.

**Create service:**
```bash
kubectl apply -f service.yaml
```

## Service Selector

**How service finds pods:**

**Selector:**
- Defines pod criteria
- Must match pod labels
- Identifies target pods

**Example:**
```yaml
selector:
  app: hotel-app
  env: production
```

**Pods must have matching labels:**
```yaml
metadata:
  labels:
    app: hotel-app
    env: production
```

**Think of it as:** Room service criteria. Which rooms to route to.

**Critical:** Selector must match pod labels.

## Port Configuration

**Port mapping:**

**port:**
- Service port
- What clients use
- External interface

**targetPort:**
- Pod port
- Where traffic goes
- Container port

**Example:**
```yaml
ports:
- port: 80        # Service port
  targetPort: 8080  # Pod port
  protocol: TCP
```

**Think of it as:** Room service port. Routes to room port.

## Complete ClusterIP Service

**Production-ready service:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: hotel-service
  namespace: production
  labels:
    app: hotel-app
    env: production
spec:
  type: ClusterIP
  selector:
    app: hotel-app
    env: production
  ports:
  - name: http
    port: 80
    targetPort: 8080
    protocol: TCP
  - name: https
    port: 443
    targetPort: 8443
    protocol: TCP
  sessionAffinity: ClientIP
  sessionAffinityConfig:
    clientIP:
      timeoutSeconds: 10800
```

**What this provides:**
- Internal access only
- Multiple ports
- Session affinity
- Production-ready

**That's a complete ClusterIP service. Production-ready.**

## Real-World Example: Complete Setup

**Step 1: Create deployment:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hotel-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: hotel-app
  template:
    metadata:
      labels:
        app: hotel-app
    spec:
      containers:
      - name: app
        image: hotel-app:1.0.0
        ports:
        - containerPort: 8080
```

**Step 2: Create service:**
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
    targetPort: 8080
```

**Step 3: Verify:**
```bash
kubectl get service hotel-service
```

**Output:**
```
NAME           TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
hotel-service  ClusterIP   10.96.xxx.xxx   <none>        80/TCP    30s
```

**Step 4: Test from pod:**
```bash
kubectl run test --image=curlimages/curl --rm -it --restart=Never -- curl http://hotel-service
```

**That's complete setup. Internal service. Working.**

## My Take: ClusterIP Strategy

**Here's what I do:**

**Use ClusterIP for:**
- Internal services
- Service-to-service communication
- Default choice
- Not exposed externally

**The key:** Use ClusterIP by default. Expose externally only when needed.

## Memory Tip: The Internal Room Service Analogy

**ClusterIP services = Internal room service**

**Service:** Internal desk
**ClusterIP:** Internal number
**Load Balancing:** Call distribution
**Internal only:** Not external

**Once you see it this way, ClusterIP makes perfect sense.**

## Common Mistakes

1. **Trying to access externally**: ClusterIP is internal only
2. **Selector mismatch**: Service can't find pods
3. **Wrong port mapping**: Traffic doesn't reach pods
4. **Not understanding default**: ClusterIP is default
5. **Over-exposing**: Using NodePort/LoadBalancer when not needed

## Key Takeaways

1. **ClusterIP is default** - Internal-only access
2. **Selector must match pod labels** - Critical requirement
3. **Port mapping** - Service port → Pod port
4. **Load balancing built-in** - Distributes requests
5. **Use for internal communication** - Service-to-service

## What's Next?

Now that you understand ClusterIP services, let's learn about NodePort services. Next: [NodePort Services](/docs/kubernetes/06-services/nodeport-services).

---

> **Remember**: ClusterIP services are like internal room service. Internal only. Stable IP. Load balancing. Default choice. Use for internal communication.

