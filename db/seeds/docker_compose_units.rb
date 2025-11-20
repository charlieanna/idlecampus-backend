# Docker Compose Interactive Learning Units
# Converting 8 compose orchestration commands into CodeSprout-style learning experiences

puts "🐳 Creating Docker Compose Interactive Learning Units..."

# Find or create Docker Fundamentals course
course = Course.find_by(slug: 'docker-fundamentals')
unless course
  course = Course.create!(
    slug: 'docker-fundamentals',
    title: 'Docker Fundamentals',
    description: 'Master Docker from basics to advanced topics',
    difficulty_level: 'beginner',
    estimated_hours: 20,
    published: true,
    sequence_order: 1
  )
end

# Find or create Docker Compose module
compose_module = course.course_modules.find_or_create_by!(slug: 'docker-compose') do |m|
  m.title = "Docker Compose"
  m.description = "Multi-container application orchestration with Docker Compose"
  m.sequence_order = 4
  m.estimated_minutes = 200
  m.published = true
  m.learning_objectives = [
    'Orchestrate multi-container applications',
    'Define services with docker-compose.yml',
    'Manage application lifecycle with compose commands',
    'Scale services dynamically',
    'Execute commands in compose environments',
    'Monitor and debug compose stacks'
  ]
end

# Unit 49: docker-compose up
unit_49 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-compose-up-command') do |u|
  u.title = 'Docker Compose Up: Start Multi-Container Applications'
  u.concept_explanation = <<~MD
    # Mastering docker-compose up: Orchestrating Multi-Service Applications

    ## What is docker-compose up?
    `docker-compose up` reads your `docker-compose.yml` file and creates, starts, and connects all defined services in one command. It's the primary way to launch complete application stacks with all their dependencies, networks, and volumes configured automatically.

    ## Why Compose Matters
    - **Simplicity**: Start complex stacks with one command
    - **Reproducibility**: Same configuration works everywhere
    - **Development Speed**: No manual container management
    - **Service Dependencies**: Automatic service ordering and networking
    - **Configuration as Code**: docker-compose.yml is version-controlled

    ## Basic Syntax
    ```bash
    docker-compose up [OPTIONS] [SERVICE...]
    ```

    ## Common Use Cases

    ### 1. Start All Services
    ```bash
    docker-compose up
    ```
    Starts all services in foreground, showing logs from all containers.

    ### 2. Start in Background (Detached)
    ```bash
    docker-compose up -d
    ```
    Most common for development - starts services in background.

    ### 3. Rebuild Images Before Starting
    ```bash
    docker-compose up --build
    ```
    Forces rebuild of images defined with `build:` in compose file.

    ### 4. Start Specific Services
    ```bash
    docker-compose up web database
    ```
    Only starts web and database services (plus their dependencies).

    ## How docker-compose up Works

    ```
    1. Read docker-compose.yml
       ↓
    2. Create custom network (if not exists)
       ↓
    3. Create volumes (if not exists)
       ↓
    4. Pull/build images as needed
       ↓
    5. Create containers with configurations
       ↓
    6. Start services in dependency order
       ↓
    7. Attach to logs (unless -d used)
    ```

    ## Sample docker-compose.yml

    ```yaml
    version: '3.8'
    services:
      web:
        image: nginx:alpine
        ports:
          - "8080:80"
        depends_on:
          - api
      api:
        build: ./api
        environment:
          - DB_HOST=database
        depends_on:
          - database
      database:
        image: postgres:13
        environment:
          - POSTGRES_PASSWORD=secret
        volumes:
          - db-data:/var/lib/postgresql/data
    volumes:
      db-data:
    ```

    ## Service Dependencies

    Compose respects `depends_on` to start services in correct order:
    ```yaml
    web:
      depends_on:
        - api
        - cache
    ```
    Starts cache and api before web (but doesn't wait for "ready").

    ## Common Options

    | Option | Description | Example |
    |--------|-------------|---------|
    | `-d` | Detached mode | `docker-compose up -d` |
    | `--build` | Force rebuild images | `docker-compose up --build` |
    | `--force-recreate` | Recreate containers | `docker-compose up --force-recreate` |
    | `--no-deps` | Don't start dependencies | `docker-compose up --no-deps web` |
    | `--scale` | Scale services | `docker-compose up --scale api=3` |

    ## Networking Magic

    Compose creates a default network where services can reach each other by name:
    ```yaml
    api:
      environment:
        - DB_HOST=database  # Uses service name as hostname!
    ```

    ## Watching Logs

    ### Foreground Mode (Default)
    ```bash
    docker-compose up
    ```
    Shows interleaved logs from all services. Press Ctrl+C to stop.

    ### Detached Mode
    ```bash
    docker-compose up -d
    docker-compose logs -f  # Follow logs separately
    ```

    ## Incremental Changes

    Compose detects changes and only recreates affected containers:
    ```bash
    # Edit docker-compose.yml
    docker-compose up -d  # Only affected services restart!
    ```

    ## Common Mistakes to Avoid

    1. **Forgetting -d in scripts**: Blocks terminal without detached mode
    2. **Not rebuilding after code changes**: Use `--build` flag
    3. **Wrong working directory**: Must be in directory with docker-compose.yml
    4. **Port conflicts**: Ensure ports in compose file aren't already used
    5. **Missing env files**: Create `.env` if compose references environment variables

    ## Development Workflow

    ### First Time Setup
    ```bash
    docker-compose up --build  # Build and start
    ```

    ### Daily Development
    ```bash
    docker-compose up -d       # Start in background
    docker-compose logs -f web # Watch specific service logs
    ```

    ### After Code Changes
    ```bash
    docker-compose up -d --build web  # Rebuild and restart only web
    ```

    ## Pro Tips

    1. **Use detached mode for CI/CD**: `docker-compose up -d` doesn't block pipelines
    2. **Override compose files**: Use `-f` to stack configurations
    3. **Health checks matter**: Add healthchecks in compose file for readiness
    4. **Named volumes for data**: Don't lose database data between restarts
    5. **Environment files**: Use `.env` for sensitive configuration
    6. **Service names as hostnames**: Inter-service communication is seamless

    ## When to Use docker-compose up

    - Starting complete application stacks for development
    - Running integration tests with all dependencies
    - Demo environments with multiple services
    - Local replication of production architectures
    - CI/CD pipeline test environments
  MD

  u.command_to_learn = 'docker-compose up -d'
  u.command_variations = [
    'docker-compose up',
    'docker-compose up --build',
    'docker-compose up -d web api',
    'docker-compose up --scale api=3 -d'
  ]

  u.practice_hints = [
    'Start all services: docker-compose up -d',
    'With rebuild: docker-compose up --build -d',
    'Specific services: docker-compose up -d web',
    'Watch logs: docker-compose up (without -d)'
  ]

  u.scenario_narrative = <<~MD
    **First Production Deploy**
    
    Tech lead assigns you: "We have a new microservices stack - web frontend, API backend, and PostgreSQL database. Everything is defined in docker-compose.yml. Start the entire stack in detached mode so we can test the deployment."
  MD

  u.problem_statement = 'Start complete application stack with all services running in background'

  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 49
  u.category = 'docker-compose'
  u.published = true

  u.quiz_question_text = 'What does docker-compose up create automatically?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Networks, volumes, and containers for all services', correct: true },
    { text: 'Only containers', correct: false },
    { text: 'Only networks', correct: false },
    { text: 'Nothing - you must create them manually', correct: false }
  ]
  u.quiz_correct_answer = 'Networks, volumes, and containers for all services'
  u.quiz_explanation = 'docker-compose up automatically creates networks, volumes, and containers defined in docker-compose.yml, connecting everything together.'

  u.concept_tags = ['docker-compose', 'orchestration', 'multi-container', 'deployment', 'services']
end

unit_49.update!(
  code_examples: [
    {
      title: 'Start all services in foreground',
      code: 'docker-compose up',
      explanation: 'Starts all services and displays interleaved logs - great for debugging'
    },
    {
      title: 'Start in detached mode',
      code: 'docker-compose up -d',
      explanation: 'Most common - starts services in background, frees terminal'
    },
    {
      title: 'Rebuild and start',
      code: 'docker-compose up --build -d',
      explanation: 'Forces image rebuild before starting - use after code changes'
    },
    {
      title: 'Start with scaling',
      code: 'docker-compose up -d --scale api=3',
      explanation: 'Starts 3 instances of api service for load balancing'
    }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: compose_module,
  interactive_learning_unit: unit_49
) do |miu|
  miu.sequence_order = 1
  miu.required = true
end

# Unit 50: docker-compose down
unit_50 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-compose-down-command') do |u|
  u.title = 'Docker Compose Down: Stop and Remove Stack'
  u.concept_explanation = <<~MD
    # Mastering docker-compose down: Clean Stack Teardown

    ## What is docker-compose down?
    `docker-compose down` stops all services and removes containers, networks, and optionally volumes created by `docker-compose up`. It's the clean way to tear down your entire application stack, returning to a clean slate.

    ## Why Down Matters
    - **Complete Cleanup**: Removes containers AND networks
    - **Resource Management**: Frees ports, memory, and disk
    - **Fresh Start**: Ensures clean state for next deployment
    - **CI/CD Essential**: Cleanup step in automated pipelines
    - **Safer than docker stop**: Handles dependencies and networks properly

    ## Basic Syntax
    ```bash
    docker-compose down [OPTIONS]
    ```

    ## Common Use Cases

    ### 1. Standard Teardown
    ```bash
    docker-compose down
    ```
    Stops and removes containers and networks (keeps volumes and images).

    ### 2. Remove Volumes Too
    ```bash
    docker-compose down -v
    ```
    **DANGER**: Also removes named volumes, deleting all data!

    ### 3. Remove Images
    ```bash
    docker-compose down --rmi all
    ```
    Removes all images used by services (thorough cleanup).

    ### 4. Remove Orphans
    ```bash
    docker-compose down --remove-orphans
    ```
    Removes containers for services not in current compose file.

    ## How docker-compose down Works

    ```
    1. Stop all containers gracefully (SIGTERM)
       ↓
    2. Wait for graceful shutdown (10s timeout)
       ↓
    3. Force kill if needed (SIGKILL)
       ↓
    4. Remove all containers
       ↓
    5. Remove custom networks
       ↓
    6. Remove volumes (if -v flag used)
       ↓
    7. Remove images (if --rmi flag used)
    ```

    ## What Gets Removed vs Kept

    ### Always Removed
    - Containers created by up
    - Networks created by up
    - Internal networks

    ### Kept by Default
    - Volumes (data persistence)
    - Images (avoid re-downloading)
    - External networks

    ### Removed with Flags
    - Volumes: use `-v` or `--volumes`
    - Images: use `--rmi all` or `--rmi local`

    ## Common Options

    | Option | Description | Use Case |
    |--------|-------------|----------|
    | `-v, --volumes` | Remove named volumes | Clean slate, delete data |
    | `--rmi all` | Remove all images | Complete cleanup |
    | `--rmi local` | Remove images without tags | Cleanup build artifacts |
    | `--remove-orphans` | Remove unlisted containers | After compose file changes |
    | `-t, --timeout` | Shutdown timeout seconds | Graceful shutdown control |

    ## Volume Preservation Example

    ```bash
    # First run
    docker-compose up -d
    # Database writes data to volume

    # Teardown
    docker-compose down
    # Volume still exists with data!

    # Next run
    docker-compose up -d
    # Database finds existing data - no loss!
    ```

    ## Dangerous Operations

    ### Delete All Data (Volumes)
    ```bash
    docker-compose down -v
    ```
    ⚠️ **WARNING**: Deletes database data, uploaded files, etc.!

    ### Complete Cleanup
    ```bash
    docker-compose down -v --rmi all --remove-orphans
    ```
    ⚠️ **WARNING**: Nuclear option - removes everything!

    ## vs docker-compose stop

    ### docker-compose stop
    - Stops containers
    - **Keeps** containers
    - **Keeps** networks
    - Fast restart with `docker-compose start`

    ### docker-compose down
    - Stops containers
    - **Removes** containers
    - **Removes** networks
    - Must use `docker-compose up` to restart

    ## Common Mistakes

    1. **Using down -v in production**: Accidentally deletes all data
    2. **Forgetting --remove-orphans**: Old containers linger after config changes
    3. **Not specifying timeout**: Long-running tasks get killed abruptly
    4. **Wrong directory**: Must be in same directory as docker-compose.yml

    ## Best Practices

    ### Development Workflow
    ```bash
    # End of day
    docker-compose down  # Clean shutdown, keep data

    # Fresh start (no data)
    docker-compose down -v  # Remove data for testing
    ```

    ### CI/CD Cleanup
    ```bash
    # After tests
    docker-compose down -v --remove-orphans  # Complete cleanup
    ```

    ### Production Deployment
    ```bash
    # NEVER use -v in production!
    docker-compose down  # Keeps volumes with data
    ```

    ## Pro Tips

    1. **Preserve data**: Never use `-v` in production
    2. **Use in scripts**: Add `|| true` to ignore errors if nothing running
    3. **Increase timeout**: Use `-t 30` for services needing graceful shutdown
    4. **Check before down -v**: Verify you want to delete all data
    5. **Remove orphans regularly**: Clean up after compose file changes
    6. **Combine with up**: `docker-compose down && docker-compose up -d` for fresh restart

    ## When to Use docker-compose down

    - End of development session
    - Before major configuration changes
    - CI/CD pipeline cleanup steps
    - When you need to free ports
    - Switching between different projects
    - Complete environment reset
  MD

  u.command_to_learn = 'docker-compose down'
  u.command_variations = [
    'docker-compose down -v',
    'docker-compose down --rmi all',
    'docker-compose down --remove-orphans',
    'docker-compose down -v --rmi all'
  ]

  u.practice_hints = [
    'Standard cleanup: docker-compose down',
    'Remove volumes too: docker-compose down -v',
    'Remove images: docker-compose down --rmi all',
    'After config changes: docker-compose down --remove-orphans'
  ]

  u.scenario_narrative = 'End of sprint cleanup: Tear down the entire development stack but preserve database volumes for next sprint'
  u.problem_statement = 'Stop and remove all services while keeping persistent data volumes intact'

  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 50
  u.category = 'docker-compose'
  u.published = true

  u.quiz_question_text = 'What is the difference between docker-compose down and docker-compose stop?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'down removes containers and networks, stop only stops containers', correct: true },
    { text: 'They are identical commands', correct: false },
    { text: 'stop is faster than down', correct: false },
    { text: 'down only works in production', correct: false }
  ]
  u.quiz_correct_answer = 'down removes containers and networks, stop only stops containers'
  u.quiz_explanation = 'docker-compose down performs complete cleanup removing containers and networks, while stop only stops containers leaving them and networks intact.'

  u.concept_tags = ['docker-compose', 'cleanup', 'teardown', 'lifecycle', 'management']
end

unit_50.update!(
  code_examples: [
    {
      title: 'Standard teardown',
      code: 'docker-compose down',
      explanation: 'Stops and removes containers and networks, keeps volumes and images'
    },
    {
      title: 'Remove data volumes',
      code: 'docker-compose down -v',
      explanation: 'Complete cleanup including volumes - DELETES ALL DATA'
    },
    {
      title: 'Remove everything',
      code: 'docker-compose down -v --rmi all --remove-orphans',
      explanation: 'Nuclear option - removes containers, networks, volumes, images, and orphans'
    }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: compose_module,
  interactive_learning_unit: unit_50
) do |miu|
  miu.sequence_order = 2
  miu.required = true
end

# Unit 51: docker-compose build
unit_51 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-compose-build-command') do |u|
  u.title = 'Docker Compose Build: Build or Rebuild Service Images'
  u.concept_explanation = <<~MD
    # Mastering docker-compose build: Building Service Images

    ## What is docker-compose build?
    `docker-compose build` builds or rebuilds images for services that have a `build:` configuration in docker-compose.yml. Essential for services using custom Dockerfiles rather than pre-built images from registries.

    ## Why Building with Compose Matters
    - **Custom Services**: Build your application images
    - **Consistency**: Same build process across team
    - **Build Arguments**: Pass variables during build
    - **Parallel Builds**: Build multiple services simultaneously
    - **Cache Control**: Force fresh builds when needed

    ## Basic Syntax
    ```bash
    docker-compose build [OPTIONS] [SERVICE...]
    ```

    ## Common Use Cases

    ### 1. Build All Services
    ```bash
    docker-compose build
    ```
    Builds all services with `build:` configuration.

    ### 2. Force Rebuild (No Cache)
    ```bash
    docker-compose build --no-cache
    ```
    Rebuilds from scratch ignoring Docker layer cache.

    ### 3. Build Specific Service
    ```bash
    docker-compose build api
    ```
    Builds only the api service.

    ### 4. Parallel Builds
    ```bash
    docker-compose build --parallel
    ```
    Builds multiple services simultaneously for speed.

    ## Sample docker-compose.yml with Build

    ```yaml
    version: '3.8'
    services:
      web:
        build:
          context: ./frontend
          dockerfile: Dockerfile
          args:
            NODE_ENV: production
        ports:
          - "3000:3000"
      
      api:
        build:
          context: ./backend
          target: production
        environment:
          - DB_HOST=database
      
      database:
        image: postgres:13  # Not built, pulled from registry
    ```

    ## Build Context Explained

    ```yaml
    web:
      build:
        context: ./frontend    # Directory with source code
        dockerfile: Dockerfile  # Optional, defaults to Dockerfile
    ```

    The context is sent to Docker daemon - use .dockerignore to exclude files!

    ## Build Arguments

    Pass variables to Dockerfile during build:

    ```yaml
    services:
      api:
        build:
          context: ./api
          args:
            VERSION: "1.0.0"
            NODE_ENV: production
    ```

    In Dockerfile:
    ```dockerfile
    ARG VERSION
    ARG NODE_ENV
    RUN echo "Building version ${VERSION}"
    ```

    ## Multi-Stage Builds

    Target specific build stage:

    ```yaml
    api:
      build:
        context: ./api
        target: production  # Stops at 'production' stage
    ```

    ## Common Options

    | Option | Description | Example |
    |--------|-------------|---------|
    | `--no-cache` | Build without using cache | `docker-compose build --no-cache` |
    | `--pull` | Always pull newer base images | `docker-compose build --pull` |
    | `--parallel` | Build in parallel | `docker-compose build --parallel` |
    | `--build-arg` | Set build arguments | `docker-compose build --build-arg VERSION=2.0` |
    | `--progress` | Set progress output type | `docker-compose build --progress plain` |

    ## Build vs Up --build

    ### docker-compose build
    - Only builds images
    - Doesn't start containers
    - Use for CI/CD pipelines

    ### docker-compose up --build
    - Builds images first
    - Then starts containers
    - Convenience for development

    ## When Images Get Built

    ### Automatic Build
    ```bash
    docker-compose up --build  # Builds then starts
    ```

    ### Manual Build
    ```bash
    docker-compose build       # Build only
    docker-compose up -d       # Start separately
    ```

    ## Pro Tips

    1. **Use .dockerignore**: Exclude node_modules, .git, etc.
    2. **Parallel builds in CI**: Use `--parallel` for speed
    3. **Pull base images**: Use `--pull` to get latest base images
    4. **Build arguments for config**: Pass environment-specific values
    5. **Name your builds**: Tag images in compose file
    6. **Cache strategically**: Use `--no-cache` only when needed
  MD

  u.command_to_learn = 'docker-compose build'
  u.command_variations = [
    'docker-compose build --no-cache',
    'docker-compose build --parallel',
    'docker-compose build api web'
  ]

  u.practice_hints = [
    'Build all: docker-compose build',
    'Force rebuild: docker-compose build --no-cache',
    'Specific service: docker-compose build api',
    'Fast builds: docker-compose build --parallel'
  ]

  u.scenario_narrative = 'After major code changes: Rebuild all application services without cache to ensure clean builds'
  u.problem_statement = 'Rebuild application services from scratch for production deployment'

  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 51
  u.category = 'docker-compose'
  u.published = true

  u.quiz_question_text = 'When should you use --no-cache flag?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'When you need a clean build without layer caching', correct: true },
    { text: 'Always, it makes builds faster', correct: false },
    { text: 'Only in production', correct: false },
    { text: 'When images are corrupted', correct: false }
  ]
  u.quiz_correct_answer = 'When you need a clean build without layer caching'
  u.quiz_explanation = '--no-cache forces Docker to rebuild every layer from scratch, useful when cache might contain stale artifacts or after major dependency changes.'

  u.concept_tags = ['docker-compose', 'build', 'images', 'dockerfile', 'compilation']
end

unit_51.update!(
  code_examples: [
    {
      title: 'Build all services with build config',
      code: 'docker-compose build',
      explanation: 'Builds all services that have build: section in compose file'
    },
    {
      title: 'Force clean rebuild',
      code: 'docker-compose build --no-cache --pull',
      explanation: 'Rebuilds from scratch and pulls latest base images'
    },
    {
      title: 'Fast parallel builds',
      code: 'docker-compose build --parallel',
      explanation: 'Builds multiple services simultaneously - faster on multi-core systems'
    }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: compose_module,
  interactive_learning_unit: unit_51
) do |miu|
  miu.sequence_order = 3
  miu.required = true
end

# Unit 52: docker-compose logs
unit_52 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-compose-logs-command') do |u|
  u.title = 'Docker Compose Logs: View Service Output'
  u.concept_explanation = <<~MD
    # Mastering docker-compose logs: Monitoring Service Output

    ## What is docker-compose logs?
    `docker-compose logs` displays output from all services or specific ones, with timestamps and service names. Essential for debugging multi-service applications where logs from different containers need correlation.

    ## Why Compose Logs Matter
    - **Unified View**: See all service logs in one place
    - **Service Identification**: Color-coded by service name
    - **Follow Mode**: Real-time log streaming
    - **Time Correlation**: Timestamps for debugging
    - **Filtering**: View specific services only

    ## Common Use Cases

    ### 1. View All Logs
    ```bash
    docker-compose logs
    ```
    Shows logs from all services with service name prefix.

    ### 2. Follow Logs in Real-Time
    ```bash
    docker-compose logs -f
    ```
    Continuously streams new log output (like tail -f).

    ### 3. Specific Service Logs
    ```bash
    docker-compose logs -f api
    ```
    Shows only api service logs in real-time.

    ### 4. Last N Lines
    ```bash
    docker-compose logs --tail=100
    ```
    Shows last 100 lines from each service.

    ## Common Options

    | Option | Description | Example |
    |--------|-------------|---------|
    | `-f` | Follow log output | `docker-compose logs -f` |
    | `--tail=N` | Show last N lines | `docker-compose logs --tail=50` |
    | `-t` | Show timestamps | `docker-compose logs -t` |
    | `--no-color` | No color output | `docker-compose logs --no-color` |

    ## Pro Tips

    1. **Follow specific services**: `docker-compose logs -f api database`
    2. **Timestamps for debugging**: Use `-t` flag
    3. **Limit output**: Use `--tail` to avoid overwhelming output
    4. **Grep logs**: Pipe to grep for filtering
    5. **Multiple terminals**: Open separate terminals for different services
  MD

  u.command_to_learn = 'docker-compose logs -f'
  u.command_variations = [
    'docker-compose logs',
    'docker-compose logs --tail=100',
    'docker-compose logs -f api',
    'docker-compose logs -t -f'
  ]

  u.practice_hints = [
    'All logs: docker-compose logs',
    'Follow: docker-compose logs -f',
    'Specific service: docker-compose logs -f api',
    'Last 100 lines: docker-compose logs --tail=100'
  ]

  u.scenario_narrative = 'Production debugging: Follow logs from web and api services to debug intermittent connection errors'
  u.problem_statement = 'Monitor real-time logs from multiple services to identify error patterns'

  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 52
  u.category = 'docker-compose'
  u.published = true

  u.quiz_question_text = 'What does the -f flag do in docker-compose logs?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Follows logs in real-time like tail -f', correct: true },
    { text: 'Filters logs by pattern', correct: false },
    { text: 'Shows full timestamps', correct: false },
    { text: 'Forces log rotation', correct: false }
  ]
  u.quiz_correct_answer = 'Follows logs in real-time like tail -f'
  u.quiz_explanation = 'The -f flag continuously streams new log output from services, similar to tail -f for regular files.'

  u.concept_tags = ['docker-compose', 'logs', 'debugging', 'monitoring', 'troubleshooting']
end

unit_52.update!(
  code_examples: [
    {
      title: 'View all service logs',
      code: 'docker-compose logs',
      explanation: 'Shows historical logs from all services'
    },
    {
      title: 'Follow logs in real-time',
      code: 'docker-compose logs -f',
      explanation: 'Streams new output from all services continuously'
    },
    {
      title: 'Specific service with timestamps',
      code: 'docker-compose logs -f -t api',
      explanation: 'Follows api service logs with timestamps for debugging'
    }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: compose_module,
  interactive_learning_unit: unit_52
) do |miu|
  miu.sequence_order = 4
  miu.required = true
end

# Unit 53: docker-compose ps
unit_53 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-compose-ps-command') do |u|
  u.title = 'Docker Compose PS: List Service Containers'
  u.concept_explanation = 'List containers for services defined in docker-compose.yml, showing status, ports, and commands. Quick overview of stack health.'
  u.command_to_learn = 'docker-compose ps'
  u.command_variations = [
    'docker-compose ps -a',
    'docker-compose ps web api'
  ]
  u.practice_hints = [
    'List running: docker-compose ps',
    'Include stopped: docker-compose ps -a',
    'Specific services: docker-compose ps web'
  ]
  u.scenario_narrative = 'Health check: Verify all services in the stack are running correctly'
  u.problem_statement = 'List all service containers and verify their running status'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 53
  u.category = 'docker-compose'
  u.published = true
  u.quiz_question_text = 'What information does docker-compose ps show?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Container names, status, ports, and commands', correct: true },
    { text: 'Only container IDs', correct: false },
    { text: 'Full container logs', correct: false },
    { text: 'Image sizes only', correct: false }
  ]
  u.quiz_correct_answer = 'Container names, status, ports, and commands'
  u.quiz_explanation = 'docker-compose ps provides overview including container state, port mappings, and running commands.'
  u.concept_tags = ['docker-compose', 'listing', 'status', 'monitoring', 'containers']
end

unit_53.update!(
  code_examples: [
    { title: 'List running services', code: 'docker-compose ps', explanation: 'Shows status of all services in compose file' },
    { title: 'Include stopped containers', code: 'docker-compose ps -a', explanation: 'Lists all containers including stopped ones' },
    { title: 'Check specific services', code: 'docker-compose ps web api', explanation: 'Shows status of only web and api services' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: compose_module,
  interactive_learning_unit: unit_53
) do |miu|
  miu.sequence_order = 5
  miu.required = true
end

# Unit 54: docker-compose restart
unit_54 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-compose-restart-command') do |u|
  u.title = 'Docker Compose Restart: Restart Services'
  u.concept_explanation = 'Restart one or more services without rebuilding or recreating containers. Useful for applying configuration changes or recovering from errors.'
  u.command_to_learn = 'docker-compose restart'
  u.command_variations = [
    'docker-compose restart api',
    'docker-compose restart -t 30 database'
  ]
  u.practice_hints = [
    'Restart all: docker-compose restart',
    'Specific service: docker-compose restart api',
    'Custom timeout: docker-compose restart -t 30 service'
  ]
  u.scenario_narrative = 'Service recovery: Restart the API service after configuration file update'
  u.problem_statement = 'Restart specific service to apply new configuration without full teardown'
  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 54
  u.category = 'docker-compose'
  u.published = true
  u.quiz_question_text = 'Does docker-compose restart rebuild images?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'No, it only stops and starts existing containers', correct: true },
    { text: 'Yes, it rebuilds images first', correct: false },
    { text: 'Only if --build flag is used', correct: false },
    { text: 'Only for services with build: config', correct: false }
  ]
  u.quiz_correct_answer = 'No, it only stops and starts existing containers'
  u.quiz_explanation = 'docker-compose restart is equivalent to stop + start, it does not rebuild images or recreate containers.'
  u.concept_tags = ['docker-compose', 'restart', 'lifecycle', 'recovery', 'maintenance']
end

unit_54.update!(
  code_examples: [
    { title: 'Restart all services', code: 'docker-compose restart', explanation: 'Stops and starts all services in compose file' },
    { title: 'Restart specific service', code: 'docker-compose restart api', explanation: 'Restarts only api service quickly' },
    { title: 'Restart with timeout', code: 'docker-compose restart -t 60 database', explanation: 'Gives database 60 seconds for graceful shutdown' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: compose_module,
  interactive_learning_unit: unit_54
) do |miu|
  miu.sequence_order = 6
  miu.required = true
end

# Unit 55: docker-compose scale
unit_55 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-compose-scale-command') do |u|
  u.title = 'Docker Compose Scale: Scale Service Instances'
  u.concept_explanation = 'Scale services to run multiple container instances for load distribution. Note: deprecated in favor of --scale flag in up command, but still useful.'
  u.command_to_learn = 'docker-compose up -d --scale api=3'
  u.command_variations = [
    'docker-compose up -d --scale web=2 --scale api=4',
    'docker-compose scale api=3'
  ]
  u.practice_hints = [
    'Modern syntax: docker-compose up -d --scale api=3',
    'Multiple services: docker-compose up -d --scale web=2 --scale api=4',
    'Scale down: docker-compose up -d --scale api=1'
  ]
  u.scenario_narrative = 'Load handling: Scale API service to 3 instances to handle increased traffic during product launch'
  u.problem_statement = 'Scale API service to multiple instances for high availability'
  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 55
  u.category = 'docker-compose'
  u.published = true
  u.quiz_question_text = 'What happens when you scale a service to 3 instances?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Three containers run the same service with load distribution', correct: true },
    { text: 'The service becomes 3x faster', correct: false },
    { text: 'Data is split across 3 containers', correct: false },
    { text: 'Only one container runs at a time', correct: false }
  ]
  u.quiz_correct_answer = 'Three containers run the same service with load distribution'
  u.quiz_explanation = 'Scaling creates multiple container instances of the same service, useful for load balancing and high availability.'
  u.concept_tags = ['docker-compose', 'scaling', 'load-balancing', 'high-availability', 'performance']
end

unit_55.update!(
  code_examples: [
    { title: 'Scale service to 3 instances', code: 'docker-compose up -d --scale api=3', explanation: 'Runs 3 copies of api service for load distribution' },
    { title: 'Scale multiple services', code: 'docker-compose up -d --scale web=2 --scale api=4', explanation: 'Scales both web and api services simultaneously' },
    { title: 'Scale down to single instance', code: 'docker-compose up -d --scale api=1', explanation: 'Reduces api service back to single container' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: compose_module,
  interactive_learning_unit: unit_55
) do |miu|
  miu.sequence_order = 7
  miu.required = true
end

# Unit 56: docker-compose exec
unit_56 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-compose-exec-command') do |u|
  u.title = 'Docker Compose Exec: Execute Commands in Services'
  u.concept_explanation = 'Execute commands in running service containers using service name instead of container ID. Essential for debugging and maintenance tasks.'
  u.command_to_learn = 'docker-compose exec api bash'
  u.command_variations = [
    'docker-compose exec database psql -U postgres',
    'docker-compose exec -T api npm test',
    'docker-compose exec web sh'
  ]
  u.practice_hints = [
    'Interactive shell: docker-compose exec api bash',
    'Run command: docker-compose exec api npm test',
    'Non-interactive: docker-compose exec -T api command',
    'As specific user: docker-compose exec -u root api apt-get update'
  ]
  u.scenario_narrative = 'Database maintenance: Connect to database service and run SQL migrations directly'
  u.problem_statement = 'Execute commands inside running service containers for debugging and maintenance'
  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 56
  u.category = 'docker-compose'
  u.published = true
  u.quiz_question_text = 'What advantage does docker-compose exec have over docker exec?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Uses service names instead of container IDs', correct: true },
    { text: 'Runs faster than docker exec', correct: false },
    { text: 'Can execute on stopped containers', correct: false },
    { text: 'Automatically restarts services', correct: false }
  ]
  u.quiz_correct_answer = 'Uses service names instead of container IDs'
  u.quiz_explanation = 'docker-compose exec uses friendly service names from compose file instead of cryptic container IDs, making commands more readable and maintainable.'
  u.concept_tags = ['docker-compose', 'exec', 'debugging', 'interactive', 'maintenance']
end

unit_56.update!(
  code_examples: [
    { title: 'Open bash shell in service', code: 'docker-compose exec api bash', explanation: 'Opens interactive bash shell in api service container' },
    { title: 'Run database command', code: 'docker-compose exec database psql -U postgres -c "SELECT * FROM users"', explanation: 'Executes SQL query in database service' },
    { title: 'Non-interactive command', code: 'docker-compose exec -T api npm test', explanation: 'Runs tests without TTY allocation - useful in CI/CD' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: compose_module,
  interactive_learning_unit: unit_56
) do |miu|
  miu.sequence_order = 8
  miu.required = true
end

puts "✓ Created 8 Docker Compose interactive learning units"
puts "  - Unit 49: docker-compose up"
puts "  - Unit 50: docker-compose down"
puts "  - Unit 51: docker-compose build"
puts "  - Unit 52: docker-compose logs"
puts "  - Unit 53: docker-compose ps"
puts "  - Unit 54: docker-compose restart"
puts "  - Unit 55: docker-compose scale"
puts "  - Unit 56: docker-compose exec"
puts ""
puts "All units include:"
puts "  ✓ Comprehensive concept explanations (first 4 detailed, remaining 4 concise)"
puts "  ✓ Command variations and examples"
puts "  ✓ Progressive practice hints"
puts "  ✓ Scenario narratives"
puts "  ✓ Problem statements"
puts "  ✓ MCQ quizzes with explanations"
puts "  ✓ 2-4 code examples with explanations"
puts "  ✓ Concept tags for remediation"
puts "  ✓ Associated with docker-compose module (sequence_order: 4)"
puts "  ✓ Sequence order: 49-56 (continuing from images)"
puts "  ✓ Difficulty: intermediate to advanced"
puts "  ✓ Estimated time: 15-25 minutes each"