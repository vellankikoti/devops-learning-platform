---
sidebar_position: 2
title: Monitoring Containers
---

# Monitoring Containers: Knowing What's Happening

**You can't manage what you can't measure. You can't fix what you don't know is broken. That's why monitoring matters.**

## 🎯 The Big Picture

Think of monitoring like a dashboard in a car. You see speed (CPU). You see fuel (memory). You see temperature (health). You know what's happening. That's monitoring.

**Monitoring tells you what's happening. Right now. In real-time. It's your window into containers.**

## Why Monitor Containers?

**The problem without monitoring:**
- Don't know if containers are healthy
- Don't know resource usage
- Don't know when things break
- Can't troubleshoot effectively
- Flying blind

**The solution with monitoring:**
- Know container health
- Know resource usage
- Know when things break
- Can troubleshoot effectively
- Always informed

**Real example:** I once had a production issue. No monitoring. Took hours to find the problem. With monitoring, I would have known immediately. Never again.

**Monitoring isn't optional. It's essential.**

## What to Monitor

**Key metrics to monitor:**

### 1. Container Health

**Is the container running?**
```bash
docker ps
# Shows running containers
```

**Is the container healthy?**
```bash
docker inspect container | grep Health
# Shows health status
```

**Think of it as:** Is the car running? Is the engine healthy?

### 2. Resource Usage

**CPU usage:**
```bash
docker stats container
# Shows CPU usage
```

**Memory usage:**
```bash
docker stats container
# Shows memory usage
```

**Disk usage:**
```bash
docker system df
# Shows disk usage
```

**Think of it as:** How much fuel? How much power? How much storage?

### 3. Application Metrics

**Request rate:**
- Requests per second
- Response times
- Error rates

**Business metrics:**
- User activity
- Transaction volume
- Revenue impact

**Think of it as:** How many customers? How fast service? How many errors?

### 4. Logs

**Application logs:**
```bash
docker logs container
# Shows application logs
```

**System logs:**
```bash
journalctl -u docker
# Shows Docker logs
```

**Think of it as:** What happened? When? Why?

## Basic Monitoring: docker stats

**See resource usage:**

```bash
# Live stats for all containers
docker stats

# Stats for specific container
docker stats container-name

# One-time snapshot
docker stats --no-stream container-name

# Custom format
docker stats --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"
```

**What you see:**
```
CONTAINER   CPU %     MEM USAGE / LIMIT     MEM %     NET I/O
app         45.2%     256MiB / 512MiB       50.0%     1.2MB / 800KB
db          12.5%     1.2GiB / 2GiB        60.0%     500KB / 1.5MB
```

**Think of it as:** Dashboard. See everything. At a glance.

## The Car Dashboard Analogy

**Think of monitoring like a car dashboard:**

**Container health:** Engine status
**CPU usage:** RPM gauge
**Memory usage:** Fuel gauge
**Network I/O:** Speedometer
**Logs:** Event recorder

**Once you see it this way, monitoring makes perfect sense.**

## Advanced Monitoring: Prometheus & Grafana

**Production monitoring setup:**

**docker-compose.yml:**
```yaml
services:
  # Prometheus - Metrics collection
  prometheus:
    image: prom/prometheus:latest
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml:ro
      - prometheus-data:/prometheus
    ports:
      - "9090:9090"
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'
    networks:
      - monitoring

  # Grafana - Visualization
  grafana:
    image: grafana/grafana:latest
    volumes:
      - grafana-data:/var/lib/grafana
      - ./grafana/dashboards:/etc/grafana/provisioning/dashboards:ro
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
    depends_on:
      - prometheus
    networks:
      - monitoring

  # Node Exporter - Host metrics
  node-exporter:
    image: prom/node-exporter:latest
    volumes:
      - /proc:/host/proc:ro
      - /sys:/host/sys:ro
      - /:/rootfs:ro
    command:
      - '--path.procfs=/host/proc'
      - '--path.sysfs=/host/sys'
      - '--collector.filesystem.mount-points-exclude=^/(sys|proc|dev|host|etc)($$|/)'
    ports:
      - "9100:9100"
    networks:
      - monitoring

volumes:
  prometheus-data:
  grafana-data:

networks:
  monitoring:
    driver: bridge
```

**What this provides:**
- Metrics collection (Prometheus)
- Visualization (Grafana)
- Host metrics (Node Exporter)
- Complete monitoring stack

## Monitoring Best Practices

### 1. Monitor Everything

**Monitor:**
- Container health
- Resource usage
- Application metrics
- Logs
- Network traffic

**Why:** Complete picture. Nothing missed.

### 2. Set Alerts

**Alert on:**
- Container down
- High CPU usage
- High memory usage
- High error rate
- Slow response times

**Why:** Know immediately. Fix quickly.

### 3. Use Dashboards

**Create dashboards:**
- Overview dashboard
- Per-service dashboards
- Infrastructure dashboard
- Business metrics dashboard

**Why:** Visual. Easy to understand. Quick insights.

### 4. Log Aggregation

**Centralize logs:**
- ELK Stack (Elasticsearch, Logstash, Kibana)
- Loki + Grafana
- Cloud logging (CloudWatch, Stackdriver)

**Why:** All logs in one place. Easy to search. Easy to analyze.

### 5. Monitor Trends

**Track over time:**
- Resource usage trends
- Error rate trends
- Performance trends
- User activity trends

**Why:** Predict problems. Plan capacity. Optimize.

## Real-World Example: Complete Monitoring

**Let me show you a complete setup:**

**1. Container metrics:**
```yaml
services:
  app:
    labels:
      - "prometheus.scrape=true"
      - "prometheus.port=3000"
      - "prometheus.path=/metrics"
```

**2. Prometheus config:**
```yaml
# prometheus.yml
scrape_configs:
  - job_name: 'containers'
    docker_sd_configs:
      - host: unix:///var/run/docker.sock
        refresh_interval: 5s
```

**3. Grafana dashboard:**
- CPU usage graph
- Memory usage graph
- Request rate graph
- Error rate graph
- Response time graph

**Complete monitoring. Production-ready.**

## My Take: Monitoring Strategy

**Here's what I monitor:**

**Infrastructure:**
- Container health
- Resource usage
- Network traffic
- Disk usage

**Application:**
- Request rate
- Response times
- Error rates
- Business metrics

**Security:**
- Failed logins
- Unusual activity
- Access patterns
- Compliance

**The key:** Monitor everything. Alert on important. Visualize for understanding. Act on alerts.

## Memory Tip: The Car Dashboard Analogy

**Monitoring = Car dashboard**

**Health:** Engine status
**CPU:** RPM
**Memory:** Fuel
**Network:** Speed
**Logs:** Recorder

**Once you see it this way, monitoring makes perfect sense.**

## Common Mistakes

1. **Not monitoring**: Flying blind
2. **Too many alerts**: Alert fatigue
3. **No dashboards**: Hard to understand
4. **Not acting on alerts**: Wasted effort
5. **Not monitoring trends**: Miss patterns

## Hands-On Exercise: Monitor Containers

**1. Run a container:**
```bash
docker run -d --name test nginx
```

**2. Monitor with stats:**
```bash
docker stats test
# Watch CPU and memory
```

**3. Check health:**
```bash
docker inspect test | grep -A 5 Health
```

**4. View logs:**
```bash
docker logs -f test
# Follow logs
```

**5. Check resource usage:**
```bash
docker stats --no-stream test
# One-time snapshot
```

## Key Takeaways

1. **Monitor everything** - Complete picture
2. **Set alerts** - Know immediately
3. **Use dashboards** - Visual understanding
4. **Aggregate logs** - Centralized search
5. **Track trends** - Predict problems
6. **Act on alerts** - Fix issues quickly

## What's Next?

Now that you understand monitoring, let's learn about logging strategies. Next: [Logging Strategies](/docs/docker/09-production-deployment/logging-strategies).

---

> **Remember**: Monitoring is like a car dashboard. You see everything. You know what's happening. Essential for production. Never skip it.

