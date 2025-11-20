puts "Creating Docker Volumes Interactive Learning Units..."

course = Course.find_by(slug: 'docker-fundamentals')
volumes_module = course.course_modules.find_or_create_by!(slug: 'docker-volumes') do |m|
  m.title = "Docker Volumes"
  m.description = "Master Docker volume management and data persistence"
  m.sequence_order = 6
  m.estimated_minutes = 140
  m.published = true
end

# Unit 64: docker volume create
unit_64 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-volume-create') do |u|
  u.title = 'Docker Volume Create'
  u.concept_explanation = 'Create named volumes for persistent data storage'
  u.command_to_learn = 'docker volume create my-volume'
  u.command_variations = ['docker volume create --driver local my-volume', 'docker volume create --label env=production my-volume']
  u.practice_hints = ['Create volume: docker volume create <name>', 'Specify driver: --driver <type>', 'Add labels: --label <key>=<value>']
  u.scenario_narrative = 'Create a persistent volume for database data'
  u.problem_statement = 'Create a named volume for data persistence'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 64
  u.category = 'docker-volumes'
  u.published = true
  u.quiz_question_text = 'Why use named volumes instead of bind mounts?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Volumes are managed by Docker and work across platforms', correct: true },
    { text: 'Bind mounts are slower', correct: false },
    { text: 'Volumes require root access', correct: false },
    { text: 'Bind mounts cannot be shared', correct: false }
  ]
  u.quiz_correct_answer = 'Volumes are managed by Docker and work across platforms'
  u.quiz_explanation = 'Named volumes are managed by Docker, work consistently across different platforms, and can be easily backed up and migrated.'
  u.concept_tags = ['volumes', 'docker-volume', 'persistence', 'storage']
end

unit_64.update!(
  code_examples: [
    { title: 'Create basic volume', code: 'docker volume create data-volume', explanation: 'Creates a named volume managed by Docker' },
    { title: 'Create with labels', code: 'docker volume create --label app=database --label env=prod db-data', explanation: 'Creates volume with metadata labels for organization' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: volumes_module,
  interactive_learning_unit: unit_64
) do |miu|
  miu.sequence_order = 1
  miu.required = true
end

# Unit 65: docker volume ls
unit_65 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-volume-ls') do |u|
  u.title = 'Docker Volume List'
  u.concept_explanation = 'List all Docker volumes on the system'
  u.command_to_learn = 'docker volume ls'
  u.command_variations = ['docker volume list', 'docker volume ls --filter dangling=true']
  u.practice_hints = ['List volumes: docker volume ls', 'Find dangling: --filter dangling=true', 'Filter by label: --filter label=<key>=<value>']
  u.scenario_narrative = 'Check existing volumes before creating new ones'
  u.problem_statement = 'Display all Docker volumes on the system'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 65
  u.category = 'docker-volumes'
  u.published = true
  u.quiz_question_text = 'What is a dangling volume?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'A volume not attached to any container', correct: true },
    { text: 'A volume with corrupted data', correct: false },
    { text: 'A volume that is full', correct: false },
    { text: 'A volume without a name', correct: false }
  ]
  u.quiz_correct_answer = 'A volume not attached to any container'
  u.quiz_explanation = 'Dangling volumes are volumes that are no longer referenced by any container and can be safely removed.'
  u.concept_tags = ['volumes', 'docker-volume', 'listing', 'inspection']
end

unit_65.update!(
  code_examples: [
    { title: 'List all volumes', code: 'docker volume ls', explanation: 'Shows all volumes with driver and name' },
    { title: 'List dangling volumes', code: 'docker volume ls --filter dangling=true', explanation: 'Shows only volumes not used by any container' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: volumes_module,
  interactive_learning_unit: unit_65
) do |miu|
  miu.sequence_order = 2
  miu.required = true
end

# Unit 66: docker volume inspect
unit_66 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-volume-inspect') do |u|
  u.title = 'Docker Volume Inspect'
  u.concept_explanation = 'View detailed information about a volume'
  u.command_to_learn = 'docker volume inspect my-volume'
  u.command_variations = ['docker volume inspect --format="{{.Mountpoint}}" my-volume']
  u.practice_hints = ['Inspect volume: docker volume inspect <name>', 'Get mountpoint: --format="{{.Mountpoint}}"']
  u.scenario_narrative = 'Find the physical location of volume data for backup'
  u.problem_statement = 'View volume configuration and mountpoint location'
  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 66
  u.category = 'docker-volumes'
  u.published = true
  u.quiz_question_text = 'Where does Docker store volume data by default?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: '/var/lib/docker/volumes/', correct: true },
    { text: '/docker/volumes/', correct: false },
    { text: '/tmp/docker/volumes/', correct: false },
    { text: '/opt/docker/volumes/', correct: false }
  ]
  u.quiz_correct_answer = '/var/lib/docker/volumes/'
  u.quiz_explanation = 'Docker stores volume data in /var/lib/docker/volumes/ by default on Linux systems.'
  u.concept_tags = ['volumes', 'docker-volume', 'inspection', 'debugging']
end

unit_66.update!(
  code_examples: [
    { title: 'Inspect volume', code: 'docker volume inspect data-volume', explanation: 'Shows full JSON details of the volume' },
    { title: 'Get mountpoint', code: 'docker volume inspect --format="{{.Mountpoint}}" data-volume', explanation: 'Extracts just the filesystem path' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: volumes_module,
  interactive_learning_unit: unit_66
) do |miu|
  miu.sequence_order = 3
  miu.required = true
end

# Unit 67: docker volume rm
unit_67 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-volume-rm') do |u|
  u.title = 'Docker Volume Remove'
  u.concept_explanation = 'Delete one or more Docker volumes'
  u.command_to_learn = 'docker volume rm my-volume'
  u.command_variations = ['docker volume rm volume1 volume2 volume3']
  u.practice_hints = ['Remove volume: docker volume rm <name>', 'Remove multiple: docker volume rm <name1> <name2>', 'Cannot remove if in use']
  u.scenario_narrative = 'Clean up old volumes to free disk space'
  u.problem_statement = 'Remove unused Docker volumes'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 67
  u.category = 'docker-volumes'
  u.published = true
  u.quiz_question_text = 'Can you remove a volume that is currently mounted to a container?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'No, must remove/stop container first', correct: true },
    { text: 'Yes, container will auto-recreate it', correct: false },
    { text: 'Yes, with -f flag', correct: false },
    { text: 'Only if container is stopped', correct: false }
  ]
  u.quiz_correct_answer = 'No, must remove/stop container first'
  u.quiz_explanation = 'Docker will not remove a volume that is mounted to a running or stopped container. The container must be removed first.'
  u.concept_tags = ['volumes', 'docker-volume', 'cleanup', 'removal']
end

unit_67.update!(
  code_examples: [
    { title: 'Remove volume', code: 'docker volume rm old-data', explanation: 'Permanently deletes the volume and its data' },
    { title: 'Remove multiple', code: 'docker volume rm vol1 vol2 vol3', explanation: 'Removes multiple volumes in one command' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: volumes_module,
  interactive_learning_unit: unit_67
) do |miu|
  miu.sequence_order = 4
  miu.required = true
end

# Unit 68: docker volume prune
unit_68 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-volume-prune') do |u|
  u.title = 'Docker Volume Prune'
  u.concept_explanation = 'Remove all unused volumes in one command'
  u.command_to_learn = 'docker volume prune'
  u.command_variations = ['docker volume prune -f', 'docker volume prune --filter label=temporary=true']
  u.practice_hints = ['Prune volumes: docker volume prune', 'Skip confirmation: -f flag', 'Filter by label: --filter label=<key>=<value>']
  u.scenario_narrative = 'Perform routine cleanup of dangling volumes'
  u.problem_statement = 'Remove all unused volumes to reclaim disk space'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 68
  u.category = 'docker-volumes'
  u.published = true
  u.quiz_question_text = 'What volumes does docker volume prune remove?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Only volumes not referenced by any container', correct: true },
    { text: 'All anonymous volumes', correct: false },
    { text: 'All named volumes', correct: false },
    { text: 'Volumes older than 24 hours', correct: false }
  ]
  u.quiz_correct_answer = 'Only volumes not referenced by any container'
  u.quiz_explanation = 'docker volume prune only removes volumes that are not currently mounted to any container (dangling volumes).'
  u.concept_tags = ['volumes', 'docker-volume', 'cleanup', 'prune', 'maintenance']
end

unit_68.update!(
  code_examples: [
    { title: 'Prune unused volumes', code: 'docker volume prune', explanation: 'Interactively removes all dangling volumes' },
    { title: 'Force prune', code: 'docker volume prune -f', explanation: 'Removes dangling volumes without confirmation' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: volumes_module,
  interactive_learning_unit: unit_68
) do |miu|
  miu.sequence_order = 5
  miu.required = true
end

# Unit 69: Using volumes with containers
unit_69 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-run-with-volume') do |u|
  u.title = 'Docker Run with Volumes'
  u.concept_explanation = 'Mount volumes to containers for persistent data'
  u.command_to_learn = 'docker run -v my-volume:/data nginx'
  u.command_variations = ['docker run -v my-volume:/app/data:ro nginx', 'docker run --mount source=my-volume,target=/data nginx']
  u.practice_hints = ['Mount volume: -v <volume>:<container-path>', 'Read-only: -v <volume>:<path>:ro', 'New syntax: --mount source=<vol>,target=<path>']
  u.scenario_narrative = 'Run a database container with persistent storage'
  u.problem_statement = 'Mount a volume to a container for data persistence'
  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 69
  u.category = 'docker-volumes'
  u.published = true
  u.quiz_question_text = 'What happens to data in a volume when you remove the container?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Data persists in the volume', correct: true },
    { text: 'Data is deleted automatically', correct: false },
    { text: 'Data is backed up first', correct: false },
    { text: 'Depends on the --rm flag', correct: false }
  ]
  u.quiz_correct_answer = 'Data persists in the volume'
  u.quiz_explanation = 'Volume data persists independently of container lifecycle. Even when containers are removed, the data remains in the volume.'
  u.concept_tags = ['volumes', 'docker-run', 'persistence', 'mounting']
end

unit_69.update!(
  code_examples: [
    { title: 'Mount named volume', code: 'docker run -d -v db-data:/var/lib/mysql mysql', explanation: 'Mounts db-data volume to MySQL data directory' },
    { title: 'Read-only mount', code: 'docker run -v config-vol:/app/config:ro nginx', explanation: 'Mounts volume as read-only to prevent modifications' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: volumes_module,
  interactive_learning_unit: unit_69
) do |miu|
  miu.sequence_order = 6
  miu.required = true
end

# Unit 70: Bind mounts vs volumes
unit_70 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-bind-mounts-vs-volumes') do |u|
  u.title = 'Bind Mounts vs Volumes'
  u.concept_explanation = 'Understand the differences between bind mounts and volumes'
  u.command_to_learn = 'docker run -v /host/path:/container/path nginx'
  u.command_variations = ['docker run -v $(pwd):/app nginx', 'docker run --mount type=bind,source=/host/path,target=/container/path nginx']
  u.practice_hints = ['Bind mount: -v /absolute/host/path:/container/path', 'Current dir: -v $(pwd):/app', 'Explicit: --mount type=bind,source=...,target=...']
  u.scenario_narrative = 'Choose between bind mounts for development and volumes for production'
  u.problem_statement = 'Understand when to use bind mounts vs volumes'
  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 70
  u.category = 'docker-volumes'
  u.published = true
  u.quiz_question_text = 'When should you use bind mounts instead of volumes?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'During development to sync code changes', correct: true },
    { text: 'For production databases', correct: false },
    { text: 'For better performance', correct: false },
    { text: 'For cross-platform compatibility', correct: false }
  ]
  u.quiz_correct_answer = 'During development to sync code changes'
  u.quiz_explanation = 'Bind mounts are ideal for development when you want file changes to immediately reflect in containers. Volumes are better for production data.'
  u.concept_tags = ['volumes', 'bind-mounts', 'comparison', 'best-practices']
end

unit_70.update!(
  code_examples: [
    { title: 'Bind mount current directory', code: 'docker run -v $(pwd):/app node:14 npm start', explanation: 'Mounts current directory for live code updates during development' },
    { title: 'Named volume for data', code: 'docker run -v postgres-data:/var/lib/postgresql/data postgres', explanation: 'Uses managed volume for database persistence in production' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: volumes_module,
  interactive_learning_unit: unit_70
) do |miu|
  miu.sequence_order = 7
  miu.required = true
end

puts "✓ Created 7 Docker Volumes interactive learning units (sequences 64-70)"