class WrongAnswerAnalyzer
  """
  Analyzes wrong answers and provides targeted feedback
  Classifies error types and recommends remediation
  """
  
  def initialize(question, user_answer, correct_answer)
    @question = question
    @user_answer = user_answer.to_s.strip
    @correct_answer = correct_answer.to_s.strip
  end
  
  def analyze
    """
    Returns:
      {
        error_type: string,
        feedback: { level_1, level_2, level_3, solution },
        hint: string,
        remediation: { type, content_ids, reason },
        similar_questions: array
      }
    """
    
    error_type = classify_error
    
    {
      error_type: error_type,
      feedback: generate_progressive_feedback(error_type),
      hint: generate_hint(error_type),
      remediation: generate_remediation(error_type),
      similar_questions: find_similar_questions(easier: true)
    }
  end
  
  private
  
  def classify_error
    """Classify the type of error"""
    
    case @question.question_type
    when 'command'
      classify_command_error
    when 'mcq'
      classify_mcq_error
    when 'true_false'
      'conceptual'
    when 'fill_blank'
      'incomplete_knowledge'
    else
      'unknown'
    end
  end
  
  def classify_command_error
    """Specific classification for command questions"""
    
    user_cmd = normalize_command(@user_answer)
    correct_cmd = normalize_command(@correct_answer)
    
    # Empty or very different
    return 'no_attempt' if user_cmd.blank?
    return 'wrong_command' if !same_base_command?(user_cmd, correct_cmd)
    
    # Has syntax errors
    return 'syntax_error' if has_syntax_error?(user_cmd)
    
    # Missing required flags
    return 'missing_flags' if missing_required_flags?(user_cmd, correct_cmd)
    
    # Wrong argument order
    return 'argument_order' if wrong_argument_order?(user_cmd, correct_cmd)
    
    # Very close (minor typo)
    return 'minor_error' if similarity_score > 0.7
    
    'conceptual'
  end
  
  def classify_mcq_error
    """Classify MCQ error by analyzing distractor chosen"""
    
    # If user selected a common misconception
    if common_distractor?
      'misconception'
    else
      'conceptual'
    end
  end
  
  def generate_progressive_feedback(error_type)
    """Generate three levels of hints plus solution"""
    
    feedback_templates = {
      'no_attempt' => {
        level_1: "Don't know where to start? Think about what you're trying to accomplish.",
        level_2: "Hint: This involves #{@question.topic&.titleize} operations.",
        level_3: "The command starts with: #{@correct_answer.split.first}",
        solution: @question.explanation
      },
      'wrong_command' => {
        level_1: "That command doesn't accomplish the task. Review what you need to do.",
        level_2: "Hint: You need a #{@question.topic} command, not #{extract_command(@user_answer)}.",
        level_3: "The correct command is: #{@correct_answer.split(' ').first(2).join(' ')}",
        solution: @question.explanation
      },
      'missing_flags' => {
        level_1: "You're close! Check if you're missing any required flags.",
        level_2: "Compare your command to the documentation. Are all required options present?",
        level_3: find_missing_flags_hint,
        solution: @question.explanation
      },
      'syntax_error' => {
        level_1: "Check your syntax - there's a formatting issue.",
        level_2: "Review: command [global-options] subcommand [options] [arguments]",
        level_3: "Common errors: missing quotes, wrong flag format (--flag vs -flag), typos",
        solution: @question.explanation
      },
      'misconception' => {
        level_1: "This is a common misconception. Think about #{@question.topic} more carefully.",
        level_2: "Review the core concept: #{@question.explanation&.split('.')&.first}",
        level_3: @question.explanation,
        solution: "Correct answer: #{@question.formatted_correct_answer}"
      },
      'conceptual' => {
        level_1: "Not quite right. Review the concept of #{@question.topic}.",
        level_2: @question.explanation&.split('.')&.first,
        level_3: @question.explanation,
        solution: "Correct answer: #{@question.formatted_correct_answer}"
      }
    }
    
    feedback_templates[error_type] || feedback_templates['conceptual']
  end
  
  def generate_hint(error_type)
    """Generate initial hint based on error type"""
    generate_progressive_feedback(error_type)[:level_1]
  end
  
  def generate_remediation(error_type)
    """Recommend remediation actions"""
    
    {
      type: 'review_content',
      content_ids: find_related_lessons,
      reason: "Review #{@question.topic} concepts to strengthen understanding",
      estimated_time_minutes: 10
    }
  end
  
  def find_similar_questions(easier: false)
    """Find similar questions for practice"""
    
    questions = QuizQuestion
      .where(topic: @question.topic)
      .where.not(id: @question.id)
      .limit(3)
    
    if easier
      questions = questions.where('difficulty < ?', @question.difficulty)
    end
    
    questions.map do |q|
      {
        id: q.id,
        text: q.question_text,
        difficulty: q.difficulty
      }
    end
  end
  
  def find_related_lessons
    """Find lessons related to this topic for review"""
    
    # Search for lessons mentioning this topic
    CourseLesson
      .where("content LIKE ?", "%#{@question.topic}%")
      .limit(2)
      .pluck(:id)
  end
  
  # ============================================
  # Command Analysis Helpers
  # ============================================
  
  def normalize_command(cmd)
    cmd.to_s.strip.squeeze(' ').downcase
  end
  
  def same_base_command?(user_cmd, correct_cmd)
    """Check if base command (first word) matches"""
    user_base = user_cmd.split.first
    correct_base = correct_cmd.split.first
    
    user_base == correct_base
  end
  
  def has_syntax_error?(cmd)
    """Detect common syntax errors"""
    
    # Unmatched quotes
    return true if cmd.count('"') % 2 != 0
    return true if cmd.count("'") % 2 != 0
    
    # Invalid flag format
    return true if cmd.match?(/--\s+\w/) # Space after --
    return true if cmd.match?(/-{3,}/) # Too many dashes
    
    false
  end
  
  def missing_required_flags?(user_cmd, correct_cmd)
    """Check if required flags are missing"""
    
    correct_flags = extract_flags(correct_cmd)
    user_flags = extract_flags(user_cmd)
    
    # Check if all required flags are present
    (correct_flags - user_flags).any?
  end
  
  def wrong_argument_order?(user_cmd, correct_cmd)
    """Check if arguments are in wrong order"""
    
    user_parts = user_cmd.split
    correct_parts = correct_cmd.split
    
    # Same parts but different order
    user_parts.sort == correct_parts.sort && user_cmd != correct_cmd
  end
  
  def extract_flags(cmd)
    """Extract flags from command"""
    cmd.scan(/--?[\w-]+/)
  end
  
  def extract_command(cmd)
    """Extract main command"""
    cmd.split.first || 'unknown'
  end
  
  def find_missing_flags_hint
    """Hint about missing flags"""
    user_flags = extract_flags(@user_answer)
    correct_flags = extract_flags(@correct_answer)
    missing = correct_flags - user_flags
    
    if missing.any?
      "Missing flags: #{missing.join(', ')}"
    else
      "Check flag values and arguments"
    end
  end
  
  def similarity_score
    """Calculate string similarity (0-1)"""
    require 'text'
    
    # Use Levenshtein distance
    distance = Text::Levenshtein.distance(@user_answer, @correct_answer)
    max_length = [@user_answer.length, @correct_answer.length].max
    
    return 1.0 if max_length == 0
    1.0 - (distance.to_f / max_length)
  end
  
  def common_distractor?
    """Check if user selected a known distractor"""
    
    return false unless @question.question_type == 'mcq'
    
    # In MCQ, check if selected option has common_mistake metadata
    selected_option = @question.options&.find { |opt| opt['text'] == @user_answer }
    selected_option&.dig('common_mistake') || false
  end
end

