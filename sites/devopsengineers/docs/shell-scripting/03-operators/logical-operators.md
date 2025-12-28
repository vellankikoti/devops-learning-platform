---
sidebar_position: 3
title: "Logical Operators: Combining Conditions"
---

# Logical Operators: Combine Conditions

Logical operators combine conditions. AND. OR. NOT.

**Here's the thing: Combining conditions makes scripts powerful. Learn these. Use them.**

## AND (&&)

```bash
# Both conditions must be true
if [ condition1 ] && [ condition2 ]; then
    echo "Both true"
fi

# Short-circuit: run command2 only if command1 succeeds
command1 && command2
```

**My take**: `&&` means both must be true. Use it when you need multiple conditions.

**Real example**:
```bash
if [ -f "$file" ] && [ -r "$file" ]; then
    process_file "$file"
fi
```

## OR (||)

```bash
# Either condition can be true
if [ condition1 ] || [ condition2 ]; then
    echo "At least one true"
fi

# Short-circuit: run command2 only if command1 fails
command1 || command2
```

**My take**: `||` means either can be true. Use it for alternatives.

**Real example**:
```bash
if [ "$USER" = "root" ] || [ "$USER" = "admin" ]; then
    echo "Admin access"
fi
```

## NOT (!)

```bash
# Invert condition
if [ ! condition ]; then
    echo "Condition is false"
fi

if ! command; then
    echo "Command failed"
fi
```

**My take**: `!` inverts. Use it to check for false conditions.

**Real example**:
```bash
if [ ! -f "$file" ]; then
    echo "File not found"
fi
```

## Combining Operators

```bash
# Complex conditions
if [ condition1 ] && [ condition2 ] || [ condition3 ]; then
    # Logic
fi

# With parentheses (bash)
if [[ (condition1 && condition2) || condition3 ]]; then
    # Logic
fi
```

**My take**: Combine operators for complex logic. Use parentheses for clarity.

## Common Patterns

### Check Multiple Conditions

```bash
if [ -f "$file" ] && [ -r "$file" ] && [ -s "$file" ]; then
    process_file "$file"
fi
```

### Try Command, Fallback

```bash
command1 || command2 || command3
```

**My take**: Try first command. If it fails, try second. If that fails, try third.

### Check if Not

```bash
if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
fi
```

## Common Mistakes (I've Made These)

1. **Wrong syntax**: `[ condition1 && condition2 ]` doesn't work. Use `[ condition1 ] && [ condition2 ]`.

2. **Not using short-circuit**: `command1 && command2` is useful. Use it.

3. **Too many conditions**: Keep it simple. Too many conditions are hard to read.

4. **Wrong operator**: `&&` for AND, `||` for OR. Don't mix them up.

5. **Not using `!`**: `!` inverts conditions. Useful for "if not" checks.

## Real-World Examples

### Validate Multiple Conditions

```bash
if [ -f "$file" ] && [ -r "$file" ] && [ -s "$file" ]; then
    process_file "$file"
else
    echo "File is invalid"
fi
```

### Try Multiple Commands

```bash
ping -c 1 server1 || ping -c 1 server2 || echo "Both servers down"
```

### Check if Not

```bash
if [ ! -d "$backup_dir" ]; then
    mkdir -p "$backup_dir"
fi
```

## What's Next?

Now that you can combine conditions, scripts become more powerful. Or learn about [File Operations](/docs/shell-scripting/file-operations/file-testing) to work with files.

---

> **Personal note**: When I started, I'd write nested if statements. Then I learned logical operators. Now I combine conditions. Scripts are cleaner. More readable. Learn logical operators. They're worth it.
