# Docker Fundamentals
# Generated from database on 2025-11-06
# Original slug: docker-fundamentals

CourseBuilder::DSL.define('docker-fundamentals') do
  course(
    title: "Docker Fundamentals",
    description: "Master Docker from basics to production deployment. Build, ship, and run containerized applications with confidence.",
    difficulty_level: "beginner",
    estimated_hours: 20,
    certification_track: "dca"
  ) do

    # Plugin: progressive_learning
    plugin :progressive_learning, { enabled: true, hints: true }

    # Plugin: command_reference
    plugin :command_reference, { command_type: "docker" }

    # Course configuration
    config { theme: "docker-pro", prerequisites: "[\"Linux Fundamentals course (recommended)\",\"Understanding of software development concepts\"]" }

    mod "Container Basics" do
      # Module: container-basics

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

      quiz "Container Basics Quiz" do

        question do
          text "What is the main difference between containers and virtual machines?"
          type "mcq"
          correct_answer "Containers share the host OS kernel while VMs have their own OS"
          explanation "Containers share the host operating system's kernel, making them lightweight and fast. VMs include a complete operating system, making them heavier but more isolated."
        end

        question do
          text "Which Docker component is responsible for managing containers?"
          type "mcq"
          correct_answer "Docker Daemon"
          explanation "The Docker Daemon (dockerd) is the background service that manages containers, images, networks, and volumes."
        end

        question do
          text "What command would you use to run a container from the 'nginx' image?"
          type "command"
          correct_answer "docker run nginx"
          explanation "The 'docker run' command creates and starts a container from an image. For nginx: docker run nginx"
        end

        question do
          text "Docker images are stored in a Docker Registry like Docker Hub."
          type "true_false"
          correct_answer "true"
          explanation "Docker images are stored in registries. Docker Hub is the default public registry, but you can also use private registries."
        end

        question do
          text "A Docker _____ is a lightweight, standalone executable package that includes everything needed to run software."
          type "fill_blank"
          correct_answer "container"
          explanation "A container is the runtime instance that packages application code with all dependencies."
        end

        passing_score 70
        max_attempts 3
      end

      lab "Your First Container - Run and Explore", lab_type: "docker" do
        description "Learn the basics by running your first Docker container and exploring its filesystem"

        step "Pull nginx image" do
          instruction "Pull the official nginx image from Docker Hub"
          command "docker pull nginx:latest"
        end

        step "Run nginx container" do
          instruction "Run nginx in detached mode with name 'my-nginx'"
          command "docker run -d --name my-nginx nginx"
        end

        step "Access container shell" do
          instruction "Execute bash shell inside the running container"
          command "docker exec -it my-nginx bash"
        end

        step "View container logs" do
          instruction "Check the logs of your nginx container"
          command "docker logs my-nginx"
        end

        step "Stop and remove" do
          instruction "Stop the container and remove it"
          command "docker stop my-nginx && docker rm my-nginx"
        end

        difficulty "easy"
        estimated_minutes 15
      end

    end

    mod "Docker Basics" do
      # Module: docker-basics

    end

    mod "Module 1: Your First Day at CodeSprout" do
      # Module: container-lifecycle

      lab "CodeSprout Web Server Management", lab_type: "docker" do
        description "Deploy and manage the CodeSprout web server in a real scenario"

        step "Deploy the web server" do
          instruction "Run an nginx:alpine container named \"codesprout-main\" on port 3000"
          hint "Use docker run with -d, -p and --name flags"
        end

        step "Verify the server is running" do
          instruction "List running containers and ensure codesprout-main is present"
          hint "Use docker ps and look for the container name"
        end

        step "Stop the server" do
          instruction "Stop the running web server container"
          hint "Use docker stop <container>"
        end

        step "Clean up the container" do
          instruction "Remove the stopped container to keep things tidy"
          hint "Use docker rm <container>"
        end

        difficulty "easy"
        estimated_minutes 15
      end

    end

    mod "Images and Dockerfiles" do
      # Module: images-dockerfiles

      lesson "Understanding Docker Images" do
        content <<~MARKDOWN
          # Understanding Docker Images
          
          Docker images are the blueprints for containers. They contain everything needed to run an application.
          
          ## Image Layers
          
          Images are built in layers, with each layer representing a filesystem change:
          - **Base layer**: Usually an OS like Ubuntu or Alpine
          - **Application layers**: Your code and dependencies
          - **Each layer is cached**: Makes rebuilds faster
          
          ## Dockerfile Basics
          
          A Dockerfile is a text file with instructions to build an image:
          
          ```dockerfile
          FROM node:18-alpine
          WORKDIR /app
          COPY package.json .
          RUN npm install
          COPY . .
          CMD ["node", "server.js"]
          ```
          
          ### Key Instructions
          - `FROM`: Base image
          - `WORKDIR`: Set working directory
          - `COPY`: Copy files into image
          - `RUN`: Execute commands
          - `CMD`: Default command to run
          - `EXPOSE`: Document ports
          
          ## Building Images
          
          ```bash
          # Build an image
          docker build -t myapp:v1 .
          
          # List images
          docker images
          
          # Tag an image
          docker tag myapp:v1 myapp:latest
          ```
          
          ## Best Practices
          1. Use specific base image tags
          2. Order instructions from least to most frequently changed
          3. Use .dockerignore to exclude files
          4. Minimize layer count
          5. Use multi-stage builds for production
        MARKDOWN
        estimated_minutes 20
      end

      quiz "Images and Dockerfiles Quiz" do

        question do
          text "What is the purpose of image layers in Docker?"
          type "mcq"
          correct_answer "To enable caching and faster rebuilds"
          explanation "Layers allow Docker to cache intermediate results, making subsequent builds much faster when only later layers change."
        end

        question do
          text "What command builds a Docker image from a Dockerfile and tags it as 'myapp:v1'?"
          type "command"
          correct_answer "docker build -t myapp:v1 ."
          explanation "The -t flag tags the image, and the dot (.) specifies the build context (current directory)."
        end

        passing_score 70
        max_attempts 3
      end

      lab "CodeSprout App Image Build", lab_type: "docker" do
        description "Write a multi-stage Dockerfile and build a lean app image"

        step "Create Dockerfile" do
          instruction "Create a multi-stage Dockerfile (builder + final). Use alpine base."
          hint "First stage builds, second stage copies artifact"
        end

        step "Build the image" do
          instruction "Build the image and tag it codesprout/app:1.0"
          hint "Use docker build -t <name> ."
        end

        step "Run the container" do
          instruction "Run the image and verify output"
          hint "Run and check the program output"
        end

        difficulty "medium"
        estimated_minutes 20
      end

    end

    mod "Container Management" do
      # Module: container-management

    end

    mod "Images and Dockerfiles" do
      # Module: images-and-dockerfiles

      lesson "Understanding Docker Images" do
        content <<~MARKDOWN
          # Understanding Docker Images
          
          Docker images are the blueprints for containers. They contain everything needed to run an application.
          
          ## Image Layers
          
          Images are built in layers, with each layer representing a filesystem change:
          - **Base layer**: Usually an OS like Ubuntu or Alpine
          - **Application layers**: Your code and dependencies
          - **Each layer is cached**: Makes rebuilds faster
          
          ## Dockerfile Basics
          
          A Dockerfile is a text file with instructions to build an image:
          
          ```dockerfile
          FROM node:18-alpine
          WORKDIR /app
          COPY package.json .
          RUN npm install
          COPY . .
          CMD ["node", "server.js"]
          ```
          
          ### Key Instructions
          - `FROM`: Base image
          - `WORKDIR`: Set working directory
          - `COPY`: Copy files into image
          - `RUN`: Execute commands
          - `CMD`: Default command to run
          - `EXPOSE`: Document ports
          
          ## Building Images
          
          ```bash
          # Build an image
          docker build -t myapp:v1 .
          
          # List images
          docker images
          
          # Tag an image
          docker tag myapp:v1 myapp:latest
          ```
          
          ## Best Practices
          1. Use specific base image tags
          2. Order instructions from least to most frequently changed
          3. Use .dockerignore to exclude files
          4. Minimize layer count
          5. Use multi-stage builds for production
        MARKDOWN
        estimated_minutes 20
      end

      quiz "Images and Dockerfiles Quiz" do

        question do
          text "What is the purpose of image layers in Docker?"
          type "mcq"
          correct_answer "To enable caching and faster rebuilds"
          explanation "Layers allow Docker to cache intermediate results, making subsequent builds much faster when only later layers change."
        end

        question do
          text "What command builds a Docker image from a Dockerfile and tags it as 'myapp:v1'?"
          type "command"
          correct_answer "docker build -t myapp:v1 ."
          explanation "The -t flag tags the image, and the dot (.) specifies the build context (current directory)."
        end

        passing_score 70
        max_attempts 3
      end

      lab "Building Your First Docker Image", lab_type: "docker" do
        description "Create a Dockerfile and build your first custom image"

        step "Create Dockerfile" do
          instruction "Create a simple Dockerfile using Alpine base image"
          command "echo -e 'FROM alpine:latest\\nRUN apk add --no-cache curl\\nCMD [\"curl\", \"--version\"]' > Dockerfile"
        end

        step "Build the image" do
          instruction "Build the image with tag 'mycurl:v1'"
          command "docker build -t mycurl:v1 ."
        end

        step "Run container from custom image" do
          instruction "Run a container from your newly built image"
          command "docker run mycurl:v1"
        end

        difficulty "medium"
        estimated_minutes 30
      end

    end

    mod "Networking & Ports" do
      # Module: networking-and-ports

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

      quiz "Networking & Ports Quiz" do
        description "Check your knowledge of port mapping and networks"

        question do
          text "Which network mode removes the need for -p when exposing ports?"
          type "mcq"
          correct_answer nil
          explanation "Host network shares the host's network namespace; no port mapping is needed."
        end

        question do
          text "Map host port 8080 to container port 80 for nginx"
          type "command"
          correct_answer "docker run -d -p 8080:80 nginx|docker container run -d -p 8080:80 nginx"
          explanation "Use -p HOST:CONTAINER to publish ports."
        end

        question do
          text "User-defined bridge networks provide built-in DNS by container name."
          type "true_false"
          correct_answer "true"
          explanation "User-defined bridges include DNS-based service discovery."
        end

        passing_score 70
        max_attempts 3
      end

      lab "Port Mapping and Network Access", lab_type: "docker" do
        description "Learn how to expose container services to the host using port mapping"

        step "Run nginx with port mapping" do
          instruction "Run nginx container mapping host port 8080 to container port 80"
          command "docker run -d -p 8080:80 --name web-server nginx"
        end

        step "Test connectivity" do
          instruction "Use curl to verify nginx is accessible on port 8080"
          command "curl http://localhost:8080"
        end

        step "Check port bindings" do
          instruction "Inspect which ports are mapped"
          command "docker port web-server"
        end

        step "Cleanup" do
          instruction "Stop and remove the container"
          command "docker stop web-server && docker rm web-server"
        end

        difficulty "easy"
        estimated_minutes 20
      end

    end

    mod "Image Management" do
      # Module: image-management

    end

    mod "Module 3: Networking & Data" do
      # Module: networking-and-data

      lab "CodeSprout Persistent Database", lab_type: "docker" do
        description "Run MySQL with a named volume and a custom network"

        step "Create a volume" do
          instruction "Create a named volume called codesprout-db"
          hint "Use docker volume create <name>"
        end

        step "Create a network" do
          instruction "Create a user-defined bridge network codesprout-net"
          hint "Use docker network create <name>"
        end

        step "Run MySQL" do
          instruction "Run mysql:8 with root password and mount the volume on /var/lib/mysql"
          hint "Use -e for env vars, -v for volumes, --network to attach"
        end

        difficulty "medium"
        estimated_minutes 25
      end

    end

    mod "Container Networking" do
      # Module: container-networking

      lesson "Docker Networking Basics" do
        content <<~MARKDOWN
          # Docker Networking Basics
          
          Docker networking allows containers to communicate with each other and the outside world.
          
          ## Network Types
          
          Docker provides several network drivers:
          
          ### Bridge (default)
          - Containers on same host can communicate
          - Isolated from host network
          - Best for standalone containers
          
          ### Host
          - Container uses host's network stack
          - No network isolation
          - Better performance, less isolation
          
          ### None
          - No networking
          - Complete isolation
          - Use for security-sensitive workloads
          
          ### Custom Networks
          - User-defined bridge networks
          - Automatic DNS resolution
          - Better isolation control
          
          ## Port Mapping
          
          Expose container ports to the host:
          
          ```bash
          # Map container port 80 to host port 8080
          docker run -p 8080:80 nginx
          
          # Map all exposed ports
          docker run -P nginx
          
          # Bind to specific host IP
          docker run -p 127.0.0.1:8080:80 nginx
          ```
          
          ## Container Communication
          
          ```bash
          # Create custom network
          docker network create mynetwork
          
          # Run containers on custom network
          docker run -d --name web --network mynetwork nginx
          docker run -d --name api --network mynetwork node:18
          
          # Containers can reach each other by name
          # web can reach api at http://api:3000
          ```
        MARKDOWN
        estimated_minutes 15
      end

      lab "Port Mapping and Network Access", lab_type: "docker" do
        description "Learn how to expose container services to the host using port mapping"

        step "Run nginx with port mapping" do
          instruction "Run nginx container mapping host port 8080 to container port 80"
          command "docker run -d -p 8080:80 --name web-server nginx"
        end

        step "Test connectivity" do
          instruction "Use curl to verify nginx is accessible on port 8080"
          command "curl http://localhost:8080"
        end

        step "Check port bindings" do
          instruction "Inspect which ports are mapped"
          command "docker port web-server"
        end

        step "Cleanup" do
          instruction "Stop and remove the container"
          command "docker stop web-server && docker rm web-server"
        end

        difficulty "easy"
        estimated_minutes 20
      end

    end

    mod "Volumes & Storage" do
      # Module: volumes-and-storage

      lesson "Data Persistence with Volumes" do
        content <<~MARKDOWN
          # Data Persistence with Volumes
          
          Volumes are the preferred mechanism for persisting data in Docker.
          
          ## Types
          - Named volumes: managed by Docker (`docker volume create`)
          - Bind mounts: map host paths into containers
          
          ## Examples
          ```bash
          docker volume create appdata
          docker run -d -v appdata:/var/lib/app --name app busybox tail -f /dev/null
          docker run --rm -v appdata:/data busybox ls -l /data
          ```
        MARKDOWN
        estimated_minutes 15
      end

      quiz "Volumes & Storage Quiz" do
        description "Volumes, bind mounts, and persistence"

        question do
          text "Which is managed by Docker and not tied to a host path?"
          type "mcq"
          correct_answer nil
          explanation "Named volumes are managed by Docker and portable across hosts (with caveats)."
        end

        question do
          text "Create a named volume called 'appdata'"
          type "command"
          correct_answer "docker volume create appdata"
          explanation "Use docker volume create <name> to create a named volume."
        end

        passing_score 70
        max_attempts 3
      end

      lab "Volume Mounting - Data Persistence", lab_type: "docker" do
        description "Learn how to persist data using Docker volumes and bind mounts"

        step "Create named volume" do
          instruction "Create a Docker volume named 'app-data'"
          command "docker volume create app-data"
        end

        step "Run container with volume" do
          instruction "Run nginx with the volume mounted at /usr/share/nginx/html"
          command "docker run -d --name web -v app-data:/usr/share/nginx/html nginx"
        end

        step "Write data to volume" do
          instruction "Create an index.html file in the mounted volume"
          command "docker exec web sh -c 'echo \"<h1>Hello from Volume</h1>\" > /usr/share/nginx/html/index.html'"
        end

        step "Verify persistence" do
          instruction "Remove container, create new one with same volume"
          command "docker rm -f web && docker run -d --name web2 -v app-data:/usr/share/nginx/html nginx"
        end

        step "Cleanup" do
          instruction "Remove container and volume"
          command "docker rm -f web2 && docker volume rm app-data"
        end

        difficulty "easy"
        estimated_minutes 25
      end

    end

    mod "Module 4: Deploying the CodeSprout Application" do
      # Module: deploying-codesprout

    end

    mod "Volumes and Data Persistence" do
      # Module: volumes-and-data-persistence

      lesson "Understanding Volumes" do
        content <<~MARKDOWN
          # Understanding Volumes
          
          Containers are ephemeral by default - when deleted, their data is lost. Volumes solve this problem.
          
          ## Volume Types
          
          ### Named Volumes (Recommended)
          - Managed by Docker
          - Stored in Docker's storage area
          - Easy to backup and migrate
          
          ```bash
          docker volume create mydata
          docker run -v mydata:/app/data nginx
          ```
          
          ### Bind Mounts
          - Mount host directory into container
          - Full host path required
          - Good for development
          
          ```bash
          docker run -v /host/path:/container/path nginx
          ```
          
          ### tmpfs Mounts
          - Stored in host memory
          - Temporary, lost on stop
          - Fast, secure for sensitive data
          
          ## Volume Commands
          
          ```bash
          # List volumes
          docker volume ls
          
          # Inspect volume
          docker volume inspect mydata
          
          # Remove volume
          docker volume rm mydata
          
          # Prune unused volumes
          docker volume prune
          ```
          
          ## Best Practices
          1. Use named volumes for production data
          2. Use bind mounts for development
          3. Never store data in container's writable layer
          4. Backup volumes regularly
        MARKDOWN
        estimated_minutes 15
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

    end

    mod "Docker Compose" do
      # Module: docker-compose

      lesson "Compose Basics" do
        content <<~MARKDOWN
          # Docker Compose Basics
          
          Compose uses a YAML file to define services, networks, and volumes.
          
          ```yaml
          version: '3.9'
          services:
            web:
              image: nginx
              ports: ["8080:80"]
            redis:
              image: redis:alpine
          ```
          
          Commands:
          - `docker compose up -d`
          - `docker compose ps`
          - `docker compose logs -f`
        MARKDOWN
        estimated_minutes 15
      end

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

      quiz "Docker Compose Quiz" do

        question do
          text "What is the primary purpose of Docker Compose?"
          type "mcq"
          correct_answer "To define and run multi-container applications"
          explanation "Docker Compose allows you to define your entire application stack (multiple containers) in a single YAML file."
        end

        question do
          text "What command starts all services defined in docker-compose.yml in detached mode?"
          type "command"
          correct_answer "docker-compose up -d"
          explanation "The 'up' command starts services, and '-d' runs them in detached (background) mode."
        end

        passing_score 70
        max_attempts 3
      end

      lab "Docker Compose - Multi-Container Application", lab_type: "docker-compose" do
        description "Deploy a multi-container application using Docker Compose"

        step "Create docker-compose.yml" do
          instruction "Create compose file with web and database services"
          command "cat > docker-compose.yml << 'EOF'\nversion: '3.8'\nservices:\n  web:\n    image: nginx:alpine\n    ports:\n      - '8080:80'\n    depends_on:\n      - db\n  db:\n    image: mysql:8\n    environment:\n      MYSQL_ROOT_PASSWORD: secret\n      MYSQL_DATABASE: myapp\n    volumes:\n      - db-data:/var/lib/mysql\nvolumes:\n  db-data:\nEOF"
        end

        step "Start services" do
          instruction "Start all services in detached mode"
          command "docker-compose up -d"
        end

        step "Check service status" do
          instruction "List running compose services"
          command "docker-compose ps"
        end

        step "View logs" do
          instruction "Check logs from all services"
          command "docker-compose logs"
        end

        step "Scale web service" do
          instruction "Scale web service to 3 replicas"
          command "docker-compose up -d --scale web=3"
        end

        step "Stop services" do
          instruction "Stop and remove all containers"
          command "docker-compose down"
        end

        step "Cleanup with volumes" do
          instruction "Remove everything including volumes"
          command "docker-compose down -v && rm docker-compose.yml"
        end

        difficulty "medium"
        estimated_minutes 40
      end

    end

    mod "Docker Networking" do
      # Module: docker-networking

    end

    mod "Security & Best Practices" do
      # Module: security-best-practices

      lesson "Container Security Basics" do
        content <<~MARKDOWN
          # Container Security Basics
          
          - Prefer non-root users in images (USER)
          - Add HEALTHCHECK to detect failure conditions
          - Limit capabilities and make FS read-only when possible
          - Scan images for vulnerabilities
        MARKDOWN
        estimated_minutes 10
      end

      quiz "Security Quiz" do
        description "Secure-by-default image and runtime settings"

        question do
          text "Running as root inside containers is recommended for production."
          type "true_false"
          correct_answer "false"
          explanation "Use a non-root USER and least privilege."
        end

        passing_score 70
        max_attempts 3
      end

      lab "Docker Security - Non-Root User and Read-Only", lab_type: "docker" do
        description "Implement security best practices in containers"

        step "Create Dockerfile with non-root user" do
          instruction "Create Dockerfile that runs as non-root user"
          command "cat > Dockerfile << 'EOF'\nFROM nginx:alpine\nRUN addgroup -S appgroup && adduser -S appuser -G appgroup\nUSER appuser\nEOF"
        end

        step "Build secure image" do
          instruction "Build the image"
          command "docker build -t secure-nginx ."
        end

        step "Run with read-only filesystem" do
          instruction "Run container with read-only root filesystem"
          command "docker run -d --name secure --read-only --tmpfs /tmp secure-nginx"
        end

        step "Verify non-root user" do
          instruction "Check that container runs as non-root"
          command "docker exec secure whoami"
        end

        step "Test read-only" do
          instruction "Try to write to filesystem (should fail)"
          command "docker exec secure touch /test.txt || echo 'Read-only verified'"
        end

        step "Drop capabilities" do
          instruction "Run with dropped capabilities"
          command "docker run -d --name cap-drop --cap-drop=ALL --cap-add=NET_BIND_SERVICE nginx"
        end

        step "Cleanup" do
          instruction "Remove all secure containers and images"
          command "docker rm -f secure cap-drop && docker rmi secure-nginx && rm Dockerfile"
        end

        difficulty "hard"
        estimated_minutes 40
      end

      lab "Troubleshooting Docker Containers", lab_type: "docker" do
        description "Debug and fix 10 common Docker container failures: exit crashes, port conflicts, permission errors, networking issues, and more"

        step "Scenario 1: Container Exits Immediately" do
          instruction "Run container that exits immediately with 'exit 1', diagnose with docker logs, then fix by changing command to run indefinitely"
          command "docker run -d --name exit-test alpine sh -c 'exit 1' && sleep 3 && docker logs exit-test && docker rm -f exit-test && docker run -d --name exit-test alpine sleep 3600"
          hint "Use 'docker logs' to see why container exited, then use 'docker inspect' to check exit code"
        end

        step "Scenario 2: Port Already in Use" do
          instruction "Start nginx on port 8080, try to start another on same port (will fail), diagnose error, fix by using different port 8081"
          command "docker run -d --name nginx1 -p 8080:80 nginx:alpine && docker run -d --name nginx2 -p 8080:80 nginx:alpine 2>&1 | grep 'address already in use' && docker run -d --name nginx2 -p 8081:80 nginx:alpine"
          hint "Look for 'bind: address already in use' error, use 'docker ps' to see what's using the port"
        end

        step "Scenario 3: Volume Permission Denied" do
          instruction "Create directory with restricted permissions, try to mount and write (will fail), diagnose permission error, fix with proper ownership"
          command "mkdir -p /tmp/restricted && chmod 000 /tmp/restricted && docker run --rm -v /tmp/restricted:/data alpine sh -c 'echo test > /data/file' 2>&1 | grep -i permission && sudo chmod 755 /tmp/restricted && docker run --rm -v /tmp/restricted:/data alpine sh -c 'echo test > /data/file'"
          hint "Check directory permissions with 'ls -ld', use chmod or run container with appropriate user"
        end

        step "Scenario 4: Image Not Found" do
          instruction "Try to run non-existent image nginx:doesnotexist999, diagnose pull error, fix by using correct tag nginx:alpine"
          command "docker run nginx:doesnotexist999 2>&1 | grep -i 'manifest.*not found' && docker run -d --name image-test nginx:alpine"
          hint "Error shows 'manifest unknown' or 'not found', verify image exists on Docker Hub"
        end

        step "Scenario 5: Out of Disk Space" do
          instruction "Check disk usage with 'docker system df', prune unused images/containers to free space"
          command "docker system df && docker system prune -f"
          hint "Use 'docker system df' to see space usage, 'docker system prune' to clean up"
        end

        step "Scenario 6: Container Network Isolation" do
          instruction "Start two containers on default bridge, create custom network, move containers to custom network to enable communication by name"
          command "docker run -d --name web1 nginx:alpine && docker run -d --name web2 alpine sh -c 'ping -c 2 web1' 2>&1 | grep 'bad address' && docker network create mynet && docker network connect mynet web1 && docker run --rm --network mynet alpine ping -c 2 web1"
          hint "Containers on default bridge can only communicate by IP, custom networks enable DNS resolution"
        end

        step "Scenario 7: Environment Variable Not Set" do
          instruction "Run container expecting MY_VAR env var (will fail), diagnose missing variable, fix by passing -e MY_VAR=value"
          command "docker run --rm alpine sh -c 'echo $MY_VAR' && docker run --rm -e MY_VAR=hello alpine sh -c 'echo $MY_VAR'"
          hint "Use -e flag to pass environment variables, or --env-file for multiple vars"
        end

        step "Scenario 8: Container Restart Loop" do
          instruction "Create container with failing healthcheck causing restart loop, diagnose with docker events, fix healthcheck"
          command "docker run -d --name restart-test --restart=always --health-cmd='exit 1' --health-interval=5s alpine sleep 3600 && sleep 10 && docker events --since 5s --filter 'container=restart-test' | grep unhealthy && docker rm -f restart-test && docker run -d --name restart-test --health-cmd='exit 0' --health-interval=5s alpine sleep 3600"
          hint "Use 'docker events' to see health status changes, check healthcheck command"
        end

        step "Scenario 9: Name Conflict" do
          instruction "Try to create container with existing name (will fail), diagnose conflict error, fix by removing old container or using different name"
          command "docker run -d --name conflict-test alpine sleep 3600 && docker run -d --name conflict-test alpine sleep 3600 2>&1 | grep 'Conflict' && docker rm -f conflict-test && docker run -d --name conflict-test alpine sleep 3600"
          hint "Error shows 'Conflict. The container name is already in use', remove old container or rename new one"
        end

        step "Scenario 10: Container Cannot Connect to Host Service" do
          instruction "Start service on host, container tries to connect to 'localhost' (will fail), diagnose connection refused, fix using host.docker.internal or host network mode"
          command "python3 -m http.server 9999 >/dev/null 2>&1 & HTTP_PID=$!; sleep 2; docker run --rm alpine sh -c 'wget -O- localhost:9999' 2>&1 | grep 'Connection refused' && docker run --rm --add-host=host.docker.internal:host-gateway alpine sh -c 'wget -O- host.docker.internal:9999' | grep -i 'http' ; kill $HTTP_PID"
          hint "Use 'host.docker.internal' to reach host from container, or '--network host' to share host network"
        end

        difficulty "hard"
        estimated_minutes 45
      end

    end

    mod "Docker Volumes" do
      # Module: docker-volumes

    end

    mod "Production Best Practices" do
      # Module: production-best-practices

      lesson "Security Best Practices" do
        content <<~MARKDOWN
          # Security Best Practices
          
          ## Image Security
          
          1. **Use Official Base Images**
             - Start with official, verified images
             - Check image signatures
             - Use minimal base images (Alpine, Distroless)
          
          2. **Don't Run as Root**
          ```dockerfile
          FROM node:18-alpine
          RUN addgroup -S appgroup && adduser -S appuser -G appgroup
          USER appuser
          ```
          
          3. **Scan for Vulnerabilities**
          ```bash
          docker scan myimage:latest
          ```
          
          ## Runtime Security
          
          1. **Limit Container Capabilities**
          ```bash
          docker run --cap-drop ALL --cap-add NET_BIND_SERVICE nginx
          ```
          
          2. **Use Read-Only Filesystems**
          ```bash
          docker run --read-only nginx
          ```
          
          3. **Set Resource Limits**
          ```bash
          docker run --memory=512m --cpus=1 nginx
          ```
          
          ## Secrets Management
          
          - Never hardcode secrets in images
          - Use Docker secrets or external vaults
          - Rotate credentials regularly
          
          ```bash
          echo "mypassword" | docker secret create db_password -
          docker service create --secret db_password myapp
          ```
        MARKDOWN
        estimated_minutes 20
      end

    end

    mod "Registries & CI/CD" do
      # Module: registries-ci-cd

      lesson "Using Docker Registries" do
        content <<~MARKDOWN
          # Using Docker Registries
          
          - docker login / logout
          - docker tag (image:tag) and naming conventions
          - docker push / pull
          - Immutable tags in CI/CD and content trust overview
        MARKDOWN
        estimated_minutes 10
      end

      quiz "Registries Quiz" do
        description "Tags, authentication, and push/pull"

        question do
          text "Tag local image myapp:latest for registry example.com/team/myapp:v1"
          type "command"
          correct_answer "docker tag myapp:latest example.com/team/myapp:v1"
          explanation "Tag must include registry/namespace/name:tag"
        end

        passing_score 70
        max_attempts 3
      end

      lab "Docker Registry - Push and Pull Custom Images", lab_type: "docker" do
        description "Set up a private registry and manage custom images"

        step "Run local registry" do
          instruction "Start a local Docker registry on port 5000"
          command "docker run -d -p 5000:5000 --name registry registry:2"
        end

        step "Build custom image" do
          instruction "Build a simple custom image"
          command "echo 'FROM alpine' > Dockerfile && docker build -t myapp:v1 ."
        end

        step "Tag for registry" do
          instruction "Tag image for local registry"
          command "docker tag myapp:v1 localhost:5000/myapp:v1"
        end

        step "Push to registry" do
          instruction "Push image to local registry"
          command "docker push localhost:5000/myapp:v1"
        end

        step "Remove local image" do
          instruction "Remove local images to test pull"
          command "docker rmi myapp:v1 localhost:5000/myapp:v1"
        end

        step "Pull from registry" do
          instruction "Pull image from private registry"
          command "docker pull localhost:5000/myapp:v1"
        end

        step "Cleanup" do
          instruction "Remove registry and images"
          command "docker rm -f registry && docker rmi localhost:5000/myapp:v1 && rm Dockerfile"
        end

        difficulty "hard"
        estimated_minutes 45
      end

    end

    mod "Docker → Kubernetes Bridge I" do
      # Module: exam-readiness-dca-mock-1

      quiz "Bridge I Knowledge Check" do
        description "Quick knowledge check to reinforce Docker→K8s mappings"

        question do
          text "Which command lists dangling images?"
          type "mcq"
          correct_answer nil
          explanation "Use filter dangling=true with docker images."
        end

        question do
          text "Limit container to 512MB memory and 1 CPU"
          type "command"
          correct_answer "docker run -m 512m --cpus 1 nginx|docker container run -m 512m --cpus 1 nginx"
          explanation "Use -m and --cpus to set resource limits."
        end

        question do
          text "Preferable base for minimal images?"
          type "mcq"
          correct_answer nil
          explanation "Alpine is commonly used for minimal images."
        end

        question do
          text "HEALTHCHECK helps detect app failures."
          type "true_false"
          correct_answer "true"
          explanation "It lets orchestrators restart unhealthy containers."
        end

        question do
          text "How to share data between two containers across restarts?"
          type "mcq"
          correct_answer nil
          explanation "Named volumes persist and can be mounted by multiple containers."
        end

        question do
          text "Create a user-defined bridge called appnet"
          type "command"
          correct_answer "docker network create appnet"
          explanation "docker network create <name>."
        end

        question do
          text "Which Compose key defines a healthcheck?"
          type "mcq"
          correct_answer nil
          explanation "Compose supports healthcheck under a service."
        end

        question do
          text "Push image example.com/acme/api:v2"
          type "command"
          correct_answer "docker push example.com/acme/api:v2"
          explanation "Requires prior docker login."
        end

        question do
          text "Which flag makes root FS read-only?"
          type "mcq"
          correct_answer nil
          explanation "--read-only sets the container root FS to read-only."
        end

        question do
          text "host network provides container-name DNS"
          type "true_false"
          correct_answer "false"
          explanation "DNS-based discovery is for user-defined bridge and overlay."
        end

        passing_score 70
        max_attempts 3
      end

    end

    mod "Docker → Kubernetes Bridge II" do
      # Module: dca-practice-bank

      quiz "Bridge II Knowledge Check" do
        description "Quick checks for Services/DNS, PV/PVC, ConfigMaps & Secrets"

        question do
          text "Which command tags an existing image? (v1)"
          type "mcq"
          correct_answer nil
          explanation "Use docker tag SOURCE[:TAG] TARGET[:TAG] to add a new tag."
        end

        question do
          text "Run nginx mapping host 8080 to container 80 (v1)"
          type "command"
          correct_answer "docker run -d -p 8080:80 nginx"
          explanation "Use -p HOST:CONTAINER for port publishing."
        end

        question do
          text "Multi-stage builds can reduce final image size. (v1)"
          type "true_false"
          correct_answer "true"
          explanation "Copy only required artefacts from builder stage."
        end

        question do
          text "Preferred storage mechanism for persistent data? (v1)"
          type "mcq"
          correct_answer nil
          explanation "Use named volumes or bind mounts for persistence."
        end

        question do
          text "Create a named volume appdata (v1)"
          type "command"
          correct_answer "docker volume create appdata"
          explanation "docker volume create <name>."
        end

        question do
          text "User-defined bridges provide container-name DNS. (v1)"
          type "true_false"
          correct_answer "true"
          explanation "Built-in DNS is available on user-defined bridges."
        end

        question do
          text "Which Compose command starts services in detached mode? (v1)"
          type "mcq"
          correct_answer nil
          explanation "Use up -d to create and start in background."
        end

        question do
          text "Which flag makes root filesystem read-only? (v1)"
          type "mcq"
          correct_answer nil
          explanation "Use --read-only for runtime hardening."
        end

        question do
          text "Which command tags an existing image? (v2)"
          type "mcq"
          correct_answer nil
          explanation "Use docker tag SOURCE[:TAG] TARGET[:TAG] to add a new tag."
        end

        question do
          text "Run nginx mapping host 8080 to container 80 (v2)"
          type "command"
          correct_answer "docker run -d -p 8080:80 nginx"
          explanation "Use -p HOST:CONTAINER for port publishing."
        end

        question do
          text "Multi-stage builds can reduce final image size. (v2)"
          type "true_false"
          correct_answer "true"
          explanation "Copy only required artefacts from builder stage."
        end

        question do
          text "Preferred storage mechanism for persistent data? (v2)"
          type "mcq"
          correct_answer nil
          explanation "Use named volumes or bind mounts for persistence."
        end

        question do
          text "Create a named volume appdata (v2)"
          type "command"
          correct_answer "docker volume create appdata"
          explanation "docker volume create <name>."
        end

        question do
          text "User-defined bridges provide container-name DNS. (v2)"
          type "true_false"
          correct_answer "true"
          explanation "Built-in DNS is available on user-defined bridges."
        end

        question do
          text "Which Compose command starts services in detached mode? (v2)"
          type "mcq"
          correct_answer nil
          explanation "Use up -d to create and start in background."
        end

        question do
          text "Which flag makes root filesystem read-only? (v2)"
          type "mcq"
          correct_answer nil
          explanation "Use --read-only for runtime hardening."
        end

        question do
          text "Which command tags an existing image? (v3)"
          type "mcq"
          correct_answer nil
          explanation "Use docker tag SOURCE[:TAG] TARGET[:TAG] to add a new tag."
        end

        question do
          text "Run nginx mapping host 8080 to container 80 (v3)"
          type "command"
          correct_answer "docker run -d -p 8080:80 nginx"
          explanation "Use -p HOST:CONTAINER for port publishing."
        end

        question do
          text "Multi-stage builds can reduce final image size. (v3)"
          type "true_false"
          correct_answer "true"
          explanation "Copy only required artefacts from builder stage."
        end

        question do
          text "Preferred storage mechanism for persistent data? (v3)"
          type "mcq"
          correct_answer nil
          explanation "Use named volumes or bind mounts for persistence."
        end

        question do
          text "Create a named volume appdata (v3)"
          type "command"
          correct_answer "docker volume create appdata"
          explanation "docker volume create <name>."
        end

        question do
          text "User-defined bridges provide container-name DNS. (v3)"
          type "true_false"
          correct_answer "true"
          explanation "Built-in DNS is available on user-defined bridges."
        end

        question do
          text "Which Compose command starts services in detached mode? (v3)"
          type "mcq"
          correct_answer nil
          explanation "Use up -d to create and start in background."
        end

        question do
          text "Which flag makes root filesystem read-only? (v3)"
          type "mcq"
          correct_answer nil
          explanation "Use --read-only for runtime hardening."
        end

        question do
          text "Which command tags an existing image? (v4)"
          type "mcq"
          correct_answer nil
          explanation "Use docker tag SOURCE[:TAG] TARGET[:TAG] to add a new tag."
        end

        question do
          text "Run nginx mapping host 8080 to container 80 (v4)"
          type "command"
          correct_answer "docker run -d -p 8080:80 nginx"
          explanation "Use -p HOST:CONTAINER for port publishing."
        end

        question do
          text "Multi-stage builds can reduce final image size. (v4)"
          type "true_false"
          correct_answer "true"
          explanation "Copy only required artefacts from builder stage."
        end

        question do
          text "Preferred storage mechanism for persistent data? (v4)"
          type "mcq"
          correct_answer nil
          explanation "Use named volumes or bind mounts for persistence."
        end

        question do
          text "Create a named volume appdata (v4)"
          type "command"
          correct_answer "docker volume create appdata"
          explanation "docker volume create <name>."
        end

        question do
          text "User-defined bridges provide container-name DNS. (v4)"
          type "true_false"
          correct_answer "true"
          explanation "Built-in DNS is available on user-defined bridges."
        end

        passing_score 0
        max_attempts 0
      end

    end

    mod "Kubernetes Readiness: CKAD Preview" do
      # Module: exam-readiness-dca-mock-2

      quiz "CKAD Preview Scenarios" do
        description "Hands-on style scenario checks (self-timed)"

        question do
          text "Create a user-defined bridge network (Q1)"
          type "command"
          correct_answer "docker network create appnet"
          explanation "docker network create <name>."
        end

        question do
          text "Named volumes persist data across container restarts. (Q2)"
          type "true_false"
          correct_answer "true"
          explanation "Volumes survive container lifecycle."
        end

        question do
          text "In volumes, which command is correct? (Q3)"
          type "mcq"
          correct_answer nil
          explanation "Pick the valid command for the domain."
        end

        question do
          text "Create a user-defined bridge network (Q4)"
          type "command"
          correct_answer "docker network create appnet"
          explanation "docker network create <name>."
        end

        question do
          text "Named volumes persist data across container restarts. (Q5)"
          type "true_false"
          correct_answer "true"
          explanation "Volumes survive container lifecycle."
        end

        question do
          text "In registry, which command is correct? (Q6)"
          type "mcq"
          correct_answer nil
          explanation "Pick the valid command for the domain."
        end

        question do
          text "Create a user-defined bridge network (Q7)"
          type "command"
          correct_answer "docker network create appnet"
          explanation "docker network create <name>."
        end

        question do
          text "Named volumes persist data across container restarts. (Q8)"
          type "true_false"
          correct_answer "true"
          explanation "Volumes survive container lifecycle."
        end

        question do
          text "In networking, which command is correct? (Q9)"
          type "mcq"
          correct_answer nil
          explanation "Pick the valid command for the domain."
        end

        question do
          text "Create a user-defined bridge network (Q10)"
          type "command"
          correct_answer "docker network create appnet"
          explanation "docker network create <name>."
        end

        question do
          text "Named volumes persist data across container restarts. (Q11)"
          type "true_false"
          correct_answer "true"
          explanation "Volumes survive container lifecycle."
        end

        question do
          text "In security, which command is correct? (Q12)"
          type "mcq"
          correct_answer nil
          explanation "Pick the valid command for the domain."
        end

        question do
          text "Create a user-defined bridge network (Q13)"
          type "command"
          correct_answer "docker network create appnet"
          explanation "docker network create <name>."
        end

        question do
          text "Named volumes persist data across container restarts. (Q14)"
          type "true_false"
          correct_answer "true"
          explanation "Volumes survive container lifecycle."
        end

        question do
          text "In containers, which command is correct? (Q15)"
          type "mcq"
          correct_answer nil
          explanation "Pick the valid command for the domain."
        end

        question do
          text "Create a user-defined bridge network (Q16)"
          type "command"
          correct_answer "docker network create appnet"
          explanation "docker network create <name>."
        end

        question do
          text "Named volumes persist data across container restarts. (Q17)"
          type "true_false"
          correct_answer "true"
          explanation "Volumes survive container lifecycle."
        end

        question do
          text "In compose, which command is correct? (Q18)"
          type "mcq"
          correct_answer nil
          explanation "Pick the valid command for the domain."
        end

        question do
          text "Create a user-defined bridge network (Q19)"
          type "command"
          correct_answer "docker network create appnet"
          explanation "docker network create <name>."
        end

        question do
          text "Named volumes persist data across container restarts. (Q20)"
          type "true_false"
          correct_answer "true"
          explanation "Volumes survive container lifecycle."
        end

        question do
          text "In images, which command is correct? (Q21)"
          type "mcq"
          correct_answer nil
          explanation "Pick the valid command for the domain."
        end

        question do
          text "Create a user-defined bridge network (Q22)"
          type "command"
          correct_answer "docker network create appnet"
          explanation "docker network create <name>."
        end

        question do
          text "Named volumes persist data across container restarts. (Q23)"
          type "true_false"
          correct_answer "true"
          explanation "Volumes survive container lifecycle."
        end

        question do
          text "In volumes, which command is correct? (Q24)"
          type "mcq"
          correct_answer nil
          explanation "Pick the valid command for the domain."
        end

        question do
          text "Create a user-defined bridge network (Q25)"
          type "command"
          correct_answer "docker network create appnet"
          explanation "docker network create <name>."
        end

        question do
          text "Named volumes persist data across container restarts. (Q26)"
          type "true_false"
          correct_answer "true"
          explanation "Volumes survive container lifecycle."
        end

        question do
          text "In registry, which command is correct? (Q27)"
          type "mcq"
          correct_answer nil
          explanation "Pick the valid command for the domain."
        end

        question do
          text "Create a user-defined bridge network (Q28)"
          type "command"
          correct_answer "docker network create appnet"
          explanation "docker network create <name>."
        end

        question do
          text "Named volumes persist data across container restarts. (Q29)"
          type "true_false"
          correct_answer "true"
          explanation "Volumes survive container lifecycle."
        end

        question do
          text "In networking, which command is correct? (Q30)"
          type "mcq"
          correct_answer nil
          explanation "Pick the valid command for the domain."
        end

        passing_score 0
        max_attempts 0
      end

    end

    mod "Kubernetes Readiness: CKA Preview" do
      # Module: exam-readiness-dca-mock-3

      quiz "CKA Preview Scenarios" do
        description "Cluster administration scenario previews"

        question do
          text "Which flag limits memory usage? (Q1)"
          type "mcq"
          correct_answer nil
          explanation "Use -m/--memory to cap memory."
        end

        question do
          text "Run nginx with read-only root filesystem (Q2)"
          type "command"
          correct_answer "docker run --read-only nginx"
          explanation "Harden container with --read-only."
        end

        question do
          text "Which flag limits memory usage? (Q3)"
          type "mcq"
          correct_answer nil
          explanation "Use -m/--memory to cap memory."
        end

        question do
          text "Run nginx with read-only root filesystem (Q4)"
          type "command"
          correct_answer "docker run --read-only nginx"
          explanation "Harden container with --read-only."
        end

        question do
          text "Which flag limits memory usage? (Q5)"
          type "mcq"
          correct_answer nil
          explanation "Use -m/--memory to cap memory."
        end

        question do
          text "Run nginx with read-only root filesystem (Q6)"
          type "command"
          correct_answer "docker run --read-only nginx"
          explanation "Harden container with --read-only."
        end

        question do
          text "Which flag limits memory usage? (Q7)"
          type "mcq"
          correct_answer nil
          explanation "Use -m/--memory to cap memory."
        end

        question do
          text "Run nginx with read-only root filesystem (Q8)"
          type "command"
          correct_answer "docker run --read-only nginx"
          explanation "Harden container with --read-only."
        end

        question do
          text "Which flag limits memory usage? (Q9)"
          type "mcq"
          correct_answer nil
          explanation "Use -m/--memory to cap memory."
        end

        question do
          text "Run nginx with read-only root filesystem (Q10)"
          type "command"
          correct_answer "docker run --read-only nginx"
          explanation "Harden container with --read-only."
        end

        question do
          text "Which flag limits memory usage? (Q11)"
          type "mcq"
          correct_answer nil
          explanation "Use -m/--memory to cap memory."
        end

        question do
          text "Run nginx with read-only root filesystem (Q12)"
          type "command"
          correct_answer "docker run --read-only nginx"
          explanation "Harden container with --read-only."
        end

        question do
          text "Which flag limits memory usage? (Q13)"
          type "mcq"
          correct_answer nil
          explanation "Use -m/--memory to cap memory."
        end

        question do
          text "Run nginx with read-only root filesystem (Q14)"
          type "command"
          correct_answer "docker run --read-only nginx"
          explanation "Harden container with --read-only."
        end

        question do
          text "Which flag limits memory usage? (Q15)"
          type "mcq"
          correct_answer nil
          explanation "Use -m/--memory to cap memory."
        end

        question do
          text "Run nginx with read-only root filesystem (Q16)"
          type "command"
          correct_answer "docker run --read-only nginx"
          explanation "Harden container with --read-only."
        end

        question do
          text "Which flag limits memory usage? (Q17)"
          type "mcq"
          correct_answer nil
          explanation "Use -m/--memory to cap memory."
        end

        question do
          text "Run nginx with read-only root filesystem (Q18)"
          type "command"
          correct_answer "docker run --read-only nginx"
          explanation "Harden container with --read-only."
        end

        question do
          text "Which flag limits memory usage? (Q19)"
          type "mcq"
          correct_answer nil
          explanation "Use -m/--memory to cap memory."
        end

        question do
          text "Run nginx with read-only root filesystem (Q20)"
          type "command"
          correct_answer "docker run --read-only nginx"
          explanation "Harden container with --read-only."
        end

        question do
          text "Which flag limits memory usage? (Q21)"
          type "mcq"
          correct_answer nil
          explanation "Use -m/--memory to cap memory."
        end

        question do
          text "Run nginx with read-only root filesystem (Q22)"
          type "command"
          correct_answer "docker run --read-only nginx"
          explanation "Harden container with --read-only."
        end

        question do
          text "Which flag limits memory usage? (Q23)"
          type "mcq"
          correct_answer nil
          explanation "Use -m/--memory to cap memory."
        end

        question do
          text "Run nginx with read-only root filesystem (Q24)"
          type "command"
          correct_answer "docker run --read-only nginx"
          explanation "Harden container with --read-only."
        end

        question do
          text "Which flag limits memory usage? (Q25)"
          type "mcq"
          correct_answer nil
          explanation "Use -m/--memory to cap memory."
        end

        passing_score 0
        max_attempts 0
      end

    end

  end
end
