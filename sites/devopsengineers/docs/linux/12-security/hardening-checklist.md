---
sidebar_position: 5
title: ""System Hardening: Security Checklist""
---

# System Hardening: Secure Your System

System hardening secures your Linux system. Follow this checklist.

**Here's the thing: Hardening reduces attack surface. Follow basics. You'll be more secure.**

## Hardening Checklist

### 1. System Updates

```bash
sudo apt update && sudo apt upgrade

# Enable automatic security updates
sudo apt install unattended-upgrades
```

**My take**: Updates fix security holes. Update regularly.

### 2. User Management

```bash
# Disable root login
sudo passwd -l root

# Remove unused users
sudo userdel unused_user

# Set password policies
sudo chage -M 90 username
```

**My take**: Secure users. Remove unused accounts. Set policies.

### 3. SSH Hardening

```bash
# /etc/ssh/sshd_config
PermitRootLogin no
PasswordAuthentication no          # Use keys only
Port 2222                          # Change default
MaxAuthTries 3
```

**My take**: Harden SSH. Disable root. Use keys. Change port.

### 4. Firewall

```bash
sudo ufw enable
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
```

**My take**: Enable firewall. Block unwanted traffic.

### 5. Remove Unused Services

```bash
# List services
systemctl list-units --type=service

# Stop and disable unused
sudo systemctl stop service-name
sudo systemctl disable service-name
```

**My take**: Remove unused services. Fewer services = smaller attack surface.

### 6. File Permissions

```bash
# Set correct permissions
chmod 600 secret.txt
chmod 644 config.txt
chmod 755 script.sh
```

**My take**: Set permissions correctly. Don't use 777.

### 7. Monitoring

```bash
# Monitor logs
journalctl -p err --since "1 hour ago"

# Check failed logins
grep "Failed password" /var/log/auth.log
```

**My take**: Monitor logs. Detect threats early.

## Complete Checklist

- [ ] System updated
- [ ] Root login disabled
- [ ] SSH hardened
- [ ] Firewall enabled
- [ ] Unused services removed
- [ ] Permissions set correctly
- [ ] Logs monitored
- [ ] Backups configured

**My take**: Follow this checklist. Your system will be more secure.

## Common Mistakes (I've Made These)

1. **Skipping updates**: Updates fix security holes. Don't skip them.

2. **Using root for everything**: Don't. Use sudo. Give minimum permissions.

3. **No firewall**: Enable firewall. Block unwanted traffic.

4. **Weak passwords**: Use strong passwords. Or better: SSH keys.

5. **Not monitoring**: Monitor logs. Detect threats.

## Real-World Examples

### Secure New System

```bash
# Update
sudo apt update && sudo apt upgrade

# Harden SSH
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Enable firewall
sudo ufw enable
sudo ufw allow 22/tcp
```

## What's Next?

Now that you understand hardening, your system is more secure. Or review what you've learned. You're ready.

---

> **Personal note**: Hardening seemed tedious at first. Then I had a security incident. Now I harden everything. It's worth it. Follow the checklist.
