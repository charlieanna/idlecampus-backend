# Load Algorithms & Data Structures Problems into Database
# This seed file loads 4600+ coding interview problems from the generated JSON
# Run with: rails db:seed:algorithms_problems
# or include in main seed file

require 'json'

puts "Loading Algorithms & Data Structures problems..."

# Read the generated problems JSON
json_path = Rails.root.join('db', 'seeds', 'algorithms_problems.json')
unless File.exist?(json_path)
  puts "ERROR: #{json_path} not found!"
  puts "Please run: ruby db/seeds/algorithms_problem_generator.rb"
  exit 1
end

data = JSON.parse(File.read(json_path))
problems_data = data['problems']

puts "Found #{problems_data.length} problems to import"
puts "Difficulty distribution: #{data['metadata']['difficulty_distribution']}"
puts "Topic distribution: #{data['metadata']['topic_distribution']}"

# Clear existing problems if desired (uncomment to enable)
# puts "Clearing existing problems..."
# Problem.destroy_all

# Import problems in batches for better performance
batch_size = 100
total_imported = 0
failed_imports = []

problems_data.each_slice(batch_size).with_index do |batch, batch_num|
  puts "Processing batch #{batch_num + 1} (#{batch_size} problems)..."

  batch.each do |problem_data|
    begin
      # Check if problem already exists
      problem = Problem.find_or_initialize_by(slug: problem_data['slug'])

      # Map the JSON data to problem attributes
      problem.assign_attributes(
        title: problem_data['title'],
        description: problem_data['description'],
        difficulty: problem_data['difficulty'],
        topic: problem_data['topic'],
        subtopic: problem_data['subtopic'],
        family_id: problem_data['family_id'],

        # JSONB fields
        examples: problem_data['examples'] || [],
        constraints: problem_data['constraints'] || [],
        test_cases: problem_data['test_cases'] || [],
        hints: problem_data['hints'] || [],
        tags: problem_data['tags'] || [],
        related_problems: problem_data['related_problems'] || [],
        prerequisites: problem_data['prerequisites'] || [],
        companies: problem_data['companies'] || [],
        starter_code: problem_data['starter_code'] || {},
        follow_ups: problem_data['follow_ups'] || [],

        # Metadata
        solution_approach: problem_data['solution_approach'],
        time_complexity: problem_data['time_complexity'],
        space_complexity: problem_data['space_complexity'],
        frequency: problem_data['frequency'],
        success_rate: problem_data['success_rate'],
        estimated_time_mins: problem_data['estimated_time_mins'],
        points: problem_data['points'],

        # Legacy fields (for backward compatibility)
        sample_input: problem_data['examples']&.first&.dig('input')&.to_s,
        sample_output: problem_data['examples']&.first&.dig('output')&.to_s
      )

      if problem.save
        total_imported += 1
      else
        failed_imports << { title: problem_data['title'], errors: problem.errors.full_messages }
      end

    rescue => e
      failed_imports << { title: problem_data['title'], error: e.message }
    end
  end

  # Show progress
  print "Imported: #{total_imported}/#{problems_data.length} problems\r"
end

puts "\n"
puts "=" * 80
puts "IMPORT COMPLETE!"
puts "=" * 80
puts "Successfully imported: #{total_imported} problems"

if failed_imports.any?
  puts "Failed imports: #{failed_imports.length}"
  puts "\nFirst 5 failures:"
  failed_imports.first(5).each do |fail|
    puts "  - #{fail[:title]}: #{fail[:errors] || fail[:error]}"
  end
end

puts "\n"
puts "SUMMARY BY DIFFICULTY:"
Problem.group(:difficulty).count.each do |difficulty, count|
  puts "  #{difficulty}: #{count} problems"
end

puts "\n"
puts "SUMMARY BY TOPIC:"
Problem.group(:topic).count.each do |topic, count|
  puts "  #{topic}: #{count} problems"
end

puts "\n"
puts "PROBLEM FAMILIES:"
families = Problem.select(:family_id, :topic).distinct.group_by(&:topic)
families.each do |topic, family_list|
  puts "  #{topic}: #{family_list.map(&:family_id).uniq.length} families"
end

puts "\n"
puts "=" * 80
puts "DATABASE READY FOR CODING INTERVIEW PREP!"
puts "=" * 80
puts "\nSample queries:"
puts "  - Easy problems: Problem.where(difficulty: 'easy')"
puts "  - Arrays & Strings: Problem.where(topic: 'Arrays & Strings')"
puts "  - Problem family: Problem.where(family_id: 'array-basics-001')"
puts "  - By company: Problem.where(\"'Amazon' = ANY(companies)\")"
puts "  - By tag: Problem.where(\"'hash-map' = ANY(tags)\")"
puts "  - Top frequency: Problem.where(frequency: 'very-high')"
