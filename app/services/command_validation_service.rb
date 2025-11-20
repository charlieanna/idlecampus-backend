class CommandValidationService
  """
  Real-time command validation for hands-on labs
  Multi-level validation: syntax → execution → state → resource
  """
  
  def initialize(lab, session)
    @lab = lab
    @session = session
    @orchestrator = LabOrchestratorService.new
  end
  
  def validate_step(step_number:, user_command:)
    """
    Validate user command for current step
    
    Returns:
      {
        success: boolean,
        validations: { command, output, state, resource },
        feedback: string,
        hint: string (if failed),
        progress: float
      }
    """
    
    steps = @lab.steps.is_a?(Array) ? @lab.steps : []
    step = steps[step_number]
    
    return { success: false, error: 'Invalid step' } unless step
    
    # Multi-level validation
    validations = {
      command: validate_command_syntax(user_command, step),
      execution: execute_and_validate(user_command, step),
      state: validate_system_state(step),
      resource: validate_resource_creation(step)
    }
    
    # All must pass
    all_passed = validations.values.all? { |v| v[:passed] }
    
    if all_passed
      # Success path
      @session.record_step_completion(step_number)
      @session.update!(current_step: step_number + 1)
      
      progress = ((@session.current_step.to_f / steps.length) * 100).round(1)
      
      {
        success: true,
        validations: validations,
        message: step['success_message'] || 'Step completed!',
        progress: progress,
        next_step: steps[@session.current_step],
        score_impact: calculate_score_impact(validations)
      }
    else
      # Failure path
      @session.use_attempt!
      
      failures = validations.select { |_, v| !v[:passed] }
      hint = generate_progressive_hint(step, @session.attempts_used, failures)
      
      {
        success: false,
        validations: validations,
        failures: failures.map { |type, v| { type: type, reason: v[:reason] } },
        hint: hint,
        attempts_remaining: step['max_attempts'] - @session.attempts_used
      }
    end
  end
  
  private
  
  def validate_command_syntax(user_command, step)
    """Validate command syntax"""
    
    expected = step['expected_command']
    
    # Normalize for comparison
    user_norm = normalize_command(user_command)
    expected_norm = normalize_command(expected)
    
    # Check base command
    user_base = user_norm.split.first
    expected_base = expected_norm.split.first
    
    if user_base != expected_base
      return {
        passed: false,
        reason: "Wrong command. Expected '#{expected_base}', got '#{user_base}'"
      }
    end
    
    # Check for required flags
    expected_flags = extract_flags(expected_norm)
    user_flags = extract_flags(user_norm)
    missing_flags = expected_flags - user_flags
    
    if missing_flags.any?
      return {
        passed: false,
        reason: "Missing required flags: #{missing_flags.join(', ')}"
      }
    end
    
    {
      passed: true,
      reason: 'Command syntax correct'
    }
  end
  
  def execute_and_validate(user_command, step)
    """Execute command and validate output"""
    
    return { passed: true, reason: 'No execution required' } unless @session.container_id
    
    result = @orchestrator.execute_command(
      container_id: @session.container_id,
      command: user_command,
      timeout: 30
    )
    
    if !result[:success]
      return {
        passed: false,
        reason: "Command failed: #{result[:stderr]}"
      }
    end
    
    # Validate output if specified
    if step['expected_output']
      if result[:stdout].include?(step['expected_output'])
        { passed: true, reason: 'Output matches expected' }
      else
        { passed: false, reason: "Output doesn't match. Expected: #{step['expected_output']}" }
      end
    else
      { passed: true, reason: 'Command executed successfully' }
    end
  end
  
  def validate_system_state(step)
    """Validate system state after command"""
    
    return { passed: true, reason: 'No state validation' } unless step['validation']
    
    validation_command = step['validation']
    
    result = @orchestrator.execute_command(
      container_id: @session.container_id,
      command: validation_command,
      timeout: 10
    )
    
    if result[:success]
      { passed: true, reason: 'System state valid' }
    else
      { passed: false, reason: 'System state validation failed' }
    end
  end
  
  def validate_resource_creation(step)
    """Validate that expected resources were created"""
    
    return { passed: true, reason: 'No resource validation' } unless @lab.validation_rules
    
    validation_rules = @lab.validation_rules.is_a?(Hash) ? @lab.validation_rules : {}
    
    # Run validation rules
    result = @orchestrator.validate_lab_state(
      container_id: @session.container_id,
      validation_rules: validation_rules
    )
    
    if result[:all_passed]
      { passed: true, reason: 'All resources created' }
    else
      failed = result[:results].select { |_, v| !v[:passed] }
      { passed: false, reason: "Resource validation failed: #{failed.keys.join(', ')}" }
    end
  end
  
  def generate_progressive_hint(step, attempts_used, failures)
    """Generate hint based on attempts and failures"""
    
    # Level 1: General hint
    if attempts_used == 1
      return step['hints']&.[]('level_1') || step['hint'] || 'Review the step instructions'
    end
    
    # Level 2: More specific
    if attempts_used == 2
      hint = step['hints']&.[]('level_2') || 'Check your command flags and arguments'
      
      # Add specific failure hints
      if failures[:command]
        hint += "\nHint: #{failures[:command][:reason]}"
      end
      
      return hint
    end
    
    # Level 3: Very specific
    if attempts_used >= 3
      hint = step['hints']&.[]('level_3') || "Try: #{step['expected_command']}"
      return hint
    end
    
    'Try reviewing the documentation'
  end
  
  def calculate_score_impact(validations)
    """Calculate score impact based on validation results"""
    
    base_score = 10
    
    # Perfect execution
    return base_score if validations.values.all? { |v| v[:passed] }
    
    # Deduct for failures
    deductions = 0
    deductions += 3 unless validations[:command][:passed]
    deductions += 2 unless validations[:execution][:passed]
    deductions += 2 unless validations[:state][:passed]
    deductions += 3 unless validations[:resource][:passed]
    
    [base_score - deductions, 0].max
  end
  
  def normalize_command(cmd)
    """Normalize command for comparison"""
    cmd.to_s.strip.squeeze(' ').downcase
  end
  
  def extract_flags(cmd)
    """Extract flags from command"""
    cmd.scan(/--?[\w-]+/)
  end
end

