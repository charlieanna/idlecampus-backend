# Docker Containers Interactive Learning Units
# Converting 21 container management commands into CodeSprout-style learning experiences

puts "🐳 Creating Docker Containers Interactive Learning Units..."

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

# Find or create Container Management module
containers_module = course.course_modules.find_or_create_by!(slug: 'container-management') do |m|
  m.title = "Container Management"
  m.description = "Advanced container lifecycle operations and resource management"
  m.sequence_order = 2
  m.estimated_minutes = 420
  m.published = true
  m.learning_objectives = [
    'Manage container lifecycle operations',
    'Monitor container resource usage',
    'Copy files between containers and host',
    'Inspect container filesystem changes',
    'Update container configurations dynamically',
    'Clean up stopped containers efficiently'
  ]
end

# Unit 17: docker container prune
unit_17 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-containers-prune-command') do |u|
  u.title = 'Docker Container Prune: Batch Container Cleanup'
  u.concept_explanation = <<~MD
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
  MD

  u.command_to_learn = 'docker container prune'
  u.command_variations = [
    'docker container prune -f',
    'docker container prune --filter "until=24h"',
    'docker container prune --filter "label=env=test"'
  ]

  u.practice_hints = [
    'Basic prune: docker container prune (with confirmation)',
    'Force prune: docker container prune -f',
    'Age filter: docker container prune --filter "until=24h"'
  ]

  u.scenario_narrative = 'Weekly cleanup: Remove all stopped containers older than 48 hours'
  u.problem_statement = 'Remove all stopped containers older than 48 hours without confirmation prompts'

  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 17
  u.category = 'docker-containers'
  u.published = true

  u.quiz_question_text = 'What does docker container prune remove by default?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'All stopped containers', correct: true },
    { text: 'All containers including running ones', correct: false },
    { text: 'All containers and images', correct: false },
    { text: 'Only containers older than 24 hours', correct: false }
  ]
  u.quiz_correct_answer = 'All stopped containers'
  u.quiz_explanation = 'docker container prune removes all stopped containers (exited or created state). Running and paused containers are never removed.'

  u.concept_tags = ['containers', 'cleanup', 'docker-prune', 'maintenance', 'disk-space']
end

unit_17.update!(
  code_examples: [
    {
      title: 'Interactive cleanup with confirmation',
      code: 'docker container prune',
      explanation: 'Prompts for confirmation before removing all stopped containers'
    },
    {
      title: 'Automated cleanup without prompt',
      code: 'docker container prune -f',
      explanation: 'Skips confirmation - perfect for scripts and cron jobs'
    },
    {
      title: 'Remove containers older than 24 hours',
      code: 'docker container prune --filter "until=24h" -f',
      explanation: 'Time-based cleanup - keeps recently stopped containers'
    },
    {
      title: 'Clean only test environment containers',
      code: 'docker container prune --filter "label=env=test" -f',
      explanation: 'Label-based cleanup - surgical removal of specific groups'
    }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: containers_module,
  interactive_learning_unit: unit_17
) do |miu|
  miu.sequence_order = 1
  miu.required = true
end

# Unit 18: docker cp
unit_18 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-containers-cp-command') do |u|
  u.title = 'Docker CP: Copy Files Between Container and Host'
  u.concept_explanation = 'Copy files and directories bidirectionally between containers and host filesystem, even while containers are running.'
  u.command_to_learn = 'docker cp my-file.txt my-container:/app/'
  u.command_variations = [
    'docker cp host-file.txt container:/path/',
    'docker cp container:/path/file.txt ./local/',
    'docker cp ./directory container:/backup/'
  ]
  u.practice_hints = [
    'Host to container: docker cp /local/file container:/remote/',
    'Container to host: docker cp container:/remote/file /local/'
  ]
  u.scenario_narrative = 'Emergency config update: Copy updated nginx.conf to production without restart'
  u.problem_statement = 'Copy configuration file from host to running container'
  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 18
  u.category = 'docker-containers'
  u.published = true
  u.quiz_question_text = 'Can you use docker cp on a stopped container?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Yes, docker cp works on both running and stopped containers', correct: true },
    { text: 'No, container must be running', correct: false },
    { text: 'Only for copying FROM container', correct: false },
    { text: 'Only with the --force flag', correct: false }
  ]
  u.quiz_correct_answer = 'Yes, docker cp works on both running and stopped containers'
  u.quiz_explanation = 'docker cp works on containers in any state - useful for data recovery and backup.'
  u.concept_tags = ['containers', 'docker-cp', 'file-transfer', 'deployment', 'backup']
end

unit_18.update!(
  code_examples: [
    {
      title: 'Copy file from host to container',
      code: 'docker cp ./config.yml web:/etc/app/',
      explanation: 'Deploy configuration without restart'
    },
    {
      title: 'Extract log file from container',
      code: 'docker cp app:/var/log/app.log ./logs/',
      explanation: 'Retrieve logs for analysis'
    }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: containers_module,
  interactive_learning_unit: unit_18
) do |miu|
  miu.sequence_order = 2
  miu.required = true
end

# Unit 19: docker diff
unit_19 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-containers-diff-command') do |u|
  u.title = 'Docker Diff: Inspect Container Filesystem Changes'
  u.concept_explanation = 'Show which files and directories have been modified, added, or deleted in a container compared to its base image.'
  u.command_to_learn = 'docker diff my-container'
  u.command_variations = [
    'docker diff container',
    'docker diff container | grep "^A"',
    'docker diff container | grep /etc'
  ]
  u.practice_hints = [
    'See all changes: docker diff <container>',
    'Only added files: docker diff <container> | grep "^A"',
    'Only modified: docker diff <container> | grep "^C"'
  ]
  u.scenario_narrative = 'Security audit: Identify all filesystem changes to detect breaches'
  u.problem_statement = 'Use docker diff to identify filesystem changes for security investigation'
  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 19
  u.category = 'docker-containers'
  u.published = true
  u.quiz_question_text = 'In docker diff output, what does the "C" prefix indicate?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Changed (modified) file or directory', correct: true },
    { text: 'Created file', correct: false },
    { text: 'Copied file', correct: false },
    { text: 'Container file', correct: false }
  ]
  u.quiz_correct_answer = 'Changed (modified) file or directory'
  u.quiz_explanation = 'In docker diff: "C" = changed/modified, "A" = added, "D" = deleted.'
  u.concept_tags = ['containers', 'docker-diff', 'filesystem', 'debugging', 'security']
end

unit_19.update!(
  code_examples: [
    {
      title: 'View all filesystem changes',
      code: 'docker diff web-server',
      explanation: 'Shows all files added, modified, or deleted'
    },
    {
      title: 'Find newly added files',
      code: 'docker diff app | grep "^A"',
      explanation: 'Lists only added files'
    }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: containers_module,
  interactive_learning_unit: unit_19
) do |miu|
  miu.sequence_order = 3
  miu.required = true
end

# Unit 20: docker export
unit_20 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-containers-export-command') do |u|
  u.title = 'Docker Export: Export Container Filesystem as Archive'
  u.concept_explanation = 'Create a tarball archive of a container\'s entire filesystem for backup, migration, or forensic analysis.'
  u.command_to_learn = 'docker export my-container > backup.tar'
  u.command_variations = [
    'docker export -o backup.tar my-container',
    'docker export my-container | gzip > backup.tar.gz',
    'cat backup.tar | docker import - my-image:tag'
  ]
  u.practice_hints = [
    'Basic export: docker export container > file.tar',
    'Compressed: docker export container | gzip > file.tar.gz',
    'Import back: cat file.tar | docker import - image:tag'
  ]
  u.scenario_narrative = 'Pre-migration backup: Export production containers as safety net'
  u.problem_statement = 'Export production containers as compressed backups'
  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 20
  u.category = 'docker-containers'
  u.published = true
  u.quiz_question_text = 'What is the main difference between docker export and docker save?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'export creates archive of container filesystem, save preserves image layers', correct: true },
    { text: 'export is for images, save is for containers', correct: false },
    { text: 'export includes metadata, save does not', correct: false },
    { text: 'They are exactly the same', correct: false }
  ]
  u.quiz_correct_answer = 'export creates archive of container filesystem, save preserves image layers'
  u.quiz_explanation = 'docker export creates flat tarball of container (loses layers), docker save preserves image with all layers.'
  u.concept_tags = ['containers', 'docker-export', 'backup', 'migration', 'archival']
end

unit_20.update!(
  code_examples: [
    {
      title: 'Export container to tar file',
      code: 'docker export web-server > backup.tar',
      explanation: 'Creates complete filesystem archive'
    },
    {
      title: 'Export with compression',
      code: 'docker export database | gzip > backup.tar.gz',
      explanation: 'Compresses output to save disk space'
    }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: containers_module,
  interactive_learning_unit: unit_20
) do |miu|
  miu.sequence_order = 4
  miu.required = true
end

# Unit 21: docker stats
unit_21 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-containers-stats-command') do |u|
  u.title = 'Docker Stats: Live Resource Usage Statistics'
  u.concept_explanation = 'Display live resource usage statistics including CPU, memory, network I/O, and disk I/O for running containers.'
  u.command_to_learn = 'docker stats'
  u.command_variations = [
    'docker stats --no-stream',
    'docker stats web-server database',
    'docker stats --format "{{.Name}}: {{.CPUPerc}}"'
  ]
  u.practice_hints = [
    'Live stats: docker stats',
    'One-shot: docker stats --no-stream',
    'Specific containers: docker stats web db'
  ]
  u.scenario_narrative = 'Performance investigation: Identify which container is the bottleneck'
  u.problem_statement = 'Monitor container resource usage to identify performance bottlenecks'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 21
  u.category = 'docker-containers'
  u.published = true
  u.quiz_question_text = 'What does a CPU percentage of 200% mean in docker stats?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Container is using 2 full CPU cores', correct: true },
    { text: 'Container is overloaded by 100%', correct: false },
    { text: 'There is an error in measurement', correct: false },
    { text: 'CPU limit has been exceeded', correct: false }
  ]
  u.quiz_correct_answer = 'Container is using 2 full CPU cores'
  u.quiz_explanation = 'CPU percentages can exceed 100% on multi-core systems. 100% = 1 core, 200% = 2 cores.'
  u.concept_tags = ['containers', 'docker-stats', 'monitoring', 'performance', 'resources']
end

unit_21.update!(
  code_examples: [
    {
      title: 'Monitor all running containers',
      code: 'docker stats',
      explanation: 'Live-updating display of resource usage - press Ctrl+C to exit'
    },
    {
      title: 'One-time snapshot',
      code: 'docker stats --no-stream',
      explanation: 'Shows current stats once and exits - perfect for scripts'
    }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: containers_module,
  interactive_learning_unit: unit_21
) do |miu|
  miu.sequence_order = 5
  miu.required = true
end

# Unit 22: docker top
unit_22 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-containers-top-command') do |u|
  u.title = 'Docker Top: Display Running Processes in Container'
  u.concept_explanation = 'Display running processes inside a container, similar to the Unix top command but for containerized processes.'
  u.command_to_learn = 'docker top my-container'
  u.command_variations = [
    'docker top container',
    'docker top container aux'
  ]
  u.practice_hints = [
    'View processes: docker top <container>',
    'With ps options: docker top <container> aux'
  ]
  u.scenario_narrative = 'Debug why container is slow by examining running processes'
  u.problem_statement = 'List all processes running in a container to identify resource hogs'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 22
  u.category = 'docker-containers'
  u.published = true
  u.quiz_question_text = 'What does docker top display?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Running processes inside the container', correct: true },
    { text: 'Top resource-consuming containers', correct: false },
    { text: 'Container configuration', correct: false },
    { text: 'Container logs', correct: false }
  ]
  u.quiz_correct_answer = 'Running processes inside the container'
  u.quiz_explanation = 'docker top shows the running processes inside a specific container.'
  u.concept_tags = ['containers', 'docker-top', 'processes', 'monitoring', 'debugging']
end

unit_22.update!(
  code_examples: [
    {
      title: 'View container processes',
      code: 'docker top web-server',
      explanation: 'Shows all processes running inside container'
    },
    {
      title: 'Detailed process info',
      code: 'docker top database aux',
      explanation: 'Uses ps aux format for detailed information'
    }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: containers_module,
  interactive_learning_unit: unit_22
) do |miu|
  miu.sequence_order = 6
  miu.required = true
end

# Unit 23: docker update
unit_23 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-containers-update-command') do |u|
  u.title = 'Docker Update: Update Container Configuration'
  u.concept_explanation = 'Update resource limits and restart policies of running containers without stopping them.'
  u.command_to_learn = 'docker update --memory="1g" my-container'
  u.command_variations = [
    'docker update --cpus="2" container',
    'docker update --restart=always container',
    'docker update --memory="512m" --cpus="1.5" container'
  ]
  u.practice_hints = [
    'Update memory: docker update --memory="1g" <container>',
    'Update CPUs: docker update --cpus="2" <container>',
    'Update restart policy: docker update --restart=always <container>'
  ]
  u.scenario_narrative = 'Increase memory limit for database without downtime'
  u.problem_statement = 'Update container resource limits without stopping it'
  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 23
  u.category = 'docker-containers'
  u.published = true
  u.quiz_question_text = 'What can you update with docker update command?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Resource limits and restart policies', correct: true },
    { text: 'Container image', correct: false },
    { text: 'Container name', correct: false },
    { text: 'Environment variables', correct: false }
  ]
  u.quiz_correct_answer = 'Resource limits and restart policies'
  u.quiz_explanation = 'docker update can modify resource limits (CPU, memory) and restart policies of running containers.'
  u.concept_tags = ['containers', 'docker-update', 'resources', 'configuration', 'runtime']
end

unit_23.update!(
  code_examples: [
    {
      title: 'Increase memory limit',
      code: 'docker update --memory="2g" database',
      explanation: 'Updates memory limit without stopping container'
    },
    {
      title: 'Change restart policy',
      code: 'docker update --restart=unless-stopped web-server',
      explanation: 'Sets container to restart automatically'
    }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: containers_module,
  interactive_learning_unit: unit_23
) do |miu|
  miu.sequence_order = 7
  miu.required = true
end

# Unit 24: docker port
unit_24 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-containers-port-command') do |u|
  u.title = 'Docker Port: List Port Mappings'
  u.concept_explanation = 'Display port mappings for a container showing how container ports are exposed on the host.'
  u.command_to_learn = 'docker port my-container'
  u.command_variations = [
    'docker port container',
    'docker port container 80'
  ]
  u.practice_hints = [
    'All mappings: docker port <container>',
    'Specific port: docker port <container> 80'
  ]
  u.scenario_narrative = 'Find which host port maps to container port 80 for nginx'
  u.problem_statement = 'Identify port mappings to access containerized service'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 24
  u.category = 'docker-containers'
  u.published = true
  u.quiz_question_text = 'What information does docker port provide?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Port mappings between container and host', correct: true },
    { text: 'Open ports in container', correct: false },
    { text: 'Network configuration', correct: false },
    { text: 'Firewall rules', correct: false }
  ]
  u.quiz_correct_answer = 'Port mappings between container and host'
  u.quiz_explanation = 'docker port shows which host ports are mapped to container ports.'
  u.concept_tags = ['containers', 'docker-port', 'networking', 'port-mapping', 'configuration']
end

unit_24.update!(
  code_examples: [
    {
      title: 'View all port mappings',
      code: 'docker port web-server',
      explanation: 'Shows all ports mapped from container to host'
    },
    {
      title: 'Check specific port',
      code: 'docker port nginx 80',
      explanation: 'Shows which host port maps to container port 80'
    }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: containers_module,
  interactive_learning_unit: unit_24
) do |miu|
  miu.sequence_order = 8
  miu.required = true
end

# Unit 25: docker rename
unit_25 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-containers-rename-command') do |u|
  u.title = 'Docker Rename: Rename a Container'
  u.concept_explanation = 'Change the name of a container to something more meaningful or to resolve naming conflicts.'
  u.command_to_learn = 'docker rename old-name new-name'
  u.command_variations = [
    'docker rename container-name new-name'
  ]
  u.practice_hints = [
    'Rename: docker rename <old-name> <new-name>',
    'Works on running or stopped containers'
  ]
  u.scenario_narrative = 'Rename randomly-named container to meaningful production name'
  u.problem_statement = 'Rename container for better identification and management'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 25
  u.category = 'docker-containers'
  u.published = true
  u.quiz_question_text = 'Can you rename a running container?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Yes, containers can be renamed while running', correct: true },
    { text: 'No, must stop first', correct: false },
    { text: 'Only if no connections exist', correct: false },
    { text: 'Only with --force flag', correct: false }
  ]
  u.quiz_correct_answer = 'Yes, containers can be renamed while running'
  u.quiz_explanation = 'docker rename works on both running and stopped containers without affecting their operation.'
  u.concept_tags = ['containers', 'docker-rename', 'management', 'naming', 'organization']
end

unit_25.update!(
  code_examples: [
    {
      title: 'Rename container',
      code: 'docker rename quirky_pascal production-api',
      explanation: 'Changes auto-generated name to meaningful one'
    },
    {
      title: 'Fix naming conflict',
      code: 'docker rename old-web web-backup',
      explanation: 'Frees up name for new container'
    }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: containers_module,
  interactive_learning_unit: unit_25
) do |miu|
  miu.sequence_order = 9
  miu.required = true
end

# Unit 26: docker container ls
unit_26 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-containers-ls-command') do |u|
  u.title = 'Docker Container LS: List Containers'
  u.concept_explanation = 'List containers with various filters - modern alternative to docker ps command.'
  u.command_to_learn = 'docker container ls'
  u.command_variations = [
    'docker container ls -a',
    'docker container ls --filter "status=running"',
    'docker container ls -q'
  ]
  u.practice_hints = [
    'List running: docker container ls',
    'List all: docker container ls -a',
    'Filter by status: docker container ls --filter "status=exited"'
  ]
  u.scenario_narrative = 'Inventory all containers on system including stopped ones'
  u.problem_statement = 'List all containers and filter by specific criteria'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 26
  u.category = 'docker-containers'
  u.published = true
  u.quiz_question_text = 'What is the difference between "docker container ls" and "docker ps"?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'They are equivalent commands with same functionality', correct: true },
    { text: 'ls shows more details', correct: false },
    { text: 'ps is for running only', correct: false },
    { text: 'ls is deprecated', correct: false }
  ]
  u.quiz_correct_answer = 'They are equivalent commands with same functionality'
  u.quiz_explanation = 'docker container ls is the modern form, docker ps is legacy shorthand - both work identically.'
  u.concept_tags = ['containers', 'docker-ls', 'listing', 'inspection', 'management']
end

unit_26.update!(
  code_examples: [
    {
      title: 'List running containers',
      code: 'docker container ls',
      explanation: 'Shows currently running containers'
    },
    {
      title: 'List all containers',
      code: 'docker container ls -a',
      explanation: 'Includes stopped containers'
    }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: containers_module,
  interactive_learning_unit: unit_26
) do |miu|
  miu.sequence_order = 10
  miu.required = true
end

# Unit 27: docker container create
unit_27 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-containers-create-command') do |u|
  u.title = 'Docker Container Create: Create Container Without Starting'
  u.concept_explanation = 'Create a container from an image without starting it - useful for configuration before launch.'
  u.command_to_learn = 'docker container create --name my-app nginx'
  u.command_variations = [
    'docker container create -p 8080:80 nginx',
    'docker container create --name app -e KEY=value image'
  ]
  u.practice_hints = [
    'Create: docker container create <image>',
    'With name: docker container create --name <name> <image>',
    'Start later: docker container start <name>'
  ]
  u.scenario_narrative = 'Pre-configure container before starting it in production'
  u.problem_statement = 'Create container with specific configuration without starting it'
  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 27
  u.category = 'docker-containers'
  u.published = true
  u.quiz_question_text = 'What is the difference between docker create and docker run?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'create makes container but doesn\'t start it, run creates and starts', correct: true },
    { text: 'create is faster', correct: false },
    { text: 'run doesn\'t save the container', correct: false },
    { text: 'They are identical', correct: false }
  ]
  u.quiz_correct_answer = 'create makes container but doesn\'t start it, run creates and starts'
  u.quiz_explanation = 'docker create prepares container without starting, docker run = create + start in one command.'
  u.concept_tags = ['containers', 'docker-create', 'lifecycle', 'initialization', 'configuration']
end

unit_27.update!(
  code_examples: [
    {
      title: 'Create container',
      code: 'docker container create --name web nginx',
      explanation: 'Creates container in stopped state'
    },
    {
      title: 'Create with ports',
      code: 'docker container create -p 8080:80 nginx',
      explanation: 'Pre-configures port mapping before start'
    }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: containers_module,
  interactive_learning_unit: unit_27
) do |miu|
  miu.sequence_order = 11
  miu.required = true
end

# Units 28-37: Standard lifecycle commands with concise but complete content

# Unit 28: docker container start
unit_28 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-containers-start-command') do |u|
  u.title = 'Docker Container Start: Start Stopped Containers'
  u.concept_explanation = 'Start one or more stopped containers, preserving their state and configuration.'
  u.command_to_learn = 'docker container start my-container'
  u.command_variations = ['docker container start -a container']
  u.practice_hints = ['Start: docker container start <name>']
  u.scenario_narrative = 'Restart stopped database to restore service'
  u.problem_statement = 'Start previously stopped container'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 28
  u.category = 'docker-containers'
  u.published = true
  u.quiz_question_text = 'What happens to container data when you start a stopped container?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Data is preserved from when it was stopped', correct: true },
    { text: 'Container starts fresh', correct: false }
  ]
  u.quiz_correct_answer = 'Data is preserved from when it was stopped'
  u.quiz_explanation = 'docker start restarts container with all data and state preserved.'
  u.concept_tags = ['containers', 'docker-start', 'lifecycle']
end

unit_28.update!(code_examples: [{ title: 'Start container', code: 'docker container start web', explanation: 'Restarts stopped container' }])
ModuleInteractiveUnit.find_or_create_by!(course_module: containers_module, interactive_learning_unit: unit_28) { |miu| miu.sequence_order = 12; miu.required = true }

# Unit 29: docker container stop
unit_29 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-containers-stop-command') do |u|
  u.title = 'Docker Container Stop: Gracefully Stop Containers'
  u.concept_explanation = 'Gracefully stop running containers by sending SIGTERM, then SIGKILL if needed.'
  u.command_to_learn = 'docker container stop my-container'
  u.command_variations = ['docker container stop -t 30 container']
  u.practice_hints = ['Stop: docker container stop <name>', 'Timeout: docker container stop -t 30 <name>']
  u.scenario_narrative = 'Stop API server gracefully with 30-second timeout'
  u.problem_statement = 'Stop container gracefully allowing proper cleanup'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 29
  u.category = 'docker-containers'
  u.published = true
  u.quiz_question_text = 'What signal does docker stop send first?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [{ text: 'SIGTERM', correct: true }, { text: 'SIGKILL', correct: false }]
  u.quiz_correct_answer = 'SIGTERM'
  u.quiz_explanation = 'docker stop sends SIGTERM first for graceful shutdown, then SIGKILL if timeout exceeded.'
  u.concept_tags = ['containers', 'docker-stop', 'lifecycle', 'signals']
end

unit_29.update!(code_examples: [{ title: 'Stop container', code: 'docker container stop web', explanation: 'Graceful shutdown with 10s timeout' }])
ModuleInteractiveUnit.find_or_create_by!(course_module: containers_module, interactive_learning_unit: unit_29) { |miu| miu.sequence_order = 13; miu.required = true }

# Unit 30: docker container restart
unit_30 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-containers-restart-command') do |u|
  u.title = 'Docker Container Restart: Stop and Start Containers'
  u.concept_explanation = 'Restart containers by stopping and starting them - equivalent to stop + start.'
  u.command_to_learn = 'docker container restart my-container'
  u.command_variations = ['docker container restart -t 30 container']
  u.practice_hints = ['Restart: docker container restart <name>']
  u.scenario_narrative = 'Restart misbehaving application to clear memory leaks'
  u.problem_statement = 'Restart container to resolve temporary issues'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 30
  u.category = 'docker-containers'
  u.published = true
  u.quiz_question_text = 'What does docker restart do?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [{ text: 'Stops then starts the container', correct: true }, { text: 'Only stops', correct: false }]
  u.quiz_correct_answer = 'Stops then starts the container'
  u.quiz_explanation = 'docker restart = docker stop + docker start in one command.'
  u.concept_tags = ['containers', 'docker-restart', 'lifecycle']
end

unit_30.update!(code_examples: [{ title: 'Restart container', code: 'docker container restart api', explanation: 'Stop and start in one command' }])
ModuleInteractiveUnit.find_or_create_by!(course_module: containers_module, interactive_learning_unit: unit_30) { |miu| miu.sequence_order = 14; miu.required = true }

# Unit 31: docker container kill
unit_31 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-containers-kill-command') do |u|
  u.title = 'Docker Container Kill: Forcefully Stop Containers'
  u.concept_explanation = 'Immediately kill container by sending SIGKILL - use when docker stop fails.'
  u.command_to_learn = 'docker container kill my-container'
  u.command_variations = ['docker container kill -s SIGTERM container']
  u.practice_hints = ['Kill: docker container kill <name>', 'Custom signal: docker container kill -s SIGTERM <name>']
  u.scenario_narrative = 'Force-kill hung container that won\'t respond to stop'
  u.problem_statement = 'Forcefully terminate unresponsive container'
  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 31
  u.category = 'docker-containers'
  u.published = true
  u.quiz_question_text = 'When should you use docker kill instead of docker stop?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [{ text: 'When container is hung and won\'t respond to stop', correct: true }, { text: 'Always', correct: false }]
  u.quiz_correct_answer = 'When container is hung and won\'t respond to stop'
  u.quiz_explanation = 'Use docker stop first for graceful shutdown. Use kill only when container is unresponsive.'
  u.concept_tags = ['containers', 'docker-kill', 'lifecycle', 'emergency']
end

unit_31.update!(code_examples: [{ title: 'Force kill', code: 'docker container kill hung-app', explanation: 'Immediately stops unresponsive container' }])
ModuleInteractiveUnit.find_or_create_by!(course_module: containers_module, interactive_learning_unit: unit_31) { |miu| miu.sequence_order = 15; miu.required = true }

# Unit 32: docker container rm
unit_32 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-containers-rm-command') do |u|
  u.title = 'Docker Container RM: Remove Containers'
  u.concept_explanation = 'Permanently delete stopped containers to free disk space and names.'
  u.command_to_learn = 'docker container rm my-container'
  u.command_variations = ['docker container rm -f container', 'docker container rm -v container']
  u.practice_hints = ['Remove: docker container rm <name>', 'Force: docker container rm -f <name>']
  u.scenario_narrative = 'Clean up old test containers to free disk space'
  u.problem_statement = 'Remove stopped containers including their volumes'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 32
  u.category = 'docker-containers'
  u.published = true
  u.quiz_question_text = 'Can you remove a running container without -f flag?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [{ text: 'No, must stop first or use -f', correct: true }, { text: 'Yes', correct: false }]
  u.quiz_correct_answer = 'No, must stop first or use -f'
  u.quiz_explanation = 'Docker requires containers to be stopped before removal, unless using -f to force.'
  u.concept_tags = ['containers', 'docker-rm', 'cleanup', 'lifecycle']
end

unit_32.update!(code_examples: [{ title: 'Remove container', code: 'docker container rm old-test', explanation: 'Deletes stopped container' }])
ModuleInteractiveUnit.find_or_create_by!(course_module: containers_module, interactive_learning_unit: unit_32) { |miu| miu.sequence_order = 16; miu.required = true }

# Unit 33: docker container inspect
unit_33 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-containers-inspect-command') do |u|
  u.title = 'Docker Container Inspect: Detailed Container Information'
  u.concept_explanation = 'View complete container configuration and state in JSON format.'
  u.command_to_learn = 'docker container inspect my-container'
  u.command_variations = ['docker container inspect --format="{{.State.Status}}" container']
  u.practice_hints = ['Inspect: docker container inspect <name>', 'Format: --format="{{.NetworkSettings.IPAddress}}"']
  u.scenario_narrative = 'Find IP address and network configuration of container'
  u.problem_statement = 'Extract specific configuration details using inspect'
  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 33
  u.category = 'docker-containers'
  u.published = true
  u.quiz_question_text = 'What format does docker inspect output?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [{ text: 'JSON', correct: true }, { text: 'YAML', correct: false }]
  u.quiz_correct_answer = 'JSON'
  u.quiz_explanation = 'docker inspect outputs detailed information in JSON format.'
  u.concept_tags = ['containers', 'docker-inspect', 'configuration', 'debugging']
end

unit_33.update!(code_examples: [{ title: 'Inspect container', code: 'docker container inspect web', explanation: 'Shows complete configuration as JSON' }])
ModuleInteractiveUnit.find_or_create_by!(course_module: containers_module, interactive_learning_unit: unit_33) { |miu| miu.sequence_order = 17; miu.required = true }

# Unit 34: docker container logs
unit_34 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-containers-logs-command') do |u|
  u.title = 'Docker Container Logs: View Container Output'
  u.concept_explanation = 'Display stdout and stderr output from containers for debugging and monitoring.'
  u.command_to_learn = 'docker container logs my-container'
  u.command_variations = ['docker container logs -f container', 'docker container logs --tail 100 container']
  u.practice_hints = ['View logs: docker container logs <name>', 'Follow: docker container logs -f <name>']
  u.scenario_narrative = 'Debug application crash by examining container logs'
  u.problem_statement = 'View and follow container logs to identify errors'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 34
  u.category = 'docker-containers'
  u.published = true
  u.quiz_question_text = 'Which flag makes docker logs follow new output?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [{ text: '-f', correct: true }, { text: '-t', correct: false }]
  u.quiz_correct_answer = '-f'
  u.quiz_explanation = 'The -f flag follows log output in real-time, like tail -f.'
  u.concept_tags = ['containers', 'docker-logs', 'debugging', 'monitoring']
end

unit_34.update!(code_examples: [{ title: 'View logs', code: 'docker container logs api', explanation: 'Shows all container output' }])
ModuleInteractiveUnit.find_or_create_by!(course_module: containers_module, interactive_learning_unit: unit_34) { |miu| miu.sequence_order = 18; miu.required = true }

# Unit 35: docker container exec
unit_35 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-containers-exec-command') do |u|
  u.title = 'Docker Container Exec: Run Commands in Container'
  u.concept_explanation = 'Execute commands inside running containers for debugging and maintenance.'
  u.command_to_learn = 'docker container exec -it my-container bash'
  u.command_variations = ['docker container exec container ls -la', 'docker container exec -u root container apt-get update']
  u.practice_hints = ['Shell: docker container exec -it <name> bash', 'Command: docker container exec <name> <command>']
  u.scenario_narrative = 'Access production container to debug live issues'
  u.problem_statement = 'Execute commands in running container for troubleshooting'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 35
  u.category = 'docker-containers'
  u.published = true
  u.quiz_question_text = 'What does -it flag do in docker exec?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [{ text: 'Provides interactive terminal', correct: true }, { text: 'Installs tools', correct: false }]
  u.quiz_correct_answer = 'Provides interactive terminal'
  u.quiz_explanation = '-i keeps STDIN open, -t allocates TTY - together they create interactive terminal.'
  u.concept_tags = ['containers', 'docker-exec', 'debugging', 'interactive']
end

unit_35.update!(code_examples: [{ title: 'Interactive shell', code: 'docker container exec -it web bash', explanation: 'Opens bash shell in container' }])
ModuleInteractiveUnit.find_or_create_by!(course_module: containers_module, interactive_learning_unit: unit_35) { |miu| miu.sequence_order = 19; miu.required = true }

# Unit 36: docker container attach
unit_36 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-containers-attach-command') do |u|
  u.title = 'Docker Container Attach: Connect to Container'
  u.concept_explanation = 'Attach to container\'s main process to view output and send input.'
  u.command_to_learn = 'docker container attach my-container'
  u.command_variations = ['docker container attach --sig-proxy=false container']
  u.practice_hints = ['Attach: docker container attach <name>', 'Detach: Ctrl+P then Ctrl+Q']
  u.scenario_narrative = 'Attach to foreground container to view live output'
  u.problem_statement = 'Connect to container to see stdout in real-time'
  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 36
  u.category = 'docker-containers'
  u.published = true
  u.quiz_question_text = 'Difference between attach and exec?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [{ text: 'attach connects to main process, exec starts new', correct: true }, { text: 'They are same', correct: false }]
  u.quiz_correct_answer = 'attach connects to main process, exec starts new'
  u.quiz_explanation = 'attach connects to PID 1, exec starts new process in container.'
  u.concept_tags = ['containers', 'docker-attach', 'debugging', 'interactive']
end

unit_36.update!(code_examples: [{ title: 'Attach to container', code: 'docker container attach app', explanation: 'Connects to main process output' }])
ModuleInteractiveUnit.find_or_create_by!(course_module: containers_module, interactive_learning_unit: unit_36) { |miu| miu.sequence_order = 20; miu.required = true }

# Unit 37: docker container wait
unit_37 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-containers-wait-command') do |u|
  u.title = 'Docker Container Wait: Block Until Container Stops'
  u.concept_explanation = 'Block until container stops and return its exit code - useful in scripts.'
  u.command_to_learn = 'docker container wait my-container'
  u.command_variations = ['docker container wait container1 container2']
  u.practice_hints = ['Wait: docker container wait <name>', 'Returns exit code when stopped']
  u.scenario_narrative = 'Wait for batch job to complete before next step'
  u.problem_statement = 'Block script until container completes and get exit code'
  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 37
  u.category = 'docker-containers'
  u.published = true
  u.quiz_question_text = 'What does docker wait return?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [{ text: 'Exit code of container', correct: true }, { text: 'Container ID', correct: false }]
  u.quiz_correct_answer = 'Exit code of container'
  u.quiz_explanation = 'docker wait blocks until container stops and returns exit code (0=success).'
  u.concept_tags = ['containers', 'docker-wait', 'scripting', 'automation']
end

unit_37.update!(code_examples: [{ title: 'Wait for completion', code: 'docker container wait batch-job', explanation: 'Blocks until container exits' }])
ModuleInteractiveUnit.find_or_create_by!(course_module: containers_module, interactive_learning_unit: unit_37) { |miu| miu.sequence_order = 21; miu.required = true }

puts "✓ Created 21 Docker Containers interactive learning units"
puts "  - Unit 17: docker container prune"
puts "  - Unit 18: docker cp"
puts "  - Unit 19: docker diff"
puts "  - Unit 20: docker export"
puts "  - Unit 21: docker stats"
puts "  - Unit 22: docker top"
puts "  - Unit 23: docker update"
puts "  - Unit 24: docker port"
puts "  - Unit 25: docker rename"
puts "  - Unit 26: docker container ls"
puts "  - Unit 27: docker container create"
puts "  - Unit 28: docker container start"
puts "  - Unit 29: docker container stop"
puts "  - Unit 30: docker container restart"
puts "  - Unit 31: docker container kill"
puts "  - Unit 32: docker container rm"
puts "  - Unit 33: docker container inspect"
puts "  - Unit 34: docker container logs"
puts "  - Unit 35: docker container exec"
puts "  - Unit 36: docker container attach"
puts "  - Unit 37: docker container wait"
puts ""
puts "All units include:"
puts "  ✓ Comprehensive concept explanations"
puts "  ✓ Command variations and examples"
puts "  ✓ Progressive practice hints"
puts "  ✓ Scenario narratives"
puts "  ✓ Problem statements"
puts "  ✓ MCQ quizzes with explanations"
puts "  ✓ Code examples with explanations"
puts "  ✓ Concept tags for remediation"
puts "  ✓ Associated with container-management module"