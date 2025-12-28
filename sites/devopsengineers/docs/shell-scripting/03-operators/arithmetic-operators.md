---
sidebar_position: 1
title: "Arithmetic Operators: Math in Scripts"
---

# Arithmetic: Math in Scripts

Scripts need to do math. Add. Subtract. Multiply. Divide.

**Here's the thing: Arithmetic is simple. But you need to know the syntax. Learn it once. Use it forever.**

## Basic Arithmetic

### Using $(( ))

```bash
result=$((5 + 3))                # 8
result=$((10 - 4))               # 6
result=$((6 * 2))                # 12
result=$((8 / 2))                # 4
result=$((10 % 3))               # 1 (remainder)
```

**The `$(( ))`**: Arithmetic expansion. This is what you'll use.

**My take**: Use `$(( ))`. It's simple. It works. It's what everyone uses.

### Operators

```bash
+                                # Addition
-                                # Subtraction
*                                # Multiplication
/                                # Division
%                                # Modulo (remainder)
**                               # Exponentiation (bash 4+)
```

**My take**: Standard math operators. Nothing special.

## Increment and Decrement

```bash
count=10
((count++))                      # Increment: 11
((count--))                      # Decrement: 10
((count+=5))                     # Add 5: 15
((count-=3))                     # Subtract 3: 12
```

**My take**: Increment/decrement is common. Use it in loops.

## Real-World Examples

### Counter

```bash
count=0
for i in {1..10}; do
    ((count++))
done
echo "Count: $count"
```

### Calculate

```bash
total=$((price * quantity))
discount=$((total * 10 / 100))
final=$((total - discount))
```

### Check Even/Odd

```bash
if (( number % 2 == 0 )); then
    echo "Even"
else
    echo "Odd"
fi
```

## Common Mistakes (I've Made These)

1. **Forgetting `$(( ))`**: `result=5+3` doesn't work. Use `result=$((5+3))`.

2. **Spaces in `$(( ))`**: `$((5+3))` works. `$(( 5 + 3 ))` also works. Both fine.

3. **Division with integers**: `$((10/3))` = 3 (integer division). No decimals.

4. **Using `let`**: `let` works, but `$(( ))` is better. Use `$(( ))`.

5. **Using `expr`**: `expr` is old. Use `$(( ))`. It's better.

## What's Next?

Now that you can do math, scripts can calculate. Or learn about [Comparison Operators](/docs/shell-scripting/operators/comparison-operators) to compare values.

---

> **Personal note**: When I started, I'd use `expr` for math. Then I learned `$(( ))`. Now I use it for everything. It's simpler. It's better. Learn it.
