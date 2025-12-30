---
sidebar_position: 1
title: Understanding ConfigMaps
---

# Understanding ConfigMaps: The Hotel Information Board

**ConfigMaps are like hotel information board. Configuration data. Public information. Non-sensitive. That's ConfigMaps.**

## 🎯 The Big Picture

Think of ConfigMaps like hotel information board. Public information. Configuration. Available to all. Non-sensitive. That's ConfigMaps.

**ConfigMaps store configuration data. Key-value pairs. Non-sensitive. Mounted as files or environment variables. Essential for configuration management.**

## The Hotel Information Board Analogy

**Think of ConfigMaps like hotel information board:**

**ConfigMap:** Information board
- Public information
- Configuration data
- Available to all

**Key-value pairs:** Information items
- Hotel name
- Check-in time
- Policies
- Configuration

**Non-sensitive:** Public information
- Not secret
- Can be public
- No encryption

**Once you see it this way, ConfigMaps make perfect sense.**

## What is a ConfigMap?

**ConfigMap definition:**
- Configuration data
- Key-value pairs
- Non-sensitive
- Mounted to pods

**Think of it as:** Information board. Configuration. Public.

## Why ConfigMaps?

**Problems without ConfigMaps:**
- Configuration in images
- Hard to change
- Not flexible
- Rebuild needed

**Solutions with ConfigMaps:**
- Configuration separate
- Easy to change
- Flexible
- No rebuild

**Real example:** I once put configuration in images. Change config? Rebuild image. With ConfigMaps, change config. No rebuild. Never going back.

**ConfigMaps aren't optional. They're essential.**

## Creating ConfigMaps

### From Literal Values

**Create from literals:**
```bash
kubectl create configmap hotel-info \
  --from-literal=hotel-name="Luxury Hotel" \
  --from-literal=check-in-time="3:00 PM" \
  --from-literal=max-guests="100"
```

**Think of it as:** Write on board. Direct. Simple.

### From File

**Create from file:**
```bash
# config.properties
hotel.name=Luxury Hotel
check.in.time=3:00 PM
max.guests=100

kubectl create configmap hotel-info --from-file=config.properties
```

**Think of it as:** Post file on board. From file. Organized.

### From YAML

**Create from YAML:**
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: hotel-info
  namespace: default
data:
  hotel-name: "Luxury Hotel"
  check-in-time: "3:00 PM"
  max-guests: "100"
  config.properties: |
    hotel.name=Luxury Hotel
    check.in.time=3:00 PM
    max.guests=100
```

**Think of it as:** Complete board. YAML. Structured.

## Using ConfigMaps

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
    - name: HOTEL_NAME
      valueFrom:
        configMapKeyRef:
          name: hotel-info
          key: hotel-name
    - name: CHECK_IN_TIME
      valueFrom:
        configMapKeyRef:
          name: hotel-info
          key: check-in-time
```

**Think of it as:** Read from board. Use as environment. Available.

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
    - name: config
      mountPath: /app/config
      readOnly: true
  volumes:
  - name: config
    configMap:
      name: hotel-info
```

**Think of it as:** Copy board to room. Mount as files. Read-only.

## Real-World Example: Complete ConfigMap

**Step 1: Create ConfigMap:**
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  app.properties: |
    server.port=8080
    database.host=db-service
    database.port=5432
    log.level=info
  nginx.conf: |
    server {
      listen 80;
      server_name hotel.example.com;
      location / {
        proxy_pass http://app:8080;
      }
    }
```

**Step 2: Use in Pod:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: app
spec:
  containers:
  - name: app
    image: hotel-app:1.0
    volumeMounts:
    - name: config
      mountPath: /app/config
  volumes:
  - name: config
    configMap:
      name: app-config
```

**Step 3: Verify:**
```bash
kubectl exec app -- cat /app/config/app.properties
```

**That's complete ConfigMap. Working.**

## My Take: ConfigMap Strategy

**Here's what I do:**

**Use ConfigMaps for:**
- Configuration files
- Environment variables
- Non-sensitive data
- Application config

**Never use for:**
- Passwords
- API keys
- Secrets
- Sensitive data

**The key:** Use ConfigMaps for config. Secrets for sensitive. Right tool.

## Memory Tip: The Hotel Information Board Analogy

**ConfigMaps = Hotel information board**

**ConfigMap:** Information board
**Key-value pairs:** Information items
**Non-sensitive:** Public information
**Mounted:** Available to pods

**Once you see it this way, ConfigMaps make perfect sense.**

## Common Mistakes

1. **Storing secrets**: Security risk
2. **Not using ConfigMaps**: Configuration in images
3. **Wrong mounting**: Can't access config
4. **Not updating**: Stale configuration
5. **Too large**: ConfigMap size limits

## Key Takeaways

1. **ConfigMaps store configuration** - Non-sensitive data
2. **Key-value pairs** - Simple structure
3. **Mount as files or env vars** - Flexible usage
4. **Never store secrets** - Use Secrets instead
5. **Essential for configuration** - Separate from images

## What's Next?

Now that you understand ConfigMaps, let's learn about creating and using them. Next: [Creating ConfigMaps](/docs/kubernetes/08-configmaps-secrets/creating-configmaps).

---

> **Remember**: ConfigMaps are like hotel information board. Configuration data. Non-sensitive. Mount as files or env vars. Never store secrets. Essential for configuration.

