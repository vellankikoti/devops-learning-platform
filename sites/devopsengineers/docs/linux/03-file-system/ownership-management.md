---
sidebar_position: 3
title: Ownership Management
---

# File Ownership: Who Owns What

Every file has an owner and a group. That's how Linux controls access.

**Here's the thing: Ownership matters. It controls who can do what. Learn it.**

## The Basic Concept

Every file has:
- **Owner** - The user who created it
- **Group** - The group it belongs to
- **Others** - Everyone else

**Think of it like a house**: You own it. Your family (group) shares it. Guests (others) can visit. Different access levels.

## Users and Groups

### Users

```bash
whoami                            # Current user
id                                # Your IDs and groups
id username                       # Another user's IDs
```

**User file**: `/etc/passwd`
```bash
cat /etc/passwd
# Format: username:x:UID:GID:comment:home:shell
# Example: ubuntu:x:1000:1000:Ubuntu:/home/ubuntu:/bin/bash
```

**What matters**:
- **username** = Login name
- **UID** = User ID (0 = root, 1000+ = regular users)
- **GID** = Primary group ID
- **home** = Home directory
- **shell** = Default shell

**My take**: UID 0 is root. UID 1000+ are regular users. That's what you need to know.

### Groups

```bash
groups                            # Your groups
groups username                    # Another user's groups
getent group groupname            # Group details
```

**Group file**: `/etc/group`
```bash
cat /etc/group
# Format: groupname:x:GID:members
# Example: sudo:x:27:ubuntu,john
```

**My take**: Groups are collections of users. Share permissions. Organize access.

## chown: Change Owner

```bash
sudo chown user:group file.txt
sudo chown user file.txt           # Just owner
sudo chown :group file.txt          # Just group
sudo chown -R user:group dir/       # Recursive
```

**Real examples**:
```bash
sudo chown www-data:www-data /var/www/html
sudo chown ubuntu:ubuntu script.sh
sudo chown -R ubuntu:ubuntu /home/ubuntu/projects
```

**My take**: Use `chown` to change ownership. Usually for web servers. Files need to be owned by the right user.

## chgrp: Change Group

```bash
sudo chgrp group file.txt
sudo chgrp -R group directory/     # Recursive
```

**My take**: `chown` can do this. `chgrp` is just a shortcut. Use whichever you prefer.

## Common Patterns

### Web Server Files

```bash
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html
```

**My take**: Web server needs to read files. Owner needs to write. This is the pattern.

### User Files

```bash
sudo chown -R user:user /home/user
```

**My take**: User should own their home directory. Simple.

### Shared Directories

```bash
sudo chown -R :sharedgroup /shared
sudo chmod -R 775 /shared
```

**My take**: Group ownership for shared directories. Multiple users can access.

## Understanding IDs

```bash
id
# uid=1000(ubuntu) gid=1000(ubuntu) groups=1000(ubuntu),27(sudo)
```

**Breaking it down**:
- **uid** = User ID
- **gid** = Primary group ID
- **groups** = All groups (primary + secondary)

**My take**: IDs are numbers. Names are labels. System uses IDs. You use names.

## Common Mistakes (I've Made These)

1. **Forgetting sudo**: Changing ownership needs root. Use `sudo`.

2. **Wrong user/group**: Make sure user and group exist. `id username` to check.

3. **Not using -R for directories**: `-R` is recursive. Needed for directories.

4. **Changing system files**: Don't change ownership of system files. Bad things happen.

5. **Not checking current ownership**: `ls -l` shows ownership. Check before changing.

## Real-World Examples

### Fix Web Server Permissions

```bash
sudo chown -R www-data:www-data /var/www/html
sudo find /var/www/html -type f -exec chmod 644 {} \;
sudo find /var/www/html -type d -exec chmod 755 {} \;
```

### Transfer Ownership

```bash
sudo chown -R newuser:newuser /home/olduser
```

### Shared Project Directory

```bash
sudo chgrp -R developers /projects
sudo chmod -R 775 /projects
```

## What's Next?

Now that you understand ownership, you can manage file access. Or learn about [Links](/docs/linux/file-system/links-symbolic-hard) to create file shortcuts.

---

> **Personal note**: When I started, I'd use `sudo chown` for everything. Then I learned about proper ownership. Now I set it correctly. Ownership is Linux's way of organizing access. Learn it. Use it.
