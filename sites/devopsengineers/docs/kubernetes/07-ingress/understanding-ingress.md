---
sidebar_position: 1
title: Understanding Ingress
---

# Understanding Ingress: The Hotel Main Entrance

**Ingress is like hotel main entrance. Routes external traffic. HTTP/HTTPS routing. SSL termination. That's Ingress.**

## 🎯 The Big Picture

Think of Ingress like hotel main entrance. External guests arrive (external traffic). Entrance routes to correct floor (service). Handles security (SSL/TLS). That's Ingress.

**Ingress provides HTTP/HTTPS routing. Path-based. Host-based. SSL termination. External access. Better than LoadBalancer for HTTP/HTTPS.**

## The Hotel Main Entrance Analogy

**Think of Ingress like hotel main entrance:**

**Ingress:** Main entrance
- External access point
- Routes to floors (services)
- Handles security

**Ingress Controller:** Entrance security
- Processes requests
- Routes traffic
- Handles SSL/TLS

**Rules:** Routing rules
- Path-based routing
- Host-based routing
- Route to services

**Once you see it this way, Ingress makes perfect sense.**

## What is Ingress?

**Ingress definition:**
- HTTP/HTTPS routing
- External access
- Path and host-based
- SSL/TLS termination

**Think of it as:** Main entrance. Routes traffic. Handles security.

## Why Ingress?

**Problems with LoadBalancer:**
- One LoadBalancer per service
- Expensive
- No path-based routing
- No SSL termination

**Solutions with Ingress:**
- One Ingress for many services
- Cost-effective
- Path-based routing
- SSL/TLS termination

**Real example:** I once used LoadBalancer for each service. Expensive. Many IPs. With Ingress, one entrance. Routes to all. Never going back.

**Ingress isn't optional for HTTP/HTTPS. It's essential.**

## Ingress vs LoadBalancer

**Comparison:**

**LoadBalancer:**
- One per service
- TCP/UDP
- Expensive
- Simple

**Ingress:**
- One for many services
- HTTP/HTTPS
- Cost-effective
- Advanced routing

**Think of it as:** Multiple entrances vs one entrance. Different use. Different cost.

## Ingress Controller

**What it is:**
- Processes Ingress rules
- Routes traffic
- Handles SSL/TLS
- Required component

**Common controllers:**
- Nginx Ingress Controller
- Traefik
- HAProxy
- Istio Gateway

**Think of it as:** Entrance security. Processes rules. Routes traffic.

**Must install separately:**
```bash
# Nginx Ingress Controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
```

## Basic Ingress

**Simple Ingress:**
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: hotel-entrance
spec:
  ingressClassName: nginx
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
```

**What this does:**
- Routes hotel.example.com to hotel-service
- Path-based routing
- HTTP routing

**Think of it as:** Main entrance. Routes to service. Simple.

## Complete Request Journey: Ingress Routing

**Let's trace a complete request through Ingress using hotel analogy:**

### Step 1: Guest Arrives (External Request)

**What happens:**
- Guest arrives at hotel (external request)
- Goes to main entrance (Ingress)
- Requests room service

**Kubernetes:**
```bash
curl https://hotel.example.com/api/data
```

**Think of it as:** Guest arrives. Main entrance. Requests service.

### Step 2: Entrance Security Checks (Ingress Controller)

**What happens:**
- Entrance security (Ingress Controller) receives request
- Checks routing rules (Ingress rules)
- Determines destination

**Kubernetes:**
- Ingress Controller receives request
- Matches host and path
- Finds target service

**Think of it as:** Entrance security. Checks rules. Finds destination.

### Step 3: SSL/TLS Termination (Security Check)

**What happens:**
- Entrance handles security (SSL/TLS termination)
- Decrypts request
- Validates certificate

**Kubernetes:**
- Ingress Controller terminates SSL
- Decrypts HTTPS
- Validates certificate

**Think of it as:** Security check. Decrypts. Validates.

### Step 4: Route to Service (Route to Floor)

**What happens:**
- Entrance routes to correct floor (service)
- Based on path or host
- Routes to service

**Kubernetes:**
- Ingress routes to service
- Based on rules
- Service receives request

**Think of it as:** Route to floor. Based on rules. Service receives.

### Step 5: Service Routes (Service Routes to Pod)

**What happens:**
- Floor service (service) routes to room (pod)
- Load balances
- Routes to pod

**Kubernetes:**
- Service routes to pod
- Load balances
- Pod receives request

**Think of it as:** Service routes. Load balances. Pod receives.

### Step 6: Response Returns (Response Routes Back)

**What happens:**
- Response routes back
- Through service
- Through Ingress
- To guest

**Kubernetes:**
- Response routes back
- Through service
- Through Ingress
- To client

**Think of it as:** Response returns. Through entrance. To guest.

## Real-World Example: Complete Ingress Setup

**Step 1: Install Ingress Controller:**
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
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
```

**Step 3: Create Ingress:**
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: hotel-ingress
spec:
  ingressClassName: nginx
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
```

**Step 4: Verify:**
```bash
kubectl get ingress
```

**Output:**
```
NAME           CLASS   HOSTS                ADDRESS         PORTS   AGE
hotel-ingress  nginx   hotel.example.com   52.xxx.xxx.xxx  80      1m
```

**Step 5: Test:**
```bash
curl http://hotel.example.com
```

**That's complete Ingress setup. Working.**

## My Take: Ingress Strategy

**Here's what I do:**

**Use Ingress for:**
- HTTP/HTTPS traffic
- Multiple services
- Path-based routing
- SSL/TLS termination

**Use LoadBalancer for:**
- TCP/UDP traffic
- Single service
- Simple external access

**The key:** Use Ingress for HTTP/HTTPS. LoadBalancer for TCP/UDP. Right tool.

## Memory Tip: The Hotel Main Entrance Analogy

**Ingress = Hotel main entrance**

**Ingress:** Main entrance
**Ingress Controller:** Entrance security
**Rules:** Routing rules
**Request Journey:** Guest arrival flow

**Once you see it this way, Ingress makes perfect sense.**

## Common Mistakes

1. **Not installing controller**: Ingress won't work
2. **Wrong ingressClassName**: Controller mismatch
3. **Not understanding rules**: Wrong routing
4. **SSL/TLS issues**: Certificate problems
5. **Using LoadBalancer for HTTP**: Should use Ingress

## Key Takeaways

1. **Ingress provides HTTP/HTTPS routing** - Path and host-based
2. **Requires Ingress Controller** - Must install separately
3. **One Ingress for many services** - Cost-effective
4. **SSL/TLS termination** - Handles certificates
5. **Better than LoadBalancer for HTTP/HTTPS** - Advanced routing

## What's Next?

Now that you understand Ingress, let's learn about Ingress Controllers. Next: [Ingress Controllers](/docs/kubernetes/07-ingress/ingress-controllers).

---

> **Remember**: Ingress is like hotel main entrance. Routes external traffic. HTTP/HTTPS routing. SSL termination. Requires controller. Better for HTTP/HTTPS.

