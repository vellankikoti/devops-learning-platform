---
sidebar_position: 4
title: LoadBalancer Services
---

# LoadBalancer Services: Cloud Room Service

**LoadBalancer services are like cloud room service. Managed by cloud. External IP. Production-ready. That's LoadBalancer services.**

## 🎯 The Big Picture

Think of LoadBalancer services like cloud room service. Managed by cloud provider (AWS, Azure, GCP). External IP address. Production-ready. That's LoadBalancer services.

**LoadBalancer services create cloud load balancers. External IP. Managed by cloud. Production-ready. Best for cloud.**

## The Cloud Room Service Analogy

**Think of LoadBalancer services like cloud room service:**

**Service:** Cloud room service
- Managed by cloud
- External access
- Production-ready

**LoadBalancer:** Cloud load balancer
- Managed by cloud provider
- External IP
- High availability

**Cloud integration:** Cloud services
- AWS ELB
- Azure Load Balancer
- GCP Load Balancer

**Once you see it this way, LoadBalancer services make perfect sense.**

## What is LoadBalancer?

**LoadBalancer service:**
- Creates cloud load balancer
- External IP address
- Managed by cloud
- Production-ready

**Think of it as:** Cloud room service. Managed. External. Production.

## Why LoadBalancer?

**Use cases:**
- Cloud clusters
- Production workloads
- External access needed
- High availability

**Why:**
- Managed by cloud
- External IP
- High availability
- Production-ready

**Think of it as:** Cloud room service. Managed. Production. Best option.

## Creating LoadBalancer Service

**Basic LoadBalancer service:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: cloud-service
  labels:
    app: hotel-app
spec:
  type: LoadBalancer
  selector:
    app: hotel-app
  ports:
  - port: 80
    targetPort: 8080
    protocol: TCP
```

**What this does:**
- Creates cloud load balancer
- Gets external IP
- Routes to pods

**Think of it as:** Cloud room service. External IP. Routes to rooms.

**Create service:**
```bash
kubectl apply -f service.yaml
```

## Cloud-Specific Behavior

**AWS (EKS):**
- Creates ELB (Elastic Load Balancer)
- External IP assigned
- Managed by AWS

**Azure (AKS):**
- Creates Azure Load Balancer
- External IP assigned
- Managed by Azure

**GCP (GKE):**
- Creates GCP Load Balancer
- External IP assigned
- Managed by GCP

**Think of it as:** Different cloud providers. Different load balancers. All managed.

## External IP Assignment

**How it works:**

**Service created:**
```bash
kubectl get service cloud-service
```

**Output:**
```
NAME           TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)        AGE
cloud-service  LoadBalancer   10.96.xxx.xxx   <pending>       80:30080/TCP   10s
```

**External IP pending:**
- Cloud provider creating
- Takes 1-2 minutes
- Then assigned

**After assignment:**
```
NAME           TYPE           CLUSTER-IP      EXTERNAL-IP        PORT(S)        AGE
cloud-service  LoadBalancer   10.96.xxx.xxx   52.xxx.xxx.xxx     80:30080/TCP   2m
```

**Think of it as:** Cloud service. Creating. Then ready. External IP assigned.

## Complete LoadBalancer Service

**Production-ready service:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: production-service
  namespace: production
  labels:
    app: hotel-app
    env: production
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-type: "nlb"
    service.beta.kubernetes.io/aws-load-balancer-ssl-cert: "arn:aws:acm:..."
spec:
  type: LoadBalancer
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
  loadBalancerIP: "52.xxx.xxx.xxx"  # Optional, specific IP
```

**What this provides:**
- Cloud load balancer
- External IP
- SSL/TLS support
- Production-ready

**That's a complete LoadBalancer service. Production-ready.**

## Real-World Example: Complete Setup

**Step 1: Create deployment:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hotel-app
spec:
  replicas: 5
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

**Step 2: Create LoadBalancer service:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: hotel-lb
spec:
  type: LoadBalancer
  selector:
    app: hotel-app
  ports:
  - port: 80
    targetPort: 8080
```

**Step 3: Wait for external IP:**
```bash
kubectl get service hotel-lb -w
```

**Step 4: Access via external IP:**
```bash
curl http://<external-ip>
```

**That's complete setup. LoadBalancer service. External access.**

## LoadBalancer vs NodePort

**Comparison:**

**NodePort:**
- Node IP + port
- Manual management
- On-premise

**LoadBalancer:**
- External IP
- Managed by cloud
- Cloud clusters

**Think of it as:** Floor-level vs cloud service. Different management. Different use.

## My Take: LoadBalancer Strategy

**Here's what I do:**

**Use LoadBalancer for:**
- Cloud clusters
- Production workloads
- External access needed
- High availability

**Use NodePort for:**
- On-premise
- Testing
- Development

**The key:** Use LoadBalancer in cloud. NodePort for on-premise. Right tool.

## Memory Tip: The Cloud Room Service Analogy

**LoadBalancer services = Cloud room service**

**Service:** Cloud service
**LoadBalancer:** Cloud load balancer
**External IP:** Public address
**Managed:** By cloud

**Once you see it this way, LoadBalancer makes perfect sense.**

## Common Mistakes

1. **Using LoadBalancer on-premise**: Won't work, use NodePort
2. **Not waiting for IP**: External IP takes time
3. **Cost concerns**: LoadBalancers cost money
4. **Not using Ingress**: Better for HTTP/HTTPS
5. **Security**: Exposes service externally

## Key Takeaways

1. **LoadBalancer creates cloud load balancer** - Managed by cloud
2. **External IP assigned** - Public access
3. **Cloud-specific** - AWS, Azure, GCP
4. **Production-ready** - High availability
5. **Use Ingress for HTTP/HTTPS** - Better option

## What's Next?

Now that you understand LoadBalancer services, let's learn about service discovery. Next: [Service Discovery](/docs/kubernetes/06-services/service-discovery).

---

> **Remember**: LoadBalancer services are like cloud room service. Managed by cloud. External IP. Production-ready. Use in cloud. Use Ingress for HTTP/HTTPS.

