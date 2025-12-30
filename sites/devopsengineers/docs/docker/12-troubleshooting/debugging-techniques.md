---
sidebar_position: 2
title: Debugging Techniques
---

# Debugging Techniques: How to Find and Fix Problems

**Debugging is detective work. Find clues. Follow leads. Solve the mystery. That's debugging.**

## 🎯 The Big Picture

Think of debugging like being a detective. You have a crime (problem). You gather evidence (logs, inspection). You follow leads (test hypotheses). You solve it (fix the problem). That's debugging.

**Debugging finds problems. Systematically. Methodically. It's how you solve issues.**

## Debugging Workflow

**Systematic debugging:**

**Step 1: Reproduce**
- Can you reproduce the problem?
- When does it happen?
- What triggers it?

**Step 2: Gather Evidence**
- Check logs
- Inspect containers
- Check resources
- Review configuration

**Step 3: Form Hypothesis**
- What could cause this?
- What changed?
- What's different?

**Step 4: Test Hypothesis**
- Test the theory
- Verify or disprove
- Gather more evidence

**Step 5: Fix and Verify**
- Apply fix
- Test again
- Verify it works

**Think of it as:** Detective work. Systematic. Methodical.

## The Detective Analogy

**Think of debugging like being a detective:**

**Problem:** Crime
**Logs:** Evidence
**Inspection:** Investigation
**Hypothesis:** Theory
**Fix:** Solution

**Once you see it this way, debugging makes perfect sense.**

## Essential Debugging Commands

### 1. docker logs

**View container logs:**
```bash
# View logs
docker logs container-name

# Follow logs
docker logs -f container-name

# Last 100 lines
docker logs --tail 100 container-name

# With timestamps
docker logs -t container-name
```

**Why:** Logs show what happened.

### 2. docker inspect

**Inspect everything:**
```bash
# Inspect container
docker inspect container-name

# Inspect image
docker inspect image-name

# Inspect network
docker inspect network-name

# Specific field
docker inspect -f '{{.State.Status}}' container-name
```

**Why:** See configuration. Find issues.

### 3. docker exec

**Execute commands in container:**
```bash
# Interactive shell
docker exec -it container-name sh

# Run command
docker exec container-name ps aux

# Check environment
docker exec container-name env
```

**Why:** See what's happening inside.

### 4. docker stats

**Monitor resources:**
```bash
# Live stats
docker stats

# Specific container
docker stats container-name

# One-time snapshot
docker stats --no-stream container-name
```

**Why:** See resource usage. Find bottlenecks.

### 5. docker events

**Watch Docker events:**
```bash
# Watch events
docker events

# Filter events
docker events --filter 'container=my-container'
```

**Why:** See what's happening. Real-time.

## Real-World Example: Debugging Session

**Problem:** Container keeps crashing

**Step 1: Check status**
```bash
docker ps -a
# Container status: Exited (1)
```

**Step 2: Check logs**
```bash
docker logs container-name
# Error: Cannot connect to database
```

**Step 3: Inspect container**
```bash
docker inspect container-name
# See environment variables, network, volumes
```

**Step 4: Check network**
```bash
docker network inspect bridge
# See if database container is connected
```

**Step 5: Test connection**
```bash
docker exec container-name ping database
# Connection failed
```

**Step 6: Fix**
```bash
# Connect to same network
docker network create app-network
docker run --network app-network database
docker run --network app-network app
```

**Step 7: Verify**
```bash
docker logs container-name
# No more errors
```

**That's debugging. Systematic. Effective.**

## Advanced Debugging

### 1. Debug Builds

**Debug build issues:**
```bash
# Verbose build
docker build --progress=plain -t my-app .

# No cache
docker build --no-cache -t my-app .

# Build specific stage
docker build --target builder -t my-app .
```

**Why:** See build process. Find issues.

### 2. Debug Networks

**Debug network issues:**
```bash
# List networks
docker network ls

# Inspect network
docker network inspect network-name

# Test connectivity
docker exec container1 ping container2
```

**Why:** See network configuration. Test connectivity.

### 3. Debug Volumes

**Debug volume issues:**
```bash
# List volumes
docker volume ls

# Inspect volume
docker volume inspect volume-name

# Check mount
docker inspect container-name | grep Mounts
```

**Why:** See volume configuration. Check mounts.

### 4. Debug Performance

**Debug performance issues:**
```bash
# Monitor resources
docker stats

# Check disk usage
docker system df

# Profile build
time docker build -t my-app .
```

**Why:** Find bottlenecks. Optimize.

## Best Practices

### 1. Start with Logs

**Always check logs first:**
```bash
docker logs container-name
```

**Why:** Logs usually show the problem.

### 2. Use docker exec

**Debug inside container:**
```bash
docker exec -it container-name sh
```

**Why:** See what's happening inside.

### 3. Test Incrementally

**Test one thing at a time:**
- Test image
- Test container
- Test network
- Test volumes

**Why:** Isolate the problem.

### 4. Document Findings

**Keep notes:**
- What you tried
- What worked
- What didn't
- Solution

**Why:** Learn. Don't repeat mistakes.

### 5. Use Health Checks

**Monitor health:**
```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost/health"]
  interval: 30s
```

**Why:** Know when unhealthy. Automatic detection.

## My Take: Debugging Strategy

**Here's what I do:**

**When debugging:**
1. Check logs
2. Inspect container
3. Test incrementally
4. Form hypothesis
5. Test and verify

**Tools:**
- docker logs
- docker inspect
- docker exec
- docker stats
- docker events

**The key:** Systematic approach. Use tools. Test. Verify.

## Memory Tip: The Detective Analogy

**Debugging = Detective work**

**Problem:** Crime
**Logs:** Evidence
**Inspection:** Investigation
**Fix:** Solution

**Once you see it this way, debugging makes perfect sense.**

## Common Mistakes

1. **Not checking logs**: Missing obvious clues
2. **Not inspecting**: Don't see configuration
3. **Testing too much at once**: Can't isolate problem
4. **Not documenting**: Repeat same mistakes
5. **Giving up too soon**: Problems are solvable

## Hands-On Exercise: Debug

**1. Create a problem:**
```bash
docker run --name test alpine
docker ps -a
# Container exited
```

**2. Check logs:**
```bash
docker logs test
# No output (normal for alpine)
```

**3. Inspect:**
```bash
docker inspect test
# See exit code, status
```

**4. Debug:**
```bash
docker run --name test2 alpine sleep 60
docker exec test2 ps aux
# See running processes
```

**5. Fix:**
```bash
# Based on findings, fix the issue
```

**That's debugging. Practice. Learn.**

## Key Takeaways

1. **Debugging is systematic** - Follow a process
2. **Start with logs** - Usually shows the problem
3. **Use docker inspect** - See configuration
4. **Use docker exec** - Debug inside container
5. **Test incrementally** - Isolate the problem
6. **Document findings** - Learn from experience

## What's Next?

Now that you understand debugging techniques, let's learn about performance issues. Next: [Performance Issues](/docs/docker/12-troubleshooting/performance-issues).

---

> **Remember**: Debugging is like being a detective. Gather evidence. Follow leads. Solve the mystery. Systematic. Methodical. Effective.

