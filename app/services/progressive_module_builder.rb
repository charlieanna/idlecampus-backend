# frozen_string_literal: true

# Service to transform a module's lessons into a progressive learning format
# where content and commands are interleaved for step-by-step unlocking
class ProgressiveModuleBuilder
  def initialize(course_module, session_module_data)
    @course_module = course_module
    @session_module_data = session_module_data
  end

  # Build progressive lesson items array
  # Returns array of hashes with type: 'content' or 'command'
  def build_items
    items = []

    # Get all lessons for this module from session data
    lessons = get_module_lessons

    lessons.each_with_index do |lesson, index|
      # Skip labs - only process lessons
      next if lesson['contentType'] == 'lab'

      # Add content item
      items << build_content_item(lesson, index)

      # Add command item
      items << build_command_item(lesson, index)
    end

    items
  end

  # Get module metadata
  def module_metadata
    {
      id: @course_module.id,
      slug: @course_module.slug,
      title: @course_module.title,
      description: @course_module.description,
      sequence_order: @course_module.sequence_order,
      estimated_minutes: calculate_total_time,
      total_commands: get_module_lessons.reject { |l| l['contentType'] == 'lab' }.count
    }
  end

  private

  def get_module_lessons
    # Get lessons from session module data
    @session_module_data['lessons'] || []
  end

  def build_content_item(lesson, index)
    {
      type: 'content',
      id: "content-#{index}",
      markdown: lesson['content'] || "# #{lesson['title']}\n\nLearn this command.",
      title: lesson['title'],
      estimated_minutes: lesson['estimated_minutes'] || 5
    }
  end

  def build_command_item(lesson, index)
    # Extract command from first commands array or determine from lesson
    command = extract_command_from_lesson(lesson)

    {
      type: 'command',
      id: "command-#{index}",
      command: command,
      description: lesson['description'] || lesson['title'],
      example: command,
      hint: extract_hint_from_content(lesson['content'] || '', command),
      validation: build_validation_rule(command),
      alternatives: extract_command_variations(command)
    }
  end

  def extract_command_from_lesson(lesson)
    # Try to get command from commands array
    if lesson['commands']&.any?
      first_cmd = lesson['commands'].first
      return first_cmd['command'] if first_cmd.is_a?(Hash) && first_cmd['command']
    end

    # Fallback: try to extract from title
    # e.g., "Listing Containers" -> "docker ps"
    extract_command_from_title(lesson['title'])
  end

  def extract_command_from_title(title)
    # Map common titles to commands
    title_lower = title.downcase
    case title_lower
    when /listing.*container/
      'docker ps'
    when /running.*first.*container/
      'docker run hello-world'
    when /running.*web.*server/
      'docker run nginx'
    when /detached.*mode/
      'docker run -d nginx'
    when /naming.*container/
      'docker run -d --name my-nginx nginx'
    when /port/
      'docker run -d -p 8080:80 nginx'
    when /stopping/
      'docker stop my-nginx'
    when /removing/
      'docker rm my-nginx'
    when /logs/
      'docker logs my-nginx'
    when /exec/
      'docker exec -it my-nginx bash'
    else
      'docker help'
    end
  end

  def extract_hint_from_content(content, command)
    # Try to extract hint from content
    if content.include?('Hint:')
      content.split('Hint:').last.split("\n").first.strip
    elsif content.include?('💡')
      content.split('💡').last.split("\n").first.strip
    else
      "Try typing: #{command}"
    end
  end

  def build_validation_rule(command)
    # Determine validation type based on command complexity
    if command.include?('<') || command.include?('[')
      # Command has placeholders - use pattern matching
      {
        type: 'pattern',
        pattern: convert_to_regex_pattern(command),
        description: "Command should match the pattern"
      }
    elsif command.include?('my-') || command.include?('your-')
      # Command has variable parts - use semantic validation
      {
        type: 'semantic',
        base_command: extract_base_command(command),
        required_flags: extract_required_flags(command),
        description: "Command should achieve the same result"
      }
    else
      # Simple command - exact match (with alternatives)
      {
        type: 'exact',
        value: command,
        description: "Type the exact command"
      }
    end
  end

  def convert_to_regex_pattern(command)
    # Convert command with placeholders to regex
    # e.g., "docker run <image>" -> "docker run \w+"
    pattern = command.dup
    pattern.gsub!(/<[^>]+>/, '\\w+')
    pattern.gsub!(/\[([^\]]+)\]/, '(\1)?')  # Optional parts
    "^#{Regexp.escape(pattern).gsub('\\\\w\\+', '\\w+').gsub('\\(', '(').gsub('\\)', ')')}$"
  end

  def extract_base_command(command)
    # Extract the main command part
    # e.g., "docker run -d --name my-nginx nginx" -> "docker run"
    command.split.first(2).join(' ')
  end

  def extract_required_flags(command)
    # Extract flags like -d, -p, --name
    flags = []
    parts = command.split

    parts.each_with_index do |part, index|
      if part.start_with?('-')
        flags << part
        # Include the next part if it's not a flag (it's the flag's value)
        flags << parts[index + 1] if index + 1 < parts.length && !parts[index + 1].start_with?('-')
      end
    end

    flags
  end

  def extract_command_variations(command)
    # Return array of alternative commands that are also valid
    variations = []

    # Add common variations
    if command.start_with?('docker ')
      # Short form to long form
      if command.include?(' -d ')
        variations << command.gsub(' -d ', ' --detach ')
      end

      if command.include?(' -p ')
        variations << command.gsub(' -p ', ' --publish ')
      end

      if command.include?(' -it ')
        variations << command.gsub(' -it ', ' --interactive --tty ')
      end

      # Add 'container' subcommand variant for management commands
      if command.match?(/docker (run|ps|stop|rm|exec|logs)/)
        subcommand = command.match(/docker (\w+)/)[1]
        variations << command.sub("docker #{subcommand}", "docker container #{subcommand}")
      end
    end

    variations.uniq.reject { |v| v == command }
  end

  def calculate_total_time
    get_module_lessons.sum { |l| l['estimated_minutes'] || 5 }
  end
end
