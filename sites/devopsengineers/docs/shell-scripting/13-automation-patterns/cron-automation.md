---
sidebar_position: 6
title: "Cron Automation: Schedule Scripts"
---

# Cron Automation: Schedule Tasks

Cron schedules scripts. Run them automatically. Common.

**Here's the thing: Cron runs scripts automatically. Learn it. Use it.**

## Basic Cron

```bash
# Run daily at 2 AM
0 2 * * * /path/to/script.sh
```

**My take**: Cron schedules tasks. Use it.

## Common Patterns

### Daily Backup

```bash
0 2 * * * /usr/local/bin/backup.sh
```

## What's Next?

Now that you understand cron, you can schedule tasks. Or review [Automation Patterns](/docs/shell-scripting/automation-patterns/backup-scripts) to reinforce.

---

> **Personal note**: Cron seemed complex at first. Then I learned it. Now I use it constantly. It's useful. Learn it.


