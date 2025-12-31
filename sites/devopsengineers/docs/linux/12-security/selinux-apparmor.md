---
sidebar_position: 2
title: "SELinux And AppArmor: Mandatory Access Control"
---

# SELinux and AppArmor: Advanced Security

SELinux and AppArmor add extra security. Beyond standard permissions.

**Here's the thing: These are advanced. You might not need them. But when you do, they're powerful.**

## What They Do

Mandatory Access Control (MAC) restricts what processes can do:
- Beyond standard permissions
- Process-level restrictions
- Prevents privilege escalation

**My take**: MAC is like extra security. Even with permissions, processes are restricted.

## SELinux

### Check Status

```bash
getenforce                        # Enforcing, Permissive, or Disabled
```

**States**:
- **Enforcing** = Active, blocks violations
- **Permissive** = Logs violations, doesn't block
- **Disabled** = Off

**My take**: Enforcing blocks. Permissive logs. Use permissive for testing.

### Common Commands

```bash
# View context
ls -Z                             # Show SELinux context

# Fix context
sudo restorecon -R /var/www/html

# Check if blocking
sudo ausearch -m avc -ts recent
```

**My take**: SELinux uses contexts. Files and processes have contexts. They must match.

## AppArmor

### Check Status

```bash
sudo aa-status                     # Show status
```

**My take**: AppArmor is simpler than SELinux. Easier to use.

### Profiles

```bash
# List profiles
sudo aa-status

# Enable profile
sudo aa-enforce profile_name

# Complain mode (log only)
sudo aa-complain profile_name
```

**My take**: AppArmor uses profiles. Each application has a profile.

## When to Use

**Use when**:
- High security requirements
- Compliance needs
- Multi-tenant systems
- Defense in depth

**Don't use when**:
- Simple setup
- Don't need extra security
- Learning basics

**My take**: These are advanced. Use them when you need extra security. Otherwise, standard permissions are enough.

## Common Mistakes (I've Made These)

1. **Too complex for simple needs**: MAC adds complexity. Use when needed.

2. **Not understanding contexts**: SELinux contexts must match. Learn them.

3. **Disabling instead of fixing**: Don't disable. Fix the issue.

4. **Not testing in permissive**: Test in permissive first. Then enforce.

5. **Ignoring audit logs**: Audit logs tell you what's blocked. Read them.

## Real-World Examples

### Check SELinux Status

```bash
getenforce
```

### Fix SELinux Context

```bash
sudo restorecon -R /var/www/html
```

### Check AppArmor

```bash
sudo aa-status
```

## What's Next?

Now that you understand MAC, you have advanced security. Or learn about [Encryption](/docs/linux/security/encryption) to protect data.

---

> **Personal note**: SELinux seemed complex at first. Then I used it. Now I appreciate it. But you might not need it. Use it when you do.
