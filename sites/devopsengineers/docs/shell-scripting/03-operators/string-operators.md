---
sidebar_position: 4
title: "String Operators: Working With Strings"
---

# String Operators: Compare And Manipulate Strings

String operators compare strings. Check if they're empty. Compare them.

**Here's the thing: String operators are useful. Learn them. Use them.**

## Comparison Operators

### Equal

```bash
if [ "$name" = "John" ]; then
    echo "Match"
fi
```

**My take**: `=` compares strings. Use it.

### Not Equal

```bash
if [ "$name" != "John" ]; then
    echo "Different"
fi
```

**My take**: `!=` checks not equal. Use it.

## Empty Checks

### -z: Empty String

```bash
if [ -z "$name" ]; then
    echo "Empty"
fi
```

**My take**: `-z` checks if empty. Use it.

### -n: Not Empty

```bash
if [ -n "$name" ]; then
    echo "Has value"
fi
```

**My take**: `-n` checks if not empty. Use it.

## String Length

```bash
name="John"
length=${#name}
echo "$length"  # 4
```

**My take**: `${#var}` gets length. Useful.

## Common Patterns

### Check If Empty

```bash
if [ -z "$input" ]; then
    echo "Input required"
    exit 1
fi
```

### Compare Strings

```bash
if [ "$status" = "active" ]; then
    echo "Running"
fi
```

## What's Next?

Now that you understand string operators, let's talk about [Operator Precedence](/docs/shell-scripting/operators/operator-precedence).

---

> **Personal note**: String operators seemed simple. Then I learned them properly. Now I use them constantly. They're essential. Learn them.

