# CodeSprout Application Deployment - Interactive Learning Units
# Module 4: Deploying the CodeSprout Application
# Progressive lessons teaching how to deploy a multi-service application locally

puts "🚀 Creating CodeSprout Deployment Learning Units..."

# ========================================
# CLUSTER 1: Building the Frontend
# Goal: Get CodeSprout frontend running at localhost:3000
# ========================================

# Lesson 4.1: Build a Node.js frontend image
unit_4_1 = InteractiveLearningUnit.create!(
  title: "Building the CodeSprout Frontend",
  slug: "codesprout-build-frontend",
  concept_explanation: <<~MD,
    # Building the Frontend Image

    Sarah: "Alright team, let's start deploying CodeSprout! First up: the frontend.
    Our users will interact with a React web application that needs to be containerized."

    ## What We're Building
    CodeSprout is a task management application with three components:
    - **Frontend**: React app (what users see)
    - **Backend**: Node.js API (business logic)
    - **Database**: PostgreSQL (data storage)

    ## Building the Frontend

    The frontend is a React application. To containerize it, we need a Dockerfile that:
    1. Uses a Node.js base image
    2. Copies the application code
    3. Installs dependencies (`npm install`)
    4. Builds the React app (`npm run build`)
    5. Serves it with a lightweight server

    **Command**: `docker build -t codesprout/frontend:1.0 ./frontend`

    This creates an image tagged `codesprout/frontend:1.0` from the code in `./frontend` directory.
  MD
  command_to_learn: "docker build -t codesprout/frontend:1.0 ./frontend",
  command_variations: [
    "docker build --tag codesprout/frontend:1.0 ./frontend",
    "docker image build -t codesprout/frontend:1.0 ./frontend"
  ],
  practice_hints: [
    "Use -t to tag the image with a name and version",
    "Format: docker build -t NAME:TAG PATH",
    "The path (./frontend) points to the directory with the Dockerfile",
    "Try: docker build -t codesprout/frontend:1.0 ./frontend"
  ],
  scenario_narrative: "Build the CodeSprout frontend image so we can run the web interface.",
  difficulty_level: "medium",
  estimated_minutes: 4,
  sequence_order: 108,
  category: "images",
  published: true,
  quiz_question_text: "What does the -t flag do in 'docker build'?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "Tags the image with a name and version", correct: true },
    { text: "Sets build timeout", correct: false },
    { text: "Runs tests after building", correct: false },
    { text: "Creates a temporary image", correct: false }
  ],
  quiz_correct_answer: "Tags the image with a name and version",
  quiz_explanation: "The -t flag tags the built image, making it easy to reference with a meaningful name like 'codesprout/frontend:1.0'",
  learning_objectives: ["Build Docker images from Dockerfiles", "Tag images with names and versions"],
  prerequisites: ["running-nginx-detached"],
  concept_tags: ["docker-build", "image-tagging", "dockerfiles"]
)

puts "  ✓ Created: #{unit_4_1.title}"

# Lesson 4.2: Expose frontend on port 3000
unit_4_2 = InteractiveLearningUnit.create!(
  title: "Running the Frontend on Port 3000",
  slug: "codesprout-run-frontend",
  concept_explanation: <<~MD,
    # Exposing the Frontend

    Sarah: "Great! Now let's run the frontend and make it accessible at localhost:3000."

    ## Why Port 3000?

    The React development server traditionally runs on port 3000. Users expect to access
    web applications at familiar ports:
    - Port 80/443: Production web servers
    - Port 3000: Development React/Node apps
    - Port 8080: Alternative web server port

    ## Running with Port Mapping

    **Command**: `docker run -d -p 3000:3000 --name codesprout-web codesprout/frontend:1.0`

    Breaking it down:
    - `-d`: Run in background (detached mode)
    - `-p 3000:3000`: Map host port 3000 to container port 3000
    - `--name codesprout-web`: Give it a memorable name
    - `codesprout/frontend:1.0`: The image we just built

    Now visit http://localhost:3000 and you'll see the CodeSprout interface!
  MD
  command_to_learn: "docker run -d -p 3000:3000 --name codesprout-web codesprout/frontend:1.0",
  command_variations: [
    "docker run --detach -p 3000:3000 --name codesprout-web codesprout/frontend:1.0",
    "docker run -d --name codesprout-web -p 3000:3000 codesprout/frontend:1.0"
  ],
  practice_hints: [
    "Map port 3000 on host to port 3000 in container",
    "Use -d to run in background",
    "Name it 'codesprout-web' for easy reference",
    "Try: docker run -d -p 3000:3000 --name codesprout-web codesprout/frontend:1.0"
  ],
  scenario_narrative: "Run the CodeSprout frontend container so users can access it at localhost:3000.",
  difficulty_level: "easy",
  estimated_minutes: 3,
  sequence_order: 109,
  category: "networking",
  published: true,
  quiz_question_text: "Why do we map port 3000:3000?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "To access the container's port 3000 from the host's port 3000", correct: true },
    { text: "To run two instances on the same port", correct: false },
    { text: "To create a port range", correct: false },
    { text: "For security purposes only", correct: false }
  ],
  quiz_correct_answer: "To access the container's port 3000 from the host's port 3000",
  quiz_explanation: "Port mapping makes services inside containers accessible from your host machine.",
  learning_objectives: ["Map container ports to host", "Run web applications in containers"],
  prerequisites: ["codesprout-build-frontend"],
  concept_tags: ["port-mapping", "docker-run", "web-servers"]
)

puts "  ✓ Created: #{unit_4_2.title}"

# Lesson 4.3: Add environment variables
unit_4_3 = InteractiveLearningUnit.create!(
  title: "Configuring with Environment Variables",
  slug: "codesprout-frontend-env",
  concept_explanation: <<~MD,
    # Environment Variables for Configuration

    Sarah: "The frontend needs to know where the backend API is. Let's pass that as an environment variable."

    ## Why Environment Variables?

    Environment variables let you configure containers without rebuilding images:
    - **API endpoints**: Where to find the backend
    - **Feature flags**: Enable/disable features
    - **Debug modes**: Control logging levels

    ## Setting Environment Variables

    **Command**: `docker run -d -p 3000:3000 -e API_URL=http://localhost:8080 --name codesprout-web codesprout/frontend:1.0`

    The `-e` flag sets environment variables:
    - `-e API_URL=http://localhost:8080`: Backend API location
    - Multiple `-e` flags for multiple variables
    - Variables are accessible inside the container

    Now the React app knows to send API requests to http://localhost:8080!
  MD
  command_to_learn: "docker run -d -p 3000:3000 -e API_URL=http://localhost:8080 --name codesprout-web codesprout/frontend:1.0",
  command_variations: [
    "docker run -d -p 3000:3000 --env API_URL=http://localhost:8080 --name codesprout-web codesprout/frontend:1.0",
    "docker run -d -e API_URL=http://localhost:8080 -p 3000:3000 --name codesprout-web codesprout/frontend:1.0"
  ],
  practice_hints: [
    "Use -e to set environment variables",
    "Format: -e VARIABLE=value",
    "Set API_URL to http://localhost:8080",
    "Try: docker run -d -p 3000:3000 -e API_URL=http://localhost:8080 --name codesprout-web codesprout/frontend:1.0"
  ],
  scenario_narrative: "Configure the frontend to connect to the backend API using environment variables.",
  difficulty_level: "easy",
  estimated_minutes: 3,
  sequence_order: 110,
  category: "configuration",
  published: true,
  quiz_question_text: "What is the purpose of environment variables in containers?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "To configure containers without rebuilding images", correct: true },
    { text: "To improve container performance", correct: false },
    { text: "To secure the container", correct: false },
    { text: "To set the container name", correct: false }
  ],
  quiz_correct_answer: "To configure containers without rebuilding images",
  quiz_explanation: "Environment variables provide runtime configuration, making containers flexible and reusable across different environments.",
  learning_objectives: ["Use environment variables for configuration", "Configure multi-tier applications"],
  prerequisites: ["codesprout-run-frontend"],
  concept_tags: ["environment-variables", "configuration", "docker-run"]
)

puts "  ✓ Created: #{unit_4_3.title}"

# ========================================
# CLUSTER 2: Adding the Backend API
# Goal: Connect frontend to backend via Docker network
# ========================================

# Lesson 4.4: Build backend API image
unit_4_4 = InteractiveLearningUnit.create!(
  title: "Building the Backend API",
  slug: "codesprout-build-backend",
  concept_explanation: <<~MD,
    # Building the Backend Service

    Sarah: "The frontend looks great, but it's lonely without data! Let's build the backend API."

    ## The Backend API

    The backend is a Node.js Express server that:
    - Provides REST API endpoints (`/api/tasks`, `/api/users`)
    - Handles business logic
    - Connects to the database
    - Runs on port 8080

    ## Building the Backend Image

    **Command**: `docker build -t codesprout/backend:1.0 ./backend`

    This backend Dockerfile:
    1. Uses `node:16-alpine` as base
    2. Copies `package.json` and installs dependencies
    3. Copies application code
    4. Exposes port 8080
    5. Starts the server with `npm start`
  MD
  command_to_learn: "docker build -t codesprout/backend:1.0 ./backend",
  command_variations: [
    "docker build --tag codesprout/backend:1.0 ./backend",
    "docker image build -t codesprout/backend:1.0 ./backend"
  ],
  practice_hints: [
    "Build from the ./backend directory",
    "Tag as codesprout/backend:1.0",
    "Format: docker build -t NAME:TAG PATH",
    "Try: docker build -t codesprout/backend:1.0 ./backend"
  ],
  scenario_narrative: "Build the CodeSprout backend API image.",
  difficulty_level: "easy",
  estimated_minutes: 4,
  sequence_order: 111,
  category: "images",
  published: true,
  quiz_question_text: "Why do we tag both frontend and backend with version '1.0'?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "To track versions and allow rollbacks", correct: true },
    { text: "Because Docker requires version numbers", correct: false },
    { text: "To improve build performance", correct: false },
    { text: "For security scanning", correct: false }
  ],
  quiz_correct_answer: "To track versions and allow rollbacks",
  quiz_explanation: "Version tags help you manage different releases and roll back if needed.",
  learning_objectives: ["Build backend API images", "Understand multi-service architecture"],
  prerequisites: ["codesprout-frontend-env"],
  concept_tags: ["docker-build", "backend-services", "apis"]
)

puts "  ✓ Created: #{unit_4_4.title}"

# Lesson 4.5: Connect frontend to backend
unit_4_5 = InteractiveLearningUnit.create!(
  title: "Connecting Frontend to Backend",
  slug: "codesprout-connect-services",
  concept_explanation: <<~MD,
    # Service-to-Service Communication

    Sarah: "Now we need the frontend and backend to talk to each other. But there's a problem..."

    ## The Problem

    Right now:
    - Frontend: localhost:3000 (on host machine)
    - Backend: localhost:8080 (on host machine)

    But containers are isolated! The frontend container can't reach "localhost:8080"
    because that's the *host* machine, not the backend *container*.

    ## The Solution: Docker Networks

    We need to:
    1. Create a custom Docker network
    2. Connect both containers to it
    3. Use container names as hostnames

    **Command**: `docker run -d -p 8080:8080 --name codesprout-api --network codesprout-net codesprout/backend:1.0`

    Now the frontend can reach the backend at `http://codesprout-api:8080` instead of `localhost:8080`!
  MD
  command_to_learn: "docker run -d -p 8080:8080 --name codesprout-api --network codesprout-net codesprout/backend:1.0",
  command_variations: [
    "docker run -d --name codesprout-api -p 8080:8080 --network codesprout-net codesprout/backend:1.0",
    "docker run --detach -p 8080:8080 --name codesprout-api --network codesprout-net codesprout/backend:1.0"
  ],
  practice_hints: [
    "Connect to the network with --network codesprout-net",
    "Name it 'codesprout-api' so other containers can find it",
    "Expose port 8080 for the API",
    "Try: docker run -d -p 8080:8080 --name codesprout-api --network codesprout-net codesprout/backend:1.0"
  ],
  scenario_narrative: "Run the backend API and connect it to the same network as the frontend.",
  difficulty_level: "medium",
  estimated_minutes: 4,
  sequence_order: 112,
  category: "networking",
  published: true,
  quiz_question_text: "How do containers on the same network find each other?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "By container name as hostname", correct: true },
    { text: "By IP address only", correct: false },
    { text: "Through port mapping", correct: false },
    { text: "They cannot communicate", correct: false }
  ],
  quiz_correct_answer: "By container name as hostname",
  quiz_explanation: "Docker provides automatic DNS resolution, allowing containers on the same network to reach each other by name.",
  learning_objectives: ["Connect services using Docker networks", "Understand container-to-container communication"],
  prerequisites: ["codesprout-build-backend"],
  concept_tags: ["docker-networks", "service-discovery", "multi-container"]
)

puts "  ✓ Created: #{unit_4_5.title}"

# Lesson 4.6: Create custom network
unit_4_6 = InteractiveLearningUnit.create!(
  title: "Creating Custom Docker Networks",
  slug: "codesprout-create-network",
  concept_explanation: <<~MD,
    # Custom Networks for Isolation

    Sarah: "Before we connect services, we need to create a dedicated network for CodeSprout."

    ## Why Custom Networks?

    Default Docker networking has limitations:
    - All containers can potentially see each other
    - No isolation between different applications
    - Limited DNS features

    Custom networks provide:
    - **Isolation**: Only connected containers can communicate
    - **DNS**: Automatic service discovery by container name
    - **Flexibility**: Multiple isolated networks on one host

    ## Creating a Network

    **Command**: `docker network create codesprout-net`

    This creates a bridge network named `codesprout-net`. Now we can connect
    containers to it with `--network codesprout-net`.

    **Check networks**: `docker network ls`
  MD
  command_to_learn: "docker network create codesprout-net",
  command_variations: [
    "docker network create --driver bridge codesprout-net"
  ],
  practice_hints: [
    "Create a network named 'codesprout-net'",
    "Format: docker network create NETWORK_NAME",
    "Try: docker network create codesprout-net"
  ],
  scenario_narrative: "Create a dedicated network for all CodeSprout services to communicate securely.",
  difficulty_level: "easy",
  estimated_minutes: 3,
  sequence_order: 113,
  category: "networking",
  published: true,
  quiz_question_text: "What is the benefit of using custom networks?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "Isolation and automatic DNS between connected containers", correct: true },
    { text: "Faster network speeds", correct: false },
    { text: "Encrypted traffic automatically", correct: false },
    { text: "Required for port mapping", correct: false }
  ],
  quiz_correct_answer: "Isolation and automatic DNS between connected containers",
  quiz_explanation: "Custom networks isolate containers and provide DNS resolution so services can find each other by name.",
  learning_objectives: ["Create Docker networks", "Understand network isolation"],
  prerequisites: ["codesprout-connect-services"],
  concept_tags: ["docker-network", "isolation", "dns"]
)

puts "  ✓ Created: #{unit_4_6.title}"

# ========================================
# CLUSTER 3: Adding the Database
# Goal: Add PostgreSQL with persistent data
# ========================================

# Lesson 4.7: Run PostgreSQL container
unit_4_7 = InteractiveLearningUnit.create!(
  title: "Running the Database",
  slug: "codesprout-run-database",
  concept_explanation: <<~MD,
    # Adding PostgreSQL Database

    Sarah: "Time to add the database! Our backend needs somewhere to store all the tasks."

    ## Database Requirements

    The backend API needs PostgreSQL to:
    - Store user accounts
    - Save tasks and projects
    - Track completion status

    ## Running PostgreSQL

    **Command**: `docker run -d --name codesprout-db --network codesprout-net -e POSTGRES_PASSWORD=secret123 -e POSTGRES_DB=codesprout postgres:15`

    Breaking it down:
    - `--name codesprout-db`: Backend will connect to this hostname
    - `--network codesprout-net`: Same network as frontend/backend
    - `-e POSTGRES_PASSWORD=secret123`: Database password
    - `-e POSTGRES_DB=codesprout`: Create database named "codesprout"
    - `postgres:15`: Official PostgreSQL image, version 15

    No port mapping needed! The database is only accessed by the backend, not the host.
  MD
  command_to_learn: "docker run -d --name codesprout-db --network codesprout-net -e POSTGRES_PASSWORD=secret123 -e POSTGRES_DB=codesprout postgres:15",
  command_variations: [
    "docker run -d --network codesprout-net --name codesprout-db -e POSTGRES_PASSWORD=secret123 -e POSTGRES_DB=codesprout postgres:15",
    "docker run --detach --name codesprout-db --network codesprout-net -e POSTGRES_DB=codesprout -e POSTGRES_PASSWORD=secret123 postgres:15"
  ],
  practice_hints: [
    "Connect to codesprout-net network",
    "Set POSTGRES_PASSWORD and POSTGRES_DB environment variables",
    "Name it 'codesprout-db' for the backend to find",
    "Try: docker run -d --name codesprout-db --network codesprout-net -e POSTGRES_PASSWORD=secret123 -e POSTGRES_DB=codesprout postgres:15"
  ],
  scenario_narrative: "Add a PostgreSQL database to store CodeSprout's data.",
  difficulty_level: "medium",
  estimated_minutes: 4,
  sequence_order: 114,
  category: "data",
  published: true,
  quiz_question_text: "Why don't we need -p for the database container?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "Only the backend needs access, not the host machine", correct: true },
    { text: "PostgreSQL doesn't use ports", correct: false },
    { text: "The network flag handles ports automatically", correct: false },
    { text: "It's a security vulnerability", correct: false }
  ],
  quiz_correct_answer: "Only the backend needs access, not the host machine",
  quiz_explanation: "Port mapping is only needed when you want to access a service from your host. Internal services only need to be on the same network.",
  learning_objectives: ["Run database containers", "Understand internal vs external services"],
  prerequisites: ["codesprout-create-network"],
  concept_tags: ["databases", "postgres", "internal-services"]
)

puts "  ✓ Created: #{unit_4_7.title}"

# Lesson 4.8: Create volume for database
unit_4_8 = InteractiveLearningUnit.create!(
  title: "Persisting Database Data",
  slug: "codesprout-db-volume",
  concept_explanation: <<~MD,
    # Persistent Storage with Volumes

    Sarah: "Houston, we have a problem! If the database container restarts, all data is lost!"

    ## The Container Data Problem

    Containers are ephemeral:
    - Data written inside a container disappears when it's removed
    - Database restarts = data loss
    - This is unacceptable for production!

    ## The Solution: Docker Volumes

    Volumes persist data outside containers:
    - Survive container restarts and removals
    - Can be backed up
    - Shared between containers if needed

    **Command**: `docker run -d --name codesprout-db --network codesprout-net -v codesprout-data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=secret123 -e POSTGRES_DB=codesprout postgres:15`

    The `-v codesprout-data:/var/lib/postgresql/data` means:
    - `codesprout-data`: Named volume (Docker manages storage location)
    - `/var/lib/postgresql/data`: Where PostgreSQL stores its data inside the container

    Now your data survives container restarts!
  MD
  command_to_learn: "docker run -d --name codesprout-db --network codesprout-net -v codesprout-data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=secret123 -e POSTGRES_DB=codesprout postgres:15",
  command_variations: [
    "docker run -d --network codesprout-net --name codesprout-db --volume codesprout-data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=secret123 -e POSTGRES_DB=codesprout postgres:15",
    "docker run -d --name codesprout-db -v codesprout-data:/var/lib/postgresql/data --network codesprout-net -e POSTGRES_DB=codesprout -e POSTGRES_PASSWORD=secret123 postgres:15"
  ],
  practice_hints: [
    "Use -v to mount a volume",
    "Format: -v VOLUME_NAME:CONTAINER_PATH",
    "Mount codesprout-data to /var/lib/postgresql/data",
    "Try: docker run -d --name codesprout-db --network codesprout-net -v codesprout-data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=secret123 -e POSTGRES_DB=codesprout postgres:15"
  ],
  scenario_narrative: "Add persistent storage to the database so data survives container restarts.",
  difficulty_level: "medium",
  estimated_minutes: 3,
  sequence_order: 115,
  category: "volumes",
  published: true,
  quiz_question_text: "What happens to data in a volume when you remove the container?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "The data persists and can be used by a new container", correct: true },
    { text: "The data is deleted", correct: false },
    { text: "The data becomes read-only", correct: false },
    { text: "The volume is automatically deleted", correct: false }
  ],
  quiz_correct_answer: "The data persists and can be used by a new container",
  quiz_explanation: "Volumes persist independently of container lifecycle, making them perfect for databases and important data.",
  learning_objectives: ["Use volumes for persistent data", "Understand container data lifecycle"],
  prerequisites: ["codesprout-run-database"],
  concept_tags: ["volumes", "persistence", "databases"]
)

puts "  ✓ Created: #{unit_4_8.title}"

# Lesson 4.9: Pass database credentials
unit_4_9 = InteractiveLearningUnit.create!(
  title: "Configuring Database Credentials",
  slug: "codesprout-db-credentials",
  concept_explanation: <<~MD,
    # Connecting Backend to Database

    Sarah: "The database is running, but the backend doesn't know how to connect to it yet!"

    ## Database Connection Configuration

    The backend needs to know:
    - **Host**: Where is the database? (`codesprout-db`)
    - **Port**: What port? (`5432` - PostgreSQL default)
    - **Database name**: Which database? (`codesprout`)
    - **Username**: Who to login as? (`postgres` - default)
    - **Password**: What's the password? (`secret123`)

    ## Passing Connection Info

    We'll pass all this via environment variables to the backend:

    **Command**: `docker run -d -p 8080:8080 --name codesprout-api --network codesprout-net -e DB_HOST=codesprout-db -e DB_PORT=5432 -e DB_NAME=codesprout -e DB_USER=postgres -e DB_PASSWORD=secret123 codesprout/backend:1.0`

    Now the backend can connect to PostgreSQL!
  MD
  command_to_learn: "docker run -d -p 8080:8080 --name codesprout-api --network codesprout-net -e DB_HOST=codesprout-db -e DB_PORT=5432 -e DB_NAME=codesprout -e DB_USER=postgres -e DB_PASSWORD=secret123 codesprout/backend:1.0",
  command_variations: [
    "docker run -d --name codesprout-api -p 8080:8080 --network codesprout-net -e DB_HOST=codesprout-db -e DB_PORT=5432 -e DB_NAME=codesprout -e DB_USER=postgres -e DB_PASSWORD=secret123 codesprout/backend:1.0"
  ],
  practice_hints: [
    "Pass 5 environment variables for database connection",
    "DB_HOST should be 'codesprout-db' (container name)",
    "Use multiple -e flags for multiple variables",
    "Try: docker run -d -p 8080:8080 --name codesprout-api --network codesprout-net -e DB_HOST=codesprout-db -e DB_PORT=5432 -e DB_NAME=codesprout -e DB_USER=postgres -e DB_PASSWORD=secret123 codesprout/backend:1.0"
  ],
  scenario_narrative: "Configure the backend with database credentials so it can connect to PostgreSQL.",
  difficulty_level: "medium",
  estimated_minutes: 3,
  sequence_order: 116,
  category: "configuration",
  published: true,
  quiz_question_text: "Why use 'codesprout-db' as DB_HOST instead of 'localhost'?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "Container name provides DNS resolution on the Docker network", correct: true },
    { text: "localhost doesn't work in Docker", correct: false },
    { text: "It's required by PostgreSQL", correct: false },
    { text: "For security reasons", correct: false }
  ],
  quiz_correct_answer: "Container name provides DNS resolution on the Docker network",
  quiz_explanation: "On a Docker network, containers can reach each other by name. 'localhost' would refer to the backend container itself, not the database.",
  learning_objectives: ["Configure multi-tier applications", "Understand service discovery in Docker"],
  prerequisites: ["codesprout-db-volume"],
  concept_tags: ["environment-variables", "service-discovery", "configuration"]
)

puts "  ✓ Created: #{unit_4_9.title}"

# ========================================
# CLUSTER 4: Docker Compose Orchestration
# Goal: Manage entire stack with one command
# ========================================

# Lesson 4.10: Write docker-compose.yml
unit_4_10 = InteractiveLearningUnit.create!(
  title: "Creating docker-compose.yml",
  slug: "codesprout-compose-file",
  concept_explanation: <<~MD,
    # Orchestrating with Docker Compose

    Sarah: "Running three containers with those long commands is tedious! Let's use Docker Compose."

    ## The Problem

    Currently we need to run:
    1. `docker network create...`
    2. `docker run...` (database with volumes and env vars)
    3. `docker run...` (backend with network and 5 env vars)
    4. `docker run...` (frontend with network and env vars)

    That's a lot to remember and type!

    ## The Solution: docker-compose.yml

    Docker Compose lets you define all services in one YAML file:

    ```yaml
    version: '3.8'
    services:
      frontend:
        build: ./frontend
        ports:
          - "3000:3000"
        environment:
          - API_URL=http://backend:8080
      backend:
        build: ./backend
        ports:
          - "8080:8080"
        environment:
          - DB_HOST=database
      database:
        image: postgres:15
        volumes:
          - codesprout-data:/var/lib/postgresql/data
    ```

    **Command**: `docker-compose up -d`

    That's it! One command starts everything.
  MD
  command_to_learn: "docker-compose up -d",
  command_variations: [
    "docker-compose up --detach",
    "docker compose up -d"
  ],
  practice_hints: [
    "Use 'docker-compose up' to start all services",
    "Add -d to run in detached mode",
    "Try: docker-compose up -d"
  ],
  scenario_narrative: "Use Docker Compose to start the entire CodeSprout stack with one command.",
  difficulty_level: "easy",
  estimated_minutes: 5,
  sequence_order: 117,
  category: "orchestration",
  published: true,
  quiz_question_text: "What does 'docker-compose up -d' do?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "Starts all services defined in docker-compose.yml in detached mode", correct: true },
    { text: "Updates all containers to latest versions", correct: false },
    { text: "Uploads containers to a registry", correct: false },
    { text: "Deletes all running containers", correct: false }
  ],
  quiz_correct_answer: "Starts all services defined in docker-compose.yml in detached mode",
  quiz_explanation: "docker-compose up reads the compose file and starts all defined services. The -d flag runs them in the background.",
  learning_objectives: ["Use Docker Compose for multi-container applications", "Define services in docker-compose.yml"],
  prerequisites: ["codesprout-db-credentials"],
  concept_tags: ["docker-compose", "orchestration", "yaml"]
)

puts "  ✓ Created: #{unit_4_10.title}"

# Lesson 4.11: Define service dependencies
unit_4_11 = InteractiveLearningUnit.create!(
  title: "Managing Service Dependencies",
  slug: "codesprout-compose-depends",
  concept_explanation: <<~MD,
    # Service Startup Order

    Sarah: "Sometimes the backend starts before the database is ready. Let's fix that!"

    ## The Dependency Problem

    Services start in parallel, which can cause issues:
    - Backend tries to connect to database before it's ready
    - Frontend loads before backend is available
    - Connection errors during startup

    ## Using `depends_on`

    Docker Compose provides `depends_on` to control startup order:

    ```yaml
    services:
      backend:
        depends_on:
          - database
      frontend:
        depends_on:
          - backend
    ```

    This ensures:
    1. Database starts first
    2. Backend waits for database
    3. Frontend waits for backend

    **Note**: `depends_on` only waits for the container to start, not for the service to be fully ready.
    For production, you'd add health checks!
  MD
  command_to_learn: "docker-compose up -d",
  command_variations: [
    "docker compose up -d",
    "docker-compose up --detach"
  ],
  practice_hints: [
    "Add depends_on to your docker-compose.yml",
    "Start services with docker-compose up -d",
    "Try: docker-compose up -d"
  ],
  scenario_narrative: "Configure service dependencies so containers start in the correct order.",
  difficulty_level: "medium",
  estimated_minutes: 4,
  sequence_order: 118,
  category: "orchestration",
  published: true,
  quiz_question_text: "What does 'depends_on' do in docker-compose.yml?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "Controls the startup order of services", correct: true },
    { text: "Shares data between services", correct: false },
    { text: "Creates network connections", correct: false },
    { text: "Sets environment variables", correct: false }
  ],
  quiz_correct_answer: "Controls the startup order of services",
  quiz_explanation: "depends_on ensures dependent services start after their dependencies, preventing startup race conditions.",
  learning_objectives: ["Manage service dependencies", "Control startup order"],
  prerequisites: ["codesprout-compose-file"],
  concept_tags: ["docker-compose", "dependencies", "startup-order"]
)

puts "  ✓ Created: #{unit_4_11.title}"

# Lesson 4.12: Manage the stack
unit_4_12 = InteractiveLearningUnit.create!(
  title: "Managing the Compose Stack",
  slug: "codesprout-compose-manage",
  concept_explanation: <<~MD,
    # Docker Compose Commands

    Sarah: "Now that everything is running, let's learn how to manage the stack!"

    ## Essential Compose Commands

    **Start services**: `docker-compose up -d`
    - Starts all services in detached mode

    **Stop services**: `docker-compose down`
    - Stops and removes all containers
    - Networks are removed
    - Volumes are preserved (unless you add `-v`)

    **View logs**: `docker-compose logs -f`
    - See logs from all services
    - `-f` follows logs in real-time
    - Add service name for specific logs: `docker-compose logs -f backend`

    **Check status**: `docker-compose ps`
    - Shows status of all services

    **Restart services**: `docker-compose restart`
    - Restart all or specific services

    **Command**: `docker-compose down`

    This cleanly stops everything when you're done working on CodeSprout.
  MD
  command_to_learn: "docker-compose down",
  command_variations: [
    "docker compose down"
  ],
  practice_hints: [
    "Use 'docker-compose down' to stop all services",
    "This removes containers and networks but preserves volumes",
    "Try: docker-compose down"
  ],
  scenario_narrative: "Stop the CodeSprout stack when you're done working.",
  difficulty_level: "easy",
  estimated_minutes: 3,
  sequence_order: 119,
  category: "orchestration",
  published: true,
  quiz_question_text: "What does 'docker-compose down' remove?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "Containers and networks, but preserves volumes", correct: true },
    { text: "Everything including volumes", correct: false },
    { text: "Only stops containers without removing them", correct: false },
    { text: "Only networks", correct: false }
  ],
  quiz_correct_answer: "Containers and networks, but preserves volumes",
  quiz_explanation: "docker-compose down cleans up containers and networks but keeps volumes safe by default. Use -v to also remove volumes.",
  learning_objectives: ["Manage Docker Compose stacks", "Start and stop multi-container applications"],
  prerequisites: ["codesprout-compose-depends"],
  concept_tags: ["docker-compose", "lifecycle-management"]
)

puts "  ✓ Created: #{unit_4_12.title}"

# ========================================
# CLUSTER 5: Managing the Application
# Goal: Update, debug, and scale services
# ========================================

# Lesson 4.13: View logs from services
unit_4_13 = InteractiveLearningUnit.create!(
  title: "Debugging with Logs",
  slug: "codesprout-compose-logs",
  concept_explanation: <<~MD,
    # Viewing Application Logs

    Sarah: "Something's not working? Let's check the logs to debug!"

    ## Why Logs Matter

    Logs help you:
    - Debug errors and exceptions
    - Monitor application behavior
    - Track API requests
    - Diagnose performance issues

    ## Viewing Compose Logs

    **All services**: `docker-compose logs -f`
    - Shows logs from all containers
    - `-f` follows logs in real-time (like `tail -f`)
    - Color-coded by service

    **Specific service**: `docker-compose logs -f backend`
    - Only shows backend logs
    - Useful for isolating issues

    **Last N lines**: `docker-compose logs --tail=100 backend`
    - Shows last 100 lines only

    **Command**: `docker-compose logs -f backend`

    This shows real-time logs from the backend service to help debug API issues.
  MD
  command_to_learn: "docker-compose logs -f backend",
  command_variations: [
    "docker compose logs -f backend",
    "docker-compose logs --follow backend"
  ],
  practice_hints: [
    "Use 'docker-compose logs' to view logs",
    "Add -f to follow logs in real-time",
    "Specify 'backend' to see only backend logs",
    "Try: docker-compose logs -f backend"
  ],
  scenario_narrative: "Check the backend logs to debug API errors.",
  difficulty_level: "easy",
  estimated_minutes: 3,
  sequence_order: 120,
  category: "debugging",
  published: true,
  quiz_question_text: "What does the -f flag do in 'docker-compose logs -f'?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "Follows logs in real-time like tail -f", correct: true },
    { text: "Filters logs by level", correct: false },
    { text: "Forces log output", correct: false },
    { text: "Formats logs as JSON", correct: false }
  ],
  quiz_correct_answer: "Follows logs in real-time like tail -f",
  quiz_explanation: "The -f flag streams logs continuously, updating as new log entries are written.",
  learning_objectives: ["Debug applications using logs", "Monitor service behavior"],
  prerequisites: ["codesprout-compose-manage"],
  concept_tags: ["logging", "debugging", "docker-compose"]
)

puts "  ✓ Created: #{unit_4_13.title}"

# Lesson 4.14: Update and restart services
unit_4_14 = InteractiveLearningUnit.create!(
  title: "Updating Services",
  slug: "codesprout-compose-update",
  concept_explanation: <<~MD,
    # Updating Running Services

    Sarah: "You just fixed a bug in the backend code. Let's deploy the update!"

    ## Updating Services

    When you change code, you need to:
    1. Rebuild the image (if code changed)
    2. Recreate the container with the new image

    **Command**: `docker-compose up -d --build backend`

    Breaking it down:
    - `up`: Start services
    - `-d`: Detached mode
    - `--build`: Rebuild images before starting
    - `backend`: Only update this service

    This rebuilds the backend image and recreates the container while keeping
    the database and frontend running!

    ## Alternative: Restart Without Rebuilding

    If you only changed environment variables or want to restart:

    **Command**: `docker-compose restart backend`

    This just restarts the container without rebuilding.
  MD
  command_to_learn: "docker-compose up -d --build backend",
  command_variations: [
    "docker compose up -d --build backend",
    "docker-compose up --detach --build backend"
  ],
  practice_hints: [
    "Use --build to rebuild images before starting",
    "Specify 'backend' to only update that service",
    "Other services keep running",
    "Try: docker-compose up -d --build backend"
  ],
  scenario_narrative: "Deploy an updated version of the backend after fixing a bug.",
  difficulty_level: "medium",
  estimated_minutes: 4,
  sequence_order: 121,
  category: "orchestration",
  published: true,
  quiz_question_text: "What does '--build' do in 'docker-compose up --build'?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "Rebuilds images before starting containers", correct: true },
    { text: "Only builds images without starting", correct: false },
    { text: "Builds the project source code", correct: false },
    { text: "Downloads images from a registry", correct: false }
  ],
  quiz_correct_answer: "Rebuilds images before starting containers",
  quiz_explanation: "The --build flag forces Docker Compose to rebuild images from Dockerfiles before starting containers, ensuring code changes are included.",
  learning_objectives: ["Update running services", "Deploy code changes"],
  prerequisites: ["codesprout-compose-logs"],
  concept_tags: ["docker-compose", "deployment", "updates"]
)

puts "  ✓ Created: #{unit_4_14.title}"

# Lesson 4.15: Scale services
unit_4_15 = InteractiveLearningUnit.create!(
  title: "Scaling Services",
  slug: "codesprout-compose-scale",
  concept_explanation: <<~MD,
    # Scaling for More Traffic

    Sarah: "CodeSprout is getting popular! Let's run 3 backend instances to handle the load."

    ## Why Scale?

    Single container limitations:
    - Can only use one CPU core fully
    - Limited throughput
    - No redundancy if it crashes

    Multiple instances provide:
    - **Higher throughput**: Handle more requests
    - **Load balancing**: Distribute work across instances
    - **Redundancy**: One crash doesn't take down everything

    ## Scaling with Compose

    **Command**: `docker-compose up -d --scale backend=3`

    This runs 3 backend containers:
    - `codesprout_backend_1`
    - `codesprout_backend_2`
    - `codesprout_backend_3`

    Docker Compose load balances requests across all 3!

    **Check status**: `docker-compose ps`

    You'll see all 3 backend instances running.

    **Note**: You can't map the same host port for multiple containers, so remove
    explicit port mapping for scaled services (use a load balancer instead).
  MD
  command_to_learn: "docker-compose up -d --scale backend=3",
  command_variations: [
    "docker compose up -d --scale backend=3",
    "docker-compose up --detach --scale backend=3"
  ],
  practice_hints: [
    "Use --scale SERVICE=COUNT to run multiple instances",
    "Run 3 backend instances with --scale backend=3",
    "Try: docker-compose up -d --scale backend=3"
  ],
  scenario_narrative: "Scale the backend to 3 instances to handle increased traffic.",
  difficulty_level: "medium",
  estimated_minutes: 3,
  sequence_order: 122,
  category: "scaling",
  published: true,
  quiz_question_text: "Why might you want to scale a service to multiple instances?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "To handle more traffic and provide redundancy", correct: true },
    { text: "To use more disk space", correct: false },
    { text: "To reduce memory usage", correct: false },
    { text: "Required by Docker Compose", correct: false }
  ],
  quiz_correct_answer: "To handle more traffic and provide redundancy",
  quiz_explanation: "Scaling services horizontally increases capacity and resilience, allowing your application to handle more load and survive instance failures.",
  learning_objectives: ["Scale services horizontally", "Understand load distribution"],
  prerequisites: ["codesprout-compose-update"],
  concept_tags: ["docker-compose", "scaling", "performance"]
)

puts "  ✓ Created: #{unit_4_15.title}"

puts "🎉 Successfully created #{InteractiveLearningUnit.where("sequence_order >= 108 AND sequence_order <= 122").count} CodeSprout deployment units!"
