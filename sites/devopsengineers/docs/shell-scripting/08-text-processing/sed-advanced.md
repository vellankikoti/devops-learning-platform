---
sidebar_position: 3
title: "sed Advanced: Advanced Patterns"
---

# sed Advanced: Complex Editing

Advanced sed uses patterns. Ranges. Hold space. Complex edits.

**Here's the thing: Advanced sed is powerful. But complex. Learn basics first.**

## Patterns

```bash
sed '/pattern/d' file.txt
```

**My take**: Patterns match lines. Use them.

## Ranges

```bash
sed '2,5d' file.txt
```

**My take**: Ranges work on multiple lines. Use them.

## Common Patterns

### Complex Substitution

```bash
sed 's/pattern/replacement/g' file.txt
```

## What's Next?

Now that you understand advanced sed, let's talk about [awk Basics](/docs/shell-scripting/text-processing/awk-basics).

---

> **Personal note**: Advanced sed seemed too complex. Then I learned it gradually. Now I use it when needed. It's powerful. Learn it.

