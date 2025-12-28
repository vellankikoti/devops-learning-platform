---
sidebar_position: 4
title: "Signals: Process Communication"
---

# Signals: Communicating With Processes

Signals communicate with processes. Stop them. Kill them. Reload them.

**Here's the thing: Signals are how you control processes. Learn them. Use them.**

## What Signals Are

Signals are:
- Messages to processes
- Ways to control processes
- Interrupts and commands
- Process communication

**My take**: Signals are like commands to processes. Send a signal. Process reacts.

## Common Signals

### SIGTERM (15): Terminate Gracefully

```bash
kill PID                           # Send SIGTERM (default)
kill -15 PID                       # Explicit SIGTERM
```

**My take**: SIGTERM asks process to stop. Graceful. Use it first.

### SIGKILL (9): Force Kill

```bash
kill -9 PID                        # Force kill
kill -KILL PID                     # Same thing
```

**My take**: SIGKILL forces stop. Can't be ignored. Last resort.

### SIGHUP (1): Hang Up

```bash
kill -1 PID                        # Send SIGHUP
kill -HUP PID                      # Same thing
```

**My take**: SIGHUP often reloads config. Use it for reloading.

### SIGINT (2): Interrupt

```bash
kill -2 PID                        # Send SIGINT
# Or Ctrl+C
```

**My take**: SIGINT is like Ctrl+C. Interrupts process.

## Signal Numbers

| Signal | Number | Meaning |
|--------|--------|---------|
| SIGHUP | 1 | Hang up (reload) |
| SIGINT | 2 | Interrupt (Ctrl+C) |
| SIGTERM | 15 | Terminate gracefully |
| SIGKILL | 9 | Force kill |

**My take**: Learn these. They're what you'll use.

## Using Signals

### Send Signal

```bash
kill -SIGNAL PID
kill -9 1234                       # Force kill
kill -15 1234                      # Graceful kill
```

**My take**: `kill -signal PID` sends signals. Use it.

### Send to Process Name

```bash
killall -9 process-name            # Force kill all
pkill -9 process-name              # Force kill by pattern
```

**My take**: `killall` and `pkill` kill by name. Useful.

## Common Patterns

### Graceful Stop Then Force

```bash
kill PID                           # Try graceful
sleep 5
kill -9 PID                        # Force if still running
```

**My take**: Try graceful first. Force if needed.

### Reload Configuration

```bash
kill -HUP PID                      # Reload config
```

**My take**: SIGHUP reloads. Use it for services.

## Common Mistakes (I've Made These)

1. **Using SIGKILL first**: Try SIGTERM first. SIGKILL is last resort.

2. **Wrong signal number**: Learn signal numbers. Use the right one.

3. **Killing wrong process**: Check PID. Don't kill wrong thing.

4. **Not waiting**: Give process time to stop. Don't force immediately.

5. **Not understanding signals**: Signals have meanings. Understand them.

## Real-World Examples

### Stop Service Gracefully

```bash
kill 1234                          # SIGTERM
# Wait
kill -9 1234                       # SIGKILL if needed
```

### Reload Service

```bash
kill -HUP 1234                     # Reload config
```

## What's Next?

Now that you understand signals, let's talk about [Process Monitoring](/docs/linux/process-management/process-monitoring) to watch processes.

---

> **Personal note**: I used to use `kill -9` for everything. Then I learned signals. Now I try graceful first. Processes should have a chance to clean up. Be nice to your processes.


