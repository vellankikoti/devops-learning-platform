---
sidebar_position: 2
title: "Process Control: Starting and Stopping"
---

# Process Control: Start, Stop, Kill

You need to control processes. Start them. Stop them. Kill them when they misbehave.

**Here's the thing: Process control is essential. You'll do it constantly.**

## Starting Processes

### Foreground (Normal)

```bash
./script.sh                      # Run script
python app.py                    # Run Python
nginx                            # Start nginx
```

**What happens**: Process runs. Blocks terminal. You see output. Ctrl+C stops it.

**My take**: This is normal. Most commands run this way.

### Background (With &)

```bash
./script.sh &                    # Run in background
python app.py &                  # Background Python
```

**What happens**: Process runs. Doesn't block terminal. Shows job number.

**Real example**:
```bash
$ ./long_script.sh &
[1] 12345
$ 
```

Job [1], PID 12345. Terminal is free.

**My take**: Use `&` when you want to keep using the terminal. Process runs in background.

### nohup: Survive Terminal Close

```bash
nohup ./script.sh > output.log 2>&1 &
```

**What it does**: Runs in background. Survives terminal close. Output goes to file.

**The `2>&1`**: Redirects errors to same place as output.

**My take**: Use `nohup` for long-running processes. They keep running after you disconnect.

## Stopping Processes

### kill: Send Signals

```bash
kill PID                         # Send TERM (graceful)
kill -9 PID                      # Send KILL (force)
kill -15 PID                     # Send TERM (explicit)
kill -HUP PID                    # Send HUP (reload)
```

**Common signals**:
- **TERM (15)** = Terminate gracefully (default)
- **KILL (9)** = Force kill (cannot be ignored)
- **HUP (1)** = Hang up (often reloads config)
- **INT (2)** = Interrupt (like Ctrl+C)

**My take**: Try `kill` first (TERM). If that doesn't work, use `kill -9` (KILL). Force kill is last resort.

**Real example**:
```bash
$ ps aux | grep nginx
ubuntu    1234  ... nginx
$ kill 1234                      # Try graceful first
$ kill -9 1234                   # Force if needed
```

### killall: Kill by Name

```bash
killall process-name             # Kill all processes with name
killall -9 process-name          # Force kill
```

**Real example**:
```bash
killall nginx                    # Kill all nginx processes
```

**My take**: Useful when you don't know the PID. But be careful. Kills all processes with that name.

### pkill: Kill by Pattern

```bash
pkill -f "pattern"               # Kill processes matching pattern
pkill -9 -f "pattern"            # Force kill
```

**Real example**:
```bash
pkill -f "python.*script.py"     # Kill Python script
```

**My take**: More flexible than `killall`. Use patterns. Useful for specific processes.

## Finding PIDs

```bash
ps aux | grep process-name       # Find process
pgrep process-name               # Get PIDs
pidof process-name                # Get PID
```

**My take**: `ps aux | grep` is what you'll use. Simple. Works.

## Job Control

### jobs: List Background Jobs

```bash
jobs                             # List jobs
jobs -l                          # List with PIDs
```

**Real example**:
```bash
$ ./script.sh &
[1] 12345
$ jobs
[1]+  Running                 ./script.sh &
```

### fg: Bring to Foreground

```bash
fg %1                            # Bring job 1 to foreground
fg                               # Bring last job
```

**My take**: Useful when you want to see output. Or interact with the process.

### bg: Run in Background

```bash
bg %1                            # Run job 1 in background
```

**My take**: If you stopped a process (Ctrl+Z), `bg` runs it in background.

## Common Patterns

### Start and Background

```bash
./script.sh &
```

### Start and Detach

```bash
nohup ./script.sh > output.log 2>&1 &
```

### Stop Gracefully Then Force

```bash
kill PID                         # Try graceful
sleep 5
kill -9 PID                       # Force if still running
```

### Kill All Instances

```bash
killall process-name
# or
pkill process-name
```

## Common Mistakes (I've Made These)

1. **Using `kill -9` first**: Try graceful kill first. `kill -9` is last resort.

2. **Killing wrong process**: Always check PID. `ps aux | grep` to verify.

3. **Forgetting `&` for background**: Process blocks terminal. Add `&` to background.

4. **Not using nohup**: Process dies when terminal closes. Use `nohup` for long-running.

5. **Killing system processes**: Be careful. Don't kill system processes. Check what you're killing.

## Real-World Examples

### Start Service in Background

```bash
nohup nginx > /dev/null 2>&1 &
```

### Stop Stuck Process

```bash
ps aux | grep stuck_process
kill PID                         # Try graceful
kill -9 PID                      # Force if needed
```

### Restart Process

```bash
killall process-name
./process-name &
```

## What's Next?

Now that you can control processes, let's talk about [Job Control](/docs/linux/process-management/job-control). We'll cover managing background jobs in detail.

Or practice. Start processes. Stop them. Kill them. Get comfortable.

---

> **Personal note**: When I started, I'd use `kill -9` for everything. Then I learned about graceful termination. Now I try `kill` first, `kill -9` only if needed. Processes should have a chance to clean up. Be nice to your processes.
