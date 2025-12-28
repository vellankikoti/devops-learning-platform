---
sidebar_position: 1
title: "CI/CD Scripts: Automation in Pipelines"
---

# CI/CD Scripts: Automate Deployment

CI/CD scripts automate deployment. Build. Test. Deploy. All automated.

**Here's the thing: CI/CD is just Linux commands. Your Linux skills apply directly.**

## GitHub Actions

**Example**:
```yaml
name: Build and Deploy
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Install dependencies
        run: |
          sudo apt update
          sudo apt install -y build-essential
      - name: Build
        run: make build
      - name: Deploy
        run: ./deploy.sh
```

**My take**: GitHub Actions = Linux commands in YAML. That's it.

## Common CI/CD Tasks

### Build

```bash
# Install dependencies
sudo apt update
sudo apt install -y dependencies

# Build
make build
npm install
npm run build
```

### Test

```bash
# Run tests
make test
npm test
pytest
```

### Deploy

```bash
# Deploy
./deploy.sh
rsync -av build/ user@server:/var/www/html/
```

**My take**: All Linux commands. Your skills apply directly.

## Deployment Script

```bash
#!/bin/bash
set -euo pipefail

# Configuration
SERVER="${DEPLOY_SERVER:-production.example.com}"
DEPLOY_PATH="/var/www/html"

# Build
echo "Building..."
npm install
npm run build

# Deploy
echo "Deploying to $SERVER..."
rsync -av --delete build/ "user@${SERVER}:${DEPLOY_PATH}/"

# Restart service
ssh "user@${SERVER}" "sudo systemctl reload nginx"

echo "Deployment complete"
```

**My take**: Deployment scripts are just Linux commands. SSH. rsync. systemctl. You know these.

## Common Patterns

### Build and Test

```bash
#!/bin/bash
set -e

# Install
npm install

# Test
npm test

# Build
npm run build
```

### Deploy to Multiple Servers

```bash
#!/bin/bash
SERVERS=("server1.example.com" "server2.example.com")

for server in "${SERVERS[@]}"; do
    echo "Deploying to $server"
    rsync -av build/ "user@${server}:/var/www/html/"
    ssh "user@${server}" "sudo systemctl reload nginx"
done
```

## Common Mistakes (I've Made These)

1. **Not using `set -e`**: Scripts continue after errors. Use `set -e`.

2. **Hardcoding values**: Use environment variables. Make scripts configurable.

3. **Not testing locally**: Test scripts locally before using in CI/CD.

4. **No error handling**: Scripts fail silently. Handle errors. Check exit codes.

5. **Not idempotent**: Scripts should be safe to run multiple times. Make them idempotent.

## Real-World Examples

### Complete CI/CD Script

```bash
#!/bin/bash
set -euo pipefail

# Build
echo "Building application..."
npm install
npm run build

# Test
echo "Running tests..."
npm test

# Deploy
echo "Deploying..."
rsync -av --delete build/ "user@server:/var/www/html/"
ssh "user@server" "sudo systemctl reload nginx"

echo "Deployment successful"
```

## What's Next?

Now that you can write CI/CD scripts, you can automate deployment. Or learn about [Best Practices](/docs/shell-scripting/best-practices/code-style) to write better scripts.

---

> **Personal note**: When I started with CI/CD, I thought it was complex. Then I realized: it's just Linux commands. The same commands I use daily. CI/CD is Linux automation. Learn Linux. CI/CD follows.
