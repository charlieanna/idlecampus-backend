class QuizSelectionService
  # Smart question selection with IRT-based difficulty matching and deduplication

  RECENTLY_SEEN_DAYS = 7 # Don't show questions seen in last 7 days

  def initialize(user)
    @user = user
  end

  # Select questions by topic with adaptive difficulty
  def select_by_topic(topic:, count:, difficulty_range: nil)
    # Get user's ability in the relevant skill dimension
    skill_dimension = infer_skill_dimension(topic)
    ability = user_ability(skill_dimension)

    # Calculate difficulty range around user ability
    diff_range = difficulty_range || [(ability - 1.0), (ability + 1.0)]

    # Find questions matching topic and difficulty
    questions = QuizQuestion
      .where(topic: topic)
      .where('difficulty >= ? AND difficulty <= ?', diff_range[0], diff_range[1])
      .where.not(id: recently_seen_question_ids)
      .order('RANDOM()')
      .limit(count)

    # If not enough questions, expand difficulty range
    if questions.length < count
      Rails.logger.info "Found only #{questions.length}/#{count} for topic #{topic}, expanding difficulty range"
      questions = QuizQuestion
        .where(topic: topic)
        .where.not(id: recently_seen_question_ids)
        .order('RANDOM()')
        .limit(count)
    end

    questions
  end

  # Select questions by skill dimension with IRT matching
  def select_by_skill_dimension(skill_dimension:, count:, difficulty_range: nil)
    ability = user_ability(skill_dimension)
    diff_range = difficulty_range || [(ability - 1.0), (ability + 1.0)]

    QuizQuestion
      .where(skill_dimension: skill_dimension)
      .where('difficulty >= ? AND difficulty <= ?', diff_range[0], diff_range[1])
      .where.not(id: recently_seen_question_ids)
      .order('RANDOM()')
      .limit(count)
  end

  # Select questions for specific commands
  def select_for_commands(commands:, question_type: nil)
    query = QuizQuestion.where.not(id: recently_seen_question_ids)

    # Filter by question type if specified
    query = query.where(question_type: question_type) if question_type.present?

    # Match questions related to these commands
    # Look in topic, concept_tags, or question_text
    command_questions = []
    commands.each do |command|
      # Extract base command (e.g., "docker ps" from "docker ps -a")
      base_command = extract_base_command(command)

      matching = query.where(
        "topic LIKE ? OR concept_tags::text LIKE ? OR question_text LIKE ?",
        "%#{base_command}%",
        "%#{base_command}%",
        "%#{base_command}%"
      ).limit(2) # Up to 2 questions per command

      command_questions.concat(matching.to_a)
    end

    command_questions.uniq
  end

  # Select questions targeting user weaknesses
  def select_for_weaknesses(count:)
    # Get weak skill dimensions (ability < 0.0)
    weak_dimensions = UserSkillDimension
      .where(user: @user)
      .where('ability_estimate < ?', 0.0)
      .order('ability_estimate ASC')
      .limit(3)
      .pluck(:skill_dimension)

    return [] if weak_dimensions.empty?

    # Select questions from weak dimensions
    questions_per_dimension = (count / weak_dimensions.length.to_f).ceil

    questions = []
    weak_dimensions.each do |dimension|
      questions.concat(
        select_by_skill_dimension(
          skill_dimension: dimension,
          count: questions_per_dimension
        ).to_a
      )
    end

    questions.shuffle.take(count)
  end

  private

  # Get user's ability estimate for a skill dimension
  def user_ability(skill_dimension)
    skill_record = UserSkillDimension
      .find_by(user: @user, skill_dimension: skill_dimension)

    skill_record&.ability_estimate || 0.0
  end

  # Get IDs of recently seen questions to avoid repetition
  def recently_seen_question_ids
    @recently_seen_question_ids ||= begin
      cutoff_date = RECENTLY_SEEN_DAYS.days.ago

      # Get question IDs from recent quiz attempts
      quiz_attempt_ids = QuizAttempt
        .where(user: @user)
        .where('created_at > ?', cutoff_date)
        .pluck(:id)

      return [] if quiz_attempt_ids.empty?

      # Extract question IDs from answers
      question_ids = QuizAttempt
        .where(id: quiz_attempt_ids)
        .pluck(:answers)
        .compact
        .flat_map { |answers| answers.keys }
        .map(&:to_i)
        .uniq

      question_ids
    end
  end

  # Extract base command from full command string
  def extract_base_command(command)
    # "docker ps -a" -> "docker ps"
    # "kubectl get pods" -> "kubectl get"
    parts = command.split(' ')
    parts.take(2).join(' ')
  end

  # Infer skill dimension from topic name
  def infer_skill_dimension(topic)
    case topic.downcase
    when /network|port|dns|bridge/
      'docker_networking'
    when /volume|storage|mount|bind/
      'docker_storage'
    when /security|user|namespace|trust/
      'docker_security'
    when /compose|stack/
      'docker_compose'
    when /build|dockerfile|image|registry/
      'docker_advanced'
    when /container|run|exec|ps|stop|rm/
      'docker_basics'
    when /pod|deployment|service|replicaset/
      'k8s_workloads'
    when /kubectl|cluster/
      'k8s_administration'
    when /ingress|networkpolicy|service/
      'k8s_networking'
    when /persistentvolume|storageclass/
      'k8s_storage'
    when /rbac|securitycontext|podsecuritypolicy/
      'k8s_security'
    else
      'docker_basics'
    end
  end
end
