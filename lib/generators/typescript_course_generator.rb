# frozen_string_literal: true

# Frontend TypeScript Course Generator
# Generates TypeScript data files from YAML course definitions
#
# Usage:
#   generator = TypescriptCourseGenerator.new
#   generator.generate('kubernetes-complete')
#   generator.generate_all
#
class TypescriptCourseGenerator
  def initialize(output_dir: nil)
    @output_dir = output_dir || Rails.root.join('frontend/src/data/courses')
    @base_paths = [
      Rails.root.join('db/seeds/converted_microlessons'),
      Rails.root.join('db/seeds/docker_complete_enhanced')
    ]
  end

  def generate_all
    puts "📝 Generating TypeScript files for all YAML courses..."

    course_count = 0
    @base_paths.each do |base_path|
      next unless Dir.exist?(base_path)

      Dir.glob(File.join(base_path, '**/manifest.yml')).each do |manifest_path|
        course_slug = File.basename(File.dirname(manifest_path))
        generate(course_slug, manifest_path)
        course_count += 1
      end
    end

    puts "\n✅ Generated TypeScript for #{course_count} courses"
  end

  def generate(course_slug, manifest_path = nil)
    # Find manifest if not provided
    unless manifest_path
      @base_paths.each do |base_path|
        path = File.join(base_path, course_slug, 'manifest.yml')
        if File.exist?(path)
          manifest_path = path
          break
        end
      end
    end

    unless manifest_path && File.exist?(manifest_path)
      puts "❌ Course not found: #{course_slug}"
      return
    end

    # Load manifest and microlessons
    manifest = YAML.load_file(manifest_path)
    course_dir = File.dirname(manifest_path)
    course_data = build_course_data(manifest, course_dir)

    # Generate TypeScript file
    output_path = File.join(@output_dir, "#{course_slug}.ts")
    write_typescript_file(output_path, course_data, course_slug)

    puts "✅ Generated: #{output_path}"
  end

  private

  def build_course_data(manifest, course_dir)
    course_meta = manifest['course']
    modules = manifest['modules'] || []

    {
      meta: {
        slug: course_meta['slug'],
        title: course_meta['title'],
        description: course_meta['description'],
        estimatedHours: course_meta['estimated_hours'],
        level: course_meta['level'],
        tags: course_meta['tags'] || []
      },
      modules: modules.map.with_index do |mod_data, mod_idx|
        build_module_data(mod_data, mod_idx, course_dir)
      end
    }
  end

  def build_module_data(mod_data, index, course_dir)
    module_data = {
      id: mod_data['slug'],
      title: mod_data['title'],
      description: mod_data['description'],
      sequence: index + 1,
      estimatedMinutes: mod_data['estimated_minutes']
    }

    # Load microlessons
    if mod_data['lessons']
      module_data[:microlessons] = load_microlessons(mod_data['lessons'], course_dir)
    end

    # Add course lessons
    if mod_data['course_lessons']
      module_data[:lessons] = mod_data['course_lessons'].map do |lesson|
        transform_course_lesson(lesson)
      end
    end

    # Add labs
    if mod_data['labs']
      module_data[:labs] = mod_data['labs'].map do |lab|
        transform_lab(lab)
      end
    end

    # Add quizzes
    if mod_data['quizzes']
      module_data[:quizzes] = mod_data['quizzes'].map do |quiz|
        transform_quiz(quiz)
      end
    end

    module_data
  end

  def load_microlessons(lesson_slugs, course_dir)
    microlessons_dir = File.join(course_dir, 'microlessons')
    return [] unless Dir.exist?(microlessons_dir)

    lesson_slugs.map do |slug|
      lesson_path = File.join(microlessons_dir, "#{slug}.yml")
      next unless File.exist?(lesson_path)

      lesson_data = YAML.load_file(lesson_path)
      transform_microlesson(lesson_data)
    end.compact
  end

  def transform_microlesson(data)
    {
      slug: data['slug'],
      title: data['title'],
      durationMinutes: data['estimated_minutes'],
      difficulty: data['difficulty'],
      content: data['content_md'],
      keyConcepts: data['key_concepts'] || [],
      keyCommands: extract_key_commands(data),
      exercises: (data['exercises'] || []).map { |ex| transform_exercise(ex) },
      objectives: data['objectives'] || []
    }
  end

  def transform_course_lesson(lesson)
    {
      title: lesson['title'],
      content: lesson['content'],
      videoUrl: lesson['video_url'],
      readingTime: lesson['reading_time_minutes']
    }
  end

  def transform_lab(lab)
    {
      slug: lab['slug'],
      title: lab['title'],
      difficulty: lab['difficulty'],
      durationMinutes: lab['estimated_minutes'],
      labType: lab['lab_type'],
      labFormat: lab['lab_format'],
      description: lab['description'],
      tasks: lab['tasks'] || []
    }.tap do |lab_data|
      # Add code editor fields if applicable
      if %w[code_editor hybrid].include?(lab['lab_format'])
        lab_data.merge!(
          programmingLanguage: lab['programming_language'],
          starterCode: lab['starter_code'],
          solutionCode: lab['solution_code'],
          testCases: lab['test_cases'] || []
        )
      end
    end
  end

  def transform_quiz(quiz)
    {
      title: quiz['title'],
      passingScore: quiz['passing_score'] || 70,
      quizType: quiz['quiz_type'],
      timeLimitMinutes: quiz['time_limit_minutes'],
      questions: (quiz['questions'] || []).map { |q| transform_quiz_question(q) }
    }
  end

  def transform_quiz_question(question)
    {
      type: question['type'],
      question: question['question'],
      options: question['options'],
      correct: question['correct'],
      explanation: question['explanation']
    }
  end

  def transform_exercise(exercise)
    base = {
      type: exercise['type'],
      sequenceOrder: exercise['sequence_order'],
      description: exercise['description'],
      hints: exercise['hints'] || [],
      requirePass: exercise['require_pass'] || false
    }

    case exercise['type']
    when 'terminal'
      base.merge(
        command: exercise['command'],
        timeoutSec: exercise['timeout_sec'],
        validation: exercise['validation']
      )
    when 'mcq'
      base.merge(
        question: exercise['question'],
        options: exercise['options'],
        correctAnswerIndex: exercise['correct_answer_index'],
        explanation: exercise['explanation']
      )
    when 'short_answer'
      base.merge(
        question: exercise['question']
      )
    when 'coding', 'code'
      base.merge(
        question: exercise['question'],
        language: exercise['language'],
        starterCode: exercise['starter_code'],
        solutionCode: exercise['solution_code'],
        testCases: exercise['test_cases'] || []
      )
    else
      base
    end
  end

  def extract_key_commands(data)
    # Extract commands from content or key_commands field
    commands = []

    # From key_commands field
    if data['key_commands']
      commands.concat(data['key_commands'])
    end

    # Parse from content_md (look for command blocks or descriptions)
    if data['content_md']
      # Extract from lines like "kubectl get pods - List all pods"
      data['content_md'].scan(/^\s*-\s*`([^`]+)`\s*-\s*(.+)$/).each do |cmd, desc|
        commands << { command: cmd, description: desc }
      end
    end

    commands
  end

  def write_typescript_file(output_path, course_data, course_slug)
    # Ensure output directory exists
    FileUtils.mkdir_p(File.dirname(output_path))

    # Generate TypeScript content
    ts_content = generate_typescript_content(course_data, course_slug)

    # Write file
    File.write(output_path, ts_content)
  end

  def generate_typescript_content(data, slug)
    # Convert to camelCase for TypeScript
    json_data = JSON.pretty_generate(deep_transform_keys(data, :camelize))

    <<~TS
      /**
       * Auto-generated from YAML course definition
       * Course: #{data[:meta][:title]}
       * Generated: #{Time.current.iso8601}
       *
       * DO NOT EDIT THIS FILE DIRECTLY
       * Edit the YAML files in db/seeds/converted_microlessons/#{slug}/
       */

      export interface CourseMetadata {
        slug: string;
        title: string;
        description?: string;
        estimatedHours?: number;
        level?: 'beginner' | 'intermediate' | 'advanced';
        tags?: string[];
      }

      export interface Exercise {
        type: 'terminal' | 'mcq' | 'short_answer' | 'coding' | 'sql' | 'reflection' | 'checkpoint';
        sequenceOrder: number;
        description?: string;
        hints?: string[];
        requirePass?: boolean;
        command?: string;
        question?: string;
        options?: string[];
        correctAnswerIndex?: number;
        [key: string]: any;
      }

      export interface Microlesson {
        slug: string;
        title: string;
        durationMinutes?: number;
        difficulty?: 'easy' | 'medium' | 'hard';
        content?: string;
        keyConcepts?: string[];
        keyCommands?: any[];
        exercises?: Exercise[];
        objectives?: string[];
      }

      export interface Lab {
        slug: string;
        title: string;
        difficulty: 'easy' | 'medium' | 'hard';
        durationMinutes: number;
        labType: string;
        labFormat: 'terminal' | 'code_editor' | 'hybrid';
        description?: string;
        tasks?: any[];
        programmingLanguage?: string;
        starterCode?: string;
        testCases?: any[];
      }

      export interface Quiz {
        title: string;
        passingScore: number;
        quizType?: string;
        timeLimitMinutes?: number;
        questions: any[];
      }

      export interface CourseModule {
        id: string;
        title: string;
        description?: string;
        sequence: number;
        estimatedMinutes?: number;
        microlessons?: Microlesson[];
        lessons?: any[];
        labs?: Lab[];
        quizzes?: Quiz[];
      }

      export interface CourseData {
        meta: CourseMetadata;
        modules: CourseModule[];
      }

      export const courseData: CourseData = #{json_data};

      export const courseMeta = courseData.meta;
      export const courseModules = courseData.modules;

      export default courseData;
    TS
  end

  def deep_transform_keys(object, method)
    case object
    when Hash
      object.each_with_object({}) do |(key, value), result|
        new_key = method == :camelize ? key.to_s.camelize(:lower) : key
        result[new_key] = deep_transform_keys(value, method)
      end
    when Array
      object.map { |e| deep_transform_keys(e, method) }
    else
      object
    end
  end
end
