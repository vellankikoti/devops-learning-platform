---
sidebar_position: 2
title: "Function Parameters: Passing Arguments"
---

# Function Parameters: Pass Data To Functions

Functions can take parameters. Pass data to them. Use it.

**Here's the thing: Function parameters work like script arguments. $1, $2, etc. Simple.**

## Basic Parameters

```bash
function greet() {
    echo "Hello, $1"
}

greet "John"
```

**My take**: `$1` is first parameter. `$2` is second. Like script arguments.

## Multiple Parameters

```bash
function add() {
    sum=$(( $1 + $2 ))
    echo "$sum"
}

add 5 10
```

**My take**: Multiple parameters work. Use them.

## All Parameters

```bash
function process_all() {
    for arg in "$@"; do
        echo "$arg"
    done
}

process_all "one" "two" "three"
```

**My take**: `$@` is all parameters. Use it.

## Common Patterns

### Required Parameters

```bash
function process() {
    if [ $# -lt 2 ]; then
        echo "Usage: process <arg1> <arg2>"
        return 1
    fi
    # Use $1 and $2
}
```

## What's Next?

Now that you understand parameters, let's talk about [Return Values](/docs/shell-scripting/functions/return-values).

---

> **Personal note**: Function parameters seemed complex at first. Then I learned: they're like script arguments. Now I use them constantly. They're simple. Learn them.


