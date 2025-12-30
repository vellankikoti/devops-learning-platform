---
sidebar_position: 4
title: Infrastructure as Code
---

# Infrastructure as Code: Docker in IaC

**Infrastructure as Code means infrastructure defined in code. Version controlled. Reproducible. Docker fits perfectly. That's Docker in IaC.**

## 🎯 The Big Picture

Think of Infrastructure as Code like a blueprint. You design once (write code). You build many times (deploy). Same result every time. That's IaC.

**Docker in IaC means containers defined in code. Version controlled. Reproducible. It's how modern infrastructure works.**

## What is Infrastructure as Code?

**Infrastructure as Code defines infrastructure in code:**

**What it means:**
- Infrastructure in code files
- Version controlled
- Reproducible
- Automated deployment

**Think of it as:** Blueprint for infrastructure. Code defines everything. Deploy anywhere.

## Why Docker in IaC?

**The problem without IaC:**
- Manual infrastructure setup
- Inconsistent environments
- Hard to reproduce
- No version control
- Error-prone

**The solution with IaC:**
- Infrastructure in code
- Consistent environments
- Easy to reproduce
- Version controlled
- Automated

**Real example:** I once set up infrastructure manually. Different each time. With IaC, same every time. Never again.

**Docker in IaC isn't optional. It's essential.**

## Docker with Terraform

**Define Docker resources in Terraform:**

```hcl
# main.tf
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name = "nginx:alpine"
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "nginx"
  ports {
    internal = 80
    external = 8080
  }
}
```

**Apply:**
```bash
terraform init
terraform plan
terraform apply
```

**That's Docker with Terraform. Infrastructure as code.**

## Docker with Ansible

**Define Docker in Ansible:**

```yaml
# playbook.yml
- name: Deploy Docker containers
  hosts: all
  tasks:
    - name: Pull nginx image
      docker_image:
        name: nginx:alpine
        source: pull
    
    - name: Run nginx container
      docker_container:
        name: nginx
        image: nginx:alpine
        state: started
        ports:
          - "8080:80"
```

**Run:**
```bash
ansible-playbook playbook.yml
```

**That's Docker with Ansible. Infrastructure as code.**

## Docker Compose as IaC

**Compose files are IaC:**

```yaml
# docker-compose.yml
services:
  app:
    build: .
    image: my-app:1.0
    ports:
      - "3000:3000"
    environment:
      NODE_ENV: production
    volumes:
      - app-data:/data

volumes:
  app-data:
```

**Deploy:**
```bash
docker compose up -d
```

**That's Docker Compose as IaC. Simple. Works.**

## The Blueprint Analogy

**Think of IaC like a blueprint:**

**Code:** Blueprint design
**Version control:** Blueprint storage
**Deploy:** Build from blueprint
**Reproducible:** Same result every time

**Once you see it this way, IaC makes perfect sense.**

## Best Practices

### 1. Version Control Everything

**Commit infrastructure code:**
```bash
git add docker-compose.yml
git commit -m "Add production infrastructure"
git push
```

**Why:** History. Rollback. Collaboration.

### 2. Use Modules

**Reusable modules:**
```hcl
module "web_app" {
  source = "./modules/web-app"
  image  = "my-app:1.0"
}
```

**Why:** DRY. Reusable. Maintainable.

### 3. Parameterize

**Use variables:**
```yaml
services:
  app:
    image: ${APP_IMAGE:-my-app:1.0}
    replicas: ${REPLICAS:-3}
```

**Why:** Flexible. Environment-specific.

### 4. Test Infrastructure

**Test before deploy:**
```bash
terraform plan
docker compose config
```

**Why:** Catch errors. Before production.

### 5. Document

**Document infrastructure:**
- What it does
- How to deploy
- Dependencies
- Requirements

**Why:** Clear. Maintainable.

## My Take: IaC Strategy

**Here's what I do:**

**Development:**
- Docker Compose
- Simple
- Local

**Staging:**
- Terraform or Ansible
- Automated
- Tested

**Production:**
- Terraform or Ansible
- Automated
- Version controlled
- Documented

**The key:** Everything in code. Version controlled. Automated. Documented.

## Memory Tip: The Blueprint Analogy

**Infrastructure as Code = Blueprint**

**Code:** Design
**Version control:** Storage
**Deploy:** Build
**Reproducible:** Same result

**Once you see it this way, IaC makes perfect sense.**

## Common Mistakes

1. **Not version controlling**: No history
2. **Hard-coding values**: Not flexible
3. **Not testing**: Errors in production
4. **No documentation**: Hard to maintain
5. **Manual changes**: Breaks reproducibility

## Key Takeaways

1. **Infrastructure as Code defines infrastructure in code** - Version controlled, reproducible
2. **Docker fits perfectly** - Containers in code
3. **Version control everything** - History, rollback
4. **Use modules** - DRY, reusable
5. **Test infrastructure** - Catch errors early
6. **Document** - Clear, maintainable

## What's Next?

Congratulations! You've completed the DevOps Integration module. Now let's learn about advanced Docker topics. Next: [Docker Swarm](/docs/docker/11-advanced-topics/docker-swarm).

---

> **Remember**: Infrastructure as Code is like a blueprint. Design once. Build many times. Same result. Version controlled. Essential for modern DevOps.

