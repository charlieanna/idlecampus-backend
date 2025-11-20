# Fix Docker command ordering to follow logical learning progression
# This script updates sequence_order field for proper pedagogical flow

puts "🔧 Reordering Docker commands for logical learning progression..."

# Define proper learning order for each module
LEARNING_ORDER = {
  # BASICS MODULE - Start with absolute fundamentals
  basics: [
    'docker version',           # 1. First: Check installation
    'docker system info',       # 2. Understand system
    'docker ps',                # 3. See running containers
    'docker run -d nginx',      # 4. Start first container
    'docker logs <container>',  # 5. View container output
    'docker stop <container>',  # 6. Stop container
    'docker start <container>', # 7. Restart container
    'docker restart <container>', # 8. Restart in one command
    'docker rm <container>',    # 9. Remove container
    'docker exec -it <container> bash', # 10. Interactive access (advanced)
    'docker inspect <container>', # 11. Detailed inspection
    'docker events',            # 12. Monitor events
    'docker system df',         # 13. Check disk usage
    'docker system prune'       # 14. Cleanup
    # Remove: docker context create, docker plugin install (too advanced for basics)
  ],
  
  # IMAGES MODULE - Building on container knowledge
  images: [
    'docker images',            # 1. List images
    'docker pull nginx:alpine', # 2. Pull from registry
    'docker build -t myapp:v1 .', # 3. Build your own
    'docker tag myapp:v1 myrepo/myapp:latest', # 4. Tag images
    'docker history <image>',   # 5. View layers
    'docker rmi <image>',       # 6. Remove images
    'docker image prune',       # 7. Cleanup unused
    'docker commit <container> myimage:v2', # 8. Create from container
    'docker save -o myapp.tar myapp:v1', # 9. Export
    'docker load -i myapp.tar', # 10. Import
    'docker import backup.tar myimage:v1' # 11. Import tarball
  ],
  
  # REGISTRY MODULE - Publishing images
  registry: [
    'docker login',             # 1. Authenticate first
    'docker search nginx',      # 2. Find images
    'docker push myrepo/myapp:v1', # 3. Publish
    'docker logout'             # 4. Security
  ],
  
  # COMPOSE MODULE - Multi-container apps
  compose: [
    'docker-compose ps',        # 1. Check status
    'docker-compose up -d',     # 2. Start services
    'docker-compose logs',      # 3. View logs
    'docker-compose exec <service> bash', # 4. Access service
    'docker-compose build',     # 5. Build services
    'docker-compose scale web=3', # 6. Scale (deprecated but educational)
    'docker-compose restart <service>', # 7. Restart
    'docker-compose down'       # 8. Stop everything
  ],
  
  # SECURITY MODULE
  security: [
    'docker secret ls',         # 1. List secrets
    'docker secret create my-secret secret.txt', # 2. Create
    'docker secret inspect <secret>', # 3. Inspect
    'docker secret rm <secret>', # 4. Remove
    'docker trust sign myimage:v1' # 5. Image signing
  ]
}

# Helper to find unit by command
def find_unit_by_command(command)
  # Try exact match first
  unit = InteractiveLearningUnit.find_by(command_to_learn: command)
  return unit if unit
  
  # Try fuzzy match
  InteractiveLearningUnit.where("command_to_learn LIKE ?", "%#{command.split.first(2).join(' ')}%").first
end

# Process each module
LEARNING_ORDER.each do |module_name, commands|
  puts "\n📚 Processing #{module_name.upcase} module..."
  
  commands.each_with_index do |command, index|
    unit = find_unit_by_command(command)
    
    if unit
      old_seq = unit.sequence_order
      new_seq = index + 1
      
      unit.update_column(:sequence_order, new_seq)
      puts "  ✓ #{new_seq}. #{unit.command_to_learn} (seq: #{old_seq} → #{new_seq})"
    else
      puts "  ⚠️  Command not found: #{command}"
    end
  end
end

# Remove advanced commands that don't belong in basics
puts "\n🗑️  Removing overly advanced commands from basics..."
advanced_basics = [
  'docker context create',
  'docker plugin install'
]

advanced_basics.each do |cmd|
  units = InteractiveLearningUnit.where("command_to_learn LIKE ?", "#{cmd}%")
  units.each do |unit|
    puts "  ✓ Removing: #{unit.command_to_learn} (ID: #{unit.id})"
    unit.destroy
  end
end

puts "\n✅ Command reordering complete!"
puts "Total commands: #{InteractiveLearningUnit.count}"
puts "\nCommands now ordered by pedagogical progression:"
puts "  1. Basics: Installation → Running → Managing → Inspecting → Cleanup"
puts "  2. Images: Viewing → Pulling → Building → Managing → Export/Import"
puts "  3. Registry: Login → Search → Push → Logout"
puts "  4. Compose: Status → Start → Logs → Access → Build → Scale → Stop"
puts "  5. Security: List → Create → Inspect → Remove → Sign"