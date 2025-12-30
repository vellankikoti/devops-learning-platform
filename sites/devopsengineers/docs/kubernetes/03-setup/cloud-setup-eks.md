---
sidebar_position: 4
title: Cloud Setup with EKS
---

# Cloud Setup with EKS: AWS Luxury Hotel

**EKS is AWS's managed Kubernetes. Like a luxury hotel. Managed. High availability. Production-ready. That's EKS.**

## 🎯 The Big Picture

Think of EKS like a luxury hotel managed by AWS. You don't manage the hotel. AWS does. High availability. Production-ready. That's EKS.

**EKS (Elastic Kubernetes Service) is AWS's managed Kubernetes. Control plane managed by AWS. You manage worker nodes. Production-ready.**

## Why EKS?

**Perfect for:**
- Production workloads
- AWS ecosystem
- High availability
- Enterprise needs

**Why:**
- Managed control plane
- AWS integration
- High availability
- Production-ready

**Think of it as:** AWS luxury hotel. Managed. High availability. Production.

## Prerequisites

**What you need:**
- AWS account
- AWS CLI installed
- kubectl installed
- eksctl (recommended) or AWS Console

**Install eksctl:**
```bash
# macOS
brew install eksctl

# Linux
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
```

**Verify:**
```bash
eksctl version
```

## Creating EKS Cluster

### Using eksctl (Recommended)

**Create cluster:**
```bash
eksctl create cluster \
  --name my-hotel-cluster \
  --region us-east-1 \
  --nodegroup-name workers \
  --node-type t3.medium \
  --nodes 3 \
  --nodes-min 2 \
  --nodes-max 5
```

**What happens:**
- Creates VPC
- Creates control plane
- Creates worker nodes
- Configures kubectl

**Takes 15-20 minutes. Be patient.**

### Using AWS Console

**Step 1: Create cluster**
- Go to EKS console
- Click "Create cluster"
- Configure cluster
- Create

**Step 2: Create node group**
- Go to cluster
- Add node group
- Configure nodes
- Create

**Step 3: Configure kubectl**
```bash
aws eks update-kubeconfig --name my-hotel-cluster --region us-east-1
```

## The AWS Luxury Hotel Analogy

**Think of EKS like AWS luxury hotel:**

**AWS manages:** Hotel management (control plane)
- You don't manage it
- AWS handles it
- High availability

**You manage:** Hotel floors (worker nodes)
- You configure them
- You scale them
- You maintain them

**Integration:** Hotel services (AWS services)
- IAM for security
- VPC for networking
- CloudWatch for monitoring

**Once you see it this way, EKS makes perfect sense.**

## Verifying Setup

**Check cluster:**
```bash
kubectl get nodes
```

**Expected output:**
```
NAME                                           STATUS   ROLES    AGE   VERSION
ip-192-168-1-100.us-east-1.compute.internal   Ready    <none>   5m    v1.28.0
ip-192-168-1-101.us-east-1.compute.internal   Ready    <none>   5m    v1.28.0
ip-192-168-1-102.us-east-1.compute.internal   Ready    <none>   5m    v1.28.0
```

**Check cluster info:**
```bash
kubectl cluster-info
```

**Check AWS integration:**
```bash
kubectl get configmap aws-auth -n kube-system
```

**That's verification. Everything working.**

## Node Groups

**What they are:**
- Groups of worker nodes
- Same instance type
- Same configuration
- Auto-scaling

**Create node group:**
```bash
eksctl create nodegroup \
  --cluster=my-hotel-cluster \
  --name=workers \
  --node-type=t3.large \
  --nodes=3 \
  --nodes-min=2 \
  --nodes-max=10
```

**Think of it as:** Hotel floor types. Standard rooms. Suite rooms. Different configurations.

## Auto-Scaling

**Enable cluster autoscaler:**
```bash
# Install cluster autoscaler
kubectl apply -f https://raw.githubusercontent.com/kubernetes/autoscaler/master/cluster-autoscaler/cloudprovider/aws/examples/cluster-autoscaler-autodiscover.yaml

# Annotate deployment
kubectl annotate deployment cluster-autoscaler \
  -n kube-system \
  cluster-autoscaler.kubernetes.io/safe-to-evict="false"
```

**Think of it as:** Automatic room capacity. Scales up when busy. Scales down when quiet.

## Real-World Example: Production EKS Setup

**Complete production setup:**

**Step 1: Create cluster:**
```bash
eksctl create cluster \
  --name production-hotel \
  --region us-east-1 \
  --version 1.28 \
  --nodegroup-name workers \
  --node-type t3.large \
  --nodes 3 \
  --nodes-min 2 \
  --nodes-max 10 \
  --managed
```

**Step 2: Configure kubectl:**
```bash
aws eks update-kubeconfig --name production-hotel --region us-east-1
```

**Step 3: Verify:**
```bash
kubectl get nodes
kubectl cluster-info
```

**Step 4: Deploy application:**
```bash
kubectl create deployment my-app --image=my-app:1.0
kubectl expose deployment my-app --port=80 --type=LoadBalancer
```

**That's production EKS. Complete. Ready.**

## Cost Considerations

**EKS costs:**
- Control plane: $0.10/hour (~$73/month)
- Worker nodes: EC2 instance costs
- Data transfer: AWS data transfer costs

**Optimization:**
- Use spot instances
- Right-size nodes
- Use Fargate (serverless)
- Monitor costs

**Think of it as:** Hotel costs. Management fee. Room costs. Services costs.

## My Take: EKS Strategy

**Here's what I do:**

**Production:**
- Use EKS
- Managed control plane
- Auto-scaling nodes
- High availability

**Development:**
- Use local (minikube/kind)
- Or EKS dev cluster
- Cost-effective

**The key:** Use EKS for production. Local for development. Right tool for job.

## Memory Tip: The AWS Luxury Hotel Analogy

**EKS = AWS luxury hotel**

**AWS manages:** Hotel management
**You manage:** Hotel floors
**Integration:** Hotel services

**Once you see it this way, EKS makes perfect sense.**

## Common Mistakes

1. **Not configuring kubectl**: Can't access cluster
2. **Wrong region**: Cluster in wrong region
3. **No node groups**: No worker nodes
4. **Not monitoring costs**: Unexpected bills
5. **No auto-scaling**: Manual scaling

## Key Takeaways

1. **EKS is managed Kubernetes** - AWS manages control plane
2. **You manage worker nodes** - Configure and scale
3. **High availability** - Production-ready
4. **AWS integration** - IAM, VPC, CloudWatch
5. **Cost considerations** - Control plane + nodes

## What's Next?

Congratulations! You've completed the Setting Up Cluster module. Now let's learn about pods. Next: [Understanding Pods](/docs/kubernetes/04-pods/understanding-pods).

---

> **Remember**: EKS is like AWS luxury hotel. Managed control plane. You manage nodes. High availability. Production-ready. Right for production workloads.

