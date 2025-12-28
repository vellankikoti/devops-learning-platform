---
sidebar_position: 2
title: "Container Runtimes: Understanding Containers"
---

# Container Runtimes: How Containers Work

Container runtimes run containers. containerd. runc. They're the foundation of Docker.

**Here's the thing: Understanding runtimes helps you understand Docker. Kubernetes. Modern deployment.**

## What Container Runtimes Do

Container runtimes:
- Run containers
- Manage container lifecycle
- Isolate containers
- Provide the foundation

**My take**: Runtimes are the engine. Docker uses them. Kubernetes uses them.

## containerd: Container Runtime

### What containerd Is

containerd is a container runtime. Docker uses it. Kubernetes uses it.

**My take**: containerd is the runtime. It runs containers.

### containerd Commands

```bash
# List containers
ctr containers list

# Run container
ctr run docker.io/library/nginx:latest nginx

# List images
ctr images list
```

**My take**: `ctr` is containerd's CLI. Use it to manage containers.

## runc: Low-Level Runtime

### What runc Is

runc is the low-level runtime. It actually runs containers.

**My take**: runc is the actual runner. containerd uses it.

## Docker Connection

**Key point**: Docker uses containerd and runc:
- Docker = High-level interface
- containerd = Container runtime
- runc = Low-level runner

**My take**: Understanding runtimes = understanding Docker. Learn them.

## Container Fundamentals

### Namespaces

Containers use Linux namespaces:
- PID namespace
- Network namespace
- Mount namespace
- User namespace

**My take**: Namespaces provide isolation. Containers use them.

### cgroups

cgroups limit resources:
- CPU limits
- Memory limits
- I/O limits

**My take**: cgroups limit resources. Containers use them.

## When You'll Use Runtimes

**You'll use runtimes when**:
- Understanding Docker
- Understanding Kubernetes
- Debugging containers
- Building container tools

**Most of the time**: You'll use Docker. But understanding runtimes helps.

**My take**: Learn runtimes to understand containers. But use Docker for daily work.

## Common Mistakes (I've Made These)

1. **Too complex for beginners**: Start with Docker. Learn runtimes later.

2. **Not understanding layers**: Runtimes are layers. Understand them.

3. **Mixing concepts**: Docker, containerd, runc are different. Understand each.

4. **Not using Docker**: Docker is easier. Use it for daily work.

5. **Overthinking**: Containers are simple. Don't overthink them.

## Real-World Examples

### List Containers

```bash
ctr containers list
```

### Run Container

```bash
ctr run docker.io/library/nginx:latest nginx
```

## What's Next?

Now that you understand runtimes, you understand containers. Or learn about [Cloud Integration](/docs/linux/devops-integration/cloud-integration) for cloud platforms.

---

> **Personal note**: Runtimes seemed complex at first. Then I learned them. Now I understand Docker better. Learn runtimes. Understand containers.

