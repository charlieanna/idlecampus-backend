# Quick Reference: Adding New Chemistry Modules

## File Structure at a Glance

```
idlecampus-backend/
├── app/
│   ├── models/
│   │   ├── course.rb                    # Course container
│   │   ├── course_module.rb             # Module container
│   │   ├── course_lesson.rb             # Lesson content
│   │   ├── quiz.rb                      # Quiz container
│   │   ├── quiz_question.rb             # Question logic
│   │   ├── module_item.rb               # Polymorphic linker
│   │   └── quiz_attempt.rb              # Student responses
│   ├── controllers/
│   │   └── api/v1/
│   │       ├── generic_courses_controller.rb      # Base class
│   │       └── chemistry/
│   │           └── chemistry_courses_controller.rb # Chemistry API
│   └── services/
│       └── chemical_equation_validator.rb         # Chemistry validation
├── db/
│   ├── migrate/
│   │   └── 20251030020100_create_course_system.rb  # Core schema
│   └── seeds/
│       └── inorganic/
│           ├── module_04_s_block.rb                # Example module
│           ├── module_05_p_block_part1.rb          # Example module
│           └── [YOUR NEW MODULE FILE].rb           # Your new module
└── CODEBASE_STRUCTURE.md                # This comprehensive guide
```

---

## Quick Workflow: Creating a New Chemistry Module

### 1. Create Seed File
```bash
# Create file: db/seeds/inorganic/module_10_new_topic.rb
# Copy from: db/seeds/inorganic/module_04_s_block.rb
# Replace: titles, slugs, content, questions
```

### 2. Key Things to Set:
```ruby
# Module basics:
- title: 'Your Module Title'
- slug: 'your-module-slug'        # lowercase with hyphens
- sequence_order: 10               # Use unique number
- estimated_minutes: 480           # Time estimate

# Lesson basics:
- title: 'Lesson Title'
- reading_time_minutes: 30         # Usually 25-40 min
- key_concepts: ['concept1', 'concept2', ...]

# Quiz basics:
- title: 'Quiz Title'
- time_limit_minutes: 30
- passing_score: 70
- quiz_type: 'standard'

# Question basics (for each question):
- question_type: 'mcq'|'numerical'|'fill_blank'|'equation_balance'|'sequence'|'true_false'
- question_text: 'Your question text'
- correct_answer: 'Answer text' OR options array
- points: 2 or 3 (based on difficulty)
- difficulty_level: 'easy'|'medium'|'hard'
- difficulty: 0.0     # For IRT adaptive learning
- discrimination: 1.0 # 0.1 to 3.0
- guessing: 0.2       # 0.0 to 0.5
```

### 3. Run Seed
```bash
rails db:seed
```

### 4. Verify in Console
```bash
rails console
course = Course.find_by(slug: 'iit-jee-inorganic-chemistry')
course.course_modules.count  # Should increase
course.course_modules.ordered.last.module_items.count  # Items in your module
```

---

## Question Type Quick Examples

### MCQ - Single Correct
```ruby
{
  quiz: quiz,
  question_type: 'mcq',
  question_text: 'Which is the strongest oxidizing agent?',
  options: [
    {text: 'Cl₂', correct: false},
    {text: 'F₂', correct: true},
    {text: 'I₂', correct: false}
  ],
  multiple_correct: false,
  points: 2
}
```

### MCQ - Multiple Correct (IIT JEE style)
```ruby
{
  quiz: quiz,
  question_type: 'mcq',
  question_text: 'Which are bidentate ligands?',
  options: [
    {text: 'NH₃', correct: false},
    {text: 'EDTA', correct: true},
    {text: 'C₂O₄²⁻', correct: true},
    {text: 'H₂O', correct: false}
  ],
  multiple_correct: true,  # Set to true
  points: 3
}
```

### Numerical (with tolerance)
```ruby
{
  quiz: quiz,
  question_type: 'numerical',
  question_text: 'Calculate molar mass of Ca(OH)₂',
  correct_answer: '74.08',
  tolerance: 0.1,  # ±0.1 accepted
  points: 2
}
```

### Equation Balance (Chemistry-specific)
```ruby
{
  quiz: quiz,
  question_type: 'equation_balance',
  question_text: 'Balance: _KMnO₄ + _H₂SO₄ + _FeSO₄ → _Fe₂(SO₄)₃ + _MnSO₄ + _K₂SO₄ + _H₂O',
  correct_answer: '2KMnO₄ + 3H₂SO₄ + 10FeSO₄ → 5Fe₂(SO₄)₃ + 2MnSO₄ + K₂SO₄ + 4H₂O',
  points: 3
}
```

### Sequence (Order items)
```ruby
{
  quiz: quiz,
  question_type: 'sequence',
  question_text: 'Order by increasing atomic radius',
  sequence_items: [
    {id: 1, text: 'Li'},
    {id: 2, text: 'Na'},
    {id: 3, text: 'K'},
    {id: 4, text: 'Rb'}
  ],
  correct_answer: '1,2,3,4',  # IDs in order
  points: 2
}
```

### Fill Blank (Multiple acceptable answers)
```ruby
{
  quiz: quiz,
  question_type: 'fill_blank',
  question_text: 'The IUPAC name suffix for carboxylic acids is ___.',
  correct_answer: '-oic acid|oic acid',  # Pipe-separated alternatives
  points: 1
}
```

### True/False
```ruby
{
  quiz: quiz,
  question_type: 'true_false',
  question_text: 'Lattice energy increases down a group.',
  correct_answer: 'false',
  points: 1
}
```

---

## Database Hierarchy

```
Course
  └─→ CourseModule (sequence_order)
        └─→ ModuleItem (polymorphic, sequence_order)
              ├─→ CourseLesson
              │     └─→ LessonCompletion (tracks: user completed this lesson)
              ├─→ Quiz
              │     ├─→ QuizQuestion (7 types)
              │     └─→ QuizAttempt (tracks: user's attempt, score, answers)
              └─→ HandsOnLab
                    └─→ LabSession (tracks: user's lab attempt)
```

---

## API Usage (Automatic)

Once you create and seed the module, it's automatically available:

```bash
# List all chemistry courses
GET /api/v1/chemistry/courses

# Get specific course with all modules
GET /api/v1/chemistry/courses/iit-jee-inorganic-chemistry

# Get module details
GET /api/v1/chemistry/courses/iit-jee-inorganic-chemistry/modules/your-module-slug

# Get quiz questions
GET /api/v1/chemistry/quizzes/123/questions

# Submit answer to a question
POST /api/v1/chemistry/quizzes/123/questions/456/submit
Body: {answer: "user's answer"}
```

---

## Common Patterns

### Get existing course in Rails console:
```ruby
course = Course.find_by(slug: 'iit-jee-inorganic-chemistry')
```

### Access all modules ordered:
```ruby
course.course_modules.ordered  # Returns sorted modules
```

### Access all items in a module:
```ruby
module_obj.module_items.ordered  # Returns sorted items
module_obj.lessons               # Only lessons
module_obj.quizzes               # Only quizzes
module_obj.hands_on_labs         # Only labs
```

### Access quiz questions:
```ruby
quiz = Quiz.find(1)
quiz.quiz_questions.ordered      # Questions in order
```

### Check difficulty validations:
```ruby
QuizQuestion::DIFFICULTY_LEVELS   # easy, medium, hard
QuizQuestion::QUESTION_TYPES      # mcq, fill_blank, ...
```

---

## File Locations Reference

| Component | Location | File Type |
|-----------|----------|-----------|
| Models | `/app/models/` | `.rb` |
| Controllers | `/app/controllers/api/v1/` | `.rb` |
| Services | `/app/services/` | `.rb` |
| Migrations | `/db/migrate/` | `.rb` |
| Seeds | `/db/seeds/inorganic/` | `.rb` |
| Tests | `/spec/` | `_spec.rb` |
| Documentation | Root directory | `.md` |

---

## Testing Your Module

```bash
# Load data
rails db:seed

# Enter console
rails console

# Verify course
Course.find_by(slug: 'iit-jee-inorganic-chemistry').course_modules.count

# Verify module
module_10 = Course.find_by(slug: 'iit-jee-inorganic-chemistry')
          .course_modules.find_by(slug: 'your-module-slug')

# Verify items
module_10.module_items.ordered.map { |i| [i.item_type, i.item.title] }

# Verify questions
quiz = module_10.quizzes.first
quiz.quiz_questions.map { |q| [q.question_type, q.question_text] }

# Test API endpoint
curl http://localhost:3000/api/v1/chemistry/courses/iit-jee-inorganic-chemistry
```

---

## Important Notes

1. **Slugs must be lowercase with hyphens**: `periodic-table-periodicity`
2. **Course slugs are globally unique**, module slugs are unique per course
3. **sequence_order matters**: Used for ordering in UI and APIs
4. **Always set published: true** for production content
5. **Difficulty/discrimination/guessing are required** (they enable adaptive learning)
6. **Content is Markdown**: Supports headers, formatting, code blocks
7. **JSON fields** (options, sequence_items) are validated automatically

---

## Troubleshooting

### Module not showing up:
- Check `published: true`
- Verify `sequence_order` is set correctly
- Run `rails db:seed` again

### Questions not validating:
- Check `question_type` is in valid list
- For numerical: ensure `tolerance` is present
- For sequence: ensure all items have `id` and `text`
- For MCQ: ensure at least one option has `correct: true`

### API not working:
- Check course slug matches pattern 'chemistry'
- Verify course is published
- Verify modules are published
- Clear Rails cache: `rails cache:clear`

---

## Example Complete Module Structure

```ruby
# File: db/seeds/inorganic/module_10_example.rb

puts "\n" + "=" * 80
puts "MODULE 10: EXAMPLE TOPIC"
puts "=" * 80

course = Course.find_by(slug: 'iit-jee-inorganic-chemistry') || exit(1)

module_10 = course.course_modules.find_or_create_by!(slug: 'example-topic') do |m|
  m.title = 'Example Topic'
  m.sequence_order = 10
  m.estimated_minutes = 480
  m.description = 'Description here'
  m.learning_objectives = [
    'Objective 1',
    'Objective 2'
  ]
  m.published = true
end

puts "✅ Module 10: #{module_10.title}"

# Lesson
lesson = CourseLesson.create!(
  title: 'Example Lesson',
  reading_time_minutes: 30,
  key_concepts: ['concept1', 'concept2'],
  content: <<~MD
    # Markdown Content Here
  MD
)

ModuleItem.create!(course_module: module_10, item: lesson, sequence_order: 1, required: true)

# Quiz
quiz = Quiz.create!(
  title: 'Example Quiz',
  time_limit_minutes: 30,
  passing_score: 70,
  quiz_type: 'standard'
)

ModuleItem.create!(course_module: module_10, item: quiz, sequence_order: 2, required: true)

# Questions
QuizQuestion.create!([
  {
    quiz: quiz,
    question_type: 'mcq',
    question_text: 'Question text?',
    options: [
      {text: 'Option A', correct: true},
      {text: 'Option B', correct: false}
    ],
    correct_answer: 'Option A',
    explanation: 'Because...',
    points: 2,
    difficulty_level: 'easy',
    sequence_order: 1,
    difficulty: 0.0,
    discrimination: 1.0,
    guessing: 0.2
  }
])

puts "✅ Completed: #{module_10.module_items.count} items"
```

