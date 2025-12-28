---
sidebar_position: 2
title: "Output Redirection: Redirecting Output"
---

# Output Redirection: Where Output Goes

Redirect output to files. Or discard it. Control where it goes.

**Here's the thing: Redirection controls where output goes. Learn it. Use it.**

## Redirect to File

```bash
echo "Hello" > file.txt
```

**My take**: `>` redirects to file. Overwrites.

## Append to File

```bash
echo "Hello" >> file.txt
```

**My take**: `>>` appends. Doesn't overwrite.

## Redirect Input

```bash
command < file.txt
```

**My take**: `<` redirects input. Reads from file.

## Redirect Errors

```bash
command 2> error.log
command 2>> error.log
```

**My take**: `2>` redirects errors. Use it.

## Redirect Both

```bash
command > output.log 2>&1
```

**My take**: `2>&1` redirects errors to stdout. Use it.

## Discard Output

```bash
command > /dev/null
command > /dev/null 2>&1
```

**My take**: `/dev/null` discards. Use it.

## Common Patterns

### Log Everything

```bash
script.sh > output.log 2>&1
```

## What's Next?

Now that you understand redirection, let's talk about [Here Documents](/docs/shell-scripting/input-output/here-documents).

---

> **Personal note**: Redirection seemed confusing at first. Then I learned it. Now I use it constantly. It's essential. Learn it.

