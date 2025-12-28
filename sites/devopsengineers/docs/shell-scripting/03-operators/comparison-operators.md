---
sidebar_position: 2
title: "Comparison Operators: Making Comparisons"
---

# Comparison Operators: Compare Values

Scripts need to compare values. Is this equal to that? Is this greater than that?

**Here's the thing: Comparisons are how scripts make decisions. Learn them. Use them.**

## Numeric Comparisons

```bash
[ $a -eq $b ]                    # Equal
[ $a -ne $b ]                    # Not equal
[ $a -lt $b ]                    # Less than
[ $a -le $b ]                    # Less than or equal
[ $a -gt $b ]                    # Greater than
[ $a -ge $b ]                    # Greater than or equal
```

**Memory trick**: `-eq` = equal, `-ne` = not equal, `-lt` = less than, `-gt` = greater than.

**Real example**:
```bash
a=10
b=20

if [ $a -lt $b ]; then
    echo "$a is less than $b"
fi
```

**My take**: Use these for numbers. They work. Simple.

## String Comparisons

```bash
[ "$str1" = "$str2" ]            # Equal
[ "$str1" != "$str2" ]           # Not equal
[ -z "$str" ]                    # Empty string
[ -n "$str" ]                    # Non-empty string
```

**Important**: Always quote strings. `[ "$name" = "John" ]` not `[ $name = "John" ]`.

**Real example**:
```bash
if [ "$USER" = "root" ]; then
    echo "Running as root"
fi

if [ -z "$BACKUP_DIR" ]; then
    BACKUP_DIR="/backup"
fi
```

**My take**: Quote strings. Always. Spaces break things without quotes.

## Common Patterns

### Check if Equal

```bash
if [ "$value" = "expected" ]; then
    echo "Match"
fi
```

### Check if Not Empty

```bash
if [ -n "$variable" ]; then
    echo "Variable is set"
fi
```

### Check if Empty

```bash
if [ -z "$variable" ]; then
    echo "Variable is empty"
fi
```

## Common Mistakes (I've Made These)

1. **Using `=` for numbers**: Use `-eq` for numbers, `=` for strings.

2. **Not quoting strings**: `[ $name = "John" ]` breaks with spaces. Use `[ "$name" = "John" ]`.

3. **Wrong operator**: `-lt` for less than, `-gt` for greater than. Don't mix them up.

4. **Spaces in brackets**: `[condition]` doesn't work. Use `[ condition ]`. Spaces required.

5. **Using `==`**: `=` works. `==` also works, but `=` is more portable.

## Real-World Examples

### Validate Input

```bash
if [ "$1" = "start" ]; then
    start_service
elif [ "$1" = "stop" ]; then
    stop_service
else
    echo "Usage: $0 {start|stop}"
fi
```

### Check Number Range

```bash
if [ $age -ge 18 ] && [ $age -le 65 ]; then
    echo "Valid age"
fi
```

### Check if Variable Set

```bash
if [ -z "$PORT" ]; then
    PORT=8080
fi
```

## What's Next?

Now that you can compare values, scripts can make decisions. Or learn about [Logical Operators](/docs/shell-scripting/operators/logical-operators) to combine conditions.

---

> **Personal note**: When I started, I'd use `=` for everything. Then I learned the difference. Numbers use `-eq`. Strings use `=`. Small detail. Big difference.
