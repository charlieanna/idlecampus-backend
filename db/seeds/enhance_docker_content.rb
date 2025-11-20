# Enhance Docker Interactive Learning Units with comprehensive educational content
# Transform from reference cards to rich learning experiences

puts "📚 Enhancing Docker course content with educational explanations..."

# Define enhanced content for each command
ENHANCED_CONTENT = {
  'docker version' => {
    concept_explanation: <<~MARKDOWN.strip,
      # Understanding Docker Version

      Before diving into Docker, you need to verify that Docker is properly installed and understand what version you're working with. The `docker version` command is your first diagnostic tool.

      ## What This Command Does

      `docker version` displays detailed version information about both the Docker **client** (the command-line tool you're using) and the Docker **daemon** (the background service that actually runs containers).

      ## Why This Matters

      Understanding your Docker version is crucial because:
      - **Compatibility**: Different Docker versions support different features
      - **Troubleshooting**: Version mismatches between client and server can cause issues
      - **Documentation**: Knowing your version helps you find the right documentation
      - **Security**: Older versions may have known vulnerabilities

      ## The Client-Server Architecture

      Docker uses a client-server model:
      - **Client**: The `docker` command you type in your terminal
      - **Server (Daemon)**: The background process (`dockerd`) that manages containers
      - **API**: They communicate via REST API

      This means they can have different versions, and it's important both are compatible.

      ## Common Use Cases

      1. **Verify installation**: Check that Docker is installed correctly
      2. **Check compatibility**: Ensure your client and server versions match
      3. **Before upgrading**: Document your current version before updates
      4. **Troubleshooting**: When reporting issues, always include version info

      ## Real-World Example

      ```bash
      $ docker version
      Client: Docker Engine - Community
       Version:           24.0.6
       API version:       1.43
       Go version:        go1.20.7
       Built:             Mon Sep  4 12:32:48 2023

      Server: Docker Engine - Community
       Engine:
        Version:          24.0.6
        API version:      1.43 (minimum version 1.12)
      ```

      ## What to Look For

      - **Version numbers match**: Client and Server should usually be the same
      - **API version**: Determines which features are available
      - **OS/Arch**: Shows what platform Docker is running on

      ## Pro Tips

      - Use `--format` flag to extract specific information programmatically
      - In scripts, check versions before executing Docker commands
      - Keep both client and server updated for best performance and security

      ⚠️ **Important**: If client and server versions differ significantly, some commands may not work as expected.
    MARKDOWN
    scenario_description: "You're setting up a new development environment and need to verify Docker is installed correctly. Let's check the Docker version to ensure everything is working."
  },

  'docker system info' => {
    concept_explanation: <<~MARKDOWN.strip,
      # Docker System Information Deep Dive

      Once you've confirmed Docker is installed, you need to understand your Docker environment's configuration and capabilities. The `docker system info` (or simply `docker info`) command provides a comprehensive overview of your Docker setup.

      ## What This Command Reveals

      This command displays critical information about:
      - **Storage driver**: How Docker stores container and image data
      - **Logging driver**: How container logs are handled
      - **Plugins**: What additional capabilities are available
      - **System resources**: Available containers, images, and volumes
      - **Security**: Security features enabled (AppArmor, SELinux, etc.)
      - **Swarm status**: Whether you're in cluster mode

      ## Why This Information Matters

      ### 1. Storage Driver
      The storage driver affects performance and compatibility:
      - `overlay2` (recommended): Fast, efficient, widely supported
      - `aufs`: Older, being phased out
      - `devicemapper`: Legacy, avoid if possible

      ### 2. System Resources
      Know what's running:
      - Containers: Running vs stopped
      - Images: Cached locally
      - Volumes: Persistent data storage

      ### 3. Security Features
      Understanding enabled security:
      - **Seccomp**: System call filtering
      - **AppArmor/SELinux**: Mandatory access control
      - **User namespaces**: Container user isolation

      ## Troubleshooting with docker info

      This command is invaluable for diagnosing issues:

      ### Storage Issues
      ```
      WARNING: No swap limit support
      ```
      → Your system can't limit container memory swap

      ### Permission Problems
      ```
      Cannot connect to the Docker daemon
      ```
      → Docker service isn't running or permission denied

      ### Resource Exhaustion
      ```
      Containers: 47
      Images: 156
      ```
      → You might need to clean up old resources

      ## Real-World Scenario

      **Before deploying to production**, you should verify:
      1. Storage driver is production-ready (overlay2)
      2. Logging driver is configured for centralized logging
      3. Security features are enabled
      4. Resource limits are properly configured

      ## Common Flags

      ```bash
      # Get specific information in machine-readable format
      docker info --format '{{.ServerVersion}}'

      # Check storage driver
      docker info --format '{{.Driver}}'
      ```

      ## What to Watch For

      ⚠️ **Warnings section**: Pay attention to any warnings displayed - they often indicate configuration issues that could cause problems later.

      🔒 **Security options**: Ensure security features appropriate for your environment are enabled.

      💾 **Disk space**: Monitor available storage to prevent out-of-space errors.

      ## Pro Tips

      - Run this after installing Docker to verify proper setup
      - Include output when asking for help in forums
      - Use in scripts to check environment before running containers
      - Regular checks can catch resource leaks early
    MARKDOWN
    scenario_description: "You've installed Docker and now need to understand your environment's configuration. Let's check the system information to see what storage driver, logging, and security features are configured."
  },

  'docker ps' => {
    concept_explanation: <<~MARKDOWN.strip,
      # Listing and Managing Containers

      The `docker ps` command is your window into the world of running containers. It's probably the command you'll use most frequently when working with Docker.

      ## What This Command Shows

      By default, `docker ps` lists **only running containers**, showing:
      - **Container ID**: Unique identifier (first 12 chars of full ID)
      - **Image**: Which image was used to create the container
      - **Command**: The main process running inside
      - **Created**: How long ago the container was created
      - **Status**: Current state (Up, Exited, Paused, etc.)
      - **Ports**: Network port mappings
      - **Names**: Human-friendly name (auto-generated or custom)

      ## The Most Important Flags

      ### `-a, --all` - Show ALL Containers
      ```bash
      docker ps -a
      ```
      Shows running AND stopped containers. **Use this frequently** because stopped containers still consume disk space and can be restarted.

      ### `-q, --quiet` - IDs Only
      ```bash
      docker ps -q
      ```
      Returns only container IDs. Perfect for scripting:
      ```bash
      # Stop all running containers
      docker stop $(docker ps -q)

      # Remove all stopped containers
      docker rm $(docker ps -aq)
      ```

      ### `-f, --filter` - Filter Results
      ```bash
      # Only containers from nginx image
      docker ps -f "ancestor=nginx"

      # Only exited containers
      docker ps -a -f "status=exited"

      # Containers created in last hour
      docker ps -f "since=1h"
      ```

      ## Understanding Container States

      ### Up (Running)
      ```
      STATUS: Up 2 hours
      ```
      Container is currently running. Main process is active.

      ### Exited
      ```
      STATUS: Exited (0) 5 minutes ago
      ```
      Container stopped. Number in parentheses is exit code:
      - `0` = normal, successful exit
      - Non-zero = error (check logs with `docker logs`)

      ### Restarting
      ```
      STATUS: Restarting (1) 2 seconds ago
      ```
      Container crashed and is being restarted due to restart policy.

      ### Paused
      ```
      STATUS: Up 1 hour (Paused)
      ```
      Container is frozen (rarely used in practice).

      ## Real-World Workflows

      ### Daily Development Check
      ```bash
      # What's running right now?
      docker ps

      # What have I been working on?
      docker ps -a --filter "since=24h"

      # Clean up old stopped containers
      docker ps -a -f "status=exited" -f "exited=0"
      ```

      ### Troubleshooting Crashed Containers
      ```bash
      # Find crashed containers (non-zero exit)
      docker ps -a --filter "exited=1"

      # See what failed
      docker logs <container-id>
      ```

      ### Resource Monitoring
      ```bash
      # How many containers are running?
      docker ps -q | wc -l

      # What images are actively in use?
      docker ps --format '{{.Image}}' | sort | uniq
      ```

      ## Format Customization

      Create custom output formats:
      ```bash
      # Show only name, image, and status
      docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"

      # JSON output for processing
      docker ps --format '{{json .}}'
      ```

      ## Common Gotchas

      ### "Why don't I see my container?"
      1. Did you use `-a`? Container might have exited
      2. Check if it exited immediately (common with misconfigured images)
      3. Container name/ID might be different than you expect

      ### "Why are there so many stopped containers?"
      - Docker doesn't auto-remove containers by default
      - Each `docker run` creates a new container
      - Use `--rm` flag when running to auto-cleanup: `docker run --rm nginx`

      ## Pro Tips

      💡 **Aliases**: Create shell aliases for common commands:
      ```bash
      alias dps='docker ps'
      alias dpsa='docker ps -a'
      alias dpsq='docker ps -q'
      ```

      🧹 **Regular cleanup**: Get in the habit of removing stopped containers:
      ```bash
      docker container prune
      ```

      📊 **Monitoring**: Use `docker stats` (covered later) to see live resource usage.

      ⚠️ **Important**: Without `-a`, you're only seeing part of the picture. Always check stopped containers too!
    MARKDOWN
    scenario_description: "Your development environment has several containers. You need to see what's currently running, check their status, and identify which containers might need attention. Let's explore the running containers."
  }
}

# Apply enhanced content
puts "\n🔄 Updating Interactive Learning Units..."

ENHANCED_CONTENT.each do |command, content|
  unit = InteractiveLearningUnit.find_by("command_to_learn LIKE ?", "%#{command}%")
  
  if unit
    unit.update!(
      concept_explanation: content[:concept_explanation],
      scenario_description: content[:scenario_description],
      estimated_minutes: 8 # Increased from 5 to account for richer content
    )
    puts "  ✓ Enhanced: #{command}"
  else
    puts "  ⚠️  Not found: #{command}"
  end
end

puts "\n✅ Content enhancement complete!"
puts "\nSample enhancement statistics:"
ENHANCED_CONTENT.each do |command, content|
  chars = content[:concept_explanation].length
  puts "  #{command}: #{chars} characters (#{(chars / 250.0).round}x increase)"
end