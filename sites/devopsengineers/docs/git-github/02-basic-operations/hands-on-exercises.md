---
sidebar_position: 7
title: Hands-On Exercises
---

# Hands-On Exercises: Learning Git by Doing

**Theory is good. Practice is better. These hands-on exercises will make Git second nature.**

## 🎯 The Big Picture

You can read about Git all day. But you'll only learn it by doing it. These exercises take you through real scenarios you'll face in DevOps.

**Think of it like this: Reading about swimming doesn't teach you to swim. These exercises are the pool. Jump in.**

## Prerequisites

Before starting, make sure you have:
- Git installed (`git --version`)
- A terminal/command prompt
- A GitHub account (for remote exercises)

## Exercise 1: Clone a Repository

### What You'll Learn
How to get an existing project from GitHub and start working on it.

### Steps

```bash
# Clone a repository (use any public repo or create your own)
git clone https://github.com/yourusername/your-repo.git

# Navigate into the cloned directory
cd your-repo

# Check the current status
git status
```

### Expected Results
- Repository files downloaded to your local machine
- You're in the repository directory
- Git status shows you're on the main branch

### What to Observe
- Notice the `.git` folder (hidden) that was created
- Check `git remote -v` to see where the repository came from
- See what branch you're on with `git branch`

---

## Exercise 2: Pull Latest Changes

### What You'll Learn
How to sync your local repository with the remote repository.

### Steps

```bash
# Make sure you're in the repository directory
cd your-repo

# Pull the latest changes from remote
git pull origin main
```

### Expected Results
- If there are new changes, they'll be downloaded
- If you're already up to date, you'll see "Already up to date"

### What to Observe
- Notice how Git merges remote changes with your local changes
- Check `git log` to see the latest commits

---

## Exercise 3: Make Changes and Commit

### What You'll Learn
The basic workflow: modify files, stage them, and commit.

### Steps

```bash
# Check current status
git status

# Make a change (create or edit a file)
echo "# My Changes" > changes.txt
# Or edit an existing file

# Check status again - see the changes
git status

# Stage all changes
git add .

# Check status - see staged changes
git status

# Commit with a message
git commit -m "Add changes.txt file"
```

### Expected Results
- `git status` shows untracked/modified files
- After `git add`, files show as "Changes to be committed"
- After `git commit`, you see "working tree clean"

### What to Observe
- Notice the difference between untracked, staged, and committed
- See your commit in `git log`
- Try `git diff` before staging to see changes

---

## Exercise 4: Push Changes to Remote

### What You'll Learn
How to upload your local commits to the remote repository.

### Steps

```bash
# Push your commits to the remote main branch
git push origin main
```

### Expected Results
- Your commits are uploaded to GitHub/GitLab
- You see output showing the push was successful
- Others can now see your changes

### What to Observe
- Notice the branch name in the output
- Check GitHub/GitLab to see your changes online
- Try pushing again - it should say "Everything up-to-date"

---

## Exercise 5: Working with Branches

### What You'll Learn
How to create, switch, and work with branches.

### Steps

```bash
# List all branches
git branch

# Create a new branch
git checkout -b feature/my-new-feature

# Or use the newer command
git switch -c feature/my-new-feature

# Verify you're on the new branch
git branch

# Make some changes
echo "Feature code" > feature.txt
git add feature.txt
git commit -m "Add feature implementation"

# Switch back to main
git checkout main
# Or: git switch main

# Notice feature.txt doesn't exist here
ls -la

# Switch back to feature branch
git checkout feature/my-new-feature
# Now feature.txt exists again
```

### Expected Results
- New branch created and switched to
- Changes on feature branch don't affect main
- You can switch between branches freely

### What to Observe
- Notice how files appear/disappear when switching branches
- Check `git log` on different branches - different histories
- See how `git branch` shows which branch you're on

---

## Exercise 6: Push a Branch to Remote

### What You'll Learn
How to share your branch with others or back it up remotely.

### Steps

```bash
# Make sure you're on your feature branch
git checkout feature/my-new-feature

# Push the branch to remote
git push origin feature/my-new-feature

# Or set upstream and push in one command
git push -u origin feature/my-new-feature
```

### Expected Results
- Your branch is now on the remote repository
- You can see it on GitHub/GitLab
- Others can checkout your branch

### What to Observe
- Notice the `-u` flag sets up tracking
- Check `git branch -a` to see remote branches
- See the branch on GitHub/GitLab web interface

---

## Exercise 7: Set Upstream for Branch

### What You'll Learn
How to link your local branch to a remote branch.

### Steps

```bash
# Create a branch locally
git checkout -b feature/new-feature

# Push and set upstream
git push --set-upstream origin feature/new-feature

# Or use the shorter version
git push -u origin feature/new-feature
```

### Expected Results
- Local branch is linked to remote branch
- Future `git push` and `git pull` work without specifying branch
- Git knows where to push/pull from

### What to Observe
- Notice the "set upstream" message
- Try `git push` without arguments - it works now
- Check `git branch -vv` to see tracking information

---

## Exercise 8: Cherry-Pick a Commit

### What You'll Learn
How to apply a specific commit from one branch to another.

### Steps

```bash
# First, find a commit hash from another branch
git log --oneline --all

# Switch to the branch where you want to apply the commit
git checkout main

# Cherry-pick the commit (use actual commit hash)
git cherry-pick <commit-hash>

# If there are conflicts, resolve them:
# 1. Edit the conflicted files
# 2. git add <resolved-files>
# 3. git cherry-pick --continue
```

### Expected Results
- The commit is applied to your current branch
- Commit history shows the cherry-picked commit
- If conflicts occur, you resolve them manually

### What to Observe
- Notice the commit appears in your branch's history
- See how conflicts are marked in files
- Check `git log` to see the cherry-picked commit

---

## Exercise 9: Resolve Merge Conflicts

### What You'll Learn
How to handle conflicts when merging branches.

### Steps

```bash
# Create a branch and make changes
git checkout -b feature/conflict-test
echo "Line 1" > conflict-file.txt
echo "Line 2 from feature" >> conflict-file.txt
git add conflict-file.txt
git commit -m "Add lines to conflict file"

# Switch to main and modify the same file
git checkout main
echo "Line 1" > conflict-file.txt
echo "Line 2 from main" >> conflict-file.txt
git add conflict-file.txt
git commit -m "Modify conflict file on main"

# Try to merge (this will create a conflict)
git merge feature/conflict-test

# Resolve the conflict:
# 1. Open conflict-file.txt
# 2. Look for conflict markers: <<<<<<<, =======, >>>>>>>
# 3. Edit to keep what you want
# 4. Remove the conflict markers

# After resolving:
git add conflict-file.txt
git commit -m "Resolve merge conflict"
```

### Expected Results
- Merge starts but pauses due to conflict
- Conflict markers show in the file
- After resolving, merge completes

### What to Observe
- Notice the conflict markers in the file
- See how Git shows both versions
- Understand that you choose what to keep

---

## Exercise 10: Rebase Your Branch

### What You'll Learn
How to rebase your branch on top of another branch.

### Steps

```bash
# Make sure main is up to date
git checkout main
git pull origin main

# Switch to your feature branch
git checkout feature/my-feature

# Rebase on top of main
git rebase main

# If conflicts occur:
# 1. Resolve conflicts in files
# 2. git add <resolved-files>
# 3. git rebase --continue

# If you want to abort:
# git rebase --abort
```

### Expected Results
- Your feature branch commits are replayed on top of main
- Linear history (no merge commit)
- Conflicts may need resolution

### What to Observe
- Notice how history changes after rebase
- See the difference from merge (no merge commit)
- Understand when to use rebase vs merge

---

## Exercise 11: Git Flow Workflow

### What You'll Learn
A structured branching model for managing releases.

### Steps

```bash
# Start from main
git checkout main

# Create a feature branch
git checkout -b feature/awesome-feature
# ... work on feature ...
git add .
git commit -m "Implement awesome feature"
git push -u origin feature/awesome-feature

# Create a release branch
git checkout main
git checkout -b release/1.0.0
# ... prepare for release ...
git commit -m "Prepare release 1.0.0"
git push -u origin release/1.0.0

# Create a hotfix branch (from main)
git checkout main
git checkout -b hotfix/urgent-fix
# ... fix urgent issue ...
git commit -m "Fix urgent issue"
git push -u origin hotfix/urgent-fix
```

### Expected Results
- Different branch types for different purposes
- Feature branches for new work
- Release branches for preparing releases
- Hotfix branches for urgent fixes

### What to Observe
- Notice the branch naming convention
- See how different branches serve different purposes
- Understand the workflow structure

---

## Exercise 12: View Git Reflog

### What You'll Learn
How to see Git's history of operations and recover lost commits.

### Steps

```bash
# View the reflog
git reflog

# See reflog for a specific branch
git reflog show main

# Use reflog to recover a lost commit
# Find the commit hash in reflog
git checkout <commit-hash>

# Or create a branch from it
git checkout -b recovered-branch <commit-hash>
```

### Expected Results
- See all recent Git operations
- Find commits even if branches were deleted
- Recover lost work

### What to Observe
- Notice how reflog shows operations, not just commits
- See that reflog has a time component
- Understand that reflog is local (not shared)

---

## Exercise 13: Complete Workflow

### What You'll Learn
Putting it all together - a complete Git workflow.

### Steps

```bash
# 1. Start from updated main
git checkout main
git pull origin main

# 2. Create feature branch
git checkout -b feature/user-dashboard

# 3. Develop feature
echo "Dashboard code" > dashboard.js
git add dashboard.js
git commit -m "Add user dashboard component"

# 4. Push feature branch
git push -u origin feature/user-dashboard

# 5. (On GitHub) Create Pull Request
# 6. (After PR is merged) Update local main
git checkout main
git pull origin main

# 7. Delete feature branch locally
git branch -d feature/user-dashboard

# 8. Delete remote branch
git push origin --delete feature/user-dashboard
```

### Expected Results
- Complete workflow from start to finish
- Feature developed, reviewed, merged, cleaned up
- Main branch stays clean

### What to Observe
- Notice the complete lifecycle
- See how branches are created, used, and deleted
- Understand the collaboration workflow

---

## Practice Checklist

Work through these exercises and check them off:

- [ ] Cloned a repository
- [ ] Pulled latest changes
- [ ] Made changes and committed them
- [ ] Pushed changes to remote
- [ ] Created and switched branches
- [ ] Pushed a branch to remote
- [ ] Set upstream for a branch
- [ ] Cherry-picked a commit
- [ ] Resolved a merge conflict
- [ ] Rebased a branch
- [ ] Used Git Flow workflow
- [ ] Viewed and used reflog
- [ ] Completed a full workflow

## My Take: Practice Makes Perfect

I used to read Git tutorials. I'd understand the concepts. But when I actually needed to use Git, I'd forget.

Then I started doing these exercises. Over and over. Until they became muscle memory.

**Now? I don't think about Git commands. I just use them. That's the power of practice.**

## Key Takeaways

1. **Practice is essential** - Reading isn't enough
2. **Start simple** - Master basics before advanced
3. **Repeat exercises** - Until they're automatic
4. **Real scenarios** - Practice what you'll actually do
5. **Make mistakes** - That's how you learn

## What's Next?

Now that you've practiced the basics, let's dive deeper into advanced operations. Next: [Advanced Git Operations](/docs/git-github/advanced-git/rebase-vs-merge).

---

> **Remember**: Git is learned by doing. Practice these exercises until they're automatic. Then create your own screenshots to document your learning journey.
