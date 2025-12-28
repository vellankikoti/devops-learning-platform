---
sidebar_position: 6
title: "Regex In Bash: Regular Expressions"
---

# Regex In Bash: Pattern Matching

Regular expressions match patterns. In bash. With =~.

**Here's the thing: Regex matches patterns. Learn it. Use it.**

## =~ Operator

```bash
if [[ "hello" =~ ^h ]]; then
    echo "Matches"
fi
```

**My take**: `=~` matches regex. Use it.

## Common Patterns

### Email Validation

```bash
if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "Valid email"
fi
```

## What's Next?

Now that you understand regex, you can match patterns. Or review [Advanced Features](/docs/shell-scripting/advanced-features/parameter-expansion) to reinforce.

---

> **Personal note**: Regex seemed complex at first. Then I learned basics. Now I use it when needed. It's powerful. Learn it.


