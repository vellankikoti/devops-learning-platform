---
sidebar_position: 3
title: "Monitoring Scripts: Watch Systems"
---

# Monitoring Scripts: Monitor Systems

Monitoring scripts watch systems. Check health. Alert on problems.

**Here's the thing: Monitoring scripts watch systems. Learn patterns. Use them.**

## Basic Monitoring

```bash
#!/bin/bash
if ! systemctl is-active nginx; then
    echo "Nginx is down!"
    # Alert
fi
```

**My take**: Monitoring checks status. Alerts on problems.

## Common Patterns

### Health Check

```bash
check_service() {
    if ! systemctl is-active "$1"; then
        alert "Service $1 is down"
    fi
}
```

## What's Next?

Now that you understand monitoring, let's talk about [Log Analysis](/docs/shell-scripting/automation-patterns/log-analysis).

---

> **Personal note**: Monitoring scripts seemed unnecessary at first. Then I used them. Now I use them always. They prevent problems. Use them.


