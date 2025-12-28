---
sidebar_position: 3
title: "Associative Arrays: Key-Value Pairs"
---

# Associative Arrays: Key-Value Arrays

Associative arrays use keys. Like dictionaries. Key-value pairs.

**Here's the thing: Associative arrays are like dictionaries. Use keys instead of numbers. Useful.**

## Declaring

```bash
declare -A colors
colors["red"]="#FF0000"
colors["green"]="#00FF00"
```

**My take**: `declare -A` creates associative array. Use it.

## Accessing

```bash
echo "${colors[red]}"
```

**My take**: Access by key. Not by number.

## Iterating

```bash
for key in "${!colors[@]}"; do
    echo "$key: ${colors[$key]}"
done
```

**My take**: `${!array[@]}` gets keys. Use it.

## Common Patterns

### Configuration

```bash
declare -A config
config["host"]="example.com"
config["port"]="8080"
```

## What's Next?

Now that you understand associative arrays, let's talk about [Array Iteration](/docs/shell-scripting/arrays/array-iteration).

---

> **Personal note**: Associative arrays seemed unnecessary at first. Then I used them. Now I use them for configs. They're useful. Learn them.

