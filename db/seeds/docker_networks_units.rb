puts "Creating Docker Networks Interactive Learning Units..."

course = Course.find_by(slug: 'docker-fundamentals')
networks_module = course.course_modules.find_or_create_by!(slug: 'docker-networking') do |m|
  m.title = "Docker Networking"
  m.description = "Master Docker network creation and management"
  m.sequence_order = 5
  m.estimated_minutes = 160
  m.published = true
end

# Unit 57: docker network create
unit_57 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-network-create') do |u|
  u.title = 'Docker Network Create'
  u.concept_explanation = 'Create custom Docker networks for container communication'
  u.command_to_learn = 'docker network create my-network'
  u.command_variations = ['docker network create --driver bridge my-network', 'docker network create --subnet 172.18.0.0/16 my-network']
  u.practice_hints = ['Create network: docker network create <name>', 'Specify driver: --driver bridge', 'Set subnet: --subnet <cidr>']
  u.scenario_narrative = 'Create an isolated network for microservices'
  u.problem_statement = 'Create a custom bridge network for service isolation'
  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 57
  u.category = 'docker-networks'
  u.published = true
  u.quiz_question_text = 'What is the default network driver in Docker?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'bridge', correct: true },
    { text: 'host', correct: false },
    { text: 'overlay', correct: false },
    { text: 'macvlan', correct: false }
  ]
  u.quiz_correct_answer = 'bridge'
  u.quiz_explanation = 'The bridge driver is the default network driver. If you don\'t specify a driver, this is the type of network you are creating.'
  u.concept_tags = ['networking', 'docker-network', 'bridge', 'isolation']
end

unit_57.update!(
  code_examples: [
    { title: 'Create basic network', code: 'docker network create my-app-network', explanation: 'Creates a bridge network with default settings' },
    { title: 'Create with subnet', code: 'docker network create --subnet 172.18.0.0/16 --gateway 172.18.0.1 my-network', explanation: 'Specifies custom IP range for the network' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: networks_module,
  interactive_learning_unit: unit_57
) do |miu|
  miu.sequence_order = 1
  miu.required = true
end

# Unit 58: docker network ls
unit_58 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-network-ls') do |u|
  u.title = 'Docker Network List'
  u.concept_explanation = 'List all Docker networks on the system'
  u.command_to_learn = 'docker network ls'
  u.command_variations = ['docker network list', 'docker network ls --filter driver=bridge']
  u.practice_hints = ['List networks: docker network ls', 'Filter by driver: --filter driver=<type>']
  u.scenario_narrative = 'Check what networks exist before creating new ones'
  u.problem_statement = 'Display all available Docker networks'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 58
  u.category = 'docker-networks'
  u.published = true
  u.quiz_question_text = 'Which default networks are created by Docker?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'bridge, host, none', correct: true },
    { text: 'default, public, private', correct: false },
    { text: 'bridge, overlay', correct: false },
    { text: 'nat, bridge', correct: false }
  ]
  u.quiz_correct_answer = 'bridge, host, none'
  u.quiz_explanation = 'Docker creates three default networks: bridge (default for containers), host (no isolation), and none (no networking).'
  u.concept_tags = ['networking', 'docker-network', 'listing', 'inspection']
end

unit_58.update!(
  code_examples: [
    { title: 'List all networks', code: 'docker network ls', explanation: 'Shows all networks with their driver types' },
    { title: 'Filter by driver', code: 'docker network ls --filter driver=bridge', explanation: 'Shows only bridge networks' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: networks_module,
  interactive_learning_unit: unit_58
) do |miu|
  miu.sequence_order = 2
  miu.required = true
end

# Unit 59: docker network inspect
unit_59 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-network-inspect') do |u|
  u.title = 'Docker Network Inspect'
  u.concept_explanation = 'View detailed network configuration and connected containers'
  u.command_to_learn = 'docker network inspect my-network'
  u.command_variations = ['docker network inspect --format="{{.IPAM.Config}}" my-network']
  u.practice_hints = ['Inspect network: docker network inspect <name>', 'Format output: --format="{{.Field}}"']
  u.scenario_narrative = 'Debug connectivity issues by inspecting network details'
  u.problem_statement = 'View network configuration and connected containers'
  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 59
  u.category = 'docker-networks'
  u.published = true
  u.quiz_question_text = 'What information does docker network inspect provide?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Network configuration, subnet, and connected containers', correct: true },
    { text: 'Only container names', correct: false },
    { text: 'Only IP addresses', correct: false },
    { text: 'Only network driver', correct: false }
  ]
  u.quiz_correct_answer = 'Network configuration, subnet, and connected containers'
  u.quiz_explanation = 'docker network inspect shows complete network details including subnet, gateway, connected containers, and their IP addresses.'
  u.concept_tags = ['networking', 'docker-network', 'inspection', 'debugging']
end

unit_59.update!(
  code_examples: [
    { title: 'Inspect network', code: 'docker network inspect bridge', explanation: 'Shows full JSON configuration of bridge network' },
    { title: 'Get subnet info', code: 'docker network inspect --format="{{range .IPAM.Config}}{{.Subnet}}{{end}}" my-network', explanation: 'Extracts just the subnet information' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: networks_module,
  interactive_learning_unit: unit_59
) do |miu|
  miu.sequence_order = 3
  miu.required = true
end

# Unit 60: docker network connect
unit_60 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-network-connect') do |u|
  u.title = 'Docker Network Connect'
  u.concept_explanation = 'Connect a running container to a network'
  u.command_to_learn = 'docker network connect my-network my-container'
  u.command_variations = ['docker network connect --ip 172.18.0.22 my-network my-container', 'docker network connect --alias db my-network my-container']
  u.practice_hints = ['Connect container: docker network connect <network> <container>', 'Assign IP: --ip <address>', 'Add alias: --alias <name>']
  u.scenario_narrative = 'Add a container to an additional network for multi-network communication'
  u.problem_statement = 'Connect a running container to a custom network'
  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 60
  u.category = 'docker-networks'
  u.published = true
  u.quiz_question_text = 'Can a container be connected to multiple networks?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Yes, containers can join multiple networks', correct: true },
    { text: 'No, only one network per container', correct: false },
    { text: 'Only in swarm mode', correct: false },
    { text: 'Only with overlay networks', correct: false }
  ]
  u.quiz_correct_answer = 'Yes, containers can join multiple networks'
  u.quiz_explanation = 'Containers can be connected to multiple networks simultaneously, allowing flexible network topologies.'
  u.concept_tags = ['networking', 'docker-network', 'connect', 'multi-network']
end

unit_60.update!(
  code_examples: [
    { title: 'Connect to network', code: 'docker network connect frontend-net web-server', explanation: 'Connects web-server container to frontend-net network' },
    { title: 'Connect with IP', code: 'docker network connect --ip 172.18.0.10 app-net api-server', explanation: 'Connects with specific IP address assignment' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: networks_module,
  interactive_learning_unit: unit_60
) do |miu|
  miu.sequence_order = 4
  miu.required = true
end

# Unit 61: docker network disconnect
unit_61 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-network-disconnect') do |u|
  u.title = 'Docker Network Disconnect'
  u.concept_explanation = 'Disconnect a container from a network'
  u.command_to_learn = 'docker network disconnect my-network my-container'
  u.command_variations = ['docker network disconnect -f my-network my-container']
  u.practice_hints = ['Disconnect: docker network disconnect <network> <container>', 'Force disconnect: -f flag']
  u.scenario_narrative = 'Remove container from network for security isolation'
  u.problem_statement = 'Disconnect a container from a specific network'
  u.difficulty_level = 'medium'
  u.estimated_minutes = 10
  u.sequence_order = 61
  u.category = 'docker-networks'
  u.published = true
  u.quiz_question_text = 'What happens when you disconnect a container from its only network?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Container loses all network connectivity', correct: true },
    { text: 'Container is automatically stopped', correct: false },
    { text: 'Container joins the bridge network', correct: false },
    { text: 'Operation fails', correct: false }
  ]
  u.quiz_correct_answer = 'Container loses all network connectivity'
  u.quiz_explanation = 'Disconnecting a container from its only network leaves it without any network connectivity until connected to another network.'
  u.concept_tags = ['networking', 'docker-network', 'disconnect', 'isolation']
end

unit_61.update!(
  code_examples: [
    { title: 'Disconnect from network', code: 'docker network disconnect backend-net api-server', explanation: 'Removes api-server from backend-net network' },
    { title: 'Force disconnect', code: 'docker network disconnect -f frontend-net web-server', explanation: 'Forces disconnection even if container is running' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: networks_module,
  interactive_learning_unit: unit_61
) do |miu|
  miu.sequence_order = 5
  miu.required = true
end

# Unit 62: docker network rm
unit_62 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-network-rm') do |u|
  u.title = 'Docker Network Remove'
  u.concept_explanation = 'Delete one or more Docker networks'
  u.command_to_learn = 'docker network rm my-network'
  u.command_variations = ['docker network rm network1 network2 network3', 'docker network prune']
  u.practice_hints = ['Remove network: docker network rm <name>', 'Remove multiple: docker network rm <name1> <name2>', 'Remove unused: docker network prune']
  u.scenario_narrative = 'Clean up unused networks to free resources'
  u.problem_statement = 'Remove a Docker network that is no longer needed'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 62
  u.category = 'docker-networks'
  u.published = true
  u.quiz_question_text = 'Can you remove a network with containers still connected?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'No, must disconnect all containers first', correct: true },
    { text: 'Yes, containers auto-disconnect', correct: false },
    { text: 'Yes, with -f flag', correct: false },
    { text: 'Only if containers are stopped', correct: false }
  ]
  u.quiz_correct_answer = 'No, must disconnect all containers first'
  u.quiz_explanation = 'Docker will not remove a network that has active container connections. All containers must be disconnected or removed first.'
  u.concept_tags = ['networking', 'docker-network', 'cleanup', 'removal']
end

unit_62.update!(
  code_examples: [
    { title: 'Remove network', code: 'docker network rm test-network', explanation: 'Deletes the test-network if no containers are connected' },
    { title: 'Remove unused networks', code: 'docker network prune -f', explanation: 'Removes all networks not used by any container' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: networks_module,
  interactive_learning_unit: unit_62
) do |miu|
  miu.sequence_order = 6
  miu.required = true
end

# Unit 63: docker network prune
unit_63 = InteractiveLearningUnit.find_or_create_by!(slug: 'docker-network-prune') do |u|
  u.title = 'Docker Network Prune'
  u.concept_explanation = 'Remove all unused Docker networks in one command'
  u.command_to_learn = 'docker network prune'
  u.command_variations = ['docker network prune -f', 'docker network prune --filter until=24h']
  u.practice_hints = ['Prune networks: docker network prune', 'Skip confirmation: -f flag', 'Filter by age: --filter until=<time>']
  u.scenario_narrative = 'Perform routine cleanup of unused networks'
  u.problem_statement = 'Remove all unused networks to reclaim resources'
  u.difficulty_level = 'easy'
  u.estimated_minutes = 10
  u.sequence_order = 63
  u.category = 'docker-networks'
  u.published = true
  u.quiz_question_text = 'What does docker network prune remove?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Only networks not used by any container', correct: true },
    { text: 'All custom networks', correct: false },
    { text: 'All networks including defaults', correct: false },
    { text: 'Only networks older than 1 day', correct: false }
  ]
  u.quiz_correct_answer = 'Only networks not used by any container'
  u.quiz_explanation = 'docker network prune only removes networks that are not currently connected to any container. Default networks and active networks are preserved.'
  u.concept_tags = ['networking', 'docker-network', 'cleanup', 'prune', 'maintenance']
end

unit_63.update!(
  code_examples: [
    { title: 'Prune unused networks', code: 'docker network prune', explanation: 'Interactively removes all unused networks' },
    { title: 'Force prune', code: 'docker network prune -f', explanation: 'Removes unused networks without confirmation prompt' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: networks_module,
  interactive_learning_unit: unit_63
) do |miu|
  miu.sequence_order = 7
  miu.required = true
end

puts "✓ Created 7 Docker Networks interactive learning units (sequences 57-63)"