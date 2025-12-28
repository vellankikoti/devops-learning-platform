---
sidebar_position: 5
title: "Globbing Patterns: File Matching"
---

# Globbing Patterns: Match Files

Globbing patterns match files. Wildcards. Ranges. Useful.

**Here's the thing: Globbing matches files. Learn patterns. Use them.**

## Wildcards

```bash
*.txt
file?.txt
```

**My take**: `*` matches many. `?` matches one.

## Ranges

```bash
file[0-9].txt
file[a-z].txt
```

**My take**: `[]` matches ranges. Use them.

## Common Patterns

### Match Files

```bash
for file in *.txt; do
    process "$file"
done
```

## What's Next?

Now that you understand globbing, let's talk about [Regex In Bash](/docs/shell-scripting/advanced-features/regex-in-bash).

---

> **Personal note**: Globbing seemed simple at first. Then I learned patterns. Now I use them constantly. They're useful. Learn them.


