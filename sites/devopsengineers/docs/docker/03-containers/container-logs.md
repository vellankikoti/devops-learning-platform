---
sidebar_position: 4
title: Container Logs
---

# Container Logs: Seeing What Your Containers Are Doing

**Logs are your window into containers. They tell you what's happening. What went wrong. What's working. Without logs, you're blind.**

## 🎯 The Big Picture

Think of container logs like a security camera recording. It records everything that happens. You can watch it live. You can review past recordings. You can search for specific events.

**Logs are your evidence. Your debugging tool. Your monitoring solution.**

## Why Logs Matter

**Logs tell you:**
- What the application is doing
- What errors occurred
- What requests were made
- What responses were sent
- Performance information
- Debugging information

**Without logs:**
- You can't debug issues
- You don't know what's happening
- You can't monitor applications
- You're flying blind

**With logs:**
- You can see everything
- You can debug issues
- You can monitor applications
- You're in control

## Viewing Logs

**Basic log viewing:**

```bash
# View logs
docker logs web

# Follow logs (live)
docker logs -f web

# Last N lines
docker logs --tail 100 web

# Since timestamp
docker logs --since 2024-01-15T10:00:00 web

# Until timestamp
docker logs --until 2024-01-15T12:00:00 web
```

**Output:**
```
2024-01-15T10:00:00.123Z INFO Server started on port 3000
2024-01-15T10:00:05.456Z INFO Request: GET /api/users
2024-01-15T10:00:05.789Z INFO Response: 200 OK
2024-01-15T10:00:10.012Z ERROR Database connection failed
```

**What you see:**
- Timestamps
- Log levels (INFO, ERROR, WARN)
- Messages
- Everything the application outputs

## Following Logs (Live View)

**Watch logs in real-time:**

```bash
docker logs -f web
```

**What it does:**
- Shows existing logs
- Then follows new logs
- Updates in real-time
- Like `tail -f` in Linux

**Exit:** Press `Ctrl+C`

**Think of it as:** Watching a live security camera feed.

**Follow with timestamps:**
```bash
docker logs -f -t web
# Shows timestamps on each line
```

## Limiting Log Output

**Show only recent logs:**

```bash
# Last 50 lines
docker logs --tail 50 web

# Last 100 lines
docker logs --tail 100 web
```

**Why limit?**
- Logs can be huge
- You usually want recent logs
- Faster to load

**Show logs since specific time:**
```bash
# Since 1 hour ago
docker logs --since 1h web

# Since 30 minutes ago
docker logs --since 30m web

# Since specific date
docker logs --since 2024-01-15T10:00:00 web
```

## Log Format

**Docker captures:**
- STDOUT (standard output)
- STDERR (standard error)

**Everything your application prints goes to logs.**

**Example application:**
```javascript
console.log('Server started');
console.error('Error occurred');
process.stdout.write('Data\n');
```

**All of these appear in logs.**

## The Security Camera Analogy

**Think of container logs like security camera recordings:**

**Viewing logs (`docker logs`):** Watch past recordings

**Following logs (`docker logs -f`):** Watch live feed

**Limiting output (`--tail`):** Watch last N minutes

**Since timestamp (`--since`):** Watch from specific time

**Once you see it this way, logs make perfect sense.**

## Real-World Example: Debugging a Web Application

**Problem:** Application is slow. Need to debug.

**1. Check recent logs:**
```bash
docker logs --tail 100 web
```

**2. Follow logs to see what's happening:**
```bash
docker logs -f web
# Make a request, watch logs
```

**3. Look for errors:**
```bash
docker logs web 2>&1 | grep ERROR
```

**4. Check logs since issue started:**
```bash
docker logs --since 1h web
```

**Logs show:**
- Slow database queries
- High request volume
- Error patterns

**You find the issue. You fix it. Logs helped.**

## Logging Best Practices

### 1. Use Structured Logging

**Don't do this:**
```javascript
console.log('User logged in');
```

**Do this:**
```javascript
console.log(JSON.stringify({
  level: 'info',
  message: 'User logged in',
  userId: 123,
  timestamp: new Date().toISOString()
}));
```

**Why:**
- Easier to parse
- Better for log aggregation
- More searchable

### 2. Use Log Levels

**Use appropriate levels:**
- `ERROR`: Something went wrong
- `WARN`: Warning, but not critical
- `INFO`: General information
- `DEBUG`: Debugging information

**Example:**
```javascript
console.error('Database connection failed');
console.warn('High memory usage detected');
console.log('Request processed successfully');
console.debug('Processing user data...');
```

### 3. Include Context

**Include relevant information:**
- Timestamps
- Request IDs
- User IDs
- Error details

**Example:**
```javascript
console.log(`[${new Date().toISOString()}] [Request: ${requestId}] User ${userId} logged in`);
```

### 4. Don't Log Sensitive Data

**Don't log:**
- Passwords
- API keys
- Credit card numbers
- Personal information

**Log:**
- User IDs (not passwords)
- Request IDs
- Error messages (sanitized)

## Log Aggregation

**For production, use log aggregation:**

**Options:**
- Docker logging drivers
- ELK Stack (Elasticsearch, Logstash, Kibana)
- Loki + Grafana
- Cloud logging (CloudWatch, Stackdriver)

**Docker logging driver:**
```bash
docker run -d \
  --log-driver json-file \
  --log-opt max-size=10m \
  --log-opt max-file=3 \
  nginx
```

**What it does:**
- Logs to JSON files
- Rotates at 10MB
- Keeps 3 files
- Prevents disk fill-up

## My Take: Logging Strategy

**Here's what I do:**

**Development:**
- Use `docker logs -f` for live debugging
- Check logs when issues occur
- Simple and effective

**Production:**
- Use log aggregation (ELK, Loki)
- Centralized logging
- Search and analysis
- Alerts on errors

**The key:** Logs are essential. Use them. Monitor them. They're your debugging tool.

## Memory Tip: The Security Camera Analogy

**Container logs = Security camera recordings**

**View:** Watch past recordings
**Follow:** Watch live feed
**Limit:** Watch last N minutes
**Since:** Watch from specific time

**Once you see it this way, logs make perfect sense.**

## Common Mistakes

1. **Not checking logs**: Can't debug issues
2. **Logging too much**: Hard to find important information
3. **Logging sensitive data**: Security risk
4. **Not using log levels**: Can't filter effectively
5. **Not aggregating in production**: Hard to manage

## Hands-On Exercise: Working with Logs

**1. Run a container:**
```bash
docker run -d --name test nginx
```

**2. View logs:**
```bash
docker logs test
```

**3. Follow logs:**
```bash
docker logs -f test
# Make a request to nginx, see logs
# Press Ctrl+C to exit
```

**4. View last 10 lines:**
```bash
docker logs --tail 10 test
```

**5. View logs with timestamps:**
```bash
docker logs -t test
```

**6. Search for errors:**
```bash
docker logs test 2>&1 | grep error
```

## Key Takeaways

1. **`docker logs` shows container logs** - Everything the application outputs
2. **`-f` follows logs live** - Real-time updates
3. **`--tail` limits output** - Show only recent logs
4. **`--since` filters by time** - Show logs from specific time
5. **Logs are essential** - Use them for debugging and monitoring
6. **Use structured logging** - Easier to parse and search

## What's Next?

Now that you can view logs, let's learn how to debug containers when things go wrong. Next: [Container Debugging](/docs/docker/03-containers/container-debugging).

---

> **Remember**: Logs are your window into containers. They tell you what's happening. Use them. Monitor them. They're essential for debugging and monitoring.

