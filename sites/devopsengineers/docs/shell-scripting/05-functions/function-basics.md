---
sidebar_position: 1
title: "Functions: Reusable Code Blocks"
---

# Functions: Write Once, Use Many Times

Functions are just code you write once and call whenever you need it. That's it.

**But here's the thing: Functions make scripts maintainable. They make code reusable. They make scripts professional.**

Without functions, you repeat code. With functions, you write it once and call it.

## What Functions Actually Are

Think of functions like recipes. You write the recipe once. Then you use it whenever you need that dish.

```bash
greet() {
    echo "Hello, World!"
}

greet                            # Call it
greet                            # Call it again
```

Same code. Multiple uses. That's functions.

## Defining Functions

```bash
function_name() {
    # commands
}
```

**Example**:
```bash
backup_file() {
    cp "$1" "${1}.backup"
    echo "Backed up: $1"
}

backup_file "important.txt"
```

**The `$1` is the first argument**. We'll cover that.

**Memory trick**: `function_name() { ... }`. Simple.

## Function Arguments

Functions can take arguments. Like commands take arguments.

```bash
greet() {
    echo "Hello, $1"
}

greet "John"                     # $1 = "John"
greet "Jane"                     # $1 = "Jane"
```

**Arguments**:
- `$1` = First argument
- `$2` = Second argument
- `$3` = Third argument
- `$@` = All arguments
- `$#` = Number of arguments

**Real example**:
```bash
add() {
    result=$(( $1 + $2 ))
    echo "$1 + $2 = $result"
}

add 5 3                          # Output: 5 + 3 = 8
```

## Multiple Arguments

```bash
print_all() {
    for arg in "$@"; do
        echo "Argument: $arg"
    done
}

print_all "one" "two" "three"
```

The `$@` is all arguments. Useful when you don't know how many there are.

## Return Values (Sort Of)

Bash functions don't return values like other languages. They return exit codes.

```bash
check_file() {
    if [ -f "$1" ]; then
        return 0                  # Success
    else
        return 1                  # Failure
    fi
}

if check_file "file.txt"; then
    echo "File exists"
fi
```

**Exit codes**: `0` = success, anything else = failure. That's how bash works.

**My take**: Functions return exit codes. Use them for success/failure. For actual values, use `echo` and capture with `$()`.

## Local Variables

Variables in functions are global by default. Use `local` to make them local.

```bash
count() {
    local count=0                # Local variable
    for i in {1..10}; do
        count=$((count + 1))
    done
    echo "Count: $count"
}
```

**Why it matters**: Without `local`, functions can overwrite global variables. That's bad.

**My take**: Always use `local` for function variables. It prevents conflicts.

## Real-World Examples

### Logging Function

```bash
log() {
    local level="$1"
    shift
    local message="$*"
    echo "[$(date)] [$level] $message"
}

log "INFO" "Script started"
log "ERROR" "Something went wrong"
```

### Backup Function

```bash
backup_file() {
    local file="$1"
    if [ ! -f "$file" ]; then
        echo "Error: File not found: $file"
        return 1
    fi
    cp "$file" "${file}.backup"
    return 0
}

if backup_file "config.txt"; then
    echo "Backup successful"
fi
```

### Validation Function

```bash
validate_user() {
    if [ -z "$1" ]; then
        echo "Error: Username required"
        return 1
    fi
    if ! id "$1" &>/dev/null; then
        echo "Error: User not found: $1"
        return 1
    fi
    return 0
}

if validate_user "$username"; then
    echo "User is valid"
fi
```

## Common Patterns

### Error Handling

```bash
process_file() {
    local file="$1"
    if [ ! -f "$file" ]; then
        echo "Error: File not found"
        return 1
    fi
    # Process file
    return 0
}
```

### Default Values

```bash
get_config() {
    local key="$1"
    local default="$2"
    local value=$(grep "^$key=" /etc/config | cut -d= -f2)
    echo "${value:-$default}"
}
```

### Wrapper Functions

```bash
safe_rm() {
    if [ -f "$1" ]; then
        rm "$1"
        echo "Deleted: $1"
    else
        echo "File not found: $1"
    fi
}
```

## Best Practices

### 1. Use Descriptive Names

```bash
# Good
backup_database() { ... }
validate_user_input() { ... }

# Bad
func1() { ... }
do_stuff() { ... }
```

### 2. Use Local Variables

```bash
# Good
my_function() {
    local var="value"
    # Use var
}

# Bad
my_function() {
    var="value"                  # Global variable
}
```

### 3. Return Exit Codes

```bash
# Good
check_something() {
    if [ condition ]; then
        return 0
    else
        return 1
    fi
}
```

### 4. Document Functions

```bash
# Backup a file
# Usage: backup_file <filename>
backup_file() {
    # Function body
}
```

## Common Mistakes (I've Made These)

1. **Forgetting `local`**: Variables become global. That's bad.

2. **Not returning exit codes**: Functions should indicate success/failure.

3. **Not validating arguments**: Functions should check if arguments are provided.

4. **Global variable conflicts**: Using same variable names in functions and main script.

5. **Not using `$@` correctly**: Always quote it. `"$@"` not `$@`.

## What's Next?

Now that you understand functions, let's talk about [Arrays](/docs/shell-scripting/arrays/array-basics). We'll cover working with collections of data. Or practice with functions. Write some reusable functions.

---

> **Personal note**: When I started, I'd copy and paste code. Same logic in multiple places. Then I learned functions. Now I write it once and call it. My scripts are shorter. They're easier to maintain. Functions changed how I write scripts.
