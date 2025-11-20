# GRE Skill Dimensions Setup
# This seed file configures the skill dimensions for GRE questions
# and links questions to their appropriate skill dimensions

puts "Setting up GRE skill dimensions..."

# Find GRE Verbal Reasoning course
course = Course.find_by(slug: 'gre-verbal-reasoning')

if course.nil?
  puts "⚠️  GRE Verbal Reasoning course not found. Please run gre_verbal_reasoning seeds first."
  return
end

# Update quiz questions with skill_dimension

# Reading Comprehension questions
reading_module = course.course_modules.find_by(slug: 'reading-comprehension')
if reading_module && reading_module.quiz
  reading_questions = reading_module.quiz.quiz_questions
  reading_questions.update_all(skill_dimension: 'gre_reading_comprehension')
  puts "✓ Updated #{reading_questions.count} Reading Comprehension questions with skill_dimension"
end

# Text Completion questions
text_comp_module = course.course_modules.find_by(slug: 'text-completion')
if text_comp_module && text_comp_module.quiz
  text_comp_questions = text_comp_module.quiz.quiz_questions
  text_comp_questions.update_all(skill_dimension: 'gre_text_completion')
  puts "✓ Updated #{text_comp_questions.count} Text Completion questions with skill_dimension"
end

# Sentence Equivalence questions
sent_equiv_module = course.course_modules.find_by(slug: 'sentence-equivalence')
if sent_equiv_module && sent_equiv_module.quiz
  sent_equiv_questions = sent_equiv_module.quiz.quiz_questions
  sent_equiv_questions.update_all(skill_dimension: 'gre_sentence_equivalence')
  puts "✓ Updated #{sent_equiv_questions.count} Sentence Equivalence questions with skill_dimension"
end

puts "GRE skill dimensions setup completed successfully!"
puts ""
puts "=" * 60
puts "GRE PRACTICE EXAM SYSTEM READY"
puts "=" * 60
puts ""
puts "Skill Dimensions Created:"
puts "  - gre_reading_comprehension"
puts "  - gre_text_completion"
puts "  - gre_sentence_equivalence"
puts ""
puts "To take a GRE practice exam:"
puts "  1. Navigate to /exam_simulations"
puts "  2. Select 'GRE Verbal Reasoning Practice Test'"
puts "  3. Complete the 40-question timed exam (70 minutes)"
puts "  4. Get scaled score (130-170) and detailed performance breakdown"
puts ""
puts "Features Available:"
puts "  ✓ Full-length timed practice exams"
puts "  ✓ Scaled scoring (130-170 scale)"
puts "  ✓ Performance breakdown by question type"
puts "  ✓ Weakness detection and recommendations"
puts "  ✓ IRT-based ability tracking"
puts "  ✓ Personalized study plans"
puts "=" * 60
