---
sidebar_position: 5
title: Secrets Best Practices
---

# Secrets Best Practices: Keeping the Safe Secure

**Secrets need best practices. Like keeping hotel safe secure. Access control. Rotation. Monitoring. That's secrets best practices.**

## 🎯 The Big Picture

Think of secrets best practices like keeping hotel safe secure. Who can access (RBAC). When to change combination (rotation). Monitor access (auditing). That's secrets best practices.

**Secrets best practices ensure security. Access control. Rotation. Monitoring. Encryption. Essential for production.**

## The Hotel Safe Security Analogy

**Think of secrets best practices like hotel safe security:**

**Access control:** Who can access safe
- RBAC policies
- Limited access
- Principle of least privilege

**Rotation:** Change combination
- Regular rotation
- Limit exposure
- Security

**Monitoring:** Monitor access
- Audit logs
- Track usage
- Detect anomalies

**Once you see it this way, secrets best practices make perfect sense.**

## Access Control: RBAC

**Limit access:**

**Create Role:**
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: secret-reader
  namespace: production
rules:
- apiGroups: [""]
  resources: ["secrets"]
  resourceNames: ["app-secrets"]
  verbs: ["get", "list"]
```

**Create RoleBinding:**
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: secret-reader-binding
  namespace: production
subjects:
- kind: ServiceAccount
  name: app-service-account
  namespace: production
roleRef:
  kind: Role
  name: secret-reader
  apiGroup: rbac.authorization.k8s.io
```

**Think of it as:** Safe access control. Who can access. Limited.

## Secret Rotation

**Rotate regularly:**

**Why:**
- Limit exposure
- Security best practice
- Compliance

**When:**
- Monthly for passwords
- Quarterly for API keys
- Immediately if compromised

**How:**
```bash
# Update secret
kubectl create secret generic app-secrets \
  --from-literal=db-password="new-password" \
  --dry-run=client -o yaml | kubectl apply -f -

# Restart pods to use new secret
kubectl rollout restart deployment/app
```

**Think of it as:** Change safe combination. Regular. Security.

## Encryption at Rest

**Ensure encryption:**

**etcd encryption:**
- Enable encryption at rest
- Encrypt etcd data
- Protect secrets

**Configuration:**
```yaml
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
- resources:
  - secrets
  providers:
  - aescbc:
      keys:
      - name: key1
        secret: <base64-encoded-key>
```

**Think of it as:** Safe encryption. Encrypted storage. Secure.

## Never Commit Secrets

**Always:**
- Use .gitignore
- Never commit
- Use secret managers

**Don't:**
- Commit to git
- Store in ConfigMaps
- Hardcode in code

**Think of it as:** Never leave safe combination visible. Secure. Private.

## Use Secret Managers

**External secret managers:**

**AWS Secrets Manager:**
- Managed secrets
- Automatic rotation
- Integration

**HashiCorp Vault:**
- Secret management
- Dynamic secrets
- Advanced features

**Azure Key Vault:**
- Managed secrets
- Integration
- Secure

**Think of it as:** External safe management. Managed. Secure.

## Monitoring and Auditing

**Monitor access:**

**Enable audit logging:**
```yaml
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
- level: Metadata
  resources:
  - group: ""
    resources: ["secrets"]
```

**Monitor:**
- Secret access
- Who accessed
- When accessed
- What accessed

**Think of it as:** Safe access log. Monitor. Audit.

## Real-World Example: Complete Security

**Complete secrets security:**

**Step 1: Create Secret:**
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
type: Opaque
stringData:
  db-password: secret-password
```

**Step 2: Create RBAC:**
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: secret-reader
rules:
- apiGroups: [""]
  resources: ["secrets"]
  resourceNames: ["app-secrets"]
  verbs: ["get"]
```

**Step 3: Enable encryption:**
- Configure etcd encryption
- Encrypt at rest
- Secure storage

**Step 4: Monitor:**
- Enable audit logging
- Track access
- Monitor usage

**That's complete security. Production-ready.**

## My Take: Secrets Security Strategy

**Here's what I do:**

**Always:**
- Use RBAC
- Rotate regularly
- Enable encryption
- Monitor access
- Never commit

**Production:**
- Use secret managers
- Advanced rotation
- Full auditing
- Compliance

**The key:** Multiple layers. RBAC. Rotation. Encryption. Monitoring. Essential.

## Memory Tip: The Hotel Safe Security Analogy

**Secrets best practices = Hotel safe security**

**Access control:** Who can access
**Rotation:** Change combination
**Monitoring:** Monitor access
**Encryption:** Safe encryption

**Once you see it this way, best practices make perfect sense.**

## Common Mistakes

1. **No access control**: Everyone can access
2. **Not rotating**: Long exposure
3. **No encryption**: Unencrypted storage
4. **Committing secrets**: Visible in git
5. **No monitoring**: Don't know who accessed

## Key Takeaways

1. **Use RBAC** - Limit access
2. **Rotate regularly** - Security best practice
3. **Enable encryption** - Encrypt at rest
4. **Never commit** - Use .gitignore
5. **Monitor access** - Audit logging
6. **Use secret managers** - For production

## What's Next?

Congratulations! You've completed the ConfigMaps & Secrets module. Now let's learn about storage. Next: [Understanding Persistent Volumes](/docs/kubernetes/09-storage/understanding-persistent-volumes).

---

> **Remember**: Secrets best practices are like hotel safe security. Access control. Rotation. Monitoring. Encryption. Multiple layers. Essential for production.

