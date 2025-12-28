---
sidebar_position: 2
title: "Directory Operations: Working With Directories"
---

# Directory Operations: Create And Manage Directories

Create directories. Remove them. Navigate them. Common operations.

**Here's the thing: Directory operations are common. Learn them. Use them.**

## Create Directory

```bash
mkdir dirname
mkdir -p path/to/dir
```

**My take**: `mkdir` creates. `-p` creates parents.

## Remove Directory

```bash
rmdir dirname
rm -r dirname
```

**My take**: `rmdir` removes empty. `rm -r` removes all.

## Navigate

```bash
cd dirname
cd ..
cd ~
```

**My take**: `cd` navigates. Common.

## Common Patterns

### Create Structure

```bash
mkdir -p project/{src,docs,tests}
```

## What's Next?

Now that you understand directory operations, let's talk about [File Searching](/docs/shell-scripting/file-operations/file-searching).

---

> **Personal note**: Directory operations seemed simple. Then I used them. Now I use them constantly. They're essential. Learn them.


