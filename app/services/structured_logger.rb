class StructuredLogger
  """
  Structured logging with trace IDs for correlation across services
  """
  
  def self.log_event(category:, action:, context: {}, level: :info)
    """
    Log a structured event
    
    Args:
      category: 'adaptive', 'quiz', 'lab', 'api', etc.
      action: 'question_selected', 'answer_submitted', etc.
      context: hash of relevant data
      level: :info, :warn, :error
    """
    
    trace_id = Thread.current[:trace_id] || SecureRandom.uuid
    
    log_data = {
      timestamp: Time.current.iso8601(3),
      trace_id: trace_id,
      category: category,
      action: action,
      **context
    }
    
    log_message = log_data.to_json
    
    case level
    when :error
      Rails.logger.error(log_message)
    when :warn
      Rails.logger.warn(log_message)
    else
      Rails.logger.info(log_message)
    end
    
    log_data
  end
  
  def self.with_trace_id(trace_id = nil)
    """Execute block with trace ID"""
    
    trace_id ||= SecureRandom.uuid
    Thread.current[:trace_id] = trace_id
    
    yield trace_id
  ensure
    Thread.current[:trace_id] = nil
  end
  
  # ============================================
  # Convenience Methods
  # ============================================
  
  def self.log_adaptive_selection(user_id:, question_id:, difficulty:, reason:, using_fallback:)
    log_event(
      category: 'adaptive',
      action: 'question_selected',
      context: {
        user_id: user_id,
        question_id: question_id,
        difficulty: difficulty,
        reason: reason,
        using_fallback: using_fallback
      }
    )
  end
  
  def self.log_answer_submission(user_id:, question_id:, correct:, time_taken:, ability_update:)
    log_event(
      category: 'adaptive',
      action: 'answer_submitted',
      context: {
        user_id: user_id,
        question_id: question_id,
        correct: correct,
        time_taken_seconds: time_taken,
        new_ability: ability_update
      }
    )
  end
  
  def self.log_api_call(service:, endpoint:, duration_ms:, success:, error: nil)
    log_event(
      category: 'api',
      action: 'external_call',
      context: {
        service: service,
        endpoint: endpoint,
        duration_ms: duration_ms,
        success: success,
        error: error
      },
      level: success ? :info : :warn
    )
  end
  
  def self.log_weakness_detected(user_id:, topic:, severity:, remediation:)
    log_event(
      category: 'analytics',
      action: 'weakness_detected',
      context: {
        user_id: user_id,
        topic: topic,
        severity: severity,
        remediation_type: remediation[:type]
      }
    )
  end
  
  def self.log_fsrs_scheduling(user_id:, item_type:, item_id:, performance:, next_review:, interval_days:)
    log_event(
      category: 'fsrs',
      action: 'review_scheduled',
      context: {
        user_id: user_id,
        item_type: item_type,
        item_id: item_id,
        performance_grade: performance,
        next_review_at: next_review,
        interval_days: interval_days
      }
    )
  end
  
  def self.log_lab_event(user_id:, lab_id:, session_id:, event:, details: {})
    log_event(
      category: 'lab',
      action: event,
      context: {
        user_id: user_id,
        lab_id: lab_id,
        session_id: session_id,
        **details
      }
    )
  end
  
  def self.log_error(error:, context: {})
    """Log error with context"""
    log_event(
      category: 'error',
      action: 'exception',
      context: {
        error_class: error.class.name,
        error_message: error.message,
        backtrace: error.backtrace.first(5),
        **context
      },
      level: :error
    )
  end
end

