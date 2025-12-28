---
sidebar_position: 5
title: Conflict Resolution in Branches
---

# Conflict Resolution in Branches: When Branches Collide

**Conflicts happen when branches diverge. Understanding how to resolve conflicts during merges and rebases is essential.**

## 🎯 The Big Picture

Conflicts occur when Git can't automatically combine changes. Two branches changed the same lines. Git needs your help to decide which version to keep.

**Think of it like this: Conflicts are Git asking for your input. It's not a failure. It's collaboration.**

## When Conflicts Occur

Conflicts happen when:
- Two branches modify the same lines
- You merge branches with conflicting changes
- You rebase and conflicts arise
- You pull and local changes conflict

**Conflicts are normal. They're part of collaboration.**

## Understanding Conflict Markers

Git marks conflicts in files:

```bash
<<<<<<< HEAD
Your version of the code
=======
Their version of the code
>>>>>>> branch-name
```

**Breaking it down**:
- `<<<<<<< HEAD`: Start of your version
- `=======`: Separator
- `>>>>>>> branch-name`: End of their version

## Resolving Merge Conflicts

### Step 1: Identify Conflicts

```bash
# Try to merge
git merge feature-branch

# Git tells you:
# Auto-merging file.txt
# CONFLICT (content): Merge conflict in file.txt
# Automatic merge failed; fix conflicts and then commit the result.
```

### Step 2: See What's Conflicted

```bash
# See conflicted files
git status

# Output:
# Unmerged paths:
#   both modified:   file.txt
```

### Step 3: Open and Resolve

Open the file. You'll see conflict markers:

```python
def calculate_total(items):
<<<<<<< HEAD
    return sum(item.price for item in items)
=======
    total = 0
    for item in items:
        total += item.price
    return total
>>>>>>> feature-branch
```

### Step 4: Choose Resolution

**Option 1: Keep Your Version**
```python
def calculate_total(items):
    return sum(item.price for item in items)
```

**Option 2: Keep Their Version**
```python
def calculate_total(items):
    total = 0
    for item in items:
        total += item.price
    return total
```

**Option 3: Combine Both**
```python
def calculate_total(items):
    # Use the more efficient version
    return sum(item.price for item in items)
```

### Step 5: Mark as Resolved

```bash
# After editing, stage the file
git add file.txt

# Git knows conflict is resolved
```

### Step 6: Complete Merge

```bash
# Commit to complete merge
git commit

# Or with message:
git commit -m "Merge feature-branch: resolve conflicts"
```

## Resolving Rebase Conflicts

Rebase conflicts work similarly, but you continue instead of commit.

### Step 1: Rebase with Conflicts

```bash
# Rebase on main
git rebase main

# Conflict!
# Resolve it:
vim file.txt
git add file.txt
```

### Step 2: Continue Rebase

```bash
# Continue rebase
git rebase --continue

# If more conflicts, repeat
```

### Step 3: Abort If Needed

```bash
# If rebase goes wrong
git rebase --abort

# Returns to state before rebase
```

## Conflict Resolution Strategies

### Strategy 1: Accept Current (Yours)

```bash
# Keep your version for all conflicts
git checkout --ours file.txt
git add file.txt
```

### Strategy 2: Accept Incoming (Theirs)

```bash
# Keep their version for all conflicts
git checkout --theirs file.txt
git add file.txt
```

### Strategy 3: Manual Resolution (Recommended)

```bash
# Open file, manually resolve
vim file.txt
# Edit, remove conflict markers, keep what you need
git add file.txt
```

## Using Merge Tools

### Configure Merge Tool

```bash
# Configure VS Code as merge tool
git config --global merge.tool vscode
git config --global mergetool.vscode.cmd 'code --wait $MERGED'

# Or vim
git config --global merge.tool vimdiff
```

### Use Merge Tool

```bash
# During conflict, use merge tool
git mergetool

# Opens configured tool
# Resolve conflicts visually
# Save and close
```

## Real-World Conflict Scenarios

### Scenario 1: Merge Conflict

```bash
# Merge feature branch
git checkout main
git merge feature/auth

# Conflict in auth.js
# Resolve:
vim auth.js
# Remove markers, keep correct version
git add auth.js
git commit -m "Merge feature/auth: resolve conflicts"
```

### Scenario 2: Rebase Conflict

```bash
# Rebase on updated main
git checkout feature-branch
git rebase main

# Conflict!
# Resolve:
vim conflicted-file.txt
git add conflicted-file.txt
git rebase --continue
```

### Scenario 3: Pull Conflict

```bash
# Pull with local changes
git pull

# Conflict!
# Resolve:
vim file.txt
git add file.txt
git commit -m "Merge remote changes"
```

## My Take: Conflicts Are Normal

I used to panic at conflicts. I'd think I broke something. I'd avoid merging.

Then I learned: **Conflicts are normal. They're Git asking for help.**

Now I resolve conflicts confidently:
- Read the conflict markers
- Understand both versions
- Choose the best resolution
- Test after resolving

**Conflicts are collaboration. Resolve them thoughtfully.**

## Memory Tip: The Editor Analogy

Think of conflicts like editing a document:
- **Conflict markers**: Track changes showing both versions
- **Resolution**: Accept or reject changes
- **Staging**: Marking the edit as complete
- **Committing**: Saving the final version

Once you see it that way, conflicts are just editing.

## Common Mistakes

### Mistake 1: Committing Conflict Markers

```bash
# Don't do this
# Leave conflict markers in file
git add file.txt
git commit
# Now conflict markers are in your code!
```

**Fix**: Always remove conflict markers before committing.

### Mistake 2: Not Testing After Resolution

```bash
# Don't do this
# Resolve conflict, commit, push
# Then realize the code doesn't work
```

**Fix**: Always test after resolving conflicts.

### Mistake 3: Aborting When Scared

```bash
# Don't do this
git merge --abort  # Every time there's a conflict
```

**Fix**: Learn to resolve. Aborting doesn't solve the problem.

## Key Takeaways

1. **Conflicts are normal** - Part of collaboration
2. **Understand conflict markers** - They show both versions
3. **Resolve thoughtfully** - Don't just pick one side
4. **Test after resolution** - Make sure it works
5. **Use merge tools** - They make it easier

## What's Next?

Now that you can resolve conflicts, let's learn about branch management. Next: [Branch Management](/docs/git-github/branching-merging/branch-management).

---

> **Remember**: Conflicts aren't failures. They're Git asking for your help. Give it thoughtfully.

