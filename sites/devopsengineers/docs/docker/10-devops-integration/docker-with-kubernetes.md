---
sidebar_position: 3
title: Docker with Kubernetes
---

# Docker with Kubernetes: The Perfect Combination

**Docker creates containers. Kubernetes orchestrates them. Together, they're powerful. That's Docker with Kubernetes.**

## 🎯 The Big Picture

Think of Docker with Kubernetes like a restaurant. Docker is the kitchen (creates dishes/containers). Kubernetes is the restaurant manager (orchestrates service). Kitchen makes food. Manager coordinates service. That's Docker with Kubernetes.

**Docker builds containers. Kubernetes runs them. Together, they're production-ready.**

## How Docker and Kubernetes Work Together

**The relationship:**

**Docker:**
- Builds container images
- Runs containers locally
- Manages images
- Container runtime

**Kubernetes:**
- Orchestrates containers
- Manages at scale
- Handles deployment
- Container orchestration

**Think of it as:** Docker makes containers. Kubernetes uses them. Perfect combination.

## Building Images for Kubernetes

**Build images normally:**

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
USER nodejs
CMD ["node", "server.js"]
```

**Build:**
```bash
docker build -t my-app:1.0 .
```

**Push to registry:**
```bash
docker tag my-app:1.0 registry.example.com/my-app:1.0
docker push registry.example.com/my-app:1.0
```

**Use in Kubernetes:**
```yaml
apiVersion: apps/v1
kind: Deployment
spec:
  template:
    spec:
      containers:
      - name: app
        image: registry.example.com/my-app:1.0
```

**That's it. Docker builds. Kubernetes uses.**

## The Restaurant Analogy

**Think of Docker with Kubernetes like a restaurant:**

**Docker:** Kitchen
- Creates dishes (containers)
- Manages ingredients (images)
- Prepares food (builds)

**Kubernetes:** Restaurant manager
- Coordinates service (orchestration)
- Manages staff (containers)
- Handles customers (traffic)

**Once you see it this way, Docker with Kubernetes makes perfect sense.**

## Complete Example: Docker + Kubernetes

**Step 1: Build with Docker**
```bash
# Create Dockerfile
cat > Dockerfile <<EOF
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
USER nodejs
CMD ["node", "server.js"]
EOF

# Build image
docker build -t my-app:1.0 .
```

**Step 2: Push to Registry**
```bash
# Tag for registry
docker tag my-app:1.0 registry.example.com/my-app:1.0

# Push
docker push registry.example.com/my-app:1.0
```

**Step 3: Deploy to Kubernetes**
```yaml
# deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: app
        image: registry.example.com/my-app:1.0
        ports:
        - containerPort: 3000
        resources:
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 30
          periodSeconds: 10
```

**Step 4: Apply**
```bash
kubectl apply -f deployment.yaml
```

**Complete workflow. Docker builds. Kubernetes runs.**

## Best Practices

### 1. Use Specific Image Tags

**Don't use latest:**
```yaml
image: my-app:latest  # BAD
```

**Do use versions:**
```yaml
image: my-app:1.0.0  # GOOD
```

**Why:** Predictable. Reproducible.

### 2. Use Private Registry

**Use private registry:**
```yaml
image: registry.example.com/my-app:1.0.0
```

**Why:** Security. Control. Compliance.

### 3. Set Resource Limits

**Set limits:**
```yaml
resources:
  limits:
    memory: "512Mi"
    cpu: "500m"
```

**Why:** Prevent resource exhaustion.

### 4. Use Health Checks

**Add probes:**
```yaml
livenessProbe:
  httpGet:
    path: /health
    port: 3000
```

**Why:** Know when healthy. Automatic recovery.

### 5. Use Secrets

**Use Kubernetes secrets:**
```yaml
env:
- name: DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: db-secret
      key: password
```

**Why:** Secure. Not in images.

## My Take: Docker + Kubernetes Strategy

**Here's what I do:**

**Development:**
- Docker Compose
- Local development
- Simple setup

**Staging:**
- Docker builds
- Kubernetes deploys
- Test orchestration

**Production:**
- Docker builds
- Kubernetes deploys
- Full orchestration
- Monitoring
- Scaling

**The key:** Docker for building. Kubernetes for running. Perfect combination.

## Memory Tip: The Restaurant Analogy

**Docker + Kubernetes = Restaurant**

**Docker:** Kitchen (creates)
**Kubernetes:** Manager (orchestrates)

**Once you see it this way, the combination makes perfect sense.**

## Common Mistakes

1. **Using latest tags**: Unpredictable
2. **No resource limits**: Resource exhaustion
3. **No health checks**: Don't know when unhealthy
4. **Secrets in images**: Security risk
5. **Not using private registry**: Security risk

## Key Takeaways

1. **Docker builds containers** - Creates images
2. **Kubernetes orchestrates containers** - Runs at scale
3. **Use specific tags** - Predictable deployments
4. **Use private registry** - Security and control
5. **Set resource limits** - Prevent exhaustion
6. **Use health checks** - Automatic recovery

## What's Next?

Now that you understand Docker with Kubernetes, let's learn about Infrastructure as Code. Next: [Infrastructure as Code](/docs/docker/10-devops-integration/infrastructure-as-code).

---

> **Remember**: Docker with Kubernetes is like a restaurant. Docker is the kitchen (creates). Kubernetes is the manager (orchestrates). Perfect combination. Production-ready.

