module Api
  module V1
    class CodeLabsController < ApplicationController
      before_action :set_lab, only: [:show, :execute, :validate, :submit, :hint, :solution]
      skip_before_action :verify_authenticity_token

      # Allow guests to access code labs (read-only)
      # Require authentication for execution and submissions
      before_action :authenticate_user!, only: [:submit]

      # GET /api/v1/code_labs
      def index
        @labs = HandsOnLab
          .code_editor_labs
          .where(published: true)
          .order(:sequence_order)

        # Filter by programming language if provided
        @labs = @labs.by_programming_language(params[:language]) if params[:language].present?

        # Filter by difficulty if provided
        @labs = @labs.by_difficulty(params[:difficulty]) if params[:difficulty].present?

        render json: {
          success: true,
          labs: @labs.map { |lab| lab_summary(lab) }
        }
      end

      # GET /api/v1/code_labs/:id
      def show
        render json: {
          success: true,
          lab: lab_details(@lab)
        }
      end

      # POST /api/v1/code_labs/:id/execute
      # Run code without validation (for testing)
      def execute
        code = params[:code]
        test_input = params[:test_input]

        if code.blank?
          return render json: {
            success: false,
            error: 'Code is required'
          }, status: :bad_request
        end

        # Validate imports if restrictions exist
        if @lab.allowed_imports_list.any?
          service = CodeExecutionService.new(@lab, current_user)
          import_validation = service.send(:validate_imports, code)

          unless import_validation[:valid]
            return render json: {
              success: false,
              error: "Forbidden imports detected: #{import_validation[:forbidden_imports].join(', ')}",
              forbidden_imports: import_validation[:forbidden_imports]
            }, status: :unprocessable_entity
          end
        end

        begin
          service = CodeExecutionService.new(@lab, current_user)
          result = service.execute(code, test_input)

          # Track execution attempt if user is logged in
          track_code_execution(code, result[:success]) if current_user

          render json: {
            success: result[:success],
            output: result[:output],
            error: result[:error],
            execution_time: result[:execution_time],
            memory_used: result[:memory_used],
            timeout: result[:timeout] || false
          }
        rescue CodeExecutionService::UnsupportedLanguageError => e
          render json: {
            success: false,
            error: e.message
          }, status: :unprocessable_entity
        rescue => e
          Rails.logger.error("Code execution error: #{e.message}\n#{e.backtrace.join("\n")}")
          render json: {
            success: false,
            error: 'An error occurred while executing your code'
          }, status: :internal_server_error
        end
      end

      # POST /api/v1/code_labs/:id/validate
      # Validate code against all test cases
      def validate
        code = params[:code]

        if code.blank?
          return render json: {
            success: false,
            error: 'Code is required'
          }, status: :bad_request
        end

        begin
          service = CodeExecutionService.new(@lab, current_user)
          validation_result = service.validate_against_tests(code)

          # Track validation attempt if user is logged in
          if current_user
            track_code_attempt(code, validation_result[:all_passed])
          end

          # Don't show hidden test case details (input/expected output)
          sanitized_results = sanitize_test_results(validation_result[:results])

          render json: {
            success: true,
            validation: {
              total_tests: validation_result[:total_tests],
              passed_tests: validation_result[:passed_tests],
              failed_tests: validation_result[:failed_tests],
              results: sanitized_results,
              all_passed: validation_result[:all_passed],
              pass_percentage: validation_result[:pass_percentage]
            }
          }
        rescue => e
          Rails.logger.error("Code validation error: #{e.message}\n#{e.backtrace.join("\n")}")
          render json: {
            success: false,
            error: 'An error occurred while validating your code'
          }, status: :internal_server_error
        end
      end

      # POST /api/v1/code_labs/:id/submit
      # Final submission (updates progress, requires authentication)
      def submit
        code = params[:code]

        if code.blank?
          return render json: {
            success: false,
            error: 'Code is required'
          }, status: :bad_request
        end

        begin
          service = CodeExecutionService.new(@lab, current_user)
          validation_result = service.validate_against_tests(code)

          if validation_result[:all_passed]
            # Update lab completion and progress
            update_lab_completion(code, validation_result)

            # Sanitize results
            sanitized_results = sanitize_test_results(validation_result[:results])

            render json: {
              success: true,
              message: 'Congratulations! All tests passed.',
              validation: {
                total_tests: validation_result[:total_tests],
                passed_tests: validation_result[:passed_tests],
                failed_tests: validation_result[:failed_tests],
                results: sanitized_results,
                all_passed: true,
                pass_percentage: 100.0
              },
              points_earned: @lab.points_reward,
              lab_completed: true
            }
          else
            # Track failed submission
            track_code_attempt(code, false)

            sanitized_results = sanitize_test_results(validation_result[:results])

            render json: {
              success: false,
              message: "#{validation_result[:failed_tests]} test(s) failed. Please review and try again.",
              validation: {
                total_tests: validation_result[:total_tests],
                passed_tests: validation_result[:passed_tests],
                failed_tests: validation_result[:failed_tests],
                results: sanitized_results,
                all_passed: false,
                pass_percentage: validation_result[:pass_percentage]
              },
              lab_completed: false
            }
          end
        rescue => e
          Rails.logger.error("Code submission error: #{e.message}\n#{e.backtrace.join("\n")}")
          render json: {
            success: false,
            error: 'An error occurred while submitting your code'
          }, status: :internal_server_error
        end
      end

      # GET /api/v1/code_labs/:id/hint
      def hint
        attempt_count = get_attempt_count(@lab)

        # Progressive hints based on attempt count
        hints = @lab.steps.map { |s| s['hint'] }.compact

        if hints.empty?
          return render json: {
            success: false,
            error: 'No hints available for this lab'
          }
        end

        hint_index = [attempt_count - 1, hints.length - 1].min.clamp(0, hints.length - 1)

        render json: {
          success: true,
          hint: hints[hint_index],
          attempt_count: attempt_count,
          total_hints: hints.length
        }
      end

      # GET /api/v1/code_labs/:id/solution
      # Only available after multiple failed attempts
      def solution
        attempt_count = get_attempt_count(@lab)

        # Require at least 3 attempts before showing solution
        if attempt_count < 3
          return render json: {
            success: false,
            error: 'Solution is available after 3 attempts',
            attempts_remaining: 3 - attempt_count
          }, status: :forbidden
        end

        render json: {
          success: true,
          solution: @lab.solution_code,
          message: 'Study this solution carefully and try to understand the approach.'
        }
      end

      private

      def set_lab
        @lab = HandsOnLab.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: {
          success: false,
          error: 'Lab not found'
        }, status: :not_found
      end

      def lab_summary(lab)
        {
          id: lab.id,
          title: lab.title,
          description: lab.description,
          difficulty: lab.difficulty,
          programming_language: lab.programming_language,
          estimated_minutes: lab.estimated_minutes,
          points_reward: lab.points_reward,
          test_case_count: lab.test_case_count,
          sequence_order: lab.sequence_order,
          times_completed: lab.times_completed,
          average_success_rate: lab.average_success_rate
        }
      end

      def lab_details(lab)
        {
          id: lab.id,
          title: lab.title,
          description: lab.description,
          difficulty: lab.difficulty,
          programming_language: lab.programming_language,
          lab_format: lab.lab_format,
          estimated_minutes: lab.estimated_minutes,
          starter_code: lab.starter_code,
          test_cases: lab.public_test_cases,  # Only show public test cases
          file_structure: lab.file_structure,
          allowed_imports: lab.allowed_imports_list,
          objectives: lab.steps.map { |s| s['instruction'] }.compact,
          points_reward: lab.points_reward,
          max_attempts: lab.max_attempts,
          time_limit_seconds: lab.time_limit_seconds,
          memory_limit_mb: lab.memory_limit_mb,
          has_solution: lab.solution_code.present?,
          has_hints: lab.steps.any? { |s| s['hint'].present? }
        }
      end

      def sanitize_test_results(results)
        results.map do |result|
          test_case = @lab.all_test_cases[result[:test_number] - 1]
          is_hidden = test_case && test_case['hidden']

          if is_hidden && !result[:passed]
            # For hidden tests that failed, don't show expected output or input
            {
              test_number: result[:test_number],
              description: result[:description],
              passed: result[:passed],
              execution_time: result[:execution_time],
              error: result[:error],
              hidden: true,
              message: 'This is a hidden test case'
            }
          else
            result.except(:hidden)
          end
        end
      end

      def track_code_execution(code, success)
        # Track execution (not a validation attempt)
        # This is just for analytics
        return unless current_user

        Rails.logger.info(
          "User #{current_user.id} executed code for lab #{@lab.id}: " \
          "success=#{success}, language=#{@lab.programming_language}"
        )
      end

      def track_code_attempt(code, success)
        return unless current_user

        LabAttempt.create(
          user: current_user,
          hands_on_lab: @lab,
          attempt_data: {
            code: code,
            language: @lab.programming_language,
            success: success
          },
          success: success,
          attempted_at: Time.current
        )
      end

      def update_lab_completion(code, validation_result)
        return unless current_user

        # Create successful lab attempt
        track_code_attempt(code, true)

        # Find or create lab session
        session = LabSession.find_or_initialize_by(
          user: current_user,
          hands_on_lab: @lab,
          status: 'active'
        )

        if session.new_record?
          session.session_id = SecureRandom.uuid
          session.started_at = Time.current
        end

        # Mark session as completed
        session.status = 'completed'
        session.ended_at = Time.current
        session.time_spent_seconds = validation_result[:results].sum { |r| r[:execution_time] || 0 }
        session.completion_percentage = 100
        session.steps_completed = @lab.test_case_count
        session.metadata = {
          test_results: validation_result,
          final_code: code
        }
        session.save!

        # Update lab statistics
        @lab.record_completion(session.time_spent_seconds, true)

        # Update course progress if this lab is part of a module
        update_module_progress if @lab.course_modules.any?

        session
      end

      def update_module_progress
        # Find all course modules this lab belongs to
        @lab.course_modules.each do |course_module|
          course = course_module.course
          enrollment = CourseEnrollment.find_by(user: current_user, course: course)

          next unless enrollment

          # Find or create module progress
          module_progress = ModuleProgress.find_or_initialize_by(
            user: current_user,
            course_module: course_module,
            course_enrollment: enrollment
          )

          # Mark this lab as completed in module progress
          module_progress.items_completed ||= 0
          module_progress.items_completed += 1
          module_progress.total_items = course_module.module_items.count
          module_progress.completion_percentage = (module_progress.items_completed.to_f / module_progress.total_items * 100).round(2)
          module_progress.status = module_progress.completion_percentage == 100 ? 'completed' : 'in_progress'
          module_progress.started_at ||= Time.current
          module_progress.completed_at = Time.current if module_progress.status == 'completed'
          module_progress.save!
        end
      end

      def get_attempt_count(lab)
        return 0 unless current_user

        LabAttempt.where(
          user: current_user,
          hands_on_lab: lab
        ).count
      end
    end
  end
end
