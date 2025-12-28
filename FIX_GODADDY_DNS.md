# Fix GoDaddy DNS - Point to GitHub Pages

## 🔍 Current Issue

Your DNS is partially configured:
- ✅ `www.devopsengineers.in` → Correctly points to GitHub Pages
- ❌ `devopsengineers.in` (root) → Points to GoDaddy IPs (3.33.130.190, 15.197.148.33)

This is why you're seeing the GoDaddy landing page instead of your site.

## ✅ Solution: Update DNS at GoDaddy

### Step 1: Log into GoDaddy

1. Go to: https://www.godaddy.com
2. Log in to your account
3. Go to **My Products** → **Domains**
4. Click on **devopsengineers.in**
5. Click **DNS** or **Manage DNS**

### Step 2: Remove/Update A Records

Find the A records for the root domain (`@` or `devopsengineers.in`):

**Current (WRONG):**
```
Type: A
Name: @
Value: 3.33.130.190
Value: 15.197.148.33
```

**Update to (CORRECT):**
```
Type: A
Name: @
Value: 185.199.108.153
Value: 185.199.109.153
Value: 185.199.110.153
Value: 185.199.111.153
```

**Action:**
1. Delete the existing A records with GoDaddy IPs
2. Add 4 new A records with GitHub Pages IPs (one for each IP)
3. Save changes

### Step 3: Verify CNAME for www

Make sure `www` CNAME exists:
```
Type: CNAME
Name: www
Value: vellankikoti.github.io
```

This should already be correct based on DNS check.

### Step 4: Disable GoDaddy Hosting (Important!)

If GoDaddy hosting is enabled, it will interfere:

1. In GoDaddy dashboard, go to **My Products**
2. Look for **Web Hosting** or **Website Builder**
3. If you see hosting for `devopsengineers.in`, **disable or remove it**
4. Or go to **DNS Settings** and make sure no hosting services are active

### Step 5: Wait for DNS Propagation

After updating DNS:
- Wait **15-60 minutes** for changes to propagate
- Check DNS: `dig devopsengineers.in +short`
- Should return: `185.199.108.153` (or similar GitHub Pages IPs)

### Step 6: Verify in GitHub Pages

1. Go to: https://github.com/vellankikoti/devops-learning-platform/settings/pages
2. Make sure custom domain shows: `devopsengineers.in`
3. Check "Enforce HTTPS" (after DNS propagates)
4. Save

## 📋 DNS Records Summary

Your final DNS configuration should be:

```
Root Domain (devopsengineers.in):
Type: A
Name: @
Value: 185.199.108.153
Value: 185.199.109.153
Value: 185.199.110.153
Value: 185.199.111.153

WWW Subdomain:
Type: CNAME
Name: www
Value: vellankikoti.github.io
```

## ✅ Verification

After DNS updates:

```bash
# Check root domain
dig devopsengineers.in +short
# Should return: 185.199.108.153 (GitHub Pages IPs)

# Check www subdomain
dig www.devopsengineers.in +short
# Should return: vellankikoti.github.io

# Test site
curl -I https://devopsengineers.in
# Should return: HTTP/2 200 (not GoDaddy page)
```

## 🚨 Common GoDaddy Issues

### Issue 1: GoDaddy Parking Page
- **Solution**: Disable domain parking in GoDaddy settings

### Issue 2: GoDaddy Website Builder Active
- **Solution**: Disable or remove Website Builder for this domain

### Issue 3: DNS Not Updating
- **Solution**: Clear DNS cache, wait longer (up to 48 hours)

### Issue 4: HTTPS Not Working
- **Solution**: After DNS propagates, enable "Enforce HTTPS" in GitHub Pages settings

---

**After updating DNS at GoDaddy, your site should work at https://devopsengineers.in!** ✅

