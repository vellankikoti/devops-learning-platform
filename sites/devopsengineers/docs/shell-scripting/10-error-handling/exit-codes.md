---
sidebar_position: 1
title: "Exit Codes: Understanding Success and Failure"
---

# Exit Codes: Did It Work or Not?

Every command returns an exit code. 0 means success. Anything else means failure.

**Here's the thing: Exit codes let scripts know if commands worked. That's how you handle errors.**

## The Basic Concept

- **0** = Success
- **1-255** = Failure (different codes mean different things)

**Think of it like a test**: 0 is perfect. Anything else means something went wrong.

## Checking Exit Codes

```bash
command
echo $?                          # Exit code of last command
```

**The `$?` variable**: Contains the exit code of the last command.

**Real example**:
```bash
$ ls /nonexistent
ls: cannot access '/nonexistent': No such file or directory
$ echo $?
2

$ ls /tmp
file1.txt  file2.txt
$ echo $?
0
```

**My take**: `$?` is how you check if something worked. Use it.

## Common Exit Codes

| Code | Meaning | Example |
|------|---------|---------|
| **0** | Success | Command worked |
| **1** | General error | Something went wrong |
| **2** | Misuse of command | Wrong arguments |
| **126** | Not executable | Permission denied |
| **127** | Command not found | Command doesn't exist |
| **130** | Terminated | Ctrl+C |
| **255** | Out of range | Invalid exit code |

**My take**: 0 = success. Non-zero = failure. That's what matters.

## Using Exit Codes

### Check if Command Succeeded

```bash
command
if [ $? -eq 0 ]; then
    echo "Success"
else
    echo "Failed"
fi
```

**My take**: This is the pattern. Check exit code. Act accordingly.

### Shortcut: Direct Check

```bash
if command; then
    echo "Success"
else
    echo "Failed"
fi
```

**This works too**. `if command` automatically checks the exit code.

**My take**: Use this. It's cleaner. Less typing.

### Chain Commands

```bash
# Run command2 only if command1 succeeds
command1 && command2

# Run command2 only if command1 fails
command1 || command2

# Run both regardless
command1 ; command2
```

**Real examples**:
```bash
mkdir backup && cp file.txt backup/
test -f file.txt || echo "File not found"
```

**My take**: `&&` and `||` are useful. Use them. They make scripts cleaner.

## Exit Codes in Scripts

### Setting Exit Codes

```bash
#!/bin/bash
if [ ! -f "$1" ]; then
    echo "Error: File not found"
    exit 1
fi

# Process file
exit 0
```

**The `exit` command**: Sets the script's exit code.

**My take**: Scripts should exit with appropriate codes. 0 for success. Non-zero for failure.

### Using set -e

```bash
#!/bin/bash
set -e                              # Exit on error
```

**What it does**: Script exits immediately if any command fails.

**My take**: Use `set -e`. It catches errors early. Prevents scripts from continuing after failures.

### Using set -o pipefail

```bash
#!/bin/bash
set -o pipefail                     # Fail if any pipe command fails
```

**What it does**: Pipeline fails if any command in it fails.

**My take**: Use this with `set -e`. Makes error handling more reliable.

## Common Patterns

### Validate Input

```bash
if [ -z "$1" ]; then
    echo "Error: Argument required"
    exit 1
fi
```

### Check File Exists

```bash
if [ ! -f "$file" ]; then
    echo "Error: File not found: $file"
    exit 1
fi
```

### Check Command Success

```bash
if ! command; then
    echo "Error: Command failed"
    exit 1
fi
```

## Common Mistakes (I've Made These)

1. **Checking `$?` too late**: `$?` is the last command. Check it immediately.

2. **Not using `set -e`**: Scripts continue after errors. Use `set -e` to stop.

3. **Wrong exit code**: Use 0 for success. Use 1 for general errors. Use appropriate codes.

4. **Forgetting to exit**: Scripts should exit with codes. Don't forget.

5. **Not checking exit codes**: Commands can fail. Check them.

## Real-World Examples

### Backup Script

```bash
#!/bin/bash
set -e

backup_file="$1"
if [ ! -f "$backup_file" ]; then
    echo "Error: File not found"
    exit 1
fi

cp "$backup_file" "${backup_file}.backup"
if [ $? -eq 0 ]; then
    echo "Backup successful"
    exit 0
else
    echo "Backup failed"
    exit 1
fi
```

### Deployment Script

```bash
#!/bin/bash
set -e

deploy() {
    if ! git pull; then
        echo "Git pull failed"
        return 1
    fi
    
    if ! npm install; then
        echo "npm install failed"
        return 1
    fi
    
    if ! npm run build; then
        echo "Build failed"
        return 1
    fi
    
    return 0
}

if deploy; then
    echo "Deployment successful"
    exit 0
else
    echo "Deployment failed"
    exit 1
fi
```

## What's Next?

Now that you understand exit codes, you can handle errors properly. Scripts become more reliable. More professional.

Or learn about [Error Handling](/docs/shell-scripting/error-handling/trap-errors) for more advanced error handling.

---

> **Personal note**: When I started, my scripts would fail silently. Commands would fail, but scripts would continue. Then I learned exit codes. Now my scripts fail loudly. They tell me what went wrong. Exit codes make scripts reliable.
