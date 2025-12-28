---
sidebar_position: 5
title: "Recursive Functions: Functions Calling Themselves"
---

# Recursive Functions: Functions That Call Themselves

Recursive functions call themselves. Useful for some problems.

**Here's the thing: Recursion is powerful. But use it carefully. It can be slow.**

## Basic Recursion

```bash
function countdown() {
    local n=$1
    if [ $n -le 0 ]; then
        echo "Done"
        return
    fi
    echo "$n"
    countdown $((n - 1))
}

countdown 5
```

**My take**: Recursion calls itself. Has a base case. Use it.

## Factorial

```bash
function factorial() {
    local n=$1
    if [ $n -le 1 ]; then
        echo 1
        return
    fi
    local prev=$(factorial $((n - 1)))
    echo $((n * prev))
}

result=$(factorial 5)
echo "$result"
```

**My take**: Factorial is classic recursion. Learn it.

## When to Use

**Use recursion when**:
- Problem is naturally recursive
- Depth is limited
- Code is clearer

**Don't use when**:
- Depth is unknown
- Performance matters
- Iteration is simpler

**My take**: Use recursion when it fits. But iteration is often simpler.

## Common Mistakes (I've Made These)

1. **No base case**: Recursion needs base case. Without it, infinite loop.

2. **Too deep**: Deep recursion can fail. Be careful.

3. **Not needed**: Sometimes iteration is simpler. Use it.

## What's Next?

Now that you understand recursion, let's talk about [Function Libraries](/docs/shell-scripting/functions/function-libraries).

---

> **Personal note**: Recursion seemed magical at first. Then I learned it's just functions calling themselves. Now I use it when it fits. But iteration is often simpler.


