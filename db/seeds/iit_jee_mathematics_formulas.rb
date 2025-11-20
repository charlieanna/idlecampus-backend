# IIT JEE Mathematics - Formula Drills with FSRS Spaced Repetition
# 150 essential formulas across all topics

puts "Creating IIT JEE Mathematics - Formula Drills..."

# Create Course
course = Course.find_or_create_by!(slug: 'iit-jee-mathematics-formulas') do |c|
  c.title = 'IIT JEE Mathematics - Formula Mastery'
  c.description = 'Master 150 essential mathematics formulas with spaced repetition. Failed formulas automatically enter review schedule for optimal retention.'
  c.difficulty_level = 'advanced'
  c.certification_track = 'none'
  c.published = true
  c.estimated_hours = 20
end

puts "Course created: #{course.title}"

# Module for all formula quizzes
module_formulas = course.course_modules.find_or_create_by!(slug: 'formula-drills') do |m|
  m.title = 'Formula Drills'
  m.description = 'Daily practice of essential formulas with spaced repetition'
  m.sequence_order = 1
  m.estimated_minutes = 1200
  m.published = true
end

# QUIZ 1: DIFFERENTIATION FORMULAS (30)
quiz_diff_formulas = Quiz.find_or_create_by!(title: 'Differentiation Formulas Drill') do |q|
  q.description = 'Essential derivative formulas for IIT JEE'
  q.time_limit_minutes = 20
  q.passing_score = 70
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(course_module: module_formulas, item: quiz_diff_formulas) do |mi|
  mi.item_type = 'Quiz'
  mi.sequence_order = 1
end

diff_formulas = [
  { name: 'Power Rule', prompt: 'd/dx[xⁿ] = ?', answer: 'nxⁿ⁻¹|n·x^(n-1)|nx^(n-1)' },
  { name: 'Constant Rule', prompt: 'd/dx[c] = ? (where c is constant)', answer: '0' },
  { name: 'Sum Rule', prompt: 'd/dx[f(x) + g(x)] = ?', answer: 'f\'(x) + g\'(x)|f\' + g\'' },
  { name: 'Product Rule', prompt: 'd/dx[f(x)·g(x)] = ?', answer: 'f\'(x)·g(x) + f(x)·g\'(x)|f\'g + fg\'|u\'v + uv\'' },
  { name: 'Quotient Rule', prompt: 'd/dx[f(x)/g(x)] = ?', answer: '[f\'(x)·g(x) - f(x)·g\'(x)]/[g(x)]²|(f\'g - fg\')/g²' },
  { name: 'Chain Rule', prompt: 'd/dx[f(g(x))] = ?', answer: 'f\'(g(x))·g\'(x)' },
  { name: 'Sine', prompt: 'd/dx[sin(x)] = ?', answer: 'cos(x)|cos x' },
  { name: 'Cosine', prompt: 'd/dx[cos(x)] = ?', answer: '-sin(x)|-sin x' },
  { name: 'Tangent', prompt: 'd/dx[tan(x)] = ?', answer: 'sec²(x)|sec²x|sec^2(x)' },
  { name: 'Cotangent', prompt: 'd/dx[cot(x)] = ?', answer: '-cosec²(x)|-csc²x|-cosec^2(x)' },
  { name: 'Secant', prompt: 'd/dx[sec(x)] = ?', answer: 'sec(x)·tan(x)|sec x tan x' },
  { name: 'Cosecant', prompt: 'd/dx[cosec(x)] = ?', answer: '-cosec(x)·cot(x)|-csc x cot x' },
  { name: 'Natural Exponential', prompt: 'd/dx[eˣ] = ?', answer: 'eˣ|e^x|exp(x)' },
  { name: 'Exponential aˣ', prompt: 'd/dx[aˣ] = ?', answer: 'aˣ·ln(a)|a^x·ln(a)|a^x ln a' },
  { name: 'Natural Log', prompt: 'd/dx[ln(x)] = ?', answer: '1/x' },
  { name: 'Log base a', prompt: 'd/dx[logₐ(x)] = ?', answer: '1/(x·ln(a))|1/(x ln a)' },
  { name: 'Arcsine', prompt: 'd/dx[sin⁻¹(x)] = ?', answer: '1/√(1-x²)|1/sqrt(1-x^2)' },
  { name: 'Arccosine', prompt: 'd/dx[cos⁻¹(x)] = ?', answer: '-1/√(1-x²)|-1/sqrt(1-x^2)' },
  { name: 'Arctangent', prompt: 'd/dx[tan⁻¹(x)] = ?', answer: '1/(1+x²)|1/(1+x^2)' },
  { name: 'Arccotangent', prompt: 'd/dx[cot⁻¹(x)] = ?', answer: '-1/(1+x²)|-1/(1+x^2)' },
  { name: 'Arcsecant', prompt: 'd/dx[sec⁻¹(x)] = ?', answer: '1/(|x|√(x²-1))|1/(x sqrt(x^2-1))' },
  { name: 'Arccosecant', prompt: 'd/dx[cosec⁻¹(x)] = ?', answer: '-1/(|x|√(x²-1))|-1/(x sqrt(x^2-1))' },
  { name: 'Hyperbolic Sine', prompt: 'd/dx[sinh(x)] = ?', answer: 'cosh(x)|cosh x' },
  { name: 'Hyperbolic Cosine', prompt: 'd/dx[cosh(x)] = ?', answer: 'sinh(x)|sinh x' },
  { name: 'Hyperbolic Tangent', prompt: 'd/dx[tanh(x)] = ?', answer: 'sech²(x)|sech^2(x)' },
  { name: 'Absolute Value', prompt: 'd/dx[|x|] = ?', answer: 'x/|x||sgn(x)' },
  { name: 'Square Root', prompt: 'd/dx[√x] = ?', answer: '1/(2√x)|1/(2sqrt(x))' },
  { name: 'Cube Root', prompt: 'd/dx[∛x] = ?', answer: '1/(3∛(x²))|1/(3x^(2/3))' },
  { name: 'e^f(x)', prompt: 'd/dx[e^f(x)] = ?', answer: 'e^f(x)·f\'(x)|e^f(x) f\'(x)' },
  { name: 'ln f(x)', prompt: 'd/dx[ln f(x)] = ?', answer: 'f\'(x)/f(x)|f\'/f' }
]

diff_formulas.each_with_index do |formula, idx|
  QuizQuestion.find_or_create_by!(
    quiz: quiz_diff_formulas,
    question_text: "#{formula[:name]}: #{formula[:prompt]}"
  ) do |qq|
    qq.question_type = 'fill_blank'
    qq.correct_answer = formula[:answer]
    qq.points = 2
    qq.difficulty = -0.3 + (idx * 0.04)
    qq.discrimination = 1.4
    qq.guessing = 0.0
    qq.difficulty_level = idx < 15 ? 'medium' : 'hard'
    qq.topic = 'differentiation-formulas'
    qq.skill_dimension = 'calculus'
    qq.sequence_order = idx + 1
    qq.explanation = "Standard differentiation formula - memorize for quick recall"
  end
end

# QUIZ 2: INTEGRATION FORMULAS (30)
quiz_int_formulas = Quiz.find_or_create_by!(title: 'Integration Formulas Drill') do |q|
  q.description = 'Essential integral formulas for IIT JEE'
  q.time_limit_minutes = 20
  q.passing_score = 70
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(course_module: module_formulas, item: quiz_int_formulas) do |mi|
  mi.item_type = 'Quiz'
  mi.sequence_order = 2
end

int_formulas = [
  { name: 'Power Rule', prompt: '∫xⁿ dx = ? (n ≠ -1)', answer: 'xⁿ⁺¹/(n+1) + C|x^(n+1)/(n+1) + C' },
  { name: '1/x', prompt: '∫(1/x) dx = ?', answer: 'ln|x| + C|ln(|x|) + C' },
  { name: 'Exponential', prompt: '∫eˣ dx = ?', answer: 'eˣ + C|e^x + C' },
  { name: 'aˣ', prompt: '∫aˣ dx = ?', answer: 'aˣ/ln(a) + C|a^x/ln(a) + C' },
  { name: 'Sine', prompt: '∫sin(x) dx = ?', answer: '-cos(x) + C|-cos x + C' },
  { name: 'Cosine', prompt: '∫cos(x) dx = ?', answer: 'sin(x) + C|sin x + C' },
  { name: 'Secant²', prompt: '∫sec²(x) dx = ?', answer: 'tan(x) + C|tan x + C' },
  { name: 'Cosecant²', prompt: '∫cosec²(x) dx = ?', answer: '-cot(x) + C|-cot x + C' },
  { name: 'Secant·Tangent', prompt: '∫sec(x)·tan(x) dx = ?', answer: 'sec(x) + C|sec x + C' },
  { name: 'Cosecant·Cotangent', prompt: '∫cosec(x)·cot(x) dx = ?', answer: '-cosec(x) + C|-csc x + C' },
  { name: 'Tangent', prompt: '∫tan(x) dx = ?', answer: 'ln|sec(x)| + C|ln|sec x| + C|-ln|cos x| + C' },
  { name: 'Cotangent', prompt: '∫cot(x) dx = ?', answer: 'ln|sin(x)| + C|ln|sin x| + C' },
  { name: 'Secant', prompt: '∫sec(x) dx = ?', answer: 'ln|sec(x)+tan(x)| + C' },
  { name: 'Cosecant', prompt: '∫cosec(x) dx = ?', answer: 'ln|cosec(x)-cot(x)| + C|-ln|csc x+cot x| + C' },
  { name: '1/(1+x²)', prompt: '∫1/(1+x²) dx = ?', answer: 'tan⁻¹(x) + C|arctan(x) + C' },
  { name: '1/√(1-x²)', prompt: '∫1/√(1-x²) dx = ?', answer: 'sin⁻¹(x) + C|arcsin(x) + C' },
  { name: '-1/√(1-x²)', prompt: '∫-1/√(1-x²) dx = ?', answer: 'cos⁻¹(x) + C|arccos(x) + C' },
  { name: '1/(x√(x²-1))', prompt: '∫1/(x√(x²-1)) dx = ?', answer: 'sec⁻¹(x) + C|arcsec(x) + C' },
  { name: '1/(a²+x²)', prompt: '∫1/(a²+x²) dx = ?', answer: '(1/a)tan⁻¹(x/a) + C' },
  { name: '1/√(a²-x²)', prompt: '∫1/√(a²-x²) dx = ?', answer: 'sin⁻¹(x/a) + C' },
  { name: '1/√(x²-a²)', prompt: '∫1/√(x²-a²) dx = ?', answer: 'ln|x+√(x²-a²)| + C' },
  { name: '1/√(x²+a²)', prompt: '∫1/√(x²+a²) dx = ?', answer: 'ln|x+√(x²+a²)| + C' },
  { name: '√(a²-x²)', prompt: '∫√(a²-x²) dx = ?', answer: '(x/2)√(a²-x²) + (a²/2)sin⁻¹(x/a) + C' },
  { name: '√(x²+a²)', prompt: '∫√(x²+a²) dx = ?', answer: '(x/2)√(x²+a²) + (a²/2)ln|x+√(x²+a²)| + C' },
  { name: 'Integration by Parts', prompt: '∫u dv = ?', answer: 'uv - ∫v du' },
  { name: 'sin²(x)', prompt: '∫sin²(x) dx = ?', answer: 'x/2 - sin(2x)/4 + C' },
  { name: 'cos²(x)', prompt: '∫cos²(x) dx = ?', answer: 'x/2 + sin(2x)/4 + C' },
  { name: 'tan²(x)', prompt: '∫tan²(x) dx = ?', answer: 'tan(x) - x + C' },
  { name: 'cot²(x)', prompt: '∫cot²(x) dx = ?', answer: '-cot(x) - x + C' },
  { name: 'sin(mx)cos(nx)', prompt: '∫sin(mx)cos(nx) dx = ? (general form)', answer: 'Use product-to-sum formulas' }
]

int_formulas.each_with_index do |formula, idx|
  QuizQuestion.find_or_create_by!(
    quiz: quiz_int_formulas,
    question_text: "#{formula[:name]}: #{formula[:prompt]}"
  ) do |qq|
    qq.question_type = 'fill_blank'
    qq.correct_answer = formula[:answer]
    qq.points = 2
    qq.difficulty = -0.2 + (idx * 0.04)
    qq.discrimination = 1.5
    qq.guessing = 0.0
    qq.difficulty_level = idx < 15 ? 'medium' : 'hard'
    qq.topic = 'integration-formulas'
    qq.skill_dimension = 'calculus'
    qq.sequence_order = idx + 31
    qq.explanation = "Standard integration formula - essential for JEE"
  end
end

# QUIZ 3: TRIGONOMETRY FORMULAS (30)
quiz_trig_formulas = Quiz.find_or_create_by!(title: 'Trigonometry Formulas Drill') do |q|
  q.description = 'Essential trigonometric identities and formulas'
  q.time_limit_minutes = 20
  q.passing_score = 70
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(course_module: module_formulas, item: quiz_trig_formulas) do |mi|
  mi.item_type = 'Quiz'
  mi.sequence_order = 3
end

trig_formulas = [
  { name: 'Pythagorean 1', prompt: 'sin²θ + cos²θ = ?', answer: '1' },
  { name: 'Pythagorean 2', prompt: '1 + tan²θ = ?', answer: 'sec²θ|sec^2(θ)' },
  { name: 'Pythagorean 3', prompt: '1 + cot²θ = ?', answer: 'cosec²θ|csc²θ|cosec^2(θ)' },
  { name: 'sin(A+B)', prompt: 'sin(A+B) = ?', answer: 'sin A cos B + cos A sin B|sinAcosB + cosAsinB' },
  { name: 'sin(A-B)', prompt: 'sin(A-B) = ?', answer: 'sin A cos B - cos A sin B|sinAcosB - cosAsinB' },
  { name: 'cos(A+B)', prompt: 'cos(A+B) = ?', answer: 'cos A cos B - sin A sin B|cosAcosB - sinAsinB' },
  { name: 'cos(A-B)', prompt: 'cos(A-B) = ?', answer: 'cos A cos B + sin A sin B|cosAcosB + sinAsinB' },
  { name: 'tan(A+B)', prompt: 'tan(A+B) = ?', answer: '(tan A + tan B)/(1 - tan A tan B)|(tanA + tanB)/(1 - tanAtanB)' },
  { name: 'tan(A-B)', prompt: 'tan(A-B) = ?', answer: '(tan A - tan B)/(1 + tan A tan B)|(tanA - tanB)/(1 + tanAtanB)' },
  { name: 'sin(2A)', prompt: 'sin(2A) = ?', answer: '2 sin A cos A|2sinAcosA' },
  { name: 'cos(2A) form 1', prompt: 'cos(2A) = ? (in terms of cos)', answer: '2cos²A - 1|2cos^2(A) - 1' },
  { name: 'cos(2A) form 2', prompt: 'cos(2A) = ? (in terms of sin)', answer: '1 - 2sin²A|1 - 2sin^2(A)' },
  { name: 'cos(2A) form 3', prompt: 'cos(2A) = ? (mixed form)', answer: 'cos²A - sin²A|cos^2(A) - sin^2(A)' },
  { name: 'tan(2A)', prompt: 'tan(2A) = ?', answer: '2tanA/(1-tan²A)|2tan A/(1-tan^2 A)' },
  { name: 'sin(3A)', prompt: 'sin(3A) = ?', answer: '3sinA - 4sin³A|3sin A - 4sin^3 A' },
  { name: 'cos(3A)', prompt: 'cos(3A) = ?', answer: '4cos³A - 3cosA|4cos^3 A - 3cos A' },
  { name: 'sin²A', prompt: 'sin²A = ? (in terms of cos2A)', answer: '(1 - cos2A)/2|(1 - cos 2A)/2' },
  { name: 'cos²A', prompt: 'cos²A = ? (in terms of cos2A)', answer: '(1 + cos2A)/2|(1 + cos 2A)/2' },
  { name: 'sinC + sinD', prompt: 'sinC + sinD = ?', answer: '2sin((C+D)/2)cos((C-D)/2)' },
  { name: 'sinC - sinD', prompt: 'sinC - sinD = ?', answer: '2cos((C+D)/2)sin((C-D)/2)' },
  { name: 'cosC + cosD', prompt: 'cosC + cosD = ?', answer: '2cos((C+D)/2)cos((C-D)/2)' },
  { name: 'cosC - cosD', prompt: 'cosC - cosD = ?', answer: '-2sin((C+D)/2)sin((C-D)/2)|2sin((C+D)/2)sin((D-C)/2)' },
  { name: '2sinAcosB', prompt: '2sinA cosB = ?', answer: 'sin(A+B) + sin(A-B)' },
  { name: '2cosAsinB', prompt: '2cosA sinB = ?', answer: 'sin(A+B) - sin(A-B)' },
  { name: '2cosAcosB', prompt: '2cosA cosB = ?', answer: 'cos(A+B) + cos(A-B)' },
  { name: '2sinAsinB', prompt: '2sinA sinB = ?', answer: 'cos(A-B) - cos(A+B)' },
  { name: 'sin⁻¹x + cos⁻¹x', prompt: 'sin⁻¹x + cos⁻¹x = ?', answer: 'π/2|pi/2' },
  { name: 'tan⁻¹x + cot⁻¹x', prompt: 'tan⁻¹x + cot⁻¹x = ?', answer: 'π/2|pi/2' },
  { name: 'sec⁻¹x + cosec⁻¹x', prompt: 'sec⁻¹x + cosec⁻¹x = ?', answer: 'π/2|pi/2' },
  { name: 'tan⁻¹x + tan⁻¹y', prompt: 'tan⁻¹x + tan⁻¹y = ? (if xy < 1)', answer: 'tan⁻¹((x+y)/(1-xy))' }
]

trig_formulas.each_with_index do |formula, idx|
  QuizQuestion.find_or_create_by!(
    quiz: quiz_trig_formulas,
    question_text: "#{formula[:name]}: #{formula[:prompt]}"
  ) do |qq|
    qq.question_type = 'fill_blank'
    qq.correct_answer = formula[:answer]
    qq.points = 2
    qq.difficulty = -0.25 + (idx * 0.04)
    qq.discrimination = 1.4
    qq.guessing = 0.0
    qq.difficulty_level = idx < 15 ? 'medium' : 'hard'
    qq.topic = 'trigonometry-formulas'
    qq.skill_dimension = 'trigonometry'
    qq.sequence_order = idx + 61
    qq.explanation = "Key trigonometric identity - practice daily"
  end
end

# QUIZ 4: ALGEBRA FORMULAS (30)
quiz_algebra_formulas = Quiz.find_or_create_by!(title: 'Algebra Formulas Drill') do |q|
  q.description = 'Essential algebraic formulas and identities'
  q.time_limit_minutes = 15
  q.passing_score = 70
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(course_module: module_formulas, item: quiz_algebra_formulas) do |mi|
  mi.item_type = 'Quiz'
  mi.sequence_order = 4
end

algebra_formulas = [
  { name: '(a+b)²', prompt: '(a+b)² = ?', answer: 'a² + 2ab + b²|a^2 + 2ab + b^2' },
  { name: '(a-b)²', prompt: '(a-b)² = ?', answer: 'a² - 2ab + b²|a^2 - 2ab + b^2' },
  { name: 'a²-b²', prompt: 'a² - b² = ?', answer: '(a+b)(a-b)' },
  { name: '(a+b)³', prompt: '(a+b)³ = ?', answer: 'a³ + 3a²b + 3ab² + b³|a^3 + 3a^2b + 3ab^2 + b^3' },
  { name: '(a-b)³', prompt: '(a-b)³ = ?', answer: 'a³ - 3a²b + 3ab² - b³|a^3 - 3a^2b + 3ab^2 - b^3' },
  { name: 'a³+b³', prompt: 'a³ + b³ = ?', answer: '(a+b)(a² - ab + b²)|(a+b)(a^2 - ab + b^2)' },
  { name: 'a³-b³', prompt: 'a³ - b³ = ?', answer: '(a-b)(a² + ab + b²)|(a-b)(a^2 + ab + b^2)' },
  { name: 'a³+b³+c³-3abc', prompt: 'a³ + b³ + c³ - 3abc = ?', answer: '(a+b+c)(a²+b²+c²-ab-bc-ca)' },
  { name: 'Quadratic Formula', prompt: 'For ax² + bx + c = 0, x = ?', answer: '(-b ± √(b²-4ac))/(2a)' },
  { name: 'Sum of Roots', prompt: 'For ax² + bx + c = 0, sum of roots = ?', answer: '-b/a' },
  { name: 'Product of Roots', prompt: 'For ax² + bx + c = 0, product of roots = ?', answer: 'c/a' },
  { name: 'Discriminant', prompt: 'Discriminant of ax² + bx + c = 0 is?', answer: 'b² - 4ac|b^2 - 4ac' },
  { name: 'AP nth term', prompt: 'nth term of AP with first term a and common difference d?', answer: 'a + (n-1)d' },
  { name: 'AP sum', prompt: 'Sum of n terms of AP?', answer: 'n/2[2a + (n-1)d]|n(a+l)/2' },
  { name: 'GP nth term', prompt: 'nth term of GP with first term a and common ratio r?', answer: 'arⁿ⁻¹|a·r^(n-1)' },
  { name: 'GP sum (finite)', prompt: 'Sum of n terms of GP (r≠1)?', answer: 'a(rⁿ-1)/(r-1)|a(1-rⁿ)/(1-r)' },
  { name: 'GP sum (infinite)', prompt: 'Sum of infinite GP (|r|<1)?', answer: 'a/(1-r)' },
  { name: 'Binomial Theorem', prompt: '(a+b)ⁿ = ? (use ΣnCr notation)', answer: 'Σ ⁿCᵣ aⁿ⁻ʳ bʳ|sum from r=0 to n of C(n,r)a^(n-r)b^r' },
  { name: 'nCr formula', prompt: 'ⁿCᵣ = ?', answer: 'n!/(r!(n-r)!)|n!/[r!(n-r)!]' },
  { name: 'nPr formula', prompt: 'ⁿPᵣ = ?', answer: 'n!/(n-r)!|n!/(n-r)!' },
  { name: 'Sum of first n natural numbers', prompt: '1 + 2 + 3 + ... + n = ?', answer: 'n(n+1)/2' },
  { name: 'Sum of squares', prompt: '1² + 2² + 3² + ... + n² = ?', answer: 'n(n+1)(2n+1)/6' },
  { name: 'Sum of cubes', prompt: '1³ + 2³ + 3³ + ... + n³ = ?', answer: '[n(n+1)/2]²|n²(n+1)²/4' },
  { name: 'Arithmetic Mean', prompt: 'AM of a and b?', answer: '(a+b)/2' },
  { name: 'Geometric Mean', prompt: 'GM of a and b?', answer: '√(ab)|sqrt(ab)' },
  { name: 'Harmonic Mean', prompt: 'HM of a and b?', answer: '2ab/(a+b)' },
  { name: 'AM-GM Inequality', prompt: 'AM ≥ GM means?', answer: '(a+b)/2 ≥ √(ab)' },
  { name: 'Complex number i²', prompt: 'i² = ?', answer: '-1' },
  { name: 'Modulus of z', prompt: 'If z = a + ib, then |z| = ?', answer: '√(a²+b²)|sqrt(a^2+b^2)' },
  { name: 'Conjugate relation', prompt: 'If z = a + ib, then z·z̄ = ?', answer: '|z|²|a²+b²' }
]

algebra_formulas.each_with_index do |formula, idx|
  QuizQuestion.find_or_create_by!(
    quiz: quiz_algebra_formulas,
    question_text: "#{formula[:name]}: #{formula[:prompt]}"
  ) do |qq|
    qq.question_type = 'fill_blank'
    qq.correct_answer = formula[:answer]
    qq.points = 2
    qq.difficulty = -0.35 + (idx * 0.04)
    qq.discrimination = 1.3
    qq.guessing = 0.0
    qq.difficulty_level = idx < 15 ? 'medium' : 'hard'
    qq.topic = 'algebra-formulas'
    qq.skill_dimension = 'algebra'
    qq.sequence_order = idx + 91
    qq.explanation = "Fundamental algebra formula"
  end
end

# QUIZ 5: COORDINATE GEOMETRY FORMULAS (30)
quiz_coord_formulas = Quiz.find_or_create_by!(title: 'Coordinate Geometry Formulas Drill') do |q|
  q.description = 'Essential coordinate geometry formulas'
  q.time_limit_minutes = 15
  q.passing_score = 70
  q.quiz_type = 'standard'
end

ModuleItem.find_or_create_by!(course_module: module_formulas, item: quiz_coord_formulas) do |mi|
  mi.item_type = 'Quiz'
  mi.sequence_order = 5
end

coord_formulas = [
  { name: 'Distance Formula', prompt: 'Distance between (x₁,y₁) and (x₂,y₂)?', answer: '√[(x₂-x₁)²+(y₂-y₁)²]|sqrt[(x2-x1)^2+(y2-y1)^2]' },
  { name: 'Midpoint Formula', prompt: 'Midpoint of (x₁,y₁) and (x₂,y₂)?', answer: '((x₁+x₂)/2, (y₁+y₂)/2)' },
  { name: 'Section Formula (internal)', prompt: 'Point dividing (x₁,y₁) and (x₂,y₂) in ratio m:n?', answer: '((mx₂+nx₁)/(m+n), (my₂+ny₁)/(m+n))' },
  { name: 'Slope Formula', prompt: 'Slope of line through (x₁,y₁) and (x₂,y₂)?', answer: '(y₂-y₁)/(x₂-x₁)|m = (y2-y1)/(x2-x1)' },
  { name: 'Slope-Intercept Form', prompt: 'Equation of line with slope m and y-intercept c?', answer: 'y = mx + c' },
  { name: 'Point-Slope Form', prompt: 'Equation of line through (x₁,y₁) with slope m?', answer: 'y - y₁ = m(x - x₁)|y-y1 = m(x-x1)' },
  { name: 'Two-Point Form', prompt: 'Equation of line through (x₁,y₁) and (x₂,y₂)?', answer: '(y-y₁)/(x-x₁) = (y₂-y₁)/(x₂-x₁)' },
  { name: 'Intercept Form', prompt: 'Equation of line with intercepts a and b?', answer: 'x/a + y/b = 1' },
  { name: 'Perpendicular Slopes', prompt: 'If slopes are m₁ and m₂ and lines perpendicular?', answer: 'm₁·m₂ = -1|m1·m2 = -1' },
  { name: 'Parallel Slopes', prompt: 'If lines are parallel, slopes are?', answer: 'equal|m₁ = m₂|m1 = m2' },
  { name: 'Distance from Point to Line', prompt: 'Distance from (x₁,y₁) to ax+by+c=0?', answer: '|ax₁+by₁+c|/√(a²+b²)' },
  { name: 'Circle Standard Form', prompt: 'Equation of circle with center (h,k) and radius r?', answer: '(x-h)² + (y-k)² = r²|(x-h)^2 + (y-k)^2 = r^2' },
  { name: 'Circle General Form', prompt: 'General equation of circle?', answer: 'x² + y² + 2gx + 2fy + c = 0' },
  { name: 'Circle Center', prompt: 'Center of x²+y²+2gx+2fy+c=0?', answer: '(-g, -f)' },
  { name: 'Circle Radius', prompt: 'Radius of x²+y²+2gx+2fy+c=0?', answer: '√(g²+f²-c)|sqrt(g^2+f^2-c)' },
  { name: 'Parabola y²=4ax', prompt: 'For parabola y²=4ax, focus is?', answer: '(a, 0)' },
  { name: 'Parabola x²=4ay', prompt: 'For parabola x²=4ay, focus is?', answer: '(0, a)' },
  { name: 'Parabola Directrix', prompt: 'For parabola y²=4ax, directrix is?', answer: 'x = -a' },
  { name: 'Ellipse Standard', prompt: 'Standard equation of ellipse?', answer: 'x²/a² + y²/b² = 1' },
  { name: 'Ellipse Eccentricity', prompt: 'For ellipse x²/a²+y²/b²=1 (a>b), e = ?', answer: '√(1-b²/a²)|sqrt(1-b^2/a^2)' },
  { name: 'Ellipse Foci', prompt: 'For ellipse x²/a²+y²/b²=1, foci at?', answer: '(±ae, 0)|(±c, 0) where c²=a²-b²' },
  { name: 'Hyperbola Standard', prompt: 'Standard equation of hyperbola?', answer: 'x²/a² - y²/b² = 1' },
  { name: 'Hyperbola Eccentricity', prompt: 'For hyperbola x²/a²-y²/b²=1, e = ?', answer: '√(1+b²/a²)|sqrt(1+b^2/a^2)' },
  { name: 'Hyperbola Asymptotes', prompt: 'Asymptotes of x²/a²-y²/b²=1?', answer: 'y = ±(b/a)x' },
  { name: 'Area of Triangle (coordinates)', prompt: 'Area of triangle with vertices (x₁,y₁), (x₂,y₂), (x₃,y₃)?', answer: '½|x₁(y₂-y₃)+x₂(y₃-y₁)+x₃(y₁-y₂)|' },
  { name: 'Centroid Formula', prompt: 'Centroid of triangle with vertices (x₁,y₁), (x₂,y₂), (x₃,y₃)?', answer: '((x₁+x₂+x₃)/3, (y₁+y₂+y₃)/3)' },
  { name: '3D Distance', prompt: 'Distance between (x₁,y₁,z₁) and (x₂,y₂,z₂)?', answer: '√[(x₂-x₁)²+(y₂-y₁)²+(z₂-z₁)²]' },
  { name: 'Direction Cosines', prompt: 'If l, m, n are direction cosines?', answer: 'l² + m² + n² = 1' },
  { name: 'Angle between lines', prompt: 'cos θ between lines with direction ratios a₁,b₁,c₁ and a₂,b₂,c₂?', answer: '(a₁a₂+b₁b₂+c₁c₂)/√[(a₁²+b₁²+c₁²)(a₂²+b₂²+c₂²)]' },
  { name: 'Plane Equation', prompt: 'General equation of plane?', answer: 'ax + by + cz + d = 0' }
]

coord_formulas.each_with_index do |formula, idx|
  QuizQuestion.find_or_create_by!(
    quiz: quiz_coord_formulas,
    question_text: "#{formula[:name]}: #{formula[:prompt]}"
  ) do |qq|
    qq.question_type = 'fill_blank'
    qq.correct_answer = formula[:answer]
    qq.points = 2
    qq.difficulty = -0.3 + (idx * 0.04)
    qq.discrimination = 1.4
    qq.guessing = 0.0
    qq.difficulty_level = idx < 15 ? 'medium' : 'hard'
    qq.topic = 'coordinate-formulas'
    qq.skill_dimension = 'algebra'
    qq.sequence_order = idx + 121
    qq.explanation = "Essential coordinate geometry formula"
  end
end

all_quizzes = [quiz_diff_formulas, quiz_int_formulas, quiz_trig_formulas, quiz_algebra_formulas, quiz_coord_formulas]
total_formulas = QuizQuestion.where(quiz: all_quizzes).count

puts "\n✅ Created Formula Drills with #{total_formulas} formulas"

puts "\n" + "="*80
puts "IIT JEE MATHEMATICS - FORMULA MASTERY SUMMARY"
puts "="*80
puts "Total Formulas Created: #{total_formulas}"
puts "\nFormula Distribution:"
puts "  - Differentiation: 30 formulas"
puts "  - Integration: 30 formulas"
puts "  - Trigonometry: 30 formulas"
puts "  - Algebra: 30 formulas"
puts "  - Coordinate Geometry: 30 formulas"
puts "\nFSRS Integration:"
puts "  ✅ Failed formulas auto-added to spaced repetition queue"
puts "  ✅ Review intervals: 2 days → 1 week → 2 weeks → 1 month"
puts "  ✅ Daily review notifications on dashboard"
puts "\nCourse accessible at: /chemistry/#{course.slug}"
puts "API: GET /api/v1/chemistry/courses/#{course.slug}"
puts "="*80
