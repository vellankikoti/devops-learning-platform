---
sidebar_position: 4
title: "trap Command: Cleanup On Exit"
---

# trap Command: Run Code On Signals

trap runs code on signals. Cleanup. Error handling. Useful.

**Here's the thing: trap runs code on exit. Use it for cleanup.**

## Basic trap

```bash
trap 'echo "Exiting"' EXIT
```

**My take**: trap runs code on exit. Use it.

## Cleanup

```bash
temp_file="/tmp/temp_$$"
trap "rm -f $temp_file" EXIT
```

**My take**: trap cleans up. Use it.

## Error Handling

```bash
trap 'echo "Error on line $LINENO"' ERR
```

**My take**: trap handles errors. Use it.

## Common Patterns

### Cleanup on Exit

```bash
temp_file="/tmp/temp_$$"
trap "rm -f $temp_file" EXIT INT TERM
```

## What's Next?

Now that you understand trap, let's talk about [Error Logging](/docs/shell-scripting/error-handling/error-logging).

---

> **Personal note**: trap seemed complex at first. Then I used it for cleanup. Now I use it always. It's useful. Learn it.

