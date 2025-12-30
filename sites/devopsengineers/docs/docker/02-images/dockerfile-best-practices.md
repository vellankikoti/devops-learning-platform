---
sidebar_position: 3
title: Dockerfile Best Practices
---

# Dockerfile Best Practices: Writing Production-Grade Dockerfiles

**Anyone can write a Dockerfile. Writing a good one? That takes practice. Writing a production-grade one? That takes understanding why these practices matter.**

## 🎯 The Big Picture

Think of Dockerfile best practices like building codes. You can build a house without following codes. It might work. But it won't be safe. It won't be efficient. It won't last.

**Following best practices makes your images:**
- **Smaller** - Faster to pull, less storage
- **Faster to build** - Better caching, quicker iterations
- **More secure** - Fewer vulnerabilities, better isolation
- **More reliable** - Consistent builds, predictable behavior

## Practice 1: Use Specific Base Image Tags

**Don't do this:**
```dockerfile
FROM node:latest
FROM ubuntu:latest
```

**Do this:**
```dockerfile
FROM node:18-alpine
FROM ubuntu:20.04
```

**Why?**
- `latest` changes. Today it's version 18. Tomorrow it might be 19. Your build breaks.
- Specific tags are predictable. Same version every time.
- `alpine` is smaller. Less attack surface.

**Real example:** I once used `node:latest`. One day builds started failing. Why? `latest` changed from Node 16 to Node 18. Breaking changes. Took hours to debug.

**Always use specific tags in production.**

## Practice 2: Order Instructions by Change Frequency

**The rule:** Things that change less often should come first.

**Don't do this:**
```dockerfile
FROM node:18
COPY . .              # Changes often
RUN npm install        # Runs every time
```

**Do this:**
```dockerfile
FROM node:18
COPY package*.json ./  # Changes less often
RUN npm install        # Cached if package.json unchanged
COPY . .               # Changes often, but comes last
```

**Why?**
- Docker caches layers. If a layer hasn't changed, Docker reuses the cache.
- Dependencies change less than code. Put them first.
- Code changes frequently. Put it last.

**Result:** Faster rebuilds. Only rebuilds what changed.

## Practice 3: Combine RUN Commands

**Don't do this:**
```dockerfile
RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y curl
RUN rm -rf /var/lib/apt/lists/*
```

**Do this:**
```dockerfile
RUN apt-get update && \
    apt-get install -y nginx curl && \
    rm -rf /var/lib/apt/lists/*
```

**Why?**
- Each RUN creates a layer. More layers = larger image.
- Combining reduces layers. Smaller image.
- Cleanup in same layer. Temporary files don't stay in image.

**The `&&` means:** "Run next command only if previous succeeded."

**The `\` means:** "Continue on next line."

## Practice 4: Use .dockerignore

**Create `.dockerignore` file:**
```
node_modules
.git
.env
*.log
.DS_Store
dist
coverage
```

**Why?**
- Docker sends everything to build context. Large context = slow builds.
- `.dockerignore` excludes files. Smaller context. Faster builds.
- Excludes secrets. `.env` files don't accidentally get copied.

**Real example:** I once forgot `.dockerignore`. Build context was 2GB. Build took 10 minutes. Added `.dockerignore`. Build context became 50MB. Build took 30 seconds.

**Always use `.dockerignore`.**

## Practice 5: Don't Install Unnecessary Packages

**Don't do this:**
```dockerfile
RUN apt-get update && \
    apt-get install -y \
    nginx \
    vim \
    curl \
    wget \
    git \
    build-essential
```

**Do this:**
```dockerfile
RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*
```

**Why?**
- Every package increases image size.
- Every package is a potential security vulnerability.
- Install only what you need.

**If you need build tools, use multi-stage builds (we'll cover that next).**

## Practice 6: Use Non-Root User

**Don't do this:**
```dockerfile
FROM node:18
RUN npm install
CMD ["node", "app.js"]  # Runs as root
```

**Do this:**
```dockerfile
FROM node:18
RUN groupadd -r appuser && useradd -r -g appuser appuser
WORKDIR /app
COPY --chown=appuser:appuser . .
USER appuser
CMD ["node", "app.js"]  # Runs as appuser
```

**Why?**
- Running as root is a security risk. If container is compromised, attacker has root access.
- Use non-root user. Limits damage if compromised.

**Alpine Linux example:**
```dockerfile
FROM node:18-alpine
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001
USER nodejs
```

## Practice 7: Use Multi-Stage Builds

**Don't do this:**
```dockerfile
FROM node:18
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build
CMD ["node", "dist/server.js"]
# Image includes: source code, node_modules, build tools (huge!)
```

**Do this:**
```dockerfile
# Stage 1: Build
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Runtime
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY package*.json ./
CMD ["node", "dist/server.js"]
# Final image: only runtime files (small!)
```

**Why?**
- Build stage has build tools. Runtime doesn't need them.
- Final image is smaller. Only what's needed to run.
- More secure. Fewer packages = fewer vulnerabilities.

**Think of it like:** Building a car in a factory (build stage), then shipping only the finished car (runtime stage).

## Practice 8: Set Proper Labels

**Do this:**
```dockerfile
LABEL maintainer="your-email@example.com"
LABEL version="1.0"
LABEL description="My application"
```

**Why?**
- Documents the image. Who maintains it. What version. What it does.
- Helps with organization. Filter images by label.
- Useful in production. Know what each image is.

## Practice 9: Use Health Checks

**Do this:**
```dockerfile
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:3000/health || exit 1
```

**Why?**
- Docker can check if container is healthy.
- Automatically restarts unhealthy containers.
- Useful in production. Know when things break.

**Your application needs a health endpoint:**
```javascript
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'ok' });
});
```

## Practice 10: Don't Store Secrets in Images

**Don't do this:**
```dockerfile
ENV DB_PASSWORD=mysecretpassword
ENV API_KEY=sk_live_1234567890
```

**Do this:**
```dockerfile
# Use environment variables at runtime
# docker run -e DB_PASSWORD=secret my-app
```

**Or use secrets:**
```dockerfile
# Use Docker secrets or Kubernetes secrets
# Never in Dockerfile
```

**Why?**
- Secrets in images are visible. Anyone with the image can see them.
- Use environment variables at runtime. Or secrets management.
- Never commit secrets to version control.

## Real-World Example: Production Dockerfile

Here's a production Dockerfile I use:

```dockerfile
# Use specific, minimal base image
FROM node:18-alpine

# Set labels
LABEL maintainer="devops@company.com"
LABEL version="1.0.0"

# Create non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Set working directory
WORKDIR /app

# Copy package files first (for caching)
COPY --chown=nodejs:nodejs package*.json ./

# Install dependencies
RUN npm ci --only=production && \
    npm cache clean --force

# Copy application code
COPY --chown=nodejs:nodejs . .

# Switch to non-root user
USER nodejs

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
  CMD node -e "require('http').get('http://localhost:3000/health', (r) => {process.exit(r.statusCode === 200 ? 0 : 1)})"

# Start application
CMD ["node", "server.js"]
```

**Why this works:**
- Specific base image (node:18-alpine)
- Non-root user (security)
- Proper layer ordering (caching)
- Health check (monitoring)
- Production dependencies only (smaller)

## The Hotel Analogy: Building a Proper Hotel

**Think of best practices like building codes for hotels:**

**Practice 1 (Specific tags):** Use approved building materials. Not "whatever's available."

**Practice 2 (Layer ordering):** Build foundation first. Then structure. Then interior.

**Practice 3 (Combine RUN):** Don't build one room at a time. Build efficiently.

**Practice 4 (.dockerignore):** Don't bring construction waste into the hotel.

**Practice 5 (Minimal packages):** Don't install unnecessary features. Keep it simple.

**Practice 6 (Non-root):** Don't give everyone master keys. Limit access.

**Practice 7 (Multi-stage):** Build in construction area. Move only finished rooms to hotel.

**Practice 8 (Labels):** Put signs on rooms. Know what each is.

**Practice 9 (Health checks):** Regular inspections. Know if something's broken.

**Practice 10 (No secrets):** Don't write passwords on walls. Use secure storage.

## My Take: Why These Practices Matter

I learned these practices the hard way. Through production incidents. Through debugging sessions. Through security audits.

**The practices aren't theoretical. They're battle-tested.**

**Start with the basics:**
1. Specific tags
2. Proper layer ordering
3. .dockerignore

**Then add:**
4. Non-root user
5. Multi-stage builds
6. Health checks

**Your Dockerfiles will be:**
- Smaller
- Faster
- More secure
- More reliable

## Memory Tip: The Building Code Analogy

**Dockerfile best practices = Building codes**
- Not optional. They're requirements.
- Based on experience. Learned from mistakes.
- Make things better. Safer. More efficient.

**Follow them. Your images will be production-ready.**

## Common Mistakes

1. **Using `latest` tag**: Breaks when base image changes
2. **Wrong layer order**: Breaks caching, slow builds
3. **Too many layers**: Large images, slow builds
4. **No .dockerignore**: Slow builds, security risks
5. **Running as root**: Security vulnerability
6. **Secrets in images**: Major security risk

## Key Takeaways

1. **Use specific tags** - Predictable builds
2. **Order by change frequency** - Better caching
3. **Combine RUN commands** - Fewer layers
4. **Use .dockerignore** - Faster builds
5. **Run as non-root** - Better security
6. **Use multi-stage builds** - Smaller images
7. **Add health checks** - Better monitoring
8. **Never store secrets** - Security risk

## What's Next?

Now that you know best practices, let's learn about multi-stage builds in detail. Next: [Multi-Stage Builds](/docs/docker/02-images/multi-stage-builds).

---

> **Remember**: Best practices aren't optional. They're what separates working Dockerfiles from production-ready ones.

