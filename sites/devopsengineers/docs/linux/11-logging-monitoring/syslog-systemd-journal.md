---
sidebar_position: 1
title: ""Logging Systems: syslog And systemd-journal""
---

# Logs: Your System's Memory

Logs record what happened. When. Why. They're your system's memory.

**Here's the thing: Logs are where problems hide. And where solutions live. Learn to read them.**

## Where Logs Are

### Traditional Logs

```bash
/var/log/syslog                    # System log (Debian/Ubuntu)
/var/log/messages                   # System log (RHEL/CentOS)
/var/log/auth.log                  # Authentication
/var/log/kern.log                  # Kernel messages
```

**My take**: `/var/log/` is where logs live. Know this directory.

### Application Logs

```bash
/var/log/nginx/                    # Nginx
/var/log/apache2/                  # Apache
/var/log/mysql/                    # MySQL
```

**My take**: Applications have their own logs. Check their directories.

## systemd-journal (Modern Logging)

### journalctl: View Journal

```bash
journalctl                          # All logs
journalctl -n 50                    # Last 50 entries
journalctl -f                        # Follow (like tail -f)
```

**My take**: `journalctl` is modern logging. Use it. It's powerful.

### By Time

```bash
journalctl --since today            # Since today
journalctl --since "1 hour ago"    # Last hour
journalctl --since "2024-12-28 10:00:00"
```

**My take**: Time-based filtering is useful. Find logs from specific times.

### By Service

```bash
journalctl -u nginx                 # Nginx logs
journalctl -u sshd -f                # SSH logs, follow
```

**My take**: Service-specific logs are useful. See what a service is doing.

### By Priority

```bash
journalctl -p err                   # Errors and above
journalctl -p warning               # Warnings and above
```

**My take**: Filter by priority. See only important messages.

## Reading Logs

### tail: Watch Logs

```bash
tail -f /var/log/syslog             # Follow log
tail -n 100 /var/log/syslog         # Last 100 lines
```

**My take**: `tail -f` watches logs in real-time. You'll use it constantly.

### grep: Find in Logs

```bash
grep -i error /var/log/syslog      # Find errors
grep "pattern" /var/log/syslog | tail -20  # Last 20 matches
```

**My take**: `grep` finds things in logs. Combine with `tail` for recent matches.

## Common Log Patterns

### Find Errors

```bash
grep -i error /var/log/syslog | tail -20
journalctl -p err -n 50
```

### Find by Time

```bash
journalctl --since "1 hour ago" -p err
```

### Find by Service

```bash
journalctl -u nginx -p err
```

## Log Rotation

```bash
ls -la /var/log/syslog*
```

**What it does**: Logs rotate. Old logs get compressed. New logs start.

**My take**: Log rotation prevents disk full. It's automatic. Usually works.

## Common Mistakes (I've Made These)

1. **Not checking logs**: Problems happen. Logs tell you why. Check them.

2. **Reading wrong log**: Multiple logs exist. Find the right one.

3. **Not using journalctl**: Modern systems use journald. Use `journalctl`.

4. **Not filtering**: Logs are huge. Filter by time, service, priority.

5. **Not following logs**: `tail -f` or `journalctl -f` shows real-time. Use it.

## Real-World Examples

### Find Recent Errors

```bash
journalctl -p err --since "1 hour ago"
```

### Watch Service Logs

```bash
journalctl -u nginx -f
```

### Search Logs

```bash
grep -i "failed" /var/log/syslog | tail -50
```

## What's Next?

Now that you can read logs, you can troubleshoot. Or learn about [Security](/docs/linux/security/security-fundamentals) to protect your system.

---

> **Personal note**: When I started, I'd ignore logs. Then something broke. I learned to read logs. Now logs are my first step in troubleshooting. Logs tell you everything. Learn to read them.
