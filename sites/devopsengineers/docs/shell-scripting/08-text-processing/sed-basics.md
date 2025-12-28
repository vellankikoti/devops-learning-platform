---
sidebar_position: 2
title: "sed Basics: Stream Editor"
---

# sed Basics: Edit Text Streams

sed edits text streams. Substitute. Delete. Insert. Powerful.

**Here's the thing: sed edits text. Learn it. It's powerful.**

## Substitute

```bash
echo "hello world" | sed 's/world/universe/'
```

**My take**: `s/old/new/` substitutes. Use it.

## Delete Lines

```bash
sed '2d' file.txt
```

**My take**: `d` deletes lines. Use it.

## Common Patterns

### Replace in File

```bash
sed -i 's/old/new/g' file.txt
```

**My take**: `-i` edits in place. `g` replaces all.

## What's Next?

Now that you understand sed basics, let's talk about [sed Advanced](/docs/shell-scripting/text-processing/sed-advanced).

---

> **Personal note**: sed seemed complex at first. Then I learned basics. Now I use it. It's powerful. Learn it.

