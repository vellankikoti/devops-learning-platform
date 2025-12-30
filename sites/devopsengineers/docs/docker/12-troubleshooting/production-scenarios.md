---
sidebar_position: 4
title: Production Scenarios
---

# Production Scenarios: Real-World Troubleshooting

**Production is different. Real problems. Real pressure. Real solutions. That's production scenarios.**

## 🎯 The Big Picture

Think of production scenarios like emergency situations. Car breaks down on highway (production issue). You need to fix it. Fast. That's production troubleshooting.

**Production scenarios are real problems. In production. Under pressure. With real solutions. This is how you handle them.**

## Scenario 1: Container Crash Loop

**Problem:**
- Container keeps crashing
- Restarts continuously
- Application unavailable

**Investigation:**
```bash
# Check container status
docker ps -a

# Check logs
docker logs container-name

# Check recent logs
docker logs --tail 100 container-name

# Check exit code
docker inspect container-name | grep ExitCode
```

**Common Causes:**
- Application error
- Missing dependencies
- Configuration error
- Resource exhaustion

**Solution:**
```bash
# Fix the root cause
# - Fix application code
# - Fix configuration
# - Add missing dependencies
# - Increase resources

# Restart container
docker restart container-name

# Or rebuild
docker build -t my-app:1.1 .
docker run my-app:1.1
```

**Prevention:**
- Health checks
- Proper error handling
- Resource limits
- Testing before deploy

## Scenario 2: High Memory Usage

**Problem:**
- Containers using too much memory
- Host running out of memory
- Containers being killed

**Investigation:**
```bash
# Check memory usage
docker stats

# Check specific container
docker stats container-name

# Check host memory
free -h

# Check container limits
docker inspect container-name | grep Memory
```

**Solution:**
```bash
# Set memory limits
docker run -m 512m my-app

# Or in Compose
services:
  app:
    deploy:
      resources:
        limits:
          memory: 512M
```

**Optimization:**
- Use smaller base images
- Remove unnecessary packages
- Optimize application
- Use multi-stage builds

## Scenario 3: Network Connectivity Issues

**Problem:**
- Containers can't communicate
- Services unreachable
- Connection timeouts

**Investigation:**
```bash
# Check networks
docker network ls

# Inspect network
docker network inspect network-name

# Test connectivity
docker exec container1 ping container2

# Check DNS
docker exec container-name nslookup service-name
```

**Solution:**
```bash
# Connect to same network
docker network create app-network
docker run --network app-network app
docker run --network app-network db

# Use service names
# app can connect to db using hostname "db"
```

**Prevention:**
- Use Docker networks
- Use service names
- Document network topology
- Test connectivity

## The Emergency Situation Analogy

**Think of production scenarios like emergency situations:**

**Crash loop:** Car breaks down
**High memory:** Out of fuel
**Network issues:** Can't communicate

**Once you see it this way, production troubleshooting makes perfect sense.**

## Scenario 4: Disk Space Exhaustion

**Problem:**
- No space left on device
- Can't build images
- Can't create containers

**Investigation:**
```bash
# Check disk usage
docker system df

# Check detailed usage
docker system df -v

# Check host disk
df -h
```

**Solution:**
```bash
# Clean up unused resources
docker system prune -a

# Remove unused volumes
docker volume prune

# Remove unused images
docker image prune -a

# Remove build cache
docker builder prune -a
```

**Prevention:**
- Regular cleanup
- Monitor disk usage
- Set up alerts
- Use .dockerignore

## Scenario 5: Slow Performance

**Problem:**
- Slow response times
- High CPU usage
- Poor user experience

**Investigation:**
```bash
# Monitor resources
docker stats

# Check CPU usage
docker stats --format "table {{.Container}}\t{{.CPUPerc}}"

# Profile application
docker exec container-name top
```

**Solution:**
```bash
# Set CPU limits
docker run --cpus="1.0" my-app

# Or in Compose
services:
  app:
    deploy:
      resources:
        limits:
          cpus: '1.0'
```

**Optimization:**
- Use BuildKit
- Optimize Dockerfile
- Use cache mounts
- Multi-stage builds

## Real-World Example: Complete Troubleshooting

**Problem:** Production application is down

**Step 1: Check status**
```bash
docker ps -a
# Container status: Exited
```

**Step 2: Check logs**
```bash
docker logs --tail 100 container-name
# Error: Database connection failed
```

**Step 3: Check network**
```bash
docker network inspect app-network
# Database container not connected
```

**Step 4: Check database**
```bash
docker ps -a | grep db
# Database container stopped
```

**Step 5: Restart database**
```bash
docker start db-container
```

**Step 6: Restart application**
```bash
docker restart app-container
```

**Step 7: Verify**
```bash
docker logs app-container
# Application running
curl http://localhost:3000/health
# Healthy
```

**That's production troubleshooting. Fast. Effective.**

## Best Practices

### 1. Monitor Everything

**Set up monitoring:**
- Container health
- Resource usage
- Logs
- Metrics

**Why:** Know what's happening. Detect issues early.

### 2. Have Runbooks

**Document procedures:**
- Common issues
- Solutions
- Escalation paths

**Why:** Faster resolution. Consistent approach.

### 3. Test Scenarios

**Practice troubleshooting:**
- Simulate failures
- Test recovery
- Document learnings

**Why:** Better prepared. Faster response.

### 4. Use Health Checks

**Monitor health:**
```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost/health"]
  interval: 30s
```

**Why:** Automatic detection. Faster response.

### 5. Set Up Alerts

**Alert on issues:**
- Container down
- High resource usage
- Errors in logs

**Why:** Know immediately. Faster response.

## My Take: Production Strategy

**Here's what I do:**

**Prevention:**
- Health checks
- Resource limits
- Monitoring
- Alerts
- Testing

**When issues occur:**
1. Check status
2. Check logs
3. Investigate systematically
4. Fix and verify
5. Document

**The key:** Monitor. Alert. Respond. Document. Learn.

## Memory Tip: The Emergency Situation Analogy

**Production scenarios = Emergency situations**

**Crash loop:** Car breaks down
**High memory:** Out of fuel
**Network issues:** Can't communicate
**Disk space:** No storage

**Once you see it this way, production troubleshooting makes perfect sense.**

## Common Mistakes

1. **No monitoring**: Don't know what's happening
2. **No runbooks**: Slow response
3. **No health checks**: Don't detect issues
4. **No alerts**: Issues go unnoticed
5. **Not documenting**: Repeat same mistakes

## Hands-On Exercise: Production Troubleshooting

**1. Create a problem:**
```bash
docker run -d --name test nginx
docker stop test
# Container stopped
```

**2. Investigate:**
```bash
docker ps -a
docker logs test
docker inspect test
```

**3. Fix:**
```bash
docker start test
docker logs test
```

**4. Verify:**
```bash
curl http://localhost
# Should work
```

**That's production troubleshooting. Practice. Learn.**

## Key Takeaways

1. **Monitor everything** - Know what's happening
2. **Have runbooks** - Faster resolution
3. **Test scenarios** - Better prepared
4. **Use health checks** - Automatic detection
5. **Set up alerts** - Know immediately
6. **Document everything** - Learn from experience

## What's Next?

Congratulations! You've completed the Troubleshooting module. Now let's learn about best practices. Next: [Image Best Practices](/docs/docker/13-best-practices/image-best-practices).

---

> **Remember**: Production scenarios are like emergency situations. Monitor. Alert. Respond. Document. Learn. Be prepared. Act fast.

