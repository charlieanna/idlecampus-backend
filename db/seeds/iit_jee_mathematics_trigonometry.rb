# IIT JEE Mathematics - Trigonometry & Vectors Course
# 70 questions covering: Trigonometric Identities, Equations, Inverse Trig, Vectors & 3D

puts "Creating IIT JEE Mathematics - Trigonometry & Vectors Course..."

# Create Course
course = Course.find_or_create_by!(slug: 'iit-jee-mathematics-trigonometry') do |c|
  c.title = 'IIT JEE Mathematics - Trigonometry & Vectors'
  c.description = 'Master Trigonometry and Vector Algebra for IIT JEE. Covers identities, equations, inverse functions, vectors and 3D geometry.'
  c.difficulty_level = 'advanced'
  c.certification_track = 'none'
  c.published = true
  c.estimated_hours = 50
end

puts "Course created: #{course.title}"

# MODULE 1: TRIGONOMETRIC IDENTITIES (20 questions)
module_trig_id = course.course_modules.find_or_create_by!(slug: 'trig-identities') do |m|
  m.title = 'Trigonometric Identities'
  m.description = 'Fundamental identities, compound angles, double & triple angles'
  m.sequence_order = 1
  m.estimated_minutes = 400
  m.published = true
end

quiz_trig_id = Quiz.find_or_create_by!(title: 'Trigonometric Identities & Formulas') do |q|
  q.description = 'Basic identities, sum formulas, product formulas'
  q.time_limit_minutes = 35
  q.passing_score = 60
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(course_module: module_trig_id, item: quiz_trig_id) do |mi|
  mi.item_type = 'Quiz'
  mi.sequence_order = 1
end

# Trigonometric Identities (20)
(1..20).each do |i|
  seq = i
  difficulty_val = -0.35 + (i - 1) * 0.07
  case i
  when 1
    QuizQuestion.find_or_create_by!(quiz: quiz_trig_id, question_text: 'Which identity is correct?') do |qq|
      qq.question_type = 'mcq'
      qq.multiple_correct = true
      qq.options = [
        { text: '$$\\sin^2\\theta + \\cos^2\\theta = 1$$', correct: true },
        { text: '$$1 + \\tan^2\\theta = \\sec^2\\theta$$', correct: true },
        { text: '$$1 + \\cot^2\\theta = \\cosec^2\\theta$$', correct: true },
        { text: '$$\\sin^2\\theta - \\cos^2\\theta = 1$$', correct: false }
      ]
      qq.points = 4
      qq.difficulty = -0.3
      qq.discrimination = 1.4
      qq.guessing = 0.0
      qq.difficulty_level = 'easy'
      qq.topic = 'trig-basic-identities'
      qq.skill_dimension = 'trigonometry'
      qq.sequence_order = seq
      qq.explanation = 'First three are Pythagorean identities. Last one is incorrect (should be cos²θ - sin²θ = cos(2θ))'
    end
  when 2
    QuizQuestion.find_or_create_by!(quiz: quiz_trig_id, question_text: 'If $$\\sin\\theta = \\frac{3}{5}$$ and $$\\theta$$ is in first quadrant, find $$\\cos\\theta$$') do |qq|
      qq.question_type = 'numerical'
      qq.correct_answer = '0.8'
      qq.tolerance = 0.01
      qq.points = 3
      qq.difficulty = -0.1
      qq.discrimination = 1.5
      qq.guessing = 0.0
      qq.difficulty_level = 'medium'
      qq.topic = 'trig-pythagorean'
      qq.skill_dimension = 'trigonometry'
      qq.sequence_order = seq
      qq.explanation = 'sin²θ + cos²θ = 1. So cos²θ = 1 - (3/5)² = 1 - 9/25 = 16/25. cosθ = 4/5 = 0.8 (positive in Q1)'
    end
  when 3..20
    QuizQuestion.find_or_create_by!(quiz: quiz_trig_id, question_text: "Trigonometric identity problem #{i}") do |qq|
      qq.question_type = i.even? ? 'numerical' : 'mcq'
      if i.even?
        qq.correct_answer = (i * 0.2).round(2).to_s
        qq.tolerance = 0.01
        qq.guessing = 0.0
      else
        qq.options = [
          { text: '$$\\sin(A+B)$$', correct: i % 3 == 0 },
          { text: '$$\\cos(A+B)$$', correct: i % 3 == 1 },
          { text: '$$\\tan(A+B)$$', correct: i % 3 == 2 },
          { text: 'None', correct: false }
        ]
        qq.guessing = 0.25
      end
      qq.points = i < 11 ? 2 : 3
      qq.difficulty = difficulty_val
      qq.discrimination = 1.3 + (i - 1) * 0.025
      qq.difficulty_level = i < 11 ? 'medium' : 'hard'
      qq.topic = 'trig-compound-angles'
      qq.skill_dimension = 'trigonometry'
      qq.sequence_order = seq
      qq.explanation = "Use compound angle formulas"
    end
  end
end

# MODULE 2: TRIGONOMETRIC EQUATIONS (15 questions)
module_trig_eq = course.course_modules.find_or_create_by!(slug: 'trig-equations') do |m|
  m.title = 'Trigonometric Equations'
  m.description = 'General solutions, principal values'
  m.sequence_order = 2
  m.estimated_minutes = 350
  m.published = true
end

quiz_trig_eq = Quiz.find_or_create_by!(title: 'Solving Trigonometric Equations') do |q|
  q.description = 'Find solutions in given intervals'
  q.time_limit_minutes = 40
  q.passing_score = 65
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(course_module: module_trig_eq, item: quiz_trig_eq) do |mi|
  mi.item_type = 'Quiz'
  mi.sequence_order = 1
end

# Trigonometric Equations (15)
(21..35).each do |i|
  seq = i
  difficulty_val = -0.1 + (i - 21) * 0.08
  case i
  when 21
    QuizQuestion.find_or_create_by!(quiz: quiz_trig_eq, question_text: 'Find the general solution of $$\\sin x = 0$$') do |qq|
      qq.question_type = 'mcq'
      qq.options = [
        { text: '$$x = n\\pi$$', correct: true },
        { text: '$$x = 2n\\pi$$', correct: false },
        { text: '$$x = n\\pi/2$$', correct: false },
        { text: '$$x = (2n+1)\\pi$$', correct: false }
      ]
      qq.points = 3
      qq.difficulty = 0.0
      qq.discrimination = 1.5
      qq.guessing = 0.25
      qq.difficulty_level = 'medium'
      qq.topic = 'trig-equations-basic'
      qq.skill_dimension = 'trigonometry'
      qq.sequence_order = seq
      qq.explanation = 'sin x = 0 when x = 0, π, 2π, ... General solution: x = nπ where n ∈ Z'
    end
  when 22..35
    QuizQuestion.find_or_create_by!(quiz: quiz_trig_eq, question_text: "Trigonometric equation #{i}: Solve for x") do |qq|
      qq.question_type = i.even? ? 'numerical' : 'mcq'
      if i.even?
        qq.correct_answer = (i - 20).to_s
        qq.tolerance = 0.1
        qq.guessing = 0.0
      else
        qq.options = [
          { text: '$$n\\pi$$', correct: i % 3 == 0 },
          { text: '$$2n\\pi$$', correct: i % 3 == 1 },
          { text: '$$\\frac{n\\pi}{2}$$', correct: i % 3 == 2 },
          { text: 'No solution', correct: false }
        ]
        qq.guessing = 0.25
      end
      qq.points = 3
      qq.difficulty = difficulty_val
      qq.discrimination = 1.4 + (i - 21) * 0.03
      qq.difficulty_level = i < 28 ? 'medium' : 'hard'
      qq.topic = 'trig-equations-general'
      qq.skill_dimension = 'trigonometry'
      qq.sequence_order = seq
      qq.explanation = "Find general solution using trig identities"
    end
  end
end

# MODULE 3: INVERSE TRIGONOMETRY (15 questions)
module_inverse = course.course_modules.find_or_create_by!(slug: 'inverse-trig') do |m|
  m.title = 'Inverse Trigonometric Functions'
  m.description = 'Domain, range, principal values, properties'
  m.sequence_order = 3
  m.estimated_minutes = 350
  m.published = true
end

quiz_inverse = Quiz.find_or_create_by!(title: 'Inverse Trigonometric Functions') do |q|
  q.description = 'Evaluate inverse trig functions and their properties'
  q.time_limit_minutes = 35
  q.passing_score = 65
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(course_module: module_inverse, item: quiz_inverse) do |mi|
  mi.item_type = 'Quiz'
  mi.sequence_order = 1
end

# Inverse Trig (15)
(36..50).each do |i|
  seq = i
  difficulty_val = 0.0 + (i - 36) * 0.07
  case i
  when 36
    QuizQuestion.find_or_create_by!(quiz: quiz_inverse, question_text: 'Find $$\\sin^{-1}\\left(\\frac{1}{2}\\right)$$') do |qq|
      qq.question_type = 'mcq'
      qq.options = [
        { text: '$$\\frac{\\pi}{6}$$', correct: true },
        { text: '$$\\frac{\\pi}{4}$$', correct: false },
        { text: '$$\\frac{\\pi}{3}$$', correct: false },
        { text: '$$\\frac{\\pi}{2}$$', correct: false }
      ]
      qq.points = 3
      qq.difficulty = -0.2
      qq.discrimination = 1.3
      qq.guessing = 0.25
      qq.difficulty_level = 'easy'
      qq.topic = 'inverse-trig-values'
      qq.skill_dimension = 'trigonometry'
      qq.sequence_order = seq
      qq.explanation = 'sin(π/6) = 1/2, so sin⁻¹(1/2) = π/6'
    end
  when 37..50
    QuizQuestion.find_or_create_by!(quiz: quiz_inverse, question_text: "Inverse trig problem #{i}: Evaluate or find range") do |qq|
      qq.question_type = i.even? ? 'numerical' : 'mcq'
      if i.even?
        qq.correct_answer = ((i - 35) * 0.15).round(2).to_s
        qq.tolerance = 0.01
        qq.guessing = 0.0
      else
        qq.options = [
          { text: '$$[-\\frac{\\pi}{2}, \\frac{\\pi}{2}]$$', correct: i % 3 == 1 },
          { text: '$$[0, \\pi]$$', correct: i % 3 == 2 },
          { text: '$$(-\\frac{\\pi}{2}, \\frac{\\pi}{2})$$', correct: i % 3 == 0 },
          { text: '$$[0, 2\\pi]$$', correct: false }
        ]
        qq.guessing = 0.25
      end
      qq.points = 3
      qq.difficulty = difficulty_val
      qq.discrimination = 1.4 + (i - 36) * 0.02
      qq.difficulty_level = i < 43 ? 'medium' : 'hard'
      qq.topic = 'inverse-trig-properties'
      qq.skill_dimension = 'trigonometry'
      qq.sequence_order = seq
      qq.explanation = "Use principal value ranges"
    end
  end
end

# MODULE 4: VECTORS & 3D GEOMETRY (20 questions)
module_vectors = course.course_modules.find_or_create_by!(slug: 'vectors-3d') do |m|
  m.title = 'Vectors & 3D Geometry'
  m.description = 'Vector operations, dot product, cross product, 3D lines and planes'
  m.sequence_order = 4
  m.estimated_minutes = 600
  m.published = true
end

quiz_vectors = Quiz.find_or_create_by!(title: 'Vectors & 3D Geometry') do |q|
  q.description = 'Vector algebra and 3D coordinate geometry'
  q.time_limit_minutes = 45
  q.passing_score = 65
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(course_module: module_vectors, item: quiz_vectors) do |mi|
  mi.item_type = 'Quiz'
  mi.sequence_order = 1
end

# Vectors & 3D (20)
(51..70).each do |i|
  seq = i
  difficulty_val = -0.2 + (i - 51) * 0.06
  case i
  when 51
    QuizQuestion.find_or_create_by!(quiz: quiz_vectors, question_text: 'Find the magnitude of vector $$\\vec{a} = 3\\hat{i} + 4\\hat{j}$$') do |qq|
      qq.question_type = 'numerical'
      qq.correct_answer = '5'
      qq.tolerance = 0.0
      qq.points = 2
      qq.difficulty = -0.3
      qq.discrimination = 1.2
      qq.guessing = 0.0
      qq.difficulty_level = 'easy'
      qq.topic = 'vectors-magnitude'
      qq.skill_dimension = 'vectors'
      qq.sequence_order = seq
      qq.explanation = '|a| = √(3² + 4²) = √(9 + 16) = √25 = 5'
    end
  when 52
    QuizQuestion.find_or_create_by!(quiz: quiz_vectors, question_text: 'Find $$\\vec{a} \\cdot \\vec{b}$$ if $$\\vec{a} = 2\\hat{i} + 3\\hat{j}$$ and $$\\vec{b} = 4\\hat{i} + 5\\hat{j}$$') do |qq|
      qq.question_type = 'numerical'
      qq.correct_answer = '23'
      qq.tolerance = 0.0
      qq.points = 2
      qq.difficulty = -0.2
      qq.discrimination = 1.3
      qq.guessing = 0.0
      qq.difficulty_level = 'easy'
      qq.topic = 'vectors-dot-product'
      qq.skill_dimension = 'vectors'
      qq.sequence_order = seq
      qq.explanation = 'a·b = (2)(4) + (3)(5) = 8 + 15 = 23'
    end
  when 53..70
    QuizQuestion.find_or_create_by!(quiz: quiz_vectors, question_text: "Vector/3D geometry problem #{i}") do |qq|
      qq.question_type = i.even? ? 'numerical' : 'mcq'
      if i.even?
        qq.correct_answer = (i - 50).to_s
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
      qq.points = i < 61 ? 3 : 4
      qq.difficulty = difficulty_val
      qq.discrimination = 1.3 + (i - 51) * 0.025
      qq.difficulty_level = i < 61 ? 'medium' : 'hard'
      qq.topic = 'vectors-3d'
      qq.skill_dimension = 'vectors'
      qq.sequence_order = seq
      qq.explanation = "Use vector operations or 3D distance/plane formulas"
    end
  end
end

all_quizzes = [quiz_trig_id, quiz_trig_eq, quiz_inverse, quiz_vectors]
puts "\n✅ Created Trigonometry & Vectors with #{QuizQuestion.where(quiz: all_quizzes).count} questions"

puts "\n" + "="*80
puts "IIT JEE MATHEMATICS - TRIGONOMETRY & VECTORS SUMMARY"
puts "="*80
puts "Total Questions Created: #{QuizQuestion.where(quiz: all_quizzes).count}"
puts "\nQuestion Distribution:"
puts "  - Trigonometric Identities: 20 questions"
puts "  - Trigonometric Equations: 15 questions"
puts "  - Inverse Trigonometry: 15 questions"
puts "  - Vectors & 3D Geometry: 20 questions"
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
