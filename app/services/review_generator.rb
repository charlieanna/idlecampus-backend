class ReviewGenerator
  # Generate a single-command quick review (30 seconds)
  def self.generate_single_command_review(command_mastery, user)
    command = command_mastery.canonical_command
    original_chapter = get_original_chapter_slug(command)

    # Get actual command from database if it's a chapter slug
    actual_command = get_actual_command(command)

    {
      id: "review-#{command.parameterize}-#{SecureRandom.hex(4)}",
      type: 'quick_review',
      content_type: 'interactive',
      duration_seconds: 30,

      content: {
        title: "Quick Review: #{get_command_friendly_name(actual_command)}",
        scenario_narrative: get_random_scenario(actual_command),
        problem_statement: "Review the command you learned earlier.",

        command_to_learn: actual_command,
        expected_command: actual_command,
        practice_hints: get_progressive_hints(actual_command),

        # No concept_explanation - they already learned it!
        concept_explanation: nil,

        # Lightweight metadata
        difficulty_level: 'review',
        category: 'spaced_repetition',
        is_review: true,
        original_chapter: original_chapter
      },

      scoring: {
        on_success: {
          boost_score_by: 20,  # +20% boost
          reset_last_used_at: true,
          award_xp: 10
        },
        on_failure: {
          penalty: 5,  # -5% penalty
          suggest_reteach: true
        }
      }
    }
  end

  # Generate a multi-command scenario review (2-3 minutes)
  def self.generate_multi_command_review(command_masteries, user)
    commands = command_masteries.map(&:canonical_command)

    {
      id: "multi-review-#{SecureRandom.hex(4)}",
      type: 'scenario_review',
      content_type: 'interactive',
      duration_minutes: 3,

      content: {
        title: generate_scenario_title(commands),
        scenario_narrative: generate_cohesive_scenario(commands),
        problem_statement: "Complete this realistic workflow using commands you've learned.",

        steps: commands.map.with_index do |cmd, i|
          {
            step_number: i + 1,
            description: get_step_description(cmd, commands),
            expected_command: cmd,
            hints: [get_command_specific_hint(cmd)],
            points: 10
          }
        end,

        # No teaching - just practice
        difficulty_level: 'review',
        category: 'spaced_repetition',
        is_review: true,
        commands_tested: commands
      },

      scoring: {
        total_points: commands.count * 10,
        on_success: {
          boost_all_commands_by: 15,
          award_xp: 50
        }
      }
    }
  end

  private

  # Scenario templates for single-command reviews
  SCENARIO_TEMPLATES = {
    'docker run hello-world' => [
      "A new team member asks you to verify their Docker installation works.",
      "Quick sanity check: Is Docker running correctly on this machine?",
      "Your manager asks: 'Can you confirm Docker is installed?'",
      "Before starting work, verify Docker is functional.",
      "A colleague is having issues - show them Docker works on your machine first."
    ],

    'docker run -p' => [
      "Start a quick web server accessible on port 8080.",
      "Deploy nginx so you can access it at localhost:3000.",
      "Launch a test container with port mapping for debugging.",
      "Your team needs a temporary web server with ports exposed."
    ],

    'docker ps' => [
      "Your colleague asks: 'What containers are running right now?'",
      "Quick check: Are any containers currently active?",
      "List all running containers to verify the deployment.",
      "Show your manager what's currently running on the server.",
      "Check if the containers you started earlier are still up."
    ],

    'docker stop' => [
      "A container is misbehaving - shut it down cleanly.",
      "Your colleague asks you to stop the test container.",
      "Gracefully stop the running nginx container.",
      "Before redeploying, stop the old version first."
    ],

    'docker rm' => [
      "Clean up the stopped container from earlier.",
      "Remove the old container to free up the name.",
      "Your manager wants a clean server - remove unused containers.",
      "Delete the test container you're done with."
    ],

    'docker logs' => [
      "A container crashed - check what went wrong.",
      "Your colleague asks: 'Why did this container fail?'",
      "Investigate the error by viewing container output.",
      "Debug the issue by checking the logs."
    ],

    'docker exec' => [
      "A file is missing in the container - verify it exists.",
      "Your colleague asks: 'Can you check if the config file is there?'",
      "Explore the container's filesystem to debug.",
      "Run a command inside the container to investigate."
    ],

    'docker run -d' => [
      "Start a long-running service in the background.",
      "Launch a database container in detached mode.",
      "Deploy nginx without blocking your terminal.",
      "Start a container that should keep running."
    ],

    'docker run --name' => [
      "Start a container with a memorable name.",
      "Launch nginx with a custom name for easy reference.",
      "Your team needs a named container for the project.",
      "Create a container you can reference later."
    ],

    'docker run -d --name codesprout-web nginx:alpine' => [
      "Start a web server in the background named codesprout-web.",
      "Launch nginx in detached mode with the name codesprout-web.",
      "Your team needs the codesprout-web container running.",
      "Deploy the nginx server as a background service."
    ],

    'docker images' => [
      "Your colleague asks: 'What images do we have on this system?'",
      "Quick check: List all Docker images available locally.",
      "Show your manager what images are installed.",
      "Verify which images are downloaded on this machine."
    ],

    'docker pull' => [
      "Download the nginx image before deploying it.",
      "Your team needs you to pull the latest Alpine image.",
      "Get the official postgres image from Docker Hub.",
      "Pre-download an image for faster deployment later."
    ],

    'docker build' => [
      "Build a custom image from your Dockerfile.",
      "Create a new image for the web application.",
      "Your team needs you to build the app image from source.",
      "Package the application into a Docker image."
    ],

    'docker-compose up' => [
      "Start all services defined in docker-compose.yml.",
      "Launch the entire application stack with one command.",
      "Your team needs the development environment running.",
      "Bring up the multi-container application."
    ],

    'docker network ls' => [
      "Check what Docker networks exist on this system.",
      "Your colleague asks: 'What networks are configured?'",
      "List all available Docker networks.",
      "Verify network configuration before deployment."
    ],

    'docker volume ls' => [
      "See what volumes are created on this system.",
      "Check which persistent storage volumes exist.",
      "Your manager wants to know about data volumes.",
      "List all Docker volumes for the audit."
    ]
  }.freeze

  # Multi-command scenario templates
  def self.generate_cohesive_scenario(commands)
    # Smart scenario generation based on command combination
    if commands.include?('docker run') && commands.include?('docker ps') && commands.include?('docker stop')
      "A web server is misbehaving. Start a fresh container, verify it's running, and stop the old one."

    elsif commands.include?('docker logs') && commands.include?('docker exec')
      "A container is crashing on startup. Check its logs to see the error, then explore its filesystem to debug the issue."

    elsif commands.include?('docker run -p') && commands.include?('docker ps') && commands.include?('docker rm')
      "Deploy a test web server with port mapping, verify it's accessible, then clean it up when done."

    elsif commands.include?('docker stop') && commands.include?('docker rm')
      "Your colleague left test containers running. Stop them gracefully and remove them to clean up the server."

    elsif commands.include?('docker ps') && commands.include?('docker logs')
      "The staging server is acting weird. Check what's running, then investigate the logs of suspicious containers."

    else
      "Practice these Docker commands in a realistic workflow. #{commands.count} steps to complete."
    end
  end

  def self.generate_scenario_title(commands)
    if commands.count == 2
      "Quick Review: #{commands.count} Commands"
    elsif commands.count == 3
      "Scenario Review: #{get_scenario_theme(commands)}"
    else
      "Multi-Command Review"
    end
  end

  def self.get_scenario_theme(commands)
    themes = {
      ['docker run', 'docker ps', 'docker stop'] => 'Container Lifecycle',
      ['docker logs', 'docker exec'] => 'Debugging Containers',
      ['docker run -p', 'docker ps', 'docker rm'] => 'Deploy & Cleanup',
      ['docker stop', 'docker rm'] => 'Container Cleanup'
    }

    themes[commands] || 'Docker Workflow'
  end

  def self.get_step_description(command, all_commands)
    case command
    when /docker run.*-p/
      "Start a web server with port mapping"
    when /docker run.*-d/
      "Launch a container in detached mode"
    when /docker run.*--name/
      "Create a named container"
    when /docker run/
      "Start a container"
    when 'docker ps'
      "List running containers to verify"
    when 'docker stop'
      "Stop the container gracefully"
    when 'docker rm'
      "Remove the stopped container"
    when 'docker logs'
      "Check the container's output"
    when 'docker exec'
      "Run a command inside the container"
    else
      "Execute: #{command}"
    end
  end

  def self.get_random_scenario(command)
    scenarios = SCENARIO_TEMPLATES[command]

    # If no specific scenario template, create a helpful generic one
    if scenarios.nil?
      friendly_name = get_command_friendly_name(command)
      scenarios = [
        "Practice the #{friendly_name} command you learned earlier.",
        "Quick review: #{friendly_name}.",
        "Your colleague needs help with #{friendly_name}.",
        "Time to reinforce your #{friendly_name} skills!"
      ]
    end

    scenarios.sample  # Random scenario each time!
  end

  def self.get_progressive_hints(command)
    # Progressive hints: each hint gets more specific
    hints_map = {
      'docker run hello-world' => [
        "Start with the 'docker run' command",
        "You need to specify an image name",
        "The image is called 'hello-world'"
      ],
      'docker ps' => [
        "This command lists containers",
        "It's a 2-word command starting with 'docker'",
        "The second word is an abbreviation for 'processes'"
      ],
      'docker run -d --name codesprout-web nginx:alpine' => [
        "Think about: detached mode (-d), naming the container, and which image to use",
        "You need three parts: the -d flag, --name with 'codesprout-web', and the nginx:alpine image",
        "Format: docker run -d --name <container-name> <image-name>"
      ],
      'docker stop' => [
        "This command stops a running container",
        "You need to specify which container to stop",
        "Format: docker stop <container-name-or-id>"
      ],
      'docker rm' => [
        "This command removes a container (must be stopped first)",
        "You need the container name or ID",
        "Format: docker rm <container-name-or-id>"
      ],
      'docker images' => [
        "This lists all downloaded Docker images",
        "It's a 2-word command",
        "The second word is 'images'"
      ],
      'docker pull' => [
        "This downloads an image from Docker Hub",
        "You need to specify which image to download",
        "Format: docker pull <image-name>"
      ],
      'docker build' => [
        "This creates an image from a Dockerfile",
        "You usually need to tag it with -t and specify the build context",
        "Format: docker build -t <tag-name> <path>"
      ],
      'docker logs' => [
        "This shows output from a container",
        "You need to specify which container",
        "Format: docker logs <container-name>"
      ],
      'docker exec' => [
        "This runs a command inside a running container",
        "You need: container name and the command to run",
        "Common format: docker exec -it <container> /bin/bash"
      ],
      'docker run -d' => [
        "The -d flag means 'detached' (background)",
        "Format: docker run -d <image-name>",
        "This runs the container in the background"
      ],
      'docker run --name' => [
        "The --name flag gives the container a custom name",
        "You need: --name <your-name> <image>",
        "Example: docker run --name myapp nginx"
      ],
      'docker network ls' => [
        "This lists Docker networks",
        "It's similar to 'docker ps' but for networks",
        "Format: docker network ls"
      ],
      'docker volume ls' => [
        "This lists Docker volumes",
        "It's similar to 'docker ps' but for volumes",
        "Format: docker volume ls"
      ],
      'docker-compose up' => [
        "This starts services defined in docker-compose.yml",
        "The command has a hyphen in 'docker-compose'",
        "Add -d to run in background: docker-compose up -d"
      ],
      'docker-compose down' => [
        "This stops and removes containers defined in docker-compose.yml",
        "It's the opposite of 'up'",
        "Format: docker-compose down"
      ]
    }

    # Return specific hints if available
    return hints_map[command] if hints_map[command]

    # Try to match by base command (e.g., "docker run" for any docker run variant)
    base_command = command.split[0..1].join(' ')
    hints_map.each do |key, hints|
      if key.start_with?(base_command)
        return hints
      end
    end

    # Fallback to generic but still helpful hints
    [
      "Break down what the command needs to do",
      "Think about the command structure: docker <action> <options> <target>",
      "Check the syntax for this specific Docker command"
    ]
  end

  def self.get_command_specific_hint(command)
    hints = {
      'docker run hello-world' => "Use the hello-world test image",
      'docker run -p' => "Remember the -p flag for port mapping",
      'docker ps' => "This shows all running containers",
      'docker stop' => "Use the container name or ID",
      'docker rm' => "Container must be stopped first",
      'docker logs' => "Use the container name to view output",
      'docker exec' => "Format: docker exec <container> <command>",
      'docker run -d' => "The -d flag runs in detached mode",
      'docker run --name' => "Use --name to give it a custom name"
    }

    hints[command] || "You've practiced this before!"
  end

  def self.get_command_friendly_name(command)
    names = {
      'docker run hello-world' => 'Docker Installation Test',
      'docker run -p' => 'Port Mapping',
      'docker ps' => 'List Containers',
      'docker stop' => 'Stop Container',
      'docker rm' => 'Remove Container',
      'docker logs' => 'Container Logs',
      'docker exec' => 'Execute in Container',
      'docker run -d' => 'Detached Mode',
      'docker run --name' => 'Named Containers',
      'docker run -d --name codesprout-web nginx:alpine' => 'Running Nginx in Detached Mode',
      'docker images' => 'List Images',
      'docker pull' => 'Pull Image',
      'docker build' => 'Build Image',
      'docker push' => 'Push Image',
      'docker network ls' => 'List Networks',
      'docker network create' => 'Create Network',
      'docker volume ls' => 'List Volumes',
      'docker volume create' => 'Create Volume',
      'docker-compose up' => 'Docker Compose Up',
      'docker-compose down' => 'Docker Compose Down',
      'kubectl get' => 'Kubernetes Get',
      'kubectl apply' => 'Kubernetes Apply'
    }

    # Return mapped name if it exists
    return names[command] if names[command]

    # Fallback: Extract just the base command (first 2-3 words)
    # e.g., "docker run -d --name foo nginx:alpine" → "docker run"
    base_command = command.split[0..1].join(' ')

    # Try to find a partial match
    partial_match = names.find { |k, v| command.start_with?(k) }&.last
    return partial_match if partial_match

    # Final fallback: Show the base command cleanly
    base_command.gsub('docker ', '').gsub('-', ' ').titleize
  end

  def self.get_original_chapter_slug(command)
    # If it's already a chapter slug, return it as-is
    return command if command.start_with?('codesprout-')

    # Map commands back to their original chapters
    # Use pattern matching to handle commands with arguments/container names
    case command
    when /^docker run hello-world/
      'codesprout-hello-world'
    when /^docker run.*-p/
      'codesprout-docker-run'
    when /^docker run.*-d/
      'codesprout-detached-nginx'
    when /^docker run.*--name/
      'codesprout-naming-containers'
    when /^docker ps/
      'codesprout-docker-ps'
    when /^docker stop/
      'codesprout-docker-stop'
    when /^docker rm/
      'codesprout-docker-rm'
    when /^docker logs/
      'codesprout-docker-logs'
    when /^docker exec/
      'codesprout-docker-exec'
    else
      'unknown'
    end
  end

  def self.get_chapter_title(slug)
    titles = {
      'codesprout-hello-world' => 'Chapter 1: Welcome to Docker',
      'codesprout-docker-run' => 'Chapter 2: Port Mapping',
      'codesprout-detached-nginx' => 'Chapter 3: Detached Mode',
      'codesprout-naming-containers' => 'Chapter 4: Named Containers',
      'codesprout-docker-ps' => 'Chapter 5: Listing Containers',
      'codesprout-docker-stop' => 'Chapter 6: Stopping Containers',
      'codesprout-docker-rm' => 'Chapter 7: Removing Containers',
      'codesprout-docker-logs' => 'Chapter 8: Container Logs',
      'codesprout-docker-exec' => 'Chapter 9: Executing Commands'
    }

    titles[slug] || slug
  end

  def self.get_actual_command(canonical_command)
    # If it's a chapter slug (codesprout-*), look up the actual command from database
    if canonical_command.start_with?('codesprout-')
      unit = InteractiveLearningUnit.find_by(slug: canonical_command)
      return unit.command_to_learn if unit
    end

    # Otherwise, return as-is
    canonical_command
  end
end
