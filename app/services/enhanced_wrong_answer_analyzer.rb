class EnhancedWrongAnswerAnalyzer
  def initialize(quiz_attempt)
    @quiz_attempt = quiz_attempt
    @user = quiz_attempt.user
  end
  
  def analyze_and_recommend
    wrong_answers = get_wrong_answers
    
    {
      immediate_recommendations: generate_immediate_help(wrong_answers),
      lesson_mappings: find_relevant_lessons(wrong_answers),
      weakness_patterns: detect_patterns(wrong_answers),
      adaptive_quiz_config: generate_retry_config(wrong_answers)
    }
  end
  
  private
  
  def get_wrong_answers
    return [] unless @quiz_attempt.answers.is_a?(Hash)
    
    wrong = []
    @quiz_attempt.answers.each do |question_id, user_answer|
      question = QuizQuestion.find_by(id: question_id)
      next unless question
      
      unless question.correct_answer?(user_answer)
        wrong << {
          question: question,
          user_answer: user_answer,
          correct_answer: question.formatted_correct_answer,
          topic: question.topic,
          skill_dimension: question.skill_dimension
        }
      end
    end
    
    wrong
  end
  
  def generate_immediate_help(wrong_answers)
    wrong_answers.map do |wa|
      analyzer = WrongAnswerAnalyzer.new(wa[:question])
      analysis = analyzer.analyze(wa[:user_answer])
      
      {
        question_id: wa[:question].id,
        question_text: wa[:question].question_text,
        user_answer: wa[:user_answer],
        correct_answer: wa[:correct_answer],
        error_type: analysis[:error_type],
        feedback: analysis[:feedback],
        hint: analysis[:hint]
      }
    end
  end
  
  def find_relevant_lessons(wrong_answers)
    wrong_answers.map do |wa|
      mappings = wa[:question].quiz_question_lesson_mappings
                   .includes(:course_lesson)
                   .ordered_by_relevance
      
      {
        question_id: wa[:question].id,
        primary_lesson: format_lesson_mapping(mappings.first),
        additional_lessons: mappings.offset(1).limit(2).map { |m| format_lesson_mapping(m) },
        mini_lesson: generate_mini_lesson_content(wa)
      }
    end
  end
  
  def format_lesson_mapping(mapping)
    return nil unless mapping
    
    {
      lesson_id: mapping.course_lesson.id,
      lesson_title: mapping.course_lesson.title,
      section_anchor: mapping.section_anchor,
      section_title: mapping.section_title,
      url: mapping.lesson_url_with_anchor,
      relevance_weight: mapping.relevance_weight
    }
  end
  
  def generate_mini_lesson_content(wrong_answer)
    question = wrong_answer[:question]
    topic = question.topic
    
    # Generate a quick mini-lesson based on the topic
    case topic
    when /pod|container/i
      {
        title: "Understanding #{topic}",
        content: "A #{topic} is a fundamental concept in Kubernetes...",
        key_points: [
          "Pods are the smallest deployable units",
          "Containers run inside pods",
          "Each pod has a unique IP address"
        ]
      }
    when /deployment|replicaset/i
      {
        title: "Understanding #{topic}",
        content: "#{topic.capitalize} manages pod replicas and updates...",
        key_points: [
          "Deployments manage ReplicaSets",
          "ReplicaSets ensure desired number of pods",
          "Rolling updates are handled automatically"
        ]
      }
    when /service|networking/i
      {
        title: "Understanding #{topic}",
        content: "Kubernetes Services enable network access to pods...",
        key_points: [
          "Services provide stable endpoints",
          "ClusterIP, NodePort, and LoadBalancer types",
          "Selectors match pods by labels"
        ]
      }
    else
      {
        title: "Key Concept: #{topic}",
        content: "Let's review the key concepts related to #{topic}.",
        key_points: [
          "Review the official documentation",
          "Practice with hands-on labs",
          "Ask questions in the community"
        ]
      }
    end
  end
  
  def detect_patterns(wrong_answers)
    patterns = {
      topics_struggling: {},
      skill_dimensions_weak: {},
      question_types_difficult: {},
      overall_weakness: nil
    }
    
    # Count mistakes by topic
    wrong_answers.each do |wa|
      topic = wa[:topic] || 'general'
      skill = wa[:skill_dimension] || 'general'
      question_type = wa[:question].question_type
      
      patterns[:topics_struggling][topic] ||= 0
      patterns[:topics_struggling][topic] += 1
      
      patterns[:skill_dimensions_weak][skill] ||= 0
      patterns[:skill_dimensions_weak][skill] += 1
      
      patterns[:question_types_difficult][question_type] ||= 0
      patterns[:question_types_difficult][question_type] += 1
    end
    
    # Identify primary weakness
    if patterns[:topics_struggling].any?
      primary_topic = patterns[:topics_struggling].max_by { |_, count| count }
      patterns[:overall_weakness] = {
        type: 'topic',
        name: primary_topic[0],
        count: primary_topic[1],
        percentage: (primary_topic[1].to_f / wrong_answers.count * 100).round(1)
      }
    end
    
    patterns
  end
  
  def generate_retry_config(wrong_answers)
    weak_topics = detect_patterns(wrong_answers)[:topics_struggling].keys
    weak_skills = detect_patterns(wrong_answers)[:skill_dimensions_weak].keys
    
    {
      focus_ratio: calculate_focus_ratio(wrong_answers.count),
      target_topics: weak_topics,
      target_skills: weak_skills,
      difficulty_adjustment: calculate_difficulty_adjustment,
      recommended_question_count: @quiz_attempt.quiz.quiz_questions.count
    }
  end
  
  def calculate_focus_ratio(wrong_count)
    # More mistakes = higher focus on weak areas
    case wrong_count
    when 0..2
      0.5  # 50% focused
    when 3..5
      0.7  # 70% focused
    else
      0.8  # 80% focused
    end
  end
  
  def calculate_difficulty_adjustment
    score = @quiz_attempt.score
    
    case score
    when 0..40
      -0.5  # Make easier
    when 41..60
      -0.2  # Slightly easier
    when 61..75
      0.0   # Same difficulty
    else
      0.1   # Slightly harder
    end
  end
end
