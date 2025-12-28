---
sidebar_position: 6
title: "cut, sort, uniq: Text Tools"
---

# cut, sort, uniq: Simple Text Tools

cut extracts fields. sort sorts. uniq finds unique. Simple tools.

**Here's the thing: These tools are simple. But useful. Learn them.**

## cut

```bash
cut -d: -f1 /etc/passwd
```

**My take**: `cut` extracts fields. Use it.

## sort

```bash
sort file.txt
sort -r file.txt  # Reverse
```

**My take**: `sort` sorts lines. Use it.

## uniq

```bash
sort file.txt | uniq
```

**My take**: `uniq` finds unique. Sort first.

## Common Patterns

### Combine

```bash
cut -d: -f1 /etc/passwd | sort | uniq
```

## What's Next?

Now that you understand these tools, let's talk about [Text Processing Examples](/docs/shell-scripting/text-processing/text-processing-examples).

---

> **Personal note**: These tools seemed simple. Then I used them. Now I use them constantly. They're useful. Learn them.

