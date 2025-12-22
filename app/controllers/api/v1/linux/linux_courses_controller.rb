# frozen_string_literal: true

module Api
  module V1
    module Linux
      class LinuxCoursesController < ApplicationController
        # Disable auth and CSRF for public API access
        skip_before_action :verify_authenticity_token
        skip_before_action :authenticate_user!, raise: false if respond_to?(:skip_before_action)
        protect_from_forgery with: :null_session

        before_action :set_default_format
        before_action :set_cors_headers
        before_action :cors_preflight, if: -> { request.method == 'OPTIONS' }

        # GET /api/v1/linux/courses
        def index
          # Load courses from YAML files
          all_courses = CourseFileReaderService.all_courses
          linux_courses = all_courses.select { |c| c[:slug].include?('linux') }

          render json: {
            courses: linux_courses.map { |course| course_summary_from_yaml(course) }
          }
        end

        # GET /api/v1/linux/courses/:slug
        def show
          # Load from YAML
          course = CourseFileReaderService.find_course(params[:id])

          if course
            render json: {
              course: course_detail_from_yaml(course)
            }
          else
            render json: { error: 'Course not found' }, status: :not_found
          end
        end

        # GET /api/v1/linux/courses/:course_slug/modules
        def modules
          # Load from YAML
          course = CourseFileReaderService.course_with_modules(params[:course_id])

          if course
            render json: {
              modules: course[:modules]
            }
          else
            render json: { error: 'Course not found' }, status: :not_found
          end
        end

        # GET /api/v1/linux/courses/:course_slug/modules/:module_slug
        def module_show
          # Load from YAML (consistent with other endpoints)
          course = CourseFileReaderService.course_with_modules(params[:course_id])

          if course.nil?
            render json: { error: 'Course not found' }, status: :not_found
            return
          end

          course_module = course[:modules].find { |m| m[:slug] == params[:id] }

          if course_module.nil?
            render json: { error: 'Module not found' }, status: :not_found
            return
          end

          render json: {
            module: module_detail_from_yaml(course_module)
          }
        end

        # GET /api/v1/linux/labs
        def labs
          labs = HandsOnLab.all.order(:id)

          render json: {
            labs: labs.map { |lab| lab_summary(lab) }
          }
        end

        # GET /api/v1/linux/labs/:id
        def lab_show
          lab = HandsOnLab.find(params[:id])

          render json: {
            lab: lab_detail(lab)
          }
        end

        private

        def lab_summary(lab)
          {
            id: lab.id,
            title: lab.title,
            description: lab.description,
            difficulty: lab.difficulty,
            estimated_minutes: lab.estimated_minutes
          }
        end

        def lab_detail(lab)
          lab_summary(lab).merge({
            objectives: parse_json_or_array(lab.learning_objectives),
            prerequisites: parse_json_or_array(lab.prerequisites),
            steps: parse_json_or_array(lab.steps),
            solution: lab.solution_code
          })
        end


        def course_summary(course)
          {
            id: course.id,
            slug: course.slug,
            title: course.title,
            description: course.description,
            difficulty_level: course.difficulty_level,
            estimated_hours: (course.estimated_duration.to_f / 60.0).round(1),
            certification_track: course.certification_track,
            module_count: course.course_modules.count,
            published: course.published
          }
        end

        def course_summary_from_yaml(course)
          {
            id: course[:slug],
            slug: course[:slug],
            title: course[:title],
            description: course[:description],
            difficulty_level: course[:difficulty_level],
            estimated_hours: course[:estimated_hours],
            certification_track: 'linux',
            module_count: course[:modules_count],
            published: true
          }
        end

        def course_detail_from_yaml(course)
          course_summary_from_yaml(course).merge({
            learning_objectives: course[:learning_objectives] || [],
            prerequisites: course[:prerequisites] || [],
            modules: course[:modules] || []
          })
        end

        def module_detail_from_yaml(course_module)
          {
            id: course_module[:slug],
            slug: course_module[:slug],
            title: course_module[:title],
            description: course_module[:description],
            sequence_order: course_module[:sequence_order],
            estimated_minutes: course_module[:estimated_minutes],
            learning_outcomes: course_module[:learning_outcomes] || [],
            lessons: course_module[:lessons] || [],
            labs: [],
            quizzes: []
          }
        end

        def course_detail(course)
          {
            id: course.id,
            slug: course.slug,
            title: course.title,
            description: course.description,
            difficulty_level: course.difficulty_level,
            estimated_hours: (course.estimated_duration.to_f / 60.0).round(1),
            certification_track: course.certification_track,
            learning_objectives: parse_json_or_array(course.learning_objectives),
            prerequisites: parse_json_or_array(course.prerequisites),
            modules: course.course_modules.ordered.map { |mod| module_summary(mod) }
          }
        end

        def module_summary(course_module)
          {
            id: course_module.id,
            slug: course_module.slug,
            title: course_module.title,
            description: course_module.description,
            sequence_order: course_module.sequence_order,
            estimated_minutes: course_module.estimated_minutes,
            published: course_module.published,
            item_count: course_module.module_items.count,
            lessons: lessons_for_module(course_module),
            labs: labs_for_module(course_module),
            quizzes: quizzes_for_module(course_module)
          }
        end

        def module_detail(course_module)
          module_summary(course_module).merge({
            learning_objectives: parse_json_or_array(course_module.learning_objectives)
          })
        end

        def lessons_for_module(course_module)
          course_module.module_items
                      .where(item_type: 'CourseLesson')
                      .includes(:item)
                      .ordered
                      .map do |module_item|
            lesson = module_item.item

            # Extract Linux commands from markdown code blocks
            key_commands = []
            if lesson.content.present?
              # Find all code blocks (both ```bash and plain ```)
              lesson.content.scan(/```(?:bash)?\n?(.*?)```/m) do |match|
                code_block = match[0]
                # Split into lines and process each
                code_block.each_line do |line|
                  # Skip comment lines and empty lines
                  next if line.strip.start_with?('#') || line.strip.empty?

                  # Check if line starts with a common Linux command
                  if line.strip.match?(/^(?:ls|cd|pwd|cat|grep|find|chmod|chown|mkdir|rm|cp|mv|touch|echo|whoami|date|head|tail|less|man|ps|kill|top|df|du|free|ssh|scp|curl|wget|tar|zip|unzip|apt|yum|systemctl|service|ip|ifconfig|netstat|ping|traceroute|nslookup|dig|awk|sed|sort|uniq|wc|cut|paste|diff|patch|vi|vim|nano|tmux|screen)\b/)
                    command = line.strip

                    # Generate description from command
                    parts = command.split
                    verb = parts[0] || "execute"
                    resource = parts[1] || ""
                    description = resource.present? ? "#{verb.capitalize} #{resource}" : verb.capitalize

                    # Add to key_commands array in format: "command - description - example"
                    key_commands << "#{command} - #{description} - #{command}"
                  end
                end
              end
              key_commands = key_commands.uniq.first(10) # Return up to 10 unique commands
            end

            {
              id: lesson.id,
              title: lesson.title,
              content: lesson.content,
              contentType: 'lesson',
              sequence_order: module_item.sequence_order,
              reading_time_minutes: lesson.reading_time_minutes,
              video_url: lesson.video_url,
              key_concepts: parse_json_or_array(lesson.key_concepts),
              key_commands: key_commands
            }
          end
        end

        def labs_for_module(course_module)
          course_module.module_items
                      .where(item_type: 'HandsOnLab')
                      .includes(:item)
                      .ordered
                      .map do |module_item|
            lab = module_item.item
            {
              id: lab.id,
              title: lab.title,
              description: lab.description,
              contentType: 'lab',
              difficulty: lab.difficulty,
              estimated_minutes: lab.estimated_minutes,
              sequence_order: module_item.sequence_order,
              objectives: parse_json_or_array(lab.learning_objectives),
              prerequisites: parse_json_or_array(lab.prerequisites),
              steps: parse_json_or_array(lab.steps),
              solution: lab.solution_code
            }
          end
        end

        def quizzes_for_module(course_module)
          course_module.module_items
                      .where(item_type: 'Quiz')
                      .includes(item: :quiz_questions)
                      .ordered
                      .map do |module_item|
            quiz = module_item.item
            {
              id: quiz.id,
              title: quiz.title,
              description: quiz.description,
              contentType: 'quiz',
              sequence_order: module_item.sequence_order,
              time_limit_minutes: quiz.time_limit_minutes,
              passing_score: quiz.passing_score,
              questions: quiz.quiz_questions.ordered.map { |q| question_summary(q) }
            }
          end
        end

        def question_summary(question)
          base = {
            id: question.id,
            type: question.question_type,
            question: question.question_text,
            points: question.points,
            difficulty: question.difficulty_level,
            explanation: question.explanation
          }

          case question.question_type
          when 'mcq'
            base.merge({
              options: parse_json_or_array(question.options),
              correct_answer: question.options.is_a?(String) ?
                JSON.parse(question.options).find_index { |opt| opt['correct'] } : nil
            })
          when 'command', 'fill_blank'
            base.merge({
              correct_answer: question.correct_answer
            })
          when 'true_false'
            base.merge({
              correct_answer: question.correct_answer
            })
          else
            base
          end
        end

        def parse_json_or_array(value)
          return [] if value.nil?
          return value if value.is_a?(Array)

          begin
            JSON.parse(value)
          rescue JSON::ParserError
            []
          end
        end

        def set_default_format
          request.format = :json unless params[:format]
        end

        def set_cors_headers
          headers['Access-Control-Allow-Origin'] = '*'
          headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
          headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
        end

        def cors_preflight
          head :ok
        end
      end
    end
  end
end
