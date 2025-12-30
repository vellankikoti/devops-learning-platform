---
sidebar_position: 4
title: Docker Architecture
---

# Docker Architecture: How It Actually Works

**Understanding Docker's architecture isn't just academic. It's practical. When things break, you'll know where to look. When you need to optimize, you'll know what to change.**

## 🎯 The Big Picture

Think of Docker's architecture like a restaurant:

- **Docker Client**: You (the customer) ordering food
- **Docker Daemon**: The kitchen (where the work happens)
- **Docker Images**: The recipes (blueprints for dishes)
- **Docker Containers**: The actual dishes (running applications)
- **Docker Registry**: The cookbook library (where recipes are stored)

**You order (client) → Kitchen prepares (daemon) → Uses recipe (image) → Serves dish (container)**

## The Core Components

Docker has four main components:

1. **Docker Client** (`docker` CLI)
2. **Docker Daemon** (`dockerd`)
3. **Docker Images** (blueprints)
4. **Docker Containers** (running instances)

Let's break each down:

## 1. Docker Client

**What it is:**
- The command-line interface you use
- Sends commands to the Docker daemon
- Can be on the same machine or remote

**What it does:**
```bash
docker run nginx
# Client sends command → Daemon executes it
```

**Think of it as:** The remote control for your TV (Docker daemon).

## 2. Docker Daemon

**What it is:**
- The background service that does the actual work
- Manages containers, images, networks, volumes
- Listens for API requests from the client

**What it does:**
- Builds images
- Runs containers
- Manages storage
- Handles networking

**Think of it as:** The engine of your car. It does the work.

**Architecture:**
```
Docker Daemon (dockerd)
├── Container Runtime (containerd)
├── Image Management
├── Network Management
└── Volume Management
```

## 3. Docker Images

**What it is:**
- Read-only templates for creating containers
- Built from Dockerfiles
- Stored in layers (like an onion)

**What it contains:**
- Base operating system
- Application code
- Dependencies
- Configuration

**Think of it as:** A blueprint. It defines what the container will be.

**Image Layers:**
```
Layer 4: Application code (your changes)
Layer 3: Dependencies (npm install)
Layer 2: Base image modifications
Layer 1: Base OS (Ubuntu, Alpine, etc.)
```

## 4. Docker Containers

**What it is:**
- Running instance of an image
- Has a writable layer on top of the image
- Isolated process with its own filesystem

**What it contains:**
- Everything from the image (read-only)
- Writable layer for changes
- Running processes

**Think of it as:** A running instance of the blueprint (image).

## How They Work Together

Here's the flow:

```
1. You: docker run nginx
   ↓
2. Client: Sends request to daemon
   ↓
3. Daemon: Checks if nginx image exists locally
   ↓
4. If not: Pulls image from registry
   ↓
5. Daemon: Creates container from image
   ↓
6. Daemon: Starts container
   ↓
7. Container: Runs nginx process
```

## Docker's Layered Architecture

**This is important:** Docker uses a layered filesystem.

**Images are built in layers:**
```dockerfile
FROM ubuntu:20.04          # Layer 1: Base OS
RUN apt-get update         # Layer 2: Update packages
RUN apt-get install nginx  # Layer 3: Install nginx
COPY app.conf /etc/nginx/  # Layer 4: Copy config
```

**Each instruction creates a new layer.**

**Why layers matter:**
- **Efficiency**: Layers are cached and shared
- **Speed**: Only changed layers are rebuilt
- **Size**: Shared base layers reduce total size

**Example:**
```
Image A: [Base] [App1] [Config1]
Image B: [Base] [App2] [Config2]
         ↑
    Shared layer (saves space)
```

## Docker's Storage Drivers

Docker needs to store images and containers. It uses storage drivers:

**Common drivers:**
- **overlay2** (default, recommended)
- **devicemapper** (legacy)
- **aufs** (legacy)
- **btrfs**, **zfs** (advanced)

**You usually don't need to change this.** overlay2 works for most cases.

## Docker's Networking

Docker creates virtual networks for containers:

**Default networks:**
- **bridge**: Default network for containers
- **host**: Uses host's network directly
- **none**: No networking
- **Custom**: Your own networks

**How it works:**
```
Container A (10.0.0.2) ←→ Bridge Network ←→ Container B (10.0.0.3)
                              ↓
                         Host Network
```

## Docker's Volume System

Docker manages data persistence through volumes:

**Volume types:**
- **Named volumes**: Managed by Docker
- **Bind mounts**: Mount host directories
- **tmpfs**: In-memory storage

**Why volumes matter:**
- Containers are ephemeral
- Data needs to persist
- Volumes provide persistence

## The Complete Picture

```
┌─────────────────────────────────────────┐
│         Docker Client (CLI)              │
│         docker run, build, etc.          │
└──────────────┬──────────────────────────┘
               │
               ↓
┌─────────────────────────────────────────┐
│         Docker Daemon (dockerd)          │
│  ┌──────────────────────────────────┐   │
│  │  Container Runtime (containerd)  │   │
│  └──────────────────────────────────┘   │
│  ┌──────────────────────────────────┐   │
│  │  Image Management                 │   │
│  └──────────────────────────────────┘   │
│  ┌──────────────────────────────────┐   │
│  │  Network Management              │   │
│  └──────────────────────────────────┘   │
│  ┌──────────────────────────────────┐   │
│  │  Volume Management               │   │
│  └──────────────────────────────────┘   │
└─────────────────────────────────────────┘
               │
               ↓
┌─────────────────────────────────────────┐
│         Docker Registry                  │
│    (Docker Hub, Private Registry)        │
└─────────────────────────────────────────┘
```

## Real-World Example: What Happens When You Run `docker run nginx`

1. **Client sends command**: `docker run nginx`
2. **Daemon checks local images**: Does `nginx` image exist?
3. **If not, pulls from registry**: Downloads from Docker Hub
4. **Creates container**: Sets up filesystem, network, volumes
5. **Starts container**: Runs nginx process
6. **Returns control**: Container runs in background

**All of this happens in seconds.**

## My Take: Why Architecture Matters

I used to just run Docker commands without understanding what was happening. Then something broke. I had no idea where to look.

Understanding the architecture changed that. Now I know:
- **Client issues?** Check the CLI
- **Container issues?** Check the daemon logs
- **Image issues?** Check the registry
- **Network issues?** Check Docker networks

**The architecture is your map when things go wrong.**

## Memory Tip: The Restaurant Analogy

- **Docker Client**: You ordering food
- **Docker Daemon**: The kitchen doing the work
- **Docker Images**: Recipes (blueprints)
- **Docker Containers**: Actual dishes (running apps)
- **Docker Registry**: Cookbook library (image storage)

Once you see it this way, the architecture makes sense.

## Common Mistakes

1. **Not understanding layers**: Leads to inefficient images
2. **Ignoring storage drivers**: Can cause performance issues
3. **Not understanding networking**: Containers can't communicate
4. **Forgetting about volumes**: Data gets lost
5. **Not checking daemon logs**: Missing important information

## Key Takeaways

1. **Docker has four core components** - Client, Daemon, Images, Containers
2. **Images are layered** - Understanding layers is key to efficiency
3. **Daemon does the work** - Client just sends commands
4. **Architecture matters** - Helps with troubleshooting
5. **Everything is connected** - Client → Daemon → Containers

## What's Next?

Now that you understand the architecture, let's run your first container. Next: [Your First Container](/docs/docker/01-fundamentals/first-container).

---

> **Remember**: Understanding the architecture isn't just theory. It's practical. It helps you troubleshoot and optimize.

