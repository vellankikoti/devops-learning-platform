---
sidebar_position: 5
title: "Service Troubleshooting: Fixing Issues"
---

# Service Troubleshooting: When Things Go Wrong

Services fail. They don't start. They crash. You need to fix them.

**Here's the thing: Troubleshooting services is essential. Learn it. You'll use it constantly.**

## Check Service Status

```bash
systemctl status service-name
```

**What it shows**:
- Service state (active, failed, inactive)
- Recent log entries
- Process information
- Error messages

**My take**: `status` is your first step. It shows what's wrong.

## View Service Logs

```bash
# Journal logs
journalctl -u service-name
journalctl -u service-name -n 50    # Last 50 lines
journalctl -u service-name -f        # Follow logs

# Recent errors
journalctl -u service-name -p err
```

**My take**: Logs tell you why services fail. Read them.

## Common Issues

### Service Won't Start

```bash
# Check status
systemctl status service-name

# Check logs
journalctl -u service-name -n 100

# Check configuration
systemctl cat service-name
```

**My take**: Check status. Check logs. Check configuration. Find the problem.

### Service Crashes

```bash
# Check restart count
systemctl status service-name | grep "Main PID"

# Check logs for errors
journalctl -u service-name -p err

# Check if it's restarting
systemctl status service-name
```

**My take**: Crashes show in logs. Find the error. Fix it.

### Service Fails to Enable

```bash
# Check if service file exists
systemctl cat service-name

# Check syntax
systemctl daemon-reload
systemctl status service-name
```

**My take**: Enable failures are usually syntax errors. Check the service file.

## Debugging Steps

### 1. Check Status

```bash
systemctl status service-name
```

### 2. Check Logs

```bash
journalctl -u service-name -n 100
```

### 3. Test Manually

```bash
# Run command manually
sudo -u service-user /path/to/command
```

**My take**: Run manually. See if it works. If it does, it's a service config issue.

### 4. Check Permissions

```bash
# Check file permissions
ls -la /path/to/service/file

# Check user
id service-user
```

**My take**: Permissions matter. Check them.

### 5. Check Dependencies

```bash
# Check what service needs
systemctl list-dependencies service-name
```

**My take**: Services need dependencies. Make sure they're running.

## Common Mistakes (I've Made These)

1. **Not checking logs**: Logs tell you everything. Check them first.

2. **Not testing manually**: Test commands manually. See if they work.

3. **Wrong user/permissions**: Services need correct user and permissions.

4. **Missing dependencies**: Services need dependencies. Make sure they're available.

5. **Not reloading systemd**: After changing service files, reload systemd.

## Real-World Examples

### Debug Failed Service

```bash
# Check status
systemctl status myservice

# Check logs
journalctl -u myservice -n 100

# Test manually
sudo -u service-user /usr/local/bin/myservice

# Fix and restart
sudo systemctl restart myservice
```

### Check Service Configuration

```bash
# View service file
systemctl cat myservice

# Check if enabled
systemctl is-enabled myservice

# Check dependencies
systemctl list-dependencies myservice
```

## What's Next?

Now that you can troubleshoot services, you can fix problems. Or review [System Services](/docs/linux/system-services/systemd-overview) to understand services better.

---

> **Personal note**: When services fail, I used to panic. Then I learned troubleshooting. Now I check status. Check logs. Fix the problem. It's systematic. Learn it.

