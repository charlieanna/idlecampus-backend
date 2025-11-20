# AUTO-GENERATED from docker_basics_units.rb
puts "Creating Microlessons for Docker Basics..."

module_var = CourseModule.find_by(slug: 'docker-basics')

# === MICROLESSON 1: Docker PS: Listing Running Containers ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker PS: Listing Running Containers',
  content: <<~MARKDOWN,
# Docker PS: Listing Running Containers 🚀

# Understanding docker ps: Your Container Dashboard

    ## What is docker ps?
    The `docker ps` command is your primary tool for viewing running containers. Think of it as the "process list" for Docker containers - similar to how `ps` shows running processes in Linux, `docker ps` shows your active containers.

    ## Why It's Important
    - **Monitoring**: See which containers are currently running
    - **Troubleshooting**: Check container status, ports, and names
    - **Resource Management**: Identify containers consuming resources
    - **Quick Reference**: Get container IDs for other Docker commands

    ## Common Use Cases

    ### 1. Check Running Containers
    ```bash
    docker ps
    ```
    Shows only currently running containers with essential information.

    ### 2. See All Containers (Including Stopped)
    ```bash
    docker ps -a
    ```
    The `-a` flag shows all containers, regardless of their state.

    ### 3. Filter by Status
    ```bash
    docker ps -a --filter "status=exited"
    ```
    Find all stopped containers for cleanup.

    ### 4. Show Only Container IDs
    ```bash
    docker ps -q
    ```
    Useful for scripting and piping to other commands.

    ## Output Columns Explained

    ```
    CONTAINER ID   IMAGE         COMMAND                  CREATED        STATUS        PORTS                  NAMES
    abc123def456   nginx:alpine  "nginx -g 'daemon of…"   2 hours ago    Up 2 hours    0.0.0.0:8080->80/tcp   web-server
    ```

    - **CONTAINER ID**: Unique identifier (short form)
    - **IMAGE**: Docker image used to create the container
    - **COMMAND**: Command running inside the container
    - **CREATED**: When the container was created
    - **STATUS**: Current state (Up/Exited/Paused)
    - **PORTS**: Port mappings between host and container
    - **NAMES**: Human-friendly name (auto-generated or custom)

    ## Visual Example

    ```
    Your Terminal
         │
         ├─ docker ps
         │
         └─> Shows Running Containers
              ├─ web-server (nginx)
              ├─ database (mysql)
              └─ cache (redis)
    ```

    ## Common Mistakes to Avoid

    1. **Forgetting -a**: Running `docker ps` only shows running containers. Use `-a` to see stopped ones.
    2. **Confusing Names and IDs**: You can use either the container name or ID in commands.
    3. **Not Using Filters**: For large environments, use filters to narrow results.
    4. **Ignoring Status**: Always check the STATUS column - "Up" doesn't mean "healthy".

    ## Pro Tips

    - Use `--format` for custom output: `docker ps --format "{{.Names}}: {{.Status}}"`
    - Combine with `grep`: `docker ps | grep nginx`
    - Use `-n 5` to show only the last 5 containers
    - Set aliases: `alias dps='docker ps --format "table {{.Names}}\\t{{.Status}}\\t{{.Ports}}"'`

    ## When to Use docker ps

    - Before starting a new container (check for port conflicts)
    - After deploying services (verify they're running)
    - During troubleshooting (check container status)
    - Before cleanup operations (identify containers to remove)

## Syntax/Command

```bash
docker ps
```

## Example

```bash
docker ps -a
```

## Key Points

- Start with basic "docker ps" to see running containers

- Add -a flag to see all containers including stopped ones

- Use -q to get just container IDs (useful for scripting)
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['containers', 'cli', 'monitoring', 'docker-ps', 'inspection'],
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
    command: 'docker ps',
    description: 'List all running Docker containers on the system and identify their key information (names, images, ports)',
    difficulty: 'easy',
    hints: ['Start with basic "docker ps" to see running containers', 'Add -a flag to see all containers including stopped ones', 'Use -q to get just container IDs (useful for scripting)']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker ps',
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
    question: 'What flag should you add to "docker ps" to see stopped containers?',
    options: ['-a or --all', '-s or --stopped', '-e or --exited', '--show-stopped'],
    correct_answer: 0,
    explanation: 'The -a (or --all) flag shows all containers, both running and stopped. Without it, only running containers are displayed.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 2: Docker Run: Creating and Starting Containers ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Run: Creating and Starting Containers',
  content: <<~MARKDOWN,
# Docker Run: Creating and Starting Containers 🚀

# Mastering docker run: From Image to Running Container

    ## What is docker run?
    `docker run` is the most fundamental Docker command - it creates a new container from an image and starts it immediately. This single command combines container creation and startup in one operation.

    ## Why It's Critical
    - **Instant Deployment**: Launch applications in seconds
    - **Isolation**: Each container runs in its own isolated environment
    - **Reproducibility**: Same command works across all systems
    - **Flexibility**: Customize containers with numerous options

    ## Basic Syntax
    ```bash
    docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
    ```

    ## Common Use Cases

    ### 1. Run a Simple Container
    ```bash
    docker run nginx
    ```
    Downloads nginx image (if needed) and starts a container in foreground mode.

    ### 2. Run in Detached Mode
    ```bash
    docker run -d nginx
    ```
    The `-d` flag runs the container in the background, freeing your terminal.

    ### 3. Assign a Name
    ```bash
    docker run --name my-nginx nginx
    ```
    Give your container a memorable name instead of random auto-generated one.

    ### 4. Map Ports
    ```bash
    docker run -p 8080:80 nginx
    ```
    Maps container port 80 to host port 8080. Access via http://localhost:8080

    ### 5. Complete Example
    ```bash
    docker run -d --name web-server -p 8080:80 nginx:alpine
    ```
    Runs nginx Alpine in background, names it "web-server", accessible on port 8080.

    ## Essential Options

    | Option | Description | Example |
    |--------|-------------|---------|
    | `-d` | Detached mode (background) | `docker run -d nginx` |
    | `--name` | Assign container name | `docker run --name web nginx` |
    | `-p` | Publish port (host:container) | `docker run -p 80:80 nginx` |
    | `-e` | Set environment variable | `docker run -e NODE_ENV=production node` |
    | `-v` | Mount volume | `docker run -v /data:/app/data mysql` |
    | `--rm` | Remove container when stopped | `docker run --rm alpine echo "hi"` |
    | `-it` | Interactive terminal | `docker run -it ubuntu bash` |

    ## How docker run Works Internally

    ```
    1. Check if image exists locally
       ↓ (if not found)
    2. Pull image from Docker Hub
       ↓
    3. Create container from image
       ↓
    4. Allocate filesystem layer
       ↓
    5. Set up networking
       ↓
    6. Start the container process
       ↓
    7. Execute the default command (or your override)
    ```

    ## Common Patterns

    ### Interactive Debugging
    ```bash
    docker run -it --rm ubuntu bash
    ```
    Opens interactive shell, automatically removes container on exit.

    ### One-off Tasks
    ```bash
    docker run --rm node:14 node --version
    ```
    Runs command and cleans up immediately.

    ### Environment Configuration
    ```bash
    docker run -d -e MYSQL_ROOT_PASSWORD=secret -p 3306:3306 mysql
    ```
    Sets up MySQL with environment variables and port mapping.

    ## Common Mistakes to Avoid

    1. **Forgetting -d**: Container runs in foreground, blocking terminal
    2. **Port Already in Use**: Check with `docker ps` before mapping ports
    3. **Not Using --rm for Testing**: Leaves many stopped containers
    4. **Wrong Port Order**: Format is `-p HOST:CONTAINER`, not the reverse
    5. **Missing Environment Variables**: Some images require specific env vars to work

    ## Interactive vs Detached Mode

    **Foreground (Default)**
    - Attaches to container output
    - Blocks terminal
    - Good for: debugging, one-off commands
    - Exit with: Ctrl+C (stops container)

    **Background (-d)**
    - Returns container ID immediately
    - Frees terminal
    - Good for: services, long-running processes
    - View logs with: `docker logs <container>`

    ## Pro Tips

    1. **Always name production containers**: Makes management easier
    2. **Use specific image tags**: `nginx:1.21` instead of `nginx:latest`
    3. **Set restart policies**: `--restart unless-stopped` for services
    4. **Limit resources**: `--memory="512m" --cpus="1.0"`
    5. **Use .env files**: `--env-file .env` for multiple variables

## Syntax/Command

```bash
docker run -d -p 8080:80 --name my-nginx nginx:alpine
```

## Example

```bash
docker run nginx
```

## Key Points

- Basic run: docker run nginx (foreground mode)

- Add -d for background: docker run -d nginx

- Name it: docker run -d --name my-web nginx
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['containers', 'docker-run', 'deployment', 'port-mapping', 'detached-mode'],
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
    command: 'docker run -d -p 8080:80 --name my-nginx nginx:alpine',
    description: 'Deploy an nginx:alpine container in detached mode, name it "production-web", and map port 8080 to container port 80',
    difficulty: 'easy',
    hints: ['Basic run: docker run nginx (foreground mode)', 'Add -d for background: docker run -d nginx', 'Name it: docker run -d --name my-web nginx']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_2,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker run -d -p 8080:80 --name my-nginx nginx:alpine',
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
    question: 'In "docker run -p 8080:80 nginx", which port is on the host machine?',
    options: ['8080', '80', 'Both are host ports', 'Neither, both are container ports'],
    correct_answer: 0,
    explanation: 'Port mapping format is -p HOST:CONTAINER. So 8080 is the host port, and 80 is the container port. Traffic to localhost:8080 routes to container port 80.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 3: Docker Stop: Gracefully Stopping Containers ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Stop: Gracefully Stopping Containers',
  content: <<~MARKDOWN,
# Docker Stop: Gracefully Stopping Containers 🚀

# Understanding docker stop: Graceful Container Shutdown

    ## What is docker stop?
    `docker stop` gracefully stops one or more running containers by sending signals to the main process. This is the proper way to stop containers, allowing them to clean up resources before shutting down.

    ## Why Graceful Shutdown Matters
    - **Data Integrity**: Allows databases to flush buffers to disk
    - **Connection Cleanup**: Lets web servers close client connections properly
    - **State Preservation**: Enables applications to save state before exit
    - **Resource Release**: Properly releases locks, file handles, and network ports

    ## Basic Syntax
    ```bash
    docker stop [OPTIONS] CONTAINER [CONTAINER...]
    ```

    ## How It Works: The Signal Dance

    ```
    docker stop container_name
         │
         ├─ Sends SIGTERM signal
         │  (polite request to shut down)
         │
         ├─ Waits up to 10 seconds
         │  (default grace period)
         │
         └─ If still running: sends SIGKILL
            (forceful termination)
    ```

    ## Common Use Cases

    ### 1. Stop a Single Container
    ```bash
    docker stop web-server
    ```
    Gracefully stops the container named "web-server".

    ### 2. Stop Multiple Containers
    ```bash
    docker stop web-server database cache
    ```
    Stops all three containers in sequence.

    ### 3. Custom Timeout
    ```bash
    docker stop -t 30 database
    ```
    Waits 30 seconds before force-killing (useful for databases).

    ### 4. Stop All Running Containers
    ```bash
    docker stop $(docker ps -q)
    ```
    Stops every running container on the system.

    ## SIGTERM vs SIGKILL

    **SIGTERM (Signal 15)**
    - Polite request to terminate
    - Application can catch and handle it
    - Allows cleanup operations
    - Default first signal sent

    **SIGKILL (Signal 9)**
    - Immediate, forceful termination
    - Cannot be caught or ignored
    - No cleanup possible
    - Used as last resort

    ## Timing Considerations

    ```
    Start: docker stop database
         │
         ├─ 0s: SIGTERM sent → app starts shutdown
         ├─ 2s: closing connections...
         ├─ 5s: flushing data to disk...
         ├─ 8s: cleanup complete, exits gracefully ✓
         │
         └─ If took > 10s: SIGKILL sent ✗
    ```

    ## Stop vs Kill

    | Command | Signal | Graceful | Use Case |
    |---------|--------|----------|----------|
    | `docker stop` | SIGTERM → SIGKILL | Yes | Normal operations |
    | `docker kill` | SIGKILL immediately | No | Hung containers |

    ## Common Patterns

    ### Stop and Remove
    ```bash
    docker stop my-app && docker rm my-app
    ```
    Stops container then removes it.

    ### Stop with Specific Timeout
    ```bash
    docker stop -t 60 production-db
    ```
    Gives database 60 seconds to shut down cleanly.

    ### Emergency Stop All
    ```bash
    docker stop $(docker ps -q) -t 1
    ```
    Quickly stops all containers (1 second timeout).

    ## Common Mistakes to Avoid

    1. **Using docker kill first**: Always try `docker stop` before `docker kill`
    2. **Too short timeout**: Some apps need more than 10 seconds to shut down
    3. **Not checking status**: Verify container actually stopped with `docker ps`
    4. **Force-stopping databases**: Always use longer timeout for data services
    5. **Stopping without checking dependencies**: Stop dependent services first

    ## Container States After Stop

    ```
    Running → Stopping → Stopped (Exited)
                │
                ├─ Container remains on disk
                ├─ Can be restarted with docker start
                └─ Remove with docker rm
    ```

    ## Pro Tips

    1. **Check logs before stopping**: `docker logs container_name`
    2. **Use health checks**: Ensure graceful shutdown is working
    3. **Set appropriate timeouts**: Match to application needs
    4. **Script cleanup**: Create stop scripts for dependent services
    5. **Monitor shutdown**: Watch logs during stop to catch issues

    ## Restart vs Stop/Start

    ```bash
    # These are different:
    docker stop web && docker start web  # Keeps same container
    docker restart web                   # Equivalent to above
    docker stop web && docker run web    # Creates NEW container
    ```

    ## When to Use docker stop

    - Deploying new version (stop old, start new)
    - Maintenance windows (controlled shutdown)
    - Resource cleanup (free ports/memory)
    - Before system reboot (clean shutdown)
    - Troubleshooting (restart services)

## Syntax/Command

```bash
docker stop my-container
```

## Example

```bash
docker stop container_name
```

## Key Points

- Basic stop: docker stop <container-name>

- Stop by ID: docker stop abc123

- Custom timeout: docker stop -t 30 database
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
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
    command: 'docker stop my-container',
    description: 'Stop the api-server container gracefully with a 30-second timeout to allow proper connection cleanup',
    difficulty: 'easy',
    hints: ['Basic stop: docker stop <container-name>', 'Stop by ID: docker stop abc123', 'Custom timeout: docker stop -t 30 database']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_3,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker stop my-container',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# === MICROLESSON 4: Docker RM: Removing Containers ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker RM: Removing Containers',
  content: <<~MARKDOWN,
# Docker RM: Removing Containers 🚀

# Mastering docker rm: Container Cleanup and Removal

    ## What is docker rm?
    `docker rm` permanently deletes one or more stopped containers from your system. This command frees up disk space and keeps your Docker environment clean and organized.

    ## Why Container Removal Matters
    - **Disk Space**: Each container consumes disk space even when stopped
    - **Organization**: Prevents clutter from old experiments and tests
    - **Name Conflicts**: Frees up container names for reuse
    - **System Health**: Reduces metadata overhead on Docker daemon

    ## Basic Syntax
    ```bash
    docker rm [OPTIONS] CONTAINER [CONTAINER...]
    ```

    ## Important Constraint
    **You CANNOT remove a running container without -f flag**
    ```bash
    docker rm running-container
    # Error: You cannot remove a running container
    
    docker stop running-container
    docker rm running-container
    # Success!
    ```

    ## Common Use Cases

    ### 1. Remove a Stopped Container
    ```bash
    docker rm old-container
    ```
    Removes a single stopped container.

    ### 2. Force Remove Running Container
    ```bash
    docker rm -f web-server
    ```
    Stops AND removes the container (not recommended for production).

    ### 3. Remove Multiple Containers
    ```bash
    docker rm container1 container2 container3
    ```
    Removes multiple containers in one command.

    ### 4. Remove All Stopped Containers
    ```bash
    docker rm $(docker ps -a -q -f status=exited)
    ```
    Cleans up all exited containers.

    ## Container Lifecycle: Remove in Context

    ```
    Created → Running → Stopped → Removed
              ↓          ↓         ↓
           (start)   (stop)     (rm)
                                 ↓
                           Gone forever!
                      (image still exists)
    ```

    ## Remove Options

    | Option | Description | Example |
    |--------|-------------|---------|
    | `-f` | Force remove (stops if running) | `docker rm -f web` |
    | `-v` | Remove associated volumes | `docker rm -v database` |
    | `-l` | Remove specified link | `docker rm -l my-link` |

    ## Volumes and Removal

    **Default Behavior (volumes persist)**
    ```bash
    docker rm database
    # Container removed, but volumes remain!
    ```

    **Remove Container AND Volumes**
    ```bash
    docker rm -v database
    # Container AND its anonymous volumes removed
    ```

    ## Common Cleanup Patterns

    ### 1. Stop and Remove
    ```bash
    docker stop my-app && docker rm my-app
    ```
    Proper two-step removal process.

    ### 2. Force Remove (shortcut)
    ```bash
    docker rm -f my-app
    ```
    Combines stop and remove (use with caution).

    ### 3. Clean All Stopped Containers
    ```bash
    docker container prune
    ```
    Modern way to remove all stopped containers.

    ### 4. Remove Containers Matching Pattern
    ```bash
    docker rm $(docker ps -a -q -f name=test-)
    ```
    Removes all containers with names starting with "test-".

    ## Common Mistakes to Avoid

    1. **Trying to remove running containers**: Always stop first (or use -f)
    2. **Forgetting about volumes**: Use -v if you want to remove volumes too
    3. **Removing production containers**: Double-check before removing!
    4. **Not using --rm flag on docker run**: For temporary containers
    5. **Manual cleanup when automated works**: Use `docker run --rm` for tests

    ## What Gets Removed?

    **Removed:**
    - Container filesystem layer
    - Container metadata
    - Network connections (unless connected to user-defined networks)
    - Anonymous volumes (if -v flag used)

    **NOT Removed:**
    - The underlying image
    - Named volumes
    - User-defined networks
    - Container logs (in some configurations)

    ## Preventing Accidental Removal

    ```bash
    # Use descriptive names
    docker run --name production-api-server nginx
    
    # Add labels for organization
    docker run --label env=production nginx
    
    # Use docker run --rm for temporary work
    docker run --rm alpine echo "test"
    ```

    ## Bulk Cleanup Strategies

    ### Remove All Stopped Containers
    ```bash
    docker container prune
    # or
    docker rm $(docker ps -a -q -f status=exited)
    ```

    ### Remove Containers Older Than 24h
    ```bash
    docker container prune --filter "until=24h"
    ```

    ### Remove Everything (nuclear option)
    ```bash
    docker rm -f $(docker ps -a -q)
    # WARNING: Removes ALL containers!
    ```

    ## Automation and Best Practices

    ### 1. Self-Cleaning Test Containers
    ```bash
    docker run --rm -it alpine sh
    # Automatically removed on exit
    ```

    ### 2. Cron Job for Cleanup
    ```bash
    # Daily cleanup of exited containers
    0 2 * * * docker container prune -f
    ```

    ### 3. Pre-Deployment Cleanup
    ```bash
    #!/bin/bash
    docker stop old-version
    docker rm old-version
    docker run -d --name new-version app:latest
    ```

    ## When to Use docker rm

    - After testing/development work
    - Before redeploying with same name
    - During regular maintenance
    - When freeing disk space
    - After failed deployments

    ## Recovery After Accidental Removal

    **Important**: Once removed, a container cannot be recovered!

    However, you can:
    1. Recreate from the same image
    2. Restore from volume backups (if volumes still exist)
    3. Check Docker logs (if log driver persists logs)

    ## Pro Tips

    1. **Use --rm for temporary work**: `docker run --rm alpine echo "test"`
    2. **Label your containers**: `--label purpose=testing`
    3. **Regular cleanup**: Schedule `docker container prune`
    4. **Check before removing**: `docker inspect` to verify it's safe
    5. **Backup important data**: Always backup before removing data containers

## Syntax/Command

```bash
docker rm my-container
```

## Example

```bash
docker rm container_name
```

## Key Points

- Remove stopped container: docker rm <name>

- Force remove running: docker rm -f <name>

- Remove with volumes: docker rm -v <name>
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['containers', 'lifecycle', 'docker-rm', 'cleanup', 'maintenance'],
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
    command: 'docker rm my-container',
    description: 'Remove all stopped containers that start with "test-" including their volumes',
    difficulty: 'easy',
    hints: ['Remove stopped container: docker rm <name>', 'Force remove running: docker rm -f <name>', 'Remove with volumes: docker rm -v <name>']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_4,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker rm my-container',
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
    question: 'Can you remove a running container with just "docker rm container_name"?',
    options: ['No, you must stop it first or use -f flag', 'Yes, it will stop automatically', 'Yes, but only if you use sudo', 'No, running containers cannot be removed'],
    correct_answer: 0,
    explanation: 'Docker will not remove a running container with just docker rm. You must either stop it first with docker stop, or use the -f flag to force removal (which stops and removes in one step).',
    difficulty: 'easy'
  }
)

puts "✓ Created 4 microlessons for Docker Basics"
