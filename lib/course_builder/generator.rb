# Course Generator - Converts DSL definitions to ActiveRecord objects
require_relative 'dsl'

module CourseBuilder
  class Generator
    attr_reader :dsl, :course, :modules

    def initialize(dsl)
      @dsl = dsl
      @course = nil
      @modules = []
    end

    def generate!
      data = @dsl.to_course_object

      ActiveRecord::Base.transaction do
        @course = create_course(data[:course])
        @modules = create_modules(data[:modules], @course)
      end

      {
        course: @course,
        modules: @modules,
        success: true
      }
    rescue => e
      {
        success: false,
        error: e.message,
        backtrace: e.backtrace.first(5)
      }
    end

    private

    def create_course(course_data)
      # Handle JSON fields
      course_attrs = course_data.dup
      course_attrs[:learning_objectives] = JSON.generate(course_attrs[:learning_objectives]) if course_attrs[:learning_objectives]
      course_attrs[:prerequisites] = JSON.generate(course_attrs[:prerequisites]) if course_attrs[:prerequisites]

      # Find or create course
      course = Course.find_or_initialize_by(slug: course_attrs[:slug])
      course.assign_attributes(course_attrs)
      course.save!

      puts "✅ Course created: #{course.title}"
      course
    end

    def create_modules(modules_data, course)
      modules_data.map do |module_data|
        create_module(module_data, course)
      end
    end

    def create_module(module_data, course)
      # Extract items
      items_data = module_data.delete(:items) || []

      # Handle JSON fields
      module_attrs = module_data.dup
      module_attrs[:learning_objectives] = JSON.generate(module_attrs[:learning_objectives]) if module_attrs[:learning_objectives].is_a?(Array)

      # Find or create module
      course_module = course.course_modules.find_or_initialize_by(slug: module_attrs[:slug])
      course_module.assign_attributes(module_attrs)
      course_module.save!

      puts "  📚 Module created: #{course_module.title}"

      # Create items
      items_data.each do |item_data|
        create_module_item(item_data, course_module)
      end

      course_module
    end

    def create_module_item(item_data, course_module)
      item_type = item_data.delete(:type)
      sequence_order = item_data.delete(:sequence_order)

      case item_type
      when :lesson
        item = create_lesson(item_data)
        puts "    📖 Lesson: #{item.title}"
      when :quiz
        item = create_quiz(item_data)
        puts "    ❓ Quiz: #{item.title}"
      when :lab
        item = create_lab(item_data)
        puts "    🧪 Lab: #{item.title}"
      when :interactive_unit
        item = create_interactive_unit(item_data)
        puts "    🎓 Interactive Unit: #{item.title}"
      else
        raise "Unknown item type: #{item_type}"
      end

      # Create ModuleItem association
      module_item = course_module.module_items.find_or_initialize_by(
        item_type: item.class.name,
        item_id: item.id
      )
      module_item.sequence_order = sequence_order
      module_item.required = true
      module_item.save!

      item
    end

    def create_lesson(data)
      # Handle JSON fields
      attrs = data.dup
      attrs[:key_concepts] = JSON.generate(attrs[:key_concepts]) if attrs[:key_concepts].is_a?(Array)
      attrs[:key_commands] = JSON.generate(attrs[:key_commands]) if attrs[:key_commands].is_a?(Array)

      lesson = CourseLesson.find_or_initialize_by(title: attrs[:title])
      lesson.assign_attributes(attrs)
      lesson.save!
      lesson
    end

    def create_quiz(data)
      # Extract questions
      questions_data = data.delete(:questions) || []

      quiz = Quiz.find_or_initialize_by(title: data[:title])
      quiz.assign_attributes(data)
      quiz.save!

      # Create questions
      questions_data.each_with_index do |q_data, index|
        create_quiz_question(q_data, quiz, index + 1)
      end

      quiz
    end

    def create_quiz_question(data, quiz, sequence_order)
      attrs = data.dup

      # Handle MCQ options
      if attrs[:options].is_a?(Array)
        attrs[:options] = JSON.generate(attrs[:options])
      end

      question = quiz.quiz_questions.find_or_initialize_by(
        sequence_order: sequence_order
      )
      question.assign_attributes(attrs)
      question.save!
      question
    end

    def create_lab(data)
      attrs = data.dup

      # Handle JSON fields
      attrs[:steps] = JSON.generate(attrs[:steps]) if attrs[:steps].is_a?(Array)
      attrs[:validation_rules] = JSON.generate(attrs[:validation_rules]) if attrs[:validation_rules].is_a?(Hash)
      attrs[:test_cases] = JSON.generate(attrs[:test_cases]) if attrs[:test_cases].is_a?(Array)
      attrs[:required_tools] = JSON.generate(attrs[:required_tools]) if attrs[:required_tools].is_a?(Array)
      attrs[:prerequisites] = JSON.generate(attrs[:prerequisites]) if attrs[:prerequisites].is_a?(Array)

      lab = HandsOnLab.find_or_initialize_by(title: attrs[:title])
      lab.assign_attributes(attrs)
      lab.save!
      lab
    end

    def create_interactive_unit(data)
      attrs = data.dup

      # Handle JSON fields
      attrs[:command_variations] = JSON.generate(attrs[:command_variations]) if attrs[:command_variations].is_a?(Array)
      attrs[:practice_hints] = JSON.generate(attrs[:practice_hints]) if attrs[:practice_hints].is_a?(Array)
      attrs[:scenario_steps] = JSON.generate(attrs[:scenario_steps]) if attrs[:scenario_steps].is_a?(Array)
      attrs[:learning_objectives] = JSON.generate(attrs[:learning_objectives]) if attrs[:learning_objectives].is_a?(Array)
      attrs[:prerequisites] = JSON.generate(attrs[:prerequisites]) if attrs[:prerequisites].is_a?(Array)
      attrs[:quiz_options] = JSON.generate(attrs[:quiz_options]) if attrs[:quiz_options].is_a?(Array)

      unit = InteractiveLearningUnit.find_or_initialize_by(slug: attrs[:slug])
      unit.assign_attributes(attrs)
      unit.save!
      unit
    end
  end
end
