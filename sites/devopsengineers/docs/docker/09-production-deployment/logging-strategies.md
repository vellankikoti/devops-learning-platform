---
sidebar_position: 3
title: Logging Strategies
---

# Logging Strategies: Capturing What Matters

**Logs are your evidence. Your debugging tool. Your audit trail. Without good logging, you're blind. With good logging, you can solve any problem.**

## 🎯 The Big Picture

Think of logging like a security camera recording. It records everything. You can review it. You can search it. You can analyze it. That's logging.

**Logging captures what happens. When it happens. Why it happens. It's essential for production.**

## Why Logging Matters

**The problem without logging:**
- Can't debug issues
- Don't know what happened
- Can't audit actions
- Can't troubleshoot
- Flying blind

**The solution with logging:**
- Can debug issues
- Know what happened
- Can audit actions
- Can troubleshoot
- Always informed

**Real example:** I once had a production issue. No logs. Took days to debug. With proper logging, I would have found it in minutes. Never again.

**Logging isn't optional. It's essential.**

## Logging Levels

**Use appropriate log levels:**

**DEBUG:** Detailed information for debugging
```javascript
console.debug('Processing user data:', userData);
```

**INFO:** General information
```javascript
console.log('User logged in:', userId);
```

**WARN:** Warning messages
```javascript
console.warn('High memory usage detected:', memoryUsage);
```

**ERROR:** Error messages
```javascript
console.error('Database connection failed:', error);
```

**Think of it as:** Different severity. Different urgency. Different actions.

## Structured Logging

**Use structured logging:**

**Don't do this:**
```javascript
console.log('User 123 logged in from IP 192.168.1.1');
```

**Do this:**
```javascript
console.log(JSON.stringify({
  level: 'info',
  message: 'User logged in',
  userId: 123,
  ip: '192.168.1.1',
  timestamp: new Date().toISOString()
}));
```

**Why:**
- Easy to parse
- Easy to search
- Easy to analyze
- Better for log aggregation

## Docker Logging Drivers

**Configure logging drivers:**

### JSON File (Default)

```yaml
services:
  app:
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
        compress: "true"
```

**Why:** Default. Works. Good for most cases.

### Syslog

```yaml
services:
  app:
    logging:
      driver: "syslog"
      options:
        syslog-address: "tcp://localhost:514"
        syslog-facility: "daemon"
        tag: "app"
```

**Why:** Centralized. Standard. Good for Linux.

### Journald

```yaml
services:
  app:
    logging:
      driver: "journald"
```

**Why:** Systemd integration. Good for systemd systems.

### GELF (Graylog)

```yaml
services:
  app:
    logging:
      driver: "gelf"
      options:
        gelf-address: "udp://localhost:12201"
        tag: "app"
```

**Why:** Graylog integration. Good for centralized logging.

### Fluentd

```yaml
services:
  app:
    logging:
      driver: "fluentd"
      options:
        fluentd-address: "localhost:24224"
        tag: "app"
```

**Why:** Fluentd integration. Good for log aggregation.

## The Security Camera Analogy

**Think of logging like security camera recordings:**

**Logging levels:** Different camera angles
**Structured logging:** Organized recordings
**Log drivers:** Different storage systems
**Log aggregation:** Centralized viewing

**Once you see it this way, logging makes perfect sense.**

## Log Aggregation

**Centralize logs:**

### ELK Stack

**Elasticsearch, Logstash, Kibana:**

```yaml
services:
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.11.0
    environment:
      - discovery.type=single-node
    volumes:
      - es-data:/usr/share/elasticsearch/data

  logstash:
    image: docker.elastic.co/logstash/logstash:8.11.0
    volumes:
      - ./logstash.conf:/usr/share/logstash/pipeline/logstash.conf:ro
    depends_on:
      - elasticsearch

  kibana:
    image: docker.elastic.co/kibana/kibana:8.11.0
    ports:
      - "5601:5601"
    depends_on:
      - elasticsearch

  app:
    logging:
      driver: "gelf"
      options:
        gelf-address: "udp://logstash:12201"
```

**What this provides:**
- Log collection (Logstash)
- Log storage (Elasticsearch)
- Log visualization (Kibana)
- Complete logging stack

### Loki + Grafana

**Lightweight alternative:**

```yaml
services:
  loki:
    image: grafana/loki:latest
    volumes:
      - loki-data:/loki
    command: -config.file=/etc/loki/loki-config.yaml

  promtail:
    image: grafana/promtail:latest
    volumes:
      - /var/lib/docker/containers:/var/lib/docker/containers:ro
      - ./promtail-config.yml:/etc/promtail/config.yml:ro
    command: -config.file=/etc/promtail/config.yml

  grafana:
    image: grafana/grafana:latest
    ports:
      - "3000:3000"
    depends_on:
      - loki
```

**Why:** Lighter than ELK. Good for smaller setups.

## Logging Best Practices

### 1. Use Appropriate Levels

**Use levels correctly:**
- DEBUG: Development only
- INFO: Important events
- WARN: Potential issues
- ERROR: Actual problems

**Why:** Filter effectively. Focus on what matters.

### 2. Include Context

**Add context to logs:**
```javascript
logger.info({
  message: 'Request processed',
  requestId: req.id,
  userId: req.user.id,
  duration: Date.now() - startTime
});
```

**Why:** Easier to trace. Better debugging.

### 3. Don't Log Sensitive Data

**Never log:**
- Passwords
- API keys
- Credit card numbers
- Personal information

**Why:** Security risk. Compliance violation.

### 4. Rotate Logs

**Configure log rotation:**
```yaml
logging:
  driver: "json-file"
  options:
    max-size: "10m"
    max-file: "3"
```

**Why:** Prevent disk fill-up. Manageable size.

### 5. Centralize Logs

**Use log aggregation:**
- All logs in one place
- Easy to search
- Easy to analyze
- Better insights

**Why:** Complete picture. Better troubleshooting.

## Real-World Example: Production Logging

**Complete logging setup:**

```yaml
services:
  app:
    image: my-app:1.0
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
        compress: "true"
        labels: "production"
        tag: "{{.Name}}/{{.ID}}"
    labels:
      - "logging.enabled=true"
      - "logging.level=info"
```

**Application logging:**
```javascript
// Structured logging
const logger = {
  info: (data) => console.log(JSON.stringify({
    level: 'info',
    timestamp: new Date().toISOString(),
    ...data
  })),
  error: (data) => console.error(JSON.stringify({
    level: 'error',
    timestamp: new Date().toISOString(),
    ...data
  }))
};

// Use it
logger.info({
  message: 'User logged in',
  userId: 123
});
```

**Complete logging. Production-ready.**

## My Take: Logging Strategy

**Here's what I do:**

**Development:**
- Console logging
- DEBUG level
- Simple format

**Staging:**
- Structured logging
- INFO level
- Log aggregation

**Production:**
- Structured logging
- INFO/WARN/ERROR levels
- Centralized aggregation
- Retention policies
- Alert on errors

**The key:** Log everything important. Structure it. Centralize it. Use it.

## Memory Tip: The Security Camera Analogy

**Logging = Security camera recordings**

**Levels:** Different angles
**Structure:** Organized
**Drivers:** Storage systems
**Aggregation:** Centralized viewing

**Once you see it this way, logging makes perfect sense.**

## Common Mistakes

1. **Not logging enough**: Can't debug
2. **Logging too much**: Hard to find important
3. **Not structuring logs**: Hard to parse
4. **Logging sensitive data**: Security risk
5. **Not centralizing**: Hard to search

## Hands-On Exercise: Set Up Logging

**1. Configure logging:**
```yaml
services:
  app:
    image: nginx
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
```

**2. Run container:**
```bash
docker compose up -d
```

**3. View logs:**
```bash
docker compose logs app
```

**4. Follow logs:**
```bash
docker compose logs -f app
```

**5. Check log files:**
```bash
docker inspect app | grep LogPath
# Shows log file location
```

## Key Takeaways

1. **Log everything important** - Complete picture
2. **Use appropriate levels** - Filter effectively
3. **Structure logs** - Easy to parse
4. **Don't log sensitive data** - Security risk
5. **Centralize logs** - Easy to search
6. **Rotate logs** - Prevent disk fill-up

## What's Next?

Now that you understand logging, let's learn about backup and recovery. Next: [Backup & Recovery](/docs/docker/09-production-deployment/backup-recovery).

---

> **Remember**: Logging is like security camera recordings. It captures everything. You can review it. You can search it. Essential for production. Never skip it.

