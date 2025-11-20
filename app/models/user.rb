class User < ApplicationRecord
    has_many :user_lessons
    has_many :lessons, through: :user_lessons
    has_one :profile
    has_many :interests, dependent: :destroy
    has_many :interested_posts, through: :interests, source: :post
    has_many :user_course_enrollments
    has_many :user_course_progresses
    has_many :user_achievements
    
    # Course system associations
    has_many :course_enrollments, dependent: :destroy
    has_many :enrolled_courses, through: :course_enrollments, source: :course
    has_many :module_progresses, dependent: :destroy
    has_many :quiz_attempts, dependent: :destroy
    has_many :lesson_completions, dependent: :destroy
    has_many :learning_unit_progresses, dependent: :destroy
    has_many :interactive_learning_units, through: :learning_unit_progresses
    has_many :remediation_sessions, dependent: :destroy
  has_many :learning_events, dependent: :destroy
  has_many :user_skill_dimensions, dependent: :destroy
    has_many :completed_lessons, through: :lesson_completions, source: :lesson
    has_many :lab_sessions, dependent: :destroy
    has_one :user_stat, dependent: :destroy
    has_many :study_plans, dependent: :destroy
    has_many :exam_simulations, dependent: :destroy
    has_many :remediation_activities, dependent: :destroy
    
    # Autonomous Learning & Mastery Decay
    has_many :learning_sessions, dependent: :destroy
    has_many :command_masteries, class_name: 'UserCommandMastery', dependent: :destroy
    has_many :stealth_reviews, dependent: :destroy
    has_many :lab_attempts, dependent: :destroy
    
    # Achievement system (renamed to avoid conflicts)
    has_many :user_course_achievements, dependent: :destroy
    has_many :course_achievements, through: :user_course_achievements

    # UPSC Preparation System
    has_one :upsc_student_profile, class_name: 'Upsc::StudentProfile', dependent: :destroy
    has_many :upsc_user_test_attempts, class_name: 'Upsc::UserTestAttempt', dependent: :destroy
    has_many :upsc_user_answers, class_name: 'Upsc::UserAnswer', dependent: :destroy
    has_many :upsc_study_plans, class_name: 'Upsc::StudyPlan', dependent: :destroy
    has_many :upsc_daily_tasks, class_name: 'Upsc::DailyTask', dependent: :destroy
    has_many :upsc_revisions, class_name: 'Upsc::Revision', dependent: :destroy
    has_many :upsc_user_progress, class_name: 'Upsc::UserProgress', dependent: :destroy

    # Algorithms & Problem Solving
    has_many :problem_attempts, dependent: :destroy
    has_many :attempted_problems, through: :problem_attempts, source: :problem
    has_one :learning_path, dependent: :destroy

    # Helper methods for problem solving
    def completed_problem_ids
      problem_attempts.successful.pluck(:problem_id).uniq
    end

    def attempted_problem_ids
      problem_attempts.pluck(:problem_id).uniq
    end

    def problem_success_rate
      total = problem_attempts.count
      return 0 if total.zero?

      successes = problem_attempts.successful.count
      (successes.to_f / total * 100).round(2)
    end

    def current_problem_streak
      learning_path&.current_streak || 0
    end

    def is_struggling?
      learning_path&.currently_struggling? || false
    end

    def parsed_associated_data
      return {} unless associated_data.present?

      if associated_data.is_a?(String)
        begin
          JSON.parse(associated_data)
        rescue JSON::ParserError
          {}
        end
      else
        associated_data
      end
    end
end

# class User < ApplicationRecord
#   has_many :submissions, dependent: :destroy

#   def total_score
#     # Calculate the sum of scores of all submissions for this user
#     submissions.sum(:score)
#   end
  
#   def day_summary
#     # shows what the user has done from 9 am to 9 pm of the day in SO

#   end
  
#   def answers
#     user_id = self.user_id
#     api = "https://api.stackexchange.com/2.2/users/#{user_id}/answers?order=desc&sort=activity&site=stackoverflow"
#     uri = URI.parse(api)
#     user_response = Net::HTTP.get(uri)
#     user = JSON.parse(user_response)
#     questions = []
#     for item in user["items"]
#       answer_score = AnswerScore.find_by(question_id: item["question_id"], answer_id: item["answer_id"], user_id: item["owner"]["user_id"])
#       if answer_score.nil?
#         AnswerScore.create(question_id: item["question_id"], answer_id: item["answer_id"], score: item["score"], user_id: item["owner"]["user_id"])
#       else
#         answer_score.update(question_id: item["question_id"], answer_id: item["answer_id"], score: item["score"], user_id: item["owner"]["user_id"])
#       end
#     end
#   end
# end