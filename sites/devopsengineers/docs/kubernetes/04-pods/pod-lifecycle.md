---
sidebar_position: 2
title: Pod Lifecycle
---

# Pod Lifecycle: Hotel Room States

**Pods have a lifecycle. Like hotel rooms. Reserved. Occupied. Checked out. That's pod lifecycle.**

## 🎯 The Big Picture

Think of pod lifecycle like hotel room states. Room reserved (Pending). Room occupied (Running). Guest checked out (Succeeded). Problem occurred (Failed). That's pod lifecycle.

**Pod lifecycle has states. Pending. Running. Succeeded. Failed. Unknown. Understanding lifecycle is understanding pods.**

## The Hotel Room States Analogy

**Think of pod lifecycle like hotel room states:**

**Pending:** Room reserved
- Reservation made
- Waiting for assignment
- Not yet occupied

**Running:** Room occupied
- Guest checked in
- Room in use
- Everything working

**Succeeded:** Guest checked out successfully
- Stay completed
- No problems
- Clean checkout

**Failed:** Problem occurred
- Guest had to leave early
- Problem during stay
- Unsuccessful

**Unknown:** Status unclear
- Can't determine state
- Communication issue
- Problem with hotel system

**Once you see it this way, pod lifecycle makes perfect sense.**

## Pod States

### Pending: Room Reserved

**What it means:**
- Pod created
- Not yet scheduled
- Waiting for resources

**Why pending:**
- Waiting for scheduler
- Insufficient resources
- Node taints
- No suitable nodes

**Think of it as:** Room reserved. Waiting for floor assignment.

**Example:**
```bash
kubectl get pods
```

**Output:**
```
NAME    READY   STATUS    RESTARTS   AGE
my-pod  0/1     Pending  0          30s
```

### Running: Room Occupied

**What it means:**
- Pod scheduled
- Containers running
- At least one container running

**Why running:**
- Successfully scheduled
- Containers started
- Application running

**Think of it as:** Room occupied. Guest checked in. Everything working.

**Example:**
```bash
kubectl get pods
```

**Output:**
```
NAME    READY   STATUS    RESTARTS   AGE
my-pod  1/1     Running   0          2m
```

### Succeeded: Guest Checked Out Successfully

**What it means:**
- All containers terminated
- Successfully completed
- Exit code 0

**Why succeeded:**
- Job completed
- Task finished
- Successful execution

**Think of it as:** Guest checked out. Stay completed. No problems.

**Example:**
```bash
kubectl get pods
```

**Output:**
```
NAME    READY   STATUS      RESTARTS   AGE
my-job  0/1     Succeeded   0          5m
```

### Failed: Problem Occurred

**What it means:**
- All containers terminated
- At least one failed
- Exit code non-zero

**Why failed:**
- Application error
- Container crash
- Configuration error

**Think of it as:** Problem occurred. Guest had to leave. Unsuccessful.

**Example:**
```bash
kubectl get pods
```

**Output:**
```
NAME    READY   STATUS   RESTARTS   AGE
my-pod  0/1     Failed   3         5m
```

### Unknown: Status Unclear

**What it means:**
- Pod state unknown
- Communication issue
- Node problem

**Why unknown:**
- Node unreachable
- kubelet not responding
- Network issue

**Think of it as:** Status unclear. Can't determine. Communication problem.

## Container States

**Within pod, containers have states:**

### Waiting: Waiting to Start

**What it means:**
- Container not started
- Waiting for something
- Pre-start phase

**Why waiting:**
- Pulling image
- Waiting for dependencies
- Init containers running

**Think of it as:** Guest waiting. Not yet in room.

### Running: Container Running

**What it means:**
- Container started
- Process running
- Application active

**Why running:**
- Successfully started
- Application running
- Healthy

**Think of it as:** Guest in room. Active. Using room.

### Terminated: Container Stopped

**What it means:**
- Container stopped
- Process terminated
- Exit code set

**Why terminated:**
- Completed successfully
- Failed
- Stopped manually

**Think of it as:** Guest left. Room empty. Stay ended.

## Complete Pod Lifecycle Journey

**Let's trace a complete pod lifecycle using hotel analogy:**

### Step 1: Reservation Made (Pod Created)

**What happens:**
- Guest makes reservation (pod created)
- Reservation recorded (pod definition stored)
- Waiting for room assignment

**Kubernetes:**
```bash
kubectl apply -f pod.yaml
```

**State:** Pending

**Think of it as:** Reservation made. Waiting for assignment.

### Step 2: Room Assigned (Pod Scheduled)

**What happens:**
- Room assigned (pod scheduled to node)
- Floor selected (node chosen)
- Ready for check-in

**Kubernetes:**
- Scheduler assigns pod
- Pod bound to node
- kubelet receives

**State:** Pending → Running

**Think of it as:** Room assigned. Ready for check-in.

### Step 3: Guest Checks In (Container Starts)

**What happens:**
- Guest arrives (container starts)
- Room service activates (container runtime runs)
- Guest in room (container running)

**Kubernetes:**
- kubelet creates pod
- Container runtime starts container
- Container running

**State:** Running

**Think of it as:** Guest checks in. Room occupied.

### Step 4: Guest Stays (Container Running)

**What happens:**
- Guest in room (container running)
- Using room services (application serving)
- Everything working

**Kubernetes:**
- Container running
- Application serving
- Health checks passing

**State:** Running

**Think of it as:** Guest stays. Room in use.

### Step 5: Guest Checks Out (Container Terminates)

**What happens:**
- Guest checks out (container terminates)
- Room vacated (pod terminated)
- Stay completed

**Kubernetes:**
- Container terminates
- Exit code set
- Pod state updated

**State:** Running → Succeeded/Failed

**Think of it as:** Guest checks out. Stay completed.

## Restart Policies

**What happens when container exits:**

### Always: Always Restart

**What it means:**
- Always restart container
- Keep pod running
- Continuous operation

**Use case:**
- Web servers
- APIs
- Long-running services

**Think of it as:** Always rebook room. Keep occupied.

### OnFailure: Restart on Failure

**What it means:**
- Restart only on failure
- Don't restart on success
- Retry failed containers

**Use case:**
- Jobs
- Batch processing
- One-time tasks

**Think of it as:** Rebook only if problem. Success means done.

### Never: Never Restart

**What it means:**
- Never restart container
- Let it terminate
- No automatic restart

**Use case:**
- Completed jobs
- One-time tasks
- Manual control

**Think of it as:** Don't rebook. Let it end.

## Real-World Example: Complete Lifecycle

**Deploying a web application:**

**Step 1: Create pod:**
```bash
kubectl apply -f web-pod.yaml
```

**State:** Pending

**Step 2: Pod scheduled:**
```bash
kubectl get pods
# Status: Pending → Running
```

**Step 3: Container starts:**
```bash
kubectl get pods
# Status: Running
# Ready: 0/1 → 1/1
```

**Step 4: Application running:**
```bash
kubectl get pods
# Status: Running
# Ready: 1/1
```

**Step 5: Pod terminates (if needed):**
```bash
kubectl delete pod web-pod
# State: Running → Terminating → (removed)
```

**That's complete lifecycle. From creation to termination.**

## My Take: Lifecycle Understanding

**Here's what I think:**

**Understanding lifecycle:**
- Essential for troubleshooting
- Know what state means
- Understand transitions
- Debug effectively

**The key:** Understand lifecycle. Know states. Troubleshoot effectively.

## Memory Tip: The Hotel Room States Analogy

**Pod lifecycle = Hotel room states**

**Pending:** Reserved
**Running:** Occupied
**Succeeded:** Checked out successfully
**Failed:** Problem occurred
**Unknown:** Status unclear

**Once you see it this way, lifecycle makes perfect sense.**

## Common Mistakes

1. **Not understanding states**: Confusing what state means
2. **Ignoring container states**: Missing container-level issues
3. **Wrong restart policy**: Unexpected behavior
4. **Not monitoring transitions**: Missing state changes
5. **Confusing pod and container states**: Wrong understanding

## Key Takeaways

1. **Pods have lifecycle states** - Pending, Running, Succeeded, Failed, Unknown
2. **Containers have states too** - Waiting, Running, Terminated
3. **Restart policies control behavior** - Always, OnFailure, Never
4. **Understanding lifecycle is essential** - For troubleshooting
5. **States transition** - From creation to termination

## What's Next?

Now that you understand pod lifecycle, let's learn about creating pods. Next: [Creating Pods](/docs/kubernetes/04-pods/creating-pods).

---

> **Remember**: Pod lifecycle is like hotel room states. Pending (reserved). Running (occupied). Succeeded (checked out). Failed (problem). Understand lifecycle. Master pods.

