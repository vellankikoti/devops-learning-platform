---
sidebar_position: 4
title: First Steps in Linux
---

# Your First Commands (The Ones You'll Use Forever)

Open a terminal. See that prompt? That's your new best friend. Or worst enemy. Depends on the day.

Let me show you the commands you'll use every single day. These aren't optional. These are essential.

## The Terminal (How to Actually Open It)

**On Linux**: `Ctrl + Alt + T`. That's it.

**On Mac**: `Cmd + Space`, type "Terminal". Or use iTerm2 (it's better).

**On Windows**: Use WSL. Or Git Bash. But really, use WSL.

**Remote (SSH)**:
```bash
ssh username@server-ip
```

That's how you connect to servers. You'll do this a lot.

## Understanding the Prompt

When you open a terminal, you see something like:
```bash
ubuntu@server:~$
```

Let me break that down:
- `ubuntu` - Your username
- `@server` - The computer name
- `~` - Where you are (`~` means home directory)
- `$` - You're a regular user (`#` means root)

**The `~` is important**. It means "home". Like your house. Everything starts from home.

## pwd: Where Am I?

```bash
pwd
```

That's it. It tells you where you are.

**When to use**: Always. When you're lost, `pwd` tells you where you are.

**Real example**:
```bash
$ pwd
/home/ubuntu
```

You're in your home directory. Simple.

## ls: What's Here?

```bash
ls
```

Lists what's in the current directory. You'll use this constantly.

**Basic usage**:
```bash
ls                    # What's here?
ls -l                 # More details
ls -a                 # Show hidden files too
ls -la                # Both (this is what you'll use most)
```

**The `-la` combo**: Long format (`-l`) plus all files (`-a`). This is your most common command.

**Real example**:
```bash
$ ls -la
total 24
drwxr-xr-x 3 ubuntu ubuntu 4096 Dec 28 10:30 .
drwxr-xr-x 5 ubuntu ubuntu 4096 Dec 28 09:15 ..
-rw-r--r-- 1 ubuntu ubuntu  220 Dec 28 10:30 .bashrc
-rw-r--r-- 1 ubuntu ubuntu 1234 Dec 28 10:25 file.txt
drwxr-xr-x 2 ubuntu ubuntu 4096 Dec 28 10:20 projects
```

That's a lot of information. Don't worry about understanding it all now. Just know: `ls -la` shows you everything.

## cd: Moving Around

```bash
cd /path/to/dir       # Go somewhere
cd ~                  # Go home
cd                    # Also go home
cd ..                 # Go up one level
cd ../..              # Go up two levels
```

**Navigation basics**:
- `/` = root (top level)
- `~` = home (your directory)
- `.` = current directory
- `..` = parent directory (one level up)

**Real example**:
```bash
$ pwd
/home/ubuntu
$ cd /etc
$ pwd
/etc
$ cd ~
$ pwd
/home/ubuntu
```

**Pro tip**: `cd -` goes back to where you were. Useful when you're jumping around.

## cat: See File Contents

```bash
cat filename
```

Shows file contents. Simple.

**Real example**:
```bash
$ cat /etc/hostname
server1
```

**When to use**: Quick file viewing. For long files, use `less` (we'll cover that).

## mkdir: Create Directories

```bash
mkdir dirname
mkdir -p path/to/dir  # Create parent directories too
```

**Real example**:
```bash
$ mkdir projects
$ mkdir -p projects/2024/january
```

The `-p` flag creates parent directories if they don't exist. Useful.

## touch: Create Empty Files

```bash
touch filename
```

Creates an empty file. Or updates the timestamp if it exists.

**Real example**:
```bash
$ touch test.txt
$ ls -la test.txt
-rw-r--r-- 1 ubuntu ubuntu 0 Dec 28 10:30 test.txt
```

Zero bytes. Empty file. That's it.

## cp: Copy Files

```bash
cp source destination
cp -r dir1 dir2       # Copy directory (recursive)
```

**Real example**:
```bash
$ cp file.txt file_backup.txt
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

**Pro tip**: `mv` is also how you rename. There's no separate rename command.

## rm: Delete (Be Careful)

```bash
rm filename
rm -r dirname        # Delete directory
rm -rf dirname       # Force delete (dangerous)
```

**Real example**:
```bash
$ rm test.txt
$ rm -r old_directory
```

**Warning**: `rm -rf` is dangerous. It deletes without asking. Be careful.

**Pro tip**: There's no undo. Deleted is deleted. Be sure before you delete.

## Getting Help

### man: The Manual

```bash
man command
```

Shows the manual for a command. Everything is documented.

**Real example**:
```bash
$ man ls
```

Press `q` to quit. Use arrow keys to scroll.

### --help: Quick Help

```bash
command --help
```

Shorter help. Usually enough.

**Real example**:
```bash
$ ls --help
```

## Your First Practice Session

Let's actually do this:

```bash
# See where you are
pwd

# See what's here
ls -la

# Go home
cd ~

# Create a test directory
mkdir test_linux

# Go into it
cd test_linux

# Create a file
touch hello.txt

# See it
ls -la

# Go back home
cd ~

# Delete the test directory
rm -r test_linux
```

Do that. Actually type it. Don't just read it. That's how you learn.

## Common Mistakes (I've Made These)

1. **Spaces in paths**: `cd /home/user/my folder` doesn't work. Use quotes: `cd "/home/user/my folder"` or escape: `cd /home/user/my\ folder`

2. **Case sensitivity**: `File.txt` and `file.txt` are different. Linux cares about case.

3. **Forgetting sudo**: Some commands need root. You'll forget `sudo` a lot. It's fine. Just add it.

4. **Deleting wrong thing**: Always double-check before `rm`. There's no undo.

## What's Next?

Now that you know the basics, let's dive into [Essential Commands](/docs/linux/command-line-basics/essential-commands). We'll cover the commands you'll use every day. The ones that actually matter.

Or practice these first. Your call. But get comfortable with these before moving on.

---

> **Personal note**: When I started, I typed `ls` about a thousand times just to see what was there. That's fine. Get comfortable. These commands become muscle memory. Just practice.
