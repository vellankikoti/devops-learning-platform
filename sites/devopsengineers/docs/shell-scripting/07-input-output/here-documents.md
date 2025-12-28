---
sidebar_position: 3
title: "Here Documents: Multi-Line Input"
---

# Here Documents: Multi-Line Strings

Here documents create multi-line strings. Useful for templates.

**Here's the thing: Here documents are multi-line strings. Use them for templates.**

## Basic Syntax

```bash
cat << EOF
Line 1
Line 2
Line 3
EOF
```

**My take**: `<<` starts here document. `EOF` ends it.

## With Variables

```bash
name="John"
cat << EOF
Hello, $name
Welcome!
EOF
```

**My take**: Variables expand in here documents. Use them.

## To File

```bash
cat > config.txt << EOF
host=example.com
port=8080
EOF
```

**My take**: Redirect here document to file. Useful.

## Common Patterns

### Generate Config

```bash
cat > nginx.conf << EOF
server {
    listen 80;
    server_name example.com;
}
EOF
```

## What's Next?

Now that you understand here documents, let's talk about [Here Strings](/docs/shell-scripting/input-output/here-strings).

---

> **Personal note**: Here documents seemed unnecessary at first. Then I used them for templates. Now I use them constantly. They're useful. Learn them.

