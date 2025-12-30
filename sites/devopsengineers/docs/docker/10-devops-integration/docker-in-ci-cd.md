---
sidebar_position: 1
title: Docker in CI/CD
---

# Docker in CI/CD: Automating Your Pipeline

**CI/CD without Docker is like cooking without ingredients. You can do it. But it's harder. Docker makes CI/CD better. Faster. More reliable.**

## 🎯 The Big Picture

Think of Docker in CI/CD like an assembly line. Each step uses the same tools (containers). Same environment. Same results. That's Docker in CI/CD.

**Docker in CI/CD makes pipelines consistent. Reliable. Fast. It's how modern DevOps works.**

## Why Docker in CI/CD?

**The problem without Docker:**
- Different environments (dev, CI, prod)
- "Works on my machine" issues
- Slow builds
- Inconsistent results
- Hard to reproduce

**The solution with Docker:**
- Same environment everywhere
- Consistent builds
- Fast builds (cached layers)
- Reproducible results
- Easy to debug

**Real example:** I once had CI failures that worked locally. Different environments. With Docker, same environment. No more failures. Never again.

**Docker in CI/CD isn't optional. It's essential.**

## CI/CD Pipeline with Docker

**Complete pipeline:**

**1. Build Stage:**
```yaml
# Build Docker image
docker build -t my-app:$GIT_COMMIT .
```

**2. Test Stage:**
```yaml
# Run tests in container
docker run --rm my-app:$GIT_COMMIT npm test
```

**3. Scan Stage:**
```yaml
# Scan for vulnerabilities
docker scout cves my-app:$GIT_COMMIT
```

**4. Push Stage:**
```yaml
# Push to registry
docker push registry.example.com/my-app:$GIT_COMMIT
```

**5. Deploy Stage:**
```yaml
# Deploy to production
docker pull registry.example.com/my-app:$GIT_COMMIT
docker run -d my-app:$GIT_COMMIT
```

**That's a complete CI/CD pipeline. With Docker. Consistent. Reliable.**

## The Assembly Line Analogy

**Think of Docker in CI/CD like an assembly line:**

**Build:** Prepare ingredients (build image)
**Test:** Quality check (run tests)
**Scan:** Safety inspection (scan vulnerabilities)
**Push:** Store product (push to registry)
**Deploy:** Deliver product (deploy to production)

**Once you see it this way, Docker in CI/CD makes perfect sense.**

## GitHub Actions Example

**Complete GitHub Actions workflow:**

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2
      
      - name: Login to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}
      
      - name: Build image
        uses: docker/build-push-action@v4
        with:
          context: .
          push: true
          tags: |
            username/my-app:${{ github.sha }}
            username/my-app:latest
          cache-from: type=registry,ref=username/my-app:buildcache
          cache-to: type=registry,ref=username/my-app:buildcache,mode=max
  
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
          docker pull username/my-app:${{ github.sha }}
          docker scout cves username/my-app:${{ github.sha }}
  
  deploy:
    runs-on: ubuntu-latest
    needs: [build, test, scan]
    if: github.ref == 'refs/heads/main'
    steps:
      - name: Deploy to production
        run: |
          # Deploy commands
          docker pull username/my-app:${{ github.sha }}
          # ... deployment steps
```

**What this does:**
- Builds on every push
- Tests in container
- Scans for vulnerabilities
- Deploys to production
- Complete automation

## GitLab CI Example

**Complete GitLab CI pipeline:**

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

**What this does:**
- Builds Docker image
- Tests application
- Scans for vulnerabilities
- Deploys to production
- GitLab CI integration

## Jenkins Example

**Complete Jenkins pipeline:**

```groovy
pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = 'registry.example.com'
        IMAGE_NAME = 'my-app'
    }
    
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} .'
            }
        }
        
        stage('Test') {
            steps {
                sh 'docker run --rm ${IMAGE_NAME}:${BUILD_NUMBER} npm test'
            }
        }
        
        stage('Scan') {
            steps {
                sh 'docker scout cves ${IMAGE_NAME}:${BUILD_NUMBER}'
            }
        }
        
        stage('Push') {
            steps {
                sh 'docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${DOCKER_REGISTRY}/${IMAGE_NAME}:${BUILD_NUMBER}'
                sh 'docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:${BUILD_NUMBER}'
            }
        }
        
        stage('Deploy') {
            steps {
                sh 'docker pull ${DOCKER_REGISTRY}/${IMAGE_NAME}:${BUILD_NUMBER}'
                sh 'docker run -d ${DOCKER_REGISTRY}/${IMAGE_NAME}:${BUILD_NUMBER}'
            }
        }
    }
}
```

**What this does:**
- Jenkins pipeline
- Docker integration
- Complete automation

## Best Practices

### 1. Use Build Cache

**Cache Docker layers:**
```yaml
docker build \
  --cache-from registry.example.com/my-app:buildcache \
  --cache-to registry.example.com/my-app:buildcache \
  -t my-app:1.0 .
```

**Why:** Faster builds. Reuse layers.

### 2. Multi-Stage Builds

**Use multi-stage in CI/CD:**
```dockerfile
FROM node:18 AS builder
# ... build

FROM node:18-alpine
COPY --from=builder /app/dist ./dist
```

**Why:** Smaller images. Faster deployments.

### 3. Tag Properly

**Tag with commit SHA:**
```bash
docker tag my-app:$GIT_COMMIT registry.example.com/my-app:$GIT_COMMIT
```

**Why:** Traceability. Know which code.

### 4. Scan Before Push

**Scan in pipeline:**
```yaml
- name: Scan
  run: docker scout cves my-app:$GIT_COMMIT
```

**Why:** Find vulnerabilities. Before production.

### 5. Deploy Only on Success

**Conditional deployment:**
```yaml
deploy:
  needs: [build, test, scan]
  if: success()
```

**Why:** Only deploy if all pass.

## My Take: CI/CD Strategy

**Here's what I do:**

**Pipeline stages:**
1. Build - Create image
2. Test - Run tests
3. Scan - Check vulnerabilities
4. Push - Store in registry
5. Deploy - Deploy to production

**The key:** Automate everything. Use Docker. Consistent. Reliable. Fast.

## Memory Tip: The Assembly Line Analogy

**Docker in CI/CD = Assembly line**

**Build:** Prepare
**Test:** Quality check
**Scan:** Safety inspection
**Push:** Store
**Deploy:** Deliver

**Once you see it this way, CI/CD makes perfect sense.**

## Common Mistakes

1. **Not using cache**: Slow builds
2. **Not scanning**: Vulnerable images
3. **Wrong tags**: Can't trace
4. **No tests**: Broken deployments
5. **Manual steps**: Error-prone

## Hands-On Exercise: Simple CI/CD

**1. Create GitHub Actions workflow:**
```yaml
# .github/workflows/ci.yml
name: CI

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Build
        run: docker build -t my-app .
      - name: Test
        run: docker run --rm my-app npm test
```

**2. Push to GitHub:**
```bash
git add .github/workflows/ci.yml
git commit -m "Add CI pipeline"
git push
```

**3. Watch it run:**
- Go to GitHub Actions tab
- See pipeline run
- Check results

**That's CI/CD with Docker. Simple. Works.**

## Key Takeaways

1. **Docker makes CI/CD consistent** - Same environment everywhere
2. **Automate everything** - Build, test, scan, deploy
3. **Use build cache** - Faster builds
4. **Scan before deploy** - Find vulnerabilities
5. **Tag properly** - Traceability
6. **Deploy only on success** - Quality gate

## What's Next?

Now that you understand Docker in CI/CD, let's learn about container orchestration. Next: [Container Orchestration](/docs/docker/10-devops-integration/container-orchestration).

---

> **Remember**: Docker in CI/CD is like an assembly line. Consistent. Reliable. Fast. Automate everything. Use Docker. It works.

