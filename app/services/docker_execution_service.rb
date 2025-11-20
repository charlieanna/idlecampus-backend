class DockerExecutionService
  # Execute Docker commands in user-isolated namespaces
  # Each user gets their own container namespace to avoid conflicts

  attr_reader :user, :namespace

  def initialize(user)
    @user = user
    @namespace = "user#{user.id}_"
  end

  # Execute a Docker command with user namespace isolation
  def execute(command, chapter: nil)
    Rails.logger.info "🐳 Executing Docker command for user #{user.id}: #{command}"

    # Parse and transform command to use user namespace
    namespaced_command = apply_namespace(command)

    # Setup prerequisites if needed
    ensure_prerequisites(command, chapter) if chapter

    # Execute the actual Docker command
    result = execute_docker_command(namespaced_command)

    # Track container state for this user
    track_container_state(namespaced_command, result) if result[:success]

    result
  end

  # Get all containers for this user
  def user_containers
    result = execute_raw("docker ps -a --filter 'name=#{namespace}' --format '{{.Names}}'")
    return [] unless result[:success]

    result[:output].split("\n").map(&:strip).reject(&:blank?)
  end

  # Clean up all containers for this user
  def cleanup_all
    containers = user_containers
    return { success: true, message: "No containers to clean up" } if containers.empty?

    Rails.logger.info "🧹 Cleaning up #{containers.count} containers for user #{user.id}"

    # Stop all running containers
    containers.each do |container|
      execute_raw("docker stop #{container} 2>/dev/null || true")
    end

    # Remove all containers
    containers.each do |container|
      execute_raw("docker rm #{container} 2>/dev/null || true")
    end

    { success: true, message: "Cleaned up #{containers.count} containers" }
  end

  # Reset environment for a specific chapter (create prerequisites)
  def reset_for_chapter(chapter_slug)
    Rails.logger.info "🔄 Resetting environment for chapter: #{chapter_slug}"

    prerequisites = get_chapter_prerequisites(chapter_slug)
    return { success: true } if prerequisites.empty?

    prerequisites.each do |prereq|
      case prereq[:type]
      when :running_container
        ensure_running_container(prereq[:name], prereq[:image], prereq[:options])
      when :stopped_container
        ensure_stopped_container(prereq[:name], prereq[:image], prereq[:options])
      when :image
        ensure_image(prereq[:image])
      end
    end

    { success: true, prerequisites: prerequisites }
  end

  private

  # Apply user namespace to container names in command
  def apply_namespace(command)
    # Pattern: --name <container-name> or container name as argument
    transformed = command.dup

    # Handle: --name codesprout-web
    transformed.gsub!(/--name\s+(\S+)/) do
      container_name = $1
      "--name #{namespace}#{container_name}"
    end

    # Handle: docker stop codesprout-web
    # Handle: docker rm codesprout-web
    # Handle: docker exec codesprout-web ...
    # Handle: docker logs codesprout-web
    if transformed =~ /^docker\s+(stop|rm|exec|logs|start|restart|inspect)\s+(\S+)/
      action = $1
      container_name = $2
      # Don't namespace if already namespaced
      unless container_name.start_with?(namespace)
        transformed.gsub!(/^docker\s+#{action}\s+#{container_name}/, "docker #{action} #{namespace}#{container_name}")
      end
    end

    transformed
  end

  # Execute the Docker command
  def execute_docker_command(command)
    begin
      # Use Open3 to capture output and errors safely
      require 'open3'

      stdout, stderr, status = Open3.capture3(command)

      success = status.success?
      output = stdout.presence || stderr.presence || ""

      Rails.logger.info success ? "✅ Command succeeded" : "❌ Command failed: #{stderr}"

      {
        success: success,
        output: output.strip,
        error: stderr.strip,
        exit_code: status.exitstatus
      }
    rescue => e
      Rails.logger.error "❌ Exception executing Docker command: #{e.message}"
      {
        success: false,
        output: "",
        error: e.message,
        exit_code: 1
      }
    end
  end

  # Execute raw Docker command without namespace transformation
  def execute_raw(command)
    execute_docker_command(command)
  end

  # Track container state changes
  def track_container_state(command, result)
    # Extract container names created/removed
    if command =~ /docker run.*--name\s+#{namespace}(\S+)/
      container_name = $1
      Rails.logger.info "📝 Tracked: Created container #{container_name}"
    elsif command =~ /docker rm.*#{namespace}(\S+)/
      container_name = $1
      Rails.logger.info "📝 Tracked: Removed container #{container_name}"
    end
  end

  # Get prerequisites for a specific chapter
  def get_chapter_prerequisites(chapter_slug)
    CHAPTER_PREREQUISITES[chapter_slug] || []
  end

  # Ensure a container is running
  def ensure_running_container(name, image, options = {})
    namespaced_name = "#{namespace}#{name}"

    # Check if container already exists
    check_result = execute_raw("docker ps -a --filter 'name=^#{namespaced_name}$' --format '{{.Names}}'")

    if check_result[:output].include?(namespaced_name)
      # Container exists, ensure it's running
      status_result = execute_raw("docker inspect -f '{{.State.Running}}' #{namespaced_name}")
      if status_result[:output].strip == "false"
        execute_raw("docker start #{namespaced_name}")
        Rails.logger.info "▶️  Started existing container: #{namespaced_name}"
      else
        Rails.logger.info "✅ Container already running: #{namespaced_name}"
      end
    else
      # Create and run the container
      port_map = options[:ports] ? "-p #{options[:ports]}" : ""
      detached = options[:detached] != false ? "-d" : ""

      create_cmd = "docker run #{detached} #{port_map} --name #{namespaced_name} #{image}"
      execute_raw(create_cmd)
      Rails.logger.info "🆕 Created container: #{namespaced_name}"
    end
  end

  # Ensure a container exists but is stopped
  def ensure_stopped_container(name, image, options = {})
    namespaced_name = "#{namespace}#{name}"

    # First ensure it exists
    ensure_running_container(name, image, options)

    # Then stop it
    execute_raw("docker stop #{namespaced_name}")
    Rails.logger.info "⏸️  Stopped container: #{namespaced_name}"
  end

  # Ensure an image is pulled
  def ensure_image(image)
    # Check if image exists
    check_result = execute_raw("docker images -q #{image}")

    if check_result[:output].blank?
      Rails.logger.info "📥 Pulling image: #{image}"
      execute_raw("docker pull #{image}")
    else
      Rails.logger.info "✅ Image already exists: #{image}"
    end
  end

  # Ensure prerequisites before executing command
  def ensure_prerequisites(command, chapter)
    prereqs = get_chapter_prerequisites(chapter)
    return if prereqs.empty?

    Rails.logger.info "🔍 Checking prerequisites for #{chapter}: #{prereqs.count} items"

    prereqs.each do |prereq|
      case prereq[:type]
      when :running_container
        ensure_running_container(prereq[:name], prereq[:image], prereq[:options] || {})
      when :stopped_container
        ensure_stopped_container(prereq[:name], prereq[:image], prereq[:options] || {})
      when :image
        ensure_image(prereq[:image])
      end
    end
  end

  # Chapter prerequisites mapping
  CHAPTER_PREREQUISITES = {
    # Chapter 5: Stop containers - needs running container
    'codesprout-docker-stop' => [
      { type: :running_container, name: 'codesprout-web', image: 'nginx:alpine', options: { detached: true, ports: '8080:80' } }
    ],

    # Chapter 6: Remove containers - needs stopped container
    'codesprout-docker-rm' => [
      { type: :stopped_container, name: 'codesprout-web', image: 'nginx:alpine', options: { detached: true } }
    ],

    # Chapter 8: Logs - needs running container
    'codesprout-docker-logs' => [
      { type: :running_container, name: 'codesprout-web', image: 'nginx:alpine', options: { detached: true } }
    ],

    # Chapter 9: Exec - needs running container
    'codesprout-docker-exec' => [
      { type: :running_container, name: 'codesprout-web', image: 'nginx:alpine', options: { detached: true } }
    ],

    # Add more as needed...
  }.freeze
end
