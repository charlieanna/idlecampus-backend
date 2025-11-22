# frozen_string_literal: true
#
# ⚠️  WARNING: This controller contains DEPRECATED database-based course fetching methods!
#
# IMPORTANT: Courses should ONLY be fetched from YAML files using CourseFileReaderService.
# Many methods in this controller assume courses are database ActiveRecord models, which is
# incorrect. These methods are marked as DEPRECATED and should NOT be used.
#
# The database should ONLY be used for:
# - User enrollments (CourseEnrollment)
# - User progress (ModuleProgress)
# - Quiz attempts (QuizAttempt)
# - User achievements (UserCourseAchievement)
# - Hands-on labs (HandsOnLab) - if labs are separate from courses
#
# For correct course fetching, see:
# - app/controllers/api/v1/courses_controller.rb (uses CourseFileReaderService)
# - app/controllers/api/v1/linux/linux_courses_controller.rb (uses CourseFileReaderService)
#
module Api
  module V1
    class GenericCoursesController < ApplicationController
      skip_before_action :verify_authenticity_token
      skip_before_action :authenticate_user!, raise: false if respond_to?(:skip_before_action)
      protect_from_forgery with: :null_session

      before_action :set_default_format
      before_action :set_cors_headers
      before_action :cors_preflight, if: -> { request.method == 'OPTIONS' }

      private

      def set_default_format
        request.format = :json unless params[:format]
      end

      def set_cors_headers
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
        headers['Access-Control-Allow-Headers'] = 'Content-Type, Authorization'
        headers['Access-Control-Max-Age'] = '3600'
      end

      def cors_preflight
        head :ok
      end

      # DEPRECATED: This method assumes 'course' is a database ActiveRecord model.
      # Courses should be fetched from YAML files (as Hash), not from the database.
      # For YAML-based courses, use the course hash directly from CourseFileReaderService.
      def course_summary(course)
        {
          id: course.id,
          title: course.title,
          slug: course.slug,
          description: course.description,
          difficulty_level: course.difficulty_level,
          estimated_hours: course.estimated_hours,
          module_count: course.course_modules.count
        }
      end

      # DEPRECATED: This method assumes 'course' is a database ActiveRecord model.
      # Courses should be fetched from YAML files (as Hash), not from the database.
      # For YAML-based courses, use the course hash directly from CourseFileReaderService.
      def course_detail(course)
        {
          id: course.id,
          title: course.title,
          slug: course.slug,
          description: course.description,
          difficulty_level: course.difficulty_level,
          estimated_hours: course.estimated_hours,
          certification_track: course.certification_track,
          learning_objectives: JSON.parse(course.learning_objectives || '[]'),
          prerequisites: JSON.parse(course.prerequisites || '[]'),
          modules: course.course_modules.ordered.map { |mod| module_summary(mod) }
        }
      end

      def module_summary(mod)
        # Count YAML microlessons
        yaml_count = count_yaml_microlessons(mod)
        
        {
          id: mod.id,
          title: mod.title,
          slug: mod.slug,
          description: mod.description,
          sequence_order: mod.sequence_order,
          estimated_minutes: mod.estimated_minutes,
          item_count: yaml_count  # Only count YAML items, not database items
        }
      end

      def count_yaml_microlessons(mod)
        course = mod.course
        yaml_directories = [
          Rails.root.join('db/seeds/networking_complete_enhanced'),
          Rails.root.join('db/seeds/converted_microlessons/networking'),
          Rails.root.join('db/seeds/docker_complete_enhanced')
        ]
        
        yaml_directories.each do |yaml_dir|
          next unless Dir.exist?(yaml_dir)
          
          manifest_path = File.join(yaml_dir, 'manifest.yml')
          next unless File.exist?(manifest_path)
          
          begin
            manifest = YAML.load_file(manifest_path)
            yaml_course_slug = manifest.dig('course', 'slug')
            
            course_matches = if yaml_course_slug
              course.slug == yaml_course_slug || 
              (course.slug.include?('networking') && yaml_course_slug.include?('networking'))
            else
              false
            end
            
            next unless course_matches
            
            module_data = manifest['modules']&.find { |m| m['slug'].include?('networking') } || manifest['modules']&.first
            next unless module_data
            
            lesson_slugs = module_data['lessons'] || []
            microlessons_dir = File.join(yaml_dir, 'microlessons')
            
            if Dir.exist?(microlessons_dir)
              filtered = filter_microlessons_for_module(lesson_slugs, mod.slug, microlessons_dir)
              return filtered.count
            end
          rescue
            next
          end
        end
        
        0
      end

      def module_detail(mod)
        # ONLY load content from YAML files - no database content
        # All courses are stored in YAML files, not in the database
        microlesson_items = load_microlessons_from_yaml(mod)
        
        # Sort by sequence_order
        all_items = microlesson_items.sort_by { |item| item[:sequence_order] || 9999 }
        
        {
          id: mod.id,
          title: mod.title,
          slug: mod.slug,
          description: mod.description,
          sequence_order: mod.sequence_order,
          estimated_minutes: mod.estimated_minutes,
          learning_objectives: JSON.parse(mod.learning_objectives || '[]'),
          items: all_items,
          microlesson_count: microlesson_items.count
        }
      end

      def item_summary(item)
        {
          id: item.id,
          type: item.item_type,
          sequence_order: item.sequence_order,
          required: item.required,
          content: item_content(item)
        }
      end

      def item_content(item)
        case item.item_type
        when 'CourseLesson'
          {
            id: item.item.id,
            title: item.item.title,
            content: item.item.content,
            reading_time_minutes: item.item.reading_time_minutes,
            key_commands: item.item.key_commands || []
          }
        when 'Quiz'
          {
            id: item.item.id,
            title: item.item.title,
            description: item.item.description,
            time_limit_minutes: item.item.time_limit_minutes
          }
        when 'HandsOnLab'
          lab_summary(item.item)
        end
      end

      def lab_summary(lab)
        base = {
          id: lab.id,
          title: lab.title,
          description: lab.description,
          difficulty: lab.difficulty,
          estimated_minutes: lab.estimated_minutes,
          category: lab.category,
          points_reward: lab.points_reward
        }
        
        # Include code editor fields if this is a code_editor lab
        if lab.lab_format == 'code_editor'
          base.merge!({
            lab_format: lab.lab_format,
            programming_language: lab.programming_language,
            starter_code: lab.starter_code,
            schema_setup: lab.schema_setup,
            sample_data: lab.sample_data,
            test_cases: lab.test_cases,
            hints: lab.hints,
            learning_objectives: lab.learning_objectives
          })
        end
        
        base
      end

      def lab_detail(lab)
        base = {
          id: lab.id,
          title: lab.title,
          description: lab.description,
          difficulty: lab.difficulty,
          estimated_minutes: lab.estimated_minutes,
          lab_type: lab.lab_type,
          category: lab.category,
          certification_exam: lab.certification_exam,
          learning_objectives: lab.learning_objectives,
          prerequisites: lab.prerequisites,
          steps: lab.steps,
          validation_rules: lab.validation_rules,
          success_criteria: lab.success_criteria,
          points_reward: lab.points_reward,
          environment_image: lab.environment_image,
          required_tools: lab.required_tools,
          max_attempts: lab.max_attempts
        }
        
        # Include code editor fields if this is a code_editor lab
        if lab.lab_format == 'code_editor'
          base.merge!({
            lab_format: lab.lab_format,
            programming_language: lab.programming_language,
            starter_code: lab.starter_code,
            schema_setup: lab.schema_setup,
            sample_data: lab.sample_data,
            test_cases: lab.test_cases,
            hints: lab.hints
          })
        end
        
        base
      end

      def load_microlessons_from_yaml(mod)
        microlesson_items = []
        course = mod.course
        
        # Find YAML course directories that might contain microlessons for this module
        yaml_directories = [
          Rails.root.join('db/seeds/networking_complete_enhanced'),
          Rails.root.join('db/seeds/converted_microlessons/networking'),
          Rails.root.join('db/seeds/docker_complete_enhanced')
        ]
        
        yaml_directories.each do |yaml_dir|
          next unless Dir.exist?(yaml_dir)
          
          manifest_path = File.join(yaml_dir, 'manifest.yml')
          next unless File.exist?(manifest_path)
          
          begin
            manifest = YAML.load_file(manifest_path)
            yaml_course_slug = manifest.dig('course', 'slug')
            
            # Match course by slug - networking-fundamentals matches networking-fundamentals
            course_matches = if yaml_course_slug
              course.slug == yaml_course_slug || 
              (course.slug.include?('networking') && yaml_course_slug.include?('networking'))
            else
              false
            end
            
            next unless course_matches
            
            # For networking course, the manifest has one module with all lessons
            # We need to map them to the appropriate database module based on topic
            module_data = manifest['modules']&.find { |m| m['slug'].include?('networking') } || manifest['modules']&.first
            next unless module_data
            
            # Load microlessons from YAML files
            lesson_slugs = module_data['lessons'] || []
            microlessons_dir = File.join(yaml_dir, 'microlessons')
            
            next unless Dir.exist?(microlessons_dir)
            
            # Filter and map microlessons to this specific module based on topic keywords
            filtered_slugs = filter_microlessons_for_module(lesson_slugs, mod.slug, microlessons_dir)
            
            filtered_slugs.each_with_index do |lesson_slug, index|
              lesson_path = File.join(microlessons_dir, "#{lesson_slug}.yml")
              next unless File.exist?(lesson_path)
              
              begin
                lesson_data = YAML.load_file(lesson_path)
                
                # Skip if not published
                next if lesson_data['published'] == false
                
                microlesson_items << {
                  id: "yaml-#{lesson_slug}",
                  type: 'MicroLesson',
                  sequence_order: lesson_data['sequence_order'] || (index + 1),
                  required: true,
                  content: format_yaml_microlesson(lesson_data, lesson_slug)
                }
              rescue => e
                Rails.logger.error "Failed to load microlesson #{lesson_slug}: #{e.message}"
                next
              end
            end
            
            # Break after finding the first matching manifest with microlessons
            break if microlesson_items.any?
          rescue => e
            Rails.logger.error "Failed to load manifest from #{yaml_dir}: #{e.message}"
            Rails.logger.error e.backtrace.first(5).join("\n")
            next
          end
        end
        
        microlesson_items
      end

      def filter_microlessons_for_module(lesson_slugs, module_slug, microlessons_dir)
        # Map modules to topic keywords (networking-specific only)
        module_keywords = {
          'tcp-ip-fundamentals' => ['tcp', 'ip', 'udp', 'osi', 'protocol', 'packet', 'port', 'socket', 'http', 'https', 'tls', 'ssl'],
          'dns-fundamentals' => ['dns', 'domain', 'name', 'resolution', 'dig', 'nslookup', 'record'],
          'routing-traffic-control' => ['routing', 'bgp', 'nat', 'traffic', 'qos', 'route', 'gateway', 'subnet', 'cidr']
        }
        
        # Exclude patterns - lessons that should NOT be included even if they match keywords
        # Use case-insensitive matching without requiring start-of-string to catch all variations
        exclude_patterns = [
          /docker/i,             # Exclude all Docker-related (docker-build, docker-compose, docker-network, codesprout-exposing-containers, etc.)
          /chemistry/i,          # Exclude chemistry lessons
          /electrolysis/i,       # Exclude chemistry lessons
          /group-\d+/i,          # Exclude chemistry group lessons
          /qualitative-analysis/i, # Exclude chemistry lessons
          /crystal-defects/i,    # Exclude chemistry lessons
          /pointers-in-go/i,     # Exclude Go programming lessons
          /building-http-servers/i, # Exclude Go programming lessons (this is about Go net/http, not networking)
          /goroutines/i,         # Exclude Go programming lessons
          /channels/i,           # Exclude Go programming lessons (Go channels, not networking channels)
          /json-requestresponse/i, # Exclude Go programming lessons
          /middleware-and-logging/i, # Exclude Go programming lessons
          /rest-api-design/i,    # Exclude API design lessons
          /database-integration/i, # Exclude database lessons
          /infrastructure-as-code/i, # Exclude infrastructure lessons
          /terraform/i,          # Exclude terraform lessons
          /python-setup/i,       # Exclude Python lessons
          /bash.*shell/i,        # Exclude shell scripting lessons
          /regular-expressions/i, # Exclude regex lessons
          /quantifiers/i,        # Exclude regex quantifiers
          /fan-outfan-in/i,      # Exclude pipeline lessons
          /concurrency/i,        # Exclude concurrency lessons
          /security-principles/i, # Exclude general security lessons
          /configuration-management/i, # Exclude config management
          /managing-secrets/i,   # Exclude secrets management
          /ssh-keys/i,           # Exclude SSH lessons (SSH is networking but not fundamentals)
          /introduction-to-cryptography/i, # Exclude general cryptography (TLS/SSL is networking, general crypto is not)
          /biodiversity/i,       # Exclude biology lessons
          /air-pollution/i,      # Exclude environment lessons
          /ozonedepletion/i,     # Exclude environment lessons
          /physical-features/i,  # Exclude geography lessons
          /information-technology/i, # Exclude IT lessons
          /anomalousbehavior/i,  # Exclude chemistry lessons
          /close-packing/i,      # Exclude chemistry lessons
          /liquid-state/i,       # Exclude chemistry lessons
          /conductance-kohlrausch/i, # Exclude chemistry lessons
          /emulsions/i,          # Exclude chemistry lessons
          /micelles/i,           # Exclude chemistry lessons
          /adsorption/i,         # Exclude chemistry lessons
          /basic-laboratory/i,   # Exclude chemistry lessons
          /cation.*anion/i,      # Exclude chemistry lessons
          /which-reagent/i,      # Exclude chemistry lessons
          /practice-question/i,  # Exclude generic practice
          /^lesson-\d+$/i,       # Exclude generic numbered lessons
          /codesprout/i          # Exclude codesprout container lessons
        ]
        
        # Get keywords for this module
        keywords = module_keywords[module_slug] || []
        
        # If no specific keywords for module, use general networking keywords
        if keywords.empty?
          keywords = ['network', 'tcp', 'dns', 'routing', 'bgp', 'ip', 'subnet', 'nat', 'protocol', 'packet', 'http', 'https', 'tls', 'ssl']
        end
        
        # Filter lessons: must match keywords AND not match exclude patterns
        filtered = lesson_slugs.select do |slug|
          # Skip if matches any exclude pattern
          if exclude_patterns.any? { |pattern| slug.match?(pattern) }
            Rails.logger.debug "Excluding lesson: #{slug} (matches exclude pattern)"
            next false
          end
          
          # Must match at least one keyword (in slug or content)
          matches_keyword = keywords.any? { |keyword| slug.downcase.include?(keyword.downcase) } ||
                           microlesson_matches_module?(slug, keywords, microlessons_dir)
          
          unless matches_keyword
            Rails.logger.debug "Excluding lesson: #{slug} (does not match networking keywords)"
          end
          
          matches_keyword
        end
        
        Rails.logger.info "Filtered #{filtered.length} networking lessons from #{lesson_slugs.length} total lessons for module: #{module_slug}"
        filtered
      end

      def microlesson_matches_module?(lesson_slug, keywords, microlessons_dir)
        lesson_path = File.join(microlessons_dir, "#{lesson_slug}.yml")
        return false unless File.exist?(lesson_path)
        
        begin
          lesson_data = YAML.load_file(lesson_path)
          content = (lesson_data['content_md'] || lesson_data['content'] || '').downcase
          title = (lesson_data['title'] || '').downcase
          key_concepts = (lesson_data['key_concepts'] || []).join(' ').downcase
          
          full_text = "#{title} #{content} #{key_concepts}"
          keywords.any? { |keyword| full_text.include?(keyword.downcase) }
        rescue
          false
        end
      end

      def format_yaml_microlesson(lesson_data, slug)
        {
          id: "yaml-#{slug}",
          title: lesson_data['title'] || slug.humanize,
          slug: slug,
          content: lesson_data['content_md'] || lesson_data['content'] || '',
          estimated_minutes: lesson_data['estimated_minutes'] || 2,
          difficulty: lesson_data['difficulty'] || 'medium',
          key_concepts: lesson_data['key_concepts'] || [],
          objectives: lesson_data['objectives'] || [],
          exercises: (lesson_data['exercises'] || []).map.with_index { |ex, idx| format_yaml_exercise(ex, idx) },
          published: lesson_data.fetch('published', true)
        }
      end

      def format_yaml_exercise(ex_data, index)
        {
          id: "yaml-ex-#{index}",
          exercise_type: map_exercise_type(ex_data['type']),
          sequence_order: ex_data['sequence_order'] || index + 1,
          exercise_data: build_exercise_data_from_yaml(ex_data)
        }
      end

      def map_exercise_type(yaml_type)
        case yaml_type
        when 'terminal', 'mcq', 'code', 'short_answer', 'sandbox'
          yaml_type
        when 'coding'
          'code'
        when 'reflection', 'checkpoint', 'sql'
          'short_answer'
        else
          'short_answer'
        end
      end

      def build_exercise_data_from_yaml(ex_data)
        base_data = {
          'description' => ex_data['description'],
          'hints' => ex_data['hints'] || [],
          'require_pass' => ex_data['require_pass'] || false,
          'difficulty' => ex_data['difficulty'] || 'medium'
        }

        case ex_data['type']
        when 'terminal'
          base_data.merge(
            'command' => ex_data['command'],
            'timeout_sec' => ex_data['timeout_sec'] || 60,
            'validation' => ex_data['validation'] || {}
          )
        when 'mcq'
          base_data.merge(
            'question' => ex_data['question'],
            'options' => ex_data['options'] || [],
            'correct_answer' => ex_data['options']&.[](ex_data['correct_answer_index'] || 0),
            'correct_answer_index' => ex_data['correct_answer_index'] || 0,
            'explanation' => ex_data['explanation']
          )
        when 'short_answer'
          base_data.merge(
            'question' => ex_data['question'],
            'expected_answer' => ex_data['expected_answer'],
            'validation_type' => ex_data['validation_type'] || 'flexible'
          )
        when 'reflection', 'checkpoint'
          base_data.merge(
            'prompt' => ex_data['prompt'],
            'slug' => ex_data['slug']
          )
        when 'coding', 'code'
          base_data.merge(
            'question' => ex_data['question'],
            'language' => ex_data['language'] || 'python',
            'starter_code' => ex_data['starter_code'],
            'solution_code' => ex_data['solution_code'],
            'test_cases' => ex_data['test_cases'] || []
          )
        when 'sql'
          base_data.merge(
            'question' => ex_data['question'],
            'schema' => ex_data['schema'],
            'expected_result' => ex_data['expected_result']
          )
        else
          base_data
        end
      end

      # DEPRECATED: Do NOT use this method for fetching courses!
      # This method queries the database for courses, but courses should ONLY be
      # fetched from YAML files using CourseFileReaderService.
      #
      # Use CourseFileReaderService.all_courses instead and filter in Ruby:
      #   CourseFileReaderService.all_courses.select { |c| c[:slug].include?(pattern) }
      #
      # This method is kept temporarily for backwards compatibility but will be removed.
      def get_courses_by_pattern(pattern)
        raise "DEPRECATED: Use CourseFileReaderService instead of querying the database for courses. " \
              "Courses are stored in YAML files, not in the database."
      end

      def get_labs_by_type(lab_type)
        labs = HandsOnLab.where(lab_type: lab_type, is_active: true)
        labs = labs.where(difficulty: params[:difficulty]) if params[:difficulty].present?
        labs = labs.where(category: params[:category]) if params[:category].present?
        labs
      end
    end
  end
end
