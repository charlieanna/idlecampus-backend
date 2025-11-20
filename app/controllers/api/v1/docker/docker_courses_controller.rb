# frozen_string_literal: true

module Api
  module V1
    module Docker
      # Guest user struct for unauthenticated API calls
      GuestUser = Struct.new(:id)

      class DockerCoursesController < ApplicationController
        # Disable auth and CSRF for public API access
        skip_before_action :verify_authenticity_token
        skip_before_action :authenticate_user!, raise: false if respond_to?(:skip_before_action)
        protect_from_forgery with: :null_session

        before_action :set_default_format
        before_action :set_cors_headers
        before_action :cors_preflight, if: -> { request.method == 'OPTIONS' }

        # GET /api/v1/docker/courses
        def index
          courses = load_docker_courses_from_yaml
          
          render json: {
            courses: courses.map { |course| course_summary_from_yaml(course) }
          }
        end

        # GET /api/v1/docker/courses/:slug
        def show
          courses = load_docker_courses_from_yaml
          course = courses.find { |c| c[:slug] == params[:id] }
          
          if course.nil?
            render json: { error: 'Course not found' }, status: :not_found
            return
          end

          render json: {
            course: course_detail_from_yaml(course)
          }
        end

        # GET /api/v1/docker/courses/:course_slug/modules
        def modules
          courses = load_docker_courses_from_yaml
          course = courses.find { |c| c[:slug] == params[:course_id] }
          
          if course.nil?
            render json: { error: 'Course not found' }, status: :not_found
            return
          end

          render json: {
            modules: course[:modules] || []
          }
        end

        # GET /api/v1/docker/courses/:course_slug/modules/:module_slug
        def module_show
          course = Course.find_by!(slug: params[:course_id])
          module_slug = params[:id]

          # Get Docker learning content
          session_data = get_docker_learning_content
          docker_modules = session_data.dig('data', 'modules') || []

          # Find the specific module
          docker_module = docker_modules.find { |m| m['id'] == module_slug }

          if docker_module
            index = docker_modules.index(docker_module)

            transformed_module = {
              id: index + 1,
              slug: docker_module['id'].to_s,
              title: docker_module['title'],
              description: docker_module['description'] || "Docker learning module",
              sequence_order: index + 1,
              estimated_minutes: 30,
              lessons: (docker_module['lessons'] || []).map.with_index do |lesson, lesson_index|
                {
                  id: lesson_index + 1,
                  title: lesson['title'],
                  content: lesson['content'] || '',
                  contentType: lesson['contentType'] || 'lesson',
                  sequence_order: lesson_index + 1,
                  estimated_minutes: lesson['estimated_minutes'] || 15,
                  learning_objectives: [],
                  description: lesson['description'],
                  difficulty: lesson['difficulty'],
                  steps: lesson['steps'],
                  key_commands: (lesson['commands'] || []).map { |cmd|
                    "#{cmd['command']} - #{cmd['description']} - #{cmd['example']}"
                  }
                }
              end
            }

            render json: { module: transformed_module }
          else
            render json: { error: 'Module not found' }, status: :not_found
          end
        end

        # GET /api/v1/docker/courses/:course_slug/modules/:module_slug/progressive
        # Returns module as a single progressive lesson with interleaved content and commands
        def progressive
          module_slug = params[:id]

          # Try DB-backed module first
          course = Course.find_by(slug: params[:course_id])
          if course
            course_module = course.course_modules.find_by(slug: module_slug)

            if course_module
              session_module = build_session_module_data(course_module)

              if session_module && session_module['lessons']&.any?
                builder = ProgressiveModuleBuilder.new(course_module, session_module)
                render json: { module: builder.module_metadata.merge({ items: builder.build_items }) }
                return
              end
            end
          end

          # Fallback: use session API content when DB records are missing
          require 'ostruct'
          session_data = get_docker_learning_content
          docker_modules = session_data.dig('data', 'modules') || []
          docker_module = docker_modules.find do |m|
            m['id'].to_s == module_slug.to_s || m['slug'].to_s == module_slug.to_s
          end

          if docker_module
            # Build a lightweight course_module-like object for metadata
            dummy_module = OpenStruct.new(
              id: 0,
              slug: docker_module['id'].to_s,
              title: docker_module['title'] || module_slug.humanize,
              description: docker_module['description'] || 'Docker learning module',
              sequence_order: 1
            )

            builder = ProgressiveModuleBuilder.new(dummy_module, docker_module)
            render json: { module: builder.module_metadata.merge({ items: builder.build_items }) }
          else
            # Second-chance fallback: build module data directly from DB by well-known slug mappings
            direct_module_data = build_session_module_data_by_slug(module_slug)
            if direct_module_data && direct_module_data['lessons']&.any?
              dummy_module = OpenStruct.new(
                id: 0,
                slug: module_slug,
                title: direct_module_data['title'] || module_slug.humanize,
                description: direct_module_data['description'] || 'Docker learning module',
                sequence_order: 1
              )

              builder = ProgressiveModuleBuilder.new(dummy_module, direct_module_data)
              render json: { module: builder.module_metadata.merge({ items: builder.build_items }) }
            else
              render json: { error: 'Module not found' }, status: :not_found
            end
          end
        end

        # GET /api/v1/docker/commands
        def commands
          category = params[:category]
          difficulty = params[:difficulty]

          cmds = DockerCommand.all
          cmds = cmds.where(category: category) if category.present?
          cmds = cmds.where(difficulty: difficulty) if difficulty.present?
          cmds = cmds.order(exam_frequency: :desc).order(:command)

          render json: {
            commands: cmds.map { |cmd| command_detail(cmd) }
          }
        end

        # GET /api/v1/docker/labs
        def labs
          # FIXED: Include both docker and docker-compose labs
          labs = HandsOnLab.docker_related_labs.active.order(:id)

          render json: {
            labs: labs.map { |lab| lab_summary(lab) }
          }
        end

        # GET /api/v1/docker/labs/:id
        def lab_show
          lab = HandsOnLab.find(params[:id])

          render json: {
            lab: lab_detail(lab)
          }
        end

        # POST /api/v1/docker/execute
        # Execute Docker command and return real output
        def execute_command
          command = params[:command]

          # Execute using existing DockerExecutionService
          # Use current_user if authenticated, otherwise create a guest user
          user = current_user || GuestUser.new('guest')
          executor = DockerExecutionService.new(user)
          result = executor.execute(command)

          render json: {
            success: result[:success],
            output: result[:output] || result[:error],
            error: result[:error]
          }
        end

        # Respond to OPTIONS preflight requests
        def cors_preflight
          headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
          headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS'
          headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization'
          headers['Access-Control-Max-Age'] = '1728000'
          headers['Vary'] = 'Origin'
          head :ok
        end

        private

        # Build module data with lessons from database (for progressive endpoint)
        def build_session_module_data(course_module)
          # Get lessons associated with this module
          lessons = get_module_lessons(course_module)

          {
            'id' => course_module.id.to_s,
            'title' => course_module.title,
            'description' => course_module.description,
            'lessons' => lessons.map { |lesson| lesson_to_hash(lesson) }
          }
        end

        # Build session-like module data using known slug mappings when DB/session lookup fails
        def build_session_module_data_by_slug(module_slug)
          lessons = []

          case module_slug
          when 'container-lifecycle', 'container-basics'
            # Load from YAML files instead of database
            lessons = load_lessons_from_yaml
          else
            return nil
          end

          return nil if lessons.blank?

          {
            'id' => module_slug,
            'title' => module_slug.humanize,
            'description' => 'Docker learning module',
            'lessons' => lessons
          }
        end

        def get_module_lessons(course_module)
          # Get lessons for this module from YAML files
          if course_module.slug == 'container-basics' || course_module.slug == 'container-lifecycle'
            load_lessons_from_yaml
          else
            []
          end
        end

        def load_lessons_from_yaml
          # Load from networking microlessons YAML files
          yaml_dir = Rails.root.join('db/seeds/converted_microlessons/networking')
          manifest_path = yaml_dir.join('manifest.yml')

          return [] unless File.exist?(manifest_path)

          manifest = YAML.load_file(manifest_path)
          lesson_slugs = manifest.dig('modules', 0, 'lessons') || []

          # Load each microlesson YAML file
          lessons = lesson_slugs.map do |slug|
            microlesson_path = yaml_dir.join('microlessons', "#{slug}.yml")
            next unless File.exist?(microlesson_path)

            microlesson = YAML.load_file(microlesson_path)
            yaml_lesson_to_hash(microlesson)
          end.compact

          # Sort by sequence_order
          lessons.sort_by { |l| l['sequence_order'] || 999 }
        end

        def yaml_lesson_to_hash(microlesson)
          {
            'id' => microlesson['slug'],
            'title' => microlesson['title'],
            'content' => microlesson['content_md'] || '',
            'contentType' => 'lesson',
            'description' => microlesson['content_md']&.lines&.first&.strip || '',
            'difficulty' => microlesson['difficulty'],
            'estimated_minutes' => microlesson['estimated_minutes'] || 5,
            'sequence_order' => microlesson['sequence_order'],
            'commands' => microlesson.dig('exercises', 0, 'command') ? [{
              'command' => microlesson.dig('exercises', 0, 'command'),
              'description' => microlesson['title'],
              'example' => microlesson.dig('exercises', 0, 'command')
            }] : []
          }
        end

        def lesson_to_hash(lesson)
          {
            'id' => lesson.id,
            'title' => lesson.title,
            'content' => lesson.concept_explanation || '',
            'contentType' => 'lesson',
            'description' => lesson.scenario_description,
            'difficulty' => lesson.difficulty_level,
            'estimated_minutes' => lesson.estimated_minutes || 5,
            'commands' => [{
              'command' => lesson.command_to_learn,
              'description' => lesson.title,
              'example' => lesson.command_to_learn
            }]
          }
        end

        def set_default_format
          request.format = :json
        end

        def set_cors_headers
          headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
          headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS'
          headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization'
          headers['Vary'] = 'Origin'
        end

        def get_docker_learning_content
          # Fetch data from the existing learning session API
          # This is a simple HTTP call to the existing endpoint
          require 'net/http'
          require 'json'

          uri = URI("http://localhost:3000/api/v1/learning/session?track=docker")
          response = Net::HTTP.get(uri)
          parsed = JSON.parse(response)

          Rails.logger.info "Docker learning content fetched: #{parsed.dig('data', 'modules')&.length || 0} modules"

          parsed
        rescue => e
          Rails.logger.error "Failed to fetch Docker learning content: #{e.message}"
          Rails.logger.error e.backtrace.join("\n")
          { 'data' => { 'modules' => [] } }
        end

        def load_docker_courses_from_yaml
          # Load from the main data.yml file or specific Docker course YAML files
          yaml_files = [
            Rails.root.join('db/data.yml'),
            Rails.root.join('db/seeds/converted_microlessons/docker-fundamentals/manifest.yml'),
            Rails.root.join('db/seeds/converted_microlessons/docker-containers-bootcamp/manifest.yml')
          ]
          
          courses = []
          
          yaml_files.each do |yaml_file|
            next unless File.exist?(yaml_file)
            
            begin
              if yaml_file.basename.to_s == 'data.yml'
                # Handle the large data.yml file - look for Docker courses
                yaml_content = YAML.load_file(yaml_file)
                docker_courses = extract_docker_courses_from_data_yml(yaml_content)
                courses.concat(docker_courses)
              else
                # Handle manifest.yml files
                yaml_content = YAML.load_file(yaml_file)
                if yaml_content['course']
                  course_data = yaml_content['course']
                  if course_data['certification_track']&.include?('docker') || course_data['slug']&.include?('docker')
                    courses << build_course_from_manifest(yaml_content)
                  end
                end
              end
            rescue => e
              Rails.logger.error "Failed to load YAML file #{yaml_file}: #{e.message}"
            end
          end
          
          # If no courses found in YAML, return default Docker courses
          if courses.empty?
            courses = default_docker_courses
          end
          
          courses
        end
        
        def extract_docker_courses_from_data_yml(yaml_content)
          # This would extract Docker courses from the large data.yml file
          # For now, return empty as we need to implement YAML parsing logic
          []
        end
        
        def build_course_from_manifest(manifest_content)
          course_data = manifest_content['course']
          modules_data = manifest_content['modules'] || []
          
          {
            id: course_data['id'] || 1,
            slug: course_data['slug'],
            title: course_data['title'],
            description: course_data['description'],
            difficulty_level: course_data['level'] || 'intermediate',
            estimated_hours: course_data['estimated_hours'] || 8,
            certification_track: course_data['certification_track'] || 'docker',
            module_count: modules_data.length,
            modules: modules_data.map.with_index do |mod, index|
              {
                id: index + 1,
                slug: mod['slug'],
                title: mod['title'],
                description: mod['description'],
                sequence_order: index + 1,
                estimated_minutes: mod['estimated_minutes'] || 30,
                lesson_count: (mod['lessons'] || []).length,
                lessons: []
              }
            end
          }
        end
        
        def default_docker_courses
          [
            {
              id: 1,
              slug: 'docker-fundamentals',
              title: 'Docker Fundamentals',
              description: 'Learn the basics of Docker containerization',
              difficulty_level: 'beginner',
              estimated_hours: 6,
              certification_track: 'docker',
              module_count: 3,
              modules: [
                {
                  id: 1,
                  slug: 'getting-started',
                  title: 'Getting Started with Docker',
                  description: 'Introduction to Docker concepts',
                  sequence_order: 1,
                  estimated_minutes: 45,
                  lesson_count: 3,
                  lessons: []
                },
                {
                  id: 2,
                  slug: 'working-with-containers',
                  title: 'Working with Containers',
                  description: 'Container lifecycle and management',
                  sequence_order: 2,
                  estimated_minutes: 60,
                  lesson_count: 4,
                  lessons: []
                },
                {
                  id: 3,
                  slug: 'docker-compose',
                  title: 'Docker Compose',
                  description: 'Multi-container applications',
                  sequence_order: 3,
                  estimated_minutes: 45,
                  lesson_count: 3,
                  lessons: []
                }
              ]
            },
            {
              id: 2,
              slug: 'docker-containers-bootcamp',
              title: 'Docker Containers Professional Bootcamp',
              description: '7-week intensive Docker training program covering all Docker concepts',
              difficulty_level: 'intermediate',
              estimated_hours: 40,
              certification_track: 'dca',
              module_count: 7,
              modules: [
                {
                  id: 1,
                  slug: 'container-basics',
                  title: 'Container Basics',
                  description: 'Fundamental container concepts and lifecycle',
                  sequence_order: 1,
                  estimated_minutes: 90,
                  lesson_count: 6,
                  lessons: []
                },
                {
                  id: 2,
                  slug: 'docker-images',
                  title: 'Docker Images',
                  description: 'Image creation, management, and optimization',
                  sequence_order: 2,
                  estimated_minutes: 120,
                  lesson_count: 8,
                  lessons: []
                },
                {
                  id: 3,
                  slug: 'dockerfile-mastery',
                  title: 'Dockerfile Mastery',
                  description: 'Advanced Dockerfile techniques and best practices',
                  sequence_order: 3,
                  estimated_minutes: 100,
                  lesson_count: 7,
                  lessons: []
                },
                {
                  id: 4,
                  slug: 'networking',
                  title: 'Docker Networking',
                  description: 'Container networking, bridges, and custom networks',
                  sequence_order: 4,
                  estimated_minutes: 110,
                  lesson_count: 6,
                  lessons: []
                },
                {
                  id: 5,
                  slug: 'volumes-storage',
                  title: 'Volumes & Storage',
                  description: 'Data persistence and storage management',
                  sequence_order: 5,
                  estimated_minutes: 95,
                  lesson_count: 5,
                  lessons: []
                },
                {
                  id: 6,
                  slug: 'docker-compose',
                  title: 'Docker Compose',
                  description: 'Multi-container applications and orchestration',
                  sequence_order: 6,
                  estimated_minutes: 120,
                  lesson_count: 8,
                  lessons: []
                },
                {
                  id: 7,
                  slug: 'production-deployment',
                  title: 'Production Deployment',
                  description: 'Security, monitoring, and production best practices',
                  sequence_order: 7,
                  estimated_minutes: 130,
                  lesson_count: 9,
                  lessons: []
                }
              ]
            }
          ]
        end

        def course_summary_from_yaml(course)
          {
            id: course[:id],
            slug: course[:slug],
            title: course[:title],
            description: course[:description],
            difficulty_level: course[:difficulty_level],
            estimated_hours: course[:estimated_hours],
            certification_track: course[:certification_track],
            module_count: course[:module_count]
          }
        end

        def course_detail_from_yaml(course)
          {
            id: course[:id],
            slug: course[:slug],
            title: course[:title],
            description: course[:description],
            difficulty_level: course[:difficulty_level],
            estimated_hours: course[:estimated_hours],
            certification_track: course[:certification_track],
            learning_objectives: [],
            prerequisites: [],
            modules: course[:modules] || []
          }
        end

        def lab_summary(lab)
          {
            id: lab.id,
            title: lab.title,
            difficulty: lab.difficulty,
            estimated_minutes: lab.estimated_minutes,
            sequence_order: lab.respond_to?(:sequence_order) ? lab.sequence_order : 0
          }
        end

        def lab_detail(lab)
          {
            id: lab.id,
            title: lab.title,
            description: lab.description,
            difficulty: lab.difficulty,
            estimated_minutes: lab.estimated_minutes,
            objectives: lab.learning_objectives || [],
            prerequisites: lab.prerequisites || [],
            steps: lab.steps || [],
            validation_commands: extract_validation_commands(lab),
            hints: extract_hints(lab),
            solution: lab.steps&.map { |s| s['expected_command'] }&.join("\n") || nil,
            sequence_order: lab.respond_to?(:sequence_order) ? lab.sequence_order : 0
          }
        end

        def extract_validation_commands(lab)
          return [] unless lab.steps.is_a?(Array)
          lab.steps.map { |step| step['validation'] || step['expected_command'] }.compact
        end

        def extract_hints(lab)
          return [] unless lab.steps.is_a?(Array)
          lab.steps.map { |step| step['instruction'] }.compact
        end

        def question_summary(question)
          base = {
            id: question.id,
            type: question.question_type,
            question: question.question_text,
            points: question.points || 1,
            difficulty: question.difficulty_level || 'medium',
            explanation: question.explanation
          }

          case question.question_type
          when 'mcq', 'multiple_choice'
            # Parse options from JSON if needed
            options = if question.options.is_a?(String)
              begin
                JSON.parse(question.options)
              rescue JSON::ParserError
                []
              end
            else
              question.options || []
            end

            base.merge({
              options: options.is_a?(Array) ? options.map { |opt| opt.is_a?(Hash) ? opt['text'] || opt : opt.to_s } : [],
              correct_answer: question.correct_answer
            })
          when 'command', 'fill_blank'
            base.merge({
              expectedCommand: question.correct_answer
            })
          when 'true_false'
            base.merge({
              correct_answer: question.correct_answer
            })
          else
            base
          end
        end

        def command_detail(cmd)
          {
            id: cmd.id,
            command: cmd.command,
            explanation: cmd.explanation,
            difficulty: cmd.difficulty,
            category: cmd.category,
            flags: cmd.flags || {},
            variations: cmd.variations || [],
            use_cases: cmd.use_cases,
            gotchas: cmd.gotchas,
            exam_frequency: cmd.exam_frequency
          }
        end
      end
    end
  end
end
