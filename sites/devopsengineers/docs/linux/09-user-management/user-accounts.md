---
sidebar_position: 1
title: User Account Management
---

# User Accounts: Who Can Access What

User accounts control access. Who can log in. What they can do. Where they can go.

**Here's the thing: User management is essential. You'll create users. You'll manage them. You'll control access.**

## The Basic Concept

Every process runs as a user. Every file has an owner. Users control access.

**Think of it like a building**: Each person has an ID. Different access levels. Their actions are tracked.

## Viewing Users

### Current User

```bash
whoami                            # Current username
id                                # Your IDs and groups
```

**Real example**:
```bash
$ whoami
ubuntu
$ id
uid=1000(ubuntu) gid=1000(ubuntu) groups=1000(ubuntu),27(sudo)
```

### User Information

```bash
cat /etc/passwd                   # All users
getent passwd username            # Specific user
```

**The `/etc/passwd` file**: User database.

**Format**: `username:x:UID:GID:comment:home:shell`

**Example**: `ubuntu:x:1000:1000:Ubuntu:/home/ubuntu:/bin/bash`

**What matters**:
- **username** = Login name
- **UID** = User ID (0 = root, 1000+ = regular)
- **GID** = Primary group ID
- **home** = Home directory
- **shell** = Default shell

**My take**: UID 0 is root. UID 1000+ are regular users. That's what you need to know.

## Creating Users

### useradd: Add User

```bash
sudo useradd username             # Basic (no home directory)
sudo useradd -m username         # With home directory
sudo useradd -m -s /bin/bash username  # With home and shell
```

**Common options**:
- `-m` = Create home directory
- `-s` = Set shell
- `-c` = Comment (full name)
- `-G` = Secondary groups
- `-u` = User ID

**Real example**:
```bash
sudo useradd -m -s /bin/bash -c "John Doe" -G sudo,developers john
```

**My take**: Use `-m` to create home directory. Users need homes.

### Setting Password

```bash
sudo passwd username             # Set password
```

**Real example**:
```bash
sudo passwd john
```

**My take**: Set passwords after creating users. Or use SSH keys. Passwords are less secure.

## Modifying Users

### usermod: Modify User

```bash
sudo usermod -s /bin/zsh username        # Change shell
sudo usermod -G group1,group2 username   # Change groups
sudo usermod -L username                  # Lock account
sudo usermod -U username                  # Unlock account
```

**My take**: `usermod` changes user properties. Use it to modify accounts.

## Deleting Users

### userdel: Delete User

```bash
sudo userdel username             # Delete user (keeps home)
sudo userdel -r username          # Delete with home directory
```

**The `-r` flag**: Removes home directory too.

**My take**: Use `-r` to remove everything. Or keep home for backups. Your choice.

## Groups

### Viewing Groups

```bash
groups                            # Your groups
groups username                    # Another user's groups
getent group groupname            # Group details
cat /etc/group                    # All groups
```

### Creating Groups

```bash
sudo groupadd groupname           # Create group
```

**My take**: Groups organize users. Share permissions. Useful for shared access.

### Adding Users to Groups

```bash
sudo usermod -aG groupname username  # Add to group
```

**The `-aG` flags**: Append to groups (doesn't remove existing).

**My take**: Use `-aG` to add to groups. Without `-a`, it replaces groups.

## Common Patterns

### Create User with Home

```bash
sudo useradd -m -s /bin/bash username
sudo passwd username
```

### Add User to sudo Group

```bash
sudo usermod -aG sudo username
```

**My take**: Sudo group gives admin access. Add users who need it.

### Lock Account

```bash
sudo usermod -L username          # Lock
sudo usermod -U username          # Unlock
```

**My take**: Lock accounts when users leave. Unlock when they return.

## Common Mistakes (I've Made These)

1. **Forgetting `-m`**: Users created without home directories. They can't log in properly.

2. **Not setting password**: Users can't log in. Set passwords or use SSH keys.

3. **Using `-G` without `-a`**: Replaces groups instead of adding. Use `-aG`.

4. **Deleting users without backup**: User data is lost. Backup first if needed.

5. **Not checking if user exists**: `id username` to check. Don't create duplicates.

## Real-World Examples

### Create Developer User

```bash
sudo useradd -m -s /bin/bash -c "Developer" -G developers,sudo devuser
sudo passwd devuser
```

### Create Service User

```bash
sudo useradd -r -s /bin/false -d /var/lib/service serviceuser
```

**The `-r` flag**: Creates system user (UID < 1000).

**My take**: Service users don't need shells. Use `/bin/false`. They don't log in.

### Add User to Multiple Groups

```bash
sudo usermod -aG group1,group2,group3 username
```

## What's Next?

Now that you can manage users, you can control access. Or learn about [Security](/docs/linux/security/security-fundamentals) to protect your system.

---

> **Personal note**: When I started, I'd create users without home directories. Then they couldn't log in. I learned to use `-m`. Now users work properly. Small details matter. Learn them.
