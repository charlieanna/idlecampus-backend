#!/usr/bin/env ruby
require 'yaml'
require 'fileutils'

# Define the consolidated Linux/DevOps courses
devops_courses = {
  'linux-shell-fundamentals' => {
    'title' => 'Linux & Shell Scripting Fundamentals',
    'description' => 'Master Linux command line, filesystem navigation, and shell scripting for DevOps. Learn essential Linux skills including bash scripting, process management, and automation.',
    'estimated_hours' => 8,
    'level' => 'beginner',
    'prerequisites' => [
      'Basic computer literacy',
      'Understanding of command line concepts'
    ],
    'learning_outcomes' => [
      'Navigate and manage Linux filesystem',
      'Execute Linux commands for file and process management',
      'Write bash scripts for automation',
      'Understand Linux permissions and security basics',
      'Automate repetitive tasks with shell scripts'
    ],
    'tags' => ['linux', 'bash', 'shell-scripting', 'devops', 'sysadmin', 'automation'],
    'related_courses' => ['devops-essentials', 'docker-fundamentals'],
    'recommended_next' => 'devops-essentials',
    'modules' => [
      {
        'slug' => 'introduction-to-linux',
        'title' => 'Introduction to Linux',
        'description' => 'Linux filesystem hierarchy, navigation commands, file operations, and permissions',
        'order' => 1,
        'estimated_hours' => 2,
        'source_courses' => ['linux-basics-navigation']
      },
      {
        'slug' => 'shell-basics',
        'title' => 'Linux Shell Basics',
        'description' => 'Shell introduction, basic commands, and working with processes',
        'order' => 2,
        'estimated_hours' => 2,
        'source_courses' => ['intro-linux-shell'],
        'exclude_lessons' => ['practice-question'] # Exclude the 23 missing practice questions
      },
      {
        'slug' => 'bash-scripting',
        'title' => 'Bash Scripting',
        'description' => 'Introduction to bash, variables, and data types',
        'order' => 3,
        'estimated_hours' => 2,
        'source_courses' => ['bash-basics']
      },
      {
        'slug' => 'shell-automation',
        'title' => 'Shell Scripting Automation',
        'description' => 'Automation scripts and advanced scripting techniques',
        'order' => 4,
        'estimated_hours' => 2,
        'source_courses' => ['shell-scripting-automation'],
        'exclude_lessons' => ['practice-question'] # If any
      }
    ]
  },

  'devops-essentials' => {
    'title' => 'DevOps Essentials - Version Control, CI/CD & IaC',
    'description' => 'Modern DevOps practices including Git version control, CI/CD pipelines, Infrastructure as Code with Terraform, and networking fundamentals. Build automated deployment workflows.',
    'estimated_hours' => 10,
    'level' => 'intermediate',
    'prerequisites' => [
      'Basic Linux command line knowledge',
      'Understanding of software development lifecycle',
      'Linux & Shell Scripting Fundamentals (recommended)'
    ],
    'learning_outcomes' => [
      'Master Git version control and collaboration workflows',
      'Build and maintain CI/CD pipelines',
      'Provision infrastructure with Terraform (IaC)',
      'Automate deployment and testing',
      'Understand networking for cloud and containers'
    ],
    'tags' => ['devops', 'git', 'cicd', 'terraform', 'iac', 'automation', 'networking'],
    'related_courses' => ['linux-shell-fundamentals', 'aws-cloud-fundamentals', 'docker-fundamentals'],
    'recommended_next' => 'aws-cloud-fundamentals',
    'modules' => [
      {
        'slug' => 'version-control-git',
        'title' => 'Version Control with Git',
        'description' => 'Git basics, branching, and collaboration (Note: Currently only 1 lesson - needs expansion)',
        'order' => 1,
        'estimated_hours' => 2,
        'source_courses' => ['git-fundamentals'],
        'note' => 'NEEDS EXPANSION: Should add 5-7 more lessons on branching, merging, GitHub workflows'
      },
      {
        'slug' => 'cicd-fundamentals',
        'title' => 'CI/CD Fundamentals',
        'description' => 'Continuous Integration and Continuous Delivery pipelines',
        'order' => 2,
        'estimated_hours' => 3,
        'source_courses' => ['cicd-fundamentals']
      },
      {
        'slug' => 'infrastructure-as-code',
        'title' => 'Infrastructure as Code with Terraform',
        'description' => 'Terraform basics, advanced patterns, and configuration management',
        'order' => 3,
        'estimated_hours' => 3,
        'source_courses' => ['iac-fundamentals']
      },
      {
        'slug' => 'networking-fundamentals',
        'title' => 'Networking Fundamentals',
        'description' => 'OSI model, TCP/IP stack, and networking concepts for DevOps',
        'order' => 4,
        'estimated_hours' => 2,
        'source_courses' => ['network-models', 'tcp-ip-fundamentals']
      }
    ]
  },

  'aws-cloud-fundamentals' => {
    'title' => 'AWS Cloud Fundamentals',
    'description' => 'Comprehensive introduction to Amazon Web Services. Master core AWS services including EC2, S3, VPC, RDS, and IAM. Learn to design, deploy, and manage scalable cloud infrastructure.',
    'estimated_hours' => 8,
    'level' => 'intermediate',
    'prerequisites' => [
      'Linux basics',
      'Understanding of networking concepts',
      'DevOps Essentials (recommended, especially IaC module)'
    ],
    'learning_outcomes' => [
      'Deploy and manage EC2 instances',
      'Configure VPCs and networking',
      'Use S3 for object storage',
      'Set up RDS databases',
      'Implement IAM security and access control',
      'Design cost-effective cloud architectures'
    ],
    'tags' => ['aws', 'cloud', 'ec2', 's3', 'vpc', 'devops', 'infrastructure'],
    'certification_prep' => ['AWS Certified Cloud Practitioner', 'AWS Certified Solutions Architect - Associate'],
    'related_courses' => ['devops-essentials', 'docker-fundamentals', 'kubernetes-complete'],
    'modules' => [
      {
        'slug' => 'aws-core-services',
        'title' => 'AWS Core Services',
        'description' => 'EC2, S3, VPC, RDS, IAM, security, and networking',
        'order' => 1,
        'estimated_hours' => 8,
        'source_courses' => ['aws-fundamentals'],
        'exclude_lessons' => ['practice-question'] # If any generic ones
      }
    ]
  }
}

# Read source manifests and get lesson lists
def get_lessons_from_course(course_slug, exclude_lessons = [])
  manifest_path = "db/seeds/converted_microlessons/#{course_slug}/manifest.yml"
  return [] unless File.exist?(manifest_path)

  manifest = YAML.load_file(manifest_path)
  lessons = manifest['modules']&.first&.dig('lessons') || []

  # Filter out excluded lessons (like missing practice-questions)
  lessons.reject { |lesson| exclude_lessons.any? { |exclude| lesson.include?(exclude) } }
end

# Generate manifest files
devops_courses.each do |slug, course_data|
  manifest = {
    'course' => {
      'slug' => slug,
      'title' => course_data['title'],
      'description' => course_data['description'],
      'estimated_hours' => course_data['estimated_hours'],
      'level' => course_data['level'],
      'prerequisites' => course_data['prerequisites'],
      'learning_outcomes' => course_data['learning_outcomes'],
      'tags' => course_data['tags'],
      'related_courses' => devops_courses.keys.reject { |k| k == slug },
      'recommended_next' => course_data['recommended_next']
    },
    'modules' => []
  }

  # Add certification_prep if present
  if course_data['certification_prep']
    manifest['course']['certification_prep'] = course_data['certification_prep']
  end

  # Add modules with lessons from source courses
  course_data['modules'].each do |module_data|
    lessons = []
    exclude_lessons = module_data['exclude_lessons'] || []

    # Get lessons from all source courses for this module
    module_data['source_courses'].each do |source_course|
      course_lessons = get_lessons_from_course(source_course, exclude_lessons)
      lessons.concat(course_lessons)
    end

    module_info = {
      'slug' => module_data['slug'],
      'title' => module_data['title'],
      'description' => module_data['description'],
      'order' => module_data['order'],
      'estimated_hours' => module_data['estimated_hours'],
      'lessons' => lessons.uniq # Remove duplicates if any
    }

    # Add note if present (e.g., for Git expansion needed)
    if module_data['note']
      module_info['note'] = module_data['note']
    end

    manifest['modules'] << module_info
  end

  # Write manifest file
  output_dir = "db/seeds/consolidated_courses/#{slug}"
  FileUtils.mkdir_p(output_dir) unless Dir.exist?(output_dir)

  output_file = File.join(output_dir, 'manifest.yml')
  File.write(output_file, manifest.to_yaml)

  total_lessons = manifest['modules'].sum { |m| m['lessons'].count }
  puts "✓ Generated #{slug} manifest"
  puts "  - #{manifest['modules'].count} modules"
  puts "  - #{total_lessons} lessons"

  # Show note if Git expansion needed
  manifest['modules'].each do |mod|
    if mod['note']
      puts "  ⚠️  #{mod['title']}: #{mod['note']}"
    end
  end
  puts
end

puts "\n✓ All Linux/DevOps course manifests generated successfully!"
puts "\nNotes:"
puts "- Git Fundamentals module has only 1 lesson - recommend adding 5-7 more on branching, workflows, GitHub"
puts "- Intro Linux Shell: Excluded 23 missing practice-question files"
puts "- Networking course (Docker content) excluded from consolidation"
