---
sidebar_position: 2
title: "Log Rotation: Managing Log Files"
---

# Log Rotation: Prevent Disk Full

Log rotation prevents logs from filling disk. Old logs get compressed. New logs start.

**Here's the thing: Logs grow. They consume space. Rotate them. Or disk fills up.**

## What Log Rotation Does

Log rotation:
- Archives old logs
- Compresses logs
- Deletes old logs
- Prevents disk full

**My take**: Log rotation is automatic. But you need to configure it.

## logrotate: The Tool

### Configuration

```bash
# Configuration files
/etc/logrotate.conf                 # Main config
/etc/logrotate.d/                # Per-service configs
```

**My take**: Logrotate configs are in `/etc/logrotate.d/`. One per service.

### Basic Configuration

```bash
# /etc/logrotate.d/nginx
/var/log/nginx/*.log {
    daily
    rotate 7
    compress
    delaycompress
    missingok
    notifempty
    create 0640 www-data www-data
    sharedscripts
    postrotate
        systemctl reload nginx > /dev/null 2>&1 || true
    endscript
}
```

**My take**: This is a typical config. Learn it. Use it.

## Common Options

### Rotation Frequency

```bash
daily                            # Rotate daily
weekly                           # Rotate weekly
monthly                          # Rotate monthly
size 100M                        # Rotate when size reached
```

**My take**: Choose frequency based on log volume. Daily is common.

### Retention

```bash
rotate 7                         # Keep 7 rotated logs
rotate 30                        # Keep 30 rotated logs
```

**My take**: Keep enough logs. But not too many. 7-30 is common.

### Compression

```bash
compress                         # Compress old logs
delaycompress                    # Compress on next rotation
nocompress                       # Don't compress
```

**My take**: Compress logs. Saves space. Use `delaycompress` for active logs.

## Testing Rotation

```bash
# Test configuration
sudo logrotate -d /etc/logrotate.conf

# Force rotation
sudo logrotate -f /etc/logrotate.conf
```

**My take**: Test before applying. `-d` is dry run. `-f` forces rotation.

## Common Patterns

### Daily Rotation

```bash
/var/log/app/*.log {
    daily
    rotate 7
    compress
    missingok
    notifempty
}
```

### Size-Based Rotation

```bash
/var/log/app/*.log {
    size 100M
    rotate 5
    compress
    missingok
    notifempty
}
```

**My take**: Size-based rotates when logs get large. Use for high-volume logs.

## Common Mistakes (I've Made These)

1. **Not configuring rotation**: Logs grow. Configure rotation.

2. **Keeping too many logs**: Old logs consume space. Don't keep too many.

3. **Not compressing**: Compression saves space. Use it.

4. **Wrong permissions**: Rotated logs need correct permissions. Set them.

5. **Not testing**: Test rotation. Make sure it works.

## Real-World Examples

### Nginx Log Rotation

```bash
/var/log/nginx/*.log {
    daily
    rotate 14
    compress
    delaycompress
    missingok
    notifempty
    create 0640 www-data www-data
    sharedscripts
    postrotate
        systemctl reload nginx > /dev/null 2>&1 || true
    endscript
}
```

## What's Next?

Now that you understand log rotation, let's talk about [System Monitoring](/docs/linux/logging-monitoring/system-monitoring) to watch your system.

---

> **Personal note**: I've had disks fill up from logs. Then I learned log rotation. Now I configure it for everything. Logs rotate. Disk stays free. Configure it.

