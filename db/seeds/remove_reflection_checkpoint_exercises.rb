# Remove all reflection and checkpoint exercises from all courses
# This script removes 1,002 exercises (501 reflection + 501 checkpoint)

puts "=" * 80
puts "REMOVING REFLECTION AND CHECKPOINT EXERCISES"
puts "=" * 80

# Count before deletion
reflection_count = Exercise.where(exercise_type: 'reflection').count
checkpoint_count = Exercise.where(exercise_type: 'checkpoint').count
total_before = Exercise.count

puts "\nBefore deletion:"
puts "  Reflection exercises: #{reflection_count}"
puts "  Checkpoint exercises: #{checkpoint_count}"
puts "  Total exercises: #{total_before}"
puts "  Other exercises: #{total_before - reflection_count - checkpoint_count}"

# Delete reflection exercises
puts "\nDeleting reflection exercises..."
deleted_reflection = Exercise.where(exercise_type: 'reflection').delete_all
puts "  Deleted #{deleted_reflection} reflection exercises"

# Delete checkpoint exercises
puts "\nDeleting checkpoint exercises..."
deleted_checkpoint = Exercise.where(exercise_type: 'checkpoint').delete_all
puts "  Deleted #{deleted_checkpoint} checkpoint exercises"

# Count after deletion
total_after = Exercise.count

puts "\nAfter deletion:"
puts "  Total exercises remaining: #{total_after}"
puts "  Total deleted: #{deleted_reflection + deleted_checkpoint}"
puts "\nBreakdown of remaining exercises by type:"
Exercise.group(:exercise_type).count.sort.each do |type, count|
  puts "  #{type}: #{count}"
end

puts "\n" + "=" * 80
puts "DELETION COMPLETE"
puts "=" * 80
