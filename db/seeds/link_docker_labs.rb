# Link orphaned Docker labs to appropriate modules

puts "🔗 Linking orphaned Docker labs to modules..."

course = Course.find_by(slug: 'docker-fundamentals')

unless course
  puts "❌ Docker course not found!"
  exit
end

# Mapping: module slug => [lab IDs to add]
lab_mappings = {
  'container-basics' => [3, 5, 40, 43],  # Env vars, logs, CodeSprout basics, lifecycle
  'images-dockerfiles' => [6, 7, 41, 44],  # Build image, multi-stage, CodeSprout image, optimization
  'networking-and-ports' => [8, 45, 56],  # Docker networks, networking/communication, frontend-backend
  'volumes-and-storage' => [15, 46, 42, 57],  # Backup/restore, persistence, database, full stack
  'docker-compose' => [47, 54, 55],  # Multi-container, compose connect, deploy frontend
  'security-best-practices' => [10, 12, 49],  # Resource limits, health checks, security
  'registries-ci-cd' => [14, 52]  # Monitoring, full stack integration
}

total_linked = 0

lab_mappings.each do |module_slug, lab_ids|
  mod = course.course_modules.find_by(slug: module_slug)
  unless mod
    puts "⚠️  Module not found: #{module_slug}"
    next
  end

  puts "\n#{mod.title}:"

  lab_ids.each do |lab_id|
    lab = HandsOnLab.find_by(id: lab_id)
    unless lab
      puts "  ⚠️  Lab not found: ID #{lab_id}"
      next
    end

    # Check if already linked
    if mod.module_items.exists?(item_type: 'HandsOnLab', item_id: lab.id)
      puts "  ⏭️  Already linked: #{lab.title}"
    else
      # Find next sequence order
      last_seq = mod.module_items.maximum(:sequence_order) || 0

      mod.module_items.create!(
        item: lab,
        sequence_order: last_seq + 1,
        required: false
      )
      total_linked += 1
      puts "  ✅ Linked: #{lab.title}"
    end
  end
end

puts "\n" + "=" * 60
puts "✅ Linked #{total_linked} new labs!"
puts "\nFinal module summary:"
course.course_modules.ordered.each do |mod|
  lab_count = mod.module_items.where(item_type: 'HandsOnLab').count
  puts "  #{mod.title}: #{lab_count} labs"
end
