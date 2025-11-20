# One-Week Networking Fundamentals Course - Part 3 (Days 6-7)
# Final modules: Container Networking and Cloud VPCs
puts "Adding Days 6-7 to Networking Fundamentals Course..."

networking_course = Course.find_by(slug: 'networking-fundamentals')
unless networking_course
  puts "❌ Error: networking-fundamentals course not found. Run networking_week_course.rb first."
  exit
end

# ==========================================
# DAY 6: Container Networking Fundamentals
# ==========================================

day6_module = CourseModule.find_or_create_by!(slug: 'day6-container-networking', course: networking_course) do |mod|
  mod.title = "Day 6: Container Networking Fundamentals"
  mod.description = "Learn how Docker handles networking with bridge, host, and overlay networks. Understand how containers communicate on the same host and across hosts, and how Kubernetes networking relates to these concepts."
  mod.sequence_order = 6
  mod.estimated_minutes = 120
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Understand Docker's default bridge network and NAT",
    "Compare bridge, host, and overlay network modes",
    "Configure container networking for different scenarios",
    "Understand basic Kubernetes pod networking concepts"
  ])
end

day6_lesson = CourseLesson.find_or_create_by!(title: "Docker Bridge, Host, and Overlay Networks") do |lesson|
  lesson.reading_time_minutes = 60
  lesson.content = <<~MARKDOWN
    # Day 6: Container Networking Fundamentals

    ## Learning Goals

    - Understand how Docker handles networking
    - Compare bridge, host, and overlay network modes
    - Learn how containers communicate within and across hosts
    - Connect Docker networking concepts to Kubernetes

    ## Why Container Networking Matters for DevOps

    Containers are fundamental to modern DevOps workflows. Understanding container networking is essential for:
    - Deploying microservices architectures
    - Troubleshooting container-to-container communication
    - Configuring Kubernetes networking
    - Designing secure multi-tier applications
    - Setting up CI/CD pipelines with containerized services

    ## Docker Networking Overview

    Docker provides several networking drivers to control how containers communicate:

    1. **Bridge** (default): Isolated network on single host
    2. **Host**: Share host's network namespace
    3. **Overlay**: Multi-host networking for Swarm/orchestrators
    4. **Macvlan**: Assign MAC address to container
    5. **None**: No networking

    ## 1. Bridge Network (Default)

    ### What is Bridge Network?

    The **bridge network** creates a private internal network on the Docker host. Containers on the same bridge can communicate, and Docker provides NAT for internet access.

    **Default Bridge**: `docker0` (usually 172.17.0.0/16)

    ### How Bridge Networks Work

    ```
    Host: 192.168.1.100

    Docker Bridge (docker0): 172.17.0.1/16
       │
       ├─ Container A: 172.17.0.2
       ├─ Container B: 172.17.0.3
       └─ Container C: 172.17.0.4

    [Containers can talk to each other via 172.17.0.x]
    [Internet access via NAT through host's IP]
    ```

    ### Bridge Network Architecture

    ```
    Internet
       ↕
    Host (192.168.1.100)
       ↕ [NAT via iptables]
    docker0 bridge (172.17.0.1)
       ├─ veth pair ─ Container A (172.17.0.2)
       ├─ veth pair ─ Container B (172.17.0.3)
       └─ veth pair ─ Container C (172.17.0.4)
    ```

    **Key Components**:
    - **docker0**: Virtual bridge interface
    - **veth pairs**: Virtual Ethernet pairs (one end in container, one on bridge)
    - **iptables**: NAT rules for outbound internet access

    ### Default Bridge vs User-Defined Bridge

    **Default Bridge** (`docker0`):
    - Created automatically
    - Containers use IP addresses to communicate
    - No automatic DNS resolution between containers
    - Legacy linking mechanism

    **User-Defined Bridge**:
    - Created with `docker network create`
    - **Automatic DNS resolution** by container name
    - Better isolation
    - Can connect/disconnect containers dynamically
    - **Best practice for production**

    ### Bridge Network Commands

    ```bash
    # List networks
    docker network ls

    # Create user-defined bridge
    docker network create my-network

    # Create bridge with specific subnet
    docker network create --subnet=192.168.10.0/24 my-network

    # Run container on specific network
    docker run --network=my-network --name=web nginx

    # Run container on default bridge
    docker run --name=app nginx  # Uses default bridge

    # Inspect network
    docker network inspect my-network

    # Connect running container to network
    docker network connect my-network existing-container

    # Disconnect container from network
    docker network disconnect my-network existing-container
    ```

    ### Container Communication on Bridge

    **Same User-Defined Bridge**:
    ```bash
    # Create network
    docker network create app-network

    # Start two containers
    docker run -d --name web --network app-network nginx
    docker run -d --name api --network app-network python:3.9

    # From inside 'api' container, you can reach 'web' by name:
    docker exec api ping web  # ✅ Works! DNS resolves 'web' to container IP
    ```

    **Default Bridge** (legacy):
    ```bash
    # Start containers on default bridge
    docker run -d --name web1 nginx
    docker run -d --name web2 nginx

    # DNS resolution doesn't work
    docker exec web1 ping web2  # ❌ Fails: "unknown host"

    # Must use IP address
    docker exec web1 ping 172.17.0.3  # ✅ Works if web2 has this IP
    ```

    ### Port Mapping (Publishing Ports)

    By default, containers on bridge networks are **not accessible from outside**. To expose services:

    ```bash
    # Map host port 8080 to container port 80
    docker run -p 8080:80 nginx
    # Now: localhost:8080 → container:80

    # Map host port to container port on specific IP
    docker run -p 192.168.1.100:8080:80 nginx

    # Map random host port
    docker run -P nginx  # Uses random high port

    # Multiple port mappings
    docker run -p 80:80 -p 443:443 nginx
    ```

    **How it works**: Docker adds iptables DNAT rules to forward host port to container IP:port

    ### NAT and Internet Access

    **Outbound** (Container → Internet):
    ```
    Container sends: [Source: 172.17.0.2:12345, Dest: 8.8.8.8:53]
       ↓
    Docker NAT: [Source: 192.168.1.100:45678, Dest: 8.8.8.8:53]
       ↓
    Internet sees traffic from host IP
    ```

    **Inbound** (Internet → Container) via port mapping:
    ```
    Request: [Dest: 192.168.1.100:8080]
       ↓
    Docker DNAT: [Dest: 172.17.0.2:80]
       ↓
    Container receives on port 80
    ```

    ### Bridge Network Use Cases

    - ✅ **Development**: Multiple services on one machine
    - ✅ **Microservices on single host**: Services communicate by name
    - ✅ **Isolated environments**: Different bridges for different apps
    - ❌ **Multi-host**: Doesn't work across machines (use overlay instead)

    ## 2. Host Network Mode

    ### What is Host Network?

    In **host network mode**, a container shares the host's network namespace. It doesn't get its own IP address – it's directly on the host's network.

    ### Host Network Architecture

    ```
    Internet
       ↕
    Host (192.168.1.100)
       ↕ [Direct access - no isolation]
    Container (no separate IP, uses host's 192.168.1.100)
    ```

    **No separation**: Container sees host's network interfaces directly.

    ### Using Host Network

    ```bash
    # Run container in host mode
    docker run --network=host nginx

    # Container's nginx binds directly to host's port 80
    # No port mapping needed or possible
    ```

    ### Host Network Characteristics

    **Advantages**:
    - ✅ **Performance**: No NAT overhead, direct networking
    - ✅ **Low latency**: Best network performance
    - ✅ **Complex protocols**: Handles protocols that don't work well with NAT
    - ✅ **Network monitoring tools**: Can see host's full network

    **Disadvantages**:
    - ❌ **No isolation**: Security risk, container has full network access
    - ❌ **Port conflicts**: Can't run multiple containers on same port
    - ❌ **Not portable**: Behavior differs across environments
    - ❌ **Docker Desktop limitation**: Not fully supported on Mac/Windows

    ### Host Network Example

    ```bash
    # Start web server in host mode
    docker run --network=host -d nginx

    # nginx now listening on host's port 80 directly
    curl http://localhost  # ✅ Reaches container without port mapping

    # Try to start another container on same port
    docker run --network=host -d nginx  # ❌ Fails: port 80 already in use
    ```

    ### When to Use Host Network

    - ✅ **Network performance critical**: Minimal latency needed
    - ✅ **Network utilities**: tcpdump, packet capture tools
    - ✅ **Kubernetes CNI plugins**: Some network plugins run in host mode
    - ❌ **Typical applications**: Usually bridge is better due to isolation

    ## 3. Overlay Network (Multi-Host)

    ### What is Overlay Network?

    **Overlay networks** enable containers on different Docker hosts to communicate as if they're on the same network. Essential for orchestrated environments (Swarm, Kubernetes).

    ### Overlay Network Architecture

    ```
    Host A (10.0.1.10)                    Host B (10.0.2.20)
         │                                      │
    ┌────┴────────────────────────────────────┴────┐
    │      Overlay Network (172.20.0.0/24)         │
    │                                               │
    │  Container A1 (172.20.0.2)    Container B1 (172.20.0.3) │
    │  Container A2 (172.20.0.4)    Container B2 (172.20.0.5) │
    └──────────────────────────────────────────────┘

    [Containers see a flat L2 network]
    [Actually: VXLAN tunnels between hosts]
    ```

    **How it works**:
    - Creates virtual network spanning multiple hosts
    - Uses **VXLAN** (Virtual Extensible LAN) encapsulation
    - Containers get IPs from overlay subnet
    - Traffic between hosts is encapsulated/decapsulated automatically

    ### Creating Overlay Networks

    **Prerequisites**: Docker Swarm mode or external key-value store

    ```bash
    # Initialize Swarm (required for overlay)
    docker swarm init

    # Create overlay network
    docker network create -d overlay my-overlay

    # Create overlay with specific subnet
    docker network create -d overlay --subnet=10.10.0.0/24 my-overlay

    # Deploy service on overlay (Swarm mode)
    docker service create --name web --network my-overlay nginx
    ```

    ### Overlay Network Use Cases

    - ✅ **Docker Swarm**: Multi-node container orchestration
    - ✅ **Microservices across hosts**: Service mesh communication
    - ✅ **Kubernetes**: Pod networking (via CNI plugins like Flannel)
    - ✅ **Hybrid cloud**: Connect containers across cloud providers

    ## 4. Container-to-Container Communication

    ### Same Host, Same Network

    ```bash
    # Create user-defined bridge
    docker network create app-net

    # Start frontend and backend
    docker run -d --name backend --network app-net python-api
    docker run -d --name frontend --network app-net nginx

    # Frontend can reach backend by name
    # In frontend config: http://backend:5000
    ```

    **DNS Resolution**: Docker's embedded DNS server resolves container names to IPs.

    ### Same Host, Different Networks

    ```bash
    # Two separate networks
    docker network create frontend-net
    docker network create backend-net

    # Containers on different networks can't communicate
    docker run -d --name web --network frontend-net nginx
    docker run -d --name db --network backend-net postgres

    # web ✗→ db  (no route between networks)
    ```

    **Solution**: Connect container to multiple networks

    ```bash
    # Create app server that bridges both networks
    docker run -d --name app --network frontend-net python-api
    docker network connect backend-net app

    # Now 'app' can reach both 'web' and 'db'
    ```

    ### Cross-Host Communication (Overlay)

    ```bash
    # On Host A and B (both in same Swarm)
    docker network create -d overlay shared-net

    # Host A: Start container
    docker service create --name api --network shared-net python-api

    # Host B: Start container
    docker service create --name web --network shared-net nginx

    # web can reach api by name, even though on different hosts!
    # Docker Swarm + overlay network handles routing
    ```

    ## 5. Kubernetes Pod Networking

    ### K8s Networking Model

    Kubernetes has a simpler, more opinionated networking model:

    **Requirements**:
    1. Every **Pod** gets a unique IP
    2. Pods can communicate with any other Pod without NAT
    3. Nodes can communicate with Pods without NAT

    **Key Difference from Docker**:
    - Docker default: Isolated networks, NAT for internet
    - Kubernetes: Flat network, all Pods can reach each other

    ### How K8s Achieves This (CNI Plugins)

    Kubernetes doesn't implement networking itself – it uses **CNI (Container Network Interface)** plugins:

    | Plugin | Method | Description |
    |--------|--------|-------------|
    | **Flannel** | VXLAN overlay | Simple, popular, uses overlay network |
    | **Calico** | BGP routing | L3 networking, network policies |
    | **Weave** | VXLAN/fastdp | Encrypted overlay option |
    | **Cilium** | eBPF | High-performance, security-focused |

    ### K8s Pod Networking Example

    ```yaml
    # Two pods in same cluster
    Pod A: 10.244.1.5 (on Node 1)
    Pod B: 10.244.2.8 (on Node 2)

    # Pod A can directly reach Pod B by IP: 10.244.2.8
    # CNI plugin (e.g., Flannel) routes traffic between nodes
    ```

    ### K8s Services

    While Pods have IPs, they're ephemeral. **Services** provide stable endpoints:

    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: backend
    spec:
      selector:
        app: backend
      ports:
      - port: 80
        targetPort: 8080

    # Other Pods can reach backend via: http://backend:80
    # Kubernetes DNS resolves 'backend' to Service IP (ClusterIP)
    # Service load-balances across backend Pods
    ```

    ### Relation to Docker Networking

    - **Docker user-defined bridge** ≈ Kubernetes flat Pod network
    - **Docker DNS** ≈ Kubernetes DNS (CoreDNS)
    - **Docker overlay** ≈ Kubernetes CNI plugins (Flannel, Calico)
    - **Docker service** ≈ Kubernetes Service

    ## Practical Examples

    ### Example 1: Microservices on Single Host

    **Goal**: Run frontend, API, and database with proper isolation

    ```bash
    # Create networks
    docker network create frontend-net
    docker network create backend-net

    # Database (backend only)
    docker run -d --name db --network backend-net \\
      -e POSTGRES_PASSWORD=secret postgres

    # API (both networks - bridge between tiers)
    docker run -d --name api --network frontend-net python-api
    docker network connect backend-net api

    # Frontend (frontend only)
    docker run -d --name web --network frontend-net -p 80:80 nginx

    # Result:
    # - web → api ✓ (frontend-net)
    # - api → db ✓ (backend-net)
    # - web → db ✗ (no route - secure!)
    # - internet → web ✓ (port 80 published)
    ```

    ### Example 2: Development Environment

    **Docker Compose** automates this:

    ```yaml
    version: '3'
    services:
      web:
        image: nginx
        ports:
          - "80:80"
        networks:
          - frontend

      api:
        image: python-api
        networks:
          - frontend
          - backend

      db:
        image: postgres
        environment:
          POSTGRES_PASSWORD: secret
        networks:
          - backend

    networks:
      frontend:
      backend:
    ```

    **Benefits**:
    - Services communicate by name (web → api, api → db)
    - Automatic DNS resolution
    - Network isolation (db not on frontend network)

    ## Troubleshooting Container Networking

    ### Check Container IP and Network

    ```bash
    # Inspect container networking
    docker inspect <container_name> | grep -A 20 Networks

    # Get container IP
    docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container>

    # List container's networks
    docker inspect -f '{{range $k,$v := .NetworkSettings.Networks}}{{$k}} {{end}}' <container>
    ```

    ### Test Connectivity Between Containers

    ```bash
    # From one container, ping another
    docker exec container1 ping container2

    # Install network tools if needed
    docker exec container1 apt-get update && apt-get install -y iputils-ping curl

    # Test HTTP connectivity
    docker exec container1 curl http://container2:80
    ```

    ### Check DNS Resolution

    ```bash
    # Test DNS inside container
    docker exec container1 nslookup container2
    docker exec container1 getent hosts container2

    # Check Docker's embedded DNS (usually 127.0.0.11)
    docker exec container cat /etc/resolv.conf
    ```

    ### Inspect iptables Rules

    ```bash
    # View Docker's NAT rules
    sudo iptables -t nat -L -n

    # View Docker's filter rules
    sudo iptables -L -n

    # Look for DOCKER-USER chain (custom rules)
    sudo iptables -L DOCKER-USER -n
    ```

    ### Common Issues

    | Problem | Likely Cause | Solution |
    |---------|--------------|----------|
    | Can't reach container from host | Port not published | Add `-p` flag |
    | Containers can't talk by name | Using default bridge | Use user-defined bridge |
    | Container can't reach internet | DNS/routing issue | Check DNS, gateway, iptables |
    | Port already in use | Another container/process | Check with `ss -tuln`, stop conflicting service |
    | Network not found | Typo or network deleted | `docker network ls`, recreate network |

    ## Best Practices

    1. **Use user-defined bridges** for better DNS and isolation
    2. **Avoid default bridge** in production (legacy, no DNS)
    3. **Use host mode sparingly** (security risk)
    4. **Design for multiple networks** to segment tiers (web, app, db)
    5. **Don't hardcode IPs** - use container names and DNS
    6. **Publish only necessary ports** (principle of least exposure)
    7. **Use Docker Compose** for development environments
    8. **Use overlay networks** for multi-host deployments
    9. **Monitor network performance** (check for NAT overhead)
    10. **Understand your orchestrator's networking** (K8s, Swarm, ECS)

    ## Key Takeaways

    1. **Bridge network** (default): Isolated network on single host with NAT
    2. **User-defined bridges** provide automatic DNS resolution by container name
    3. **Host network** shares host's network namespace (high performance, low isolation)
    4. **Overlay networks** enable multi-host container communication via VXLAN
    5. **Port mapping** (`-p`) exposes container ports to host/internet
    6. **Docker uses NAT** for container internet access (masquerade via iptables)
    7. **Kubernetes Pod networking** provides flat network where all Pods can communicate
    8. **CNI plugins** (Flannel, Calico, etc.) implement K8s networking
    9. **Container DNS** allows service discovery by name within networks
    10. **Network isolation** enhances security by segmenting tiers

    ## Connection to Previous Days

    - **Day 2 (IP/Subnetting)**: Docker bridge networks use private IP ranges (172.17.0.0/16)
    - **Day 3 (NAT)**: Docker uses NAT (masquerading) for container internet access
    - **Day 3 (DNS)**: Docker provides embedded DNS for container name resolution
    - **Day 4 (Ports)**: Container port mapping uses DNAT to forward host ports
    - **Day 5 (Troubleshooting)**: Same tools (ping, curl, netstat) work inside containers
    - **Day 7 (Cloud)**: Similar concepts - cloud VPCs are like big overlay networks
  MARKDOWN

  lesson.key_concepts = JSON.generate([
    "Docker bridge networks and NAT",
    "User-defined bridges with automatic DNS",
    "Host network mode and trade-offs",
    "Overlay networks for multi-host communication",
    "Container port mapping and publishing",
    "Kubernetes flat Pod networking model",
    "CNI plugins and their implementations"
  ])
end

ModuleItem.find_or_create_by!(
  course_module: day6_module,
  item: day6_lesson,
  sequence_order: 1
) do |item|
  item.required = true
end

puts "  ✓ Day 6 Module and Lesson"

# ==========================================
# DAY 7: Cloud Networking Basics – VPCs
# ==========================================

day7_module = CourseModule.find_or_create_by!(slug: 'day7-cloud-vpc-networking', course: networking_course) do |mod|
  mod.title = "Day 7: Cloud Networking Basics – Public/Private Cloud Networks and VPCs"
  mod.description = "Translate networking knowledge into cloud context. Understand Virtual Private Clouds (VPCs), public vs private subnets, Internet Gateways, NAT gateways, and security groups."
  mod.sequence_order = 7
  mod.estimated_minutes = 120
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Understand VPC concept and cloud network isolation",
    "Design public and private subnets",
    "Configure Internet Gateways and NAT Gateways",
    "Implement security groups and network ACLs",
    "Apply week's learning to real cloud architecture"
  ])
end

day7_lesson = CourseLesson.find_or_create_by!(title: "AWS VPCs, Subnets, and Cloud Network Design") do |lesson|
  lesson.reading_time_minutes = 65
  lesson.content = <<~MARKDOWN
    # Day 7: Cloud Networking Basics – VPCs and Cloud Architecture

    ## Learning Goals

    - Understand Virtual Private Cloud (VPC) concept
    - Design public vs private subnets
    - Master Internet Gateway and NAT Gateway roles
    - Configure routing and security in cloud environments
    - Apply entire week's learning to cloud architecture

    ## Welcome to Cloud Networking!

    Everything you've learned this week applies to cloud networking:
    - **IP addressing** → Planning VPC CIDR blocks
    - **Subnetting** → Creating public/private subnets
    - **Routing** → VPC route tables
    - **NAT** → NAT Gateways for private subnets
    - **Firewalls** → Security Groups and Network ACLs
    - **DNS** → Route 53, internal DNS
    - **Troubleshooting** → Same tools work on cloud VMs!

    ## What is a Virtual Private Cloud (VPC)?

    ### VPC Definition

    A **VPC** is your own isolated virtual network within a cloud provider's infrastructure. It's like having your own private data center in the cloud.

    **Cloud Provider Terms**:
    - **AWS**: VPC (Virtual Private Cloud)
    - **Azure**: VNet (Virtual Network)
    - **GCP**: VPC (Virtual Private Cloud)

    ### VPC Characteristics

    - **Isolated**: Your VPC is logically separated from others
    - **Private IP range**: You choose the CIDR block (e.g., 10.0.0.0/16)
    - **Subnets**: Divide VPC into smaller networks
    - **Routing**: Control how traffic flows with route tables
    - **Security**: Firewalls at multiple levels (security groups, NACLs)
    - **Connectivity**: Internet Gateway, VPN, peering

    ### VPC vs Traditional Network

    | Traditional Data Center | Cloud VPC |
    |------------------------|-----------|
    | Physical routers | Virtual routers |
    | Physical switches | Software-defined networking |
    | Physical firewalls | Security Groups, NACLs |
    | BGP for routing | Route tables |
    | VLAN for segmentation | Subnets |
    | Physical cables | Virtual network |

    **Key Insight**: VPC is traditional networking on virtual infrastructure!

    ## VPC Components

    ### 1. CIDR Block (IP Range)

    Every VPC has a primary CIDR block that defines its IP address space.

    **Example**:
    ```
    VPC CIDR: 10.0.0.0/16
    - Usable IPs: 10.0.0.0 - 10.0.255.255
    - Total: 65,536 addresses
    ```

    **Best Practices**:
    - Use private IP ranges (10.x.x.x, 172.16-31.x.x, 192.168.x.x)
    - Choose large enough range for growth
    - Avoid overlap with other VPCs or on-premises networks
    - Common choices: 10.0.0.0/16, 172.16.0.0/16, 192.168.0.0/16

    ### 2. Subnets

    **Subnets** divide your VPC into smaller networks, each in a specific Availability Zone.

    **Subnet Types**:
    - **Public Subnet**: Has route to Internet Gateway, resources can have public IPs
    - **Private Subnet**: No direct internet route, uses NAT for outbound access

    **Example Subnet Design**:
    ```
    VPC: 10.0.0.0/16

    Availability Zone A:
      - Public Subnet A:  10.0.0.0/24  (256 IPs)
      - Private Subnet A: 10.0.1.0/24  (256 IPs)

    Availability Zone B:
      - Public Subnet B:  10.0.2.0/24  (256 IPs)
      - Private Subnet B: 10.0.3.0/24  (256 IPs)
    ```

    **Reserved IPs** (AWS example):
    In each subnet, AWS reserves 5 IPs:
    - **10.0.0.0**: Network address
    - **10.0.0.1**: VPC router
    - **10.0.0.2**: DNS server
    - **10.0.0.3**: Reserved for future use
    - **10.0.0.255**: Broadcast address

    So /24 subnet has 256 - 5 = **251 usable IPs**.

    ### 3. Internet Gateway (IGW)

    **Internet Gateway** connects your VPC to the internet. It's a horizontally-scaled, redundant, highly available component.

    **Functions**:
    - Provides route to/from the internet
    - Performs NAT for instances with public IPs
    - One IGW per VPC

    **How it works**:
    ```
    Instance with public IP: 10.0.0.10 (private), 54.x.y.z (public)
       ↓
    Internet Gateway: Maps public IP ↔ private IP (1-to-1 NAT)
       ↓
    Internet: Sees traffic from 54.x.y.z
    ```

    **Creating IGW**:
    ```bash
    # AWS CLI
    aws ec2 create-internet-gateway
    aws ec2 attach-internet-gateway --vpc-id vpc-xxx --internet-gateway-id igw-xxx
    ```

    ### 4. NAT Gateway

    **NAT Gateway** allows instances in private subnets to access the internet for outbound traffic (updates, API calls) without exposing them to inbound traffic.

    **Architecture**:
    ```
    Private Instance (10.0.1.10)
       ↓ [Route: 0.0.0.0/0 → NAT Gateway]
    NAT Gateway (10.0.0.50, public IP 52.x.y.z)
       ↓ [Route: 0.0.0.0/0 → Internet Gateway]
    Internet Gateway
       ↓
    Internet
    ```

    **Key Points**:
    - NAT Gateway resides in **public subnet**
    - Has its own **Elastic IP** (public IP)
    - Private instances route internet traffic through NAT
    - NAT Gateway source-NATs outbound traffic
    - **Managed service**: AWS handles availability, scaling

    **Alternative**: NAT Instance (EC2 running NAT software, less common now)

    ### 5. Route Tables

    **Route Tables** define where network traffic is directed.

    **Main Route Table**: Default for all subnets
    **Custom Route Tables**: Can be associated with specific subnets

    **Example Route Tables**:

    **Public Subnet Route Table**:
    ```
    Destination       Target
    10.0.0.0/16      local          (VPC internal traffic)
    0.0.0.0/0        igw-xxx        (Internet via IGW)
    ```

    **Private Subnet Route Table**:
    ```
    Destination       Target
    10.0.0.0/16      local          (VPC internal traffic)
    0.0.0.0/0        nat-xxx        (Internet via NAT Gateway)
    ```

    **Traffic Flow**:
    - Traffic to VPC CIDR (10.0.0.0/16) → stays local
    - Traffic to anywhere else (0.0.0.0/0) → goes to IGW or NAT

    ### 6. Security Groups

    **Security Groups** are stateful firewalls at the instance level. They control inbound and outbound traffic.

    **Characteristics**:
    - **Stateful**: Return traffic automatically allowed
    - **Instance-level**: Applied to ENI (Elastic Network Interface)
    - **Allow rules only**: Can't create deny rules (default deny)
    - **Referenced by ID**: Can reference other security groups

    **Example Security Group**:
    ```
    Security Group: web-sg

    Inbound Rules:
    - Type: HTTP, Port: 80, Source: 0.0.0.0/0 (allow HTTP from anywhere)
    - Type: HTTPS, Port: 443, Source: 0.0.0.0/0 (allow HTTPS from anywhere)
    - Type: SSH, Port: 22, Source: admin-sg (allow SSH from admin security group)

    Outbound Rules:
    - Type: All, Port: All, Dest: 0.0.0.0/0 (allow all outbound)
    ```

    ### 7. Network ACLs (NACLs)

    **Network ACLs** are stateless firewalls at the subnet level.

    **Characteristics**:
    - **Stateless**: Must explicitly allow return traffic
    - **Subnet-level**: Applies to all instances in subnet
    - **Numbered rules**: Evaluated in order (lowest first)
    - **Allow and Deny**: Can explicitly deny traffic

    **Default NACL**: Allows all inbound and outbound
    **Custom NACL**: Denies all by default

    **Example NACL**:
    ```
    Inbound Rules:
    Rule #  Type       Port    Source          Allow/Deny
    100     HTTP       80      0.0.0.0/0       ALLOW
    110     HTTPS      443     0.0.0.0/0       ALLOW
    120     SSH        22      203.0.113.0/24  ALLOW
    *       All        All     0.0.0.0/0       DENY

    Outbound Rules:
    Rule #  Type       Port    Dest            Allow/Deny
    100     All        All     0.0.0.0/0       ALLOW
    ```

    **Security Groups vs NACLs**:

    | Feature | Security Groups | NACLs |
    |---------|----------------|--------|
    | **Level** | Instance (ENI) | Subnet |
    | **State** | Stateful | Stateless |
    | **Rules** | Allow only | Allow and Deny |
    | **Rule eval** | All rules evaluated | First match wins |
    | **Applied to** | Specified instances | All instances in subnet |

    **Best Practice**: Use Security Groups as primary defense, NACLs for additional subnet-level control.

    ## Public vs Private Subnets

    ### Public Subnet

    **Definition**: Subnet with a route to an Internet Gateway.

    **Characteristics**:
    - Instances can have public IPs
    - Directly accessible from internet (if security group allows)
    - Route table has: 0.0.0.0/0 → IGW

    **Use Cases**:
    - Web servers
    - Load balancers
    - Bastion hosts (jump boxes)
    - NAT Gateways

    **Example**:
    ```
    Public Subnet: 10.0.0.0/24
    Route Table:
      10.0.0.0/16 → local
      0.0.0.0/0 → igw-xxx

    Instance: Web Server
      Private IP: 10.0.0.10
      Public IP: 54.123.45.67
      Security Group: Allow HTTP/HTTPS from 0.0.0.0/0
    ```

    ### Private Subnet

    **Definition**: Subnet with no direct route to Internet Gateway.

    **Characteristics**:
    - Instances have only private IPs
    - Not directly accessible from internet
    - Outbound internet via NAT Gateway (if needed)
    - Route table has: 0.0.0.0/0 → NAT Gateway (in public subnet)

    **Use Cases**:
    - Application servers
    - Databases
    - Backend services
    - Sensitive workloads

    **Example**:
    ```
    Private Subnet: 10.0.1.0/24
    Route Table:
      10.0.0.0/16 → local
      0.0.0.0/0 → nat-xxx

    Instance: Database Server
      Private IP: 10.0.1.20
      Public IP: None
      Security Group: Allow MySQL (3306) from app-sg only
    ```

    ## Designing a Secure VPC Architecture

    ### Classic 3-Tier Architecture

    **Goal**: Web tier accessible from internet, app and database tiers isolated.

    ```
    ┌──────────────────────────────────────────────────────────┐
    │                    VPC: 10.0.0.0/16                      │
    │                                                           │
    │  ┌─────────────────────────────────────────────────┐    │
    │  │  Public Subnet: 10.0.0.0/24                     │    │
    │  │  ┌────────────────┐  ┌──────────────────┐      │    │
    │  │  │ Load Balancer  │  │  NAT Gateway     │      │    │
    │  │  │ (ELB)          │  │  52.x.y.z        │      │    │
    │  │  └────────────────┘  └──────────────────┘      │    │
    │  │          │                     ▲                 │    │
    │  └──────────┼─────────────────────┼─────────────────┘    │
    │             │                     │                       │
    │             ▼                     │                       │
    │  ┌─────────────────────────────────────────────────┐    │
    │  │  Private Subnet: 10.0.1.0/24 (App Tier)         │    │
    │  │  ┌────────────────┐  ┌────────────────┐        │    │
    │  │  │  App Server 1  │  │  App Server 2  │───────►│    │
    │  │  │  10.0.1.10     │  │  10.0.1.11     │ Internet    │
    │  │  └────────────────┘  └────────────────┘ (via NAT)   │
    │  │          │                     │                 │    │
    │  └──────────┼─────────────────────┼─────────────────┘    │
    │             ▼                     ▼                       │
    │  ┌─────────────────────────────────────────────────┐    │
    │  │  Private Subnet: 10.0.2.0/24 (DB Tier)          │    │
    │  │  ┌────────────────┐  ┌────────────────┐        │    │
    │  │  │  DB Primary    │  │  DB Replica    │        │    │
    │  │  │  10.0.2.20     │  │  10.0.2.21     │        │    │
    │  │  └────────────────┘  └────────────────┘        │    │
    │  └─────────────────────────────────────────────────┘    │
    │                                                           │
    │  Internet Gateway (igw-xxx)                              │
    └─────────────┬─────────────────────────────────────────────┘
                  │
                  ▼
             [Internet]
    ```

    ### Security Group Configuration

    **Load Balancer SG** (public-facing):
    ```
    Inbound:
      - HTTP (80) from 0.0.0.0/0
      - HTTPS (443) from 0.0.0.0/0
    Outbound:
      - HTTP (80) to app-sg
      - HTTPS (443) to app-sg
    ```

    **App Server SG**:
    ```
    Inbound:
      - HTTP (80) from lb-sg
      - HTTPS (443) from lb-sg
      - SSH (22) from bastion-sg (for admin)
    Outbound:
      - MySQL (3306) to db-sg
      - HTTPS (443) to 0.0.0.0/0 (for API calls, package updates)
    ```

    **Database SG**:
    ```
    Inbound:
      - MySQL (3306) from app-sg
      - MySQL (3306) from bastion-sg (for admin)
    Outbound:
      - None needed (or minimal)
    ```

    ### Route Table Configuration

    **Public Subnet Route Table**:
    ```
    Destination       Target          Description
    10.0.0.0/16      local           VPC internal
    0.0.0.0/0        igw-xxx         Internet via IGW
    ```

    **Private Subnet Route Table** (App/DB tiers):
    ```
    Destination       Target          Description
    10.0.0.0/16      local           VPC internal
    0.0.0.0/0        nat-xxx         Internet via NAT (for updates)
    ```

    ### Traffic Flows

    **User → Web Server**:
    ```
    1. User (Internet) → Load Balancer (public IP)
       [Internet Gateway maps public IP to LB's private IP]

    2. Load Balancer → App Server (10.0.1.10:80)
       [Within VPC, direct routing via route table]

    3. App Server → Database (10.0.2.20:3306)
       [Within VPC, direct routing]

    4. Database → App Server [Response]
       [Return path, automatic with stateful security groups]

    5. App Server → Load Balancer → User [Response]
       [Response flows back through same path]
    ```

    **App Server → Internet** (for updates):
    ```
    1. App Server (10.0.1.10) → NAT Gateway (10.0.0.50)
       [Route: 0.0.0.0/0 → nat-xxx]

    2. NAT Gateway translates source IP:
       10.0.1.10 → 52.x.y.z (NAT's public IP)

    3. NAT Gateway → Internet Gateway → Internet

    4. Internet responds to 52.x.y.z

    5. NAT Gateway translates back: 52.x.y.z → 10.0.1.10

    6. App Server receives response
    ```

    ## Multi-AZ High Availability

    **Best Practice**: Deploy resources across multiple Availability Zones for fault tolerance.

    ```
    VPC: 10.0.0.0/16

    ┌─────────────────────────────────────────────────────────┐
    │  Availability Zone A          Availability Zone B       │
    │  ┌─────────────────────┐      ┌─────────────────────┐  │
    │  │ Public Subnet A     │      │ Public Subnet B     │  │
    │  │ 10.0.0.0/24         │      │ 10.0.2.0/24         │  │
    │  │ - NAT Gateway A     │      │ - NAT Gateway B     │  │
    │  │ - Web Server A      │      │ - Web Server B      │  │
    │  └─────────────────────┘      └─────────────────────┘  │
    │  ┌─────────────────────┐      ┌─────────────────────┐  │
    │  │ Private Subnet A    │      │ Private Subnet B    │  │
    │  │ 10.0.1.0/24         │      │ 10.0.3.0/24         │  │
    │  │ - App Server A      │      │ - App Server B      │  │
    │  │ - DB Primary        │      │ - DB Replica        │  │
    │  └─────────────────────┘      └─────────────────────┘  │
    └─────────────────────────────────────────────────────────┘
    ```

    **Benefits**:
    - If AZ A fails, traffic serves from AZ B
    - Load balancer distributes across both AZs
    - Database replication for data redundancy

    ## VPC Connectivity Options

    ### 1. VPC Peering

    **VPC Peering** connects two VPCs (same or different accounts, regions) for private communication.

    ```
    VPC A (10.0.0.0/16) ←→ VPC B (192.168.0.0/16)

    [Resources in VPC A can reach VPC B via private IPs]
    ```

    **Use Cases**:
    - Connect prod and dev VPCs
    - Share services across VPCs
    - Multi-account architectures

    ### 2. Transit Gateway

    **Transit Gateway** acts as a central hub connecting multiple VPCs and on-premises networks.

    ```
              ┌──── VPC A
              │
    [Transit] ├──── VPC B
    [Gateway] ├──── VPC C
              │
              └──── On-Premises (VPN)
    ```

    **Benefits**: Simplifies complex network topologies.

    ### 3. VPN Connection

    **VPN** connects your VPC to on-premises network over encrypted tunnel.

    ```
    Corporate Data Center ←[VPN Tunnel]→ AWS VPC
    ```

    ### 4. Direct Connect

    **Direct Connect** provides dedicated private connection from on-premises to AWS (not over internet).

    **Benefits**: Higher bandwidth, lower latency, more consistent than VPN.

    ## Cloud Networking Best Practices

    1. **Plan IP addressing carefully**: Avoid overlaps, choose large enough range
    2. **Use multiple AZs**: Deploy across at least 2 AZs for HA
    3. **Separate public and private subnets**: Defense in depth
    4. **Use security groups as primary firewall**: Least privilege principle
    5. **Enable VPC Flow Logs**: Monitor and audit network traffic
    6. **Use NAT Gateways in each AZ**: Avoid single point of failure
    7. **Tag everything**: Organize resources for cost tracking and management
    8. **Automate with IaC**: Use Terraform, CloudFormation for reproducibility
    9. **Test connectivity**: Verify routes, security groups, NACLs
    10. **Monitor and alert**: Set up CloudWatch alarms for network metrics

    ## Week Review: Bringing It All Together

    ### How This Week's Topics Apply to Cloud

    | Day | Topic | Cloud Application |
    |-----|-------|-------------------|
    | 1 | OSI Model | Understand cloud network layers (VPC = L2/L3) |
    | 2 | IP/Subnetting | Plan VPC CIDR, subnet allocation |
    | 3 | DNS/DHCP/NAT | Route 53, DHCP options, NAT Gateways |
    | 4 | TCP/UDP/Firewall | Security Groups, NACLs, port configuration |
    | 5 | Troubleshooting | Same tools work on EC2, CloudShell |
    | 6 | Container Networking | ECS networking, EKS pod networking |
    | 7 | Cloud VPCs | Design secure, scalable cloud architectures |

    ### Real-World Scenario: E-Commerce Platform

    **Requirements**:
    - Handle 10,000+ concurrent users
    - PCI-compliant (secure payment processing)
    - High availability (99.9% uptime)
    - Global user base

    **Architecture**:
    ```
    - CloudFront (CDN): Cache static content globally
    - Route 53 (DNS): Geo-routing, health checks
    - Multi-region VPCs: Primary in us-east-1, DR in eu-west-1
    - Public subnets: Application Load Balancers
    - Private subnets: ECS containers (web tier), RDS (database tier)
    - NAT Gateways: Outbound internet for private instances
    - Security Groups: Strict ingress/egress rules
    - VPC Flow Logs: Security monitoring
    - Direct Connect: PCI-compliant private connection to payment processor
    ```

    **Network Flow**:
    1. User requests www.shop.com
    2. Route 53 resolves to CloudFront
    3. CloudFront serves cached content or forwards to ALB
    4. ALB distributes to ECS containers across AZs
    5. Containers query RDS database in private subnet
    6. Payment processing via Direct Connect to PCI vault
    7. All traffic logged, monitored, secured at multiple layers

    ## Key Takeaways

    1. **VPC** is your isolated virtual network in the cloud
    2. **Subnets** divide VPCs into public (internet-facing) and private (internal) networks
    3. **Internet Gateway** connects VPC to the internet
    4. **NAT Gateway** allows private instances outbound internet access
    5. **Route tables** control traffic flow within VPC
    6. **Security Groups** are stateful instance-level firewalls (allow rules only)
    7. **NACLs** are stateless subnet-level firewalls (allow/deny rules)
    8. **Multi-AZ design** provides high availability and fault tolerance
    9. **All networking fundamentals apply**: IP addressing, routing, NAT, DNS, firewalls
    10. **Cloud abstracts complexity** but understanding the fundamentals is crucial for troubleshooting and design

    ## Congratulations!

    You've completed the one-week Networking Fundamentals course! You now have a solid foundation to:
    - Design and troubleshoot networks in any environment
    - Deploy secure cloud architectures
    - Configure container networking
    - Debug connectivity issues systematically
    - Communicate effectively about networking topics
    - Continue learning advanced networking (BGP, SD-WAN, service mesh, etc.)

    **Next Steps**:
    - Build hands-on projects (deploy 3-tier app in AWS)
    - Get AWS Certified (Solutions Architect or SysOps)
    - Explore advanced topics (Kubernetes CNI, service mesh, eBPF)
    - Practice troubleshooting in real scenarios
    - Keep networking diagrams and notes handy

    Remember: Networking is a journey, not a destination. Keep learning, keep building, and most importantly, keep troubleshooting! 🚀
  MARKDOWN

  lesson.key_concepts = JSON.generate([
    "VPC as isolated virtual network",
    "Public vs private subnets",
    "Internet Gateway for public internet access",
    "NAT Gateway for private subnet outbound access",
    "Security Groups (stateful, instance-level)",
    "Network ACLs (stateless, subnet-level)",
    "Multi-AZ high availability design",
    "VPC routing and route tables",
    "Cloud networking best practices"
  ])
end

ModuleItem.find_or_create_by!(
  course_module: day7_module,
  item: day7_lesson,
  sequence_order: 1
) do |item|
  item.required = true
end

puts "  ✓ Day 7 Module and Lesson"

puts "\n✅ One-Week Networking Fundamentals Course COMPLETE!"
puts "\n📚 Course Summary:"
puts "   Day 1: OSI Model in Practice"
puts "   Day 2: IP Addressing and Subnetting"
puts "   Day 3: Network Services (DNS, DHCP, NAT, Routing)"
puts "   Day 4: TCP/UDP, Ports, and Security"
puts "   Day 5: Troubleshooting Tools"
puts "   Day 6: Container Networking"
puts "   Day 7: Cloud VPC Networking"
puts "\n🎯 Total: 7 modules covering essential DevOps networking fundamentals"
