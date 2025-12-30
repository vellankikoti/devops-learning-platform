---
sidebar_position: 2
title: Local Setup with minikube
---

# Local Setup with minikube: Your First Hotel

**minikube is your first hotel. Local. Simple. Perfect for learning. Let's set it up.**

## 🎯 The Big Picture

Think of minikube like setting up a small local hotel. Simple setup. Single floor (node). Perfect for learning. That's minikube.

**minikube runs a single-node Kubernetes cluster locally. Perfect for learning. Development. Testing.**

## Why minikube?

**Perfect for:**
- Learning Kubernetes
- Local development
- Testing
- Quick experiments

**Why:**
- Easy setup
- Single command start
- Works on all platforms
- No cloud needed

**Think of it as:** Small local hotel. Easy setup. Perfect for learning.

## Installation

### macOS

**Using Homebrew:**
```bash
brew install minikube
```

**Verify installation:**
```bash
minikube version
```

### Linux

**Download binary:**
```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

### Windows

**Using Chocolatey:**
```bash
choco install minikube
```

**Or download from:**
https://minikube.sigs.k8s.io/docs/start/

## Starting minikube

**Start cluster:**
```bash
minikube start
```

**What happens:**
- Downloads Kubernetes
- Creates VM (if needed)
- Starts cluster
- Configures kubectl

**First time output:**
```
😄  minikube v1.32.0 on Darwin 14.0
✨  Automatically selected the docker driver
📦  Preparing Kubernetes v1.28.0 on Docker 24.0.7 ...
🚜  Pulling base image ...
💾  Downloading Kubernetes v1.28.0 preload ...
    > preloaded-images-k8s-v18-v1...:  385.37 MiB / 385.37 MiB  100.00% 1.20 MiB
    > gcr.io/k8s-minikube/kicbase...:  397.09 MiB / 397.09 MiB  100.00% 1.20 MiB
🔥  Creating docker container (CPUs=2, Memory=4000MB) ...
🐳  Preparing Kubernetes v1.28.0 on Docker 24.0.7 ...
    ▪ Generating certificates and keys ...
    ▪ Booting control plane ...
    ▪ Configuring RBAC rules ...
✅  Successfully started node minikube
🎉  kubectl is now configured to use "minikube" cluster
```

**That's it. Cluster running.**

## Verifying Setup

**Check cluster status:**
```bash
minikube status
```

**Output:**
```
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured
```

**Check nodes:**
```bash
kubectl get nodes
```

**Output:**
```
NAME       STATUS   ROLES           AGE   VERSION
minikube   Ready    control-plane   1m    v1.28.0
```

**Check cluster info:**
```bash
kubectl cluster-info
```

**That's verification. Everything working.**

## The Hotel Setup Analogy

**Think of minikube setup like opening a small hotel:**

**Installation:** Get hotel license
**Starting:** Open hotel
**Verification:** Check everything works
**Ready:** Hotel operational

**Once you see it this way, minikube setup makes perfect sense.**

## Common Commands

**Start cluster:**
```bash
minikube start
```

**Stop cluster:**
```bash
minikube stop
```

**Delete cluster:**
```bash
minikube delete
```

**Get status:**
```bash
minikube status
```

**Open dashboard:**
```bash
minikube dashboard
```

**Get service URL:**
```bash
minikube service my-service
```

**SSH into node:**
```bash
minikube ssh
```

## Driver Options

**Different drivers:**

**Docker (default):**
```bash
minikube start --driver=docker
```

**VirtualBox:**
```bash
minikube start --driver=virtualbox
```

**Hyper-V (Windows):**
```bash
minikube start --driver=hyperv
```

**Think of it as:** Different hotel locations. Choose what works.

## Resource Configuration

**Configure resources:**
```bash
minikube start \
  --memory=4096 \
  --cpus=2 \
  --disk-size=20g
```

**Why:** More resources. Better performance.

## Real-World Example: Complete Setup

**Step 1: Install:**
```bash
brew install minikube
```

**Step 2: Start:**
```bash
minikube start
```

**Step 3: Verify:**
```bash
kubectl get nodes
kubectl cluster-info
```

**Step 4: Test:**
```bash
kubectl run test --image=nginx --port=80
kubectl get pods
```

**That's complete setup. Working cluster.**

## Troubleshooting

**Common issues:**

**Issue: minikube start fails**
```bash
# Check Docker is running
docker ps

# Try with different driver
minikube start --driver=virtualbox
```

**Issue: kubectl not configured**
```bash
# Check kubectl context
kubectl config current-context

# Should show: minikube
```

**Issue: Out of resources**
```bash
# Increase resources
minikube stop
minikube start --memory=8192 --cpus=4
```

## My Take: minikube Strategy

**Here's what I do:**

**Learning:**
- Use minikube
- Start simple
- Learn basics

**Development:**
- Use minikube
- Fast iteration
- Local testing

**The key:** Start with minikube. Learn. Then move to cloud.

## Memory Tip: The Hotel Setup Analogy

**minikube setup = Opening small hotel**

**Installation:** Get license
**Starting:** Open hotel
**Verification:** Check works
**Ready:** Operational

**Once you see it this way, minikube makes perfect sense.**

## Common Mistakes

1. **Not installing kubectl**: Can't interact with cluster
2. **Wrong driver**: Doesn't work on platform
3. **Insufficient resources**: Poor performance
4. **Not verifying**: Don't know if works
5. **Forgetting to start**: Cluster not running

## Key Takeaways

1. **minikube is perfect for learning** - Easy setup, local
2. **Single command to start** - `minikube start`
3. **Works on all platforms** - macOS, Linux, Windows
4. **Verify setup** - Check nodes, cluster info
5. **Start simple** - Learn basics, then scale

## What's Next?

Now that you have minikube running, let's verify it works. Next: [Verifying Cluster](/docs/kubernetes/03-setup/verifying-cluster).

---

> **Remember**: minikube is like opening a small hotel. Easy setup. Single command. Perfect for learning. Start simple. Learn. Then scale.

