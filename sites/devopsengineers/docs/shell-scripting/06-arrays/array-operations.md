---
sidebar_position: 2
title: "Array Operations: Adding And Removing"
---

# Array Operations: Modify Arrays

Arrays can be modified. Add elements. Remove elements. Change them.

**Here's the thing: Array operations let you modify arrays. Learn them. Use them.**

## Adding Elements

```bash
fruits=("apple" "banana")
fruits+=("orange")
```

**My take**: `+=` adds elements. Simple.

## Removing Elements

```bash
fruits=("apple" "banana" "orange")
unset fruits[1]  # Remove banana
```

**My take**: `unset` removes elements. Use it.

## Modifying Elements

```bash
fruits=("apple" "banana")
fruits[0]="grape"
```

**My take**: Modify by index. Simple.

## Common Patterns

### Add Multiple

```bash
items=("one")
items+=("two" "three")
```

## What's Next?

Now that you understand operations, let's talk about [Associative Arrays](/docs/shell-scripting/arrays/associative-arrays).

---

> **Personal note**: Array operations seemed complex. Then I learned them. Now I use them. They're useful. Learn them.


