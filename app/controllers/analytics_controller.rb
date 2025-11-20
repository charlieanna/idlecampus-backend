class AnalyticsController < ApplicationController
  before_action :authenticate_user!
  
  def dashboard
    """Main analytics dashboard"""
    
    @skill_dimensions = UserSkillDimension.where(user: current_user)
    @weaknesses = detect_weaknesses
    @recent_activity = get_recent_activity
    @learning_stats = calculate_learning_stats
    @recommendations = generate_recommendations
    @exam_readiness = calculate_exam_readiness
    @certification_progress = get_certification_progress
    @remediation_stats = get_remediation_stats
  end
  
  def skill_radar_data
    """API endpoint for skill radar chart data"""
    
    dimensions = UserSkillDimension.where(user: current_user)
    
    data = {
      labels: [],
      datasets: [{
        label: 'Your Skills',
        data: [],
        backgroundColor: 'rgba(54, 162, 235, 0.2)',
        borderColor: 'rgb(54, 162, 235)',
        pointBackgroundColor: 'rgb(54, 162, 235)'
      }]
    }
    
    dimensions.each do |dim|
      data[:labels] << dim.dimension.titleize
      # Convert ability (-3 to +3) to 0-100 scale
      score = ((dim.ability_estimate + 3) / 6.0 * 100).round(1)
      data[:datasets][0][:data] << score
    end
    
    render json: data
  end
  
  def progress_timeline_data
    """API endpoint for progress timeline chart"""
    
    # Get daily snapshots or aggregate from events
    snapshots = DailyPerformanceSnapshot
      .where(user: current_user)
      .where('snapshot_date >= ?', 30.days.ago)
      .order(:snapshot_date)
    
    data = {
      labels: [],
      datasets: [{
        label: 'Overall Ability',
        data: [],
        borderColor: 'rgb(75, 192, 192)',
        tension: 0.1
      }]
    }
    
    snapshots.each do |snapshot|
      data[:labels] << snapshot.snapshot_date.strftime('%m/%d')
      overall = snapshot.skill_estimates['overall'] || 0.0
      data[:datasets][0][:data] << overall
    end
    
    # If no snapshots, generate from events
    if snapshots.empty?
      data = generate_timeline_from_events
    end
    
    render json: data
  end
  
  def weakness_analysis
    """Detailed weakness analysis page"""
    
    service = WeaknessDetectionService.new(current_user)
    @weaknesses = service.detect_weaknesses
    @study_plan = service.generate_study_plan
  end
  
  private
  
  def calculate_exam_readiness
    """Calculate readiness scores for each certification"""
    
    readiness = {}
    
    # DCA (Docker Certified Associate)
    dca_skills = ['docker_basics', 'docker_compose', 'networking']
    dca_scores = UserSkillDimension.where(user: current_user, dimension: dca_skills)
    if dca_scores.any?
      avg_ability = dca_scores.average(:ability_estimate) || 0
      # Convert -3 to +3 scale to 0-100%
      readiness['dca'] = {
        score: ((avg_ability + 3) / 6.0 * 100).round,
        status: get_readiness_status(avg_ability),
        recommendation: get_readiness_recommendation('dca', avg_ability)
      }
    end
    
    # CKAD
    ckad_skills = ['k8s_workloads', 'k8s_networking', 'k8s_basics']
    ckad_scores = UserSkillDimension.where(user: current_user, dimension: ckad_skills)
    if ckad_scores.any?
      avg_ability = ckad_scores.average(:ability_estimate) || 0
      readiness['ckad'] = {
        score: ((avg_ability + 3) / 6.0 * 100).round,
        status: get_readiness_status(avg_ability),
        recommendation: get_readiness_recommendation('ckad', avg_ability)
      }
    end
    
    # CKA
    cka_skills = ['k8s_basics', 'k8s_storage', 'k8s_security', 'k8s_networking']
    cka_scores = UserSkillDimension.where(user: current_user, dimension: cka_skills)
    if cka_scores.any?
      avg_ability = cka_scores.average(:ability_estimate) || 0
      readiness['cka'] = {
        score: ((avg_ability + 3) / 6.0 * 100).round,
        status: get_readiness_status(avg_ability),
        recommendation: get_readiness_recommendation('cka', avg_ability)
      }
    end
    
    readiness
  end
  
  def get_readiness_status(ability)
    case ability
    when 1.5..3.0
      'ready'
    when 0.5..1.5
      'almost_ready'
    when -0.5..0.5
      'progressing'
    else
      'needs_work'
    end
  end
  
  def get_readiness_recommendation(cert, ability)
    case cert
    when 'dca'
      if ability >= 1.5
        "You're ready! Take practice exams to maintain skills."
      elsif ability >= 0.5
        "Focus on Docker networking and security topics."
      else
        "Complete Docker Fundamentals course first."
      end
    when 'ckad'
      if ability >= 1.5
        "Schedule your exam! Practice with time pressure."
      elsif ability >= 0.5
        "Work on ConfigMaps, Secrets, and Services."
      else
        "Master pod creation and deployments first."
      end
    when 'cka'
      if ability >= 1.5
        "You're exam-ready! Focus on cluster troubleshooting."
      elsif ability >= 0.5
        "Study RBAC, storage, and networking in depth."
      else
        "Build stronger foundation with CKAD topics first."
      end
    end
  end
  
  def get_certification_progress
    """Get detailed progress for each certification track"""
    
    progress = {}
    
    # Get enrolled courses
    enrollments = current_user.course_enrollments.includes(:course)
    
    enrollments.each do |enrollment|
      course = enrollment.course
      cert_type = detect_certification_type(course)
      next unless cert_type
      
      progress[cert_type] = {
        course_name: course.title,
        completion: enrollment.completion_percentage,
        modules_completed: course.module_progresses.where(user: current_user, status: 'completed').count,
        total_modules: course.course_modules.published.count,
        estimated_days_remaining: estimate_days_remaining(enrollment),
        next_milestone: get_next_milestone(enrollment)
      }
    end
    
    progress
  end
  
  def detect_certification_type(course)
    title = course.title.downcase
    if title.include?('docker') || title.include?('dca')
      'dca'
    elsif title.include?('ckad')
      'ckad'
    elsif title.include?('cka') && !title.include?('ckad')
      'cka'
    elsif title.include?('cks')
      'cks'
    end
  end
  
  def estimate_days_remaining(enrollment)
    return nil unless enrollment.completion_percentage < 100
    
    # Calculate based on average progress rate
    days_enrolled = (Date.today - enrollment.created_at.to_date).to_i
    return nil if days_enrolled == 0 || enrollment.completion_percentage == 0
    
    rate_per_day = enrollment.completion_percentage.to_f / days_enrolled
    remaining_percentage = 100 - enrollment.completion_percentage
    
    (remaining_percentage / rate_per_day).ceil
  end
  
  def get_next_milestone(enrollment)
    # Find next incomplete module
    next_module = enrollment.course.course_modules
      .published
      .ordered
      .left_joins(:module_progresses)
      .where('module_progresses.user_id = ? OR module_progresses.id IS NULL', current_user.id)
      .where('module_progresses.status != ? OR module_progresses.id IS NULL', 'completed')
      .first
      
    next_module&.title
  end
  
  def detect_weaknesses
    """Detect user weaknesses"""
    service = WeaknessDetectionService.new(current_user)
    service.detect_weaknesses.first(5)
  end
  
  def get_recent_activity
    """Get recent learning activity"""
    
    LearningEvent
      .for_user(current_user.id)
      .recent
      .limit(10)
      .map do |event|
        {
          type: event.event_type,
          category: event.event_category,
          description: format_event_description(event),
          performance: event.performance_score,
          time: event.created_at
        }
      end
  end
  
  def calculate_learning_stats
    """Calculate overall learning statistics"""
    
    events = LearningEvent.for_user(current_user.id)
    
    {
      total_time_minutes: events.sum(:time_spent_seconds) / 60,
      quizzes_taken: events.by_type('quiz_completed').count,
      lessons_completed: events.by_type('lesson_completed').count,
      labs_completed: events.by_type('lab_completed').count,
      current_streak: calculate_streak,
      questions_answered: events.by_type('quiz_question_answered').count,
      average_accuracy: calculate_average_accuracy(events)
    }
  end
  
  def generate_recommendations
    """Generate content recommendations"""
    
    recommendations = []
    
    # Recommend based on weaknesses
    weaknesses = detect_weaknesses
    weaknesses.first(3).each do |weakness|
      lessons = CourseLesson.where("content LIKE ?", "%#{weakness[:topic]}%").limit(1)
      
      lessons.each do |lesson|
        recommendations << {
          type: 'lesson',
          item: lesson,
          reason: "Strengthen #{weakness[:topic]} (#{(weakness[:severity] * 100).round(0)}% weak)",
          priority: weakness[:severity]
        }
      end
    end
    
    # Recommend spaced repetition items
    due_items = SpacedRepetitionItem.where(user: current_user).due.limit(5)
    due_items.each do |item|
      recommendations << {
        type: 'review',
        item: item.reviewable,
        reason: "Review due",
        priority: 0.8
      }
    end
    
    recommendations.sort_by { |r| -r[:priority] }.first(5)
  end
  
  def calculate_streak
    """Calculate current learning streak in days"""
    
    # Get dates with activity
    active_dates = LearningEvent
      .for_user(current_user.id)
      .pluck(:created_at)
      .map { |t| t.to_date }
      .uniq
      .sort
      .reverse
    
    return 0 if active_dates.empty?
    
    streak = 1
    current_date = Date.today
    
    active_dates.each do |date|
      break if date < current_date - 1.day
      streak += 1 if date == current_date - 1.day
      current_date = date
    end
    
    streak
  end
  
  def calculate_average_accuracy(events)
    """Calculate average quiz accuracy"""
    
    quiz_events = events.by_type('quiz_question_answered')
    total = quiz_events.count
    return 0.0 if total == 0
    
    correct = quiz_events.where('performance_score > 0').count
    (correct.to_f / total * 100).round(1)
  end
  
  def format_event_description(event)
    """Format event for display"""
    
    case event.event_type
    when 'quiz_completed'
      "Completed #{event.event_data['quiz_title']} (#{event.performance_score * 100}%)"
    when 'lesson_completed'
      "Finished #{event.event_data['lesson_title']}"
    when 'lab_completed'
      "Completed lab: #{event.event_data['lab_title']} (#{event.performance_score * 100}%)"
    else
      event.event_type.humanize
    end
  end
  
  def generate_timeline_from_events
    """Generate timeline from learning events when no snapshots"""
    
    # Group events by day and calculate average performance
    events_by_day = LearningEvent
      .for_user(current_user.id)
      .where('created_at >= ?', 30.days.ago)
      .group_by { |e| e.created_at.to_date }
    
    data = {
      labels: [],
      datasets: [{
        label: 'Daily Performance',
        data: [],
        borderColor: 'rgb(75, 192, 192)',
        tension: 0.1
      }]
    }
    
    events_by_day.sort.each do |date, events|
      data[:labels] << date.strftime('%m/%d')
      avg_performance = events.map(&:performance_score).compact.sum / events.count.to_f
      data[:datasets][0][:data] << (avg_performance * 100).round(1)
    end
    
    data
  end
  
  def ability_to_level(ability)
    """Convert ability to level"""
    case ability
    when -Float::INFINITY..-0.5 then 'Beginner'
    when -0.5..0.5 then 'Intermediate'
    when 0.5..1.5 then 'Advanced'
    else 'Expert'
    end
  end
  
  def get_remediation_stats
    """Get remediation activity statistics"""
    service = RemediationTrackingService.new(current_user)
    stats = service.get_remediation_stats(period: :week)
    
    {
      total_activities: stats[:total_activities],
      lessons_reviewed: stats[:lessons_reviewed],
      unique_lessons: stats[:unique_lessons],
      improvement_rate: stats[:improvement_rate],
      most_reviewed_topics: stats[:most_reviewed_topics],
      recent_reviews: stats[:recent_reviews]
    }
  rescue => e
    Rails.logger.error "Error getting remediation stats: #{e.message}"
    {
      total_activities: 0,
      lessons_reviewed: 0,
      unique_lessons: 0,
      improvement_rate: 0.0,
      most_reviewed_topics: {},
      recent_reviews: []
    }
  end
end

