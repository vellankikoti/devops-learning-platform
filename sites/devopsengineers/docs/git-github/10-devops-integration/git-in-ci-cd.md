---
sidebar_position: 1
title: Git in CI/CD
---

# Git in CI/CD: The Foundation of Automation

**CI/CD pipelines are triggered by Git. Understanding how Git integrates with CI/CD is understanding modern DevOps.**

## 🎯 The Big Picture

Every CI/CD pipeline starts with Git. You push code. Git triggers the pipeline. Code gets tested, built, deployed.

**Git is the trigger. CI/CD is the automation. Together, they're DevOps.**

## How CI/CD Uses Git

### Trigger Events

```yaml
# GitHub Actions example
on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
```

**What happens:**
- Push to main → Triggers pipeline
- Create PR → Triggers pipeline
- Tag created → Triggers deployment

### Checking Out Code

```yaml
# Every CI/CD job starts with:
- uses: actions/checkout@v3
  with:
    ref: ${{ github.ref }}
```

**What happens:**
- CI/CD checks out your code
- Runs tests on that version
- Builds from that commit
- Deploys that exact version

## Git Strategies for CI/CD

### Strategy 1: Branch-Based Deployment

```bash
# main branch → Production
# develop branch → Staging
# feature branches → Development

# Push to main triggers production deployment
git push origin main
```

### Strategy 2: Tag-Based Deployment

```bash
# Create release tag
git tag -a v1.2.3 -m "Release version 1.2.3"
git push origin v1.2.3

# CI/CD detects tag, deploys to production
```

### Strategy 3: Commit Message Triggers

```bash
# Special commit message triggers deployment
git commit -m "Deploy to staging [deploy:staging]"
git push
```

## Real-World CI/CD Git Workflows

### Workflow 1: Feature Development

```bash
# 1. Create feature branch
git checkout -b feature/new-api

# 2. Develop and commit
git add .
git commit -m "Add new API endpoint"
git push origin feature/new-api

# 3. CI runs tests on feature branch
# 4. Create PR
# 5. CI runs tests on PR
# 6. Merge to main
# 7. CI deploys to production
```

### Workflow 2: Hotfix Deployment

```bash
# 1. Create hotfix from main
git checkout -b hotfix/critical-bug main

# 2. Fix and commit
git add .
git commit -m "Fix critical security bug"
git push origin hotfix/critical-bug

# 3. CI runs tests
# 4. Merge to main
# 5. CI immediately deploys (bypasses staging)
```

### Workflow 3: Release Process

```bash
# 1. Merge to main
git checkout main
git merge release/v1.2.3

# 2. Tag release
git tag -a v1.2.3 -m "Release 1.2.3"
git push origin v1.2.3

# 3. CI detects tag, creates release, deploys
```

## Git Hooks in CI/CD

### Pre-Push Validation

```bash
# .git/hooks/pre-push
#!/bin/bash
# Run tests before allowing push
npm test
if [ $? -ne 0 ]; then
    echo "Tests failed. Push aborted."
    exit 1
fi
```

### Post-Receive Deployment

```bash
# On server, after git push
# .git/hooks/post-receive
#!/bin/bash
cd /var/www/app
git pull
npm install
npm run build
systemctl restart app
```

## My Take: Git Is the Trigger

I used to think CI/CD was separate from Git. I'd push code, then manually trigger deployments.

Then I learned: **Git IS the trigger. Every push can trigger automation.**

Now I structure my Git workflow around CI/CD:
- Feature branches trigger tests
- Main branch triggers deployment
- Tags trigger releases

**Git and CI/CD are one system. Design them together.**

## Key Takeaways

1. **Git triggers CI/CD** - Every push can start automation
2. **Branches map to environments** - main = production, develop = staging
3. **Tags trigger releases** - Version tags deploy specific versions
4. **Git hooks integrate** - Pre-push validation, post-receive deployment
5. **Git and CI/CD are one** - Design them together

## What's Next?

Now that you understand Git in CI/CD, let's learn about GitOps. Next: [GitOps Principles](/docs/git-github/devops-integration/gitops-principles).

---

> **Remember**: Git is the foundation. CI/CD is the automation. Together, they're DevOps.

