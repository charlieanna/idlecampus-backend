module Api
  module V1
    class AdaptiveLearningController < ApplicationController
      before_action :authenticate_user!
      before_action :ensure_learning_path

      # GET /api/v1/adaptive_learning/next_problem
      # Get next recommended problem based on user's performance
      def next_problem
        service = AdaptiveLearningService.new(current_user)
        recommendation = service.recommend_next_problem

        render json: {
          success: true,
          recommendation: recommendation,
          learning_path: learning_path_summary
        }
      end

      # POST /api/v1/adaptive_learning/record_attempt
      # Record a problem attempt and get feedback
      def record_attempt
        problem = Problem.find_by!(slug: params[:problem_slug])
        service = AdaptiveLearningService.new(current_user)

        result = service.record_attempt(problem, attempt_params)

        render json: {
          success: true,
          attempt: result[:attempt],
          next_action: result[:next_action],
          suggestions: result[:learning_suggestions],
          struggle_analysis: analyze_if_struggling(result[:attempt])
        }
      end

      # GET /api/v1/adaptive_learning/daily_practice
      # Get personalized daily practice set
      def daily_practice
        service = AdaptiveLearningService.new(current_user)
        practice_set = service.generate_daily_practice

        render json: {
          success: true,
          practice_set: practice_set
        }
      end

      # GET /api/v1/adaptive_learning/improvement_plan
      # Get improvement plan for weak areas
      def improvement_plan
        service = AdaptiveLearningService.new(current_user)
        plan = service.create_improvement_plan

        render json: {
          success: true,
          improvement_plan: plan
        }
      end

      # GET /api/v1/adaptive_learning/struggle_analysis
      # Analyze struggling patterns and get interventions
      def struggle_analysis
        service = AdaptiveLearningService.new(current_user)
        analysis = service.detect_struggle_patterns

        render json: {
          success: true,
          analysis: analysis
        }
      end

      # GET /api/v1/adaptive_learning/learning_path
      # Get complete learning path information
      def learning_path
        path = current_user.learning_path

        render json: {
          success: true,
          learning_path: {
            current_problem: path.current_problem,
            current_topic: path.current_topic,
            current_difficulty: path.current_difficulty,
            overall_success_rate: path.overall_success_rate,
            topic_performance: path.topic_performance,
            difficulty_performance: path.difficulty_performance,
            weak_topics: path.weak_topics,
            strong_topics: path.strong_topics,
            current_streak: path.current_streak,
            longest_streak: path.longest_streak,
            total_problems_attempted: path.total_problems_attempted,
            total_problems_solved: path.total_problems_solved,
            recommended_problems: Problem.where(id: path.recommended_problems.first(5)),
            suggestions: path.learning_suggestions
          }
        }
      end

      # POST /api/v1/adaptive_learning/set_learning_style
      # Set user's learning style preference
      def set_learning_style
        path = current_user.learning_path
        path.update!(
          learning_style: params[:learning_style],
          target_difficulty_level: params[:target_difficulty_level] || 1
        )

        render json: {
          success: true,
          learning_path: path
        }
      end

      # GET /api/v1/adaptive_learning/prerequisites/:problem_slug
      # Get prerequisites for a specific problem
      def prerequisites
        problem = Problem.find_by!(slug: params[:problem_slug])
        last_attempt = current_user.problem_attempts.where(problem: problem).recent.first

        prerequisites = if last_attempt&.struggling?
                         last_attempt.get_prerequisite_recommendations
                       else
                         problem.get_prerequisites
                       end

        render json: {
          success: true,
          problem: problem,
          struggling: last_attempt&.struggling? || false,
          prerequisites: prerequisites,
          message: generate_prerequisite_message(last_attempt, prerequisites)
        }
      end

      # GET /api/v1/adaptive_learning/similar_problems/:problem_slug
      # Get similar problems for practice
      def similar_problems
        problem = Problem.find_by!(slug: params[:problem_slug])
        last_attempt = current_user.problem_attempts.where(problem: problem).recent.first

        similar = if last_attempt&.struggling?
                   last_attempt.get_easier_alternatives
                 else
                   last_attempt&.get_similar_problems || problem.family_problems.limit(5)
                 end

        render json: {
          success: true,
          problem: problem,
          similar_problems: similar,
          difficulty_adjusted: last_attempt&.struggling?
        }
      end

      # GET /api/v1/adaptive_learning/stats
      # Get detailed statistics
      def stats
        path = current_user.learning_path
        attempts = current_user.problem_attempts

        render json: {
          success: true,
          stats: {
            overview: {
              total_problems_attempted: attempts.count,
              total_problems_solved: attempts.successful.count,
              success_rate: path.overall_success_rate,
              current_streak: path.current_streak,
              longest_streak: path.longest_streak
            },
            by_difficulty: {
              easy: difficulty_stats('easy'),
              medium: difficulty_stats('medium'),
              hard: difficulty_stats('hard'),
              expert: difficulty_stats('expert')
            },
            by_topic: topic_stats,
            recent_activity: recent_activity_stats,
            time_analysis: time_analysis_stats
          }
        }
      end

      private

      def ensure_learning_path
        current_user.create_learning_path unless current_user.learning_path
      end

      def attempt_params
        params.require(:attempt).permit(
          :success,
          :time_spent_seconds,
          :submitted_code,
          :hints_used,
          :gave_up,
          :viewed_solution,
          :syntax_errors,
          :logic_errors,
          :compilation_errors,
          :started_at,
          test_results: [],
          hints_viewed: []
        )
      end

      def learning_path_summary
        path = current_user.learning_path
        {
          current_streak: path.current_streak,
          success_rate: path.overall_success_rate,
          current_difficulty: path.current_difficulty,
          total_solved: path.total_problems_solved,
          struggling: current_user.is_struggling?
        }
      end

      def analyze_if_struggling(attempt)
        return nil unless attempt.struggling?

        {
          struggling: true,
          struggle_score: attempt.struggle_score,
          factors: {
            multiple_attempts: attempt.attempts_count >= 3,
            hints_used: attempt.hints_used >= 2,
            gave_up: attempt.gave_up,
            viewed_solution: attempt.viewed_solution,
            many_errors: (attempt.syntax_errors + attempt.logic_errors + attempt.compilation_errors) >= 3
          },
          recommendation: attempt.recommended_next_action
        }
      end

      def generate_prerequisite_message(attempt, prerequisites)
        if attempt&.struggling?
          "I notice you're finding this challenging. These #{prerequisites.count} problems will help build the foundation you need."
        elsif prerequisites.any?
          "Complete these #{prerequisites.count} prerequisites to better understand this problem."
        else
          "No prerequisites needed - you're ready to tackle this problem!"
        end
      end

      def difficulty_stats(difficulty)
        attempts = current_user.problem_attempts.for_difficulty(difficulty)
        {
          attempted: attempts.count,
          solved: attempts.successful.count,
          success_rate: attempts.count.zero? ? 0 : (attempts.successful.count.to_f / attempts.count * 100).round(2)
        }
      end

      def topic_stats
        stats = {}
        Problem.distinct.pluck(:topic).each do |topic|
          attempts = current_user.problem_attempts.for_topic(topic)
          stats[topic] = {
            attempted: attempts.count,
            solved: attempts.successful.count,
            success_rate: attempts.count.zero? ? 0 : (attempts.successful.count.to_f / attempts.count * 100).round(2)
          }
        end
        stats
      end

      def recent_activity_stats
        recent = current_user.problem_attempts.recent.limit(10)
        {
          last_10_attempts: recent.map do |attempt|
            {
              problem: attempt.problem.title,
              success: attempt.success,
              difficulty: attempt.problem.difficulty,
              time_spent_mins: attempt.time_spent_mins,
              struggling: attempt.struggling?,
              date: attempt.created_at
            }
          end
        }
      end

      def time_analysis_stats
        attempts = current_user.problem_attempts.where.not(time_spent_seconds: nil)
        return {} if attempts.empty?

        {
          average_time_mins: (attempts.average(:time_spent_seconds).to_f / 60).round(2),
          fastest_solve_mins: (attempts.minimum(:time_spent_seconds).to_f / 60).round(2),
          slowest_solve_mins: (attempts.maximum(:time_spent_seconds).to_f / 60).round(2)
        }
      end
    end
  end
end
