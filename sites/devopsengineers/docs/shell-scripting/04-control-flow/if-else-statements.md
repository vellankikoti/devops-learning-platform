---
sidebar_position: 1
title: "if/else: Making Decisions"
---

# if/else: Making Scripts Think

Scripts need to make decisions. "If this file exists, do this. Otherwise, do that." That's what if/else does.

**Without conditionals, scripts are dumb. They just run commands in order. With conditionals, scripts are smart. They react. They adapt.**

## The Basic if

```bash
if [ condition ]; then
    # commands
fi
```

That's it. If the condition is true, run the commands. Otherwise, skip them.

**Example**:
```bash
if [ "$USER" = "root" ]; then
    echo "You are root"
fi
```

**The `[ ]` is important**. It's actually a command. Weird, but that's how it works.

**Memory trick**: `if [ condition ]; then ... fi`. The `fi` closes the `if`. Backwards spelling. Weird, but memorable.

## if/else

```bash
if [ condition ]; then
    # commands if true
else
    # commands if false
fi
```

If condition is true, do this. Otherwise, do that.

**Example**:
```bash
if [ -f "file.txt" ]; then
    echo "File exists"
else
    echo "File does not exist"
fi
```

**Real example**:
```bash
if [ -f "/etc/nginx/nginx.conf" ]; then
    echo "Nginx is installed"
else
    echo "Nginx is not installed"
fi
```

## if/elif/else

```bash
if [ condition1 ]; then
    # commands
elif [ condition2 ]; then
    # commands
else
    # commands
fi
```

Multiple conditions. Check the first. If false, check the second. If both false, do the else.

**Example**:
```bash
if [ "$1" = "start" ]; then
    echo "Starting..."
elif [ "$1" = "stop" ]; then
    echo "Stopping..."
else
    echo "Usage: $0 {start|stop}"
fi
```

**Real example**:
```bash
if [ "$1" = "deploy" ]; then
    deploy_application
elif [ "$1" = "rollback" ]; then
    rollback_application
else
    echo "Usage: $0 {deploy|rollback}"
    exit 1
fi
```

## File Tests (You'll Use These a Lot)

```bash
[ -f file ]                      # File exists and is regular file
[ -d dir ]                       # Directory exists
[ -r file ]                      # File is readable
[ -w file ]                      # File is writable
[ -x file ]                      # File is executable
[ -s file ]                      # File exists and is not empty
[ -e file ]                      # File exists (any type)
```

**Real examples**:
```bash
# Check if file exists
if [ -f "/etc/nginx/nginx.conf" ]; then
    echo "Config file exists"
fi

# Check if directory exists
if [ -d "/var/www/html" ]; then
    echo "Web directory exists"
fi

# Check if file is readable
if [ -r "data.txt" ]; then
    process_file "data.txt"
else
    echo "Cannot read data.txt"
fi
```

**My take**: File tests are what you'll use most. Check if files exist. Check if directories exist. Check permissions. That's 90% of what you need.

## String Comparisons

```bash
[ "$str1" = "$str2" ]            # Equal
[ "$str1" != "$str2" ]           # Not equal
[ -z "$str" ]                    # Empty string
[ -n "$str" ]                    # Non-empty string
```

**Important**: Always quote variables. `[ "$name" = "John" ]` not `[ $name = "John" ]`. Spaces break things.

**Real examples**:
```bash
# Check if user is root
if [ "$USER" = "root" ]; then
    echo "Running as root"
fi

# Check if variable is set
if [ -z "$BACKUP_DIR" ]; then
    BACKUP_DIR="/backup"
fi
```

## Number Comparisons

```bash
[ $a -eq $b ]                    # Equal
[ $a -ne $b ]                    # Not equal
[ $a -lt $b ]                    # Less than
[ $a -le $b ]                    # Less than or equal
[ $a -gt $b ]                    # Greater than
[ $a -ge $b ]                    # Greater than or equal
```

**Real example**:
```bash
if [ $age -ge 18 ]; then
    echo "Adult"
else
    echo "Minor"
fi
```

**Memory trick**: `-eq` = equal, `-ne` = not equal, `-lt` = less than, `-gt` = greater than.

## Combining Conditions

```bash
# AND
if [ condition1 ] && [ condition2 ]; then
    # both must be true
fi

# OR
if [ condition1 ] || [ condition2 ]; then
    # either can be true
fi
```

**Real example**:
```bash
# Check if file exists and is readable
if [ -f "$file" ] && [ -r "$file" ]; then
    process_file "$file"
fi

# Check if user is root or admin
if [ "$USER" = "root" ] || [ "$USER" = "admin" ]; then
    echo "Admin access"
fi
```

## Common Patterns

### Check if File Exists Before Using

```bash
if [ -f "$config_file" ]; then
    source "$config_file"
else
    echo "Error: Config file not found: $config_file"
    exit 1
fi
```

### Validate Input

```bash
if [ -z "$1" ]; then
    echo "Error: Argument required"
    exit 1
fi
```

### Check User

```bash
if [ "$USER" != "root" ]; then
    echo "Error: Must run as root"
    exit 1
fi
```

### Multiple Conditions

```bash
if [ "$1" = "start" ]; then
    start_service
elif [ "$1" = "stop" ]; then
    stop_service
elif [ "$1" = "restart" ]; then
    restart_service
else
    echo "Usage: $0 {start|stop|restart}"
    exit 1
fi
```

## Common Mistakes (I've Made These)

1. **Spaces in brackets**: `[condition]` doesn't work. Use `[ condition ]`. Spaces are required.

2. **Forgetting quotes**: `[ $name = "John" ]` breaks if `$name` has spaces. Use `[ "$name" = "John" ]`.

3. **Wrong operator**: Using `=` for numbers. Use `-eq` for numbers, `=` for strings.

4. **Forgetting `fi`**: Every `if` needs a `fi`. You'll forget it. Bash will tell you.

5. **Using `==` instead of `=`**: `=` works. `==` also works, but `=` is more portable.

## What's Next?

Now that you can make decisions, let's talk about [Loops](/docs/shell-scripting/control-flow/for-loops). We'll cover repeating actions. Or practice with if/else. Write some scripts that make decisions.

---

> **Personal note**: When I started, I'd write scripts without any conditionals. They'd break if files didn't exist. They'd fail if users weren't set. Then I learned if/else. Now my scripts handle errors. They validate input. They're actually useful. Conditionals make scripts smart.
