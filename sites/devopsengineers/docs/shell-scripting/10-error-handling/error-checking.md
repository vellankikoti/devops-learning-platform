---
sidebar_position: 2
title: "Error Checking: Check For Errors"
---

# Error Checking: Verify Commands Succeed

Check if commands succeed. Handle errors. Important.

**Here's the thing: Check for errors. Handle them. Don't ignore them.**

## Check Exit Code

```bash
command
if [ $? -eq 0 ]; then
    echo "Success"
else
    echo "Failed"
fi
```

**My take**: Check `$?` after commands. Handle errors.

## Inline Check

```bash
if command; then
    echo "Success"
fi
```

**My take**: Inline check is cleaner. Use it.

## set -e

```bash
#!/bin/bash
set -e
command1
command2
```

**My take**: `set -e` exits on error. Use it.

## Common Patterns

### Check Before Use

```bash
if ! command; then
    echo "Error: command failed"
    exit 1
fi
```

## What's Next?

Now that you understand error checking, let's talk about [set Options](/docs/shell-scripting/error-handling/set-options).

---

> **Personal note**: I used to ignore errors. Then things broke. Now I check always. It prevents problems. Do it.

