---
sidebar_position: 5
title: "Troubleshooting Techniques: Systematic Approach"
---

# Troubleshooting: Fix Problems Systematically

Troubleshooting is systematic. Check one thing at a time. Find the problem. Fix it.

**Here's the thing: Troubleshooting is a skill. Learn the approach. Use it.**

## The Troubleshooting Process

### 1. Understand the Problem

**Ask**:
- What's broken?
- When did it break?
- What changed?
- What should it do?

**My take**: Understand the problem first. Don't guess.

### 2. Reproduce the Problem

```bash
# Try to reproduce
# See if it happens consistently
```

**My take**: Reproduce the problem. If you can't reproduce it, you can't fix it.

### 3. Check Logs

```bash
# System logs
journalctl -p err --since "1 hour ago"

# Service logs
journalctl -u service-name -n 100

# Application logs
tail -f /var/log/app.log
```

**My take**: Logs tell you what's wrong. Check them first.

### 4. Check Status

```bash
# Service status
systemctl status service-name

# System resources
htop
df -h
```

**My take**: Check status. See what's running. See what's using resources.

### 5. Isolate the Problem

```bash
# Test components separately
# Find what works and what doesn't
```

**My take**: Isolate the problem. Narrow it down. Find the root cause.

### 6. Fix and Test

```bash
# Make the fix
# Test that it works
# Verify the problem is solved
```

**My take**: Fix it. Test it. Verify it works.

## Common Troubleshooting Areas

### Services Not Starting

```bash
# Check status
systemctl status service-name

# Check logs
journalctl -u service-name -n 100

# Test manually
sudo -u service-user /path/to/command
```

**My take**: Services fail for reasons. Check status. Check logs. Test manually.

### High Resource Usage

```bash
# Check CPU
top
htop

# Check memory
free -h

# Check disk I/O
sudo iotop

# Find the process
ps aux --sort=-%cpu | head -10
```

**My take**: High usage means something is using resources. Find it. Fix it.

### Network Problems

```bash
# Check interface
ip link show

# Check IP
ip addr show

# Test connectivity
ping 8.8.8.8

# Check DNS
nslookup google.com
```

**My take**: Network problems are systematic. Check one thing at a time.

## Systematic Approach

### Start Broad, Narrow Down

1. Check if system is running
2. Check if service is running
3. Check if network is working
4. Check specific component
5. Fix the problem

**My take**: Start broad. Narrow down. Find the problem.

## Common Mistakes (I've Made These)

1. **Jumping to conclusions**: Don't guess. Check systematically.

2. **Not checking logs**: Logs tell you everything. Check them.

3. **Changing too many things**: Change one thing at a time. Test results.

4. **Not documenting**: Document what you tried. Learn from it.

5. **Giving up too early**: Troubleshooting takes time. Be patient.

## Real-World Examples

### Service Won't Start

```bash
# 1. Check status
systemctl status myservice

# 2. Check logs
journalctl -u myservice -n 100

# 3. Test manually
sudo -u service-user /usr/local/bin/myservice

# 4. Check permissions
ls -la /usr/local/bin/myservice

# 5. Fix and restart
sudo systemctl restart myservice
```

### System is Slow

```bash
# 1. Check resources
htop
df -h

# 2. Find resource hogs
ps aux --sort=-%cpu | head -10

# 3. Check I/O
sudo iotop

# 4. Fix the problem
```

## What's Next?

Now that you understand troubleshooting, you can fix problems systematically. Or review [Logging](/docs/linux/logging-monitoring/syslog-systemd-journal) to understand logs better.

---

> **Personal note**: Troubleshooting used to frustrate me. Then I learned the systematic approach. Now I troubleshoot methodically. It works. Learn it.


