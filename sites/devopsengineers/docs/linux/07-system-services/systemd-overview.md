---
sidebar_position: 1
title: "systemd: Modern Service Manager"
---

# systemd: What Actually Runs Your System

systemd is what starts your system. It's what manages services. It's what keeps everything running.

**Love it or hate it, it's what you'll use. Most modern Linux uses systemd. Learn it.**

## What systemd Actually Does

systemd:
- Starts the system at boot
- Manages services (start, stop, restart)
- Handles dependencies (service A needs service B)
- Manages system resources
- Provides logging (journald)

**That's it. But that's a lot.**

## systemctl: The Command You'll Use

```bash
sudo systemctl start service-name     # Start service
sudo systemctl stop service-name      # Stop service
sudo systemctl restart service-name   # Restart service
sudo systemctl reload service-name    # Reload config (if supported)
sudo systemctl status service-name    # Show status
```

**That's 90% of what you need.**

**Real examples**:
```bash
sudo systemctl start nginx
sudo systemctl stop nginx
sudo systemctl restart nginx
sudo systemctl status nginx
```

**My take**: `systemctl` is the command. Learn it. You'll use it constantly.

## Enable and Disable (Start at Boot)

```bash
sudo systemctl enable service-name    # Start at boot
sudo systemctl disable service-name   # Don't start at boot
```

**Enable** = Start automatically when system boots. **Disable** = Don't start automatically.

**Real example**:
```bash
sudo systemctl enable nginx           # Start nginx on boot
sudo systemctl disable nginx          # Don't start on boot
```

**My take**: Enable services you want running. Disable services you don't need. Simple.

## Checking Status

```bash
systemctl status nginx
```

**Output shows**:
- **Loaded** - Service file loaded
- **Active** - Is it running? (active, inactive, failed)
- **Main PID** - Process ID
- **Tasks** - Number of tasks
- **Memory** - Memory usage
- **Logs** - Recent log entries

**Real example**:
```
● nginx.service - A high performance web server
   Loaded: loaded (/lib/systemd/system/nginx.service; enabled)
   Active: active (running) since Mon 2024-12-28 10:00:00 UTC
 Main PID: 1234 (nginx)
    Tasks: 2
   Memory: 2.1M
```

**What matters**: **Active: active (running)** = It's working. **Active: inactive (dead)** = It's not running. **Active: failed** = Something broke.

## Listing Services

```bash
systemctl list-units --type=service  # All services
systemctl list-units --state=running # Running services
systemctl list-units --failed        # Failed services
```

**My take**: `list-units --failed` is useful. Shows what's broken.

**Real example**:
```bash
$ systemctl list-units --failed
```

If something is broken, it shows here.

## Common Services You'll Manage

```bash
sudo systemctl start nginx
sudo systemctl start apache2
sudo systemctl start mysql
sudo systemctl start docker
sudo systemctl start ssh
```

**These are the services you'll actually manage.** Web servers. Databases. Docker. SSH.

## Understanding Service States

- **active (running)** - Working
- **active (exited)** - Ran and finished (one-time services)
- **inactive (dead)** - Not running
- **failed** - Broken

**My take**: `active (running)` = good. `failed` = bad. Everything else = depends.

## Reload vs Restart

```bash
sudo systemctl reload nginx           # Reload config
sudo systemctl restart nginx          # Restart service
```

**Reload** = Reload configuration without stopping. **Restart** = Stop and start again.

**When to use**: Reload if the service supports it (nginx does). Restart if it doesn't or if reload doesn't work.

**My take**: Try reload first. It's faster. If it doesn't work, restart.

## The Truth About systemd

People complain about systemd. It's complex. It does a lot. It's not simple.

**But here's the thing: It works. It's what you'll use. Learn it.**

**My take**: Don't fight it. Learn it. Use it. It's not going away.

## What's Next?

Now that you understand systemd, let's talk about [Service Management](/docs/linux/system-services/service-management). We'll cover managing services in detail.

Or practice. Start a service. Stop it. Check its status. Get familiar with `systemctl`.

---

> **Personal note**: When I first saw systemd, I thought it was overcomplicated. Then I learned it. Now I appreciate it. It's powerful. It's reliable. It just works. Don't fight it. Learn it.
