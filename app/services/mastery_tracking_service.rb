\n# Service to handle mastery tracking operations\n# Coordinates updates, remedial checks, and decay calculations\nclass MasteryTrackingService\n  attr_reader :user, :errors\n  \n  def initialize(user)\n    @user = user\n    @errors = []\n  end\n  \n  # Record a command attempt from any context\n  # @param command [String] Raw command string\n  # @param success [Boolean] Whether the attempt was successful\n  # @param context [String] Context of attempt (practice, quiz, lab, real_project)\n  # @return [UserCommandMastery, nil] Updated mastery record or nil if error\n  def record_attempt(command:, success:, context: 'practice')\n    canonical = CommandCanonicalizer.canonicalize(command)\n    \n    unless canonical\n      @errors << \"Unrecognized command: #{command}\"\n      return nil\n    end\n    \n    mastery = find_or_create_mastery(canonical)\n    category = CommandCanonicalizer.category(canonical)\n    \n    mastery.command_category ||= category\n    mastery.record_attempt(success: success, context: context)\n    \n    # Check for stealth review opportunities (Phase 3)\n    schedule_stealth_reviews(mastery) if mastery.needs_practice?\n    \n    # Award shields if newly mastered (Phase 3)\n    award_shield(mastery) if mastery.mastered? && mastery.first_mastered_at_previously_changed?\n    \n    mastery\n  rescue => e\n    @errors << \"Error recording attempt: #{e.message}\"\n    Rails.logger.error \"MasteryTrackingService error: #{e.message}\\n#{e.backtrace.join(\"\\n\")}\"\n    nil\n  end\n  \n  # Check if user can proceed to Apply step\n  # @param unit [InteractiveLearningUnit] The unit being attempted\n  # @return [Hash] Gate status with details\n  def check_remedial_gate(unit)\n    required_commands = extract_required_commands(unit)\n    \n    if required_commands.empty?\n      return { \n        status: 'ok', \n        message: 'No command requirements' \n      }\n    end\n    \n    blocked_commands = []\n    remedial_needed = []\n    \n    required_commands.each do |command|\n      mastery = find_or_create_mastery(command)\n      \n      # Apply decay before checking (Phase 3)\n      mastery.apply_decay! if mastery.last_used_at.present?\n      \n      unless mastery.mastered?\n        blocked_commands << command\n        remedial_needed << {\n          command: command,\n          label: CommandCanonicalizer.label(command),\n          current_score: mastery.proficiency_score,\n          attempts_needed: estimate_attempts_needed(mastery)\n        }\n      end\n    end\n    \n    if blocked_commands.empty?\n      { \n        status: 'ok', \n        message: 'All commands mastered',\n        commands: required_commands.map { |c| CommandCanonicalizer.label(c) }\n      }\n    else\n      { \n        status: 'blocked',\n        message: \"Master these commands first (100% required)\",\n        blocked_commands: blocked_commands,\n        remedial_drills: remedial_needed\n      }\n    end\n  end\n  \n  # Get user's overall mastery statistics\n  # @param category [String, nil] Optional category filter\n  # @return [Hash] Mastery statistics\n  def mastery_stats(category: nil)\n    scope = user.user_command_masteries\n    scope = scope.by_category(category) if category\n    \n    total = scope.count\n    mastered = scope.mastered.count\n    needs_practice = scope.needs_practice.count\n    \n    {\n      total_commands: total,\n      mastered: mastered,\n      needs_practice: needs_practice,\n      mastery_percentage: total > 0 ? (mastered.to_f / total * 100).round(2) : 0,\n      categories: category_breakdown,\n      recent_progress: recent_progress_data,\n      shields: shield_summary\n    }\n  end\n  \n  # Get commands that need review based on decay\n  # @param limit [Integer] Maximum number of commands to return\n  # @return [Array<Hash>] Commands needing review\n  def commands_needing_review(limit: 5)\n    masteries = user.user_command_masteries\n      .where.not(last_used_at: nil)\n      .order(last_used_at: :asc)\n      .limit(limit)\n    \n    masteries.map do |mastery|\n      mastery.apply_decay!\n      \n      {\n        command: mastery.canonical_command,\n        label: CommandCanonicalizer.label(mastery.canonical_command),\n        current_score: mastery.proficiency_score,\n        decay_amount: mastery.proficiency_score - mastery.calculate_decay,\n        days_since_use: ((Time.current - mastery.last_used_at) / 1.day).round,\n        examples: CommandCanonicalizer.examples(mastery.canonical_command)\n      }\n    end.select { |cmd| cmd[:decay_amount] > 0 }\n  end\n  \n  # Create a remedial drill for blocked commands\n  # @param commands [Array<String>] Canonical commands needing practice\n  # @return [Hash] Drill configuration\n  def create_remedial_drill(commands)\n    drills = commands.map do |command|\n      mastery = find_or_create_mastery(command)\n      \n      {\n        command: command,\n        label: CommandCanonicalizer.label(command),\n        examples: CommandCanonicalizer.examples(command),\n        current_score: mastery.proficiency_score,\n        hint_level: calculate_hint_level(mastery),\n        exercise_type: select_exercise_type(mastery)\n      }\n    end\n    \n    {\n      drills: drills,\n      total_exercises: drills.length * 3, # 3 attempts per command\n      estimated_time: drills.length * 2, # 2 minutes per command\n      success_criteria: 'All commands at 100% mastery'\n    }\n  end\n  \n  # Record remedial drill completion\n  # @param drill_results [Array<Hash>] Results from remedial drill\n  # @return [Boolean] Whether gate is now passed\n  def complete_remedial_drill(drill_results)\n    drill_results.each do |result|\n      record_attempt(\n        command: result[:command],\n        success: result[:success],\n        context: 'remedial'\n      )\n    end\n    \n    # Check if all commands now mastered\n    blocked = drill_results.map { |r| r[:command] }.uniq.any? do |cmd|\n      canonical = CommandCanonicalizer.canonicalize(cmd)\n      mastery = find_or_create_mastery(canonical)\n      !mastery.mastered?\n    end\n    \n    !blocked\n  end\n  \n  private\n  \n  def find_or_create_mastery(canonical_command)\n    user.user_command_masteries.find_or_create_by(\n      canonical_command: canonical_command\n    ) do |mastery|\n      mastery.command_category = CommandCanonicalizer.category(canonical_command)\n    end\n  end\n  \n  def extract_required_commands(unit)\n    commands = []\n    \n    # Get explicitly defined required commands\n    if unit.respond_to?(:required_commands) && unit.required_commands.present?\n      commands.concat(unit.required_commands)\n    end\n    \n    # Extract from command_to_learn if present\n    if unit.respond_to?(:command_to_learn) && unit.command_to_learn.present?\n      canonical = CommandCanonicalizer.canonicalize(unit.command_to_learn)\n      commands << canonical if canonical\n    end\n    \n    # Extract from scenario content\n    if unit.respond_to?(:scenario) && unit.scenario.present?\n      commands.concat(CommandCanonicalizer.extract_commands(unit.scenario))\n    end\n    \n    commands.uniq\n  end\n  \n  def estimate_attempts_needed(mastery)\n    return 1 if mastery.proficiency_score >= 90\n    return 2 if mastery.proficiency_score >= 70\n    return 3 if mastery.proficiency_score >= 50\n    4\n  end\n  \n  def calculate_hint_level(mastery)\n    case mastery.proficiency_score\n    when 0..30 then :full\n    when 31..60 then :partial\n    when 61..90 then :minimal\n    else :none\n    end\n  end\n  \n  def select_exercise_type(mastery)\n    if mastery.total_attempts == 0\n  
      :guided_tutorial
    elsif mastery.proficiency_score < 50
      :fill_in_blank
    elsif mastery.proficiency_score < 80
      :multiple_choice
    else
      :free_form
    end
  end
  
  def category_breakdown
    categories = %w[docker docker-compose kubernetes]
    
    categories.map do |category|
      scope = user.user_command_masteries.by_category(category)
      {
        category: category,
        total: scope.count,
        mastered: scope.mastered.count,
        percentage: scope.count > 0 ? (scope.mastered.count.to_f / scope.count * 100).round(2) : 0
      }
    end
  end
  
  def recent_progress_data
    last_week = user.user_command_masteries
      .where('last_used_at > ?', 7.days.ago)
      .order(last_used_at: :desc)
    
    {
      commands_practiced: last_week.count,
      new_masteries: last_week.where('first_mastered_at > ?', 7.days.ago).count,
      average_score: last_week.average(:proficiency_score)&.round(2) || 0
    }
  end
  
  def shield_summary
    shields = {
      bronze: 0,
      silver: 0,
      gold: 0,
      platinum: 0
    }
    
    user.user_command_masteries.mastered.each do |mastery|
      level = mastery.shield_level
      shields[level] += 1 if level
    end
    
    shields
  end
  
  def schedule_stealth_reviews(mastery)
    # Phase 3: Schedule stealth reviews for commands needing practice
    # This would integrate with the lesson scheduling system
    Rails.logger.info "Scheduling stealth review for #{mastery.canonical_command}"
  end
  
  def award_shield(mastery)
    # Phase 3: Award shield badges for maintaining mastery
    Rails.logger.info "Awarding shield for #{mastery.canonical_command}"
  end
end