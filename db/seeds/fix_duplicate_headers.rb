# Fix duplicate headers in InteractiveLearningUnit concept_explanation
# Remove the first markdown header since the UI already displays the title

puts "🔧 Fixing duplicate headers in InteractiveLearningUnit records..."

fixed_count = 0
units = InteractiveLearningUnit.all

units.each do |unit|
  next unless unit.concept_explanation.present?

  # Check if content starts with markdown header
  if unit.concept_explanation =~ /^#\s+.+?\n\n/
    # Remove the first header line and blank line after it
    new_content = unit.concept_explanation.sub(/^#\s+.+?\n\n/, '')

    unit.update!(concept_explanation: new_content)
    fixed_count += 1
    puts "  ✅ Fixed: #{unit.title}"
  end
end

puts "\n✅ Fixed #{fixed_count} units with duplicate headers"
puts "📊 Total units: #{InteractiveLearningUnit.count}"
