---
sidebar_position: 6
title: "Nested Controls: Complex Logic"
---

# Nested Controls: Combining Control Structures

Nested controls combine if, loops, case. Complex logic.

**Here's the thing: Nested controls are powerful. But keep them simple. Don't nest too deep.**

## Nested If

```bash
if [ "$status" = "active" ]; then
    if [ "$count" -gt 10 ]; then
        echo "Active and many"
    else
        echo "Active but few"
    fi
else
    echo "Inactive"
fi
```

**My take**: Nested if works. But keep it simple.

## Loop With If

```bash
for file in *.txt; do
    if [ -f "$file" ]; then
        process "$file"
    fi
done
```

**My take**: Loops with if are common. Use them.

## Complex Nesting

```bash
for dir in */; do
    if [ -d "$dir" ]; then
        case "$dir" in
            "important"*)
                for file in "$dir"/*; do
                    if [ -f "$file" ]; then
                        process "$file"
                    fi
                done
                ;;
        esac
    fi
done
```

**My take**: Complex nesting works. But keep it readable.

## Common Patterns

### Nested Loops

```bash
for i in {1..3}; do
    for j in {1..3}; do
        echo "$i $j"
    done
done
```

## Common Mistakes (I've Made These)

1. **Too deep nesting**: Keep nesting shallow. 2-3 levels max.

2. **Hard to read**: Complex nesting is hard to read. Simplify.

3. **Not using functions**: Functions reduce nesting. Use them.

## What's Next?

Now that you understand nested controls, you can write complex logic. Or review [Control Flow](/docs/shell-scripting/control-flow/if-else-statements) to reinforce.

---

> **Personal note**: I used to nest deeply. Then code was hard to read. Now I keep it shallow. Use functions. It's better.

