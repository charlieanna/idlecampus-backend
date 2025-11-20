puts "Kubernetes Content Inventory"
puts "=" * 80

# Check for Kubernetes learning units
k8s_units = InteractiveLearningUnit.where("slug LIKE ?", "%k8s%").or(
  InteractiveLearningUnit.where("slug LIKE ?", "%kubernetes%")
).or(
  InteractiveLearningUnit.where("title LIKE ?", "%Kubernetes%")
).or(
  InteractiveLearningUnit.where("title LIKE ?", "%K8s%")
).order(:sequence_order)

puts "\n📚 Interactive Learning Units (Kubernetes):"
puts "Found: #{k8s_units.count} units\n"

if k8s_units.any?
  k8s_units.each do |unit|
    status = unit.published ? "✅ Published" : "⚠️  Draft"
    puts "\n#{status} - #{unit.slug}"
    puts "   Title: #{unit.title}"
    puts "   Sequence: #{unit.sequence_order}"
    puts "   Category: #{unit.category}"
    puts "   Difficulty: #{unit.difficulty_level}"
    puts "   Command: #{unit.command_to_learn}"
    puts "   Created: #{unit.created_at.strftime('%Y-%m-%d')}"
  end
else
  puts "   No Kubernetes interactive units found."
end

# Check for Kubernetes labs
puts "\n\n🔬 Hands-On Labs (Kubernetes):"
k8s_labs = HandsOnLab.where("lab_type = ? OR title LIKE ?", "kubernetes", "%Kubernetes%")
puts "Found: #{k8s_labs.count} labs\n"

if k8s_labs.any?
  k8s_labs.each do |lab|
    status = lab.is_active ? "✅ Active" : "⚠️  Inactive"
    puts "\n#{status} - #{lab.title}"
    puts "   Type: #{lab.lab_type}"
    puts "   Difficulty: #{lab.difficulty}"
    puts "   Steps: #{lab.step_count}"
    puts "   Estimated time: #{lab.estimated_minutes} min"
    if lab.has_prerequisites?
      puts "   Prerequisites: #{lab.prerequisite_list.join(', ')}"
    end
  end
else
  puts "   No Kubernetes labs found."
end

# Check for Kubernetes courses
puts "\n\n📖 Courses (Kubernetes):"
k8s_courses = Course.where("slug LIKE ? OR title LIKE ?", "%k8s%", "%Kubernetes%")
puts "Found: #{k8s_courses.count} courses\n"

if k8s_courses.any?
  k8s_courses.each do |course|
    status = course.published ? "✅ Published" : "⚠️  Draft"
    puts "\n#{status} - #{course.slug}"
    puts "   Title: #{course.title}"
    puts "   Modules: #{course.course_modules.count}"
    puts "   Lessons: #{course.course_modules.sum { |m| m.module_items.count }}"
  end
else
  puts "   No Kubernetes courses found."
end

# Summary
puts "\n\n" + "=" * 80
puts "📊 SUMMARY"
puts "=" * 80
puts "Interactive Units: #{k8s_units.count}"
puts "Labs: #{k8s_labs.count}"
puts "Courses: #{k8s_courses.count}"
puts "Total Kubernetes Content: #{k8s_units.count + k8s_labs.count + k8s_courses.count} items"
