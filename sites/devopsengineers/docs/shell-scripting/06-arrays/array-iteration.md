---
sidebar_position: 4
title: "Array Iteration: Looping Through Arrays"
---

# Array Iteration: Loop Through Arrays

Iterate through arrays. Process each element. Common pattern.

**Here's the thing: Array iteration is common. Learn the patterns. Use them.**

## Basic Iteration

```bash
fruits=("apple" "banana" "orange")
for fruit in "${fruits[@]}"; do
    echo "$fruit"
done
```

**My take**: `${array[@]}` gets all elements. Use it.

## With Index

```bash
fruits=("apple" "banana" "orange")
for i in "${!fruits[@]}"; do
    echo "$i: ${fruits[$i]}"
done
```

**My take**: `${!array[@]}` gets indices. Use it.

## Common Patterns

### Process All

```bash
files=("file1.txt" "file2.txt")
for file in "${files[@]}"; do
    process "$file"
done
```

## What's Next?

Now that you understand iteration, you can work with arrays. Or review [Arrays](/docs/shell-scripting/arrays/array-basics) to reinforce.

---

> **Personal note**: Array iteration seemed complex. Then I learned the patterns. Now I use them constantly. They're essential. Learn them.


