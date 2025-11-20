class AdaptiveContentSelector
  PRIORITIES = {
    critical_review: 1,          # < 60% - Single command urgent review
    comprehensive_lab: 2,         # Milestone labs (every 5 chapters)
    batch_review: 3,             # 60-75% - Multi-command scenarios
    urgent_decay: 4,             # Legacy urgent decay (< 50%)
    failed_recent: 5,
    stealth_review: 6,
    weakness_area: 7,
    lab_ready: 8,
    learning_path: 9,
    new_content: 10
  }.freeze

  # Configuration for new review system
  CRITICAL_THRESHOLD = 60       # Below 60% = critical review needed
  MODERATE_THRESHOLD = 75       # 60-75% = batch review candidate
  LAB_INTERVAL_CHAPTERS = 5     # Lab every 5 chapters
  MIN_COMMANDS_FOR_BATCH = 3    # Need 3+ commands for batch review
  
  STEALTH_REVIEW_PROBABILITY = 0.20 # 20% chance
  
  def initialize(user, track = 'docker')
    @user = user
    @track = track
    @content_library = get_content_library_for_track(track)
  end
  
  def next_content(options = {})
    exclude_ids = options[:exclude_ids] || []
    last_correct = options[:last_correct]

    # Detect recent correct answer from session to avoid immediate repetition
    current_session = @user.learning_sessions.active.first
    session_last_correct = false
    if current_session
      last_resp = (current_session.state_data['responses'] || []).last
      session_last_correct = last_resp && last_resp['correct'] == true
    end

    # If brand new session (no current chapter), force start at first learning path chapter (docker run)
    current_session = @user.learning_sessions.active.first
    if current_session && current_session.state_data['current_chapter'].blank?
      return get_start_of_session_content
    end

    # PRIORITY 0: If user EXPLICITLY navigated to a chapter (within last 5 minutes), show that chapter!
    # Don't interrupt with reviews when user is actively learning a specific chapter
    # But if they just reloaded /docker/learn, check for reviews first
    if current_session && current_session.state_data['current_chapter'].present?
      # Only prioritize current chapter if it was recently set (user is actively working on it)
      recently_active = current_session.updated_at > 5.minutes.ago
      if recently_active && !session_last_correct
        content = get_continue_current_chapter_content
        return content if content
      end
    end

    # Priority 1: Critical reviews (< 60% using HybridDecayService)
    content = get_critical_review(exclude_ids)
    return content if content

    # Priority 2: Comprehensive labs (every 5 chapters)
    content = get_comprehensive_lab
    return content if content

    # Priority 3: Batch reviews (60-75%, 3+ commands)
    content = get_batch_review(exclude_ids)
    return content if content

    # Priority 4: Urgent decay reviews (legacy < 50% retention)
    content = get_urgent_reviews(exclude_ids)
    return content if content

    # Priority 5: Failed recent items (last 24 hours)
    content = get_failed_recent_items(exclude_ids)
    return content if content

    # Priority 6: Stealth reviews (20% probability)
    content = maybe_insert_stealth_review(exclude_ids)
    return content if content
    
    # Priority 4: Weakness areas (< 60% mastery)
    content = nil
    unless last_correct || session_last_correct
      content = get_weakness_areas(exclude_ids)
    end
    return content if content
    
    # Priority 5: Labs ready (meets prerequisites)
    content = get_ready_lab_content
    return content if content

    # Priority 6: Current learning path progression
    content = get_learning_path_content(exclude_ids)
    return content if content
    
    # Priority 8: New content (unexplored)
    content = get_new_content(exclude_ids)
    return content if content
    
    # Last resort: Return first available content from learning path
    first_chapter = learning_path.first
    if first_chapter
      micro = pick_best_micro_for_chapter(first_chapter)
      if micro
        return {
          id: "fallback_#{SecureRandom.hex(4)}",
          type: 'interactive',
          priority: PRIORITIES[:learning_path],
          content: micro[:content],
          metadata: {
            is_learning_path: true,
            canonical_command: first_chapter,
            chapter: first_chapter,
            micro_id: micro[:id]
          }
        }
      end
    end
    
    # If still no content, return nil (view will handle it)
    nil
  end
  
  private

  # NEW: Priority 1 - Critical single-command reviews (< 60%)
  def get_critical_review(exclude_ids)
    return nil if @user.command_masteries.empty?

    # Get user's completed chapters
    session = @user.learning_sessions.active.first
    completed_chapters = if session
      (session.state_data['completed_micros'] || {}).keys
    else
      []
    end

    # Get all command masteries with hybrid decay scores < 60%
    # Filter by track AND only include completed chapters!
    critical_commands = @user.command_masteries.select do |mastery|
      command = mastery.canonical_command

      # CRITICAL: Only review commands from completed chapters!
      next false unless completed_chapters.include?(command)

      # Filter by track
      track_match = if @track == 'docker'
        command.include?('docker') || command.include?('codesprout')
      elsif @track == 'kubernetes' || @track == 'k8s'
        command.include?('kubectl') || command.include?('k8s')
      else
        true # Allow all for unknown tracks
      end

      next false unless track_match

      hybrid_service = HybridDecayService.new(mastery)
      score = hybrid_service.current_decayed_score
      score < CRITICAL_THRESHOLD
    end.sort_by { |m| HybridDecayService.new(m).current_decayed_score }

    return nil if critical_commands.empty?

    # Take the worst one
    worst = critical_commands.first
    score = HybridDecayService.new(worst).current_decayed_score

    Rails.logger.info "🔴 CRITICAL REVIEW: #{worst.canonical_command} at #{score.round(1)}%"

    # Generate single-command review using ReviewGenerator
    review_content = ReviewGenerator.generate_single_command_review(worst, @user)

    {
      id: review_content[:id],
      type: 'quick_review',
      priority: PRIORITIES[:critical_review],
      content: review_content[:content],
      metadata: review_content[:content].merge({
        is_review: true,
        mastery_score: worst.proficiency_score.round,  # Show actual DB score, not decayed score
        review_type: 'critical',
        review_reason: 'critical_decay',
        retention_level: score.round(1),  # Keep decayed score for internal tracking
        original_chapter: review_content[:content][:original_chapter]
      }),
      scoring: review_content[:scoring]
    }
  end

  # NEW: Priority 2 - Comprehensive labs (every 5 chapters)
  def get_comprehensive_lab
    session = @user.learning_sessions.active.first
    return nil unless session

    # Calculate chapters completed
    current_position = current_chapter_position
    return nil if current_position < 5  # Must complete at least 5 chapters first

    last_lab_chapter = session.get_state('last_lab_chapter') || 0
    chapters_since_lab = current_position - last_lab_chapter

    return nil if chapters_since_lab < LAB_INTERVAL_CHAPTERS

    # Find a comprehensive lab gated by prerequisites the user has mastered
    eligible = DockerContentLibrary.eligible_labs_for_user(@user, min_mastery: 60)
    return nil if eligible.blank?
    lab = HandsOnLab.find_by(id: eligible.first[:id])
    return nil unless lab

    # Check if retry is locked
    last_attempt = @user.lab_attempts.where(hands_on_lab: lab).order(created_at: :desc).first
    if last_attempt && !last_attempt.can_retry?
      Rails.logger.info "🔒 Lab locked: #{lab.title} - retry in #{last_attempt.retry_available_in}"
      # Return a targeted review for failed commands instead
      return get_failed_lab_command_review(last_attempt)
    end

    Rails.logger.info "🟢 COMPREHENSIVE LAB: #{lab.title} (#{chapters_since_lab} chapters since last lab)"

    # Parse learning_objectives (text field) - keep as string for display
    # Only split if it contains multiple complete sentences (separated by periods) or newlines
    objectives = if lab.learning_objectives.present?
      obj_text = lab.learning_objectives.to_s.strip
      # If it has newlines or multiple sentences (periods followed by space), split it
      if obj_text.include?("\n") || obj_text.scan(/\.\s+/).length > 1
        obj_text.split(/[\n]+|\.\s+/).map(&:strip).reject(&:blank?).map { |o| o.end_with?('.') ? o : "#{o}." }
      else
        # Single sentence/phrase - keep as is
        [obj_text]
      end
    else
      []
    end

    # Get steps and first instruction
    steps = lab.steps || []
    first_step = steps.first
    current_instruction = first_step&.dig('instruction') || first_step&.dig(:instruction) || 'Ready to start! Type your first command.'

    {
      id: "lab_#{lab.id}",
      type: 'comprehensive_lab',
      priority: PRIORITIES[:comprehensive_lab],
      content: {
        title: lab.title,
        scenario: lab.description,
        description: lab.description,
        objectives: objectives,
        estimated_minutes: lab.estimated_minutes || 15,
        commands_tested: lab.commands_tested || [],
        current_instruction: current_instruction
      },
      metadata: {
        lab_id: lab.id,
        is_comprehensive_lab: true,
        chapters_since_last_lab: chapters_since_lab,
        step_count: steps.length
      }
    }
  end

  # NEW: Priority 3 - Batch multi-command reviews (60-75%, 3+ commands)
  def get_batch_review(exclude_ids)
    return nil if @user.command_masteries.empty?

    session = @user.learning_sessions.active.first
    return nil unless session

    last_review_chapter = session.get_state('last_review_chapter') || 0
    current_position = current_chapter_position

    # Only show batch reviews if at least 3 chapters since last review
    return nil if (current_position - last_review_chapter) < 3

    # Get commands in moderate range (60-75%)
    moderate_commands = @user.command_masteries.select do |mastery|
      score = HybridDecayService.new(mastery).current_decayed_score
      score >= CRITICAL_THRESHOLD && score < MODERATE_THRESHOLD
    end.sort_by { |m| HybridDecayService.new(m).current_decayed_score }

    return nil if moderate_commands.count < MIN_COMMANDS_FOR_BATCH

    # Take up to 3 commands
    commands_to_review = moderate_commands.take(3)
    scores = commands_to_review.map { |m| HybridDecayService.new(m).current_decayed_score.round(1) }

    Rails.logger.info "🟡 BATCH REVIEW: #{commands_to_review.count} commands (scores: #{scores.join(', ')}%)"

    # Generate multi-command review using ReviewGenerator
    review_content = ReviewGenerator.generate_multi_command_review(commands_to_review, @user)

    # Update session to track this review
    session.update_state('last_review_chapter', current_position)

    {
      id: review_content[:id],
      type: 'scenario_review',
      priority: PRIORITIES[:batch_review],
      content: review_content[:content],
      metadata: review_content[:content].merge({
        is_review: true,
        review_type: 'batch',
        review_reason: 'moderate_decay',
        commands_reviewed: commands_to_review.map(&:canonical_command)
      }),
      scoring: review_content[:scoring]
    }
  end

  def get_failed_lab_command_review(lab_attempt)
    return nil if lab_attempt.failed_commands.blank?

    # Get the first failed command
    failed_command = lab_attempt.failed_commands.first
    mastery = @user.command_masteries.find_by(canonical_command: failed_command)

    return nil unless mastery

    Rails.logger.info "🔴 FAILED LAB REVIEW: #{failed_command} from lab #{lab_attempt.hands_on_lab.title}"

    # Generate single-command review
    review_content = ReviewGenerator.generate_single_command_review(mastery, @user)

    {
      id: review_content[:id],
      type: 'quick_review',
      priority: PRIORITIES[:critical_review],
      content: review_content[:content],
      metadata: review_content[:content].merge({
        is_review: true,
        review_type: 'failed_lab',
        review_reason: "Failed in lab: #{lab_attempt.hands_on_lab.title}",
        lab_attempt_id: lab_attempt.id
      }),
      scoring: review_content[:scoring]
    }
  end

  def current_chapter_position
    session = @user.learning_sessions.active.first
    return 0 unless session

    current_chapter = session.get_state('current_chapter')
    return 0 unless current_chapter

    DockerContentLibrary.learning_path_order.index(current_chapter) || 0
  end

  def get_urgent_reviews(exclude_ids)
    # Find commands with < 50% retention (urgent decay)
    # Skip if exclude_ids is not an array or if user has no masteries
    return nil if @user.command_masteries.empty?
    
    masteries = if exclude_ids.present? && exclude_ids.is_a?(Array)
                  @user.command_masteries.where.not(id: exclude_ids)
                else
                  @user.command_masteries
                end
    
    masteries = masteries.where('last_used_at < ?', 7.days.ago)

    urgent = masteries.select do |mastery|
      decay_service = HybridDecayService.new(mastery)
      current_score = decay_service.current_decayed_score
      current_score < 50
    end.first

    return nil unless urgent

    # Pick next unfinished micro for this chapter
    micro = pick_best_micro_for_chapter(urgent.canonical_command)
    return nil unless micro

    decay_service = HybridDecayService.new(urgent)
    current_score = decay_service.current_decayed_score
    
    {
      id: "review_#{urgent.id}",
      type: 'interactive',
      priority: PRIORITIES[:urgent_decay],
      canonical_command: urgent.canonical_command,
      retention: current_score,
      content: micro[:content],
      metadata: {
        is_review: true,
        review_reason: 'decay',
        previous_score: urgent.proficiency_score.round(1),
        retention_level: current_score.round(1),
        is_urgent: true,
        needs_review: true,
        chapter: urgent.canonical_command,
        micro_id: micro[:id]
      }
    }
  end
  
  def get_failed_recent_items(exclude_ids)
    # Skip failed items for brand new sessions (within first 2 minutes)
    current_session = @user.learning_sessions.active.first
    if current_session && current_session.started_at > 2.minutes.ago
      return nil
    end
    
    # Get items failed in last 24 hours from learning sessions (excluding current session)
    recent_sessions = @user.learning_sessions
                           .where('created_at > ?', 24.hours.ago)
                           .where.not(id: current_session&.id)
    
    failed_items = []
    recent_sessions.each do |session|
      responses = session.state_data['responses'] || []
      failed = responses.select { |r| !r['correct'] }
      failed_items.concat(failed.map { |r| r['item_id'] })
    end
    
    failed_items -= exclude_ids
    return nil if failed_items.empty?
    
    # Get the chapter/micro for the failed item and return as interactive
    # For now, just skip failed items (they're handled by weakness areas)
    return nil
  end
  
  def maybe_insert_stealth_review(exclude_ids)
    return nil if rand > STEALTH_REVIEW_PROBABILITY

    # Get a stealth review from generator
    generator = StealthReviewGenerator.new(user_id: @user.id)
    reviews = generator.generate_lesson_reviews(1)

    return nil if reviews.empty?

    review = reviews.first

    # Convert stealth review into an interactive micro for the same chapter
    chapter = review[:canonical_command] || review.try(:canonical_command)

    # Don't show stealth review for commands at 100% mastery - they've already learned it!
    mastery = @user.command_masteries.find_by(canonical_command: chapter)
    return nil if mastery && mastery.proficiency_score >= 100

    micro = pick_best_micro_for_chapter(chapter)
    return nil unless micro
    
    {
      id: "stealth_#{review[:id] || review.try(:id) || SecureRandom.hex(4)}",
      type: 'interactive',
      priority: PRIORITIES[:stealth_review],
      content: micro[:content],
      metadata: {
        is_review: true,
        review_reason: 'stealth',
        is_stealth_review: true,
        stealth_disguise: review[:disguise_text] || review.try(:disguise_prompt),
        insertion_strategy: review[:strategy] || review.try(:insertion_strategy),
        chapter: chapter,
        micro_id: micro[:id],
        canonical_command: chapter
      }
    }
  end
  
  def get_weakness_areas(exclude_ids)
    # Find commands with < 60% mastery
    return nil if @user.command_masteries.empty?
    
    # Skip weakness areas for brand new sessions (within first 5 minutes)
    current_session = @user.learning_sessions.active.first
    if current_session && current_session.started_at > 5.minutes.ago
      return nil
    end
    
    weak_masteries = if exclude_ids.present? && exclude_ids.is_a?(Array)
                       @user.command_masteries.where.not(id: exclude_ids)
                     else
                       @user.command_masteries
                     end
    
    weak_masteries = weak_masteries.where('proficiency_score < ?', 60)
                                   .order(:proficiency_score)
                          .first
    
    return nil unless weak_masteries
    
    # Pick next unfinished micro for this chapter
    micro = pick_best_micro_for_chapter(weak_masteries.canonical_command)
    return nil unless micro
    
    {
      id: "weakness_#{weak_masteries.id}",
      type: 'interactive',
      priority: PRIORITIES[:weakness_area],
      canonical_command: weak_masteries.canonical_command,
      mastery_score: weak_masteries.proficiency_score,
      content: micro[:content],
      metadata: { 
        is_review: true,
        review_reason: 'low_mastery',
        previous_score: weak_masteries.proficiency_score.round(1),
        is_weakness: true,
        current_score: weak_masteries.proficiency_score,
        chapter: weak_masteries.canonical_command,
        micro_id: micro[:id]
      }
    }
  end
  
  def get_learning_path_content(exclude_ids)
    # Get next chapter for user
    next_chapter = @content_library.get_next_chapter_for_user(@user)
    micro = pick_best_micro_for_chapter(next_chapter)
    
    return nil unless micro
    
    # Determine content type:
    # - 'lesson' for base micros (first teaching micro in a chapter)
    # - 'interactive' for database units (codesprout-*) or new learning path content
    # - 'practice' only for follow-up practice micros within the same chapter
    content_type = if micro[:id].to_s.end_with?('_base')
      'lesson'
    elsif InteractiveLearningUnit.exists?(slug: next_chapter)
      # Database unit - should show as interactive lesson, not practice
      'interactive'
    else
      # For hardcoded lessons, check if user has completed the base micro
      session = @user.learning_sessions.active.first
      if session
        completed = (session.state_data['completed_micros'] || {})[next_chapter] || []
        base_micro_id = "#{next_chapter.split(' ').first}_base"
        if completed.include?(base_micro_id)
          'practice'  # User already learned, now practicing
        else
          'interactive'  # User hasn't learned yet, show as lesson
        end
      else
        'interactive'  # New session, show as lesson
      end
    end
    
    {
      id: "lesson_#{SecureRandom.hex(4)}",
      type: content_type,
      priority: PRIORITIES[:learning_path],
      content: normalize_micro_content(micro),
      metadata: { 
        is_learning_path: true,
        canonical_command: next_chapter,
        chapter: next_chapter,
        micro_id: micro[:id]
      }
    }
  end

  def get_continue_current_chapter_content
    session = @user.learning_sessions.active.first
    return nil unless session
    chapter = session.state_data['current_chapter']
    micro_id = session.state_data['current_micro']
    
    Rails.logger.info "🔍 get_continue_current_chapter_content: chapter=#{chapter}, micro_id=#{micro_id}"
    
    return nil unless chapter && micro_id
    
    # Check if this micro is already completed
    completed = (session.state_data['completed_micros'] || {})[chapter] || []
    
    Rails.logger.info "🔍 Completed micros for #{chapter}: #{completed.inspect}"
    
    if completed.include?(micro_id)
      Rails.logger.info "⚠️ Current micro #{micro_id} is already completed, should get next micro"
      # Current micro is complete, get the next one
      next_micro = @content_library.get_next_micro(chapter, micro_id)
      
      if next_micro
        Rails.logger.info "✅ Found next micro: #{next_micro[:id]}"
        # Update session to point to next micro
        session.update_state('current_micro', next_micro[:id])
        # If this is a database unit (next_micro[:id] is a slug), also update chapter
        if defined?(InteractiveLearningUnit) && InteractiveLearningUnit.find_by(slug: next_micro[:id])
          session.update_state('current_chapter', next_micro[:id])
        end
        micro = next_micro
        micro_id = next_micro[:id]
      else
        Rails.logger.info "⚠️ No next micro found in chapter #{chapter}, advancing to next chapter"
        # For database units (single micro per unit), advance to next chapter
        # Clear current chapter/micro so next_chapter logic picks the right one
        next_chapter = @content_library.get_next_chapter_for_user(@user)
        if next_chapter && next_chapter != chapter
          Rails.logger.info "✅ Advancing to next chapter: #{next_chapter}"
          first_micro = @content_library.get_first_micro_for_chapter(next_chapter)
          if first_micro
            session.update_state('current_chapter', next_chapter)
            session.update_state('current_micro', first_micro[:id])
            # Return nil so Priority 7 handles it, or recursively get content for new chapter
            return get_learning_path_content([])
          end
        end
        return nil # No more micros in this chapter, advance to next chapter
      end
    else
      # Current micro not completed yet, continue with it
      micro = @content_library.get_micro_lesson(chapter, micro_id)
      Rails.logger.info "📝 Current micro not completed yet, continuing with: #{micro_id}"
    end
    
    return nil unless micro
    
    {
      id: "continue_#{chapter}_#{micro_id}",
      type: 'interactive',
      priority: PRIORITIES[:learning_path],
      content: micro[:content],
      metadata: {
        is_learning_path: true,
        chapter: chapter,
        micro_id: micro_id,
        canonical_command: chapter
      }
    }
  end

  def get_ready_lab_content
    # Gate labs so they don't appear too early
    current_session = @user.learning_sessions.active.first
    return nil unless current_session && current_session.items_presented >= 3

    eligible = @content_library.eligible_labs_for_user(@user)
    # Skip labs with no explicit prerequisites to avoid surprising unlocks
    eligible = eligible.select { |lab| (lab[:requires_mastery] || []).any? }
    return nil if eligible.empty?
    lab = eligible.first
    {
      id: lab[:id],
      type: 'lab',
      priority: PRIORITIES[:lab_ready],
      content: {
        title: lab[:title],
        scenario: lab[:scenario] || lab[:description],
        description: lab[:description],
        objectives: lab[:objectives] || [],
        current_instruction: (lab[:steps].first[:instruction] rescue nil),
        hints_available: 0
      },
      metadata: {
        lab_id: lab[:id],
        step_count: lab[:steps].length,
        is_lab_unlock: true,
        prerequisites: lab[:requires_mastery]
      }
    }
  end
  
  def get_new_content(exclude_ids)
    # Try to get next module/lesson from database first
    db_content = get_next_database_content
    return db_content if db_content
    
    # Fallback to chapter-based progression
    next_chapter = @content_library.get_next_chapter_for_user(@user)
    micro = pick_best_micro_for_chapter(next_chapter)
    
    return nil unless micro
    
    {
      id: "new_#{SecureRandom.hex(4)}",
      type: 'interactive',
      priority: PRIORITIES[:new_content],
      content: micro[:content],
      metadata: { 
        is_new_content: true,
        canonical_command: next_chapter,
        chapter: next_chapter,
        micro_id: micro[:id]
      }
    }
  end
  
  def get_next_database_content
    # Get Docker course and find next uncompleted module
    docker_course = Course.find_by(slug: 'docker-fundamentals')
    return nil unless docker_course
    
    # Find first module that user hasn't completed
    modules = docker_course.course_modules.published.order(:sequence_order)
    
    modules.each do |mod|
      # Check if user has completed this module
      enrollment = CourseEnrollment.find_by(user: @user, course: docker_course)
      next if enrollment && ModuleProgress.find_by(course_enrollment: enrollment, course_module: mod, completed: true)
      
      # Get first item in this module
      content = @content_library.get_module_content(mod.id)
      return content if content
    end
    
    # If all modules complete, return first interactive unit
    unit = InteractiveLearningUnit.order(:sequence_order).first
    return nil unless unit
    
    micro = @content_library.convert_unit_to_micro_lesson(unit)
    {
      id: "unit_#{unit.id}",
      type: 'interactive',
      priority: PRIORITIES[:new_content],
      content: micro[:content],
      metadata: {
        is_new_content: true,
        unit_id: unit.id,
        micro_id: micro[:id],
        chapter: unit.slug,
        canonical_command: unit.slug
      }
    }
  end
  
  def get_content_library_for_track(track)
    case track
    when 'kubernetes', 'k8s'
      KubernetesContentLibrary
    else # default to docker
      DockerContentLibrary
    end
  end
  
  def generate_review_content(mastery)
    practice_content = @content_library.get_practice_content(mastery.canonical_command)
    decay_service = HybridDecayService.new(mastery)
    current_score = decay_service.current_decayed_score
    {
      title: practice_content[:title] || "Review: #{mastery.canonical_command}",
      description: practice_content[:description] || "Your retention has dropped to #{current_score.round(1)}%. Let's practice!"
    }
  end
  
  def generate_retry_content(item_id)
    {
      title: "Let's Try This Again",
      description: "Practice makes perfect! Let's reinforce your understanding with another attempt."
    }
  end
  
  def generate_practice_content(mastery)
    practice_content = @content_library.get_practice_content(mastery.canonical_command)
    {
      title: practice_content[:title] || "Practice: #{mastery.canonical_command}",
      description: practice_content[:description] || "Improve your mastery from #{mastery.proficiency_score}% by practicing this command."
    }
  end
  
  # Ensure first session item starts with the first chapter of the path (docker run)
  def get_start_of_session_content
    first_chapter = learning_path.first
    micro = pick_best_micro_for_chapter(first_chapter)
    return nil unless micro
    {
      id: "start_#{SecureRandom.hex(4)}",
      type: 'interactive',
      priority: PRIORITIES[:learning_path],
      content: micro[:content],
      metadata: {
        is_learning_path: true,
        canonical_command: first_chapter,
        chapter: first_chapter,
        micro_id: micro[:id]
      }
    }
  end

  # Resolve learning path with method-first, constant fallback for compatibility
  def learning_path
    raw_path = if @content_library.respond_to?(:learning_path_order)
      @content_library.learning_path_order
    else
      @content_library::LEARNING_PATH_ORDER
    end

    # Flatten module-grouped structure to array of chapter slugs
    if raw_path.first.is_a?(Hash) && raw_path.first[:module_id]
      # Module-grouped structure: [{module_id, items: [...]}, ...]
      # Extract all items from all modules into a flat array
      raw_path.flat_map { |mod| mod[:items] }
    else
      # Legacy flat structure: ['chapter1', 'chapter2', ...]
      raw_path
    end
  end
  
  # Pick the next unfinished micro for a chapter, falling back to first micro
  def pick_best_micro_for_chapter(chapter)
    # PRIORITY 1: Check if chapter is a database unit slug
    unit = InteractiveLearningUnit.find_by(slug: chapter, published: true)
    if unit
      Rails.logger.info "✅ Found database unit: #{unit.slug}"
      return @content_library.convert_unit_to_micro_lesson(unit)
    end
    
    # PRIORITY 2: Check if it's a lab-based chapter
    if @content_library.respond_to?(:lab_chapter?) && @content_library.lab_chapter?(chapter)
      lab_id = @content_library.lab_id_from_chapter(chapter)
      if lab_id
        lab_content = @content_library.get_lab_as_chapter(lab_id)
        return lab_content[:micro_lessons].first if lab_content && lab_content[:micro_lessons].present?
      end
    end
    
    # PRIORITY 3: Try database-first approach via library method
    first_micro = @content_library.get_first_micro_for_chapter(chapter)
    return first_micro if first_micro
    
    # No more fallbacks - everything is in database
    nil
  end

  # Ensure practice micros have a description that the testing view can show
  def normalize_micro_content(micro)
    content = (micro[:content] || {}).dup
    if content[:description].to_s.strip.empty? && content[:task]
      content[:description] = content[:task]
    end
    content
  end
end
