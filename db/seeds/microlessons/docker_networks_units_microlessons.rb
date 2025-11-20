# AUTO-GENERATED from docker_networks_units.rb
puts "Creating Microlessons for Docker Networks..."

module_var = CourseModule.find_by(slug: 'docker-networks')

# === MICROLESSON 1: Docker Network Create ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Network Create',
  content: <<~MARKDOWN,
# Docker Network Create 🚀

Create custom Docker networks for container communication

## Syntax/Command

```bash
docker network create my-network
```

## Example

```bash
docker network create --driver bridge my-network
```

## Key Points

- Create network: docker network create <name>

- Specify driver: --driver bridge

- Set subnet: --subnet <cidr>
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['networking', 'docker-network', 'bridge', 'isolation'],
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
    command: 'docker network create my-network',
    description: 'Create a custom bridge network for service isolation',
    difficulty: 'medium',
    hints: ['Create network: docker network create <name>', 'Specify driver: --driver bridge', 'Set subnet: --subnet <cidr>']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker network create my-network',
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
    question: 'What is the default network driver in Docker?',
    options: ['bridge', 'host', 'overlay', 'macvlan'],
    correct_answer: 0,
    explanation: 'The bridge driver is the default network driver. If you don\',
    difficulty: 'medium'
  }
)

# === MICROLESSON 2: Docker Network List ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Network List',
  content: <<~MARKDOWN,
# Docker Network List 🚀

List all Docker networks on the system

## Syntax/Command

```bash
docker network ls
```

## Example

```bash
docker network list
```

## Key Points

- List networks: docker network ls

- Filter by driver: --filter driver=<type>
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['networking', 'docker-network', 'listing', 'inspection'],
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
    command: 'docker network ls',
    description: 'Display all available Docker networks',
    difficulty: 'easy',
    hints: ['List networks: docker network ls', 'Filter by driver: --filter driver=<type>']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_2,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker network ls',
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
    question: 'Which default networks are created by Docker?',
    options: ['bridge, host, none', 'default, public, private', 'bridge, overlay', 'nat, bridge'],
    correct_answer: 0,
    explanation: 'Docker creates three default networks: bridge (default for containers), host (no isolation), and none (no networking).',
    difficulty: 'easy'
  }
)

# === MICROLESSON 3: Docker Network Inspect ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Network Inspect',
  content: <<~MARKDOWN,
# Docker Network Inspect 🚀

View detailed network configuration and connected containers

## Syntax/Command

```bash
docker network inspect my-network
```

## Example

```bash
docker network inspect --format="{{.IPAM.Config}}" my-network
```

## Key Points

- Inspect network: docker network inspect <name>

- Format output: --format="{{.Field}}"
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['networking', 'docker-network', 'inspection', 'debugging'],
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
    command: 'docker network inspect my-network',
    description: 'View network configuration and connected containers',
    difficulty: 'medium',
    hints: ['Inspect network: docker network inspect <name>', 'Format output: --format="{{.Field}}"']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_3,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker network inspect my-network',
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
    question: 'What information does docker network inspect provide?',
    options: ['Network configuration, subnet, and connected containers', 'Only container names', 'Only IP addresses', 'Only network driver'],
    correct_answer: 0,
    explanation: 'docker network inspect shows complete network details including subnet, gateway, connected containers, and their IP addresses.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 4: Docker Network Connect ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Network Connect',
  content: <<~MARKDOWN,
# Docker Network Connect 🚀

Connect a running container to a network

## Syntax/Command

```bash
docker network connect my-network my-container
```

## Example

```bash
docker network connect --ip 172.18.0.22 my-network my-container
```

## Key Points

- Connect container: docker network connect <network> <container>

- Assign IP: --ip <address>

- Add alias: --alias <name>
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['networking', 'docker-network', 'connect', 'multi-network'],
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
    command: 'docker network connect my-network my-container',
    description: 'Connect a running container to a custom network',
    difficulty: 'medium',
    hints: ['Connect container: docker network connect <network> <container>', 'Assign IP: --ip <address>', 'Add alias: --alias <name>']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_4,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker network connect my-network my-container',
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
    question: 'Can a container be connected to multiple networks?',
    options: ['Yes, containers can join multiple networks', 'No, only one network per container', 'Only in swarm mode', 'Only with overlay networks'],
    correct_answer: 0,
    explanation: 'Containers can be connected to multiple networks simultaneously, allowing flexible network topologies.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 5: Docker Network Disconnect ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Network Disconnect',
  content: <<~MARKDOWN,
# Docker Network Disconnect 🚀

Disconnect a container from a network

## Syntax/Command

```bash
docker network disconnect my-network my-container
```

## Example

```bash
docker network disconnect -f my-network my-container
```

## Key Points

- Disconnect: docker network disconnect <network> <container>

- Force disconnect: -f flag
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['networking', 'docker-network', 'disconnect', 'isolation'],
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
    command: 'docker network disconnect my-network my-container',
    description: 'Disconnect a container from a specific network',
    difficulty: 'medium',
    hints: ['Disconnect: docker network disconnect <network> <container>', 'Force disconnect: -f flag']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker network disconnect my-network my-container',
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
    question: 'What happens when you disconnect a container from its only network?',
    options: ['Container loses all network connectivity', 'Container is automatically stopped', 'Container joins the bridge network', 'Operation fails'],
    correct_answer: 0,
    explanation: 'Disconnecting a container from its only network leaves it without any network connectivity until connected to another network.',
    difficulty: 'medium'
  }
)

# === MICROLESSON 6: Docker Network Remove ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Network Remove',
  content: <<~MARKDOWN,
# Docker Network Remove 🚀

Delete one or more Docker networks

## Syntax/Command

```bash
docker network rm my-network
```

## Example

```bash
docker network rm network1 network2 network3
```

## Key Points

- Remove network: docker network rm <name>

- Remove multiple: docker network rm <name1> <name2>

- Remove unused: docker network prune
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['networking', 'docker-network', 'cleanup', 'removal'],
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
    command: 'docker network rm my-network',
    description: 'Remove a Docker network that is no longer needed',
    difficulty: 'easy',
    hints: ['Remove network: docker network rm <name>', 'Remove multiple: docker network rm <name1> <name2>', 'Remove unused: docker network prune']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker network rm my-network',
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
    question: 'Can you remove a network with containers still connected?',
    options: ['No, must disconnect all containers first', 'Yes, containers auto-disconnect', 'Yes, with -f flag', 'Only if containers are stopped'],
    correct_answer: 0,
    explanation: 'Docker will not remove a network that has active container connections. All containers must be disconnected or removed first.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 7: Docker Network Prune ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'Docker Network Prune',
  content: <<~MARKDOWN,
# Docker Network Prune 🚀

Remove all unused Docker networks in one command

## Syntax/Command

```bash
docker network prune
```

## Example

```bash
docker network prune -f
```

## Key Points

- Prune networks: docker network prune

- Skip confirmation: -f flag

- Filter by age: --filter until=<time>
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['networking', 'docker-network', 'cleanup', 'prune', 'maintenance'],
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
    command: 'docker network prune',
    description: 'Remove all unused networks to reclaim resources',
    difficulty: 'easy',
    hints: ['Prune networks: docker network prune', 'Skip confirmation: -f flag', 'Filter by age: --filter until=<time>']
  }
)
# Sandbox: auto-added from terminal exercise
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'sandbox',
  sequence_order: 99,
  exercise_data: {
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'docker network prune',
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
    question: 'What does docker network prune remove?',
    options: ['Only networks not used by any container', 'All custom networks', 'All networks including defaults', 'Only networks older than 1 day'],
    correct_answer: 0,
    explanation: 'docker network prune only removes networks that are not currently connected to any container. Default networks and active networks are preserved.',
    difficulty: 'easy'
  }
)

puts "✓ Created 7 microlessons for Docker Networks"
