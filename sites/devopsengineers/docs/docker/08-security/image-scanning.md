---
sidebar_position: 2
title: Image Scanning
---

# Image Scanning: Finding Vulnerabilities Before They Find You

**Vulnerabilities exist. In base images. In dependencies. In your code. Image scanning finds them. Before attackers do. That's why scanning matters.**

## 🎯 The Big Picture

Think of image scanning like a health checkup. You go to the doctor. They check for problems. They find issues early. You fix them. That's image scanning.

**Image scanning finds vulnerabilities. Early. Before production. Before attacks. It's your security inspection.**

## What is Image Scanning?

**Image scanning analyzes Docker images for security vulnerabilities.**

**What it finds:**
- Known CVEs (Common Vulnerabilities and Exposures)
- Outdated packages
- Security issues
- Compliance violations
- Best practice violations

**Think of it as:** A security inspector. Checks everything. Finds problems. Reports issues.

## Why Scan Images?

**The problem without scanning:**
- Unknown vulnerabilities
- Outdated packages
- Security risks
- Compliance issues
- Attacks succeed

**The solution with scanning:**
- Known vulnerabilities
- Updated packages
- Security awareness
- Compliance met
- Attacks prevented

**Real example:** I once deployed an image without scanning. It had a critical vulnerability. It was exploited. Production was compromised. Never again.

**Scanning isn't optional. It's essential.**

## Scanning Tools

**Popular scanning tools:**

### 1. Docker Scout (Built-in)

**Docker's built-in scanning:**
```bash
# Scan image
docker scout cves my-app:1.0

# Compare images
docker scout compare my-app:1.0 my-app:2.0

# Quick view
docker scout quickview my-app:1.0
```

**Why use it:**
- Built into Docker
- Easy to use
- Good for quick checks
- Free

### 2. Trivy

**Comprehensive scanning:**
```bash
# Install Trivy
# macOS: brew install trivy
# Linux: See trivy installation docs

# Scan image
trivy image my-app:1.0

# Scan with JSON output
trivy image --format json my-app:1.0

# Scan filesystem
trivy fs .

# Scan repository
trivy repo https://github.com/user/repo
```

**Why use it:**
- Comprehensive
- Fast
- Multiple scan types
- Good reporting

### 3. Snyk

**Developer-focused scanning:**
```bash
# Install Snyk CLI
npm install -g snyk

# Authenticate
snyk auth

# Scan Docker image
snyk test --docker my-app:1.0

# Monitor image
snyk monitor --docker my-app:1.0
```

**Why use it:**
- Developer-friendly
- Good integration
- Actionable fixes
- Free tier available

### 4. Clair

**Enterprise scanning:**
```bash
# Run Clair server
docker run -d --name clair clair:latest

# Use clair-scanner
clair-scanner my-app:1.0
```

**Why use it:**
- Enterprise-grade
- API-based
- Scalable
- Good for automation

## Understanding Scan Results

**What you'll see:**

```
CRITICAL: 2
HIGH: 5
MEDIUM: 12
LOW: 8

Vulnerabilities:
- CVE-2023-12345 (CRITICAL)
  Package: openssl
  Version: 1.1.1
  Fixed in: 1.1.2
  Description: Buffer overflow vulnerability
```

**Severity levels:**
- **CRITICAL**: Immediate action required
- **HIGH**: Fix soon
- **MEDIUM**: Fix when possible
- **LOW**: Monitor
- **INFO**: Informational

**Think of it as:** Problem severity. Critical is urgent. Low can wait.

## Scanning Workflow

**Complete scanning workflow:**

**Step 1: Scan during build**
```bash
# Build image
docker build -t my-app:1.0 .

# Scan immediately
docker scout cves my-app:1.0
```

**Step 2: Fix critical issues**
```dockerfile
# Update vulnerable package
FROM node:18-alpine
RUN apk update && apk upgrade
# Updates all packages
```

**Step 3: Rescan**
```bash
docker build -t my-app:1.0 .
docker scout cves my-app:1.0
```

**Step 4: Only push if clean**
```bash
# Only push if no critical/high vulnerabilities
if docker scout cves my-app:1.0 | grep -q "CRITICAL\|HIGH"; then
  echo "Vulnerabilities found! Fix before pushing."
  exit 1
fi

docker push my-app:1.0
```

## The Health Checkup Analogy

**Think of image scanning like a health checkup:**

**Scanning:** Doctor's examination
**Vulnerabilities:** Health problems
**Severity:** Problem severity
**Fixes:** Treatment
**Rescan:** Follow-up check

**Once you see it this way, image scanning makes perfect sense.**

## Real-World Example: CI/CD Scanning

**GitHub Actions example:**

```yaml
name: Build and Scan

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Build image
        run: docker build -t my-app:${{ github.sha }} .
      
      - name: Scan image
        run: |
          docker scout cves my-app:${{ github.sha }} > scan-results.txt
          if grep -q "CRITICAL\|HIGH" scan-results.txt; then
            echo "Critical vulnerabilities found!"
            exit 1
          fi
      
      - name: Push if clean
        if: success()
        run: docker push my-app:${{ github.sha }}
```

**What this does:**
- Builds on every push
- Scans for vulnerabilities
- Fails if critical/high found
- Only pushes if clean

**That's how professionals do it. Automated. Consistent. Secure.**

## Scanning Best Practices

### 1. Scan Early and Often

**Scan at multiple stages:**
- During development
- Before committing
- In CI/CD pipeline
- Before production
- Regularly scheduled

**Why:** Find issues early. Fix before production.

### 2. Fix Critical and High First

**Priority order:**
1. CRITICAL - Fix immediately
2. HIGH - Fix soon
3. MEDIUM - Fix when possible
4. LOW - Monitor

**Why:** Focus on what matters. Critical first.

### 3. Update Base Images

**Keep base images updated:**
```dockerfile
# Don't use old base
FROM node:16-alpine

# Use current base
FROM node:18-alpine
```

**Why:** Newer images have fewer vulnerabilities.

### 4. Use Minimal Images

**Smaller images = fewer vulnerabilities:**
```dockerfile
# Large image, many packages
FROM ubuntu:20.04

# Small image, minimal packages
FROM alpine:latest
```

**Why:** Less to scan. Less to attack.

### 5. Automate Scanning

**Don't scan manually:**
- Easy to forget
- Inconsistent
- Error-prone

**Do automate:**
- CI/CD integration
- Pre-commit hooks
- Scheduled scans
- Consistent process

## My Take: Scanning Strategy

**Here's what I do:**

**Development:**
- Quick scan before committing
- Fix critical issues
- Document findings

**CI/CD:**
- Automated scanning
- Fail on critical/high
- Report all findings

**Production:**
- Full scan before deploy
- Regular scheduled scans
- Monitor for new vulnerabilities
- Update when needed

**The key:** Scan early. Scan often. Fix critical. Automate everything.

## Memory Tip: The Health Checkup Analogy

**Image scanning = Health checkup**

**Scan:** Examination
**Vulnerabilities:** Problems
**Severity:** Urgency
**Fixes:** Treatment
**Rescan:** Follow-up

**Once you see it this way, scanning makes perfect sense.**

## Common Mistakes

1. **Not scanning**: Unknown vulnerabilities
2. **Scanning only once**: Miss new issues
3. **Ignoring results**: Vulnerabilities remain
4. **Not automating**: Easy to forget
5. **Only scanning production**: Too late

## Hands-On Exercise: Scan an Image

**1. Build an image:**
```bash
docker build -t test-app:1.0 .
```

**2. Scan with Docker Scout:**
```bash
docker scout cves test-app:1.0
```

**3. Scan with Trivy:**
```bash
trivy image test-app:1.0
```

**4. Compare results:**
```bash
# Different tools may find different issues
# Use multiple tools for comprehensive coverage
```

**5. Fix vulnerabilities:**
```dockerfile
# Update base image
FROM node:18-alpine

# Update packages
RUN apk update && apk upgrade
```

**6. Rescan:**
```bash
docker build -t test-app:1.1 .
docker scout cves test-app:1.1
# Should show fewer vulnerabilities
```

## Key Takeaways

1. **Image scanning finds vulnerabilities** - Before attackers do
2. **Scan early and often** - Find issues early
3. **Fix critical first** - Priority matters
4. **Automate scanning** - Consistent process
5. **Use multiple tools** - Comprehensive coverage
6. **Update base images** - Fewer vulnerabilities

## What's Next?

Now that you understand image scanning, let's learn about secrets management. Next: [Secrets Management](/docs/docker/08-security/secrets-management).

---

> **Remember**: Image scanning is like a health checkup. Find problems early. Fix them. Rescan. Stay healthy. Stay secure.

