puts "Creating Docker Swarm Interactive Learning Units..."

course = Course.find_by(slug: 'docker-fundamentals')
swarm_module = course.course_modules.find_or_create_by!(slug: 'docker-swarm') do |m|
  m.title = "Docker Swarm"
  m.description = "Master Docker Swarm orchestration and clustering"
  m.sequence_order = 7
  m.estimated_minutes = 520
  m.published = true
end

# Helper method to create units efficiently
def create_swarm_unit(slug, title, sequence, concept, command, variations, hints, scenario, problem, difficulty, minutes, quiz_text, quiz_options, correct_answer, explanation, tags, code_examples)
  unit = InteractiveLearningUnit.find_or_create_by!(slug: slug) do |u|
    u.title = title
    u.concept_explanation = concept
    u.command_to_learn = command
    u.command_variations = variations
    u.practice_hints = hints
    u.scenario_narrative = scenario
    u.problem_statement = problem
    u.difficulty_level = difficulty
    u.estimated_minutes = minutes
    u.sequence_order = sequence
    u.category = 'docker-swarm'
    u.published = true
    u.quiz_question_text = quiz_text
    u.quiz_question_type = 'mcq'
    u.quiz_options = quiz_options
    u.quiz_correct_answer = correct_answer
    u.quiz_explanation = explanation
    u.concept_tags = tags
  end
  
  unit.update!(code_examples: code_examples) if code_examples.any?
  unit
end

# Unit 72: docker swarm init
unit_72 = create_swarm_unit(
  'docker-swarm-init',
  'Docker Swarm Init',
  72,
  'Initialize a Docker Swarm cluster and become a manager node',
  'docker swarm init',
  ['docker swarm init --advertise-addr <ip>', 'docker swarm init --listen-addr <ip>:2377'],
  ['Initialize swarm: docker swarm init', 'Specify address: --advertise-addr <ip>', 'Set listen address: --listen-addr <ip>:2377'],
  'Set up a new Docker Swarm cluster for container orchestration',
  'Initialize a Docker Swarm cluster',
  'medium',
  20,
  'What happens when you run docker swarm init?',
  [
    { text: 'Current node becomes swarm manager', correct: true },
    { text: 'Creates worker node', correct: false },
    { text: 'Joins existing swarm', correct: false },
    { text: 'Removes current swarm', correct: false }
  ],
  'Current node becomes swarm manager',
  'docker swarm init transforms the current Docker host into a Swarm manager node and creates a new swarm cluster.',
  ['swarm', 'orchestration', 'clustering', 'initialization'],
  [
    { title: 'Initialize swarm', code: 'docker swarm init', explanation: 'Creates new swarm with current node as manager' },
    { title: 'Init with specific IP', code: 'docker swarm init --advertise-addr 192.168.1.100', explanation: 'Specifies IP address for swarm communication' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: swarm_module,
  interactive_learning_unit: unit_72
) do |miu|
  miu.sequence_order = 1
  miu.required = true
end

# Unit 73: docker swarm join
unit_73 = create_swarm_unit(
  'docker-swarm-join',
  'Docker Swarm Join',
  73,
  'Join a Docker host to an existing swarm as worker or manager',
  'docker swarm join --token <token> <manager-ip>:2377',
  ['docker swarm join --token <worker-token> <ip>:2377', 'docker swarm join --token <manager-token> <ip>:2377'],
  ['Join as worker: docker swarm join --token <token> <ip>:2377', 'Get token from manager first', 'Use manager token to join as manager'],
  'Add worker nodes to expand swarm capacity',
  'Join additional nodes to the swarm cluster',
  'medium',
  20,
  'What do you need to join a swarm?',
  [
    { text: 'Join token and manager IP address', correct: true },
    { text: 'Only manager IP', correct: false },
    { text: 'Root password', correct: false },
    { text: 'Swarm name', correct: false }
  ],
  'Join token and manager IP address',
  'To join a swarm, you need the join token (from manager) and the manager node IP address with port 2377.',
  ['swarm', 'clustering', 'nodes', 'scaling'],
  [
    { title: 'Join as worker', code: 'docker swarm join --token SWMTKN-1-xxx manager-ip:2377', explanation: 'Joins swarm as worker node using worker token' }
  ]
)

ModuleInteractiveUnit.find_or_create_by!(
  course_module: swarm_module,
  interactive_learning_unit: unit_73
) do |miu|
  miu.sequence_order = 2
  miu.required = true
end

# Create remaining units 74-97 with abbreviated content
(74..97).each do |seq|
  unit_data = case seq
  when 74 then ['docker-swarm-leave', 'Docker Swarm Leave', 'Leave a swarm cluster', 'docker swarm leave']
  when 75 then ['docker-node-ls', 'Docker Node List', 'List all nodes in the swarm', 'docker node ls']
  when 76 then ['docker-node-inspect', 'Docker Node Inspect', 'View detailed node information', 'docker node inspect <node>']
  when 77 then ['docker-node-update', 'Docker Node Update', 'Update node attributes', 'docker node update <node>']
  when 78 then ['docker-node-promote', 'Docker Node Promote', 'Promote worker to manager', 'docker node promote <node>']
  when 79 then ['docker-node-demote', 'Docker Node Demote', 'Demote manager to worker', 'docker node demote <node>']
  when 80 then ['docker-node-rm', 'Docker Node Remove', 'Remove node from swarm', 'docker node rm <node>']
  when 81 then ['docker-service-create', 'Docker Service Create', 'Create a new service in swarm', 'docker service create <image>']
  when 82 then ['docker-service-ls', 'Docker Service List', 'List all services in swarm', 'docker service ls']
  when 83 then ['docker-service-ps', 'Docker Service PS', 'List tasks of a service', 'docker service ps <service>']
  when 84 then ['docker-service-inspect', 'Docker Service Inspect', 'View service configuration', 'docker service inspect <service>']
  when 85 then ['docker-service-logs', 'Docker Service Logs', 'View service logs', 'docker service logs <service>']
  when 86 then ['docker-service-scale', 'Docker Service Scale', 'Scale service replicas', 'docker service scale <service>=<num>']
  when 87 then ['docker-service-update', 'Docker Service Update', 'Update service configuration', 'docker service update <service>']
  when 88 then ['docker-service-rollback', 'Docker Service Rollback', 'Rollback service update', 'docker service rollback <service>']
  when 89 then ['docker-service-rm', 'Docker Service Remove', 'Remove a service', 'docker service rm <service>']
  when 90 then ['docker-stack-deploy', 'Docker Stack Deploy', 'Deploy stack from compose file', 'docker stack deploy -c <file> <stack>']
  when 91 then ['docker-stack-ls', 'Docker Stack List', 'List all stacks', 'docker stack ls']
  when 92 then ['docker-stack-ps', 'Docker Stack PS', 'List stack tasks', 'docker stack ps <stack>']
  when 93 then ['docker-stack-services', 'Docker Stack Services', 'List stack services', 'docker stack services <stack>']
  when 94 then ['docker-stack-rm', 'Docker Stack Remove', 'Remove a stack', 'docker stack rm <stack>']
  when 95 then ['docker-secret-create', 'Docker Secret Create', 'Create a secret', 'docker secret create <name> <file>']
  when 96 then ['docker-config-create', 'Docker Config Create', 'Create a config', 'docker config create <name> <file>']
  when 97 then ['docker-swarm-update', 'Docker Swarm Update', 'Update swarm configuration', 'docker swarm update']
  end
  
  unit = create_swarm_unit(
    unit_data[0],
    unit_data[1],
    seq,
    unit_data[2],
    unit_data[3],
    [],
    ["Use #{unit_data[3]}"],
    "Complete swarm orchestration task using #{unit_data[1]}",
    unit_data[2],
    'medium',
    20,
    "What does #{unit_data[1]} do?",
    [
      { text: unit_data[2], correct: true },
      { text: 'Different operation', correct: false }
    ],
    unit_data[2],
    "#{unit_data[1]} command is used to #{unit_data[2].downcase} in Docker Swarm.",
    ['swarm', 'orchestration'],
    []
  )
  
  ModuleInteractiveUnit.find_or_create_by!(
    course_module: swarm_module,
    interactive_learning_unit: unit
  ) do |miu|
    miu.sequence_order = seq - 71
    miu.required = true
  end
end

puts "✓ Created 26 Docker Swarm interactive learning units (sequences 72-97)"