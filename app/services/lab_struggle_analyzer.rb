# Lab Struggle Analyzer Service
# Analyzes lab sessions to detect when users are struggling
# Calculates struggle scores and identifies specific pain points

class LabStruggleAnalyzer
  attr_reader :lab_session

  # Struggle thresholds
  STRUGGLE_THRESHOLD = 0.6 # > 60% = struggling
  CRITICAL_THRESHOLD = 0.8 # > 80% = critical struggle

  def initialize(lab_session)
    @lab_session = lab_session
  end

  # Calculate comprehensive struggle score (0.0 to 1.0)
  def calculate_struggle_score
    score = 0.0

    # Factor 1: Hints usage (max 0.25)
    score += hint_struggle_component

    # Factor 2: Time taken (max 0.25)
    score += time_struggle_component

    # Factor 3: Validation failures (max 0.25)
    score += validation_struggle_component

    # Factor 4: Error patterns (max 0.15)
    score += error_pattern_component

    # Factor 5: Step completion ratio (max 0.10)
    score += completion_ratio_component

    # Cap at 1.0
    [score, 1.0].min.round(2)
  end

  # Check if user is struggling
  def struggling?
    calculate_struggle_score >= STRUGGLE_THRESHOLD
  end

  # Check if struggle is critical
  def critical_struggle?
    calculate_struggle_score >= CRITICAL_THRESHOLD
  end

  # Get detailed struggle indicators
  def struggle_indicators
    {
      hints_used: lab_session.hints_used || 0,
      time_ratio: time_ratio,
      validation_failures: validation_failure_count,
      error_count: error_count,
      completion_ratio: completion_ratio,
      stuck_on_step: stuck_on_step?,
      error_patterns: identify_error_patterns,
      struggle_score: calculate_struggle_score,
      struggling: struggling?,
      critical: critical_struggle?
    }
  end

  # Identify specific areas where user is struggling
  def identify_pain_points
    pain_points = []

    # Check for specific step difficulties
    if lab_session.step_history.present?
      failed_steps = lab_session.step_history.select { |sh| sh['status'] == 'failed' }
      if failed_steps.any?
        pain_points << {
          type: 'step_failures',
          severity: failed_steps.count > 2 ? 'high' : 'medium',
          details: failed_steps.map { |s| s['step_number'] },
          description: "User failed on steps: #{failed_steps.map { |s| s['step_number'] }.join(', ')}"
        }
      end
    end

    # Check for repeated validation failures
    if validation_failure_count > 3
      pain_points << {
        type: 'validation_failures',
        severity: 'high',
        details: { count: validation_failure_count },
        description: "Multiple validation failures (#{validation_failure_count})"
      }
    end

    # Check for time struggles
    if time_ratio > 2.0
      pain_points << {
        type: 'time_exceeded',
        severity: time_ratio > 3.0 ? 'critical' : 'high',
        details: { ratio: time_ratio, expected: expected_time_minutes, actual: actual_time_minutes },
        description: "Taking #{time_ratio.round(1)}x longer than expected"
      }
    end

    # Check for error patterns
    error_patterns = identify_error_patterns
    if error_patterns.any?
      pain_points << {
        type: 'error_patterns',
        severity: 'medium',
        details: error_patterns,
        description: "Recurring error patterns detected"
      }
    end

    # Check if stuck on one step
    if stuck_on_step?
      pain_points << {
        type: 'stuck_on_step',
        severity: 'high',
        details: { step: lab_session.current_step },
        description: "Stuck on step #{lab_session.current_step}"
      }
    end

    pain_points
  end

  # Get recommended interventions
  def recommended_interventions
    score = calculate_struggle_score
    interventions = []

    if critical_struggle?
      interventions << {
        type: 'break_recommended',
        priority: 'high',
        message: 'Take a break and review the prerequisites',
        actions: ['Take 15-30 min break', 'Review related concepts', 'Check hints carefully']
      }
    elsif struggling?
      interventions << {
        type: 'support_needed',
        priority: 'medium',
        message: 'You might benefit from additional help',
        actions: ['Request a hint', 'Review the lab instructions', 'Check similar examples']
      }
    end

    # Specific interventions based on pain points
    pain_points = identify_pain_points

    if pain_points.any? { |p| p[:type] == 'validation_failures' }
      interventions << {
        type: 'validation_help',
        priority: 'medium',
        message: 'Review the validation requirements carefully',
        actions: ['Check command syntax', 'Verify expected output', 'Review step instructions']
      }
    end

    if pain_points.any? { |p| p[:type] == 'time_exceeded' }
      interventions << {
        type: 'time_management',
        priority: 'low',
        message: 'Consider breaking the problem into smaller steps',
        actions: ['Focus on one step at a time', 'Use hints to stay on track']
      }
    end

    if pain_points.any? { |p| p[:type] == 'error_patterns' }
      interventions << {
        type: 'concept_review',
        priority: 'medium',
        message: 'Review the fundamental concepts',
        actions: ['Go back to related lessons', 'Practice basic commands', 'Check documentation']
      }
    end

    interventions
  end

  private

  # Hint usage component (0.0 to 0.25)
  def hint_struggle_component
    hints = lab_session.hints_used || 0
    return 0.0 if hints == 0
    return 0.1 if hints == 1
    return 0.15 if hints == 2
    return 0.2 if hints == 3
    0.25 # 4+ hints
  end

  # Time struggle component (0.0 to 0.25)
  def time_struggle_component
    ratio = time_ratio
    return 0.0 if ratio <= 1.0
    return 0.1 if ratio <= 1.5
    return 0.15 if ratio <= 2.0
    return 0.2 if ratio <= 3.0
    0.25 # 3x+ longer
  end

  # Validation failure component (0.0 to 0.25)
  def validation_struggle_component
    failures = validation_failure_count
    return 0.0 if failures == 0
    return 0.1 if failures <= 2
    return 0.15 if failures <= 4
    return 0.2 if failures <= 6
    0.25 # 7+ failures
  end

  # Error pattern component (0.0 to 0.15)
  def error_pattern_component
    patterns = identify_error_patterns
    return 0.0 if patterns.empty?
    return 0.05 if patterns.count == 1
    return 0.1 if patterns.count == 2
    0.15 # 3+ patterns
  end

  # Completion ratio component (0.0 to 0.10)
  def completion_ratio_component
    ratio = completion_ratio
    return 0.0 if ratio >= 0.8
    return 0.03 if ratio >= 0.5
    return 0.07 if ratio >= 0.25
    0.1 # < 25% completed
  end

  # Calculate time ratio (actual / expected)
  def time_ratio
    expected = expected_time_minutes
    actual = actual_time_minutes
    return 0.0 if expected.zero?
    actual / expected.to_f
  end

  def expected_time_minutes
    lab_session.hands_on_lab&.estimated_minutes || 30
  end

  def actual_time_minutes
    return 0 unless lab_session.started_at
    elapsed_seconds = lab_session.time_spent_seconds ||
                     (Time.current - lab_session.started_at).to_i
    elapsed_seconds / 60.0
  end

  # Count validation failures
  def validation_failure_count
    return 0 unless lab_session.validation_results.present?

    if lab_session.validation_results.is_a?(Hash)
      lab_session.validation_results.values.count { |v| v == false || v['passed'] == false }
    elsif lab_session.validation_results.is_a?(Array)
      lab_session.validation_results.count { |v| v == false || v['passed'] == false }
    else
      0
    end
  end

  # Count errors in error_logs
  def error_count
    return 0 unless lab_session.error_logs.present?

    if lab_session.error_logs.is_a?(String)
      lab_session.error_logs.scan(/error|failed|exception/i).count
    elsif lab_session.error_logs.is_a?(Array)
      lab_session.error_logs.count
    else
      0
    end
  end

  # Calculate completion ratio
  def completion_ratio
    total = lab_session.hands_on_lab&.steps&.count || 1
    completed = lab_session.steps_completed || 0
    completed.to_f / total
  end

  # Check if stuck on one step for too long
  def stuck_on_step?
    return false unless lab_session.step_history.present?
    return false if lab_session.step_history.empty?

    # If current step hasn't changed in the last 50% of session time
    step_history = lab_session.step_history
    return false if step_history.count < 3

    last_three_steps = step_history.last(3)
    last_three_steps.map { |s| s['step_number'] }.uniq.count == 1
  end

  # Identify recurring error patterns
  def identify_error_patterns
    patterns = []
    return patterns unless lab_session.error_logs.present?

    error_text = lab_session.error_logs.to_s.downcase

    # Common error patterns
    patterns << 'permission_errors' if error_text.include?('permission denied')
    patterns << 'syntax_errors' if error_text.include?('syntax error')
    patterns << 'command_not_found' if error_text.include?('command not found')
    patterns << 'network_errors' if error_text.include?('connection') || error_text.include?('network')
    patterns << 'file_not_found' if error_text.include?('no such file')
    patterns << 'docker_errors' if error_text.include?('docker') && error_text.include?('error')
    patterns << 'kubernetes_errors' if error_text.include?('kubernetes') || error_text.include?('kubectl')

    patterns.uniq
  end
end
