---
sidebar_position: 5
title: "Testing Scripts: Test Your Code"
---

# Testing Scripts: Verify Scripts Work

Test scripts. Verify they work. Find problems. Important.

**Here's the thing: Testing finds problems. Test scripts. Always.**

## Manual Testing

```bash
./script.sh test_arg
# Verify output
```

**My take**: Manual testing works. Use it.

## Test Functions

```bash
test_function() {
    local result=$(my_function "input")
    if [ "$result" = "expected" ]; then
        echo "PASS"
    else
        echo "FAIL"
    fi
}
```

**My take**: Test functions verify behavior. Use them.

## Common Patterns

### Test Suite

```bash
run_tests() {
    test_function1
    test_function2
}
```

## What's Next?

Now that you understand testing, you can verify scripts. Or review [Best Practices](/docs/shell-scripting/best-practices/code-style) to reinforce.

---

> **Personal note**: Testing seemed unnecessary at first. Then scripts broke. Now I test always. It prevents problems. Test scripts.

