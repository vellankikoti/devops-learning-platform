---
sidebar_position: 5
title: "Error Logging: Log Errors"
---

# Error Logging: Record Errors

Log errors. To files. To syslog. Track them.

**Here's the thing: Log errors. Track them. Fix them.**

## Log to File

```bash
log_error() {
    echo "$(date): ERROR: $1" >> error.log
}

log_error "Something failed"
```

**My take**: Log to file. Track errors.

## Log to syslog

```bash
logger "Error message"
```

**My take**: logger sends to syslog. Use it.

## Common Patterns

### Log Function

```bash
log() {
    local level=$1
    shift
    echo "$(date): [$level] $*" >> app.log
}

log ERROR "Something failed"
```

## What's Next?

Now that you understand error logging, let's talk about [Debugging Techniques](/docs/shell-scripting/error-handling/debugging-techniques).

---

> **Personal note**: Error logging seemed unnecessary at first. Then I needed it. Now I log everything. It helps. Do it.


