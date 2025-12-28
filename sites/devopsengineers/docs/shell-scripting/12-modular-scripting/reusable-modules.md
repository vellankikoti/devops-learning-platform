---
sidebar_position: 4
title: "Reusable Modules: Building Systems"
---

# Reusable Modules: Build Modular Systems

Reusable modules build systems. Modular. Maintainable.

**Here's the thing: Modules make systems maintainable. Build them.**

## Module Structure

```bash
# modules/logging.sh
log_info() { ... }
log_error() { ... }
```

**My take**: Modules group related functions. Organize them.

## Using Modules

```bash
source modules/logging.sh
log_info "Message"
```

**My take**: Source modules. Use functions.

## Common Patterns

### Module System

```bash
# Load all modules
for module in modules/*.sh; do
    source "$module"
done
```

## What's Next?

Now that you understand modules, you can build systems. Or review [Modular Scripting](/docs/shell-scripting/modular-scripting/source-include) to reinforce.

---

> **Personal note**: Modules seemed complex at first. Then I built them. Now I use them always. They're useful. Build them.

