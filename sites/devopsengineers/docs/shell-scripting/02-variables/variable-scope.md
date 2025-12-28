---
sidebar_position: 5
title: "Variable Scope: Local vs Global"
---

# Variable Scope: Where Variables Work

Variables have scope. Global. Local. Understand it.

**Here's the thing: Scope matters. Global variables are everywhere. Local variables are in functions.**

## Global Variables

```bash
name="John"

function greet() {
    echo "Hello, $name"
}

greet
```

**My take**: Global variables are available everywhere. In functions too.

## Local Variables

```bash
function example() {
    local count=10
    echo "$count"
}

example
echo "$count"  # Empty - not available
```

**My take**: `local` makes variables local. Use it in functions.

## Why It Matters

### Without Local

```bash
count=0

function increment() {
    count=$((count + 1))
}

increment
echo "$count"  # Changed!
```

**My take**: Without `local`, you change global variables. Be careful.

### With Local

```bash
count=0

function increment() {
    local count=$((count + 1))
    echo "$count"
}

increment
echo "$count"  # Still 0
```

**My take**: With `local`, you don't change global. Safer.

## Common Patterns

### Use Local in Functions

```bash
function process() {
    local temp_file="/tmp/process_$$"
    # Use temp_file
}
```

## Common Mistakes (I've Made These)

1. **Not using local**: Use `local` in functions. Avoid conflicts.

2. **Changing globals**: Be careful. Don't change globals accidentally.

3. **Not understanding scope**: Understand where variables are available.

## What's Next?

Now that you understand scope, let's talk about [Best Practices](/docs/shell-scripting/variables/best-practices) for variables.

---

> **Personal note**: Scope confused me at first. Then I learned: use `local` in functions. Now I do it always. It prevents problems.

