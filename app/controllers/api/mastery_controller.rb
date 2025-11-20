class Api::MasteryController < ApplicationController
  before_action :authenticate_user!, except: [:lesson_reviews]
  skip_before_action :verify_authenticity_token, only: [:lesson_reviews]
  
  # GET /api/mastery/decay_visualization
  def decay_visualization
    time_range = params[:time_range]&.to_i || 30
    
    timeline_data = MasteryDecayService.generate_user_decay_timeline(
      current_user.id, 
      time_range
    )
    
    render json: {
      decay_timeline: timeline_data,
      summary: generate_decay_summary,
      time_range: time_range
    }
  end
  
  # POST /api/mastery/request_stealth_review
  def request_stealth_review
    canonical_command = params[:canonical_command]
    
    unless canonical_command.present?
      render json: { error: 'canonical_command is required' }, status: :bad_request
      return
    end
    
    generator = StealthReviewGenerator.new(user_id: current_user.id)
    success = generator.queue_stealth_review(canonical_command)
    
    if success
      render json: { 
        success: true, 
        message: 'Stealth review queued successfully',
        canonical_command: canonical_command
      }
    else
      render json: { 
        success: false, 
        error: 'Failed to queue stealth review - command not found or already queued' 
      }, status: :unprocessable_entity
    end
  end
  
  # POST /api/mastery/track_attempt
  # Track a terminal command attempt with context
  def track_attempt
    command = params[:command]
    success = params[:success]
    context = params[:context] || 'practice'
    time_taken = params[:time_taken]
    attempt_number = params[:attempt_number] || 1
    hints_used = params[:hints_used] || 0
    saw_answer = params[:saw_answer] || false
    expected_command = params[:expected_command]

    unless command.present?
      render json: { success: false, error: 'command is required' }, status: :bad_request
      return
    end

    # Build attempt context for MasteryCalculator
    attempt_context = {
      attempt_number: attempt_number,
      time_taken: time_taken,
      hints_used: hints_used,
      saw_answer: saw_answer,
      previous_failures: attempt_number - 1,
      first_try: attempt_number == 1
    }

    # Record attempt using MasteryTrackingService
    tracking_service = MasteryTrackingService.new(current_user)
    mastery = tracking_service.record_attempt(
      command: command,
      success: success,
      context: context
    )

    if mastery
      # Apply context-aware scoring
      if success
        MasteryCalculator.update_on_success!(mastery, attempt_context)
      else
        MasteryCalculator.update_on_failure!(mastery, attempt_context)
      end

      # Calculate current decay score
      decay_service = MasteryDecayService.new(mastery)
      current_score = decay_service.current_decayed_score

      # Check if needs review (below 80%)
      needs_review = current_score < 80.0

      # Auto-schedule stealth review if struggling (3+ failures)
      if mastery.consecutive_failures >= 3
        generator = StealthReviewGenerator.new(user_id: current_user.id)
        generator.queue_stealth_review(mastery.canonical_command, priority: 8)
      end

      render json: {
        success: true,
        mastery: {
          canonical_command: mastery.canonical_command,
          proficiency_score: mastery.proficiency_score.to_f,
          current_score: current_score,
          total_attempts: mastery.total_attempts,
          successful_attempts: mastery.successful_attempts,
          consecutive_successes: mastery.consecutive_successes,
          consecutive_failures: mastery.consecutive_failures,
          mastered: mastery.mastered?,
          needs_practice: mastery.needs_practice?,
          needs_review: needs_review,
          shield_level: mastery.shield_level
        }
      }
    else
      render json: {
        success: false,
        error: 'Failed to track command attempt'
      }, status: :unprocessable_entity
    end
  rescue => e
    Rails.logger.error "Error tracking command attempt: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    render json: {
      success: false,
      error: e.message
    }, status: :internal_server_error
  end

  # GET /api/mastery/stealth_reviews
  def stealth_reviews
    reviews = StealthReview.where(user_id: current_user.id)
                          .includes(:user)
                          .order(created_at: :desc)
                          .limit(50)
    
    render json: {
      reviews: reviews.map { |review| serialize_stealth_review(review) },
      stats: calculate_stealth_review_stats(reviews)
    }
  end
  
  # GET /api/mastery/decay_analysis/:canonical_command
  def decay_analysis
    canonical_command = params[:canonical_command]
    mastery = current_user.user_command_masteries
                         .find_by(canonical_command: canonical_command)
    
    unless mastery
      render json: { error: 'Command mastery not found' }, status: :not_found
      return
    end
    
    decay_service = MasteryDecayService.new(mastery)
    
    render json: {
      canonical_command: canonical_command,
      current_score: mastery.proficiency_score,
      decayed_score: decay_service.current_decayed_score,
      decay_curve: decay_service.generate_decay_curve(30),
      risk_threshold_breach: decay_service.predict_risk_threshold_breach,
      review_timing: decay_service.suggest_review_timing,
      strength_factor: decay_service.send(:calculate_strength_factor),
      protected_by_shield: decay_service.protected_by_shield?
    }
  end
  
  # GET /api/mastery/commands_at_risk
  def commands_at_risk
    risk_threshold = params[:threshold]&.to_i || 80
    
    at_risk_commands = current_user.user_command_masteries
                                  .includes(:shields)
                                  .select do |mastery|
      decay_service = MasteryDecayService.new(mastery)
      decay_service.current_decayed_score < risk_threshold
    end
    
    commands_data = at_risk_commands.map do |mastery|
      decay_service = MasteryDecayService.new(mastery)
      current_score = decay_service.current_decayed_score
      
      {
        canonical_command: mastery.canonical_command,
        original_score: mastery.proficiency_score,
        current_score: current_score,
        risk_level: determine_risk_level(current_score),
        days_since_practice: days_since_practice(mastery),
        review_urgency: decay_service.suggest_review_timing,
        protected_by_shield: decay_service.protected_by_shield?,
        contexts_seen: mastery.contexts_seen&.size || 0,
        success_rate: calculate_success_rate(mastery)
      }
    end
    
    render json: {
      commands_at_risk: commands_data.sort_by { |cmd| cmd[:current_score] },
      risk_threshold: risk_threshold,
      total_commands: current_user.user_command_masteries.count,
      at_risk_count: commands_data.size
    }
  end
  
  # POST /api/mastery/apply_decay_batch
  def apply_decay_batch
    # Apply decay calculations to all user masteries
    masteries = current_user.user_command_masteries.includes(:shields)
    updated_count = 0

    masteries.each do |mastery|
      decay_service = MasteryDecayService.new(mastery)
      old_score = mastery.proficiency_score
      new_score = decay_service.apply_decay!

      updated_count += 1 if new_score < old_score
    end

    render json: {
      success: true,
      updated_count: updated_count,
      total_masteries: masteries.count,
      timestamp: Time.current.iso8601
    }
  end

  # GET /api/mastery/lesson_reviews
  # Get pending reviews for current lesson
  # Handles both database CourseLesson and YAML microlessons
  def lesson_reviews
    lesson_id = params[:lesson_id]
    module_id = params[:module_id]

    unless lesson_id.present?
      render json: { success: false, error: 'lesson_id is required' }, status: :bad_request
      return
    end

    lesson_id_str = lesson_id.to_s
    
    # Try to find database lesson by ID (numeric) first, then by slug
    lesson = if lesson_id_str.match?(/^\d+$/)
      CourseLesson.find_by(id: lesson_id)
    else
      # Try by slug
      CourseLesson.find_by(slug: lesson_id_str)
    end

    # If no lesson found in database, it's likely a YAML microlesson
    # Return no reviews gracefully (reviews only work for database lessons)
    unless lesson
      render json: {
        success: true,
        has_reviews: false,
        message: 'Reviews not available for this lesson'
      }
      return
    end

    # If user is not authenticated, return no reviews
    # Check if current_user exists (set by authenticate_user! if authenticated)
    unless current_user
      render json: {
        success: true,
        has_reviews: false,
        message: 'Authentication required for reviews'
      }
      return
    end

    # Generate review insertion for this lesson
    inserter = LessonReviewInserter.new(current_user, lesson, module_context: module_id)
    review_data = inserter.generate_review_insertion

    if review_data
      # Mark reviews as shown
      pending_reviews = inserter.pending_reviews_for_lesson
      pending_reviews.each { |review| inserter.mark_review_shown(review) }

      render json: {
        success: true,
        has_reviews: true,
        reviews: review_data[:content],
        strategy: review_data[:strategy],
        insertion_point: review_data[:insertion_point],
        priority: review_data[:priority]
      }
    else
      render json: {
        success: true,
        has_reviews: false,
        message: 'No reviews needed for this lesson'
      }
    end
  rescue => e
    Rails.logger.error "Error fetching lesson reviews: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    render json: {
      success: true,
      has_reviews: false,
      message: 'Error loading reviews'
    }
  end

  # POST /api/mastery/complete_review
  # Mark a stealth review as completed
  def complete_review
    canonical_command = params[:canonical_command]
    success = params[:success]
    response_time = params[:response_time]

    unless canonical_command.present?
      render json: { success: false, error: 'canonical_command is required' }, status: :bad_request
      return
    end

    # Find the in-progress review
    review = StealthReview.where(user: current_user)
                         .where(canonical_command: canonical_command)
                         .where(status: ['scheduled', 'in_progress'])
                         .order(scheduled_for: :desc)
                         .first

    unless review
      render json: { success: false, error: 'Review not found' }, status: :not_found
      return
    end

    # Update review status
    review.update(
      status: 'completed',
      completed_at: Time.current,
      success: success,
      response_time: response_time
    )

    # Update mastery tracking
    tracking_service = MasteryTrackingService.new(current_user)
    mastery = tracking_service.record_attempt(
      command: canonical_command,
      success: success,
      context: 'stealth_review'
    )

    # Update FSRS based on review performance
    if mastery
      spaced_rep_item = SpacedRepetitionItem.find_or_initialize_by(
        user: current_user,
        reviewable_type: 'UserCommandMastery',
        reviewable_id: mastery.id
      )

      # Determine FSRS grade based on success and response time
      grade = determine_fsrs_grade(success, response_time)

      # Schedule next review
      fsrs_service = SpacedRepetitionService.new(current_user)
      next_review = fsrs_service.schedule_review(
        spaced_rep_item,
        grade,
        Time.current
      )

      render json: {
        success: true,
        review_completed: true,
        mastery: {
          canonical_command: mastery.canonical_command,
          proficiency_score: mastery.proficiency_score.to_f,
          consecutive_successes: mastery.consecutive_successes,
          consecutive_failures: mastery.consecutive_failures
        },
        next_review: {
          scheduled_at: next_review[:next_review_at],
          interval_days: next_review[:interval]
        }
      }
    else
      render json: {
        success: false,
        error: 'Failed to update mastery'
      }, status: :unprocessable_entity
    end
  rescue => e
    Rails.logger.error "Error completing review: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    render json: {
      success: false,
      error: e.message
    }, status: :internal_server_error
  end

  # GET /api/mastery/check_gate
  # Check if user can progress past current lesson
  def check_gate
    lesson_id = params[:lesson_id]

    unless lesson_id.present?
      render json: { success: false, error: 'lesson_id is required' }, status: :bad_request
      return
    end

    lesson = CourseLesson.find_by(id: lesson_id)
    unless lesson
      render json: { success: false, error: 'Lesson not found' }, status: :not_found
      return
    end

    gate_service = RemediationGateService.new(current_user, lesson)
    status = gate_service.progression_status

    render json: {
      success: true,
      can_progress: status[:can_progress],
      gate_status: status,
      drill_session: status[:can_progress] ? nil : gate_service.generate_drill_session
    }
  rescue => e
    Rails.logger.error "Error checking gate: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    render json: {
      success: false,
      error: e.message
    }, status: :internal_server_error
  end

  # POST /api/mastery/generate_drill_session
  # Generate personalized drill session for weak commands
  def generate_drill_session
    lesson_id = params[:lesson_id]
    session_type = params[:session_type] || 'remediation'

    case session_type
    when 'remediation'
      # Generate drills for specific lesson gate
      unless lesson_id.present?
        render json: { success: false, error: 'lesson_id is required for remediation' }, status: :bad_request
        return
      end

      lesson = CourseLesson.find_by(id: lesson_id)
      unless lesson
        render json: { success: false, error: 'Lesson not found' }, status: :not_found
        return
      end

      gate_service = RemediationGateService.new(current_user, lesson)
      session = gate_service.generate_drill_session

    when 'quick'
      # Generate quick practice session (3-5 drills)
      session = DrillGenerator.generate_quick_session(current_user)

    when 'targeted'
      # Generate drills for specific mastery level
      level = params[:level] || 'intermediate'
      session = DrillGenerator.generate_for_mastery_level(current_user, level)

    when 'focused'
      # Generate drill for single command
      canonical_command = params[:canonical_command]
      unless canonical_command.present?
        render json: { success: false, error: 'canonical_command is required for focused' }, status: :bad_request
        return
      end

      drill = DrillGenerator.generate_focused_drill(current_user, canonical_command)
      session = {
        session_id: SecureRandom.uuid,
        drills: [drill],
        total_drills: 1,
        session_type: 'focused'
      }

    else
      render json: { success: false, error: 'Invalid session_type' }, status: :bad_request
      return
    end

    if session.nil? || session[:drills].empty?
      render json: {
        success: true,
        has_drills: false,
        message: 'No drills needed - all commands are mastered!'
      }
    else
      render json: {
        success: true,
        has_drills: true,
        session: session
      }
    end
  rescue => e
    Rails.logger.error "Error generating drill session: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    render json: {
      success: false,
      error: e.message
    }, status: :internal_server_error
  end

  # POST /api/mastery/complete_drill
  # Mark a drill as completed and update mastery
  def complete_drill
    drill_id = params[:drill_id]
    canonical_command = params[:canonical_command]
    success = params[:success]
    response_time = params[:response_time]
    attempts_used = params[:attempts_used] || 1

    unless canonical_command.present?
      render json: { success: false, error: 'canonical_command is required' }, status: :bad_request
      return
    end

    # Build attempt context
    attempt_context = {
      attempt_number: attempts_used,
      time_taken: response_time,
      hints_used: params[:hints_used] || 0,
      saw_answer: params[:saw_answer] || false,
      context_type: 'drill'
    }

    # Update mastery tracking
    tracking_service = MasteryTrackingService.new(current_user)
    mastery = tracking_service.record_attempt(
      command: canonical_command,
      success: success,
      context: 'drill'
    )

    if mastery
      # Apply context-aware scoring
      if success
        MasteryCalculator.update_on_success!(mastery, attempt_context)
      else
        MasteryCalculator.update_on_failure!(mastery, attempt_context)
      end

      # Calculate current status
      decay_service = MasteryDecayService.new(mastery)
      current_score = decay_service.current_decayed_score

      render json: {
        success: true,
        drill_completed: true,
        mastery: {
          canonical_command: mastery.canonical_command,
          proficiency_score: mastery.proficiency_score.to_f,
          current_score: current_score,
          mastered: current_score >= 80.0,
          total_attempts: mastery.total_attempts
        }
      }
    else
      render json: {
        success: false,
        error: 'Failed to update mastery'
      }, status: :unprocessable_entity
    end
  rescue => e
    Rails.logger.error "Error completing drill: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    render json: {
      success: false,
      error: e.message
    }, status: :internal_server_error
  end

  # POST /api/mastery/pass_gate
  # Mark a gate as passed (for analytics)
  def pass_gate
    lesson_id = params[:lesson_id]

    unless lesson_id.present?
      render json: { success: false, error: 'lesson_id is required' }, status: :bad_request
      return
    end

    lesson = CourseLesson.find_by(id: lesson_id)
    unless lesson
      render json: { success: false, error: 'Lesson not found' }, status: :not_found
      return
    end

    gate_service = RemediationGateService.new(current_user, lesson)

    unless gate_service.can_progress?
      render json: {
        success: false,
        error: 'Cannot pass gate - requirements not met'
      }, status: :unprocessable_entity
      return
    end

    gate_service.mark_gate_passed!

    render json: {
      success: true,
      gate_passed: true,
      message: 'Congratulations! You can now proceed to the next lesson.'
    }
  rescue => e
    Rails.logger.error "Error passing gate: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    render json: {
      success: false,
      error: e.message
    }, status: :internal_server_error
  end

  private

  def determine_fsrs_grade(success, response_time)
    return :again unless success

    # Grade based on response time
    case response_time
    when 0...3000 then :easy      # < 3 seconds = easy
    when 3000...8000 then :good   # 3-8 seconds = good
    when 8000...15000 then :hard  # 8-15 seconds = hard
    else :hard                     # > 15 seconds = hard
    end
  end
  
  def generate_decay_summary
    masteries = current_user.user_command_masteries.includes(:shields)
    
    total_commands = masteries.count
    return { total_commands: 0 } if total_commands == 0
    
    mastered_count = 0
    decaying_count = 0
    at_risk_count = 0
    protected_count = 0
    
    masteries.each do |mastery|
      decay_service = MasteryDecayService.new(mastery)
      current_score = decay_service.current_decayed_score
      
      if decay_service.protected_by_shield?
        protected_count += 1
      end
      
      case current_score
      when 100..Float::INFINITY
        mastered_count += 1
      when 80...100
        decaying_count += 1
      else
        at_risk_count += 1
      end
    end
    
    {
      total_commands: total_commands,
      mastered: mastered_count,
      decaying: decaying_count,
      at_risk: at_risk_count,
      protected: protected_count
    }
  end
  
  def serialize_stealth_review(review)
    {
      id: review.id,
      canonical_command: review.canonical_command,
      status: review.status,
      priority: review.priority,
      strategy: review.strategy,
      requested_at: review.requested_at,
      scheduled_for: review.scheduled_for,
      completed_at: review.completed_at,
      success: review.success,
      response_time: review.response_time,
      stealth_level: review.stealth_level
    }
  end
  
  def calculate_stealth_review_stats(reviews)
    completed_reviews = reviews.select(&:completed?)
    
    return { total: 0 } if completed_reviews.empty?
    
    {
      total: reviews.count,
      completed: completed_reviews.count,
      success_rate: completed_reviews.count(&:success?) / completed_reviews.count.to_f,
      average_response_time: completed_reviews.filter_map(&:response_time).sum / completed_reviews.count.to_f,
      queued: reviews.count { |r| r.status == 'queued' },
      scheduled: reviews.count { |r| r.status == 'scheduled' }
    }
  end
  
  def determine_risk_level(score)
    case score
    when 90..Float::INFINITY then 'safe'
    when 70...90 then 'watch'
    when 50...70 then 'risk'
    else 'critical'
    end
  end
  
  def days_since_practice(mastery)
    return 0 unless mastery.last_practiced_at
    ((Time.current - mastery.last_practiced_at) / 1.day).round
  end
  
  def calculate_success_rate(mastery)
    return 0 if mastery.total_attempts == 0
    (mastery.successful_attempts.to_f / mastery.total_attempts * 100).round(1)
  end
end