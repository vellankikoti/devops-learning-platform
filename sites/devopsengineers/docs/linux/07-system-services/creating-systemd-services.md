---
sidebar_position: 3
title: Creating systemd Services
---

# Creating systemd Services: Write Your Own

You can create your own systemd services. For custom applications. For scripts that need to run automatically.

**Here's the thing: Creating services is useful. Learn it. You'll use it.**

## Service File Location

```bash
/etc/systemd/system/              # System services (preferred)
/usr/lib/systemd/system/         # Package services
~/.config/systemd/user/          # User services
```

**My take**: Use `/etc/systemd/system/` for custom services. It's the right place.

## Basic Service File

### Simple Service

```bash
# /etc/systemd/system/myservice.service
[Unit]
Description=My Custom Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/myservice
Restart=always
User=myuser

[Install]
WantedBy=multi-user.target
```

**My take**: This is a basic service file. Learn it. Use it.

### Service Sections

**Unit**: Service metadata
- `Description` = What the service does
- `After` = Start after these services

**Service**: How to run
- `Type` = Service type (simple, forking, oneshot)
- `ExecStart` = Command to run
- `Restart` = Restart policy
- `User` = Run as this user

**Install**: When to start
- `WantedBy` = Start with this target

**My take**: Three sections. Unit. Service. Install. Learn them.

## Common Service Types

### Type: simple

```bash
[Service]
Type=simple
ExecStart=/usr/bin/myapp
```

**My take**: Simple service runs in foreground. Most common.

### Type: forking

```bash
[Service]
Type=forking
ExecStart=/usr/bin/myapp
PIDFile=/var/run/myapp.pid
```

**My take**: Forking service daemonizes. Use when app forks.

### Type: oneshot

```bash
[Service]
Type=oneshot
ExecStart=/usr/bin/myscript
RemainAfterExit=yes
```

**My take**: Oneshot runs once. Use for scripts.

## Real-World Examples

### Python Application Service

```bash
[Unit]
Description=Python Web Application
After=network.target

[Service]
Type=simple
User=www-data
WorkingDirectory=/var/www/app
ExecStart=/usr/bin/python3 /var/www/app/app.py
Restart=always
Environment="PORT=8080"

[Install]
WantedBy=multi-user.target
```

### Script Service

```bash
[Unit]
Description=Backup Script Service
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/backup.sh
User=backup

[Install]
WantedBy=multi-user.target
```

## Enabling Services

```bash
# Reload systemd
sudo systemctl daemon-reload

# Enable service
sudo systemctl enable myservice.service

# Start service
sudo systemctl start myservice.service
```

**My take**: Reload. Enable. Start. That's the process.

## Common Mistakes (I've Made These)

1. **Not reloading systemd**: After creating service, reload systemd. `daemon-reload`

2. **Wrong ExecStart path**: Use absolute paths. Relative paths don't work.

3. **Wrong user**: Services run as root by default. Set user if needed.

4. **Not enabling**: Services don't start on boot unless enabled. Enable them.

5. **Wrong Type**: Choose the right type. Simple for most cases.

## What's Next?

Now that you can create services, let's talk about [Timers And Cron](/docs/linux/system-services/timers-cron) for scheduled tasks.

---

> **Personal note**: When I started, I'd run scripts manually. Then I learned systemd services. Now I create services for everything. They're reliable. They're automatic. Learn them.

