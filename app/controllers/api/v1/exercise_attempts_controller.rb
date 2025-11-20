module Api
  module V1
    class ExerciseAttemptsController < ApplicationController
      protect_from_forgery with: :null_session

      def create
        ex = Exercise.find_by(id: params[:id])
        return render json: { error: 'exercise_not_found' }, status: :not_found unless ex

        payload = attempt_params.to_h

        case ex.exercise_type
        when 'mcq'
          return render json: grade_mcq(ex, payload)
        when 'short_answer'
          return render json: grade_short_answer(ex, payload)
        when 'terminal', 'sandbox', 'code'
          return render json: run_with_runner(ex, payload)
        else
          render json: { error: 'unsupported_type' }, status: :unprocessable_entity
        end
      end

      private

      def attempt_params
        params.permit(:answer, :answer_index, :code, :files => {})
      end

      def grade_mcq(ex, payload)
        idx = payload['answer_index'].to_i
        correct = ex.exercise_data['correct_answer'].to_i
        pass = (idx == correct)
        {
          pass: pass,
          messages: pass ? ['Correct'] : ['Incorrect'],
          explanation: ex.exercise_data['explanation']
        }
      end

      def grade_short_answer(ex, payload)
        expected = ex.exercise_data['answer'] || ex.exercise_data['correct_answer']
        return { pass: false, messages: ['No expected answer configured'] } unless expected
        given = (payload['answer'] || '').to_s.strip
        variants = expected.split('|').map { |s| s.strip }
        pass = variants.any? { |v| given.casecmp(v).zero? }
        {
          pass: pass,
          messages: pass ? ['Correct'] : ["Expected one of: #{variants.join(', ')}"],
          explanation: ex.exercise_data['explanation']
        }
      end

      def run_with_runner(ex, payload = {})
        # For code exercises, write posted files to disk so tests can run
        if ex.exercise_type == 'code'
          files = payload['files'] || payload[:files]
          if files.is_a?(Hash)
            files.each do |rel_path, content|
              # Sanitize path to avoid directory traversal
              safe_rel = rel_path.to_s.gsub("..", "").sub(%r{^/+}, '')
              abs = Rails.root.join(safe_rel)
              FileUtils.mkdir_p(File.dirname(abs))
              File.write(abs, content.to_s)
            end
          else
            # If no files posted but starter_code is provided with a single file, write it once
            ed = ex.exercise_data || {}
            arr = ed['files'] || []
            if arr.is_a?(Array) && arr.length == 1 && ed['starter_code'].present?
              rel = arr.first.to_s.gsub('..','').sub(%r{^/+}, '')
              abs = Rails.root.join(rel)
              FileUtils.mkdir_p(File.dirname(abs))
              File.write(abs, ed['starter_code'].to_s) unless File.exist?(abs)
            end
          end
        end
        runner = File.expand_path('../../../../scripts/run_exercise.rb', __dir__)
        payload = {
          exercise_type: ex.exercise_type,
          exercise_data: ex.exercise_data
        }
        # Merge in working dir for code exercises if present
        if ex.exercise_type == 'code'
          # runner defaults validation for code
        end
        out = nil
        Dir.chdir(Rails.root) do
          out = IO.popen([RbConfig.ruby, runner, payload.to_json], &:read)
        end
        JSON.parse(out)
      rescue => e
        Rails.logger.error "Exercise runner error: #{e.message}"
        { pass: false, error: 'runner_error', message: e.message }
      end
    end
  end
end
