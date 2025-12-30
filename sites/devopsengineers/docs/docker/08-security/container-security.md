---
sidebar_position: 1
title: Container Security
---

# Container Security: Protecting Your Containers

**Security isn't optional. It's essential. Containers need security. Images need security. Everything needs security. That's container security.**

## 🎯 The Big Picture

Think of container security like home security. You lock doors (non-root users). You have alarms (scanning). You check visitors (image verification). You protect valuables (secrets). That's container security.

**Container security is about protection. Layers of protection. Defense in depth. It's how you keep things safe.**

## Why Container Security Matters

**The problem without security:**
- Vulnerable containers
- Exposed secrets
- Root access
- No scanning
- Security breaches

**The solution with security:**
- Hardened containers
- Protected secrets
- Limited privileges
- Regular scanning
- Secure deployments

**Real example:** I once saw a container running as root with secrets in environment variables. It was compromised. Data was stolen. Never again.

**Security isn't theoretical. It's real. It matters.**

## Security Layers

**Defense in depth - multiple layers:**

**Layer 1: Image Security**
- Use trusted base images
- Scan for vulnerabilities
- Keep images updated
- Minimal images

**Layer 2: Container Security**
- Non-root users
- Read-only filesystems
- Resource limits
- Network policies

**Layer 3: Runtime Security**
- Secrets management
- Access control
- Monitoring
- Logging

**Layer 4: Infrastructure Security**
- Secure registries
- Network isolation
- Host security
- Compliance

**Think of it as:** Multiple locks on doors. Each layer adds protection. Defense in depth.

## Principle 1: Use Minimal Base Images

**Don't do this:**
```dockerfile
FROM ubuntu:20.04
# Large image, many packages, many vulnerabilities
```

**Do this:**
```dockerfile
FROM alpine:latest
# Small image, minimal packages, fewer vulnerabilities
```

**Or:**
```dockerfile
FROM distroless/nodejs:18
# Even smaller, no shell, minimal attack surface
```

**Why:**
- Smaller attack surface
- Fewer vulnerabilities
- Faster scans
- Better security

**Size comparison:**
- `ubuntu:20.04`: ~70MB
- `alpine:latest`: ~5MB
- `distroless/nodejs:18`: ~20MB

**Smaller is better. Less to attack. Less to maintain.**

## Principle 2: Run as Non-Root

**Don't do this:**
```dockerfile
FROM node:18
# Runs as root by default
CMD ["node", "app.js"]
```

**Do this:**
```dockerfile
FROM node:18-alpine

# Create non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Set working directory
WORKDIR /app

# Copy files as non-root
COPY --chown=nodejs:nodejs . .

# Switch to non-root user
USER nodejs

CMD ["node", "app.js"]
```

**Why:**
- Limits damage if compromised
- Principle of least privilege
- Security best practice
- Required in many environments

**Think of it as:** Don't give everyone master keys. Give them only what they need.

## Principle 3: Scan Images

**Scan for vulnerabilities:**

```bash
# Using Docker Scout (built-in)
docker scout cves my-app:1.0

# Or using Trivy
trivy image my-app:1.0

# Or using Snyk
snyk test --docker my-app:1.0
```

**What scanning finds:**
- Known vulnerabilities
- Outdated packages
- Security issues
- Recommendations

**Scan regularly:**
- Before publishing
- In CI/CD pipeline
- Regularly scheduled
- After base image updates

**Think of it as:** Security inspection. Find problems before they're exploited.

## Principle 4: Keep Images Updated

**Update regularly:**

```bash
# Check for updates
docker pull nginx:alpine
# Gets latest alpine-based nginx

# Update base images
docker pull node:18-alpine
# Gets latest Node.js 18 on Alpine
```

**Why:**
- Security patches
- Bug fixes
- New features
- Better performance

**Strategy:**
- Use specific tags (not `latest`)
- Update regularly
- Test updates
- Document changes

## Principle 5: Use Secrets Management

**Don't do this:**
```dockerfile
ENV DB_PASSWORD=my-secret-password
ENV API_KEY=sk_live_1234567890
```

**Do this:**
```yaml
# docker-compose.yml
services:
  app:
    secrets:
      - db_password
      - api_key

secrets:
  db_password:
    file: ./secrets/db_password.txt
  api_key:
    file: ./secrets/api_key.txt
```

**Or use environment variables at runtime:**
```bash
docker run -e DB_PASSWORD=secret my-app
```

**Why:**
- Not in image layers
- Not in version control
- Can rotate easily
- Better security

## Principle 6: Read-Only Filesystems

**Use read-only root filesystem:**

```yaml
services:
  app:
    image: my-app:1.0
    read_only: true
    tmpfs:
      - /tmp
      - /var/run
```

**Why:**
- Prevents file modifications
- Limits attack surface
- Immutable containers
- Better security

**Use tmpfs for writable directories:**
- `/tmp` - Temporary files
- `/var/run` - Runtime files
- `/var/cache` - Cache files

## Principle 7: Resource Limits

**Set resource limits:**

```yaml
services:
  app:
    image: my-app:1.0
    deploy:
      resources:
        limits:
          cpus: '1.0'
          memory: 512M
        reservations:
          cpus: '0.5'
          memory: 256M
```

**Why:**
- Prevent resource exhaustion
- Denial of service protection
- Fair resource sharing
- Predictable performance

## Principle 8: Network Isolation

**Isolate networks:**

```yaml
services:
  app:
    networks:
      - frontend
      - backend

  db:
    networks:
      - backend  # Only backend, not frontend

networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
    internal: true  # No external access
```

**Why:**
- Limit network access
- Defense in depth
- Better security
- Compliance

## The Home Security Analogy

**Think of container security like home security:**

**Minimal images:** Small house, fewer entry points
**Non-root:** Don't give master keys
**Scanning:** Security inspection
**Updates:** Regular maintenance
**Secrets:** Safe for valuables
**Read-only:** Locked rooms
**Resource limits:** Security guards
**Network isolation:** Gated communities

**Once you see it this way, container security makes perfect sense.**

## Real-World Security Checklist

**Production security checklist:**

**Image Security:**
- [ ] Use minimal base images (Alpine, Distroless)
- [ ] Scan images for vulnerabilities
- [ ] Keep base images updated
- [ ] Use specific image tags
- [ ] No secrets in images

**Container Security:**
- [ ] Run as non-root user
- [ ] Read-only filesystem where possible
- [ ] Resource limits set
- [ ] Health checks configured
- [ ] Logging configured

**Runtime Security:**
- [ ] Secrets managed properly
- [ ] Network isolation
- [ ] Access control
- [ ] Monitoring enabled
- [ ] Regular updates

**Infrastructure Security:**
- [ ] Secure registry
- [ ] Authentication required
- [ ] Network policies
- [ ] Host security
- [ ] Compliance met

## My Take: Security Strategy

**Here's my security approach:**

**Development:**
- Basic security (non-root, minimal images)
- Scan before committing
- No secrets in code

**Staging:**
- Full security checklist
- Regular scanning
- Security testing

**Production:**
- All security measures
- Continuous scanning
- Security monitoring
- Incident response plan

**The key:** Security is layered. Start with basics. Add more for production. Never skip security.

## Memory Tip: The Home Security Analogy

**Container security = Home security**

**Minimal images:** Small house
**Non-root:** Limited keys
**Scanning:** Inspection
**Updates:** Maintenance
**Secrets:** Safe
**Read-only:** Locked rooms
**Limits:** Guards
**Isolation:** Gates

**Once you see it this way, security makes perfect sense.**

## Common Mistakes

1. **Running as root**: Major security risk
2. **Secrets in images**: Visible to anyone
3. **Not scanning**: Unknown vulnerabilities
4. **Using `latest` tags**: Unpredictable
5. **No resource limits**: DoS vulnerability

## Hands-On Exercise: Secure a Container

**1. Create secure Dockerfile:**
```dockerfile
FROM node:18-alpine

# Create non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

WORKDIR /app

# Copy and set ownership
COPY --chown=nodejs:nodejs package*.json ./
RUN npm ci --only=production

COPY --chown=nodejs:nodejs . .

# Switch to non-root
USER nodejs

EXPOSE 3000
CMD ["node", "server.js"]
```

**2. Build image:**
```bash
docker build -t secure-app:1.0 .
```

**3. Scan image:**
```bash
docker scout cves secure-app:1.0
```

**4. Run securely:**
```bash
docker run -d \
  --name secure-app \
  --read-only \
  --tmpfs /tmp \
  --tmpfs /var/run \
  --user 1001:1001 \
  --memory=512m \
  --cpus="1.0" \
  secure-app:1.0
```

**5. Verify security:**
```bash
docker exec secure-app whoami
# Should show: nodejs (not root)

docker exec secure-app touch /test
# Should fail: read-only filesystem
```

## Key Takeaways

1. **Security is essential** - Not optional
2. **Use minimal images** - Smaller attack surface
3. **Run as non-root** - Limit damage
4. **Scan regularly** - Find vulnerabilities
5. **Manage secrets properly** - Never in images
6. **Use read-only filesystems** - Immutable containers
7. **Set resource limits** - Prevent DoS
8. **Isolate networks** - Defense in depth

## What's Next?

Now that you understand container security, let's learn about image scanning. Next: [Image Scanning](/docs/docker/08-security/image-scanning).

---

> **Remember**: Container security is like home security. Multiple layers. Defense in depth. Essential for production. Never skip it.

