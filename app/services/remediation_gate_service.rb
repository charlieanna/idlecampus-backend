# Remediation Gate Service
# Determines if user can progress based on command mastery
# Blocks advancement if critical commands are below mastery threshold

class RemediationGateService
  MASTERY_THRESHOLD = 80.0  # Must achieve 80% proficiency to pass
  MIN_ATTEMPTS = 3          # Must attempt command at least 3 times

  attr_reader :user, :lesson, :module_context

  def initialize(user, lesson, module_context: nil)
    @user = user
    @lesson = lesson
    @module_context = module_context
  end

  # Check if user can progress past this lesson
  def can_progress?
    weak_commands = get_weak_commands
    weak_commands.empty?
  end

  # Get all commands that are blocking progression
  def get_weak_commands
    lesson_commands = extract_lesson_commands
    return [] if lesson_commands.empty?

    weak = []

    lesson_commands.each do |command_text|
      canonical = CommandCanonicalizer.canonicalize(command_text)
      mastery = user.user_command_masteries.find_by(canonical_command: canonical)

      # Command is weak if:
      # 1. Never attempted, OR
      # 2. Attempted but below mastery threshold
      if mastery.nil?
        weak << {
          command: command_text,
          canonical_command: canonical,
          reason: 'not_attempted',
          current_score: 0,
          required_score: MASTERY_THRESHOLD,
          total_attempts: 0
        }
      elsif !meets_mastery_requirements?(mastery)
        decay_service = MasteryDecayService.new(mastery)
        current_score = decay_service.current_decayed_score

        weak << {
          command: command_text,
          canonical_command: canonical,
          reason: current_score < MASTERY_THRESHOLD ? 'low_proficiency' : 'insufficient_attempts',
          current_score: current_score.round(1),
          required_score: MASTERY_THRESHOLD,
          total_attempts: mastery.total_attempts,
          min_attempts: MIN_ATTEMPTS,
          consecutive_failures: mastery.consecutive_failures
        }
      end
    end

    weak
  end

  # Get progression status with details
  def progression_status
    weak_commands = get_weak_commands
    lesson_commands = extract_lesson_commands

    {
      can_progress: weak_commands.empty?,
      total_commands: lesson_commands.size,
      mastered_count: lesson_commands.size - weak_commands.size,
      weak_commands: weak_commands,
      completion_percentage: calculate_completion_percentage(weak_commands.size, lesson_commands.size),
      gate_message: generate_gate_message(weak_commands)
    }
  end

  # Generate drill session for weak commands
  def generate_drill_session
    weak_commands = get_weak_commands
    return nil if weak_commands.empty?

    DrillGenerator.new(user, weak_commands).generate_session
  end

  # Mark gate as passed (for analytics)
  def mark_gate_passed!
    GatePassage.create!(
      user: user,
      lesson: lesson,
      passed_at: Time.current,
      weak_commands_at_start: get_weak_commands.size,
      attempts_required: calculate_total_attempts_needed
    )
  rescue => e
    Rails.logger.error "Failed to mark gate as passed: #{e.message}"
  end

  private

  def extract_lesson_commands
    commands = []

    # Extract from lesson items if available
    if lesson.respond_to?(:items) && lesson.items.present?
      lesson.items.each do |item|
        if item.is_a?(Hash) && item['type'] == 'command'
          commands << item['command']['command']
        elsif item.respond_to?(:type) && item.type == 'command'
          commands << item.command.command
        end
      end
    end

    # Extract from lesson commands if available
    if lesson.respond_to?(:commands) && lesson.commands.present?
      lesson.commands.each do |cmd|
        if cmd.is_a?(Hash)
          commands << cmd['command']
        else
          commands << cmd.command
        end
      end
    end

    # Extract from lesson content (look for code blocks)
    if lesson.respond_to?(:content) && lesson.content.present?
      # Match commands in code blocks: ```bash\ndocker ps\n```
      lesson.content.scan(/```(?:bash|sh)?\n(.+?)\n```/m).each do |match|
        commands << match[0].strip
      end

      # Match inline code that looks like commands
      lesson.content.scan(/`((?:docker|kubectl|ls|cd|mkdir|rm|git|npm|yarn)\s+[^`]+)`/).each do |match|
        commands << match[0].strip
      end
    end

    commands.uniq.map(&:strip).reject(&:empty?)
  end

  def meets_mastery_requirements?(mastery)
    decay_service = MasteryDecayService.new(mastery)
    current_score = decay_service.current_decayed_score

    # Must meet BOTH criteria:
    # 1. Current score >= MASTERY_THRESHOLD
    # 2. Total attempts >= MIN_ATTEMPTS
    current_score >= MASTERY_THRESHOLD && mastery.total_attempts >= MIN_ATTEMPTS
  end

  def calculate_completion_percentage(weak_count, total_count)
    return 100.0 if total_count == 0
    ((total_count - weak_count).to_f / total_count * 100).round(1)
  end

  def calculate_total_attempts_needed
    weak_commands = get_weak_commands
    weak_commands.sum { |cmd| MIN_ATTEMPTS - (cmd[:total_attempts] || 0) }
  end

  def generate_gate_message(weak_commands)
    return "Great job! You can proceed to the next lesson." if weak_commands.empty?

    case weak_commands.size
    when 1
      "Master 1 more command to unlock the next lesson."
    else
      "Master #{weak_commands.size} commands to unlock the next lesson."
    end
  end

  class << self
    # Check if user can progress past module
    def can_progress_module?(user, course_module)
      lessons = course_module.lessons

      lessons.all? do |lesson|
        gate = new(user, lesson)
        gate.can_progress?
      end
    end

    # Get all blocking gates for a course
    def get_blocking_gates(user, course)
      blocking_gates = []

      course.course_modules.order(:sequence_order).each do |course_module|
        course_module.lessons.each do |lesson|
          gate = new(user, lesson)
          status = gate.progression_status

          unless status[:can_progress]
            blocking_gates << {
              lesson_id: lesson.id,
              lesson_title: lesson.title,
              module_title: course_module.title,
              status: status
            }
          end
        end
      end

      blocking_gates
    end

    # Batch check: Get next available lesson considering gates
    def next_available_lesson(user, course)
      course.course_modules.order(:sequence_order).each do |course_module|
        course_module.lessons.order(:sequence_order).each do |lesson|
          # Check if lesson is already completed
          completion = LessonCompletion.find_by(
            user: user,
            course_lesson: lesson,
            completed: true
          )

          next if completion

          # Check if previous lessons are mastered
          gate = new(user, lesson)
          return lesson if gate.can_progress? || lesson == course_module.lessons.first

          # If gate is blocking, return nil (user must complete remediation)
          return nil
        end
      end

      nil # Course complete
    end
  end
end

# Model for tracking gate passages (optional, for analytics)
# Run: rails generate model GatePassage user:references lesson:references passed_at:datetime weak_commands_at_start:integer attempts_required:integer
class GatePassage < ApplicationRecord
  belongs_to :user
  belongs_to :lesson, class_name: 'CourseLesson'

  validates :passed_at, presence: true
end
