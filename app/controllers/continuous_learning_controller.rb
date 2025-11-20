class ContinuousLearningController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!
  before_action :ensure_user
  before_action :set_track
  before_action :find_or_create_session, only: [:index, :respond, :execute_lab_command]
  
  # GET /learn - The ONLY learning endpoint
  def index
    # Validate and reset session state if it's from a different track
    content_library = get_content_library
    stored_chapter = @session.get_state('current_chapter')
    stored_micro = @session.get_state('current_micro')
    
    # Handle chapter parameter for direct navigation
    direct_navigation = false
    if params[:chapter].present?
      requested_chapter = params[:chapter]
      Rails.logger.info "📍 User requested chapter: #{requested_chapter}"

      # Check if this is a valid chapter/unit
      unit = InteractiveLearningUnit.find_by(slug: requested_chapter, published: true) if defined?(InteractiveLearningUnit)
      if unit || content_library.get_first_micro_for_chapter(requested_chapter)
        # Set session to requested chapter
        first_micro = content_library.get_first_micro_for_chapter(requested_chapter)
        if first_micro
          @session.update_state('current_chapter', requested_chapter)
          @session.update_state('current_micro', first_micro[:id])
          stored_chapter = requested_chapter
          stored_micro = first_micro[:id]
          direct_navigation = true
          Rails.logger.info "✅ Navigated to chapter: #{requested_chapter}, micro: #{first_micro[:id]}"
        end
      else
        Rails.logger.warn "⚠️ Invalid chapter requested: #{requested_chapter}"
      end
    end
    
    # If stored chapter doesn't belong to current track, reset session state
    if stored_chapter.present? && !learning_path_for(content_library).include?(stored_chapter)
      Rails.logger.info "🔄 Resetting session: chapter '#{stored_chapter}' not in #{@track} track"
      @session.update_state('current_chapter', nil)
      @session.update_state('current_micro', nil)
    elsif stored_chapter.present? && stored_micro.present?
      # Validate that micro belongs to chapter
      micro_exists = content_library.get_micro_lesson(stored_chapter, stored_micro)
      unless micro_exists
        Rails.logger.info "🔄 Resetting session: micro '#{stored_micro}' doesn't belong to chapter '#{stored_chapter}'"
        @session.update_state('current_micro', nil)
      end
    end
    
    # BEFORE using adaptive selector: Check if current chapter/micro is already completed
    # If so, advance to next incomplete chapter and show it directly
    auto_advanced = false
    if !direct_navigation && stored_chapter && stored_micro
      Rails.logger.info "🔍 Checking if current chapter is completed: chapter=#{stored_chapter}, micro=#{stored_micro}"
      completed = (@session.state_data['completed_micros'] || {})[stored_chapter] || []
      Rails.logger.info "🔍 Completed micros for #{stored_chapter}: #{completed.inspect}"

      if completed.include?(stored_micro)
        Rails.logger.info "⚠️ Current micro #{stored_micro} in chapter #{stored_chapter} is already completed on page load"
        # Advance to next incomplete chapter
        next_chapter = content_library.get_next_chapter_for_user(current_user)
        Rails.logger.info "🔍 Next incomplete chapter from library: #{next_chapter}"

        if next_chapter && next_chapter != stored_chapter
          Rails.logger.info "✅ Auto-advancing from completed chapter #{stored_chapter} to next chapter: #{next_chapter}"
          first_micro = content_library.get_first_micro_for_chapter(next_chapter)
          if first_micro
            Rails.logger.info "✅ Found first micro for next chapter: #{first_micro[:id]}"
            @session.update_state('current_chapter', next_chapter)
            @session.update_state('current_micro', first_micro[:id])
            # Reload session to ensure we have fresh state
            @session.reload
            stored_chapter = next_chapter
            stored_micro = first_micro[:id]
            auto_advanced = true
            Rails.logger.info "✅ Session updated to: chapter=#{stored_chapter}, micro=#{stored_micro}"
          else
            Rails.logger.warn "⚠️ Could not find first micro for next chapter #{next_chapter}"
          end
        else
          Rails.logger.info "ℹ️ Next chapter is same as current or nil: #{next_chapter.inspect}"
        end
      else
        Rails.logger.info "✅ Current micro #{stored_micro} is NOT completed yet, continuing"
      end
    end

    # Use adaptive selector as the single source of truth
    # BUT: If user directly navigated OR we auto-advanced, show that chapter directly
    if (direct_navigation || auto_advanced) && stored_chapter && stored_micro
      # Direct navigation or auto-advance takes precedence - show the requested chapter/micro
      micro = content_library.get_micro_lesson(stored_chapter, stored_micro)
      if micro
        @content = {
          id: auto_advanced ? "auto_advance_#{stored_chapter}_#{stored_micro}" : "direct_nav_#{stored_chapter}_#{stored_micro}",
          type: 'interactive',
          priority: 0, # Highest priority
          content: micro[:content],
          metadata: {
            is_learning_path: true,
            chapter: stored_chapter,
            micro_id: stored_micro,
            canonical_command: stored_chapter,
            direct_navigation: direct_navigation,
            auto_advanced: auto_advanced
          }
        }
        Rails.logger.info "✅ Showing #{auto_advanced ? 'auto-advanced' : 'directly navigated'} content: #{stored_chapter} / #{stored_micro}"
      else
        # Fallback to selector if micro not found
        Rails.logger.warn "⚠️ Could not find micro, falling back to selector"
        selector = AdaptiveContentSelector.new(current_user, @track)
        @content = selector.next_content
      end
    else
      # Normal flow - use adaptive selector
      Rails.logger.info "ℹ️ Using adaptive selector for content selection"
      selector = AdaptiveContentSelector.new(current_user, @track)
      @content = selector.next_content
    end
    
    # If interactive micro (lesson/practice), sync session with chapter/micro
    # UNLESS this was direct navigation (already synced above)
    if @content && ['interactive', 'lesson', 'practice'].include?(@content[:type]) && @content[:metadata] && !direct_navigation
      chapter = @content[:metadata][:chapter]
      micro_id = @content[:metadata][:micro_id]
      if chapter && micro_id
        @session.update_state('current_chapter', chapter)
        @session.update_state('current_micro', micro_id)
        @session.update_state('current_canonical_command', chapter)
      end
      @session.update_state('current_item_type', @content[:type])
      @session.update_state('current_item_id', micro_id || @content[:id])
    elsif @content && @content[:type] == 'quiz'
      # Handle quiz content
      @session.update_state('current_item_type', 'quiz')
      @session.update_state('current_item_id', @content[:id])
      if @content[:metadata]
        @session.update_state('current_quiz_id', @content[:metadata][:quiz_id])
        @session.update_state('current_question_index', 0)
      end
    elsif @content && (@content[:type] == 'lab' || @content[:type] == 'comprehensive_lab')
      # Prepare lab session state
      @session.update_state('current_item_type', 'lab')
      @session.update_state('current_item_id', @content[:id])
      if @content[:metadata]
        @session.update_state('current_lab_id', @content[:metadata][:lab_id])
        @session.update_state('current_lab_step_index', 0)
      end
    elsif @content && ['quick_review', 'scenario_review', 'review'].include?(@content[:type])
      # Handle review content - temporarily set session to review command for validation
      @session.update_state('current_item_type', 'review')
      @session.update_state('current_item_id', @content[:id])
      # Store the expected command for validation
      if @content[:content] && @content[:content][:command_to_learn]
        @session.update_state('current_review_command', @content[:content][:command_to_learn])
        @session.update_state('current_canonical_command', @content[:content][:command_to_learn])
      end
    end

    @session.update_state('current_state', (@content && @content[:type]) || 'INTERACTIVE')
    @session.touch_activity!
    
    # Create lightweight lab session ID (no container needed - commands run on host)
    if @content && ['interactive', 'lab', 'comprehensive_lab'].include?(@content[:type]) && !@session.get_state('lab_session_id')
      Rails.logger.info "🚀 Creating lab session for content type: #{@content[:type]}"
      # Generate session ID without creating a container
      session_id = "#{Time.current.to_i}_#{SecureRandom.hex(4)}"
      @session.update_state('lab_session_id', session_id)
      Rails.logger.info "✅ Lab session created: #{session_id} (host execution mode)"
    end

    render :index
  end
  
  # GET /kubernetes/course - New React-based Kubernetes course UI
  def kubernetes_course
    @current_user = current_user if respond_to?(:current_user)
    @current_user ||= User.first || User.create!(account_id: "demo-#{SecureRandom.hex(4)}")

    # Get initial data for React
    content_library = KubernetesContentLibrary
    learning_path = learning_path_for(content_library)

    # Get user progress
    @completed_lessons = @current_user.command_masteries
      .where(canonical_command: learning_path)
      .where('proficiency_score >= ?', 50)
      .pluck(:canonical_command)

    @total_lessons = learning_path.length
    @progress_percentage = @total_lessons > 0 ? ((@completed_lessons.length.to_f / @total_lessons) * 100).round : 0

    # Use minimal layout to avoid loading problematic dependencies
    render :kubernetes_course, layout: false
  end

  # GET /learn/react - React learning interface
  def react
    @track = params[:track] || 'docker'
    ensure_user
    render 'continuous_learning/react', layout: false
  end

  # POST /learn/respond - Handle user responses for lesson/practice micros
  def respond
    response_type = params[:response_type] || params[:action]
    user_input = params[:response] || params[:answer]
    current_item_type = @session.get_state('current_item_type')

    # For reviews, use the review command instead of current_chapter
    if current_item_type == 'review'
      current_chapter = @session.get_state('current_review_command')
      current_micro_id = current_chapter  # For reviews, micro_id is the same as command
      content_library = get_content_library
      # Create a synthetic micro for validation
      current_micro = {
        id: current_chapter,
        content: {
          command_to_learn: current_chapter,
          expected_command: current_chapter
        },
        validation: {
          type: 'command',
          expected_command: current_chapter
        }
      }
    else
      current_chapter = @session.get_state('current_chapter')
      current_micro_id = @session.get_state('current_micro')
      content_library = get_content_library
      current_micro = content_library.get_micro_lesson(current_chapter, current_micro_id)
    end

    # Understanding confirmed from teaching → advance to next micro
    if response_type == 'understanding_confirmed'
      next_micro = content_library.get_next_micro(current_chapter, current_micro_id)
      with_db_retry do
        if next_micro
          @session.mark_micro_complete(current_chapter, current_micro_id)
          if defined?(InteractiveLearningUnit) && InteractiveLearningUnit.find_by(slug: next_micro[:id])
            @session.update_state('current_chapter', next_micro[:id])
          end
          @session.update_state('current_micro', next_micro[:id])
        else
          advance_to_next_chapter
        end
      end
      selector = AdaptiveContentSelector.new(current_user, @track)
      next_content = selector.next_content
      render json: {
        success: true,
        feedback: 'Great! Let\'s practice it now.',
        next_content: next_content,
        session_stats: session_stats_hash
      }
      return
    end

    # Skip review - clear review state and get next content
    if response_type == 'skip_review'
      Rails.logger.info "⏭️ User skipped review"

      # Clear review state
      @session.update_state('current_item_type', nil)
      @session.update_state('current_review_command', nil)

      # Get next non-review content
      selector = AdaptiveContentSelector.new(current_user, @track)
      next_content = selector.next_content(exclude_review: true)

      render json: {
        success: true,
        skipped: true,
        next_content: next_content,
        session_stats: session_stats_hash
      }
      return
    end

    # Practice answer validation
    if response_type == 'test_answer'
      # For reviews, do exact command matching instead of using lenient validator
      if current_item_type == 'review' && current_micro&.dig(:expected_command)
        expected = current_micro[:expected_command].strip
        user_normalized = user_input.strip

        if user_normalized == expected
          validation = { valid: true, message: "Perfect! Exactly right!" }
        else
          validation = { valid: false, message: "Not quite. Expected: #{expected}" }
        end
      else
        # For lessons, use the normal validator
        spec = (current_micro && current_micro[:validation]) || {}
        validator = get_validator_for_track

        # EXECUTE the Docker command first (with user namespace isolation)
        execution_result = if @track == 'docker'
          executor = DockerExecutionService.new(current_user)
          # For reviews, need to map command back to chapter slug for prerequisites
          chapter_for_prereqs = if current_item_type == 'review'
            ReviewGenerator.get_original_chapter_slug(current_chapter)
          else
            current_chapter
          end
          executor.execute(user_input, chapter: chapter_for_prereqs)
        else
          # For non-Docker tracks, skip execution
          { success: true, output: "", error: "" }
        end

        # Validate with execution result
        validation = validator.validate(user_input, execution_result, spec)
      end
      if validation[:valid]
        # Initialize variables before db block
        mastery = nil
        mastery_boost = 0

        # Wrap all database operations in retry logic
        with_db_retry do
          @session.mark_micro_complete(current_chapter, current_micro_id)
          @session.record_response(current_micro_id, true, params[:response_time]&.to_f || 0)

          # For reviews, find mastery by chapter slug, not command
          canonical_for_mastery = if current_item_type == 'review'
            ReviewGenerator.get_original_chapter_slug(current_chapter)
          else
            current_chapter
          end

          mastery = current_user.command_masteries.find_or_create_by(canonical_command: canonical_for_mastery)

          # Get attempt context from params (progressive mastery tracking)
          attempt_context = if params[:attempt_context].present?
            params[:attempt_context].to_unsafe_h.symbolize_keys
          else
            {}
          end
          attempt_context[:consecutive_successes] = mastery.consecutive_successes || 0

          # Store old score to calculate boost
          old_score = mastery.proficiency_score

          # Update attempts count
          mastery.total_attempts += 1
          mastery.successful_attempts += 1

          # Use MasteryCalculator for progressive mastery boost
          MasteryCalculator.update_on_success!(mastery, attempt_context)

          # Calculate actual boost for feedback
          mastery_boost = (mastery.proficiency_score - old_score).round

          # For reviews, clear review state and don't advance
          if current_item_type == 'review'
            @session.update_state('current_item_type', nil)
            @session.update_state('current_review_command', nil)
            # Don't update current_chapter/micro for reviews - keep user where they were
          else
            # Proactively advance session state for DB-first units so a refresh shows the next unit
            next_micro = content_library.get_next_micro(current_chapter, current_micro_id)
            if next_micro
              if defined?(InteractiveLearningUnit) && InteractiveLearningUnit.find_by(slug: next_micro[:id])
                @session.update_state('current_chapter', next_micro[:id])
              end
              @session.update_state('current_micro', next_micro[:id])
            else
              # No next micro in this chapter (typical for DB units) → advance to next chapter
              next_chapter = content_library.get_next_chapter_for_user(current_user)
              if next_chapter && next_chapter != current_chapter
                # For DB units, micro id equals slug; for legacy, fetch first micro
                first_micro = content_library.get_first_micro_for_chapter(next_chapter) || { id: next_chapter }
                @session.update_state('current_chapter', next_chapter)
                @session.update_state('current_micro', first_micro[:id])
              end
            end
          end
        end
        # Next step from selector
        selector = AdaptiveContentSelector.new(current_user, @track)
        next_content = selector.next_content(last_correct: true)
        render json: {
          success: true,
          correct: true,
          feedback: validation[:message],
          mastery_boost: mastery_boost,
          new_mastery: mastery.proficiency_score.round,
          next_content: next_content,
          advance_to_next: true,
          session_stats: session_stats_hash
        }
      else
        # Progressive hinting with retry
        hint_index = @session.get_state('hint_count') || 0
        with_db_retry do
          @session.update_state('hint_count', hint_index + 1)
        end
        render json: {
          success: true,
          correct: false,
          feedback: validation[:message],
          hint: current_micro&.dig(:hints, hint_index)
        }
      end
      return
    end

    render json: { success: false, message: 'Unknown response' }
  end
  
  # POST /learn/execute - Execute lab command
  def execute_lab_command
    command = params[:command]
    lab_session_id = @session.get_state('lab_session_id')
    
    # Create session ID if missing (lightweight, no container)
    unless lab_session_id
      lab_session_id = "#{Time.current.to_i}_#{SecureRandom.hex(4)}"
      @session.update_state('lab_session_id', lab_session_id)
    end
    
    # Use track-specific lab runner
    lab_runner = get_lab_runner_for_track(current_user.id, lab_session_id)
    
    result = lab_runner.execute_command(command)
    
    # Branch: lab multi-step vs interactive micro
    if @session.get_state('current_item_type') == 'lab'
      lab_id = @session.get_state('current_lab_id')
      step_index = (@session.get_state('current_lab_step_index') || 0).to_i
      # Use appropriate content library based on track
      content_library = get_content_library
      lab_def = content_library.get_lab(lab_id)
      unless lab_def
        render json: { success: false, error: 'Unknown lab' }
        return
      end
      current_step = lab_def[:steps][step_index]
      exercise_like = { validation: current_step[:validation] }
      validator = get_validator_for_track
      validation_result = validator.validate(command, result, exercise_like)
      if validation_result[:valid]
        # Advance to next step with retry
        step_index += 1
        if step_index < lab_def[:steps].length
          with_db_retry do
            @session.reload
            @session.update_state('current_lab_step_index', step_index)
          end
          next_instruction = lab_def[:steps][step_index][:instruction]
          render json: {
            success: true,
            output: (result[:output] || [result[:stdout], result[:stderr]].compact.join),
            correct: true,
            feedback: validation_result[:message],
            advance_to_next_step: true,
            next_instruction: next_instruction,
            step_position: "#{step_index + 1} of #{lab_def[:steps].length}"
          }
        else
          # Lab complete with retry
          with_db_retry do
            @session.reload
            @session.update_state('current_lab_id', nil)
            @session.update_state('current_lab_step_index', nil)
            
            # Mark the lab as completed in the session
            current_chapter = @session.get_state('current_chapter')
            if current_chapter && current_chapter.start_with?('lab_')
              # Mark lab chapter as complete and advance to next chapter
              @session.mark_micro_complete(current_chapter, 'lab_complete')
              advance_to_next_chapter
            end
            
            # Give mastery boost for prerequisites
            (lab_def[:requires_mastery] || []).each do |cmd|
              m = current_user.command_masteries.find_or_create_by(canonical_command: cmd)
              m.update!(
                proficiency_score: [m.proficiency_score + 10, 100].min,
                last_used_at: Time.current
              )
            end
          end
          render json: {
            success: true,
            output: (result[:output] || [result[:stdout], result[:stderr]].compact.join),
            correct: true,
            feedback: 'Lab complete! Great job. Moving to next lesson...',
            lab_complete: true
          }
        end
      else
        render json: {
          success: result[:success],
          output: (result[:output] || [result[:stdout], result[:stderr]].compact.join),
          correct: false,
          feedback: validation_result[:message]
        }
      end
    else
      # Interactive micro flow
      current_chapter = @session.get_state('current_chapter')
      current_micro_id = @session.get_state('current_micro')
      # Use appropriate content library based on track
      content_library = get_content_library
      
      Rails.logger.info "🔍 Looking for micro: track=#{@track}, chapter=#{current_chapter}, micro_id=#{current_micro_id}, library=#{content_library.name}"
      
      # Validate that chapter exists in current track's content library
      if current_chapter.present? && !learning_path_for(content_library).include?(current_chapter)
        Rails.logger.warn "⚠️ Chapter '#{current_chapter}' not in #{@track} track, resetting to first chapter"
        current_chapter = nil
        current_micro_id = nil
      end
      
      current_micro = content_library.get_micro_lesson(current_chapter, current_micro_id)
      
      # Also validate that micro_id actually belongs to the chapter if chapter exists
      if current_chapter.present? && current_micro_id.present? && current_micro.nil?
        Rails.logger.warn "⚠️ Micro ID '#{current_micro_id}' doesn't belong to chapter '#{current_chapter}', resetting"
        current_micro_id = nil
        # Try to get first micro for the chapter
        current_micro = content_library.get_first_micro_for_chapter(current_chapter)
      end
      
      # Handle case where micro doesn't exist (wrong track or invalid chapter)
      unless current_micro
        Rails.logger.error "❌ Micro not found: track=#{@track}, chapter=#{current_chapter}, micro_id=#{current_micro_id}"
        
        # Try to reset to first chapter if we're lost
        if current_chapter.blank? || current_micro_id.blank? || !learning_path_for(content_library).include?(current_chapter)
          Rails.logger.info "⚠️ Missing/invalid chapter/micro, resetting to first chapter"
          first_chapter = learning_path_for(content_library).first
          first_micro = content_library.get_first_micro_for_chapter(first_chapter)
          
          if first_micro
            with_db_retry do
              @session.reload
              @session.update_state('current_chapter', first_chapter)
              @session.update_state('current_micro', first_micro[:id])
            end
            current_chapter = first_chapter
            current_micro_id = first_micro[:id]
            current_micro = first_micro
            Rails.logger.info "✅ Reset to: chapter=#{current_chapter}, micro_id=#{current_micro_id}"
          end
        end
        
        unless current_micro
          render json: {
            success: false,
            error: "No lesson found for chapter '#{current_chapter}' micro '#{current_micro_id}'. Track: #{@track}. Visit /#{@track}/learn to start fresh."
          }
      return
    end
      end
      
      # If we reset the micro_id, update session state
      if current_micro_id != @session.get_state('current_micro')
        with_db_retry do
          @session.reload
          @session.update_state('current_micro', current_micro_id)
        end
      end
    
      validator = get_validator_for_track
      validation_result = validator.validate(command, result, current_micro[:validation])
      
      if validation_result[:valid]
        # Batch all state updates in a transaction with retry logic
        with_db_retry do
          completed = @session.state_data['completed_micros'] || {}
          completed[current_chapter] ||= []
          completed[current_chapter] << current_micro_id unless completed[current_chapter].include?(current_micro_id)
          
          responses = @session.state_data['responses'] || []
          responses << {
            'item_id' => current_micro_id,
            'correct' => true,
            'response_time' => 0,
            'timestamp' => Time.current.iso8601
          }
          
          # Reload session to get latest state before updating
          @session.reload
          
          @session.update!(
            items_presented: @session.items_presented + 1,
            items_correct: @session.items_correct + 1,
            state_data: @session.state_data.merge(
              'completed_micros' => completed,
              'responses' => responses,
              'hint_count' => 0
            )
          )
          
          mastery = current_user.command_masteries.find_or_create_by(
            canonical_command: current_chapter
          )
          mastery.update!(
            proficiency_score: 100,
            last_used_at: Time.current,
            total_attempts: mastery.total_attempts + 1,
            successful_attempts: mastery.successful_attempts + 1
          )
        end
    
        # Use appropriate content library based on track
        content_library = get_content_library
        next_micro = content_library.get_next_micro(current_chapter, current_micro_id)
        
        # Update micro state with retry
        with_db_retry do
          @session.reload
          if next_micro
            # If next_micro is a DB unit (slug), advance both chapter and micro
            if defined?(InteractiveLearningUnit) && InteractiveLearningUnit.find_by(slug: next_micro[:id])
              @session.update_state('current_chapter', next_micro[:id])
            end
            @session.update_state('current_micro', next_micro[:id])
          else
            advance_to_next_chapter
          end
        end
        
        render json: {
          success: true,
          output: (result[:output] || [result[:stdout], result[:stderr]].compact.join),
          correct: true,
          feedback: validation_result[:message],
          advance_to_next: true,
          session_stats: session_stats_hash
        }
      else
        hint_index = @session.get_state('hint_count') || 0
        
        # Single update with retry to avoid database locks
        with_db_retry do
          @session.reload
          @session.update!(
            state_data: @session.state_data.merge('hint_count' => hint_index + 1)
          )
        end
        
        render json: {
          success: result[:success],
          output: (result[:output] || [result[:stdout], result[:stderr]].compact.join),
          correct: false,
          feedback: validation_result[:message],
          hint: current_micro[:hints]&.[](hint_index)
        }
      end
    end
  end
  
  # GET/POST /learn/restart - Restart learning from beginning
  def restart
    # Option to reset progress (completely start over) or just restart current session
    reset_progress = params[:reset_progress] == 'true'

    if reset_progress
      # FULL RESET: Completely delete all user progress
      Rails.logger.info "🔄 FULL RESTART: Deleting all progress for user #{current_user.id}"

      # DELETE all mastery records (completely fresh start)
      deleted_count = current_user.command_masteries.destroy_all.length
      Rails.logger.info "🗑️ Deleted #{deleted_count} mastery records"

      # DELETE all learning sessions entirely (fresh start from scratch)
      session_count = current_user.learning_sessions.destroy_all.length
      Rails.logger.info "🗑️ Deleted #{session_count} learning sessions"

      Rails.logger.info "✅ FULL RESTART COMPLETE: All progress deleted for user #{current_user.id}"
    else
      # SOFT RESTART: Just end current session, keep progress
      @session = LearningSession.find_or_create_active(current_user)
      @session.update_state('lab_session_id', nil)
      @session.complete!('manual_exit')
    end

    # Redirect to appropriate learn path based on track
    learn_url = params[:track] == 'docker' ? docker_learn_path : learn_path
    redirect_to learn_url
  end
  
  # POST /learn/complete - End session
  def complete
    @session = LearningSession.find_or_create_active(current_user)

    # Just clear the lab session ID (no container cleanup needed in host mode)
    @session.update_state('lab_session_id', nil)

    @session.complete!('user_completed')

    # Calculate session stats
    @stats = {
      duration: @session.session_duration,
      items_presented: @session.items_presented,
      accuracy: @session.accuracy_rate,
      streak: @session.current_streak
    }

    render :complete
  end

  # ========================================
  # React API Methods (JSON endpoints)
  # ========================================

  # GET /api/v1/learning/session
  def api_session
    session = LearningSession.find_or_create_active(@current_user)
    content_library = get_content_library

    # FIXED: Use learning_path_order directly to preserve module structure
    # Don't flatten via learning_path_for
    raw_path = if content_library.respond_to?(:learning_path_order)
      content_library.learning_path_order
    else
      content_library::LEARNING_PATH_ORDER
    end

    # Build modules from content library (preserving hierarchical structure)
    modules = if raw_path.first.is_a?(Hash) && raw_path.first[:module_id]
      raw_path.map { |mod| build_module_json(mod, content_library) }
    else
      # Legacy flat structure fallback - raw_path is array of slugs
      [{
        id: 'main',
        title: "#{@track.capitalize} Learning Path",
        icon: 'Container',
        lessons: raw_path.compact.map { |slug|
          # Skip if slug is not a string (safety check)
          next unless slug.is_a?(String) || slug.is_a?(Symbol)
          build_lesson_json(slug.to_s, content_library)
        }.compact
      }]
    end

    # Get mastery scores
    mastery = @current_user.command_masteries.index_by(&:canonical_command)

    render json: {
      success: true,
      data: {
        session: serialize_session_json(session),
        modules: modules,
        masteryScores: serialize_mastery_json(mastery)
      }
    }
  end

  # GET /api/v1/learning/modules
  def api_modules
    content_library = get_content_library

    # FIXED: Use learning_path_order directly to preserve module structure
    raw_path = if content_library.respond_to?(:learning_path_order)
      content_library.learning_path_order
    else
      content_library::LEARNING_PATH_ORDER
    end

    modules = if raw_path.first.is_a?(Hash) && raw_path.first[:module_id]
      raw_path.map { |mod| build_module_json(mod, content_library) }
    else
      # Legacy flat structure fallback - raw_path is array of slugs
      [{
        id: 'main',
        title: "#{@track.capitalize} Learning Path",
        icon: 'Container',
        lessons: raw_path.compact.map { |slug|
          # Skip if slug is not a string (safety check)
          next unless slug.is_a?(String) || slug.is_a?(Symbol)
          build_lesson_json(slug.to_s, content_library)
        }.compact
      }]
    end

    render json: { success: true, data: modules }
  end

  # POST /api/v1/learning/command
  def api_validate_command
    command = params[:command]
    lesson_id = params[:lessonId]

    content_library = get_content_library
    lesson = find_lesson_for_api(lesson_id, content_library)

    unless lesson
      render json: { success: false, error: 'Lesson not found' }, status: :not_found
      return
    end

    # Execute command if Docker track
    execution_result = if @track == 'docker'
      executor = DockerExecutionService.new(@current_user)
      executor.execute(command, chapter: lesson_id)
    else
      { success: true, output: "", error: "" }
    end

    render json: {
      success: true,
      data: {
        valid: execution_result[:success],
        message: execution_result[:output] || "Command executed",
        output: execution_result[:output]
      }
    }
  end

  # POST /api/v1/learning/complete/command
  def api_complete_command
    lesson_id = params[:lessonId]
    command_index = params[:commandIndex]&.to_i || 0

    session = LearningSession.find_or_create_active(@current_user)
    completed_commands = session.state_data['completed_commands'] || {}
    completed_commands[lesson_id] ||= []
    completed_commands[lesson_id] << command_index unless completed_commands[lesson_id].include?(command_index)

    session.update!(state_data: session.state_data.merge('completed_commands' => completed_commands))

    render json: { success: true, data: { commandIndex: command_index, lessonId: lesson_id } }
  end

  # POST /api/v1/learning/complete/lesson
  def api_complete_lesson
    lesson_id = params[:lessonId]
    session = LearningSession.find_or_create_active(@current_user)

    completed_lessons = session.state_data['completed_lessons'] || []
    completed_lessons << lesson_id unless completed_lessons.include?(lesson_id)

    session.update!(
      state_data: session.state_data.merge('completed_lessons' => completed_lessons),
      items_presented: session.items_presented + 1,
      items_correct: session.items_correct + 1
    )

    # Update mastery
    mastery = @current_user.command_masteries.find_or_create_by(canonical_command: lesson_id)
    mastery.update!(
      proficiency_score: [mastery.proficiency_score + 20, 100].min,
      last_used_at: Time.current,
      total_attempts: mastery.total_attempts + 1,
      successful_attempts: mastery.successful_attempts + 1
    )

    render json: { success: true, data: { lessonId: lesson_id, masteryScore: mastery.proficiency_score } }
  end

  # POST /api/v1/learning/complete/task
  def api_complete_task
    lab_id = params[:labId]
    task_index = params[:taskIndex]&.to_i || 0

    session = LearningSession.find_or_create_active(@current_user)
    completed_tasks = session.state_data['completed_tasks'] || {}
    completed_tasks[lab_id] ||= []
    completed_tasks[lab_id] << task_index unless completed_tasks[lab_id].include?(task_index)

    session.update!(state_data: session.state_data.merge('completed_tasks' => completed_tasks))

    render json: { success: true, data: { taskIndex: task_index, labId: lab_id } }
  end

  # GET /api/v1/learning/mastery
  def api_mastery_scores
    mastery = @current_user.command_masteries.index_by(&:canonical_command)
    render json: { success: true, data: serialize_mastery_json(mastery) }
  end

  private
  
  def set_track
    @track = params[:track] || 'docker'
  end
  
  # Resolve learning path with method-first, constant fallback for compatibility
  def learning_path_for(content_library)
    raw_path = if content_library.respond_to?(:learning_path_order)
      content_library.learning_path_order
    else
      content_library::LEARNING_PATH_ORDER
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
  
  def find_or_create_session
    @session = LearningSession.find_or_create_active(@current_user)
  end
  
  def validate_answer(content_id, answer)
    # Find the content and validate answer
    # This is a placeholder - implement based on your content model
    content = find_content(content_id)
    return false unless content
    
    case content[:type]
    when 'question'
      content[:correct_answer].to_s.strip.downcase == answer.to_s.strip.downcase
    when 'lab'
      # Lab validation would use LabRunnerService
      true # Placeholder
    else
      true
    end
  end
  
  def update_mastery(content_id, correct)
    # Update command mastery if this was a command-related item
    content = find_content(content_id)
    return unless content[:canonical_command]
    
    mastery = current_user.command_masteries.find_or_create_by(
      canonical_command: content[:canonical_command]
    )
    
    # Increase mastery score on correct answer
    new_score = [mastery.proficiency_score + 10, 100].min
    mastery.update!(
      proficiency_score: new_score,
      last_used_at: Time.current
    )
  end
  
  def find_content(content_id)
    # Placeholder - implement based on your content model
    # This should return content from your database
    {
      id: content_id,
      type: 'question',
      correct_answer: 'docker run',
      canonical_command: 'docker run'
    }
  end
  
  def format_micro_for_display(micro, chapter)
    {
      id: micro[:id],
      type: micro[:type],
      content: micro[:content],
      metadata: {
        chapter: chapter,
        micro_id: micro[:id],
        canonical_command: chapter
      }
    }
  end
  
  def advance_to_next_chapter
    current_chapter = @session.get_state('current_chapter')

    # Use appropriate content library based on track
    content_library = get_content_library
    learning_path = learning_path_for(content_library)

    # Check if current chapter is a database unit (CodeSprout slug)
    if defined?(InteractiveLearningUnit) && current_chapter&.to_s&.start_with?('codesprout-')
      # Get next CodeSprout unit
      current_unit = InteractiveLearningUnit.published.find_by(slug: current_chapter)
      all_codesprout = InteractiveLearningUnit.published.where("slug LIKE 'codesprout-%'").ordered

      if current_unit
        # Find current unit's position in the ordered list
        current_index = all_codesprout.pluck(:slug).index(current_chapter)
        next_unit_slug = all_codesprout.pluck(:slug)[current_index + 1] if current_index

        if next_unit_slug
          # Advance to next CodeSprout unit
          @session.update_state('current_chapter', next_unit_slug)
          @session.update_state('current_micro', next_unit_slug)
          return
        end
      end
    end

    # Not a CodeSprout unit, use learning path logic
    # Find next chapter in learning path
    chapter_index = learning_path.index(current_chapter)
    next_chapter = if chapter_index
                     learning_path[chapter_index + 1]
                   else
                     learning_path.first
                   end

    # Default to first chapter if at end
    next_chapter ||= learning_path.first

    # Try to get first micro for next chapter
    first_micro = content_library.get_first_micro_for_chapter(next_chapter)

    if first_micro
      # Chapter has micros, set it up
      @session.update_state('current_chapter', next_chapter)
      @session.update_state('current_micro', first_micro[:id])
    else
      # Chapter doesn't have micros yet, loop back to first chapter with micros
      fallback_chapter = learning_path.first
      @session.update_state('current_chapter', fallback_chapter)
      first_micro = content_library.get_first_micro_for_chapter(fallback_chapter)
      @session.update_state('current_micro', first_micro[:id])
    end
  end
  
  def session_stats_hash
    {
      items_completed: @session.items_presented,
      accuracy: @session.accuracy_rate,
      streak: @session.current_streak
    }
  end
  
  # Duplicate set_track removed; using the single definition above
  
  def ensure_user
    # Get or create a user for testing purposes
    @current_user = current_user if respond_to?(:current_user)
    @current_user ||= User.first || User.create!(
      account_id: "demo-#{SecureRandom.hex(4)}"
    )
  end
  
  def current_user
    @current_user
  end
  
  # Get content library based on track
  def get_content_library
    case @track
    when 'kubernetes', 'k8s'
      KubernetesContentLibrary
    else
      DockerContentLibrary
    end
  end
  
  # Get validator class based on track
  def get_validator_for_track
    case @track
    when 'kubernetes', 'k8s'
      KubernetesExerciseValidator
    else
      DockerExerciseValidator
    end
  end
  
  # Get lab runner instance based on track
  def get_lab_runner_for_track(user_id, session_id)
    case @track
    when 'kubernetes', 'k8s'
      KubernetesLabRunner.new(user_id: user_id, session_id: session_id)
    else
      LabRunnerService.new(user_id: user_id, lab_session_id: session_id)
    end
  end
  
  # Retry database operations to handle SQLite locks
  # This is critical for SQLite which can have lock contention under concurrent writes
  def with_db_retry(max_retries: 10, base_delay: 0.05)
    retries = 0
    begin
      # Wrap in a transaction to ensure atomicity
      ActiveRecord::Base.transaction do
        yield
      end
    rescue ActiveRecord::StatementInvalid, SQLite3::BusyException, ActiveRecord::LockWaitTimeout => e
      error_message = e.message.to_s.downcase
      is_lock_error = error_message.include?('database is locked') || 
                      error_message.include?('busy') ||
                      e.is_a?(SQLite3::BusyException) ||
                      e.is_a?(ActiveRecord::LockWaitTimeout)
      
      if is_lock_error && retries < max_retries
        retries += 1
        # Exponential backoff with jitter to prevent thundering herd
        jitter = rand(0.0..0.02)
        sleep_time = (base_delay * (2 ** retries)) + jitter
        Rails.logger.warn "⚠️ Database lock detected (attempt #{retries}/#{max_retries}), retrying in #{sleep_time.round(3)}s..."
        sleep(sleep_time)
        retry
      else
        # Log the error for debugging
        Rails.logger.error "❌ Database operation failed after #{retries} retries: #{e.message}"
        Rails.logger.error e.backtrace.first(5).join("\n")
        raise
      end
    end
  end
  
  # Helper methods for views
  helper_method :render_formatted_explanation
  
  # Redefined to render lists as clean paragraphs (no UL/OL)
  def render_formatted_explanation(text)
    return '' if text.blank?
    formatted = text.dup
    # Normalize inline numbered lists like "1) ... 2) ..." by inserting newlines
    formatted.gsub!(/\s(\d+)[\.)]\s+/) { "\n#{$1}) " }
    # Optional section icons on bold headers
    section_icons = {
      'Your Mission' => '🎯',
      'What just happened' => '💡',
      'What\'s about to happen' => '🔮',
      'The solution' => '✨',
      'The command' => '⚡',
      'The Command' => '⚡',
      'DCA Exam Tip' => '📝',
      'DCA Exam Scenario' => '📋',
      'What you\'ll see' => '👀',
      'Try it now' => '🚀',
      'The problem' => '⚠️',
      'Where we are' => '📍',
      'Why this matters' => '💎',
      'Real-World Use' => '🌍',
      'Production Tip' => '⭐'
    }
    formatted.gsub!(/\*\*([^*]+?):\*\*/) do
      section_name = $1
      icon = section_icons[section_name] || '▸'
      "<span class='section-icon'>#{icon}</span><strong>#{section_name}:</strong>"
    end
    # Headings (use multiline mode to match start of line, handle emojis)
    formatted.gsub!(/^###\s+(.+?)$/im, '<h4 class="explanation-subhead">\1</h4>')
    formatted.gsub!(/^##\s+(.+?)$/im, '<h3 class="explanation-head">\1</h3>')
    formatted.gsub!(/^#\s+(.+?)$/im, '<h2 class="explanation-headline">\1</h2>')
    
    # Fenced code blocks: ```lang\n...```
    formatted.gsub!(/```(\w+)?[ \t]*\n?([\s\S]*?)```/m) do
      lang = ($1 || '').strip
      code = ($2 || '').to_s
      code = ERB::Util.html_escape(code.strip)
      lang_class = lang.present? ? " language-#{lang}" : ''
      "<pre class='code-block#{lang_class}'><code>#{code}</code></pre>"
    end
    # Bold + inline code (avoid triple backticks, no newlines)
    formatted.gsub!(/\*\*(.+?)\*\*/, '<strong>\1</strong>')
    formatted.gsub!(/(?<!`)`([^\n`]+)`(?!`)/, '<code>\1</code>')
    # Numbered items -> paragraphs
    formatted.gsub!(/^(\d+)[\.)]\s+(.+)$/, '<p class="explanation-point"><span class="point-index">\1)</span> \2</p>')
    # Bullet items -> paragraphs
    formatted.gsub!(/^-\s+(.+)$/, '<p class="explanation-point">\1</p>')
    formatted.gsub!(/^\*\s+(.+)$/, '<p class="explanation-point">\1</p>')
    # Wrap remaining chunks as paragraphs unless already HTML blocks
    formatted = formatted.split("\n\n").map do |para|
      para_stripped = para.strip
      # If already HTML, keep as is
      if para_stripped.start_with?('<h2', '<h3', '<h4') || para_stripped.include?('<p ')
        para
      # Detect standalone question-style headers (lines ending with ? that are questions)
      # Matches: "Why hello-world?", "What is Docker?", etc.
      elsif para_stripped.match?(/^[A-Z][A-Za-z0-9\s\-'",:;]{3,}\?$/) && para_stripped.split("\n").length == 1 && para_stripped.length < 100
        "<h3 class=\"explanation-head\">#{para_stripped}</h3>"
      # Detect other standalone headers (title case, no punctuation at end)
      elsif para_stripped.match?(/^[A-Z][A-Za-z0-9\s\-'",:;]{5,}$/) && para_stripped.split("\n").length == 1 && para_stripped.length < 80 && !para_stripped.match?(/[.!]$/)
        "<h3 class=\"explanation-head\">#{para_stripped}</h3>"
      # Regular paragraphs
      else
        "<p class='explanation-paragraph'>#{para}</p>"
      end
    end.join("\n")

    # Merge consecutive explanation-point paragraphs into a single story paragraph
    formatted = formatted.gsub(/((?:<p class='explanation-point'>.*?<\/p>\s*){2,})/m) do |block|
      items = block.scan(/<p class='explanation-point'>(.*?)<\/p>/m).flatten
      sentences = items.map do |s|
        # Remove numeric indices like <span class="point-index">1)</span>
        s = s.sub(/\A\s*<span class=\"point-index\">.*?<\/span>\s*/,'')
        s.strip
      end
      "<p class='explanation-story'>#{sentences.join(' ')}</p>"
    end
    formatted.html_safe
  end

  # JSON serialization helpers for React API
  def build_module_json(module_def, content_library)
    {
      id: module_def[:module_id],
      title: module_def[:module_title] || module_def[:title], # FIXED: Use correct key
      description: module_def[:module_description],
      icon: module_def[:icon] || 'Container',
      lessons: module_def[:items].map { |slug| build_lesson_json(slug, content_library) }.compact
    }
  end

  def build_lesson_json(slug, content_library)
    db_unit = if defined?(InteractiveLearningUnit)
      InteractiveLearningUnit.find_by(slug: slug, published: true)
    end

    if db_unit
      # InteractiveLearningUnits with scenario_steps are interactive lessons, not labs
      # Real labs come from HandsOnLab model
      content_type = if db_unit.quiz_question_text.present? && !db_unit.scenario_steps.present?
        'quiz'
      else
        'lesson'  # Interactive lessons with practice steps are still lessons
      end

      {
        id: db_unit.slug,
        title: db_unit.title,
        slug: db_unit.slug,
        contentType: content_type,
        content: db_unit.concept_explanation,
        description: db_unit.problem_statement,
        commands: db_unit.command_to_learn.present? ? [{
          command: db_unit.command_to_learn,
          description: db_unit.problem_statement || db_unit.title,
          example: db_unit.command_to_learn
        }] : []
      }
    else
      first_micro = content_library.get_first_micro_for_chapter(slug)
      if first_micro
        # Check if it's a lab or a lesson
        # Labs have :type == 'comprehensive_lab' or :metadata[:is_lab] == true
        is_lab = first_micro[:type]&.include?('lab') || first_micro.dig(:metadata, :is_lab)

        if is_lab
          # Lab structure: has :title, :description, :difficulty, :steps directly
          {
            id: slug,
            title: first_micro[:title] || slug.titleize,
            slug: slug,
            contentType: 'lab',
            description: first_micro[:description],
            difficulty: first_micro[:difficulty],
            estimated_minutes: first_micro[:estimated_minutes],
            steps: first_micro[:steps] || []
          }
        elsif first_micro[:content]
          # Lesson structure: has nested :content key
          {
            id: slug,
            title: first_micro[:content][:title] || slug.titleize,
            slug: slug,
            contentType: 'lesson',
            content: first_micro[:content][:explanation] || first_micro[:content][:text]
          }
        end
      end
    end
  end

  def serialize_session_json(session)
    {
      id: session.id,
      sessionId: session.session_id,
      userId: session.user_id,
      stateData: session.state_data,
      itemsPresented: session.items_presented,
      itemsCorrect: session.items_correct,
      accuracyRate: session.accuracy_rate,
      currentStreak: session.current_streak
    }
  end

  def serialize_mastery_json(mastery_hash)
    mastery_hash.transform_values do |mastery|
      {
        canonicalCommand: mastery.canonical_command,
        proficiencyScore: mastery.proficiency_score.round,
        lastUsedAt: mastery.last_used_at&.iso8601,
        totalAttempts: mastery.total_attempts,
        successfulAttempts: mastery.successful_attempts,
        consecutiveSuccesses: mastery.consecutive_successes || 0,
        consecutiveFailures: mastery.consecutive_failures || 0
      }
    end
  end

  def find_lesson_for_api(lesson_id, content_library)
    db_unit = if defined?(InteractiveLearningUnit)
      InteractiveLearningUnit.find_by(slug: lesson_id, published: true)
    end

    db_unit || content_library.get_first_micro_for_chapter(lesson_id)
  end
end
