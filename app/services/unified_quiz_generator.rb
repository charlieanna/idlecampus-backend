class UnifiedQuizGenerator
  # Unified entry point for all quiz generation types
  # Supports: review_session, topic_deepdive, mastery_challenge

  QUIZ_TYPES = {
    review_session: 'review_session',
    topic_deepdive: 'topic_deepdive',
    mastery_challenge: 'mastery_challenge'
  }.freeze

  def initialize(user)
    @user = user
  end

  # Generate review session quiz - bundles spaced repetition items
  def generate_review_session(options: {})
    length = options[:length] || 10

    # Get due spaced repetition items
    due_items = SpacedRepetitionItem
      .for_user(@user.id)
      .due
      .includes(:item)
      .limit(length)

    return nil if due_items.empty?

    # Extract quiz questions from items
    questions = due_items.map(&:item).select { |item| item.is_a?(QuizQuestion) }

    # Create quiz
    quiz = Quiz.create!(
      title: "Review Session - #{Date.today.strftime('%b %d, %Y')}",
      description: "Practice #{questions.length} items due for review using spaced repetition",
      quiz_type: QUIZ_TYPES[:review_session],
      passing_score: 70,
      max_attempts: nil, # Unlimited attempts for practice
      shuffle_questions: true,
      show_correct_answers: true,
      metadata: {
        generated_at: Time.current,
        review_item_ids: due_items.map(&:id),
        user_id: @user.id
      }
    )

    # Link questions to quiz
    questions.each_with_index do |question, index|
      quiz.quiz_questions << question
    end

    Rails.logger.info "✅ Generated review session quiz: #{quiz.id} with #{questions.length} questions"

    quiz
  end

  # Generate topic deep-dive quiz - focused practice on specific topic
  def generate_topic_deepdive(topic:, options: {})
    length = options[:length] || 15

    # Use QuizSelectionService for smart question selection
    selection_service = QuizSelectionService.new(@user)
    questions = selection_service.select_by_topic(
      topic: topic,
      count: length,
      difficulty_range: options[:difficulty_range]
    )

    # If insufficient questions, use hybrid generation
    if questions.length < length
      Rails.logger.info "Only found #{questions.length}/#{length} questions for #{topic}, will use hybrid generation"
      # TODO: Phase 5 - Generate additional questions using QuestionGeneratorService
    end

    return nil if questions.empty?

    # Detect skill dimension from first question
    skill_dimension = questions.first&.skill_dimension || infer_skill_dimension(topic)

    quiz = Quiz.create!(
      title: "Deep Dive: #{topic}",
      description: "Master #{topic} with #{questions.length} focused practice questions",
      quiz_type: QUIZ_TYPES[:topic_deepdive],
      passing_score: 75,
      max_attempts: nil,
      shuffle_questions: true,
      show_correct_answers: true,
      metadata: {
        generated_at: Time.current,
        topic: topic,
        skill_dimension: skill_dimension,
        user_id: @user.id,
        adaptive: true # Adjust difficulty mid-quiz
      }
    )

    # Link questions
    questions.each_with_index do |question, index|
      quiz.quiz_questions << question
    end

    Rails.logger.info "✅ Generated topic deep-dive quiz: #{quiz.id} for topic '#{topic}' with #{questions.length} questions"

    quiz
  end

  # Generate command mastery challenge - timed rapid-fire quiz
  def generate_mastery_challenge(options: {})
    length = options[:length] || 10
    time_limit = options[:time_limit] || 5 # 5 minutes default

    # Find commands in 75-85% mastery range
    near_mastery_commands = UserCommandMastery
      .where(user: @user)
      .where('proficiency_score >= ? AND proficiency_score < ?', 75, 85)
      .order('proficiency_score DESC')
      .limit(length)

    return nil if near_mastery_commands.empty?

    # Select command-type questions for these commands
    selection_service = QuizSelectionService.new(@user)
    questions = selection_service.select_for_commands(
      commands: near_mastery_commands.map(&:canonical_command),
      question_type: 'command'
    )

    return nil if questions.empty?

    quiz = Quiz.create!(
      title: "Mastery Challenge - #{Date.today.strftime('%b %d')}",
      description: "🔥 #{time_limit}-minute rapid-fire challenge! Push #{questions.length} commands to full mastery",
      quiz_type: QUIZ_TYPES[:mastery_challenge],
      passing_score: 80,
      max_attempts: 3, # Limited attempts for challenge
      shuffle_questions: true,
      show_correct_answers: true,
      time_limit_minutes: time_limit,
      metadata: {
        generated_at: Time.current,
        target_commands: near_mastery_commands.map(&:canonical_command),
        speed_bonus_enabled: true,
        target_time_per_question: 30, # seconds
        user_id: @user.id
      }
    )

    # Link questions
    questions.each do |question|
      quiz.quiz_questions << question
    end

    Rails.logger.info "✅ Generated mastery challenge: #{quiz.id} with #{questions.length} questions, #{time_limit}min limit"

    quiz
  end

  private

  # Infer skill dimension from topic name
  def infer_skill_dimension(topic)
    case topic.downcase
    when /network|port|dns|bridge/
      'networking'
    when /volume|storage|mount|bind/
      'storage'
    when /security|user|namespace|trust/
      'security'
    when /compose|stack/
      'orchestration'
    when /build|dockerfile|image/
      'image_management'
    when /container|run|exec|ps/
      'container_management'
    when /pod|deployment|service|replicaset/
      'k8s_workloads'
    when /kubectl|cluster/
      'k8s_administration'
    else
      'docker_basics'
    end
  end
end
