# AUTO-GENERATED from docker_compose_units.rb
puts "Creating Microlessons for Docker Compose..."

module_var = CourseModule.find_by(slug: 'docker-compose')

# === MICROLESSON 1: Docker Compose Up: Start Multi-Container Applications ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Compose Up: Start Multi-Container Applications',
  content: <<~MARKDOWN,
# Docker Compose Up: Start Multi-Container Applications 🚀

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

## Syntax/Command

```bash
docker-compose up -d
```

## Example

```bash
docker-compose up
```

## Key Points

- Start all services: docker-compose up -d

- With rebuild: docker-compose up --build -d

- Specific services: docker-compose up -d web
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['docker-compose', 'orchestration', 'multi-container', 'deployment', 'services'],
  prerequisite_ids: []
)

# Exercise 1.1: Terminal
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker-compose up -d',
    description: 'Start complete application stack with all services running in background',
    difficulty: 'medium',
    hints: ['Start all services: docker-compose up -d', 'With rebuild: docker-compose up --build -d', 'Specific services: docker-compose up -d web']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker-compose up -d',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 1.2: MCQ
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What does docker-compose up create automatically?',
    options: ['Networks, volumes, and containers for all services', 'Only containers', 'Only networks', 'Nothing - you must create them manually'],
    correct_answer: 0,
    explanation: 'docker-compose up automatically creates networks, volumes, and containers defined in docker-compose.yml, connecting everything together.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 2: Docker Compose Down: Stop and Remove Stack ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Compose Down: Stop and Remove Stack',
  content: <<~MARKDOWN,
# Docker Compose Down: Stop and Remove Stack 🚀

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

## Syntax/Command

```bash
docker-compose down
```

## Example

```bash
docker-compose down -v
```

## Key Points

- Standard cleanup: docker-compose down

- Remove volumes too: docker-compose down -v

- Remove images: docker-compose down --rmi all
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['docker-compose', 'cleanup', 'teardown', 'lifecycle', 'management'],
  prerequisite_ids: []
)

# Exercise 2.1: Terminal
Exercise.create!(
  micro_lesson: lesson_2,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker-compose down',
    description: 'Stop and remove all services while keeping persistent data volumes intact',
    difficulty: 'medium',
    hints: ['Standard cleanup: docker-compose down', 'Remove volumes too: docker-compose down -v', 'Remove images: docker-compose down --rmi all']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_2,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker-compose down',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 2.2: MCQ
Exercise.create!(
  micro_lesson: lesson_2,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the difference between docker-compose down and docker-compose stop?',
    options: ['down removes containers and networks, stop only stops containers', 'They are identical commands', 'stop is faster than down', 'down only works in production'],
    correct_answer: 0,
    explanation: 'docker-compose down performs complete cleanup removing containers and networks, while stop only stops containers leaving them and networks intact.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 3: Docker Compose Build: Build or Rebuild Service Images ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Compose Build: Build or Rebuild Service Images',
  content: <<~MARKDOWN,
# Docker Compose Build: Build or Rebuild Service Images 🚀

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

## Syntax/Command

```bash
docker-compose build
```

## Example

```bash
docker-compose build --no-cache
```

## Key Points

- Build all: docker-compose build

- Force rebuild: docker-compose build --no-cache

- Specific service: docker-compose build api
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 3.1: Terminal
Exercise.create!(
  micro_lesson: lesson_3,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker-compose build',
    description: 'Rebuild application services from scratch for production deployment',
    difficulty: 'medium',
    hints: ['Build all: docker-compose build', 'Force rebuild: docker-compose build --no-cache', 'Specific service: docker-compose build api']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_3,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker-compose build',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 3.2: MCQ
Exercise.create!(
  micro_lesson: lesson_3,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'When should you use --no-cache flag?',
    options: ['When you need a clean build without layer caching', 'Always, it makes builds faster', 'Only in production', 'When images are corrupted'],
    correct_answer: 0,
    explanation: 'Review the concept explanation above.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 4: Docker Compose Logs: View Service Output ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Compose Logs: View Service Output',
  content: <<~MARKDOWN,
# Docker Compose Logs: View Service Output 🚀

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

## Syntax/Command

```bash
docker-compose logs -f
```

## Example

```bash
docker-compose logs
```

## Key Points

- All logs: docker-compose logs

- Follow: docker-compose logs -f

- Specific service: docker-compose logs -f api
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['docker-compose', 'logs', 'debugging', 'monitoring', 'troubleshooting'],
  prerequisite_ids: []
)

# Exercise 4.1: Terminal
Exercise.create!(
  micro_lesson: lesson_4,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker-compose logs -f',
    description: 'Monitor real-time logs from multiple services to identify error patterns',
    difficulty: 'easy',
    hints: ['All logs: docker-compose logs', 'Follow: docker-compose logs -f', 'Specific service: docker-compose logs -f api']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_4,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker-compose logs -f',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 4.2: MCQ
Exercise.create!(
  micro_lesson: lesson_4,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What does the -f flag do in docker-compose logs?',
    options: ['Follows logs in real-time like tail -f', 'Filters logs by pattern', 'Shows full timestamps', 'Forces log rotation'],
    correct_answer: 0,
    explanation: 'The -f flag continuously streams new log output from services, similar to tail -f for regular files.',
    difficulty: 'easy'
  }
)

puts "✓ Created 4 microlessons for Docker Compose"
