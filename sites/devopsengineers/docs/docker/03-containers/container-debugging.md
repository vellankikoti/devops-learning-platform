---
sidebar_position: 5
title: Container Debugging
---

# Container Debugging: Finding and Fixing Problems

**Things break. Applications crash. Containers fail. That's reality. Knowing how to debug makes the difference between hours of frustration and minutes of solution.**

## 🎯 The Big Picture

Think of container debugging like being a detective. You have clues (logs, status, events). You investigate (inspect, exec, test). You find the problem. You fix it.

**Debugging is systematic. Methodical. It works.**

## The Debugging Mindset

**Rule #1: Don't panic.**

Problems happen. They always do. Panicking doesn't help. A systematic approach does.

**Rule #2: Gather evidence first.**

Don't guess. Don't assume. Look at the evidence. Logs. Status. Events. Then form a hypothesis.

**Rule #3: Test your hypothesis.**

Don't just guess. Test it. Verify it. Then fix it.

## Step 1: Check Container Status

**First, see what state the container is in:**

```bash
docker ps -a
```

**Look for:**
- Is it running? (`Up`)
- Is it stopped? (`Exited`)
- Is it restarting? (`Restarting`)
- Exit code? (0 = success, non-zero = error)

**Example:**
```
CONTAINER ID   STATUS                 EXIT CODE
abc123def456   Up 2 hours             0
def456ghi789   Exited (1) 5 minutes ago  1
```

**Exit code 1 means error. That's your first clue.**

## Step 2: Check Logs

**Logs tell you what happened:**

```bash
# View all logs
docker logs web

# View last 100 lines
docker logs --tail 100 web

# Follow logs
docker logs -f web

# Previous container instance (if restarted)
docker logs --previous web
```

**Look for:**
- Error messages
- Stack traces
- Warning messages
- Application errors

**Example log output:**
```
ERROR: Database connection failed
at connect.js:25
Error: connect ECONNREFUSED 127.0.0.1:5432
```

**That's your problem. Database connection failed.**

## Step 3: Inspect the Container

**Get detailed information:**

```bash
docker inspect web
```

**Look for:**
- Configuration
- Environment variables
- Network settings
- Mounts
- Resource limits

**Get specific information:**
```bash
# Get exit code
docker inspect -f '{{.State.ExitCode}}' web

# Get error message
docker inspect -f '{{.State.Error}}' web

# Get environment variables
docker inspect -f '{{.Config.Env}}' web

# Get network settings
docker inspect -f '{{.NetworkSettings}}' web
```

## Step 4: Execute Commands Inside Container

**Run commands to investigate:**

```bash
# Get a shell
docker exec -it web /bin/bash

# Check processes
docker exec web ps aux

# Check files
docker exec web ls -la /app

# Check network
docker exec web netstat -tulpn

# Check environment variables
docker exec web env

# Test connectivity
docker exec web ping db.example.com
```

**Think of it as:** Going inside the container. Looking around. Testing things.

## Common Problems and Solutions

### Problem 1: Container Exits Immediately

**Symptoms:**
- Container starts
- Immediately exits
- Exit code non-zero

**Debugging:**
```bash
# Check logs
docker logs web

# Check exit code
docker inspect -f '{{.State.ExitCode}}' web

# Run interactively to see errors
docker run -it my-app /bin/bash
# Then try running the command manually
```

**Common causes:**
- Application crashes on startup
- Missing configuration
- Wrong command
- Port already in use

**Solutions:**
- Fix application code
- Add missing configuration
- Fix command in Dockerfile
- Change port mapping

### Problem 2: Application Not Accessible

**Symptoms:**
- Container is running
- Can't access application
- Connection refused

**Debugging:**
```bash
# Check if container is running
docker ps

# Check port mapping
docker port web

# Check if application is listening
docker exec web netstat -tulpn

# Test from inside container
docker exec web curl localhost:3000
```

**Common causes:**
- Wrong port mapping
- Application not listening on expected port
- Firewall blocking
- Application binding to wrong interface

**Solutions:**
- Fix port mapping: `-p 8080:3000`
- Check application listens on `0.0.0.0`, not `127.0.0.1`
- Check firewall rules
- Verify application configuration

### Problem 3: Container Keeps Restarting

**Symptoms:**
- Container status: Restarting
- Keeps crashing and restarting
- High restart count

**Debugging:**
```bash
# Check logs
docker logs web

# Check previous instance logs
docker logs --previous web

# Check restart policy
docker inspect -f '{{.HostConfig.RestartPolicy}}' web

# Temporarily disable restart to see error
docker update --restart=no web
docker start web
# Now it will exit and stay exited, showing the error
```

**Common causes:**
- Application crashes on startup
- Missing dependencies
- Configuration errors
- Resource limits too low

**Solutions:**
- Fix application code
- Install missing dependencies
- Fix configuration
- Increase resource limits

### Problem 4: Can't Connect to Database

**Symptoms:**
- Application can't connect to database
- Connection refused errors
- Timeout errors

**Debugging:**
```bash
# Check if database container is running
docker ps | grep postgres

# Test connectivity from app container
docker exec web ping postgres-container

# Test database port
docker exec web nc -zv postgres-container 5432

# Check environment variables
docker exec web env | grep DB
```

**Common causes:**
- Database container not running
- Wrong hostname (use container name, not localhost)
- Wrong port
- Network not connected

**Solutions:**
- Start database container
- Use container name as hostname: `postgres-container`
- Verify port: `5432`
- Connect containers to same network

### Problem 5: Out of Memory

**Symptoms:**
- Container killed
- Exit code 137 (OOM killed)
- High memory usage

**Debugging:**
```bash
# Check memory usage
docker stats web

# Check memory limits
docker inspect -f '{{.HostConfig.Memory}}' web

# Check system memory
free -h
```

**Common causes:**
- Memory limit too low
- Memory leak in application
- Too many processes

**Solutions:**
- Increase memory limit: `--memory=512m`
- Fix memory leak
- Optimize application
- Reduce number of processes

## The Detective Analogy

**Think of debugging like being a detective:**

**Step 1 (Check status):** "What's the crime scene?" (container status)

**Step 2 (Check logs):** "What do the witnesses say?" (logs)

**Step 3 (Inspect):** "What evidence is there?" (inspect container)

**Step 4 (Execute):** "Let me investigate" (exec commands)

**Step 5 (Fix):** "I found the culprit" (fix the problem)

**Once you see it this way, debugging becomes systematic.**

## Real-World Example: Debugging a Production Issue

**Problem:** Application is slow. Users complaining.

**1. Check container status:**
```bash
docker ps
# Container is running, but slow
```

**2. Check logs:**
```bash
docker logs --tail 100 web
# See: "Database query taking 5 seconds"
```

**3. Check resource usage:**
```bash
docker stats web
# CPU: 100%, Memory: 512MB/512MB
```

**4. Execute command to check database:**
```bash
docker exec web psql -h db -U user -d mydb -c "SELECT * FROM slow_table"
# Query takes 10 seconds
```

**5. Found the problem:**
- Slow database query
- No index on table
- CPU at 100%

**6. Fix:**
- Add database index
- Optimize query
- Increase CPU limit

**Problem solved. Systematic debugging worked.**

## Debugging Tools

### docker exec

**Run commands inside container:**
```bash
docker exec -it web /bin/bash
```

### docker logs

**View application logs:**
```bash
docker logs -f web
```

### docker stats

**Monitor resource usage:**
```bash
docker stats web
```

### docker inspect

**Get detailed information:**
```bash
docker inspect web
```

### docker top

**See running processes:**
```bash
docker top web
```

## My Take: Debugging Workflow

**Here's my systematic approach:**

**1. Check status** - Is it running? What's the exit code?

**2. Check logs** - What errors do I see?

**3. Inspect container** - What's the configuration?

**4. Execute commands** - Test things inside container

**5. Form hypothesis** - Based on evidence

**6. Test hypothesis** - Verify it

**7. Fix the problem** - Apply solution

**8. Verify fix** - Confirm it works

**This process works. Every time.**

## Memory Tip: The Detective Analogy

**Container debugging = Detective work**

**Check status:** Examine crime scene
**Check logs:** Interview witnesses
**Inspect:** Gather evidence
**Execute:** Investigate
**Fix:** Solve the case

**Once you see it this way, debugging becomes systematic.**

## Common Mistakes

1. **Not checking logs first**: Missing obvious errors
2. **Guessing instead of investigating**: Wastes time
3. **Not using exec**: Can't test inside container
4. **Ignoring exit codes**: Missing important clues
5. **Not being systematic**: Random debugging doesn't work

## Hands-On Exercise: Debug a Problem

**1. Create a broken container:**
```bash
docker run -d --name broken nginx
# Then stop it
docker stop broken
```

**2. Debug why it stopped:**
```bash
# Check status
docker ps -a | grep broken

# Check logs
docker logs broken

# Inspect
docker inspect broken
```

**3. Fix it:**
```bash
# Restart it
docker start broken

# Verify it's running
docker ps | grep broken
```

## Key Takeaways

1. **Debugging is systematic** - Follow a process
2. **Check status first** - Know the state
3. **Check logs** - See what happened
4. **Inspect container** - Get details
5. **Execute commands** - Test inside container
6. **Form hypothesis** - Based on evidence
7. **Test and fix** - Verify solution

## What's Next?

Congratulations! You've completed the Containers module. Now let's learn about Docker networking. Next: [Docker Networks](/docs/docker/04-networking/docker-networks).

---

> **Remember**: Debugging is systematic. Don't panic. Gather evidence. Form hypothesis. Test it. Fix it. This process works.

