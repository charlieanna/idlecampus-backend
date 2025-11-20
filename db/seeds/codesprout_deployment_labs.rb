# CodeSprout Deployment Labs
# Hands-on labs that combine multiple lessons into complete deployment scenarios

puts "🧪 Creating CodeSprout Deployment Labs..."

# Lab 4.1: Run CodeSprout Frontend
lab_4_1 = HandsOnLab.create!(
  title: "Lab 4.1: Deploy CodeSprout Frontend",
  slug: "codesprout-frontend-deployment",
  description: "Build and deploy the CodeSprout React frontend, making it accessible at localhost:3000",
  lab_type: "docker",
  difficulty: "easy",
  estimated_minutes: 20,
  category: "deployment",
  is_active: true,
  points_reward: 200,
  learning_objectives: [
    "Build a frontend image from a Dockerfile",
    "Run a web server container with port mapping",
    "Configure containers with environment variables"
  ],
  prerequisites: ["Build", "Run containers", "Port mapping"],
  required_tools: ["docker", "curl"],
  certification_exam: "DCA",
  steps: [
    {
      step_number: 1,
      title: "Build the frontend image",
      instruction: "Navigate to the frontend directory and build the CodeSprout frontend image tagged as codesprout/frontend:1.0",
      expected_command: "docker build -t codesprout/frontend:1.0 ./frontend",
      validation: "docker images | grep codesprout/frontend",
      hints: [
        "Use 'docker build -t' to tag the image",
        "The path should be ./frontend",
        "Tag format: name:version"
      ]
    },
    {
      step_number: 2,
      title: "Run the frontend container",
      instruction: "Run the frontend container in detached mode, map port 3000, and name it 'codesprout-web'",
      expected_command: "docker run -d -p 3000:3000 --name codesprout-web codesprout/frontend:1.0",
      validation: "docker ps | grep codesprout-web",
      hints: [
        "Use -d for detached mode",
        "Map port 3000:3000 with -p",
        "Name it with --name codesprout-web"
      ]
    },
    {
      step_number: 3,
      title: "Verify frontend is accessible",
      instruction: "Test that the frontend is serving content at localhost:3000",
      expected_command: "curl http://localhost:3000",
      validation: "curl -s http://localhost:3000 | grep -q 'CodeSprout' && echo 'SUCCESS'",
      hints: [
        "Use curl to fetch the page",
        "The response should contain 'CodeSprout'",
        "If it's not working, check 'docker logs codesprout-web'"
      ]
    },
    {
      step_number: 4,
      title: "Add API configuration",
      instruction: "Stop and remove the current container, then run it again with the API_URL environment variable set to http://localhost:8080",
      expected_command: "docker stop codesprout-web && docker rm codesprout-web && docker run -d -p 3000:3000 -e API_URL=http://localhost:8080 --name codesprout-web codesprout/frontend:1.0",
      validation: "docker inspect codesprout-web | grep API_URL",
      hints: [
        "Stop with 'docker stop codesprout-web'",
        "Remove with 'docker rm codesprout-web'",
        "Add -e API_URL=http://localhost:8080"
      ]
    },
    {
      step_number: 5,
      title: "View frontend logs",
      instruction: "Check the logs to confirm the frontend started successfully",
      expected_command: "docker logs codesprout-web",
      validation: "docker logs codesprout-web | grep -q 'Serving' && echo 'SUCCESS'",
      hints: [
        "Use 'docker logs' followed by container name",
        "Look for startup messages"
      ]
    }
  ],
  validation_rules: {
    required_containers: ["codesprout-web"],
    required_images: ["codesprout/frontend:1.0"],
    required_ports: ["3000"],
    max_time_minutes: 20
  },
  success_criteria: "Frontend accessible at localhost:3000 with API_URL configured"
)

puts "  ✓ Created: #{lab_4_1.title}"

# Lab 4.2: Connect Frontend to Backend
lab_4_2 = HandsOnLab.create!(
  title: "Lab 4.2: Connect Frontend to Backend API",
  slug: "codesprout-backend-connection",
  description: "Deploy the backend API and connect it to the frontend using a Docker network",
  lab_type: "docker",
  difficulty: "medium",
  estimated_minutes: 25,
  category: "networking",
  is_active: true,
  points_reward: 250,
  learning_objectives: [
    "Build and run backend API containers",
    "Create custom Docker networks",
    "Enable service-to-service communication using DNS"
  ],
  prerequisites: ["Docker networks", "Multi-container applications"],
  required_tools: ["docker", "curl"],
  certification_exam: "DCA",
  steps: [
    {
      step_number: 1,
      title: "Create a custom network",
      instruction: "Create a Docker bridge network named 'codesprout-net' for all services to communicate",
      expected_command: "docker network create codesprout-net",
      validation: "docker network ls | grep codesprout-net",
      hints: [
        "Use 'docker network create'",
        "Name it 'codesprout-net'"
      ]
    },
    {
      step_number: 2,
      title: "Build the backend image",
      instruction: "Build the backend API image tagged as codesprout/backend:1.0",
      expected_command: "docker build -t codesprout/backend:1.0 ./backend",
      validation: "docker images | grep codesprout/backend",
      hints: [
        "Use 'docker build -t'",
        "Path is ./backend",
        "Tag as codesprout/backend:1.0"
      ]
    },
    {
      step_number: 3,
      title: "Run backend on the network",
      instruction: "Run the backend container on port 8080, connected to codesprout-net, named 'codesprout-api'",
      expected_command: "docker run -d -p 8080:8080 --name codesprout-api --network codesprout-net codesprout/backend:1.0",
      validation: "docker ps | grep codesprout-api",
      hints: [
        "Use --network codesprout-net",
        "Name it 'codesprout-api'",
        "Map port 8080:8080"
      ]
    },
    {
      step_number: 4,
      title: "Connect frontend to the network",
      instruction: "Stop the frontend, then restart it connected to codesprout-net with API_URL pointing to http://codesprout-api:8080",
      expected_command: "docker stop codesprout-web && docker rm codesprout-web && docker run -d -p 3000:3000 --name codesprout-web --network codesprout-net -e API_URL=http://codesprout-api:8080 codesprout/frontend:1.0",
      validation: "docker inspect codesprout-web | grep codesprout-net",
      hints: [
        "Connect to --network codesprout-net",
        "Set API_URL to http://codesprout-api:8080 (using container name)",
        "Both containers must be on the same network"
      ]
    },
    {
      step_number: 5,
      title: "Test service communication",
      instruction: "Verify the frontend can reach the backend API",
      expected_command: "curl http://localhost:3000/api/health",
      validation: "curl -s http://localhost:8080/health | grep -q 'ok' && echo 'SUCCESS'",
      hints: [
        "Test the backend directly: curl http://localhost:8080/health",
        "The frontend should be able to make API calls",
        "Check logs with 'docker logs codesprout-web' if issues"
      ]
    }
  ],
  validation_rules: {
    required_containers: ["codesprout-web", "codesprout-api"],
    required_networks: ["codesprout-net"],
    max_time_minutes: 25
  },
  success_criteria: "Frontend and backend communicating on custom network"
)

puts "  ✓ Created: #{lab_4_2.title}"

# Lab 4.3: Add PostgreSQL Database
lab_4_3 = HandsOnLab.create!(
  title: "Lab 4.3: Deploy Full Stack with Database",
  slug: "codesprout-database-integration",
  description: "Add PostgreSQL database with persistent storage and connect the backend to it",
  lab_type: "docker",
  difficulty: "medium",
  estimated_minutes: 30,
  category: "data",
  is_active: true,
  points_reward: 300,
  learning_objectives: [
    "Run database containers with persistent volumes",
    "Configure database credentials securely",
    "Connect backend services to databases"
  ],
  prerequisites: ["Docker volumes", "Environment variables", "Networking"],
  required_tools: ["docker"],
  certification_exam: "DCA",
  steps: [
    {
      step_number: 1,
      title: "Create a volume for database data",
      instruction: "Create a named volume called 'codesprout-data' to persist PostgreSQL data",
      expected_command: "docker volume create codesprout-data",
      validation: "docker volume ls | grep codesprout-data",
      hints: [
        "Use 'docker volume create'",
        "Name it 'codesprout-data'"
      ]
    },
    {
      step_number: 2,
      title: "Run PostgreSQL container",
      instruction: "Run PostgreSQL 15 on the codesprout-net network, named 'codesprout-db', with the volume mounted and password set to 'secret123'",
      expected_command: "docker run -d --name codesprout-db --network codesprout-net -v codesprout-data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=secret123 -e POSTGRES_DB=codesprout postgres:15",
      validation: "docker ps | grep codesprout-db",
      hints: [
        "Use postgres:15 image",
        "Mount volume: -v codesprout-data:/var/lib/postgresql/data",
        "Set POSTGRES_PASSWORD and POSTGRES_DB"
      ]
    },
    {
      step_number: 3,
      title: "Verify database is running",
      instruction: "Check the PostgreSQL logs to confirm it started successfully",
      expected_command: "docker logs codesprout-db",
      validation: "docker logs codesprout-db | grep -q 'database system is ready' && echo 'SUCCESS'",
      hints: [
        "Use 'docker logs codesprout-db'",
        "Look for 'database system is ready to accept connections'"
      ]
    },
    {
      step_number: 4,
      title: "Configure backend with database credentials",
      instruction: "Stop and restart the backend with database connection environment variables (DB_HOST=codesprout-db, DB_PORT=5432, DB_NAME=codesprout, DB_USER=postgres, DB_PASSWORD=secret123)",
      expected_command: "docker stop codesprout-api && docker rm codesprout-api && docker run -d -p 8080:8080 --name codesprout-api --network codesprout-net -e DB_HOST=codesprout-db -e DB_PORT=5432 -e DB_NAME=codesprout -e DB_USER=postgres -e DB_PASSWORD=secret123 codesprout/backend:1.0",
      validation: "docker inspect codesprout-api | grep DB_HOST",
      hints: [
        "Pass 5 environment variables: DB_HOST, DB_PORT, DB_NAME, DB_USER, DB_PASSWORD",
        "DB_HOST should be 'codesprout-db' (container name)",
        "Keep it on codesprout-net network"
      ]
    },
    {
      step_number: 5,
      title: "Test database connectivity",
      instruction: "Verify the backend can connect to the database by checking the API health endpoint",
      expected_command: "curl http://localhost:8080/health",
      validation: "curl -s http://localhost:8080/health | grep -q 'database.*connected' && echo 'SUCCESS'",
      hints: [
        "The health endpoint should report database status",
        "Check backend logs if connection fails: docker logs codesprout-api"
      ]
    },
    {
      step_number: 6,
      title: "Verify data persistence",
      instruction: "Restart the database container and confirm data persists",
      expected_command: "docker restart codesprout-db",
      validation: "docker ps | grep codesprout-db",
      hints: [
        "Use 'docker restart'",
        "The volume preserves data across restarts"
      ]
    }
  ],
  validation_rules: {
    required_containers: ["codesprout-web", "codesprout-api", "codesprout-db"],
    required_volumes: ["codesprout-data"],
    max_time_minutes: 30
  },
  success_criteria: "Complete 3-tier application (frontend, backend, database) running with persistent data"
)

puts "  ✓ Created: #{lab_4_3.title}"

# Lab 4.4: Docker Compose Orchestration
lab_4_4 = HandsOnLab.create!(
  title: "Lab 4.4: Deploy with Docker Compose",
  slug: "codesprout-compose-deployment",
  description: "Use Docker Compose to orchestrate the entire CodeSprout stack with a single command",
  lab_type: "docker-compose",
  difficulty: "medium",
  estimated_minutes: 35,
  category: "orchestration",
  is_active: true,
  points_reward: 350,
  learning_objectives: [
    "Write docker-compose.yml for multi-container applications",
    "Define service dependencies and startup order",
    "Manage entire application stacks with single commands"
  ],
  prerequisites: ["Docker Compose basics", "Multi-container networking"],
  required_tools: ["docker", "docker-compose"],
  certification_exam: "DCA",
  steps: [
    {
      step_number: 1,
      title: "Stop all running containers",
      instruction: "Clean up existing containers to start fresh with Docker Compose",
      expected_command: "docker stop codesprout-web codesprout-api codesprout-db && docker rm codesprout-web codesprout-api codesprout-db",
      validation: "! docker ps -a | grep codesprout",
      hints: [
        "Stop all three containers",
        "Then remove them",
        "Use: docker stop [containers] && docker rm [containers]"
      ]
    },
    {
      step_number: 2,
      title: "Create docker-compose.yml",
      instruction: "Create a docker-compose.yml file in the project root that defines all three services (frontend, backend, database)",
      expected_command: "cat docker-compose.yml",
      validation: "test -f docker-compose.yml && grep -q 'services:' docker-compose.yml",
      hints: [
        "File should define: services, networks, volumes",
        "Include: frontend (port 3000), backend (port 8080), database (postgres:15)",
        "Use the provided template or create your own"
      ]
    },
    {
      step_number: 3,
      title: "Start the stack with Compose",
      instruction: "Use docker-compose to start all services in detached mode",
      expected_command: "docker-compose up -d",
      validation: "docker-compose ps | grep Up",
      hints: [
        "Use 'docker-compose up -d'",
        "This builds images and starts all services",
        "Wait for all containers to be 'Up'"
      ]
    },
    {
      step_number: 4,
      title: "Verify all services are running",
      instruction: "Check the status of all Compose services",
      expected_command: "docker-compose ps",
      validation: "docker-compose ps | grep -c Up | grep -q 3",
      hints: [
        "All 3 services should show 'Up'",
        "Use 'docker-compose ps' to check status"
      ]
    },
    {
      step_number: 5,
      title: "Test the full application",
      instruction: "Verify the frontend is accessible and can communicate with the backend and database",
      expected_command: "curl http://localhost:3000 && curl http://localhost:8080/health",
      validation: "curl -s http://localhost:8080/health | grep -q 'database.*connected'",
      hints: [
        "Frontend: http://localhost:3000",
        "Backend health: http://localhost:8080/health",
        "Both should respond successfully"
      ]
    },
    {
      step_number: 6,
      title: "View logs from all services",
      instruction: "Use Docker Compose to view logs from all services",
      expected_command: "docker-compose logs",
      validation: "docker-compose logs 2>&1 | grep -q 'codesprout'",
      hints: [
        "Use 'docker-compose logs'",
        "Add -f to follow logs in real-time",
        "Add service name to see specific logs"
      ]
    },
    {
      step_number: 7,
      title: "Stop the stack",
      instruction: "Stop and remove all containers using Docker Compose (but preserve volumes)",
      expected_command: "docker-compose down",
      validation: "! docker-compose ps | grep Up",
      hints: [
        "Use 'docker-compose down'",
        "This removes containers and networks",
        "Volumes are preserved"
      ]
    }
  ],
  validation_rules: {
    required_files: ["docker-compose.yml"],
    max_time_minutes: 35
  },
  success_criteria: "Complete CodeSprout stack managed with Docker Compose"
)

puts "  ✓ Created: #{lab_4_4.title}"

# Lab 4.5: Manage and Scale the Application
lab_4_5 = HandsOnLab.create!(
  title: "Lab 4.5: Manage and Scale CodeSprout",
  slug: "codesprout-management-scaling",
  description: "Update services, check logs, and scale the backend to handle more traffic",
  lab_type: "docker-compose",
  difficulty: "medium",
  estimated_minutes: 25,
  category: "operations",
  is_active: true,
  points_reward: 300,
  learning_objectives: [
    "Update and restart services without downtime",
    "Debug applications using logs",
    "Scale services horizontally to handle load"
  ],
  prerequisites: ["Docker Compose", "Multi-container operations"],
  required_tools: ["docker", "docker-compose"],
  certification_exam: "DCA",
  steps: [
    {
      step_number: 1,
      title: "Start the CodeSprout stack",
      instruction: "Bring up the entire stack using Docker Compose",
      expected_command: "docker-compose up -d",
      validation: "docker-compose ps | grep -c Up | grep -q 3",
      hints: [
        "Use 'docker-compose up -d'",
        "All services should start"
      ]
    },
    {
      step_number: 2,
      title: "View backend logs",
      instruction: "Check the backend logs to see API requests",
      expected_command: "docker-compose logs backend",
      validation: "docker-compose logs backend | grep -q 'codesprout'",
      hints: [
        "Use 'docker-compose logs backend'",
        "Add -f to follow logs in real-time"
      ]
    },
    {
      step_number: 3,
      title: "Update backend code",
      instruction: "Rebuild and update the backend service with code changes",
      expected_command: "docker-compose up -d --build backend",
      validation: "docker-compose ps backend | grep Up",
      hints: [
        "Use --build to rebuild the image",
        "Only update the backend service",
        "Other services keep running"
      ]
    },
    {
      step_number: 4,
      title: "Scale the backend",
      instruction: "Scale the backend to 3 instances to handle more traffic",
      expected_command: "docker-compose up -d --scale backend=3",
      validation: "docker-compose ps | grep backend | wc -l | grep -q 3",
      hints: [
        "Use --scale backend=3",
        "This creates 3 backend containers",
        "Note: You may need to remove explicit port mapping for scaling to work"
      ]
    },
    {
      step_number: 5,
      title: "Verify scaling",
      instruction: "Check that all 3 backend instances are running",
      expected_command: "docker-compose ps",
      validation: "docker-compose ps | grep backend | grep -c Up | grep -q 3",
      hints: [
        "Use 'docker-compose ps'",
        "You should see 3 backend containers",
        "All should be in 'Up' state"
      ]
    },
    {
      step_number: 6,
      title: "View aggregated logs",
      instruction: "View logs from all backend instances simultaneously",
      expected_command: "docker-compose logs backend",
      validation: "docker-compose logs backend 2>&1 | grep -q backend",
      hints: [
        "Logs from all 3 instances are combined",
        "Each log line shows which instance it came from"
      ]
    },
    {
      step_number: 7,
      title: "Clean shutdown",
      instruction: "Stop and remove all containers gracefully",
      expected_command: "docker-compose down",
      validation: "! docker-compose ps | grep Up",
      hints: [
        "Use 'docker-compose down'",
        "This stops all services cleanly",
        "Data in volumes is preserved"
      ]
    }
  ],
  validation_rules: {
    max_time_minutes: 25
  },
  success_criteria: "Successfully scaled and managed CodeSprout services"
)

puts "  ✓ Created: #{lab_4_5.title}"

puts "🎉 Successfully created #{HandsOnLab.where("slug LIKE 'codesprout-%'").count} CodeSprout deployment labs!"
