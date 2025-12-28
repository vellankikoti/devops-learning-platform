---
sidebar_position: 1
title: Understanding Processes
---

# Processes: What's Actually Running

Everything running on Linux is a process. Every program. Every service. Every command.

**Understanding processes is understanding how Linux actually works.**

## What's a Process?

A process is just a running program. That's it.

Each process has:
- **PID** (Process ID) - Unique number
- **PPID** (Parent Process ID) - The process that started it
- **User** - Who owns it
- **State** - Running, sleeping, stopped
- **Resources** - CPU, memory it's using

**Think of it like this**: Every process is like an employee. It has an ID, reports to a manager (parent), uses resources, and has a status.

## ps: See What's Running

```bash
ps                              # Your processes
ps aux                          # All processes (what you'll use)
ps aux | grep nginx             # Find specific process
```

**The `ps aux` command**: This is what you'll use. All processes. Detailed info.

**Understanding the output**:
```
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.1  16832  1084 ?        Ss   Dec28   0:01 /sbin/init
ubuntu    1234  0.5  2.1 245680 21500 ?        Ssl  Dec28   5:23 /usr/bin/nginx
```

**What matters**:
- **USER** - Who owns it
- **PID** - Process ID (unique number)
- **%CPU** - CPU usage
- **%MEM** - Memory usage
- **COMMAND** - What's running

**The rest?** You can ignore it most of the time.

**Real example**:
```bash
$ ps aux | grep nginx
ubuntu    1234  0.5  2.1 245680 21500 ?        Ssl  Dec28   5:23 /usr/bin/nginx
```

That's nginx. PID 1234. Using 0.5% CPU, 2.1% memory.

## top: Watch Processes in Real-Time

```bash
top                             # Interactive process viewer
```

Shows processes. Updates in real-time. Press `q` to quit.

**Useful keys**:
- `q` - Quit
- `k` - Kill process (enter PID)
- `M` - Sort by memory
- `P` - Sort by CPU
- `1` - Show all CPUs

**When to use**: When something is slow. `top` shows what's using resources.

**Real example**: Server is slow. Run `top`. See process using 100% CPU. That's your problem.

## htop: Better top (If Installed)

```bash
htop                            # Better version of top
```

Like `top`, but better. Colorful. Easier to use.

**My take**: Install it. `sudo apt install htop` or `sudo dnf install htop`. It's worth it.

## Understanding Process States

Processes have states. Here's what matters:

- **R** (Running) - Actually running
- **S** (Sleeping) - Waiting for something
- **Z** (Zombie) - Dead but not cleaned up
- **D** (Uninterruptible sleep) - Waiting on I/O

**My take**: Most processes are sleeping. That's normal. They're waiting for something to do.

## Parent and Child Processes

Every process has a parent. Except PID 1 (init/systemd). That's the parent of everything.

**Why it matters**: When you kill a parent, children usually die too. Usually.

**Real example**:
```bash
$ ps aux | grep nginx
root      1234  ... nginx: master process
www-data  1235  ... nginx: worker process
www-data  1236  ... nginx: worker process
```

PID 1234 is the parent. 1235 and 1236 are children. Kill 1234, and the children die.

## Finding Processes

```bash
ps aux | grep nginx             # Find nginx
pgrep nginx                     # Get PIDs of nginx
pidof nginx                     # Get PID of nginx
```

**My take**: `ps aux | grep` is what you'll use. Simple. Works.

**Real example**:
```bash
$ ps aux | grep nginx
ubuntu    1234  ... /usr/bin/nginx
```

That's how you find processes.

## Process Trees

```bash
pstree                          # Show process tree
pstree -p                       # Show PIDs
pstree -u                       # Show users
```

Shows processes in a tree. Parent to child relationships.

**When to use**: Understanding how processes relate. Rarely, but useful when you need it.

## What's Next?

Now that you understand processes, let's talk about [Process Control](/docs/linux/process-management/process-control). We'll cover starting, stopping, and killing processes.

Or practice. Run `ps aux`. See what's running. Get familiar with it.

---

> **Personal note**: When I started, I'd see hundreds of processes and panic. "Why are there so many?" Then I realized: most are sleeping. They're just waiting. Only a few are actually using resources. Don't panic. Most processes are fine.
