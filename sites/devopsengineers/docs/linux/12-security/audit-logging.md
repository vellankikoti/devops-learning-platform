---
sidebar_position: 4
title: ""Audit Logging: Tracking System Activity""
---

# Audit Logging: Track Everything

Audit logging records system activity. For security. For compliance.

**Here's the thing: Audit logs track everything. Use them to detect threats. Investigate incidents.**

## What Audit Logs Record

Audit logs record:
- File access
- System calls
- User actions
- Security events

**My take**: Audit logs are like security cameras. They record everything.

## auditd: Audit Daemon

### Check Status

```bash
sudo systemctl status auditd
sudo auditctl -s                 # Show status
```

**My take**: `auditd` is the audit daemon. It records events.

### View Logs

```bash
# All events
sudo ausearch -m all

# File events
sudo ausearch -m file

# Recent events
sudo ausearch -ts recent

# Specific user
sudo ausearch -ua username
```

**My take**: `ausearch` searches audit logs. Use it to find events.

### Reports

```bash
sudo aureport                    # Summary
sudo aureport -u                 # User report
sudo aureport -f                 # File report
```

**My take**: `aureport` generates reports. Easier to read than raw logs.

## When to Use Audit Logging

**Use when**:
- Security requirements
- Compliance needs
- Incident investigation
- Threat detection

**Don't use when**:
- Simple setup
- Don't need tracking
- Performance critical

**My take**: Audit logging is for security. Use it when you need tracking.

## Common Mistakes (I've Made These)

1. **Too much logging**: Audit logs can be huge. Configure carefully.

2. **Not monitoring**: Logs are useless if not monitored. Monitor them.

3. **Not rotating**: Logs accumulate. Rotate them.

4. **Not understanding events**: Audit events are complex. Learn them.

5. **Performance impact**: Audit logging adds overhead. Consider performance.

## Real-World Examples

### Check Recent Events

```bash
sudo ausearch -ts recent
```

### Find File Access

```bash
sudo ausearch -m file -f /etc/passwd
```

### User Activity

```bash
sudo ausearch -ua username
```

## What's Next?

Now that you understand audit logging, you can track activity. Or learn about [System Hardening](/docs/linux/security/hardening-checklist) to secure systems.

---

> **Personal note**: Audit logging seemed unnecessary at first. Then I needed to investigate an incident. Now I use it. It's essential for security.
