---
sidebar_position: 3
title: "Return Values: Getting Output From Functions"
---

# Return Values: Functions Return Data

Functions return exit codes. Or output. Use both.

**Here's the thing: Functions return exit codes. Or you can capture output. Use what fits.**

## Exit Codes

```bash
function check_file() {
    if [ -f "$1" ]; then
        return 0
    else
        return 1
    fi
}

check_file "test.txt"
if [ $? -eq 0 ]; then
    echo "File exists"
fi
```

**My take**: Exit codes are 0 for success, non-zero for failure. Use them.

## Capturing Output

```bash
function get_name() {
    echo "John"
}

name=$(get_name)
echo "$name"
```

**My take**: Capture output with `$()`. Use it for data.

## Both

```bash
function process() {
    if [ $# -eq 0 ]; then
        return 1
    fi
    echo "Processed: $1"
    return 0
}

result=$(process "data")
if [ $? -eq 0 ]; then
    echo "$result"
fi
```

**My take**: Use both. Exit code for success. Output for data.

## Common Patterns

### Return Status

```bash
function validate() {
    if [ -z "$1" ]; then
        return 1
    fi
    return 0
}
```

### Return Data

```bash
function get_config() {
    echo "/etc/myapp.conf"
}

config=$(get_config)
```

## What's Next?

Now that you understand return values, let's talk about [Local Variables](/docs/shell-scripting/functions/local-variables).

---

> **Personal note**: Return values confused me at first. Then I learned: exit codes for status, output for data. Now I use both. They're useful. Learn them.

