---
sidebar_position: 4
title: Security Best Practices
---

# Security Best Practices: The Complete Checklist

**Security isn't one thing. It's many things. Layers. Practices. Habits. This is the complete checklist. Follow it. Your containers will be secure.**

## 🎯 The Big Picture

Think of security best practices like a security system. Multiple components. All working together. Doors locked (non-root). Alarms set (scanning). Cameras on (monitoring). That's security best practices.

**Security best practices are proven. Tested. Essential. Follow them. Your containers will be secure.**

## The Complete Security Checklist

### Image Security

**✅ Use minimal base images**
```dockerfile
FROM alpine:latest  # Not ubuntu:20.04
```

**✅ Use specific image tags**
```dockerfile
FROM node:18-alpine  # Not node:latest
```

**✅ Scan images regularly**
```bash
docker scout cves my-app:1.0
```

**✅ Keep base images updated**
```bash
docker pull node:18-alpine  # Get latest
```

**✅ Use distroless when possible**
```dockerfile
FROM gcr.io/distroless/nodejs:18
```

**✅ Remove unnecessary packages**
```dockerfile
RUN apk del .build-deps  # Remove build tools
```

### Container Security

**✅ Run as non-root user**
```dockerfile
USER nodejs  # Not root
```

**✅ Use read-only filesystem**
```yaml
read_only: true
tmpfs:
  - /tmp
```

**✅ Set resource limits**
```yaml
deploy:
  resources:
    limits:
      memory: 512M
      cpus: '1.0'
```

**✅ Remove capabilities**
```yaml
cap_drop:
  - ALL
cap_add:
  - NET_BIND_SERVICE  # Only what's needed
```

**✅ Use no-new-privileges**
```yaml
security_opt:
  - no-new-privileges:true
```

### Secrets Security

**✅ Never commit secrets**
```
# .gitignore
.env
secrets/
*.key
*.pem
```

**✅ Use secrets managers**
```yaml
secrets:
  - db_password
```

**✅ Rotate secrets regularly**
- Monthly for passwords
- Quarterly for keys
- Immediately if compromised

**✅ Use least privilege**
- Only necessary access
- Time-limited
- Scope-limited

**✅ Encrypt secrets at rest**
- Encrypted files
- Encrypted volumes
- Key management

### Network Security

**✅ Isolate networks**
```yaml
networks:
  backend:
    internal: true  # No external access
```

**✅ Use network policies**
- Limit communication
- Allow only needed
- Deny by default

**✅ Don't expose unnecessary ports**
```yaml
# Only expose what's needed
ports:
  - "80:80"  # Not all ports
```

**✅ Use TLS/SSL**
- Encrypt traffic
- Valid certificates
- Strong ciphers

### Runtime Security

**✅ Enable logging**
```yaml
logging:
  driver: "json-file"
  options:
    max-size: "10m"
    max-file: "3"
```

**✅ Monitor containers**
- Resource usage
- Network traffic
- Anomaly detection

**✅ Set health checks**
```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost/health"]
  interval: 30s
```

**✅ Use restart policies**
```yaml
restart: unless-stopped
```

**✅ Limit container communication**
- Only necessary services
- Network isolation
- Service mesh for advanced

### Build Security

**✅ Use multi-stage builds**
```dockerfile
# Build stage
FROM node:18 AS builder
# ... build

# Runtime stage
FROM node:18-alpine
COPY --from=builder /app/dist ./dist
```

**✅ Don't include secrets in build**
```dockerfile
# BAD
ENV API_KEY=secret

# GOOD
# Pass at runtime
```

**✅ Use .dockerignore**
```
node_modules
.git
.env
*.key
```

**✅ Scan during build**
```bash
docker build -t my-app:1.0 .
docker scout cves my-app:1.0
```

**✅ Sign images**
```bash
docker trust sign my-app:1.0
```

### Registry Security

**✅ Use private registries**
- For proprietary code
- For internal apps
- For sensitive data

**✅ Require authentication**
```bash
docker login registry.example.com
```

**✅ Use HTTPS**
- Encrypted connections
- Valid certificates
- No HTTP

**✅ Scan registry images**
- Regular scanning
- Vulnerability alerts
- Update notifications

**✅ Limit access**
- Only needed teams
- Review regularly
- Remove unused access

## The Security System Analogy

**Think of security best practices like a security system:**

**Image security:** Strong foundation (minimal, updated)
**Container security:** Locked doors (non-root, read-only)
**Secrets security:** Vault (secure storage)
**Network security:** Fences (isolation)
**Runtime security:** Alarms (monitoring)
**Build security:** Quality control (scanning)
**Registry security:** Access control (authentication)

**Once you see it this way, security best practices make perfect sense.**

## Real-World Example: Secure Production Setup

**Complete secure setup:**

```yaml
services:
  app:
    build:
      context: .
      dockerfile: Dockerfile.prod
    image: registry.example.com/my-app:1.0.0
    
    # Container security
    user: "1001:1001"  # Non-root
    read_only: true
    tmpfs:
      - /tmp
      - /var/run
    
    # Resource limits
    deploy:
      resources:
        limits:
          cpus: '1.0'
          memory: 512M
        reservations:
          cpus: '0.5'
          memory: 256M
    
    # Security options
    security_opt:
      - no-new-privileges:true
    cap_drop:
      - ALL
    cap_add:
      - NET_BIND_SERVICE
    
    # Secrets
    secrets:
      - db_password
      - api_key
    
    # Network isolation
    networks:
      - backend
    
    # Health check
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
    
    # Logging
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
    
    # Restart policy
    restart: unless-stopped

secrets:
  db_password:
    file: ./secrets/db_password.txt
  api_key:
    file: ./secrets/api_key.txt

networks:
  backend:
    driver: bridge
    internal: true  # No external access
```

**What this includes:**
- Non-root user
- Read-only filesystem
- Resource limits
- Dropped capabilities
- Secrets management
- Network isolation
- Health checks
- Logging
- Restart policy

**Complete security. Production-ready.**

## Security Maturity Levels

### Level 1: Basic Security

**Minimum requirements:**
- Non-root user
- Specific image tags
- Basic scanning
- No secrets in code

**Good for:** Development, learning

### Level 2: Standard Security

**Add:**
- Read-only filesystem
- Resource limits
- Network isolation
- Secrets management
- Regular scanning

**Good for:** Staging, internal apps

### Level 3: Advanced Security

**Add:**
- Capability dropping
- Image signing
- Advanced monitoring
- Automated scanning
- Compliance checks

**Good for:** Production, compliance

### Level 4: Enterprise Security

**Add:**
- Full audit logging
- Advanced threat detection
- Compliance automation
- Security policies
- Incident response

**Good for:** Enterprise, regulated industries

## My Take: Security Strategy

**Here's my security approach:**

**Start with basics:**
- Non-root user
- Specific tags
- No secrets in code
- Basic scanning

**Add for staging:**
- Read-only filesystem
- Resource limits
- Network isolation
- Secrets management

**Add for production:**
- All security measures
- Advanced scanning
- Monitoring
- Compliance

**The key:** Start simple. Add layers. Never skip basics. Security is cumulative.

## Memory Tip: The Security System Analogy

**Security best practices = Security system**

**Image:** Foundation
**Container:** Doors
**Secrets:** Vault
**Network:** Fences
**Runtime:** Alarms
**Build:** Quality control
**Registry:** Access control

**Once you see it this way, security makes perfect sense.**

## Common Mistakes

1. **Skipping basics**: Non-root, specific tags
2. **Secrets in code**: Visible forever
3. **Not scanning**: Unknown vulnerabilities
4. **No resource limits**: DoS vulnerability
5. **Too much access**: Security risk

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

# Drop capabilities (if needed)
# Not available in Dockerfile, set in Compose

EXPOSE 3000
CMD ["node", "server.js"]
```

**2. Build securely:**
```bash
docker build -t secure-app:1.0 .
```

**3. Scan:**
```bash
docker scout cves secure-app:1.0
```

**4. Run securely:**
```bash
docker run -d \
  --name secure-app \
  --user 1001:1001 \
  --read-only \
  --tmpfs /tmp \
  --tmpfs /var/run \
  --memory=512m \
  --cpus="1.0" \
  --cap-drop ALL \
  --cap-add NET_BIND_SERVICE \
  --security-opt no-new-privileges:true \
  secure-app:1.0
```

**5. Verify security:**
```bash
# Check user
docker exec secure-app whoami
# Should show: nodejs

# Check read-only
docker exec secure-app touch /test
# Should fail

# Check capabilities
docker inspect secure-app | grep -A 10 CapAdd
# Should show limited capabilities
```

## Key Takeaways

1. **Security is layered** - Multiple practices together
2. **Start with basics** - Non-root, specific tags, no secrets in code
3. **Add layers for production** - Read-only, limits, isolation
4. **Scan regularly** - Find vulnerabilities
5. **Automate security** - CI/CD integration
6. **Monitor continuously** - Know what's happening
7. **Follow the checklist** - Proven practices work

## What's Next?

Congratulations! You've completed the Security module. Now let's learn about production deployment. Next: [Production Considerations](/docs/docker/09-production-deployment/production-considerations).

---

> **Remember**: Security best practices are like a security system. Multiple components. All working together. Follow the checklist. Your containers will be secure.

