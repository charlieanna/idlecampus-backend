# CodeSprout Guided Learning Path Curriculum
# A narrative-driven Docker learning experience

puts "🌱 Creating CodeSprout guided learning curriculum..."

# First, ensure we have a Docker course
course = Course.find_or_create_by!(slug: 'docker-fundamentals') do |c|
  c.title = 'Docker Fundamentals - CodeSprout Journey'
  c.description = 'Join CodeSprout as a new DevOps engineer and learn Docker by solving real startup challenges'
  c.difficulty_level = 'beginner'
  c.estimated_hours = 20
  c.published = true
  c.sequence_order = 1
  c.learning_objectives = [
    'Master Docker container lifecycle management',
    'Build and optimize Docker images',
    'Manage data persistence and networking',
    'Orchestrate multi-service applications'
  ]
end

# MODULE 1: Core Concepts & Container Lifecycle
module1 = CourseModule.find_or_create_by!(course: course, slug: 'container-lifecycle') do |m|
  m.title = 'Module 1: Your First Day at CodeSprout'
  m.description = 'Learn container basics by managing CodeSprout\'s web services'
  m.sequence_order = 1
  m.estimated_minutes = 180
  m.published = true
  m.learning_objectives = [
    'Understand what containers are and why CodeSprout uses them',
    'Run and manage containers',
    'Handle container ports and networking basics',
    'Clean up containers properly'
  ]
end

# Unit 1.1: CodeSprout - Port Mapping with docker run
unit_1_1 = InteractiveLearningUnit.find_or_create_by!(slug: 'codesprout-docker-run') do |u|
  u.title = 'CodeSprout: Exposing Containers with Port Mapping'
  u.concept_explanation = <<~MD
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
  MD

  u.command_to_learn = 'docker run -d -p 8080:80 --name codesprout-web nginx:alpine'
  u.command_variations = [
    'docker run -d --name codesprout-web -p 8080:80 nginx:alpine',
    'docker run --name codesprout-web -d -p 8080:80 nginx:alpine'
  ]

  u.practice_hints = [
    'Port mapping format: -p HOST:CONTAINER → -p 8080:80',
    'Remember: first number (8080) is your host, second (80) is the container',
    'Use -d to run in background and free your terminal',
    'Full command: docker run -d -p 8080:80 --name codesprout-web nginx:alpine'
  ]

  u.scenario_narrative = <<~MD
    Sarah: "The site is running but we can't access it from our browsers. 
    We need to expose port 80 from the container to port 8080 on the host.
    Once you map the ports, we should be able to visit http://localhost:8080"
  MD

  u.problem_statement = 'Expose the nginx container on port 80 so it can be accessed via http://localhost:8080'

  u.difficulty_level = 'easy'
  u.estimated_minutes = 8
  u.sequence_order = 100
  u.category = 'networking'
  u.published = true

  u.quiz_question_text = 'In "docker run -p 8080:80 nginx", what does 8080 represent?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'The port on the host machine', correct: true },
    { text: 'The port inside the container', correct: false },
    { text: 'The container ID', correct: false },
    { text: 'The process ID', correct: false }
  ]
  u.quiz_correct_answer = 'The port on the host machine'
  u.quiz_explanation = 'In -p HOST:CONTAINER format, the first number (8080) is the host port, second (80) is container port'

  u.concept_tags = ['docker-run', 'port-mapping', 'networking', 'container-exposure', 'publishing-ports']
end

 # Always update explanatory content and examples to the latest version
concept_1_1 = <<~MD
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
MD

unit_1_1.update!(
  concept_explanation: concept_1_1,
  code_examples: [
    {
      title: 'Map different host port to same container port',
      code: "docker run -d -p 9000:80 --name web-alt nginx:alpine",
      explanation: 'You can map any available host port (9000) to container port 80. Access it at http://localhost:9000'
    },
    {
      title: 'Map multiple ports for services with HTTP and HTTPS',
      code: "docker run -d -p 8080:80 -p 8443:443 --name web-secure nginx:alpine",
      explanation: 'Map multiple ports: HTTP (8080→80) and HTTPS (8443→443). Useful for services that need both.'
    },
    {
      title: 'Auto-restart on reboot or crash',
      code: "docker run -d --restart unless-stopped --name web -p 8080:80 nginx:alpine",
      explanation: 'Keeps your service up across daemon restarts or machine reboots.'
    },
    {
      title: 'Bind to specific host interface',
      code: "docker run -d -p 127.0.0.1:8080:80 --name web-local nginx:alpine",
      explanation: 'Only accessible from localhost (127.0.0.1), not from other machines on the network. More secure.'
    },
    {
      title: 'Let Docker assign random host port',
      code: "docker run -d -p 80 --name web-random nginx:alpine",
      explanation: 'Docker picks an available host port automatically. Check with: docker port web-random'
    },
    {
      title: 'Verify port mappings',
      code: "docker port codesprout-web",
      explanation: 'Shows which host ports are mapped to container ports. Useful for debugging connectivity issues.'
    }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: module1,
  interactive_learning_unit: unit_1_1
) do |miu|
  miu.sequence_order = 1
  miu.required = true
end

# Mini-Lab for Module 1
lab1 = HandsOnLab.find_or_create_by!(title: 'CodeSprout Web Server Management') do |lab|
  lab.description = 'Deploy and manage the CodeSprout web server in a real scenario'
  lab.difficulty = 'easy'
  lab.estimated_minutes = 15
  lab.lab_type = 'docker'
  lab.category = 'containers'
  
  lab.scenario_narrative = <<~MD
    **Mission Brief from Sarah:**
    
    "Great work so far! Now I need you to handle our main web server. Here's what needs to happen:
    1. Deploy our web server with proper port mapping
    2. Verify it's running correctly
    3. Stop it when I give the signal
    4. Clean up the stopped container
    
    This is a typical day-to-day task for our DevOps team. Ready?"
  MD
  
  lab.steps = [
    {
      title: 'Deploy the web server',
      instruction: 'Run an nginx:alpine container named "codesprout-main" on port 3000',
      command: 'docker run -d --name codesprout-main -p 3000:80 nginx:alpine',
      hint: 'Use docker run with -d, -p and --name flags'
    },
    {
      title: 'Verify the server is running',
      instruction: 'List running containers and ensure codesprout-main is present',
      command: 'docker ps',
      hint: 'Use docker ps and look for the container name'
    },
    {
      title: 'Stop the server',
      instruction: 'Stop the running web server container',
      command: 'docker stop codesprout-main',
      hint: 'Use docker stop <container>'
    },
    {
      title: 'Clean up the container',
      instruction: 'Remove the stopped container to keep things tidy',
      command: 'docker rm codesprout-main',
      hint: 'Use docker rm <container>'
    }
  ]
  
  lab.concept_tags = ['docker-run', 'docker-ps', 'docker-stop', 'docker-rm', 'port-mapping']
  lab.learning_objectives = [
    'Deploy a container with custom configuration',
    'Monitor running containers',
    'Manage container lifecycle'
  ]
  
  lab.is_active = true
  lab.points_reward = 100
end

# Additional Units for Module 1
unit_1_2 = InteractiveLearningUnit.find_or_create_by!(slug: 'codesprout-detached-nginx') do |u|
  u.title = 'Run Nginx in the Background'
  u.concept_explanation = "Run services without blocking your terminal using detached mode (-d)."
  u.scenario_narrative = "> Sarah: \"When I run our server, I can't type anything else. Help me run it in the background.\""
  u.command_to_learn = 'docker run -d nginx:alpine'
  u.practice_hints = ['Use the -d flag for detached mode']
  u.quiz_question_text = 'What does -d do?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Runs in detached mode', correct: true },
    { text: 'Deletes the container', correct: false },
    { text: 'Downloads image only', correct: false },
    { text: 'Debug mode', correct: false }
  ]
  u.quiz_correct_answer = 'Runs in detached mode'
  u.quiz_explanation = 'Detached mode frees your terminal for other commands.'
  u.estimated_minutes = 3
  u.sequence_order = 101
  u.category = 'containers'
  u.published = true
  u.difficulty_level = 'easy'
  u.concept_tags = ['detached-mode', 'docker-run']
end

ModuleInteractiveUnit.find_or_create_by!(
  course_module: module1,
  interactive_learning_unit: unit_1_2
) do |miu|
  miu.sequence_order = 2
  miu.required = true
end

unit_1_3 = InteractiveLearningUnit.find_or_create_by!(slug: 'codesprout-naming-containers') do |u|
  u.title = 'Naming Your Containers'
  u.concept_explanation = "Use --name to assign a friendly name to containers."
  u.scenario_narrative = "> Sarah: \"Please name the web container codesprout-web so everyone knows what it is.\""
  u.command_to_learn = 'docker run -d --name codesprout-web nginx:alpine'
  u.practice_hints = ['Use --name codesprout-web']
  u.quiz_question_text = 'Why is naming containers helpful?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Easier management', correct: true },
    { text: 'Faster containers', correct: false },
    { text: 'Smaller images', correct: false },
    { text: 'Free TLS', correct: false }
  ]
  u.quiz_correct_answer = 'Easier management'
  u.quiz_explanation = 'Names make scripting, logs, and teamwork easier.'
  u.estimated_minutes = 3
  u.sequence_order = 102
  u.category = 'containers'
  u.published = true
  u.difficulty_level = 'easy'
  u.concept_tags = ['naming-containers']
end

ModuleInteractiveUnit.find_or_create_by!(
  course_module: module1,
  interactive_learning_unit: unit_1_3
) do |miu|
  miu.sequence_order = 3
  miu.required = true
end

# Unit 1.4: Listing Containers
unit_1_4 = InteractiveLearningUnit.find_or_create_by!(slug: 'codesprout-docker-ps') do |u|
  u.title = 'Listing Containers'
  u.concept_explanation = "Use docker ps to list running containers, and docker ps -a for all containers."
  u.scenario_narrative = "> Sarah: \"Can you check if codesprout-web is running and share the status?\""
  u.command_to_learn = 'docker ps'
  u.practice_hints = ['Try docker ps -a to include stopped ones']
  u.quiz_question_text = 'Which command lists all containers including stopped ones?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'docker ps -a', correct: true },
    { text: 'docker list --all', correct: false },
    { text: 'docker containers', correct: false },
    { text: 'docker ps --running', correct: false }
  ]
  u.quiz_explanation = 'Use -a to include stopped containers.'
  u.estimated_minutes = 2
  u.sequence_order = 103
  u.category = 'containers'
  u.published = true
  u.difficulty_level = 'easy'
  u.concept_tags = ['docker-ps']
end

ModuleInteractiveUnit.find_or_create_by!(
  course_module: module1,
  interactive_learning_unit: unit_1_4
) do |miu|
  miu.sequence_order = 4
  miu.required = true
end

# Unit 1.5: Executing Commands in Containers
unit_1_7 = InteractiveLearningUnit.find_or_create_by!(slug: 'codesprout-docker-exec') do |u|
  u.title = 'Executing Commands in Containers'
  u.concept_explanation = "Use docker exec -it <container> sh to get a shell (bash may not exist)."
  u.scenario_narrative = "> Sarah: \"Jump into the container and check /usr/share/nginx/html.\""
  u.command_to_learn = 'docker exec -it codesprout-web sh'
  u.practice_hints = ['Use -it for interactive terminals']
  u.quiz_question_text = 'What does -it stand for in docker exec?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Interactive + TTY', correct: true },
    { text: 'Internal + Test', correct: false },
    { text: 'Init + Terminal', correct: false },
    { text: 'Immediate + TTY', correct: false }
  ]
  u.quiz_explanation = '-i keeps STDIN open; -t allocates a pseudo-TTY.'
  u.estimated_minutes = 3
  u.sequence_order = 104
  u.category = 'containers'
  u.published = true
  u.difficulty_level = 'easy'
  u.concept_tags = ['docker-exec']
end

ModuleInteractiveUnit.find_or_create_by!(
  course_module: module1,
  interactive_learning_unit: unit_1_7
) do |miu|
  miu.sequence_order = 5
  miu.required = true
end

# Unit 1.6: Viewing Logs
unit_1_8 = InteractiveLearningUnit.find_or_create_by!(slug: 'codesprout-docker-logs') do |u|
  u.title = 'Viewing Container Logs'
  u.concept_explanation = "docker logs shows container stdout/stderr; use -f to follow new output."
  u.scenario_narrative = "> Sarah: \"Check the web server logs for errors.\""
  u.command_to_learn = 'docker logs codesprout-web'
  u.practice_hints = ['Use -f to follow the logs in real-time']
  u.quiz_question_text = 'Which flag follows logs as they are written?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: '-f', correct: true },
    { text: '-t', correct: false },
    { text: '--tail 100', correct: false },
    { text: '-F', correct: false }
  ]
  u.quiz_explanation = 'Use -f (follow) to stream logs.'
  u.estimated_minutes = 2
  u.sequence_order = 105
  u.category = 'containers'
  u.published = true
  u.difficulty_level = 'easy'
  u.concept_tags = ['docker-logs']
end

ModuleInteractiveUnit.find_or_create_by!(
  course_module: module1,
  interactive_learning_unit: unit_1_8
) do |miu|
  miu.sequence_order = 6
  miu.required = true
end

# Unit 1.7: Stopping Containers
unit_1_5 = InteractiveLearningUnit.find_or_create_by!(slug: 'codesprout-docker-stop') do |u|
  u.title = 'Stopping Containers'
  u.concept_explanation = "docker stop sends SIGTERM then SIGKILL after a timeout to gracefully stop a container."
  u.scenario_narrative = "> Sarah: \"Pause the server—we're deploying a config change.\""
  u.command_to_learn = 'docker stop codesprout-web'
  u.practice_hints = ['docker stop <name>']
  u.quiz_question_text = 'What signal does docker stop send first?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'SIGTERM', correct: true },
    { text: 'SIGKILL', correct: false },
    { text: 'SIGHUP', correct: false },
    { text: 'SIGINT', correct: false }
  ]
  u.quiz_explanation = 'SIGTERM allows for graceful shutdown before SIGKILL.'
  u.estimated_minutes = 2
  u.sequence_order = 106
  u.category = 'containers'
  u.published = true
  u.difficulty_level = 'easy'
  u.concept_tags = ['docker-stop']
end

ModuleInteractiveUnit.find_or_create_by!(
  course_module: module1,
  interactive_learning_unit: unit_1_5
) do |miu|
  miu.sequence_order = 7
  miu.required = true
end

# Unit 1.8: Removing Containers
unit_1_6 = InteractiveLearningUnit.find_or_create_by!(slug: 'codesprout-docker-rm') do |u|
  u.title = 'Removing Containers'
  u.concept_explanation = "docker rm removes stopped containers; use -f to force-remove running ones (not recommended)."
  u.scenario_narrative = "> Sarah: \"We keep a clean house—remove any stopped containers you created.\""
  u.command_to_learn = 'docker rm codesprout-web'
  u.practice_hints = ['Remove only after stopping the container']
  u.quiz_question_text = 'Can docker rm remove a running container without -f?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'No', correct: true },
    { text: 'Yes', correct: false }
  ]
  u.quiz_explanation = 'docker rm works on stopped containers unless -f is used.'
  u.estimated_minutes = 2
  u.sequence_order = 107
  u.category = 'containers'
  u.published = true
  u.difficulty_level = 'easy'
  u.concept_tags = ['docker-rm']
end

ModuleInteractiveUnit.find_or_create_by!(
  course_module: module1,
  interactive_learning_unit: unit_1_6
) do |miu|
  miu.sequence_order = 8
  miu.required = true
end

# MODULE 2: Images & Dockerfiles
module2 = CourseModule.find_or_create_by!(course: course, slug: 'images-dockerfiles') do |m|
  m.title = 'Module 2: Building CodeSprout Images'
  m.description = 'Package and optimize CodeSprout applications using Dockerfiles'
  m.sequence_order = 2
  m.estimated_minutes = 180
  m.published = true
  m.learning_objectives = [
    'Understand image layers and caching',
    'Write efficient Dockerfiles',
    'Use multi-stage builds to shrink images'
  ]
end

# Mini-Lab for Module 2: Build a Custom Image
lab2 = HandsOnLab.find_or_create_by!(title: 'CodeSprout App Image Build') do |lab|
  lab.description = 'Write a multi-stage Dockerfile and build a lean app image'
  lab.difficulty = 'medium'
  lab.estimated_minutes = 20
  lab.lab_type = 'docker'
  lab.category = 'images'
  lab.scenario_narrative = "**Mission:** Create an optimized production image for CodeSprout's app."
  lab.steps = [
    {
      title: 'Create Dockerfile',
      instruction: 'Create a multi-stage Dockerfile (builder + final). Use alpine base.',
      command: 'cat Dockerfile',
      hint: 'First stage builds, second stage copies artifact'
    },
    {
      title: 'Build the image',
      instruction: 'Build the image and tag it codesprout/app:1.0',
      command: 'docker build -t codesprout/app:1.0 .',
      hint: 'Use docker build -t <name> .'
    },
    {
      title: 'Run the container',
      instruction: 'Run the image and verify output',
      command: 'docker run --rm codesprout/app:1.0',
      hint: 'Run and check the program output'
    }
  ]
  lab.concept_tags = ['dockerfile', 'docker-build', 'multi-stage']
  lab.learning_objectives = ['Write Dockerfiles', 'Build and run images']
  lab.is_active = true
  lab.points_reward = 120
end

ModuleItem.find_or_create_by!(
  course_module: module2,
  item: lab2
) do |mi|
  mi.sequence_order = 20
  mi.required = true
end

# MODULE 3: Networking & Data Management
module3 = CourseModule.find_or_create_by!(course: course, slug: 'networking-and-data') do |m|
  m.title = 'Module 3: Networking & Data'
  m.description = 'Persist data and connect services securely'
  m.sequence_order = 3
  m.estimated_minutes = 180
  m.published = true
  m.learning_objectives = [
    'Create and use volumes',
    'Create and use custom networks',
    'Pass configuration via environment variables'
  ]
end

# Mini-Lab for Module 3: Persistent Database
lab3 = HandsOnLab.find_or_create_by!(title: 'CodeSprout Persistent Database') do |lab|
  lab.description = 'Run MySQL with a named volume and a custom network'
  lab.difficulty = 'medium'
  lab.estimated_minutes = 25
  lab.lab_type = 'docker'
  lab.category = 'data'
  lab.scenario_narrative = "**Mission:** Deploy a MySQL database with persistent data on a custom network."
  lab.steps = [
    {
      title: 'Create a volume',
      instruction: 'Create a named volume called codesprout-db',
      command: 'docker volume create codesprout-db',
      hint: 'Use docker volume create <name>'
    },
    {
      title: 'Create a network',
      instruction: 'Create a user-defined bridge network codesprout-net',
      command: 'docker network create codesprout-net',
      hint: 'Use docker network create <name>'
    },
    {
      title: 'Run MySQL',
      instruction: 'Run mysql:8 with root password and mount the volume on /var/lib/mysql',
      command: 'docker run -d --name codesprout-db --network codesprout-net -e MYSQL_ROOT_PASSWORD=secret -v codesprout-db:/var/lib/mysql mysql:8',
      hint: 'Use -e for env vars, -v for volumes, --network to attach'
    }
  ]
  lab.concept_tags = ['volumes', 'networking', 'env-vars']
  lab.learning_objectives = ['Create volumes', 'Create networks', 'Run configured services']
  lab.is_active = true
  lab.points_reward = 150
end

ModuleItem.find_or_create_by!(
  course_module: module3,
  item: lab3
) do |mi|
  mi.sequence_order = 20
  mi.required = true
end

ModuleItem.find_or_create_by!(
  course_module: module1,
  item: lab1
) do |mi|
  mi.sequence_order = 10
  mi.required = true
end

# MODULE 4: Deploying the CodeSprout Application
module4 = CourseModule.find_or_create_by!(course: course, slug: 'deploying-codesprout') do |m|
  m.title = 'Module 4: Deploying the CodeSprout Application'
  m.description = 'Build and deploy a complete multi-service application running at localhost:3000'
  m.sequence_order = 4
  m.estimated_minutes = 200
  m.published = true
  m.learning_objectives = [
    'Deploy a full-stack application locally',
    'Connect frontend, backend, and database services',
    'Orchestrate multi-container applications with Docker Compose',
    'Prepare applications for Kubernetes deployment'
  ]
end

# Link interactive units 108-122 to Module 4
# Note: These are created in db/seeds/codesprout_deployment_units.rb

# Cluster 1: Frontend deployment (lessons 108-110, then lab)
# Cluster 2: Backend connection (lessons 111-113, then lab)
# Cluster 3: Database integration (lessons 114-116, then lab)
# Cluster 4: Docker Compose (lessons 117-119, then lab)
# Cluster 5: Management & scaling (lessons 120-122, then lab)

puts "📦 Module 4: Deploying CodeSprout Application created"
puts "   - 15 interactive lessons (sequence 108-122)"
puts "   - 5 hands-on labs (frontend, backend, database, compose, scaling)"
puts "   - Progressive structure: lessons → lab → lessons → lab"

puts "\n✅ CodeSprout curriculum created successfully!"
puts "   - 4 modules created (Lifecycle, Images, Networking, Deployment)"
puts "   - #{module1.module_interactive_units.count} interactive units in Module 1"
puts "   - Module 4 adds 15 deployment lessons + 5 labs"
puts "   - Total hands-on labs: 8"
puts "   - Concept tags for adaptive remediation: ✓"
puts "   - Progressive hints: ✓"
puts "   - Scenario narratives: ✓"
puts "   - Kubernetes-ready preparation: ✓"
