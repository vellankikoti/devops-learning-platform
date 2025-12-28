---
sidebar_position: 3
title: "Sudo Privileges: Granting Admin Access"
---

# Sudo: Granting Admin Access

Sudo lets users run commands as root. Without giving them the root password.

**Here's the thing: Sudo is how you grant admin access. Learn it. Use it. Don't share root password.**

## What Sudo Does

Sudo:
- Runs commands as root
- Requires user password (not root)
- Logs all commands
- Granular control

**My take**: Sudo is secure admin access. Use it. Don't use root directly.

## Basic Sudo Usage

### Run Command as Root

```bash
sudo command
sudo apt update
sudo systemctl restart nginx
```

**My take**: `sudo` runs commands as root. Use it for admin tasks.

### Check Sudo Access

```bash
sudo -l                            # List your sudo privileges
```

**My take**: `sudo -l` shows what you can do. Check it.

## Granting Sudo Access

### Add to sudo Group

```bash
sudo usermod -aG sudo username
```

**My take**: Sudo group gives full admin access. Add users who need it.

### Edit sudoers File

```bash
sudo visudo                        # Edit sudoers (safe)
```

**My take**: `visudo` edits sudoers safely. Use it. Don't edit directly.

### Sudoers Syntax

```bash
# Full admin access
username ALL=(ALL:ALL) ALL

# Specific command
username ALL=(ALL) /usr/bin/systemctl

# No password
username ALL=(ALL) NOPASSWD: ALL

# Specific user
username ALL=(root) /usr/bin/systemctl
```

**My take**: Sudoers syntax is: user host=(runas) commands. Learn it.

## Common Patterns

### Full Admin Access

```bash
# In sudoers
developer ALL=(ALL:ALL) ALL
```

**My take**: Full access for trusted users. Use carefully.

### Limited Commands

```bash
# In sudoers
operator ALL=(ALL) /usr/bin/systemctl, /usr/bin/docker
```

**My take**: Limit to specific commands. More secure.

### No Password

```bash
# In sudoers
ci-user ALL=(ALL) NOPASSWD: /usr/bin/deploy.sh
```

**My take**: No password for automation. Use for scripts.

## Common Mistakes (I've Made These)

1. **Editing sudoers directly**: Use `visudo`. It checks syntax.

2. **Giving full access unnecessarily**: Give only what's needed. Principle of least privilege.

3. **Not testing**: Test sudo access. Make sure it works.

4. **Forgetting NOPASSWD**: Scripts need NOPASSWD. Don't forget.

5. **Locking yourself out**: Always keep one sudo user. Don't remove all.

## Real-World Examples

### Grant Full Access

```bash
sudo usermod -aG sudo username
```

### Grant Limited Access

```bash
sudo visudo
# Add: username ALL=(ALL) /usr/bin/systemctl
```

### Grant for Automation

```bash
sudo visudo
# Add: ci-user ALL=(ALL) NOPASSWD: /usr/bin/deploy.sh
```

## What's Next?

Now that you understand sudo, let's talk about [Password Management](/docs/linux/user-management/password-management) to secure accounts.

---

> **Personal note**: When I started, I'd share root password. Then I learned sudo. Now I use sudo for everything. It's secure. It's logged. Use it.

