class LabCompletionHandler
  attr_reader :user, :lab, :result, :attempt

  def initialize(user, lab, result)
    @user = user
    @lab = lab
    @result = result
  end

  def process!
    record_attempt

    if @result[:passed]
      handle_success
    else
      handle_failure
    end

    attempt
  end

  private

  def record_attempt
    @attempt = LabAttempt.create!(
      user: user,
      hands_on_lab: lab,
      score: @result[:score],
      passed: @result[:passed],
      failed_commands: @result[:failed_commands] || []
    )
  end

  def handle_success
    Rails.logger.info "✅ Lab passed: #{lab.title} - Score: #{@result[:score]}%"

    # Boost all tested commands to 100%
    commands_tested = lab.commands_tested || []

    commands_tested.each do |command|
      mastery = user.command_masteries.find_or_create_by(canonical_command: command)

      old_score = mastery.proficiency_score
      old_stability = mastery.stability || HybridDecayService::DEFAULT_STABILITY

      mastery.update!(
        proficiency_score: 100,
        stability: old_stability * lab.stability_multiplier,
        last_used_at: Time.current,
        chapters_at_mastery: current_chapter_position  # Reset interference tracking
      )

      Rails.logger.info "  📈 #{command}: #{old_score}% → 100% (stability: #{old_stability} → #{mastery.stability})"
    end

    # Update session state
    session = user.learning_sessions.active.first
    if session
      session.update_state('last_lab_chapter', current_chapter_position)
      session.update_state('labs_completed', (session.get_state('labs_completed') || 0) + 1)
    end

    Rails.logger.info "  🏆 All #{commands_tested.count} commands boosted to 100%"
  end

  def handle_failure
    Rails.logger.info "❌ Lab failed: #{lab.title} - Score: #{@result[:score]}%"

    # Lock retry for 24 hours
    attempt.lock_retry!(hours: 24)

    # Track which commands failed for targeted reviews
    failed_commands = @result[:failed_commands] || []

    if failed_commands.any?
      Rails.logger.info "  📋 Failed commands: #{failed_commands.join(', ')}"

      # Update session to queue these for review
      session = user.learning_sessions.active.first
      if session
        queued_reviews = session.get_state('queued_reviews') || []
        new_reviews = failed_commands.map { |cmd|
          { command: cmd, reason: "Failed in lab: #{lab.title}", priority: 'high' }
        }
        session.update_state('queued_reviews', queued_reviews + new_reviews)
      end
    end

    Rails.logger.info "  🔒 Lab retry locked for 24 hours"
  end

  def current_chapter_position
    session = user.learning_sessions.active.first
    return 0 unless session

    current_chapter = session.get_state('current_chapter')
    return 0 unless current_chapter

    DockerContentLibrary.learning_path_order.index(current_chapter) || 0
  end
end
