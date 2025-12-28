---
sidebar_position: 2
title: "Variable Types: Strings And Numbers"
---

# Variable Types: What Shell Variables Are

Shell variables are strings. Always. Even numbers are strings.

**Here's the thing: Everything is a string in shell. Numbers are strings. Learn to work with that.**

## Strings: The Default

```bash
name="John"
message="Hello, World!"
```

**My take**: Strings are default. Use quotes. Always.

## Numbers: Strings That Look Like Numbers

```bash
count=10
price=99.99
```

**My take**: Numbers are strings. But you can do math with them.

## Arrays: Collections

```bash
fruits=("apple" "banana" "orange")
```

**My take**: Arrays are collections. We'll cover them later.

## Working With Types

### Strings

```bash
name="John"
echo "Hello, $name"
```

**My take**: Strings are simple. Use quotes. Use `$` to expand.

### Numbers

```bash
count=10
next=$((count + 1))
```

**My take**: Use `$((...))` for math. It converts strings to numbers.

## Common Patterns

### String Concatenation

```bash
first="Hello"
second="World"
combined="$first $second"
```

### Number Operations

```bash
a=10
b=5
sum=$((a + b))
```

## What's Next?

Now that you understand types, let's talk about [Special Variables](/docs/shell-scripting/variables/special-variables) that shell provides.

---

> **Personal note**: I used to fight with types. Then I learned: everything is a string. Now I work with it. It's simpler than I thought.

