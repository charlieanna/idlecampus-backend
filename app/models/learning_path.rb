class LearningPath < ApplicationRecord
  belongs_to :user
  belongs_to :current_problem, class_name: 'Problem', optional: true

  # Validations
  validates :user_id, presence: true, uniqueness: true

  # Process a new attempt and update learning path
  def process_attempt(attempt)
    update_statistics(attempt)
    update_performance_metrics(attempt)
    detect_weak_and_strong_topics
    update_recommendations
  end

  # Get next recommended problem based on performance
  def next_recommended_problem
    # If user is struggling, recommend from prerequisite queue
    if currently_struggling?
      return get_prerequisite_problem
    end

    # If user has recommended problems, return first one
    if recommended_problems.present?
      problem = Problem.find_by(id: recommended_problems.first)
      return problem if problem
    end

    # Otherwise, recommend based on adaptive algorithm
    recommend_next_problem
  end

  # Check if user is currently struggling
  def currently_struggling?
    recent_attempts = user.problem_attempts.recent.limit(5)
    return false if recent_attempts.count < 3

    struggle_count = recent_attempts.count(&:struggling?)
    struggle_count.to_f / recent_attempts.count > 0.6
  end

  # Get topic where user is weakest
  def weakest_topic
    return nil if topic_performance.empty?

    topic_performance.min_by { |_, data| data['success_rate'] || 0 }&.first
  end

  # Get topic where user is strongest
  def strongest_topic
    return nil if topic_performance.empty?

    topic_performance.max_by { |_, data| data['success_rate'] || 0 }&.first
  end

  # Get recommended difficulty based on performance
  def recommended_difficulty
    return 'easy' if overall_success_rate.nil?

    case overall_success_rate
    when 0.9..1.0 then increase_difficulty
    when 0.7..0.89 then current_difficulty || 'medium'
    when 0.5..0.69 then current_difficulty || 'easy'
    else decrease_difficulty
    end
  end

  # Get personalized learning suggestions
  def learning_suggestions
    suggestions = []

    # Check for struggling patterns
    if currently_struggling?
      suggestions << {
        type: 'warning',
        title: 'Taking it Slow',
        message: "I notice you're finding recent problems challenging. Let's review some fundamentals.",
        action: 'review_prerequisites',
        problems: prerequisite_queue.first(3)
      }
    end

    # Check for weak topics
    if weak_topics.present?
      weak_topic = weak_topics.first
      suggestions << {
        type: 'improvement',
        title: "Strengthen #{weak_topic}",
        message: "Practice more #{weak_topic} problems to build confidence.",
        action: 'practice_weak_topic',
        topic: weak_topic,
        problems: Problem.by_topic(weak_topic).easy_problems.limit(5).pluck(:id)
      }
    end

    # Check for good streak
    if current_streak >= 5
      suggestions << {
        type: 'success',
        title: "🔥 #{current_streak}-day Streak!",
        message: "You're on fire! Ready for a tougher challenge?",
        action: 'level_up',
        problems: Problem.by_difficulty(increase_difficulty).limit(3).pluck(:id)
      }
    end

    # Check if ready to advance
    current_diff_rate = difficulty_performance[current_difficulty]
    if current_diff_rate && current_diff_rate > 0.8
      suggestions << {
        type: 'advancement',
        title: 'Ready to Level Up!',
        message: "You're mastering #{current_difficulty} problems. Time for #{increase_difficulty}?",
        action: 'increase_difficulty',
        problems: Problem.by_difficulty(increase_difficulty).limit(5).pluck(:id)
      }
    end

    suggestions
  end

  # Get daily practice set
  def daily_practice_set
    problems = []

    # 1. One problem from weak topic (if any)
    if weak_topics.present?
      weak_problem = Problem.by_topic(weak_topics.first)
                           .by_difficulty(recommended_difficulty)
                           .where.not(id: user.attempted_problem_ids)
                           .first
      problems << weak_problem if weak_problem
    end

    # 2. One problem at current difficulty
    current_problem = Problem.by_difficulty(current_difficulty || 'easy')
                            .where.not(id: user.attempted_problem_ids)
                            .order("RANDOM()")
                            .first
    problems << current_problem if current_problem

    # 3. One challenge problem (slightly harder)
    challenge_diff = increase_difficulty
    challenge_problem = Problem.by_difficulty(challenge_diff)
                              .where.not(id: user.attempted_problem_ids)
                              .order("RANDOM()")
                              .first
    problems << challenge_problem if challenge_problem

    problems.compact
  end

  # Check if user should take a break (prevent burnout)
  def should_take_break?
    return false unless last_activity_at

    # Check if struggled on last 3 problems
    recent = user.problem_attempts.recent.limit(3)
    return false if recent.count < 3

    all_struggling = recent.all?(&:struggling?)
    all_struggling
  end

  private

  def update_statistics(attempt)
    increment!(:total_problems_attempted)

    if attempt.success
      increment!(:total_problems_solved)
      increment!(:current_streak)
      update_column(:longest_streak, current_streak) if current_streak > longest_streak
    else
      update_column(:current_streak, 0)
    end

    update_column(:last_activity_at, Time.current)
    update_column(:current_problem_id, attempt.problem_id)
  end

  def update_performance_metrics(attempt)
    # Update overall success rate
    attempts = user.problem_attempts.count
    successes = user.problem_attempts.successful.count
    update_column(:overall_success_rate, (successes.to_f / attempts * 100).round(2))

    # Update topic performance
    update_topic_performance(attempt)

    # Update difficulty performance
    update_difficulty_performance(attempt)
  end

  def update_topic_performance(attempt)
    topic = attempt.problem.topic
    perf = topic_performance.dup || {}
    perf[topic] ||= { 'problems_attempted' => 0, 'problems_solved' => 0, 'success_rate' => 0 }

    perf[topic]['problems_attempted'] += 1
    perf[topic]['problems_solved'] += 1 if attempt.success

    total = perf[topic]['problems_attempted']
    solved = perf[topic]['problems_solved']
    perf[topic]['success_rate'] = (solved.to_f / total * 100).round(2)

    update_column(:topic_performance, perf)
    update_column(:current_topic, topic)
  end

  def update_difficulty_performance(attempt)
    difficulty = attempt.problem.difficulty
    perf = difficulty_performance.dup || {}

    # Get all attempts for this difficulty
    diff_attempts = user.problem_attempts.for_difficulty(difficulty).count
    diff_successes = user.problem_attempts.for_difficulty(difficulty).successful.count

    perf[difficulty] = (diff_successes.to_f / diff_attempts).round(2)

    update_column(:difficulty_performance, perf)
    update_column(:current_difficulty, difficulty)
  end

  def detect_weak_and_strong_topics
    return if topic_performance.empty?

    # Topics with success rate < 50% are weak
    weak = topic_performance.select { |_, data| data['success_rate'] < 50 && data['problems_attempted'] >= 3 }
                           .keys

    # Topics with success rate > 80% are strong
    strong = topic_performance.select { |_, data| data['success_rate'] > 80 && data['problems_attempted'] >= 3 }
                             .keys

    update_columns(
      weak_topics: weak,
      strong_topics: strong
    )
  end

  def update_recommendations
    recommendations = []

    # If currently struggling, add prerequisites
    if currently_struggling?
      recent_problem = user.problem_attempts.recent.first&.problem
      if recent_problem
        prereqs = recent_problem.get_prerequisites
        recommendations += prereqs.pluck(:id)
      end
    end

    # Add problems at recommended difficulty
    recommended = Problem.by_difficulty(recommended_difficulty)
                        .where.not(id: user.attempted_problem_ids)
                        .high_frequency
                        .limit(10)
                        .pluck(:id)

    recommendations += recommended

    update_column(:recommended_problems, recommendations.uniq.first(20))
  end

  def get_prerequisite_problem
    return nil if prerequisite_queue.empty?

    problem_id = prerequisite_queue.first
    problem = Problem.find_by(id: problem_id)

    # Remove from queue
    new_queue = prerequisite_queue.dup
    new_queue.shift
    update_column(:prerequisite_queue, new_queue)

    problem
  end

  def recommend_next_problem
    # Strategy based on learning style
    case learning_style
    when 'progressive'
      recommend_progressive
    when 'mixed'
      recommend_mixed
    when 'challenge_focused'
      recommend_challenge
    else
      recommend_adaptive
    end
  end

  def recommend_progressive
    # Gradually increase difficulty
    Problem.by_difficulty(recommended_difficulty)
          .where.not(id: user.attempted_problem_ids)
          .order(:difficulty_level)
          .first
  end

  def recommend_mixed
    # Mix of difficulties
    [
      Problem.by_difficulty('easy'),
      Problem.by_difficulty('medium'),
      Problem.by_difficulty('hard')
    ].sample
     .where.not(id: user.attempted_problem_ids)
     .order("RANDOM()")
     .first
  end

  def recommend_challenge
    # Focus on harder problems
    Problem.where("difficulty_level >= ?", target_difficulty_level)
          .where.not(id: user.attempted_problem_ids)
          .order(:difficulty_level)
          .first
  end

  def recommend_adaptive
    # Adaptive based on performance
    if overall_success_rate > 0.8
      # User is doing well, challenge them
      recommend_challenge
    elsif overall_success_rate < 0.5
      # User is struggling, give easier problems
      Problem.easy_problems
            .where.not(id: user.attempted_problem_ids)
            .order("RANDOM()")
            .first
    else
      # User is progressing normally
      recommend_progressive
    end
  end

  def increase_difficulty
    case current_difficulty
    when 'easy' then 'medium'
    when 'medium' then 'hard'
    when 'hard' then 'expert'
    else 'medium'
    end
  end

  def decrease_difficulty
    case current_difficulty
    when 'expert' then 'hard'
    when 'hard' then 'medium'
    when 'medium' then 'easy'
    else 'easy'
    end
  end
end
