# Hands-On Docker Labs Seed Data for Practical Learning
# Progressive difficulty: easy → medium → hard

puts "🧪 Seeding Docker Hands-On Labs..."

docker_labs = [
  # BEGINNER LABS (1-5)
  {
    title: "Your First Container - Run and Explore",
    description: "Learn the basics by running your first Docker container and exploring its filesystem",
    difficulty: "easy",
    estimated_minutes: 15,
    lab_type: "docker",
    category: "basics",
    certification_exam: "DCA",
    learning_objectives: "Understand docker run, exec, and basic container lifecycle",
    prerequisites: ["Basic command line knowledge"],
    steps: [
      {
        step_number: 1,
        title: "Pull nginx image",
        instruction: "Pull the official nginx image from Docker Hub",
        expected_command: "docker pull nginx:latest",
        validation: "docker images | grep nginx"
      },
      {
        step_number: 2,
        title: "Run nginx container",
        instruction: "Run nginx in detached mode with name 'my-nginx'",
        expected_command: "docker run -d --name my-nginx nginx",
        validation: "docker ps | grep my-nginx"
      },
      {
        step_number: 3,
        title: "Access container shell",
        instruction: "Execute bash shell inside the running container",
        expected_command: "docker exec -it my-nginx bash",
        validation: "echo $HOSTNAME"
      },
      {
        step_number: 4,
        title: "View container logs",
        instruction: "Check the logs of your nginx container",
        expected_command: "docker logs my-nginx",
        validation: "docker logs my-nginx | wc -l"
      },
      {
        step_number: 5,
        title: "Stop and remove",
        instruction: "Stop the container and remove it",
        expected_command: "docker stop my-nginx && docker rm my-nginx",
        validation: "docker ps -a | grep my-nginx"
      }
    ],
    validation_rules: {
      image_pulled: "nginx image must be present",
      container_created: "container named my-nginx must exist",
      container_running: "container must be in running state",
      cleanup_complete: "no containers should remain"
    },
    success_criteria: "All 5 steps completed successfully, container lifecycle managed correctly",
    environment_image: "docker:20-dind",
    required_tools: ["docker"],
    max_attempts: 5,
    points_reward: 100,
    is_active: true
  },

  {
    title: "Port Mapping and Network Access",
    description: "Learn how to expose container services to the host using port mapping",
    difficulty: "easy",
    estimated_minutes: 20,
    lab_type: "docker",
    category: "networking",
    certification_exam: "DCA",
    learning_objectives: "Master port mapping, understand -p flag, test container connectivity",
    prerequisites: ["Completed 'Your First Container' lab"],
    steps: [
      {
        step_number: 1,
        title: "Run nginx with port mapping",
        instruction: "Run nginx container mapping host port 8080 to container port 80",
        expected_command: "docker run -d -p 8080:80 --name web-server nginx",
        validation: "docker port web-server 80"
      },
      {
        step_number: 2,
        title: "Test connectivity",
        instruction: "Use curl to verify nginx is accessible on port 8080",
        expected_command: "curl http://localhost:8080",
        validation: "curl -s -o /dev/null -w '%{http_code}' http://localhost:8080"
      },
      {
        step_number: 3,
        title: "Check port bindings",
        instruction: "Inspect which ports are mapped",
        expected_command: "docker port web-server",
        validation: "docker port web-server | grep 8080"
      },
      {
        step_number: 4,
        title: "Multiple port mapping",
        instruction: "Run another container with multiple ports (80→8081, 443→8443)",
        expected_command: "docker run -d -p 8081:80 -p 8443:443 --name web-ssl nginx",
        validation: "docker port web-ssl 80 && docker port web-ssl 443"
      },
      {
        step_number: 5,
        title: "Cleanup",
        instruction: "Stop and remove both containers",
        expected_command: "docker rm -f web-server web-ssl",
        validation: "docker ps -a -f name=web"
      }
    ],
    validation_rules: {
      port_accessible: "port 8080 must return HTTP 200",
      multiple_ports: "both ports must be mapped",
      cleanup: "no web containers remaining"
    },
    success_criteria: "Successfully map ports and verify external access",
    environment_image: "docker:20-dind",
    required_tools: ["docker", "curl"],
    max_attempts: 5,
    points_reward: 150,
    is_active: true
  },

  {
    title: "Environment Variables and Configuration",
    description: "Learn to configure containers using environment variables",
    difficulty: "easy",
    estimated_minutes: 20,
    lab_type: "docker",
    category: "configuration",
    certification_exam: "DCA",
    learning_objectives: "Use -e flag, pass configuration, inspect environment variables",
    prerequisites: ["Basic Docker knowledge"],
    steps: [
      {
        step_number: 1,
        title: "Run MySQL with environment vars",
        instruction: "Run MySQL container with root password set via env var",
        expected_command: "docker run -d --name mysql-db -e MYSQL_ROOT_PASSWORD=secretpass mysql:8",
        validation: "docker inspect mysql-db | grep MYSQL_ROOT_PASSWORD"
      },
      {
        step_number: 2,
        title: "Multiple environment variables",
        instruction: "Run MySQL with database name and user credentials",
        expected_command: "docker run -d --name mysql-app -e MYSQL_ROOT_PASSWORD=secret -e MYSQL_DATABASE=myapp -e MYSQL_USER=appuser -e MYSQL_PASSWORD=apppass mysql:8",
        validation: "docker exec mysql-app env | grep MYSQL"
      },
      {
        step_number: 3,
        title: "Inspect environment",
        instruction: "View all environment variables in the container",
        expected_command: "docker exec mysql-app env",
        validation: "docker exec mysql-app env | grep MYSQL_DATABASE"
      },
      {
        step_number: 4,
        title: "Create env file",
        instruction: "Create an .env file with KEY=value pairs",
        expected_command: "echo 'APP_NAME=MyApp\\nAPP_ENV=production' > app.env",
        validation: "cat app.env | grep APP_NAME"
      },
      {
        step_number: 5,
        title: "Cleanup",
        instruction: "Remove containers and env file",
        expected_command: "docker rm -f mysql-db mysql-app && rm app.env",
        validation: "docker ps -a | grep mysql"
      }
    ],
    validation_rules: {
      env_vars_set: "environment variables must be present",
      database_created: "MYSQL_DATABASE must be set",
      env_file_created: "app.env file must exist"
    },
    success_criteria: "Successfully configure containers with environment variables",
    environment_image: "docker:20-dind",
    required_tools: ["docker"],
    max_attempts: 5,
    points_reward: 150,
    is_active: true
  },

  {
    title: "Volume Mounting - Data Persistence",
    description: "Learn how to persist data using Docker volumes and bind mounts",
    difficulty: "easy",
    estimated_minutes: 25,
    lab_type: "docker",
    category: "storage",
    certification_exam: "DCA",
    learning_objectives: "Create volumes, bind mounts, persist data across container restarts",
    prerequisites: ["Basic Docker knowledge"],
    steps: [
      {
        step_number: 1,
        title: "Create named volume",
        instruction: "Create a Docker volume named 'app-data'",
        expected_command: "docker volume create app-data",
        validation: "docker volume ls | grep app-data"
      },
      {
        step_number: 2,
        title: "Run container with volume",
        instruction: "Run nginx with the volume mounted at /usr/share/nginx/html",
        expected_command: "docker run -d --name web -v app-data:/usr/share/nginx/html nginx",
        validation: "docker inspect web | grep app-data"
      },
      {
        step_number: 3,
        title: "Write data to volume",
        instruction: "Create an index.html file in the mounted volume",
        expected_command: "docker exec web sh -c 'echo \"<h1>Hello from Volume</h1>\" > /usr/share/nginx/html/index.html'",
        validation: "docker exec web cat /usr/share/nginx/html/index.html"
      },
      {
        step_number: 4,
        title: "Verify persistence",
        instruction: "Remove container, create new one with same volume",
        expected_command: "docker rm -f web && docker run -d --name web2 -v app-data:/usr/share/nginx/html nginx",
        validation: "docker exec web2 cat /usr/share/nginx/html/index.html | grep Hello"
      },
      {
        step_number: 5,
        title: "Cleanup",
        instruction: "Remove container and volume",
        expected_command: "docker rm -f web2 && docker volume rm app-data",
        validation: "docker volume ls | grep app-data"
      }
    ],
    validation_rules: {
      volume_created: "app-data volume must exist",
      data_persists: "data must survive container restart",
      cleanup_complete: "volume must be removed"
    },
    success_criteria: "Data persists across container lifecycle",
    environment_image: "docker:20-dind",
    required_tools: ["docker"],
    max_attempts: 5,
    points_reward: 200,
    is_active: true
  },

  {
    title: "Container Logs and Debugging",
    description: "Master container logging and basic debugging techniques",
    difficulty: "easy",
    estimated_minutes: 20,
    lab_type: "docker",
    category: "debugging",
    certification_exam: "DCA",
    learning_objectives: "View logs, follow logs, filter logs, debug container issues",
    prerequisites: ["Basic Docker knowledge"],
    steps: [
      {
        step_number: 1,
        title: "Run container with logs",
        instruction: "Run nginx and generate some access logs",
        expected_command: "docker run -d -p 8080:80 --name web nginx",
        validation: "docker ps | grep web"
      },
      {
        step_number: 2,
        title: "View logs",
        instruction: "Display all logs from the container",
        expected_command: "docker logs web",
        validation: "docker logs web | wc -l"
      },
      {
        step_number: 3,
        title: "Follow logs live",
        instruction: "Follow logs in real-time (use Ctrl+C to exit)",
        expected_command: "docker logs -f web",
        validation: "docker logs web --tail 10"
      },
      {
        step_number: 4,
        title: "Tail recent logs",
        instruction: "Display last 20 lines of logs",
        expected_command: "docker logs --tail 20 web",
        validation: "docker logs --tail 20 web | wc -l"
      },
      {
        step_number: 5,
        title: "Cleanup",
        instruction: "Remove the container",
        expected_command: "docker rm -f web",
        validation: "docker ps -a | grep web"
      }
    ],
    validation_rules: {
      logs_accessible: "logs must be retrievable",
      tail_works: "tail must limit output",
      cleanup: "container must be removed"
    },
    success_criteria: "Successfully view and analyze container logs",
    environment_image: "docker:20-dind",
    required_tools: ["docker"],
    max_attempts: 5,
    points_reward: 100,
    is_active: true
  },

  # INTERMEDIATE LABS (6-13)
  {
    title: "Build Your First Docker Image",
    description: "Create a custom Docker image using a Dockerfile",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "docker",
    category: "images",
    certification_exam: "DCA",
    learning_objectives: "Write Dockerfile, build images, understand layers, tag images",
    prerequisites: ["Completed beginner labs", "Basic understanding of Linux"],
    steps: [
      {
        step_number: 1,
        title: "Create Dockerfile",
        instruction: "Create a Dockerfile with FROM nginx, COPY index.html, EXPOSE 80",
        expected_command: "cat > Dockerfile << 'EOF'\nFROM nginx:alpine\nCOPY index.html /usr/share/nginx/html/\nEXPOSE 80\nEOF",
        validation: "test -f Dockerfile"
      },
      {
        step_number: 2,
        title: "Create index.html",
        instruction: "Create a simple HTML file",
        expected_command: "echo '<h1>My Custom Image</h1>' > index.html",
        validation: "test -f index.html"
      },
      {
        step_number: 3,
        title: "Build image",
        instruction: "Build image with tag myapp:v1",
        expected_command: "docker build -t myapp:v1 .",
        validation: "docker images | grep myapp"
      },
      {
        step_number: 4,
        title: "Run custom image",
        instruction: "Run container from your custom image",
        expected_command: "docker run -d -p 8080:80 --name custom-app myapp:v1",
        validation: "docker ps | grep custom-app"
      },
      {
        step_number: 5,
        title: "Test custom content",
        instruction: "Verify custom HTML is served",
        expected_command: "curl http://localhost:8080",
        validation: "curl -s http://localhost:8080 | grep 'My Custom Image'"
      },
      {
        step_number: 6,
        title: "View image layers",
        instruction: "Inspect image history",
        expected_command: "docker history myapp:v1",
        validation: "docker history myapp:v1 | wc -l"
      },
      {
        step_number: 7,
        title: "Cleanup",
        instruction: "Remove container, image, and files",
        expected_command: "docker rm -f custom-app && docker rmi myapp:v1 && rm Dockerfile index.html",
        validation: "docker images | grep myapp"
      }
    ],
    validation_rules: {
      dockerfile_valid: "Dockerfile must have FROM, COPY, EXPOSE",
      image_built: "image must be in local registry",
      container_runs: "container must serve custom HTML",
      cleanup: "all resources removed"
    },
    success_criteria: "Build custom image and run container successfully",
    environment_image: "docker:20-dind",
    required_tools: ["docker", "curl"],
    max_attempts: 5,
    points_reward: 250,
    is_active: true
  },

  {
    title: "Multi-Stage Builds - Optimize Image Size",
    description: "Learn to create optimized images using multi-stage builds",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "docker",
    category: "images",
    certification_exam: "DCA",
    learning_objectives: "Multi-stage builds, reduce image size, separate build and runtime",
    prerequisites: ["Completed 'Build Your First Docker Image' lab"],
    steps: [
      {
        step_number: 1,
        title: "Create Go application",
        instruction: "Create a simple Go hello world program",
        expected_command: "cat > main.go << 'EOF'\npackage main\nimport \"fmt\"\nfunc main() { fmt.Println(\"Hello from Docker!\") }\nEOF",
        validation: "test -f main.go"
      },
      {
        step_number: 2,
        title: "Create multi-stage Dockerfile",
        instruction: "Create Dockerfile with builder and runtime stages",
        expected_command: "cat > Dockerfile << 'EOF'\nFROM golang:1.20 AS builder\nWORKDIR /app\nCOPY main.go .\nRUN go build -o app main.go\n\nFROM alpine:latest\nWORKDIR /root/\nCOPY --from=builder /app/app .\nCMD [\"./app\"]\nEOF",
        validation: "grep 'AS builder' Dockerfile"
      },
      {
        step_number: 3,
        title: "Build multi-stage image",
        instruction: "Build the optimized image",
        expected_command: "docker build -t mygoapp:optimized .",
        validation: "docker images | grep mygoapp"
      },
      {
        step_number: 4,
        title: "Check image size",
        instruction: "Compare image size (should be much smaller than golang base)",
        expected_command: "docker images mygoapp:optimized --format '{{.Size}}'",
        validation: "docker images mygoapp:optimized | awk '{print $NF}'"
      },
      {
        step_number: 5,
        title: "Run optimized image",
        instruction: "Run container and verify output",
        expected_command: "docker run --rm mygoapp:optimized",
        validation: "docker run --rm mygoapp:optimized | grep Hello"
      },
      {
        step_number: 6,
        title: "Cleanup",
        instruction: "Remove image and source files",
        expected_command: "docker rmi mygoapp:optimized && rm Dockerfile main.go",
        validation: "docker images | grep mygoapp"
      }
    ],
    validation_rules: {
      multistage_dockerfile: "must have multiple FROM statements",
      image_optimized: "final image should be < 20MB",
      app_runs: "application must execute successfully"
    },
    success_criteria: "Create optimized image using multi-stage build",
    environment_image: "docker:20-dind",
    required_tools: ["docker"],
    max_attempts: 5,
    points_reward: 300,
    is_active: true
  },

  {
    title: "Docker Networks - Container Communication",
    description: "Master Docker networking by connecting multiple containers",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "docker",
    category: "networking",
    certification_exam: "DCA",
    learning_objectives: "Create networks, connect containers, test inter-container communication",
    prerequisites: ["Understanding of basic networking concepts"],
    steps: [
      {
        step_number: 1,
        title: "Create custom network",
        instruction: "Create a bridge network named 'app-network'",
        expected_command: "docker network create app-network",
        validation: "docker network ls | grep app-network"
      },
      {
        step_number: 2,
        title: "Run database on network",
        instruction: "Run MySQL on the custom network",
        expected_command: "docker run -d --name db --network app-network -e MYSQL_ROOT_PASSWORD=secret mysql:8",
        validation: "docker network inspect app-network | grep db"
      },
      {
        step_number: 3,
        title: "Run app container",
        instruction: "Run another container on same network",
        expected_command: "docker run -d --name app --network app-network nginx",
        validation: "docker network inspect app-network | grep app"
      },
      {
        step_number: 4,
        title: "Test connectivity",
        instruction: "Ping database from app container using container name",
        expected_command: "docker exec app ping -c 3 db",
        validation: "docker exec app ping -c 1 db"
      },
      {
        step_number: 5,
        title: "Inspect network",
        instruction: "View network details and connected containers",
        expected_command: "docker network inspect app-network",
        validation: "docker network inspect app-network | grep Containers"
      },
      {
        step_number: 6,
        title: "Cleanup",
        instruction: "Remove containers and network",
        expected_command: "docker rm -f app db && docker network rm app-network",
        validation: "docker network ls | grep app-network"
      }
    ],
    validation_rules: {
      network_created: "custom network must exist",
      containers_connected: "both containers on same network",
      dns_resolution: "containers can resolve each other by name",
      cleanup: "network must be removed"
    },
    success_criteria: "Containers communicate on custom network",
    environment_image: "docker:20-dind",
    required_tools: ["docker"],
    max_attempts: 5,
    points_reward: 250,
    is_active: true
  },

  {
    title: "Docker Compose - Multi-Container Application",
    description: "Deploy a multi-container application using Docker Compose",
    difficulty: "medium",
    estimated_minutes: 40,
    lab_type: "docker-compose",
    category: "orchestration",
    certification_exam: "DCA",
    learning_objectives: "Write docker-compose.yml, manage multi-container apps, understand service dependencies",
    prerequisites: ["Completed networking and volumes labs"],
    steps: [
      {
        step_number: 1,
        title: "Create docker-compose.yml",
        instruction: "Create compose file with web and database services",
        expected_command: "cat > docker-compose.yml << 'EOF'\nversion: '3.8'\nservices:\n  web:\n    image: nginx:alpine\n    ports:\n      - '8080:80'\n    depends_on:\n      - db\n  db:\n    image: mysql:8\n    environment:\n      MYSQL_ROOT_PASSWORD: secret\n      MYSQL_DATABASE: myapp\n    volumes:\n      - db-data:/var/lib/mysql\nvolumes:\n  db-data:\nEOF",
        validation: "test -f docker-compose.yml"
      },
      {
        step_number: 2,
        title: "Start services",
        instruction: "Start all services in detached mode",
        expected_command: "docker-compose up -d",
        validation: "docker-compose ps | grep Up"
      },
      {
        step_number: 3,
        title: "Check service status",
        instruction: "List running compose services",
        expected_command: "docker-compose ps",
        validation: "docker-compose ps | wc -l"
      },
      {
        step_number: 4,
        title: "View logs",
        instruction: "Check logs from all services",
        expected_command: "docker-compose logs",
        validation: "docker-compose logs | grep mysql"
      },
      {
        step_number: 5,
        title: "Scale web service",
        instruction: "Scale web service to 3 replicas",
        expected_command: "docker-compose up -d --scale web=3",
        validation: "docker-compose ps | grep web | wc -l"
      },
      {
        step_number: 6,
        title: "Stop services",
        instruction: "Stop and remove all containers",
        expected_command: "docker-compose down",
        validation: "docker-compose ps | grep Up"
      },
      {
        step_number: 7,
        title: "Cleanup with volumes",
        instruction: "Remove everything including volumes",
        expected_command: "docker-compose down -v && rm docker-compose.yml",
        validation: "test -f docker-compose.yml"
      }
    ],
    validation_rules: {
      compose_file_valid: "valid docker-compose.yml",
      services_running: "both services must be up",
      depends_on_works: "web depends on db",
      scaling_works: "must scale to 3 web containers",
      cleanup: "all resources removed"
    },
    success_criteria: "Successfully deploy and manage multi-container app",
    environment_image: "docker:20-dind",
    required_tools: ["docker", "docker-compose"],
    max_attempts: 5,
    points_reward: 350,
    is_active: true
  },

  {
    title: "Resource Limits - Control Container Resources",
    description: "Learn to limit CPU and memory for containers",
    difficulty: "medium",
    estimated_minutes: 25,
    lab_type: "docker",
    category: "performance",
    certification_exam: "DCA",
    learning_objectives: "Set memory limits, CPU limits, understand resource management",
    prerequisites: ["Basic Docker knowledge"],
    steps: [
      {
        step_number: 1,
        title: "Run container with memory limit",
        instruction: "Run container with 512MB memory limit",
        expected_command: "docker run -d --name limited --memory 512m nginx",
        validation: "docker inspect limited | grep Memory"
      },
      {
        step_number: 2,
        title: "Check memory stats",
        instruction: "View container resource usage",
        expected_command: "docker stats --no-stream limited",
        validation: "docker stats --no-stream limited | grep limited"
      },
      {
        step_number: 3,
        title: "CPU limit",
        instruction: "Run container with CPU limit (1.5 CPUs)",
        expected_command: "docker run -d --name cpu-limited --cpus 1.5 nginx",
        validation: "docker inspect cpu-limited | grep NanoCpus"
      },
      {
        step_number: 4,
        title: "Combined limits",
        instruction: "Run with both memory and CPU limits",
        expected_command: "docker run -d --name combined --memory 256m --cpus 0.5 nginx",
        validation: "docker stats --no-stream combined"
      },
      {
        step_number: 5,
        title: "Cleanup",
        instruction: "Remove all containers",
        expected_command: "docker rm -f limited cpu-limited combined",
        validation: "docker ps -a | grep limited"
      }
    ],
    validation_rules: {
      memory_limit_set: "memory limit must be enforced",
      cpu_limit_set: "CPU limit must be enforced",
      stats_accessible: "docker stats must show usage"
    },
    success_criteria: "Successfully apply and verify resource limits",
    environment_image: "docker:20-dind",
    required_tools: ["docker"],
    max_attempts: 5,
    points_reward: 200,
    is_active: true
  },

  # ADVANCED LABS (14-20)
  {
    title: "Docker Registry - Push and Pull Custom Images",
    description: "Set up a private registry and manage custom images",
    difficulty: "hard",
    estimated_minutes: 45,
    lab_type: "docker",
    category: "registry",
    certification_exam: "DCA",
    learning_objectives: "Run private registry, tag images, push/pull from registry",
    prerequisites: ["Completed image building labs"],
    steps: [
      {
        step_number: 1,
        title: "Run local registry",
        instruction: "Start a local Docker registry on port 5000",
        expected_command: "docker run -d -p 5000:5000 --name registry registry:2",
        validation: "docker ps | grep registry"
      },
      {
        step_number: 2,
        title: "Build custom image",
        instruction: "Build a simple custom image",
        expected_command: "echo 'FROM alpine' > Dockerfile && docker build -t myapp:v1 .",
        validation: "docker images | grep myapp"
      },
      {
        step_number: 3,
        title: "Tag for registry",
        instruction: "Tag image for local registry",
        expected_command: "docker tag myapp:v1 localhost:5000/myapp:v1",
        validation: "docker images | grep localhost:5000/myapp"
      },
      {
        step_number: 4,
        title: "Push to registry",
        instruction: "Push image to local registry",
        expected_command: "docker push localhost:5000/myapp:v1",
        validation: "curl -s http://localhost:5000/v2/_catalog | grep myapp"
      },
      {
        step_number: 5,
        title: "Remove local image",
        instruction: "Remove local images to test pull",
        expected_command: "docker rmi myapp:v1 localhost:5000/myapp:v1",
        validation: "docker images | grep myapp"
      },
      {
        step_number: 6,
        title: "Pull from registry",
        instruction: "Pull image from private registry",
        expected_command: "docker pull localhost:5000/myapp:v1",
        validation: "docker images | grep localhost:5000/myapp"
      },
      {
        step_number: 7,
        title: "Cleanup",
        instruction: "Remove registry and images",
        expected_command: "docker rm -f registry && docker rmi localhost:5000/myapp:v1 && rm Dockerfile",
        validation: "docker ps | grep registry"
      }
    ],
    validation_rules: {
      registry_running: "registry must be accessible",
      image_pushed: "image must be in registry",
      image_pulled: "can pull from registry",
      cleanup: "all resources removed"
    },
    success_criteria: "Successfully run private registry and manage images",
    environment_image: "docker:20-dind",
    required_tools: ["docker", "curl"],
    max_attempts: 3,
    points_reward: 400,
    is_active: true
  },

  {
    title: "Health Checks and Auto-Restart",
    description: "Implement container health checks and restart policies",
    difficulty: "hard",
    estimated_minutes: 35,
    lab_type: "docker",
    category: "reliability",
    certification_exam: "DCA",
    learning_objectives: "Define health checks, configure restart policies, test automatic recovery",
    prerequisites: ["Advanced Docker knowledge"],
    steps: [
      {
        step_number: 1,
        title: "Create Dockerfile with HEALTHCHECK",
        instruction: "Create Dockerfile with health check for nginx",
        expected_command: "cat > Dockerfile << 'EOF'\nFROM nginx:alpine\nHEALTHCHECK --interval=5s --timeout=3s --start-period=5s --retries=3 \\\n  CMD wget --no-verbose --tries=1 --spider http://localhost/ || exit 1\nEOF",
        validation: "grep HEALTHCHECK Dockerfile"
      },
      {
        step_number: 2,
        title: "Build image with health check",
        instruction: "Build the image",
        expected_command: "docker build -t webapp:health .",
        validation: "docker images | grep webapp"
      },
      {
        step_number: 3,
        title: "Run with restart policy",
        instruction: "Run container with restart=unless-stopped",
        expected_command: "docker run -d --name web --restart unless-stopped webapp:health",
        validation: "docker inspect web | grep RestartPolicy"
      },
      {
        step_number: 4,
        title: "Check health status",
        instruction: "Verify health check is working",
        expected_command: "sleep 10 && docker inspect web --format='{{.State.Health.Status}}'",
        validation: "docker inspect web --format='{{.State.Health.Status}}' | grep healthy"
      },
      {
        step_number: 5,
        title: "Test auto-restart",
        instruction: "Kill container and verify it restarts",
        expected_command: "docker kill web && sleep 5 && docker ps | grep web",
        validation: "docker ps | grep web"
      },
      {
        step_number: 6,
        title: "View health check logs",
        instruction: "Check health check results",
        expected_command: "docker inspect web --format='{{json .State.Health}}'",
        validation: "docker inspect web | grep Health"
      },
      {
        step_number: 7,
        title: "Cleanup",
        instruction: "Stop container and remove resources",
        expected_command: "docker stop web && docker rm web && docker rmi webapp:health && rm Dockerfile",
        validation: "docker ps -a | grep web"
      }
    ],
    validation_rules: {
      healthcheck_defined: "HEALTHCHECK in Dockerfile",
      container_healthy: "health status must be healthy",
      auto_restart_works: "container restarts after kill",
      cleanup: "all resources removed"
    },
    success_criteria: "Implement working health checks and auto-restart",
    environment_image: "docker:20-dind",
    required_tools: ["docker"],
    max_attempts: 3,
    points_reward: 400,
    is_active: true
  },

  {
    title: "Docker Security - Non-Root User and Read-Only",
    description: "Implement security best practices in containers",
    difficulty: "hard",
    estimated_minutes: 40,
    lab_type: "docker",
    category: "security",
    certification_exam: "DCA",
    learning_objectives: "Run as non-root, read-only filesystem, drop capabilities",
    prerequisites: ["Advanced Docker and Linux security knowledge"],
    steps: [
      {
        step_number: 1,
        title: "Create Dockerfile with non-root user",
        instruction: "Create Dockerfile that runs as non-root user",
        expected_command: "cat > Dockerfile << 'EOF'\nFROM nginx:alpine\nRUN addgroup -S appgroup && adduser -S appuser -G appgroup\nUSER appuser\nEOF",
        validation: "grep USER Dockerfile"
      },
      {
        step_number: 2,
        title: "Build secure image",
        instruction: "Build the image",
        expected_command: "docker build -t secure-nginx .",
        validation: "docker images | grep secure-nginx"
      },
      {
        step_number: 3,
        title: "Run with read-only filesystem",
        instruction: "Run container with read-only root filesystem",
        expected_command: "docker run -d --name secure --read-only --tmpfs /tmp secure-nginx",
        validation: "docker inspect secure | grep ReadonlyRootfs"
      },
      {
        step_number: 4,
        title: "Verify non-root user",
        instruction: "Check that container runs as non-root",
        expected_command: "docker exec secure whoami",
        validation: "docker exec secure whoami | grep -v root"
      },
      {
        step_number: 5,
        title: "Test read-only",
        instruction: "Try to write to filesystem (should fail)",
        expected_command: "docker exec secure touch /test.txt || echo 'Read-only verified'",
        validation: "docker exec secure sh -c 'touch /test.txt 2>&1' | grep -i 'read-only'"
      },
      {
        step_number: 6,
        title: "Drop capabilities",
        instruction: "Run with dropped capabilities",
        expected_command: "docker run -d --name cap-drop --cap-drop=ALL --cap-add=NET_BIND_SERVICE nginx",
        validation: "docker inspect cap-drop | grep CapDrop"
      },
      {
        step_number: 7,
        title: "Cleanup",
        instruction: "Remove all secure containers and images",
        expected_command: "docker rm -f secure cap-drop && docker rmi secure-nginx && rm Dockerfile",
        validation: "docker ps -a | grep secure"
      }
    ],
    validation_rules: {
      nonroot_user: "must run as non-root user",
      readonly_fs: "root filesystem must be read-only",
      capabilities_dropped: "unnecessary capabilities removed",
      security_verified: "security measures tested"
    },
    success_criteria: "Implement and verify container security hardening",
    environment_image: "docker:20-dind",
    required_tools: ["docker"],
    max_attempts: 3,
    points_reward: 500,
    is_active: true
  },

  {
    title: "Container Performance Monitoring",
    description: "Monitor and analyze container performance metrics",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "docker",
    category: "monitoring",
    certification_exam: "DCA",
    learning_objectives: "Use docker stats, analyze resource usage, identify performance issues",
    prerequisites: ["Understanding of system resources"],
    steps: [
      {
        step_number: 1,
        title: "Run test containers",
        instruction: "Start multiple containers with different workloads",
        expected_command: "docker run -d --name web nginx && docker run -d --name db mysql:8 -e MYSQL_ROOT_PASSWORD=secret",
        validation: "docker ps | wc -l"
      },
      {
        step_number: 2,
        title: "View live stats",
        instruction: "Monitor real-time resource usage",
        expected_command: "docker stats --no-stream",
        validation: "docker stats --no-stream | grep web"
      },
      {
        step_number: 3,
        title: "Format stats output",
        instruction: "Display stats with custom format",
        expected_command: "docker stats --no-stream --format 'table {{.Container}}\\t{{.CPUPerc}}\\t{{.MemUsage}}'",
        validation: "docker stats --no-stream --format '{{.Container}}'"
      },
      {
        step_number: 4,
        title: "Export stats to file",
        instruction: "Save stats to CSV file",
        expected_command: "docker stats --no-stream --format '{{.Container}},{{.CPUPerc}},{{.MemUsage}}' > stats.csv",
        validation: "test -f stats.csv"
      },
      {
        step_number: 5,
        title: "Cleanup",
        instruction: "Remove containers and stats file",
        expected_command: "docker rm -f web db && rm stats.csv",
        validation: "docker ps | grep web"
      }
    ],
    validation_rules: {
      containers_running: "multiple containers must be running",
      stats_collected: "stats must be retrievable",
      export_works: "stats exported to file"
    },
    success_criteria: "Successfully monitor container performance",
    environment_image: "docker:20-dind",
    required_tools: ["docker"],
    max_attempts: 5,
    points_reward: 250,
    is_active: true
  },

  {
    title: "Backup and Restore Container Data",
    description: "Learn to backup and restore container data and configurations",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "docker",
    category: "operations",
    certification_exam: "DCA",
    learning_objectives: "Export/import containers, backup volumes, restore data",
    prerequisites: ["Understanding of Docker volumes"],
    steps: [
      {
        step_number: 1,
        title: "Create data volume",
        instruction: "Create volume and populate with data",
        expected_command: "docker volume create backup-vol && docker run --rm -v backup-vol:/data alpine sh -c 'echo test > /data/file.txt'",
        validation: "docker volume ls | grep backup-vol"
      },
      {
        step_number: 2,
        title: "Backup volume data",
        instruction: "Backup volume to tar archive",
        expected_command: "docker run --rm -v backup-vol:/data -v $(pwd):/backup alpine tar czf /backup/backup.tar.gz -C /data .",
        validation: "test -f backup.tar.gz"
      },
      {
        step_number: 3,
        title: "Create container to backup",
        instruction: "Run container with data to backup",
        expected_command: "docker run -d --name db-backup -v backup-vol:/var/lib/data alpine sleep 3600",
        validation: "docker ps | grep db-backup"
      },
      {
        step_number: 4,
        title: "Export container",
        instruction: "Export container filesystem",
        expected_command: "docker export db-backup > container-backup.tar",
        validation: "test -f container-backup.tar"
      },
      {
        step_number: 5,
        title: "Delete original resources",
        instruction: "Remove volume and container",
        expected_command: "docker rm -f db-backup && docker volume rm backup-vol",
        validation: "docker volume ls | grep backup-vol"
      },
      {
        step_number: 6,
        title: "Restore volume",
        instruction: "Create new volume and restore data",
        expected_command: "docker volume create restored-vol && docker run --rm -v restored-vol:/data -v $(pwd):/backup alpine tar xzf /backup/backup.tar.gz -C /data",
        validation: "docker run --rm -v restored-vol:/data alpine cat /data/file.txt"
      },
      {
        step_number: 7,
        title: "Cleanup",
        instruction: "Remove all backup resources",
        expected_command: "docker volume rm restored-vol && rm backup.tar.gz container-backup.tar",
        validation: "test -f backup.tar.gz"
      }
    ],
    validation_rules: {
      volume_backed_up: "volume data saved to tar",
      container_exported: "container filesystem exported",
      data_restored: "data successfully restored",
      cleanup: "all resources removed"
    },
    success_criteria: "Successfully backup and restore container data",
    environment_image: "docker:20-dind",
    required_tools: ["docker"],
    max_attempts: 5,
    points_reward: 300,
    is_active: true
  },

  {
    title: "Container Orchestration Basics with Swarm (Deprecated)",
    description: "Deprecated in favor of Docker → Kubernetes Bridge modules.",
    difficulty: "hard",
    estimated_minutes: 0,
    lab_type: "docker",
    category: "deprecated",
    certification_exam: nil,
    learning_objectives: "Use Kubernetes for orchestration going forward",
    prerequisites: ["Completed all intermediate labs"],
    steps: [
      {
        step_number: 1,
        title: "Initialize swarm",
        instruction: "Initialize Docker Swarm mode",
        expected_command: "docker swarm init",
        validation: "docker info | grep Swarm | grep active"
      },
      {
        step_number: 2,
        title: "Deploy service",
        instruction: "Create a replicated service with 3 replicas",
        expected_command: "docker service create --name web --replicas 3 -p 8080:80 nginx",
        validation: "docker service ls | grep web"
      },
      {
        step_number: 3,
        title: "List service tasks",
        instruction: "View all running tasks of the service",
        expected_command: "docker service ps web",
        validation: "docker service ps web | grep Running | wc -l"
      },
      {
        step_number: 4,
        title: "Scale service",
        instruction: "Scale web service to 5 replicas",
        expected_command: "docker service scale web=5",
        validation: "docker service ps web | grep Running | wc -l"
      },
      {
        step_number: 5,
        title: "Rolling update",
        instruction: "Update service to use nginx:alpine",
        expected_command: "docker service update --image nginx:alpine web",
        validation: "docker service inspect web | grep alpine"
      },
      {
        step_number: 6,
        title: "View service logs",
        instruction: "Check logs from all service tasks",
        expected_command: "docker service logs web",
        validation: "docker service logs web | wc -l"
      },
      {
        step_number: 7,
        title: "Cleanup swarm",
        instruction: "Remove service and leave swarm",
        expected_command: "docker service rm web && docker swarm leave --force",
        validation: "docker info | grep Swarm | grep inactive"
      }
    ],
    validation_rules: {
      swarm_initialized: "swarm must be active",
      service_deployed: "service with 3 replicas",
      scaling_works: "scaled to 5 replicas",
      rolling_update: "image updated without downtime",
      cleanup: "swarm left successfully"
    },
    success_criteria: "Use Kubernetes for orchestration",
    environment_image: "docker:20-dind",
    required_tools: ["docker"],
    max_attempts: 0,
    points_reward: 0,
    is_active: false
  },
  {
    title: "Troubleshooting Docker Containers",
    description: "Debug and fix 10 common Docker container failures: exit crashes, port conflicts, permission errors, networking issues, and more",
    difficulty: "hard",
    estimated_minutes: 45,
    lab_type: "docker",
    category: "troubleshooting",
    learning_objectives: "Diagnose container exits, port conflicts, volume permission errors, image pull failures, disk space issues, network problems, environment variable errors, and daemon connectivity; use docker logs, inspect, events, and debugging techniques",
    prerequisites: ["Docker installed", "Basic understanding of containers", "Command line experience"],
    steps: [
      { step_number: 1, title: "Scenario 1: Container Exits Immediately", instruction: "Run container that exits immediately with 'exit 1', diagnose with docker logs, then fix by changing command to run indefinitely", expected_command: "docker run -d --name exit-test alpine sh -c 'exit 1' && sleep 3 && docker logs exit-test && docker rm -f exit-test && docker run -d --name exit-test alpine sleep 3600", validation: "docker ps | grep exit-test", hint: "Use 'docker logs' to see why container exited, then use 'docker inspect' to check exit code" },
      { step_number: 2, title: "Scenario 2: Port Already in Use", instruction: "Start nginx on port 8080, try to start another on same port (will fail), diagnose error, fix by using different port 8081", expected_command: "docker run -d --name nginx1 -p 8080:80 nginx:alpine && docker run -d --name nginx2 -p 8080:80 nginx:alpine 2>&1 | grep 'address already in use' && docker run -d --name nginx2 -p 8081:80 nginx:alpine", validation: "docker ps | grep nginx2", hint: "Look for 'bind: address already in use' error, use 'docker ps' to see what's using the port" },
      { step_number: 3, title: "Scenario 3: Volume Permission Denied", instruction: "Create directory with restricted permissions, try to mount and write (will fail), diagnose permission error, fix with proper ownership", expected_command: "mkdir -p /tmp/restricted && chmod 000 /tmp/restricted && docker run --rm -v /tmp/restricted:/data alpine sh -c 'echo test > /data/file' 2>&1 | grep -i permission && sudo chmod 755 /tmp/restricted && docker run --rm -v /tmp/restricted:/data alpine sh -c 'echo test > /data/file'", validation: "ls /tmp/restricted/file", hint: "Check directory permissions with 'ls -ld', use chmod or run container with appropriate user" },
      { step_number: 4, title: "Scenario 4: Image Not Found", instruction: "Try to run non-existent image nginx:doesnotexist999, diagnose pull error, fix by using correct tag nginx:alpine", expected_command: "docker run nginx:doesnotexist999 2>&1 | grep -i 'manifest.*not found' && docker run -d --name image-test nginx:alpine", validation: "docker ps | grep image-test", hint: "Error shows 'manifest unknown' or 'not found', verify image exists on Docker Hub" },
      { step_number: 5, title: "Scenario 5: Out of Disk Space", instruction: "Check disk usage with 'docker system df', prune unused images/containers to free space", expected_command: "docker system df && docker system prune -f", validation: "docker system df | grep 'TYPE.*TOTAL'", hint: "Use 'docker system df' to see space usage, 'docker system prune' to clean up" },
      { step_number: 6, title: "Scenario 6: Container Network Isolation", instruction: "Start two containers on default bridge, create custom network, move containers to custom network to enable communication by name", expected_command: "docker run -d --name web1 nginx:alpine && docker run -d --name web2 alpine sh -c 'ping -c 2 web1' 2>&1 | grep 'bad address' && docker network create mynet && docker network connect mynet web1 && docker run --rm --network mynet alpine ping -c 2 web1", validation: "docker network inspect mynet | grep web1", hint: "Containers on default bridge can only communicate by IP, custom networks enable DNS resolution" },
      { step_number: 7, title: "Scenario 7: Environment Variable Not Set", instruction: "Run container expecting MY_VAR env var (will fail), diagnose missing variable, fix by passing -e MY_VAR=value", expected_command: "docker run --rm alpine sh -c 'echo $MY_VAR' && docker run --rm -e MY_VAR=hello alpine sh -c 'echo $MY_VAR'", validation: "docker run --rm -e MY_VAR=test alpine sh -c 'echo $MY_VAR' | grep test", hint: "Use -e flag to pass environment variables, or --env-file for multiple vars" },
      { step_number: 8, title: "Scenario 8: Container Restart Loop", instruction: "Create container with failing healthcheck causing restart loop, diagnose with docker events, fix healthcheck", expected_command: "docker run -d --name restart-test --restart=always --health-cmd='exit 1' --health-interval=5s alpine sleep 3600 && sleep 10 && docker events --since 5s --filter 'container=restart-test' | grep unhealthy && docker rm -f restart-test && docker run -d --name restart-test --health-cmd='exit 0' --health-interval=5s alpine sleep 3600", validation: "docker inspect restart-test | grep '\"Status\": \"healthy\"'", hint: "Use 'docker events' to see health status changes, check healthcheck command" },
      { step_number: 9, title: "Scenario 9: Name Conflict", instruction: "Try to create container with existing name (will fail), diagnose conflict error, fix by removing old container or using different name", expected_command: "docker run -d --name conflict-test alpine sleep 3600 && docker run -d --name conflict-test alpine sleep 3600 2>&1 | grep 'Conflict' && docker rm -f conflict-test && docker run -d --name conflict-test alpine sleep 3600", validation: "docker ps | grep conflict-test", hint: "Error shows 'Conflict. The container name is already in use', remove old container or rename new one" },
      { step_number: 10, title: "Scenario 10: Container Cannot Connect to Host Service", instruction: "Start service on host, container tries to connect to 'localhost' (will fail), diagnose connection refused, fix using host.docker.internal or host network mode", expected_command: "python3 -m http.server 9999 >/dev/null 2>&1 & HTTP_PID=$!; sleep 2; docker run --rm alpine sh -c 'wget -O- localhost:9999' 2>&1 | grep 'Connection refused' && docker run --rm --add-host=host.docker.internal:host-gateway alpine sh -c 'wget -O- host.docker.internal:9999' | grep -i 'http' ; kill $HTTP_PID", validation: "echo 'Verified host communication works'", hint: "Use 'host.docker.internal' to reach host from container, or '--network host' to share host network" }
    ],
    validation_rules: {
      exit_fixed: "Container runs without immediate exit",
      port_fixed: "Port conflict resolved with different port",
      permission_fixed: "Volume permission issue resolved",
      image_fixed: "Correct image tag used",
      disk_cleaned: "Disk space freed via pruning",
      network_fixed: "Custom network enables container communication",
      env_fixed: "Environment variable properly passed",
      healthcheck_fixed: "Healthcheck passes successfully",
      name_fixed: "Name conflict resolved",
      host_connection_fixed: "Container can reach host services"
    },
    success_criteria: "Successfully diagnosed and fixed all 10 common Docker container failures",
    environment_image: "docker:20-dind",
    required_tools: ["docker"],
    max_attempts: 15,
    points_reward: 280,
    is_active: true
  }
]

# Create Hands-On Labs
docker_labs.each_with_index do |lab_data, index|
  begin
    lab = HandsOnLab.find_or_initialize_by(title: lab_data[:title])
    lab.assign_attributes(lab_data)
    
    if lab.save
      print "."
    else
      puts "\n❌ Failed to create: #{lab_data[:title]}"
      puts "   Errors: #{lab.errors.full_messages.join(', ')}"
    end
  rescue => e
    puts "\n❌ Error on #{lab_data[:title]}: #{e.message}"
  end
  
  # Progress indicator every 5 labs
  if (index + 1) % 5 == 0
    puts " #{index + 1}/#{docker_labs.length}"
  end
end

puts "\n\n✅ Docker Hands-On Labs Seeding Complete!"
puts "   Total labs: #{HandsOnLab.count}"
puts "   By difficulty:"
puts "     - Easy (Beginner): #{HandsOnLab.where(difficulty: 'easy').count}"
puts "     - Medium (Intermediate): #{HandsOnLab.where(difficulty: 'medium').count}"
puts "     - Hard (Advanced): #{HandsOnLab.where(difficulty: 'hard').count}"
puts "   By category:"
HandsOnLab.group(:category).count.each do |category, count|
  puts "     - #{category&.capitalize || 'Uncategorized'}: #{count}"
end
puts "   Total estimated time: #{HandsOnLab.sum(:estimated_minutes)} minutes"
puts "   Average lab duration: #{HandsOnLab.average(:estimated_minutes).to_i} minutes"
puts "\n🧪 Ready for Hands-On Learning! 🐳"
