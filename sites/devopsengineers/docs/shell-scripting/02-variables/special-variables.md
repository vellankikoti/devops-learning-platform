---
sidebar_position: 3
title: "Special Variables: Built-In Variables"
---

# Special Variables: Shell Provides These

Shell provides special variables. They're always available. Use them.

**Here's the thing: Special variables are useful. Learn them. Use them.**

## Script Information

### $0: Script Name

```bash
echo "Script: $0"
```

**My take**: `$0` is the script name. Use it for logging.

### $#: Argument Count

```bash
echo "Arguments: $#"
```

**My take**: `$#` is argument count. Check it before using arguments.

## Arguments

### $1, $2, $3...: Positional Arguments

```bash
echo "First: $1"
echo "Second: $2"
```

**My take**: `$1` is first argument. `$2` is second. Simple.

### $@: All Arguments

```bash
echo "All: $@"
```

**My take**: `$@` is all arguments. Use it to pass them along.

### $*: All Arguments (Different)

```bash
echo "All: $*"
```

**My take**: `$*` is similar but different. Use `$@` usually.

## Process Information

### $$: Process ID

```bash
echo "PID: $$"
```

**My take**: `$$` is the process ID. Use it for temp files.

### $?: Exit Code

```bash
command
if [ $? -eq 0 ]; then
    echo "Success"
fi
```

**My take**: `$?` is exit code. Check it after commands.

## Common Patterns

### Check Arguments

```bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <arg>"
    exit 1
fi
```

### Use All Arguments

```bash
for arg in "$@"; do
    echo "$arg"
done
```

## What's Next?

Now that you understand special variables, let's talk about [Environment Variables](/docs/shell-scripting/variables/environment-variables).

---

> **Personal note**: Special variables seemed confusing at first. Then I learned them. Now I use them constantly. They're useful. Learn them.


