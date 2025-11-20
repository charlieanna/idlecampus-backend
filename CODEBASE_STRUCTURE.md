# Educational Modules Codebase Structure - Comprehensive Summary

## 1. DATABASE SCHEMA STRUCTURE

### Core Course Hierarchy Tables

#### **Courses Table** (`/db/migrate/20251030020100_create_course_system.rb`)
```sql
- id (bigint, primary key)
- title (string)                 -- Course name
- slug (string, unique)          -- URL-friendly identifier
- description (text)             -- Course overview
- difficulty_level (string)      -- beginner, intermediate, advanced
- estimated_hours (integer)      -- Course duration
- certification_track (string)   -- dca, cka, docker, kubernetes, none, etc.
- icon_url (string)              -- Course icon
- banner_url (string)            -- Course banner image
- published (boolean, default: false)
- sequence_order (integer)       -- Display order
- learning_objectives (text)     -- JSON array of objectives
- prerequisites (text)           -- JSON array of prerequisites
```

#### **CourseModules Table**
```sql
- id (bigint)
- course_id (bigint, foreign key)  -- Links to courses
- title (string)                   -- Module title
- slug (string, unique per course) -- URL-friendly identifier
- description (text)               -- Module description
- sequence_order (integer)         -- Order within course
- estimated_minutes (integer)      -- Time to complete
- learning_objectives (text)       -- JSON array
- published (boolean)
```

#### **CourseLesson Table** (New lesson model, separate from old Lessons table)
```sql
- id (bigint)
- title (string)
- content (text)                   -- Markdown content
- video_url (string)
- reading_time_minutes (integer)
- key_concepts (text)              -- JSON array
- content_sections (jsonb)         -- Structured sections with headers/text
- key_commands (json)              -- Commands for Linux/Docker courses
```

#### **Quiz Table**
```sql
- id (bigint)
- title (string)
- description (text)
- time_limit_minutes (integer)
- passing_score (integer, default: 70)
- max_attempts (integer)
- shuffle_questions (boolean, default: true)
- show_correct_answers (boolean, default: true)
- quiz_type (string)               -- standard, review_session, topic_deepdive, mastery_challenge
- metadata (text)                  -- JSON for adaptive retry config
```

#### **QuizQuestions Table** (Most Complex - Chemistry Support)
```sql
- id (bigint)
- quiz_id (bigint, foreign key)
- question_type (string)           -- mcq, fill_blank, true_false, numerical, equation_balance, sequence, command
- question_text (text)
- options (text)                   -- JSON array for MCQs: [{text: "...", correct: true/false}, ...]
- correct_answer (text)            -- For fill_blank, numerical, sequence, command
- explanation (text)               -- Answer explanation
- points (integer, default: 1)
- difficulty_level (string)        -- easy, medium, hard
- tags (text)                      -- JSON array of topic tags
- sequence_order (integer)
- image_url (string)               -- For diagrams (chemical structures, etc.)

-- Adaptive learning metadata:
- difficulty (decimal)             -- -3.0 to 3.0 (Item Response Theory)
- discrimination (decimal)         -- 0.1 to 3.0 (discriminative power)
- guessing (decimal)               -- 0.0 to 0.5 (guessing parameter)

-- Chemistry-specific fields:
- tolerance (decimal, 10,6)        -- ±tolerance for numerical answers
- multiple_correct (boolean)       -- IIT JEE multi-correct MCQs
- sequence_items (json)            -- [{id: 1, text: "Step 1"}, ...] for sequence questions
```

#### **ModuleItems Table** (Polymorphic Join Table)
```sql
- id (bigint)
- course_module_id (bigint, foreign key)
- item_type (string)               -- CourseLesson, Quiz, HandsOnLab, InteractiveLearningUnit
- item_id (bigint)                 -- ID of the polymorphic item
- sequence_order (integer)         -- Order within module
- required (boolean, default: true)

-- This allows one module to contain:
-- - Multiple lessons
-- - Multiple quizzes
-- - Multiple hands-on labs
-- - Multiple interactive units
```

#### **LessonCompletions Table** (Progress Tracking)
```sql
- id (bigint)
- user_id (bigint, foreign key)
- course_lesson_id (bigint, foreign key)
- completed_at (datetime)
- Unique constraint: (user_id, course_lesson_id)
```

#### **QuizAttempts Table** (Assessment Tracking)
```sql
- id (bigint)
- user_id (bigint, foreign key)
- quiz_id (bigint, foreign key)
- course_enrollment_id (bigint, foreign key)
- started_at (datetime)
- completed_at (datetime)
- score (integer)                  -- Percentage (0-100)
- total_questions (integer)
- correct_answers (integer)
- answers (text)                   -- JSON: {question_id: user_answer}
- time_taken_seconds (integer)
- passed (boolean)
- attempt_number (integer)
```

#### **CourseEnrollments Table** (Student Progress)
```sql
- id (bigint)
- user_id (bigint, foreign key)
- course_id (bigint, foreign key)
- enrolled_at (datetime)
- started_at (datetime)
- completed_at (datetime)
- completion_percentage (integer, default: 0)
- total_points (integer, default: 0)
- status (string)                  -- enrolled, in_progress, completed, dropped
- current_item_type (string)       -- Polymorphic link
- current_item_id (bigint)         -- Polymorphic link
```

#### **ModuleProgress Table** (Module-level Tracking)
```sql
- id (bigint)
- user_id (bigint, foreign key)
- course_module_id (bigint, foreign key)
- course_enrollment_id (bigint, foreign key)
- started_at (datetime)
- completed_at (datetime)
- completion_percentage (integer, default: 0)
- items_completed (integer, default: 0)
- total_items (integer, default: 0)
- status (string)                  -- not_started, in_progress, completed
```

---

## 2. MODEL RELATIONSHIPS (Active Record Associations)

### Course Model
```ruby
class Course < ApplicationRecord
  has_many :course_modules, dependent: :destroy
  has_many :course_enrollments, dependent: :destroy
  has_many :enrolled_users, through: :course_enrollments, source: :user
end
```

### CourseModule Model
```ruby
class CourseModule < ApplicationRecord
  belongs_to :course
  has_many :module_items, dependent: :destroy
  has_many :lessons, through: :module_items, source: :item, source_type: 'CourseLesson'
  has_many :quizzes, through: :module_items, source: :item, source_type: 'Quiz'
  has_many :hands_on_labs, through: :module_items, source: :item, source_type: 'HandsOnLab'
  has_many :module_progresses, dependent: :destroy
  has_many :module_interactive_units, dependent: :destroy
  has_many :interactive_learning_units, through: :module_interactive_units
end
```

### ModuleItem Model (Polymorphic)
```ruby
class ModuleItem < ApplicationRecord
  belongs_to :course_module
  belongs_to :item, polymorphic: true  # Can be CourseLesson, Quiz, or HandsOnLab
  
  delegate :title, to: :item, allow_nil: true
end
```

### CourseLesson Model
```ruby
class CourseLesson < ApplicationRecord
  has_many :lesson_completions, dependent: :destroy
  has_many :module_items, as: :item, dependent: :destroy
  has_many :course_modules, through: :module_items
  has_many :quiz_question_lesson_mappings, dependent: :destroy
  has_many :quiz_questions, through: :quiz_question_lesson_mappings
end
```

### Quiz Model
```ruby
class Quiz < ApplicationRecord
  has_many :quiz_questions, dependent: :destroy
  has_many :module_items, as: :item, dependent: :destroy
  has_many :course_modules, through: :module_items
  has_many :quiz_attempts, dependent: :destroy
end
```

### QuizQuestion Model (Most Complex)
```ruby
class QuizQuestion < ApplicationRecord
  belongs_to :quiz
  has_many :quiz_question_lesson_mappings, dependent: :destroy
  has_many :course_lessons, through: :quiz_question_lesson_mappings
  has_many :remediation_activities, dependent: :destroy
  
  # Question type validation
  validates :question_type, inclusion: { 
    in: %w[mcq fill_blank command true_false numerical equation_balance sequence]
  }
  
  # Chemistry-specific validations
  validates :tolerance, numericality: { >= 0 }, if: -> { question_type == 'numerical' }
  validate :validate_sequence_items_format, if: -> { question_type == 'sequence' }
  validate :validate_mcq_multiple_correct, if: -> { question_type == 'mcq' && multiple_correct? }
end
```

---

## 3. SUPPORTED QUESTION TYPES

### 1. **MCQ** (Multiple Choice)
```json
{
  "question_type": "mcq",
  "question_text": "Which element has highest ionization energy?",
  "options": [
    {"text": "Lithium", "correct": false},
    {"text": "Fluorine", "correct": true},
    {"text": "Sodium", "correct": false}
  ],
  "multiple_correct": false,  // Set true for IIT JEE style multi-correct
  "points": 2
}
```

### 2. **Fill Blank** (Text Answer)
```json
{
  "question_type": "fill_blank",
  "question_text": "The charge on an electron is ___.",
  "correct_answer": "-1.6e-19 C|1.6e-19 C",  // Pipe-separated acceptable answers
  "points": 1
}
```

### 3. **Numerical** (Math Answer with Tolerance)
```json
{
  "question_type": "numerical",
  "question_text": "Calculate the pH of 0.01 M HCl",
  "correct_answer": "2.0",
  "tolerance": 0.1,  // ±0.1 accepted
  "points": 3
}
```

### 4. **Equation Balance** (Chemistry-specific)
```json
{
  "question_type": "equation_balance",
  "question_text": "Balance: _Fe + _O₂ → _Fe₂O₃",
  "correct_answer": "4Fe + 3O₂ → 2Fe₂O₃",
  "points": 2
}
```

### 5. **Sequence** (Order Items)
```json
{
  "question_type": "sequence",
  "question_text": "Order the oxidizing agent strength",
  "sequence_items": [
    {"id": 1, "text": "F₂"},
    {"id": 2, "text": "Cl₂"},
    {"id": 3, "text": "Br₂"},
    {"id": 4, "text": "I₂"}
  ],
  "correct_answer": "1,2,3,4",  // IDs in correct order
  "points": 2
}
```

### 6. **True/False**
```json
{
  "question_type": "true_false",
  "question_text": "Lattice energy increases down a group",
  "correct_answer": "false",
  "points": 1
}
```

### 7. **Command** (For Docker/Linux courses)
```json
{
  "question_type": "command",
  "question_text": "List all containers including stopped ones",
  "correct_answer": "docker ps -a|docker container ls -a",
  "points": 1
}
```

---

## 4. API ROUTES & ENDPOINTS

### Base URL: `/api/v1`

#### Subject-Specific Namespaces
```
/api/v1/chemistry/          -- Chemistry courses
/api/v1/mathematics/        -- Mathematics courses
/api/v1/linux/              -- Linux courses
/api/v1/kubernetes/         -- Kubernetes courses
/api/v1/docker/             -- Docker courses
/api/v1/security/           -- Security courses
/api/v1/golang/             -- Golang courses
/api/v1/system_design/      -- System design courses
/api/v1/postgresql/         -- PostgreSQL courses
/api/v1/coding/             -- Coding interview courses
```

#### Chemistry API Routes (Example)
```
GET  /api/v1/chemistry/courses                                 -- List all chemistry courses
GET  /api/v1/chemistry/courses/:slug                           -- Show specific course
GET  /api/v1/chemistry/courses/:slug/modules                   -- List course modules
GET  /api/v1/chemistry/courses/:course_slug/modules/:module_slug
GET  /api/v1/chemistry/labs                                    -- List hands-on labs
GET  /api/v1/chemistry/labs/:id                                -- Show lab details
GET  /api/v1/chemistry/quizzes/:quiz_id                        -- Show quiz
GET  /api/v1/chemistry/quizzes/:quiz_id/questions              -- Get all questions
POST /api/v1/chemistry/quizzes/:quiz_id/questions/:question_id/submit
GET  /api/v1/chemistry/lessons/:lesson_id                      -- Show lesson
```

#### Generic Courses Controller (Base Class)
```ruby
module Api::V1
  class GenericCoursesController < ApplicationController
    # Helper methods for all subject courses:
    # - course_summary(course)
    # - course_detail(course)
    # - module_summary(mod)
    # - module_detail(mod)
    # - item_summary(item)
    # - item_content(item)
    # - lab_summary(lab)
    # - lab_detail(lab)
    # - get_courses_by_pattern(pattern)
    # - get_labs_by_type(lab_type)
  end
end
```

---

## 5. EXISTING CHEMISTRY IMPLEMENTATIONS

### Current Status: PRODUCTION READY (Phase 1)
Located in: `/db/seeds/iit_jee/` and `/db/seeds/inorganic/`

#### Implemented Modules:
1. **Periodic Table & Periodicity** - Complete with lessons & quizzes
2. **Chemical Bonding** - Complete
3. **Coordination Chemistry** - Most comprehensive (10 questions)
4. **s-Block Elements** - Complete
5. **p-Block Elements** - Parts 1 & 2
6. **d-Block Elements** - Complete
7. **Metallurgy & f-Block** - Complete
8. **Qualitative Analysis** - Complete

#### Question Coverage:
- 200+ questions across all modules
- Mix of question types: MCQ, numerical, sequence, fill-blank, true/false
- IIT JEE advanced level
- Difficulty levels: easy, medium, hard
- Adaptive metadata included for all questions

### API Endpoints:
```
POST /api/v1/chemistry/quizzes/:quiz_id/questions/:question_id/submit
GET  /api/v1/chemistry/courses
GET  /api/v1/chemistry/labs
```

---

## 6. CREATION & MODIFICATION WORKFLOW

### To Add NEW Chemistry Modules:

#### Step 1: Create Seeds File
**Location**: `/db/seeds/inorganic/module_XX_topic.rb`

**Template**:
```ruby
# frozen_string_literal: true

puts "\n" + "=" * 80
puts "MODULE X: TOPIC TITLE"
puts "=" * 80

# Find the course
course = Course.find_by(slug: 'iit-jee-inorganic-chemistry')
unless course
  puts "❌ ERROR: IIT JEE Inorganic Chemistry course not found!"
  exit 1
end

# Create Module
module_x = course.course_modules.find_or_create_by!(slug: 'topic-slug') do |m|
  m.title = 'Full Module Title'
  m.sequence_order = X
  m.estimated_minutes = 480  # Time in minutes
  m.description = '...'
  m.learning_objectives = [...]
  m.published = true
end

puts "✅ Module #{module_x.sequence_order}: #{module_x.title}"

# Create Lessons (CourseLesson model)
lesson = CourseLesson.create!(
  title: 'Lesson Title',
  reading_time_minutes: 30,
  key_concepts: ['concept1', 'concept2'],
  content: <<~MD
    # Markdown Content
    ...
  MD
)

ModuleItem.create!(
  course_module: module_x,
  item: lesson,
  sequence_order: 1,
  required: true
)

# Create Quiz
quiz = Quiz.create!(
  title: 'Quiz Title',
  description: 'Quiz description',
  time_limit_minutes: 30,
  passing_score: 70,
  quiz_type: 'standard',
  shuffle_questions: true
)

ModuleItem.create!(
  course_module: module_x,
  item: quiz,
  sequence_order: 2,
  required: true
)

# Create Questions
QuizQuestion.create!([
  {
    quiz: quiz,
    question_type: 'mcq',
    question_text: '...',
    options: [...],
    correct_answer: '...',
    explanation: '...',
    points: 2,
    difficulty_level: 'easy',
    sequence_order: 1,
    difficulty: 0.0,
    discrimination: 1.0,
    guessing: 0.2
  },
  # More questions...
])
```

#### Step 2: Run the Seed
```bash
rails db:seed  # Runs all seeds
# OR
rails db:seed:coop  # Runs specific category
# OR
rails db:environment:set RAILS_ENV=development
rake db:seed  # For older Rails versions
```

#### Step 3: Verify in Database
```bash
rails console
# Check course
Course.find_by(slug: 'iit-jee-inorganic-chemistry')
# Check modules
course.course_modules.pluck(:title, :sequence_order)
# Check items
module_x.module_items.includes(:item).map { |i| [i.item_type, i.item.title] }
```

---

## 7. CONTROLLER & ROUTING PATTERNS

### Creating a New Subject-Specific Course API:

#### Step 1: Create Controller
**Location**: `/app/controllers/api/v1/[subject]/[subject]_courses_controller.rb`

```ruby
module Api
  module V1
    module YourSubject
      class YourCoursesController < GenericCoursesController
        def index
          courses = get_courses_by_pattern('your-subject')
          render json: {
            success: true,
            courses: courses.map { |c| course_summary(c) }
          }
        end

        def show
          course = Course.find_by!(slug: params[:slug])
          render json: {
            success: true,
            course: course_detail(course)
          }
        end

        # Additional custom actions as needed
      end
    end
  end
end
```

#### Step 2: Add Routes
**Location**: `/config/routes.rb`

```ruby
namespace :api do
  namespace :v1 do
    namespace :your_subject do
      get    'courses',                    to: 'your_courses#index'
      get    'courses/:slug',              to: 'your_courses#show'
      get    'courses/:slug/modules',      to: 'your_courses#modules'
      get    'courses/:course_slug/modules/:module_slug', to: 'your_courses#show_module'
      get    'quizzes/:quiz_id',           to: 'your_courses#show_quiz'
      get    'quizzes/:quiz_id/questions', to: 'your_courses#quiz_questions'
      post   'quizzes/:quiz_id/questions/:question_id/submit', to: 'your_courses#submit_answer'
      match  '*all',                       to: 'your_courses#cors_preflight', via: :options
    end
  end
end
```

---

## 8. CONVENTIONS & PATTERNS USED

### Naming Conventions:
- **Courses**: lowercase with hyphens (e.g., `iit-jee-inorganic-chemistry`)
- **Modules**: lowercase with hyphens (e.g., `periodic-table-periodicity`)
- **Lessons**: `CourseLesson` model (not `Lesson`)
- **Slugs**: Unique per course for modules, globally unique for courses

### Database Practices:
- **Polymorphic associations** for flexible content types (ModuleItem → CourseLesson/Quiz/Lab)
- **JSON fields** for flexible data (options, learning_objectives, prerequisites)
- **Unique constraints** on (course_id, slug) for modules, (user_id, course_lesson_id) for completions
- **Indexes** on frequently queried fields (published, difficulty_level, question_type)

### API Practices:
- **CORS enabled** for all subject APIs
- **JSON responses** with success/error flags
- **Pattern-based filtering** (courses matching "chemistry" slug/title)
- **Lazy loading prevention** with `.includes()` for associations
- **Enumerable question types** with specific formats per type

### Code Organization:
- **Services** for business logic (e.g., ChemicalEquationValidator, RemediationTrackingService)
- **Models** for relationships and validations
- **Controllers** for request/response handling
- **Seeds** for data creation and seeding

### Quality Metrics:
- Passing RSpec tests for all question validations
- Error handling in answer submission
- Tolerance-based validation for numerical questions
- IRT (Item Response Theory) parameters for adaptive learning

---

## 9. FILES TO CREATE/MODIFY FOR NEW CHEMISTRY MODULES

### Required Files:

| Task | File | Action |
|------|------|--------|
| Add new module data | `/db/seeds/inorganic/module_XX_title.rb` | **CREATE** |
| Define course structure | `/app/models/course.rb` | Already exists |
| Define module structure | `/app/models/course_module.rb` | Already exists |
| Handle lessons | `/app/models/course_lesson.rb` | Already exists |
| Handle quizzes | `/app/models/quiz.rb` | Already exists |
| Handle questions | `/app/models/quiz_question.rb` | Already exists |
| Chemistry validation | `/app/services/chemical_equation_validator.rb` | Already exists |
| API endpoints | `/app/controllers/api/v1/chemistry/chemistry_courses_controller.rb` | Already exists |

### Optional Files:

| Task | File | Action |
|------|------|--------|
| Add hands-on lab | `/db/seeds/inorganic/labs_XX_title.rb` | **CREATE** if needed |
| Interactive units | `/db/seeds/inorganic/interactive_XX_title.rb` | **CREATE** if needed |
| Custom validation | `/app/services/custom_validator.rb` | **CREATE** if needed |

---

## 10. KEY METRICS & STATISTICS

### Existing Inorganic Chemistry Course:
- **Total Modules**: 8 main modules + 1 overview
- **Total Questions**: 200+
- **Question Type Distribution**:
  - Single MCQ: 25%
  - Multi-correct MCQ: 20%
  - Numerical: 15%
  - Sequence: 10%
  - Fill-blank: 15%
  - True/False: 5%
  - Equation Balance: 10%

### Average Lesson Structure:
- Reading time: 25-40 minutes per lesson
- Questions per quiz: 4-10 questions
- Difficulty mix: 40% easy, 35% medium, 25% hard
- Points per question: 1-3 (based on difficulty)

### Database Efficiency:
- **Indexes** on: published, difficulty_level, question_type, skill_dimension, topic
- **Polymorphic queries** optimized with includes()
- **JSON serialization** for flexible schema
- **Unique constraints** preventing duplicates

---

## Summary: What You Need to Know

### For Adding NEW Chemistry Content:
1. Use `/db/seeds/inorganic/module_XX_title.rb` template
2. Create `CourseLesson` for lessons, `Quiz` for quizzes, `QuizQuestion` for questions
3. Link with `ModuleItem` to organize in modules
4. Run `rails db:seed` to load data
5. API automatically available at `/api/v1/chemistry/...`

### Key Tables to Understand:
- **courses** → course_modules → module_items → (lessons/quizzes/labs)
- **quiz_questions** with 7 question types + chemistry fields
- **course_enrollments** & **module_progress** for tracking
- **lesson_completions** & **quiz_attempts** for assessments

### Most Important Models:
- `Course` - Course container
- `CourseModule` - Module container
- `CourseLesson` - Lesson content
- `Quiz` & `QuizQuestion` - Assessment
- `ModuleItem` - Polymorphic linker

### Most Important Files:
- `/db/migrate/20251030020100_create_course_system.rb` - Schema definition
- `/app/models/quiz_question.rb` - Question logic with chemistry support
- `/app/controllers/api/v1/generic_courses_controller.rb` - API base implementation
- `/db/seeds/inorganic/module_04_s_block.rb` - Example seed file pattern
