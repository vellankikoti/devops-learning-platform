---
sidebar_position: 2
title: Essential Commands You'll Use Daily
---

# Essential Commands (The Real Ones)

These are the commands you'll use every single day. Not a comprehensive list. Just the ones that matter.

Master these, and you can do 80% of what you need. The other 20%? You'll learn as you go.

## How Commands Work

Commands follow a pattern:
```bash
command [options] [arguments]
```

- **command**: What to do (`ls`, `cd`, `cp`)
- **options**: How to do it (`-l`, `-a`, `-r`)
- **arguments**: What to do it to (`filename`, `/path`)

**Example**:
```bash
ls -la /home/ubuntu
# ls = command (list)
# -la = options (long format, all files)
# /home/ubuntu = argument (what to list)
```

That's it. That's how all commands work.

## ls: Your Most Used Command

You'll use `ls` constantly. Here's what you need:

```bash
ls                    # Basic list
ls -l                 # Long format (details)
ls -a                 # All files (including hidden)
ls -la                # Both (use this most)
ls -lh                # Human-readable sizes
ls -lt                # Sort by time (newest first)
ls -ltr               # Sort by time, reverse (oldest first)
```

**The `-la` combo**: This is what you'll use 90% of the time. Long format plus all files.

**Understanding the output**:
```
-rw-r--r-- 1 ubuntu ubuntu 1234 Dec 28 10:30 file.txt
```

That's a lot of information. Here's what matters:
- First character: `-` = file, `d` = directory
- Next 9 characters: Permissions (we'll cover this later)
- `ubuntu ubuntu`: Owner and group
- `1234`: Size in bytes
- `Dec 28 10:30`: When it was modified
- `file.txt`: The filename

**Don't memorize this now**. Just know `ls -la` shows you everything. You'll understand the details as you learn more.

## cd: Navigation

```bash
cd /path/to/dir       # Go somewhere
cd ~                  # Go home
cd ..                 # Go up one level
cd -                  # Go back to previous directory
```

**Pro tip**: `cd -` is underrated. It goes back to where you were. Super useful.

## cat: Quick File Viewing

```bash
cat filename
cat file1 file2       # Multiple files
```

Shows file contents. Simple.

**When to use**: Quick viewing. For long files, use `less` (we'll cover that).

**Real example**:
```bash
$ cat /etc/hostname
server1
```

## less: View Long Files

```bash
less filename
```

Like `cat`, but better for long files. You can scroll.

**Navigation**:
- `Space`: Next page
- `b`: Previous page
- `q`: Quit
- `/search`: Search for text
- `n`: Next search result

**When to use**: Any file longer than a screen. Which is most files.

## head and tail: See Beginning or End

```bash
head filename         # First 10 lines
head -n 20 filename   # First 20 lines
tail filename         # Last 10 lines
tail -n 20 filename   # Last 20 lines
tail -f filename      # Follow (watch as it grows)
```

**Real example**:
```bash
$ tail -f /var/log/syslog
```

That `-f` flag is magic. It follows the file. Watch logs in real-time. You'll use this a lot.

## grep: Find Text

```bash
grep "pattern" filename
grep -i "pattern" filename    # Case insensitive
grep -r "pattern" directory    # Recursive (search in subdirectories)
grep -v "pattern" filename     # Invert (show lines that DON'T match)
```

**Real example**:
```bash
$ grep "error" /var/log/syslog
$ grep -i "error" /var/log/syslog    # Find "error", "Error", "ERROR"
$ grep -r "password" /etc            # Find "password" in all files under /etc
```

**You'll use grep constantly**. It's how you find things in files.

## find: Find Files

```bash
find /path -name "filename"
find /path -type f -name "*.txt"    # Find all .txt files
find /path -mtime -7                # Modified in last 7 days
```

**Real example**:
```bash
$ find /home -name "*.log"
$ find /var/log -mtime -1           # Logs modified today
```

**When to use**: When you need to find files. `grep` finds text. `find` finds files.

## cp: Copy

```bash
cp source destination
cp -r dir1 dir2       # Copy directory
cp -p file1 file2     # Preserve permissions and timestamps
```

**Real example**:
```bash
$ cp file.txt backup.txt
$ cp -r projects projects_backup
```

The `-r` flag is for directories. Remember it.

## mv: Move or Rename

```bash
mv source destination
```

Moves files. Or renames them. Same command.

**Real example**:
```bash
$ mv oldname.txt newname.txt  # Rename
$ mv file.txt /tmp/           # Move
```

## rm: Delete (Be Careful)

```bash
rm filename
rm -r dirname        # Delete directory
rm -f filename       # Force (no confirmation)
rm -rf dirname       # Force recursive (dangerous)
```

**Warning**: `rm -rf` is dangerous. It deletes without asking. Be very careful.

**Pro tip**: There's no undo. Deleted is deleted. Always double-check.

## mkdir and rmdir: Directories

```bash
mkdir dirname
mkdir -p path/to/dir    # Create parent directories too
rmdir dirname            # Remove empty directory
```

**Real example**:
```bash
$ mkdir -p projects/2024/january
$ rmdir empty_dir
```

The `-p` flag creates parent directories. Useful.

## chmod: Change Permissions

```bash
chmod 755 filename
chmod +x filename       # Make executable
chmod -x filename       # Remove executable
chmod u+x filename      # User executable
```

**Real example**:
```bash
$ chmod +x script.sh
$ chmod 644 file.txt
```

We'll cover permissions in detail later. For now, `chmod +x` makes files executable. That's what you need most.

## sudo: Run as Root

```bash
sudo command
```

Runs a command as root (administrator). You'll use this a lot.

**Real example**:
```bash
$ sudo apt update
$ sudo systemctl restart nginx
```

**When to use**: When you need administrator privileges. Installing software. Managing services. System configuration.

## systemctl: Manage Services

```bash
sudo systemctl start service
sudo systemctl stop service
sudo systemctl restart service
sudo systemctl status service
sudo systemctl enable service    # Start on boot
sudo systemctl disable service   # Don't start on boot
```

**Real example**:
```bash
$ sudo systemctl status nginx
$ sudo systemctl restart nginx
```

**You'll use this constantly**. Services are how Linux runs things automatically.

## ps: See Running Processes

```bash
ps aux                # All processes
ps aux | grep nginx   # Find specific process
```

**Real example**:
```bash
$ ps aux | grep nginx
```

Shows what's running. Useful for troubleshooting.

## top/htop: Monitor System

```bash
top                   # System monitor
htop                  # Better version (if installed)
```

Shows what's using CPU and memory. Press `q` to quit.

**Real example**: When something is slow, `top` shows you what's using resources.

## df: Disk Space

```bash
df -h                 # Human-readable
```

Shows disk usage. The `-h` flag makes it readable.

**Real example**:
```bash
$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        20G   5G   14G  27% /
```

**When to use**: When you're running out of space. Which happens.

## du: Directory Size

```bash
du -h directory
du -sh directory      # Summary (just the total)
```

Shows how much space a directory uses.

**Real example**:
```bash
$ du -sh /var/log
```

**When to use**: When you need to find what's using space.

## wget/curl: Download Files

```bash
wget https://example.com/file
curl -O https://example.com/file
```

Downloads files from the internet.

**Real example**:
```bash
$ wget https://example.com/script.sh
$ curl -O https://example.com/config.txt
```

## tar: Archives

```bash
tar -czf archive.tar.gz directory    # Create
tar -xzf archive.tar.gz               # Extract
```

Creates and extracts archives. The `-czf` means: create (`-c`), compress with gzip (`-z`), file (`-f`).

**Real example**:
```bash
$ tar -czf backup.tar.gz /home/ubuntu
$ tar -xzf backup.tar.gz
```

## The Commands You'll Actually Use

Here's the truth: You'll use maybe 20 commands regularly. The rest? You'll look up when you need them.

**Daily use**:
- `ls -la` - See what's here
- `cd` - Move around
- `cat` / `less` - View files
- `grep` - Find text
- `sudo` - Run as root
- `systemctl` - Manage services

**Weekly use**:
- `find` - Find files
- `ps aux` - See processes
- `df -h` - Check disk space
- `tar` - Archives

**Everything else**: Look it up when you need it. Don't try to memorize everything.

## What's Next?

Now that you know the essential commands, let's talk about [File Operations](/docs/linux/command-line-basics/file-operations). We'll cover creating, copying, moving, and deleting files in more detail.

Or practice these commands. Actually use them. That's how you learn.

---

> **Personal note**: I still look up command options. That's fine. The important part is knowing what command to use. The options? You can always look them up. Don't try to memorize everything.
