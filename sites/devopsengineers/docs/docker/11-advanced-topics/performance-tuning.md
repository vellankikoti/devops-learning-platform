---
sidebar_position: 5
title: Performance Tuning
---

# Performance Tuning: Making Docker Fast

**Docker can be slow. Or fast. It depends on how you tune it. That's performance tuning.**

## 🎯 The Big Picture

Think of performance tuning like tuning a car. Default settings work. But tuned? Faster. More efficient. Better performance. That's performance tuning.

**Performance tuning optimizes Docker. Faster builds. Faster runs. Better resource usage. It's how you make Docker fast.**

## Why Performance Tuning?

**The problem without tuning:**
- Slow builds
- Slow container startup
- High resource usage
- Poor performance
- Wasted resources

**The solution with tuning:**
- Fast builds
- Fast container startup
- Optimal resource usage
- Better performance
- Efficient resources

**Real example:** I once had builds taking 10 minutes. After tuning, 2 minutes. Same Dockerfile. Never going back.

**Tuning isn't optional. It's essential.**

## Build Performance

### 1. Use BuildKit

**Enable BuildKit:**
```bash
export DOCKER_BUILDKIT=1
docker build -t my-app:1.0 .
```

**Why:** Faster builds. Parallel execution.

### 2. Use Cache Mounts

**Cache dependencies:**
```dockerfile
# syntax=docker/dockerfile:1
RUN --mount=type=cache,target=/root/.npm \
    npm ci
```

**Why:** Faster dependency installation.

### 3. Optimize Layer Order

**Order matters:**
```dockerfile
# BAD - changes often, invalidates cache
COPY . .
RUN npm install

# GOOD - changes rarely, preserves cache
COPY package*.json ./
RUN npm install
COPY . .
```

**Why:** Better caching. Faster rebuilds.

### 4. Use Multi-Stage Builds

**Smaller images:**
```dockerfile
FROM node:18 AS builder
# ... build

FROM node:18-alpine
COPY --from=builder /app/dist ./dist
```

**Why:** Smaller images. Faster pulls.

### 5. Use .dockerignore

**Exclude unnecessary files:**
```
node_modules
.git
.env
*.log
```

**Why:** Smaller context. Faster builds.

## The Car Tuning Analogy

**Think of performance tuning like tuning a car:**

**Default:** Works, but not optimal
**Tuned:** Optimized, faster, efficient

**Once you see it this way, tuning makes perfect sense.**

## Runtime Performance

### 1. Resource Limits

**Set appropriate limits:**
```yaml
deploy:
  resources:
    limits:
      cpus: '1.0'
      memory: 512M
    reservations:
      cpus: '0.5'
      memory: 256M
```

**Why:** Prevents resource exhaustion. Better performance.

### 2. Use Read-Only Filesystem

**Read-only when possible:**
```yaml
read_only: true
tmpfs:
  - /tmp
```

**Why:** Better performance. Security.

### 3. Use Health Checks

**Monitor health:**
```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost/health"]
  interval: 30s
```

**Why:** Know when unhealthy. Better reliability.

### 4. Use Appropriate Base Images

**Choose minimal images:**
```dockerfile
# BAD - large image
FROM ubuntu:20.04

# GOOD - minimal image
FROM alpine:latest
```

**Why:** Smaller images. Faster pulls. Less resources.

### 5. Remove Unnecessary Packages

**Clean up:**
```dockerfile
RUN apk add --no-cache package && \
    apk del .build-deps
```

**Why:** Smaller images. Less attack surface.

## Real-World Example: Optimized Setup

**Before (slow):**
```dockerfile
FROM ubuntu:20.04
RUN apt-get update && apt-get install -y nodejs npm
COPY . .
RUN npm install
CMD ["node", "server.js"]
```

**Build time:** 5 minutes
**Image size:** 800MB
**Startup time:** 10 seconds

**After (fast):**
```dockerfile
# syntax=docker/dockerfile:1
FROM node:18-alpine AS deps
WORKDIR /app
COPY package*.json ./
RUN --mount=type=cache,target=/root/.npm \
    npm ci --only=production

FROM node:18-alpine
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
USER nodejs
CMD ["node", "server.js"]
```

**Build time:** 1.5 minutes
**Image size:** 150MB
**Startup time:** 2 seconds

**That's tuning. Faster. Smaller. Better.**

## Best Practices

### 1. Profile First

**Measure before optimizing:**
```bash
docker build --progress=plain -t my-app .
# See where time is spent
```

**Why:** Know what to optimize.

### 2. Use Build Cache

**Leverage cache:**
```bash
docker build --cache-from my-app:latest -t my-app:1.0 .
```

**Why:** Faster builds. Reuse layers.

### 3. Parallelize Builds

**Build in parallel:**
```dockerfile
FROM node:18 AS deps
# ... dependencies

FROM node:18 AS build
# ... build
```

**Why:** Faster. Parallel execution.

### 4. Minimize Layers

**Combine RUN commands:**
```dockerfile
# BAD - many layers
RUN apt-get update
RUN apt-get install -y package1
RUN apt-get install -y package2

# GOOD - one layer
RUN apt-get update && \
    apt-get install -y package1 package2 && \
    rm -rf /var/lib/apt/lists/*
```

**Why:** Fewer layers. Smaller images.

### 5. Monitor Performance

**Track metrics:**
- Build time
- Image size
- Startup time
- Resource usage

**Why:** Know if optimizations work.

## My Take: Performance Strategy

**Here's what I do:**

**Build optimization:**
- Always use BuildKit
- Cache mounts
- Optimize layer order
- Multi-stage builds
- .dockerignore

**Runtime optimization:**
- Resource limits
- Read-only filesystem
- Minimal base images
- Remove unnecessary packages
- Health checks

**The key:** Profile first. Optimize systematically. Measure results.

## Memory Tip: The Car Tuning Analogy

**Performance tuning = Car tuning**

**Default:** Works, not optimal
**Tuned:** Optimized, faster
**Profile:** Measure first
**Optimize:** Systematic improvements

**Once you see it this way, tuning makes perfect sense.**

## Common Mistakes

1. **Not profiling**: Don't know what to optimize
2. **Wrong base images**: Large, slow
3. **No caching**: Slow builds
4. **Too many layers**: Large images
5. **No resource limits**: Resource exhaustion

## Hands-On Exercise: Tune Performance

**1. Profile current build:**
```bash
docker build --progress=plain -t my-app .
# Note build time
```

**2. Enable BuildKit:**
```bash
export DOCKER_BUILDKIT=1
docker build -t my-app .
# Compare time
```

**3. Add cache mounts:**
```dockerfile
RUN --mount=type=cache,target=/root/.npm \
    npm ci
```

**4. Optimize layer order:**
```dockerfile
COPY package*.json ./
RUN npm install
COPY . .
```

**5. Use multi-stage:**
```dockerfile
FROM node:18 AS builder
# ... build

FROM node:18-alpine
COPY --from=builder /app/dist ./dist
```

**6. Measure improvement:**
```bash
# Compare build time
# Compare image size
# Compare startup time
```

## Key Takeaways

1. **Profile first** - Know what to optimize
2. **Use BuildKit** - Faster builds
3. **Use cache mounts** - Faster dependency installation
4. **Optimize layer order** - Better caching
5. **Use multi-stage builds** - Smaller images
6. **Set resource limits** - Prevent exhaustion
7. **Use minimal images** - Faster, smaller

## What's Next?

Congratulations! You've completed the Advanced Topics module. Now let's learn about troubleshooting. Next: [Common Issues](/docs/docker/12-troubleshooting/common-issues).

---

> **Remember**: Performance tuning is like tuning a car. Profile first. Optimize systematically. Measure results. Faster builds. Faster runs. Better performance.

