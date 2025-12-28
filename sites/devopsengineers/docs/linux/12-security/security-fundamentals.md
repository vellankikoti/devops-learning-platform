---
sidebar_position: 1
title: ""Security Fundamentals: Protecting Your System""
---

# Security: Protect Your System

Security protects your system. Your data. Your users.

**Here's the thing: Security is essential. But it's not complicated. Follow basics. You'll be fine.**

## Core Principles

### 1. Least Privilege

**What**: Users get minimum permissions needed.

**How**:
- Don't use root for everything
- Use sudo for specific tasks
- Limit user permissions
- Restrict service accounts

**My take**: Don't run as root. Use sudo. Give users only what they need.

### 2. Defense in Depth

**What**: Multiple security layers.

**Layers**:
- Network firewall
- Host firewall
- Access controls
- Encryption
- Monitoring

**My take**: One layer isn't enough. Use multiple layers.

### 3. Regular Updates

```bash
sudo apt update && sudo apt upgrade
```

**My take**: Updates fix security holes. Update regularly.

## User Security

### Strong Passwords

```bash
# Enforce password policy
sudo chage -M 90 username         # 90 day expiration
sudo chage -m 7 username          # 7 day minimum
```

**My take**: Strong passwords matter. But SSH keys are better.

### Disable Root Login

```bash
# Edit /etc/ssh/sshd_config
PermitRootLogin no

# Restart SSH
sudo systemctl restart sshd
```

**My take**: Root shouldn't SSH directly. Disable it.

### Limit Sudo Access

```bash
# Edit /etc/sudoers
username ALL=(ALL) NOPASSWD: /usr/bin/systemctl
```

**My take**: Limit sudo. Give only what's needed.

## Network Security

### Firewall

```bash
# UFW (Ubuntu)
sudo ufw enable
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
```

**My take**: Firewall blocks unwanted traffic. Enable it.

### Close Unused Ports

```bash
# Check listening ports
ss -tlnp

# Stop unused services
sudo systemctl stop service-name
sudo systemctl disable service-name
```

**My take**: Close ports you don't need. Fewer ports = less attack surface.

## File Security

### Permissions

```bash
chmod 600 secret.txt              # Owner only
chmod 644 config.txt              # Owner read+write, others read
chmod 755 script.sh               # Owner full, others read+execute
```

**My take**: Set permissions correctly. Don't use 777. Ever.

### Ownership

```bash
sudo chown user:group file.txt
```

**My take**: Files should be owned by the right user. Check ownership.

## Common Security Practices

### Keep System Updated

```bash
sudo apt update && sudo apt upgrade
```

### Use SSH Keys

```bash
# Instead of passwords
ssh-keygen -t ed25519
ssh-copy-id user@host
```

**My take**: SSH keys are more secure than passwords. Use them.

### Monitor Logs

```bash
journalctl -p err --since "1 hour ago"
grep -i "failed" /var/log/auth.log
```

**My take**: Logs show security issues. Monitor them.

## Common Mistakes (I've Made These)

1. **Using root for everything**: Don't. Use sudo. Give minimum permissions.

2. **Weak passwords**: Use strong passwords. Or better: SSH keys.

3. **No firewall**: Enable firewall. Block unwanted traffic.

4. **Open ports**: Close ports you don't need. Fewer ports = safer.

5. **Not updating**: Updates fix security holes. Update regularly.

## Real-World Examples

### Secure SSH

```bash
# Disable root login
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

# Change port (optional)
sudo sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config

# Restart
sudo systemctl restart sshd
```

### Enable Firewall

```bash
sudo ufw enable
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw status
```

### Check Security

```bash
# Check listening ports
ss -tlnp

# Check failed logins
grep "Failed password" /var/log/auth.log

# Check sudo usage
grep sudo /var/log/auth.log
```

## What's Next?

Now that you understand security basics, let's talk about [SELinux and AppArmor](/docs/linux/security/selinux-apparmor) for advanced security.

---

> **Personal note**: When I started, I'd run everything as root. Then I learned security. Now I use sudo. I enable firewalls. I update regularly. Security is about basics. Follow them.
