---
sidebar_position: 4
title: TLS Termination
---

# TLS Termination: SSL/TLS at the Entrance

**TLS termination is like SSL/TLS at hotel entrance. Encrypts traffic. Validates certificates. Secure communication. That's TLS termination.**

## 🎯 The Big Picture

Think of TLS termination like SSL/TLS at hotel entrance. Guest arrives with encrypted connection (HTTPS). Entrance decrypts (TLS termination). Routes to service (HTTP). That's TLS termination.

**TLS termination handles SSL/TLS at Ingress. Decrypts HTTPS. Routes HTTP internally. Certificate management. Essential for security.**

## The Entrance Security Analogy

**Think of TLS termination like entrance security:**

**HTTPS request:** Encrypted connection
- Guest arrives encrypted
- Secure connection
- Certificate validated

**TLS termination:** Decryption at entrance
- Entrance decrypts
- Validates certificate
- Secure processing

**HTTP to service:** Internal routing
- Routes HTTP internally
- No encryption needed
- Faster

**Once you see it this way, TLS termination makes perfect sense.**

## What is TLS Termination?

**TLS termination:**
- SSL/TLS at Ingress
- Decrypts HTTPS
- Routes HTTP internally
- Certificate management

**Think of it as:** Entrance security. Decrypts. Routes. Secure.

## Why TLS Termination?

**Problems without TLS:**
- Unencrypted traffic
- Security risk
- No certificate validation
- Insecure

**Solutions with TLS:**
- Encrypted traffic
- Secure communication
- Certificate validation
- Secure

**Real example:** I once ran HTTP only. Security risk. With TLS, encrypted. Secure. Never going back.

**TLS termination isn't optional. It's essential.**

## TLS Configuration

**Basic TLS Ingress:**
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: tls-ingress
spec:
  ingressClassName: nginx
  tls:
  - hosts:
    - hotel.example.com
    secretName: hotel-tls
  rules:
  - host: hotel.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: hotel-service
            port:
              number: 80
```

**What this does:**
- Enables TLS for hotel.example.com
- Uses certificate from secret
- HTTPS access

**Think of it as:** Entrance security. Certificate. HTTPS.

## Creating TLS Secret

**Create certificate secret:**
```bash
# Create TLS secret
kubectl create secret tls hotel-tls \
  --cert=tls.crt \
  --key=tls.key
```

**Or from files:**
```bash
kubectl create secret tls hotel-tls \
  --cert=path/to/cert.crt \
  --key=path/to/cert.key
```

**Think of it as:** Security certificate. Store in safe (secret).

## Let's Encrypt Integration

**Automatic certificates:**

**Using cert-manager:**
```yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: hotel-cert
spec:
  secretName: hotel-tls
  issuerRef:
    name: letsencrypt-prod
    kind: ClusterIssuer
  dnsNames:
  - hotel.example.com
```

**Why:**
- Automatic certificates
- Free
- Auto-renewal
- Production-ready

**Think of it as:** Automatic security certificate. Free. Auto-renewal.

## Complete TLS Setup

**Production-ready TLS:**
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: production-tls
  namespace: production
  annotations:
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
spec:
  ingressClassName: nginx
  tls:
  - hosts:
    - hotel.example.com
    - api.hotel.example.com
    secretName: hotel-tls
  rules:
  - host: hotel.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: hotel-service
            port:
              number: 80
  - host: api.hotel.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: api-service
            port:
              number: 80
```

**What this provides:**
- TLS for all hosts
- SSL redirect
- Automatic certificates
- Production-ready

**That's complete TLS setup. Production-ready.**

## Real-World Example: Complete TLS

**Step 1: Install cert-manager:**
```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.0/cert-manager.yaml
```

**Step 2: Create ClusterIssuer:**
```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: admin@example.com
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
    - http01:
        ingress:
          class: nginx
```

**Step 3: Create Ingress with TLS:**
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: hotel-tls
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
spec:
  ingressClassName: nginx
  tls:
  - hosts:
    - hotel.example.com
    secretName: hotel-tls
  rules:
  - host: hotel.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: hotel-service
            port:
              number: 80
```

**Step 4: Verify:**
```bash
kubectl get certificate
kubectl describe certificate hotel-tls
```

**Step 5: Test:**
```bash
curl https://hotel.example.com
```

**That's complete TLS. Automatic. Secure.**

## My Take: TLS Strategy

**Here's what I do:**

**Production:**
- Always use TLS
- Automatic certificates (cert-manager)
- SSL redirect
- Strong ciphers

**Development:**
- TLS optional
- Self-signed certificates
- Or HTTP

**The key:** Always use TLS in production. Automatic certificates. Secure.

## Memory Tip: The Entrance Security Analogy

**TLS termination = Entrance security**

**HTTPS:** Encrypted connection
**TLS termination:** Decryption
**Certificate:** Security certificate
**HTTP internally:** Unencrypted routing

**Once you see it this way, TLS termination makes perfect sense.**

## Common Mistakes

1. **Not using TLS**: Security risk
2. **Wrong certificate**: Doesn't match host
3. **Not configuring redirect**: HTTP still accessible
4. **Certificate expiration**: Not renewing
5. **Not using cert-manager**: Manual certificate management

## Key Takeaways

1. **TLS termination at Ingress** - Decrypts HTTPS
2. **Certificates in secrets** - Secure storage
3. **Use cert-manager** - Automatic certificates
4. **SSL redirect** - Force HTTPS
5. **Always use TLS in production** - Essential for security

## What's Next?

Now that you understand TLS termination, let's learn about Ingress troubleshooting. Next: [Ingress Troubleshooting](/docs/kubernetes/07-ingress/ingress-troubleshooting).

---

> **Remember**: TLS termination is like entrance security. Encrypts traffic. Validates certificates. Secure communication. Always use in production. Automatic certificates.

