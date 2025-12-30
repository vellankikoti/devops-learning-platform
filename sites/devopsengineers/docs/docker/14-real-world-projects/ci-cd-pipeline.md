---
sidebar_position: 2
title: CI/CD Pipeline with Docker
---

# CI/CD Pipeline with Docker: Complete Automation

**CI/CD with Docker automates everything. Build. Test. Deploy. All automated. That's CI/CD.**

## 🎯 The Big Picture

Think of CI/CD like an assembly line. Code comes in. Gets built. Tested. Deployed. Automatically. That's CI/CD.

**CI/CD with Docker automates the pipeline. Build images. Run tests. Deploy containers. All automated. Production-ready.**

## Complete CI/CD Pipeline

**Pipeline stages:**

1. **Build** - Build Docker image
2. **Test** - Run tests in container
3. **Scan** - Scan for vulnerabilities
4. **Push** - Push to registry
5. **Deploy** - Deploy to production

**Think of it as:** Assembly line. Automated. Consistent.

## GitHub Actions Example

**Complete workflow:**

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

env:
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2
      
      - name: Login to Container Registry
        uses: docker/login-action@v2
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}
      
      - name: Build and push
        uses: docker/build-push-action@v4
        with:
          context: .
          push: true
          tags: |
            ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}
            ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:latest
          cache-from: type=registry,ref=${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:buildcache
          cache-to: type=registry,ref=${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:buildcache,mode=max
  
  test:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - uses: actions/checkout@v3
      
      - name: Run tests
        run: |
          docker run --rm \
            -v $(pwd):/app \
            -w /app \
            node:18-alpine \
            npm test
  
  scan:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Scan image
        run: |
          docker pull ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}
          docker scout cves ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}
  
  deploy:
    runs-on: ubuntu-latest
    needs: [build, test, scan]
    if: github.ref == 'refs/heads/main'
    steps:
      - name: Deploy to production
        run: |
          # Deployment commands
          echo "Deploying ${{ github.sha }} to production"
```

**That's CI/CD. Complete. Automated.**

## GitLab CI Example

**Complete pipeline:**

```yaml
stages:
  - build
  - test
  - scan
  - deploy

build:
  stage: build
  image: docker:latest
  services:
    - docker:dind
  script:
    - docker build -t $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA .
    - docker push $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA

test:
  stage: test
  image: node:18-alpine
  script:
    - npm install
    - npm test

scan:
  stage: scan
  image: docker:latest
  services:
    - docker:dind
  script:
    - docker pull $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
    - docker scout cves $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA

deploy:
  stage: deploy
  image: docker:latest
  services:
    - docker:dind
  script:
    - docker pull $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
    - docker run -d $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
  only:
    - main
```

**That's GitLab CI. Simple. Works.**

## Best Practices

### 1. Use Build Cache

**Cache layers:**
```yaml
cache-from: type=registry,ref=my-app:buildcache
cache-to: type=registry,ref=my-app:buildcache,mode=max
```

**Why:** Faster builds. Reuse layers.

### 2. Scan Before Deploy

**Always scan:**
```yaml
- name: Scan
  run: docker scout cves my-app:$GIT_SHA
```

**Why:** Find vulnerabilities. Before production.

### 3. Tag Properly

**Use commit SHA:**
```yaml
tags: my-app:${{ github.sha }}
```

**Why:** Traceability. Know which code.

### 4. Deploy Only on Success

**Conditional deployment:**
```yaml
needs: [build, test, scan]
if: success()
```

**Why:** Only deploy if all pass.

### 5. Use Secrets

**Manage secrets:**
```yaml
secrets:
  - DOCKER_PASSWORD
```

**Why:** Secure. Not exposed.

## Key Takeaways

1. **CI/CD automates everything** - Build, test, scan, deploy
2. **Use build cache** - Faster builds
3. **Scan before deploy** - Find vulnerabilities
4. **Tag properly** - Traceability
5. **Deploy only on success** - Quality gate

## What's Next?

Now that you understand CI/CD, you've completed the Docker learning path! Next: [Docker Summary](/docs/docker/summary).

---

> **Remember**: CI/CD is like an assembly line. Automated. Consistent. Fast. Build. Test. Scan. Deploy. All automated.

