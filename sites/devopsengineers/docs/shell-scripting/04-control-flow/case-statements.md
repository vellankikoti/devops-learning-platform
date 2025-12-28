---
sidebar_position: 2
title: "Case Statements: Pattern Matching"
---

# Case Statements: Multiple Choices

Case statements match patterns. Like switch statements. Cleaner than many if-else.

**Here's the thing: Case statements are cleaner for multiple choices. Use them.**

## Basic Syntax

```bash
case "$choice" in
    "option1")
        echo "Option 1"
        ;;
    "option2")
        echo "Option 2"
        ;;
    *)
        echo "Default"
        ;;
esac
```

**My take**: Case is cleaner than many if-else. Use it.

## Pattern Matching

### Exact Match

```bash
case "$status" in
    "active")
        echo "Running"
        ;;
    "inactive")
        echo "Stopped"
        ;;
esac
```

### Wildcards

```bash
case "$file" in
    *.txt)
        echo "Text file"
        ;;
    *.sh)
        echo "Script"
        ;;
esac
```

**My take**: Patterns are powerful. Use them.

## Common Patterns

### Menu Selection

```bash
case "$choice" in
    1)
        install_package
        ;;
    2)
        remove_package
        ;;
    3)
        list_packages
        ;;
    *)
        echo "Invalid choice"
        ;;
esac
```

## What's Next?

Now that you understand case, let's talk about [While Loops](/docs/shell-scripting/control-flow/while-loops).

---

> **Personal note**: I used to use many if-else. Then I learned case. Now I use it for multiple choices. It's cleaner. Use it.


