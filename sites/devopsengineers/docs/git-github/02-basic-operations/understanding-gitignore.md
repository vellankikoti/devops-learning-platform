---
sidebar_position: 6
title: Understanding .gitignore
---

# Understanding .gitignore: What Git Shouldn't Track

**.gitignore is your friend. It tells Git what to ignore. Understanding .gitignore is understanding what shouldn't be in version control.**

## 🎯 The Big Picture

Not everything should be tracked. Build outputs, dependencies, secrets, temporary files - these don't belong in Git. `.gitignore` tells Git to ignore them.

**Think of it like this: If Git is a filing cabinet, .gitignore is the "don't file" list. It keeps junk out of your repository.**

## What Is .gitignore?

`.gitignore` is a file that tells Git which files and directories to ignore. It uses pattern matching to exclude files from tracking.

```bash
# Create .gitignore
touch .gitignore

# Or create with content
cat > .gitignore << EOF
node_modules/
*.log
.env
EOF
```

## .gitignore Location

`.gitignore` can be in multiple places:

1. **Repository root** (most common)
   ```
   project/
   ├── .gitignore  # Applies to entire repository
   └── ...
   ```

2. **Subdirectories** (applies to that directory and below)
   ```
   project/
   ├── src/
   │   └── .gitignore  # Applies to src/ and below
   └── ...
   ```

3. **Global .gitignore** (applies to all repositories)
   ```bash
   # Set global ignore file
   git config --global core.excludesfile ~/.gitignore_global
   ```

## .gitignore Patterns

### Basic Patterns

```bash
# Ignore specific file
filename.txt

# Ignore all files with extension
*.log

# Ignore directory
node_modules/

# Ignore all files in directory
dist/*
```

### Pattern Matching Rules

```bash
# * matches zero or more characters
*.log          # All .log files
*.txt          # All .txt files

# ? matches single character
file?.txt      # file1.txt, file2.txt, but not file10.txt

# [] matches character set
file[0-9].txt  # file0.txt through file9.txt

# ** matches any directory level
**/node_modules/  # node_modules in any directory

# ! negates pattern (unignore)
*.log
!important.log  # Ignore all .log except important.log

# / at start matches repository root
/README.md      # Only README.md in root

# / at end matches directory
src/            # Only src/ directory
```

## Common .gitignore Patterns

### Node.js Project

```bash
# Dependencies
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Build outputs
dist/
build/
*.tsbuildinfo

# Environment
.env
.env.local
.env.*.local

# IDE
.vscode/
.idea/
*.swp
```

### Python Project

```bash
# Bytecode
__pycache__/
*.py[cod]
*$py.class

# Virtual environments
venv/
env/
ENV/

# Distribution
dist/
build/
*.egg-info/

# IDE
.vscode/
.idea/
```

### General Development

```bash
# OS files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
Thumbs.db

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# Logs
*.log
logs/

# Temporary files
*.tmp
*.temp
*.bak
```

## Advanced .gitignore Patterns

### Ignore Everything Except

```bash
# Ignore everything
*

# But track these
!src/
!README.md
!.gitignore
```

### Ignore in Specific Directory

```bash
# Ignore .env only in config/
config/.env

# Ignore all .tmp in temp/
temp/**/*.tmp
```

### Conditional Patterns

```bash
# Ignore .log files
*.log

# But not important.log
!important.log

# Ignore all in build/
build/*

# But track build/README.md
!build/README.md
```

## Real-World .gitignore Examples

### Example 1: Web Application

```bash
# Dependencies
node_modules/
vendor/

# Build outputs
dist/
build/
public/assets/

# Environment
.env
.env.local
.env.production

# IDE
.vscode/
.idea/
*.swp

# OS
.DS_Store
Thumbs.db

# Logs
*.log
logs/
```

### Example 2: Infrastructure as Code

```bash
# Terraform
*.tfstate
*.tfstate.*
.terraform/
.terraform.lock.hcl

# Ansible
*.retry
.vault_pass

# Secrets
*.pem
*.key
secrets/

# IDE
.vscode/
.idea/
```

### Example 3: Documentation Site

```bash
# Build outputs
build/
.docusaurus/
.cache/

# Dependencies
node_modules/

# Environment
.env
.env.local

# IDE
.vscode/
.idea/
```

## Ignoring Already Tracked Files

If a file is already tracked, adding it to `.gitignore` won't remove it:

```bash
# File is tracked
git status
# Shows: file.txt

# Add to .gitignore
echo "file.txt" >> .gitignore

# Still tracked!
git status
# Still shows: file.txt

# Remove from tracking
git rm --cached file.txt

# Now ignored
git status
# file.txt is gone

# Commit
git add .gitignore
git commit -m "Stop tracking file.txt"
```

## Testing .gitignore

### Check What Would Be Ignored

```bash
# See what git status would show
git status --ignored

# Or check specific file
git check-ignore -v file.txt
# Output: .gitignore:3:*.log file.txt
```

### Verify Patterns

```bash
# Test if pattern matches
git check-ignore -v *.log
git check-ignore -v node_modules/
```

## My Take: .gitignore Is Essential

I used to manually avoid adding files. I'd remember not to add `node_modules/`. I'd forget sometimes.

Then I learned: **.gitignore is set-and-forget. Create it once, use it forever.**

Now I:
- Create `.gitignore` first thing in every project
- Use comprehensive patterns
- Review it periodically
- Never commit without it

**.gitignore is essential. Don't skip it.**

## Memory Tip: The Bouncer Analogy

Think of `.gitignore` like a bouncer at a club:
- **Patterns are the guest list** - What's allowed/not allowed
- **Tracked files are inside** - Already in the club
- **Untracked files are outside** - Waiting to get in
- **Ignored files are rejected** - Not on the list, can't get in

Once you see it that way, `.gitignore` makes sense.

## Common Mistakes

### Mistake 1: Not Using .gitignore

```bash
# Don't do this
# Manually avoid adding files every time
git add file1 file2 file3  # Carefully avoiding node_modules
```

**Fix**: Create `.gitignore` and add freely.

### Mistake 2: Committing .gitignore Too Late

```bash
# Don't do this
git add node_modules/  # Oops!
git commit -m "Add dependencies"
# Now node_modules is in history forever
```

**Fix**: Create `.gitignore` before first commit.

### Mistake 3: Overly Restrictive Patterns

```bash
# Don't do this
*
!src/
# Now you can't add anything new easily
```

**Fix**: Be specific. Ignore what you need, track what you want.

## Key Takeaways

1. **.gitignore prevents tracking unwanted files** - Use it always
2. **Patterns use wildcards** - Learn the syntax
3. **Create it early** - Before first commit
4. **Test patterns** - Use `git check-ignore`
5. **Remove tracked files first** - If already tracked, use `git rm --cached`

## What's Next?

Now that you understand .gitignore, you've completed Basic Operations. Next: [Understanding Branches](/docs/git-github/branching-merging/understanding-branches).

---

> **Remember**: .gitignore is set-and-forget. Create it once, use it forever.

