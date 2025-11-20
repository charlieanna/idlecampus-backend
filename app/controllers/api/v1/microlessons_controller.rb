module Api
  module V1
    class MicrolessonsController < ApplicationController
      protect_from_forgery with: :null_session

      def by_module
        slug = params[:module_slug] || params[:slug]
        mod = CourseModule.find_by(slug: slug)
        return render json: { error: 'module_not_found' }, status: :not_found unless mod

        lessons = mod.micro_lessons.ordered
        render json: lessons.map { |l| serialize_lesson(l, include_exercises: false) }
      end

      def show
        lesson = MicroLesson.find_by(id: params[:id]) || MicroLesson.find_by(slug: params[:id])
        return render json: { error: 'lesson_not_found' }, status: :not_found unless lesson

        render json: serialize_lesson(lesson, include_exercises: true)
      end

      private

      def serialize_lesson(lesson, include_exercises: true)
        data = {
          id: lesson.id,
          slug: lesson.slug,
          title: lesson.title,
          content: lesson.content,
          sequence_order: lesson.sequence_order,
          difficulty: lesson.difficulty,
          estimated_minutes: lesson.estimated_minutes,
          module_slug: lesson.course_module&.slug
        }
        if include_exercises
          data[:exercises] = lesson.exercises.ordered.map { |e| serialize_exercise(e) }
        end
        data
      end

      # expose only public fields; never leak hidden test details
      def serialize_exercise(ex)
        d = ex.exercise_data.deep_dup || {}
        # Remove test/validation internals from client payload for code/sandbox
        d.delete('tests')
        # Keep a minimal safe subset
        public_keys = case ex.exercise_type
                      when 'terminal' then %w[command description hints difficulty timeout_sec cwd]
                      when 'sandbox'  then %w[run description hints difficulty timeout_sec]
                      when 'code'     then %w[description language files starter_code hints]
                      when 'mcq'      then %w[question options explanation hints]
                      when 'short_answer' then %w[question hints]
                      else d.keys
                      end
        safe = d.slice(*public_keys)
        {
          id: ex.id,
          exercise_type: ex.exercise_type,
          sequence_order: ex.sequence_order,
          exercise_data: safe
        }
      end
    end
  end
end

