namespace :remediation do
  desc "Populate question-to-lesson mappings based on topic matching"
  task populate_mappings: :environment do
    puts "Populating question-to-lesson mappings..."
    
    total_created = 0
    total_questions = QuizQuestion.count
    
    QuizQuestion.find_each.with_index do |question, index|
      next unless question.topic.present?
      
      # Find lessons related to this topic
      relevant_lessons = find_relevant_lessons(question)
      
      if relevant_lessons.any?
        relevant_lessons.each_with_index do |lesson_data, priority_index|
          lesson = lesson_data[:lesson]
          section_anchor = lesson_data[:section_anchor]
          
          # Calculate relevance weight: primary lesson gets 100, others decrease
          relevance_weight = [100 - (priority_index * 20), 20].max
          
          mapping = QuizQuestionLessonMapping.find_or_initialize_by(
            quiz_question_id: question.id,
            course_lesson_id: lesson.id
          )
          
          is_new = mapping.new_record?
          
          mapping.section_anchor = section_anchor
          mapping.relevance_weight = relevance_weight
          mapping.save!
          
          total_created += 1 if is_new
        end
        
        # Progress indicator
        if (index + 1) % 50 == 0
          puts "  Processed #{index + 1}/#{total_questions} questions..."
        end
      end
    end
    
    puts "\nCompleted!"
    puts "  Total questions processed: #{total_questions}"
    puts "  Total mappings created: #{total_created}"
    puts "  Average mappings per question: #{(total_created.to_f / total_questions).round(2)}"
  end
  
  private
  
  def find_relevant_lessons(question)
    topic = question.topic.to_s.downcase
    skill = question.skill_dimension.to_s.downcase
    
    results = []
    
    # Strategy 1: Exact topic match in lesson title
    lessons = CourseLesson.where("LOWER(title) LIKE ?", "%#{topic}%")
    lessons.each do |lesson|
      section = find_matching_section(lesson, topic)
      results << { lesson: lesson, section_anchor: section&.dig('anchor'), priority: 1 }
    end
    
    # Strategy 2: Topic match in lesson content
    if results.count < 2
      content_lessons = CourseLesson.where("LOWER(content) LIKE ?", "%#{topic}%")
        .where.not(id: results.map { |r| r[:lesson].id })
        .limit(3 - results.count)
      
      content_lessons.each do |lesson|
        section = find_matching_section(lesson, topic)
        results << { lesson: lesson, section_anchor: section&.dig('anchor'), priority: 2 }
      end
    end
    
    # Strategy 3: Skill dimension match
    if results.count < 2 && skill.present?
      skill_lessons = CourseLesson.where("LOWER(title) LIKE ? OR LOWER(content) LIKE ?", 
                                         "%#{skill}%", "%#{skill}%")
        .where.not(id: results.map { |r| r[:lesson].id })
        .limit(2 - results.count)
      
      skill_lessons.each do |lesson|
        results << { lesson: lesson, section_anchor: nil, priority: 3 }
      end
    end
    
    # Sort by priority and return
    results.sort_by { |r| r[:priority] }
  end
  
  def find_matching_section(lesson, topic)
    return nil unless lesson.content_sections.present?
    
    # Find section that mentions the topic
    lesson.content_sections.find do |section|
      section['title'].to_s.downcase.include?(topic) ||
        section['title'].to_s.downcase.include?(topic.singularize) ||
        section['title'].to_s.downcase.include?(topic.pluralize)
    end
  end
end


