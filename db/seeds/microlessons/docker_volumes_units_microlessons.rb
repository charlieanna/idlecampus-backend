# AUTO-GENERATED from docker_volumes_units.rb
puts "Creating Microlessons for Docker Volumes..."

module_var = CourseModule.find_by(slug: 'docker-volumes')

# === MICROLESSON 1: Docker Volume Create ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Volume Create',
  content: <<~MARKDOWN,
# Docker Volume Create 🚀

Create named volumes for persistent data storage

## Syntax/Command

```bash
docker volume create my-volume
```

## Example

```bash
docker volume create --driver local my-volume
```

## Key Points

- Create volume: docker volume create <name>

- Specify driver: --driver <type>

- Add labels: --label <key>=<value>
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['volumes', 'docker-volume', 'persistence', 'storage'],
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
    command: 'docker volume create my-volume',
    description: 'Create a named volume for data persistence',
    difficulty: 'easy',
    hints: ['Create volume: docker volume create <name>', 'Specify driver: --driver <type>', 'Add labels: --label <key>=<value>']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker volume create my-volume',
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
    question: 'Why use named volumes instead of bind mounts?',
    options: ['Volumes are managed by Docker and work across platforms', 'Bind mounts are slower', 'Volumes require root access', 'Bind mounts cannot be shared'],
    correct_answer: 0,
    explanation: 'Named volumes are managed by Docker, work consistently across different platforms, and can be easily backed up and migrated.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 2: Docker Volume List ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Volume List',
  content: <<~MARKDOWN,
# Docker Volume List 🚀

List all Docker volumes on the system

## Syntax/Command

```bash
docker volume ls
```

## Example

```bash
docker volume list
```

## Key Points

- List volumes: docker volume ls

- Find dangling: --filter dangling=true

- Filter by label: --filter label=<key>=<value>
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['volumes', 'docker-volume', 'listing', 'inspection'],
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
    command: 'docker volume ls',
    description: 'Display all Docker volumes on the system',
    difficulty: 'easy',
    hints: ['List volumes: docker volume ls', 'Find dangling: --filter dangling=true', 'Filter by label: --filter label=<key>=<value>']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_2,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker volume ls',
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
    question: 'What is a dangling volume?',
    options: ['A volume not attached to any container', 'A volume with corrupted data', 'A volume that is full', 'A volume without a name'],
    correct_answer: 0,
    explanation: 'Dangling volumes are volumes that are no longer referenced by any container and can be safely removed.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 3: Docker Volume Inspect ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Volume Inspect',
  content: <<~MARKDOWN,
# Docker Volume Inspect 🚀

View detailed information about a volume

## Syntax/Command

```bash
docker volume inspect my-volume
```

## Example

```bash
docker volume inspect --format="{{.Mountpoint}}" my-volume
```

## Key Points

- Inspect volume: docker volume inspect <name>

- Get mountpoint: --format="{{.Mountpoint}}"
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['volumes', 'docker-volume', 'inspection', 'debugging'],
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
    command: 'docker volume inspect my-volume',
    description: 'View volume configuration and mountpoint location',
    difficulty: 'medium',
    hints: ['Inspect volume: docker volume inspect <name>', 'Get mountpoint: --format="{{.Mountpoint}}"']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_3,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker volume inspect my-volume',
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
    question: 'Where does Docker store volume data by default?',
    options: ['/var/lib/docker/volumes/', '/docker/volumes/', '/tmp/docker/volumes/', '/opt/docker/volumes/'],
    correct_answer: 0,
    explanation: 'Docker stores volume data in /var/lib/docker/volumes/ by default on Linux systems.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 4: Docker Volume Remove ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Volume Remove',
  content: <<~MARKDOWN,
# Docker Volume Remove 🚀

Delete one or more Docker volumes

## Syntax/Command

```bash
docker volume rm my-volume
```

## Example

```bash
docker volume rm volume1 volume2 volume3
```

## Key Points

- Remove volume: docker volume rm <name>

- Remove multiple: docker volume rm <name1> <name2>

- Cannot remove if in use
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['volumes', 'docker-volume', 'cleanup', 'removal'],
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
    command: 'docker volume rm my-volume',
    description: 'Remove unused Docker volumes',
    difficulty: 'easy',
    hints: ['Remove volume: docker volume rm <name>', 'Remove multiple: docker volume rm <name1> <name2>', 'Cannot remove if in use']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_4,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker volume rm my-volume',
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
    question: 'Can you remove a volume that is currently mounted to a container?',
    options: ['No, must remove/stop container first', 'Yes, container will auto-recreate it', 'Yes, with -f flag', 'Only if container is stopped'],
    correct_answer: 0,
    explanation: 'Docker will not remove a volume that is mounted to a running or stopped container. The container must be removed first.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 5: Docker Volume Prune ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Volume Prune',
  content: <<~MARKDOWN,
# Docker Volume Prune 🚀

Remove all unused volumes in one command

## Syntax/Command

```bash
docker volume prune
```

## Example

```bash
docker volume prune -f
```

## Key Points

- Prune volumes: docker volume prune

- Skip confirmation: -f flag

- Filter by label: --filter label=<key>=<value>
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['volumes', 'docker-volume', 'cleanup', 'prune', 'maintenance'],
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
    command: 'docker volume prune',
    description: 'Remove all unused volumes to reclaim disk space',
    difficulty: 'easy',
    hints: ['Prune volumes: docker volume prune', 'Skip confirmation: -f flag', 'Filter by label: --filter label=<key>=<value>']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker volume prune',
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
    question: 'What volumes does docker volume prune remove?',
    options: ['Only volumes not referenced by any container', 'All anonymous volumes', 'All named volumes', 'Volumes older than 24 hours'],
    correct_answer: 0,
    explanation: 'docker volume prune only removes volumes that are not currently mounted to any container (dangling volumes).',
    difficulty: 'easy'
  }
)

# === MICROLESSON 6: Docker Run with Volumes ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Run with Volumes',
  content: <<~MARKDOWN,
# Docker Run with Volumes 🚀

Mount volumes to containers for persistent data

## Syntax/Command

```bash
docker run -v my-volume:/data nginx
```

## Example

```bash
docker run -v my-volume:/app/data:ro nginx
```

## Key Points

- Mount volume: -v <volume>:<container-path>

- Read-only: -v <volume>:<path>:ro

- New syntax: --mount source=<vol>,target=<path>
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
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
    command: 'docker run -v my-volume:/data nginx',
    description: 'Mount a volume to a container for data persistence',
    difficulty: 'medium',
    hints: ['Mount volume: -v <volume>:<container-path>', 'Read-only: -v <volume>:<path>:ro', 'New syntax: --mount source=<vol>,target=<path>']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker run -v my-volume:/data nginx',
    validation: { must_not_include: ['Error', 'panic:'] },
    timeout_sec: 60,
    require_pass: true,
    hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
  }
)


# === MICROLESSON 7: Bind Mounts vs Volumes ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'Bind Mounts vs Volumes',
  content: <<~MARKDOWN,
# Bind Mounts vs Volumes 🚀

Understand the differences between bind mounts and volumes

## Syntax/Command

```bash
docker run -v /host/path:/container/path nginx
```

## Example

```bash
docker run -v $(pwd):/app nginx
```

## Key Points

- Bind mount: -v /absolute/host/path:/container/path

- Current dir: -v $(pwd):/app

- Explicit: --mount type=bind,source=...,target=...
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['volumes', 'bind-mounts', 'comparison', 'best-practices'],
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
    command: 'docker run -v /host/path:/container/path nginx',
    description: 'Understand when to use bind mounts vs volumes',
    difficulty: 'medium',
    hints: ['Bind mount: -v /absolute/host/path:/container/path', 'Current dir: -v $(pwd):/app', 'Explicit: --mount type=bind,source=...,target=...']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker run -v /host/path:/container/path nginx',
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
    question: 'When should you use bind mounts instead of volumes?',
    options: ['During development to sync code changes', 'For production databases', 'For better performance', 'For cross-platform compatibility'],
    correct_answer: 0,
    explanation: 'Bind mounts are ideal for development when you want file changes to immediately reflect in containers. Volumes are better for production data.',
    difficulty: 'medium'
  }
)

puts "✓ Created 7 microlessons for Docker Volumes"
