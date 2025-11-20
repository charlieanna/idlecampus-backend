# Course Builder DSL - A clean way to define courses
# Usage:
#   CourseBuilder.define("docker-fundamentals") do
#     course title: "Docker Fundamentals", difficulty: "beginner" do
#       module "Container Basics" do
#         lesson "What are Containers?", content: "..."
#         quiz "Container Quiz", passing_score: 70 do
#           mcq "What is a container?", correct: "A", options: {...}
#         end
#         lab "Your First Container", lab_type: "docker", format: "terminal" do
#           step "Pull image", command: "docker pull nginx"
#         end
#       end
#     end
#   end

module CourseBuilder
  class DSL
    attr_reader :course_data, :modules_data

    @@definitions = {}

    def self.definitions
      @@definitions
    end

    def self.define(slug, &block)
      builder = new(slug)
      builder.instance_eval(&block)
      @@definitions[slug] = builder.course_data.merge(modules: builder.modules_data)
      builder
    end

    def initialize(slug)
      @slug = slug
      @course_data = {}
      @modules_data = []
      @current_module = nil
      @plugins = []
      @config = {}
    end

    def course(**attributes, &block)
      @course_data = attributes.merge(slug: @slug)
      instance_eval(&block) if block_given?
    end

    # Enable a plugin for this course
    # Usage: plugin :progressive_learning, enabled: true
    def plugin(plugin_name, **options)
      @plugins << { name: plugin_name, options: options }
      @course_data[:plugins] ||= []
      @course_data[:plugins] << plugin_name
      @course_data[:plugin_options] ||= {}
      @course_data[:plugin_options][plugin_name.to_s] = options
    end

    # Set custom configuration for the course
    # Usage: config interactive_units: true, formula_sheets: true
    def config(**custom_config)
      @config.merge!(custom_config)
      @course_data[:custom_config] = @config
    end

    def mod(title, &block)
      module_builder = ModuleBuilder.new(title, @modules_data.length + 1)
      module_builder.instance_eval(&block)
      @modules_data << module_builder.to_h
    end

    alias_method :module, :mod

    def to_course_object
      # Returns a structure that can be used to create the course
      {
        course: @course_data,
        modules: @modules_data,
        plugins: @plugins,
        config: @config
      }
    end

    def generate!
      # Creates the actual ActiveRecord objects
      CourseGenerator.new(self).generate!
    end

    # Get list of plugins for this course
    attr_reader :plugins

    # Get custom config for this course
    attr_reader :config
  end

  class ModuleBuilder
    attr_reader :items

    def initialize(title, sequence_order)
      @title = title
      @slug = title.parameterize
      @sequence_order = sequence_order
      @description = ""
      @estimated_minutes = 0
      @learning_objectives = []
      @items = []
    end

    def description(text)
      @description = text
    end

    def estimated_minutes(mins)
      @estimated_minutes = mins
    end

    def learning_objectives(*objectives)
      @learning_objectives = objectives.flatten
    end

    def lesson(title, **attributes, &block)
      lesson_data = attributes.merge(
        type: :lesson,
        title: title,
        sequence_order: @items.length + 1
      )

      if block_given?
        lesson_builder = LessonBuilder.new(title)
        lesson_builder.instance_eval(&block)
        lesson_data.merge!(lesson_builder.to_h)
      end

      @items << lesson_data
    end

    def quiz(title, **attributes, &block)
      quiz_builder = QuizBuilder.new(title, attributes)
      quiz_builder.instance_eval(&block) if block_given?

      @items << {
        type: :quiz,
        title: title,
        sequence_order: @items.length + 1,
        **quiz_builder.to_h
      }
    end

    def lab(title, **attributes, &block)
      lab_builder = LabBuilder.new(title, attributes)
      lab_builder.instance_eval(&block) if block_given?

      @items << {
        type: :lab,
        title: title,
        sequence_order: @items.length + 1,
        **lab_builder.to_h
      }
    end

    def interactive_unit(title, **attributes, &block)
      unit_builder = InteractiveUnitBuilder.new(title, attributes)
      unit_builder.instance_eval(&block) if block_given?

      @items << {
        type: :interactive_unit,
        title: title,
        sequence_order: @items.length + 1,
        **unit_builder.to_h
      }
    end

    def to_h
      {
        title: @title,
        slug: @slug,
        description: @description,
        sequence_order: @sequence_order,
        estimated_minutes: @estimated_minutes,
        learning_objectives: @learning_objectives,
        items: @items
      }
    end
  end

  class LessonBuilder
    def initialize(title)
      @title = title
      @content = ""
      @reading_time_minutes = 10
      @key_concepts = []
      @key_commands = []
    end

    def content(text)
      @content = text
    end

    def reading_time(minutes)
      @reading_time_minutes = minutes
    end

    def estimated_minutes(minutes)
      @reading_time_minutes = minutes
    end

    def key_concepts(*concepts)
      @key_concepts = concepts.flatten
    end

    def key_commands(*commands)
      @key_commands = commands.flatten
    end

    def to_h
      {
        content: @content,
        reading_time_minutes: @reading_time_minutes,
        key_concepts: @key_concepts,
        key_commands: @key_commands
      }
    end
  end

  class QuizBuilder
    def initialize(title, attributes = {})
      @title = title
      @description = attributes[:description] || ""
      @passing_score = attributes[:passing_score] || 70
      @time_limit_minutes = attributes[:time_limit_minutes]
      @max_attempts = attributes[:max_attempts] || 3
      @quiz_type = attributes[:quiz_type] || "standard"
      @questions = []
    end

    def description(text)
      @description = text
    end

    def mcq(question_text, **options)
      @questions << {
        question_type: "mcq",
        question_text: question_text,
        options: options[:options] || [],
        correct_answer: options[:correct],
        explanation: options[:explanation],
        points: options[:points] || 10,
        difficulty_level: options[:difficulty] || "medium"
      }
    end

    def true_false(question_text, correct:, **options)
      @questions << {
        question_type: "true_false",
        question_text: question_text,
        correct_answer: correct.to_s,
        explanation: options[:explanation],
        points: options[:points] || 5,
        difficulty_level: options[:difficulty] || "easy"
      }
    end

    def command(question_text, answer:, **options)
      @questions << {
        question_type: "command",
        question_text: question_text,
        correct_answer: answer,
        explanation: options[:explanation],
        points: options[:points] || 15,
        difficulty_level: options[:difficulty] || "hard"
      }
    end

    def fill_blank(question_text, answer:, **options)
      @questions << {
        question_type: "fill_blank",
        question_text: question_text,
        correct_answer: answer,
        explanation: options[:explanation],
        points: options[:points] || 10,
        difficulty_level: options[:difficulty] || "medium"
      }
    end

    def to_h
      {
        description: @description,
        passing_score: @passing_score,
        time_limit_minutes: @time_limit_minutes,
        max_attempts: @max_attempts,
        quiz_type: @quiz_type,
        questions: @questions
      }
    end
  end

  class LabBuilder
    def initialize(title, attributes = {})
      @title = title
      @description = attributes[:description] || ""
      @difficulty = attributes[:difficulty] || "easy"
      @estimated_minutes = attributes[:estimated_minutes] || 30
      @lab_type = attributes[:lab_type] || "docker"
      @lab_format = attributes[:format] || attributes[:lab_format] || "terminal"
      @category = attributes[:category]
      @certification_exam = attributes[:certification_exam]
      @learning_objectives = attributes[:learning_objectives]
      @prerequisites = attributes[:prerequisites] || []
      @environment_image = attributes[:environment_image] || "docker:20-dind"
      @required_tools = attributes[:required_tools] || ["docker"]
      @points_reward = attributes[:points_reward] || 100
      @max_attempts = attributes[:max_attempts] || 5

      # Terminal lab specific
      @steps = []
      @validation_rules = {}

      # Code editor specific
      @programming_language = attributes[:programming_language]
      @starter_code = attributes[:starter_code]
      @solution_code = attributes[:solution_code]
      @test_cases = []
      @time_limit_seconds = attributes[:time_limit_seconds] || 5
      @memory_limit_mb = attributes[:memory_limit_mb] || 128

      # SQL specific
      @schema_setup = attributes[:schema_setup]
      @sample_data = attributes[:sample_data]
    end

    def description(text)
      @description = text
    end

    def programming_language(lang)
      @programming_language = lang
    end

    def difficulty(level)
      @difficulty = level
    end

    def estimated_minutes(minutes)
      @estimated_minutes = minutes
    end

    def step(title, **options)
      @steps << {
        step_number: @steps.length + 1,
        title: title,
        instruction: options[:instruction] || options[:desc] || "",
        expected_command: options[:command] || options[:expected_command],
        validation: options[:validation],
        hint: options[:hint]
      }
    end

    def validation_rule(key, value)
      @validation_rules[key] = value
    end

    def starter_code(code)
      @starter_code = code
    end

    def solution_code(code)
      @solution_code = code
    end

    def test_case(**options)
      @test_cases << {
        description: options[:description] || options[:desc],
        input: options[:input],
        expected_output: options[:expected_output] || options[:output],
        hidden: options[:hidden] || false,
        points: options[:points] || 10
      }
    end

    def schema_setup(sql)
      @schema_setup = sql
    end

    def sample_data(sql)
      @sample_data = sql
    end

    def to_h
      base = {
        description: @description,
        difficulty: @difficulty,
        estimated_minutes: @estimated_minutes,
        lab_type: @lab_type,
        lab_format: @lab_format,
        category: @category,
        certification_exam: @certification_exam,
        learning_objectives: @learning_objectives,
        prerequisites: @prerequisites,
        environment_image: @environment_image,
        required_tools: @required_tools,
        points_reward: @points_reward,
        max_attempts: @max_attempts
      }

      if @lab_format == "terminal"
        base.merge(
          steps: @steps,
          validation_rules: @validation_rules
        )
      elsif @lab_format == "code_editor"
        base.merge(
          programming_language: @programming_language,
          starter_code: @starter_code,
          solution_code: @solution_code,
          test_cases: @test_cases,
          time_limit_seconds: @time_limit_seconds,
          memory_limit_mb: @memory_limit_mb,
          schema_setup: @schema_setup,
          sample_data: @sample_data
        )
      else
        base
      end
    end
  end

  class InteractiveUnitBuilder
    def initialize(title, attributes = {})
      @title = title
      @slug = title.parameterize
      @concept_explanation = attributes[:concept_explanation] || ""
      @command_to_learn = attributes[:command_to_learn]
      @command_variations = attributes[:command_variations] || []
      @practice_hints = attributes[:practice_hints] || []
      @scenario_description = attributes[:scenario_description]
      @scenario_steps = []
      @difficulty_level = attributes[:difficulty_level] || "easy"
      @estimated_minutes = attributes[:estimated_minutes] || 3
      @category = attributes[:category]
      @learning_objectives = attributes[:learning_objectives] || []
      @prerequisites = attributes[:prerequisites] || []

      # Quiz data
      @quiz_question_text = attributes[:quiz_question_text]
      @quiz_question_type = attributes[:quiz_question_type] || "mcq"
      @quiz_options = attributes[:quiz_options] || []
      @quiz_correct_answer = attributes[:quiz_correct_answer]
      @quiz_explanation = attributes[:quiz_explanation]
    end

    def concept(text)
      @concept_explanation = text
    end

    def command(cmd)
      @command_to_learn = cmd
    end

    def variations(*cmds)
      @command_variations = cmds.flatten
    end

    def hints(*hints)
      @practice_hints = hints.flatten
    end

    def scenario_step(**options)
      @scenario_steps << {
        step: @scenario_steps.length + 1,
        instruction: options[:instruction],
        command: options[:command],
        explanation: options[:explanation]
      }
    end

    def quiz(question_text, **options)
      @quiz_question_text = question_text
      @quiz_question_type = options[:type] || "mcq"
      @quiz_options = options[:options] || []
      @quiz_correct_answer = options[:correct]
      @quiz_explanation = options[:explanation]
    end

    def to_h
      {
        slug: @slug,
        concept_explanation: @concept_explanation,
        command_to_learn: @command_to_learn,
        command_variations: @command_variations,
        practice_hints: @practice_hints,
        scenario_description: @scenario_description,
        scenario_steps: @scenario_steps,
        difficulty_level: @difficulty_level,
        estimated_minutes: @estimated_minutes,
        category: @category,
        learning_objectives: @learning_objectives,
        prerequisites: @prerequisites,
        quiz_question_text: @quiz_question_text,
        quiz_question_type: @quiz_question_type,
        quiz_options: @quiz_options,
        quiz_correct_answer: @quiz_correct_answer,
        quiz_explanation: @quiz_explanation
      }
    end
  end
end
