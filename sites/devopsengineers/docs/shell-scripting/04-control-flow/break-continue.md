---
sidebar_position: 5
title: "Break And Continue: Control Loops"
---

# Break And Continue: Control Loop Execution

Break exits loops. Continue skips to next iteration. Control flow.

**Here's the thing: Break and continue control loops. Use them when needed.**

## break: Exit Loop

```bash
while true; do
    read input
    if [ "$input" = "quit" ]; then
        break
    fi
    echo "$input"
done
```

**My take**: `break` exits loop. Use it to exit early.

## continue: Skip Iteration

```bash
for i in {1..10}; do
    if [ $((i % 2)) -eq 0 ]; then
        continue
    fi
    echo "$i"
done
```

**My take**: `continue` skips to next iteration. Use it to skip.

## Common Patterns

### Exit On Condition

```bash
for file in *.txt; do
    if [ ! -f "$file" ]; then
        break
    fi
    process "$file"
done
```

### Skip Invalid Items

```bash
for item in "$@"; do
    if [ -z "$item" ]; then
        continue
    fi
    process "$item"
done
```

## Common Mistakes (I've Made These)

1. **Using break in wrong place**: Break exits loop. Make sure it's where you want.

2. **Not understanding continue**: Continue skips iteration. Doesn't exit loop.

3. **Too many breaks**: Too many breaks make code hard to follow. Use carefully.

## What's Next?

Now that you understand break and continue, let's talk about [Nested Controls](/docs/shell-scripting/control-flow/nested-controls).

---

> **Personal note**: Break and continue seemed simple. Then I used them wrong. Now I understand them. They're useful. Use them carefully.

