# AUTO-GENERATED from codesprout_curriculum.rb
puts "Creating Microlessons for Networking..."

module_var = CourseModule.find_by(slug: 'networking')

# === MICROLESSON 1: Stopping Containers ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Stopping Containers',
  content: <<~MARKDOWN,
# Stopping Containers 🚀

## What is this?
A concise explanation of the concept.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 2: Removing Containers ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Removing Containers',
  content: <<~MARKDOWN,
# Removing Containers 🚀

## What is this?
A concise explanation of the concept.
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 3: Naming Your Containers ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Naming Your Containers',
  content: <<~MARKDOWN,
# Naming Your Containers 🚀

## What is this?
A concise explanation of the concept.
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 4: CodeSprout: Exposing Containers with Port Mapping ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'CodeSprout: Exposing Containers with Port Mapping',
  content: <<~MARKDOWN,
# CodeSprout: Exposing Containers with Port Mapping 🚀

**Port Mapping Challenge** 🌐

    Your team lead Sarah has a problem:

    > "We deployed our marketing site in a container, but no one can access it! The container is running
    > but when we try to visit the site, nothing loads. Can you figure out why?"

    ### The Problem
    Containers are **isolated by default**. Even if nginx is running perfectly inside the container on port 80,
    your browser on your host machine can't reach it. You need to **map** (publish) the container's port to your host.

    ### Port Mapping Explained
    Port mapping connects a port on your **host machine** to a port inside the **container**:

    ```bash
    docker run -p HOST_PORT:CONTAINER_PORT image
    ```

    - **HOST_PORT** (e.g., `8080`) → Port on your computer
    - **CONTAINER_PORT** (e.g., `80`) → Port inside the container where the app listens
    - **Format**: `-p 8080:80` means "send traffic from host port 8080 to container port 80"

    ### Visual Example
    ```
    Your Browser → http://localhost:8080 → Docker NAT → Container Port 80 → nginx
    ```

    ### The Solution
    To make the CodeSprout site accessible, we need to:
    1. Map host port `8080` to container port `80` (where nginx listens)
    2. Run in detached mode (`-d`) so the terminal isn't blocked
    3. Name it `codesprout-web` for easy reference

    ```bash
    docker run -d -p 8080:80 --name codesprout-web nginx:alpine
    ```

    After this, anyone can visit `http://localhost:8080` and see the site!

    ### Common Mistakes
    - **Swapping ports**: `-p 80:8080` would try to map your host's port 80 to container 8080 (wrong direction!)
    - **Forgetting `-p`**: Container runs but can't be accessed from outside
    - **Port conflicts**: If port 8080 is already in use, Docker will error - try a different port like 8081

## Syntax/Command

```bash
docker run -d -p 8080:80 --name codesprout-web nginx:alpine
```

## Example

```bash
docker run -d --name codesprout-web -p 8080:80 nginx:alpine
```

## Key Points

- Port mapping format: -p HOST:CONTAINER → -p 8080:80

- Remember: first number (8080) is your host, second (80) is the container

- Use -d to run in background and free your terminal
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['docker-run', 'port-mapping', 'networking', 'container-exposure', 'publishing-ports'],
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
    command: 'docker run -d -p 8080:80 --name codesprout-web nginx:alpine',
    description: 'Expose the nginx container on port 80 so it can be accessed via http://localhost:8080',
    difficulty: 'easy',
    hints: ['Port mapping format: -p HOST:CONTAINER → -p 8080:80', 'Remember: first number (8080) is your host, second (80) is the container', 'Use -d to run in background and free your terminal']
  }
)

# Exercise 4.2: MCQ
Exercise.create!(
  micro_lesson: lesson_4,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'In "docker run -p 8080:80 nginx", what does 8080 represent?',
    options: ['The port on the host machine', 'The port inside the container', 'The container ID', 'The process ID'],
    correct_answer: 0,
    explanation: 'In -p HOST:CONTAINER format, the first number (8080) is the host port, second (80) is container port',
    difficulty: 'easy'
  }
)

# === MICROLESSON 5: Run Nginx in the Background ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Run Nginx in the Background',
  content: <<~MARKDOWN,
# Run Nginx in the Background 🚀

## What is this?
A concise explanation of the concept.

## Syntax/Command

```bash
docker run -d nginx:alpine
```

## Key Points

- Use the -d flag for detached mode
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['detached-mode', 'docker-run'],
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
    command: 'docker run -d nginx:alpine',
    description: 'Practice the command: docker run -d nginx:alpine',
    difficulty: 'easy',
    hints: ['Use the -d flag for detached mode']
  }
)

# Exercise 5.2: MCQ
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What does -d do?',
    options: ['Runs in detached mode', 'Deletes the container', 'Downloads image only', 'Debug mode'],
    correct_answer: 0,
    explanation: 'Detached mode frees your terminal for other commands.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 6: Listing Containers ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Listing Containers',
  content: <<~MARKDOWN,
# Listing Containers 🚀

## What is this?
A concise explanation of the concept.

## Syntax/Command

```bash
docker ps
```

## Key Points

- Try docker ps -a to include stopped ones
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['docker-ps'],
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
    command: 'docker ps',
    description: 'Practice the command: docker ps',
    difficulty: 'easy',
    hints: ['Try docker ps -a to include stopped ones']
  }
)

# Exercise 6.2: MCQ
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which command lists all containers including stopped ones?',
    options: ['docker ps -a', 'docker list --all', 'docker containers', 'docker ps --running'],
    correct_answer: 0,
    explanation: 'Use -a to include stopped containers.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 7: Executing Commands in Containers ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'Executing Commands in Containers',
  content: <<~MARKDOWN,
# Executing Commands in Containers 🚀

## What is this?
A concise explanation of the concept.

## Syntax/Command

```bash
docker exec -it codesprout-web sh
```

## Key Points

- Use -it for interactive terminals
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['docker-exec'],
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
    command: 'docker exec -it codesprout-web sh',
    description: 'Practice the command: docker exec -it codesprout-web sh',
    difficulty: 'easy',
    hints: ['Use -it for interactive terminals']
  }
)

# Exercise 7.2: MCQ
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'What does -it stand for in docker exec?',
    options: ['Interactive + TTY', 'Internal + Test', 'Init + Terminal', 'Immediate + TTY'],
    correct_answer: 0,
    explanation: '-i keeps STDIN open; -t allocates a pseudo-TTY.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 8: Viewing Container Logs ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'Viewing Container Logs',
  content: <<~MARKDOWN,
# Viewing Container Logs 🚀

## What is this?
A concise explanation of the concept.

## Syntax/Command

```bash
docker logs codesprout-web
```

## Key Points

- Use -f to follow the logs in real-time
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['docker-logs'],
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
    command: 'docker logs codesprout-web',
    description: 'Practice the command: docker logs codesprout-web',
    difficulty: 'easy',
    hints: ['Use -f to follow the logs in real-time']
  }
)

# Exercise 8.2: MCQ
Exercise.create!(
  micro_lesson: lesson_8,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    require_pass: true,
    question: 'Which flag follows logs as they are written?',
    options: ['-f', '-t', '--tail 100', '-F'],
    correct_answer: 0,
    explanation: 'Use -f (follow) to stream logs.',
    difficulty: 'easy'
  }
)

puts "✓ Created 8 microlessons for Networking"
