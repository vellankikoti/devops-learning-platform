---
sidebar_position: 2
title: Service Management With systemctl
---

# Service Management: Start, Stop, Control

Services are background processes that run automatically. You need to control them.

**Here's the thing: Service management is what you'll do constantly. Start services. Stop services. Check status.**

## Basic Control

### Start, Stop, Restart

```bash
sudo systemctl start service-name
sudo systemctl stop service-name
sudo systemctl restart service-name
```

**Real examples**:
```bash
sudo systemctl start nginx
sudo systemctl stop nginx
sudo systemctl restart nginx
```

**My take**: These are the commands you'll use most. Learn them.

### Reload vs Restart

```bash
sudo systemctl reload service-name    # Reload config
sudo systemctl restart service-name   # Stop and start
```

**The difference**: Reload re-reads config without stopping. Restart stops and starts.

**When to use**: Reload if service supports it (nginx does). Restart if it doesn't.

**My take**: Try reload first. It's faster. No downtime. Restart if reload doesn't work.

## Enable and Disable

```bash
sudo systemctl enable service-name    # Start at boot
sudo systemctl disable service-name   # Don't start at boot
```

**Enable** = Start automatically when system boots.

**Disable** = Don't start automatically.

**Real example**:
```bash
sudo systemctl enable nginx           # Start nginx on boot
sudo systemctl disable nginx          # Don't start on boot
```

**My take**: Enable services you want running. Disable services you don't need.

## Check Status

```bash
systemctl status service-name
```

**Output shows**:
- **Loaded** = Service file loaded
- **Active** = Is it running? (active, inactive, failed)
- **Main PID** = Process ID
- **Logs** = Recent log entries

**What matters**: **Active: active (running)** = Good. **Active: failed** = Bad.

**My take**: `status` shows everything. Use it to see what's happening.

## List Services

```bash
systemctl list-units --type=service  # All services
systemctl list-units --state=running # Running services
systemctl list-units --failed        # Failed services
```

**My take**: `list-units --failed` is useful. Shows what's broken.

## Common Services

```bash
sudo systemctl start nginx
sudo systemctl start apache2
sudo systemctl start mysql
sudo systemctl start docker
sudo systemctl start ssh
```

**These are the services you'll actually manage.** Web servers. Databases. Docker. SSH.

## Troubleshooting

### Service Won't Start

```bash
systemctl status service-name        # Check status
journalctl -u service-name          # Check logs
```

**My take**: Check status first. Then check logs. Logs tell you why.

### Service Failed

```bash
systemctl status service-name        # See error
sudo systemctl restart service-name  # Try restart
journalctl -u service-name -n 50     # Recent logs
```

**My take**: Failed services need fixing. Check logs. Fix the problem.

## Common Patterns

### Start and Enable

```bash
sudo systemctl start nginx
sudo systemctl enable nginx
```

### Check if Running

```bash
systemctl is-active nginx            # Returns: active or inactive
```

### Reload Config

```bash
sudo systemctl reload nginx          # Reload if supported
sudo systemctl restart nginx          # Restart if not
```

## Common Mistakes (I've Made These)

1. **Forgetting sudo**: Service management needs root. Use `sudo`.

2. **Using restart instead of reload**: Reload is faster. Use it when possible.

3. **Not checking status**: Services can fail silently. Check status.

4. **Not enabling services**: Services don't start on boot unless enabled. Enable them.

5. **Not checking logs**: When services fail, logs tell you why. Check them.

## Real-World Examples

### Deploy New Version

```bash
sudo systemctl stop nginx
# Deploy files
sudo systemctl start nginx
sudo systemctl status nginx
```

### Reload Configuration

```bash
# Edit config
sudo vim /etc/nginx/nginx.conf
# Test config
sudo nginx -t
# Reload
sudo systemctl reload nginx
```

### Troubleshoot Service

```bash
systemctl status nginx
journalctl -u nginx -n 100
```

## What's Next?

Now that you can manage services, you control what runs. Or learn about [Networking](/docs/linux/networking/network-fundamentals) to connect systems.

---

> **Personal note**: When I started, I'd restart services for everything. Then I learned reload. Now I reload when possible. It's faster. No downtime. Small things matter.
