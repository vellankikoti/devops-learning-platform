---
sidebar_position: 3
title: "While Loops: Repeat While True"
---

# While Loops: Repeat Until False

While loops repeat while condition is true. Keep going until it's false.

**Here's the thing: While loops repeat until condition is false. Use them for unknown iterations.**

## Basic Syntax

```bash
while [ condition ]; do
    # commands
done
```

**My take**: While loops repeat while true. Simple.

## Common Patterns

### Count Down

```bash
count=10
while [ $count -gt 0 ]; do
    echo "$count"
    count=$((count - 1))
done
```

### Read Until Empty

```bash
while read line; do
    echo "$line"
done < file.txt
```

### Infinite Loop

```bash
while true; do
    # commands
    sleep 1
done
```

**My take**: Infinite loops need break. Or they run forever.

## Common Mistakes (I've Made These)

1. **Infinite loops**: Make sure condition changes. Or use break.

2. **Wrong condition**: Check condition. Make sure it can become false.

3. **Not updating**: Update variables in loop. Or it never ends.

## What's Next?

Now that you understand while loops, let's talk about [Until Loops](/docs/shell-scripting/control-flow/until-loops).

---

> **Personal note**: While loops seemed simple. Then I created infinite loops. Now I'm careful. Check your conditions. Always.


