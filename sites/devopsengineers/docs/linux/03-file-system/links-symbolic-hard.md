---
sidebar_position: 4
title: Symbolic And Hard Links
---

# Links: Multiple Names for the Same File

Links let you access files from multiple locations. Like shortcuts. But different.

**Here's the thing: Links are useful. You'll use them. Mostly symbolic links. Hard links are rare.**

## The Difference

**Hard link**: Multiple names for the same file. All point to the same data.

**Symbolic link**: A pointer to another file. Like a shortcut.

**My take**: Use symbolic links. They're more common. Hard links are rare.

## Hard Links

### Creating Hard Links

```bash
ln file.txt hardlink.txt          # Create hard link
```

**What it does**: Creates another name for the same file.

**Real example**:
```bash
$ echo "Hello" > original.txt
$ ln original.txt link.txt
$ cat original.txt
Hello
$ cat link.txt
Hello
$ echo "World" >> link.txt
$ cat original.txt
Hello
World
```

**Both point to the same data**. Change one, both change.

**Limitations**:
- Only works on same filesystem
- Can't link directories
- All links are equal (no "original")

**My take**: Hard links are rare. You'll rarely use them. But they exist.

## Symbolic Links (What You'll Actually Use)

### Creating Symbolic Links

```bash
ln -s target link                  # Create symbolic link
ln -s /path/to/file link           # Absolute path
ln -s ../file.txt link             # Relative path
```

**The `-s` flag**: Makes it symbolic.

**Real examples**:
```bash
ln -s /var/www/html /var/www/current
ln -s ../config/production.conf app.conf
```

**My take**: Symbolic links are common. Use them. They're useful.

### Understanding Symbolic Links

```bash
$ ln -s /etc/nginx/nginx.conf nginx.conf
$ ls -l nginx.conf
lrwxrwxrwx 1 ubuntu ubuntu 25 Dec 28 10:30 nginx.conf -> /etc/nginx/nginx.conf
```

**The `->` shows where it points**. The `l` at the start means it's a link.

**My take**: Symbolic links are pointers. They point to other files. Simple.

### Broken Links

```bash
$ ln -s /nonexistent/file.txt broken
$ ls -l broken
lrwxrwxrwx 1 ubuntu ubuntu 20 Dec 28 10:30 broken -> /nonexistent/file.txt
$ cat broken
cat: broken: No such file or directory
```

**What happens**: Link exists, but target doesn't. Link is broken.

**My take**: Broken links happen. Delete them. They're useless.

## Common Uses

### Version Management

```bash
ln -s /opt/app-v2.0 /opt/app-current
# Switch versions by changing the link
```

**My take**: Useful for deployments. Point to current version. Switch easily.

### Convenient Access

```bash
ln -s /var/log/nginx/access.log ~/nginx-access.log
```

**My take**: Create links for convenience. Access files from anywhere.

### Configuration Management

```bash
ln -s /etc/nginx/sites-available/mysite /etc/nginx/sites-enabled/mysite
```

**My take**: Common pattern. Available vs enabled. Links enable sites.

## Finding Links

```bash
find /path -type l                 # Find all symbolic links
ls -l | grep "^l"                  # List links in directory
readlink link                      # Show where link points
```

**My take**: `readlink` shows where a link points. Useful for debugging.

## Removing Links

```bash
rm link                            # Remove link (not the target)
unlink link                        # Same thing
```

**My take**: Removing a link doesn't remove the target. Just the link.

## Common Mistakes (I've Made These)

1. **Forgetting `-s`**: `ln file link` creates hard link. `ln -s file link` creates symbolic link.

2. **Relative vs absolute paths**: Absolute paths are safer. Relative paths break if you move the link.

3. **Linking to directories**: Hard links can't link directories. Symbolic links can.

4. **Broken links**: Links break if target is deleted. Clean them up.

5. **Circular links**: Don't create links that point to each other. It breaks things.

## Real-World Examples

### Enable Nginx Site

```bash
sudo ln -s /etc/nginx/sites-available/mysite /etc/nginx/sites-enabled/mysite
sudo nginx -t
sudo systemctl reload nginx
```

### Current Version Link

```bash
ln -s /opt/app-v2.0 /opt/app-current
# Deploy new version
rm /opt/app-current
ln -s /opt/app-v3.0 /opt/app-current
```

## What's Next?

Now that you understand links, you can create shortcuts. Or learn about [Disk Management](/docs/linux/file-system/disk-management) to monitor storage.

---

> **Personal note**: When I started, I'd copy files to multiple locations. Then I learned symbolic links. Now I link instead of copy. Saves space. Easier to manage. Links are useful.
