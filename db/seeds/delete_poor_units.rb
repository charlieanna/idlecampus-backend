# Delete poorly structured InteractiveLearningUnit records created from DockerCommand table
# Keep the original 10 good progressive units (IDs 146-158)

puts "🗑️  Deleting poorly structured learning units..."

# The original 10 good progressive units have IDs 146-158
# These have rich content with quizzes and proper structure
original_good_units = [146, 147, 148, 149, 150, 151, 153, 154, 157, 158]

puts "\n✅ Keeping #{original_good_units.count} original progressive units:"
InteractiveLearningUnit.where(id: original_good_units).each do |unit|
  puts "  - #{unit.command_to_learn}"
end

# Find all units that are NOT in the good list
poor_units = InteractiveLearningUnit.where.not(id: original_good_units)

puts "\n🗑️  Found #{poor_units.count} poorly structured units to delete"

# Delete module_items links first
poor_units.each do |unit|
  module_items = ModuleItem.where(item_type: 'InteractiveLearningUnit', item_id: unit.id)
  module_items.destroy_all
end

# Delete the units themselves
deleted_count = poor_units.destroy_all.count

puts "\n✅ Deleted #{deleted_count} poorly structured units and their module links"

puts "\n📊 Remaining InteractiveLearningUnits:"
puts "  Total: #{InteractiveLearningUnit.count}"
puts "  With quizzes: #{InteractiveLearningUnit.where.not(quiz_question_text: nil).count}"
puts "  With scenario steps: #{InteractiveLearningUnit.where("scenario_steps != '[]'").count}"
