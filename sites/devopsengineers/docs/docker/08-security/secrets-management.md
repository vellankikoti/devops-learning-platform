---
sidebar_position: 3
title: Secrets Management
---

# Secrets Management: Protecting Sensitive Data

**Secrets are everywhere. Passwords. API keys. Certificates. They need protection. Not in code. Not in images. Not in logs. That's secrets management.**

## 🎯 The Big Picture

Think of secrets management like a bank vault. You don't keep money in your wallet (code). You keep it in a vault (secrets manager). Secure. Protected. That's secrets management.

**Secrets management protects sensitive data. Keeps it secure. Makes it accessible when needed. It's essential for security.**

## What are Secrets?

**Secrets are sensitive data that must be protected:**

**Common secrets:**
- Database passwords
- API keys
- SSL certificates
- SSH keys
- OAuth tokens
- Encryption keys

**Think of it as:** Anything you don't want exposed. Anything that grants access. Anything sensitive.

## Why Secrets Management Matters

**The problem without proper management:**
- Secrets in code (visible in git)
- Secrets in images (visible in layers)
- Secrets in logs (visible to anyone)
- Secrets in environment variables (visible in processes)
- Security breaches

**The solution with proper management:**
- Secrets in secure storage
- Secrets not in code
- Secrets not in images
- Secrets not in logs
- Secure deployments

**Real example:** I once saw API keys in a Dockerfile. Committed to git. Visible to everyone. Used by attackers. Never again.

**Secrets management isn't optional. It's essential.**

## Secrets Management Methods

### Method 1: Docker Secrets (Docker Swarm)

**Use Docker secrets for Swarm:**

**Create secret:**
```bash
echo "my-secret-password" | docker secret create db_password -
```

**Use in service:**
```yaml
services:
  db:
    image: postgres:16-alpine
    secrets:
      - db_password
    environment:
      POSTGRES_PASSWORD_FILE: /run/secrets/db_password
```

**Why:** Built into Docker Swarm. Secure. Managed.

### Method 2: Docker Compose Secrets

**Use secrets in Compose:**

**Create secret file:**
```bash
echo "my-secret-password" > secrets/db_password.txt
chmod 600 secrets/db_password.txt
```

**Use in Compose:**
```yaml
services:
  db:
    image: postgres:16-alpine
    secrets:
      - db_password
    environment:
      POSTGRES_PASSWORD_FILE: /run/secrets/db_password

secrets:
  db_password:
    file: ./secrets/db_password.txt
```

**Why:** Works with Compose. File-based. Simple.

### Method 3: Environment Variables (Runtime)

**Pass secrets at runtime:**

```bash
docker run -d \
  --name app \
  -e DB_PASSWORD=$(cat secrets/db_password.txt) \
  my-app:1.0
```

**Or with Compose:**
```yaml
services:
  app:
    image: my-app:1.0
    environment:
      DB_PASSWORD: ${DB_PASSWORD}
```

**Load from .env file:**
```bash
# .env file (not in git!)
DB_PASSWORD=my-secret-password
```

**Why:** Simple. Flexible. Not in images.

### Method 4: External Secrets Managers

**Use cloud secrets managers:**

**AWS Secrets Manager:**
```bash
# Get secret
SECRET=$(aws secretsmanager get-secret-value \
  --secret-id db-password \
  --query SecretString --output text)

# Use in container
docker run -e DB_PASSWORD=$SECRET my-app
```

**HashiCorp Vault:**
```bash
# Get secret
SECRET=$(vault kv get -field=password secret/db)

# Use in container
docker run -e DB_PASSWORD=$SECRET my-app
```

**Why:** Enterprise-grade. Centralized. Auditable.

## The Bank Vault Analogy

**Think of secrets management like a bank vault:**

**Secrets in code:** Money in wallet (exposed)
**Secrets in images:** Money in pocket (visible)
**Secrets manager:** Bank vault (secure)
**Access control:** Vault access (controlled)

**Once you see it this way, secrets management makes perfect sense.**

## Best Practices

### 1. Never Commit Secrets

**Don't do this:**
```dockerfile
# BAD - Secret in Dockerfile
ENV DB_PASSWORD=my-secret-password
```

**Don't do this:**
```bash
# BAD - Secret in git
echo "DB_PASSWORD=secret" >> .env
git add .env
git commit -m "Add config"
```

**Do this:**
```bash
# GOOD - .env in .gitignore
echo ".env" >> .gitignore
echo "secrets/" >> .gitignore
```

**Why:** Secrets in git are visible. Forever. To everyone.

### 2. Use .gitignore

**Always ignore secrets:**
```
.env
.env.local
.env.*.local
secrets/
*.pem
*.key
*.crt
```

**Why:** Prevents accidental commits. Essential.

### 3. Rotate Secrets Regularly

**Change secrets periodically:**
- Monthly for passwords
- Quarterly for API keys
- Annually for certificates
- Immediately if compromised

**Why:** Limits exposure. Better security.

### 4. Use Least Privilege

**Give minimum access:**
- Only what's needed
- Time-limited access
- Scope-limited access
- Audit access

**Why:** Limits damage if compromised.

### 5. Encrypt Secrets at Rest

**Encrypt stored secrets:**
- Encrypt secret files
- Use encrypted volumes
- Use encrypted databases
- Use key management

**Why:** Defense in depth. Multiple layers.

## Real-World Example: Complete Secrets Setup

**Let me show you a complete setup:**

**1. Create secrets directory:**
```bash
mkdir -p secrets
chmod 700 secrets
```

**2. Create secret files:**
```bash
echo "db-secret-password" > secrets/db_password.txt
echo "api-key-12345" > secrets/api_key.txt
chmod 600 secrets/*.txt
```

**3. Add to .gitignore:**
```
secrets/
.env
*.key
*.pem
```

**4. Use in Compose:**
```yaml
services:
  db:
    image: postgres:16-alpine
    secrets:
      - db_password
    environment:
      POSTGRES_PASSWORD_FILE: /run/secrets/db_password

  app:
    image: my-app:1.0
    secrets:
      - db_password
      - api_key
    environment:
      DB_PASSWORD_FILE: /run/secrets/db_password
      API_KEY_FILE: /run/secrets/api_key

secrets:
  db_password:
    file: ./secrets/db_password.txt
  api_key:
    file: ./secrets/api_key.txt
```

**5. Application reads from files:**
```javascript
// Read from file, not environment
const dbPassword = fs.readFileSync(
  process.env.DB_PASSWORD_FILE, 
  'utf8'
).trim();
```

**That's a complete secrets setup. Secure. Manageable.**

## My Take: Secrets Management Strategy

**Here's what I do:**

**Development:**
- .env files (not in git)
- Local secrets directory
- Simple and works

**Staging/Production:**
- Secrets manager (Vault, AWS Secrets Manager)
- Encrypted storage
- Access control
- Audit logging

**The key:** Never commit secrets. Use secrets managers. Rotate regularly. Audit access.

## Memory Tip: The Bank Vault Analogy

**Secrets management = Bank vault**

**Secrets in code:** Wallet (exposed)
**Secrets manager:** Vault (secure)
**Access control:** Vault access
**Rotation:** Change combination

**Once you see it this way, secrets management makes perfect sense.**

## Common Mistakes

1. **Committing secrets to git**: Visible forever
2. **Secrets in Dockerfiles**: Visible in layers
3. **Secrets in logs**: Visible to anyone
4. **Not rotating secrets**: Long exposure
5. **Too much access**: Security risk

## Hands-On Exercise: Manage Secrets

**1. Create secrets directory:**
```bash
mkdir -p secrets
chmod 700 secrets
```

**2. Create secret file:**
```bash
echo "my-secret-password" > secrets/db_password.txt
chmod 600 secrets/db_password.txt
```

**3. Add to .gitignore:**
```bash
echo "secrets/" >> .gitignore
```

**4. Use in Compose:**
```yaml
services:
  app:
    image: alpine
    secrets:
      - db_password
    command: sh -c "cat /run/secrets/db_password"

secrets:
  db_password:
    file: ./secrets/db_password.txt
```

**5. Test:**
```bash
docker compose up
# Should show: my-secret-password
```

**6. Verify not in git:**
```bash
git status
# secrets/ should not appear
```

## Key Takeaways

1. **Never commit secrets** - Use .gitignore
2. **Use secrets managers** - Secure storage
3. **Rotate regularly** - Limit exposure
4. **Use least privilege** - Minimum access
5. **Encrypt at rest** - Defense in depth
6. **Audit access** - Know who accessed what

## What's Next?

Now that you understand secrets management, let's learn about security best practices. Next: [Security Best Practices](/docs/docker/08-security/security-best-practices).

---

> **Remember**: Secrets management is like a bank vault. Keep secrets secure. Never in code. Never in images. Always protected.

