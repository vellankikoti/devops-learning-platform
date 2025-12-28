---
sidebar_position: 1
title: Linux Directory Structure (FHS)
---

# Linux Directory Structure: Know Where Everything Is

Linux has a standard directory structure. Same on every system. Once you learn it, you'll never get lost.

This is the Filesystem Hierarchy Standard (FHS). It's boring. But essential.

## The Root Directory (`/`)

Everything starts at `/`. That's root. Not to be confused with the root user. Just the root of the filesystem.

```
/ (root)
├── bin/          # Essential commands
├── boot/         # Boot files
├── dev/           # Devices
├── etc/           # Configuration
├── home/          # User directories
├── lib/            # Libraries
├── media/          # Removable media
├── mnt/            # Temporary mounts
├── opt/            # Optional software
├── proc/            # Process info
├── root/            # Root user's home
├── run/              # Runtime data
├── sbin/             # System admin commands
├── srv/               # Service data
├── tmp/                # Temporary files
├── usr/                 # User programs
└── var/                  # Variable data
```

**That's the structure. Learn it. You'll use it constantly.**

## The Directories You'll Actually Use

### /bin - Essential Commands

Where basic commands live. `ls`, `cp`, `mv`, `rm`, `cat`, `grep`. The stuff that has to work even when everything else is broken.

**Why it matters**: These commands are always available. Even in single-user mode.

**Real example**:
```bash
$ ls /bin
bash  cat  cp  grep  ls  mv  rm  ...
```

### /sbin - System Admin Commands

Like `/bin`, but for system administration. Usually need root.

**Contains**: `ifconfig`, `fdisk`, `systemctl`, `iptables`. Admin stuff.

**Real example**:
```bash
$ ls /sbin
fdisk  ifconfig  init  systemctl  ...
```

### /etc - Configuration Files

This is where configuration lives. Everything that configures the system.

**Important files**:
- `/etc/passwd` - User accounts
- `/etc/group` - Groups
- `/etc/hosts` - Hostname resolution
- `/etc/fstab` - Filesystem mounts
- `/etc/ssh/sshd_config` - SSH configuration
- `/etc/nginx/nginx.conf` - Nginx config (if installed)

**My take**: You'll spend a lot of time in `/etc`. This is where you configure things.

**Real example**:
```bash
$ ls /etc
passwd  group  hosts  fstab  ssh  nginx  ...
```

### /home - User Directories

Where users live. Each user has a directory here.

**Structure**:
```
/home/
├── user1/
├── user2/
└── ubuntu/
```

**My take**: This is where you put your stuff. Your files. Your projects. Your life.

**Real example**:
```bash
$ ls /home
ubuntu  user1  user2
$ cd ~
$ pwd
/home/ubuntu
```

The `~` is shorthand for your home directory. You'll use it constantly.

### /root - Root User's Home

Like `/home`, but for the root user. Don't put your stuff here.

**My take**: Only root should use this. Regular users use `/home`.

### /usr - User Programs

Where most programs live. Not user programs in the sense of "for users," but programs that aren't essential for booting.

**Structure**:
- `/usr/bin` - User commands
- `/usr/sbin` - User admin commands
- `/usr/lib` - Libraries
- `/usr/share` - Shared data
- `/usr/local` - Locally installed software

**My take**: Most of what you install goes here. Or in `/usr/local` if you install manually.

### /var - Variable Data

Data that changes. Logs. Spool files. Cache. Stuff that grows and shrinks.

**Important**:
- `/var/log` - Log files (you'll be here a lot)
- `/var/spool` - Spool files
- `/var/cache` - Cache
- `/var/tmp` - Temporary files

**My take**: `/var/log` is where problems hide. And where solutions live. Learn to read logs.

**Real example**:
```bash
$ ls /var/log
syslog  auth.log  nginx  apache2  ...
```

### /tmp - Temporary Files

Temporary files. Usually cleared on reboot. Don't put important stuff here.

**My take**: Use it for temporary work. Don't rely on it persisting.

### /opt - Optional Software

Third-party software. Stuff that doesn't fit the standard structure.

**My take**: Some software installs here. Docker. Some IDEs. Not everything, but some things.

### /proc - Process Information

Virtual filesystem. Shows running processes. Not real files - just information about the system.

**My take**: You'll rarely edit things here. But you'll read from it. `cat /proc/cpuinfo` to see CPU info. `cat /proc/meminfo` for memory.

**Real example**:
```bash
$ cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
...
```

### /dev - Devices

Device files. Everything is a file in Linux. Even devices.

**My take**: You'll rarely touch this directly. But it's good to know it exists.

### /boot - Boot Files

Kernel. Bootloader. Stuff needed to boot.

**My take**: Don't mess with this unless you know what you're doing. Breaking this breaks booting.

### /media and /mnt - Mount Points

Where you mount things. `/media` for removable media. `/mnt` for temporary mounts.

**My take**: You'll use `/mnt` for temporary mounts. `/media` is usually automatic.

## The Mental Map

Here's how I think about it:

- **`/etc`** = Configuration (where you configure)
- **`/home`** = Your stuff (where you work)
- **`/var/log`** = Logs (where problems hide)
- **`/usr`** = Programs (where software lives)
- **`/tmp`** = Temporary (where temporary stuff goes)
- **`/opt`** = Optional (where some software goes)

**That's 90% of what you need to know.**

## Common Paths You'll Use

```bash
/etc/nginx/nginx.conf          # Nginx config
/etc/ssh/sshd_config           # SSH config
/var/log/syslog               # System log
/var/log/nginx/access.log     # Nginx access log
/home/ubuntu/projects          # Your projects
/usr/local/bin                 # Local binaries
```

**Learn these. You'll use them constantly.**

## What's Next?

Now that you understand the directory structure, let's talk about [File Permissions](/docs/linux/file-system/file-permissions). We'll cover who can do what. It's important.

Or explore the directories. Actually go into them. See what's there. That's how you learn.

---

> **Personal note**: When I started, I got lost constantly. I'd be in `/etc` and not know how I got there. That's fine. Use `pwd` to see where you are. Use `cd ~` to go home. You'll learn the structure by using it.
