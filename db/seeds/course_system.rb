# Course System Seed Data
puts "🌱 Seeding Course System..."

# Ensure models are loaded
require_relative '../../app/models/achievement'
require_relative '../../app/models/user_achievement'
require_relative '../../app/models/lesson'

# Clear existing data (be careful in production!)
CourseAchievement.destroy_all
UserCourseAchievement.destroy_all
QuizAttempt.destroy_all
ModuleProgress.destroy_all
CourseEnrollment.destroy_all
QuizQuestion.destroy_all
Quiz.destroy_all
ModuleItem.destroy_all
CourseLesson.destroy_all
CourseModule.destroy_all
Course.destroy_all
UserStat.destroy_all

puts "✅ Cleared existing course data"

# ========================================
# COURSE 1: Docker Fundamentals
# ========================================

docker_course = Course.create!(
  title: "Docker Fundamentals",
  slug: "docker-fundamentals",
  description: "Master Docker from basics to production deployment. Build, ship, and run containerized applications with confidence.",
  difficulty_level: "beginner",
  estimated_hours: 20,
  certification_track: "dca",
  published: true,
  sequence_order: 1,
  learning_objectives: JSON.generate([
    "Understand container concepts and Docker architecture",
    "Build and manage Docker images effectively",
    "Configure Docker networking and storage",
    "Deploy multi-container applications with Docker Compose",
    "Implement best practices for production deployments"
  ]),
  prerequisites: JSON.generate([
    "Linux Fundamentals course (recommended)",
    "Understanding of software development concepts"
  ])
)

puts "📦 Created course: #{docker_course.title}"

# Module 1: Container Basics
module1 = docker_course.course_modules.create!(
  title: "Container Basics",
  slug: "container-basics",
  description: "Introduction to containerization and Docker fundamentals",
  sequence_order: 1,
  estimated_minutes: 120,
  published: true,
  learning_objectives: JSON.generate([
    "Understand what containers are and why they matter",
    "Learn Docker architecture and components",
    "Run your first containers"
  ])
)

# Module 1 Lesson 1
lesson1_1 = CourseLesson.create!(
  title: "What are Containers?",
  content: <<~MARKDOWN,
    # What are Containers?

    Containers are lightweight, standalone, executable packages that include everything needed to run a piece of software: code, runtime, system tools, libraries, and settings.

    ## Key Concepts

    ### Containers vs Virtual Machines
    - **Containers** share the host OS kernel, making them lightweight and fast
    - **Virtual Machines** include a full OS, making them heavier but more isolated

    ### Why Containers?
    1. **Consistency**: Same environment from dev to production
    2. **Isolation**: Applications don't interfere with each other
    3. **Portability**: Run anywhere Docker is installed
    4. **Efficiency**: Lightweight and fast to start

    ## Docker Architecture

    Docker uses a client-server architecture:
    - **Docker Client**: CLI tool you use to interact with Docker
    - **Docker Daemon**: Background service that manages containers
    - **Docker Registry**: Storage for Docker images (e.g., Docker Hub)

    ### Key Components
    ```
    docker run hello-world
    ```

    This simple command demonstrates the entire Docker workflow:
    1. Client sends command to daemon
    2. Daemon checks for image locally
    3. If not found, pulls from registry
    4. Creates container from image
    5. Runs the container
  MARKDOWN
  video_url: nil,
  reading_time_minutes: 15,
  key_concepts: JSON.generate([
    "Containers vs VMs",
    "Docker architecture",
    "Images and containers",
    "Docker Hub registry"
  ])
)

module1.module_items.create!(
  item: lesson1_1,
  sequence_order: 1,
  required: true
)

# Module 1 Quiz
quiz1 = Quiz.create!(
  title: "Container Basics Quiz",
  description: "Test your understanding of container fundamentals",
  time_limit_minutes: 15,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true
)

# Quiz Questions for Module 1
[
  {
    question_type: "mcq",
    question_text: "What is the main difference between containers and virtual machines?",
    options: JSON.generate([
      { text: "Containers share the host OS kernel while VMs have their own OS", correct: true },
      { text: "Containers are slower than VMs", correct: false },
      { text: "VMs are more portable than containers", correct: false },
      { text: "Containers require more resources than VMs", correct: false }
    ]),
    explanation: "Containers share the host operating system's kernel, making them lightweight and fast. VMs include a complete operating system, making them heavier but more isolated.",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 1
  },
  {
    question_type: "mcq",
    question_text: "Which Docker component is responsible for managing containers?",
    options: JSON.generate([
      { text: "Docker Client", correct: false },
      { text: "Docker Daemon", correct: true },
      { text: "Docker Registry", correct: false },
      { text: "Docker Image", correct: false }
    ]),
    explanation: "The Docker Daemon (dockerd) is the background service that manages containers, images, networks, and volumes.",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 2
  },
  {
    question_type: "command",
    question_text: "What command would you use to run a container from the 'nginx' image?",
    correct_answer: "docker run nginx|docker container run nginx",
    explanation: "The 'docker run' command (or 'docker container run') creates and starts a container from an image. For nginx: docker run nginx",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 3
  },
  {
    question_type: "true_false",
    question_text: "Docker images are stored in a Docker Registry like Docker Hub.",
    correct_answer: "true",
    explanation: "Docker images are stored in registries. Docker Hub is the default public registry, but you can also use private registries.",
    points: 5,
    difficulty_level: "easy",
    sequence_order: 4
  },
  {
    question_type: "fill_blank",
    question_text: "A Docker _____ is a lightweight, standalone executable package that includes everything needed to run software.",
    correct_answer: "container",
    explanation: "A container is the runtime instance that packages application code with all dependencies.",
    points: 5,
    difficulty_level: "easy",
    sequence_order: 5
  }
].each do |q_data|
  quiz1.quiz_questions.create!(q_data)
end

module1.module_items.create!(
  item: quiz1,
  sequence_order: 2,
  required: true
)

# Link existing labs to Module 1 (if they exist)
first_container_titles = [
  "Your First Container - Run and Explore",
  "Docker Basics - First Container"
]

first_container_lab = HandsOnLab.where(title: first_container_titles).first
if first_container_lab
  module1.module_items.create!(
    item: first_container_lab,
    sequence_order: 3,
    required: true
  )
  puts "  ✅ Linked lab: #{first_container_lab.title}"
end

puts "  ✅ Created module: #{module1.title} (#{module1.module_items.count} items)"

# Module 2: Images and Dockerfiles
module2 = docker_course.course_modules.create!(
  title: "Images and Dockerfiles",
  slug: "images-dockerfiles",
  description: "Learn to build and manage Docker images",
  sequence_order: 2,
  estimated_minutes: 180,
  published: true,
  learning_objectives: JSON.generate([
    "Understand Docker image layers",
    "Write efficient Dockerfiles",
    "Build and tag images",
    "Optimize image size"
  ])
)

lesson2_1 = CourseLesson.create!(
  title: "Understanding Docker Images",
  content: <<~MARKDOWN,
    # Understanding Docker Images

    Docker images are the blueprints for containers. They contain everything needed to run an application.

    ## Image Layers

    Images are built in layers, with each layer representing a filesystem change:
    - **Base layer**: Usually an OS like Ubuntu or Alpine
    - **Application layers**: Your code and dependencies
    - **Each layer is cached**: Makes rebuilds faster

    ## Dockerfile Basics

    A Dockerfile is a text file with instructions to build an image:

    ```dockerfile
    FROM node:18-alpine
    WORKDIR /app
    COPY package.json .
    RUN npm install
    COPY . .
    CMD ["node", "server.js"]
    ```

    ### Key Instructions
    - `FROM`: Base image
    - `WORKDIR`: Set working directory
    - `COPY`: Copy files into image
    - `RUN`: Execute commands
    - `CMD`: Default command to run
    - `EXPOSE`: Document ports

    ## Building Images

    ```bash
    # Build an image
    docker build -t myapp:v1 .
    
    # List images
    docker images
    
    # Tag an image
    docker tag myapp:v1 myapp:latest
    ```

    ## Best Practices
    1. Use specific base image tags
    2. Order instructions from least to most frequently changed
    3. Use .dockerignore to exclude files
    4. Minimize layer count
    5. Use multi-stage builds for production
  MARKDOWN
  reading_time_minutes: 20
)

module2.module_items.create!(item: lesson2_1, sequence_order: 1, required: true)

quiz2 = Quiz.create!(
  title: "Images and Dockerfiles Quiz",
  description: "Test your knowledge of Docker images",
  time_limit_minutes: 20,
  passing_score: 70,
  max_attempts: 3
)

[
  {
    question_type: "mcq",
    question_text: "What Dockerfile instruction sets the base image?",
    options: JSON.generate([
      { text: "BASE", correct: false },
      { text: "FROM", correct: true },
      { text: "IMAGE", correct: false },
      { text: "PULL", correct: false }
    ]),
    explanation: "The FROM instruction sets the base image for subsequent instructions. It's usually the first instruction in a Dockerfile.",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 1
  },
  {
    question_type: "command",
    question_text: "What command builds a Docker image tagged as 'myapp:v1' from the current directory?",
    correct_answer: "docker build -t myapp:v1 .|docker image build -t myapp:v1 .",
    explanation: "The 'docker build -t myapp:v1 .' command builds an image from the Dockerfile in the current directory (.) and tags it as myapp:v1",
    points: 15,
    difficulty_level: "medium",
    sequence_order: 2
  }
].each { |q| quiz2.quiz_questions.create!(q) }

module2.module_items.create!(item: quiz2, sequence_order: 2, required: true)

puts "  ✅ Created module: #{module2.title}"

# ========================================
# Module 3: Networking & Ports
# ========================================

module3 = docker_course.course_modules.create!(
  title: "Networking & Ports",
  slug: "networking-and-ports",
  description: "Expose services, understand bridge networks, and container DNS",
  sequence_order: 3,
  estimated_minutes: 180,
  published: true,
  learning_objectives: JSON.generate([
    "Publish container ports and verify connectivity",
    "Use user-defined bridge networks and container DNS",
    "Understand host vs. bridge networking modes"
  ])
)

lesson3_1 = CourseLesson.create!(
  title: "Docker Networking Fundamentals",
  content: <<~MARKDOWN,
    # Docker Networking Fundamentals

    Docker uses different network drivers to connect containers.

    ## Common Drivers
    - bridge (default): isolates containers on the host; supports DNS
    - host: shares the host network namespace (no port mapping)
    - none: disables networking

    ## Port Publishing
    - `-p HOST:CONTAINER` maps a host port to a container port
    - Verify with `docker port <container>` and `curl`

    ## User-Defined Bridge Networks
    - Provide built-in DNS: containers can reach peers by name
    - Example:
    ```bash
    docker network create appnet
    docker run -d --name api --network appnet nginx
    docker run -it --rm --network appnet alpine sh -c 'apk add --no-cache curl; curl http://api'
    ```
  MARKDOWN
  reading_time_minutes: 20
)

module3.module_items.create!(item: lesson3_1, sequence_order: 1, required: true)

quiz3 = Quiz.create!(
  title: "Networking & Ports Quiz",
  description: "Check your knowledge of port mapping and networks",
  time_limit_minutes: 15,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true
)

[
  {
    question_type: "mcq",
    question_text: "Which network mode removes the need for -p when exposing ports?",
    options: JSON.generate([
      { text: "bridge", correct: false },
      { text: "host", correct: true },
      { text: "none", correct: false },
      { text: "overlay", correct: false }
    ]),
    explanation: "Host network shares the host's network namespace; no port mapping is needed.",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 1
  },
  {
    question_type: "command",
    question_text: "Map host port 8080 to container port 80 for nginx",
    correct_answer: "docker run -d -p 8080:80 nginx|docker container run -d -p 8080:80 nginx",
    explanation: "Use -p HOST:CONTAINER to publish ports.",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 2
  },
  {
    question_type: "true_false",
    question_text: "User-defined bridge networks provide built-in DNS by container name.",
    correct_answer: "true",
    explanation: "User-defined bridges include DNS-based service discovery.",
    points: 5,
    difficulty_level: "easy",
    sequence_order: 3
  }
].each { |q| quiz3.quiz_questions.create!(q) }

module3.module_items.create!(item: quiz3, sequence_order: 2, required: true)

if (lab = HandsOnLab.find_by(title: "Port Mapping and Network Access"))
  module3.module_items.create!(item: lab, sequence_order: 3, required: true)
  puts "  ✅ Linked lab: #{lab.title}"
end

puts "  ✅ Created module: #{module3.title}"

# ========================================
# Module 4: Volumes & Storage
# ========================================

module4 = docker_course.course_modules.create!(
  title: "Volumes & Storage",
  slug: "volumes-and-storage",
  description: "Persist data using volumes and bind mounts",
  sequence_order: 4,
  estimated_minutes: 180,
  published: true,
  learning_objectives: JSON.generate([
    "Compare volumes and bind mounts",
    "Create, inspect, and use named volumes",
    "Persist and share data across containers"
  ])
)

lesson4_1 = CourseLesson.create!(
  title: "Data Persistence with Volumes",
  content: <<~MARKDOWN,
    # Data Persistence with Volumes

    Volumes are the preferred mechanism for persisting data in Docker.

    ## Types
    - Named volumes: managed by Docker (`docker volume create`)
    - Bind mounts: map host paths into containers

    ## Examples
    ```bash
    docker volume create appdata
    docker run -d -v appdata:/var/lib/app --name app busybox tail -f /dev/null
    docker run --rm -v appdata:/data busybox ls -l /data
    ```
  MARKDOWN
  reading_time_minutes: 15
)

module4.module_items.create!(item: lesson4_1, sequence_order: 1, required: true)

quiz4 = Quiz.create!(
  title: "Volumes & Storage Quiz",
  description: "Volumes, bind mounts, and persistence",
  time_limit_minutes: 15,
  passing_score: 70,
  max_attempts: 3
)

[
  {
    question_type: "mcq",
    question_text: "Which is managed by Docker and not tied to a host path?",
    options: JSON.generate([
      { text: "Bind mount", correct: false },
      { text: "Named volume", correct: true },
      { text: "Tmpfs mount", correct: false },
      { text: "Overlay mount", correct: false }
    ]),
    explanation: "Named volumes are managed by Docker and portable across hosts (with caveats).",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 1
  },
  {
    question_type: "command",
    question_text: "Create a named volume called 'appdata'",
    correct_answer: "docker volume create appdata",
    explanation: "Use docker volume create <name> to create a named volume.",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 2
  }
].each { |q| quiz4.quiz_questions.create!(q) }

module4.module_items.create!(item: quiz4, sequence_order: 2, required: true)

if (lab = HandsOnLab.find_by(title: "Volume Mounting - Data Persistence"))
  module4.module_items.create!(item: lab, sequence_order: 3, required: true)
  puts "  ✅ Linked lab: #{lab.title}"
end

puts "  ✅ Created module: #{module4.title}"

# ========================================
# Module 5: Docker Compose
# ========================================

module5 = docker_course.course_modules.create!(
  title: "Docker Compose",
  slug: "docker-compose",
  description: "Define and run multi-container apps with Compose",
  sequence_order: 5,
  estimated_minutes: 180,
  published: true
)

lesson5_1 = CourseLesson.create!(
  title: "Compose Basics",
  content: <<~MARKDOWN,
    # Docker Compose Basics

    Compose uses a YAML file to define services, networks, and volumes.

    ```yaml
    version: '3.9'
    services:
      web:
        image: nginx
        ports: ["8080:80"]
      redis:
        image: redis:alpine
    ```

    Commands:
    - `docker compose up -d`
    - `docker compose ps`
    - `docker compose logs -f`
  MARKDOWN
  reading_time_minutes: 15
)

module5.module_items.create!(item: lesson5_1, sequence_order: 1, required: true)

quiz5 = Quiz.create!(
  title: "Docker Compose Quiz",
  description: "Compose files, commands, and lifecycle",
  time_limit_minutes: 15,
  passing_score: 70,
  max_attempts: 3
)

[
  {
    question_type: "mcq",
    question_text: "Which command starts services in detached mode?",
    options: JSON.generate([
      { text: "docker compose start -d", correct: false },
      { text: "docker compose up -d", correct: true },
      { text: "docker compose run -d", correct: false },
      { text: "docker compose build -d", correct: false }
    ]),
    explanation: "Use up -d to create and start containers in background.",
    points: 10,
    difficulty_level: "easy",
    sequence_order: 1
  }
].each { |q| quiz5.quiz_questions.create!(q) }

module5.module_items.create!(item: quiz5, sequence_order: 2, required: true)

if (lab = HandsOnLab.find_by(title: "Docker Compose - Multi-Container Application"))
  module5.module_items.create!(item: lab, sequence_order: 3, required: true)
  puts "  ✅ Linked lab: #{lab.title}"
end

puts "  ✅ Created module: #{module5.title}"

# ========================================
# Module 6: Security & Best Practices
# ========================================

module6 = docker_course.course_modules.create!(
  title: "Security & Best Practices",
  slug: "security-best-practices",
  description: "Run as non-root, minimize surface, healthchecks",
  sequence_order: 6,
  estimated_minutes: 180,
  published: true
)

lesson6_1 = CourseLesson.create!(
  title: "Container Security Basics",
  content: <<~MARKDOWN,
    # Container Security Basics

    - Prefer non-root users in images (USER)
    - Add HEALTHCHECK to detect failure conditions
    - Limit capabilities and make FS read-only when possible
    - Scan images for vulnerabilities
  MARKDOWN
  reading_time_minutes: 10
)

module6.module_items.create!(item: lesson6_1, sequence_order: 1, required: true)

quiz6 = Quiz.create!(
  title: "Security Quiz",
  description: "Secure-by-default image and runtime settings",
  time_limit_minutes: 15,
  passing_score: 70,
  max_attempts: 3
)

[
  {
    question_type: "true_false",
    question_text: "Running as root inside containers is recommended for production.",
    correct_answer: "false",
    explanation: "Use a non-root USER and least privilege.",
    points: 5,
    difficulty_level: "easy",
    sequence_order: 1
  }
].each { |q| quiz6.quiz_questions.create!(q) }

module6.module_items.create!(item: quiz6, sequence_order: 2, required: true)

if (lab = HandsOnLab.find_by(title: "Docker Security - Non-Root User and Read-Only"))
  module6.module_items.create!(item: lab, sequence_order: 3, required: true)
  puts "  ✅ Linked lab: #{lab.title}"
end

if (lab = HandsOnLab.find_by(title: "Troubleshooting Docker Containers"))
  module6.module_items.create!(item: lab, sequence_order: 4, required: false)
  puts "  ✅ Linked lab: #{lab.title}"
end

puts "  ✅ Created module: #{module6.title}"

# ========================================
# Module 7: Registries & CI/CD
# ========================================

module7 = docker_course.course_modules.create!(
  title: "Registries & CI/CD",
  slug: "registries-ci-cd",
  description: "Push, pull, tag, and automate",
  sequence_order: 7,
  estimated_minutes: 120,
  published: true
)

lesson7_1 = CourseLesson.create!(
  title: "Using Docker Registries",
  content: <<~MARKDOWN,
    # Using Docker Registries

    - docker login / logout
    - docker tag (image:tag) and naming conventions
    - docker push / pull
    - Immutable tags in CI/CD and content trust overview
  MARKDOWN
  reading_time_minutes: 10
)

module7.module_items.create!(item: lesson7_1, sequence_order: 1, required: true)

quiz7 = Quiz.create!(
  title: "Registries Quiz",
  description: "Tags, authentication, and push/pull",
  time_limit_minutes: 10,
  passing_score: 70,
  max_attempts: 3
)

[
  {
    question_type: "command",
    question_text: "Tag local image myapp:latest for registry example.com/team/myapp:v1",
    correct_answer: "docker tag myapp:latest example.com/team/myapp:v1",
    explanation: "Tag must include registry/namespace/name:tag",
    points: 10,
    difficulty_level: "medium",
    sequence_order: 1
  }
].each { |q| quiz7.quiz_questions.create!(q) }

module7.module_items.create!(item: quiz7, sequence_order: 2, required: true)

if (lab = HandsOnLab.find_by(title: "Docker Registry - Push and Pull Custom Images"))
  module7.module_items.create!(item: lab, sequence_order: 3, required: true)
  puts "  ✅ Linked lab: #{lab.title}"
end

puts "  ✅ Created module: #{module7.title}"

# ========================================
# Module 8: Exam Readiness (Mock Exam)
# ========================================

module8 = docker_course.course_modules.create!(
  title: "Docker → Kubernetes Bridge I",
  slug: "exam-readiness-dca-mock-1",
  description: "Map Docker to Kubernetes: Pods, images, YAML, basic kubectl",
  sequence_order: 8,
  estimated_minutes: 90,
  published: true
)

mock1 = Quiz.create!(
  title: "Bridge I Knowledge Check",
  description: "Quick knowledge check to reinforce Docker→K8s mappings",
  time_limit_minutes: 20,
  passing_score: 70,
  max_attempts: 3,
  shuffle_questions: true,
  show_correct_answers: true
)

mock_questions = [
  { question_type: "mcq", question_text: "Which command lists dangling images?", options: JSON.generate([
      { text: "docker images -f dangling=true", correct: true },
      { text: "docker image prune -a", correct: false },
      { text: "docker ps -a", correct: false },
      { text: "docker system df", correct: false }
    ]), explanation: "Use filter dangling=true with docker images.", points: 8, difficulty_level: "medium" },
  { question_type: "command", question_text: "Limit container to 512MB memory and 1 CPU", correct_answer: "docker run -m 512m --cpus 1 nginx|docker container run -m 512m --cpus 1 nginx", explanation: "Use -m and --cpus to set resource limits.", points: 10, difficulty_level: "medium" },
  { question_type: "mcq", question_text: "Preferable base for minimal images?", options: JSON.generate([
      { text: "alpine", correct: true }, { text: "ubuntu:latest", correct: false }, { text: "debian", correct: false }, { text: "centos", correct: false }
    ]), explanation: "Alpine is commonly used for minimal images.", points: 6, difficulty_level: "easy" },
  { question_type: "true_false", question_text: "HEALTHCHECK helps detect app failures.", correct_answer: "true", explanation: "It lets orchestrators restart unhealthy containers.", points: 5, difficulty_level: "easy" },
  { question_type: "mcq", question_text: "How to share data between two containers across restarts?", options: JSON.generate([
      { text: "Bind mount a host path", correct: false },
      { text: "Named volume attached to both", correct: true },
      { text: "Copy files into both images", correct: false },
      { text: "Use tmpfs", correct: false }
    ]), explanation: "Named volumes persist and can be mounted by multiple containers.", points: 8, difficulty_level: "medium" },
  { question_type: "command", question_text: "Create a user-defined bridge called appnet", correct_answer: "docker network create appnet", explanation: "docker network create <name>.", points: 6, difficulty_level: "easy" },
  { question_type: "mcq", question_text: "Which Compose key defines a healthcheck?", options: JSON.generate([
      { text: "healthcheck", correct: true }, { text: "probe", correct: false }, { text: "check", correct: false }, { text: "status", correct: false }
    ]), explanation: "Compose supports healthcheck under a service.", points: 6, difficulty_level: "medium" },
  { question_type: "command", question_text: "Push image example.com/acme/api:v2", correct_answer: "docker push example.com/acme/api:v2", explanation: "Requires prior docker login.", points: 6, difficulty_level: "easy" },
  { question_type: "mcq", question_text: "Which flag makes root FS read-only?", options: JSON.generate([
      { text: "--read-only", correct: true }, { text: "--immutable", correct: false }, { text: "--no-write", correct: false }, { text: "--secure", correct: false }
    ]), explanation: "--read-only sets the container root FS to read-only.", points: 8, difficulty_level: "medium" },
  { question_type: "true_false", question_text: "host network provides container-name DNS", correct_answer: "false", explanation: "DNS-based discovery is for user-defined bridge and overlay.", points: 5, difficulty_level: "medium" }
]

mock_questions.each_with_index do |q, i|
  mock1.quiz_questions.create!(
    q.merge(sequence_order: i + 1)
  )
end

module8.module_items.create!(item: mock1, sequence_order: 1, required: true)

puts "  ✅ Created module: #{module8.title}"

# ========================================
# Module 9: Docker → Kubernetes Bridge II
# ========================================

module9 = docker_course.course_modules.find_or_create_by!(slug: 'dca-practice-bank') do |mod|
  mod.title = 'Docker → Kubernetes Bridge II'
  mod.description = 'Networking, storage, ConfigMaps and Secrets mapping with short checks'
  mod.sequence_order = 9
  mod.estimated_minutes = 120
  mod.published = true
end

dca_bank = Quiz.find_or_create_by!(title: 'Bridge II Knowledge Check') do |quiz|
  quiz.description = 'Quick checks for Services/DNS, PV/PVC, ConfigMaps & Secrets'
  quiz.time_limit_minutes = 0 # untimed practice
  quiz.passing_score = 0
  quiz.max_attempts = 0
  quiz.shuffle_questions = true
  quiz.show_correct_answers = true
end

# Base templates to expand to 120+ variants
dca_base = [
  { type: 'mcq', text: 'Which command tags an existing image?', options: [
      { text: 'docker tag', correct: true },
      { text: 'docker label', correct: false },
      { text: 'docker rename', correct: false },
      { text: 'docker copy', correct: false }
    ], explanation: 'Use docker tag SOURCE[:TAG] TARGET[:TAG] to add a new tag.' },
  { type: 'command', text: 'Run nginx mapping host 8080 to container 80', answer: 'docker run -d -p 8080:80 nginx', explanation: 'Use -p HOST:CONTAINER for port publishing.' },
  { type: 'true_false', text: 'Multi-stage builds can reduce final image size.', answer: 'true', explanation: 'Copy only required artefacts from builder stage.' },
  { type: 'mcq', text: 'Preferred storage mechanism for persistent data?', options: [
      { text: 'Named volume', correct: true },
      { text: 'Layer changes', correct: false },
      { text: 'Tmpfs only', correct: false },
      { text: 'Editing container root FS', correct: false }
    ], explanation: 'Use named volumes or bind mounts for persistence.' },
  { type: 'command', text: 'Create a named volume appdata', answer: 'docker volume create appdata', explanation: 'docker volume create <name>.' },
  { type: 'true_false', text: 'User-defined bridges provide container-name DNS.', answer: 'true', explanation: 'Built-in DNS is available on user-defined bridges.' },
  { type: 'mcq', text: 'Which Compose command starts services in detached mode?', options: [
      { text: 'docker compose up -d', correct: true },
      { text: 'docker compose run -d', correct: false },
      { text: 'docker compose build -d', correct: false },
      { text: 'docker compose start -d', correct: false }
    ], explanation: 'Use up -d to create and start in background.' },
  { type: 'mcq', text: 'Which flag makes root filesystem read-only?', options: [
      { text: '--read-only', correct: true },
      { text: '--immutable', correct: false },
      { text: '--no-write', correct: false },
      { text: '--secure', correct: false }
    ], explanation: 'Use --read-only for runtime hardening.' }
]

# Generate 120 questions total using variants
required_total = 30
existing = dca_bank.quiz_questions.count
seq = existing
variant = 1
while dca_bank.quiz_questions.count < required_total
  dca_base.each do |tpl|
    break if dca_bank.quiz_questions.count >= required_total
    seq += 1
    case tpl[:type]
    when 'mcq'
      dca_bank.quiz_questions.find_or_create_by!(sequence_order: seq) do |qq|
        qq.question_type   = 'mcq'
        qq.question_text   = "#{tpl[:text]} (v#{variant})"
        qq.options         = tpl[:options].to_json
        qq.explanation     = tpl[:explanation]
        qq.difficulty_level= variant % 3 == 0 ? 'medium' : 'easy'
        qq.points          = 8
      end
    when 'command'
      dca_bank.quiz_questions.find_or_create_by!(sequence_order: seq) do |qq|
        qq.question_type   = 'command'
        qq.question_text   = "#{tpl[:text]} (v#{variant})"
        qq.correct_answer  = tpl[:answer]
        qq.explanation     = tpl[:explanation]
        qq.difficulty_level= 'medium'
        qq.points          = 10
      end
    when 'true_false'
      dca_bank.quiz_questions.find_or_create_by!(sequence_order: seq) do |qq|
        qq.question_type   = 'true_false'
        qq.question_text   = "#{tpl[:text]} (v#{variant})"
        qq.correct_answer  = tpl[:answer]
        qq.explanation     = tpl[:explanation]
        qq.difficulty_level= 'easy'
        qq.points          = 5
      end
    end
  end
  variant += 1
end

ModuleItem.find_or_create_by!(course_module: module9, item_type: 'Quiz', item_id: dca_bank.id) do |mi|
  mi.sequence_order = 1
  mi.required = false
end

puts "  ✅ Created module: #{module9.title} with #{dca_bank.quiz_questions.count} questions"

# ========================================
# Module 10: Kubernetes Readiness: CKAD Preview (Optional)
# ========================================

module10 = docker_course.course_modules.find_or_create_by!(slug: 'exam-readiness-dca-mock-2') do |mod|
  mod.title = 'Kubernetes Readiness: CKAD Preview'
  mod.description = 'CKAD-style practice scenarios (optional)'
  mod.sequence_order = 10
  mod.estimated_minutes = 90
  mod.published = true
end

mock2 = Quiz.find_or_create_by!(title: 'CKAD Preview Scenarios') do |quiz|
  quiz.description = 'Hands-on style scenario checks (self-timed)'
  quiz.time_limit_minutes = 0
  quiz.passing_score = 0
  quiz.max_attempts = 0
  quiz.shuffle_questions = false
  quiz.show_correct_answers = true
end

topics = %w[images containers networking volumes compose security registry]
(1..30).each do |i|
  t = topics[i % topics.length]
  QuizQuestion.find_or_create_by!(quiz: mock2, sequence_order: i) do |qq|
    case i % 3
    when 0
      qq.question_type = 'mcq'
      qq.question_text = "In #{t}, which command is correct? (Q#{i})"
      qq.options = [
        { text: 'docker tag src:1 dst:1', correct: t == 'images' },
        { text: 'docker compose up -d', correct: t == 'compose' },
        { text: 'docker volume create data', correct: t == 'volumes' },
        { text: 'docker run --read-only nginx', correct: t == 'security' }
      ].to_json
      qq.explanation = 'Pick the valid command for the domain.'
      qq.difficulty_level = 'medium'
      qq.points = 8
    when 1
      qq.question_type = 'command'
      qq.question_text = "Create a user-defined bridge network (Q#{i})"
      qq.correct_answer = 'docker network create appnet'
      qq.explanation = 'docker network create <name>.'
      qq.difficulty_level = 'easy'
      qq.points = 6
    else
      qq.question_type = 'true_false'
      qq.question_text = "Named volumes persist data across container restarts. (Q#{i})"
      qq.correct_answer = 'true'
      qq.explanation = 'Volumes survive container lifecycle.'
      qq.difficulty_level = 'easy'
      qq.points = 5
    end
  end
end

ModuleItem.find_or_create_by!(course_module: module10, item_type: 'Quiz', item_id: mock2.id) do |mi|
  mi.sequence_order = 1
  mi.required = true
end

puts "  ✅ Created module: #{module10.title}"

# ========================================
# Module 11: Kubernetes Readiness: CKA Preview (Optional)
# ========================================

module11 = docker_course.course_modules.find_or_create_by!(slug: 'exam-readiness-dca-mock-3') do |mod|
  mod.title = 'Kubernetes Readiness: CKA Preview'
  mod.description = 'CKA-style administration scenario previews (optional)'
  mod.sequence_order = 11
  mod.estimated_minutes = 90
  mod.published = true
end

mock3 = Quiz.find_or_create_by!(title: 'CKA Preview Scenarios') do |quiz|
  quiz.description = 'Cluster administration scenario previews'
  quiz.time_limit_minutes = 0
  quiz.passing_score = 0
  quiz.max_attempts = 0
  quiz.shuffle_questions = false
  quiz.show_correct_answers = true
end

(1..25).each do |i|
  QuizQuestion.find_or_create_by!(quiz: mock3, sequence_order: i) do |qq|
    if i.odd?
      qq.question_type = 'mcq'
      qq.question_text = "Which flag limits memory usage? (Q#{i})"
      qq.options = [
        { text: '-m 512m', correct: true },
        { text: '--limit-mem 512', correct: false },
        { text: '--mem 512', correct: false },
        { text: '--memory-hard 512m', correct: false }
      ].to_json
      qq.explanation = 'Use -m/--memory to cap memory.'
      qq.difficulty_level = 'medium'
      qq.points = 8
    else
      qq.question_type = 'command'
      qq.question_text = "Run nginx with read-only root filesystem (Q#{i})"
      qq.correct_answer = 'docker run --read-only nginx'
      qq.explanation = 'Harden container with --read-only.'
      qq.difficulty_level = 'medium'
      qq.points = 10
    end
  end
end

ModuleItem.find_or_create_by!(course_module: module11, item_type: 'Quiz', item_id: mock3.id) do |mi|
  mi.sequence_order = 1
  mi.required = true
end

puts "  ✅ Created module: #{module11.title}"

# ========================================
# ACHIEVEMENTS
# ========================================

achievements = [
  {
    name: "First Steps",
    slug: "first-steps",
    description: "Complete your first lesson",
    badge_type: "bronze",
    points_value: 10,
    category: "course_completion",
    criteria: JSON.generate({ type: "complete_module", module_id: module1.id })
  },
  {
    name: "Quiz Master",
    slug: "quiz-master",
    description: "Score 100% on any quiz",
    badge_type: "silver",
    points_value: 50,
    category: "quiz_perfectionist",
    criteria: JSON.generate({ type: "quiz_perfect_score" })
  },
  {
    name: "Docker Basics Complete",
    slug: "docker-basics-complete",
    description: "Complete the Container Basics module",
    badge_type: "silver",
    points_value: 100,
    category: "course_completion",
    criteria: JSON.generate({ type: "complete_module", module_id: module1.id })
  },
  {
    name: "7-Day Streak",
    slug: "7-day-streak",
    description: "Study for 7 consecutive days",
    badge_type: "gold",
    points_value: 200,
    category: "streak",
    criteria: JSON.generate({ type: "streak_days", days: 7 })
  },
  {
    name: "Lab Expert",
    slug: "lab-expert",
    description: "Complete 10 hands-on labs",
    badge_type: "gold",
    points_value: 300,
    category: "lab_mastery",
    criteria: JSON.generate({ type: "labs_completed", count: 10 })
  }
]

achievements.each do |achievement_data|
  CourseAchievement.create!(achievement_data)
end

puts "🏆 Created #{CourseAchievement.count} achievements"

# ========================================
# SUMMARY
# ========================================

puts "\n✅ Course System Seeding Complete!"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
puts "📚 Courses: #{Course.count}"
puts "📖 Modules: #{CourseModule.count}"
puts "📝 Lessons: #{CourseLesson.count}"
puts "❓ Quizzes: #{Quiz.count}"
puts "🎯 Questions: #{QuizQuestion.count}"
puts "🔗 Module Items: #{ModuleItem.count}"
puts "🏆 Achievements: #{CourseAchievement.count}"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
