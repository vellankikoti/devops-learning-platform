---
sidebar_position: 4
title: "Cloud Automation: AWS, Azure, GCP"
---

# Cloud Automation: Automate Cloud Operations

Cloud automation scripts use AWS CLI, Azure CLI, GCP. Automate cloud.

**Here's the thing: Cloud scripts automate cloud. Learn patterns. Use them.**

## AWS CLI

```bash
#!/bin/bash
aws ec2 describe-instances
aws s3 cp file.txt s3://bucket/
```

**My take**: AWS CLI automates AWS. Use it.

## Common Patterns

### Deploy to Cloud

```bash
deploy_to_aws() {
    aws s3 sync dist/ s3://bucket/
    aws cloudfront create-invalidation --paths "/*"
}
```

## What's Next?

Now that you understand cloud automation, let's talk about [Infrastructure Scripts](/docs/shell-scripting/devops-integration/infrastructure-scripts).

---

> **Personal note**: Cloud scripts seemed complex at first. Then I learned CLI tools. Now I use them. They're useful. Learn them.

