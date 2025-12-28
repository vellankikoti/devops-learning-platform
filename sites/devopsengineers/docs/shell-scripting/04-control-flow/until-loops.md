---
sidebar_position: 4
title: "Until Loops: Repeat Until True"
---

# Until Loops: Repeat Until True

Until loops repeat until condition is true. Opposite of while.

**Here's the thing: Until loops are like while, but inverted. Use them when it makes sense.**

## Basic Syntax

```bash
until [ condition ]; do
    # commands
done
```

**My take**: Until repeats until true. Opposite of while.

## Common Patterns

### Wait For Service

```bash
until systemctl is-active nginx; do
    echo "Waiting for nginx..."
    sleep 1
done
```

**My take**: Until is good for waiting. Use it.

### Retry Until Success

```bash
until curl -f http://example.com; do
    echo "Retrying..."
    sleep 5
done
```

## When to Use

**Use until when**:
- Waiting for something
- Retrying until success
- Inverted logic makes sense

**Use while when**:
- Repeating while true
- Normal iteration
- Standard loops

**My take**: Use until when it makes sense. While is more common.

## What's Next?

Now that you understand until loops, let's talk about [Break And Continue](/docs/shell-scripting/control-flow/break-continue).

---

> **Personal note**: Until loops seemed unnecessary at first. Then I used them for waiting. Now I use them when they fit. They're useful. Learn them.

