---
sidebar_position: 5
title: "Operator Precedence: Order Matters"
---

# Operator Precedence: What Happens First

Operators have precedence. Some happen before others. Understand it.

**Here's the thing: Precedence matters. Use parentheses when unsure. Make it clear.**

## Arithmetic Precedence

```bash
result=$((2 + 3 * 4))            # 14, not 20
result=$(((2 + 3) * 4))          # 20
```

**My take**: Multiplication before addition. Use parentheses to clarify.

## Logical Precedence

```bash
if [ "$a" = "1" ] && [ "$b" = "2" ] || [ "$c" = "3" ]; then
    # Ambiguous
fi

if ([ "$a" = "1" ] && [ "$b" = "2" ]) || [ "$c" = "3" ]; then
    # Clear
fi
```

**My take**: Use parentheses. Make it clear.

## Common Patterns

### Use Parentheses

```bash
result=$(((a + b) * c))
```

### Group Conditions

```bash
if ([ "$x" = "1" ] && [ "$y" = "2" ]) || [ "$z" = "3" ]; then
    echo "Match"
fi
```

## Common Mistakes (I've Made These)

1. **Not using parentheses**: Use them. Make it clear.

2. **Assuming order**: Don't assume. Use parentheses.

3. **Complex expressions**: Break them down. Simpler is better.

## What's Next?

Now that you understand precedence, you can write clearer expressions. Or review [Operators](/docs/shell-scripting/operators/arithmetic-operators) to reinforce.

---

> **Personal note**: Precedence confused me at first. Then I learned: use parentheses. Now I always use them. It's clearer. Do it.

