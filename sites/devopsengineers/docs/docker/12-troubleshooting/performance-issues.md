---
sidebar_position: 3
title: Performance Issues
---

# Performance Issues: Making Docker Fast Again

**Docker can be slow. Builds take forever. Containers are sluggish. That's performance issues. But they're fixable.**

## 🎯 The Big Picture

Think of performance issues like a slow car. It works. But it's slow. You tune it. It gets faster. That's performance troubleshooting.

**Performance issues make Docker slow. But they're fixable. Profile. Optimize. Measure. That's how you make it fast.**

## Common Performance Issues

### Issue 1: Slow Builds

**Problem:**
- Builds take 10+ minutes
- Rebuilds are slow
- No caching

**Solution:**
```dockerfile
# Use BuildKit
# syntax=docker/dockerfile:1

# Cache dependencies
RUN --mount=type=cache,target=/root/.npm \
    npm ci

# Optimize layer order
COPY package*.json ./
RUN npm install
COPY . .
```

**Why:** BuildKit is faster. Caching helps.

### Issue 2: Large Images

**Problem:**
- Images are 1GB+
- Slow to pull
- Slow to push

**Solution:**
```dockerfile
# Use multi-stage builds
FROM node:18 AS builder
# ... build

FROM node:18-alpine
COPY --from=builder /app/dist ./dist

# Remove unnecessary files
RUN rm -rf /tmp/* /var/tmp/*
```

**Why:** Smaller images. Faster transfers.

### Issue 3: Slow Container Startup

**Problem:**
- Containers take 30+ seconds to start
- Application slow to respond

**Solution:**
```dockerfile
# Use minimal base image
FROM alpine:latest

# Pre-compile if possible
# Use health checks
HEALTHCHECK --interval=30s CMD curl -f http://localhost/health
```

**Why:** Minimal images start faster.

### Issue 4: High Resource Usage

**Problem:**
- Containers use too much CPU
- Containers use too much memory
- Host runs out of resources

**Solution:**
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

**Why:** Limits prevent resource exhaustion.

## The Slow Car Analogy

**Think of performance issues like a slow car:**

**Slow builds:** Engine needs tuning
**Large images:** Car is too heavy
**Slow startup:** Takes time to start
**High resource usage:** Uses too much fuel

**Once you see it this way, performance makes perfect sense.**

## Profiling Performance

### 1. Profile Builds

**Measure build time:**
```bash
# Time the build
time docker build -t my-app .

# Verbose output
docker build --progress=plain -t my-app .

# See where time is spent
```

**Why:** Know what's slow.

### 2. Profile Images

**Measure image size:**
```bash
# Check image size
docker images

# Detailed size
docker system df -v

# Layer sizes
docker history my-app
```

**Why:** Know what's large.

### 3. Profile Containers

**Measure container performance:**
```bash
# Monitor resources
docker stats

# Check startup time
time docker run my-app

# Profile application
docker exec container-name top
```

**Why:** Know what's slow.

## Real-World Example: Performance Optimization

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

**That's optimization. Faster. Smaller. Better.**

## Optimization Strategies

### 1. Use BuildKit

**Enable BuildKit:**
```bash
export DOCKER_BUILDKIT=1
docker build -t my-app .
```

**Why:** Faster builds. Parallel execution.

### 2. Use Cache Mounts

**Cache dependencies:**
```dockerfile
RUN --mount=type=cache,target=/root/.npm \
    npm ci
```

**Why:** Faster dependency installation.

### 3. Optimize Layer Order

**Order matters:**
```dockerfile
# Changes rarely
COPY package*.json ./
RUN npm install

# Changes often
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

### 5. Use Minimal Base Images

**Smaller base:**
```dockerfile
# BAD
FROM ubuntu:20.04

# GOOD
FROM alpine:latest
```

**Why:** Smaller images. Faster.

## Best Practices

### 1. Profile First

**Measure before optimizing:**
```bash
time docker build -t my-app .
docker images my-app
```

**Why:** Know what to optimize.

### 2. Use .dockerignore

**Exclude unnecessary files:**
```
node_modules
.git
.env
*.log
```

**Why:** Smaller context. Faster builds.

### 3. Set Resource Limits

**Prevent exhaustion:**
```yaml
resources:
  limits:
    cpus: '1.0'
    memory: 512M
```

**Why:** Prevent resource issues.

### 4. Monitor Performance

**Track metrics:**
- Build time
- Image size
- Startup time
- Resource usage

**Why:** Know if optimizations work.

### 5. Clean Up Regularly

**Remove unused resources:**
```bash
docker system prune -a
```

**Why:** Free up space. Better performance.

## My Take: Performance Strategy

**Here's what I do:**

**Build optimization:**
- Always use BuildKit
- Cache mounts
- Optimize layer order
- Multi-stage builds

**Runtime optimization:**
- Minimal base images
- Resource limits
- Health checks
- Regular cleanup

**The key:** Profile first. Optimize systematically. Measure results.

## Memory Tip: The Slow Car Analogy

**Performance issues = Slow car**

**Slow builds:** Engine tuning
**Large images:** Weight reduction
**Slow startup:** Quick start
**High usage:** Fuel efficiency

**Once you see it this way, performance makes perfect sense.**

## Common Mistakes

1. **Not profiling**: Don't know what's slow
2. **Wrong base images**: Large, slow
3. **No caching**: Slow builds
4. **Too many layers**: Large images
5. **No resource limits**: Resource exhaustion

## Hands-On Exercise: Optimize Performance

**1. Profile current build:**
```bash
time docker build -t my-app .
docker images my-app
# Note build time and size
```

**2. Enable BuildKit:**
```bash
export DOCKER_BUILDKIT=1
time docker build -t my-app .
# Compare time
```

**3. Add cache mounts:**
```dockerfile
RUN --mount=type=cache,target=/root/.npm \
    npm ci
```

**4. Use multi-stage:**
```dockerfile
FROM node:18 AS builder
# ... build

FROM node:18-alpine
COPY --from=builder /app/dist ./dist
```

**5. Measure improvement:**
```bash
time docker build -t my-app .
docker images my-app
# Compare with before
```

## Key Takeaways

1. **Profile first** - Know what's slow
2. **Use BuildKit** - Faster builds
3. **Use cache mounts** - Faster dependencies
4. **Optimize layer order** - Better caching
5. **Use multi-stage builds** - Smaller images
6. **Set resource limits** - Prevent exhaustion
7. **Monitor performance** - Track improvements

## What's Next?

Now that you understand performance issues, let's learn about production scenarios. Next: [Production Scenarios](/docs/docker/12-troubleshooting/production-scenarios).

---

> **Remember**: Performance issues are like a slow car. Profile first. Optimize systematically. Measure results. Faster builds. Faster runs. Better performance.

