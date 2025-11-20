# Reorganize Docker Course - Logical Learning Order
# This script reorganizes InteractiveLearningUnits and HandsOnLabs into a proper learning sequence

puts "🔄 Starting Docker Course Reorganization..."

# Find the Docker course
course = Course.find_by(slug: 'docker-fundamentals')
unless course
  puts "❌ Docker course not found!"
  exit
end

# Clear existing module items to rebuild from scratch
puts "\n📦 Clearing existing module items..."
ModuleItem.where(course_module_id: course.course_modules.pluck(:id)).destroy_all

# Define the logical module structure with proper sequencing
module_structure = {
  'container-basics' => {
    sequence: 1,
    title: 'Container Basics',
    description: 'Master fundamental Docker container operations',
    units: [
      # Start with version check and system info
      { id: 13, type: 'InteractiveLearningUnit' }, # docker version
      { id: 10, type: 'InteractiveLearningUnit' }, # docker system info
      
      # Basic container lifecycle
      { id: 4, type: 'InteractiveLearningUnit' },  # docker run -d nginx
      { id: 3, type: 'InteractiveLearningUnit' },  # docker ps
      { id: 2, type: 'InteractiveLearningUnit' },  # docker logs
      { id: 7, type: 'InteractiveLearningUnit' },  # docker start
      { id: 8, type: 'InteractiveLearningUnit' },  # docker stop
      { id: 9, type: 'InteractiveLearningUnit' },  # docker restart
      { id: 5, type: 'InteractiveLearningUnit' },  # docker inspect
      { id: 6, type: 'InteractiveLearningUnit' },  # docker rm
      
      # Interactive container access
      { id: 1, type: 'InteractiveLearningUnit' },  # docker exec -it bash
      { id: 37, type: 'InteractiveLearningUnit' }, # docker run --rm -it alpine sh
      { id: 47, type: 'InteractiveLearningUnit' }, # docker attach
      
      # System management basics
      { id: 12, type: 'InteractiveLearningUnit' }, # docker system df
      { id: 11, type: 'InteractiveLearningUnit' }, # docker system prune
      { id: 35, type: 'InteractiveLearningUnit' }, # docker container prune
      
      # Lab at end of module
      { id: 1, type: 'HandsOnLab' }, # Your First Container - Run and Explore
    ]
  },
  
  'containers-advanced' => {
    sequence: 2,
    title: 'Advanced Container Management',
    description: 'Advanced container configuration and management techniques',
    units: [
      # Port mapping and networking
      { id: 32, type: 'InteractiveLearningUnit' }, # docker run -d -p 8080:80 --name web nginx
      { id: 36, type: 'InteractiveLearningUnit' }, # docker port
      
      # Environment configuration
      { id: 33, type: 'InteractiveLearningUnit' }, # docker run -d --env MY_VAR=value nginx
      
      # Resource management
      { id: 43, type: 'InteractiveLearningUnit' }, # docker run -d --memory 512m --cpus 1.5 nginx
      { id: 34, type: 'InteractiveLearningUnit' }, # docker stats
      { id: 38, type: 'InteractiveLearningUnit' }, # docker top
      
      # Restart policies and health
      { id: 44, type: 'InteractiveLearningUnit' }, # docker run -d --restart unless-stopped nginx
      { id: 46, type: 'InteractiveLearningUnit' }, # docker run -d --health-cmd
      { id: 50, type: 'InteractiveLearningUnit' }, # docker update --restart
      
      # File operations
      { id: 45, type: 'InteractiveLearningUnit' }, # docker cp
      { id: 48, type: 'InteractiveLearningUnit' }, # docker diff
      
      # Container state management
      { id: 40, type: 'InteractiveLearningUnit' }, # docker pause
      { id: 42, type: 'InteractiveLearningUnit' }, # docker unpause
      { id: 39, type: 'InteractiveLearningUnit' }, # docker kill
      { id: 41, type: 'InteractiveLearningUnit' }, # docker rename
      { id: 52, type: 'InteractiveLearningUnit' }, # docker wait
      
      # Backup and export
      { id: 51, type: 'InteractiveLearningUnit' }, # docker export
      
      # Logging configuration
      { id: 49, type: 'InteractiveLearningUnit' }, # docker run -d --log-driver
      
      # Advanced system commands
      { id: 14, type: 'InteractiveLearningUnit' }, # docker events
      { id: 15, type: 'InteractiveLearningUnit' }, # docker context create
      { id: 16, type: 'InteractiveLearningUnit' }, # docker plugin install
      
      # Labs at end of module
      { id: 2, type: 'HandsOnLab' },  # Port Mapping and Network Access
      { id: 3, type: 'HandsOnLab' },  # Environment Variables and Configuration
      { id: 10, type: 'HandsOnLab' }, # Resource Limits
      { id: 14, type: 'HandsOnLab' }, # Container Performance Monitoring
      { id: 15, type: 'HandsOnLab' }, # Backup and Restore Container Data
    ]
  },
  
  'images-dockerfiles' => {
    sequence: 3,
    title: 'Images and Dockerfiles',
    description: 'Build, manage, and optimize Docker images',
    units: [
      # Basic image operations
      { id: 17, type: 'InteractiveLearningUnit' }, # docker images
      { id: 18, type: 'InteractiveLearningUnit' }, # docker pull nginx:alpine
      { id: 19, type: 'InteractiveLearningUnit' }, # docker rmi
      { id: 21, type: 'InteractiveLearningUnit' }, # docker image prune
      
      # Building images
      { id: 22, type: 'InteractiveLearningUnit' }, # docker build -t myapp:v1 .
      { id: 23, type: 'InteractiveLearningUnit' }, # docker history
      
      # Tagging and versioning
      { id: 20, type: 'InteractiveLearningUnit' }, # docker tag
      
      # Image import/export
      { id: 25, type: 'InteractiveLearningUnit' }, # docker save
      { id: 24, type: 'InteractiveLearningUnit' }, # docker load
      { id: 26, type: 'InteractiveLearningUnit' }, # docker commit
      { id: 27, type: 'InteractiveLearningUnit' }, # docker import
      
      # Labs at end of module
      { id: 6, type: 'HandsOnLab' },  # Build Your First Docker Image
      { id: 7, type: 'HandsOnLab' },  # Multi-Stage Builds
    ]
  },
  
  'volumes-and-storage' => {
    sequence: 4,
    title: 'Volumes & Storage',
    description: 'Data persistence and volume management',
    units: [
      # Volume lifecycle
      { id: 53, type: 'InteractiveLearningUnit' }, # docker volume create
      { id: 54, type: 'InteractiveLearningUnit' }, # docker volume ls
      { id: 59, type: 'InteractiveLearningUnit' }, # docker volume inspect
      { id: 56, type: 'InteractiveLearningUnit' }, # docker volume rm
      { id: 55, type: 'InteractiveLearningUnit' }, # docker volume prune
      
      # Volume mounting
      { id: 57, type: 'InteractiveLearningUnit' }, # docker run -d -v /host/path:/container/path
      { id: 58, type: 'InteractiveLearningUnit' }, # docker run -d --mount
      
      # Lab at end of module
      { id: 4, type: 'HandsOnLab' }, # Volume Mounting - Data Persistence
    ]
  },
  
  'networking-and-ports' => {
    sequence: 5,
    title: 'Networking & Ports',
    description: 'Docker networking and container communication',
    units: [
      # Network lifecycle
      { id: 60, type: 'InteractiveLearningUnit' }, # docker network create
      { id: 61, type: 'InteractiveLearningUnit' }, # docker network ls
      { id: 66, type: 'InteractiveLearningUnit' }, # docker network inspect
      { id: 63, type: 'InteractiveLearningUnit' }, # docker network rm
      { id: 64, type: 'InteractiveLearningUnit' }, # docker network prune
      
      # Container network operations
      { id: 62, type: 'InteractiveLearningUnit' }, # docker run -d --network
      { id: 65, type: 'InteractiveLearningUnit' }, # docker network connect
      { id: 67, type: 'InteractiveLearningUnit' }, # docker network disconnect
      
      # Lab at end of module
      { id: 8, type: 'HandsOnLab' }, # Docker Networks - Container Communication
    ]
  },
  
  'registries-ci-cd' => {
    sequence: 6,
    title: 'Registries & CI/CD',
    description: 'Working with Docker registries and image distribution',
    units: [
      # Registry authentication
      { id: 29, type: 'InteractiveLearningUnit' }, # docker login
      { id: 31, type: 'InteractiveLearningUnit' }, # docker search nginx
      
      # Push/pull operations
      { id: 28, type: 'InteractiveLearningUnit' }, # docker push
      { id: 30, type: 'InteractiveLearningUnit' }, # docker logout
      
      # Lab at end of module
      { id: 11, type: 'HandsOnLab' }, # Docker Registry - Push and Pull Custom Images
    ]
  },
  
  'docker-compose' => {
    sequence: 7,
    title: 'Docker Compose',
    description: 'Multi-container applications with Docker Compose',
    units: [
      # Compose lifecycle
      { id: 100, type: 'InteractiveLearningUnit' }, # docker-compose up -d
      { id: 102, type: 'InteractiveLearningUnit' }, # docker-compose ps
      { id: 101, type: 'InteractiveLearningUnit' }, # docker-compose logs
      { id: 99, type: 'InteractiveLearningUnit' },  # docker-compose down
      
      # Compose operations
      { id: 103, type: 'InteractiveLearningUnit' }, # docker-compose build
      { id: 104, type: 'InteractiveLearningUnit' }, # docker-compose exec
      { id: 105, type: 'InteractiveLearningUnit' }, # docker-compose restart
      { id: 106, type: 'InteractiveLearningUnit' }, # docker-compose scale
      
      # Lab at end of module
      { id: 9, type: 'HandsOnLab' }, # Docker Compose - Multi-Container Application
    ]
  },
  
  'security-best-practices' => {
    sequence: 8,
    title: 'Security & Best Practices',
    description: 'Container security, secrets management, and production best practices',
    units: [
      # Secrets management
      { id: 96, type: 'InteractiveLearningUnit' }, # docker secret create
      { id: 94, type: 'InteractiveLearningUnit' }, # docker secret ls
      { id: 97, type: 'InteractiveLearningUnit' }, # docker secret inspect
      { id: 95, type: 'InteractiveLearningUnit' }, # docker secret rm
      
      # Security features
      { id: 98, type: 'InteractiveLearningUnit' }, # docker trust sign
      
      # Labs at end of module
      { id: 12, type: 'HandsOnLab' }, # Health Checks and Auto-Restart
      { id: 13, type: 'HandsOnLab' }, # Docker Security - Non-Root User and Read-Only
      { id: 16, type: 'HandsOnLab' }, # Troubleshooting Docker Containers
      { id: 5, type: 'HandsOnLab' },  # Container Logs and Debugging
    ]
  },
  
  'codesprout-deployment' => {
    sequence: 9,
    title: 'CodeSprout Deployment Project',
    description: 'Real-world deployment scenarios and final project',
    units: [
      # Single special CodeSprout unit
      { id: 107, type: 'InteractiveLearningUnit' }, # CodeSprout: Exposing Containers with Port Mapping
      
      # Note: Kubernetes labs (17-39) belong in the Kubernetes course
      # Docker course is complete with Docker-specific content only
    ]
  }
}

# Process each module
puts "\n📚 Reorganizing modules..."
module_structure.each do |slug, config|
  module_record = course.course_modules.find_by(slug: slug)
  
  unless module_record
    puts "⚠️  Creating missing module: #{slug}"
    module_record = course.course_modules.create!(
      slug: slug,
      title: config[:title],
      description: config[:description],
      sequence_order: config[:sequence],
      published: true
    )
  end
  
  # Update module metadata
  module_record.update!(
    title: config[:title],
    description: config[:description],
    sequence_order: config[:sequence]
  )
  
  puts "\n  📦 Module #{config[:sequence]}: #{config[:title]}"
  puts "     #{config[:units].length} items"
  
  # Create module items in sequence
  config[:units].each_with_index do |unit_config, index|
    item = if unit_config[:type] == 'InteractiveLearningUnit'
      InteractiveLearningUnit.find(unit_config[:id])
    else
      HandsOnLab.find(unit_config[:id])
    end
    
    ModuleItem.create!(
      course_module: module_record,
      item: item,
      sequence_order: index + 1
    )
    
    puts "     #{index + 1}. #{unit_config[:type]}: #{item.title}"
  end
end

# Report on unused items
puts "\n\n📊 Summary Report"
puts "=" * 60

all_unit_ids = module_structure.values.flat_map { |v| v[:units].map { |u| u[:id] if u[:type] == 'InteractiveLearningUnit' }.compact }
all_lab_ids = module_structure.values.flat_map { |v| v[:units].map { |u| u[:id] if u[:type] == 'HandsOnLab' }.compact }

unused_units = InteractiveLearningUnit.where.not(id: all_unit_ids)
unused_labs = HandsOnLab.where(lab_type: ['docker', 'docker-compose'], is_active: true).where.not(id: all_lab_ids)

puts "\n✅ Organized:"
puts "   - #{all_unit_ids.length} Interactive Learning Units"
puts "   - #{all_lab_ids.length} Hands-On Labs"
puts "   - #{module_structure.keys.length} Modules"

if unused_units.any?
  puts "\n⚠️  Unused Interactive Learning Units (#{unused_units.count}):"
  unused_units.each { |u| puts "   - ID #{u.id}: #{u.title}" }
end

if unused_labs.any?
  puts "\n⚠️  Unused Docker Labs (#{unused_labs.count}):"
  unused_labs.each { |lab| puts "   - ID #{lab.id}: #{lab.title}" }
end

puts "\n" + "=" * 60
puts "✅ Docker Course Reorganization Complete!"
puts "\n💡 Docker Swarm removed - focusing on Kubernetes for orchestration"
puts "   CodeSprout Kubernetes labs (17-39) remain in Kubernetes course"
puts "   Docker course now has 8 focused modules preparing for Kubernetes"
