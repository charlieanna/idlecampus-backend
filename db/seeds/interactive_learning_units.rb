# Interactive Learning Units Seed Data
puts "🎓 Seeding Interactive Learning Units..."

# Clear existing data
ModuleInteractiveUnit.destroy_all
LearningUnitProgress.destroy_all
InteractiveLearningUnit.destroy_all

puts "✅ Cleared existing interactive learning data"

# ========================================
# DOCKER BASICS - Interactive Units
# Progressive learning: One concept at a time
# ========================================

# Unit 1: Listing Containers (FIRST - see what's running before learning to run)
unit_ps = InteractiveLearningUnit.create!(
  title: "Listing Containers",
  slug: "listing-containers",
  concept_explanation: <<~MARKDOWN,
    # Viewing Containers with docker ps

    The `docker ps` command shows running containers.
    This is usually the FIRST command you'll learn - it helps you see what's running on your system.

    **Commands:**
    - `docker ps` - Show running containers
    - `docker ps -a` - Show all containers (including stopped)

    **Key columns:**
    - CONTAINER ID: Unique identifier
    - IMAGE: Source image
    - COMMAND: Entry command
    - CREATED: When created
    - STATUS: Running, Exited, etc.
    - NAMES: Container name
  MARKDOWN
  command_to_learn: "docker ps",
  command_variations: [
    "docker container ls",
    "docker container ps"
  ],
  practice_hints: [
    "Use 'docker ps' to list running containers",
    "The command is simply: docker ps"
  ],
  scenario_description: "View all running containers on your system.",
  scenario_steps: [
    {
      step: 1,
      instruction: "List running containers",
      command: "docker ps",
      explanation: "Shows all currently running containers"
    },
    {
      step: 2,
      instruction: "List all containers (including stopped)",
      command: "docker ps -a",
      explanation: "The -a flag includes stopped containers"
    }
  ],
  difficulty_level: "easy",
  estimated_minutes: 3,
  sequence_order: 1,
  category: "containers",
  published: true,
  quiz_question_text: "What's the difference between 'docker ps' and 'docker ps -a'?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "'docker ps' shows running containers, 'docker ps -a' shows all containers", correct: true },
    { text: "'docker ps -a' shows only stopped containers", correct: false },
    { text: "They are exactly the same", correct: false },
    { text: "'docker ps -a' shows only failed containers", correct: false }
  ],
  quiz_correct_answer: "'docker ps' shows running containers, 'docker ps -a' shows all containers",
  quiz_explanation: "The -a flag means 'all', so it includes both running and stopped containers.",
  learning_objectives: ["List running containers", "View all containers"],
  prerequisites: []
)

puts "  ✓ Created: #{unit_ps.title}"

# Unit 2: Running Your First Container
unit_hello = InteractiveLearningUnit.create!(
  title: "Running Your First Container",
  slug: "running-first-container",
  concept_explanation: <<~MARKDOWN,
    # Running Your First Container

    The `docker run` command creates and starts a new container from an image.
    Think of it like starting a new app on your computer, but in an isolated environment.

    **Basic syntax:** `docker run [OPTIONS] IMAGE [COMMAND]`

    When you run this command, Docker:
    1. Checks if the image exists locally
    2. Downloads it from Docker Hub if needed
    3. Creates a new container
    4. Starts the container
  MARKDOWN
  command_to_learn: "docker run hello-world",
  command_variations: [
    "docker container run hello-world"
  ],
  practice_hints: [
    "Start with 'docker run'",
    "Add the image name 'hello-world'",
    "The complete command is: docker run hello-world"
  ],
  scenario_description: "Let's verify your Docker installation by running the hello-world container.",
  scenario_steps: [
    {
      step: 1,
      instruction: "Run the hello-world container",
      command: "docker run hello-world",
      explanation: "This downloads and runs a test container that prints a welcome message"
    }
  ],
  difficulty_level: "easy",
  estimated_minutes: 3,
  sequence_order: 2,
  category: "containers",
  published: true,
  quiz_question_text: "What happens when you run 'docker run hello-world'?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "Downloads the image (if needed) and runs a container that prints a message", correct: true },
    { text: "Only downloads the hello-world image", correct: false },
    { text: "Deletes all existing containers", correct: false },
    { text: "Starts the Docker daemon", correct: false }
  ],
  quiz_correct_answer: "Downloads the image (if needed) and runs a container that prints a message",
  quiz_explanation: "The 'docker run' command downloads the image if it doesn't exist locally, then creates and starts a container from that image.",
  learning_objectives: ["Understand the docker run command", "Run your first container"],
  prerequisites: ["listing-containers"]
)

puts "  ✓ Created: #{unit_hello.title}"

# Unit 3: Running a Real Server (NO FLAGS - just plain docker run)
unit_nginx_plain = InteractiveLearningUnit.create!(
  title: "Running a Real Web Server",
  slug: "running-nginx-plain",
  concept_explanation: <<~MARKDOWN,
    # Running Nginx (Without Flags)

    Now let's run a real web server - nginx! For now, we'll use the simplest form of `docker run`.

    **Command:** `docker run nginx`

    What happens:
    - Docker downloads the nginx image
    - Creates and starts a container
    - Nginx starts serving on port 80 INSIDE the container
    - Your terminal is attached to the container (you'll see nginx logs)

    **Note:** This will "block" your terminal - you'll see logs streaming.
    Press Ctrl+C to stop it. In the next lesson, we'll learn how to run it in the background!
  MARKDOWN
  command_to_learn: "docker run nginx",
  command_variations: [
    "docker container run nginx"
  ],
  practice_hints: [
    "Just use 'docker run' with the image name",
    "Try: docker run nginx",
    "Your terminal will show nginx logs - this is normal!"
  ],
  scenario_description: "Run nginx web server and see it start up.",
  scenario_steps: [
    {
      step: 1,
      instruction: "Run nginx",
      command: "docker run nginx",
      explanation: "Starts nginx in foreground mode - you'll see logs"
    }
  ],
  difficulty_level: "easy",
  estimated_minutes: 3,
  sequence_order: 3,
  category: "containers",
  published: true,
  quiz_question_text: "When you run 'docker run nginx' without flags, what happens to your terminal?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "Your terminal is attached to the container and shows logs", correct: true },
    { text: "The container runs in the background", correct: false },
    { text: "The terminal closes automatically", correct: false },
    { text: "Nothing happens", correct: false }
  ],
  quiz_correct_answer: "Your terminal is attached to the container and shows logs",
  quiz_explanation: "Without the -d flag, the container runs in foreground mode and your terminal shows the container's output.",
  learning_objectives: ["Run a real server container", "Understand foreground vs background execution"],
  prerequisites: ["running-first-container"]
)

puts "  ✓ Created: #{unit_nginx_plain.title}"

# Unit 4: Running Nginx in Detached Mode (Add ONLY -d flag)
unit_detached = InteractiveLearningUnit.create!(
  title: "Running in Detached Mode",
  slug: "running-nginx-detached",
  concept_explanation: <<~MARKDOWN,
    # Running Nginx in Detached Mode

    The `-d` flag runs a container in **detached mode** (in the background).
    This is essential for long-running services like web servers.

    **Command:** `docker run -d nginx`

    Benefits of detached mode:
    - Container runs in the background
    - You get your terminal back immediately
    - Container continues running even if you close the terminal
    - Use `docker ps` to see it running

    This is different from the previous lesson where your terminal was "blocked"!
  MARKDOWN
  command_to_learn: "docker run -d nginx",
  command_variations: [
    "docker container run -d nginx",
    "docker run --detach nginx",
    "docker container run --detach nginx"
  ],
  practice_hints: [
    "Use the -d flag for detached mode",
    "The format is: docker run -d [image_name]",
    "Try: docker run -d nginx"
  ],
  scenario_description: "Start an nginx web server in the background.",
  scenario_steps: [
    {
      step: 1,
      instruction: "Run nginx in detached mode",
      command: "docker run -d nginx",
      explanation: "The -d flag runs the container in the background"
    },
    {
      step: 2,
      instruction: "Check running containers",
      command: "docker ps",
      explanation: "List all running containers to see your nginx container"
    }
  ],
  difficulty_level: "easy",
  estimated_minutes: 4,
  sequence_order: 4,
  category: "containers",
  published: true,
  quiz_question_text: "What does the -d flag do in 'docker run -d nginx'?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "Runs the container in detached (background) mode", correct: true },
    { text: "Deletes the container after it stops", correct: false },
    { text: "Downloads the nginx image", correct: false },
    { text: "Displays detailed logs", correct: false }
  ],
  quiz_correct_answer: "Runs the container in detached (background) mode",
  quiz_explanation: "The -d (or --detach) flag runs containers in the background, freeing up your terminal.",
  learning_objectives: ["Run containers in detached mode", "Understand background processes"],
  prerequisites: ["running-nginx-plain"]
)

puts "  ✓ Created: #{unit_detached.title}"

# Unit 5: Naming Containers (Add ONLY --name flag)
unit_naming = InteractiveLearningUnit.create!(
  title: "Naming Your Containers",
  slug: "naming-containers",
  concept_explanation: <<~MARKDOWN,
    # Naming Containers with --name

    By default, Docker assigns random names to containers. The `--name` flag lets you choose meaningful names.

    **Command:** `docker run -d --name my-nginx nginx`

    Benefits:
    - Easy to remember and reference
    - Easier to manage multiple containers
    - Better for scripts and automation
    - Names must be unique
  MARKDOWN
  command_to_learn: "docker run -d --name my-nginx nginx",
  command_variations: [
    "docker container run -d --name my-nginx nginx",
    "docker run --detach --name my-nginx nginx"
  ],
  practice_hints: [
    "Use the --name flag to specify a name",
    "Format: docker run -d --name [your-name] [image]",
    "Try: docker run -d --name my-nginx nginx"
  ],
  scenario_description: "Create a named nginx container for easier management.",
  scenario_steps: [
    {
      step: 1,
      instruction: "Run nginx with a custom name",
      command: "docker run -d --name my-nginx nginx",
      explanation: "The --name flag assigns a custom name to your container"
    },
    {
      step: 2,
      instruction: "Verify the container name",
      command: "docker ps",
      explanation: "Look for your container in the NAMES column"
    }
  ],
  difficulty_level: "easy",
  estimated_minutes: 4,
  sequence_order: 5,
  category: "containers",
  published: true,
  quiz_question_text: "Why is naming containers useful?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "Makes containers easier to reference and manage", correct: true },
    { text: "Makes containers run faster", correct: false },
    { text: "Allows multiple containers with the same name", correct: false },
    { text: "Automatically exposes container ports", correct: false }
  ],
  quiz_correct_answer: "Makes containers easier to reference and manage",
  quiz_explanation: "Named containers are easier to remember, reference in commands, and manage in complex environments.",
  learning_objectives: ["Name containers with --name flag", "Understand container naming"],
  prerequisites: ["running-nginx-detached"]
)

puts "  ✓ Created: #{unit_naming.title}"

# Unit 6: Port Mapping (Add ONLY -p flag)
unit_ports = InteractiveLearningUnit.create!(
  title: "Exposing Container Ports",
  slug: "port-mapping",
  concept_explanation: <<~MARKDOWN,
    # Port Mapping with -p

    Containers are isolated by default. To access services inside a container, you need to **map ports**.

    **Command:** `docker run -d -p 8080:80 nginx`

    **Format:** `-p HOST_PORT:CONTAINER_PORT`

    - `8080`: Port on your host machine
    - `80`: Port inside the container
    - Now you can access nginx at http://localhost:8080
  MARKDOWN
  command_to_learn: "docker run -d -p 8080:80 nginx",
  command_variations: [
    "docker container run -d -p 8080:80 nginx",
    "docker run --detach -p 8080:80 nginx",
    "docker run -d --publish 8080:80 nginx"
  ],
  practice_hints: [
    "Use -p to map ports: -p HOST:CONTAINER",
    "Map host port 8080 to container port 80",
    "Try: docker run -d -p 8080:80 nginx"
  ],
  scenario_description: "Run nginx and make it accessible on port 8080 of your host machine.",
  scenario_steps: [
    {
      step: 1,
      instruction: "Run nginx with port mapping",
      command: "docker run -d -p 8080:80 --name web nginx",
      explanation: "Maps port 8080 on host to port 80 in container"
    },
    {
      step: 2,
      instruction: "Test the web server",
      command: "curl http://localhost:8080",
      explanation: "You should see the nginx welcome page"
    }
  ],
  difficulty_level: "medium",
  estimated_minutes: 5,
  sequence_order: 6,
  category: "networking",
  published: true,
  quiz_question_text: "In 'docker run -p 8080:80 nginx', what does 8080 represent?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "The port on the host machine", correct: true },
    { text: "The port inside the container", correct: false },
    { text: "The process ID", correct: false },
    { text: "The container ID", correct: false }
  ],
  quiz_correct_answer: "The port on the host machine",
  quiz_explanation: "In -p HOST:CONTAINER format, the first number (8080) is the host port, and the second (80) is the container port.",
  learning_objectives: ["Map container ports to host", "Understand port publishing"],
  prerequisites: ["naming-containers"]
)

puts "  ✓ Created: #{unit_ports.title}"

# Unit 5: Environment Variables
unit5 = InteractiveLearningUnit.create!(
  title: "Setting Environment Variables",
  slug: "environment-variables",
  concept_explanation: <<~MARKDOWN,
    # Environment Variables with -e
    
    Many containers need configuration through **environment variables**.
    Use the `-e` flag to set them.
    
    **Command:** `docker run -e MY_VAR=value nginx`
    
    **Example with MySQL:**
    ```
    docker run -e MYSQL_ROOT_PASSWORD=secret mysql
    ```
    
    - Multiple `-e` flags for multiple variables
    - Essential for passwords, API keys, configuration
  MARKDOWN
  command_to_learn: "docker run -d -e MYSQL_ROOT_PASSWORD=secret mysql",
  command_variations: [
    "docker container run -d -e MYSQL_ROOT_PASSWORD=secret mysql",
    "docker run --detach -e MYSQL_ROOT_PASSWORD=secret mysql",
    "docker run -d --env MYSQL_ROOT_PASSWORD=secret mysql"
  ],
  practice_hints: [
    "Use -e to set environment variables",
    "MySQL requires MYSQL_ROOT_PASSWORD to be set",
    "Try: docker run -d -e MYSQL_ROOT_PASSWORD=secret mysql"
  ],
  scenario_description: "Start a MySQL database with a root password set via environment variable.",
  scenario_steps: [
    {
      step: 1,
      instruction: "Run MySQL with root password",
      command: "docker run -d -e MYSQL_ROOT_PASSWORD=secret --name db mysql",
      explanation: "Sets the MySQL root password using an environment variable"
    },
    {
      step: 2,
      instruction: "Check the container logs",
      command: "docker logs db",
      explanation: "View MySQL startup logs to confirm it's running"
    }
  ],
  difficulty_level: "medium",
  estimated_minutes: 5,
  sequence_order: 7,
  category: "configuration",
  published: true,
  quiz_question_text: "How do you pass environment variables to a container?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "Using the -e or --env flag", correct: true },
    { text: "Using the -v flag", correct: false },
    { text: "Using the -p flag", correct: false },
    { text: "Environment variables are set automatically", correct: false }
  ],
  quiz_correct_answer: "Using the -e or --env flag",
  quiz_explanation: "The -e (or --env) flag allows you to set environment variables when running a container.",
  learning_objectives: ["Set environment variables in containers", "Configure containerized applications"],
  prerequisites: ["port-mapping"]
)

puts "  ✓ Created: #{unit5.title}"

# Unit 8: Stopping Containers
unit7 = InteractiveLearningUnit.create!(
  title: "Stopping Containers",
  slug: "stopping-containers",
  concept_explanation: <<~MARKDOWN,
    # Stopping Containers
    
    The `docker stop` command gracefully stops a running container.
    
    **Command:** `docker stop CONTAINER_NAME_OR_ID`
    
    How it works:
    1. Sends SIGTERM signal to the main process
    2. Waits 10 seconds for graceful shutdown
    3. If still running, sends SIGKILL
    
    You can also use `docker kill` for immediate termination (sends SIGKILL).
  MARKDOWN
  command_to_learn: "docker stop my-nginx",
  command_variations: [
    "docker container stop my-nginx"
  ],
  practice_hints: [
    "Use 'docker stop' followed by the container name",
    "If you named your container 'my-nginx', try: docker stop my-nginx"
  ],
  scenario_description: "Stop a running nginx container gracefully.",
  scenario_steps: [
    {
      step: 1,
      instruction: "First, run an nginx container",
      command: "docker run -d --name my-nginx nginx",
      explanation: "Create a container to practice stopping"
    },
    {
      step: 2,
      instruction: "Stop the container",
      command: "docker stop my-nginx",
      explanation: "Gracefully stops the container"
    },
    {
      step: 3,
      instruction: "Verify it stopped",
      command: "docker ps -a",
      explanation: "The STATUS should show 'Exited'"
    }
  ],
  difficulty_level: "easy",
  estimated_minutes: 3,
  sequence_order: 8,
  category: "containers",
  published: true,
  quiz_question_text: "What signal does 'docker stop' send first?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "SIGTERM (allows graceful shutdown)", correct: true },
    { text: "SIGKILL (immediate termination)", correct: false },
    { text: "SIGHUP", correct: false },
    { text: "SIGINT", correct: false }
  ],
  quiz_correct_answer: "SIGTERM (allows graceful shutdown)",
  quiz_explanation: "docker stop sends SIGTERM first, allowing the application to shut down gracefully. After a timeout, it sends SIGKILL.",
  learning_objectives: ["Stop containers gracefully", "Understand container shutdown process"],
  prerequisites: ["naming-containers"]
)

puts "  ✓ Created: #{unit7.title}"

# Unit 8: Removing Containers
unit8 = InteractiveLearningUnit.create!(
  title: "Removing Containers",
  slug: "removing-containers",
  concept_explanation: <<~MARKDOWN,
    # Removing Containers
    
    The `docker rm` command removes stopped containers.
    
    **Command:** `docker rm CONTAINER_NAME`
    
    **Important:**
    - Can only remove stopped containers (or use `-f` to force)
    - Removes the container but NOT the image
    - Container data is lost unless using volumes
    
    **Cleanup tip:** `docker rm $(docker ps -aq)` removes all stopped containers
  MARKDOWN
  command_to_learn: "docker rm my-nginx",
  command_variations: [
    "docker container rm my-nginx"
  ],
  practice_hints: [
    "Use 'docker rm' followed by the container name",
    "The container must be stopped first",
    "Try: docker rm my-nginx"
  ],
  scenario_description: "Remove a stopped container to clean up your system.",
  scenario_steps: [
    {
      step: 1,
      instruction: "Create and stop a container",
      command: "docker run -d --name temp-nginx nginx && docker stop temp-nginx",
      explanation: "Create a container then stop it"
    },
    {
      step: 2,
      instruction: "Remove the container",
      command: "docker rm temp-nginx",
      explanation: "Permanently removes the stopped container"
    },
    {
      step: 3,
      instruction: "Verify it's gone",
      command: "docker ps -a | grep temp-nginx",
      explanation: "Should return nothing"
    }
  ],
  difficulty_level: "easy",
  estimated_minutes: 3,
  sequence_order: 9,
  category: "containers",
  published: true,
  quiz_question_text: "Can you remove a running container with 'docker rm'?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "No, unless you use the -f flag", correct: true },
    { text: "Yes, always", correct: false },
    { text: "No, never", correct: false },
    { text: "Only if it's been running for less than 1 hour", correct: false }
  ],
  quiz_correct_answer: "No, unless you use the -f flag",
  quiz_explanation: "By default, docker rm only works on stopped containers. Use docker rm -f to force remove a running container.",
  learning_objectives: ["Remove stopped containers", "Clean up your Docker environment"],
  prerequisites: ["stopping-containers"]
)

puts "  ✓ Created: #{unit8.title}"

# Unit 9: Docker Volumes
unit9 = InteractiveLearningUnit.create!(
  title: "Creating Docker Volumes",
  slug: "creating-volumes",
  concept_explanation: <<~MARKDOWN,
    # Docker Volumes
    
    Volumes are the preferred way to persist data in Docker containers.
    
    **Create a volume:** `docker volume create VOLUME_NAME`
    
    **Why use volumes?**
    - Data persists even when containers are removed
    - Can be shared between containers
    - Easier to backup and migrate
    - Better performance than bind mounts
  MARKDOWN
  command_to_learn: "docker volume create my-data",
  command_variations: [],
  practice_hints: [
    "Use 'docker volume create' followed by a name",
    "Try: docker volume create my-data"
  ],
  scenario_description: "Create a Docker volume for persistent data storage.",
  scenario_steps: [
    {
      step: 1,
      instruction: "Create a volume",
      command: "docker volume create my-data",
      explanation: "Creates a named volume for storing data"
    },
    {
      step: 2,
      instruction: "List volumes",
      command: "docker volume ls",
      explanation: "Shows all volumes including the one you just created"
    },
    {
      step: 3,
      instruction: "Inspect the volume",
      command: "docker volume inspect my-data",
      explanation: "Shows detailed information about the volume"
    }
  ],
  difficulty_level: "medium",
  estimated_minutes: 4,
  sequence_order: 10,
  category: "volumes",
  published: true,
  quiz_question_text: "What happens to data in a volume when you remove the container?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "The data persists in the volume", correct: true },
    { text: "The data is deleted", correct: false },
    { text: "The data is moved to the host", correct: false },
    { text: "The data becomes read-only", correct: false }
  ],
  quiz_correct_answer: "The data persists in the volume",
  quiz_explanation: "Volumes persist data independently of container lifecycle. Data remains even after container removal.",
  learning_objectives: ["Create Docker volumes", "Understand persistent storage"],
  prerequisites: ["environment-variables"]
)

puts "  ✓ Created: #{unit9.title}"

# Unit 10: Using Volumes with Containers
unit10 = InteractiveLearningUnit.create!(
  title: "Mounting Volumes to Containers",
  slug: "mounting-volumes",
  concept_explanation: <<~MARKDOWN,
    # Mounting Volumes
    
    Use the `-v` flag to mount volumes to containers.
    
    **Command:** `docker run -v VOLUME_NAME:CONTAINER_PATH image`
    
    **Example:**
    ```
    docker run -d -v my-data:/app/data nginx
    ```
    
    This mounts the volume `my-data` to `/app/data` inside the container.
  MARKDOWN
  command_to_learn: "docker run -d -v my-data:/usr/share/nginx/html nginx",
  command_variations: [
    "docker run --detach --volume my-data:/usr/share/nginx/html nginx",
    "docker container run -d -v my-data:/usr/share/nginx/html nginx"
  ],
  practice_hints: [
    "Use -v to mount volumes",
    "Format: -v VOLUME_NAME:CONTAINER_PATH",
    "Try: docker run -d -v my-data:/usr/share/nginx/html nginx"
  ],
  scenario_description: "Mount a volume to an nginx container to persist web content.",
  scenario_steps: [
    {
      step: 1,
      instruction: "Create a volume first",
      command: "docker volume create web-content",
      explanation: "Create the volume we'll mount"
    },
    {
      step: 2,
      instruction: "Run nginx with the volume",
      command: "docker run -d --name web -v web-content:/usr/share/nginx/html nginx",
      explanation: "Mounts the volume to nginx's web root"
    },
    {
      step: 3,
      instruction: "Verify the mount",
      command: "docker inspect web | grep -A 10 Mounts",
      explanation: "Shows volume mount information"
    }
  ],
  difficulty_level: "medium",
  estimated_minutes: 5,
  sequence_order: 11,
  category: "volumes",
  published: true,
  quiz_question_text: "In 'docker run -v my-data:/app', what does '/app' represent?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "The path inside the container", correct: true },
    { text: "The path on the host machine", correct: false },
    { text: "The volume name", correct: false },
    { text: "The image name", correct: false }
  ],
  quiz_correct_answer: "The path inside the container",
  quiz_explanation: "In the -v VOLUME:PATH format, the path after the colon is where the volume is mounted inside the container.",
  learning_objectives: ["Mount volumes to containers", "Persist data across container restarts"],
  prerequisites: ["creating-volumes"]
)

puts "  ✓ Created: #{unit10.title}"

# Unit 11: Viewing Container Logs
unit11 = InteractiveLearningUnit.create!(
  title: "Viewing Container Logs",
  slug: "container-logs",
  concept_explanation: <<~MARKDOWN,
    # Container Logs
    
    The `docker logs` command shows output from a container's main process.
    
    **Command:** `docker logs CONTAINER_NAME`
    
    **Useful flags:**
    - `-f` or `--follow`: Stream logs in real-time
    - `--tail N`: Show only the last N lines
    - `-t` or `--timestamps`: Show timestamps
    
    **Example:** `docker logs -f --tail 100 my-app`
  MARKDOWN
  command_to_learn: "docker logs my-nginx",
  command_variations: [
    "docker container logs my-nginx"
  ],
  practice_hints: [
    "Use 'docker logs' followed by container name",
    "Try: docker logs my-nginx"
  ],
  scenario_description: "View logs from a running nginx container.",
  scenario_steps: [
    {
      step: 1,
      instruction: "Run nginx",
      command: "docker run -d --name web nginx",
      explanation: "Start nginx to generate logs"
    },
    {
      step: 2,
      instruction: "View the logs",
      command: "docker logs web",
      explanation: "Shows all output from nginx"
    },
    {
      step: 3,
      instruction: "Follow logs in real-time",
      command: "docker logs -f web",
      explanation: "Streams new log entries as they occur"
    }
  ],
  difficulty_level: "easy",
  estimated_minutes: 3,
  sequence_order: 12,
  category: "debugging",
  published: true,
  quiz_question_text: "What does the -f flag do with 'docker logs'?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "Follows logs in real-time (like tail -f)", correct: true },
    { text: "Filters logs by keyword", correct: false },
    { text: "Forces log output", correct: false },
    { text: "Formats logs as JSON", correct: false }
  ],
  quiz_correct_answer: "Follows logs in real-time (like tail -f)",
  quiz_explanation: "The -f (or --follow) flag streams logs in real-time, similar to the tail -f command in Linux.",
  learning_objectives: ["View container logs", "Debug running containers"],
  prerequisites: ["running-nginx"]
)

puts "  ✓ Created: #{unit11.title}"

# Unit 12: Executing Commands in Running Containers
unit12 = InteractiveLearningUnit.create!(
  title: "Executing Commands in Containers",
  slug: "docker-exec",
  concept_explanation: <<~MARKDOWN,
    # Docker Exec
    
    The `docker exec` command runs a command in a running container.
    
    **Command:** `docker exec [OPTIONS] CONTAINER COMMAND`
    
    **Common use cases:**
    - `docker exec -it container bash`: Get an interactive shell
    - `docker exec container ls /app`: Run a quick command
    - `docker exec -u root container apt-get update`: Run as specific user
    
    **Flags:**
    - `-i`: Keep STDIN open
    - `-t`: Allocate a pseudo-TTY
    - Combined `-it`: Interactive terminal
  MARKDOWN
  command_to_learn: "docker exec -it my-nginx bash",
  command_variations: [
    "docker container exec -it my-nginx bash",
    "docker exec -it my-nginx /bin/bash"
  ],
  practice_hints: [
    "Use -it flags for interactive shell",
    "Format: docker exec -it CONTAINER bash",
    "Try: docker exec -it my-nginx bash"
  ],
  scenario_description: "Access a running nginx container's shell.",
  scenario_steps: [
    {
      step: 1,
      instruction: "Run nginx if not already running",
      command: "docker run -d --name web nginx",
      explanation: "Need a running container to exec into"
    },
    {
      step: 2,
      instruction: "Execute bash in the container",
      command: "docker exec -it web bash",
      explanation: "Opens an interactive shell inside the container"
    },
    {
      step: 3,
      instruction: "Run a command inside",
      command: "docker exec web ls /usr/share/nginx/html",
      explanation: "Runs a single command without interactive mode"
    }
  ],
  difficulty_level: "medium",
  estimated_minutes: 4,
  sequence_order: 13,
  category: "containers",
  published: true,
  quiz_question_text: "What do the -it flags do in 'docker exec -it container bash'?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "Provide an interactive terminal", correct: true },
    { text: "Install tools in the container", correct: false },
    { text: "Inspect the container", correct: false },
    { text: "Iterate through containers", correct: false }
  ],
  quiz_correct_answer: "Provide an interactive terminal",
  quiz_explanation: "-i keeps STDIN open and -t allocates a pseudo-TTY, together they provide an interactive terminal session.",
  learning_objectives: ["Execute commands in running containers", "Access container shells"],
  prerequisites: ["running-nginx"]
)

puts "  ✓ Created: #{unit12.title}"

puts "🎉 Successfully created #{InteractiveLearningUnit.count} interactive learning units!"

