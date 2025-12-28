---
sidebar_position: 1
title: Resolving Conflicts
---

# Resolving Conflicts: When Git Can't Merge

**Conflicts happen. They're not failures. They're Git telling you: "I need help deciding which version to keep."**

## 🎯 The Big Picture

Conflicts occur when Git can't automatically merge changes. Two people changed the same lines. Git doesn't know which version is correct. So it asks you.

**Resolving conflicts is a skill. Master it, and you'll never panic again.**

## When Conflicts Happen

Conflicts occur when:
- Two branches modify the same lines
- You pull changes that conflict with local changes
- You merge branches with conflicting changes
- You rebase and conflicts arise

**Conflicts are normal. They're not errors. They're part of collaboration.**

## Understanding Conflict Markers

When Git finds a conflict, it marks it in your files:

```bash
<<<<<<< HEAD
Your version of the code
=======
Their version of the code
>>>>>>> branch-name
```

**Breaking it down:**
- `<<<<<<< HEAD`: Start of your version
- `=======`: Separator between versions
- `>>>>>>> branch-name`: End of their version

## The Conflict Resolution Process

### Step 1: Identify the Conflict

```bash
# Try to merge or pull
git merge feature-branch
# Or
git pull

# Git will tell you:
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

Open the conflicted file. You'll see conflict markers:

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

### Step 4: Choose Your Resolution

You have three options:

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

**Option 3: Combine Both (Best Option)**
```python
def calculate_total(items):
    # Use the more efficient version
    return sum(item.price for item in items)
```

### Step 5: Mark as Resolved

```bash
# After editing the file, stage it
git add file.txt

# Git knows the conflict is resolved
```

### Step 6: Complete the Merge

```bash
# Commit to complete the merge
git commit

# Git opens editor with default merge message
# Or use:
git commit -m "Merge feature-branch into main"
```

## Real-World Conflict Scenarios

### Scenario 1: Pull Conflict

**Situation**: You have local changes. Someone pushed changes to the same file.

```bash
# You try to pull
git pull

# Conflict!
# CONFLICT (content): Merge conflict in config.yaml

# Resolve the conflict
vim config.yaml
# Remove conflict markers, keep correct version

# Stage and commit
git add config.yaml
git commit -m "Resolve merge conflict in config.yaml"
```

### Scenario 2: Merge Conflict

**Situation**: Merging a feature branch with conflicting changes.

```bash
# Merge feature branch
git checkout main
git merge feature/auth

# Conflict in auth.js
# Open file, resolve conflict
vim auth.js

# Complete merge
git add auth.js
git commit -m "Merge feature/auth: resolve conflicts"
```

### Scenario 3: Rebase Conflict

**Situation**: Rebasing your branch on top of updated main.

```bash
# Rebase on main
git checkout feature-branch
git rebase main

# Conflict!
# Resolve it
vim conflicted-file.txt
git add conflicted-file.txt

# Continue rebase
git rebase --continue

# If more conflicts, repeat
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

## Advanced Conflict Tools

### Using Merge Tools

```bash
# Configure a merge tool
git config --global merge.tool vimdiff

# Use it during conflict
git mergetool

# Or use VS Code
git config --global merge.tool vscode
git mergetool
```

### See Both Versions

```bash
# See your version
git show :1:file.txt  # Common ancestor
git show :2:file.txt  # Your version (HEAD)
git show :3:file.txt  # Their version (branch)
```

## Production Scenario: Emergency Conflict Resolution

**Situation**: Production deployment blocked by merge conflict. Need to resolve quickly.

```bash
# 1. Identify the conflict
git status

# 2. Quick resolution strategy
# If it's a simple conflict, use theirs (production is priority)
git checkout --theirs deploy.sh
git add deploy.sh
git commit -m "Resolve conflict: use production version"

# 3. Verify
git log --oneline -3

# 4. Push and deploy
git push
```

**Important**: After emergency, review the resolution. Make sure nothing was lost.

## My Take: Conflicts Are Opportunities

I used to panic at conflicts. I'd think I broke something. I'd avoid merging.

Then I learned: **Conflicts are Git asking for your input. They're opportunities to review changes.**

Now I see conflicts as:
- A chance to review what changed
- An opportunity to improve code
- A moment to communicate with teammates

**Don't fear conflicts. Resolve them thoughtfully.**

## Memory Tip: The Editor Analogy

Think of conflicts like editing a document:
- **Conflict markers**: Like track changes showing both versions
- **Resolution**: Like accepting or rejecting changes
- **Staging**: Like marking the edit as complete
- **Committing**: Like saving the final version

Once you see it that way, conflicts are just editing.

## Common Mistakes

### Mistake 1: Committing Conflict Markers

```bash
# Don't do this
# Leave conflict markers in file
git add file.txt
git commit -m "Merge"
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

1. **Conflicts are normal** - They happen in collaboration
2. **Understand conflict markers** - They show both versions
3. **Resolve thoughtfully** - Don't just pick one side
4. **Test after resolution** - Make sure it works
5. **Use merge tools** - They make it easier

## Hands-On: Resolve a Real Conflict

Let's create and resolve a conflict:

```bash
# On main branch
echo "Line 1" > conflict-file.txt
git add conflict-file.txt
git commit -m "Add line 1"

# Create feature branch
git checkout -b feature/add-line2

# Add line 2
echo "Line 2" >> conflict-file.txt
git add conflict-file.txt
git commit -m "Add line 2"

# Switch to main and modify same line
git checkout main
echo "Line 2 modified" >> conflict-file.txt
git add conflict-file.txt
git commit -m "Modify line 2"

# Try to merge (conflict!)
git merge feature/add-line2
```

**What you'll see**:
- Conflict markers in the file (`<<<<<<<`, `=======`, `>>>>>>>`)
- Git telling you which files have conflicts
- You need to resolve manually

**Try it**: 
1. Create a conflict using the commands above
2. Open the conflicted file and see the markers
3. Resolve the conflict by editing the file
4. Stage the resolved file and complete the merge

**Create a screenshot**: Capture your terminal showing the merge conflict, the conflict markers in the file, and the resolution process.

## What's Next?

Now that you can resolve conflicts, let's learn about rollbacks. Next: [Rolling Back Changes](/docs/git-github/production-scenarios/rolling-back-changes).

---

> **Remember**: Conflicts aren't failures. They're Git asking for your help. Give it thoughtfully.

