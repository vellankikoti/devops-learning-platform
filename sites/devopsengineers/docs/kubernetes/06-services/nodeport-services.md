---
sidebar_position: 3
title: NodePort Services
---

# NodePort Services: Floor-Level Service

**NodePort services are like floor-level service. Accessible from outside hotel. Use node IP and high port. That's NodePort services.**

## 🎯 The Big Picture

Think of NodePort services like floor-level service. Can call from outside hotel (external access). Use hotel address and floor number (node IP and port). That's NodePort services.

**NodePort services expose services on node IP. High port (30000-32767). External access. Good for on-premise or testing.**

## The Floor-Level Service Analogy

**Think of NodePort services like floor-level service:**

**Service:** Floor-level service desk
- Accessible from outside
- Use hotel address (node IP)
- Floor number (high port)

**NodePort:** Floor number
- High port (30000-32767)
- On every node
- External access

**External access:** Can call from outside
- Not just hotel guests
- Anyone can call
- External access

**Once you see it this way, NodePort services make perfect sense.**

## What is NodePort?

**NodePort service:**
- Exposes service on node IP
- High port (30000-32767)
- External access
- On every node

**Think of it as:** Floor-level service. External access. High port.

## Why NodePort?

**Use cases:**
- External access needed
- On-premise clusters
- Testing
- Development

**Why:**
- Simple external access
- No cloud load balancer
- Works anywhere
- Good for testing

**Think of it as:** Floor-level service. Simple. Works anywhere.

## Creating NodePort Service

**Basic NodePort service:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: floor-service
  labels:
    app: hotel-app
spec:
  type: NodePort
  selector:
    app: hotel-app
  ports:
  - port: 80
    targetPort: 8080
    nodePort: 30080
    protocol: TCP
```

**What this does:**
- Creates NodePort service
- Exposes on port 30080
- Accessible via node IP:30080

**Think of it as:** Floor-level service. Port 30080. External access.

**Create service:**
```bash
kubectl apply -f service.yaml
```

## Port Ranges

**NodePort range:**
- 30000-32767
- Kubernetes assigned
- Or specify manually

**Auto-assigned:**
```yaml
ports:
- port: 80
  targetPort: 8080
  # nodePort auto-assigned
```

**Manual assignment:**
```yaml
ports:
- port: 80
  targetPort: 8080
  nodePort: 30080  # Specific port
```

**Think of it as:** Floor number. Auto or manual. In range.

## Accessing NodePort Service

**From outside cluster:**

**Get node IP:**
```bash
kubectl get nodes -o wide
```

**Access service:**
```bash
curl http://<node-ip>:30080
```

**From any node:**
- Service accessible on all nodes
- Same port on all nodes
- Load balanced

**Think of it as:** Call hotel. Use address. Floor number. Works.

## Complete NodePort Service

**Production-ready service:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: hotel-nodeport
  namespace: production
  labels:
    app: hotel-app
spec:
  type: NodePort
  selector:
    app: hotel-app
  ports:
  - name: http
    port: 80
    targetPort: 8080
    nodePort: 30080
    protocol: TCP
  - name: https
    port: 443
    targetPort: 8443
    nodePort: 30443
    protocol: TCP
  sessionAffinity: ClientIP
```

**What this provides:**
- External access
- Multiple ports
- Session affinity
- Production-ready

**That's a complete NodePort service. Production-ready.**

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

**Step 2: Create NodePort service:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: hotel-nodeport
spec:
  type: NodePort
  selector:
    app: hotel-app
  ports:
  - port: 80
    targetPort: 8080
    nodePort: 30080
```

**Step 3: Get node IP:**
```bash
kubectl get nodes -o wide
```

**Step 4: Access from outside:**
```bash
curl http://<node-ip>:30080
```

**That's complete setup. NodePort service. External access.**

## NodePort vs ClusterIP

**Comparison:**

**ClusterIP:**
- Internal only
- No external access
- Default

**NodePort:**
- External access
- Node IP + port
- More exposure

**Think of it as:** Internal vs floor-level. Different access. Different use.

## My Take: NodePort Strategy

**Here's what I do:**

**Use NodePort for:**
- On-premise clusters
- Testing
- Development
- When LoadBalancer not available

**Use LoadBalancer for:**
- Cloud clusters
- Production
- Better external access

**The key:** Use NodePort when needed. LoadBalancer for cloud. Right tool.

## Memory Tip: The Floor-Level Service Analogy

**NodePort services = Floor-level service**

**Service:** Floor-level desk
**NodePort:** Floor number
**External access:** Can call from outside
**Node IP:** Hotel address

**Once you see it this way, NodePort makes perfect sense.**

## Common Mistakes

1. **Using NodePort in cloud**: Should use LoadBalancer
2. **Wrong port range**: Port outside 30000-32767
3. **Not understanding access**: How to access externally
4. **Security concerns**: Exposes service externally
5. **Not using Ingress**: Better for HTTP/HTTPS

## Key Takeaways

1. **NodePort exposes on node IP** - External access
2. **High port range** - 30000-32767
3. **Accessible from outside** - External access
4. **Good for on-premise** - No cloud needed
5. **Use LoadBalancer in cloud** - Better option

## What's Next?

Now that you understand NodePort services, let's learn about LoadBalancer services. Next: [LoadBalancer Services](/docs/kubernetes/06-services/loadbalancer-services).

---

> **Remember**: NodePort services are like floor-level service. External access. Node IP + port. Good for on-premise. Use LoadBalancer in cloud.

