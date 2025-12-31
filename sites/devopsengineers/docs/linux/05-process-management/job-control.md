---
sidebar_position: 3
title: Job Control: Managing Background Processes
---

# Job Control: Background and Foreground

Jobs are processes you start from your terminal. You can run them in background. Bring them to foreground. Manage them.

**Here's the thing: Job control lets you multitask. Run multiple things. Switch between them.**

## Running in Background

### Start in Background

```bash
command &                          # Run in background
./script.sh &                      # Script in background
```

**Real example**:
```bash
$ sleep 60 &
[1] 12345
$ 
```

Job [1], PID 12345. Terminal is free.

**My take**: Use `&` to background processes. Keep terminal free.

### Move to Background

```bash
# Start command
python app.py

# Press Ctrl+Z to suspend
# Then:
bg                                 # Resume in background
```

**My take**: `Ctrl+Z` suspends. `bg` backgrounds. Useful when you forget `&`.

## Managing Jobs

### jobs: List Jobs

```bash
jobs                               # List jobs
jobs -l                            # With PIDs
```

**Output**:
```
[1]  + running    sleep 60
[2]  - stopped    python app.py
```

**States**:
- `+` = Current job
- `-` = Previous job
- `running` = Active
- `stopped` = Suspended

**My take**: `jobs` shows background jobs. Use it to see what's running.

### fg: Bring to Foreground

```bash
fg                                 # Current job
fg %1                              # Job 1
fg %2                              # Job 2
```

**My take**: `fg` brings jobs to foreground. See output. Interact with them.

### bg: Run in Background

```bash
bg                                 # Current job
bg %1                              # Job 1
```

**My take**: `bg` runs suspended jobs in background. Use after `Ctrl+Z`.

## nohup: Survive Terminal Close

```bash
nohup command > output.log 2>&1 &
```

**What it does**: Runs in background. Survives terminal close. Output to file.

**The `2>&1`**: Redirects errors to same place as output.

**My take**: Use `nohup` for long-running processes. They keep running after you disconnect.

## Common Patterns

### Start and Background

```bash
./long_script.sh &
```

### Start and Detach

```bash
nohup ./script.sh > output.log 2>&1 &
```

### Suspend and Background

```bash
# Start command
python app.py
# Press Ctrl+Z
bg                                 # Run in background
```

## Common Mistakes (I've Made These)

1. **Forgetting `&`**: Process blocks terminal. Add `&` to background.

2. **Not using nohup**: Process dies when terminal closes. Use `nohup` for long-running.

3. **Losing track of jobs**: Use `jobs` to see what's running.

4. **Killing wrong job**: Check job number. Don't kill wrong thing.

5. **Not redirecting output**: Background jobs need output redirected. Use `> file.log 2>&1`.

## Real-World Examples

### Run Script in Background

```bash
./deploy.sh > deploy.log 2>&1 &
```

### Check Background Jobs

```bash
jobs
fg %1                              # Bring to foreground if needed
```

### Long-Running Process

```bash
nohup python app.py > app.log 2>&1 &
```

## What's Next?

Now that you can control jobs, you can multitask. Or learn about [Process Control](/docs/linux/process-management/process-control) for more process management.

---

> **Personal note**: When I started, I'd let processes block my terminal. Then I learned job control. Now I background everything. Terminal stays free. Job control is essential.
