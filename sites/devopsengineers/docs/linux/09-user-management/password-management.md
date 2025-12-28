---
sidebar_position: 4
title: "Password Management: Securing Accounts"
---

# Password Management: Secure Accounts

Password management secures accounts. Set policies. Enforce them.

**Here's the thing: Passwords matter. But SSH keys are better. Use keys when possible.**

## Setting Passwords

### Change Password

```bash
passwd                            # Change your password
sudo passwd username              # Change another user's password
```

**My take**: `passwd` changes passwords. Use it.

### Force Password Change

```bash
sudo passwd -e username            # Expire password (force change)
```

**My take**: Force password change on first login. Good practice.

## Password Policies

### Set Expiration

```bash
# 90 days
sudo chage -M 90 username

# Never expire
sudo chage -M -1 username
```

**My take**: Expire passwords regularly. 90 days is common.

### Set Minimum Age

```bash
sudo chage -m 7 username           # 7 days minimum
```

**My take**: Prevent frequent changes. Set minimum age.

### Set Warning

```bash
sudo chage -W 7 username            # Warn 7 days before expiry
```

**My take**: Warn users before expiry. Give them time.

### View Password Info

```bash
chage -l username
```

**My take**: `chage -l` shows password info. Use it.

## Password Quality

### Install Password Quality Module

```bash
# Debian/Ubuntu
sudo apt install libpam-pwquality

# Configure
sudo vim /etc/pam.d/common-password
```

**My take**: Password quality modules enforce strong passwords. Use them.

### Password Requirements

```bash
# In /etc/pam.d/common-password
password requisite pam_pwquality.so minlen=8 difok=3
```

**My take**: Require strong passwords. 8+ characters. Mix of types.

## SSH Keys (Better Than Passwords)

### Use SSH Keys

```bash
# Generate key
ssh-keygen -t ed25519

# Copy to server
ssh-copy-id user@server
```

**My take**: SSH keys are more secure than passwords. Use them.

### Disable Password Authentication

```bash
# In /etc/ssh/sshd_config
PasswordAuthentication no

# Restart SSH
sudo systemctl restart sshd
```

**My take**: Once keys work, disable passwords. More secure.

## Common Patterns

### Set Password Policy

```bash
sudo chage -M 90 -m 7 -W 7 username
```

### Force Password Change

```bash
sudo passwd -e username
```

## Common Mistakes (I've Made These)

1. **Weak passwords**: Enforce strong passwords. Use password quality module.

2. **Never expiring**: Passwords should expire. Set expiration.

3. **Using passwords instead of keys**: SSH keys are better. Use them.

4. **Not enforcing policies**: Set policies. Enforce them.

5. **Sharing passwords**: Don't share passwords. Use sudo. Use keys.

## Real-World Examples

### Setup Password Policy

```bash
# Set expiration
sudo chage -M 90 username

# Set minimum age
sudo chage -m 7 username

# Set warning
sudo chage -W 7 username
```

### Force Password Change

```bash
sudo passwd -e username
# User must change on next login
```

## What's Next?

Now that you understand password management, let's talk about [Access Control](/docs/linux/user-management/access-control) for fine-grained permissions.

---

> **Personal note**: I used to use weak passwords. Then I learned password policies. Now I enforce them. But SSH keys are better. Use keys when possible.

