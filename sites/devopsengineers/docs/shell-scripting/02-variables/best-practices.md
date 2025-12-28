---
sidebar_position: 6
title: "Variable Best Practices: Do It Right"
---

# Variable Best Practices: Write Good Code

Good variable practices make scripts better. Safer. More maintainable.

**Here's the thing: Follow best practices. Your scripts will be better. Trust me.**

## Naming Conventions

### Use Descriptive Names

```bash
# Good
user_name="John"
file_count=10

# Bad
u="John"
fc=10
```

**My take**: Descriptive names are better. Readable. Understandable.

### Use UPPERCASE for Constants

```bash
MAX_RETRIES=3
API_URL="https://api.example.com"
```

**My take**: UPPERCASE for constants. Convention. Follow it.

## Quoting

### Always Quote Variables

```bash
name="John Doe"
echo "$name"                      # Good
echo $name                        # Bad - breaks with spaces
```

**My take**: Always quote variables. Prevents problems.

### Quote in Conditionals

```bash
if [ "$name" = "John" ]; then
    echo "Found"
fi
```

**My take**: Quote in conditionals. Always.

## Safety

### Check Before Use

```bash
if [ -z "$name" ]; then
    echo "Name is required"
    exit 1
fi
```

**My take**: Check variables before use. Prevent errors.

### Use Defaults

```bash
name="${USER_NAME:-default}"
```

**My take**: Use defaults. Safer.

## Common Patterns

### Safe Variable Use

```bash
name="${1:-default}"
if [ -z "$name" ]; then
    echo "Error: name required"
    exit 1
fi
```

## Common Mistakes (I've Made These)

1. **Not quoting**: Always quote. Prevents problems.

2. **Bad names**: Use descriptive names. Not `x`, `y`, `z`.

3. **Not checking**: Check variables before use. Prevent errors.

4. **Changing globals**: Use `local` in functions. Don't change globals.

## What's Next?

Now that you understand best practices, you write better scripts. Or review [Variables](/docs/shell-scripting/variables/variable-basics) to reinforce.

---

> **Personal note**: I used to write messy scripts. Then I learned best practices. Now my scripts are better. Cleaner. Safer. Follow practices.


