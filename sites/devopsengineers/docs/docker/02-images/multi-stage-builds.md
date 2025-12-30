---
sidebar_position: 4
title: Multi-Stage Builds
---

# Multi-Stage Builds: Building Efficient Images

**Multi-stage builds are like building a car. You build it in a factory with all the tools. Then you ship only the finished car. You don't ship the factory tools with the car.**

## 🎯 The Big Picture

Think of multi-stage builds like a restaurant kitchen. You prepare food in the kitchen (build stage). You have all the tools: knives, ovens, mixers. Then you serve only the finished dish (runtime stage). You don't bring the kitchen tools to the customer's table.

**That's multi-stage builds. Build with all tools. Ship only what's needed to run.**

## What is a Multi-Stage Build?

**A multi-stage build uses multiple FROM statements.** Each FROM starts a new stage. Like separate rooms in a building.

**Simple build (single stage):**
```dockerfile
FROM node:18
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build
CMD ["node", "dist/server.js"]
# Problem: Image includes build tools, source code, everything (huge!)
```

**Multi-stage build:**
```dockerfile
# Stage 1: Build (the kitchen)
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Runtime (the serving)
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
CMD ["node", "dist/server.js"]
# Result: Only runtime files (small!)
```

**The key:** `--from=builder` copies files from the builder stage. Not the build tools. Just the built files.

## Why Use Multi-Stage Builds?

**Three main reasons:**

### 1. Smaller Images

**Single stage:** 500MB (includes build tools, source code, everything)
**Multi-stage:** 50MB (only runtime files)

**Why it matters:**
- Faster to pull from registry
- Less storage space
- Faster deployments

### 2. More Secure

**Single stage:** Includes compilers, build tools, source code
**Multi-stage:** Only runtime files

**Why it matters:**
- Fewer packages = fewer vulnerabilities
- No source code in production image
- Smaller attack surface

### 3. Cleaner Separation

**Build stage:** Has everything needed to build
**Runtime stage:** Has only what's needed to run

**Why it matters:**
- Clear separation of concerns
- Easier to understand
- Better organization

## Real-World Example: Node.js Application

Let me show you a real example. I'm building a Node.js web application.

**Single-stage (bad):**
```dockerfile
FROM node:18
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build
CMD ["node", "dist/server.js"]
# Size: ~500MB
# Includes: node_modules (dev + prod), source code, build tools
```

**Multi-stage (good):**
```dockerfile
# Stage 1: Build
FROM node:18 AS builder
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install ALL dependencies (including dev dependencies for building)
RUN npm install

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Runtime
FROM node:18-alpine AS runtime
WORKDIR /app

# Copy only production dependencies
COPY package*.json ./
RUN npm ci --only=production

# Copy built files from builder stage
COPY --from=builder /app/dist ./dist

# Set non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001
USER nodejs

# Expose port
EXPOSE 3000

# Start application
CMD ["node", "dist/server.js"]
# Size: ~50MB
# Includes: Only runtime files
```

**Result:**
- Build stage: 500MB (has everything)
- Runtime stage: 50MB (only what's needed)
- **90% size reduction!**

## The Factory Analogy

**Think of multi-stage builds like a factory:**

**Stage 1 (Builder):** The factory floor
- Has all tools: saws, drills, welders
- Has raw materials: metal, screws, paint
- Builds the product: car

**Stage 2 (Runtime):** The shipping department
- Takes only the finished car
- Doesn't take tools or raw materials
- Ships only the car

**Result:** Customer gets the car. Not the factory.

## Advanced: Multiple Build Stages

**You can have more than two stages:**

```dockerfile
# Stage 1: Dependencies
FROM node:18 AS deps
WORKDIR /app
COPY package*.json ./
RUN npm install

# Stage 2: Build
FROM node:18 AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN npm run build

# Stage 3: Test (optional)
FROM builder AS test
RUN npm test

# Stage 4: Runtime
FROM node:18-alpine AS runtime
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=deps /app/node_modules ./node_modules
CMD ["node", "dist/server.js"]
```

**Why multiple stages?**
- Separate concerns
- Cache dependencies separately
- Run tests in isolated stage
- Final image is minimal

## Real-World Example: Go Application

**Go applications benefit greatly from multi-stage builds:**

```dockerfile
# Stage 1: Build
FROM golang:1.21 AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o server

# Stage 2: Runtime
FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /app/server .
CMD ["./server"]
# Size: ~10MB (vs 800MB with golang image)
```

**Why it works:**
- Go compiles to a single binary
- No runtime dependencies needed
- Alpine Linux is tiny (5MB)
- Final image is just the binary + Alpine

## Copying from Previous Stages

**The `--from` flag is key:**

```dockerfile
# Stage 1
FROM node:18 AS builder
RUN echo "Building..." > /app/build.txt

# Stage 2
FROM node:18-alpine
COPY --from=builder /app/build.txt /app/
# Copies file from builder stage
```

**You can copy:**
- Files
- Directories
- From any previous stage

**Naming stages:**
```dockerfile
FROM node:18 AS builder    # Named stage
FROM node:18 AS test        # Another named stage
FROM node:18-alpine
COPY --from=builder ...    # Copy from builder
COPY --from=test ...        # Copy from test
```

## Building Specific Stages

**You can build only specific stages:**

```dockerfile
FROM node:18 AS builder
# ... build steps

FROM node:18-alpine AS runtime
# ... runtime steps
```

**Build only builder stage:**
```bash
docker build --target builder -t my-app:builder .
```

**Build only runtime stage:**
```bash
docker build --target runtime -t my-app:runtime .
```

**Why?**
- Test build stage separately
- Debug specific stages
- Build only what you need

## My Take: When to Use Multi-Stage Builds

**Use multi-stage builds when:**
- You have build tools (compilers, bundlers)
- Your build artifacts are much smaller than build environment
- You want smaller production images
- You want better security (no build tools in production)

**Don't use multi-stage builds when:**
- Simple applications (no build step)
- Build and runtime are the same
- Overhead isn't worth it

**My rule:** If your image is >200MB and you have a build step, use multi-stage.

## Memory Tip: The Restaurant Kitchen Analogy

**Multi-stage builds = Restaurant kitchen**

**Stage 1 (Builder):** The kitchen
- Has all tools: ovens, mixers, knives
- Has all ingredients: flour, eggs, spices
- Prepares the dish

**Stage 2 (Runtime):** The serving
- Takes only the finished dish
- Doesn't take kitchen tools
- Serves to customer

**Customer gets the dish. Not the kitchen.**

## Common Mistakes

1. **Copying everything from builder**: Only copy what you need
2. **Not using --from**: Copies from wrong stage
3. **Including build tools in runtime**: Defeats the purpose
4. **Not naming stages**: Hard to reference later
5. **Over-engineering**: Simple apps don't need multi-stage

## Hands-On Exercise: Convert Single-Stage to Multi-Stage

**Start with this single-stage Dockerfile:**
```dockerfile
FROM node:18
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build
CMD ["node", "dist/server.js"]
```

**Convert to multi-stage:**
```dockerfile
# Build stage
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Runtime stage
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
CMD ["node", "dist/server.js"]
```

**Compare sizes:**
```bash
# Single-stage
docker build -t my-app:single .
docker images my-app:single
# Size: ~500MB

# Multi-stage
docker build -t my-app:multi .
docker images my-app:multi
# Size: ~50MB
```

**90% reduction!**

## Key Takeaways

1. **Multi-stage builds use multiple FROM statements** - Each starts a new stage
2. **Build stage has tools** - Everything needed to build
3. **Runtime stage is minimal** - Only what's needed to run
4. **Use --from to copy** - Copy files from previous stages
5. **Result: Smaller, more secure images** - 90% size reduction common

## What's Next?

Now that you understand multi-stage builds, let's learn how to manage images. Next: [Image Management](/docs/docker/02-images/image-management).

---

> **Remember**: Multi-stage builds are like a factory. Build with all tools. Ship only the finished product.

