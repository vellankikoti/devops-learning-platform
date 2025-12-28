---
sidebar_position: 4
title: "Local Variables: Function Scope"
---

# Local Variables: Keep Functions Isolated

Local variables are only in functions. Don't affect global. Use them.

**Here's the thing: Use local variables in functions. Prevents conflicts. Keeps functions isolated.**

## Basic Local

```bash
count=0

function increment() {
    local count=$((count + 1))
    echo "$count"
}

increment
echo "$count"  # Still 0
```

**My take**: `local` makes variables local. Use it in functions.

## Why It Matters

### Without Local

```bash
name="Global"

function change() {
    name="Local"
}

change
echo "$name"  # Changed to "Local"!
```

**My take**: Without local, you change globals. Be careful.

### With Local

```bash
name="Global"

function change() {
    local name="Local"
    echo "$name"
}

change
echo "$name"  # Still "Global"
```

**My take**: With local, globals stay safe. Use it.

## Common Patterns

### Always Use Local

```bash
function process() {
    local temp_file="/tmp/process_$$"
    local count=0
    # Use local variables
}
```

## Common Mistakes (I've Made These)

1. **Forgetting local**: Always use `local` in functions. Prevents conflicts.

2. **Changing globals**: Don't change globals accidentally. Use local.

3. **Not understanding scope**: Understand where variables are available.

## What's Next?

Now that you understand local variables, let's talk about [Recursive Functions](/docs/shell-scripting/functions/recursive-functions).

---

> **Personal note**: I used to forget local. Then I had conflicts. Now I always use local in functions. It prevents problems. Do it.

