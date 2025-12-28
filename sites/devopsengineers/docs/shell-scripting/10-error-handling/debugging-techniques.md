---
sidebar_position: 6
title: "Debugging Techniques: Find Problems"
---

# Debugging Techniques: Fix Scripts

Debug scripts. Find problems. Fix them. Techniques.

**Here's the thing: Debugging finds problems. Learn techniques. Use them.**

## set -x

```bash
#!/bin/bash
set -x
command
```

**My take**: `set -x` shows commands. Use for debugging.

## bash -x

```bash
bash -x script.sh
```

**My take**: `bash -x` runs with debugging. Use it.

## echo Debugging

```bash
echo "DEBUG: value is $value"
```

**My take**: echo shows values. Simple debugging.

## Common Patterns

### Debug Function

```bash
debug() {
    [ "$DEBUG" = "1" ] && echo "DEBUG: $*"
}

debug "Processing file: $file"
```

## What's Next?

Now that you understand debugging, you can fix scripts. Or review [Error Handling](/docs/shell-scripting/error-handling/exit-codes) to reinforce.

---

> **Personal note**: Debugging seemed hard at first. Then I learned techniques. Now I debug easily. It's a skill. Learn it.


