---
sidebar_position: 1
title: "Reading Input: Getting User Data"
---

# Reading Input: Making Scripts Interactive

Scripts need input. User responses. Configuration. File paths.

**Here's the thing: Reading input makes scripts interactive. Useful. User-friendly.**

## Basic read

```bash
read variable
echo "You entered: $variable"
```

**What it does**: Waits for user input. Stores it in variable.

**Real example**:
```bash
$ read name
John
$ echo "Hello, $name"
Hello, John
```

**My take**: Simple. Works. Use it.

## read with Prompt

```bash
read -p "Enter your name: " name
echo "Hello, $name"
```

**The `-p` flag**: Shows a prompt before reading.

**Real example**:
```bash
$ read -p "Enter server name: " server
Enter server name: server1
$ echo "Connecting to $server"
Connecting to server1
```

**My take**: Use `-p` for prompts. Makes scripts user-friendly.

## read with Timeout

```bash
read -t 10 -p "Enter name (10 sec): " name
```

**The `-t` flag**: Times out after seconds.

**My take**: Useful for scripts that can't wait forever. Use it when needed.

## Silent Input (Passwords)

```bash
read -s -p "Enter password: " password
echo
```

**The `-s` flag**: Silent. Doesn't echo input.

**Real example**:
```bash
read -s -p "Enter password: " password
echo
# Password entered, but not shown
```

**My take**: Use `-s` for passwords. Security. Privacy.

## Reading Multiple Values

```bash
read first second third
echo "First: $first, Second: $second, Third: $third"
```

**Input**: `one two three`
**Output**: `First: one, Second: two, Third: three`

**My take**: Useful for structured input. But usually you read one thing at a time.

## Reading into Array

```bash
read -a array
echo "${array[0]}"               # First element
echo "${array[@]}"                # All elements
```

**My take**: Rarely used. But useful when you need arrays from input.

## Reading from File

```bash
while IFS= read -r line; do
    echo "Line: $line"
done < file.txt
```

**The `IFS=`**: Preserves leading/trailing spaces.

**Real example**:
```bash
while IFS= read -r server; do
    echo "Checking $server"
    ping -c 1 "$server"
done < servers.txt
```

**My take**: Useful for processing files line by line. Common pattern.

## Command-Line Arguments

```bash
#!/bin/bash
echo "First argument: $1"
echo "Second argument: $2"
echo "All arguments: $@"
echo "Number of arguments: $#"
```

**Special variables**:
- `$1`, `$2`, `$3` = Arguments
- `$@` = All arguments
- `$#` = Number of arguments
- `$0` = Script name

**Real example**:
```bash
#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

process_file "$1"
```

**My take**: Use arguments for required input. Use `read` for interactive input.

## Common Patterns

### Validate Input

```bash
read -p "Enter filename: " filename
if [ -z "$filename" ]; then
    echo "Error: Filename required"
    exit 1
fi
```

### Read with Default

```bash
read -p "Enter port [8080]: " port
port="${port:-8080}"
echo "Using port: $port"
```

### Read Password

```bash
read -s -p "Enter password: " password
echo
if [ -z "$password" ]; then
    echo "Error: Password required"
    exit 1
fi
```

## Common Mistakes (I've Made These)

1. **Not quoting variables**: `read name` then `echo $name` breaks with spaces. Use `"$name"`.

2. **Forgetting `-r` in while loop**: `read -r` preserves backslashes. Use it.

3. **Not using `IFS=`**: Preserves spaces. Use it when spaces matter.

4. **Not validating input**: Users enter wrong things. Validate it.

5. **Using `read` for everything**: Arguments are better for scripts. `read` for interactive.

## Real-World Examples

### Interactive Script

```bash
#!/bin/bash
read -p "Enter server name: " server
read -p "Enter port [8080]: " port
port="${port:-8080}"

echo "Connecting to $server:$port"
```

### Process File List

```bash
#!/bin/bash
while IFS= read -r file; do
    if [ -f "$file" ]; then
        process_file "$file"
    fi
done < file_list.txt
```

### Validate Arguments

```bash
#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <file1> [file2] ..."
    exit 1
fi

for file in "$@"; do
    process_file "$file"
done
```

## What's Next?

Now that you can read input, scripts become interactive. Or learn about [Text Processing](/docs/shell-scripting/text-processing/grep-advanced) to process data.

---

> **Personal note**: When I started, I'd hardcode everything. Then I learned to read input. Now my scripts are flexible. They adapt. Reading input makes scripts useful.
