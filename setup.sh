#!/bin/bash

# DevOps Learning Platform - Quick Setup Script
# This script initializes the complete project structure

set -e  # Exit on error

echo "🚀 DevOps Learning Platform - Quick Setup"
echo "=========================================="
echo ""

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check prerequisites
echo -e "${BLUE}Checking prerequisites...${NC}"

if ! command -v node &> /dev/null; then
    echo -e "${YELLOW}Node.js not found. Please install Node.js 18+ first.${NC}"
    exit 1
fi

if ! command -v npm &> /dev/null; then
    echo -e "${YELLOW}npm not found. Please install npm first.${NC}"
    exit 1
fi

if ! command -v git &> /dev/null; then
    echo -e "${YELLOW}Git not found. Please install Git first.${NC}"
    exit 1
fi

echo -e "${GREEN}✓ All prerequisites met${NC}"
echo ""

# Create directory structure
echo -e "${BLUE}Creating project structure...${NC}"

mkdir -p .github/workflows
mkdir -p sites/devopsengineers
mkdir -p sites/learnk8s
mkdir -p shared/kubernetes
mkdir -p shared/components
mkdir -p scripts
mkdir -p config

echo -e "${GREEN}✓ Directory structure created${NC}"
echo ""

# Initialize main site (devopsengineers.in)
echo -e "${BLUE}Initializing main site (devopsengineers.in)...${NC}"
cd sites/devopsengineers

npx create-docusaurus@latest . classic --typescript --skip-install

echo -e "${GREEN}✓ Main site initialized${NC}"
echo ""

# Install dependencies
echo -e "${BLUE}Installing dependencies...${NC}"
npm install

echo -e "${GREEN}✓ Dependencies installed${NC}"
echo ""

# Create initial content structure
echo -e "${BLUE}Creating content structure...${NC}"

mkdir -p docs/kubernetes
mkdir -p docs/docker
mkdir -p docs/aws
mkdir -p docs/linux
mkdir -p docs/git-github
mkdir -p docs/jenkins
mkdir -p docs/ansible
mkdir -p docs/terraform
mkdir -p docs/shell-scripting

# Create intro pages
cat > docs/intro.md << 'EOF'
---
sidebar_position: 1
title: Welcome to DevOps Engineers
---

# Welcome to DevOps Engineers

Master DevOps tools from Zero to Hero with comprehensive tutorials, real-world examples, and latest updates.

## Learning Paths

### 🎯 Kubernetes Track
From container basics to production-grade Kubernetes deployments.

[Start Learning Kubernetes →](/docs/kubernetes/intro)

### 🐳 Docker Track
Master containerization with Docker and best practices.

[Start Learning Docker →](/docs/docker/intro)

### ☁️ AWS for DevOps
Cloud infrastructure and DevOps services on AWS.

[Start Learning AWS →](/docs/aws/intro)

### 🛠️ Essential Tools
Linux, Git, Jenkins, Ansible, Terraform, and more.

## What Makes Us Different

- ✅ **Always Up-to-date**: Real-time tool version tracking
- ✅ **Hands-on Focus**: Every concept backed by practical examples
- ✅ **Production-Ready**: Enterprise best practices
- ✅ **Zero Cost**: Free and open-source forever

## Latest Updates

Check out [What's New](/blog) to stay updated with latest DevOps developments.
EOF

# Create Kubernetes intro
cat > docs/kubernetes/intro.md << 'EOF'
---
sidebar_position: 1
title: Introduction to Kubernetes
---

# Kubernetes Zero to Hero

Welcome to the comprehensive Kubernetes learning path!

## What You'll Learn

This course takes you from complete beginner to Kubernetes expert with 30 detailed modules covering:

- ✅ Container orchestration fundamentals
- ✅ Kubernetes architecture and components
- ✅ Production-grade deployments
- ✅ Networking, storage, and security
- ✅ Advanced topics (CRDs, Operators, Service Mesh)

## Prerequisites

- Basic understanding of Linux commands
- Familiarity with containers (Docker basics)
- A computer to run Kubernetes locally (minikube/kind)

## Course Structure

### Beginner (Modules 1-10)
Get started with Kubernetes basics and core concepts.

### Intermediate (Modules 11-20)
Dive deeper into networking, storage, and observability.

### Advanced (Modules 21-30)
Master production patterns, security, and custom extensions.

## Start Here

Begin your journey with [What is Kubernetes?](/docs/kubernetes/what-is-kubernetes)

**Estimated time to complete**: 8-12 weeks (self-paced)
EOF

# Create Docker intro
cat > docs/docker/intro.md << 'EOF'
---
sidebar_position: 1
title: Introduction to Docker
---

# Docker Zero to Hero

Master containerization with Docker from basics to advanced production patterns.

## What You'll Learn

- Container fundamentals
- Docker images and layers
- Multi-stage builds
- Docker Compose
- Networking and volumes
- Security best practices
- Docker hardened images (latest trend!)

## Prerequisites

- Basic Linux command line knowledge
- Understanding of application deployment

## Start Learning

[Get Started with Docker →](/docs/docker/installation)
EOF

# Create AWS intro
cat > docs/aws/intro.md << 'EOF'
---
sidebar_position: 1
title: AWS for DevOps Engineers
---

# AWS for DevOps

Learn AWS services specifically relevant for DevOps engineers.

## Focus Areas

- ✅ EKS (Elastic Kubernetes Service)
- ✅ ECR (Container Registry)
- ✅ CodePipeline & CodeBuild
- ✅ CloudFormation & CDK
- ✅ IAM best practices
- ✅ Monitoring with CloudWatch

## Prerequisites

- Basic cloud computing concepts
- AWS account (free tier available)

[Get Started →](/docs/aws/iam)
EOF

echo -e "${GREEN}✓ Initial content created${NC}"
echo ""

# Create custom homepage
echo -e "${BLUE}Creating custom homepage...${NC}"

cat > src/pages/index.tsx << 'HOMEPAGE'
import React from 'react';
import clsx from 'clsx';
import Link from '@docusaurus/Link';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import Layout from '@theme/Layout';
import HomepageFeatures from '@site/src/components/HomepageFeatures';

import styles from './index.module.css';

function HomepageHeader() {
  const {siteConfig} = useDocusaurusContext();
  return (
    <header className={clsx('hero hero--primary', styles.heroBanner)}>
      <div className="container">
        <h1 className="hero__title">{siteConfig.title}</h1>
        <p className="hero__subtitle">{siteConfig.tagline}</p>
        <div className={styles.buttons}>
          <Link
            className="button button--secondary button--lg"
            to="/docs/intro">
            Start Learning - 5 min ⏱️
          </Link>
        </div>
      </div>
    </header>
  );
}

export default function Home(): JSX.Element {
  const {siteConfig} = useDocusaurusContext();
  return (
    <Layout
      title={`Welcome`}
      description="Learn DevOps from Zero to Hero - Kubernetes, Docker, AWS and more">
      <HomepageHeader />
      <main>
        <HomepageFeatures />
      </main>
    </Layout>
  );
}
HOMEPAGE

echo -e "${GREEN}✓ Homepage created${NC}"
echo ""

# Create GitHub Actions workflow
cd ../..  # Back to root
echo -e "${BLUE}Creating GitHub Actions workflow...${NC}"

cat > .github/workflows/deploy.yml << 'WORKFLOW'
name: Deploy to GitHub Pages

on:
  push:
    branches:
      - main
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      
      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: npm
          cache-dependency-path: sites/devopsengineers/package-lock.json

      - name: Install dependencies
        working-directory: sites/devopsengineers
        run: npm ci

      - name: Build website
        working-directory: sites/devopsengineers
        run: npm run build

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: sites/devopsengineers/build

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
WORKFLOW

echo -e "${GREEN}✓ GitHub Actions workflow created${NC}"
echo ""

# Create .gitignore
cat > .gitignore << 'GITIGNORE'
# Dependencies
node_modules/
package-lock.json

# Production
build/
.docusaurus/

# Generated files
.DS_Store
.env.local
.env.development.local
.env.test.local
.env.production.local

npm-debug.log*
yarn-debug.log*
yarn-error.log*

# IDE
.vscode/
.idea/
*.swp
*.swo
GITIGNORE

# Create main README
cat > README.md << 'README'
# DevOps Learning Platform

🚀 Comprehensive learning platform for Kubernetes, Docker, AWS, and all DevOps tools.

## Sites

- **devopsengineers.in** - Main hub for all DevOps content
- **learnk8s.in** - Dedicated Kubernetes deep-dive

## Features

- ✅ 100+ hands-on tutorials
- ✅ Real-time tool version tracking
- ✅ Latest DevOps news and updates
- ✅ Production-ready examples
- ✅ Zero to hero learning paths

## Tech Stack

- **Framework**: Docusaurus 3.x
- **Hosting**: GitHub Pages
- **CI/CD**: GitHub Actions
- **Language**: TypeScript/React

## Local Development

```bash
cd sites/devopsengineers
npm install
npm start
```

Visit http://localhost:3000

## Deployment

Push to `main` branch - GitHub Actions automatically deploys to GitHub Pages.

## Contributing

Contributions welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) first.

## License

MIT License - see [LICENSE](LICENSE)
README

# Initialize git repository
echo -e "${BLUE}Initializing git repository...${NC}"

git init
git add .
git commit -m "Initial commit: DevOps Learning Platform setup"

echo -e "${GREEN}✓ Git repository initialized${NC}"
echo ""

# Final instructions
echo ""
echo -e "${GREEN}=========================================="
echo "✅ Setup Complete!"
echo -e "==========================================${NC}"
echo ""
echo "Next steps:"
echo ""
echo "1. Create a GitHub repository:"
echo "   gh repo create devops-learning-platform --public"
echo ""
echo "2. Push your code:"
echo "   git remote add origin https://github.com/YOUR_USERNAME/devops-learning-platform.git"
echo "   git push -u origin main"
echo ""
echo "3. Enable GitHub Pages in repository settings:"
echo "   - Go to Settings > Pages"
echo "   - Source: GitHub Actions"
echo ""
echo "4. Configure custom domain:"
echo "   - Add DNS records (see Technical_Implementation_Guide.md)"
echo "   - Add CNAME file with your domain"
echo ""
echo "5. Start local development:"
echo "   cd sites/devopsengineers"
echo "   npm start"
echo ""
echo -e "${BLUE}📚 Documentation:${NC}"
echo "   - PRD: PRD_DevOps_Learning_Platform.md"
echo "   - Technical Guide: Technical_Implementation_Guide.md"
echo ""
echo -e "${GREEN}Happy learning! 🎓${NC}"
