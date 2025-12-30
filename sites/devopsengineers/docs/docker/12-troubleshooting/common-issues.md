---
sidebar_position: 1
title: Common Issues
---

# Common Issues: Problems You'll Face and How to Fix Them

**Docker works. Until it doesn't. Problems happen. But they're fixable. That's what this is about.**

## 🎯 The Big Picture

Think of common issues like car problems. Engine won't start (container won't run). Out of gas (out of disk space). Flat tire (network issue). Common problems. Known solutions. That's common issues.

**Common issues are problems everyone faces. Known solutions. Fixable. This is your troubleshooting guide.**

## Issue 1: Container Won't Start

**Problem:**
```bash
docker run nginx
# Error: Cannot connect to the Docker daemon
```

**Solution:**
```bash
# Check if Docker is running
docker ps

# Start Docker daemon
# macOS: Open Docker Desktop
# Linux: sudo systemctl start docker
# Windows: Start Docker Desktop
```

**Why:** Docker daemon not running. Start it.

**Think of it as:** Car won't start. Check if engine is on.

## Issue 2: Out of Disk Space

**Problem:**
```bash
docker build -t my-app .
# Error: no space left on device
```

**Solution:**
```bash
# Check disk usage
docker system df

# Clean up
docker system prune -a

# Remove unused volumes
docker volume prune

# Remove unused images
docker image prune -a
```

**Why:** Disk full. Clean up unused resources.

**Think of it as:** Out of gas. Refuel (clean up).

## Issue 3: Port Already in Use

**Problem:**
```bash
docker run -p 80:80 nginx
# Error: bind: address already in use
```

**Solution:**
```bash
# Find what's using the port
# macOS/Linux
lsof -i :80

# Windows
netstat -ano | findstr :80

# Stop the process or use different port
docker run -p 8080:80 nginx
```

**Why:** Port already in use. Free it or use different port.

**Think of it as:** Parking spot taken. Find another spot.

## Issue 4: Image Pull Fails

**Problem:**
```bash
docker pull nginx
# Error: pull access denied
```

**Solution:**
```bash
# Login to registry
docker login

# Check image name
docker pull nginx:alpine

# Use public registry
docker pull docker.io/nginx:alpine
```

**Why:** Authentication issue or wrong image name.

**Think of it as:** Access denied. Check credentials.

## Issue 5: Container Exits Immediately

**Problem:**
```bash
docker run nginx
# Container exits immediately
```

**Solution:**
```bash
# Check logs
docker logs container-name

# Run interactively
docker run -it nginx sh

# Check if process is running
docker exec container-name ps aux
```

**Why:** Process exits. Check logs. Fix issue.

**Think of it as:** Car starts then stops. Check what's wrong.

## The Car Problems Analogy

**Think of common issues like car problems:**

**Container won't start:** Engine won't start
**Out of disk space:** Out of gas
**Port in use:** Parking spot taken
**Image pull fails:** Access denied
**Container exits:** Car starts then stops

**Once you see it this way, troubleshooting makes perfect sense.**

## Issue 6: Permission Denied

**Problem:**
```bash
docker run -v /data:/data nginx
# Error: permission denied
```

**Solution:**
```bash
# Fix permissions
sudo chown -R $USER:$USER /data

# Or use named volume
docker volume create data
docker run -v data:/data nginx
```

**Why:** Permission issue. Fix permissions or use volumes.

**Think of it as:** Locked door. Get key (permissions).

## Issue 7: Network Issues

**Problem:**
```bash
docker run app
# Cannot connect to database
```

**Solution:**
```bash
# Check network
docker network ls

# Connect to same network
docker network create app-network
docker run --network app-network app
docker run --network app-network db

# Use service names
# app can connect to db using hostname "db"
```

**Why:** Containers not on same network. Connect them.

**Think of it as:** Can't call friend. Check if on same network.

## Issue 8: Build Fails

**Problem:**
```bash
docker build -t my-app .
# Error: failed to solve
```

**Solution:**
```bash
# Check Dockerfile syntax
docker build --no-cache -t my-app .

# Check build context
docker build -f Dockerfile -t my-app .

# Check logs
docker build --progress=plain -t my-app .
```

**Why:** Dockerfile issue or build context problem.

**Think of it as:** Recipe wrong. Check recipe (Dockerfile).

## Real-World Example: Complete Troubleshooting

**Problem:** Container keeps restarting

**Step 1: Check status**
```bash
docker ps -a
# See container status
```

**Step 2: Check logs**
```bash
docker logs container-name
# See error messages
```

**Step 3: Check health**
```bash
docker inspect container-name | grep Health
# See health status
```

**Step 4: Fix issue**
```bash
# Based on logs, fix the problem
# Common fixes:
# - Fix application code
# - Fix environment variables
# - Fix volume mounts
# - Fix network configuration
```

**Step 5: Restart**
```bash
docker restart container-name
# Or rebuild and run
```

**That's troubleshooting. Systematic. Effective.**

## Best Practices

### 1. Check Logs First

**Always check logs:**
```bash
docker logs container-name
```

**Why:** Logs show the problem.

### 2. Use docker inspect

**Inspect everything:**
```bash
docker inspect container-name
docker inspect image-name
docker inspect network-name
```

**Why:** See configuration. Find issues.

### 3. Test Incrementally

**Test step by step:**
- Test image
- Test container
- Test network
- Test volumes

**Why:** Isolate the problem.

### 4. Use docker exec

**Debug running containers:**
```bash
docker exec -it container-name sh
```

**Why:** See what's happening inside.

### 5. Clean Up Regularly

**Prevent issues:**
```bash
docker system prune -a
```

**Why:** Prevent disk space issues.

## My Take: Troubleshooting Strategy

**Here's what I do:**

**When problem occurs:**
1. Check logs
2. Inspect container
3. Check resources
4. Test incrementally
5. Fix and verify

**Prevention:**
- Clean up regularly
- Monitor resources
- Use health checks
- Document issues

**The key:** Systematic approach. Check logs. Inspect. Test. Fix.

## Memory Tip: The Car Problems Analogy

**Common issues = Car problems**

**Container won't start:** Engine won't start
**Out of space:** Out of gas
**Port in use:** Spot taken
**Permission denied:** Locked door

**Once you see it this way, troubleshooting makes perfect sense.**

## Common Mistakes

1. **Not checking logs**: Don't know the problem
2. **Not inspecting**: Don't see configuration
3. **Giving up too soon**: Problems are fixable
4. **Not cleaning up**: Disk space issues
5. **Not documenting**: Repeat same mistakes

## Hands-On Exercise: Troubleshoot

**1. Create a problem:**
```bash
# Run container with wrong port
docker run -p 9999:80 nginx
```

**2. Check if it works:**
```bash
curl http://localhost:9999
```

**3. Create another problem:**
```bash
# Run container that exits
docker run alpine
```

**4. Check why:**
```bash
docker ps -a
docker logs <container-id>
```

**5. Fix it:**
```bash
# Run with command
docker run alpine sleep 60
```

**That's troubleshooting. Practice. Learn.**

## Key Takeaways

1. **Check logs first** - Logs show the problem
2. **Use docker inspect** - See configuration
3. **Test incrementally** - Isolate the problem
4. **Use docker exec** - Debug inside container
5. **Clean up regularly** - Prevent issues
6. **Most problems are fixable** - Don't give up

## What's Next?

Now that you understand common issues, let's learn about debugging techniques. Next: [Debugging Techniques](/docs/docker/12-troubleshooting/debugging-techniques).

---

> **Remember**: Common issues are like car problems. Known problems. Known solutions. Check logs. Inspect. Test. Fix. Most problems are fixable.

