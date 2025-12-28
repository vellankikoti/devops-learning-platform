---
sidebar_position: 5
title: "System Maintenance: Automate Maintenance"
---

# System Maintenance: Automate Tasks

System maintenance automates tasks. Cleanup. Updates. Common.

**Here's the thing: Maintenance scripts automate tasks. Learn patterns. Use them.**

## Basic Maintenance

```bash
#!/bin/bash
# Cleanup old logs
find /var/log -name "*.log" -mtime +30 -delete

# Update packages
apt update && apt upgrade -y
```

**My take**: Maintenance scripts automate. Use them.

## Common Patterns

### Cleanup

```bash
cleanup_old_files() {
    find "$1" -type f -mtime +$2 -delete
}
```

## What's Next?

Now that you understand maintenance, let's talk about [Cron Automation](/docs/shell-scripting/automation-patterns/cron-automation).

---

> **Personal note**: Maintenance scripts seemed unnecessary at first. Then I automated them. Now I use them always. They save time. Use them.

