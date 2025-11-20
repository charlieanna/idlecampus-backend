# Rich Docker Command Converter
# Converts DockerCommand records into educational InteractiveLearningUnit records

class RichDockerCommandConverter
  def initialize(docker_cmd)
    @cmd = docker_cmd
  end

  # Generate rich markdown concept explanation (400+ chars)
  def generate_concept_explanation
    command_parts = @cmd.command.split
    main_command = command_parts[0..1].join(' ')

    explanation = "#{@cmd.explanation}\n\n"

    # Add command syntax
    explanation += "**Command:** `#{@cmd.command}`\n\n"

    # Add what happens section
    if @cmd.use_cases.present?
      explanation += "**Use case:** #{@cmd.use_cases}\n\n"
    end

    # Add flags explanation if present
    if @cmd.flags.present? && @cmd.flags.any?
      explanation += "**Common flags:**\n"
      @cmd.flags.each do |flag, desc|
        explanation += "- `#{flag}` - #{desc}\n"
      end
      explanation += "\n"
    end

    # Add variations as examples if present
    if @cmd.variations.present? && @cmd.variations.any?
      explanation += "**Examples:**\n"
      @cmd.variations.first(2).each do |variation|
        explanation += "```bash\n#{variation}\n```\n"
      end
      explanation += "\n"
    end

    # Add gotchas/warnings if present
    if @cmd.gotchas.present?
      explanation += "⚠️ **Important:** #{@cmd.gotchas}\n\n"
    end

    explanation.strip
  end

  # Generate engaging scenario description
  def generate_scenario_description
    if @cmd.use_cases.present?
      # Convert use case into action-oriented narrative
      use_case = @cmd.use_cases
      if use_case.start_with?('Deploy', 'Run', 'Create', 'Start', 'Stop')
        "Let's #{use_case.downcase}."
      else
        "Learn how to #{use_case.downcase} using Docker."
      end
    else
      "Practice using the #{@cmd.command.split.first(2).join(' ')} command."
    end
  end

  # Generate progressive practice hints array
  def generate_practice_hints
    hints = []
    command_parts = @cmd.command.split

    # First hint: start with base command
    hints << "Start with '#{command_parts[0]}'"

    # Add subcommand if present
    if command_parts.length > 1 && !command_parts[1].start_with?('-')
      hints << "Add the subcommand: #{command_parts[1]}"
    end

    # Add flag hints from DockerCommand.flags
    if @cmd.flags.present? && @cmd.flags.any?
      @cmd.flags.first(2).each do |flag, desc|
        hints << "Use #{flag} for #{desc.downcase}"
      end
    end

    # Add complete command
    hints << "Complete command: #{@cmd.command}"

    # Add tip from gotchas
    if @cmd.gotchas.present?
      hints << "💡 Tip: #{@cmd.gotchas}"
    end

    hints
  end

  # Generate structured scenario steps
  def generate_scenario_steps
    steps = []

    # Main command step
    steps << {
      step: 1,
      instruction: @cmd.explanation,
      command: @cmd.command,
      explanation: expand_command_explanation
    }

    # Add variation steps if present
    if @cmd.variations.present? && @cmd.variations.any?
      @cmd.variations.first(2).each_with_index do |variation, index|
        steps << {
          step: index + 2,
          instruction: "Try this variation",
          command: variation,
          explanation: generate_variation_explanation(variation)
        }
      end
    end

    steps
  end

  # Generate learning objectives
  def generate_learning_objectives
    objectives = []
    command_parts = @cmd.command.split
    main_cmd = command_parts[0..1].join(' ')

    # Core objective
    objectives << "Understand the #{main_cmd} command"

    # Application objective
    if @cmd.use_cases.present?
      objectives << @cmd.use_cases.gsub(/^(Deploy|Run|Create|Manage)\s+/, 'Learn to \\1 ').downcase.capitalize
    else
      objectives << "Use #{@cmd.command} in real scenarios"
    end

    # Flag objectives
    if @cmd.flags.present? && @cmd.flags.any?
      key_flag = @cmd.flags.keys.first
      objectives << "Master the #{key_flag} flag"
    end

    objectives
  end

  # Generate quiz questions
  def generate_quiz_questions
    questions = []

    # Priority 1: Flag-based question (if flags exist)
    if @cmd.flags.present? && @cmd.flags.any?
      flag = @cmd.flags.keys.first
      questions << generate_flag_question(flag, @cmd.flags[flag])
    end

    # Priority 2: Gotcha-based question (if gotchas exist)
    if @cmd.gotchas.present? && @cmd.exam_frequency >= 8
      questions << generate_gotcha_question
    end

    # Priority 3: Use case question (if high priority)
    if questions.empty? && @cmd.use_cases.present?
      questions << generate_use_case_question
    end

    questions.first # Return first question (or nil)
  end

  private

  def titleize_command(cmd)
    # Convert "docker run -d nginx" to "Running Containers in Detached Mode"
    cmd.split.map(&:capitalize).join(' ')
  end

  def expand_command_explanation
    parts = []
    parts << @cmd.explanation
    if @cmd.flags.present? && @cmd.flags.any?
      parts << "This uses: #{@cmd.flags.values.first(2).join(', ')}"
    end
    parts.join('. ')
  end

  def generate_variation_explanation(variation)
    # Compare variation to original command
    original_parts = @cmd.command.split
    variation_parts = variation.split
    diff = variation_parts - original_parts

    if diff.any?
      "This variation adds: #{diff.join(' ')}"
    else
      "Alternative syntax for the same operation"
    end
  end

  def generate_flag_question(flag, description)
    {
      question_text: "What does the '#{flag}' flag do in '#{@cmd.command}'?",
      quiz_options: [
        { text: description.capitalize, correct: true },
        { text: generate_wrong_option_1, correct: false },
        { text: generate_wrong_option_2, correct: false },
        { text: generate_wrong_option_3, correct: false }
      ],
      quiz_explanation: "The #{flag} flag is used for #{description.downcase}."
    }
  end

  def generate_gotcha_question
    {
      question_text: "What should you be aware of when running '#{@cmd.command}'?",
      quiz_options: [
        { text: @cmd.gotchas, correct: true },
        { text: "Nothing special, it's completely safe", correct: false },
        { text: "It will delete all containers", correct: false },
        { text: "It requires root access", correct: false }
      ],
      quiz_explanation: "Important to remember: #{@cmd.gotchas}"
    }
  end

  def generate_use_case_question
    {
      question_text: "When would you use '#{@cmd.command}'?",
      quiz_options: [
        { text: @cmd.use_cases, correct: true },
        { text: "To delete Docker images", correct: false },
        { text: "To install Docker", correct: false },
        { text: "To update Docker daemon", correct: false }
      ],
      quiz_explanation: "This command is used to: #{@cmd.use_cases.downcase}"
    }
  end

  def generate_wrong_option_1
    "Deletes the container after execution"
  end

  def generate_wrong_option_2
    "Enables verbose logging mode"
  end

  def generate_wrong_option_3
    "Requires elevated privileges"
  end
end
