---
sidebar_position: 3
title: Ingress Rules
---

# Ingress Rules: Routing Instructions

**Ingress rules are like routing instructions. Path-based routing. Host-based routing. Route to correct services. That's Ingress rules.**

## 🎯 The Big Picture

Think of Ingress rules like routing instructions for hotel entrance. Guest arrives (request). Check destination (host/path). Route to correct floor (service). That's Ingress rules.

**Ingress rules define routing. Path-based. Host-based. Route to services. Essential for Ingress.**

## The Routing Instructions Analogy

**Think of Ingress rules like routing instructions:**

**Rules:** Routing instructions
- Where to route
- Based on what
- To which service

**Path-based:** Route by path
- /api → API service
- /web → Web service
- Path determines route

**Host-based:** Route by host
- api.example.com → API service
- web.example.com → Web service
- Host determines route

**Once you see it this way, Ingress rules make perfect sense.**

## Path-Based Routing

**Route by path:**

**Example:**
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: path-routing
spec:
  ingressClassName: nginx
  rules:
  - http:
      paths:
      - path: /api
        pathType: Prefix
        backend:
          service:
            name: api-service
            port:
              number: 80
      - path: /web
        pathType: Prefix
        backend:
          service:
            name: web-service
            port:
              number: 80
```

**What this does:**
- /api → api-service
- /web → web-service
- Path-based routing

**Think of it as:** Route by path. Different paths. Different services.

## Host-Based Routing

**Route by host:**

**Example:**
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: host-routing
spec:
  ingressClassName: nginx
  rules:
  - host: api.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: api-service
            port:
              number: 80
  - host: web.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: web-service
            port:
              number: 80
```

**What this does:**
- api.example.com → api-service
- web.example.com → web-service
- Host-based routing

**Think of it as:** Route by host. Different hosts. Different services.

## Path Types

**Path matching types:**

**Exact:**
- Exact match
- /api/data → matches /api/data only
- Precise

**Prefix:**
- Prefix match
- /api → matches /api, /api/data, /api/users
- Flexible

**ImplementationSpecific:**
- Controller-specific
- Depends on controller
- Advanced

**Example:**
```yaml
paths:
- path: /api
  pathType: Prefix  # Matches /api, /api/data, etc.
- path: /api/data
  pathType: Exact   # Matches /api/data only
```

**Think of it as:** Matching rules. Exact or prefix. Different behavior.

## Complete Ingress with Multiple Rules

**Production-ready Ingress:**
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: production-ingress
  namespace: production
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
spec:
  ingressClassName: nginx
  tls:
  - hosts:
    - hotel.example.com
    - api.hotel.example.com
    secretName: hotel-tls
  rules:
  - host: hotel.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: hotel-service
            port:
              number: 80
      - path: /api
        pathType: Prefix
        backend:
          service:
            name: api-service
            port:
              number: 80
  - host: api.hotel.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: api-service
            port:
              number: 80
```

**What this provides:**
- Multiple hosts
- Path-based routing
- SSL/TLS support
- Production-ready

**That's a complete Ingress. Production-ready.**

## Real-World Example: Complete Routing

**Step 1: Create services:**
```yaml
# API service
apiVersion: v1
kind: Service
metadata:
  name: api-service
spec:
  selector:
    app: api
  ports:
  - port: 80

# Web service
apiVersion: v1
kind: Service
metadata:
  name: web-service
spec:
  selector:
    app: web
  ports:
  - port: 80
```

**Step 2: Create Ingress:**
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: routing-ingress
spec:
  ingressClassName: nginx
  rules:
  - host: hotel.example.com
    http:
      paths:
      - path: /api
        pathType: Prefix
        backend:
          service:
            name: api-service
            port:
              number: 80
      - path: /
        pathType: Prefix
        backend:
          service:
            name: web-service
            port:
              number: 80
```

**Step 3: Test routing:**
```bash
# API route
curl http://hotel.example.com/api/data
# Routes to api-service

# Web route
curl http://hotel.example.com/
# Routes to web-service
```

**That's complete routing. Working.**

## My Take: Routing Strategy

**Here's what I do:**

**Path-based:**
- Same host
- Different paths
- Different services

**Host-based:**
- Different hosts
- Different services
- Clear separation

**The key:** Use path-based for same domain. Host-based for different domains. Right approach.

## Memory Tip: The Routing Instructions Analogy

**Ingress rules = Routing instructions**

**Path-based:** Route by path
**Host-based:** Route by host
**Path types:** Matching rules

**Once you see it this way, rules make perfect sense.**

## Common Mistakes

1. **Wrong path type**: Not matching correctly
2. **Path order matters**: More specific first
3. **Host not configured**: DNS issues
4. **Service mismatch**: Wrong service name
5. **Not testing**: Don't know if works

## Key Takeaways

1. **Path-based routing** - Route by path
2. **Host-based routing** - Route by host
3. **Path types matter** - Exact vs Prefix
4. **Order matters** - More specific first
5. **Test routing** - Verify it works

## What's Next?

Now that you understand Ingress rules, let's learn about TLS termination. Next: [TLS Termination](/docs/kubernetes/07-ingress/tls-termination).

---

> **Remember**: Ingress rules are like routing instructions. Path-based or host-based. Path types matter. Order matters. Test routing. Essential for Ingress.

