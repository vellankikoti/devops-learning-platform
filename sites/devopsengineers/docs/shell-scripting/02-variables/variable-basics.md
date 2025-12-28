---
sidebar_position: 1
title: "Variables: Storing Data"
---

# Variables: Where Data Lives

Variables are just containers. You put data in them. You get data out. That's it.

But here's the thing: **Everything in scripting uses variables.** Understand variables, and you understand scripting.

## What Variables Actually Are

Think of variables like labeled boxes. You put something in a box, label it, and get it out later by the label.

```bash
name="John"
```

That's a variable. `name` is the label. `"John"` is what's in the box.

Simple.

## Creating Variables

```bash
name="John"
age=25
price=19.99
```

**Important**: No spaces around the `=`. This is the most common mistake.

```bash
name="John"    # ✅ Correct
name = "John"  # ❌ Wrong (creases error)
```

**Rules**:
- No spaces around `=`
- Letters, numbers, underscore in names
- Start with letter or underscore
- Case-sensitive (`Name` and `name` are different)

**My take**: Use lowercase with underscores. `user_name` not `userName`. It's more readable in scripts.

## Using Variables

```bash
name="John"
echo $name                        # John
echo "Hello, $name"               # Hello, John
echo 'Hello, $name'               # Hello, $name (literal - no expansion)
```

**The `$` tells bash to use the variable's value, not the name.**

**Quotes matter**:
- Double quotes (`"`) = Variables expanded
- Single quotes (`'`) = Literal text (no expansion)
- No quotes = Variables expanded (if safe, but can break)

**Real talk**: Always use double quotes. It's safer. `"$name"` not `$name`.

## Variable Expansion (The Braces Thing)

```bash
name="John"
echo $name                        # John
echo ${name}                      # John (explicit)
echo "${name}_suffix"             # John_suffix (needs braces)
```

**When to use braces**:
- Variable name followed by a character (like `_suffix`)
- For clarity (makes it obvious it's a variable)
- Best practice (just use them)

**My take**: Use braces. Always. `` `${name}` `` not `$name`. It's clearer and safer.

## Variable Types (They're All Strings)

Here's the thing: **Bash doesn't really have types.** Everything is a string. Sometimes you use it as a number, but it's still a string.

```bash
name="John Doe"      # String
age=25               # String (but you can do math with it)
price=19.99          # String (but you can't do math easily)
```

**Strings**:
```bash
name="John Doe"
message='Hello, World!'
path="/home/user"
```

**Numbers** (sort of):
```bash
count=10
age=25
port=8080
```

You can do math with them, but they're still strings. Bash is weird like that.

## Common Patterns

### Reading from User

```bash
read -p "Enter your name: " name
echo "Hello, $name"
```

The `read` command gets input from the user. The `-p` flag shows a prompt.

**Real example**:
```bash
#!/bin/bash
read -p "Enter server name: " server
echo "Connecting to $server..."
```

### Command Substitution

```bash
current_date=$(date)
files=$(ls)
user=$(whoami)
```

The `$(command)` runs the command and puts the output in the variable.

**Real example**:
```bash
backup_name="backup_$(date +%Y%m%d).tar.gz"
echo "Creating $backup_name"
```

**Pro tip**: Use `$(command)` not backticks. Backticks work, but `$()` is clearer and easier to nest.

### Environment Variables

```bash
echo $HOME                        # Home directory
echo $USER                        # Username
echo $PATH                        # Command path
echo $PWD                         # Current directory
```

These are set by the system. You can use them.

**Setting your own**:
```bash
export MY_VAR="value"
```

The `export` makes it available to child processes.

## Best Practices (What Actually Matters)

### 1. Always Quote Variables

```bash
# Good
name="John Doe"
echo "$name"

# Bad (breaks with spaces)
name="John Doe"
echo $name                        # Breaks!
```

**Why**: Spaces break things. Quotes prevent that.

### 2. Use Descriptive Names

```bash
# Good
user_name="John"
file_count=10

# Bad
n="John"
x=10
```

**Why**: Future you will thank present you. Descriptive names make code readable.

### 3. Use Braces

```bash
# Good
echo "${name}_file.txt"

# Works but unclear
echo "$name_file.txt"            # Looks for $name_file, not $name
```

**Why**: Clarity. Braces make it obvious what's a variable.

### 4. Initialize Variables

```bash
# Good
count=0
name=""

# Prevents undefined variable errors
```

**Why**: Prevents errors. If a variable might not be set, initialize it.

## Real-World Examples

### Example 1: Configuration

```bash
#!/bin/bash
APP_NAME="myapp"
APP_DIR="/opt/myapp"
LOG_FILE="/var/log/myapp.log"

echo "Starting $APP_NAME"
echo "Directory: $APP_DIR"
echo "Logs: $LOG_FILE"
```

Store configuration in variables. Makes scripts easier to modify.

### Example 2: Dynamic Paths

```bash
#!/bin/bash
USER_HOME=$HOME
PROJECT_DIR="$USER_HOME/projects"
BACKUP_DIR="$USER_HOME/backups"

echo "Backing up $PROJECT_DIR to $BACKUP_DIR"
```

Use environment variables. Makes scripts portable.

### Example 3: Command Output

```bash
#!/bin/bash
CURRENT_DATE=$(date +%Y-%m-%d)
HOSTNAME=$(hostname)
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')

echo "Date: $CURRENT_DATE"
echo "Host: $HOSTNAME"
echo "Disk: $DISK_USAGE"
```

Store command output in variables. Use it later.

## Common Mistakes (I've Made These)

1. **Spaces around `=`**: `name = "John"` doesn't work. Use `name="John"`.

2. **Forgetting `$`**: `echo name` prints "name", not the value. Use `echo $name`.

3. **Not quoting**: `name="John Doe"` then `echo $name` breaks. Use `echo "$name"`.

4. **Case sensitivity**: `Name` and `name` are different. Be consistent.

5. **Uninitialized variables**: Using a variable that doesn't exist. Initialize it first.

## What's Next?

Now that you understand variables, let's talk about [Operators](/docs/shell-scripting/operators/arithmetic-operators). We'll cover how to do math and make comparisons.

Or practice with variables. Create some. Use them. Break them. Fix them. That's how you learn.

---

> **Personal note**: When I started, I forgot the `$` constantly. I'd write `echo name` and wonder why it printed "name" instead of the value. It's fine. You'll make mistakes. Just fix them and move on.
