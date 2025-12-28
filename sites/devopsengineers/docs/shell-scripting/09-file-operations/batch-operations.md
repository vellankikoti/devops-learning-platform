---
sidebar_position: 5
title: "Batch Operations: Process Multiple Files"
---

# Batch Operations: Process Many Files

Process multiple files. Batch operations. Common pattern.

**Here's the thing: Batch operations process many files. Learn patterns. Use them.**

## Loop Through Files

```bash
for file in *.txt; do
    process "$file"
done
```

**My take**: Loop through files. Common pattern.

## With find

```bash
find . -name "*.txt" -exec process {} \;
```

**My take**: find processes files. Use it.

## Common Patterns

### Process All

```bash
for file in *.log; do
    gzip "$file"
done
```

## What's Next?

Now that you understand batch operations, you can process files. Or review [File Operations](/docs/shell-scripting/file-operations/file-testing) to reinforce.

---

> **Personal note**: Batch operations seemed tedious at first. Then I learned patterns. Now I use them constantly. They're useful. Learn them.

