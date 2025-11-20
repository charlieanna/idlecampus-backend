# Adaptive Learning Service
# Handles intelligent problem recommendation and learning path management
# Detects when users struggle and provides appropriate interventions

class AdaptiveLearningService
  attr_reader :user, :learning_path

  def initialize(user)
    @user = user
    @learning_path = user.learning_path || user.create_learning_path
  end

  # Main method: Get next recommended problem
  def recommend_next_problem
    # Check if user should take a break
    return break_recommendation if learning_path.should_take_break?

    # If user is struggling, provide intervention
    return struggle_intervention if user.is_struggling?

    # Check if there are prerequisites to complete
    if learning_path.prerequisite_queue.present?
      return prerequisite_recommendation
    end

    # Get adaptive recommendation based on performance
    adaptive_recommendation
  end

  # Record a problem attempt and update learning path
  def record_attempt(problem, params)
    attempt = user.problem_attempts.create!(
      problem: problem,
      success: params[:success],
      time_spent_seconds: params[:time_spent_seconds],
      submitted_code: params[:submitted_code],
      test_results: params[:test_results] || [],
      hints_used: params[:hints_used] || 0,
      hints_viewed: params[:hints_viewed] || [],
      attempts_count: count_previous_attempts(problem) + 1,
      gave_up: params[:gave_up] || false,
      viewed_solution: params[:viewed_solution] || false,
      syntax_errors: params[:syntax_errors] || 0,
      logic_errors: params[:logic_errors] || 0,
      compilation_errors: params[:compilation_errors] || 0,
      started_at: params[:started_at],
      completed_at: Time.current
    )

    # Get recommended next action
    next_action = attempt.recommended_next_action

    {
      attempt: attempt,
      next_action: next_action,
      learning_suggestions: learning_path.learning_suggestions
    }
  end

  # Get personalized daily practice set
  def generate_daily_practice
    {
      title: "Your Daily Practice",
      date: Date.today,
      problems: learning_path.daily_practice_set,
      suggestions: learning_path.learning_suggestions,
      stats: {
        current_streak: learning_path.current_streak,
        success_rate: learning_path.overall_success_rate,
        total_solved: learning_path.total_problems_solved
      }
    }
  end

  # Analyze user's weak areas and create improvement plan
  def create_improvement_plan
    weak_topics = learning_path.weak_topics
    return nil if weak_topics.empty?

    plans = weak_topics.map do |topic|
      {
        topic: topic,
        current_performance: learning_path.topic_performance[topic],
        recommended_problems: get_improvement_problems(topic),
        estimated_time: "2-3 weeks",
        milestones: [
          { goal: "Complete 5 easy problems", status: "pending" },
          { goal: "Complete 5 medium problems", status: "pending" },
          { goal: "Achieve 70% success rate", status: "pending" }
        ]
      }
    end

    {
      weak_topics: weak_topics.count,
      plans: plans,
      total_problems: plans.sum { |p| p[:recommended_problems].count }
    }
  end

  # Detect struggling patterns and provide intervention
  def detect_struggle_patterns
    recent_attempts = user.problem_attempts.recent.limit(10)
    return nil if recent_attempts.count < 5

    patterns = {
      repeated_failures: detect_repeated_failures(recent_attempts),
      hint_dependency: detect_hint_dependency(recent_attempts),
      time_struggles: detect_time_struggles(recent_attempts),
      topic_struggles: detect_topic_struggles(recent_attempts)
    }

    # Generate interventions based on patterns
    interventions = generate_interventions(patterns)

    {
      patterns: patterns,
      interventions: interventions,
      struggling: patterns.values.any?
    }
  end

  private

  # RECOMMENDATIONS

  def break_recommendation
    {
      type: 'break',
      title: 'Time for a Break',
      message: "I notice you've been struggling with recent problems. Take a break and come back refreshed!",
      suggested_break_duration: '1-2 hours',
      alternative_activities: [
        'Review your notes',
        'Watch tutorial videos',
        'Practice similar problems you\'ve already solved'
      ]
    }
  end

  def struggle_intervention
    recent_failed = user.problem_attempts.recent.failed.first
    problem = recent_failed&.problem

    {
      type: 'intervention',
      title: 'Let\'s Build a Stronger Foundation',
      message: 'I see you\'re finding this challenging. Let\'s step back and practice some fundamentals.',
      struggling_area: problem&.topic,
      recommended_actions: [
        {
          action: 'review_prerequisites',
          title: 'Review Prerequisites',
          problems: get_prerequisites_for_topic(problem&.topic)
        },
        {
          action: 'practice_easier',
          title: 'Practice Easier Problems',
          problems: get_easier_problems(problem&.topic)
        },
        {
          action: 'study_resources',
          title: 'Study Resources',
          resources: get_study_resources(problem&.topic)
        }
      ]
    }
  end

  def prerequisite_recommendation
    prereq_problem = Problem.find_by(id: learning_path.prerequisite_queue.first)

    {
      type: 'prerequisite',
      title: 'Master the Basics First',
      message: 'Complete these prerequisite problems before moving forward.',
      problem: prereq_problem,
      remaining_prerequisites: learning_path.prerequisite_queue.count,
      reason: 'These will help you build the skills needed for your next challenge'
    }
  end

  def adaptive_recommendation
    problem = learning_path.next_recommended_problem

    {
      type: 'standard',
      title: 'Your Next Challenge',
      message: personalized_message,
      problem: problem,
      difficulty: problem&.difficulty,
      estimated_time: problem&.estimated_time_mins,
      why_this_problem: explain_recommendation(problem)
    }
  end

  # HELPER METHODS

  def count_previous_attempts(problem)
    user.problem_attempts.where(problem: problem).count
  end

  def get_improvement_problems(topic)
    # Start with easy, progress to medium
    easy_problems = Problem.by_topic(topic)
                          .easy_problems
                          .where.not(id: user.completed_problem_ids)
                          .limit(5)

    medium_problems = Problem.by_topic(topic)
                            .medium_problems
                            .where.not(id: user.completed_problem_ids)
                            .limit(5)

    easy_problems + medium_problems
  end

  def get_prerequisites_for_topic(topic)
    return [] unless topic

    # Get easy problems in the topic
    Problem.by_topic(topic)
          .easy_problems
          .high_frequency
          .where.not(id: user.attempted_problem_ids)
          .limit(3)
  end

  def get_easier_problems(topic)
    return [] unless topic

    current_diff = learning_path.current_difficulty
    easier_diff = case current_diff
                  when 'hard' then 'medium'
                  when 'medium' then 'easy'
                  else 'easy'
                  end

    Problem.by_topic(topic)
          .by_difficulty(easier_diff)
          .where.not(id: user.attempted_problem_ids)
          .limit(5)
  end

  def get_study_resources(topic)
    # This would connect to your learning resources
    [
      { type: 'video', title: "#{topic} Tutorial", url: '#' },
      { type: 'article', title: "#{topic} Explained", url: '#' },
      { type: 'cheatsheet', title: "#{topic} Cheat Sheet", url: '#' }
    ]
  end

  def personalized_message
    messages = []

    if learning_path.current_streak >= 5
      messages << "🔥 Amazing #{learning_path.current_streak}-day streak! Keep it up!"
    elsif learning_path.overall_success_rate > 80
      messages << "You're doing great! Ready for a challenge?"
    elsif learning_path.overall_success_rate < 50
      messages << "Let's take it step by step. You've got this!"
    else
      messages << "Keep practicing! You're making progress."
    end

    messages.sample
  end

  def explain_recommendation(problem)
    return nil unless problem

    reasons = []

    # Check if it's in a weak topic
    if learning_path.weak_topics.include?(problem.topic)
      reasons << "This will help strengthen your #{problem.topic} skills"
    end

    # Check if it's at recommended difficulty
    if problem.difficulty == learning_path.recommended_difficulty
      reasons << "This difficulty matches your current skill level"
    end

    # Check if it's high frequency
    if problem.popular?
      reasons << "This is a frequently asked interview question"
    end

    reasons.join('. ')
  end

  # PATTERN DETECTION

  def detect_repeated_failures(attempts)
    failed_count = attempts.failed.count
    {
      detected: failed_count >= 3,
      count: failed_count,
      severity: failed_count >= 5 ? 'high' : 'medium'
    }
  end

  def detect_hint_dependency(attempts)
    high_hint_usage = attempts.count { |a| a.hints_used >= 3 }
    {
      detected: high_hint_usage >= 3,
      count: high_hint_usage,
      average_hints: attempts.average(:hints_used)&.round(2)
    }
  end

  def detect_time_struggles(attempts)
    slow_solves = attempts.count do |a|
      next false unless a.problem.estimated_time_mins && a.time_spent_seconds

      time_ratio = (a.time_spent_seconds / 60.0) / a.problem.estimated_time_mins
      time_ratio > 2.0
    end

    {
      detected: slow_solves >= 3,
      count: slow_solves
    }
  end

  def detect_topic_struggles(attempts)
    topic_failures = attempts.failed.group_by { |a| a.problem.topic }
    struggling_topics = topic_failures.select { |_, fails| fails.count >= 2 }.keys

    {
      detected: struggling_topics.any?,
      topics: struggling_topics,
      count: struggling_topics.count
    }
  end

  def generate_interventions(patterns)
    interventions = []

    if patterns[:repeated_failures][:detected]
      interventions << {
        type: 'repeated_failures',
        message: 'Try reviewing the fundamental concepts before attempting more problems',
        action: 'review_basics'
      }
    end

    if patterns[:hint_dependency][:detected]
      interventions << {
        type: 'hint_dependency',
        message: 'Try to solve problems without hints to build problem-solving confidence',
        action: 'practice_independently'
      }
    end

    if patterns[:time_struggles][:detected]
      interventions << {
        type: 'time_management',
        message: 'Focus on recognizing patterns quickly. Practice similar problems for speed',
        action: 'timed_practice'
      }
    end

    if patterns[:topic_struggles][:detected]
      interventions << {
        type: 'topic_weakness',
        message: "Focus on mastering: #{patterns[:topic_struggles][:topics].join(', ')}",
        action: 'targeted_practice',
        topics: patterns[:topic_struggles][:topics]
      }
    end

    interventions
  end
end
