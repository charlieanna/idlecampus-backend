class WeaknessDetectionService
  """
  Detects user weaknesses based on learning events and quiz performance
  Generates targeted remediation recommendations
  """
  
  def initialize(user)
    @user = user
  end
  
  def detect_weaknesses(threshold: 0.5, min_attempts: 3)
    """
    Detect weak areas based on performance
    
    Returns array of:
      {
        dimension: string,
        topic: string,
        severity: float (0-1),
        error_count: int,
        accuracy: float,
        recommendation: hash
      }
    """
    
    weaknesses = []
    
    # Analyze by topic
    topic_performance = analyze_topic_performance
    
    topic_performance.each do |topic, stats|
      next if stats[:attempts] < min_attempts
      
      accuracy = stats[:correct].to_f / stats[:attempts]
      
      if accuracy < threshold
        severity = 1.0 - accuracy
        
        weakness = {
          dimension: infer_dimension_from_topic(topic),
          topic: topic,
          severity: severity,
          error_count: stats[:incorrect],
          attempts: stats[:attempts],
          accuracy: accuracy,
          last_error_at: stats[:last_attempt],
          recommendation: generate_topic_remediation(topic, severity)
        }
        
        weaknesses << weakness
        
        # Persist to database
        persist_weakness(weakness)
      end
    end
    
    # Sort by severity (worst first)
    weaknesses.sort_by { |w| -w[:severity] }
  end
  
  def analyze_skill_dimensions
    """Analyze performance by skill dimension"""
    
    dimensions = {}
    
    UserSkillDimension.where(user: @user).each do |dim|
      dimensions[dim.dimension] = {
        ability: dim.ability_estimate,
        confidence: 1 - dim.standard_error,
        observations: dim.n_observations,
        level: ability_to_level(dim.ability_estimate)
      }
    end
    
    dimensions
  end
  
  def generate_study_plan
    """Generate prioritized study plan based on weaknesses"""
    
    weaknesses = detect_weaknesses
    
    plan = {
      priority_topics: [],
      review_items: [],
      practice_labs: [],
      estimated_time_minutes: 0
    }
    
    # Top 3 weaknesses
    weaknesses.first(3).each do |weakness|
      # Find content for this topic
      lessons = find_lessons_for_topic(weakness[:topic])
      quizzes = find_practice_quizzes_for_topic(weakness[:topic])
      labs = find_labs_for_topic(weakness[:topic])
      
      plan[:priority_topics] << {
        topic: weakness[:topic],
        severity: weakness[:severity],
        lessons: lessons,
        quizzes: quizzes,
        labs: labs,
        time_estimate: calculate_remediation_time(weakness[:severity])
      }
      
      plan[:estimated_time_minutes] += calculate_remediation_time(weakness[:severity])
    end
    
    plan
  end
  
  private
  
  def analyze_topic_performance
    """Analyze performance by topic"""
    
    performance = Hash.new { |h, k| h[k] = { correct: 0, incorrect: 0, attempts: 0, last_attempt: nil } }
    
    # Get all quiz answers
    events = LearningEvent
      .for_user(@user.id)
      .by_type('quiz_question_answered')
      .recent
      .limit(100)
    
    events.each do |event|
      topic = event.event_data['topic'] || 'general'
      correct = event.performance_score.to_f > 0
      
      performance[topic][:attempts] += 1
      performance[topic][:correct] += 1 if correct
      performance[topic][:incorrect] += 1 unless correct
      performance[topic][:last_attempt] = event.created_at
    end
    
    performance
  end
  
  def infer_dimension_from_topic(topic)
    """Map topic to skill dimension"""
    
    topic_to_dimension = {
      'container' => 'docker_basics',
      'deployment' => 'k8s_basics',
      'service' => 'networking',
      'networking' => 'networking',
      'storage' => 'storage',
      'security' => 'security',
      'rbac' => 'security',
      'pod' => 'k8s_basics',
      'scheduling' => 'k8s_advanced'
    }
    
    topic_to_dimension[topic] || 'general'
  end
  
  def generate_topic_remediation(topic, severity)
    """Generate remediation plan for topic"""
    
    lessons = find_lessons_for_topic(topic)
    quizzes = find_practice_quizzes_for_topic(topic)
    
    {
      actions: [
        severity > 0.7 ? "Review fundamentals" : "Practice more",
        "Complete #{lessons.count} related lessons",
        "Take #{quizzes.count} practice quizzes"
      ],
      content_ids: {
        lessons: lessons.pluck(:id),
        quizzes: quizzes.pluck(:id)
      },
      estimated_time: calculate_remediation_time(severity)
    }
  end
  
  def find_lessons_for_topic(topic)
    """Find lessons related to topic"""
    
    CourseLesson.where("content LIKE ? OR title LIKE ?", "%#{topic}%", "%#{topic}%")
      .limit(3)
  end
  
  def find_practice_quizzes_for_topic(topic)
    """Find quizzes for topic practice"""
    
    Quiz.joins(:quiz_questions)
      .where(quiz_questions: { topic: topic })
      .distinct
      .limit(2)
  end
  
  def find_labs_for_topic(topic)
    """Find hands-on labs for topic"""
    
    HandsOnLab
      .where("category LIKE ? OR title LIKE ?", "%#{topic}%", "%#{topic}%")
      .limit(2)
  end
  
  def calculate_remediation_time(severity)
    """Estimate time needed for remediation"""
    
    case severity
    when 0.8..1.0
      45 # Severe weakness
    when 0.6..0.8
      30 # Moderate weakness
    else
      15 # Minor weakness
    end
  end
  
  def persist_weakness(weakness)
    """Save weakness to database"""
    
    UserWeakness.find_or_initialize_by(
      user: @user,
      skill_dimension: weakness[:dimension],
      topic: weakness[:topic]
    ).tap do |w|
      w.severity = weakness[:severity]
      w.error_count = weakness[:error_count]
      w.last_error_at = weakness[:last_error_at]
      w.remediation_status = 'identified'
      w.remediation_plan = weakness[:recommendation]
      w.save!
    end
  end
  
  def ability_to_level(ability)
    """Convert ability score to level name"""
    
    case ability
    when -Float::INFINITY..-0.5
      'Beginner'
    when -0.5..0.5
      'Intermediate'
    when 0.5..1.5
      'Advanced'
    else
      'Expert'
    end
  end
  
  def normalize_command(cmd)
    cmd.to_s.strip.squeeze(' ').downcase
  end
  
  def same_base_command?(user_cmd, correct_cmd)
    user_cmd.split.first == correct_cmd.split.first
  end
  
  def has_syntax_error?(cmd)
    cmd.count('"') % 2 != 0 || cmd.count("'") % 2 != 0
  end
  
  def missing_required_flags?(user_cmd, correct_cmd)
    correct_flags = correct_cmd.scan(/--?[\w-]+/)
    user_flags = user_cmd.scan(/--?[\w-]+/)
    (correct_flags - user_flags).any?
  end
  
  def wrong_argument_order?(user_cmd, correct_cmd)
    user_parts = user_cmd.split
    correct_parts = correct_cmd.split
    user_parts.sort == correct_parts.sort && user_cmd != correct_cmd
  end
  
  def similarity_score
    require 'text'
    distance = Text::Levenshtein.distance(@user_answer, @correct_answer)
    max_length = [@user_answer.length, @correct_answer.length].max
    return 1.0 if max_length == 0
    1.0 - (distance.to_f / max_length)
  rescue LoadError
    # Fallback if text gem not available
    0.5
  end
  
  def common_distractor?
    false # Placeholder
  end
end

