namespace :lessons do
  desc "Parse lesson content and populate content_sections for deep linking"
  task populate_sections: :environment do
    puts "Populating content sections for lessons..."
    
    updated_count = 0
    CourseLesson.find_each do |lesson|
      sections = parse_sections_from_content(lesson.content)
      
      if sections.any?
        lesson.update!(content_sections: sections)
        updated_count += 1
        puts "  ✓ Updated lesson: #{lesson.title} (#{sections.count} sections)"
      end
    end
    
    puts "\nCompleted! Updated #{updated_count} lessons with section data."
  end
  
  private
  
  def parse_sections_from_content(content)
    return [] if content.blank?
    
    sections = []
    section_id_counter = 1
    
    # Match markdown level 2 headings (## Heading)
    content.scan(/^##\s+(.+)$/) do |match|
      heading_text = match[0].strip
      section_id = "section-#{section_id_counter}"
      section_id_counter += 1
      
      sections << {
        'id' => section_id,
        'title' => heading_text,
        'anchor' => heading_text.parameterize,
        'heading_level' => 2
      }
    end
    
    sections
  end
end
