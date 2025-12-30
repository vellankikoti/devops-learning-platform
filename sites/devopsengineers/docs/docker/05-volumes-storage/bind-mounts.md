---
sidebar_position: 3
title: Bind Mounts
---

# Bind Mounts: Direct Host Directory Access

**Bind mounts are like shared folders. You mount a host directory directly into a container. What you edit on the host, you see in the container. What you edit in the container, you see on the host.**

## 🎯 The Big Picture

Think of bind mounts like a shared drive between your computer and a friend's computer. You both see the same files. You both can edit them. Changes are immediate. That's bind mounts.

**Bind mounts are perfect for development. You edit code on your computer. Container sees the changes immediately. No rebuilding. No copying. Just works.**

## What are Bind Mounts?

**Bind mounts mount a host directory directly into a container.**

**Key characteristics:**
- Direct host directory access
- Changes reflect immediately
- Good for development
- Not portable (host path dependent)
- Security considerations

**Think of it as:** A shared folder. Both host and container see the same files. Both can edit. Changes are shared.

## Using Bind Mounts

**Basic usage:**

```bash
# Mount host directory
docker run -d \
  --name web \
  -v /host/path:/container/path \
  nginx

# Or using --mount (recommended)
docker run -d \
  --name web \
  --mount type=bind,source=/host/path,target=/container/path \
  nginx
```

**Format:** `-v /host/path:/container/path`

**What it does:**
- Mounts `/host/path` to `/container/path`
- Both see the same files
- Changes are immediate
- No copying needed

**Important:** Host path must exist. Docker won't create it.

## Real-World Example: Development Workflow

**Let me show you a real development workflow:**

**1. Your code is on host:**
```
/home/user/my-app/
├── src/
├── package.json
└── Dockerfile
```

**2. Run container with bind mount:**
```bash
docker run -d \
  --name dev-server \
  -v /home/user/my-app:/app \
  -p 3000:3000 \
  node:18 \
  npm run dev
```

**3. Edit code on host:**
```bash
# Edit file on host
vim /home/user/my-app/src/index.js
```

**4. Changes are immediate:**
- Container sees changes
- Dev server reloads
- No rebuild needed
- Fast iteration

**That's the power of bind mounts. Fast development. Immediate feedback.**

## The Shared Folder Analogy

**Think of bind mounts like a shared folder:**

**Host:** Your computer
- You edit files
- You see changes
- Files are on your computer

**Container:** Friend's computer
- Sees same files
- Can edit files
- Changes reflect on your computer

**Both see the same files. Both can edit. Changes are shared. That's bind mounts.**

## Bind Mount vs Named Volume

**Key differences:**

| Aspect | Bind Mount | Named Volume |
|--------|------------|--------------|
| **Location** | Host path | Docker managed |
| **Portability** | No (path dependent) | Yes |
| **Use Case** | Development | Production |
| **Editing** | Easy (from host) | Hard (need exec) |
| **Performance** | Good | Good |
| **Security** | Lower (host access) | Higher (isolated) |

**When to use which:**
- **Development:** Bind mount (easy editing)
- **Production:** Named volume (portable, managed)

## Common Use Cases

### Use Case 1: Development Server

**Need:** Edit code. See changes. Fast iteration.

**Solution:**
```bash
docker run -d \
  --name dev \
  -v $(pwd):/app \
  -p 3000:3000 \
  node:18 npm run dev
```

**Why:** Edit code on host. Container sees changes. Fast development.

### Use Case 2: Configuration Files

**Need:** Edit config. Test changes. No rebuild.

**Solution:**
```bash
docker run -d \
  --name web \
  -v /host/config:/etc/nginx \
  nginx
```

**Why:** Edit config on host. Container uses it. Test quickly.

### Use Case 3: Log Files

**Need:** View logs on host. Analyze easily.

**Solution:**
```bash
docker run -d \
  --name app \
  -v /host/logs:/app/logs \
  my-app
```

**Why:** Logs written to host. Easy to view. Easy to analyze.

## Security Considerations

**Bind mounts have security implications:**

**1. Host file access:**
- Container can access host files
- Can modify host files
- Can read sensitive data

**2. Host path traversal:**
- Can access parent directories
- Can access sensitive paths
- Be careful with paths

**3. Best practices:**
- Use specific paths
- Don't mount root (`/`)
- Use read-only when possible
- Be careful with permissions

**Read-only bind mount:**
```bash
docker run -d \
  --name web \
  -v /host/config:/etc/nginx:ro \
  nginx
```

**`:ro` means read-only.** Container can read but not write.

## Relative Paths

**You can use relative paths:**

```bash
# Current directory
docker run -d \
  --name web \
  -v $(pwd):/app \
  nginx

# Relative to current directory
docker run -d \
  --name web \
  -v ./config:/app/config \
  nginx
```

**`$(pwd)`** - Current directory (works on Linux/macOS)

**Windows:**
```powershell
# Use %cd% or ${PWD}
docker run -d --name web -v ${PWD}:/app nginx
```

## Mount Options

**You can specify mount options:**

```bash
# Read-only
-v /host/path:/container/path:ro

# Read-write (default)
-v /host/path:/container/path:rw

# Using --mount with options
--mount type=bind,source=/host/path,target=/container/path,readonly
```

**Options:**
- `ro` / `readonly`: Read-only
- `rw`: Read-write (default)
- `bind-propagation`: How mounts propagate

## My Take: Bind Mounts in Practice

**I use bind mounts for:**
- Development servers
- Configuration testing
- Log file access
- Local development

**I don't use bind mounts for:**
- Production deployments
- Databases
- When portability matters
- Security-sensitive data

**The rule:** Development = bind mounts. Production = named volumes.

## Memory Tip: The Shared Folder Analogy

**Bind mounts = Shared folders**

**Host:** Your computer
**Container:** Friend's computer
**Files:** Shared
**Changes:** Immediate
**Portability:** No (path dependent)

**Once you see it this way, bind mounts make perfect sense.**

## Common Mistakes

1. **Using bind mounts in production**: Not portable, security issues
2. **Mounting root directory**: Security risk
3. **Not checking if path exists**: Docker won't create it
4. **Wrong path format**: Windows vs Linux differences
5. **Forgetting read-only option**: Security risk

## Hands-On Exercise: Use Bind Mounts

**1. Create directory on host:**
```bash
mkdir -p /tmp/docker-bind
echo "Hello from host" > /tmp/docker-bind/file.txt
```

**2. Run container with bind mount:**
```bash
docker run -d \
  --name test \
  -v /tmp/docker-bind:/data \
  alpine sleep 3600
```

**3. Check file in container:**
```bash
docker exec test cat /data/file.txt
# Output: Hello from host
```

**4. Edit file on host:**
```bash
echo "Hello from container" >> /tmp/docker-bind/file.txt
```

**5. Check in container:**
```bash
docker exec test cat /data/file.txt
# Output: Hello from host\nHello from container
# Changes are immediate!
```

**6. Create file in container:**
```bash
docker exec test sh -c "echo 'Created in container' > /data/container.txt"
```

**7. Check on host:**
```bash
cat /tmp/docker-bind/container.txt
# Output: Created in container
# Changes reflect on host!
```

**8. Clean up:**
```bash
docker stop test
docker rm test
rm -rf /tmp/docker-bind
```

## Key Takeaways

1. **Bind mounts mount host directories** - Direct access
2. **Changes are immediate** - No rebuild needed
3. **Good for development** - Easy editing
4. **Not portable** - Host path dependent
5. **Security considerations** - Be careful with paths
6. **Use read-only when possible** - Better security

## What's Next?

Now that you understand bind mounts, let's learn about data persistence strategies. Next: [Data Persistence](/docs/docker/05-volumes-storage/data-persistence).

---

> **Remember**: Bind mounts are like shared folders. Perfect for development. Not for production. Use them wisely.

