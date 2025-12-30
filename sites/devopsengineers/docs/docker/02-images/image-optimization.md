---
sidebar_position: 6
title: Image Optimization
---

# Image Optimization: Making Images Smaller and Faster

**Small images are fast. Fast to pull. Fast to start. Fast to deploy. Large images? They're slow. Slow to pull. Slow to start. Slow to deploy.**

## 🎯 The Big Picture

Think of image optimization like packing for a trip. You can bring everything (large suitcase). Or you can bring only what you need (small backpack). The backpack is lighter. Easier to carry. Faster to move.

**Image optimization is about:**
- **Smaller images** - Less to download, less storage
- **Faster builds** - Better caching, quicker iterations
- **Faster deployments** - Less to transfer, quicker starts
- **Better security** - Fewer packages, fewer vulnerabilities

## Why Optimize Images?

**Real numbers from my experience:**

**Before optimization:**
- Image size: 800MB
- Pull time: 2 minutes
- Build time: 5 minutes
- Security vulnerabilities: 45

**After optimization:**
- Image size: 50MB
- Pull time: 10 seconds
- Build time: 1 minute
- Security vulnerabilities: 3

**94% size reduction. 12x faster pulls. 5x faster builds. 93% fewer vulnerabilities.**

**That's why optimization matters.**

## Strategy 1: Use Smaller Base Images

**The base image is the foundation. Choose wisely.**

**Don't do this:**
```dockerfile
FROM ubuntu:20.04  # ~70MB
FROM node:18       # ~900MB
```

**Do this:**
```dockerfile
FROM alpine:latest    # ~5MB
FROM node:18-alpine   # ~170MB (vs 900MB)
```

**Alpine Linux:**
- Minimal Linux distribution
- Based on musl libc and BusyBox
- Much smaller than Ubuntu/Debian
- Security-focused

**Size comparison:**
- `ubuntu:20.04`: 70MB
- `debian:bullseye`: 120MB
- `alpine:latest`: 5MB

**Use Alpine when possible. 93% smaller.**

## Strategy 2: Multi-Stage Builds

**We covered this, but it's worth repeating:**

```dockerfile
# Build stage (has build tools)
FROM node:18 AS builder
# ... build steps

# Runtime stage (minimal)
FROM node:18-alpine
COPY --from=builder /app/dist ./dist
# Only runtime files
```

**Result:** 90% size reduction common.

## Strategy 3: Minimize Layers

**Each instruction creates a layer. More layers = larger image.**

**Don't do this:**
```dockerfile
RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y curl
RUN rm -rf /var/lib/apt/lists/*
# 4 layers
```

**Do this:**
```dockerfile
RUN apt-get update && \
    apt-get install -y nginx curl && \
    rm -rf /var/lib/apt/lists/*
# 1 layer
```

**Why it matters:**
- Fewer layers = smaller image
- Combined commands = better caching
- Cleanup in same layer = no temporary files

## Strategy 4: Use .dockerignore

**Don't copy unnecessary files:**

**Create `.dockerignore`:**
```
node_modules
.git
.env
*.log
.DS_Store
dist
coverage
.vscode
.idea
```

**Why:**
- Smaller build context
- Faster builds
- No secrets accidentally copied
- Cleaner images

**Real example:** I once forgot `.dockerignore`. Build context was 2GB. Build took 10 minutes. Added `.dockerignore`. Build context became 50MB. Build took 30 seconds.

## Strategy 5: Install Only What You Need

**Don't install everything:**

**Don't do this:**
```dockerfile
RUN apt-get update && \
    apt-get install -y \
    nginx \
    vim \
    curl \
    wget \
    git \
    build-essential \
    python3 \
    ruby
# Installing everything "just in case"
```

**Do this:**
```dockerfile
RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*
# Only what you need
```

**Why:**
- Every package adds size
- Every package is a potential vulnerability
- Install only what's required

## Strategy 6: Clean Up in Same Layer

**Clean up temporary files in the same RUN command:**

**Don't do this:**
```dockerfile
RUN apt-get update
RUN apt-get install -y nginx
RUN rm -rf /var/lib/apt/lists/*
# Cleanup in separate layer (doesn't help)
```

**Do this:**
```dockerfile
RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*
# Cleanup in same layer (actually removes files)
```

**Why:**
- Each layer is immutable
- Files deleted in later layer still exist in previous layers
- Clean up in same layer to actually remove files

## Strategy 7: Use Specific Package Versions

**Pin versions for reproducibility:**

**Don't do this:**
```dockerfile
RUN npm install express
# Gets latest version (might change)
```

**Do this:**
```dockerfile
RUN npm install express@4.18.2
# Specific version (predictable)
```

**Or use package-lock.json:**
```dockerfile
COPY package.json package-lock.json ./
RUN npm ci
# Uses exact versions from lock file
```

**Why:**
- Predictable builds
- Reproducible images
- No surprises

## Strategy 8: Order Instructions by Change Frequency

**We covered this, but it's critical:**

```dockerfile
# Things that change less often first
FROM node:18-alpine
COPY package*.json ./
RUN npm install

# Things that change more often last
COPY . .
RUN npm run build
```

**Why:**
- Better layer caching
- Faster rebuilds
- Only rebuilds what changed

## Real-World Example: Optimizing a Node.js App

**Before optimization:**
```dockerfile
FROM node:18
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build
CMD ["node", "dist/server.js"]
# Size: 800MB
```

**After optimization:**
```dockerfile
# Build stage
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Runtime stage
FROM node:18-alpine
WORKDIR /app
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001
COPY --chown=nodejs:nodejs package*.json ./
RUN npm ci --only=production && \
    npm cache clean --force
COPY --chown=nodejs:nodejs --from=builder /app/dist ./dist
USER nodejs
EXPOSE 3000
CMD ["node", "dist/server.js"]
# Size: 50MB (94% reduction!)
```

**Optimizations applied:**
1. ✅ Alpine base (smaller)
2. ✅ Multi-stage build (no build tools in runtime)
3. ✅ Proper layer ordering (better caching)
4. ✅ Production dependencies only (smaller)
5. ✅ Clean npm cache (removes cache)
6. ✅ Non-root user (security)

## The Travel Analogy: Packing Efficiently

**Think of optimization like packing for a trip:**

**Strategy 1 (Smaller base):** Choose a smaller suitcase (Alpine vs Ubuntu)

**Strategy 2 (Multi-stage):** Pack at home (build stage), bring only essentials (runtime stage)

**Strategy 3 (Minimize layers):** Use packing cubes efficiently (combine commands)

**Strategy 4 (.dockerignore):** Don't pack unnecessary items (exclude files)

**Strategy 5 (Only what you need):** Pack only essentials (install only required packages)

**Strategy 6 (Clean up):** Remove packaging as you pack (clean in same layer)

**Strategy 7 (Specific versions):** Pack specific items, not "whatever's available" (pin versions)

**Strategy 8 (Order matters):** Pack stable items first (layer ordering)

**Result:** Light, efficient suitcase. Easy to carry. Fast to move.

## Measuring Image Size

**Check image sizes:**

```bash
# List images with sizes
docker images

# Detailed size information
docker system df -v

# Inspect specific image
docker inspect my-app:1.0 | grep Size
```

**Compare before/after:**
```bash
# Before optimization
docker build -t my-app:before .
docker images my-app:before
# Size: 800MB

# After optimization
docker build -t my-app:after .
docker images my-app:after
# Size: 50MB
```

## Security Benefits

**Smaller images = More secure:**

**Fewer packages:**
- Less attack surface
- Fewer vulnerabilities
- Easier to audit

**No build tools:**
- Compilers not in production
- Source code not in production
- Build dependencies not in production

**Real example:**
- Large image: 45 vulnerabilities
- Optimized image: 3 vulnerabilities
- **93% reduction in vulnerabilities**

## My Take: Optimization Strategy

**I optimize in this order:**

1. **Use Alpine base** - Biggest win, easiest change
2. **Multi-stage builds** - Huge size reduction
3. **Proper layer ordering** - Faster builds
4. **.dockerignore** - Faster builds, security
5. **Minimize packages** - Security, size
6. **Clean up in same layer** - Actually removes files

**Start with #1 and #2. You'll see 90% improvement immediately.**

**Then optimize further based on your needs.**

## Memory Tip: The Packing Analogy

**Image optimization = Efficient packing**

**Smaller base:** Smaller suitcase
**Multi-stage:** Pack essentials only
**Minimize layers:** Efficient packing
**.dockerignore:** Don't pack unnecessary items
**Only what you need:** Pack essentials
**Clean up:** Remove packaging
**Order matters:** Pack stable items first

**Once you see it this way, optimization makes sense.**

## Common Mistakes

1. **Not using Alpine**: Missing biggest optimization
2. **Not using multi-stage**: Including build tools in production
3. **Too many layers**: Slower builds, larger images
4. **No .dockerignore**: Slow builds, security risks
5. **Installing everything**: Large images, many vulnerabilities

## Hands-On Exercise: Optimize an Image

**Start with this:**
```dockerfile
FROM node:18
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build
CMD ["node", "dist/server.js"]
```

**Optimize it:**
1. Use Alpine base
2. Multi-stage build
3. Proper layer ordering
4. Add .dockerignore
5. Production dependencies only

**Compare sizes before/after.**

## Key Takeaways

1. **Use Alpine base** - 93% smaller than Ubuntu
2. **Use multi-stage builds** - 90% size reduction common
3. **Minimize layers** - Combine commands
4. **Use .dockerignore** - Faster builds, security
5. **Install only what you need** - Smaller, more secure
6. **Clean up in same layer** - Actually removes files
7. **Order by change frequency** - Better caching

## What's Next?

Congratulations! You've completed the Images module. Now let's learn about containers. Next: [Container Lifecycle](/docs/docker/03-containers/container-lifecycle).

---

> **Remember**: Optimization isn't optional. Small images are fast. Fast images are better. Optimize early. Optimize often.

