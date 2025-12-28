---
sidebar_position: 1
title: Linux In CI/CD Pipelines
---

# Linux in CI/CD: Your Skills in Action

CI/CD pipelines are Linux commands. That's it. They run on Linux. They use Linux commands.

**Here's the thing: Your Linux skills directly translate to CI/CD. Understanding Linux = understanding pipelines.**

## The Connection

**CI/CD pipelines are automated Linux commands**:
- Build = Linux commands
- Test = Linux commands
- Deploy = Linux commands
- All run on Linux

**My take**: CI/CD is just Linux automation. Your Linux skills apply directly.

## GitHub Actions

**Runs on**: Ubuntu Linux (default)

**Example**:
```yaml
name: Build
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

**Linux commands used**:
- `apt update` = Update packages
- `apt install` = Install software
- `make` = Build
- Shell scripts = Deploy

**My take**: GitHub Actions = Linux commands in YAML. That's it.

## GitLab CI

**Runs on**: Linux runners

**Example**:
```yaml
build:
  script:
    - apt-get update
    - apt-get install -y dependencies
    - make build
    - ./deploy.sh
```

**My take**: GitLab CI = Linux commands in YAML. Same concept.

## Jenkins

**Runs on**: Linux (usually)

**Pipeline**:
```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'apt-get update'
                sh 'apt-get install -y dependencies'
                sh 'make build'
            }
        }
        stage('Deploy') {
            steps {
                sh './deploy.sh'
            }
        }
    }
}
```

**The `sh` command**: Runs shell commands. Linux commands.

**My take**: Jenkins = Linux commands in Groovy. Still Linux.

## Common Pipeline Tasks

### Install Dependencies

```bash
sudo apt update
sudo apt install -y package1 package2
```

### Build Applications

```bash
make build
npm install
npm run build
```

### Run Tests

```bash
make test
npm test
pytest
```

### Deploy

```bash
./deploy.sh
rsync -av build/ user@server:/var/www/html/
```

**My take**: All Linux commands. Your Linux skills apply directly.

## The Truth About CI/CD

**CI/CD is Linux automation.**

That's it. It's not magic. It's Linux commands running automatically.

**My take**: Learn Linux well. CI/CD becomes easy. It's the same skills.

## What's Next?

Now that you see the connection, your Linux skills apply to CI/CD. Or learn [Shell Scripting](/docs/shell-scripting/intro) to automate these commands.

---

> **Personal note**: When I started with CI/CD, I thought it was complex. Then I realized: it's just Linux commands. The same commands I use daily. CI/CD is Linux automation. Learn Linux. CI/CD follows.
