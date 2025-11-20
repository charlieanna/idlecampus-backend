class ExamSimulationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_certification, only: [:start, :begin_exam]
  before_action :set_simulation, only: [:show, :submit, :result, :review]
  
  def index
    @certifications = {
      'dca' => {
        title: 'Docker Certified Associate (DCA)',
        duration: 90,
        questions: 55,
        passing_score: 65,
        description: 'Test your readiness for the DCA certification exam'
      },
      'ckad' => {
        title: 'Certified Kubernetes Application Developer (CKAD)',
        duration: 120,
        questions: 19,
        passing_score: 66,
        description: 'Performance-based exam simulation for CKAD'
      },
      'cka' => {
        title: 'Certified Kubernetes Administrator (CKA)',
        duration: 120,
        questions: 17,
        passing_score: 66,
        description: 'Hands-on simulation of CKA certification exam'
      },
      'gre' => {
        title: 'GRE Verbal Reasoning Practice Test',
        duration: 70,  # 2 sections × 35 minutes
        questions: 40, # 20 questions per section
        passing_score: 150, # 150/170 is competitive
        description: 'Full-length GRE Verbal Reasoning practice exam (scaled scoring 130-170)'
      }
    }

    @past_simulations = current_user.exam_simulations.includes(:questions).order(created_at: :desc).limit(5)
  end
  
  def start
    @past_attempts = current_user.exam_simulations
      .where(certification_type: @certification_type)
      .order(created_at: :desc)
      .limit(3)
  end
  
  def begin_exam
    # Create new exam simulation
    @simulation = current_user.exam_simulations.create!(
      certification_type: @certification_type,
      status: 'in_progress',
      started_at: Time.current,
      time_limit: @certification_info[:duration]
    )
    
    # Select appropriate questions
    questions = select_exam_questions(@certification_type, @certification_info[:questions])
    
    # Store questions in simulation
    @simulation.update!(question_ids: questions.map(&:id))
    
    # Store in session for timer
    session[:exam_simulation_id] = @simulation.id
    session[:exam_start_time] = Time.current.to_i
    
    redirect_to exam_simulation_path(@simulation)
  end
  
  def show
    # Check if time is up
    if @simulation.time_expired?
      @simulation.auto_submit!
      redirect_to result_exam_simulation_path(@simulation), 
        alert: "Time's up! Your exam has been automatically submitted."
      return
    end
    
    @questions = @simulation.questions
    @time_remaining = @simulation.time_remaining
    @current_answers = @simulation.answers || {}
  end
  
  def submit
    # Prevent multiple submissions
    if @simulation.status != 'in_progress'
      redirect_to result_exam_simulation_path(@simulation), 
        alert: 'This exam has already been submitted.'
      return
    end
    
    # Save all answers
    @simulation.answers = params[:answers] || {}
    @simulation.submitted_at = Time.current
    @simulation.time_taken = Time.current - @simulation.started_at
    
    # Calculate score
    calculate_simulation_score(@simulation)
    
    # Update status
    @simulation.status = 'completed'
    @simulation.save!
    
    # Clear session
    session.delete(:exam_simulation_id)
    session.delete(:exam_start_time)
    
    # Award progress points
    ProgressTrackingService.record_for_user(
      current_user,
      :quiz_completed,
      { score: @simulation.score, exam_simulation: true }
    )
    
    redirect_to result_exam_simulation_path(@simulation)
  end
  
  def result
    @questions = @simulation.questions
    @certification_info = certification_info(@simulation.certification_type)
    @passed = @simulation.passed?
    
    # Get performance breakdown
    @performance_breakdown = analyze_performance(@simulation)
    
    # Get readiness score
    @readiness_score = calculate_readiness_score
  end
  
  def review
    @questions = @simulation.questions
    @answers = @simulation.answers || {}
    @correct_answers = @simulation.correct_answers || {}
  end
  
  private
  
  def set_certification
    @certification_type = params[:certification_type]
    @certification_info = certification_info(@certification_type)
    
    unless @certification_info
      redirect_to exam_simulations_path, alert: 'Invalid certification type'
    end
  end
  
  def set_simulation
    @simulation = current_user.exam_simulations.find(params[:id])
  end
  
  def certification_info(type)
    {
      'dca' => {
        title: 'Docker Certified Associate',
        duration: 90,
        questions: 55,
        passing_score: 65
      },
      'ckad' => {
        title: 'CKAD',
        duration: 120,
        questions: 19,
        passing_score: 66
      },
      'cka' => {
        title: 'CKA',
        duration: 120,
        questions: 17,
        passing_score: 66
      },
      'gre' => {
        title: 'GRE Verbal Reasoning',
        duration: 70,
        questions: 40,
        passing_score: 150
      }
    }[type]
  end
  
  def select_exam_questions(certification_type, count)
    # Get questions based on certification exam blueprint
    case certification_type
    when 'dca'
      # Docker exam blueprint distribution
      questions = []
      questions += QuizQuestion.where(skill_dimension: 'docker_basics')
                              .where(difficulty_level: ['medium', 'hard'])
                              .order('RANDOM()').limit(15)
      questions += QuizQuestion.where(skill_dimension: 'docker_compose')
                              .order('RANDOM()').limit(10)
      questions += QuizQuestion.where(skill_dimension: 'networking')
                              .where("topic LIKE ?", '%docker%')
                              .order('RANDOM()').limit(15)
      # Fill remaining with general Docker questions
      remaining = count - questions.count
      questions += QuizQuestion.where("question_text LIKE ?", '%Docker%')
                              .where.not(id: questions.map(&:id))
                              .order('RANDOM()').limit(remaining)
    when 'ckad'
      # CKAD blueprint
      questions = []
      questions += QuizQuestion.where(skill_dimension: 'k8s_workloads')
                              .order('RANDOM()').limit(8)
      questions += QuizQuestion.where(skill_dimension: 'k8s_networking')
                              .order('RANDOM()').limit(6)
      questions += QuizQuestion.where(topic: ['configmap', 'secret', 'volume'])
                              .order('RANDOM()').limit(5)
    when 'cka'
      # CKA blueprint
      questions = []
      questions += QuizQuestion.where(skill_dimension: 'k8s_basics')
                              .where(difficulty_level: 'hard')
                              .order('RANDOM()').limit(7)
      questions += QuizQuestion.where(skill_dimension: 'k8s_security')
                              .order('RANDOM()').limit(5)
      questions += QuizQuestion.where(skill_dimension: 'k8s_storage')
                              .order('RANDOM()').limit(5)
    when 'gre'
      # GRE Verbal exam blueprint
      # Distribution: ~50% Reading Comp, ~30% Text Completion, ~20% Sentence Equivalence
      questions = []

      # Find the GRE Verbal course
      course = Course.find_by(slug: 'gre-verbal-reasoning')
      if course
        # Reading Comprehension: ~20 questions (50%)
        reading_module = course.course_modules.find_by(slug: 'reading-comprehension')
        if reading_module && reading_module.quiz
          questions += reading_module.quiz.quiz_questions
                               .order('RANDOM()').limit(20)
        end

        # Text Completion: ~12 questions (30%)
        text_comp_module = course.course_modules.find_by(slug: 'text-completion')
        if text_comp_module && text_comp_module.quiz
          questions += text_comp_module.quiz.quiz_questions
                               .order('RANDOM()').limit(12)
        end

        # Sentence Equivalence: ~8 questions (20%)
        sent_equiv_module = course.course_modules.find_by(slug: 'sentence-equivalence')
        if sent_equiv_module && sent_equiv_module.quiz
          questions += sent_equiv_module.quiz.quiz_questions
                               .order('RANDOM()').limit(8)
        end
      end

      # If we don't have enough questions, fill with any GRE questions
      if questions.count < count
        remaining = count - questions.count
        questions += QuizQuestion.where(skill_dimension: [
                                   'gre_reading_comprehension',
                                   'gre_text_completion',
                                   'gre_sentence_equivalence'
                                 ])
                                 .where.not(id: questions.map(&:id))
                                 .order('RANDOM()').limit(remaining)
      end
    end

    questions.first(count)
  end
  
  def calculate_simulation_score(simulation)
    questions = simulation.questions
    answers = simulation.answers || {}

    correct_count = 0
    correct_answers = {}

    questions.each do |question|
      user_answer = answers[question.id.to_s]
      is_correct = question.correct_answer?(user_answer)
      correct_count += 1 if is_correct
      correct_answers[question.id] = {
        correct: is_correct,
        user_answer: user_answer,
        correct_answer: question.correct_answer
      }
    end

    # Calculate score based on exam type
    if simulation.certification_type == 'gre'
      # GRE uses scaled scoring (130-170)
      percentage = (correct_count.to_f / questions.count * 100)
      score = GREScoreScalingService.percentage_to_gre_score(percentage)
    else
      # Other exams use percentage
      score = (correct_count.to_f / questions.count * 100).round(1)
    end

    simulation.update!(
      score: score,
      correct_count: correct_count,
      total_questions: questions.count,
      correct_answers: correct_answers,
      passed: score >= certification_info(simulation.certification_type)[:passing_score]
    )
  end
  
  def analyze_performance(simulation)
    # Analyze by skill dimension
    performance = Hash.new { |h, k| h[k] = { correct: 0, total: 0 } }
    
    simulation.questions.each do |question|
      dimension = question.skill_dimension || 'general'
      answer_data = simulation.correct_answers[question.id.to_s] || {}
      
      performance[dimension][:total] += 1
      performance[dimension][:correct] += 1 if answer_data['correct']
    end
    
    # Calculate percentages
    performance.transform_values do |data|
      {
        correct: data[:correct],
        total: data[:total],
        percentage: data[:total] > 0 ? (data[:correct].to_f / data[:total] * 100).round(1) : 0
      }
    end
  end
  
  def calculate_readiness_score
    # Calculate overall readiness based on multiple factors
    recent_simulations = current_user.exam_simulations
      .where(certification_type: @simulation.certification_type)
      .where('created_at > ?', 30.days.ago)
      .order(created_at: :desc)
      .limit(5)
    
    return @simulation.score if recent_simulations.count == 1
    
    # Average of recent scores with more weight on recent attempts
    weights = [1.0, 0.8, 0.6, 0.4, 0.2]
    weighted_sum = 0
    weight_total = 0
    
    recent_simulations.each_with_index do |sim, index|
      weighted_sum += sim.score * weights[index]
      weight_total += weights[index]
    end
    
    (weighted_sum / weight_total).round(1)
  end
end
