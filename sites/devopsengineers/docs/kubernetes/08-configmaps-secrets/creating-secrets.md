---
sidebar_position: 4
title: Creating Secrets
---

# Creating Secrets: Setting Up the Hotel Safe

**Creating Secrets is like setting up hotel safe. Define sensitive data. Create safe. Secure storage. That's creating Secrets.**

## 🎯 The Big Picture

Think of creating Secrets like setting up hotel safe. Define what to store (sensitive data). Create safe (Secret). Secure storage (encrypted). That's creating Secrets.

**Creating Secrets stores sensitive data securely. Multiple methods. YAML. kubectl. Files. All work. Choose what fits.**

## The Hotel Safe Setup Analogy

**Think of creating Secrets like setting up hotel safe:**

**Define data:** What to store
- Sensitive information
- Passwords, keys
- Secure data

**Create Secret:** Create safe
- YAML or kubectl
- Store securely
- Encrypted

**Mount to pods:** Make available to rooms
- Environment variables
- Volume mounts
- Secure access

**Once you see it this way, creating Secrets makes perfect sense.**

## Method 1: From Literal Values

**Create from command line:**
```bash
kubectl create secret generic hotel-safe \
  --from-literal=db-password="secret-password" \
  --from-literal=api-key="secret-key" \
  --from-literal=jwt-secret="jwt-secret-key"
```

**What this does:**
- Creates Secret
- Stores sensitive data
- Base64 encoded automatically

**Think of it as:** Store in safe. Direct. Secure.

**Verify:**
```bash
kubectl get secret hotel-safe
kubectl describe secret hotel-safe
```

**Note:** Values are hidden in describe output.

## Method 2: From Files

**Create from file:**
```bash
# Create secret file
echo -n "secret-password" > db-password.txt
echo -n "secret-key" > api-key.txt

# Create Secret
kubectl create secret generic hotel-safe \
  --from-file=db-password=db-password.txt \
  --from-file=api-key=api-key.txt
```

**What this does:**
- Creates Secret from files
- File content as value
- Key is filename or specified

**Think of it as:** Store files in safe. From files. Secure.

**Clean up files:**
```bash
rm db-password.txt api-key.txt
```

## Method 3: From YAML

**Create from YAML:**
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: hotel-safe
  namespace: default
type: Opaque
data:
  db-password: c2VjcmV0LXBhc3N3b3Jk  # base64: secret-password
  api-key: c2VjcmV0LWtleQ==  # base64: secret-key
```

**Encode values:**
```bash
echo -n "secret-password" | base64
# Output: c2VjcmV0LXBhc3N3b3Jk
```

**Or use stringData:**
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: hotel-safe
type: Opaque
stringData:
  db-password: secret-password  # Automatically encoded
  api-key: secret-key  # Automatically encoded
```

**Think of it as:** Store in safe. YAML. Base64 or stringData.

**Create:**
```bash
kubectl apply -f secret.yaml
```

## Docker Registry Secret

**Create for image pull:**
```bash
kubectl create secret docker-registry regcred \
  --docker-server=registry.example.com \
  --docker-username=user \
  --docker-password=password \
  --docker-email=user@example.com
```

**What this does:**
- Creates registry secret
- For image pulling
- Private registry access

**Think of it as:** Registry access card. Store in safe. Use for pulling.

## TLS Secret

**Create for TLS:**
```bash
kubectl create secret tls hotel-tls \
  --cert=tls.crt \
  --key=tls.key
```

**What this does:**
- Creates TLS secret
- For SSL/TLS
- Certificate storage

**Think of it as:** Certificate safe. Store certificates. Use for TLS.

## Complete Example: Production Secret

**Production-ready Secret:**
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: production-secrets
  namespace: production
  labels:
    app: hotel-app
    env: production
type: Opaque
stringData:
  # Automatically base64 encoded
  db-password: "production-db-password"
  db-url: "postgres://user:pass@db:5432/hotel_db"
  api-key: "production-api-key"
  jwt-secret: "production-jwt-secret"
  redis-password: "production-redis-password"
```

**That's a complete Secret. Production-ready. Secure.**

## Real-World Example: Complete Creation

**Step 1: Create YAML:**
```yaml
# secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
type: Opaque
stringData:
  db-password: secret-password
  api-key: secret-key
```

**Step 2: Create Secret:**
```bash
kubectl apply -f secret.yaml
```

**Step 3: Verify:**
```bash
kubectl get secret app-secrets
kubectl describe secret app-secrets
```

**Step 4: Use in pod:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: app
spec:
  containers:
  - name: app
    image: hotel-app:1.0
    env:
    - name: DB_PASSWORD
      valueFrom:
        secretKeyRef:
          name: app-secrets
          key: db-password
```

**Step 5: Verify in pod:**
```bash
kubectl exec app -- env | grep DB_PASSWORD
```

**That's complete creation. Secret working.**

## Best Practices

### Use stringData in YAML

**Why:**
- Easier to read
- Automatic encoding
- No manual base64

**Don't:**
- Manually encode in data
- Hard to maintain
- Error-prone

### Never Commit Secrets

**Always:**
- Use .gitignore
- Never commit
- Use secret managers

**Don't:**
- Commit to git
- Store in ConfigMaps
- Hardcode

### Rotate Regularly

**Why:**
- Security best practice
- Limit exposure
- Compliance

**Rotate:**
- Monthly for passwords
- Quarterly for keys
- Immediately if compromised

## My Take: Secret Creation Strategy

**Here's what I do:**

**Development:**
- Use kubectl create
- Quick testing
- Simple secrets

**Production:**
- Use YAML with stringData
- Version controlled (encrypted)
- Complete definitions
- Use secret managers

**The key:** Use YAML for production. stringData for ease. Never commit. Rotate regularly.

## Memory Tip: The Hotel Safe Setup Analogy

**Creating Secrets = Setting up hotel safe**

**Define data:** What to store
**Create Secret:** Create safe
**Mount to pods:** Secure access

**Once you see it this way, creating Secrets makes perfect sense.**

## Common Mistakes

1. **Committing to git**: Visible forever
2. **Using ConfigMaps**: Security risk
3. **Not rotating**: Long exposure
4. **Too much access**: Security risk
5. **Base64 confusion**: Not encryption

## Key Takeaways

1. **Multiple creation methods** - Literals, files, YAML
2. **Use stringData in YAML** - Easier, automatic encoding
3. **Never commit secrets** - Use .gitignore
4. **Rotate regularly** - Security best practice
5. **Use secret managers** - For production

## What's Next?

Now that you understand creating Secrets, let's learn about secrets best practices. Next: [Secrets Best Practices](/docs/kubernetes/08-configmaps-secrets/secrets-best-practices).

---

> **Remember**: Creating Secrets is like setting up hotel safe. Define sensitive data. Create Secret. Secure storage. Use stringData. Never commit. Rotate regularly.

