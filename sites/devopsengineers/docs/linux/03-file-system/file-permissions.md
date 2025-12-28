---
sidebar_position: 2
title: File Permissions Explained
---

# File Permissions: Who Can Do What

Permissions control who can read, write, and execute files. That's Linux's security system.

**Understanding permissions is essential. You'll deal with them constantly.**

## The Basic Concept

Every file has permissions for three types of users:
- **Owner** - The user who created it
- **Group** - Users in the file's group
- **Others** - Everyone else

**Think of it like a house**: Owner has full access. Family (group) has some access. Guests (others) have limited access.

## Reading Permissions

```bash
ls -l file.txt
```

**Output**:
```
-rw-r--r-- 1 ubuntu ubuntu 1234 Dec 28 10:30 file.txt
```

**Breaking it down**:
- First character: `-` = file, `d` = directory
- Next 9 characters: Permissions (3 groups of 3)
  - First 3: Owner (rw-)
  - Next 3: Group (r--)
  - Last 3: Others (r--)

**Permission types**:
- **r** (read) = Can view file
- **w** (write) = Can modify file
- **x** (execute) = Can run file as program

**For directories**:
- **r** = Can list directory
- **w** = Can create/delete files
- **x** = Can enter directory (cd into it)

**Memory trick**: r=read, w=write, x=execute (or enter for directories).

## Numeric Permissions (The Numbers Way)

Permissions can be numbers:
- r (read) = 4
- w (write) = 2
- x (execute) = 1
- Combine by adding: rwx = 4+2+1 = 7

**Common combinations**:
- 7 = rwx (read, write, execute)
- 6 = rw- (read, write)
- 5 = r-x (read, execute)
- 4 = r-- (read only)
- 0 = --- (no permissions)

**Three-digit notation**:
- 755 = rwxr-xr-x (owner: full, group: read+execute, others: read+execute)
- 644 = rw-r--r-- (owner: read+write, group: read, others: read)
- 600 = rw------- (owner: read+write, others: nothing)

**My take**: Learn numeric permissions. They're easier to use than letters.

## chmod: Change Permissions

```bash
chmod 755 file.txt               # Numeric
chmod u+x file.txt               # Add execute for owner
chmod g-w file.txt               # Remove write for group
chmod o+r file.txt               # Add read for others
chmod a+x file.txt               # Add execute for all
chmod -R 755 directory/          # Recursive (all files)
```

**The letters**:
- `u` = user (owner)
- `g` = group
- `o` = others
- `a` = all

**Real examples**:
```bash
chmod +x script.sh               # Make executable
chmod 600 secret.txt            # Owner only (read+write)
chmod 755 script.sh              # Owner: full, others: read+execute
chmod -R 644 /var/www/html      # All files: read+write for owner, read for others
```

**My take**: Use numeric for setting. Use letters for modifying. `chmod +x` is common. `chmod 755` is common. Learn those.

## Common Permission Patterns

### Scripts (Executable)

```bash
chmod +x script.sh              # Make executable
chmod 755 script.sh             # Same thing (rwxr-xr-x)
```

**My take**: Scripts need execute permission. `chmod +x` is what you'll use.

### Configuration Files

```bash
chmod 644 config.txt            # Owner: read+write, others: read
chmod 600 secret.txt            # Owner only
```

**My take**: Config files usually 644. Secret files 600. Simple.

### Directories

```bash
chmod 755 directory/            # Owner: full, others: read+execute
chmod 700 private/              # Owner only
```

**My take**: Directories usually 755. Private directories 700.

## umask: Default Permissions

```bash
umask                           # Show current umask
umask 022                       # Set umask
```

**What it does**: Controls default permissions for new files.

**How it works**: Subtracts from 666 (files) or 777 (directories).

**Common umasks**:
- 022 = Files: 644, Directories: 755 (common)
- 002 = Files: 664, Directories: 775 (group writable)
- 077 = Files: 600, Directories: 700 (owner only)

**My take**: Most systems use 022. That's fine. Don't change it unless you need to.

## chown: Change Owner

```bash
sudo chown user:group file.txt
sudo chown user file.txt         # Just owner
sudo chown :group file.txt       # Just group
sudo chown -R user:group dir/    # Recursive
```

**Real examples**:
```bash
sudo chown www-data:www-data /var/www/html
sudo chown ubuntu:ubuntu script.sh
```

**My take**: You'll use this for web servers. Files need to be owned by the web server user.

## chgrp: Change Group

```bash
sudo chgrp group file.txt
sudo chgrp -R group directory/  # Recursive
```

**My take**: `chown` can do this. `chgrp` is just a shortcut. Use whichever you prefer.

## Special Permissions (Advanced)

### setuid (s)

```bash
chmod u+s file                  # Set user ID
```

Runs as file owner, not the user running it.

**My take**: Rarely used. Be careful with it. Security risk if misused.

### setgid (s)

```bash
chmod g+s directory             # Set group ID
```

New files inherit directory's group.

**My take**: Useful for shared directories. Files created inherit the group.

### sticky bit (t)

```bash
chmod +t directory              # Sticky bit
```

Only owner can delete files in directory.

**My take**: Useful for /tmp. Prevents users from deleting each other's files.

## Common Mistakes (I've Made These)

1. **Forgetting execute on scripts**: Scripts need `x` permission. `chmod +x` fixes it.

2. **Wrong permissions on directories**: Directories need `x` to enter. `r` alone isn't enough.

3. **Too permissive**: Don't use 777. Ever. It's a security risk.

4. **Not using sudo for chown**: Changing ownership needs root. Use `sudo`.

5. **Forgetting -R**: Changing permissions on directories needs `-R` to affect files inside.

## Real-World Examples

### Web Server Files

```bash
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html
```

Web server needs to read files. Owner needs to write.

### Scripts

```bash
chmod +x deploy.sh
./deploy.sh
```

Scripts need execute permission to run.

### Private Files

```bash
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
```

Private keys should be 600. Public keys can be 644.

## What's Next?

Now that you understand permissions, let's talk about [Ownership Management](/docs/linux/file-system/ownership-management). We'll cover changing owners and groups.

Or practice. Create files. Change permissions. See what happens. That's how you learn.

---

> **Personal note**: When I started, I'd get "Permission denied" errors constantly. I'd use `sudo` for everything. Then I learned permissions. Now I set them correctly. Permissions are Linux's security. Learn them. Use them.
