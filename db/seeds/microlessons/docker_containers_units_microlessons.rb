# AUTO-GENERATED from docker_containers_units.rb
puts "Creating Microlessons for Docker Containers..."

module_var = CourseModule.find_by(slug: 'docker-containers')

# === MICROLESSON 1: Docker Container Stop: Gracefully Stop Containers ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Container Stop: Gracefully Stop Containers',
  content: <<~MARKDOWN,
# Docker Container Stop: Gracefully Stop Containers 🚀

## What is this?
A concise explanation of the concept.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 2: Docker Container Kill: Forcefully Stop Containers ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Container Kill: Forcefully Stop Containers',
  content: <<~MARKDOWN,
# Docker Container Kill: Forcefully Stop Containers 🚀

## What is this?
A concise explanation of the concept.
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 3: Docker Container Prune: Batch Container Cleanup ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Container Prune: Batch Container Cleanup',
  content: <<~MARKDOWN,
# Docker Container Prune: Batch Container Cleanup 🚀

# Mastering docker container prune: Efficient Container Cleanup

    ## What is docker container prune?
    `docker container prune` removes all stopped containers in a single command. It's the modern, efficient way to clean up your Docker environment without manually removing containers one by one.

    ## Why Batch Cleanup Matters
    - **Efficiency**: Clean dozens of containers with one command
    - **Disk Space**: Reclaim significant storage quickly
    - **Automation**: Perfect for CI/CD cleanup scripts
    - **Safety**: Only removes stopped containers (running ones are protected)

    ## Common Use Cases

    ### Remove All Stopped Containers
    ```bash
    docker container prune -f
    ```

    ### Filter by Time
    ```bash
    docker container prune --filter "until=24h"
    ```

    ### Safety Features
    The command prompts for confirmation unless you use `-f` flag.

    ## Best Practices
    1. Schedule regular cleanup via cron
    2. Use filters wisely
    3. Label containers for selective cleanup
    4. Test in dev first

## Syntax/Command

```bash
docker container prune
```

## Example

```bash
docker container prune -f
```

## Key Points

- Basic prune: docker container prune (with confirmation)

- Force prune: docker container prune -f

- Age filter: docker container prune --filter "until=24h"
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['containers', 'cleanup', 'docker-prune', 'maintenance', 'disk-space'],
  prerequisite_ids: []
)

# Exercise 3.1: Terminal
Exercise.create!(
  micro_lesson: lesson_3,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {
    command: 'docker container prune',
    description: 'Remove all stopped containers older than 48 hours without confirmation prompts',
    difficulty: 'easy',
    require_pass: true,
    timeout_sec: 30,
    validation: { must_not_include: ['Error', 'permission denied'], must_include: [] },
    hints: ['Basic prune: docker container prune (with confirmation)', 'Force prune: docker container prune -f', 'Age filter: docker container prune --filter "until=24h"']
  }
)

# Exercise 3.2: MCQ
Exercise.create!(
  micro_lesson: lesson_3,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    question: 'What does docker container prune remove by default?',
    options: ['All stopped containers', 'All containers including running ones', 'All containers and images', 'Only containers older than 24 hours'],
    correct_answer: 0,
    explanation: 'docker container prune removes all stopped containers (exited or created state). Running and paused containers are never removed.',
    difficulty: 'easy',
    require_pass: true
  }
)

# Exercise 3.3: Sandbox
Exercise.create!(
  micro_lesson: lesson_3,
  exercise_type: 'sandbox',
  sequence_order: 3,
  exercise_data: {
    timeout_sec: 60,
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker container prune -f',
    validation: { must_not_include: ['Error', 'panic:'] },
    require_pass: true,
    hints: ['Ensure no running containers are affected', 'Use -f to skip confirmation', 'Run as a safe cleanup in CI']
  }
)

# === MICROLESSON 4: Docker CP: Copy Files Between Container and Host ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker CP: Copy Files Between Container and Host',
  content: <<~MARKDOWN,
# Docker CP: Copy Files Between Container and Host 🚀

Copy files and directories bidirectionally between containers and host filesystem, even while containers are running.

## Syntax/Command

```bash
docker cp my-file.txt my-container:/app/
```

## Example

```bash
docker cp host-file.txt container:/path/
```

## Key Points

- Host to container: docker cp /local/file container:/remote/

- Container to host: docker cp container:/remote/file /local/
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['containers', 'docker-cp', 'file-transfer', 'deployment', 'backup'],
  prerequisite_ids: []
)

# Exercise 4.1: Terminal
Exercise.create!(
  micro_lesson: lesson_4,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {
    command: 'docker cp my-file.txt my-container:/app/',
    description: 'Copy configuration file from host to running container',
    difficulty: 'medium',
    require_pass: true,
    timeout_sec: 30,
    validation: { must_not_include: ['No such container', 'Error'], must_include: [] },
    hints: ['Host to container: docker cp /local/file container:/remote/', 'Container to host: docker cp container:/remote/file /local/']
  }
)

# Exercise 4.2: MCQ
Exercise.create!(
  micro_lesson: lesson_4,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    question: 'Can you use docker cp on a stopped container?',
    options: ['Yes, docker cp works on both running and stopped containers', 'No, container must be running', 'Only for copying FROM container', 'Only with the --force flag'],
    correct_answer: 0,
    explanation: 'docker cp works on containers in any state - useful for data recovery and backup.',
    difficulty: 'medium',
    require_pass: true
  }
)

# Exercise 4.3: Sandbox
Exercise.create!(
  micro_lesson: lesson_4,
  exercise_type: 'sandbox',
  sequence_order: 3,
  exercise_data: {
    timeout_sec: 60,
    setup: 'echo Ensure container exists: docker run -d --name my-container alpine:3.18 sleep 60 || true',
    run: 'docker cp /etc/hosts my-container:/etc/hosts.bak',
    validation: { must_not_include: ['Error', 'No such container'] },
    require_pass: true,
    hints: ['Use an existing container or start a temporary one', 'Absolute paths avoid surprises']
  }
)

# === MICROLESSON 5: Docker Diff: Inspect Container Filesystem Changes ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Diff: Inspect Container Filesystem Changes',
  content: <<~MARKDOWN,
# Docker Diff: Inspect Container Filesystem Changes 🚀

Show which files and directories have been modified, added, or deleted in a container compared to its base image.

## Syntax/Command

```bash
docker diff my-container
```

## Example

```bash
docker diff container
```

## Key Points

- See all changes: docker diff <container>

- Only added files: docker diff <container> | grep "^A"

- Only modified: docker diff <container> | grep "^C"
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['containers', 'docker-diff', 'filesystem', 'debugging', 'security'],
  prerequisite_ids: []
)

# Exercise 5.1: Terminal
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker diff my-container',
    description: 'Use docker diff to identify filesystem changes for security investigation',
    difficulty: 'medium',
    hints: ['See all changes: docker diff <container>', 'Only added files: docker diff <container> | grep "^A"', 'Only modified: docker diff <container> | grep "^C"']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker diff my-container',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 5.2: MCQ
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In docker diff output, what does the "C" prefix indicate?',
    options: ['Changed (modified) file or directory', 'Created file', 'Copied file', 'Container file'],
    correct_answer: 0,
    explanation: 'In docker diff: "C" = changed/modified, "A" = added, "D" = deleted.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 6: Docker Export: Export Container Filesystem as Archive ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Export: Export Container Filesystem as Archive',
  content: <<~MARKDOWN,
# Docker Export: Export Container Filesystem as Archive 🚀

Create a tarball archive of a container\

## Syntax/Command

```bash
docker export my-container > backup.tar
```

## Example

```bash
docker export -o backup.tar my-container
```

## Key Points

- Basic export: docker export container > file.tar

- Compressed: docker export container | gzip > file.tar.gz

- Import back: cat file.tar | docker import - image:tag
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['containers', 'docker-export', 'backup', 'migration', 'archival'],
  prerequisite_ids: []
)

# Exercise 6.1: Terminal
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker export my-container > backup.tar',
    description: 'Export production containers as compressed backups',
    difficulty: 'medium',
    hints: ['Basic export: docker export container > file.tar', 'Compressed: docker export container | gzip > file.tar.gz', 'Import back: cat file.tar | docker import - image:tag']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker export my-container > backup.tar',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 6.2: MCQ
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the main difference between docker export and docker save?',
    options: ['export creates archive of container filesystem, save preserves image layers', 'export is for images, save is for containers', 'export includes metadata, save does not', 'They are exactly the same'],
    correct_answer: 0,
    explanation: 'docker export creates flat tarball of container (loses layers), docker save preserves image with all layers.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 7: Docker Stats: Live Resource Usage Statistics ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Stats: Live Resource Usage Statistics',
  content: <<~MARKDOWN,
# Docker Stats: Live Resource Usage Statistics 🚀

Display live resource usage statistics including CPU, memory, network I/O, and disk I/O for running containers.

## Syntax/Command

```bash
docker stats
```

## Example

```bash
docker stats --no-stream
```

## Key Points

- Live stats: docker stats

- One-shot: docker stats --no-stream

- Specific containers: docker stats web db
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['containers', 'docker-stats', 'monitoring', 'performance', 'resources'],
  prerequisite_ids: []
)

# Exercise 7.1: Terminal
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker stats',
    description: 'Monitor container resource usage to identify performance bottlenecks',
    difficulty: 'easy',
    hints: ['Live stats: docker stats', 'One-shot: docker stats --no-stream', 'Specific containers: docker stats web db']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker stats',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 7.2: MCQ
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What does a CPU percentage of 200% mean in docker stats?',
    options: ['Container is using 2 full CPU cores', 'Container is overloaded by 100%', 'There is an error in measurement', 'CPU limit has been exceeded'],
    correct_answer: 0,
    explanation: 'CPU percentages can exceed 100% on multi-core systems. 100% = 1 core, 200% = 2 cores.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 8: Docker Top: Display Running Processes in Container ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Top: Display Running Processes in Container',
  content: <<~MARKDOWN,
# Docker Top: Display Running Processes in Container 🚀

Display running processes inside a container, similar to the Unix top command but for containerized processes.

## Syntax/Command

```bash
docker top my-container
```

## Example

```bash
docker top container
```

## Key Points

- View processes: docker top <container>

- With ps options: docker top <container> aux
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['containers', 'docker-top', 'processes', 'monitoring', 'debugging'],
  prerequisite_ids: []
)

# Exercise 8.1: Terminal
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker top my-container',
    description: 'List all processes running in a container to identify resource hogs',
    difficulty: 'easy',
    hints: ['View processes: docker top <container>', 'With ps options: docker top <container> aux']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker top my-container',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 8.2: MCQ
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What does docker top display?',
    options: ['Running processes inside the container', 'Top resource-consuming containers', 'Container configuration', 'Container logs'],
    correct_answer: 0,
    explanation: 'docker top shows the running processes inside a specific container.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 9: Docker Update: Update Container Configuration ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Update: Update Container Configuration',
  content: <<~MARKDOWN,
# Docker Update: Update Container Configuration 🚀

Update resource limits and restart policies of running containers without stopping them.

## Syntax/Command

```bash
docker update --memory="1g" my-container
```

## Example

```bash
docker update --cpus="2" container
```

## Key Points

- Update memory: docker update --memory="1g" <container>

- Update CPUs: docker update --cpus="2" <container>

- Update restart policy: docker update --restart=always <container>
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['containers', 'docker-update', 'resources', 'configuration', 'runtime'],
  prerequisite_ids: []
)

# Exercise 9.1: Terminal
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker update --memory="1g" my-container',
    description: 'Update container resource limits without stopping it',
    difficulty: 'medium',
    hints: ['Update memory: docker update --memory="1g" <container>', 'Update CPUs: docker update --cpus="2" <container>', 'Update restart policy: docker update --restart=always <container>']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker update --memory="1g" my-container',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 9.2: MCQ
Exercise.create!(
  micro_lesson: lesson_9,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What can you update with docker update command?',
    options: ['Resource limits and restart policies', 'Container image', 'Container name', 'Environment variables'],
    correct_answer: 0,
    explanation: 'docker update can modify resource limits (CPU, memory) and restart policies of running containers.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 10: Docker Port: List Port Mappings ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Port: List Port Mappings',
  content: <<~MARKDOWN,
# Docker Port: List Port Mappings 🚀

Display port mappings for a container showing how container ports are exposed on the host.

## Syntax/Command

```bash
docker port my-container
```

## Example

```bash
docker port container
```

## Key Points

- All mappings: docker port <container>

- Specific port: docker port <container> 80
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['containers', 'docker-port', 'networking', 'port-mapping', 'configuration'],
  prerequisite_ids: []
)

# Exercise 10.1: Terminal
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker port my-container',
    description: 'Identify port mappings to access containerized service',
    difficulty: 'easy',
    hints: ['All mappings: docker port <container>', 'Specific port: docker port <container> 80']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker port my-container',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 10.2: MCQ
Exercise.create!(
  micro_lesson: lesson_10,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What information does docker port provide?',
    options: ['Port mappings between container and host', 'Open ports in container', 'Network configuration', 'Firewall rules'],
    correct_answer: 0,
    explanation: 'docker port shows which host ports are mapped to container ports.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 11: Docker Rename: Rename a Container ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Rename: Rename a Container',
  content: <<~MARKDOWN,
# Docker Rename: Rename a Container 🚀

Change the name of a container to something more meaningful or to resolve naming conflicts.

## Syntax/Command

```bash
docker rename old-name new-name
```

## Example

```bash
docker rename container-name new-name
```

## Key Points

- Rename: docker rename <old-name> <new-name>

- Works on running or stopped containers
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['containers', 'docker-rename', 'management', 'naming', 'organization'],
  prerequisite_ids: []
)

# Exercise 11.1: Terminal
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker rename old-name new-name',
    description: 'Rename container for better identification and management',
    difficulty: 'easy',
    hints: ['Rename: docker rename <old-name> <new-name>', 'Works on running or stopped containers']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker rename old-name new-name',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 11.2: MCQ
Exercise.create!(
  micro_lesson: lesson_11,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Can you rename a running container?',
    options: ['Yes, containers can be renamed while running', 'No, must stop first', 'Only if no connections exist', 'Only with --force flag'],
    correct_answer: 0,
    explanation: 'docker rename works on both running and stopped containers without affecting their operation.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 12: Docker Container LS: List Containers ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Container LS: List Containers',
  content: <<~MARKDOWN,
# Docker Container LS: List Containers 🚀

List containers with various filters - modern alternative to docker ps command.

## Syntax/Command

```bash
docker container ls
```

## Example

```bash
docker container ls -a
```

## Key Points

- List running: docker container ls

- List all: docker container ls -a

- Filter by status: docker container ls --filter "status=exited"
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['containers', 'docker-ls', 'listing', 'inspection', 'management'],
  prerequisite_ids: []
)

# Exercise 12.1: Terminal
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker container ls',
    description: 'List all containers and filter by specific criteria',
    difficulty: 'easy',
    hints: ['List running: docker container ls', 'List all: docker container ls -a', 'Filter by status: docker container ls --filter "status=exited"']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker container ls',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 12.2: MCQ
Exercise.create!(
  micro_lesson: lesson_12,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the difference between "docker container ls" and "docker ps"?',
    options: ['They are equivalent commands with same functionality', 'ls shows more details', 'ps is for running only', 'ls is deprecated'],
    correct_answer: 0,
    explanation: 'docker container ls is the modern form, docker ps is legacy shorthand - both work identically.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 13: Docker Container Create: Create Container Without Starting ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Container Create: Create Container Without Starting',
  content: <<~MARKDOWN,
# Docker Container Create: Create Container Without Starting 🚀

Create a container from an image without starting it - useful for configuration before launch.

## Syntax/Command

```bash
docker container create --name my-app nginx
```

## Example

```bash
docker container create -p 8080:80 nginx
```

## Key Points

- Create: docker container create <image>

- With name: docker container create --name <name> <image>

- Start later: docker container start <name>
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['containers', 'docker-create', 'lifecycle', 'initialization', 'configuration'],
  prerequisite_ids: []
)

# Exercise 13.1: Terminal
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker container create --name my-app nginx',
    description: 'Create container with specific configuration without starting it',
    difficulty: 'medium',
    hints: ['Create: docker container create <image>', 'With name: docker container create --name <name> <image>', 'Start later: docker container start <name>']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker container create --name my-app nginx',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 13.2: MCQ
Exercise.create!(
  micro_lesson: lesson_13,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What is the difference between docker create and docker run?',
    options: ['create is faster', 'They are identical'],
    correct_answer: 0,
    explanation: 'docker create prepares container without starting, docker run = create + start in one command.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 14: Docker Container Start: Start Stopped Containers ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Container Start: Start Stopped Containers',
  content: <<~MARKDOWN,
# Docker Container Start: Start Stopped Containers 🚀

Start one or more stopped containers, preserving their state and configuration.

## Syntax/Command

```bash
docker container start my-container
```

## Example

```bash
docker container start -a container
```

## Key Points

- Start: docker container start <name>
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['containers', 'docker-start', 'lifecycle'],
  prerequisite_ids: []
)

# Exercise 14.1: Terminal
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker container start my-container',
    description: 'Start previously stopped container',
    difficulty: 'easy',
    hints: ['Start: docker container start <name>']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker container start my-container',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 14.2: MCQ
Exercise.create!(
  micro_lesson: lesson_14,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What happens to container data when you start a stopped container?',
    options: ['Data is preserved from when it was stopped', 'Container starts fresh'],
    correct_answer: 0,
    explanation: 'docker start restarts container with all data and state preserved.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 15: Docker Container Restart: Stop and Start Containers ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Container Restart: Stop and Start Containers',
  content: <<~MARKDOWN,
# Docker Container Restart: Stop and Start Containers 🚀

Restart containers by stopping and starting them - equivalent to stop + start.

## Syntax/Command

```bash
docker container restart my-container
```

## Example

```bash
docker container restart -t 30 container
```

## Key Points

- Restart: docker container restart <name>
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['containers', 'docker-restart', 'lifecycle'],
  prerequisite_ids: []
)

# Exercise 15.1: Terminal
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker container restart my-container',
    description: 'Restart container to resolve temporary issues',
    difficulty: 'easy',
    hints: ['Restart: docker container restart <name>']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker container restart my-container',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 15.2: MCQ
Exercise.create!(
  micro_lesson: lesson_15,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What does docker restart do?',
    options: ['Stops then starts the container', 'Only stops'],
    correct_answer: 0,
    explanation: 'docker restart = docker stop + docker start in one command.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 16: Docker Container RM: Remove Containers ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Container RM: Remove Containers',
  content: <<~MARKDOWN,
# Docker Container RM: Remove Containers 🚀

Permanently delete stopped containers to free disk space and names.

## Syntax/Command

```bash
docker container rm my-container
```

## Example

```bash
docker container rm -f container
```

## Key Points

- Remove: docker container rm <name>

- Force: docker container rm -f <name>
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['containers', 'docker-rm', 'cleanup', 'lifecycle'],
  prerequisite_ids: []
)

# Exercise 16.1: Terminal
Exercise.create!(
  micro_lesson: lesson_16,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker container rm my-container',
    description: 'Remove stopped containers including their volumes',
    difficulty: 'easy',
    hints: ['Remove: docker container rm <name>', 'Force: docker container rm -f <name>']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_16,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker container rm my-container',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 16.2: MCQ
Exercise.create!(
  micro_lesson: lesson_16,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Can you remove a running container without -f flag?',
    options: ['No, must stop first or use -f', 'Yes'],
    correct_answer: 0,
    explanation: 'Docker requires containers to be stopped before removal, unless using -f to force.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 17: Docker Container Inspect: Detailed Container Information ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Container Inspect: Detailed Container Information',
  content: <<~MARKDOWN,
# Docker Container Inspect: Detailed Container Information 🚀

View complete container configuration and state in JSON format.

## Syntax/Command

```bash
docker container inspect my-container
```

## Example

```bash
docker container inspect --format="{{.State.Status}}" container
```

## Key Points

- Inspect: docker container inspect <name>

- Format: --format="{{.NetworkSettings.IPAddress}}"
  MARKDOWN
  sequence_order: 17,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['containers', 'docker-inspect', 'configuration', 'debugging'],
  prerequisite_ids: []
)

# Exercise 17.1: Terminal
Exercise.create!(
  micro_lesson: lesson_17,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker container inspect my-container',
    description: 'Extract specific configuration details using inspect',
    difficulty: 'medium',
    hints: ['Inspect: docker container inspect <name>', 'Format: --format="{{.NetworkSettings.IPAddress}}"']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_17,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker container inspect my-container',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 17.2: MCQ
Exercise.create!(
  micro_lesson: lesson_17,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What format does docker inspect output?',
    options: ['JSON', 'YAML'],
    correct_answer: 0,
    explanation: 'docker inspect outputs detailed information in JSON format.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 18: Docker Container Logs: View Container Output ===
lesson_18 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Container Logs: View Container Output',
  content: <<~MARKDOWN,
# Docker Container Logs: View Container Output 🚀

Display stdout and stderr output from containers for debugging and monitoring.

## Syntax/Command

```bash
docker container logs my-container
```

## Example

```bash
docker container logs -f container
```

## Key Points

- View logs: docker container logs <name>

- Follow: docker container logs -f <name>
  MARKDOWN
  sequence_order: 18,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['containers', 'docker-logs', 'debugging', 'monitoring'],
  prerequisite_ids: []
)

# Exercise 18.1: Terminal
Exercise.create!(
  micro_lesson: lesson_18,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker container logs my-container',
    description: 'View and follow container logs to identify errors',
    difficulty: 'easy',
    hints: ['View logs: docker container logs <name>', 'Follow: docker container logs -f <name>']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_18,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker container logs my-container',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 18.2: MCQ
Exercise.create!(
  micro_lesson: lesson_18,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which flag makes docker logs follow new output?',
    options: ['-f', '-t'],
    correct_answer: 0,
    explanation: 'The -f flag follows log output in real-time, like tail -f.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 19: Docker Container Exec: Run Commands in Container ===
lesson_19 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Container Exec: Run Commands in Container',
  content: <<~MARKDOWN,
# Docker Container Exec: Run Commands in Container 🚀

Execute commands inside running containers for debugging and maintenance.

## Syntax/Command

```bash
docker container exec -it my-container bash
```

## Example

```bash
docker container exec container ls -la
```

## Key Points

- Shell: docker container exec -it <name> bash

- Command: docker container exec <name> <command>
  MARKDOWN
  sequence_order: 19,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['containers', 'docker-exec', 'debugging', 'interactive'],
  prerequisite_ids: []
)

# Exercise 19.1: Terminal
Exercise.create!(
  micro_lesson: lesson_19,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker container exec -it my-container bash',
    description: 'Execute commands in running container for troubleshooting',
    difficulty: 'easy',
    hints: ['Shell: docker container exec -it <name> bash', 'Command: docker container exec <name> <command>']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_19,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker container exec -it my-container bash',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 19.2: MCQ
Exercise.create!(
  micro_lesson: lesson_19,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What does -it flag do in docker exec?',
    options: ['Provides interactive terminal', 'Installs tools'],
    correct_answer: 0,
    explanation: '-i keeps STDIN open, -t allocates TTY - together they create interactive terminal.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 20: Docker Container Wait: Block Until Container Stops ===
lesson_20 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Container Wait: Block Until Container Stops',
  content: <<~MARKDOWN,
# Docker Container Wait: Block Until Container Stops 🚀

Block until container stops and return its exit code - useful in scripts.

## Syntax/Command

```bash
docker container wait my-container
```

## Example

```bash
docker container wait container1 container2
```

## Key Points

- Wait: docker container wait <name>

- Returns exit code when stopped
  MARKDOWN
  sequence_order: 20,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['containers', 'docker-wait', 'scripting', 'automation'],
  prerequisite_ids: []
)

# Exercise 20.1: Terminal
Exercise.create!(
  micro_lesson: lesson_20,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {

    validation: { must_not_include: ['Error', 'panic:'] },    timeout_sec: 60,
    require_pass: true,
    command: 'docker container wait my-container',
    description: 'Block script until container completes and get exit code',
    difficulty: 'medium',
    hints: ['Wait: docker container wait <name>', 'Returns exit code when stopped']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_20,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker container wait my-container',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# Exercise 20.2: MCQ
Exercise.create!(
  micro_lesson: lesson_20,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What does docker wait return?',
    options: ['Exit code of container', 'Container ID'],
    correct_answer: 0,
    explanation: 'docker wait blocks until container stops and returns exit code (0=success).',
    difficulty: 'medium'
  }
)

puts "✓ Created 20 microlessons for Docker Containers"
