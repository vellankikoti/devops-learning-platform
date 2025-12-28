---
sidebar_position: 5
title: "Access Control: Fine-Grained Permissions"
---

# Access Control: Beyond Basic Permissions

Access control goes beyond basic permissions. ACLs. PAM. Fine-grained control.

**Here's the thing: Sometimes basic permissions aren't enough. ACLs give you more control.**

## ACLs: Access Control Lists

### Install ACL Support

```bash
# Debian/Ubuntu
sudo apt install acl

# RHEL/CentOS
sudo dnf install acl
```

**My take**: ACLs need support. Install it first.

### Enable ACL on Filesystem

```bash
# In /etc/fstab
UUID=xxx /data ext4 defaults,acl 0 2

# Remount
sudo mount -o remount /data
```

**My take**: Filesystem must support ACLs. Enable in fstab.

### Set ACL

```bash
# Set ACL for user
setfacl -m u:username:rwx file.txt

# Set ACL for group
setfacl -m g:groupname:rx directory/

# Remove ACL
setfacl -x u:username file.txt
```

**My take**: `setfacl` sets ACLs. More flexible than basic permissions.

### View ACL

```bash
getfacl file.txt
```

**My take**: `getfacl` shows ACLs. Use it to see permissions.

## PAM: Pluggable Authentication Modules

### What PAM Does

PAM handles authentication. Login. SSH. sudo.

**My take**: PAM controls authentication. Configure it for security.

### PAM Configuration

```bash
# Files in /etc/pam.d/
/etc/pam.d/login
/etc/pam.d/sshd
/etc/pam.d/sudo
```

**My take**: PAM configs are in `/etc/pam.d/`. Edit carefully.

## Common ACL Patterns

### Multiple Users

```bash
# Allow multiple users
setfacl -m u:user1:rwx,u:user2:rx file.txt
```

### Default ACLs

```bash
# Set default ACL (inherited by new files)
setfacl -d -m u:username:rwx directory/
```

**My take**: Default ACLs apply to new files. Useful for directories.

## When to Use ACLs

**Use ACLs when**:
- Need multiple users with different permissions
- Basic permissions aren't enough
- Complex permission requirements

**Use basic permissions when**:
- Simple owner/group/others is enough
- Don't need fine-grained control

**My take**: Use ACLs when needed. Basic permissions work for most cases.

## Common Mistakes (I've Made These)

1. **Not enabling ACL support**: Filesystem must support ACLs. Enable it.

2. **Too complex**: ACLs can get complex. Keep it simple.

3. **Not understanding inheritance**: Default ACLs inherit. Understand them.

4. **Mixing ACLs and basic permissions**: Can be confusing. Be consistent.

5. **Not documenting**: ACLs are complex. Document them.

## Real-World Examples

### Shared Directory with ACLs

```bash
# Create directory
sudo mkdir /shared
sudo chmod 750 /shared

# Set ACLs
sudo setfacl -m u:user1:rwx /shared
sudo setfacl -m u:user2:rx /shared
sudo setfacl -d -m u:user1:rwx /shared
```

## What's Next?

Now that you understand access control, you can manage permissions finely. Or review [User Management](/docs/linux/user-management/user-accounts) to understand users better.

---

> **Personal note**: ACLs seemed complex at first. Then I needed them. Now I use them when basic permissions aren't enough. They're powerful. Use them when needed.

