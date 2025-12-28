---
sidebar_position: 4
title: "Environment Variables: System Variables"
---

# Environment Variables: System-Wide Variables

Environment variables are available to all processes. System provides some. You can set your own.

**Here's the thing: Environment variables are useful. Learn the common ones. Use them.**

## Common System Variables

### PATH: Command Search Path

```bash
echo $PATH
```

**My take**: PATH is where shell looks for commands. Important.

### HOME: User Home

```bash
echo $HOME
cd $HOME
```

**My take**: HOME is your home directory. Use it.

### USER: Current User

```bash
echo $USER
```

**My take**: USER is your username. Use it for personalization.

### PWD: Current Directory

```bash
echo $PWD
```

**My take**: PWD is current directory. Use it.

## Setting Environment Variables

### Export

```bash
export MY_VAR="value"
```

**My take**: `export` makes variables available to child processes.

### In Script

```bash
#!/bin/bash
export API_KEY="secret"
```

**My take**: Export in scripts. Make variables available.

## Common Patterns

### Use HOME

```bash
config_file="$HOME/.config/myapp.conf"
```

### Use USER

```bash
log_file="/var/log/${USER}_app.log"
```

## What's Next?

Now that you understand environment variables, let's talk about [Variable Scope](/docs/shell-scripting/variables/variable-scope).

---

> **Personal note**: Environment variables seemed mysterious at first. Then I learned the common ones. Now I use them constantly. They're everywhere. Learn them.

