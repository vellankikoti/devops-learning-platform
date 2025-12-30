---
sidebar_position: 2
title: Dockerfile Basics
---

# Dockerfile Basics: Writing Your First Recipe

**A Dockerfile is like a recipe card. You write instructions. Docker follows them. Simple. But writing a good Dockerfile? That's an art.**

## 🎯 The Big Picture

Think of a Dockerfile like instructions for assembling furniture. Step 1: Get the base. Step 2: Add this part. Step 3: Add that part. Step 4: Configure it. Step 5: Done.

**Each line in a Dockerfile is a step. Docker executes them in order. The result? A Docker image.**

## What is a Dockerfile?

**A Dockerfile is a text file with instructions.** That's it. No magic. Just instructions.

**File name:** `Dockerfile` (exactly that, no extension)

**What it contains:**
- Instructions to build an image
- What base image to use
- What to install
- What files to copy
- How to configure
- How to run

**Docker reads it. Executes it. Creates an image.**

## Your First Dockerfile

Let's start simple. Really simple.

```dockerfile
FROM ubuntu:20.04
RUN echo "Hello, Docker!"
```

**That's it. Two lines.**

**What it does:**
1. `FROM ubuntu:20.04` - Start with Ubuntu 20.04
2. `RUN echo "Hello, Docker!"` - Print a message

**Build it:**
```bash
docker build -t my-first-image .
```

**Run it:**
```bash
docker run my-first-image
# Output: Hello, Docker!
```

**Congratulations. You just wrote your first Dockerfile.**

## Dockerfile Instructions: The Building Blocks

**Here are the instructions you'll use most:**

### FROM: The Foundation

**What it does:** Sets the base image. Like choosing the foundation for a house.

```dockerfile
FROM ubuntu:20.04
FROM node:18
FROM python:3.9
```

**Think of it as:** "Start with this base image. Build everything on top of it."

**Always start with FROM.** It's the foundation.

### RUN: Execute Commands

**What it does:** Runs commands during image build. Like installing software.

```dockerfile
RUN apt-get update
RUN apt-get install -y nginx
RUN npm install
```

**Think of it as:** "Do this while building the image."

**Each RUN creates a new layer.** So combine them when possible:

```dockerfile
# Bad: Multiple layers
RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y curl

# Good: One layer
RUN apt-get update && \
    apt-get install -y nginx curl
```

### COPY: Copy Files

**What it does:** Copies files from your computer into the image.

```dockerfile
COPY app.js /app/
COPY package.json /app/
COPY . /app/
```

**Think of it as:** "Take this file from my computer. Put it in the image at this location."

**Important:** Copy happens during build. Not at runtime.

### ADD: Copy with Extras

**What it does:** Like COPY, but can also download URLs and extract archives.

```dockerfile
ADD https://example.com/file.tar.gz /app/
ADD config.json /app/
```

**Think of it as:** "Copy, but smarter. Can download and extract."

**My take:** Use COPY unless you need ADD's extra features. COPY is clearer.

### WORKDIR: Set Working Directory

**What it does:** Sets the current directory. Like `cd` in Linux.

```dockerfile
WORKDIR /app
RUN npm install
```

**Think of it as:** "From now on, all commands run in this directory."

**All subsequent commands run in this directory.** Like you `cd` into it.

### ENV: Set Environment Variables

**What it does:** Sets environment variables. Like setting system variables.

```dockerfile
ENV NODE_ENV=production
ENV PORT=3000
```

**Think of it as:** "Set these variables. They'll be available when the container runs."

**Use them in your application:**
```javascript
const port = process.env.PORT; // 3000
```

### CMD: Default Command

**What it does:** Sets the command to run when container starts.

```dockerfile
CMD ["node", "app.js"]
```

**Think of it as:** "When someone runs this container, execute this command."

**Important:** Only one CMD per Dockerfile. The last one wins.

### EXPOSE: Document Ports

**What it does:** Documents which ports the container uses. Doesn't actually open them.

```dockerfile
EXPOSE 80
EXPOSE 3000
```

**Think of it as:** "This container uses these ports. Document it."

**It's documentation.** You still need `-p` when running to actually map ports.

## Real-World Example: Node.js Web Application

Let me show you a real Dockerfile I use in production:

```dockerfile
# Step 1: Start with Node.js base
FROM node:18-alpine

# Step 2: Set working directory
WORKDIR /app

# Step 3: Copy package files first (for layer caching)
COPY package*.json ./

# Step 4: Install dependencies
RUN npm ci --only=production

# Step 5: Copy application code
COPY . .

# Step 6: Set environment variable
ENV NODE_ENV=production

# Step 7: Expose port
EXPOSE 3000

# Step 8: Set startup command
CMD ["node", "server.js"]
```

**Why this order?**
- Copy package.json first (changes less often)
- Install dependencies (cached if package.json doesn't change)
- Copy code last (changes most often)

**This optimizes Docker's layer caching.** Faster rebuilds.

## The Restaurant Analogy: Building a Dish

**Think of a Dockerfile like a recipe for a restaurant dish:**

```dockerfile
# Start with base ingredients (FROM)
FROM base-ingredients

# Prepare the base (WORKDIR)
WORKDIR /kitchen

# Get recipe files (COPY)
COPY recipe.txt /kitchen/

# Prepare ingredients (RUN)
RUN chop vegetables
RUN marinate meat

# Set cooking environment (ENV)
ENV TEMPERATURE=high

# Document serving method (EXPOSE)
EXPOSE plate

# Final instruction: How to serve (CMD)
CMD ["serve", "dish"]
```

**Each instruction is a step. Docker follows them in order. Result? A complete dish (image).**

## Layer Caching: The Smart Rebuild

**Here's why Docker is fast: Layer caching.**

**Docker remembers each layer.** If nothing changed, Docker reuses the cached layer.

**Example:**
```dockerfile
FROM node:18          # Layer 1: Cached (doesn't change)
COPY package.json .   # Layer 2: Check if changed
RUN npm install       # Layer 3: Only runs if Layer 2 changed
COPY . .              # Layer 4: Check if changed
CMD ["node", "app.js"] # Layer 5: Check if changed
```

**If you only change your code:**
- Layers 1-3: Reused from cache (fast!)
- Layer 4: Rebuilt (your code changed)
- Layer 5: Reused

**That's why you copy package.json first.** Dependencies change less often than code.

## Building Images: The Process

**How to build:**

```bash
docker build -t my-app:1.0 .
```

**What happens:**
1. Docker reads Dockerfile
2. Executes each instruction
3. Creates a layer for each instruction
4. Builds the final image
5. Tags it as `my-app:1.0`

**The `.` means:** "Use current directory. Look for Dockerfile here."

## Common Patterns

### Pattern 1: Multi-line RUN

```dockerfile
RUN apt-get update && \
    apt-get install -y \
    nginx \
    curl \
    wget && \
    rm -rf /var/lib/apt/lists/*
```

**Why:** Combines commands. Reduces layers. Cleans up in same layer.

### Pattern 2: Copy Dependencies First

```dockerfile
COPY package.json package-lock.json ./
RUN npm install
COPY . .
```

**Why:** Dependencies change less. Code changes more. Better caching.

### Pattern 3: Use .dockerignore

Create `.dockerignore` file:
```
node_modules
.git
.env
*.log
```

**Why:** Excludes files from COPY. Smaller context. Faster builds.

## My Take: Dockerfile Best Practices

**I've written hundreds of Dockerfiles. Here's what I learned:**

1. **Start small.** Get it working. Then optimize.
2. **Order matters.** Put things that change less first.
3. **Combine RUN commands.** Fewer layers = faster builds.
4. **Use .dockerignore.** Don't copy unnecessary files.
5. **Tag your images.** Use versions, not just `latest`.

**The best Dockerfile is one that works. Then make it better.**

## Memory Tip: The Recipe Card Analogy

**Dockerfile = Recipe Card**
- Has step-by-step instructions
- Each line is a step
- Follow in order
- Result is the dish (image)

**Building = Cooking**
- Follow the recipe
- Each step creates a layer
- Final result: Complete dish

**Once you see it this way, Dockerfiles make perfect sense.**

## Common Mistakes

1. **Not using .dockerignore**: Copies unnecessary files, slow builds
2. **Wrong instruction order**: Breaks layer caching
3. **Too many layers**: Slower builds, larger images
4. **Not cleaning up**: Leaves temporary files in image
5. **Using latest tag**: Dangerous in production

## Hands-On Exercise: Build Your First Real Image

**Create a simple web server:**

1. **Create Dockerfile:**
```dockerfile
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

2. **Create index.html:**
```html
<h1>Hello from Docker!</h1>
```

3. **Build:**
```bash
docker build -t my-webserver .
```

4. **Run:**
```bash
docker run -p 8080:80 my-webserver
```

5. **Visit:** http://localhost:8080

**You just built and ran your first real application in Docker!**

## Key Takeaways

1. **Dockerfile is a recipe** - Instructions to build an image
2. **Each instruction is a step** - Executed in order
3. **Each instruction creates a layer** - Layers are cached
4. **Order matters** - Put stable things first for better caching
5. **Start simple** - Get it working, then optimize

## What's Next?

Now that you can write a Dockerfile, let's learn best practices. Next: [Dockerfile Best Practices](/docs/docker/02-images/dockerfile-best-practices).

---

> **Remember**: A Dockerfile is just instructions. Write them clearly. Order them wisely. Docker will follow them.

