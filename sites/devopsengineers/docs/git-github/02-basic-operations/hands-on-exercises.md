---
sidebar_position: 7
title: Hands-On Exercises
---

# Hands-On Exercises: Learning Git by Doing

**Theory is good. Practice is better. These hands-on exercises will make Git second nature.**

## 🎯 The Big Picture

You can read about Git all day. But you'll only learn it by doing it. These exercises take you through real scenarios you'll face in DevOps.

**Think of it like this: Reading about swimming doesn't teach you to swim. These exercises are the pool. Jump in.**

## Exercise 1: Your First Repository

### Setup

```bash
# Create a project directory
mkdir my-first-git-project
cd my-first-git-project

# Initialize Git repository
git init
```

**Expected Output**:
```
Initialized empty Git repository in /path/to/my-first-git-project/.git
```

![Git Init Output](/img/git-github/hands-on/git-init-output.png)

### Create Your First File

```bash
# Create a README file
echo "# My First Git Project" > README.md

# Check status
git status
```

**What you'll see**:
- `README.md` shows as "untracked"
- Git is aware of the file but not tracking it yet

![Git Status Untracked](/img/git-github/hands-on/git-status-untracked.png)

### Stage and Commit

```bash
# Stage the file
git add README.md

# Check status again
git status
```

**What you'll see**:
- `README.md` now shows as "new file" ready to be committed

![Git Status Staged](/img/git-github/hands-on/git-status-staged.png)

```bash
# Make your first commit
git commit -m "Initial commit: Add README"

# Check status
git status
```

**What you'll see**:
- "working tree clean" - everything is committed

![First Commit](/img/git-github/hands-on/first-commit.png)

### View Your History

```bash
# See your commit history
git log

# Or in one line format
git log --oneline
```

![Git Log](/img/git-github/hands-on/git-log.png)

## Exercise 2: Making Changes

### Modify a File

```bash
# Edit README.md
echo "" >> README.md
echo "This is my first Git project." >> README.md
echo "Learning Git step by step." >> README.md

# Check what changed
git diff
```

**What you'll see**:
- Lines added (marked with `+`)
- Git shows exactly what changed

![Git Diff](/img/git-github/hands-on/git-diff.png)

### Stage and Commit Changes

```bash
# Stage the changes
git add README.md

# See staged changes
git diff --staged

# Commit
git commit -m "Add project description to README"
```

![Staged Changes](/img/git-github/hands-on/git-diff-staged.png)

## Exercise 3: Working with Multiple Files

### Create Multiple Files

```bash
# Create a script file
cat > deploy.sh << 'EOF'
#!/bin/bash
echo "Deploying application..."
# Deployment logic here
EOF

# Create a config file
cat > config.yaml << 'EOF'
app:
  name: my-app
  version: 1.0.0
EOF

# Check status
git status
```

**What you'll see**:
- Multiple untracked files
- Git shows all new files

![Multiple Files](/img/git-github/hands-on/multiple-files.png)

### Stage Selectively

```bash
# Stage only the script
git add deploy.sh

# Check status
git status
```

**What you'll see**:
- `deploy.sh` is staged
- `config.yaml` is still untracked

![Selective Staging](/img/git-github/hands-on/selective-staging.png)

```bash
# Commit the script
git commit -m "Add deployment script"

# Now stage and commit the config
git add config.yaml
git commit -m "Add configuration file"
```

## Exercise 4: Viewing History

### See Detailed History

```bash
# View full commit history
git log

# View with file changes
git log --stat

# View with actual code changes
git log -p
```

![Git Log Detailed](/img/git-github/hands-on/git-log-detailed.png)

### See Specific Commit

```bash
# Get commit hash from log
git log --oneline

# View specific commit
git show <commit-hash>
```

![Git Show](/img/git-github/hands-on/git-show.png)

## Exercise 5: Undoing Changes

### Undo Uncommitted Changes

```bash
# Make a change to README.md
echo "This line will be removed" >> README.md

# See the change
git diff

# Discard the change
git restore README.md

# Verify it's gone
git diff
```

![Undo Changes](/img/git-github/hands-on/undo-changes.png)

### Unstage Changes

```bash
# Make a change and stage it
echo "Test line" >> README.md
git add README.md

# Unstage it
git restore --staged README.md

# Check status
git status
```

![Unstage Changes](/img/git-github/hands-on/unstage-changes.png)

## Exercise 6: Working with .gitignore

### Create .gitignore

```bash
# Create .gitignore
cat > .gitignore << 'EOF'
# Logs
*.log
logs/

# Environment files
.env
.env.local

# Build outputs
dist/
build/
*.o
EOF

# Add it
git add .gitignore
git commit -m "Add .gitignore file"
```

![Gitignore](/img/git-github/hands-on/gitignore.png)

### Test .gitignore

```bash
# Create a file that should be ignored
echo "test" > test.log
echo "secret" > .env

# Check status
git status
```

**What you'll see**:
- These files don't appear in `git status`
- `.gitignore` is working

![Gitignore Working](/img/git-github/hands-on/gitignore-working.png)

## Exercise 7: Branching Basics

### Create a Branch

```bash
# Create and switch to new branch
git checkout -b feature/add-authentication

# Or use newer command
git switch -c feature/add-authentication

# Verify you're on the branch
git branch
```

![Create Branch](/img/git-github/hands-on/create-branch.png)

### Make Changes on Branch

```bash
# Create a new file on the branch
cat > auth.js << 'EOF'
function authenticate(user, password) {
  // Authentication logic
  return true;
}
EOF

# Commit on branch
git add auth.js
git commit -m "Add authentication function"
```

![Branch Commit](/img/git-github/hands-on/branch-commit.png)

### Switch Branches

```bash
# Switch back to main
git checkout main

# Verify auth.js doesn't exist here
ls -la

# Switch back to feature branch
git checkout feature/add-authentication

# auth.js is back
ls -la
```

![Switch Branches](/img/git-github/hands-on/switch-branches.png)

## Exercise 8: Merging Branches

### Merge Feature Branch

```bash
# Switch to main
git checkout main

# Merge feature branch
git merge feature/add-authentication

# View history
git log --oneline --graph
```

![Merge Branch](/img/git-github/hands-on/merge-branch.png)

## Exercise 9: Working with Remote

### Add Remote Repository

```bash
# Add remote (replace with your repo URL)
git remote add origin https://github.com/yourusername/your-repo.git

# Verify
git remote -v
```

![Add Remote](/img/git-github/hands-on/add-remote.png)

### Push to Remote

```bash
# Push to remote
git push -u origin main

# Verify on GitHub/GitLab
```

![Push to Remote](/img/git-github/hands-on/push-remote.png)

## Exercise 10: Clone and Collaborate

### Clone a Repository

```bash
# Clone a repository
git clone https://github.com/user/repo.git

# Enter the directory
cd repo

# Check remotes
git remote -v
```

![Clone Repo](/img/git-github/hands-on/clone-repo.png)

### Pull Latest Changes

```bash
# Get latest changes
git pull origin main

# Make changes
echo "New feature" > feature.txt
git add feature.txt
git commit -m "Add new feature"

# Push your changes
git push origin main
```

![Pull and Push](/img/git-github/hands-on/pull-push.png)

## Real-World Scenario: Complete Workflow

### Scenario: Adding a New Feature

```bash
# 1. Start from updated main
git checkout main
git pull origin main

# 2. Create feature branch
git checkout -b feature/user-dashboard

# 3. Develop feature
# ... make changes ...
git add .
git commit -m "Add user dashboard component"

# 4. Push feature branch
git push -u origin feature/user-dashboard

# 5. Create Pull Request on GitHub
# (Done via GitHub UI)

# 6. After PR is merged, update local main
git checkout main
git pull origin main

# 7. Delete feature branch
git branch -d feature/user-dashboard
git push origin --delete feature/user-dashboard
```

![Complete Workflow](/img/git-github/hands-on/complete-workflow.png)

## My Take: Practice Makes Perfect

I used to read Git tutorials. I'd understand the concepts. But when I actually needed to use Git, I'd forget.

Then I started doing these exercises. Over and over. Until they became muscle memory.

**Now? I don't think about Git commands. I just use them. That's the power of practice.**

## Practice Checklist

- [ ] Created your first repository
- [ ] Made your first commit
- [ ] Viewed commit history
- [ ] Undone changes
- [ ] Created and used .gitignore
- [ ] Created and switched branches
- [ ] Merged branches
- [ ] Added remote repository
- [ ] Pushed to remote
- [ ] Cloned a repository
- [ ] Completed a full workflow

## Key Takeaways

1. **Practice is essential** - Reading isn't enough
2. **Start simple** - Master basics before advanced
3. **Repeat exercises** - Until they're automatic
4. **Real scenarios** - Practice what you'll actually do
5. **Screenshots help** - Visual confirmation of what you should see

## What's Next?

Now that you've practiced the basics, let's dive deeper into advanced operations. Next: [Advanced Git Operations](/docs/git-github/advanced-git/rebase-vs-merge).

---

> **Remember**: Git is learned by doing. Practice these exercises until they're automatic.

