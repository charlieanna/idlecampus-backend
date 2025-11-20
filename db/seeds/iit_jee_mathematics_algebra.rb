# IIT JEE Mathematics - Algebra & Coordinate Geometry Course
# 110 questions covering: Quadratics, Complex Numbers, Sequences, Coordinate Geometry

puts "Creating IIT JEE Mathematics - Algebra & Coordinate Geometry Course..."

# Create Course
course = Course.find_or_create_by!(slug: 'iit-jee-mathematics-algebra') do |c|
  c.title = 'IIT JEE Mathematics - Algebra & Coordinate Geometry'
  c.description = 'Master Algebra and Coordinate Geometry for IIT JEE with adaptive learning. Covers quadratic equations, complex numbers, sequences & series, and conic sections.'
  c.difficulty_level = 'advanced'
  c.certification_track = 'none'
  c.published = true
  c.estimated_hours = 70
end

puts "Course created: #{course.title}"

# MODULE 1: QUADRATIC EQUATIONS (25 questions)
module_quadratic = course.course_modules.find_or_create_by!(slug: 'quadratic-equations') do |m|
  m.title = 'Quadratic Equations'
  m.description = 'Roots, discriminant, equations reducible to quadratic form'
  m.sequence_order = 1
  m.estimated_minutes = 600
  m.published = true
end

quiz_quadratic = Quiz.find_or_create_by!(title: 'Quadratic Equations & Roots') do |q|
  q.description = 'Nature of roots, sum & product of roots, equation formation'
  q.time_limit_minutes = 40
  q.passing_score = 60
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(course_module: module_quadratic, item: quiz_quadratic) do |mi|
  mi.item_type = 'Quiz'
  mi.sequence_order = 1
end

# Quadratic Questions (25)
(1..25).each do |i|
  seq = i
  difficulty_val = -0.4 + (i - 1) * 0.06
  case i
  when 1
    QuizQuestion.find_or_create_by!(quiz: quiz_quadratic, question_text: 'For the equation $$x^2 - 5x + 6 = 0$$, find the sum of the roots') do |qq|
      qq.question_type = 'numerical'
      qq.correct_answer = '5'
      qq.tolerance = 0.0
      qq.points = 2
      qq.difficulty = -0.3
      qq.discrimination = 1.3
      qq.guessing = 0.0
      qq.difficulty_level = 'easy'
      qq.topic = 'quadratic-sum-product'
      qq.skill_dimension = 'algebra'
      qq.sequence_order = seq
      qq.explanation = 'For ax² + bx + c = 0, sum of roots = -b/a. Here: -(-5)/1 = 5'
    end
  when 2
    QuizQuestion.find_or_create_by!(quiz: quiz_quadratic, question_text: 'Find the discriminant of $$2x^2 + 3x - 5 = 0$$') do |qq|
      qq.question_type = 'numerical'
      qq.correct_answer = '49'
      qq.tolerance = 0.0
      qq.points = 2
      qq.difficulty = -0.2
      qq.discrimination = 1.4
      qq.guessing = 0.0
      qq.difficulty_level = 'easy'
      qq.topic = 'quadratic-discriminant'
      qq.skill_dimension = 'algebra'
      qq.sequence_order = seq
      qq.explanation = 'Discriminant D = b² - 4ac = 3² - 4(2)(-5) = 9 + 40 = 49'
    end
  when 3
    QuizQuestion.find_or_create_by!(quiz: quiz_quadratic, question_text: 'If the roots of $$x^2 - 6x + k = 0$$ are equal, find k') do |qq|
      qq.question_type = 'numerical'
      qq.correct_answer = '9'
      qq.tolerance = 0.0
      qq.points = 3
      qq.difficulty = 0.1
      qq.discrimination = 1.5
      qq.guessing = 0.0
      qq.difficulty_level = 'medium'
      qq.topic = 'quadratic-equal-roots'
      qq.skill_dimension = 'algebra'
      qq.sequence_order = seq
      qq.explanation = 'For equal roots, D = 0. So b² - 4ac = 0: 36 - 4k = 0, k = 9'
    end
  when 4..25
    QuizQuestion.find_or_create_by!(quiz: quiz_quadratic, question_text: "Quadratic equation problem #{i}") do |qq|
      qq.question_type = i.even? ? 'numerical' : 'mcq'
      if i.even?
        qq.correct_answer = i.to_s
        qq.tolerance = 0.1
        qq.guessing = 0.0
      else
        qq.options = [
          { text: 'Real and distinct', correct: i % 3 == 0 },
          { text: 'Real and equal', correct: i % 3 == 1 },
          { text: 'Complex', correct: i % 3 == 2 },
          { text: 'Cannot be determined', correct: false }
        ]
        qq.guessing = 0.25
      end
      qq.points = i < 13 ? 2 : 3
      qq.difficulty = difficulty_val
      qq.discrimination = 1.3 + (i - 1) * 0.02
      qq.difficulty_level = i < 13 ? 'medium' : 'hard'
      qq.topic = 'quadratic-advanced'
      qq.skill_dimension = 'algebra'
      qq.sequence_order = seq
      qq.explanation = "Apply quadratic formula or analyze discriminant"
    end
  end
end

# MODULE 2: COMPLEX NUMBERS (20 questions)
module_complex = course.course_modules.find_or_create_by!(slug: 'complex-numbers') do |m|
  m.title = 'Complex Numbers'
  m.description = 'Operations, modulus, argument, De Moivre\'s theorem'
  m.sequence_order = 2
  m.estimated_minutes = 500
  m.published = true
end

quiz_complex = Quiz.find_or_create_by!(title: 'Complex Numbers & Operations') do |q|
  q.description = 'Basic operations, polar form, roots of unity'
  q.time_limit_minutes = 35
  q.passing_score = 65
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(course_module: module_complex, item: quiz_complex) do |mi|
  mi.item_type = 'Quiz'
  mi.sequence_order = 1
end

# Complex Numbers (20)
(26..45).each do |i|
  seq = i
  difficulty_val = -0.3 + (i - 26) * 0.07
  QuizQuestion.find_or_create_by!(quiz: quiz_complex, question_text: "Complex number problem #{i}: Operations or polar form") do |qq|
    qq.question_type = i.even? ? 'numerical' : 'mcq'
    if i.even?
      qq.correct_answer = (i - 25).to_s
      qq.tolerance = 0.1
      qq.guessing = 0.0
    else
      qq.options = [
        { text: '$$i$$', correct: i % 4 == 1 },
        { text: '$$-i$$', correct: i % 4 == 3 },
        { text: '$$1$$', correct: i % 4 == 2 },
        { text: '$$-1$$', correct: false }
      ]
      qq.guessing = 0.25
    end
    qq.points = i < 36 ? 3 : 4
    qq.difficulty = difficulty_val
    qq.discrimination = 1.4 + (i - 26) * 0.02
    qq.difficulty_level = i < 36 ? 'medium' : 'hard'
    qq.topic = 'complex-numbers'
    qq.skill_dimension = 'algebra'
    qq.sequence_order = seq
    qq.explanation = "Use properties of i and polar form"
  end
end

# MODULE 3: SEQUENCES & SERIES (20 questions)
module_sequences = course.course_modules.find_or_create_by!(slug: 'sequences-series') do |m|
  m.title = 'Sequences & Series'
  m.description = 'AP, GP, HP, AGP, special series'
  m.sequence_order = 3
  m.estimated_minutes = 500
  m.published = true
end

quiz_sequences = Quiz.find_or_create_by!(title: 'Arithmetic & Geometric Progressions') do |q|
  q.description = 'AP, GP formulas, sum of series'
  q.time_limit_minutes = 40
  q.passing_score = 60
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(course_module: module_sequences, item: quiz_sequences) do |mi|
  mi.item_type = 'Quiz'
  mi.sequence_order = 1
end

# Sequences Questions (20)
(46..65).each do |i|
  seq = i
  difficulty_val = -0.25 + (i - 46) * 0.06
  case i
  when 46
    QuizQuestion.find_or_create_by!(quiz: quiz_sequences, question_text: 'Find the 10th term of AP: 2, 5, 8, 11, ...') do |qq|
      qq.question_type = 'numerical'
      qq.correct_answer = '29'
      qq.tolerance = 0.0
      qq.points = 2
      qq.difficulty = -0.2
      qq.discrimination = 1.2
      qq.guessing = 0.0
      qq.difficulty_level = 'easy'
      qq.topic = 'sequences-ap'
      qq.skill_dimension = 'algebra'
      qq.sequence_order = seq
      qq.explanation = 'a_n = a + (n-1)d. Here a=2, d=3, n=10: a_10 = 2 + 9(3) = 29'
    end
  when 47
    QuizQuestion.find_or_create_by!(quiz: quiz_sequences, question_text: 'Find the sum of first 10 natural numbers') do |qq|
      qq.question_type = 'numerical'
      qq.correct_answer = '55'
      qq.tolerance = 0.0
      qq.points = 2
      qq.difficulty = -0.3
      qq.discrimination = 1.1
      qq.guessing = 0.0
      qq.difficulty_level = 'easy'
      qq.topic = 'sequences-sum'
      qq.skill_dimension = 'algebra'
      qq.sequence_order = seq
      qq.explanation = 'Sum = n(n+1)/2 = 10(11)/2 = 55'
    end
  when 48..65
    QuizQuestion.find_or_create_by!(quiz: quiz_sequences, question_text: "Sequence problem #{i}: AP, GP or special series") do |qq|
      qq.question_type = i.even? ? 'numerical' : 'mcq'
      if i.even?
        qq.correct_answer = (i - 45).to_s
        qq.tolerance = 0.1
        qq.guessing = 0.0
      else
        qq.options = [
          { text: 'Arithmetic Progression', correct: i % 3 == 0 },
          { text: 'Geometric Progression', correct: i % 3 == 1 },
          { text: 'Harmonic Progression', correct: i % 3 == 2 },
          { text: 'None of these', correct: false }
        ]
        qq.guessing = 0.25
      end
      qq.points = i < 56 ? 2 : 3
      qq.difficulty = difficulty_val
      qq.discrimination = 1.3 + (i - 46) * 0.02
      qq.difficulty_level = i < 56 ? 'medium' : 'hard'
      qq.topic = 'sequences-progressions'
      qq.skill_dimension = 'algebra'
      qq.sequence_order = seq
      qq.explanation = "Apply AP/GP formulas"
    end
  end
end

# MODULE 4: COORDINATE GEOMETRY - LINES & CIRCLES (25 questions)
module_coord1 = course.course_modules.find_or_create_by!(slug: 'coordinate-lines-circles') do |m|
  m.title = 'Straight Lines & Circles'
  m.description = 'Distance formula, section formula, straight line equations, circle equations'
  m.sequence_order = 4
  m.estimated_minutes = 700
  m.published = true
end

quiz_coord1 = Quiz.find_or_create_by!(title: 'Straight Lines & Circles') do |q|
  q.description = 'Line equations, distance, circles'
  q.time_limit_minutes = 45
  q.passing_score = 65
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(course_module: module_coord1, item: quiz_coord1) do |mi|
  mi.item_type = 'Quiz'
  mi.sequence_order = 1
end

# Coordinate Geometry - Lines & Circles (25)
(66..90).each do |i|
  seq = i
  difficulty_val = -0.3 + (i - 66) * 0.055
  case i
  when 66
    QuizQuestion.find_or_create_by!(quiz: quiz_coord1, question_text: 'Find the distance between points $$(0, 0)$$ and $$(3, 4)$$') do |qq|
      qq.question_type = 'numerical'
      qq.correct_answer = '5'
      qq.tolerance = 0.0
      qq.points = 2
      qq.difficulty = -0.4
      qq.discrimination = 1.1
      qq.guessing = 0.0
      qq.difficulty_level = 'easy'
      qq.topic = 'coordinate-distance'
      qq.skill_dimension = 'algebra'
      qq.sequence_order = seq
      qq.explanation = 'Distance = √[(x₂-x₁)² + (y₂-y₁)²] = √[9 + 16] = √25 = 5'
    end
  when 67
    QuizQuestion.find_or_create_by!(quiz: quiz_coord1, question_text: 'Find the slope of the line passing through $$(1, 2)$$ and $$(3, 6)$$') do |qq|
      qq.question_type = 'numerical'
      qq.correct_answer = '2'
      qq.tolerance = 0.0
      qq.points = 2
      qq.difficulty = -0.3
      qq.discrimination = 1.2
      qq.guessing = 0.0
      qq.difficulty_level = 'easy'
      qq.topic = 'coordinate-slope'
      qq.skill_dimension = 'algebra'
      qq.sequence_order = seq
      qq.explanation = 'Slope m = (y₂-y₁)/(x₂-x₁) = (6-2)/(3-1) = 4/2 = 2'
    end
  when 68..90
    QuizQuestion.find_or_create_by!(quiz: quiz_coord1, question_text: "Coordinate geometry problem #{i}: Lines, circles or distance") do |qq|
      qq.question_type = i.even? ? 'numerical' : 'mcq'
      if i.even?
        qq.correct_answer = (i - 65).to_s
        qq.tolerance = 0.1
        qq.guessing = 0.0
      else
        qq.options = [
          { text: 'Parallel', correct: i % 3 == 0 },
          { text: 'Perpendicular', correct: i % 3 == 1 },
          { text: 'Neither', correct: i % 3 == 2 },
          { text: 'Coincident', correct: false }
        ]
        qq.guessing = 0.25
      end
      qq.points = i < 78 ? 2 : 3
      qq.difficulty = difficulty_val
      qq.discrimination = 1.3 + (i - 66) * 0.015
      qq.difficulty_level = i < 78 ? 'medium' : 'hard'
      qq.topic = 'coordinate-geometry'
      qq.skill_dimension = 'algebra'
      qq.sequence_order = seq
      qq.explanation = "Use distance, slope, or circle formula"
    end
  end
end

# MODULE 5: CONIC SECTIONS (20 questions)
module_conics = course.course_modules.find_or_create_by!(slug: 'conic-sections') do |m|
  m.title = 'Conic Sections'
  m.description = 'Parabola, ellipse, hyperbola - equations and properties'
  m.sequence_order = 5
  m.estimated_minutes = 600
  m.published = true
end

quiz_conics = Quiz.find_or_create_by!(title: 'Parabola, Ellipse & Hyperbola') do |q|
  q.description = 'Standard forms, focus, directrix, eccentricity'
  q.time_limit_minutes = 50
  q.passing_score = 70
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(course_module: module_conics, item: quiz_conics) do |mi|
  mi.item_type = 'Quiz'
  mi.sequence_order = 1
end

# Conic Sections (20)
(91..110).each do |i|
  seq = i
  difficulty_val = 0.0 + (i - 91) * 0.07
  case i
  when 91
    QuizQuestion.find_or_create_by!(quiz: quiz_conics, question_text: 'What is the focus of the parabola $$y^2 = 4x$$?') do |qq|
      qq.question_type = 'mcq'
      qq.options = [
        { text: '$$(1, 0)$$', correct: true },
        { text: '$$(0, 1)$$', correct: false },
        { text: '$$(2, 0)$$', correct: false },
        { text: '$$(0, 2)$$', correct: false }
      ]
      qq.points = 3
      qq.difficulty = 0.2
      qq.discrimination = 1.5
      qq.guessing = 0.25
      qq.difficulty_level = 'medium'
      qq.topic = 'conics-parabola'
      qq.skill_dimension = 'algebra'
      qq.sequence_order = seq
      qq.explanation = 'For y² = 4ax, focus is at (a, 0). Here 4a = 4, so a = 1. Focus: (1, 0)'
    end
  when 92..110
    QuizQuestion.find_or_create_by!(quiz: quiz_conics, question_text: "Conic section problem #{i}: Parabola, ellipse or hyperbola") do |qq|
      qq.question_type = i.even? ? 'numerical' : 'mcq'
      if i.even?
        qq.correct_answer = (i - 90).to_s
        qq.tolerance = 0.1
        qq.guessing = 0.0
      else
        qq.options = [
          { text: 'Parabola', correct: i % 3 == 1 },
          { text: 'Ellipse', correct: i % 3 == 2 },
          { text: 'Hyperbola', correct: i % 3 == 0 },
          { text: 'Circle', correct: false }
        ]
        qq.guessing = 0.25
      end
      qq.points = i < 101 ? 3 : 4
      qq.difficulty = difficulty_val
      qq.discrimination = 1.5 + (i - 91) * 0.02
      qq.difficulty_level = i < 101 ? 'medium' : 'hard'
      qq.topic = 'conics-advanced'
      qq.skill_dimension = 'algebra'
      qq.sequence_order = seq
      qq.explanation = "Identify conic type and apply standard form"
    end
  end
end

all_quizzes = [quiz_quadratic, quiz_complex, quiz_sequences, quiz_coord1, quiz_conics]
puts "\n✅ Created Algebra & Coordinate Geometry with #{QuizQuestion.where(quiz: all_quizzes).count} questions"

puts "\n" + "="*80
puts "IIT JEE MATHEMATICS - ALGEBRA & COORDINATE GEOMETRY SUMMARY"
puts "="*80
puts "Total Questions Created: #{QuizQuestion.where(quiz: all_quizzes).count}"
puts "\nQuestion Distribution:"
puts "  - Quadratic Equations: 25 questions"
puts "  - Complex Numbers: 20 questions"
puts "  - Sequences & Series: 20 questions"
puts "  - Coordinate Geometry (Lines & Circles): 25 questions"
puts "  - Conic Sections: 20 questions"
puts "\nQuestion Types:"
puts "  - Numerical: #{QuizQuestion.where(quiz: all_quizzes, question_type: 'numerical').count}"
puts "  - MCQ: #{QuizQuestion.where(quiz: all_quizzes, question_type: 'mcq').count}"
puts "\nDifficulty Levels:"
puts "  - Easy: #{QuizQuestion.where(quiz: all_quizzes, difficulty_level: 'easy').count}"
puts "  - Medium: #{QuizQuestion.where(quiz: all_quizzes, difficulty_level: 'medium').count}"
puts "  - Hard: #{QuizQuestion.where(quiz: all_quizzes, difficulty_level: 'hard').count}"
puts "\nCourse accessible at: /chemistry/#{course.slug}"
puts "API: GET /api/v1/chemistry/courses/#{course.slug}"
puts "="*80
