---
sidebar_position: 2
title: "Docker Scripts: Automate Docker"
---

# Docker Scripts: Automate Docker Operations

Docker scripts automate Docker. Build. Run. Manage containers.

**Here's the thing: Docker scripts automate Docker. Learn patterns. Use them.**

## Basic Docker Script

```bash
#!/bin/bash
docker build -t myapp .
docker run -d -p 8080:80 myapp
```

**My take**: Docker scripts automate. Use them.

## Common Patterns

### Build And Run

```bash
build_image() {
    docker build -t "$1" .
}

run_container() {
    docker run -d -p "$2:80" "$1"
}
```

## What's Next?

Now that you understand Docker scripts, let's talk about [Kubernetes Scripts](/docs/shell-scripting/devops-integration/kubernetes-scripts).

---

> **Personal note**: Docker scripts seemed unnecessary at first. Then I used them. Now I use them constantly. They're useful. Learn them.


