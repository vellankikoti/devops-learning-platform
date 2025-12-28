---
sidebar_position: 4
title: "Timers And Cron: Scheduled Tasks"
---

# Scheduled Tasks: Run Commands Automatically

Scheduled tasks run commands automatically. Daily. Weekly. Whenever you need.

**Here's the thing: Scheduled tasks are essential. Learn them. Use them.**

## Cron: The Classic Scheduler

### Crontab Format

```bash
# Format: minute hour day month weekday command
* * * * * command                  # Every minute
0 * * * * command                  # Every hour
0 0 * * * command                  # Daily at midnight
0 0 * * 0 command                  # Weekly on Sunday
0 0 1 * * command                  # Monthly on 1st
```

**My take**: Cron format is: minute hour day month weekday. Learn it.

### Edit Crontab

```bash
crontab -e                         # Edit your crontab
crontab -l                         # List your crontabs
crontab -r                         # Remove all crontabs
```

**My take**: `crontab -e` edits your crontab. Use it.

### Common Cron Patterns

```bash
# Every 5 minutes
*/5 * * * * /path/to/script.sh

# Daily at 2 AM
0 2 * * * /path/to/backup.sh

# Weekly on Monday at 3 AM
0 3 * * 1 /path/to/cleanup.sh

# Monthly on 1st at midnight
0 0 1 * * /path/to/report.sh
```

**My take**: These are common patterns. Use them.

## systemd Timers: Modern Alternative

### Create Timer

```bash
# /etc/systemd/system/mytimer.timer
[Unit]
Description=Run Backup Daily
Requires=backup.service

[Timer]
OnCalendar=daily
OnCalendar=02:00

[Install]
WantedBy=timers.target
```

**My take**: Timers are modern. More flexible than cron.

### Timer Options

```bash
OnCalendar=daily                   # Daily
OnCalendar=weekly                  # Weekly
OnCalendar=monthly                 # Monthly
OnCalendar=02:00                   # At 2 AM
OnCalendar=Mon 03:00             # Monday at 3 AM
```

**My take**: Timers use calendar expressions. More readable than cron.

## Cron vs Timers

**Cron**:
- Simple
- Traditional
- Widely used

**Timers**:
- More flexible
- Better logging
- Modern

**My take**: Use cron for simple tasks. Use timers for complex scheduling.

## Common Patterns

### Daily Backup

```bash
# Cron
0 2 * * * /usr/local/bin/backup.sh

# Timer
OnCalendar=daily
OnCalendar=02:00
```

### Weekly Cleanup

```bash
# Cron
0 3 * * 0 /usr/local/bin/cleanup.sh

# Timer
OnCalendar=weekly
OnCalendar=Mon 03:00
```

## Common Mistakes (I've Made These)

1. **Wrong timezone**: Cron uses system timezone. Make sure it's correct.

2. **Not setting PATH**: Cron has limited PATH. Use full paths in scripts.

3. **Not redirecting output**: Cron output goes to email. Redirect to file.

4. **Wrong format**: Cron format is strict. One mistake breaks it.

5. **Not testing**: Test cron jobs. Make sure they work.

## Real-World Examples

### Daily Backup Cron

```bash
0 2 * * * /usr/local/bin/backup.sh >> /var/log/backup.log 2>&1
```

### Systemd Timer

```bash
# Enable and start
sudo systemctl enable mytimer.timer
sudo systemctl start mytimer.timer
```

## What's Next?

Now that you can schedule tasks, let's talk about [Service Troubleshooting](/docs/linux/system-services/service-troubleshooting) when things go wrong.

---

> **Personal note**: I used cron for everything. Then I learned timers. Now I use timers for complex scheduling. Cron for simple tasks. Both work. Use what fits.

