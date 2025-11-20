# Enhance Networking Chapters 21-27 (Batch)

puts "Enhancing Networking Chapters 21-27..."
puts "=" * 80

# Chapter 21: docker network ls
puts "\nChapter 21: docker network ls"
unit = InteractiveLearningUnit.find_by!(slug: "codesprout-docker-network-ls")
unit.update!(
  concept_explanation: <<-'MARKDOWN',
**Listing Docker Networks** 🌐

Understanding Docker networking is CRITICAL for the DCA exam (Networking = 15% of exam!).

### The docker network ls Command

**Lists all Docker networks on your system.**

**Syntax:**
```bash
docker network ls [OPTIONS]
```

**Example output:**
```
NETWORK ID     NAME      DRIVER    SCOPE
9f9a7c8d2e1b   bridge    bridge    local
3c2fd14a6789   host      host      local
8f1e5b9c3d2a   none      null      local
```

### Default Networks

**Every Docker installation has 3 default networks:**

**1. bridge (default)**
- Containers connect here unless specified otherwise
- Containers can communicate via IP
- Need `--link` or custom network for DNS

**2. host**
- Container uses host's network directly
- No network isolation
- Container ports directly on host

**3. none**
- No network interface
- Completely isolated
- Use for security or custom networking

### Understanding Network Drivers

**bridge:**
- Default driver for standalone containers
- Private internal network
- Containers can reach each other

**host:**
- Remove network isolation
- Container shares host's network
- Better performance, less isolation

**overlay:**
- Multi-host networking (Swarm)
- Containers across different hosts communicate
- Used in production clusters

**macvlan:**
- Assign MAC address to container
- Container appears as physical device
- For legacy apps needing direct network access

**none:**
- Disable networking
- Maximum isolation

### Common Options

**Filter by driver:**
```bash
docker network ls --filter driver=bridge
```

**Filter by name:**
```bash
docker network ls --filter name=my
```

**Quiet mode (IDs only):**
```bash
docker network ls -q
```

**No truncation:**
```bash
docker network ls --no-trunc
```

### DCA Exam Focus

**You must know:**
1. **3 default networks** - bridge, host, none
2. **Network drivers** - bridge, host, overlay, macvlan, none
3. **Filtering networks** with --filter
4. **Network scope** - local vs swarm

### Try it!

```bash
# List all networks
docker network ls

# Filter by bridge driver
docker network ls --filter driver=bridge

# Get network IDs only
docker network ls -q

# Inspect specific network
docker network inspect bridge
```
  MARKDOWN
  command_to_learn: "docker network ls",
  command_variations: ["docker network ls", "docker network ls --filter driver=bridge", "docker network ls -q"],
  practice_hints: [
    "Every Docker installation has 3 default networks: bridge, host, none",
    "bridge is the default network for containers",
    "Use --filter to find specific networks",
    "Network drivers determine how containers communicate"
  ]
)
puts "✅ Chapter 21 enhanced"

# Chapter 22: docker network create
puts "\nChapter 22: docker network create"
unit = InteractiveLearningUnit.find_by!(slug: "codesprout-docker-network-create")
unit.update!(
  concept_explanation: <<-'MARKDOWN',
**Creating Custom Docker Networks** 🛠️

Custom networks enable better container communication and isolation - essential for DCA!

### Why Custom Networks?

**❌ Default bridge limitations:**
- Containers communicate via IP only
- No automatic DNS resolution
- Must use `--link` (deprecated)

**✅ Custom bridge benefits:**
- Automatic DNS resolution (container name = hostname)
- Better isolation
- Fine-grained network control

### The docker network create Command

**Syntax:**
```bash
docker network create [OPTIONS] NETWORK_NAME
```

**Basic example:**
```bash
docker network create my-network
```

### Network Drivers

**Bridge (default for standalone):**
```bash
docker network create --driver bridge my-app-network
# or simply:
docker network create my-app-network
```

**Overlay (for Swarm):**
```bash
docker network create --driver overlay my-swarm-network
```

**Macvlan (direct MAC address):**
```bash
docker network create --driver macvlan \
  --subnet=192.168.1.0/24 \
  --gateway=192.168.1.1 \
  my-macvlan-network
```

### Subnet and IP Configuration

**Specify subnet:**
```bash
docker network create \
  --subnet=172.20.0.0/16 \
  my-network
```

**Specify gateway:**
```bash
docker network create \
  --subnet=172.20.0.0/16 \
  --gateway=172.20.0.1 \
  my-network
```

**IP range for dynamic allocation:**
```bash
docker network create \
  --subnet=172.20.0.0/16 \
  --ip-range=172.20.240.0/20 \
  my-network
```

### Real-World Example

**Multi-tier application:**
```bash
# Create frontend network
docker network create frontend-network

# Create backend network
docker network create backend-network

# Database only on backend
docker run -d --name db \
  --network backend-network \
  postgres:15

# API on both networks
docker run -d --name api \
  --network backend-network \
  myapi:latest

docker network connect frontend-network api

# Web only on frontend
docker run -d --name web \
  --network frontend-network \
  -p 80:80 \
  nginx:alpine
```

**Result:**
- Web can reach API (both on frontend-network)
- API can reach DB (both on backend-network)
- Web CANNOT reach DB (isolated!)

### DCA Exam Focus

**You must know:**
1. **Custom networks provide DNS** resolution
2. **--driver bridge** for single-host
3. **--driver overlay** for multi-host (Swarm)
4. **--subnet, --gateway** for IP config
5. **Containers in custom networks** can ping by name

### Common Patterns

**Pattern 1: Application isolation**
```bash
# Per-app network
docker network create app1-network
docker network create app2-network

# App 1 containers
docker run -d --name app1-web --network app1-network nginx
docker run -d --name app1-db --network app1-network postgres

# App 2 containers (completely isolated from App 1)
docker run -d --name app2-web --network app2-network nginx
docker run -d --name app2-db --network app2-network mysql
```

**Pattern 2: Microservices**
```bash
docker network create microservices-network

docker run -d --name users-service --network microservices-network user-api
docker run -d --name orders-service --network microservices-network order-api
docker run -d --name gateway --network microservices-network -p 80:80 api-gateway

# Services can communicate by name:
# curl http://users-service/api/users
# curl http://orders-service/api/orders
```

### Try it!

```bash
# Create custom network
docker network create my-test-network

# Run two containers on it
docker run -d --name web1 --network my-test-network nginx:alpine
docker run -it --name test --network my-test-network alpine sh

# Inside test container:
ping web1  # Works! DNS resolution
curl http://web1  # Can reach nginx by name

# Clean up
exit
docker rm -f web1 test
docker network rm my-test-network
```
  MARKDOWN
  command_to_learn: "docker network create",
  command_variations: ["docker network create NAME", "docker network create --driver bridge NAME", "docker network create --subnet CIDR NAME"],
  practice_hints: [
    "Custom networks provide automatic DNS resolution between containers",
    "Use --driver bridge for single-host, --driver overlay for Swarm",
    "Containers on custom networks can communicate by container name",
    "Create separate networks for better isolation between applications"
  ]
)
puts "✅ Chapter 22 enhanced"

# Chapter 23: docker network connect
puts "\nChapter 23: docker network connect"
unit = InteractiveLearningUnit.find_by!(slug: "codesprout-docker-network-connect")
unit.update!(
  concept_explanation: <<-'MARKDOWN',
**Connecting Containers to Networks** 🔌

Containers can connect to multiple networks - critical for microservices architecture!

### The docker network connect Command

**Connects a running container to a network.**

**Syntax:**
```bash
docker network connect [OPTIONS] NETWORK CONTAINER
```

**Example:**
```bash
docker network connect my-network my-container
```

### Why Multiple Networks?

**Real-world scenario:**
- Web tier: frontend network
- API tier: frontend + backend networks
- Database: backend network only

**Result:**
- Web → API ✓
- API → DB ✓
- Web → DB ✗ (isolated!)

### Connecting at Runtime

**Connect existing container:**
```bash
# Create network
docker network create backend-network

# Run container on default bridge
docker run -d --name api myapi:latest

# Connect to additional network
docker network connect backend-network api

# Now on TWO networks!
```

### Disconnect from Network

**Remove container from network:**
```bash
docker network disconnect backend-network api
```

### IP Address Assignment

**Specify IP address:**
```bash
docker network connect --ip 172.20.0.10 my-network my-container
```

**Specify alias (additional DNS name):**
```bash
docker network connect --alias db my-network postgres-container

# Now reachable as both:
# - postgres-container (container name)
# - db (alias)
```

### Linking Containers (Deprecated)

**❌ OLD WAY (deprecated):**
```bash
docker run --name db postgres
docker run --name web --link db nginx
```

**✅ NEW WAY (custom networks):**
```bash
docker network create my-network
docker run --name db --network my-network postgres
docker run --name web --network my-network nginx

# web can reach db by name automatically!
```

### Multi-Network Container

**Example: API gateway**
```bash
# Create networks
docker network create frontend
docker network create backend

# Run database (backend only)
docker run -d --name postgres --network backend postgres:15

# Run API (starts on backend)
docker run -d --name api --network backend myapi:latest

# Connect API to frontend too
docker network connect frontend api

# Run web (frontend only)
docker run -d --name web --network frontend -p 80:80 nginx

# Check connections
docker inspect api | grep -A 10 Networks
```

### DCA Exam Focus

**You must know:**
1. **Containers can be on multiple networks**
2. **docker network connect** for running containers
3. **--network at run time** for initial connection
4. **--alias for additional DNS names**
5. **Multi-network for tier isolation**

### Common Patterns

**Pattern 1: Database isolation**
```bash
docker network create frontend
docker network create backend

# DB on backend only
docker run -d --name db --network backend postgres

# API on both
docker run -d --name api --network backend myapi
docker network connect frontend api

# Web on frontend only
docker run -d --name web --network frontend nginx
```

**Pattern 2: Shared services**
```bash
docker network create app1-net
docker network create app2-net

# Redis shared by both apps
docker run -d --name redis redis:alpine
docker network connect app1-net redis
docker network connect app2-net redis

# App 1
docker run -d --name app1 --network app1-net myapp:v1

# App 2
docker run -d --name app2 --network app2-net myapp:v2

# Both can reach redis!
```

### Try it!

```bash
# Setup
docker network create net1
docker network create net2

# Container on net1
docker run -d --name test --network net1 nginx:alpine

# Check networks (only net1)
docker inspect test | grep -A 5 Networks

# Connect to net2
docker network connect net2 test

# Check again (now on net1 AND net2)
docker inspect test | grep -A 10 Networks

# Disconnect
docker network disconnect net2 test

# Clean up
docker rm -f test
docker network rm net1 net2
```
  MARKDOWN
  command_to_learn: "docker network connect",
  command_variations: ["docker network connect NETWORK CONTAINER", "docker network connect --ip IP NETWORK CONTAINER", "docker network disconnect NETWORK CONTAINER"],
  practice_hints: [
    "Containers can be connected to multiple networks simultaneously",
    "Use docker network connect for running containers",
    "Use --network flag at docker run for initial network",
    "Multi-network containers enable tier isolation in applications"
  ]
)
puts "✅ Chapter 23 enhanced"

puts "\n" + "=" * 80
puts "✅ Networking batch 1 complete (Chapters 21-23)"
puts "Creating batch 2..."
