# Course Generator Rake Tasks
# Usage:
#   rails course:generate[template_name]          # Generate from template
#   rails course:seed[template_name]              # Run seed for specific course
#   rails course:list                             # List available templates
#   rails course:validate[template_name]          # Validate template without creating

namespace :course do
  desc "Generate and seed a course from a template"
  task :generate, [:template_name] => :environment do |t, args|
    require_relative '../course_builder/dsl'
    require_relative '../course_builder/generator'

    template_name = args[:template_name]

    unless template_name
      puts "❌ Error: Please provide a template name"
      puts "Usage: rails course:generate[template_name]"
      puts ""
      puts "Available templates:"
      list_templates
      next
    end

    template_path = Rails.root.join("lib", "course_templates", "#{template_name}.rb")

    unless File.exist?(template_path)
      puts "❌ Error: Template not found: #{template_path}"
      puts ""
      puts "Available templates:"
      list_templates
      next
    end

    puts "🚀 Generating course from template: #{template_name}"
    puts "=" * 60

    # Load and execute the template
    begin
      dsl = load_template(template_path)
      generator = CourseBuilder::Generator.new(dsl)
      result = generator.generate!

      if result[:success]
        puts ""
        puts "=" * 60
        puts "✅ Course generated successfully!"
        puts "   Course: #{result[:course].title}"
        puts "   Modules: #{result[:modules].length}"
        puts "   Items: #{result[:modules].sum { |m| m.module_items.count }}"
        puts "=" * 60
      else
        puts ""
        puts "=" * 60
        puts "❌ Failed to generate course"
        puts "   Error: #{result[:error]}"
        puts "   Backtrace:"
        result[:backtrace]&.each { |line| puts "     #{line}" }
        puts "=" * 60
      end
    rescue => e
      puts ""
      puts "=" * 60
      puts "❌ Error loading template"
      puts "   #{e.class}: #{e.message}"
      puts "   Backtrace:"
      e.backtrace.first(10).each { |line| puts "     #{line}" }
      puts "=" * 60
    end
  end

  desc "Validate a course template without creating records"
  task :validate, [:template_name] => :environment do |t, args|
    require_relative '../course_builder/dsl'

    template_name = args[:template_name]

    unless template_name
      puts "❌ Error: Please provide a template name"
      puts "Usage: rails course:validate[template_name]"
      next
    end

    template_path = Rails.root.join("lib", "course_templates", "#{template_name}.rb")

    unless File.exist?(template_path)
      puts "❌ Error: Template not found: #{template_path}"
      next
    end

    puts "🔍 Validating template: #{template_name}"
    puts "=" * 60

    begin
      dsl = load_template(template_path)
      data = dsl.to_course_object

      puts "Course: #{data[:course][:title]}"
      puts "  Slug: #{data[:course][:slug]}"
      puts "  Difficulty: #{data[:course][:difficulty_level]}"
      puts "  Modules: #{data[:modules].length}"
      puts ""

      data[:modules].each_with_index do |mod, idx|
        puts "Module #{idx + 1}: #{mod[:title]}"
        puts "  Items: #{mod[:items].length}"

        mod[:items].each do |item|
          item_icon = case item[:type]
                      when :lesson then "📖"
                      when :quiz then "❓"
                      when :lab then "🧪"
                      when :interactive_unit then "🎓"
                      else "•"
                      end
          puts "    #{item_icon} #{item[:title]} (#{item[:type]})"
        end
        puts ""
      end

      puts "=" * 60
      puts "✅ Template is valid!"
      puts "=" * 60
    rescue => e
      puts ""
      puts "=" * 60
      puts "❌ Template validation failed"
      puts "   #{e.class}: #{e.message}"
      puts "   Backtrace:"
      e.backtrace.first(10).each { |line| puts "     #{line}" }
      puts "=" * 60
    end
  end

  desc "List all available course templates"
  task :list => :environment do
    puts "Available Course Templates:"
    puts "=" * 60
    list_templates
    puts "=" * 60
  end

  desc "Seed a specific course template"
  task :seed, [:template_name] => :environment do |t, args|
    # Just call generate
    Rake::Task["course:generate"].invoke(args[:template_name])
  end

  desc "Create a new course template from scratch"
  task :new, [:template_name] => :environment do |t, args|
    require 'fileutils'

    template_name = args[:template_name]

    unless template_name
      puts "❌ Error: Please provide a template name"
      puts "Usage: rails course:new[template_name]"
      next
    end

    slug = template_name.parameterize
    file_name = "#{slug}.rb"
    template_path = Rails.root.join("lib", "course_templates", file_name)

    if File.exist?(template_path)
      puts "❌ Error: Template already exists: #{template_path}"
      next
    end

    # Create template directory if it doesn't exist
    FileUtils.mkdir_p(Rails.root.join("lib", "course_templates"))

    # Create template file with boilerplate
    File.write(template_path, <<~RUBY)
      # #{template_name.titleize} Course Template
      # Generated: #{Time.now}

      CourseBuilder::DSL.define("#{slug}") do
        course(
          title: "#{template_name.titleize}",
          description: "Description of your course here",
          difficulty_level: "beginner",  # beginner, intermediate, advanced
          estimated_hours: 10,
          certification_track: "docker",  # docker, kubernetes, linux, python, etc.
          published: true,
          sequence_order: 1,
          learning_objectives: [
            "Learning objective 1",
            "Learning objective 2"
          ],
          prerequisites: [
            "Prerequisite 1"
          ]
        ) do
          # Module 1
          mod "Module 1 Title" do
            description "Module description"
            estimated_minutes 120
            learning_objectives "Objective 1", "Objective 2"

            # Lesson example
            lesson "Lesson 1: Introduction" do
              content <<~MARKDOWN
                # Lesson Title

                Your lesson content in markdown format.

                ## Key Concepts
                - Concept 1
                - Concept 2
              MARKDOWN

              reading_time 15
              key_concepts "Concept 1", "Concept 2"
              key_commands "command1", "command2"
            end

            # Quiz example
            quiz "Module 1 Quiz", passing_score: 70, max_attempts: 3 do
              mcq "What is X?",
                options: [
                  { text: "Option A", correct: true },
                  { text: "Option B", correct: false }
                ],
                correct: "Option A",
                explanation: "Explanation here"

              true_false "Statement is true?",
                correct: true,
                explanation: "Explanation"
            end

            # Terminal Lab example
            lab "Lab 1: Hands-On Practice",
              lab_type: "docker",
              format: "terminal",
              difficulty: "easy",
              estimated_minutes: 30,
              category: "basics" do

              description "Lab description"

              step "Step 1", command: "docker ps", validation: "docker ps | wc -l"
              step "Step 2", command: "docker run hello-world"

              validation_rule :all_steps_completed, "All steps must be completed"
            end

            # Code Editor Lab example (Python)
            # lab "Lab 2: Code Challenge",
            #   lab_type: "python",
            #   format: "code_editor",
            #   difficulty: "medium",
            #   estimated_minutes: 45,
            #   programming_language: "python" do
            #
            #   starter_code <<~PYTHON
            #     def solution():
            #         # Your code here
            #         pass
            #   PYTHON
            #
            #   solution_code <<~PYTHON
            #     def solution():
            #         return "Hello World"
            #   PYTHON
            #
            #   test_case description: "Test 1", input: "solution()", expected_output: "Hello World"
            # end
          end

          # Add more modules as needed
        end
      end
    RUBY

    puts "✅ Created new course template: #{template_path}"
    puts ""
    puts "Next steps:"
    puts "  1. Edit the template: #{template_path}"
    puts "  2. Validate: rails course:validate[#{slug}]"
    puts "  3. Generate: rails course:generate[#{slug}]"
  end

  # Helper method to load templates
  def load_template(template_path)
    # Load the template file which should return a DSL instance
    eval(File.read(template_path), binding, template_path.to_s)
  end

  # Helper to list available templates
  def list_templates
    templates_dir = Rails.root.join("lib", "course_templates")

    if Dir.exist?(templates_dir)
      templates = Dir.glob(File.join(templates_dir, "*.rb"))

      if templates.empty?
        puts "  No templates found in #{templates_dir}"
        puts ""
        puts "Create a new template with: rails course:new[template_name]"
      else
        templates.each do |template|
          name = File.basename(template, ".rb")
          puts "  - #{name}"
        end
      end
    else
      puts "  Templates directory not found: #{templates_dir}"
      puts "  Creating directory..."
      FileUtils.mkdir_p(templates_dir)
    end
  end
end
