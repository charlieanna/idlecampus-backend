# IdleCampus Backend - Codebase Exploration Summary

## 1. PROJECT OVERVIEW

**Project**: IdleCampus Backend (Ruby on Rails API)
**Architecture**: Rails 6+ application with PostgreSQL database
**Purpose**: Educational platform for courses with interactive lessons, exercises, quizzes, and labs
**Current Implementation**: Chemistry, Docker, Kubernetes, Linux, AWS, and other technical courses

---

## 2. COURSE & CONTENT ORGANIZATION HIERARCHY

### Database Hierarchy (Top-Down):
```
Course
  ├── CourseModule (modules/chapters)
  │    ├── ModuleItem (polymorphic container)
  │    │    ├── CourseLesson
  │    │    ├── Quiz
  │    │    │    └── QuizQuestion (7 types)
  │    │    ├── HandsOnLab
  │    │    └── InteractiveLearningUnit
  │    │
  │    ├── MicroLesson (newer structure)
  │    │    └── Exercise (5+ types)
  │    │
  │    └── TopicGroup (optional organization)
  │
  └── CourseEnrollment (student progress tracking)
       ├── ModuleProgress
       ├── LessonCompletion
       └── LearningEvent
```

### File Structure:
```
/db/seeds/
  ├── data_structures_algorithms_course.rb (existing DSA course)
  ├── consolidated_courses/ (structured YAML-based courses)
  │   ├── docker-fundamentals/
  │   │   └── manifest.yml
  │   ├── kubernetes-complete/
  │   │   └── manifest.yml
  │   ├── linux-shell-fundamentals/
  │   │   └── manifest.yml
  │   └── ... (other courses)
  │
  ├── [subject_name]_enhanced/ (organized by topic)
  │   ├── microlessons/
  │   │   └── *.yml (individual lessons)
  │   └── manifest.yml
  │
  └── [subject]/module_*.rb (traditional seed files)

/app/models/
  ├── course.rb
  ├── course_module.rb
  ├── course_lesson.rb
  ├── micro_lesson.rb
  ├── exercise.rb
  ├── quiz.rb
  ├── quiz_question.rb
  ├── problem.rb (minimal - title, description only)
  └── solution.rb (minimal - user_id, problem_id, code, status)
```

---

## 3. DATA FORMATS

### A. COURSE/LESSON DATA FORMATS

#### YAML Format (Consolidated Courses - PREFERRED):
```yaml
# manifest.yml for structured courses
course:
  slug: course-identifier
  title: Course Title
  description: Description
  estimated_hours: 10
  level: beginner
  learning_outcomes: [...]
  tags: [...]

modules:
  - slug: module-slug
    title: Module Title
    description: Description
    order: 1
    estimated_hours: 2
    lessons:
      - lesson-slug-1
      - lesson-slug-2
```

#### Individual Lesson YAML Format:
```yaml
# microlessons/lesson-title.yml
slug: lesson-slug
title: Lesson Title
sequence_order: 1
estimated_minutes: 15
difficulty: easy
content_md: |
  # Markdown content here
  
key_concepts:
  - concept1
  - concept2

exercises:
  - type: mcq
    slug: exercise-slug
    sequence_order: 1
    question: Question text
    options:
      - option 1
      - option 2
    correct_answer_index: 0
    explanation: Explanation text
    
  - type: reflection
    slug: reflection-slug
    sequence_order: 2
    prompt: Reflection prompt
    
  - type: checkpoint
    slug: checkpoint-slug
    sequence_order: 3
    prompt: Checkpoint prompt

objectives: [...]
next_recommended: []
```

#### Ruby Seed Format (Traditional):
```ruby
# db/seeds/data_structures_algorithms_course.rb
course = Course.find_or_create_by!(slug: 'dsa-course') do |c|
  c.title = 'Data Structures & Algorithms'
  c.difficulty_level = 'intermediate'
  c.estimated_hours = 60
  c.learning_objectives = JSON.generate([...])
end

module1 = CourseModule.find_or_create_by!(slug: 'complexity-analysis', course: course) do |m|
  m.title = 'Complexity Analysis'
  m.sequence_order = 1
  m.estimated_minutes = 100
  m.published = true
end

lesson = CourseLesson.find_or_create_by!(title: "Lesson Title") do |l|
  l.reading_time_minutes = 30
  l.content = <<~MARKDOWN
    # Markdown content
  MARKDOWN
  l.key_concepts = ['concept1', 'concept2']
end

ModuleItem.find_or_create_by!(course_module: module1, item: lesson) do |mi|
  mi.sequence_order = 1
  mi.required = true
end

quiz = Quiz.create!(
  title: 'Quiz Title',
  description: 'Description',
  time_limit_minutes: 30,
  passing_score: 70
)

ModuleItem.create!(course_module: module1, item: quiz, sequence_order: 2)

QuizQuestion.create!([
  {
    quiz: quiz,
    question_type: 'mcq',
    question_text: 'Question?',
    options: [{text: "...", correct: true}],
    correct_answer: 0,
    points: 2,
    difficulty_level: 'medium'
  }
])
```

### B. EXERCISE DATA FORMATS

#### Exercise Model (Database):
```ruby
# Located in: micro_lessons (exercises linked to microlessons)
Exercise.create!(
  micro_lesson: lesson,
  exercise_type: 'mcq',  # terminal, mcq, code, short_answer, sandbox
  sequence_order: 1,
  exercise_data: {
    # Depends on exercise_type - stored as JSONB
  }
)
```

#### Exercise Types & Data Structures:

**MCQ Exercise:**
```json
{
  "question": "Question text?",
  "options": ["Option A", "Option B", "Option C"],
  "correct_answer": 0,
  "explanation": "Why this answer is correct",
  "hints": ["Hint 1", "Hint 2"],
  "difficulty": "medium"
}
```

**Terminal Exercise:**
```json
{
  "command": "ls -la",
  "description": "List files with details",
  "expected_output_pattern": "^total \\d+",
  "hints": ["Use the l flag", "Use the a flag"],
  "difficulty": "easy"
}
```

**Code Exercise:**
```json
{
  "description": "Write a function that...",
  "language": "python",
  "starter_code": "def solve():\n    pass",
  "test_file": "test_solution.py",
  "test_cases": [...],
  "hints": [...],
  "difficulty": "hard"
}
```

**Short Answer Exercise:**
```json
{
  "question": "What is the capital of France?",
  "answer": "Paris|PARIS|paris",  // Pipe-separated variants
  "explanation": "Paris is...",
  "difficulty": "easy"
}
```

**Sandbox Exercise:**
```json
{
  "description": "Interactive scenario",
  "scenario": "You need to...",
  "success_criteria": "User must...",
  "hints": [...],
  "difficulty": "medium"
}
```

### C. PROBLEM/SOLUTION DATA FORMATS

**Current Problem Model (Very Basic):**
```ruby
# Minimal implementation - needs expansion
class Problem < ApplicationRecord
  has_many :solutions
  validates :title, presence: true
  validates :description, presence: true
  
  # Fields:
  # - title (string)
  # - description (text)
  # - sample_input (text)
  # - sample_output (text)
  # - timestamps
end

class Solution < ApplicationRecord
  belongs_to :problem
  
  # Fields:
  # - user_id (integer)
  # - problem_id (integer, FK)
  # - code (string)
  # - status (string)
  # - execution_result (string)
  # - timestamps
end
```

**Quiz Question Model (More Complete):**
```ruby
# More feature-rich for assessments
class QuizQuestion < ApplicationRecord
  # Question Types:
  # - mcq (single & multi-correct)
  # - fill_blank
  # - numerical (with tolerance)
  # - equation_balance (chemistry)
  # - sequence (ordering)
  # - true_false
  # - command (Docker/Linux)
  
  # Fields:
  # - question_type (string)
  # - question_text (text)
  # - options (JSON) - for MCQ
  # - correct_answer (text)
  # - explanation (text)
  # - points (integer)
  # - difficulty_level (string: easy, medium, hard)
  # - tolerance (decimal) - for numerical
  # - multiple_correct (boolean) - IIT JEE MCQs
  # - sequence_items (JSON) - for ordering
  # - image_url (string) - for diagrams
  # 
  # Adaptive Learning (IRT):
  # - difficulty (decimal: -3.0 to 3.0)
  # - discrimination (decimal: 0.1 to 3.0)
  # - guessing (decimal: 0.0 to 0.5)
end
```

---

## 4. EXISTING PROBLEM/EXERCISE DATABASES & CONTENT

### A. Existing Algorithm Content:
- **File**: `/db/seeds/data_structures_algorithms_course.rb`
- **Status**: Partial implementation (module 1-2 only shown)
- **Coverage**: Big O notation, arrays, linked lists, stacks, queues
- **Format**: Ruby seed file with embedded Markdown lessons

### B. Quiz Question System:
- **Count**: 200+ questions across chemistry courses
- **Types**: MCQ, fill-blank, numerical, sequence, equation-balance, true/false, command
- **Database**: quiz_questions table with JSON fields
- **Features**: Multiple correct answers, tolerance for numerical, IRT parameters

### C. Exercise System (Microlessons):
- **Count**: Hundreds of exercises across courses
- **Types**: MCQ, terminal, code, short_answer, sandbox, reflection, checkpoint
- **Storage**: exercises table linked to micro_lessons
- **Data**: JSONB exercise_data field with type-specific validation

### D. Hands-On Labs:
- **Coverage**: Docker, Kubernetes, Linux, AWS
- **Structure**: Steps, validation rules, success criteria
- **Feature**: Lab session tracking, execution results

---

## 5. KEY DIRECTORIES & FILES

### Important Directories:

| Path | Purpose |
|------|---------|
| `/app/models/` | ActiveRecord models (Course, Lesson, Exercise, Quiz, etc.) |
| `/app/controllers/api/v1/` | REST API endpoints (by subject: chemistry, docker, linux, etc.) |
| `/db/seeds/` | Data seeding for courses and content |
| `/db/seeds/consolidated_courses/` | YAML-based structured courses (RECOMMENDED) |
| `/db/migrate/` | Database schema migrations |
| `/db/schema.rb` | Current database schema |
| `/app/services/` | Business logic (validators, lab executors, etc.) |

### Key Migration Files:

| File | Purpose |
|------|---------|
| `20251030020100_create_course_system.rb` | Course hierarchy tables |
| `20251107161223_create_micro_lessons.rb` | Microlesson table |
| `20251107161303_create_exercises.rb` | Exercise table (JSONB) |
| `20240104095249_create_problems.rb` | Problem table (minimal) |
| `20240105082710_create_solutions.rb` | Solution table (minimal) |

### Key Model Files:

| File | Purpose |
|------|---------|
| `/app/models/course.rb` | Course container |
| `/app/models/course_module.rb` | Module/chapter container |
| `/app/models/course_lesson.rb` | Lesson content |
| `/app/models/micro_lesson.rb` | Microlesson with exercises |
| `/app/models/exercise.rb` | Exercise with flexible JSONB data |
| `/app/models/quiz.rb` | Assessment container |
| `/app/models/quiz_question.rb` | Question with 7+ types |
| `/app/models/problem.rb` | Coding problem (needs enhancement) |

---

## 6. CURRENT ARCHITECTURE PATTERNS

### A. Course Structure Pattern:
1. **Course** (container - Docker Fundamentals, Chemistry, etc.)
2. **CourseModule** (chapters/modules - Introduction to Docker, Docker Images, etc.)
3. **ModuleItem** (polymorphic container - references CourseLesson, Quiz, Lab, etc.)
4. **Content** (actual learning material - lessons, quizzes, labs)
5. **Progress Tracking** (enrollments, module progress, lesson completions)

### B. Exercise Structure Pattern:
1. **MicroLesson** (short focused lessons, ~2-10 minutes)
2. **Exercise** (interactive component linked to microlesson)
3. **exercise_data** (JSONB field with type-specific data)
4. **ExerciseAttempt** (user submissions and grading)

### C. Quiz/Assessment Pattern:
1. **Quiz** (assessment container)
2. **QuizQuestion** (individual questions with multiple types)
3. **QuizAttempt** (user attempts and scores)
4. **QuestionResponse** (individual answers)

### D. Progression Pattern:
- **CourseEnrollment** → User's entry point to a course
- **ModuleProgress** → Tracks completion per module
- **LessonCompletion** → Binary yes/no for lessons
- **QuizAttempt** → Assessment performance
- **LearningEvent** → Fine-grained learning analytics

---

## 7. DATABASE SCHEMA HIGHLIGHTS

### Exercise Table:
```sql
CREATE TABLE exercises (
  id BIGINT PRIMARY KEY,
  micro_lesson_id BIGINT NOT NULL,  -- Foreign key
  exercise_type VARCHAR,            -- 'mcq', 'terminal', 'code', etc.
  sequence_order INTEGER DEFAULT 1,
  exercise_data JSONB DEFAULT {},   -- Type-specific data
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  
  FOREIGN KEY (micro_lesson_id) REFERENCES micro_lessons(id),
  INDEX exercises_micro_lesson_id_sequence_order,
  INDEX exercises_exercise_type
);
```

### Problem Table (Current - Minimal):
```sql
CREATE TABLE problems (
  id BIGINT PRIMARY KEY,
  title VARCHAR,
  description TEXT,
  sample_input TEXT,
  sample_output TEXT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
```

### Quiz Question Table (Full-Featured):
```sql
CREATE TABLE quiz_questions (
  id BIGINT PRIMARY KEY,
  quiz_id BIGINT NOT NULL,
  question_type VARCHAR,
  question_text TEXT,
  options TEXT (JSON),
  correct_answer TEXT,
  explanation TEXT,
  points INTEGER DEFAULT 1,
  difficulty_level VARCHAR,
  tags TEXT (JSON),
  sequence_order INTEGER,
  image_url VARCHAR,
  
  -- Chemistry-specific
  tolerance DECIMAL(10,6),
  multiple_correct BOOLEAN,
  sequence_items TEXT (JSON),
  
  -- Adaptive Learning (IRT)
  difficulty DECIMAL,
  discrimination DECIMAL,
  guessing DECIMAL,
  
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
```

---

## 8. API ENDPOINTS STRUCTURE

### Base URL: `/api/v1`

### Subject-Specific Namespaces:
```
/api/v1/courses                    -- Generic courses
/api/v1/chemistry/                 -- Chemistry courses
/api/v1/docker/                    -- Docker courses
/api/v1/kubernetes/                -- Kubernetes courses
/api/v1/linux/                     -- Linux courses
/api/v1/security/                  -- Security courses
/api/v1/coding/                    -- Coding interview courses
/api/v1/system_design/             -- System design courses
/api/v1/exercise_attempts/         -- Exercise grading
/api/v1/microlessons/              -- Microlesson content
```

### Example Endpoint Pattern:
```
GET    /api/v1/courses                            -- List courses
GET    /api/v1/courses/:slug                      -- Course details
GET    /api/v1/courses/:slug/modules              -- Course modules
GET    /api/v1/courses/:slug/modules/:module_slug -- Module details
GET    /api/v1/microlessons/:id                   -- Microlesson details
POST   /api/v1/exercise_attempts                  -- Submit exercise
GET    /api/v1/quizzes/:quiz_id/questions         -- Get questions
POST   /api/v1/quizzes/:quiz_id/questions/:id/submit -- Submit answer
```

---

## 9. HOW CONTENT IS LOADED

### Loading Mechanism:
1. **Seed files run**: `rails db:seed`
2. **Database populated**: Courses → Modules → Lessons/Quizzes → Questions/Exercises
3. **API queries database**: Controllers fetch and return via JSON
4. **Frontend consumes**: Vue/React frontend displays content

### Seed File Execution:
```bash
rails db:seed                      # All seeds in db/seeds/*.rb and db/seeds/*/
rails db:seed:consolidate_courses # Specific seed for consolidated courses
rails db:environment:set RAILS_ENV=development  # Set environment first
```

---

## 10. RECOMMENDED LOCATION FOR ALGORITHM PROBLEMS DATABASE

### Option 1: YAML-Based Consolidated Course (RECOMMENDED):

**Path**: `/db/seeds/consolidated_courses/algorithms-data-structures/`

**Structure**:
```
consolidated_courses/
  algorithms-data-structures/
    ├── manifest.yml              -- Course metadata & module listing
    ├── microlessons/
    │   ├── big-o-notation.yml
    │   ├── arrays-lists.yml
    │   ├── trees-graphs.yml
    │   ├── sorting-algorithms.yml
    │   ├── dynamic-programming.yml
    │   └── ...
    └── loader.rb                 -- (Optional) Custom loader for special processing
```

**Advantages**:
- Organized and scalable
- Follows existing patterns (docker-fundamentals, kubernetes-complete)
- Easy to maintain and version control
- Simple YAML format for lessons
- Automatically discovered by seed loaders
- Can include multiple exercise types per lesson

### Option 2: Dedicated Ruby Seed File:

**Path**: `/db/seeds/algorithms_data_structures_course.rb`

**Pattern**: Same as `/db/seeds/data_structures_algorithms_course.rb`

**Advantages**:
- More programmatic control
- Can generate problems programmatically
- Single file to manage

### Option 3: Separate Problem Database:

**Path**: `/db/seeds/algorithms_problems_database.rb`

**Structure**:
```ruby
# Create problem entries separately
Problem.create!([
  {
    title: "Two Sum",
    description: "Find two numbers that add up to target",
    sample_input: "[2,7,11,15], target=9",
    sample_output: "[0,1]",
    # Plus: difficulty, category, tags, solution_code, etc.
  }
])
```

**Advantages**:
- Focused on problems specifically
- Can link to multiple courses
- Reusable across different courses

---

## 11. RECOMMENDED APPROACH FOR ALGORITHM PROBLEMS

### Recommended Strategy: **HYBRID (Option 1 + 3)**

**Reason**: Leverage both systems for flexibility

### Implementation Structure:

```
/db/seeds/consolidated_courses/algorithms-data-structures/
  ├── manifest.yml                    -- Course structure
  ├── loader.rb                       -- Custom loading logic
  └── microlessons/
      ├── big-o-notation.yml
      ├── arrays-and-lists.yml
      ├── trees-and-graphs.yml
      └── ...

/db/seeds/
  ├── algorithms_problem_database.rb  -- Problem definitions
  └── algorithms_problem_solutions.rb -- Solutions/test cases
```

### Content Organization:

**Each Microlesson includes**:
- Theory/explanation (Markdown)
- 2-3 practice exercises (MCQ, short-answer)
- 1-2 coding problems (reference to problem database)
- Reflection/checkpoint

**Problem Database includes**:
- Problem metadata (title, difficulty, category, tags)
- Problem description and constraints
- Test cases and validation
- Solution code (multiple languages)
- Similar problems (for progression)

---

## 12. DATABASE SCHEMA FOR ALGORITHM PROBLEMS

### Recommended Enhanced Problem Model:

```ruby
class Problem < ApplicationRecord
  has_many :solutions
  has_many :test_cases
  has_many :problem_courses, dependent: :destroy
  has_many :courses, through: :problem_courses
  
  # Current fields
  # - title (string)
  # - description (text)
  # - sample_input (text)
  # - sample_output (text)
  
  # Recommended additions:
  # - slug (string, unique)
  # - category (string): array, string, tree, graph, dp, greedy, etc.
  # - difficulty (integer or string): easy, medium, hard, expert
  # - topics (text/JSON): multiple algorithms/concepts
  # - constraints (text/JSON): problem constraints
  # - time_limit (integer): seconds
  # - memory_limit (integer): MB
  # - editorial (text/JSON): explanation/approach
  # - solution_code (text/JSON): multiple language solutions
  # - similar_problems (text/JSON): related problem IDs
  # - acceptance_rate (decimal): if tracking stats
  # - created_at, updated_at
end

class TestCase < ApplicationRecord
  belongs_to :problem
  # - problem_id (FK)
  # - input (text/JSON)
  # - expected_output (text/JSON)
  # - is_sample (boolean)
  # - explanation (text)
end

class Solution < ApplicationRecord
  belongs_to :problem
  belongs_to :user, optional: true
  # - user_id (FK, optional)
  # - problem_id (FK)
  # - code (text)
  # - language (string): python, javascript, java, cpp, etc.
  # - status (string): pending, accepted, wrong_answer, time_limit_exceeded, etc.
  # - execution_result (text/JSON)
  # - runtime_ms (integer)
  # - memory_kb (integer)
  # - submitted_at (datetime)
end
```

---

## 13. QUICK REFERENCE - WHERE THINGS ARE

| What | Where |
|------|-------|
| Database models | `/app/models/` |
| API controllers | `/app/controllers/api/v1/` |
| Course seeds (Ruby) | `/db/seeds/*.rb` |
| Course seeds (YAML) | `/db/seeds/consolidated_courses/*/` |
| Database migrations | `/db/migrate/` |
| Exercise validation | `/app/models/exercise.rb` |
| Quiz system | `/app/models/quiz.rb`, `/app/models/quiz_question.rb` |
| Service logic | `/app/services/` |
| API documentation | `/API_README.md` |
| Architecture docs | `/CODEBASE_STRUCTURE.md`, `/ARCHITECTURE_DIAGRAM.md` |
| Chemistry example | `/db/seeds/inorganic/module_*.rb` |
| Docker example | `/db/seeds/consolidated_courses/docker-fundamentals/` |

---

## 14. SUMMARY & RECOMMENDATIONS

### Current State:
- **Courses**: Fully implemented (Course → Module → Items → Content)
- **Lessons**: Two systems (CourseLesson + MicroLesson with Exercises)
- **Quizzes**: Fully featured with 7+ question types
- **Problems**: Minimal implementation (just title + description)
- **Solutions**: Basic (code + status only)

### For Algorithm Problems Database:

### CREATE at:
`/db/seeds/consolidated_courses/algorithms-data-structures/`

### Contains:
1. **manifest.yml** - Course structure and module listing
2. **microlessons/*.yml** - Individual lesson files with:
   - Markdown content
   - Conceptual exercises (MCQ, reflection)
   - References to problems
3. **loader.rb** - Optional custom loading (if needed)

### Plus: `/db/seeds/algorithms_problem_database.rb`:
- Define 100+ algorithm problems
- Include test cases, solutions
- Link to course and lessons
- Include metadata (difficulty, tags, categories)

### Execute:
```bash
rails db:seed  # Loads everything
```

### Access:
- Frontend: `/courses/algorithms-data-structures/`
- API: `/api/v1/courses/algorithms-data-structures`
- Problems: Create new endpoint or embed in lesson exercises

---

## 15. NEXT STEPS

1. **Expand Problem Model**:
   - Add category, difficulty, tags, constraints
   - Add test case relationships
   - Add solution code storage

2. **Create Consolidated Course**:
   - `/db/seeds/consolidated_courses/algorithms-data-structures/manifest.yml`
   - Create microlesson YAML files

3. **Create Problem Database**:
   - `/db/seeds/algorithms_problem_database.rb`
   - Define 50-100 problems by category

4. **Create Loaders/Seeders**:
   - Course manifest loader (if not existing)
   - Problem database seeder

5. **Create API Endpoints** (optional):
   - `/api/v1/problems` - Problem listing
   - `/api/v1/problems/:id` - Problem details
   - `/api/v1/problems/:id/test` - Run test cases

6. **Frontend Integration**:
   - Problem viewer component
   - Code editor
   - Test case runner
   - Solution submission

