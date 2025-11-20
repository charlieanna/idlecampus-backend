# Drill Generator Service
# Generates personalized practice drills for commands that need improvement
# Uses spaced repetition and progressive difficulty

class DrillGenerator
  attr_reader :user, :weak_commands

  def initialize(user, weak_commands)
    @user = user
    @weak_commands = weak_commands
  end

  # Generate a complete drill session
  def generate_session
    drills = weak_commands.map { |weak_cmd| generate_drill(weak_cmd) }

    {
      session_id: SecureRandom.uuid,
      user_id: user.id,
      created_at: Time.current,
      drills: drills,
      total_drills: drills.size,
      estimated_time_minutes: calculate_estimated_time(drills),
      difficulty_distribution: calculate_difficulty_distribution(drills)
    }
  end

  # Generate a single drill for a weak command
  def generate_drill(weak_cmd)
    canonical = weak_cmd[:canonical_command]
    current_score = weak_cmd[:current_score] || 0
    attempts = weak_cmd[:total_attempts] || 0

    # Determine drill difficulty based on current performance
    difficulty = determine_drill_difficulty(current_score, attempts)

    # Generate variations and hints
    variations = generate_command_variations(canonical, difficulty)
    hints = generate_progressive_hints(canonical, difficulty)
    explanation = generate_explanation(canonical)

    {
      drill_id: SecureRandom.uuid,
      canonical_command: canonical,
      display_command: variations[:display],
      expected_command: variations[:expected],
      difficulty: difficulty,
      explanation: explanation,
      hints: hints,
      success_criteria: generate_success_criteria(canonical, difficulty),
      max_attempts: 5,
      time_limit_seconds: calculate_time_limit(difficulty),
      points: calculate_points(difficulty),
      current_score: current_score,
      reason: weak_cmd[:reason]
    }
  end

  private

  def determine_drill_difficulty(current_score, attempts)
    # Never attempted = easy (introduce gently)
    return 'easy' if attempts == 0

    # Very low score = easy (rebuild confidence)
    return 'easy' if current_score < 30

    # Low score = medium (standard practice)
    return 'medium' if current_score < 60

    # Close to threshold = hard (push to mastery)
    'hard'
  end

  def generate_command_variations(canonical, difficulty)
    # Get base command structure
    parts = canonical.split(' ')
    base_command = parts[0]

    case difficulty
    when 'easy'
      # Exact command with full explanation
      {
        display: canonical,
        expected: canonical,
        variation_type: 'exact',
        guidance: 'Type the exact command shown above'
      }

    when 'medium'
      # Command with context, may need to infer flags
      {
        display: generate_contextual_prompt(canonical),
        expected: canonical,
        variation_type: 'contextual',
        guidance: 'Complete the task using the appropriate command'
      }

    when 'hard'
      # Scenario-based, must construct command from requirements
      {
        display: generate_scenario_prompt(canonical),
        expected: canonical,
        variation_type: 'scenario',
        guidance: 'Analyze the scenario and construct the correct command'
      }
    end
  end

  def generate_contextual_prompt(canonical)
    # Maps canonical commands to contextual descriptions
    prompts = {
      'docker ps' => 'List all running containers',
      'docker ps -a' => 'Show all containers including stopped ones',
      'docker images' => 'Display all Docker images on this system',
      'docker run -d nginx' => 'Start an nginx container in detached mode',
      'docker stop' => 'Stop a running container',
      'docker rm' => 'Remove a stopped container',
      'kubectl get pods' => 'View all pods in the current namespace',
      'kubectl get nodes' => 'List all nodes in the cluster',
      'ls -la' => 'List all files including hidden ones with details',
      'cd /var/log' => 'Navigate to the log directory',
      'mkdir test' => 'Create a new directory named test',
      'git status' => 'Check the current status of your repository'
    }

    prompts[canonical] || "Execute: #{canonical}"
  end

  def generate_scenario_prompt(canonical)
    # Maps canonical commands to realistic scenarios
    scenarios = {
      'docker ps' => 'You need to check which containers are currently running. What command would you use?',
      'docker ps -a' => 'A container keeps crashing. You need to see ALL containers, including stopped ones. What command?',
      'docker images' => 'Before pulling a new image, you want to see what images are already on your system. What command?',
      'docker run -d nginx' => 'Deploy an nginx web server that runs in the background (detached mode). What command?',
      'docker stop' => 'A container is misbehaving and you need to stop it gracefully. What command?',
      'kubectl get pods' => 'You need to see the status of all pods in your namespace. What kubectl command?',
      'ls -la' => 'You suspect there are hidden configuration files. List ALL files with full details. What command?',
      'git status' => 'Before committing, you want to see which files have been modified. What git command?'
    }

    scenarios[canonical] || "Scenario: #{canonical}"
  end

  def generate_progressive_hints(canonical, difficulty)
    parts = canonical.split(' ')
    base_command = parts[0]
    flags = parts[1..-1]

    hints = []

    # Hint 1: Always show the base command
    hints << "Start with the '#{base_command}' command"

    # Hint 2: Give context about what it does
    case base_command
    when 'docker'
      hints << "This is a Docker command for container management"
    when 'kubectl'
      hints << "This is a Kubernetes command for cluster management"
    when 'git'
      hints << "This is a Git command for version control"
    when 'ls', 'cd', 'mkdir', 'rm'
      hints << "This is a Linux file system command"
    end

    # Hint 3: Mention flags if applicable
    if flags.any?
      if difficulty == 'hard'
        hints << "You'll need to add #{flags.size} #{'flag'.pluralize(flags.size)}"
      else
        hints << "Use the following flags: #{flags.join(' ')}"
      end
    end

    # Hint 4: Show the answer for very hard cases
    if difficulty == 'hard'
      hints << "The exact command is: #{canonical}"
    end

    hints
  end

  def generate_explanation(canonical)
    explanations = {
      'docker ps' => 'Lists all running Docker containers, showing their ID, image, command, status, and ports.',
      'docker ps -a' => 'Shows ALL containers (running and stopped). The -a flag means "all".',
      'docker images' => 'Displays all Docker images stored locally, including repository, tag, and size.',
      'docker run -d nginx' => 'Starts a new nginx container in detached mode (-d runs it in the background).',
      'docker stop' => 'Gracefully stops a running container by sending SIGTERM, then SIGKILL if needed.',
      'docker rm' => 'Removes a stopped container from your system to free up space.',
      'kubectl get pods' => 'Retrieves the status of all pods in the current Kubernetes namespace.',
      'kubectl get nodes' => 'Lists all nodes in your Kubernetes cluster with their status.',
      'ls -la' => 'Lists files with -l (detailed view) and -a (including hidden files).',
      'cd /var/log' => 'Changes the current directory to /var/log where system logs are stored.',
      'mkdir test' => 'Creates a new directory named "test" in the current location.',
      'git status' => 'Shows which files have been modified, staged, or are untracked in your repository.'
    }

    explanations[canonical] || "Command: #{canonical}"
  end

  def generate_success_criteria(canonical, difficulty)
    {
      exact_match: difficulty == 'easy',
      allow_flag_order_variation: difficulty != 'easy',
      case_sensitive: true,
      trim_whitespace: true,
      validation_type: difficulty == 'easy' ? 'exact' : 'semantic'
    }
  end

  def calculate_time_limit(difficulty)
    case difficulty
    when 'easy' then 60      # 1 minute
    when 'medium' then 120   # 2 minutes
    when 'hard' then 180     # 3 minutes
    else 120
    end
  end

  def calculate_points(difficulty)
    case difficulty
    when 'easy' then 10
    when 'medium' then 25
    when 'hard' then 50
    else 25
    end
  end

  def calculate_estimated_time(drills)
    total_seconds = drills.sum { |drill| drill[:time_limit_seconds] }
    (total_seconds / 60.0).ceil
  end

  def calculate_difficulty_distribution(drills)
    distribution = drills.group_by { |d| d[:difficulty] }
                         .transform_values(&:count)

    {
      easy: distribution['easy'] || 0,
      medium: distribution['medium'] || 0,
      hard: distribution['hard'] || 0
    }
  end

  class << self
    # Generate drills for specific mastery level
    def generate_for_mastery_level(user, level)
      case level
      when 'beginner'
        threshold = 30.0
      when 'intermediate'
        threshold = 60.0
      when 'advanced'
        threshold = 80.0
      else
        threshold = 80.0
      end

      weak_commands = user.user_command_masteries
                          .select { |m| MasteryDecayService.new(m).current_decayed_score < threshold }
                          .map do |mastery|
        {
          canonical_command: mastery.canonical_command,
          current_score: MasteryDecayService.new(mastery).current_decayed_score,
          total_attempts: mastery.total_attempts,
          reason: 'targeted_practice'
        }
      end

      new(user, weak_commands).generate_session
    end

    # Generate quick practice session (3-5 drills)
    def generate_quick_session(user)
      masteries = user.user_command_masteries
                      .order('RANDOM()')
                      .limit(5)

      weak_commands = masteries.map do |mastery|
        {
          canonical_command: mastery.canonical_command,
          current_score: MasteryDecayService.new(mastery).current_decayed_score,
          total_attempts: mastery.total_attempts,
          reason: 'quick_practice'
        }
      end

      new(user, weak_commands).generate_session
    end

    # Generate focused drill for single command
    def generate_focused_drill(user, canonical_command)
      mastery = user.user_command_masteries.find_by(canonical_command: canonical_command)

      weak_cmd = if mastery
        {
          canonical_command: canonical_command,
          current_score: MasteryDecayService.new(mastery).current_decayed_score,
          total_attempts: mastery.total_attempts,
          reason: 'focused_practice'
        }
      else
        {
          canonical_command: canonical_command,
          current_score: 0,
          total_attempts: 0,
          reason: 'new_command'
        }
      end

      new(user, [weak_cmd]).generate_drill(weak_cmd)
    end
  end
end
