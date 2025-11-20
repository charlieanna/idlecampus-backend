class RemediationTrackingService
  def initialize(user)
    @user = user
  end
  
  def track_lesson_review(quiz_attempt_id:, question_id:, lesson_id:)
    # Create or find existing remediation activity
    activity = RemediationActivity.find_or_create_by!(
      user_id: @user.id,
      quiz_attempt_id: quiz_attempt_id,
      quiz_question_id: question_id,
      course_lesson_id: lesson_id
    )
    
    activity.mark_as_reviewed!
    
    # Award progress points for remediation
    ProgressTrackingService.new.record_for_user(
      @user.id,
      points: 10,
      activity_type: 'remediation_review'
    )
    
    # Track learning event
    LearningEventTracker.new(@user).track_event(
      event_type: 'remediation_review',
      content_type: 'CourseLesson',
      content_id: lesson_id,
      metadata: {
        quiz_attempt_id: quiz_attempt_id,
        question_id: question_id
      }
    )
    
    activity
  end
  
  def track_retry_result(original_attempt_id:, retry_attempt_id:)
    original_attempt = QuizAttempt.find(original_attempt_id)
    retry_attempt = QuizAttempt.find(retry_attempt_id)
    
    # Compare answers to see which questions improved
    original_wrong = get_wrong_question_ids(original_attempt)
    retry_wrong = get_wrong_question_ids(retry_attempt)
    
    improved_questions = original_wrong - retry_wrong
    
    # Update remediation activities
    improved_questions.each do |question_id|
      activities = RemediationActivity.where(
        user_id: @user.id,
        quiz_attempt_id: original_attempt_id,
        quiz_question_id: question_id
      )
      
      activities.each do |activity|
        activity.mark_improvement!(improved: true)
      end
    end
    
    # Track the improvement event
    LearningEventTracker.new(@user).track_event(
      event_type: 'quiz_retry',
      content_type: 'Quiz',
      content_id: retry_attempt.quiz_id,
      metadata: {
        original_attempt_id: original_attempt_id,
        retry_attempt_id: retry_attempt_id,
        improved_count: improved_questions.count,
        score_improvement: retry_attempt.score - original_attempt.score
      }
    )
    
    {
      improved_count: improved_questions.count,
      still_wrong_count: retry_wrong.count,
      improvement_percentage: calculate_improvement_percentage(original_attempt, retry_attempt)
    }
  end
  
  def evaluate_remediation_effectiveness(topic: nil, since: 1.month.ago)
    scope = RemediationActivity.for_user(@user.id).since(since)
    scope = scope.by_topic(topic) if topic
    
    total_reviewed = scope.reviewed.count
    return nil if total_reviewed.zero?
    
    total_improved = scope.improved.count
    effectiveness_rate = (total_improved.to_f / total_reviewed * 100).round(2)
    
    {
      total_reviewed: total_reviewed,
      total_improved: total_improved,
      effectiveness_rate: effectiveness_rate,
      topic: topic,
      period: "since #{since.strftime('%Y-%m-%d')}"
    }
  end
  
  def get_remediation_stats(period: :all)
    all_activities = RemediationActivity.for_user(@user.id)
    
    # Filter by period
    if period != :all
      since = case period
              when :week then 1.week.ago
              when :month then 1.month.ago
              when :year then 1.year.ago
              else 1.month.ago
              end
      all_activities = all_activities.since(since)
    end
    
    unique_lessons = all_activities.distinct.pluck(:course_lesson_id).count
    
    {
      total_activities: all_activities.count,
      lessons_reviewed: all_activities.reviewed.count,
      unique_lessons: unique_lessons,
      improvement_rate: all_activities.effectiveness_rate(user_id: @user.id),
      most_reviewed_topics: get_most_reviewed_topics(all_activities),
      recent_reviews: all_activities.recent.limit(5).map { |a| format_activity(a) }
    }
  end
  
  def get_recommended_reviews
    # Find topics where user has struggled but not reviewed lessons
    wrong_attempts = QuizAttempt.where(user_id: @user.id, passed: false)
      .where('created_at > ?', 2.weeks.ago)
    
    recommendations = []
    
    wrong_attempts.each do |attempt|
      analyzer = EnhancedWrongAnswerAnalyzer.new(attempt)
      analysis = analyzer.analyze_and_recommend
      
      analysis[:lesson_mappings].each do |mapping|
        next unless mapping[:primary_lesson]
        
        # Check if user has already reviewed this lesson for this question
        already_reviewed = RemediationActivity.exists?(
          user_id: @user.id,
          quiz_question_id: mapping[:question_id],
          course_lesson_id: mapping[:primary_lesson][:lesson_id],
          lesson_reviewed: true
        )
        
        unless already_reviewed
          recommendations << {
            question_id: mapping[:question_id],
            lesson: mapping[:primary_lesson],
            quiz_attempt_id: attempt.id,
            priority: 'high'
          }
        end
      end
    end
    
    recommendations.uniq { |r| r[:lesson][:lesson_id] }.take(5)
  end
  
  private
  
  def get_wrong_question_ids(attempt)
    return [] unless attempt.answers.is_a?(Hash)
    
    wrong_ids = []
    attempt.answers.each do |question_id, user_answer|
      question = QuizQuestion.find_by(id: question_id)
      next unless question
      
      unless question.correct_answer?(user_answer)
        wrong_ids << question_id.to_i
      end
    end
    
    wrong_ids
  end
  
  def calculate_improvement_percentage(original_attempt, retry_attempt)
    return 0 if original_attempt.score.zero?
    
    improvement = retry_attempt.score - original_attempt.score
    (improvement.to_f / (100 - original_attempt.score) * 100).round(2)
  end
  
  def get_most_reviewed_topics(activities_scope = nil)
    scope = activities_scope || RemediationActivity.for_user(@user.id)
    
    scope.reviewed
      .joins(:quiz_question)
      .group('quiz_questions.topic')
      .select('quiz_questions.topic, COUNT(*) as count')
      .order('count DESC')
      .limit(5)
      .map { |result| { topic: result.topic, count: result.count } }
  end
  
  def format_activity(activity)
    {
      id: activity.id,
      lesson_title: activity.course_lesson.title,
      question_topic: activity.quiz_question.topic,
      reviewed: activity.lesson_reviewed,
      improved: activity.improved_on_retry,
      created_at: activity.created_at
    }
  end
end
