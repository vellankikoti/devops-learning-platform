---
sidebar_position: 3
title: Understanding Secrets
---

# Understanding Secrets: The Hotel Safe

**Secrets are like hotel safe. Sensitive data. Encrypted. Secure storage. That's Secrets.**

## 🎯 The Big Picture

Think of Secrets like hotel safe. Sensitive information. Encrypted storage. Secure access. That's Secrets.

**Secrets store sensitive data. Passwords. API keys. Certificates. Encrypted at rest. Base64 encoded. Essential for security.**

## The Hotel Safe Analogy

**Think of Secrets like hotel safe:**

**Secret:** Hotel safe
- Sensitive information
- Encrypted storage
- Secure access

**Sensitive data:** Valuables
- Passwords
- API keys
- Certificates
- Secrets

**Encryption:** Safe lock
- Encrypted at rest
- Base64 encoded
- Secure

**Once you see it this way, Secrets make perfect sense.**

## What is a Secret?

**Secret definition:**
- Sensitive data storage
- Encrypted at rest
- Base64 encoded
- Mounted to pods

**Think of it as:** Hotel safe. Sensitive. Encrypted. Secure.

## Why Secrets?

**Problems without Secrets:**
- Secrets in images
- Secrets in ConfigMaps
- Visible to all
- Security risk

**Solutions with Secrets:**
- Secure storage
- Encrypted
- Access control
- Secure

**Real example:** I once put passwords in ConfigMaps. Visible to all. Security risk. With Secrets, encrypted. Secure. Never going back.

**Secrets aren't optional. They're essential.**

## Secret Types

**Common types:**

**Opaque (default):**
- Generic secrets
- User-defined
- Most common

**kubernetes.io/dockerconfigjson:**
- Docker registry credentials
- Image pull secrets
- Registry access

**kubernetes.io/tls:**
- TLS certificates
- SSL/TLS secrets
- Certificate storage

**kubernetes.io/service-account-token:**
- Service account tokens
- Automatic
- System managed

**Think of it as:** Different safe types. Different purposes. Different security.

## Creating Secrets

### From Literal Values

**Create from literals:**
```bash
kubectl create secret generic hotel-safe \
  --from-literal=db-password="secret-password" \
  --from-literal=api-key="secret-key"
```

**Think of it as:** Store in safe. Direct. Simple.

### From Files

**Create from file:**
```bash
# Create secret file
echo -n "secret-password" > db-password.txt

# Create Secret
kubectl create secret generic hotel-safe \
  --from-file=db-password=db-password.txt
```

**Think of it as:** Store file in safe. From file. Secure.

### From YAML

**Create from YAML:**
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: hotel-safe
type: Opaque
data:
  db-password: c2VjcmV0LXBhc3N3b3Jk  # base64 encoded
  api-key: c2VjcmV0LWtleQ==  # base64 encoded
```

**Note:** Values must be base64 encoded.

**Encode:**
```bash
echo -n "secret-password" | base64
# Output: c2VjcmV0LXBhc3N3b3Jk
```

**Think of it as:** Store in safe. Base64 encoded. Secure.

## Using Secrets

### As Environment Variables

**Inject as env vars:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: hotel-app
spec:
  containers:
  - name: app
    image: hotel-app:1.0
    env:
    - name: DB_PASSWORD
      valueFrom:
        secretKeyRef:
          name: hotel-safe
          key: db-password
```

**Think of it as:** Read from safe. Use as environment. Secure.

### As Volume Mount

**Mount as files:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: hotel-app
spec:
  containers:
  - name: app
    image: hotel-app:1.0
    volumeMounts:
    - name: secrets
      mountPath: /app/secrets
      readOnly: true
  volumes:
  - name: secrets
    secret:
      secretName: hotel-safe
```

**Think of it as:** Copy from safe to room. Mount as files. Read-only.

## Real-World Example: Complete Secret

**Production-ready Secret:**
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: production-secrets
  namespace: production
type: Opaque
data:
  db-password: <base64-encoded>
  api-key: <base64-encoded>
  jwt-secret: <base64-encoded>
stringData:
  # Automatically base64 encoded
  db-url: "postgres://user:pass@db:5432/mydb"
```

**Using stringData:**
- Automatically encoded
- Easier to use
- No manual encoding

**That's a complete Secret. Production-ready.**

## My Take: Secret Strategy

**Here's what I do:**

**Always:**
- Use Secrets for sensitive data
- Encrypt at rest
- Limit access (RBAC)
- Rotate regularly

**Never:**
- Store in ConfigMaps
- Store in images
- Commit to git
- Hardcode

**The key:** Use Secrets. Always. Secure. Rotate. Essential.

## Memory Tip: The Hotel Safe Analogy

**Secrets = Hotel safe**

**Secret:** Safe
**Sensitive data:** Valuables
**Encryption:** Safe lock
**Access:** Controlled

**Once you see it this way, Secrets make perfect sense.**

## Common Mistakes

1. **Storing in ConfigMaps**: Security risk
2. **Base64 is not encryption**: Still need encryption
3. **Not rotating**: Long exposure
4. **Too much access**: Security risk
5. **Committing to git**: Visible forever

## Key Takeaways

1. **Secrets store sensitive data** - Passwords, keys, certificates
2. **Encrypted at rest** - Secure storage
3. **Base64 encoded** - Not encryption, just encoding
4. **Use RBAC** - Limit access
5. **Rotate regularly** - Security best practice

## What's Next?

Now that you understand Secrets, let's learn about creating and using them. Next: [Creating Secrets](/docs/kubernetes/08-configmaps-secrets/creating-secrets).

---

> **Remember**: Secrets are like hotel safe. Sensitive data. Encrypted. Secure. Use for passwords, keys, certificates. Never in ConfigMaps. Rotate regularly.

