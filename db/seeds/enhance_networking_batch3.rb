# Enhance Networking Chapters 26-27 (Batch 3 - Final)

puts "Enhancing Networking Chapters 26-27 (Final Networking Chapters)..."
puts "=" * 80

# Chapter 26: DNS and Service Discovery
puts "\nChapter 26: DNS and Service Discovery"
unit = InteractiveLearningUnit.find_by!(slug: "codesprout-network-dns-discovery")
unit.update!(
  concept_explanation: <<-'MARKDOWN',
**DNS and Service Discovery in Docker** 🔍

Automatic DNS is one of Docker's most powerful networking features - critical for DCA!

### Container DNS Resolution

**In custom bridge networks, containers can reach each other by name.**

**Example:**
```bash
docker network create my-network

docker run -d --name db --network my-network postgres:15
docker run -d --name api --network my-network myapi:latest

# Inside api container:
curl http://db:5432  # ✓ Resolves to db container's IP!
ping db              # ✓ Works!
```

### How Docker DNS Works

**Built-in DNS server:**
- Docker runs a DNS server at 127.0.0.11
- Automatically configured in containers
- Resolves container names to IPs
- Updates when containers start/stop

**Check DNS config:**
```bash
docker run --rm alpine cat /etc/resolv.conf
```

**Output:**
```
nameserver 127.0.0.11
options ndots:0
```

### Default Bridge vs Custom Bridge DNS

**❌ Default bridge (docker0):**
```bash
docker run -d --name web1 nginx
docker run -it --name test alpine sh

# Inside test:
ping web1  # ❌ FAILS! No DNS on default bridge
```

**✅ Custom bridge:**
```bash
docker network create my-network
docker run -d --name web1 --network my-network nginx
docker run -it --name test --network my-network alpine sh

# Inside test:
ping web1  # ✓ Works! Automatic DNS
```

### Network Aliases

**Add multiple DNS names to a container:**

**Using --network-alias:**
```bash
docker network create my-network

docker run -d --name postgres \
  --network my-network \
  --network-alias db \
  --network-alias database \
  postgres:15

# Now accessible as:
# - postgres (container name)
# - db (alias)
# - database (alias)
```

**Using --link (deprecated but on exam):**
```bash
# OLD WAY (don't use in production)
docker run --name db postgres
docker run --name web --link db:database nginx

# web can access db as "database"
```

### Service Discovery Patterns

**Pattern 1: Multiple replicas**
```bash
docker network create web-network

# Multiple web servers with same alias
docker run -d --name web1 \
  --network web-network \
  --network-alias webserver \
  nginx:alpine

docker run -d --name web2 \
  --network web-network \
  --network-alias webserver \
  nginx:alpine

# DNS returns all IPs (round-robin)
docker run --rm --network web-network alpine nslookup webserver
# Shows both IPs!
```

**Pattern 2: Service abstraction**
```bash
docker network create app-network

# Primary database
docker run -d --name postgres-primary \
  --network app-network \
  --network-alias db \
  postgres:15

# Application connects to "db"
docker run -d --name app \
  --network app-network \
  -e DB_HOST=db \
  myapp:latest

# Later: Switch to different database
docker stop postgres-primary
docker run -d --name mysql-primary \
  --network app-network \
  --network-alias db \
  mysql:8

# App automatically uses new database (same DNS name!)
```

### DCA Exam Focus

**You must know:**
1. **Custom bridge networks** have automatic DNS
2. **Default bridge** has NO DNS (use --link or custom network)
3. **--network-alias** adds additional DNS names
4. **DNS server** at 127.0.0.11 in containers
5. **Container name** = default hostname

### DNS Resolution Workflow

**When container pings another container:**

1. Container queries 127.0.0.11 (Docker's DNS)
2. Docker DNS checks if name is on same network
3. If yes: Returns container's IP
4. If no: Forwards to external DNS

**Example:**
```bash
docker run --rm --network my-network alpine sh

# Inside container:
ping other-container  # → Docker DNS → IP
ping google.com       # → Docker DNS → External DNS → IP
```

### Embedded DNS Server

**Docker's DNS features:**
- Container name resolution
- Network alias resolution
- Service discovery
- Round-robin load balancing (multiple aliases)
- Automatic updates (containers start/stop)

**Viewing DNS records:**
```bash
docker run --rm --network my-network alpine nslookup container-name
```

### External DNS Configuration

**Custom DNS servers:**
```bash
docker run --dns 8.8.8.8 --dns 8.8.4.4 alpine
# Uses Google DNS for external queries
```

**DNS search domains:**
```bash
docker run --dns-search example.com alpine
# Can ping "host" instead of "host.example.com"
```

**Configure in daemon.json:**
```json
{
  "dns": ["8.8.8.8", "8.8.4.4"],
  "dns-search": ["example.com"]
}
```

### Service Discovery in Swarm

**In Swarm mode, DNS provides:**
- Service name → VIP (Virtual IP)
- VIP load-balances to all replicas
- Automatic updates when scaling

**Example:**
```bash
docker service create --name web --replicas 3 nginx

# From any container in swarm:
curl http://web  # Automatically load-balanced to one of 3 replicas!
```

### Try it!

**Test DNS resolution:**
```bash
# Setup
docker network create test-network

docker run -d --name web \
  --network test-network \
  --network-alias www \
  --network-alias web-server \
  nginx:alpine

# Test DNS from another container
docker run --rm -it --network test-network alpine sh

# Inside container:
ping web         # Works (container name)
ping www         # Works (alias)
ping web-server  # Works (alias)
nslookup web     # Shows IP address
cat /etc/resolv.conf  # Shows 127.0.0.11

exit

# Clean up
docker rm -f web
docker network rm test-network
```

**Test round-robin DNS:**
```bash
docker network create lb-network

# Multiple containers with same alias
docker run -d --name web1 --network lb-network --network-alias web nginx:alpine
docker run -d --name web2 --network lb-network --network-alias web nginx:alpine
docker run -d --name web3 --network lb-network --network-alias web nginx:alpine

# Check DNS
docker run --rm --network lb-network alpine nslookup web
# Returns all 3 IPs!

# Clean up
docker rm -f web1 web2 web3
docker network rm lb-network
```
  MARKDOWN
  command_to_learn: "Container DNS resolution",
  command_variations: ["docker run --network-alias ALIAS", "docker run --dns IP", "nslookup container-name"],
  practice_hints: [
    "Custom bridge networks provide automatic DNS resolution",
    "Container name is the default hostname",
    "--network-alias adds additional DNS names",
    "Docker DNS server runs at 127.0.0.11 inside containers"
  ]
)
puts "✅ Chapter 26 enhanced"

# Chapter 27: Port Publishing Strategies
puts "\nChapter 27: Port Publishing Strategies"
unit = InteractiveLearningUnit.find_by!(slug: "codesprout-port-publishing-strategies")
unit.update!(
  concept_explanation: <<-'MARKDOWN',
**Port Publishing Strategies** 🔌

Understanding port mapping is essential for making containers accessible - critical for DCA!

### Why Port Publishing?

**Container ports are isolated by default:**
```bash
docker run -d --name nginx nginx:alpine
# Nginx runs on port 80 INSIDE container
# NOT accessible from host or external
```

**Must publish ports for external access:**
```bash
docker run -d -p 8080:80 --name nginx nginx:alpine
# Now accessible at localhost:8080
```

### The -p Flag (Publish Port)

**Basic syntax:**
```bash
-p HOST_PORT:CONTAINER_PORT
```

**Examples:**

**Map to specific host port:**
```bash
docker run -d -p 8080:80 nginx
# Host port 8080 → Container port 80
curl localhost:8080  # Works!
```

**Map to all interfaces:**
```bash
docker run -d -p 80:80 nginx
# All network interfaces on port 80
```

**Map to specific IP:**
```bash
docker run -d -p 127.0.0.1:8080:80 nginx
# Only accessible on localhost
# NOT accessible from external IPs
```

**Map specific IP and port:**
```bash
docker run -d -p 192.168.1.10:8080:80 nginx
# Only accessible on 192.168.1.10:8080
```

### The -P Flag (Publish All)

**Publishes ALL EXPOSE'd ports to random high ports:**

**Dockerfile:**
```dockerfile
FROM nginx:alpine
EXPOSE 80
```

**Run with -P:**
```bash
docker run -d -P nginx
# Docker assigns random port (e.g., 32768)
```

**Check assigned port:**
```bash
docker ps
# Shows: 0.0.0.0:32768->80/tcp

docker port container-name
# Shows: 80/tcp -> 0.0.0.0:32768
```

### Port Mapping Formats

**All variations:**
```bash
-p 80:80                    # All interfaces, port 80
-p 127.0.0.1:80:80          # Localhost only, port 80
-p 8080:80                  # Host 8080 → Container 80
-p 127.0.0.1::80            # Localhost, random port → Container 80
-p 192.168.1.10:8080:80     # Specific IP, port 8080
-P                          # All EXPOSE'd ports to random
```

### Multiple Port Mappings

**Map multiple ports:**
```bash
docker run -d \
  -p 80:80 \
  -p 443:443 \
  -p 8080:8080 \
  my-web-server
```

### UDP Ports

**Default is TCP, specify UDP explicitly:**
```bash
docker run -d -p 53:53/udp dns-server
# UDP port 53

docker run -d -p 53:53/tcp -p 53:53/udp dns-server
# Both TCP and UDP port 53
```

### Port Conflicts

**❌ Port already in use:**
```bash
docker run -d -p 80:80 nginx  # Works
docker run -d -p 80:80 apache # ❌ Fails! Port 80 already bound
```

**✅ Use different host ports:**
```bash
docker run -d -p 80:80 --name web1 nginx
docker run -d -p 8080:80 --name web2 nginx
# web1 on port 80
# web2 on port 8080
```

### DCA Exam Focus

**You must know:**
1. **-p maps specific port**, -P maps all EXPOSE'd ports
2. **-p HOST:CONTAINER** format
3. **Port mapping works with bridge networks**
4. **host network ignores -p** (uses container port directly)
5. **IP:PORT:CONTAINER** for binding specific interfaces

### Common Patterns

**Pattern 1: Multiple instances on different ports**
```bash
# Run 3 nginx instances
docker run -d -p 8081:80 --name web1 nginx:alpine
docker run -d -p 8082:80 --name web2 nginx:alpine
docker run -d -p 8083:80 --name web3 nginx:alpine

# Accessible at:
# localhost:8081
# localhost:8082
# localhost:8083
```

**Pattern 2: localhost-only development**
```bash
# Database only accessible locally (security)
docker run -d \
  -p 127.0.0.1:5432:5432 \
  --name dev-db \
  postgres:15

# Accessible from host
psql -h localhost -p 5432

# NOT accessible from external IPs (secure!)
```

**Pattern 3: Multi-port application**
```bash
docker run -d \
  -p 3000:3000 \  # Web interface
  -p 9090:9090 \  # Metrics
  -p 6060:6060 \  # Profiling
  --name app \
  myapp:latest
```

### Checking Port Mappings

**View port mappings:**
```bash
docker ps
# Shows: 0.0.0.0:8080->80/tcp

docker port container-name
# Lists all port mappings

docker port container-name 80
# Shows mapping for specific container port
```

**Inspect container:**
```bash
docker inspect container-name | grep -A 10 Ports
```

### Dynamic Port Assignment

**Let Docker choose:**
```bash
docker run -d -p 80 nginx
# Docker assigns random high port (e.g., 32771)

# Find assigned port
docker port container-name 80
# 0.0.0.0:32771
```

**Useful for:**
- CI/CD pipelines
- Testing
- Avoiding port conflicts

### Port Mapping with host Network

**❌ -p flag IGNORED:**
```bash
docker run -d --network host -p 8080:80 nginx
# -p flag is IGNORED!
# Nginx uses port 80 directly on host
```

### Best Practices

**✅ DO:**
```bash
# Use specific ports in production
docker run -d -p 80:80 nginx

# Bind to localhost for development
docker run -d -p 127.0.0.1:5432:5432 postgres

# Document exposed ports in Dockerfile
EXPOSE 80 443
```

**❌ DON'T:**
```bash
# Don't expose unnecessary ports
docker run -d -p 22:22 webapp  # SSH exposed!

# Don't use random ports in production
docker run -d -P nginx  # Port changes on restart!
```

### Try it!

**Test port mapping:**
```bash
# Map to host port 8080
docker run -d -p 8080:80 --name web nginx:alpine
curl localhost:8080  # Works!

# Try to use same port (will fail)
docker run -d -p 8080:80 --name web2 nginx:alpine
# Error: port is already allocated

# Use different port
docker run -d -p 8081:80 --name web2 nginx:alpine
curl localhost:8081  # Works!

# Check all port mappings
docker ps
docker port web
docker port web2

# Clean up
docker rm -f web web2
```

**Test localhost-only binding:**
```bash
# Bind to localhost only
docker run -d -p 127.0.0.1:8080:80 --name local-web nginx:alpine

# Works from host
curl localhost:8080

# Check if accessible from network
ip addr  # Get your IP (e.g., 192.168.1.100)
curl 192.168.1.100:8080  # Should fail (localhost only!)

# Clean up
docker rm -f local-web
```
  MARKDOWN
  command_to_learn: "docker run -p / -P",
  command_variations: ["docker run -p HOST:CONTAINER", "docker run -p IP:HOST:CONTAINER", "docker run -P", "docker port CONTAINER"],
  practice_hints: [
    "-p maps specific ports, -P publishes all EXPOSE'd ports to random ports",
    "Format is -p HOST_PORT:CONTAINER_PORT",
    "Bind to 127.0.0.1 for localhost-only access",
    "Port mapping only works with bridge networks, not host network"
  ]
)
puts "✅ Chapter 27 enhanced"

puts "\n" + "=" * 80
puts "🎉 ALL NETWORKING CHAPTERS COMPLETE! (21-27)"
puts "=" * 80
