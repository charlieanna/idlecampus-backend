# Course Adaptation Service
# Aggregates user struggles and creates course adaptation recommendations
# Monitors patterns across multiple users to identify content that needs improvement

class CourseAdaptationService
  # Thresholds for creating adaptations
  MIN_AFFECTED_USERS = 3 # Minimum users struggling before creating adaptation
  CRITICAL_STRUGGLE_THRESHOLD = 0.8
  HIGH_STRUGGLE_THRESHOLD = 0.6

  class << self
    # Record a lab struggle and create/update adaptation if needed
    def record_lab_struggle(lab_session:, struggle_score:, pain_points:, indicators:)
      lab = lab_session.hands_on_lab
      return unless lab.present?

      # Find or create adaptation for this lab
      adaptation = find_or_create_adaptation_for_lab(lab, pain_points)

      # Update adaptation with new struggle data
      update_adaptation_with_struggle(
        adaptation: adaptation,
        lab_session: lab_session,
        struggle_score: struggle_score,
        pain_points: pain_points,
        indicators: indicators
      )

      adaptation
    end

    # Analyze all struggles for a specific lab
    def analyze_lab_struggles(lab_id)
      lab = HandsOnLab.find(lab_id)
      struggling_sessions = LabSession.where(hands_on_lab_id: lab_id)
                                      .where('struggle_score >= ?', HIGH_STRUGGLE_THRESHOLD)
                                      .includes(:user)

      return nil if struggling_sessions.count < MIN_AFFECTED_USERS

      {
        lab: lab,
        total_struggles: struggling_sessions.count,
        average_struggle_score: struggling_sessions.average(:struggle_score),
        common_pain_points: aggregate_pain_points(struggling_sessions),
        common_errors: aggregate_errors(struggling_sessions),
        recommendations: generate_recommendations(struggling_sessions, lab)
      }
    end

    # Analyze all struggles for a course module
    def analyze_module_struggles(module_id)
      course_module = CourseModule.find(module_id)

      # Get all labs in this module
      lab_ids = ModuleItem.where(course_module_id: module_id, item_type: 'HandsOnLab')
                          .pluck(:item_id)

      return nil if lab_ids.empty?

      struggling_sessions = LabSession.where(hands_on_lab_id: lab_ids)
                                      .where('struggle_score >= ?', HIGH_STRUGGLE_THRESHOLD)

      return nil if struggling_sessions.count < MIN_AFFECTED_USERS

      {
        module: course_module,
        total_struggles: struggling_sessions.count,
        average_struggle_score: struggling_sessions.average(:struggle_score),
        struggling_labs: identify_struggling_labs(lab_ids),
        recommendations: generate_module_recommendations(course_module, struggling_sessions)
      }
    end

    # Get all pending adaptations that need review
    def pending_adaptations
      CourseAdaptation.pending
                      .by_severity
                      .includes(:adaptable, :course_module)
                      .group_by(&:severity)
    end

    # Get adaptation summary for dashboard
    def adaptation_summary
      {
        total_pending: CourseAdaptation.pending.count,
        total_in_review: CourseAdaptation.in_review.count,
        critical: CourseAdaptation.critical.pending.count,
        high_priority: CourseAdaptation.high_priority.pending.count,
        by_type: CourseAdaptation.pending.group(:adaptation_type).count,
        recent_adaptations: CourseAdaptation.recent.limit(10)
      }
    end

    # Automatically suggest adaptations for all struggling content
    def auto_suggest_adaptations
      # Find all labs with high struggle rates
      struggling_labs = HandsOnLab.where('needs_adaptation = ? OR average_struggle_score >= ?',
                                        true, HIGH_STRUGGLE_THRESHOLD)

      adaptations_created = []

      struggling_labs.each do |lab|
        analysis = analyze_lab_struggles(lab.id)
        next unless analysis

        adaptation = create_adaptation_from_analysis(lab, analysis)
        adaptations_created << adaptation if adaptation
      end

      adaptations_created
    end

    private

    # Find or create adaptation for a lab
    def find_or_create_adaptation_for_lab(lab, pain_points)
      # Determine adaptation type based on pain points
      adaptation_type = determine_adaptation_type(pain_points)

      # Find existing pending/in_review adaptation for this lab
      adaptation = CourseAdaptation.active
                                   .for_lab(lab.id)
                                   .where(adaptation_type: adaptation_type)
                                   .first

      # Create if doesn't exist
      adaptation ||= CourseAdaptation.create!(
        adaptable: lab,
        course_module: lab.course_modules.first,
        adaptation_type: adaptation_type,
        reason: generate_reason(pain_points),
        affected_users_count: 0,
        average_struggle_score: 0.0,
        status: 'pending'
      )

      adaptation
    end

    # Update adaptation with new struggle data
    def update_adaptation_with_struggle(adaptation:, lab_session:, struggle_score:, pain_points:, indicators:)
      # Increment affected users
      adaptation.increment_affected_users!

      # Update average struggle score
      new_avg = calculate_new_average(
        current_avg: adaptation.average_struggle_score || 0.0,
        current_count: adaptation.affected_users_count - 1,
        new_value: struggle_score
      )

      adaptation.update!(average_struggle_score: new_avg)

      # Add pain points
      pain_points.each do |pp|
        adaptation.add_failure_point(pp[:description]) if pp[:description]
      end

      # Add errors from indicators
      if indicators[:error_patterns].present?
        indicators[:error_patterns].each do |error|
          adaptation.add_error(error)
        end
      end

      # Update suggested changes
      update_suggested_changes(adaptation, pain_points, indicators)
    end

    # Aggregate pain points from multiple sessions
    def aggregate_pain_points(sessions)
      all_pain_points = sessions.flat_map do |session|
        analyzer = LabStruggleAnalyzer.new(session)
        analyzer.identify_pain_points
      end

      # Group by type and count occurrences
      all_pain_points.group_by { |pp| pp[:type] }
                    .transform_values { |pps| pps.count }
                    .sort_by { |_, count| -count }
                    .to_h
    end

    # Aggregate errors from multiple sessions
    def aggregate_errors(sessions)
      all_errors = sessions.flat_map do |session|
        analyzer = LabStruggleAnalyzer.new(session)
        analyzer.identify_pain_points
                .select { |pp| pp[:type] == 'error_patterns' }
                .flat_map { |pp| pp[:details] }
      end

      all_errors.group_by(&:itself)
               .transform_values(&:count)
               .sort_by { |_, count| -count }
               .to_h
    end

    # Generate recommendations based on struggles
    def generate_recommendations(sessions, lab)
      pain_points = aggregate_pain_points(sessions)
      recommendations = []

      if pain_points['validation_failures'].to_i > sessions.count * 0.5
        recommendations << {
          type: 'add_explanation',
          priority: 'high',
          suggestion: 'Add more detailed explanations for validation requirements'
        }
      end

      if pain_points['time_exceeded'].to_i > sessions.count * 0.4
        recommendations << {
          type: 'simplify_content',
          priority: 'medium',
          suggestion: 'Consider breaking this lab into smaller steps'
        }
      end

      if pain_points['step_failures'].to_i > sessions.count * 0.6
        recommendations << {
          type: 'add_hints',
          priority: 'high',
          suggestion: 'Add progressive hints for difficult steps'
        }
        recommendations << {
          type: 'add_examples',
          priority: 'medium',
          suggestion: 'Provide more examples and similar patterns'
        }
      end

      if pain_points['error_patterns'].to_i > sessions.count * 0.4
        recommendations << {
          type: 'add_prerequisites',
          priority: 'high',
          suggestion: 'Add prerequisite lessons covering fundamental concepts'
        }
      end

      recommendations
    end

    # Generate module-level recommendations
    def generate_module_recommendations(course_module, sessions)
      # Similar to lab recommendations but at module level
      # Could suggest reordering content, adding review sections, etc.
      []
    end

    # Identify which labs in a module are causing struggles
    def identify_struggling_labs(lab_ids)
      HandsOnLab.where(id: lab_ids)
                .where('average_struggle_score >= ?', HIGH_STRUGGLE_THRESHOLD)
                .order(average_struggle_score: :desc)
    end

    # Determine adaptation type from pain points
    def determine_adaptation_type(pain_points)
      # Priority order for adaptation types
      return 'add_explanation' if pain_points.any? { |pp| pp[:type] == 'validation_failures' }
      return 'add_hints' if pain_points.any? { |pp| pp[:type] == 'stuck_on_step' }
      return 'simplify_content' if pain_points.any? { |pp| pp[:type] == 'time_exceeded' }
      return 'add_prerequisites' if pain_points.any? { |pp| pp[:type] == 'error_patterns' }

      'add_practice' # default
    end

    # Generate reason text from pain points
    def generate_reason(pain_points)
      if pain_points.empty?
        'Users are struggling with this content'
      else
        descriptions = pain_points.map { |pp| pp[:description] }.compact
        "Multiple users struggling: #{descriptions.first(3).join('; ')}"
      end
    end

    # Calculate new average incrementally
    def calculate_new_average(current_avg:, current_count:, new_value:)
      return new_value if current_count.zero?

      ((current_avg * current_count) + new_value) / (current_count + 1).to_f
    end

    # Update suggested changes based on pain points
    def update_suggested_changes(adaptation, pain_points, indicators)
      suggestions = []

      pain_points.each do |pp|
        case pp[:type]
        when 'validation_failures'
          suggestions << "Add clearer validation instructions and expected output examples"
        when 'stuck_on_step'
          suggestions << "Provide progressive hints for step #{pp[:details][:step]}"
        when 'time_exceeded'
          suggestions << "Break down complex steps into smaller, manageable tasks"
        when 'error_patterns'
          suggestions << "Add prerequisite material covering: #{pp[:details].join(', ')}"
        when 'step_failures'
          suggestions << "Review and clarify instructions for steps: #{pp[:details].join(', ')}"
        end
      end

      current_suggestions = adaptation.suggested_changes || ''
      new_suggestions = suggestions.join("\n")

      unless current_suggestions.include?(new_suggestions)
        updated_suggestions = [current_suggestions, new_suggestions].reject(&:blank?).join("\n\n")
        adaptation.update!(suggested_changes: updated_suggestions)
      end
    end

    # Create adaptation from analysis
    def create_adaptation_from_analysis(lab, analysis)
      return if analysis[:recommendations].empty?

      primary_recommendation = analysis[:recommendations].first

      CourseAdaptation.create!(
        adaptable: lab,
        course_module: lab.course_modules.first,
        adaptation_type: primary_recommendation[:type],
        reason: "#{analysis[:total_struggles]} users struggling. #{primary_recommendation[:suggestion]}",
        affected_users_count: analysis[:total_struggles],
        average_struggle_score: analysis[:average_struggle_score],
        common_failure_points: analysis[:common_pain_points].keys,
        common_errors: analysis[:common_errors].keys,
        suggested_changes: analysis[:recommendations].map { |r| r[:suggestion] }.join("\n"),
        status: 'pending'
      )
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "Failed to create adaptation: #{e.message}"
      nil
    end
  end
end
