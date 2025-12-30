---
sidebar_position: 3
title: Creating Pods
---

# Creating Pods: Booking Hotel Rooms

**Creating pods is like booking hotel rooms. Define what you need. Submit reservation. Room created. That's creating pods.**

## 🎯 The Big Picture

Think of creating pods like booking hotel rooms. You specify requirements (YAML). Submit reservation (kubectl apply). Room created (pod running). That's creating pods.

**Creating pods is defining pod specifications. YAML or JSON. kubectl commands. Then submitting to Kubernetes.**

## The Hotel Room Booking Analogy

**Think of creating pods like booking hotel rooms:**

**YAML definition:** Room reservation form
- Specify requirements
- Define what you need
- Complete form

**kubectl apply:** Submit reservation
- Send to hotel (Kubernetes)
- Process reservation
- Create room

**Pod created:** Room ready
- Room created
- Guest can check in
- Room operational

**Once you see it this way, creating pods makes perfect sense.**

## Creating Pods with YAML

**Basic pod YAML:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-room
  labels:
    app: my-app
    env: production
spec:
  containers:
  - name: guest
    image: nginx:alpine
    ports:
    - containerPort: 80
```

**What this does:**
- Creates pod named "my-room"
- Runs nginx:alpine container
- Exposes port 80

**Think of it as:** Room reservation. Room name. Guest type. Room features.

**Create pod:**
```bash
kubectl apply -f pod.yaml
```

## Creating Pods with kubectl

**Imperative creation:**
```bash
kubectl run my-room --image=nginx:alpine --port=80
```

**What this does:**
- Creates pod immediately
- No YAML file needed
- Quick creation

**Think of it as:** Quick reservation. No form. Just call.

**Why use:**
- Quick testing
- Learning
- Simple pods

**Why not use:**
- Not version controlled
- Hard to reproduce
- Not production-ready

## Complete Pod Definition

**Production-ready pod:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: production-room
  namespace: production
  labels:
    app: hotel-app
    env: production
    version: "1.0.0"
  annotations:
    description: "Production web application pod"
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
    volumeMounts:
    - name: config
      mountPath: /app/config
      readOnly: true
    livenessProbe:
      httpGet:
        path: /health
        port: 8080
      initialDelaySeconds: 30
      periodSeconds: 10
    readinessProbe:
      httpGet:
        path: /ready
        port: 8080
      initialDelaySeconds: 5
      periodSeconds: 5
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

**That's a complete pod. Production-ready. Comprehensive.**

## Key Fields Explained

### Metadata

**Name:**
- Pod name
- Unique in namespace
- Identifier

**Labels:**
- Key-value pairs
- For selection
- Organization

**Annotations:**
- Additional metadata
- Not for selection
- Documentation

**Think of it as:** Room information. Name. Tags. Notes.

### Spec

**Containers:**
- Container definitions
- Image, ports, env
- Resources, probes

**Volumes:**
- Storage mounts
- ConfigMaps, Secrets
- Persistent storage

**Restart Policy:**
- Always, OnFailure, Never
- Controls restart behavior

**Think of it as:** Room specifications. Guest details. Room features. Policies.

## Real-World Example: Complete Creation

**Step 1: Create YAML file:**
```yaml
# web-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-app
  labels:
    app: web
spec:
  containers:
  - name: app
    image: nginx:alpine
    ports:
    - containerPort: 80
```

**Step 2: Create pod:**
```bash
kubectl apply -f web-pod.yaml
```

**Output:**
```
pod/web-app created
```

**Step 3: Verify:**
```bash
kubectl get pods
```

**Output:**
```
NAME     READY   STATUS    RESTARTS   AGE
web-app  1/1     Running   0          30s
```

**Step 4: Check details:**
```bash
kubectl describe pod web-app
```

**That's complete creation. Pod running.**

## Creating Pods from Templates

**Using kubectl create:**
```bash
kubectl create deployment my-app --image=nginx:alpine --dry-run=client -o yaml > deployment.yaml
```

**Why:**
- Generate YAML
- Learn structure
- Start point

**Think of it as:** Template reservation. Fill in details.

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

### Use Labels

**Why:**
- Organization
- Selection
- Management

**Always:**
- Add meaningful labels
- Use consistent naming
- Document labels

### Use Namespaces

**Why:**
- Organization
- Isolation
- Management

**Organize:**
- By environment
- By team
- By application

## My Take: Pod Creation Strategy

**Here's what I do:**

**Development:**
- Use kubectl run
- Quick testing
- Simple pods

**Production:**
- Use YAML files
- Version controlled
- Complete definitions

**The key:** Use YAML for production. kubectl run for testing. Right tool for job.

## Memory Tip: The Hotel Room Booking Analogy

**Creating pods = Booking hotel rooms**

**YAML:** Reservation form
**kubectl apply:** Submit reservation
**Pod created:** Room ready

**Once you see it this way, creating pods makes perfect sense.**

## Common Mistakes

1. **Using imperative in production**: Not version controlled
2. **Missing labels**: Hard to manage
3. **No resource limits**: Resource exhaustion
4. **No health checks**: Don't know when unhealthy
5. **Wrong image pull policy**: Image issues

## Key Takeaways

1. **Create pods with YAML** - Version controlled, reproducible
2. **Use kubectl run for testing** - Quick, simple
3. **Use labels** - Organization, selection
4. **Use namespaces** - Organization, isolation
5. **Complete definitions** - Production-ready

## What's Next?

Now that you understand creating pods, let's learn about multi-container pods. Next: [Multi-Container Pods](/docs/kubernetes/04-pods/multi-container-pods).

---

> **Remember**: Creating pods is like booking hotel rooms. YAML is reservation form. kubectl apply submits. Pod created. Use YAML for production. Right tool for job.

