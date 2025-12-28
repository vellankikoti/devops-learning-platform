---
sidebar_position: 3
title: "Kubernetes Scripts: Automate K8s"
---

# Kubernetes Scripts: Automate Kubernetes

Kubernetes scripts automate K8s. Deploy. Manage. Common.

**Here's the thing: K8s scripts automate Kubernetes. Learn patterns. Use them.**

## Basic K8s Script

```bash
#!/bin/bash
kubectl apply -f deployment.yaml
kubectl rollout status deployment/myapp
```

**My take**: K8s scripts automate. Use them.

## Common Patterns

### Deploy

```bash
deploy() {
    kubectl apply -f "$1"
    kubectl rollout status deployment/myapp
}
```

## What's Next?

Now that you understand K8s scripts, let's talk about [Cloud Automation](/docs/shell-scripting/devops-integration/cloud-automation).

---

> **Personal note**: K8s scripts seemed complex at first. Then I learned patterns. Now I use them. They're useful. Learn them.

