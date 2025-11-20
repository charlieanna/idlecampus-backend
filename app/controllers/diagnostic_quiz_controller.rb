class DiagnosticQuizController < ApplicationController
  before_action :authenticate_user!
  
  def start
    """Initial skill assessment for new users"""
    
    # Check if user has already taken diagnostic
    if current_user.diagnostic_completed?
      redirect_to dashboard_path, notice: "You've already completed the diagnostic assessment."
      return
    end
    
    # Get diagnostic questions across different skill areas
    @questions = get_diagnostic_questions
    @total_questions = @questions.count
    
    # Store questions in session
    session[:diagnostic_questions] = @questions.map(&:id)
    session[:diagnostic_answers] = {}
    session[:diagnostic_start_time] = Time.current.to_i
  end
  
  def answer
    """Submit answer for current diagnostic question"""
    
    question_id = params[:question_id].to_i
    answer = params[:answer]
    
    # Store answer
    session[:diagnostic_answers] ||= {}
    session[:diagnostic_answers][question_id.to_s] = answer
    
    # Get next question or complete
    remaining_questions = session[:diagnostic_questions] - session[:diagnostic_answers].keys.map(&:to_i)
    
    if remaining_questions.any?
      @next_question = QuizQuestion.find(remaining_questions.first)
      @current_index = session[:diagnostic_answers].count + 1
      @total_questions = session[:diagnostic_questions].count
      @progress = (@current_index.to_f / @total_questions * 100).round
      
      render :next_question
    else
      redirect_to evaluate_diagnostic_quiz_path
    end
  end
  
  def evaluate
    """Evaluate diagnostic results and recommend learning path"""
    
    # Calculate results
    results = calculate_diagnostic_results
    
    # Determine skill level
    @skill_level = determine_skill_level(results[:overall_score])
    @recommended_course = recommend_starting_course(@skill_level, results[:skill_breakdown])
    
    # Store diagnostic completion
    current_user.update!(
      diagnostic_completed: true,
      diagnostic_skill_level: @skill_level,
      diagnostic_score: results[:overall_score]
    )
    
    # Generate personalized learning path
    @learning_path = generate_learning_path(@skill_level, results[:skill_breakdown])
    
    # Award points for completing diagnostic
    ProgressTrackingService.record_for_user(
      current_user,
      :achievement_earned,
      { achievement: 'diagnostic_complete' }
    )
    
    # Clear session data
    session.delete(:diagnostic_questions)
    session.delete(:diagnostic_answers)
    session.delete(:diagnostic_start_time)
    
    @results = results
  end
  
  private
  
  def get_diagnostic_questions
    """Get a balanced set of diagnostic questions"""
    
    # Get questions from different skill areas and difficulties
    questions = []
    
    # Docker basics (5 questions)
    questions += QuizQuestion
      .where(skill_dimension: 'docker_basics')
      .where(difficulty_level: ['easy', 'medium'])
      .order('RANDOM()')
      .limit(5)
    
    # Kubernetes basics (5 questions)
    questions += QuizQuestion
      .where(skill_dimension: ['k8s_basics', 'k8s_workloads'])
      .where(difficulty_level: ['easy', 'medium'])
      .order('RANDOM()')
      .limit(5)
    
    # Networking (3 questions)
    questions += QuizQuestion
      .where(skill_dimension: 'networking')
      .where(difficulty_level: 'easy')
      .order('RANDOM()')
      .limit(3)
    
    # Security (2 questions)
    questions += QuizQuestion
      .where(skill_dimension: 'k8s_security')
      .where(difficulty_level: 'easy')
      .order('RANDOM()')
      .limit(2)
    
    # General/mixed (5 questions)
    questions += QuizQuestion
      .where(difficulty_level: 'medium')
      .where.not(id: questions.map(&:id))
      .order('RANDOM()')
      .limit(5)
    
    questions.shuffle
  end
  
  def calculate_diagnostic_results
    """Calculate diagnostic quiz results"""
    
    answers = session[:diagnostic_answers] || {}
    questions = QuizQuestion.where(id: session[:diagnostic_questions])
    
    correct_count = 0
    skill_scores = Hash.new { |h, k| h[k] = { correct: 0, total: 0 } }
    
    questions.each do |question|
      user_answer = answers[question.id.to_s]
      is_correct = question.correct_answer?(user_answer)
      
      correct_count += 1 if is_correct
      
      # Track by skill dimension
      dimension = question.skill_dimension || 'general'
      skill_scores[dimension][:total] += 1
      skill_scores[dimension][:correct] += 1 if is_correct
    end
    
    overall_score = (correct_count.to_f / questions.count * 100).round(1)
    
    # Calculate skill breakdown
    skill_breakdown = {}
    skill_scores.each do |dimension, scores|
      skill_breakdown[dimension] = (scores[:correct].to_f / scores[:total] * 100).round(1)
    end
    
    {
      overall_score: overall_score,
      correct_count: correct_count,
      total_questions: questions.count,
      skill_breakdown: skill_breakdown,
      time_taken: Time.current.to_i - (session[:diagnostic_start_time] || Time.current.to_i)
    }
  end
  
  def determine_skill_level(score)
    """Determine user's skill level based on diagnostic score"""
    
    case score
    when 0..30
      'beginner'
    when 31..50
      'novice'
    when 51..70
      'intermediate'
    when 71..85
      'advanced'
    else
      'expert'
    end
  end
  
  def recommend_starting_course(skill_level, skill_breakdown)
    """Recommend starting course based on skill level"""
    
    docker_score = skill_breakdown['docker_basics'] || 0
    k8s_scores = [
      skill_breakdown['k8s_basics'] || 0,
      skill_breakdown['k8s_workloads'] || 0
    ].max
    
    case skill_level
    when 'beginner', 'novice'
      Course.find_by(slug: 'docker-fundamentals')
    when 'intermediate'
      if docker_score > 60 && k8s_scores < 40
        Course.find_by(title: 'CKAD: Certified Kubernetes Application Developer')
      else
        Course.find_by(slug: 'docker-fundamentals')
      end
    when 'advanced', 'expert'
      if k8s_scores > 70
        Course.find_by(title: 'CKA: Certified Kubernetes Administrator')
      else
        Course.find_by(title: 'CKAD: Certified Kubernetes Application Developer')
      end
    end
  end
  
  def generate_learning_path(skill_level, skill_breakdown)
    """Generate personalized learning path"""
    
    path = []
    
    # Identify weak areas
    weak_areas = skill_breakdown.select { |_, score| score < 60 }
    
    case skill_level
    when 'beginner', 'novice'
      path << { 
        title: "Complete Docker Fundamentals",
        description: "Build a solid foundation with containers",
        course_id: Course.find_by(slug: 'docker-fundamentals')&.id,
        estimated_days: 14
      }
      path << {
        title: "Practice with 10 Docker labs",
        description: "Get hands-on experience with Docker commands",
        type: 'labs',
        count: 10
      }
      path << {
        title: "Take Docker certification mock exam",
        description: "Test your readiness for DCA",
        type: 'mock_exam'
      }
    when 'intermediate'
      if weak_areas.key?('networking')
        path << {
          title: "Focus on Networking concepts",
          description: "Study Docker networks and Kubernetes services",
          focus_area: 'networking'
        }
      end
      path << {
        title: "Start CKAD preparation",
        description: "Move to Kubernetes application development",
        course_id: Course.find_by(title: 'CKAD: Certified Kubernetes Application Developer')&.id,
        estimated_days: 21
      }
    else
      path << {
        title: "Advanced Kubernetes Administration",
        description: "Prepare for CKA certification",
        course_id: Course.find_by(title: 'CKA: Certified Kubernetes Administrator')&.id
      }
    end
    
    # Add practice recommendations
    path << {
      title: "Daily adaptive practice",
      description: "Complete 10 questions daily to reinforce learning",
      type: 'adaptive_practice',
      daily_target: 10
    }
    
    path
  end
end
