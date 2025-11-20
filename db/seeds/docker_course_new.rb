# Docker Course - New Template-Based Seed
# This replaces the manual seed logic with template-based generation
# To use: rails course:generate[docker_fundamentals]
# Or run this file directly: rails db:seed:docker_course_new

puts "🐳 Seeding Docker Course (Template-Based)..."

# Load the DSL and Generator
require_relative '../../lib/course_builder/dsl'
require_relative '../../lib/course_builder/generator'

# Load the template
template_path = Rails.root.join("lib", "course_templates", "docker_fundamentals.rb")

if File.exist?(template_path)
  puts "📂 Loading template: #{template_path}"

  # Execute the template (returns DSL instance)
  dsl = eval(File.read(template_path), binding, template_path.to_s)

  # Generate the course
  puts "🚀 Generating course..."
  generator = CourseBuilder::Generator.new(dsl)
  result = generator.generate!

  if result[:success]
    puts ""
    puts "=" * 60
    puts "✅ Docker course generated successfully!"
    puts "   Course: #{result[:course].title}"
    puts "   Slug: #{result[:course].slug}"
    puts "   Modules: #{result[:modules].length}"
    puts "   Total Items: #{result[:modules].sum { |m| m.module_items.count }}"
    puts ""
    result[:modules].each_with_index do |mod, idx|
      puts "   Module #{idx + 1}: #{mod.title} (#{mod.module_items.count} items)"
    end
    puts "=" * 60
  else
    puts ""
    puts "=" * 60
    puts "❌ Failed to generate Docker course"
    puts "   Error: #{result[:error]}"
    if result[:backtrace]
      puts "   Backtrace:"
      result[:backtrace].each { |line| puts "     #{line}" }
    end
    puts "=" * 60
  end
else
  puts "❌ Template not found: #{template_path}"
  puts "   Please ensure the template file exists."
end
