# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

puts "🌱 Starting database seeding..."

# Load seed files in order
seed_files = [
  # ============================================
  # STEP 1: Reference Data (No dependencies)
  # ============================================
  'docker_commands.rb',              # 106 DockerCommand reference entries
  'kubernetes_resources.rb',         # K8s resource definitions
  
  # ============================================
  # STEP 2: HandsOnLab Exercises
  # ============================================
  'docker_labs.rb',                  # 17 general Docker labs
  'kubernetes_labs.rb',              # K8s labs
  'postgresql_sql_labs.rb',          # SQL labs
  'networking_labs.rb',              # 5 networking labs
  'codesprout_deployment_labs.rb',   # 5 CodeSprout application labs
  
  # ============================================
  # STEP 3: Course Structure (creates modules)
  # ============================================
  'course_system.rb',                # Creates Docker course + modules
  
  # ============================================
  # STEP 4: Docker Interactive Learning Units (106 units)
  # ============================================
  'docker_basics_units.rb',          # Docker Basics module units
  'docker_containers_units.rb',      # Docker Containers module units
  'docker_images_units.rb',          # Docker Images module units
  'docker_compose_units.rb',         # Docker Compose module units
  'docker_networks_units.rb',        # Docker Networks module units
  'docker_volumes_units.rb',         # Docker Volumes module units (note: duplicate in list)
  'docker_swarm_units.rb',           # Docker Swarm module units
  'docker_security_units.rb',        # Docker Security module units
  'docker_registry_units.rb',        # Docker Registry module units
  
  # ============================================
  # STEP 5: CodeSprout Core Curriculum
  # ============================================
  'codesprout_curriculum.rb',        # Chapters 1-9 (basics)
  'codesprout_deployment_units.rb',  # Chapters 108-122 (deployment)
  
  # ============================================
  # STEP 6: DCA Exam Chapters 10-54
  # ============================================
  # NOTE: Enhancement files commented out because base chapters don't exist yet
  # These files enhance chapters that need to be created first
  
  # # Images (10-14)
  # 'create_docker_chapters_10_14.rb',
  # 'enhance_chapters_11_14_dca.rb',
  #
  # # Dockerfiles (15-21)
  # 'enhance_chapters_15_21_dockerfiles.rb',
  # 'enhance_ch15_from_run.rb',
  # 'enhance_ch16_copy_add.rb',
  # 'enhance_ch17_env_arg.rb',
  # 'enhance_ch18_expose_cmd.rb',
  # 'enhance_ch19_entrypoint_workdir.rb',
  # 'enhance_ch20_multistage.rb',
  # 'enhance_ch21_optimization.rb',
  #
  # # Networking (21-27)
  # 'enhance_networking_batch.rb',
  # 'enhance_networking_batch2.rb',
  # 'enhance_networking_batch3.rb',
  #
  # # Volumes (28-34)
  # 'enhance_volumes_all.rb',
  # 'enhance_volumes_30_34.rb',
  #
  # # Docker Compose (35-41)
  # 'enhance_compose_all.rb',
  #
  # # Swarm (42-49)
  # 'enhance_swarm_all.rb',
  #
  # # Security (50-54)
  # 'enhance_security_all.rb',
  
  # ============================================
  # STEP 7: Module Organization & Linking
  # ============================================
  # NOTE: These files use hardcoded IDs and fail on fresh database
  # The core curriculum files already handle module linking
  
  # 'assign_lessons_to_modules.rb',   # Already done in curriculum files
  # 'reorganize_docker_course.rb',    # Uses hardcoded IDs
  # 'finalize_module_sequences.rb',   # Uses hardcoded IDs
  
  # ============================================
  # STEP 8: Other Courses
  # ============================================
  'kubernetes_complete_guide.rb',
  'kubectl_learning_content.rb',
  'linux_fundamentals_course.rb',
  'linux_labs.rb',

  # Browser-Based Linux Fundamentals Course (8 hours)
  'linux_browser_course.rb',          # Modules 1-3
  'linux_browser_course_part2.rb',    # Modules 5-6
  'linux_browser_course_part3.rb',    # Module 7 + Capstone

  'coding_interview_course.rb',
  'golang_course.rb',
  'golang_code_labs.rb',
  
  # IIT JEE Chemistry
  'iit_jee/iit_jee_inorganic_chemistry.rb',
  'organic/module_01_goc.rb',
  'organic/modules_02_to_05_core.rb',
  'iit_jee/iit_jee_physical_chemistry_formulas.rb',

  # ============================================
  # STEP 9: YAML-Based Courses
  # ============================================
  # Loads courses defined in YAML format from:
  # - db/seeds/converted_microlessons/
  # - db/seeds/docker_complete_enhanced/
  'yaml_course_loader.rb',

  # Test Prep - Commented out due to schema incompatibility
  # 'gre/gre_quantitative_reasoning.rb',
  # 'cat/cat_quantitative_ability.rb'
]

seed_files.each do |seed_file|
  seed_path = Rails.root.join('db', 'seeds', seed_file)
  
  if File.exist?(seed_path)
    puts "\n📂 Loading #{seed_file}..."
    load seed_path
  else
    puts "⚠️  Seed file not found: #{seed_file}"
  end
end

puts "\n✅ Database seeding complete!"
