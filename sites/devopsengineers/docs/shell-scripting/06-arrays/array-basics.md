---
sidebar_position: 1
title: "Arrays: Working with Collections"
---

# Arrays: Multiple Values in One Variable

Arrays are just variables that hold multiple values. That's it.

**But here's the thing: Arrays make scripts powerful. You can process lists. You can iterate over data. You can organize information.**

## What Arrays Actually Are

Think of arrays like a list. One variable. Multiple values.

```bash
fruits=("apple" "banana" "orange")
```

That's an array. Three values. One variable.

## Creating Arrays

```bash
# Basic
fruits=("apple" "banana" "orange")

# Explicit
declare -a fruits=("apple" "banana" "orange")

# One at a time
fruits[0]="apple"
fruits[1]="banana"
fruits[2]="orange"
```

**All three work. Use the first one. It's simplest.**

**Important**: Arrays start at 0. First element is `[0]`, not `[1]`. This confuses everyone at first.

## Accessing Elements

```bash
fruits=("apple" "banana" "orange")
echo "${fruits[0]}"               # apple
echo "${fruits[1]}"               # banana
echo "${fruits[2]}"               # orange
```

**The braces are important**. `` `${fruits[0]}` `` not `$fruits[0]`. Bash needs the braces.

## Accessing All Elements

```bash
fruits=("apple" "banana" "orange")
echo "${fruits[@]}"              # All elements (separate)
echo "${fruits[*]}"              # All elements (one string)
```

**The difference**: `@` gives you separate words. `*` gives you one string.

**My take**: Use `@`. Always. It's what you want 99% of the time.

**Real example**:
```bash
$ fruits=("apple" "banana" "orange")
$ for fruit in "${fruits[@]}"; do echo "$fruit"; done
apple
banana
orange
```

## Array Length

```bash
fruits=("apple" "banana" "orange")
echo "${#fruits[@]}"             # 3
```

**The `#` gives you the length**. `` `${#array[@]}` `` = number of elements.

## Array Indices

```bash
echo "${!fruits[@]}"             # 0 1 2
```

**The `!` gives you the indices**. Useful when you need to know which indices exist.

## Looping Through Arrays

```bash
# By index
for i in "${!fruits[@]}"; do
    echo "$i: ${fruits[$i]}"
done

# By value
for fruit in "${fruits[@]}"; do
    echo "$fruit"
done
```

**My take**: Loop by value most of the time. Simpler. Loop by index when you need the index.

## Adding Elements

```bash
fruits=("apple" "banana")
fruits+=("orange")               # Add to end
fruits[3]="grape"                # Add at index
```

**The `+=` adds to the end**. Simple.

## Removing Elements

```bash
unset fruits[1]                  # Remove element
fruits=("${fruits[@]}")          # Reindex (optional)
```

**`unset` removes an element**. The reindexing is optional. Usually you don't need it.

## Real-World Examples

### Process Multiple Files

```bash
files=("file1.txt" "file2.txt" "file3.txt")

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "Processing $file"
        # Process file
    fi
done
```

### Server List

```bash
servers=("server1.example.com" "server2.example.com" "server3.example.com")

for server in "${servers[@]}"; do
    echo "Checking $server"
    ping -c 1 "$server" > /dev/null && echo "$server is up" || echo "$server is down"
done
```

### Configuration Values

```bash
config=("nginx" "8080" "/var/www/html")

service="${config[0]}"
port="${config[1]}"
directory="${config[2]}"

echo "Service: $service, Port: $port, Directory: $directory"
```

## Common Mistakes (I've Made These)

1. **Forgetting braces**: `$fruits[0]` doesn't work. Use `` `${fruits[0]}` ``.

2. **Using `*` instead of `@`**: `*` gives one string. `@` gives separate words. Use `@`.

3. **Not quoting**: `"${fruits[@]}"` not `${fruits[@]}`. Quotes matter.

4. **Starting at 1**: Arrays start at 0. Not 1. This confuses everyone.

5. **Forgetting `#` for length**: `` `${#array[@]}` `` not `${array[@]}` for length.

## What's Next?

Now that you understand arrays, let's talk about [File Operations](/docs/shell-scripting/file-operations/file-testing). We'll cover working with files programmatically.

Or practice with arrays. Create some. Loop through them. Get comfortable.

---

> **Personal note**: When I started, I avoided arrays. I'd use multiple variables. `file1`, `file2`, `file3`. Then I learned arrays. Now I use them constantly. They make scripts so much cleaner. Learn arrays. They're worth it.
