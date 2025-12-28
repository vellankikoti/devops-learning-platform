---
sidebar_position: 3
title: "Choosing Shell: bash vs sh vs zsh"
---

# Choosing Shell: Which One To Use

Different shells. Different features. Different uses.

**Here's the thing: Most of the time, use bash. It's everywhere. It works.**

## The Shells

### bash: The Standard

**Use when**:
- Writing scripts
- Need portability
- Working on servers
- Most common case

**My take**: bash is everywhere. Use it for scripts. It's the standard.

### sh: The Basic

**Use when**:
- Need maximum portability
- Old systems
- POSIX compliance
- Minimal requirements

**My take**: sh is basic. Use it only when you need maximum portability.

### zsh: The Modern

**Use when**:
- Interactive use
- Modern features
- Personal preference
- macOS default

**My take**: zsh is nice for interactive use. But bash for scripts.

## My Recommendation

**For scripts**: Use bash. Always.

**For interactive**: Use what you like. zsh is nice. bash works too.

**My take**: bash for scripts. zsh for interactive. That's it.

## Shebang Lines

```bash
#!/bin/bash                        # bash script
#!/bin/sh                          # sh script
#!/usr/bin/env bash                # Find bash in PATH
```

**My take**: Use `#!/bin/bash` for bash scripts. Simple.

## Common Patterns

### bash Script

```bash
#!/bin/bash
echo "Hello, World!"
```

### sh Script

```bash
#!/bin/sh
echo "Hello, World!"
```

## What's Next?

Now that you understand shells, let's talk about [Shebang Line](/docs/shell-scripting/fundamentals/shebang-line) in detail.

---

> **Personal note**: I used to wonder which shell to use. Then I learned: bash for scripts. That's it. Don't overthink it.

