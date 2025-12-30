---
sidebar_position: 3
title: Image Publishing
---

# Image Publishing: Sharing Your Images

**You built an image. Now share it. With your team. With the world. That's image publishing. It's how you distribute your applications.**

## 🎯 The Big Picture

Think of image publishing like publishing a book. You write it (build image). You publish it (push to registry). Others can read it (pull image). That's image publishing.

**Publishing images makes them available. Shareable. Usable. It's how Docker works at scale.**

## Why Publish Images?

**The problem without publishing:**
- Images only on your machine
- Can't share with team
- Can't deploy to servers
- Can't use in CI/CD

**The solution with publishing:**
- Images available to team
- Deploy anywhere
- Use in CI/CD
- Share with world

**That's why publishing matters. It makes images useful.**

## Publishing Workflow

**The complete workflow:**

**Step 1: Build your image**
```bash
docker build -t my-app:1.0 .
```

**Step 2: Tag for registry**
```bash
docker tag my-app:1.0 registry.example.com/my-app:1.0
```

**Step 3: Login to registry**
```bash
docker login registry.example.com
```

**Step 4: Push to registry**
```bash
docker push registry.example.com/my-app:1.0
```

**That's it. Image is published. Others can pull it.**

## Publishing to Docker Hub

**Complete example:**

**Step 1: Build image**
```bash
docker build -t my-app:1.0 .
```

**Step 2: Tag with your username**
```bash
docker tag my-app:1.0 username/my-app:1.0
```

**Step 3: Login to Docker Hub**
```bash
docker login
# Enter username and password
```

**Step 4: Push to Docker Hub**
```bash
docker push username/my-app:1.0
```

**Step 5: Verify**
```bash
# Check on Docker Hub website
# Or pull to verify:
docker pull username/my-app:1.0
```

**Image is now public on Docker Hub. Anyone can pull it.**

## Publishing to Private Registry

**Complete example:**

**Step 1: Build image**
```bash
docker build -t my-app:1.0 .
```

**Step 2: Tag for private registry**
```bash
docker tag my-app:1.0 registry.example.com/my-app:1.0
```

**Step 3: Login to registry**
```bash
docker login registry.example.com
# Enter credentials
```

**Step 4: Push to registry**
```bash
docker push registry.example.com/my-app:1.0
```

**Image is now in private registry. Only authorized users can access.**

## Publishing Best Practices

### 1. Use Semantic Versioning

**Tag with versions:**
```bash
docker tag my-app:1.0 username/my-app:1.0.0
docker tag my-app:1.0 username/my-app:1.0
docker tag my-app:1.0 username/my-app:1
docker tag my-app:1.0 username/my-app:latest
```

**Why:** Clear versions. Easy to track. Easy to rollback.

### 2. Tag Multiple Versions

**Tag with multiple tags:**
```bash
docker tag my-app:1.0.0 username/my-app:1.0.0
docker tag my-app:1.0.0 username/my-app:1.0
docker tag my-app:1.0.0 username/my-app:1
docker tag my-app:1.0.0 username/my-app:latest
```

**Push all tags:**
```bash
docker push username/my-app:1.0.0
docker push username/my-app:1.0
docker push username/my-app:1
docker push username/my-app:latest
```

**Why:** Flexibility. Users can choose version specificity.

### 3. Never Push Secrets

**Don't do this:**
```dockerfile
# BAD - Secrets in image
ENV DB_PASSWORD=my-secret-password
ENV API_KEY=sk_live_1234567890
```

**Do this:**
```dockerfile
# GOOD - No secrets in image
ENV DB_PASSWORD_FILE=/run/secrets/db_password
```

**Why:** Secrets in images are visible. Security risk.

### 4. Scan Before Publishing

**Scan for vulnerabilities:**
```bash
# Use Docker Scout or similar
docker scout cves my-app:1.0
```

**Fix vulnerabilities before publishing.**

**Why:** Don't publish vulnerable images. Security best practice.

### 5. Document Your Images

**Add labels:**
```dockerfile
LABEL maintainer="your-email@example.com"
LABEL version="1.0.0"
LABEL description="My application"
LABEL org.opencontainers.image.source="https://github.com/user/repo"
```

**Add README on registry:**
- What the image does
- How to use it
- Environment variables
- Examples

**Why:** Help others use your image. Better adoption.

## The Book Publishing Analogy

**Think of image publishing like book publishing:**

**Build image:** Write the book
**Tag image:** Prepare for publishing
**Login:** Get publishing credentials
**Push:** Publish the book
**Pull:** Others read the book

**Once you see it this way, image publishing makes perfect sense.**

## Real-World Example: CI/CD Publishing

**Let me show you a real CI/CD workflow:**

**GitHub Actions example:**
```yaml
name: Build and Push

on:
  push:
    tags:
      - 'v*'

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Login to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}
      
      - name: Build image
        run: docker build -t my-app:${{ github.ref_name }} .
      
      - name: Tag image
        run: |
          docker tag my-app:${{ github.ref_name }} username/my-app:${{ github.ref_name }}
          docker tag my-app:${{ github.ref_name }} username/my-app:latest
      
      - name: Push image
        run: |
          docker push username/my-app:${{ github.ref_name }}
          docker push username/my-app:latest
```

**What this does:**
- Builds on tag push
- Logs into Docker Hub
- Builds and tags image
- Pushes to registry
- Automated publishing

**That's how professionals publish images. Automated. Consistent.**

## Publishing Workflow Tips

### Tip 1: Use Build Args

**Pass build-time variables:**
```bash
docker build \
  --build-arg VERSION=1.0.0 \
  --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
  -t my-app:1.0.0 .
```

**Use in Dockerfile:**
```dockerfile
ARG VERSION
ARG BUILD_DATE

LABEL version=$VERSION
LABEL build-date=$BUILD_DATE
```

**Why:** Metadata in images. Traceability.

### Tip 2: Multi-Architecture Builds

**Build for multiple architectures:**
```bash
# Create builder
docker buildx create --use

# Build for multiple platforms
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t username/my-app:1.0.0 \
  --push .
```

**Why:** Works on different hardware. Better compatibility.

### Tip 3: Automated Tagging

**Tag based on Git:**
```bash
# Tag with Git commit
docker tag my-app:1.0 username/my-app:$(git rev-parse --short HEAD)

# Tag with Git tag
docker tag my-app:1.0 username/my-app:$(git describe --tags)
```

**Why:** Traceability. Know which code is in image.

## My Take: Publishing Strategy

**Here's what I do:**

**Development:**
- Push to private registry
- Tag with branch name
- Quick iteration

**Staging:**
- Push to private registry
- Tag with version
- Test before production

**Production:**
- Push to production registry
- Tag with semantic version
- Scan before publishing
- Document changes

**The key:** Automate publishing. Use CI/CD. Never publish manually in production.

## Memory Tip: The Book Publishing Analogy

**Image publishing = Book publishing**

**Build:** Write book
**Tag:** Prepare
**Login:** Credentials
**Push:** Publish
**Pull:** Read

**Once you see it this way, publishing makes perfect sense.**

## Common Mistakes

1. **Pushing secrets**: Security risk
2. **Using only `latest`**: Can't rollback
3. **Not scanning**: Vulnerable images
4. **Manual publishing**: Error-prone
5. **No documentation**: Hard to use

## Hands-On Exercise: Publish an Image

**1. Build an image:**
```bash
docker build -t my-app:1.0.0 .
```

**2. Tag for Docker Hub:**
```bash
docker tag my-app:1.0.0 username/my-app:1.0.0
docker tag my-app:1.0.0 username/my-app:latest
```

**3. Login:**
```bash
docker login
```

**4. Push:**
```bash
docker push username/my-app:1.0.0
docker push username/my-app:latest
```

**5. Verify:**
```bash
# Check on Docker Hub
# Or pull to test:
docker pull username/my-app:1.0.0
```

**6. Test:**
```bash
docker run -d --name test username/my-app:1.0.0
docker logs test
docker stop test
docker rm test
```

## Key Takeaways

1. **Publishing makes images available** - Share with team, deploy anywhere
2. **Use semantic versioning** - Clear versions, easy rollback
3. **Never push secrets** - Security risk
4. **Scan before publishing** - Find vulnerabilities
5. **Automate publishing** - Use CI/CD, consistent process

## What's Next?

Congratulations! You've completed the Docker Hub & Registry module. Now let's learn about Docker security. Next: [Container Security](/docs/docker/08-security/container-security).

---

> **Remember**: Image publishing is like book publishing. Build. Tag. Login. Push. Share with the world. But never publish secrets.

