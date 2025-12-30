---
sidebar_position: 1
title: Understanding RBAC
---

# Understanding RBAC: Hotel Access Control

**RBAC is like hotel access control. Who can access which sections. What they can do. That's RBAC.**

## 🎯 The Big Picture

Think of RBAC like hotel access control. Staff can access staff section (role). Guests can access guest section (role). Different permissions (rules). That's RBAC.

**RBAC (Role-Based Access Control) controls who can do what. Roles define permissions. RoleBindings assign roles. Essential for security.**

## The Hotel Access Control Analogy

**Think of RBAC like hotel access control:**

**Role:** Access level
- Staff role
- Guest role
- Manager role
- Different permissions

**RoleBinding:** Assign access
- Assign role to user
- User gets permissions
- Access granted

**Rules:** What can do
- Read rooms
- Write rooms
- Delete rooms
- Specific actions

**Once you see it this way, RBAC makes perfect sense.**

## What is RBAC?

**RBAC definition:**
- Role-Based Access Control
- Who can do what
- Roles and bindings
- Security

**Think of it as:** Access control. Roles. Permissions. Security.

## Why RBAC?

**Problems without RBAC:**
- Everyone has access
- No security
- No control
- Security risk

**Solutions with RBAC:**
- Controlled access
- Security
- Principle of least privilege
- Secure

**Real example:** I once had no RBAC. Everyone had full access. Security risk. With RBAC, controlled. Secure. Never going back.

**RBAC isn't optional. It's essential.**

## RBAC Components

**Core components:**

**Role:**
- Defines permissions
- Namespace-scoped
- What can do

**ClusterRole:**
- Defines permissions
- Cluster-scoped
- What can do

**RoleBinding:**
- Assigns Role
- Namespace-scoped
- Who gets access

**ClusterRoleBinding:**
- Assigns ClusterRole
- Cluster-scoped
- Who gets access

**Think of it as:** Roles define permissions. Bindings assign roles. Namespace or cluster.

## Creating Role

**Basic Role:**
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: pod-reader
  namespace: production
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
```

**What this does:**
- Defines pod-reader role
- Can read pods
- In production namespace

**Think of it as:** Define access level. Read pods. In section.

## Creating RoleBinding

**Basic RoleBinding:**
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: pod-reader-binding
  namespace: production
subjects:
- kind: User
  name: developer
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

**What this does:**
- Assigns pod-reader role
- To developer user
- In production namespace

**Think of it as:** Assign access. User gets permissions. Access granted.

## Real-World Example: Complete RBAC

**Step 1: Create Role:**
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: app-developer
  namespace: production
rules:
- apiGroups: [""]
  resources: ["pods", "services"]
  verbs: ["get", "list", "create", "update", "patch"]
- apiGroups: ["apps"]
  resources: ["deployments"]
  verbs: ["get", "list", "create", "update", "patch"]
```

**Step 2: Create RoleBinding:**
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: app-developer-binding
  namespace: production
subjects:
- kind: User
  name: developer@example.com
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: app-developer
  apiGroup: rbac.authorization.k8s.io
```

**Step 3: Verify:**
```bash
kubectl auth can-i create pods --namespace=production --as=developer@example.com
# yes
```

**That's complete RBAC. Working. Secure.**

## My Take: RBAC Strategy

**Here's what I do:**

**Principle of least privilege:**
- Minimum permissions needed
- Don't over-grant
- Security first

**Organize by role:**
- Developer role
- Admin role
- Viewer role
- Clear roles

**The key:** Least privilege. Clear roles. Regular review. Essential.

## Memory Tip: The Hotel Access Control Analogy

**RBAC = Hotel access control**

**Role:** Access level
**RoleBinding:** Assign access
**Rules:** What can do

**Once you see it this way, RBAC makes perfect sense.**

## Common Mistakes

1. **Too much access**: Security risk
2. **No RBAC**: Everyone has access
3. **Not reviewing**: Stale permissions
4. **Wrong scope**: Namespace vs cluster
5. **Not testing**: Don't know if works

## Key Takeaways

1. **RBAC controls access** - Who can do what
2. **Roles define permissions** - What can do
3. **Bindings assign roles** - Who gets access
4. **Principle of least privilege** - Minimum needed
5. **Essential for security** - Can't work without

## What's Next?

Now that you understand RBAC, you've completed the RBAC module. Next: [Understanding Helm](/docs/kubernetes/15-helm/understanding-helm).

---

> **Remember**: RBAC is like hotel access control. Roles define permissions. Bindings assign roles. Principle of least privilege. Essential for security.

