# Docker Containers Professional Bootcamp
# Generated from database on 2025-11-06
# Original slug: docker-containers-bootcamp

CourseBuilder::DSL.define('docker-containers-bootcamp') do
  course(
    title: "Docker Containers Professional Bootcamp",
    description: "7-week intensive Docker certification bootcamp preparing you for Docker Certified Associate (DCA) exam and real-world container deployments",
    difficulty_level: "beginner",
    estimated_hours: 40,
    certification_track: "docker"
  ) do

    # Plugin: progressive_learning
    plugin :progressive_learning, { enabled: true, hints: true }

    # Plugin: command_reference
    plugin :command_reference, { command_type: "docker" }

    # Course configuration
    config { theme: "docker-pro", prerequisites: "[\"Basic command-line knowledge (terminal/bash)\",\"Understanding of software development concepts\",\"Familiarity with web applications (helpful but not required)\",\"No prior Docker experience required\"]" }

    mod "Week 1: Introduction to Containers & Docker 🚀" do
      # Module: week-1-introduction-to-containers-docker

      lesson "What are Containers?" do
        content <<~MARKDOWN
          # What are Containers?
          
          ## Introduction
          
          Containers have revolutionized how we develop, ship, and run applications. But what exactly are they?
          
          ## Definition
          
          **A container is a lightweight, standalone, executable package** that includes everything needed to run a piece of software:
          - Application code
          - Runtime environment
          - System tools and libraries
          - Configuration files
          
          ## The Problem Containers Solve
          
          Before containers, developers faced the infamous **"It works on my machine"** problem:
          
          ```
          Developer's Laptop ✅  →  Staging Server ❌  →  Production ❌
          ```
          
          Different environments meant different configurations, dependencies, and system libraries - leading to unpredictable failures.
          
          ## How Containers Help
          
          Containers package the entire runtime environment, ensuring your application runs identically everywhere:
          
          ```
          Developer's Laptop ✅  →  Staging Server ✅  →  Production ✅
          ```
          
          ## Key Benefits
          
          ### 1. **Consistency Across Environments**
          - Same container runs on laptop, server, and cloud
          - Eliminates environment-specific bugs
          
          ### 2. **Isolation**
          - Each container runs independently
          - No conflicts between applications
          - Secure separation of processes
          
          ### 3. **Lightweight & Fast**
          - Containers share the host OS kernel
          - Start in seconds (vs minutes for VMs)
          - Minimal resource overhead
          
          ### 4. **Portability**
          - Run anywhere: Windows, Linux, macOS, cloud
          - No vendor lock-in
          - Easy migration between providers
          
          ### 5. **Efficiency**
          - Run dozens of containers on one host
          - Better resource utilization
          - Lower infrastructure costs
          
          ## Real-World Use Cases
          
          ### Microservices Architecture
          ```
          E-Commerce Platform:
          ├─ Frontend Container (React)
          ├─ API Gateway Container (Node.js)
          ├─ Product Service Container (Python)
          ├─ User Service Container (Go)
          ├─ Database Container (PostgreSQL)
          └─ Cache Container (Redis)
          ```
          
          ### CI/CD Pipelines
          - Build code in containers
          - Test in isolated environments
          - Deploy with confidence
          
          ### Development Environments
          - Onboard new developers in minutes
          - Consistent dev/prod environments
          - No "works on my machine" issues
          
          ## How Containers Work (Simplified)
          
          ```
          Application Code
               ↓
          Container Image (Template)
               ↓
          Running Container (Process)
          ```
          
          Containers use OS-level virtualization features:
          - **Namespaces**: Isolate processes, networking, filesystems
          - **Cgroups**: Limit CPU, memory, disk usage
          - **Union File Systems**: Layer filesystems efficiently
          
          ## Container vs Process
          
          A container is essentially a **fancy process** with:
          - Its own filesystem view
          - Isolated networking
          - Resource limits
          - Security boundaries
          
          ## The Container Ecosystem
          
          Modern containerization includes:
          - **Docker**: Container runtime and tooling
          - **Container Registries**: Image distribution (Docker Hub, ECR, GCR)
          - **Orchestrators**: Manage many containers (Kubernetes, Docker Swarm)
          - **Monitoring**: Track container health and metrics
          
          ## Why Containers Matter
          
          > "Containers are to modern infrastructure what shipping containers are to global trade - standardized, efficient, and transformative."
          
          Companies using containers report:
          - 70% faster deployment times
          - 50% better resource utilization
          - 60% reduction in environment-related bugs
          
          ## What's Next?
          
          Now that you understand what containers are, let's explore how they compare to traditional virtual machines - another popular virtualization technology.
        MARKDOWN
        estimated_minutes 15
      end

      lesson "Containers vs Virtual Machines" do
        content <<~MARKDOWN
          # Containers vs Virtual Machines
          
          ## The Virtualization Spectrum
          
          Both containers and virtual machines (VMs) provide isolation, but they do it differently:
          
          ```
          Physical Hardware → Virtualization Layer → Isolated Environments
          ```
          
          Let's understand the key differences.
          
          ## Architecture Comparison
          
          ### Virtual Machines
          
          ```
          ┌─────────────────────────────────────┐
          │         Application 1               │
          ├─────────────────────────────────────┤
          │         Guest OS (Full)             │
          ├─────────────────────────────────────┤
          │         Hypervisor                  │
          ├─────────────────────────────────────┤
          │         Host OS                     │
          ├─────────────────────────────────────┤
          │         Physical Hardware           │
          └─────────────────────────────────────┘
          ```
          
          **Each VM includes:**
          - Full operating system
          - Kernel
          - Systemd/init system
          - All system libraries
          
          ### Containers
          
          ```
          ┌─────────────────────────────────────┐
          │         Application 1               │
          ├─────────────────────────────────────┤
          │      Container Runtime (Docker)     │
          ├─────────────────────────────────────┤
          │         Host OS (Shared)            │
          ├─────────────────────────────────────┤
          │         Physical Hardware           │
          └─────────────────────────────────────┘
          ```
          
          **Each container includes:**
          - Application code
          - App-specific libraries only
          - **Shares host OS kernel**
          
          ## Key Differences
          
          | Aspect | Virtual Machines | Containers |
          |--------|-----------------|------------|
          | **Start Time** | Minutes | Seconds |
          | **Size** | GBs (5-20 GB typical) | MBs (50-500 MB typical) |
          | **Resource Usage** | Heavy | Lightweight |
          | **Isolation** | Hardware-level (stronger) | Process-level |
          | **OS** | Full OS per VM | Shared host OS |
          | **Density** | 10-50 per host | 100-1000+ per host |
          | **Boot Process** | Full OS boot | Process spawn |
          
          ## Performance Comparison
          
          ### Startup Speed
          ```
          VM:        Start → Boot OS → Load services → Ready (60-120s)
          Container: Start → Ready (1-3s)
          ```
          
          ### Resource Overhead
          ```
          Running 10 Web Applications:
          
          VMs:        10 GB RAM + 10 OS kernels = 40+ GB total
          Containers: 10 GB RAM + 1 OS kernel  = 12 GB total
          ```
          
          ## When to Use Virtual Machines
          
          ✅ **Use VMs when you need:**
          - Strong security isolation
          - Different operating systems on same host
          - Full OS-level control
          - Running legacy applications
          - Hardware-level virtualization
          
          **Example**: Multi-tenant cloud hosting where customers need complete OS isolation
          
          ## When to Use Containers
          
          ✅ **Use Containers when you need:**
          - Fast deployment and scaling
          - Microservices architecture
          - CI/CD pipelines
          - Development consistency
          - Maximum resource efficiency
          
          **Example**: Modern web applications with multiple services
          
          ## Can You Use Both?
          
          **Absolutely!** Many organizations run containers inside VMs:
          
          ```
          Cloud Provider (AWS/Azure/GCP)
              ↓
          Virtual Machine (EC2/VM)
              ↓
          Docker Engine
              ↓
          Multiple Containers
          ```
          
          This provides:
          - Strong isolation (VM)
          - Fast deployment (Containers)
          - Best of both worlds
          
          ## The Hybrid Approach
          
          ```
          Production Infrastructure:
          ├─ VM 1 (Web Tier)
          │  ├─ Container: Frontend (React)
          │  └─ Container: API Gateway (Node.js)
          ├─ VM 2 (Application Tier)
          │  ├─ Container: User Service (Python)
          │  └─ Container: Product Service (Go)
          └─ VM 3 (Data Tier)
             └─ Container: PostgreSQL
          ```
          
          ## Security Considerations
          
          ### VM Isolation (Stronger)
          - Complete OS separation
          - Harder to escape to host
          - Better for untrusted workloads
          
          ### Container Isolation (Good, but requires care)
          - Shares kernel with host
          - Proper configuration essential
          - Use security best practices
          
          ## Cost Implications
          
          **VMs:**
          - Higher infrastructure costs
          - More hardware required
          - Better for steady-state workloads
          
          **Containers:**
          - Lower infrastructure costs
          - Higher density = better ROI
          - Better for variable workloads
          
          ## Real-World Example
          
          **Netflix:**
          - Runs containers inside AWS VMs
          - Gets security from VMs
          - Gets agility from containers
          - Handles billions of requests
          
          ## The Future: Hybrid
          
          Modern infrastructure often combines:
          - **VMs** for isolation and security boundaries
          - **Containers** for application deployment
          - **Orchestration** (Kubernetes) to manage it all
          
          ## Summary
          
          Containers and VMs serve different purposes:
          - VMs: Strong isolation, full OS control
          - Containers: Fast, efficient, portable
          
          **The best solution?** Often it's using both together!
          
          ## What's Next?
          
          Now that you understand containers and how they differ from VMs, let's dive into Docker - the most popular container platform.
        MARKDOWN
        estimated_minutes 15
      end

      lesson "Introduction to Docker" do
        content <<~MARKDOWN
          # Introduction to Docker
          
          ## What is Docker?
          
          **Docker** is an open-source platform that automates the deployment of applications inside containers. It's the most popular containerization tool in the world.
          
          > "Docker makes containers easy to create, deploy, and run."
          
          ## Docker History
          
          - **2013**: Docker Inc. releases Docker as open source
          - **2015**: Docker Compose and Docker Swarm launched
          - **2016**: Docker reaches 10 billion container downloads
          - **2020**: Docker Desktop has 2+ million users
          - **Today**: Industry standard for containerization
          
          ## Docker Architecture
          
          Docker uses a **client-server architecture**:
          
          ```
          ┌──────────────┐         ┌──────────────────┐
          │ Docker CLI   │────────▶│ Docker Daemon    │
          │ (Client)     │         │ (Server)         │
          └──────────────┘         └──────────────────┘
                                            │
                                            ▼
                                   ┌──────────────────┐
                                   │  Containers       │
                                   │  Images           │
                                   │  Networks         │
                                   │  Volumes          │
                                   └──────────────────┘
          ```
          
          ## Core Components
          
          ### 1. Docker Daemon (`dockerd`)
          - Background service that manages Docker objects
          - Creates and runs containers
          - Manages images, networks, volumes
          - Listens for Docker API requests
          
          ### 2. Docker Client (`docker`)
          - Command-line interface you interact with
          - Sends commands to Docker daemon
          - Can connect to remote daemons
          
          ### 3. Docker Registry
          - Stores Docker images
          - Docker Hub: public registry
          - Private registries: AWS ECR, Azure ACR, Google GCR
          
          ### 4. Docker Objects
          
          **Images:**
          - Read-only templates for creating containers
          - Built from Dockerfiles
          - Can be shared via registries
          
          **Containers:**
          - Runnable instances of images
          - Can be started, stopped, moved, deleted
          - Isolated from other containers
          
          **Networks:**
          - Enable container communication
          - Multiple network drivers available
          - Can be user-defined or default
          
          **Volumes:**
          - Persistent data storage
          - Survive container deletion
          - Shared between containers
          
          ## How Docker Works
          
          ### Workflow:
          ```
          1. Write Dockerfile
               ↓
          2. Build Image
               ↓
          3. Push to Registry (optional)
               ↓
          4. Pull Image
               ↓
          5. Run Container
          ```
          
          ### Example Flow:
          ```bash
          # 1. Build an image
          docker build -t myapp:v1 .
          
          # 2. Run a container
          docker run -d -p 8080:80 myapp:v1
          
          # 3. Check running containers
          docker ps
          
          # 4. View logs
          docker logs <container-id>
          
          # 5. Stop container
          docker stop <container-id>
          ```
          
          ## Docker Engine Components
          
          ```
          ┌─────────────────────────────────────┐
          │         Docker CLI                  │
          └─────────────────────────────────────┘
                        │
                        ▼
          ┌─────────────────────────────────────┐
          │      Docker REST API                │
          └─────────────────────────────────────┘
                        │
                        ▼
          ┌─────────────────────────────────────┐
          │         Docker Daemon               │
          │  ┌──────────────────────────────┐   │
          │  │      containerd              │   │
          │  │  ┌────────────────────────┐  │   │
          │  │  │       runc             │  │   │
          │  │  │ (Container Runtime)    │  │   │
          │  │  └────────────────────────┘  │   │
          │  └──────────────────────────────┘   │
          └─────────────────────────────────────┘
          ```
          
          - **Docker CLI**: User interface
          - **REST API**: Communication protocol
          - **Docker Daemon**: Core engine
          - **containerd**: Container lifecycle management
          - **runc**: Low-level container runtime
          
          ## Docker Desktop vs Docker Engine
          
          ### Docker Engine (Linux)
          - Server-side daemon
          - CLI tools
          - Runs on Linux natively
          
          ### Docker Desktop (Windows/Mac)
          - Docker Engine in a VM
          - GUI dashboard
          - Easier installation
          - Better developer experience
          
          ## Docker Hub
          
          **The world's largest container registry:**
          - 100,000+ official images
          - Millions of community images
          - Free public repositories
          - Paid private repositories
          
          Popular images:
          - `nginx`: Web server
          - `mysql`: Database
          - `python`: Python runtime
          - `node`: Node.js runtime
          - `ubuntu`: Ubuntu OS
          
          ## Docker Commands Overview
          
          ```bash
          # Container Management
          docker run          # Create and start container
          docker ps           # List running containers
          docker stop         # Stop container
          docker rm           # Remove container
          
          # Image Management
          docker images       # List images
          docker pull         # Download image
          docker build        # Build image
          docker push         # Upload image
          
          # System Information
          docker version      # Show Docker version
          docker info         # Display system info
          docker help         # Get help
          ```
          
          ## Docker Editions
          
          ### Docker Community Edition (CE)
          - Free and open source
          - Ideal for developers
          - Regular updates
          
          ### Docker Enterprise Edition (EE)
          - Paid version
          - Enterprise support
          - Additional security features
          - Advanced management
          
          ## Why Docker Became Popular
          
          1. **Ease of Use**: Simple commands, great documentation
          2. **Ecosystem**: Huge community and image library
          3. **Portability**: Run anywhere Docker runs
          4. **Developer Productivity**: Fast iteration cycles
          5. **DevOps Enabler**: Bridge between dev and ops
          6. **Open Source**: Transparent and extensible
          
          ## Docker vs Other Container Tools
          
          | Tool | Focus | Pros |
          |------|-------|------|
          | **Docker** | Developer experience | Easy, popular, mature |
          | **Podman** | Daemonless containers | No root required |
          | **LXC/LXD** | System containers | Full OS containers |
          | **rkt** | Security | Strong isolation (deprecated) |
          
          ## Real-World Docker Usage
          
          **Companies using Docker:**
          - PayPal: 700+ applications containerized
          - Spotify: Deploys 10,000+ containers daily
          - Uber: Entire platform runs on containers
          - Netflix: Thousands of containers in production
          
          ## Docker Certification
          
          **Docker Certified Associate (DCA):**
          - Official Docker certification
          - Validates container expertise
          - Covers Docker fundamentals to orchestration
          - Industry-recognized credential
          
          This bootcamp prepares you for the DCA exam!
          
          ## Summary
          
          Docker is:
          - Industry-standard container platform
          - Client-server architecture
          - Consists of daemon, CLI, registry, objects
          - Makes containerization accessible
          - Foundation for modern DevOps
          
          ## What's Next?
          
          Now that you understand Docker's architecture, let's clarify the relationship between Docker images and containers - a crucial concept.
        MARKDOWN
        estimated_minutes 20
      end

      lesson "Understanding Images vs Containers" do
        content <<~MARKDOWN
          # Understanding Images vs Containers
          
          ## The Core Concept
          
          One of the most important concepts in Docker is understanding the relationship between **images** and **containers**.
          
          ```
          Image (Template) ──────▶ Container (Running Instance)
             📦                         🏃
          ```
          
          ## What is a Docker Image?
          
          A Docker image is a **read-only template** containing:
          - Application code
          - Runtime environment
          - System libraries
          - Dependencies
          - Configuration files
          - Metadata
          
          Think of it like:
          - 📸 A photograph (static snapshot)
          - 📝 A recipe (instructions)
          - 💿 An ISO file (template)
          
          ### Image Characteristics:
          - ✅ Immutable (cannot be changed)
          - ✅ Shareable (can be distributed)
          - ✅ Layered (built in layers)
          - ✅ Reusable (create many containers)
          
          ## What is a Docker Container?
          
          A Docker container is a **running instance** of an image:
          - Active process
          - Writable filesystem layer
          - Network configuration
          - Resource allocation
          
          Think of it like:
          - 🎬 A running program
          - 🍰 A cake baked from a recipe
          - 💻 A booted operating system
          
          ### Container Characteristics:
          - ✅ Mutable (can be modified)
          - ✅ Ephemeral (temporary by default)
          - ✅ Isolated (runs independently)
          - ✅ Stateful (holds runtime data)
          
          ## The Relationship
          
          ```
          One Image → Many Containers
          
          nginx:latest (Image)
               │
               ├─────▶ Container 1 (web-server-1)
               ├─────▶ Container 2 (web-server-2)
               └─────▶ Container 3 (web-server-3)
          ```
          
          ### Analogy: Class vs Objects
          ```java
          // Image is like a Class definition
          class WebServer {
            // Template definition
          }
          
          // Containers are like Object instances
          WebServer server1 = new WebServer();
          WebServer server2 = new WebServer();
          WebServer server3 = new WebServer();
          ```
          
          ## Image Layers
          
          Images are built in **layers**, like a stack:
          
          ```
          ┌────────────────────────────┐
          │  Application Layer         │ ← Your code
          ├────────────────────────────┤
          │  Dependencies Layer        │ ← npm install
          ├────────────────────────────┤
          │  Node.js Layer             │ ← node:14
          ├────────────────────────────┤
          │  Base OS Layer             │ ← Ubuntu
          └────────────────────────────┘
          ```
          
          Each layer is:
          - Read-only
          - Cached for efficiency
          - Shared between images
          
          ### Benefits of Layers:
          1. **Efficient Storage**: Shared layers save space
          2. **Fast Builds**: Cached layers speed up rebuilds
          3. **Quick Distribution**: Only changed layers transfer
          
          ## Container Writable Layer
          
          When you run a container, Docker adds a thin **writable layer** on top:
          
          ```
          ┌────────────────────────────┐
          │  Writable Layer (NEW!)     │ ← Container changes
          ├────────────────────────────┤
          │  Application Layer         │ ← Read-only
          ├────────────────────────────┤
          │  Dependencies Layer        │ ← Read-only
          ├────────────────────────────┤
          │  Runtime Layer             │ ← Read-only
          └────────────────────────────┘
          ```
          
          - Writable layer stores container-specific changes
          - Deleted when container is removed
          - Does NOT modify the image
          
          ## Lifecycle Comparison
          
          ### Image Lifecycle:
          ```
          Build → Tag → Push → Pull → Delete
             ↓
          Exists until explicitly deleted
          ```
          
          ### Container Lifecycle:
          ```
          Create → Start → Stop → Restart → Remove
             ↓
          Ephemeral - designed to be temporary
          ```
          
          ## Commands Comparison
          
          ### Image Commands:
          ```bash
          docker images          # List images
          docker pull nginx      # Download image
          docker build -t app .  # Build image
          docker rmi nginx       # Remove image
          docker image inspect   # View image details
          ```
          
          ### Container Commands:
          ```bash
          docker ps              # List running containers
          docker run nginx       # Create & start container
          docker stop web        # Stop container
          docker rm web          # Remove container
          docker container inspect # View container details
          ```
          
          ## Image Naming Convention
          
          ```
          registry/repository:tag
          
          Example: docker.io/library/nginx:1.21-alpine
                   │        │      │     │
                   │        │      │     └─ Tag (version)
                   │        │      └─────── Image name
                   │        └────────────── Repository
                   └─────────────────────── Registry
          ```
          
          ### Common Patterns:
          ```
          nginx                  # Official image, latest tag
          nginx:1.21             # Specific version
          nginx:alpine           # Alpine Linux variant
          myuser/myapp:v1        # User repository
          gcr.io/project/app:1.0 # Google Container Registry
          ```
          
          ## Image Size Matters
          
          ```
          ubuntu:latest         → 77 MB
          ubuntu:20.04          → 77 MB
          alpine:latest         → 5 MB    ← Smallest!
          node:14               → 942 MB
          node:14-alpine        → 117 MB  ← Much smaller!
          ```
          
          **Best Practice**: Use Alpine-based images for smaller sizes
          
          ## Image vs Container Storage
          
          ### Where are they stored?
          
          **Images:**
          ```
          /var/lib/docker/image/
          /var/lib/docker/overlay2/
          ```
          
          **Containers:**
          ```
          /var/lib/docker/containers/
          ```
          
          ## Practical Example
          
          Let's see the relationship in action:
          
          ```bash
          # 1. Pull an image (download template)
          $ docker pull nginx:alpine
          
          # 2. List images
          $ docker images
          REPOSITORY   TAG      SIZE
          nginx        alpine   23.4MB
          
          # 3. Create multiple containers from same image
          $ docker run -d --name web1 nginx:alpine
          $ docker run -d --name web2 nginx:alpine
          $ docker run -d --name web3 nginx:alpine
          
          # 4. List containers
          $ docker ps
          CONTAINER ID   IMAGE          NAMES
          abc123...      nginx:alpine   web1
          def456...      nginx:alpine   web2
          ghi789...      nginx:alpine   web3
          
          # 5. Each container is independent
          $ docker exec web1 hostname  # Returns: abc123...
          $ docker exec web2 hostname  # Returns: def456...
          ```
          
          ## Key Differences Summary
          
          | Aspect | Image | Container |
          |--------|-------|-----------|
          | **Nature** | Template | Running instance |
          | **State** | Immutable | Mutable |
          | **Storage** | Permanent | Ephemeral |
          | **Quantity** | One per application | Many per image |
          | **File System** | Read-only layers | Read-only + writable layer |
          | **Purpose** | Distribution | Execution |
          | **Creation** | Build/Pull | Run |
          
          ## Common Misunderstandings
          
          ❌ **Myth**: "Deleting a container deletes the image"
          ✅ **Truth**: Images and containers are independent
          
          ❌ **Myth**: "Changes to a container modify the image"
          ✅ **Truth**: Container changes only affect that container
          
          ❌ **Myth**: "I need to rebuild the image to run another container"
          ✅ **Truth**: One image can spawn unlimited containers
          
          ## When Do You Need Images?
          
          You need images when:
          - Sharing applications
          - Deploying to production
          - Version controlling applications
          - Distributing software
          
          ## When Do You Need Containers?
          
          You need containers when:
          - Running applications
          - Testing code
          - Development environments
          - Production workloads
          
          ## The Big Picture
          
          ```
          Developer Workflow:
          
          1. Write Code
               ↓
          2. Create Dockerfile (defines image)
               ↓
          3. Build Image (docker build)
               ↓
          4. Push to Registry (docker push)
               ↓
          5. Pull Image on Server (docker pull)
               ↓
          6. Run Container (docker run)
               ↓
          7. Application Running!
          ```
          
          ## Summary
          
          - **Images** are templates (recipes)
          - **Containers** are running instances (cakes)
          - One image → many containers
          - Images are immutable, containers are mutable
          - Images are permanent, containers are ephemeral
          - Understanding this relationship is crucial for Docker mastery
          
          ## What's Next?
          
          Now that you understand the theory, it's time to get hands-on! In the next lab, you'll run your first Docker container and experience these concepts firsthand.
        MARKDOWN
        estimated_minutes 20
      end

      lab "Hello Container!", lab_type: "docker" do
        description "Welcome to your first hands-on Docker lab! In this exercise, you'll:\n\n1. Verify Docker is installed and running\n2. Pull and run the classic \"hello-world\" container\n3. Explore running and stopped containers\n4. Understand the container lifecycle\n\nThis lab introduces you to basic Docker commands you'll use throughout the bootcamp.\n"

        step "Verify Docker Installation" do
          instruction "Check that Docker is installed and the daemon is running"
          command "docker version"
          hint "This command shows both client and server (daemon) versions"
        end

        step "Check Docker System Information" do
          instruction "View detailed information about your Docker installation"
          command "docker info"
          hint "Look for the number of containers and images"
        end

        step "Run Hello World Container" do
          instruction "Pull and run the official Docker hello-world image"
          command "docker run hello-world"
          hint "Docker will automatically pull the image if it doesn't exist locally"
        end

        step "List Running Containers" do
          instruction "Check which containers are currently running"
          command "docker ps"
          hint "The hello-world container exits immediately, so it won't appear here"
        end

        step "List All Containers" do
          instruction "View all containers, including stopped ones"
          command "docker ps -a"
          hint "The -a flag shows containers in all states"
        end

        step "List Downloaded Images" do
          instruction "See what images are now stored locally"
          command "docker images"
          hint "You should see the hello-world image"
        end

        step "Run Nginx Web Server" do
          instruction "Start a more substantial container - an nginx web server"
          command "docker run -d --name my-nginx -p 8080:80 nginx:alpine"
          hint "-d runs in detached mode, -p maps ports, --name gives it a memorable name"
        end

        step "Verify Nginx is Running" do
          instruction "Check that the nginx container is actively running"
          command "docker ps"
          hint "You should now see my-nginx in the list"
        end

        step "View Nginx Logs" do
          instruction "Check the logs from the nginx container"
          command "docker logs my-nginx"
          hint "Logs show stdout/stderr from the container"
        end

        step "Stop the Nginx Container" do
          instruction "Gracefully stop the running nginx container"
          command "docker stop my-nginx"
          hint "This sends SIGTERM signal to stop the container"
        end

        step "Verify Container Stopped" do
          instruction "Confirm the container is no longer running"
          command "docker ps"
          hint "my-nginx should not appear in running containers"
        end

        step "Check All Containers Again" do
          instruction "View both running and stopped containers"
          command "docker ps -a"
          hint "my-nginx should now show as Exited"
        end

        difficulty "easy"
        estimated_minutes 30
      end

      quiz "Week 1 Review: Containers & Docker Fundamentals" do
        description "Test your understanding of containerization concepts, Docker architecture, and the relationship between images and containers"

        question do
          text "What is a container?"
          type "mcq"
          correct_answer "A lightweight, standalone package that includes everything needed to run software"
          explanation "Containers are lightweight, standalone packages that include application code, runtime, system tools, libraries, and settings - everything needed to run the software."
        end

        question do
          text "What is the main advantage of containers over virtual machines?"
          type "mcq"
          correct_answer "Containers are faster and more lightweight because they share the host OS kernel"
          explanation "Containers share the host operating system's kernel, making them much lighter and faster than VMs which each require a full operating system."
        end

        question do
          text "What is the Docker daemon responsible for?"
          type "mcq"
          correct_answer "Managing Docker objects like containers, images, networks, and volumes"
          explanation "The Docker daemon (dockerd) is the background service that manages all Docker objects including containers, images, networks, and volumes."
        end

        question do
          text "What is the relationship between Docker images and containers?"
          type "mcq"
          correct_answer "An image is a template, and containers are running instances of images"
          explanation "Docker images are read-only templates, while containers are running instances created from those images. One image can create many containers."
        end

        question do
          text "Docker containers share the host operating system's kernel."
          type "true_false"
          correct_answer "true"
          explanation "True. Unlike VMs, containers share the host OS kernel, which makes them lightweight and fast to start."
        end

        question do
          text "When you delete a container, the image it was created from is also deleted."
          type "true_false"
          correct_answer "false"
          explanation "False. Images and containers are independent. Deleting a container does not affect the image it was created from."
        end

        question do
          text "Docker images are mutable and can be changed after creation."
          type "true_false"
          correct_answer "false"
          explanation "False. Docker images are immutable (read-only). Any changes happen in a container's writable layer, not the image itself."
        end

        question do
          text "What does the command 'docker ps -a' do?"
          type "mcq"
          correct_answer "Lists all containers, both running and stopped"
          explanation "The -a flag shows all containers regardless of their state (running, stopped, exited, etc.)."
        end

        question do
          text "Which Docker component stores Docker images?"
          type "mcq"
          correct_answer "Docker Registry (like Docker Hub)"
          explanation "Docker registries store Docker images. Docker Hub is the public registry, but private registries also exist."
        end

        question do
          text "What happens when you run 'docker run hello-world' for the first time?"
          type "mcq"
          correct_answer "Docker pulls the image from Docker Hub and runs a container"
          explanation "When you run a container from an image that doesn't exist locally, Docker automatically pulls it from the registry (Docker Hub by default) and then runs it."
        end

        passing_score 70
        max_attempts 3
      end

    end

    mod "Week 2: Running and Managing Containers 🏗️" do
      # Module: week-2-running-and-managing-containers

      lesson "Docker Run Command Deep Dive" do
        content <<~MARKDOWN
          # Docker Run Command Deep Dive
          
          The `docker run` command is the cornerstone of Docker. It combines image pulling, container creation, and container startup into one powerful command.
          
          ## Basic Syntax
          ```bash
          docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
          ```
          
          ## Essential Options
          
          **Detached Mode (-d)**
          ```bash
          docker run -d nginx
          # Runs in background, returns container ID
          ```
          
          **Interactive Terminal (-it)**
          ```bash
          docker run -it ubuntu bash
          # Opens interactive shell inside container
          ```
          
          **Port Mapping (-p)**
          ```bash
          docker run -p 8080:80 nginx
          # Maps host port 8080 to container port 80
          ```
          
          **Named Containers (--name)**
          ```bash
          docker run --name my-web nginx
          # Easier to reference than container ID
          ```
          
          **Environment Variables (-e)**
          ```bash
          docker run -e NODE_ENV=production node
          # Sets environment variables inside container
          ```
          
          **Auto-remove (--rm)**
          ```bash
          docker run --rm alpine echo "hello"
          # Container automatically removed after exit
          ```
          
          ## Best Practices
          
          1. **Always name production containers**
          2. **Use specific image tags** (not :latest)
          3. **Set resource limits** (--memory, --cpus)
          4. **Use health checks** (--health-cmd)
          5. **Implement restart policies** (--restart)
        MARKDOWN
        estimated_minutes 20
      end

      lesson "Container Lifecycle Management" do
        content <<~MARKDOWN
          # Container Lifecycle Management
          
          Understanding the container lifecycle is crucial for effective Docker usage.
          
          ## Container States
          
          ```
          Created → Running → Paused → Stopped → Removed
          ```
          
          ## Key Commands
          
          **Start/Stop**
          ```bash
          docker start container_name
          docker stop container_name    # Graceful (SIGTERM)
          docker kill container_name    # Forceful (SIGKILL)
          ```
          
          **Restart**
          ```bash
          docker restart container_name
          # Equivalent to stop + start
          ```
          
          **Pause/Unpause**
          ```bash
          docker pause container_name
          docker unpause container_name
          # Freezes processes without stopping
          ```
          
          **Remove**
          ```bash
          docker rm container_name        # Remove stopped container
          docker rm -f container_name     # Force remove running container
          docker rm $(docker ps -aq)      # Remove all containers
          ```
          
          ## Restart Policies
          
          - **no**: Don't automatically restart (default)
          - **on-failure**: Restart on non-zero exit
          - **unless-stopped**: Always restart unless manually stopped
          - **always**: Always restart
        MARKDOWN
        estimated_minutes 15
      end

      lesson "Inspecting and Monitoring Containers" do
        content <<~MARKDOWN
          # Inspecting and Monitoring Containers
          
          ## Viewing Container Details
          
          **docker inspect**
          ```bash
          docker inspect container_name
          # Returns detailed JSON configuration
          ```
          
          **docker stats**
          ```bash
          docker stats
          # Real-time resource usage statistics
          ```
          
          **docker top**
          ```bash
          docker top container_name
          # Shows running processes inside container
          ```
          
          **docker logs**
          ```bash
          docker logs container_name          # View all logs
          docker logs -f container_name       # Follow logs (tail -f)
          docker logs --tail 100 container_name  # Last 100 lines
          docker logs --since 1h container_name  # Logs from last hour
          ```
          
          ## Health Checks
          
          Define health checks in Dockerfile or docker run:
          ```bash
          docker run --health-cmd="curl -f http://localhost/ || exit 1"            --health-interval=30s            nginx
          ```
          
          ## Best Practices
          
          1. Always check logs when troubleshooting
          2. Use health checks for production containers
          3. Monitor resource usage with docker stats
          4. Set up centralized logging (ELK, Fluentd)
        MARKDOWN
        estimated_minutes 20
      end

      lesson "Executing Commands in Containers" do
        content <<~MARKDOWN
          # Executing Commands in Containers
          
          ## docker exec
          
          Run commands inside running containers:
          
          **Interactive Shell**
          ```bash
          docker exec -it container_name bash
          # Opens interactive shell (most common use)
          ```
          
          **Single Commands**
          ```bash
          docker exec container_name ls -la /app
          docker exec container_name cat /etc/hostname
          ```
          
          **As Different User**
          ```bash
          docker exec -u root container_name apt-get update
          # Execute with elevated privileges
          ```
          
          ## exec vs attach
          
          - **exec**: Starts new process in container
          - **attach**: Connects to main process (PID 1)
          
          ## Common Patterns
          
          **Database Access**
          ```bash
          docker exec -it mysql-container mysql -u root -p
          ```
          
          **File Inspection**
          ```bash
          docker exec app-container cat /var/log/app.log
          ```
          
          **Debugging**
          ```bash
          docker exec -it app-container sh
          # Troubleshoot inside container
          ```
        MARKDOWN
        estimated_minutes 15
      end

      lesson "Managing Docker Images" do
        content <<~MARKDOWN
          # Managing Docker Images
          
          ## Image Commands
          
          **List Images**
          ```bash
          docker images
          docker images -a    # Include intermediate images
          ```
          
          **Pull Images**
          ```bash
          docker pull nginx:alpine
          docker pull ubuntu:20.04
          ```
          
          **Remove Images**
          ```bash
          docker rmi image_name
          docker rmi $(docker images -q)  # Remove all images
          docker image prune              # Remove dangling images
          ```
          
          **Tag Images**
          ```bash
          docker tag nginx:alpine myregistry/nginx:v1
          ```
          
          **Image Information**
          ```bash
          docker image inspect nginx
          docker image history nginx  # Show layer history
          ```
          
          ## Best Practices
          
          1. Regularly clean up unused images
          2. Use multi-stage builds for smaller images
          3. Prefer Alpine-based images
          4. Tag images with semantic versions
          5. Scan images for vulnerabilities
        MARKDOWN
        estimated_minutes 15
      end

      lab "Deploy and Manage Web Server", lab_type: "docker" do
        description "In this lab, you'll deploy an Nginx web server and practice essential container management skills including starting, stopping, inspecting, and monitoring containers.\n"

        step "Run Nginx in Detached Mode" do
          instruction "Start an nginx web server in the background with port mapping"
          command "docker run -d --name web-server -p 8080:80 nginx:alpine"
          hint "-d runs detached, -p maps ports, --name assigns a friendly name"
        end

        step "Verify Container is Running" do
          instruction "List running containers to confirm web-server is active"
          command "docker ps"
        end

        step "Inspect Container Details" do
          instruction "View detailed configuration of the web-server container"
          command "docker inspect web-server"
          hint "Look for IPAddress, ports, and environment variables in the JSON output"
        end

        step "Check Container Logs" do
          instruction "View the logs from the nginx container"
          command "docker logs web-server"
        end

        step "Execute Command Inside Container" do
          instruction "Run a command inside the container to see nginx version"
          command "docker exec web-server nginx -v"
        end

        step "Open Interactive Shell" do
          instruction "Access the container's shell interactively"
          command "docker exec -it web-server sh"
          hint "Alpine Linux uses 'sh' instead of 'bash'"
        end

        step "View Container Resource Usage" do
          instruction "Check CPU and memory usage of the container"
          command "docker stats web-server --no-stream"
          hint "--no-stream shows stats once instead of continuously"
        end

        step "Stop the Container Gracefully" do
          instruction "Stop the nginx container with graceful shutdown"
          command "docker stop web-server"
        end

        step "Restart the Container" do
          instruction "Start the stopped container again"
          command "docker start web-server"
        end

        step "Follow Logs in Real-time" do
          instruction "Watch logs as they happen (Ctrl+C to exit)"
          command "docker logs -f web-server"
          hint "Try accessing http://localhost:8080 in another terminal to generate logs"
        end

        step "Stop and Remove Container" do
          instruction "Stop the container and remove it"
          command "docker stop web-server && docker rm web-server"
        end

        step "Cleanup Images" do
          instruction "List images and optionally clean up"
          command "docker images"
        end

        difficulty "easy"
        estimated_minutes 40
      end

      quiz "Week 2 Review: Container Management" do
        description "Test your knowledge of container lifecycle, monitoring, and management"

        question do
          text "What does the -d flag do in 'docker run -d nginx'?"
          type "mcq"
          correct_answer "Runs the container in detached mode (background)"
          explanation "The -d flag runs containers in detached mode, freeing up your terminal."
        end

        question do
          text "docker exec starts a new process inside a running container"
          type "true_false"
          correct_answer "true"
          explanation "True. docker exec launches a new process in an existing container, unlike attach which connects to the main process."
        end

        question do
          text "Which command shows real-time resource usage of containers?"
          type "mcq"
          correct_answer "docker stats"
          explanation "docker stats shows live CPU, memory, network, and disk usage for running containers."
        end

        question do
          text "What's the difference between 'docker stop' and 'docker kill'?"
          type "mcq"
          correct_answer "stop sends SIGTERM (graceful), kill sends SIGKILL (forceful)"
          explanation "docker stop allows graceful shutdown (SIGTERM), while docker kill forces immediate termination (SIGKILL)."
        end

        question do
          text "Removing a container also removes the image it was created from"
          type "true_false"
          correct_answer "false"
          explanation "False. Containers and images are independent. Removing a container doesn't affect its image."
        end

        passing_score 70
        max_attempts 3
      end

    end

    mod "Week 3: Docker Images and Dockerfiles 📝" do
      # Module: week-3-docker-images-and-dockerfiles

      lesson "Understanding Image Layers" do
        content <<~MARKDOWN
          # Understanding Image Layers
          
          Docker images are built in layers, and understanding this is key to optimization.
          
          ## Layer Architecture
          
          Each Dockerfile instruction creates a new layer:
          
          ```dockerfile
          FROM ubuntu:20.04        # Layer 1: Base OS
          RUN apt-get update       # Layer 2: Update packages
          RUN apt-get install -y nginx  # Layer 3: Install nginx
          COPY app /app            # Layer 4: Add application
          ```
          
          ## Benefits of Layers
          
          1. **Efficient Storage**: Layers are shared between images
          2. **Fast Builds**: Unchanged layers use cache
          3. **Quick Distribution**: Only new layers are transferred
          
          ## Layer Caching
          
          Docker caches layers during builds. If a layer hasn't changed, Docker reuses it.
          
          **Cache Busting**: Any change invalidates that layer and all subsequent layers.
          
          ## Best Practices
          
          - Order Dockerfile commands from least to most frequently changing
          - Combine commands to reduce layers
          - Use .dockerignore to exclude unnecessary files
        MARKDOWN
        estimated_minutes 25
      end

      lesson "Dockerfile Syntax and Best Practices" do
        content <<~MARKDOWN
          # Dockerfile Syntax and Best Practices
          
          ## Essential Instructions
          
          **FROM**: Base image
          ```dockerfile
          FROM node:14-alpine
          ```
          
          **WORKDIR**: Set working directory
          ```dockerfile
          WORKDIR /app
          ```
          
          **COPY**: Copy files from host
          ```dockerfile
          COPY package*.json ./
          COPY . .
          ```
          
          **RUN**: Execute commands during build
          ```dockerfile
          RUN npm install
          RUN apt-get update && apt-get install -y curl
          ```
          
          **CMD**: Default command to run
          ```dockerfile
          CMD ["npm", "start"]
          ```
          
          **ENTRYPOINT**: Configure container executable
          ```dockerfile
          ENTRYPOINT ["python", "app.py"]
          ```
          
          **EXPOSE**: Document port usage
          ```dockerfile
          EXPOSE 3000
          ```
          
          **ENV**: Set environment variables
          ```dockerfile
          ENV NODE_ENV=production
          ```
          
          ## Example: Node.js Application
          
          ```dockerfile
          FROM node:14-alpine
          
          WORKDIR /app
          
          # Copy dependency files first (better caching)
          COPY package*.json ./
          
          # Install dependencies
          RUN npm ci --only=production
          
          # Copy application code
          COPY . .
          
          # Expose port
          EXPOSE 3000
          
          # Start application
          CMD ["npm", "start"]
          ```
          
          ## Best Practices
          
          1. Use specific base image tags
          2. Minimize layer count
          3. Leverage build cache
          4. Use .dockerignore
          5. Don't run as root
          6. Use multi-stage builds
        MARKDOWN
        estimated_minutes 30
      end

      lesson "Building Custom Images" do
        content <<~MARKDOWN
          # Building Custom Images
          
          ## docker build Command
          
          ```bash
          docker build -t myapp:v1 .
          ```
          
          - `-t`: Tag the image
          - `.`: Build context (current directory)
          
          ## Build Process
          
          1. Docker reads Dockerfile
          2. Creates temporary container for each instruction
          3. Runs instruction in container
          4. Commits result as new layer
          5. Removes temporary container
          6. Repeats for each instruction
          
          ## Build Arguments
          
          **ARG**: Build-time variables
          ```dockerfile
          ARG VERSION=1.0
          FROM node:${VERSION}
          ```
          
          ```bash
          docker build --build-arg VERSION=14 -t myapp .
          ```
          
          ## Build Context
          
          - All files in build directory sent to Docker daemon
          - Use .dockerignore to exclude files
          - Keep build context small for faster builds
          
          ## Multi-Stage Builds
          
          Reduce final image size:
          
          ```dockerfile
          # Build stage
          FROM node:14 AS builder
          WORKDIR /app
          COPY . .
          RUN npm install && npm run build
          
          # Production stage
          FROM node:14-alpine
          WORKDIR /app
          COPY --from=builder /app/dist ./dist
          CMD ["node", "dist/index.js"]
          ```
        MARKDOWN
        estimated_minutes 25
      end

      lab "Build Custom Web Application", lab_type: "docker" do
        description "Build a custom Docker image for a Node.js web application using best practices.\n"

        step "Create Project Directory" do
          instruction "Create a directory for the Node.js application"
          command "mkdir -p ~/myapp && cd ~/myapp"
        end

        step "Create Simple Node App" do
          instruction "Create a basic package.json file"
          command "echo '{\"name\":\"myapp\",\"version\":\"1.0.0\",\"scripts\":{\"start\":\"node server.js\"}}' > package.json"
        end

        step "Create Basic Dockerfile" do
          instruction "Write a Dockerfile for the Node.js app"
          command "echo 'FROM node:14-alpine\nWORKDIR /app\nCOPY package*.json ./\nRUN npm install\nCOPY . .\nEXPOSE 3000\nCMD [\"npm\",\"start\"]' > Dockerfile"
        end

        step "Build the Image" do
          instruction "Build the Docker image with a tag"
          command "docker build -t myapp:v1 ."
          hint "The . specifies the build context (current directory)"
        end

        step "Verify Image Was Created" do
          instruction "List images to confirm myapp:v1 exists"
          command "docker images | grep myapp"
        end

        difficulty "medium"
        estimated_minutes 45
      end

      quiz "Week 3 Review: Docker Images and Dockerfiles" do
        description "Test your knowledge of Dockerfiles, image layers, and building custom images"

        question do
          text "What does each instruction in a Dockerfile create?"
          type "mcq"
          correct_answer "A new layer in the image"
          explanation "Each Dockerfile instruction creates a new read-only layer in the image."
        end

        question do
          text "Docker caches layers during builds to speed up subsequent builds"
          type "true_false"
          correct_answer "true"
          explanation "True. Docker caches unchanged layers, making rebuilds much faster."
        end

        passing_score 70
        max_attempts 3
      end

    end

    mod "Week 4: Data Management with Volumes 💾" do
      # Module: week-4-data-management-with-volumes

      lesson "Understanding Container Storage" do
        content <<~MARKDOWN
          # Understanding Container Storage
          
          ## The Ephemeral Problem
          
          By default, data in containers is **ephemeral** - it disappears when the container is removed:
          
          ```bash
          docker run --rm alpine sh -c "echo 'data' > /tmp/file.txt"
          # Container exits, file.txt is lost forever
          ```
          
          ## Storage Solutions
          
          Docker provides two main approaches for persistent data:
          
          1. **Volumes**: Managed by Docker
          2. **Bind Mounts**: Direct host filesystem mapping
          
          ## Why Persistence Matters
          
          - Database data must survive container restarts
          - Application logs need to be retained
          - Configuration files should be easily editable
          - Shared data between containers
          
          ## Volume Benefits
          
          - Managed by Docker
          - Easier to back up
          - Work on all platforms
          - Can be shared safely
          - Better performance
        MARKDOWN
        estimated_minutes 20
      end

      lab "Working with Volumes", lab_type: "docker" do
        description "Practice creating volumes, mounting them in containers, and persisting data.\n"

        step "Create a Named Volume" do
          instruction "Create a Docker volume called mydata"
          command "docker volume create mydata"
        end

        step "List Volumes" do
          instruction "View all Docker volumes"
          command "docker volume ls"
        end

        step "Use Volume in Container" do
          instruction "Run a container that mounts the volume"
          command "docker run -d --name db -v mydata:/data postgres:alpine"
        end

        difficulty "medium"
        estimated_minutes 40
      end

      quiz "Week 4 Review: Data Persistence" do
        description "Test your understanding of volumes and data management"

        question do
          text "Data stored in a container's writable layer persists after the container is removed"
          type "true_false"
          correct_answer "false"
          explanation "False. Container data is ephemeral by default. Use volumes for persistence."
        end

        passing_score 70
        max_attempts 3
      end

    end

    mod "Week 5: Networking and Multi-Container Apps 🌐" do
      # Module: week-5-networking-and-multi-container-apps

      lesson "Docker Networking Fundamentals" do
        content <<~MARKDOWN
          # Docker Networking Fundamentals
          
          ## Network Drivers
          
          Docker provides several network drivers:
          
          - **bridge**: Default, isolated network
          - **host**: Use host's network directly
          - **none**: No networking
          - **overlay**: Multi-host networking (Swarm)
          
          ## Container Communication
          
          Containers on the same network can communicate using:
          - Container names as hostnames
          - IP addresses
          - Service discovery (automatic DNS)
          
          ## Port Publishing
          
          ```bash
          docker run -p 8080:80 nginx
          # Host port 8080 → Container port 80
          ```
        MARKDOWN
        estimated_minutes 25
      end

      lab "Multi-Container Application", lab_type: "docker" do
        description "Deploy a web application with a separate database container, connected via a custom network.\n"

        step "Create Custom Network" do
          instruction "Create a bridge network for the application"
          command "docker network create myapp-network"
        end

        step "Run Database Container" do
          instruction "Start a PostgreSQL database on the custom network"
          command "docker run -d --name db --network myapp-network postgres:alpine"
        end

        step "Run Web Application" do
          instruction "Start a web app that connects to the database"
          command "docker run -d --name web --network myapp-network -p 8080:80 nginx:alpine"
        end

        difficulty "medium"
        estimated_minutes 45
      end

      quiz "Week 5 Review: Networking" do
        description "Test your knowledge of Docker networking"

        question do
          text "Containers on the same custom network can communicate using container names"
          type "true_false"
          correct_answer "true"
          explanation "True. Docker provides automatic DNS resolution for containers on custom networks."
        end

        passing_score 70
        max_attempts 3
      end

    end

    mod "Week 6: Docker Compose for Orchestration 🎼" do
      # Module: week-6-docker-compose-for-orchestration

      lesson "Introduction to Docker Compose" do
        content <<~MARKDOWN
          # Introduction to Docker Compose
          
          ## What is Docker Compose?
          
          Docker Compose is a tool for defining and running multi-container applications using a YAML file.
          
          ## Benefits
          
          - **Declarative**: Define entire stack in one file
          - **Reproducible**: Same setup everywhere
          - **Simple**: One command to start everything
          - **Version Control**: Track infrastructure as code
          
          ## Basic docker-compose.yml
          
          ```yaml
          version: '3.8'
          services:
            web:
              image: nginx:alpine
              ports:
                - "8080:80"
            db:
              image: postgres:alpine
              environment:
                POSTGRES_PASSWORD: secret
          ```
          
          ## Common Commands
          
          ```bash
          docker-compose up -d      # Start services
          docker-compose down       # Stop and remove
          docker-compose ps         # List services
          docker-compose logs -f    # View logs
          ```
        MARKDOWN
        estimated_minutes 30
      end

      lab "Deploy with Docker Compose", lab_type: "docker" do
        description "Create a complete application stack using Docker Compose.\n"

        step "Create Compose File" do
          instruction "Create a docker-compose.yml file"
          command "mkdir -p ~/compose-app && cd ~/compose-app && echo 'version: \"3.8\"\nservices:\n  web:\n    image: nginx:alpine\n    ports:\n      - \"8080:80\"' > docker-compose.yml"
        end

        step "Start Services" do
          instruction "Launch all services with Docker Compose"
          command "docker-compose up -d"
        end

        step "List Running Services" do
          instruction "Check the status of Compose services"
          command "docker-compose ps"
        end

        difficulty "medium"
        estimated_minutes 45
      end

      quiz "Week 6 Review: Docker Compose" do
        description "Test your understanding of Docker Compose"

        question do
          text "Docker Compose can manage multiple containers with a single YAML file"
          type "true_false"
          correct_answer "true"
          explanation "True. Docker Compose allows you to define entire multi-container applications in docker-compose.yml."
        end

        passing_score 70
        max_attempts 3
      end

    end

    mod "Week 7: Capstone Project & Kubernetes Readiness 🎓" do
      # Module: week-7-capstone-project-kubernetes-readiness

      lesson "Docker Best Practices Summary" do
        content <<~MARKDOWN
          # Docker Best Practices Summary
          
          ## Image Optimization
          
          1. Use Alpine base images
          2. Minimize layers
          3. Leverage build cache
          4. Use multi-stage builds
          5. Don't run as root
          
          ## Security
          
          1. Scan images for vulnerabilities
          2. Use official images
          3. Keep images updated
          4. Limit container privileges
          5. Use secrets management
          
          ## Production Readiness
          
          1. Health checks
          2. Proper logging
          3. Resource limits
          4. Restart policies
          5. Monitoring and alerting
        MARKDOWN
        estimated_minutes 25
      end

      lesson "Introduction to Kubernetes" do
        content <<~MARKDOWN
          # Introduction to Kubernetes
          
          ## What is Kubernetes?
          
          Kubernetes (K8s) is an open-source container orchestration platform for automating deployment, scaling, and management of containerized applications.
          
          ## Why Kubernetes?
          
          - **Auto-scaling**: Scale containers based on demand
          - **Self-healing**: Restart failed containers
          - **Load balancing**: Distribute traffic
          - **Rolling updates**: Zero-downtime deployments
          - **Service discovery**: Automatic DNS and networking
          
          ## Kubernetes vs Docker
          
          - Docker: Container runtime
          - Kubernetes: Container orchestrator
          - They work together!
          
          ## Key Concepts
          
          - **Pods**: Smallest deployable units
          - **Services**: Stable network endpoints
          - **Deployments**: Manage pod replicas
          - **Namespaces**: Virtual clusters
        MARKDOWN
        estimated_minutes 20
      end

      lab "Capstone: Full-Stack Application", lab_type: "docker" do
        description "Build a complete microservices application with frontend, backend, database, and reverse proxy - all orchestrated with Docker Compose.\n"

        step "Create Project Structure" do
          instruction "Set up the capstone project directory"
          command "mkdir -p ~/capstone/{frontend,backend,nginx} && cd ~/capstone"
        end

        step "Create Backend Dockerfile" do
          instruction "Create a Dockerfile for a Node.js API"
          command "cd backend && echo 'FROM node:14-alpine\nWORKDIR /app\nCOPY package*.json ./\nRUN npm install\nCOPY . .\nEXPOSE 3000\nCMD [\"npm\",\"start\"]' > Dockerfile && cd .."
        end

        step "Create Docker Compose Configuration" do
          instruction "Define the complete application stack"
          command "echo 'version: \"3.8\"\nservices:\n  frontend:\n    image: nginx:alpine\n    ports:\n      - \"80:80\"\n  backend:\n    build: ./backend\n    ports:\n      - \"3000:3000\"\n  db:\n    image: postgres:alpine\n    environment:\n      POSTGRES_PASSWORD: secret' > docker-compose.yml"
        end

        step "Build and Launch Application" do
          instruction "Start the entire application stack"
          command "docker-compose up -d --build"
        end

        step "Verify All Services Running" do
          instruction "Check that all services are healthy"
          command "docker-compose ps"
        end

        step "View Application Logs" do
          instruction "Monitor logs from all services"
          command "docker-compose logs"
        end

        step "Scale Backend Service" do
          instruction "Scale the backend to 3 instances"
          command "docker-compose up -d --scale backend=3"
        end

        step "Cleanup" do
          instruction "Stop and remove all containers"
          command "docker-compose down"
        end

        difficulty "hard"
        estimated_minutes 90
      end

      quiz "Final Assessment: DCA Certification Readiness" do
        description "Comprehensive exam covering all bootcamp topics - Docker Certified Associate aligned"

        question do
          text "What is the primary benefit of using multi-stage builds?"
          type "mcq"
          correct_answer "Reduce final image size by excluding build dependencies"
          explanation "Multi-stage builds allow you to use build tools in early stages and copy only the final artifacts to the production image."
        end

        question do
          text "Which command shows real-time resource usage for all containers?"
          type "mcq"
          correct_answer "docker stats"
          explanation "docker stats provides live CPU, memory, network, and disk I/O metrics for running containers."
        end

        question do
          text "What is the difference between CMD and ENTRYPOINT in a Dockerfile?"
          type "mcq"
          correct_answer "ENTRYPOINT sets the main executable, CMD provides default arguments"
          explanation "ENTRYPOINT defines the main command, while CMD provides default arguments that can be overridden."
        end

        question do
          text "How do containers on the same custom network communicate?"
          type "mcq"
          correct_answer "Using container names as hostnames via automatic DNS"
          explanation "Docker provides automatic service discovery via DNS on custom networks."
        end

        question do
          text "What does 'docker-compose up -d' do?"
          type "mcq"
          correct_answer "Starts all services in detached mode"
          explanation "The -d flag runs services in the background, freeing up your terminal."
        end

        question do
          text "Docker volumes are managed by Docker and persist data beyond container lifecycle"
          type "true_false"
          correct_answer "true"
          explanation "True. Volumes are the preferred way to persist data in Docker containers."
        end

        question do
          text "Bind mounts are more portable than Docker volumes"
          type "true_false"
          correct_answer "false"
          explanation "False. Volumes are more portable as they're managed by Docker and work across all platforms."
        end

        question do
          text "Which restart policy ensures a container always restarts unless manually stopped?"
          type "mcq"
          correct_answer "unless-stopped"
          explanation "unless-stopped restarts containers automatically except when manually stopped."
        end

        question do
          text "What is the purpose of .dockerignore?"
          type "mcq"
          correct_answer "Exclude files from the build context to speed up builds"
          explanation ".dockerignore prevents unnecessary files from being sent to the Docker daemon, making builds faster."
        end

        question do
          text "In a production environment, which image tag should you use?"
          type "mcq"
          correct_answer "Specific version tags (e.g., nginx:1.21)"
          explanation "Specific version tags ensure reproducibility and prevent unexpected updates in production."
        end

        passing_score 80
        max_attempts 2
      end

    end

  end
end
