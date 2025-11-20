# Course Migrator
# Converts existing database courses (from seeds) to template DSL format
#
# Features:
# - Zero data loss - preserves all course content
# - Auto-detects plugins based on course features
# - Generates proper lab format configuration
# - Handles all item types: lessons, quizzes, labs
# - Creates runnable template files
#
# Usage:
#   CourseBuilder::Migrator.migrate_course('docker-fundamentals')
#   CourseBuilder::Migrator.migrate_all_courses

module CourseBuilder
  class Migrator
    class << self
      # Migrate a single course from database to template
      def migrate_course(course_slug, output_dir: nil)
        output_dir ||= Rails.root.join('lib', 'course_templates')

        course = Course.find_by!(slug: course_slug)

        puts "🔄 Migrating course: #{course.title} (#{course_slug})"

        # Generate template content
        template_content = generate_template(course)

        # Write to file
        filename = "#{course_slug.underscore}.rb"
        filepath = File.join(output_dir, filename)

        File.write(filepath, template_content)

        puts "✅ Template created: #{filepath}"
        puts "📊 Stats:"

        module_ids = course.course_modules.pluck(:id)

        lesson_count = ModuleItem.where(
          course_module_id: module_ids,
          item_type: 'CourseLesson'
        ).count

        lab_count = ModuleItem.where(
          course_module_id: module_ids,
          item_type: ['HandsOnLab', 'InteractiveLearningUnit']
        ).count

        quiz_count = ModuleItem.where(
          course_module_id: module_ids,
          item_type: 'Quiz'
        ).count

        puts "   - Modules: #{course.course_modules.count}"
        puts "   - Lessons: #{lesson_count}"
        puts "   - Labs: #{lab_count}"
        puts "   - Quizzes: #{quiz_count}"

        filepath
      end

      # Migrate all courses
      def migrate_all_courses(output_dir: nil)
        output_dir ||= Rails.root.join('lib', 'course_templates')
        FileUtils.mkdir_p(output_dir)

        courses = Course.all
        puts "🚀 Migrating #{courses.count} courses..."
        puts ""

        results = []

        courses.each do |course|
          begin
            filepath = migrate_course(course.slug, output_dir: output_dir)
            results << { course: course.slug, status: :success, file: filepath }
          rescue => e
            puts "❌ Error migrating #{course.slug}: #{e.message}"
            results << { course: course.slug, status: :error, error: e.message }
          end
          puts ""
        end

        # Summary
        puts "=" * 60
        puts "Migration Summary"
        puts "=" * 60
        successful = results.count { |r| r[:status] == :success }
        failed = results.count { |r| r[:status] == :error }

        puts "✅ Successful: #{successful}"
        puts "❌ Failed: #{failed}"

        if failed > 0
          puts "\nFailed courses:"
          results.select { |r| r[:status] == :error }.each do |r|
            puts "  - #{r[:course]}: #{r[:error]}"
          end
        end

        results
      end

      private

      # Generate template DSL code from database course
      def generate_template(course)
        # Detect plugins and lab format
        plugins = detect_plugins(course)
        lab_format = detect_lab_format(course)
        config = detect_config(course)

        # Build template string
        template = []
        template << "# #{course.title}"
        template << "# Generated from database on #{Time.current.strftime('%Y-%m-%d')}"
        template << "# Original slug: #{course.slug}"
        template << ""
        template << "CourseBuilder::DSL.define('#{course.slug}') do"
        template << "  course("
        template << "    title: #{course.title.inspect},"
        template << "    description: #{course.description.inspect},"
        template << "    difficulty_level: #{course.difficulty_level.inspect},"
        template << "    estimated_hours: #{course.estimated_hours || 10},"
        template << "    certification_track: #{course.certification_track.inspect}"
        template << "  ) do"
        template << ""

        # Add plugins
        plugins.each do |plugin_name, options|
          template << "    # Plugin: #{plugin_name}"
          if options.empty?
            template << "    plugin :#{plugin_name}"
          else
            template << "    plugin :#{plugin_name}, #{format_hash(options)}"
          end
          template << ""
        end

        # Add config
        unless config.empty?
          template << "    # Course configuration"
          template << "    config #{format_hash(config)}"
          template << ""
        end

        # Add modules
        course.course_modules.order(:sequence_order).each do |course_module|
          template << generate_module(course_module, indent: 4)
          template << ""
        end

        template << "  end"
        template << "end"
        template << ""

        template.join("\n")
      end

      # Generate module DSL
      def generate_module(course_module, indent: 4)
        lines = []
        ind = " " * indent

        lines << "#{ind}mod #{course_module.title.inspect} do"
        lines << "#{ind}  # Module: #{course_module.slug}"
        lines << ""

        # Get all module items in order
        items = course_module.module_items.includes(:item).order(:sequence_order)

        items.each do |module_item|
          case module_item.item_type
          when 'CourseLesson'
            lines << generate_lesson(module_item.item, indent: indent + 2)
          when 'Quiz'
            lines << generate_quiz(module_item.item, indent: indent + 2)
          when 'HandsOnLab', 'InteractiveLearningUnit'
            lines << generate_lab(module_item.item, indent: indent + 2)
          end
          lines << ""
        end

        lines << "#{ind}end"

        lines.join("\n")
      end

      # Generate lesson DSL
      def generate_lesson(lesson, indent: 6)
        lines = []
        ind = " " * indent

        lines << "#{ind}lesson #{lesson.title.inspect} do"

        # Content
        if lesson.content.present?
          # Escape heredoc content properly
          content = lesson.content.gsub('\\', '\\\\\\\\')
          lines << "#{ind}  content <<~MARKDOWN"
          lesson.content.each_line do |line|
            lines << "#{ind}    #{line.rstrip}"
          end
          lines << "#{ind}  MARKDOWN"
        end

        # Metadata
        if lesson.respond_to?(:estimated_minutes) && lesson.estimated_minutes.present?
          lines << "#{ind}  estimated_minutes #{lesson.estimated_minutes}"
        elsif lesson.respond_to?(:reading_time_minutes) && lesson.reading_time_minutes.present?
          lines << "#{ind}  estimated_minutes #{lesson.reading_time_minutes}"
        end

        lines << "#{ind}end"

        lines.join("\n")
      end

      # Generate quiz DSL
      def generate_quiz(quiz, indent: 6)
        lines = []
        ind = " " * indent

        lines << "#{ind}quiz #{quiz.title.inspect} do"

        if quiz.description.present?
          lines << "#{ind}  description #{quiz.description.inspect}"
        end

        # Questions
        questions = quiz.quiz_questions.order(:sequence_order)
        questions.each do |question|
          lines << ""
          lines << "#{ind}  question do"
          lines << "#{ind}    text #{question.question_text.inspect}"
          lines << "#{ind}    type #{question.question_type.inspect}"

          # Options for multiple choice
          if question.question_type == 'multiple_choice' && question.options.present?
            lines << "#{ind}    options #{question.options.inspect}"
          end

          lines << "#{ind}    correct_answer #{question.correct_answer.inspect}"

          if question.explanation.present?
            lines << "#{ind}    explanation #{question.explanation.inspect}"
          end

          lines << "#{ind}  end"
        end

        # Metadata
        if quiz.passing_score.present?
          lines << ""
          lines << "#{ind}  passing_score #{quiz.passing_score}"
        end

        if quiz.max_attempts.present?
          lines << "#{ind}  max_attempts #{quiz.max_attempts}"
        end

        lines << "#{ind}end"

        lines.join("\n")
      end

      # Generate lab DSL
      def generate_lab(lab, indent: 6)
        lines = []
        ind = " " * indent

        lab_type = detect_item_lab_type(lab)

        lines << "#{ind}lab #{lab.title.inspect}, lab_type: #{lab_type.inspect} do"

        if lab.description.present?
          lines << "#{ind}  description #{lab.description.inspect}"
        end

        # Steps for terminal labs
        if lab.respond_to?(:steps) && lab.steps.present?
          # Parse steps if they're stored as JSON string
          steps_data = lab.steps.is_a?(String) ? JSON.parse(lab.steps) : lab.steps

          steps_data.each do |step|
            lines << ""
            lines << "#{ind}  step #{step['title'].inspect} do"
            lines << "#{ind}    instruction #{step['instruction'].inspect}"

            if step['expected_command'].present?
              lines << "#{ind}    command #{step['expected_command'].inspect}"
            end

            if step['hint'].present?
              lines << "#{ind}    hint #{step['hint'].inspect}"
            end

            lines << "#{ind}  end"
          end
        end

        # Code editor labs
        if lab.respond_to?(:programming_language) && lab.programming_language.present?
          lines << ""
          lines << "#{ind}  programming_language #{lab.programming_language.inspect}"

          if lab.starter_code.present?
            lines << "#{ind}  starter_code <<~CODE"
            lab.starter_code.each_line do |line|
              lines << "#{ind}    #{line.rstrip}"
            end
            lines << "#{ind}  CODE"
          end

          if lab.test_cases.present?
            lines << ""
            lines << "#{ind}  # Test cases"
            lab.test_cases.each do |test_case|
              lines << "#{ind}  test_case do"
              lines << "#{ind}    name #{test_case['name'].inspect}" if test_case['name']
              lines << "#{ind}    input #{test_case['input'].inspect}"
              lines << "#{ind}    expected_output #{test_case['expected_output'].inspect}"
              lines << "#{ind}    points #{test_case['points']}" if test_case['points']
              lines << "#{ind}  end"
            end
          end
        end

        # SQL labs
        if lab.respond_to?(:schema_setup) && lab.schema_setup.present?
          lines << ""
          lines << "#{ind}  schema_setup <<~SQL"
          lab.schema_setup.each_line do |line|
            lines << "#{ind}    #{line.rstrip}"
          end
          lines << "#{ind}  SQL"
        end

        # Metadata
        if lab.respond_to?(:difficulty) && lab.difficulty.present?
          lines << ""
          lines << "#{ind}  difficulty #{lab.difficulty.inspect}"
        end

        if lab.respond_to?(:estimated_minutes) && lab.estimated_minutes.present?
          lines << "#{ind}  estimated_minutes #{lab.estimated_minutes}"
        end

        lines << "#{ind}end"

        lines.join("\n")
      end

      # Detect plugins based on course characteristics
      def detect_plugins(course)
        plugins = {}

        course_slug = course.slug.downcase

        # Progressive learning for Docker/K8s
        if course_slug.include?('docker') || course_slug.include?('kubernetes')
          plugins[:progressive_learning] = { enabled: true, hints: true }
        end

        # Command reference for terminal-based courses
        if course_slug.include?('docker') || course_slug.include?('kubernetes') || course_slug.include?('linux')
          command_type = if course_slug.include?('docker')
            'docker'
          elsif course_slug.include?('kubernetes')
            'kubernetes'
          else
            'linux'
          end
          plugins[:command_reference] = { command_type: command_type }
        end

        # Formula sheet for academic courses
        if course_slug.include?('jee') || course_slug.include?('chemistry') || course_slug.include?('mathematics') || course_slug.include?('physics')
          subject = if course_slug.include?('chemistry')
            'chemistry'
          elsif course_slug.include?('mathematics')
            'mathematics'
          else
            'physics'
          end
          plugins[:formula_sheet] = { subject: subject, downloadable: true }
        end

        plugins
      end

      # Detect lab format based on course content
      def detect_lab_format(course)
        # Check first lab to determine format
        module_ids = course.course_modules.pluck(:id)
        first_lab_item = ModuleItem.where(
          course_module_id: module_ids,
          item_type: ['HandsOnLab', 'InteractiveLearningUnit']
        ).first

        return 'terminal' unless first_lab_item

        first_lab = first_lab_item.item

        if first_lab.respond_to?(:programming_language) && first_lab.programming_language.present?
          'code_editor'
        elsif first_lab.respond_to?(:schema_setup) && first_lab.schema_setup.present?
          'sql_editor'
        elsif first_lab.respond_to?(:steps) && first_lab.steps.present?
          'terminal'
        else
          'terminal'
        end
      end

      # Detect lab type for individual lab item
      def detect_item_lab_type(lab)
        if lab.respond_to?(:programming_language) && lab.programming_language.present?
          lab.programming_language
        elsif lab.respond_to?(:schema_setup) && lab.schema_setup.present?
          'sql'
        elsif lab.respond_to?(:lab_type) && lab.lab_type.present?
          lab.lab_type
        else
          'terminal'
        end
      end

      # Detect course configuration
      def detect_config(course)
        config = {}

        # Theme based on course type
        course_slug = course.slug.downcase
        if course_slug.include?('docker')
          config[:theme] = 'docker-pro'
        elsif course_slug.include?('kubernetes')
          config[:theme] = 'k8s-blue'
        elsif course_slug.include?('security')
          config[:theme] = 'security-dark'
        end

        # Prerequisites
        if course.prerequisites.present?
          config[:prerequisites] = course.prerequisites
        end

        config
      end

      # Format hash for Ruby code generation
      def format_hash(hash)
        return '{}' if hash.empty?

        items = hash.map do |key, value|
          "#{key}: #{value.inspect}"
        end

        "{ #{items.join(', ')} }"
      end
    end
  end
end
