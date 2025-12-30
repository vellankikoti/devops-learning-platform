---
sidebar_position: 3
title: Local Setup with kind
---

# Local Setup with kind: Kubernetes in Docker

**kind runs Kubernetes in Docker. Like a hotel built inside containers. Fast. Multi-node. Perfect for testing.**

## 🎯 The Big Picture

Think of kind like a hotel built inside containers. Each container is a node. Fast startup. Multi-node support. Perfect for testing. That's kind.

**kind (Kubernetes in Docker) runs Kubernetes clusters using Docker containers as nodes. Fast. Multi-node. CI/CD friendly.**

## Why kind?

**Perfect for:**
- Local testing
- CI/CD pipelines
- Multi-node testing
- Fast iteration

**Why:**
- Fast startup
- Docker-based
- Multi-node support
- Easy cleanup

**Think of it as:** Medium local hotel. Fast setup. Multi-floor. Good for testing.

## Installation

### macOS

**Using Homebrew:**
```bash
brew install kind
```

**Verify installation:**
```bash
kind version
```

### Linux

**Download binary:**
```bash
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```

### Windows

**Using Chocolatey:**
```bash
choco install kind
```

**Or download from:**
https://kind.sigs.k8s.io/docs/user/quick-start/

## Creating a Cluster

**Create single-node cluster:**
```bash
kind create cluster
```

**What happens:**
- Creates Docker container
- Runs Kubernetes inside
- Configures kubectl
- Cluster ready

**Output:**
```
Creating cluster "kind" ...
 ✓ Ensuring node image (kindest/node:v1.28.0) 🖼
 ✓ Preparing nodes 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing CNI 🔌
 ✓ Installing StorageClass 💾
Set kubectl context to "kind-kind"
You can now use your cluster with:

kubectl cluster-info
kubectl get nodes
```

**That's it. Cluster running.**

## Multi-Node Cluster

**Create multi-node cluster:**
```yaml
# kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
```

**Create cluster:**
```bash
kind create cluster --config kind-config.yaml
```

**What you get:**
- 1 control plane node
- 2 worker nodes
- Multi-node cluster

**Think of it as:** Multi-floor hotel. Control plane floor. Worker floors.

## Verifying Setup

**Check cluster:**
```bash
kind get clusters
```

**Output:**
```
kind
```

**Check nodes:**
```bash
kubectl get nodes
```

**Output:**
```
NAME                 STATUS   ROLES           AGE   VERSION
kind-control-plane   Ready    control-plane   1m    v1.28.0
kind-worker          Ready    <none>          1m    v1.28.0
kind-worker2         Ready    <none>          1m    v1.28.0
```

**Check cluster info:**
```bash
kubectl cluster-info
```

**That's verification. Everything working.**

## The Hotel in Containers Analogy

**Think of kind like hotel in containers:**

**Docker containers:** Hotel floors
- Each container is a node
- Fast to create
- Easy to destroy

**Multi-node:** Multiple floors
- Control plane floor
- Worker floors
- All in containers

**Fast startup:** Quick hotel setup
- Containers start fast
- No VM overhead
- Quick iteration

**Once you see it this way, kind makes perfect sense.**

## Common Commands

**Create cluster:**
```bash
kind create cluster
```

**Create with name:**
```bash
kind create cluster --name my-cluster
```

**Create with config:**
```bash
kind create cluster --config kind-config.yaml
```

**Delete cluster:**
```bash
kind delete cluster
```

**Delete specific cluster:**
```bash
kind delete cluster --name my-cluster
```

**List clusters:**
```bash
kind get clusters
```

**Load image:**
```bash
kind load docker-image my-image:1.0
```

## Loading Images

**Load Docker images:**
```bash
# Build image
docker build -t my-app:1.0 .

# Load into kind
kind load docker-image my-app:1.0
```

**Why:** kind nodes are containers. Need to load images.

**Think of it as:** Moving furniture to hotel. Load into containers.

## Real-World Example: Complete Setup

**Step 1: Install kind:**
```bash
brew install kind
```

**Step 2: Create cluster:**
```bash
kind create cluster
```

**Step 3: Verify:**
```bash
kubectl get nodes
kubectl cluster-info
```

**Step 4: Build and load image:**
```bash
docker build -t my-app:1.0 .
kind load docker-image my-app:1.0
```

**Step 5: Deploy:**
```bash
kubectl run my-app --image=my-app:1.0
kubectl get pods
```

**That's complete setup. Working cluster.**

## CI/CD Integration

**kind in CI/CD:**
```yaml
# GitHub Actions example
- name: Create kind cluster
  run: |
    kind create cluster
    kubectl cluster-info

- name: Run tests
  run: |
    kubectl run test --image=nginx
    kubectl get pods

- name: Cleanup
  run: kind delete cluster
```

**Why:** Fast. Easy. Perfect for CI/CD.

## Troubleshooting

**Common issues:**

**Issue: Docker not running**
```bash
# Check Docker
docker ps

# Start Docker if needed
```

**Issue: Port conflicts**
```bash
# Use different ports
kind create cluster --config kind-config.yaml
# Configure ports in config
```

**Issue: Out of resources**
```bash
# Increase Docker resources
# Docker Desktop: Settings > Resources
```

## My Take: kind Strategy

**Here's what I do:**

**Local testing:**
- Use kind
- Multi-node
- Fast iteration

**CI/CD:**
- Use kind
- Fast startup
- Easy cleanup

**The key:** Use kind for testing. Fast. Multi-node. Perfect.

## Memory Tip: The Hotel in Containers Analogy

**kind = Hotel in containers**

**Containers:** Hotel floors
**Multi-node:** Multiple floors
**Fast startup:** Quick setup

**Once you see it this way, kind makes perfect sense.**

## Common Mistakes

1. **Not loading images**: Images not available in cluster
2. **Docker not running**: Can't create cluster
3. **Port conflicts**: Can't bind ports
4. **Not cleaning up**: Clusters accumulate
5. **Wrong Docker context**: Using wrong cluster

## Key Takeaways

1. **kind runs Kubernetes in Docker** - Containers as nodes
2. **Fast startup** - No VM overhead
3. **Multi-node support** - Control plane + workers
4. **CI/CD friendly** - Perfect for pipelines
5. **Load images manually** - Need to load Docker images

## What's Next?

Now that you understand kind, let's learn about cloud setup. Next: [Cloud Setup with EKS](/docs/kubernetes/03-setup/cloud-setup-eks).

---

> **Remember**: kind is like hotel in containers. Fast setup. Multi-node. Perfect for testing. CI/CD friendly. Load images manually.

