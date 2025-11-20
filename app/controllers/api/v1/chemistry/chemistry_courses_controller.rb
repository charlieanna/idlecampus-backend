# frozen_string_literal: true

module Api
  module V1
    module Chemistry
      class ChemistryCoursesController < GenericCoursesController
        # GET /api/v1/chemistry/courses
        def index
          courses = get_courses_by_pattern('chemistry')
          render json: {
            success: true,
            courses: courses.map { |c| course_summary(c) }
          }
        end

        # GET /api/v1/chemistry/courses/:slug
        def show
          course = Course.find_by!(slug: params[:slug])
          render json: {
            success: true,
            course: course_detail(course)
          }
        rescue ActiveRecord::RecordNotFound
          render json: { success: false, error: 'Course not found' }, status: :not_found
        end

        # GET /api/v1/chemistry/courses/:slug/modules
        def modules
          course = Course.find_by!(slug: params[:slug])
          modules = course.course_modules.ordered
          render json: {
            success: true,
            modules: modules.map { |mod| module_summary(mod) }
          }
        rescue ActiveRecord::RecordNotFound
          render json: { success: false, error: 'Course not found' }, status: :not_found
        end

        # GET /api/v1/chemistry/courses/:course_slug/modules/:module_slug
        def show_module
          course = Course.find_by!(slug: params[:course_slug])
          mod = course.course_modules.find_by!(slug: params[:module_slug])

          render json: {
            success: true,
            course: { id: course.id, title: course.title, slug: course.slug },
            module: module_detail(mod)
          }
        rescue ActiveRecord::RecordNotFound
          render json: { success: false, error: 'Module not found' }, status: :not_found
        end

        # GET /api/v1/chemistry/labs
        def labs
          labs = get_labs_by_type('chemistry')
          render json: {
            success: true,
            labs: labs.map { |lab| lab_summary(lab) }
          }
        end

        # GET /api/v1/chemistry/labs/:id
        def lab_show
          lab = HandsOnLab.find(params[:id])
          render json: {
            success: true,
            lab: lab_detail(lab)
          }
        rescue ActiveRecord::RecordNotFound
          render json: { success: false, error: 'Lab not found' }, status: :not_found
        end

        # GET /api/v1/chemistry/quizzes/:quiz_id
        def show_quiz
          quiz = Quiz.find(params[:quiz_id])

          render json: {
            success: true,
            quiz: quiz_detail(quiz)
          }
        rescue ActiveRecord::RecordNotFound
          render json: { success: false, error: 'Quiz not found' }, status: :not_found
        end

        # GET /api/v1/chemistry/quizzes/:quiz_id/questions
        def quiz_questions
          quiz = Quiz.find(params[:quiz_id])
          questions = quiz.quiz_questions.ordered

          render json: {
            success: true,
            quiz: {
              id: quiz.id,
              title: quiz.title,
              description: quiz.description,
              time_limit_minutes: quiz.time_limit_minutes,
              passing_score: quiz.passing_score,
              question_count: questions.count
            },
            questions: questions.map { |q| question_summary(q) }
          }
        rescue ActiveRecord::RecordNotFound
          render json: { success: false, error: 'Quiz not found' }, status: :not_found
        end

        # POST /api/v1/chemistry/quizzes/:quiz_id/questions/:question_id/submit
        def submit_answer
          question = QuizQuestion.find(params[:question_id])
          user_answer = params[:answer]

          is_correct = question.correct_answer?(user_answer)

          render json: {
            success: true,
            correct: is_correct,
            explanation: question.explanation,
            correct_answer: is_correct ? nil : question.formatted_correct_answer,
            points_earned: is_correct ? question.points : 0
          }
        rescue ActiveRecord::RecordNotFound
          render json: { success: false, error: 'Question not found' }, status: :not_found
        end

        # GET /api/v1/chemistry/lessons/:lesson_id
        def show_lesson
          lesson = CourseLesson.find(params[:lesson_id])

          render json: {
            success: true,
            lesson: lesson_detail(lesson)
          }
        rescue ActiveRecord::RecordNotFound
          render json: { success: false, error: 'Lesson not found' }, status: :not_found
        end

        private

        def quiz_detail(quiz)
          {
            id: quiz.id,
            title: quiz.title,
            description: quiz.description,
            time_limit_minutes: quiz.time_limit_minutes,
            passing_score: quiz.passing_score,
            max_attempts: quiz.max_attempts,
            shuffle_questions: quiz.shuffle_questions,
            show_correct_answers: quiz.show_correct_answers,
            quiz_type: quiz.quiz_type
          }
        end

        def question_summary(question)
          base = {
            id: question.id,
            question_type: question.question_type,
            question_text: question.question_text,
            points: question.points,
            difficulty_level: question.difficulty_level,
            sequence_order: question.sequence_order,
            image_url: question.image_url
          }

          # Add type-specific fields
          case question.question_type
          when 'mcq'
            base.merge(
              options: question.parsed_options,
              multiple_correct: question.multiple_correct || false
            )
          when 'sequence'
            base.merge(sequence_items: question.sequence_items || [])
          when 'numerical'
            base[:tolerance] = question.tolerance
            base
          else
            base
          end
        end

        def lesson_detail(lesson)
          {
            id: lesson.id,
            title: lesson.title,
            content: lesson.content,
            video_url: lesson.video_url,
            reading_time_minutes: lesson.reading_time_minutes,
            key_concepts: lesson.key_concepts
          }
        end
      end
    end
  end
end
