---
sidebar_position: 2
title: Creating ConfigMaps
---

# Creating ConfigMaps: Setting Up the Information Board

**Creating ConfigMaps is like setting up hotel information board. Define information. Create board. Make available. That's creating ConfigMaps.**

## 🎯 The Big Picture

Think of creating ConfigMaps like setting up information board. Define what information to display (data). Create board (ConfigMap). Make available to rooms (mount to pods). That's creating ConfigMaps.

**Creating ConfigMaps defines configuration data. Multiple methods. YAML. kubectl. Files. All work. Choose what fits.**

## The Information Board Setup Analogy

**Think of creating ConfigMaps like setting up information board:**

**Define data:** What to display
- Information items
- Configuration
- Data

**Create ConfigMap:** Create board
- YAML or kubectl
- Store data
- Make available

**Mount to pods:** Make available to rooms
- Environment variables
- Volume mounts
- Accessible

**Once you see it this way, creating ConfigMaps makes perfect sense.**

## Method 1: From Literal Values

**Create from command line:**
```bash
kubectl create configmap hotel-info \
  --from-literal=hotel-name="Luxury Hotel" \
  --from-literal=check-in-time="3:00 PM" \
  --from-literal=max-guests="100" \
  --from-literal=wifi-password="public-wifi"
```

**What this does:**
- Creates ConfigMap
- Stores key-value pairs
- Available immediately

**Think of it as:** Write on board. Direct. Quick.

**Verify:**
```bash
kubectl get configmap hotel-info
kubectl describe configmap hotel-info
```

## Method 2: From Files

**Create from file:**
```bash
# Create config file
cat > app.properties <<EOF
server.port=8080
database.host=db-service
database.port=5432
log.level=info
EOF

# Create ConfigMap
kubectl create configmap app-config --from-file=app.properties
```

**What this does:**
- Creates ConfigMap from file
- File content as value
- Key is filename

**Think of it as:** Post file on board. From file. Organized.

**Multiple files:**
```bash
kubectl create configmap app-config \
  --from-file=app.properties \
  --from-file=nginx.conf
```

## Method 3: From Directory

**Create from directory:**
```bash
# Create directory with files
mkdir config
echo "port=8080" > config/server.properties
echo "host=localhost" > config/db.properties

# Create ConfigMap
kubectl create configmap app-config --from-file=config/
```

**What this does:**
- Creates ConfigMap from directory
- All files included
- Filenames as keys

**Think of it as:** Post directory on board. All files. Organized.

## Method 4: From YAML

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

**What this does:**
- Complete ConfigMap definition
- Version controlled
- Production-ready

**Think of it as:** Complete board design. YAML. Structured.

**Create:**
```bash
kubectl apply -f configmap.yaml
```

## Complete Example: Production ConfigMap

**Production-ready ConfigMap:**
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: production-config
  namespace: production
  labels:
    app: hotel-app
    env: production
data:
  # Application configuration
  app.properties: |
    server.port=8080
    server.host=0.0.0.0
    database.host=db-service.production
    database.port=5432
    database.name=hotel_db
    log.level=info
    log.format=json
  
  # Nginx configuration
  nginx.conf: |
    server {
      listen 80;
      server_name hotel.example.com;
      
      location / {
        proxy_pass http://app:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
      }
      
      location /health {
        access_log off;
        proxy_pass http://app:8080/health;
      }
    }
  
  # Feature flags
  features.properties: |
    feature.new-ui.enabled=true
    feature.payment.enabled=true
    feature.analytics.enabled=false
```

**That's a complete ConfigMap. Production-ready. Comprehensive.**

## Real-World Example: Complete Creation

**Step 1: Create YAML:**
```yaml
# configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  app.properties: |
    port=8080
    host=0.0.0.0
```

**Step 2: Create ConfigMap:**
```bash
kubectl apply -f configmap.yaml
```

**Step 3: Verify:**
```bash
kubectl get configmap app-config
kubectl describe configmap app-config
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
    volumeMounts:
    - name: config
      mountPath: /app/config
  volumes:
  - name: config
    configMap:
      name: app-config
```

**Step 5: Verify in pod:**
```bash
kubectl exec app -- cat /app/config/app.properties
```

**That's complete creation. ConfigMap working.**

## Best Practices

### Use YAML Files

**Why:**
- Version controlled
- Reproducible
- Production-ready

**Don't:**
- Use imperative commands in production
- Create without YAML
- Skip version control

### Organize Data

**Structure:**
- Group related data
- Use meaningful keys
- Document purpose

**Think of it as:** Organize board. Group information. Clear.

### Keep Non-Sensitive

**Never:**
- Store passwords
- Store API keys
- Store secrets

**Use Secrets:**
- For sensitive data
- Encrypted
- Secure

## My Take: ConfigMap Creation Strategy

**Here's what I do:**

**Development:**
- Use kubectl create
- Quick testing
- Simple configs

**Production:**
- Use YAML files
- Version controlled
- Complete definitions

**The key:** Use YAML for production. kubectl for testing. Right tool.

## Memory Tip: The Information Board Setup Analogy

**Creating ConfigMaps = Setting up information board**

**Define data:** What to display
**Create ConfigMap:** Create board
**Mount to pods:** Make available

**Once you see it this way, creating ConfigMaps makes perfect sense.**

## Common Mistakes

1. **Using imperative in production**: Not version controlled
2. **Storing secrets**: Security risk
3. **Not organizing data**: Hard to manage
4. **Too large ConfigMaps**: Size limits
5. **Not documenting**: Hard to understand

## Key Takeaways

1. **Multiple creation methods** - Literals, files, YAML
2. **Use YAML for production** - Version controlled
3. **Organize data** - Group related items
4. **Never store secrets** - Use Secrets
5. **Keep it simple** - Don't over-complicate

## What's Next?

Now that you understand creating ConfigMaps, let's learn about Secrets. Next: [Understanding Secrets](/docs/kubernetes/08-configmaps-secrets/understanding-secrets).

---

> **Remember**: Creating ConfigMaps is like setting up information board. Define data. Create ConfigMap. Mount to pods. Use YAML for production. Never store secrets.

