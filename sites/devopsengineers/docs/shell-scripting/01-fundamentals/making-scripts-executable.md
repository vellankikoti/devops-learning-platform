---
sidebar_position: 5
title: Making Scripts Executable
---

# Making Scripts Executable: Run Them Directly

To run scripts directly, they need execute permission.

**Here's the thing: Scripts need execute permission. Give it to them. Then run them.**

## Making Executable

### chmod +x

```bash
chmod +x script.sh
```

**My take**: `chmod +x` makes scripts executable. Use it.

### chmod 755

```bash
chmod 755 script.sh
```

**My take**: `755` is common. Owner: read/write/execute. Others: read/execute.

## Running Scripts

### With Execute Permission

```bash
./script.sh
```

**My take**: `./` runs the script. Needs execute permission.

### Without Execute Permission

```bash
bash script.sh
```

**My take**: This works without execute permission. But `./` is better.

## Common Patterns

### Make and Run

```bash
chmod +x script.sh
./script.sh
```

### One Liner

```bash
chmod +x script.sh && ./script.sh
```

## Common Mistakes (I've Made These)

1. **Forgetting chmod**: Scripts need execute permission. Don't forget.

2. **Not using ./**: Use `./script.sh` not `script.sh`. Path matters.

3. **Wrong permissions**: `755` is good. `777` is too open. Don't use it.

4. **Not checking permissions**: Check with `ls -l`. See what you have.

## What's Next?

Now that you can make scripts executable, you're ready. Or review [Script Structure](/docs/shell-scripting/fundamentals/script-structure) to write better scripts.

---

> **Personal note**: I used to forget chmod. Then scripts wouldn't run. Now I always chmod +x. It's habit. Do it.


