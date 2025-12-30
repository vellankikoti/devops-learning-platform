---
sidebar_position: 2
title: Creating Deployments
---

# Creating Deployments: Setting Up Hotel Room Management

**Creating deployments is like setting up hotel room management. Define room requirements. Submit to management. Rooms managed automatically. That's creating deployments.**

## 🎯 The Big Picture

Think of creating deployments like setting up hotel room management. You define room requirements (YAML). Submit to management system (kubectl apply). Rooms managed automatically (pods created). That's creating deployments.

**Creating deployments is defining deployment specifications. YAML or JSON. kubectl commands. Then submitting to Kubernetes for automatic management.**

## The Hotel Room Management Setup Analogy

**Think of creating deployments like setting up room management:**

**YAML definition:** Management system configuration
- Define room requirements
- Specify room count
- Configure management

**kubectl apply:** Activate management system
- Submit to Kubernetes
- System activated
- Rooms managed

**Deployment active:** Management system running
- Rooms created automatically
- Count maintained
- Updates handled

**Once you see it this way, creating deployments makes perfect sense.**

## Creating Deployments with YAML

**Basic deployment YAML:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hotel-management
  labels:
    app: hotel-app
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

**What this does:**
- Creates deployment named "hotel-management"
- Maintains 3 pod replicas
- Uses hotel-app:1.0.0 image

**Think of it as:** Room management system. 3 rooms. Automatic management.

**Create deployment:**
```bash
kubectl apply -f deployment.yaml
```

## Creating Deployments with kubectl

**Imperative creation:**
```bash
kubectl create deployment hotel-management --image=hotel-app:1.0.0 --replicas=3
```

**What this does:**
- Creates deployment immediately
- No YAML file needed
- Quick creation

**Think of it as:** Quick management setup. No configuration file. Just command.

**Why use:**
- Quick testing
- Learning
- Simple deployments

**Why not use:**
- Not version controlled
- Hard to reproduce
- Not production-ready

## Complete Deployment Definition

**Production-ready deployment:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: production-hotel
  namespace: production
  labels:
    app: hotel-app
    env: production
    version: "1.0.0"
spec:
  replicas: 5
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 2
      maxUnavailable: 1
  selector:
    matchLabels:
      app: hotel-app
      env: production
  template:
    metadata:
      labels:
        app: hotel-app
        env: production
        version: "1.0.0"
    spec:
      containers:
      - name: app
        image: hotel-app:1.0.0
        imagePullPolicy: IfNotPresent
        ports:
        - name: http
          containerPort: 8080
          protocol: TCP
        env:
        - name: NODE_ENV
          value: "production"
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: url
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 10
          timeoutSeconds: 5
          failureThreshold: 3
        readinessProbe:
          httpGet:
            path: /ready
            port: 8080
          initialDelaySeconds: 5
          periodSeconds: 5
          timeoutSeconds: 3
          failureThreshold: 3
        volumeMounts:
        - name: config
          mountPath: /app/config
          readOnly: true
      volumes:
      - name: config
        configMap:
          name: app-config
      restartPolicy: Always
      nodeSelector:
        env: production
      tolerations:
      - key: "dedicated"
        operator: "Equal"
        value: "app"
        effect: "NoSchedule"
```

**That's a complete deployment. Production-ready. Comprehensive.**

## Key Fields Explained

### Metadata

**Name:**
- Deployment name
- Unique in namespace
- Identifier

**Labels:**
- Key-value pairs
- For selection
- Organization

**Think of it as:** Management system name. Tags. Organization.

### Spec

**Replicas:**
- Desired pod count
- Maintained automatically
- Scaling target

**Selector:**
- Pod selection criteria
- Must match template labels
- Identifies managed pods

**Template:**
- Pod template
- Used to create pods
- Pod specification

**Strategy:**
- Update strategy
- RollingUpdate or Recreate
- Update configuration

**Think of it as:** Management specifications. Room count. Selection. Room template. Update method.

## Real-World Example: Complete Creation

**Step 1: Create YAML file:**
```yaml
# web-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
  labels:
    app: web
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: app
        image: nginx:alpine
        ports:
        - containerPort: 80
```

**Step 2: Create deployment:**
```bash
kubectl apply -f web-deployment.yaml
```

**Output:**
```
deployment.apps/web-app created
```

**Step 3: Verify:**
```bash
kubectl get deployments
```

**Output:**
```
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
web-app   3/3     3            3           30s
```

**Step 4: Check pods:**
```bash
kubectl get pods -l app=web
```

**Output:**
```
NAME                      READY   STATUS    RESTARTS   AGE
web-app-7d4b8c9f6-xxxxx   1/1     Running   0          30s
web-app-7d4b8c9f6-yyyyy   1/1     Running   0          30s
web-app-7d4b8c9f6-zzzzz   1/1     Running   0          30s
```

**That's complete creation. Deployment running. Pods created.**

## Creating from Templates

**Using kubectl create:**
```bash
kubectl create deployment my-app --image=nginx:alpine --dry-run=client -o yaml > deployment.yaml
```

**Why:**
- Generate YAML
- Learn structure
- Start point

**Think of it as:** Template configuration. Fill in details.

## Best Practices

### Use YAML Files

**Why:**
- Version controlled
- Reproducible
- Production-ready

**Don't:**
- Use imperative commands in production
- Create without YAML
- Skip version control

### Use Labels Consistently

**Why:**
- Organization
- Selection
- Management

**Always:**
- Add meaningful labels
- Use consistent naming
- Match selector and template

### Set Appropriate Replicas

**Why:**
- High availability
- Load distribution
- Fault tolerance

**Consider:**
- Traffic volume
- Availability needs
- Resource constraints

## My Take: Deployment Creation Strategy

**Here's what I do:**

**Development:**
- Use kubectl create
- Quick testing
- Simple deployments

**Production:**
- Use YAML files
- Version controlled
- Complete definitions

**The key:** Use YAML for production. kubectl create for testing. Right tool for job.

## Memory Tip: The Hotel Room Management Setup Analogy

**Creating deployments = Setting up room management**

**YAML:** Management configuration
**kubectl apply:** Activate system
**Deployment active:** Management running

**Once you see it this way, creating deployments makes perfect sense.**

## Common Mistakes

1. **Using imperative in production**: Not version controlled
2. **Selector mismatch**: Deployment can't find pods
3. **No resource limits**: Resource exhaustion
4. **No health checks**: Don't know when unhealthy
5. **Wrong replica count**: Over or under provisioned

## Key Takeaways

1. **Create deployments with YAML** - Version controlled, reproducible
2. **Use kubectl create for testing** - Quick, simple
3. **Selector must match template labels** - Critical requirement
4. **Set appropriate replicas** - High availability, load distribution
5. **Complete definitions** - Production-ready

## What's Next?

Now that you understand creating deployments, let's learn about ReplicaSets. Next: [ReplicaSets](/docs/kubernetes/05-deployments/replicasets).

---

> **Remember**: Creating deployments is like setting up room management. YAML is configuration. kubectl apply activates. Deployment manages pods. Use YAML for production. Right tool for job.

