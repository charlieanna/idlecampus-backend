# Enhance Networking Chapters 24-27 (Batch 2)

puts "Enhancing Networking Chapters 24-27..."
puts "=" * 80

# Chapter 24: Bridge Networks Deep Dive
puts "\nChapter 24: Bridge Networks In-Depth"
unit = InteractiveLearningUnit.find_by!(slug: "codesprout-bridge-network-deep-dive")
unit.update!(
  concept_explanation: <<-'MARKDOWN',
**Bridge Networks In-Depth** 🌉

Bridge networks are the most common Docker network type - essential for DCA!

### What is a Bridge Network?

**A software bridge** that allows containers connected to it to communicate, while isolating them from containers not on the bridge.

**Think of it as:**
- A virtual switch connecting containers
- Private network on your host
- Containers get private IPs (e.g., 172.17.0.x)

### Default Bridge vs Custom Bridge

**Default bridge (docker0):**
```bash
docker run -d --name web1 nginx
# Automatically connected to default bridge
```

**Limitations:**
- ❌ No automatic DNS resolution
- ❌ Must use --link (deprecated)
- ❌ All containers share same subnet
- ❌ Less isolation

**Custom bridge:**
```bash
docker network create my-bridge
docker run -d --name web1 --network my-bridge nginx
```

**Benefits:**
- ✅ Automatic DNS resolution
- ✅ Better isolation
- ✅ Configure subnet, gateway
- ✅ Control which containers communicate

### How Bridge Networks Work

**Under the hood:**
```
Host Network
    |
[docker0 bridge] ← Default bridge (172.17.0.0/16)
    |
    ├─ container1 (172.17.0.2)
    ├─ container2 (172.17.0.3)

[br-abc123] ← Custom bridge (172.18.0.0/16)
    |
    ├─ container3 (172.18.0.2)
    ├─ container4 (172.18.0.3)
```

**NAT (Network Address Translation):**
- Containers have private IPs
- Host translates to public IP for external access
- Port mapping required for inbound connections

### DNS Resolution

**Default bridge - NO DNS:**
```bash
docker run -d --name db postgres
docker run -it --name app alpine sh

# Inside app container:
ping db  # ❌ Fails! No DNS resolution
ping 172.17.0.2  # ✓ Works if you know the IP
```

**Custom bridge - Automatic DNS:**
```bash
docker network create my-network
docker run -d --name db --network my-network postgres
docker run -it --name app --network my-network alpine sh

# Inside app container:
ping db  # ✅ Works! Automatic DNS
```

### Port Mapping with Bridges

**Without port mapping:**
```bash
docker run -d --name nginx nginx:alpine
# Accessible from other containers on same network
# NOT accessible from host or external
```

**With port mapping:**
```bash
docker run -d -p 8080:80 --name nginx nginx:alpine
# Accessible from host at localhost:8080
# Accessible from external at host-ip:8080
```

### Creating Custom Bridge Networks

**Basic:**
```bash
docker network create my-app-network
```

**With custom subnet:**
```bash
docker network create \
  --driver bridge \
  --subnet=172.25.0.0/16 \
  --gateway=172.25.0.1 \
  my-app-network
```

**With IP range:**
```bash
docker network create \
  --driver bridge \
  --subnet=172.25.0.0/16 \
  --ip-range=172.25.5.0/24 \
  my-app-network
# Dynamic IPs assigned from 172.25.5.0-172.25.5.255
```

### DCA Exam Focus

**You must know:**
1. **Default bridge** has NO DNS resolution
2. **Custom bridge** has automatic DNS
3. **Bridge networks** are for single-host only
4. **NAT** translates private to public IPs
5. **Port mapping** required for external access

### Inspecting Bridge Networks

**View bridge config:**
```bash
docker network inspect bridge
```

**Key information:**
- Subnet
- Gateway
- Connected containers
- IP addresses

**View all bridges on host:**
```bash
# On Linux
ip link show type bridge

# or
brctl show
```

### Bridge Network Drivers

**Default driver:**
```bash
docker network ls --filter driver=bridge
```

**Bridge driver features:**
- Single-host networking
- Container isolation
- Port mapping support
- Custom subnets

### Common Patterns

**Pattern 1: Application stack**
```bash
docker network create app-network

docker run -d --name postgres \
  --network app-network \
  postgres:15

docker run -d --name redis \
  --network app-network \
  redis:alpine

docker run -d --name api \
  --network app-network \
  -p 3000:3000 \
  myapi:latest

# API can reach postgres and redis by name!
```

**Pattern 2: Development environment**
```bash
docker network create dev-network

# Database
docker run -d --name dev-db \
  --network dev-network \
  -e POSTGRES_PASSWORD=dev \
  postgres:15

# App with code mounted
docker run -it --name dev-app \
  --network dev-network \
  -v $(pwd):/app \
  -p 3000:3000 \
  node:18 bash

# Can connect to dev-db from app!
```

### Try it!

```bash
# Create custom bridge
docker network create test-bridge \
  --subnet=172.30.0.0/16 \
  --gateway=172.30.0.1

# Run containers
docker run -d --name web1 --network test-bridge nginx:alpine
docker run -d --name web2 --network test-bridge nginx:alpine

# Test DNS
docker run -it --name tester --network test-bridge alpine sh
# Inside container:
ping web1  # Works!
ping web2  # Works!
nslookup web1  # Shows IP

# Inspect
docker network inspect test-bridge

# Clean up
exit
docker rm -f web1 web2 tester
docker network rm test-bridge
```
  MARKDOWN
  command_to_learn: "Bridge network concepts",
  command_variations: ["docker network create --driver bridge", "docker network inspect bridge", "docker run --network bridge-name"],
  practice_hints: [
    "Default bridge has no DNS resolution, custom bridges do",
    "Bridge networks are for single-host container communication",
    "Port mapping (-p) required for external access to containers",
    "Custom bridges provide better isolation than default bridge"
  ]
)
puts "✅ Chapter 24 enhanced"

# Chapter 25: Host and None Networks
puts "\nChapter 25: Host and None Network Modes"
unit = InteractiveLearningUnit.find_by!(slug: "codesprout-host-none-networks")
unit.update!(
  concept_explanation: <<-'MARKDOWN',
**Host and None Network Modes** 🚫

Special network modes for performance and isolation - important for DCA!

### The host Network

**Container shares the host's network namespace.**

**Syntax:**
```bash
docker run --network host nginx
```

**How it works:**
- NO network isolation
- Container uses host's network directly
- Ports bind directly to host
- No port mapping needed (-p flag ignored!)

### Host Network Benefits and Limitations

**✅ Benefits:**
- **Maximum performance** (no NAT overhead)
- **Simplicity** (no port mapping)
- **Direct access** to host network interfaces

**❌ Limitations:**
- **No port conflict protection** (port 80 can only be used once)
- **No isolation** (security concern)
- **Can't run multiple instances** of same service
- **Not portable** between hosts

### Host Network Example

**Bridge network (typical):**
```bash
docker run -d -p 8080:80 nginx
# Nginx listens on port 80 INSIDE container
# Port 8080 on host maps to port 80 in container
curl localhost:8080  # Works
```

**Host network:**
```bash
docker run -d --network host nginx
# Nginx listens directly on host's port 80
# No port mapping needed or possible
curl localhost:80  # Works (direct access)
```

**Port conflict:**
```bash
docker run -d --network host nginx  # Listens on port 80
docker run -d --network host nginx  # ❌ FAILS! Port 80 already in use
```

### When to Use Host Network

**✅ Use when:**
- Need maximum network performance
- Container needs to see host network interfaces
- Simplifying network stack
- Testing/debugging

**❌ Don't use when:**
- Need container isolation
- Running multiple instances
- Portability across hosts matters
- Security is a concern

### The none Network

**Container has NO network interface** (except loopback).

**Syntax:**
```bash
docker run --network none nginx
```

**How it works:**
- Completely isolated
- No external network access
- Only loopback interface (127.0.0.1)
- Maximum security

### None Network Use Cases

**✅ Use when:**
- Maximum isolation needed
- Processing sensitive data
- No network access required
- Custom network configuration needed
- Batch jobs with no external communication

**Example:**
```bash
# Run data processing job with no network
docker run --network none \
  -v /data:/data \
  data-processor:latest
# Can access mounted volumes
# Cannot access network
```

### Comparing Network Modes

**Bridge (default):**
```bash
docker run -d -p 8080:80 nginx
```
- Isolated network
- Port mapping required
- Container-to-container communication
- Most common mode

**Host:**
```bash
docker run -d --network host nginx
```
- Shares host network
- No port mapping
- Maximum performance
- No isolation

**None:**
```bash
docker run -d --network none nginx
```
- No network access
- Maximum isolation
- For security/batch jobs

### DCA Exam Focus

**You must know:**
1. **--network host** shares host's network (no isolation)
2. **--network none** disables networking (max isolation)
3. **-p flag ignored** with host network
4. **host mode** = best performance, worst isolation
5. **none mode** = no network, max security

### Host Network in Detail

**Check network namespaces:**
```bash
# Bridge mode container
docker run --rm -it alpine ip addr
# Shows: eth0@ifXX (virtual ethernet)

# Host mode container
docker run --rm -it --network host alpine ip addr
# Shows: same interfaces as host!
```

**Performance difference:**
```bash
# Bridge mode (with NAT)
docker run --rm -p 5000:5000 benchmark-server
# ~100k requests/sec

# Host mode (no NAT)
docker run --rm --network host benchmark-server
# ~150k requests/sec (50% faster!)
```

### None Network in Detail

**What's available:**
```bash
docker run --rm -it --network none alpine sh

# Inside container:
ip addr
# Shows only loopback (127.0.0.1)

ping google.com
# ❌ Network is unreachable

ping 127.0.0.1
# ✓ Works (loopback only)
```

**Adding custom network later:**
```bash
# Start with none
docker run -d --name isolated --network none alpine sleep 1000

# Add custom network later
docker network create custom-network
docker network connect custom-network isolated

# Now has network access!
```

### Common Patterns

**Pattern 1: High-performance proxy**
```bash
# HAProxy in host mode for max performance
docker run -d \
  --name haproxy \
  --network host \
  -v $(pwd)/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro \
  haproxy:latest
# Directly uses host ports 80/443
```

**Pattern 2: Secure data processing**
```bash
# Process sensitive data with no network
docker run --rm \
  --network none \
  -v /secure-data:/data:ro \
  -v /output:/output \
  data-sanitizer:latest
# Can read/write volumes
# Cannot leak data over network
```

**Pattern 3: Network monitoring**
```bash
# Monitor all host network traffic
docker run -d \
  --name monitor \
  --network host \
  --cap-add NET_ADMIN \
  network-monitor:latest
# Sees all network interfaces
```

### Try it!

**Test host network:**
```bash
# Start nginx on host network
docker run -d --name nginx-host --network host nginx:alpine

# Check it's on host's port 80 directly
curl localhost:80

# Try to start another (will fail)
docker run -d --name nginx-host2 --network host nginx:alpine
# Error: port 80 already in use

# Clean up
docker rm -f nginx-host nginx-host2
```

**Test none network:**
```bash
# Start container with no network
docker run -it --name isolated --network none alpine sh

# Inside container:
ping google.com  # Fails - no network
ping 127.0.0.1   # Works - loopback only
ls /              # Works - filesystem accessible

exit

# Clean up
docker rm isolated
```
  MARKDOWN
  command_to_learn: "docker run --network host/none",
  command_variations: ["docker run --network host", "docker run --network none", "docker network connect NETWORK CONTAINER"],
  practice_hints: [
    "host mode shares host's network - maximum performance, no isolation",
    "none mode disables networking - maximum isolation, no external access",
    "-p port mapping is ignored in host network mode",
    "Use host mode for performance, none mode for security"
  ]
)
puts "✅ Chapter 25 enhanced"

puts "\n" + "=" * 80
puts "✅ Networking batch 2 complete (Chapters 24-25)"
puts "Continue with final networking chapters..."
