# Enhance Security Chapters 50-54 (FINAL CHAPTERS!)

puts "=" * 80
puts "Enhancing Security Chapters 50-54 (FINAL CHAPTERS!)..."
puts "=" * 80

security_chapters = [
  {
    slug: "codesprout-docker-content-trust",
    num: 50,
    command: "DOCKER_CONTENT_TRUST=1",
    title: "Docker Content Trust (DCT)",
    content: <<-'MD'
**Docker Content Trust (DCT)** 🔒

Image verification is critical for security - important for DCA exam!

### What is Docker Content Trust?

**Cryptographic signature verification for images:**
- Ensures image integrity
- Verifies publisher identity
- Prevents tampering
- Man-in-the-middle protection

**Based on:** Notary (CNCF project) and TUF (The Update Framework)

### Enabling DCT

**Enable globally:**
```bash
export DOCKER_CONTENT_TRUST=1
```

**Now all pulls/pushes require signatures:**
```bash
docker pull nginx
# ✓ Verifies signature before pulling
# ❌ Fails if image not signed
```

**Disable for one command:**
```bash
DOCKER_CONTENT_TRUST=0 docker pull unsigned-image
```

### Signing Images

**First push with DCT:**
```bash
export DOCKER_CONTENT_TRUST=1
docker push myregistry/myapp:1.0
```

**Prompts for passphrases:**
1. Root key (offline key) - Generate once, keep safe
2. Repository key - Per-repository signing

**Keys stored in:** `~/.docker/trust/`

### Verifying Signed Images

**Pull signed image:**
```bash
export DOCKER_CONTENT_TRUST=1
docker pull myregistry/myapp:1.0
```

**Output:**
```
Pull (1 of 1): myregistry/myapp:1.0@sha256:abc123...
Tagging myregistry/myapp:1.0@sha256:abc123... as myregistry/myapp:1.0
```

**If signature invalid or missing:**
```
Error: remote trust data does not exist
```

### DCA Exam Focus

Must know:
1. **DOCKER_CONTENT_TRUST=1** enables verification
2. **Requires signed images** to pull/push
3. **Root key vs repository key**
4. **Notary** is the backend service
5. **Docker Hub** supports DCT

### Key Management

**Root key (offline key):**
- Generated once
- Keep offline/secure
- Needed to add new repositories

**Repository key:**
- Per repository
- Used for daily signing
- Can be rotated

**Backup keys:**
```bash
# Keys in:
~/.docker/trust/private/
~/.docker/trust/tuf/

# Backup securely!
```

### Rotating Keys

**Rotate repository key:**
```bash
docker trust key rotate myregistry/myapp
```

**Requires root key passphrase**

### Delegation Keys

**Delegate signing to others:**
```bash
docker trust signer add --key key.pub alice myregistry/myapp
```

**Alice can now sign:**
```bash
docker trust sign myregistry/myapp:2.0
```

### Try it!

```bash
# Enable DCT
export DOCKER_CONTENT_TRUST=1

# Try pulling unsigned image (will fail)
docker pull untrusted/image  # Likely fails

# Pull official signed image
docker pull library/nginx:alpine  # Works (Docker official images are signed)

# Disable DCT
export DOCKER_CONTENT_TRUST=0
```
    MD
  },
  {
    slug: "codesprout-security-scanning",
    num: 51,
    command: "docker scan",
    title: "Image Security Scanning",
    content: <<-'MD'
**Image Security Scanning** 🔍

Vulnerability scanning is essential for secure containerized applications!

### docker scan

**Scan image for vulnerabilities:**
```bash
docker scan nginx:latest
```

**Output:**
```
Testing nginx:latest...

✗ Low severity vulnerability found in openssl
  Description: CVE-2021-XXXX
  Info: https://security.alpinelinux.org/...
  Introduced through: openssl@1.1.1k-r0

✗ High severity vulnerability found in nginx
  Description: CVE-2021-YYYY

✓ Tested 150 dependencies for known vulnerabilities
  Found 3 vulnerabilities
```

### Scanning Workflow

**Best practice:**
```bash
# 1. Build image
docker build -t myapp:1.0 .

# 2. Scan immediately
docker scan myapp:1.0

# 3. Fix vulnerabilities
# Update Dockerfile, rebuild

# 4. Scan again
docker scan myapp:1.0

# 5. Push when clean
docker push myapp:1.0
```

### Scan Options

**JSON output:**
```bash
docker scan --json myapp:1.0 > scan-results.json
```

**Filter by severity:**
```bash
docker scan --severity high myapp:1.0
# Only show high severity
```

**Scan Dockerfile:**
```bash
docker scan --file Dockerfile myapp:1.0
```

### Alternative Scanners

**Trivy (popular open-source):**
```bash
trivy image nginx:latest
```

**Clair:**
```bash
# Requires Clair server setup
clairctl analyze nginx:latest
```

**Anchore:**
```bash
anchore-cli image add nginx:latest
anchore-cli image vuln nginx:latest all
```

### DCA Exam Focus

Must know:
1. **docker scan** checks for vulnerabilities
2. **CVE database** is source of vulnerability data
3. **Severity levels:** Low, Medium, High, Critical
4. **Best practice:** Scan before pushing
5. **Regular scanning** of production images

### CI/CD Integration

**Fail build on high severity:**
```bash
# In CI pipeline:
docker build -t myapp:$VERSION .
docker scan --severity high myapp:$VERSION || exit 1
docker push myapp:$VERSION
```

### Remediation Strategies

**1. Update base image:**
```dockerfile
# Before:
FROM node:14

# After:
FROM node:18-alpine
# Newer version, fewer vulnerabilities
```

**2. Update packages:**
```dockerfile
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y package
```

**3. Multi-stage to reduce attack surface:**
```dockerfile
FROM node:18 AS builder
# Build dependencies

FROM node:18-alpine
COPY --from=builder /app/dist .
# Minimal runtime image
```

### Try it!

```bash
# Scan official image
docker scan nginx:latest

# Scan older version (likely more vulnerabilities)
docker scan nginx:1.20

# Compare Alpine (usually fewer vulnerabilities)
docker scan nginx:alpine
```
    MD
  },
  {
    slug: "codesprout-user-namespaces",
    num: 52,
    command: "User namespaces",
    title: "User Namespace Remapping",
    content: <<-'MD'
**User Namespace Remapping** 👤

User namespaces enhance container security by preventing root privilege escalation!

### The Problem

**By default:**
- Container root = Host root (same UID 0)
- Container escape = Full host access
- Security risk!

**Example:**
```bash
docker run -v /:/host alpine
# Inside container as root (UID 0)
# Can modify /host files as root!
```

### What are User Namespaces?

**Remap container users to unprivileged host users:**

```
Container UID    →    Host UID
0 (root)         →    100000
1                →    100001
1000             →    101000
```

**Container root = Unprivileged host user!**

### Enabling User Namespaces

**Configure daemon.json:**
```json
{
  "userns-remap": "default"
}
```

**Restart Docker:**
```bash
sudo systemctl restart docker
```

**Docker creates:**
- `dockremap` user/group
- Subordinate UID/GID ranges

### Custom User Mapping

**Create user:**
```bash
sudo useradd -r -s /bin/false dockremap
```

**Set subordinate ranges:**
```bash
# /etc/subuid
dockremap:100000:65536

# /etc/subgid
dockremap:100000:65536
```

**Configure daemon.json:**
```json
{
  "userns-remap": "dockremap"
}
```

### How It Works

**Without user namespaces:**
```bash
docker run alpine id
# uid=0(root) gid=0(root)
# Same as host root!
```

**With user namespaces:**
```bash
docker run alpine id
# uid=0(root) gid=0(root)  # Inside container

# But on host:
ps aux | grep sleep
# Shows: 100000 (unprivileged user)
```

### DCA Exam Focus

Must know:
1. **User namespaces** remap container users
2. **userns-remap** in daemon.json
3. **Container root ≠ host root**
4. **Security benefit:** Limits privilege escalation
5. **Storage drivers** may be affected

### Limitations

**Volume mounts:**
- File ownership may be incorrect
- Named volumes work better
- Bind mounts can have issues

**Networking:**
- Some drivers may not support it

**Existing containers:**
- Not compatible with pre-existing containers
- Must recreate after enabling

### Best Practices

**✅ DO:**
```bash
# Enable user namespaces for security
{
  "userns-remap": "default"
}

# Use named volumes
docker run -v mydata:/data app

# Run as non-root in Dockerfile
USER 1000
```

**❌ DON'T:**
```bash
# Don't run as root in containers
# Add USER directive:
USER appuser
```

### Try it!

**Without user namespaces:**
```bash
docker run -it alpine sh
# id
# uid=0(root)

# On host (different terminal):
ps aux | grep sh
# root ... /bin/sh
```

**With user namespaces (if enabled):**
```bash
docker run -it alpine sh
# id
# uid=0(root) gid=0(root)

# On host:
ps aux | grep sh
# 100000 ... /bin/sh  (remapped!)
```
    MD
  },
  {
    slug: "codesprout-resource-constraints",
    num: 53,
    command: "--memory --cpus",
    title: "Resource Limits and Constraints",
    content: <<-'MD'
**Resource Limits and Constraints** ⚙️

Resource limits prevent containers from consuming all host resources!

### Why Resource Limits?

**Without limits:**
- One container can use 100% CPU
- One container can use all RAM
- System becomes unresponsive
- Other containers starve

**With limits:**
- Fair resource sharing
- Prevent DoS
- Predictable performance

### Memory Limits

**Set memory limit:**
```bash
docker run -m 512m nginx
# Maximum 512MB RAM
```

**Memory + swap:**
```bash
docker run -m 512m --memory-swap 1g nginx
# 512MB RAM + 512MB swap = 1GB total
```

**No swap:**
```bash
docker run -m 512m --memory-swap 512m nginx
# Disable swap (memory-swap = memory)
```

### CPU Limits

**CPU shares (relative weight):**
```bash
docker run --cpu-shares 512 nginx
# Default is 1024
# Gets half the CPU time when competing
```

**CPU count:**
```bash
docker run --cpus 1.5 nginx
# Maximum 1.5 CPUs
```

**Specific CPUs:**
```bash
docker run --cpuset-cpus 0,1 nginx
# Only use CPUs 0 and 1
```

### Memory Behavior

**When limit exceeded:**
```bash
docker run -m 100m stress --vm 1 --vm-bytes 200M
# Container killed (OOM - Out Of Memory)
```

**Check if OOM killed:**
```bash
docker inspect CONTAINER | grep OOMKilled
```

### CPU Behavior

**When limit exceeded:**
```bash
docker run --cpus 1 stress --cpu 4
# Uses 100% of 1 CPU
# Other 3 CPU threads throttled
```

### DCA Exam Focus

Must know:
1. **-m or --memory** sets memory limit
2. **--cpus** sets CPU limit
3. **--cpu-shares** for relative weighting
4. **OOM killer** terminates on memory exceed
5. **CPU limits throttle**, don't kill

### Monitoring Resources

**View resource usage:**
```bash
docker stats
docker stats CONTAINER
```

**Output:**
```
CONTAINER   CPU %   MEM USAGE / LIMIT   MEM %   NET I/O
app         0.50%   100MB / 512MB       19.5%   1.2kB / 0B
```

### Swarm Resource Constraints

**Service with limits:**
```bash
docker service create \
  --name web \
  --limit-cpu 1 \
  --limit-memory 512M \
  nginx
```

**Reservations (guaranteed minimum):**
```bash
docker service create \
  --name db \
  --reserve-cpu 2 \
  --reserve-memory 1G \
  postgres
```

### Compose Resource Limits

```yaml
version: "3.8"
services:
  web:
    image: nginx
    deploy:
      resources:
        limits:
          cpus: '1.5'
          memory: 512M
        reservations:
          cpus: '0.5'
          memory: 256M
```

### Best Practices

**✅ DO:**
```bash
# Set memory limits for all containers
docker run -m 512m app

# Reserve resources for critical services
docker service create --reserve-memory 2G db

# Monitor resource usage
docker stats
```

**❌ DON'T:**
```bash
# Don't omit limits in production
docker run app  # Can use all system resources!

# Don't set limits too low
docker run -m 10m java-app  # Will OOM immediately
```

### Try it!

```bash
# Run with memory limit
docker run -m 100m --name limited alpine sleep 1000

# Check limit
docker inspect limited | grep Memory

# Monitor usage
docker stats limited

# Try to exceed (will be killed)
docker run -m 100m stress --vm 1 --vm-bytes 200M

# Clean up
docker rm -f limited
```
    MD
  },
  {
    slug: "codesprout-security-best-practices",
    num: 54,
    command: "Security checklist",
    title: "Docker Security Best Practices",
    content: <<-'MD'
**Docker Security Best Practices** ⭐

Comprehensive security checklist for production Docker environments!

### 1. Image Security

**✅ Use official images:**
```dockerfile
FROM nginx:alpine  # Official, maintained
```

**✅ Specify versions:**
```dockerfile
FROM node:18.16-alpine  # Not "latest"
```

**✅ Scan for vulnerabilities:**
```bash
docker scan myapp:1.0
```

**✅ Use minimal base images:**
```dockerfile
FROM alpine:3.18  # 5MB vs Ubuntu 77MB
```

### 2. Dockerfile Best Practices

**✅ Run as non-root:**
```dockerfile
RUN adduser -D appuser
USER appuser
```

**✅ Don't include secrets:**
```dockerfile
# ❌ BAD
ENV API_KEY=sk_live_abc123

# ✅ GOOD
# Use runtime secrets or config
```

**✅ Use .dockerignore:**
```
.git/
.env
secrets/
*.key
```

### 3. Runtime Security

**✅ Drop capabilities:**
```bash
docker run --cap-drop ALL --cap-add NET_BIND_SERVICE nginx
```

**✅ Read-only filesystem:**
```bash
docker run --read-only nginx
```

**✅ No privileged mode:**
```bash
# ❌ AVOID
docker run --privileged app

# ✅ Use specific capabilities instead
docker run --cap-add SYS_TIME app
```

### 4. Network Security

**✅ Use custom networks:**
```bash
docker network create app-network
# Better than default bridge
```

**✅ Isolate services:**
```bash
# Frontend network
# Backend network
# DB only on backend
```

**✅ Don't expose unnecessary ports:**
```dockerfile
# Document but don't publish
EXPOSE 8080
# Publish only what's needed at runtime
```

### 5. Resource Limits

**✅ Always set limits:**
```bash
docker run -m 512m --cpus 1 app
```

**✅ Prevent DoS:**
```bash
docker run \
  -m 256m \
  --memory-swap 256m \
  --pids-limit 100 \
  app
```

### 6. Logging and Monitoring

**✅ Centralized logging:**
```bash
docker run \
  --log-driver syslog \
  --log-opt syslog-address=udp://logs:514 \
  app
```

**✅ Monitor containers:**
```bash
docker stats
# Use Prometheus, Grafana, etc.
```

### 7. Secrets Management

**✅ Use Docker secrets (Swarm):**
```bash
docker secret create db_password password.txt
docker service create --secret db_password app
```

**✅ Never in environment variables:**
```bash
# ❌ BAD
docker run -e PASSWORD=secret app

# ✅ GOOD
docker run --secret PASSWORD app
```

### 8. Image Signing

**✅ Enable Content Trust:**
```bash
export DOCKER_CONTENT_TRUST=1
```

**✅ Only pull signed images:**
```bash
DOCKER_CONTENT_TRUST=1 docker pull trusted/image
```

### 9. Host Security

**✅ Keep Docker updated:**
```bash
docker version  # Check regularly
```

**✅ Configure daemon securely:**
```json
{
  "icc": false,
  "userns-remap": "default",
  "no-new-privileges": true
}
```

**✅ Use AppArmor/SELinux:**
```bash
docker run --security-opt apparmor=docker-default app
```

### 10. Access Control

**✅ Limit Docker socket access:**
```bash
# Don't mount Docker socket unless necessary
# ❌ DANGEROUS
docker run -v /var/run/docker.sock:/var/run/docker.sock app
```

**✅ Use TLS for remote API:**
```json
{
  "tls": true,
  "tlscert": "/path/to/cert.pem",
  "tlskey": "/path/to/key.pem"
}
```

### DCA Exam Focus

Must know:
1. **Run as non-root** in containers
2. **Resource limits** prevent DoS
3. **Content Trust** for image verification
4. **Secrets management** best practices
5. **Minimal base images** reduce attack surface
6. **Security scanning** before deployment
7. **Network isolation** between services
8. **No privileged containers** in production

### Security Checklist

**Before deployment:**
- [ ] Images scanned for vulnerabilities
- [ ] Running as non-root user
- [ ] Resource limits set
- [ ] Secrets managed properly
- [ ] Network isolation configured
- [ ] Logging enabled
- [ ] Content Trust enabled
- [ ] Unnecessary capabilities dropped
- [ ] Read-only filesystem (if possible)
- [ ] Health checks configured

### Try it!

**Secure container example:**
```bash
# Create network
docker network create secure-network

# Run with security best practices
docker run -d \
  --name secure-app \
  --network secure-network \
  --memory 512m \
  --cpus 1 \
  --read-only \
  --cap-drop ALL \
  --security-opt no-new-privileges=true \
  --health-cmd="curl -f http://localhost/ || exit 1" \
  --health-interval=30s \
  nginx:alpine

# Verify security settings
docker inspect secure-app | grep -A 10 Security

# Clean up
docker rm -f secure-app
docker network rm secure-network
```

### Production Hardening

**Complete hardened setup:**
```yaml
version: "3.8"
services:
  app:
    image: myapp:1.0
    read_only: true
    cap_drop:
      - ALL
    cap_add:
      - NET_BIND_SERVICE
    security_opt:
      - no-new-privileges:true
    deploy:
      resources:
        limits:
          cpus: '2'
          memory: 1G
        reservations:
          cpus: '1'
          memory: 512M
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost/health"]
      interval: 30s
      timeout: 3s
      retries: 3
    logging:
      driver: syslog
      options:
        syslog-address: "udp://logs:514"
```
    MD
  }
]

security_chapters.each do |ch|
  puts "\nChapter #{ch[:num]}: #{ch[:title]}"
  unit = InteractiveLearningUnit.find_by!(slug: ch[:slug])
  unit.update!(
    concept_explanation: ch[:content],
    command_to_learn: ch[:command],
    command_variations: ["DOCKER_CONTENT_TRUST=1", "docker scan IMAGE", "--cap-drop ALL", "-m MEMORY --cpus CPU"],
    practice_hints: [
      "Always run containers as non-root users in production",
      "Enable Docker Content Trust for image verification",
      "Set resource limits to prevent DoS attacks",
      "Scan images for vulnerabilities before deployment"
    ]
  )
  puts "✅ Enhanced"
end

puts "\n" + "=" * 80
puts "🎉🎉🎉 ALL SECURITY CHAPTERS COMPLETE (50-54)! 🎉🎉🎉"
puts "=" * 80
puts ""
puts "🚀 COMPLETE DCA CURRICULUM ENHANCED! 🚀"
puts "All 54 chapters from Foundation to Security are now DCA-exam-ready!"
puts "=" * 80
