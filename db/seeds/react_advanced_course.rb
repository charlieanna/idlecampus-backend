# React Advanced Patterns Course
puts "Creating React Advanced Patterns Course..."

react_course = Course.find_or_create_by!(slug: 'react-advanced-patterns') do |course|
  course.title = 'React Advanced Patterns'
  course.description = 'Master advanced React patterns, hooks, performance optimization, and architecture'
  course.difficulty_level = 'advanced'
  course.published = true
  course.sequence_order = 35
  course.estimated_hours = 30
  course.learning_objectives = JSON.generate([
    "Master custom hooks",
    "Implement advanced patterns (HOC, Render Props, Compound Components)",
    "Optimize React performance",
    "Use Context API and state management",
    "Build scalable React applications",
    "Test React components effectively"
  ])
end

CourseModule.find_or_create_by!(slug: 'react-hooks-advanced', course: react_course) do |mod|
  mod.title = 'Advanced Hooks'
  mod.sequence_order = 1
  mod.estimated_minutes = 130
  mod.published = true
end

CourseModule.find_or_create_by!(slug: 'react-patterns', course: react_course) do |mod|
  mod.title = 'React Patterns'
  mod.sequence_order = 2
  mod.estimated_minutes = 140
  mod.published = true
end

CourseModule.find_or_create_by!(slug: 'react-performance', course: react_course) do |mod|
  mod.title = 'Performance Optimization'
  mod.sequence_order = 3
  mod.estimated_minutes = 130
  mod.published = true
end

puts "  ✅ Created React Advanced course\n"
puts "Created course: #{react_course.title}"
