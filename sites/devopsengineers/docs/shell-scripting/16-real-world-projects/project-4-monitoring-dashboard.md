---
sidebar_position: 4
title: "Project 4: Monitoring Dashboard"
---

# Project 4: Monitoring Dashboard Script

Build monitoring dashboard. Collect metrics. Display them. Real project.

**Here's the thing: Monitoring dashboards are useful. Build one. Learn from it.**

## Features

- Collect system metrics
- Display dashboard
- Alert on problems
- Generate reports

## Implementation

```bash
#!/bin/bash
# Monitoring dashboard
# Collects and displays system metrics

collect_metrics() {
    cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
    memory=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    echo "CPU: $cpu% Memory: $memory%"
}
```

**My take**: Build projects. Learn from them.

## What's Next?

Now that you understand monitoring dashboards, let's talk about [Project 5: Infrastructure Setup](/docs/shell-scripting/real-world-projects/project-5-infrastructure-setup).

---

> **Personal note**: Projects teach you. Build them. Learn from them. They're valuable.

