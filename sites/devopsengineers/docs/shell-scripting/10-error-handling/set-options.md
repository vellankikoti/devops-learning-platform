---
sidebar_position: 3
title: "set Options: Script Safety"
---

# set Options: Make Scripts Safer

set options make scripts safer. Exit on error. Check variables. Useful.

**Here's the thing: set options make scripts safer. Use them.**

## set -e: Exit on Error

```bash
#!/bin/bash
set -e
command1
command2
```

**My take**: `set -e` exits on error. Use it.

## set -u: Undefined Variables

```bash
#!/bin/bash
set -u
echo "$undefined"  # Error
```

**My take**: `set -u` catches undefined variables. Use it.

## set -x: Debug Mode

```bash
#!/bin/bash
set -x
command
```

**My take**: `set -x` shows commands. Use for debugging.

## set -o pipefail

```bash
#!/bin/bash
set -o pipefail
command1 | command2
```

**My take**: `pipefail` catches pipe failures. Use it.

## Common Pattern

```bash
#!/bin/bash
set -euo pipefail
```

**My take**: Use all together. Safer scripts.

## What's Next?

Now that you understand set options, let's talk about [trap Command](/docs/shell-scripting/error-handling/trap-command).

---

> **Personal note**: set options seemed unnecessary at first. Then I used them. Now I always use them. They prevent problems. Use them.

