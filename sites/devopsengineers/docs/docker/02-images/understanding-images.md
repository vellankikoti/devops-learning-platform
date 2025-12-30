---
sidebar_position: 1
title: Understanding Images
---

# Understanding Docker Images: The Blueprint for Containers

**Think of a Docker image like a recipe card. You don't eat the recipe card. You use it to make food. Similarly, you don't run an image. You use it to create containers.**

## 🎯 The Big Picture

Imagine you're building a house. You need a blueprint, right? The blueprint tells you what materials to use, how to arrange them, what the final house will look like.

**A Docker image is like that blueprint.** It tells Docker what to build. What operating system to use. What software to install. What files to include. How to configure everything.

**The container? That's the actual house built from the blueprint.**

## What is a Docker Image?

**A Docker image is a read-only template.** That's the key word: **read-only**. You can't change an image. You can only use it to create containers.

**Think of it like this:**
- **Image**: A photo of a meal (the recipe, the ingredients, everything)
- **Container**: The actual meal you eat (running instance)

You can make many meals from one recipe. Similarly, you can create many containers from one image.

## How Images Work: The Layered System

Here's where it gets interesting. **Docker images are built in layers.** Like an onion. Or a cake with multiple layers.

**Each layer is a step in building the image:**

```
Layer 4: Your application code
    ↓
Layer 3: Install dependencies (npm install, pip install)
    ↓
Layer 2: Install system packages (apt-get install)
    ↓
Layer 1: Base operating system (Ubuntu, Alpine, etc.)
```

**Why layers matter:**
- **Efficiency**: If two images use the same base layer, Docker shares it. Saves space.
- **Speed**: If you change only your code (Layer 4), Docker rebuilds only that layer. Other layers are cached.
- **Size**: Shared layers mean smaller total image sizes.

**Real example:**
- Image A: Ubuntu + Node.js + My App v1
- Image B: Ubuntu + Node.js + My App v2

Both share Ubuntu and Node.js layers. Only the app layer is different. **Docker is smart. It shares the common layers.**

## Where Images Come From

**Images come from three places:**

### 1. Docker Hub (The Public Library)

Docker Hub is like a public library. Millions of images. Free to use. Anyone can publish.

**Common images:**
- `nginx` - Web server
- `redis` - Database
- `node` - Node.js runtime
- `python` - Python runtime
- `ubuntu` - Ubuntu operating system

**How to use:**
```bash
docker pull nginx
# Downloads nginx image from Docker Hub
```

### 2. Private Registries (Your Private Library)

Like a private library. Only your organization can access. For proprietary code.

**Examples:**
- AWS ECR (Elastic Container Registry)
- Google Container Registry
- Azure Container Registry
- Your own private registry

### 3. You Build Them (Your Custom Recipe)

You write a Dockerfile. You build an image. It's yours.

**How to build:**
```bash
docker build -t my-app:1.0 .
# Builds image from Dockerfile in current directory
```

## Image Tags: Versions and Labels

**Tags are like labels on boxes.** They tell you what's inside.

**Format:** `image-name:tag`

**Examples:**
- `nginx:latest` - Latest version
- `nginx:1.21` - Specific version
- `my-app:v1.0` - Your custom tag
- `my-app:production` - Environment tag

**Common tags:**
- `latest` - Most recent version (default if no tag specified)
- Version numbers: `1.0`, `2.1`, `3.0.1`
- Environment: `dev`, `staging`, `production`

**Important:** Always tag your images. `latest` is convenient but dangerous. Use specific versions in production.

## Image Layers: The Onion Analogy

**Think of an image like an onion:**

```
Outer Layer (Your changes)
    ↓
Layer 3 (Dependencies)
    ↓
Layer 2 (System packages)
    ↓
Inner Layer (Base OS)
```

**Each layer is read-only.** When you create a container, Docker adds a writable layer on top. That's where your running application makes changes.

**Why this matters:**
- **Images are immutable** - Can't change them
- **Containers are mutable** - Can make changes (in the writable layer)
- **Layers are shared** - Multiple containers from same image share layers

## Real-World Example: Building a Web Application Image

Let me show you a real example. I'm building a Node.js web application.

**Step 1: Start with a base**
```dockerfile
FROM node:18
# This is Layer 1: Node.js runtime on Linux
```

**Step 2: Install dependencies**
```dockerfile
COPY package.json .
RUN npm install
# This is Layer 2: Dependencies installed
```

**Step 3: Copy application code**
```dockerfile
COPY . .
# This is Layer 3: Your code
```

**Step 4: Set startup command**
```dockerfile
CMD ["node", "app.js"]
# This is Layer 4: How to run it
```

**When I build this:**
```bash
docker build -t my-web-app:1.0 .
```

**Docker creates:**
- Layer 1: node:18 base (shared with other Node.js images)
- Layer 2: npm packages (specific to my app)
- Layer 3: My code (unique to my app)
- Layer 4: Command (how to start)

**Total size:** Maybe 200MB. But Layer 1 (150MB) is shared. So if I have 10 Node.js apps, they all share that 150MB base.

## Image vs Container: The Hotel Analogy

**This is the most important concept. Let me explain with a hotel:**

**Image = Hotel Blueprint**
- The architectural plans
- Shows room layout, facilities, everything
- Read-only. Can't change the blueprint.
- One blueprint can build many hotels

**Container = Actual Hotel Room**
- Built from the blueprint
- You can use it, modify it (within limits)
- Each room is independent
- Many rooms from one blueprint

**When you run a container:**
```bash
docker run nginx
```

**What happens:**
1. Docker takes the nginx image (blueprint)
2. Creates a container (hotel room)
3. Starts the application (guest checks in)
4. Container runs (guest stays in room)

**Multiple containers from one image:**
```bash
docker run nginx  # Container 1
docker run nginx  # Container 2
docker run nginx  # Container 3
```

**Three hotel rooms. Same blueprint. Independent.**

## Inspecting Images

**See what's in an image:**

```bash
# List images
docker images

# Inspect image details
docker inspect nginx

# See image history (layers)
docker history nginx
```

**What you'll see:**
- Image ID
- Size
- Creation date
- Layers
- Configuration

## My Take: Why Images Matter

I used to think images were just files. Then I understood layers. Then I understood sharing. Then everything clicked.

**Images are the foundation of Docker.** Understand images, and you understand Docker.

**The key insight:** Images are immutable. Containers are mutable. That's why Docker works. That's why it's fast. That's why it's efficient.

## Memory Tip: The Recipe Card Analogy

**Docker Image = Recipe Card**
- Has all instructions
- Read-only (can't change the card)
- Use it to make food (containers)
- One recipe, many meals

**Docker Container = The Actual Meal**
- Made from the recipe
- You can eat it, modify it
- Each meal is independent
- Many meals from one recipe

**Once you see it this way, images make perfect sense.**

## Common Mistakes

1. **Confusing images and containers**: Images are blueprints. Containers are instances.
2. **Not tagging images**: Always use specific tags, not just `latest`
3. **Not understanding layers**: Leads to inefficient images
4. **Pulling images without checking size**: Some images are huge
5. **Not cleaning up old images**: They accumulate and waste space

## Key Takeaways

1. **Images are read-only templates** - Blueprints for containers
2. **Images are built in layers** - Like an onion, each layer adds something
3. **Layers are shared** - Multiple images can share base layers
4. **Images come from registries** - Docker Hub, private registries, or you build them
5. **Tags identify versions** - Always use specific tags, not just `latest`

## What's Next?

Now that you understand images, let's learn how to build them. Next: [Dockerfile Basics](/docs/docker/02-images/dockerfile-basics).

---

> **Remember**: An image is a blueprint. A container is the house built from it. Understand this, and Docker makes sense.

