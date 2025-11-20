class DockerContentLibrary
  # DEPRECATED: All lessons have been migrated to database (InteractiveLearningUnit table)
  # This hash is kept empty as all content is now in the database
  # To update content, edit the database records directly
  DOCKER_LESSONS = {}.freeze
  
  # Multi-step labs with prerequisites
  LABS = [
    {
      id: 'lab_run_and_manage_nginx',
      title: 'Lab: Run and Manage an Nginx Server',
      scenario: 'You are tasked with deploying a simple nginx web server, verifying it is running, and then shutting it down cleanly.',
      objectives: [
        'Run nginx in detached mode with a friendly name',
        'Verify the container is running',
        'Stop the container gracefully'
      ],
      requires_mastery: ['docker run', 'docker ps', 'docker stop'],
      steps: [
        {
          instruction: "Run an nginx container in detached mode with the name 'webserver'",
          validation: { type: 'container_running', name: 'webserver', image: 'nginx' }
        },
        {
          instruction: "Verify that the 'webserver' container is running.",
          validation: { type: 'output_contains', contains: 'webserver' }
        },
        {
          instruction: "Stop the 'webserver' container.",
          validation: { type: 'container_stopped', name: 'webserver' }
        }
      ]
    }
  ].freeze
  
  # Learning progression from beginner to advanced
  LEARNING_PATH_ORDER = [
    'docker run',        # 1. Start here - most fundamental
    'docker ps',         # 2. See what's running
    'docker images',     # 3. Understand images
    'docker pull',       # 4. Getting images
    'docker logs',       # 5. Debugging basics
    'docker stop',       # 6. Managing containers
    'docker exec',       # 7. Interacting with containers
    'docker build',      # 8. Creating images
    'docker network',    # 9. Networking (intermediate)
    'docker volume',     # 10. Persistence (intermediate)
    'docker-compose'     # 11. Orchestration (advanced)
  ].freeze
  
  # Get complete learning path including all labs
  def self.get_complete_learning_path
    # Start with basic commands
    path = LEARNING_PATH_ORDER.dup
    
    # Add all lab chapters dynamically from database
    HandsOnLab.where(lab_type: 'docker', is_active: true)
              .order(:difficulty, :estimated_minutes)
              .each do |lab|
      path << get_lab_chapter_name(lab)
    end
    
    path
  end
  
  # Get labs organized by difficulty
  def self.get_labs_by_difficulty
    {
      beginner: HandsOnLab.where(lab_type: 'docker', is_active: true, difficulty: 'easy')
                          .order(:estimated_minutes)
                          .map { |lab| get_lab_chapter_name(lab) },
      intermediate: HandsOnLab.where(lab_type: 'docker', is_active: true, difficulty: 'medium')
                              .order(:estimated_minutes)
                              .map { |lab| get_lab_chapter_name(lab) },
      advanced: HandsOnLab.where(lab_type: 'docker', is_active: true, difficulty: 'hard')
                          .order(:estimated_minutes)
                          .map { |lab| get_lab_chapter_name(lab) }
    }
  end
  
  def self.get_lesson(command)
    # Check if it's a lab-based chapter
    if lab_chapter?(command)
      lab_id = lab_id_from_chapter(command)
      return get_lab_as_chapter(lab_id) if lab_id
    end
    
    # Try database lookup first
    unit = InteractiveLearningUnit.published.where(command_to_learn: command).first
    return convert_unit_to_micro_lesson(unit) if unit
    
    # Fallback to generating a basic lesson
    generate_fallback_lesson(command)
  end
  
  def self.get_random_lesson
    # Get random unit from database
    unit = InteractiveLearningUnit.published.order('RANDOM()').first
    return convert_unit_to_micro_lesson(unit).merge(canonical_command: unit.command_to_learn) if unit
    
    # Fallback to first learning path command
    first_command = LEARNING_PATH_ORDER.first
    unit = InteractiveLearningUnit.published.where(command_to_learn: first_command).first
    return convert_unit_to_micro_lesson(unit).merge(canonical_command: first_command) if unit
    
    nil
  end
  
  def self.get_next_lesson_for_user(user)
    # Get user's learning progress
    learned_commands = user.command_masteries
                           .where('proficiency_score > ?', 30)
                           .pluck(:canonical_command)
    
    # Find the first command in learning path they haven't learned yet
    next_command = LEARNING_PATH_ORDER.find { |cmd| !learned_commands.include?(cmd) }
    
    # Default to first lesson if nothing found or user is new
    next_command ||= LEARNING_PATH_ORDER.first
    
    # Get from database
    unit = InteractiveLearningUnit.published.where(command_to_learn: next_command).first
    return convert_unit_to_micro_lesson(unit).merge(canonical_command: next_command) if unit
    
    # Fallback to get_first_micro_for_chapter
    micro = get_first_micro_for_chapter(next_command)
    return micro.merge(canonical_command: next_command) if micro
    
    nil
  end
  
  def self.get_practice_content(command)
    # Get from database
    unit = InteractiveLearningUnit.published.where(command_to_learn: command).first
    return convert_unit_to_micro_lesson(unit) if unit
    
    # Fallback to get_first_micro_for_chapter
    get_first_micro_for_chapter(command)
  end
  
  # Micro-lesson methods - REMOVED: This method is redefined below with database support
  # Keeping comment for reference but the actual implementation is below
  
  def self.get_first_micro_for_chapter(chapter)
    # PRIORITY 0: Check if it's a lab (using "lab_#{id}" pattern or lab slug)
    if chapter.to_s.start_with?('lab_')
      lab_id = chapter.to_s.sub('lab_', '').to_i
      lab = HandsOnLab.find_by(id: lab_id, is_active: true)
      if lab
        Rails.logger.info "✅ Found lab by ID pattern: lab_#{lab_id}"
        return convert_lab_to_chapter(lab)
      end
    end

    # Also check if chapter matches a lab slug directly
    lab = HandsOnLab.find_by(slug: chapter.to_s, is_active: true)
    if lab
      Rails.logger.info "✅ Found lab by slug: #{lab.slug}"
      return convert_lab_to_chapter(lab)
    end

    # PRIORITY 1: Check database units FIRST (database is source of truth)
    # Try exact slug match
    unit = InteractiveLearningUnit.find_by(slug: chapter, published: true)
    if unit
      Rails.logger.info "✅ Found database unit: #{unit.slug}"
      return convert_unit_to_micro_lesson(unit)
    end

    # PRIORITY 2: Try slug matching chapter parameterized (e.g., "docker run" -> "docker-run")
    unit = InteractiveLearningUnit.find_by(slug: chapter.parameterize, published: true)
    if unit
      Rails.logger.info "✅ Found database unit by parameterized slug: #{unit.slug}"
      return convert_unit_to_micro_lesson(unit)
    end

    # PRIORITY 3: Try finding by command_to_learn matching chapter exactly
    unit = InteractiveLearningUnit.published.where(command_to_learn: chapter).first
    if unit
      Rails.logger.info "✅ Found database unit by command: #{unit.slug}"
      return convert_unit_to_micro_lesson(unit)
    end

    # PRIORITY 4: Check if chapter is a database unit slug (for CodeSprout units like "codesprout-docker-run")
    codesprout_unit = InteractiveLearningUnit.find_by(slug: "codesprout-#{chapter.parameterize}", published: true)
    return convert_unit_to_micro_lesson(codesprout_unit) if codesprout_unit

    # PRIORITY 5: Check if it's a lab-based chapter (legacy support)
    if lab_chapter?(chapter)
      lab_id = lab_id_from_chapter(chapter)
      lab_content = get_lab_as_chapter(lab_id)
      return lab_content[:micro_lessons].first if lab_content
    end
    
    # PRIORITY 6: Try to find unit by command_to_learn matching chapter (fuzzy match)
    unit_by_command = InteractiveLearningUnit.published.where("command_to_learn LIKE ?", "%#{chapter}%").ordered.first
    return convert_unit_to_micro_lesson(unit_by_command) if unit_by_command
    
    # PRIORITY 7: Fallback to hardcoded (legacy support - should be removed eventually)
    lesson = DOCKER_LESSONS[chapter]
    if lesson && lesson[:micro_lessons]
      Rails.logger.warn "⚠️ Using hardcoded lesson for #{chapter} - consider migrating to database"
      return lesson[:micro_lessons].first
    end
    
    # Last resort: return nil
    nil
  end
  
  # Note: get_next_micro is defined below with database integration
  
  def self.chapter_has_micros?(chapter)
    # Check if it's a lab-based chapter
    if lab_chapter?(chapter)
      lab_id = lab_id_from_chapter(chapter)
      lab_content = get_lab_as_chapter(lab_id)
      return lab_content && lab_content[:micro_lessons].present?
    end
    
    # Check database
    unit = InteractiveLearningUnit.find_by(slug: chapter, published: true)
    return true if unit
    
    unit = InteractiveLearningUnit.published.where(command_to_learn: chapter).first
    return true if unit
    
    false
  end
  
  def self.get_next_chapter_for_user(user)
    # Database-first progression using published InteractiveLearningUnit slugs
    # NO special priority - all units ordered by sequence_order
    units = InteractiveLearningUnit.published.ordered.pluck(:slug)

    unless units.empty?
      session = user.learning_sessions.active.first
      completed_micros = session&.state_data&.[]('completed_micros') || {}

      Rails.logger.info "🔍 get_next_chapter_for_user: units=#{units.inspect}"
      Rails.logger.info "🔍 completed_micros=#{completed_micros.inspect}"

      next_slug = units.find do |slug|
        # Check if this unit is completed
        # For database units, completion is tracked under chapter=slug, micro_id=slug
        # Also check if chapter key equals slug (for backwards compatibility)
        chapter_done = completed_micros[slug] || []
        is_completed = chapter_done.include?(slug) ||
                      (!chapter_done.empty? && chapter_done.any? { |m| m == slug })

        Rails.logger.info "🔍 Checking slug #{slug}: chapter_done=#{chapter_done.inspect}, is_completed=#{is_completed}"
        !is_completed
      end

      Rails.logger.info "✅ Next slug: #{next_slug || units.first}"
      return next_slug || units.first
    end

    # Fallback to LEARNING_PATH_ORDER progression (check database for each chapter)
    session = user.learning_sessions.active.first
    completed_micros = session&.state_data&.[]('completed_micros') || {}

    completed_chapters = []
    LEARNING_PATH_ORDER.each do |chapter|
      # Check if chapter has units in database
      unit = InteractiveLearningUnit.published.where(command_to_learn: chapter).first
      next unless unit
      
      # Check if chapter is completed
      chapter_completed_micros = completed_micros[chapter] || []
      completed_chapters << chapter if chapter_completed_micros.include?(unit.slug)
    end

    next_chapter = LEARNING_PATH_ORDER.find { |cmd| !completed_chapters.include?(cmd) }
    next_chapter || LEARNING_PATH_ORDER.first
  end
  
  # Labs helpers - Now pulling from database
  def self.labs
    # Try database first, fallback to hardcoded
    db_labs = load_labs_from_database
    db_labs.any? ? db_labs : LABS
  end
  
  def self.get_lab(lab_id)
    # Check database first
    db_lab = HandsOnLab.find_by(id: lab_id)
    if db_lab
      convert_lab_to_hash(db_lab)
    else
      # Fallback to hardcoded
      LABS.find { |l| l[:id] == lab_id }
    end
  end
  
  def self.eligible_labs_for_user(user, min_mastery: 60)
    # Load from database
    db_labs = load_labs_from_database
    
    if db_labs.any?
      # Check prerequisites for database labs
      db_labs.select do |lab|
        # Skip labs that require commands the user hasn't learned
        prerequisites = lab[:requires_mastery] || []
        
        # For "Your First Container" lab, it should require basic commands
        if lab[:title] =~ /Your First Container/
          # This is an intro lab, but user should know docker run, ps, stop first
          prerequisites = ['docker run', 'docker ps', 'docker stop']
        end
        
        # Check if user has minimum mastery of prerequisites
        prerequisites.all? do |cmd|
          mastery = user.command_masteries.find_by(canonical_command: cmd)
          mastery && mastery.proficiency_score >= min_mastery
        end
      end
    else
      # Fallback to hardcoded
      LABS.select do |lab|
        (lab[:requires_mastery] || []).all? do |cmd|
          mastery = user.command_masteries.find_by(canonical_command: cmd)
          mastery && mastery.proficiency_score >= min_mastery
        end
      end
    end
  end
  
  # Load labs from database and convert to expected format
  def self.load_labs_from_database
    # Include all active labs (docker, docker-compose, etc.) for Docker track
    HandsOnLab.where(is_active: true).map do |lab|
      convert_lab_to_hash(lab)
    end
  end
  
  def self.convert_lab_to_hash(lab)
    # Parse prerequisites properly - they're stored as array of strings in DB
    prerequisites = if lab.prerequisites.is_a?(Array)
                      # Filter out non-command prerequisites like "Basic command line knowledge"
                      lab.prerequisites.select { |p| p.start_with?('docker') || p.start_with?('kubectl') }
                    else
                      []
                    end

    # For "Your First Container", ensure proper prerequisites (basic only)
    if lab.title =~ /Your First Container/
      prerequisites = ['docker run', 'docker ps', 'docker stop']
    end

    {
      id: lab.id,
      title: lab.title,
      description: lab.description,
      scenario: lab.description, # Use description as scenario for lab view
      difficulty: lab.difficulty,
      estimated_minutes: lab.estimated_minutes,
      category: lab.category,
      steps: symbolize_keys_deep(lab.steps || []),
      validation_rules: lab.validation_rules || {},
      requires_mastery: prerequisites,
      points: lab.points_reward || 100,
      objectives: parse_learning_objectives(lab.learning_objectives)
    }
  end

  # Convert lab to chapter format for get_first_micro_for_chapter
  def self.convert_lab_to_chapter(lab)
    {
      id: "lab_#{lab.id}",
      type: 'comprehensive_lab',
      title: lab.title,
      description: lab.description,
      difficulty: lab.difficulty,
      estimated_minutes: lab.estimated_minutes,
      steps: symbolize_keys_deep(lab.steps || []),
      lab_id: lab.id,
      metadata: {
        is_lab: true,
        lab_type: lab.lab_type,
        title: lab.title,
        chapter: lab.slug || "lab_#{lab.id}",
        canonical_command: lab.slug || "lab_#{lab.id}"
      }
    }
  end

  # Normalize incoming hashes/arrays from DB JSON into symbol-keyed structures
  def self.symbolize_keys_deep(obj)
    case obj
    when Array
      obj.map { |element| symbolize_keys_deep(element) }
    when Hash
      obj.each_with_object({}) do |(key, value), acc|
        sym_key = (key.respond_to?(:to_sym) ? key.to_sym : key)
        acc[sym_key] = symbolize_keys_deep(value)
      end
    else
      obj
    end
  end
  
  def self.parse_learning_objectives(objectives_string)
    return [] if objectives_string.blank?
    
    # Split by comma or newline and clean up
    objectives_string.to_s.split(/[,\n]/).map(&:strip).reject(&:blank?)
  end
  
  # Load interactive micro lessons from database
  def self.get_micro_lesson_from_db(chapter, micro_id)
    # Find InteractiveLearningUnit by slug or command
    unit = InteractiveLearningUnit.find_by(slug: micro_id) || 
           InteractiveLearningUnit.find_by(command_to_learn: chapter)
    
    return nil unless unit
    
    convert_unit_to_micro_lesson(unit)
  end
  
  def self.convert_unit_to_micro_lesson(unit)
    # Determine task content - use problem_statement if available, otherwise scenario_description
    task_content = unit.respond_to?(:problem_statement) && unit.problem_statement.present? ? 
                    unit.problem_statement : 
                    (unit.scenario_description || unit.scenario_narrative || 'Complete the task')
    
    {
      id: unit.slug,
      type: 'interactive',
      content: {
        title: unit.title,
        explanation: unit.concept_explanation,
        examples: [unit.command_to_learn] + (unit.command_variations || []),
        task: task_content,
        expected_command: unit.command_to_learn
      },
      validation: {
        type: 'command_match',
        base_command: [unit.command_to_learn.split(' ').first(2).join(' ')],
        required_flags: [],
        accepts_any_image: true,
        minimum_args: 2,
        no_extra_flags: false,
        require_success: true
      },
      hints: unit.practice_hints || [
        "Try: #{unit.command_to_learn}",
        "Follow the format shown in the examples"
      ],
      quiz: unit.quiz_question_text.present? ? {
        question: unit.quiz_question_text,
        type: unit.quiz_question_type,
        options: unit.quiz_options,
        correct_answer: unit.quiz_correct_answer,
        explanation: unit.quiz_explanation
      } : nil
    }
  end
  
  # Enhanced get_micro_lesson to use database as primary source
  def self.get_micro_lesson(chapter, micro_id)
    # PRIORITY 1: Check database units FIRST (database is source of truth)
    unit = InteractiveLearningUnit.find_by(slug: micro_id, published: true)
    if unit
      Rails.logger.info "✅ Found database unit by micro_id: #{unit.slug}"
      return convert_unit_to_micro_lesson(unit)
    end
    
    # PRIORITY 2: Check if chapter is a database unit slug
    if chapter != micro_id
      unit = InteractiveLearningUnit.find_by(slug: chapter, published: true)
      if unit
        Rails.logger.info "✅ Found database unit by chapter: #{unit.slug}"
        return convert_unit_to_micro_lesson(unit)
      end
    end
    
    # PRIORITY 3: Check if it's a lab-based chapter
    if lab_chapter?(chapter)
      lab_id = lab_id_from_chapter(chapter)
      lab_content = get_lab_as_chapter(lab_id)
      return lab_content[:micro_lessons].find { |m| m[:id] == micro_id } if lab_content
    end
    
    # PRIORITY 4: Try database lookup by command
    db_micro = get_micro_lesson_from_db(chapter, micro_id)
    return db_micro if db_micro
    
    # No more fallbacks - everything is in database
    nil
  end
  
  # Build learning path from database - includes modules, units, and lessons
  def self.build_learning_path_from_db
    path_items = []
    
    # Get Docker course modules in order
    docker_course = Course.find_by(slug: 'docker-fundamentals')
    if docker_course
      docker_course.course_modules.published.order(:sequence_order).each do |mod|
        path_items << "module_#{mod.id}"
      end
    end
    
    # Add interactive units
    units = InteractiveLearningUnit.order(:sequence_order)
    units.each do |unit|
      path_items << "unit_#{unit.id}"
    end
    
    # Fallback to command-based path if no structured content
    if path_items.empty?
      units = InteractiveLearningUnit.order(:sequence_order).limit(12)
      return units.map { |unit| unit.command_to_learn.split(' ').first(2).join(' ') }.uniq
    end
    
    path_items
  end
  
  # Enhanced LEARNING_PATH_ORDER - Returns module-grouped structure
  def self.learning_path_order
    # Build module-grouped learning path with lessons AND labs interleaved
    # Returns array of hashes: [{module_id, module_title, items: [...]}]

    # FIXED: Only get Docker labs, not Kubernetes labs
    labs = HandsOnLab.where(is_active: true, lab_type: ['docker', 'docker-compose']).order(:id).to_a

    # Lab placement mapping: which module should each lab go into
    # Updated structure: Modules 1-5 progressive learning, Module 6 = CodeSprout Capstone
    lab_to_module = {
      # Module 1: Container Basics (791)
      1 => 791,  # Lab 1: Your First Container
      2 => 791,  # Lab 2: Port Mapping and Network Access
      5 => 791,  # Lab 5: Container Logs and Debugging

      # Module 2: Building Images (781)
      6 => 781,  # Lab 6: Build Your First Docker Image
      7 => 781,  # Lab 7: Multi-Stage Builds - Optimize Image Size

      # Module 3: Networking (782)
      8 => 782,  # Lab 8: Docker Networks - Container Communication

      # Module 4: Data Persistence (783)
      4 => 783,  # Lab 4: Volume Mounting - Data Persistence
      15 => 783, # Lab 15: Backup and Restore Container Data

      # Module 5: Docker Compose (784)
      9 => 784,  # Lab 9: Docker Compose - Multi-Container Application

      # Module 6: Advanced Operations / Capstone (785)
      3 => 785,  # Lab 3: Environment Variables and Configuration
      10 => 785, # Lab 10: Resource Limits - Control Container Resources
      11 => 785, # Lab 11: Docker Registry - Push and Pull Custom Images
      12 => 785, # Lab 12: Health Checks and Auto-Restart
      13 => 785, # Lab 13: Docker Security - Non-Root User and Read-Only
      14 => 785  # Lab 14: Container Performance Monitoring
    }

    # Get modules in order (Modules 1-6: progressive learning + capstone)
    docker_course = Course.find_by(slug: 'docker-fundamentals')
    modules = if docker_course
      docker_course.course_modules
        .where(id: [791, 781, 782, 783, 784, 785])
        .published
        .order(:sequence_order)
    else
      CourseModule.where(id: [791, 781, 782, 783, 784, 785]).published.order(:sequence_order)
    end

    module_path = []

    modules.each do |mod|
      # Get lessons for this module
      lesson_items = mod.interactive_learning_units.order('module_interactive_units.sequence_order').map(&:slug)

      # Add labs assigned to this module
      module_labs = labs.select { |lab| lab_to_module[lab.id] == mod.id }
      lab_items = module_labs.map { |lab| lab.slug.presence || "lab_#{lab.id}" }

      # Combine lessons and labs (labs come after lessons in each module)
      all_items = lesson_items + lab_items

      module_path << {
        module_id: mod.id,
        module_title: mod.title,
        module_description: mod.description,
        items: all_items,
        lesson_count: lesson_items.length,
        lab_count: lab_items.length
      }
    end

    # Add any remaining labs not assigned to modules (as "Advanced Labs")
    placed_lab_ids = lab_to_module.keys
    remaining_labs = labs.reject { |l| placed_lab_ids.include?(l.id) }
    if remaining_labs.any?
      module_path << {
        module_id: nil,
        module_title: "Advanced Labs",
        module_description: "Additional hands-on practice labs",
        items: remaining_labs.map { |lab| lab.slug.presence || "lab_#{lab.id}" },
        lesson_count: 0,
        lab_count: remaining_labs.length
      }
    end

    module_path
  end
  
  # Get course module as content
  def self.get_module_content(module_id)
    mod = CourseModule.find_by(id: module_id)
    return nil unless mod
    
    # Get first item in module (lesson or quiz)
    first_item = mod.module_items.order(:sequence_order).first
    return nil unless first_item
    
    case first_item.item_type
    when 'CourseLesson'
      lesson = first_item.item
      {
        id: "lesson_#{lesson.id}",
        type: 'lesson',
        title: lesson.title,
        description: "#{mod.title}: #{lesson.title}",
        content: lesson.content,
        module_id: mod.id,
        metadata: {
          module_title: mod.title,
          lesson_id: lesson.id,
          reading_time: lesson.reading_time_minutes
        }
      }
    when 'Quiz'
      quiz = first_item.item
      {
        id: "quiz_#{quiz.id}",
        type: 'quiz',
        title: quiz.title,
        description: "#{mod.title}: #{quiz.title}",
        quiz_data: convert_quiz_to_format(quiz),
        module_id: mod.id,
        metadata: {
          module_title: mod.title,
          quiz_id: quiz.id,
          time_limit: quiz.time_limit_minutes,
          passing_score: quiz.passing_score
        }
      }
    when 'HandsOnLab'
      lab = first_item.item
      convert_lab_to_hash(lab)
    else
      nil
    end
  end
  
  def self.convert_quiz_to_format(quiz)
    {
      id: quiz.id,
      title: quiz.title,
      description: quiz.description,
      time_limit_minutes: quiz.time_limit_minutes,
      passing_score: quiz.passing_score,
      questions: quiz.quiz_questions.order(:sequence_order).map do |q|
        {
          id: q.id,
          type: q.question_type,
          text: q.question_text,
          options: q.options,
          correct_answer: q.correct_answer,
          explanation: q.explanation,
          points: q.points
        }
      end
    }
  end
  
  # Get next micro for a chapter (enhanced with database support)
  def self.get_next_micro(chapter, current_micro_id)
    Rails.logger.info "🔍 get_next_micro: chapter=#{chapter}, current_micro_id=#{current_micro_id}"
    
    # Check if it's a lab-based chapter
    if lab_chapter?(chapter)
      lab_id = lab_id_from_chapter(chapter)
      lab_content = get_lab_as_chapter(lab_id)
      if lab_content
        micros = lab_content[:micro_lessons]
        current_index = micros.index { |m| m[:id] == current_micro_id }
        return micros[current_index + 1] if current_index && current_index < micros.length - 1
      end
    end
    
    # Try to find in database first - check both by current_micro_id and by chapter
    # For database units, chapter and micro_id are often the same (both are the slug)
    current_unit = InteractiveLearningUnit.find_by(slug: current_micro_id) || 
                   InteractiveLearningUnit.find_by(slug: chapter)
    
    if current_unit
      Rails.logger.info "✅ Found current unit: #{current_unit.slug} (sequence_order: #{current_unit.sequence_order})"
      # Get next unit by sequence_order - NO special priority for CodeSprout
      next_unit = InteractiveLearningUnit.published
                                         .where('sequence_order > ?', current_unit.sequence_order)
                                         .order(:sequence_order)
                                         .first

      if next_unit
        Rails.logger.info "✅ Found next unit: #{next_unit.slug} (sequence_order: #{next_unit.sequence_order})"
        return convert_unit_to_micro_lesson(next_unit)
      else
        Rails.logger.info "⚠️ No next unit found after #{current_unit.slug}"
      end
    end
    
    # No more fallbacks - everything is in database
    nil
  end
  
  # =============================================================================
  # LAB-TO-MICROLESSON CONVERSION SYSTEM
  # Converts HandsOnLab steps into interactive microlessons
  # =============================================================================
  
  def self.get_lab_as_chapter(lab_title_or_id)
    # Find lab in database by title or ID
    lab = if lab_title_or_id.is_a?(Integer)
            HandsOnLab.find_by(id: lab_title_or_id, lab_type: 'docker', is_active: true)
          else
            HandsOnLab.find_by(title: lab_title_or_id, lab_type: 'docker', is_active: true)
          end
    
    return nil unless lab
    
    {
      title: lab.title,
      micro_lessons: convert_lab_steps_to_microlessons(lab)
    }
  end
  
  def self.convert_lab_steps_to_microlessons(lab)
    return [] unless lab.steps.is_a?(Array)
    
    lab.steps.map.with_index do |step, index|
      {
        id: "lab_#{lab.id}_step_#{step['step_number'] || index + 1}",
        type: 'interactive',
        content: {
          title: "#{lab.title}: #{step['title']}",
          explanation: build_step_explanation(lab, step, index),
          examples: [step['expected_command']].compact,
          task: step['instruction'],
          expected_command: step['expected_command']
        },
        validation: {
          type: 'command_execution',
          expected_command: step['expected_command'],
          validation_check: step['validation'],
          require_success: true
        },
        hints: build_step_hints(step),
        metadata: {
          lab_id: lab.id,
          step_number: step['step_number'] || index + 1,
          total_steps: lab.steps.length,
          difficulty: lab.difficulty,
          category: lab.category
        }
      }
    end
  end
  
  def self.build_step_explanation(lab, step, index)
    parts = []
    
    # Step context
    parts << "**Step #{step['step_number'] || index + 1} of #{lab.steps.length}**\n"
    
    # Lab context (only on first step)
    if index == 0
      parts << "**Lab: #{lab.title}**"
      parts << lab.description
      parts << "\n**Learning Objectives:**"
      if lab.learning_objectives.present?
        lab.learning_objectives.split(',').each do |obj|
          parts << "- #{obj.strip}"
        end
      end
      parts << ""
    end
    
    # Step instruction
    parts << "**What you'll do:**"
    parts << step['instruction']
    parts << ""
    
    # Command explanation
    if step['expected_command'].present?
      parts << "**The command:**"
      parts << "`#{step['expected_command']}`"
      parts << ""
    end
    
    # Additional context based on step title
    if step['title']&.include?('Cleanup')
      parts << "🧹 **Important:** Always clean up resources after labs to avoid conflicts!"
    end
    
    parts.join("\n")
  end
  
  def self.build_step_hints(step)
    hints = []
    
    if step['expected_command'].present?
      hints << "Try: #{step['expected_command']}"
    end
    
    if step['instruction'].present?
      hints << step['instruction']
    end
    
    if step['validation'].present?
      hints << "Verify with: #{step['validation']}"
    end
    
    hints << "Check for typos in the command"
    hints << "Make sure all required flags are included"
    
    hints.uniq
  end
  
  # Get all labs as chapter definitions
  def self.get_all_lab_chapters
    HandsOnLab.where(lab_type: 'docker', is_active: true).order(:difficulty, :estimated_minutes).map do |lab|
      chapter_key = "lab_#{lab.id}"
      [chapter_key, get_lab_as_chapter(lab.title)]
    end.to_h
  end
  
  # Get lab chapters organized by category
  LAB_CHAPTERS_BY_CATEGORY = {
    'images' => ['Build Your First Docker Image', 'Multi-Stage Builds - Optimize Image Size'],
    'networking' => ['Docker Networks - Container Communication', 'Docker Compose - Multi-Container Application'],
    'operations' => ['Resource Limits - Control Container Resources', 'Container Performance Monitoring'],
    'registry' => ['Docker Registry - Push and Pull Custom Images'],
    'reliability' => ['Health Checks and Auto-Restart'],
    'security' => ['Docker Security - Non-Root User and Read-Only'],
    'data' => ['Backup and Restore Container Data'],
    # Orchestration: prefer Compose over Swarm for local orchestration
    'orchestration' => ['Docker Compose - Multi-Container Application']
  }.freeze
  
  # Get chapter name for a lab
  def self.get_lab_chapter_name(lab)
    "lab_#{lab.id}"
  end
  
  # Check if a chapter is a lab-based chapter
  def self.lab_chapter?(chapter)
    chapter.to_s.start_with?('lab_')
  end
  
  # Get lab ID from chapter name
  def self.lab_id_from_chapter(chapter)
    return nil unless lab_chapter?(chapter)
    chapter.to_s.sub('lab_', '').to_i
  end

  private
  
  def self.generate_fallback_lesson(command)
    {
      title: "Understanding #{command}",
      explanation: "This is a Docker command used in container management. Practice using it to improve your skills.",
      examples: [command],
      command_to_learn: command,
      practice_prompt: "Try using the #{command} command"
    }
  end
end
