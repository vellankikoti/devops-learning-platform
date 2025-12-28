---
sidebar_position: 5
title: "Infrastructure Scripts: Terraform, Ansible"
---

# Infrastructure Scripts: Automate Infrastructure

Infrastructure scripts use Terraform, Ansible. Automate infrastructure.

**Here's the thing: Infrastructure scripts automate infrastructure. Learn patterns. Use them.**

## Terraform

```bash
#!/bin/bash
terraform init
terraform plan
terraform apply
```

**My take**: Terraform scripts automate. Use them.

## Ansible

```bash
#!/bin/bash
ansible-playbook playbook.yml
```

**My take**: Ansible scripts automate. Use them.

## Common Patterns

### Provision Infrastructure

```bash
provision() {
    terraform init
    terraform apply -auto-approve
}
```

## What's Next?

Now that you understand infrastructure scripts, you can automate infrastructure. Or review [DevOps Integration](/docs/shell-scripting/devops-integration/ci-cd-scripts) to reinforce.

---

> **Personal note**: Infrastructure scripts seemed complex at first. Then I learned them. Now I use them. They're useful. Learn them.

