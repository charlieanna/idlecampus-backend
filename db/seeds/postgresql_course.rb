# PostgreSQL Database Mastery Course

puts "🐘 Creating PostgreSQL Database Mastery Course..."

# Create or find PostgreSQL course
postgresql_course = Course.find_or_initialize_by(slug: 'postgresql-mastery')
postgresql_course.update!(
  title: 'PostgreSQL Database Mastery',
  description: 'Master PostgreSQL from fundamentals to advanced query optimization and database design',
  difficulty_level: 'intermediate',
  estimated_hours: 40,
  certification_track: 'foundation',
  published: true,
  sequence_order: 10,
  learning_objectives: [
    'Master SQL query writing and optimization',
    'Understand database design and normalization',
    'Learn advanced PostgreSQL features',
    'Practice with hands-on SQL exercises'
  ],
  prerequisites: ['Basic understanding of databases', 'Familiarity with data structures']
)

puts "✅ PostgreSQL course created: #{postgresql_course.title}"

# Create course modules with SQL labs
module_data = [
  {
    title: 'SQL Fundamentals',
    slug: 'sql-fundamentals',
    description: 'Learn the basics of SQL queries, filtering, and data manipulation',
    sequence_order: 1,
    estimated_minutes: 120,
    learning_objectives: ['Master SELECT statements', 'Use WHERE clause effectively', 'Understand basic filtering'],
    lab_titles: ['SQL Basics - SELECT and Filtering']
  },
  {
    title: 'Aggregation and Grouping',
    slug: 'aggregation-grouping',
    description: 'Master aggregate functions and GROUP BY operations',
    sequence_order: 2,
    estimated_minutes: 150,
    learning_objectives: ['Use COUNT, SUM, AVG', 'Master GROUP BY', 'Apply HAVING clause'],
    lab_titles: ['SQL Aggregation - COUNT, SUM, AVG']
  },
  {
    title: 'Table Relationships and Joins',
    slug: 'joins',
    description: 'Learn to combine data from multiple tables using various join types',
    sequence_order: 3,
    estimated_minutes: 180,
    learning_objectives: ['Understand table relationships', 'Master INNER and LEFT joins', 'Work with multiple tables'],
    lab_titles: ['SQL Joins - Combining Tables']
  },
  {
    title: 'Advanced SQL Techniques',
    slug: 'advanced-sql',
    description: 'Master subqueries, nested queries, and complex data retrieval',
    sequence_order: 4,
    estimated_minutes: 200,
    learning_objectives: ['Use subqueries effectively', 'Master correlated subqueries', 'Apply EXISTS and IN'],
    lab_titles: ['Subqueries and Nested SELECT']
  },
  {
    title: 'Window Functions and Analytics',
    slug: 'window-functions',
    description: 'Learn advanced analytical queries with window functions',
    sequence_order: 5,
    estimated_minutes: 240,
    learning_objectives: ['Master window functions', 'Use PARTITION BY', 'Calculate running totals and rankings'],
    lab_titles: ['Window Functions - Advanced Analytics']
  }
]

module_data.each do |mod_data|
  lab_titles = mod_data.delete(:lab_titles)
  
  course_module = CourseModule.find_or_initialize_by(
    course: postgresql_course,
    slug: mod_data[:slug]
  )
  course_module.update!(mod_data.merge(published: true))
  
  puts "  ✅ Created module: #{course_module.title}"
  
  # Link labs to module
  lab_titles.each do |lab_title|
    lab = HandsOnLab.find_by(title: lab_title)
    if lab
      module_item = ModuleItem.find_or_create_by!(
        course_module: course_module,
        item_type: 'HandsOnLab',
        item_id: lab.id
      ) do |item|
        item.sequence_order = course_module.module_items.count + 1
        item.required = true
      end
      puts "    ✅ Linked lab: #{lab_title}"
    else
      puts "    ⚠️  Lab not found: #{lab_title}"
    end
  end
end

puts "\n✅ PostgreSQL Database Mastery Course Setup Complete!"
puts "   Course: #{postgresql_course.title}"
puts "   Modules: #{postgresql_course.course_modules.count}"
puts "   Total Labs: #{postgresql_course.course_modules.joins(:module_items).where(module_items: {item_type: 'HandsOnLab'}).count}"
puts "\n🐘 Ready for PostgreSQL Learning at /postgresql!"
