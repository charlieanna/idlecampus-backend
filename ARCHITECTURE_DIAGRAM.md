# Educational Modules Architecture Diagram

## Database Schema Relationships

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         COURSE STRUCTURE                                 │
└─────────────────────────────────────────────────────────────────────────┘

                              ┌──────────────┐
                              │   COURSES    │
                              │──────────────│
                              │ id (PK)      │
                              │ title        │
                              │ slug (UQ)    │
                              │ description  │
                              │ difficulty   │
                              │ published    │
                              └───────┬──────┘
                                      │
                                      │ 1:N (has_many)
                                      │
                    ┌─────────────────▼────────────────┐
                    │      COURSE_MODULES              │
                    │──────────────────────────────────│
                    │ id (PK)                          │
                    │ course_id (FK)                   │
                    │ title                            │
                    │ slug (UQ per course)             │
                    │ sequence_order                   │
                    │ estimated_minutes                │
                    │ learning_objectives (JSON)       │
                    │ published                        │
                    └────────────────┬─────────────────┘
                                     │
                                     │ 1:N (has_many)
                                     │
                    ┌────────────────▼──────────────────┐
                    │      MODULE_ITEMS (Polymorphic)  │
                    │───────────────────────────────────│
                    │ id (PK)                           │
                    │ course_module_id (FK)             │
                    │ item_type (string)                │
                    │ item_id (bigint)                  │
                    │ sequence_order                    │
                    │ required (boolean)                │
                    └────┬─────────┬──────────┬─────────┘
                         │         │          │
         ┌───────────────┘         │          └──────────────────┐
         │                         │                             │
    N:1  │ belongs_to :item        │                         N:1 │
         │ (CourseLesson)          │                         N:1 │
         │                         │                         N:1 │
    ┌────▼──────────────┐   ┌─────▼────────────┐   ┌────────▼──────────────┐
    │  COURSE_LESSONS   │   │      QUIZZES     │   │  HANDS_ON_LABS        │
    │───────────────────│   │──────────────────│   │──────────────────────│
    │ id (PK)           │   │ id (PK)          │   │ id (PK)              │
    │ title             │   │ title            │   │ title                │
    │ content (Markdown)│   │ description      │   │ description          │
    │ reading_time      │   │ time_limit_min   │   │ difficulty           │
    │ key_concepts      │   │ passing_score    │   │ estimated_minutes    │
    │ content_sections  │   │ max_attempts     │   │ lab_type             │
    │ video_url         │   │ quiz_type        │   │ category             │
    └────┬──────────────┘   │ shuffle_q        │   │ steps (JSON)         │
         │                  │ show_answers     │   │ validation_rules     │
         │ 1:N              └────┬─────────────┘   │ success_criteria     │
         │ (has_many          │ 1:N               │ published            │
         │ lesson_          │ (has_many:        │ points_reward        │
         │ completions)     │  quiz_questions) └────────────────────────┘
         │                  │
    ┌────▼────────────────┐ │
    │ LESSON_COMPLETIONS  │ │
    │────────────────────│ │
    │ id (PK)            │ │
    │ user_id (FK)       │ │
    │ course_lesson_id(FK)  │
    │ completed_at       │ │
    │ UQ: (user, lesson) │ │
    └────────────────────┘ │
                           │
                    ┌──────▼──────────────┐
                    │  QUIZ_QUESTIONS      │
                    │──────────────────────│
                    │ id (PK)              │
                    │ quiz_id (FK)         │
                    │ question_type        │ ◄── 7 types: mcq,
                    │ question_text        │     fill_blank, numerical,
                    │ options (JSON)       │     equation_balance,
                    │ correct_answer       │     sequence, true_false,
                    │ explanation          │     command
                    │ points               │
                    │ difficulty_level     │
                    │ sequence_order       │
                    │                      │
                    │ ◄── Chemistry Fields:
                    │ tolerance (decimal)  │ ◄── For numerical questions
                    │ multiple_correct     │ ◄── For IIT JEE MCQs
                    │ sequence_items (JSON)│ ◄── For ordering questions
                    │ image_url            │ ◄── For diagrams
                    │                      │
                    │ ◄── Adaptive Learning:
                    │ difficulty (IRT)     │ ◄── -3.0 to 3.0
                    │ discrimination       │ ◄── 0.1 to 3.0
                    │ guessing             │ ◄── 0.0 to 0.5
                    │ topic                │
                    │ skill_dimension      │
                    └──────┬───────────────┘
                           │
                           │ 1:N (has_many: quiz_attempts)
                           │
                    ┌──────▼───────────────┐
                    │  QUIZ_ATTEMPTS       │
                    │──────────────────────│
                    │ id (PK)              │
                    │ user_id (FK)         │
                    │ quiz_id (FK)         │
                    │ course_enrollment_id │
                    │ started_at           │
                    │ completed_at         │
                    │ score (%)            │
                    │ total_questions      │
                    │ correct_answers      │
                    │ answers (JSON)       │ ◄── {question_id: answer}
                    │ time_taken_seconds   │
                    │ passed (boolean)     │
                    │ attempt_number       │
                    └──────────────────────┘
```

---

## Progress Tracking Schema

```
                    ┌──────────────┐
                    │ USER         │
                    │──────────────│
                    │ id (PK)      │
                    └───────┬──────┘
                            │
                            │ 1:N (has_many)
                            │
            ┌───────────────▼─────────────────┐
            │   COURSE_ENROLLMENTS            │
            │─────────────────────────────────│
            │ id (PK)                         │
            │ user_id (FK)                    │
            │ course_id (FK)                  │
            │ enrolled_at                     │
            │ started_at                      │
            │ completed_at                    │
            │ completion_percentage (0-100)   │
            │ total_points                    │
            │ status (enrolled/in_progress/)  │
            │ current_item_type (polymorphic) │
            │ current_item_id (polymorphic)   │
            │ UQ: (user_id, course_id)       │
            └───────┬───────────────┬─────────┘
                    │               │
                    │ 1:N           │ 1:N
                    │               │
        ┌───────────▼──────────┐    │
        │ MODULE_PROGRESS      │    │
        │──────────────────────│    │
        │ id (PK)              │    │
        │ user_id (FK)         │    │
        │ course_module_id(FK) │    │
        │ course_enrollment_id │    │
        │ started_at           │    │
        │ completed_at         │    │
        │ completion_percentage│    │
        │ items_completed      │    │
        │ total_items          │    │
        │ status (not_started, │    │
        │         in_progress, │    │
        │         completed)   │    │
        │ UQ: (user_module)    │    │
        └──────────────────────┘    │
                                    │
                        ┌───────────▼──────────────────┐
                        │   LEARNING_EVENTS           │
                        │───────────────────────────   │
                        │ id (PK)                      │
                        │ user_id (FK)                 │
                        │ event_type                   │
                        │ event_category               │
                        │ event_data (JSON)            │
                        │ skill_dimensions (JSON)      │
                        │ performance_score (decimal)  │
                        │ time_spent_seconds           │
                        │ created_at                   │
                        └──────────────────────────────┘
```

---

## Question Type Validators

```
┌────────────────────────────────────────────────────────────────┐
│           QUIZ_QUESTION MODEL - VALIDATION LOGIC               │
└────────────────────────────────────────────────────────────────┘

┌─ question_type: 'mcq' ────────────────────────────────────────┐
│                                                                 │
│  options: [                                                    │
│    {text: "Option A", correct: true},                          │
│    {text: "Option B", correct: false},                         │
│    ...                                                          │
│  ]                                                              │
│                                                                 │
│  ┌─ If multiple_correct: true ─┐                              │
│  │ At least 2 options must be   │                              │
│  │ marked as correct            │                              │
│  └──────────────────────────────┘                              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

┌─ question_type: 'fill_blank' ──────────────────────────────────┐
│                                                                 │
│  correct_answer: "answer1|answer2|answer3"                     │
│  (Pipe-separated acceptable answers)                           │
│                                                                 │
│  Validation: Case-insensitive matching                         │
│             Whitespace-tolerant matching                       │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

┌─ question_type: 'numerical' ───────────────────────────────────┐
│                                                                 │
│  correct_answer: "123.45"                                      │
│  tolerance: 0.1      (±0.1 accepted)                           │
│                                                                 │
│  Validation: Float parsing                                     │
│             Tolerance range check: |user - correct| <= tol    │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

┌─ question_type: 'sequence' ────────────────────────────────────┐
│                                                                 │
│  sequence_items: [                                             │
│    {id: 1, text: "Step 1"},                                    │
│    {id: 2, text: "Step 2"},                                    │
│    {id: 3, text: "Step 3"}                                     │
│  ]                                                              │
│                                                                 │
│  correct_answer: "1,2,3"      (IDs in order)                  │
│  user_answer: "1,2,3" OR [1,2,3]                              │
│                                                                 │
│  Validation: All items have id and text                        │
│             Order matching (exact)                             │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

┌─ question_type: 'equation_balance' ────────────────────────────┐
│                                                                 │
│  question_text: "Balance: _Fe + _O₂ → _Fe₂O₃"                  │
│  correct_answer: "4Fe + 3O₂ → 2Fe₂O₃"                          │
│                                                                 │
│  Validation: ChemicalEquationValidator service                 │
│             Validates atom counts on both sides               │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

┌─ question_type: 'true_false' ──────────────────────────────────┐
│                                                                 │
│  correct_answer: "true" OR "false"                             │
│  user_answer: "true", "t", "yes", "1" (all = true)             │
│              "false", "f", "no", "0" (all = false)             │
│                                                                 │
│  Validation: Boolean normalization                             │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘

┌─ question_type: 'command' ─────────────────────────────────────┐
│                                                                 │
│  correct_answer: "docker ps -a|docker container ls -a"         │
│  (Pipe-separated acceptable commands)                          │
│                                                                 │
│  Validation: Command normalization (whitespace, lowercase)    │
│             Flexible matching for variations                   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## API Call Flow for Chemistry Courses

```
┌──────────────────────────────────────────────────────────────────┐
│                    CLIENT REQUEST                                 │
└───────────────────────────┬──────────────────────────────────────┘
                            │
                            ▼
        ┌───────────────────────────────────────┐
        │ Route: /api/v1/chemistry/courses      │
        │ Maps to: Chemistry::CoursesController │
        └───────────┬─────────────────────────────┘
                    │
                    ▼
        ┌──────────────────────────────────────┐
        │ ChemistryCoursesController           │
        │ (inherits GenericCoursesController)  │
        │                                       │
        │ def index                             │
        │   courses = get_courses_by_pattern   │
        │            ('chemistry')              │
        │   render json: {                     │
        │     courses: courses.map {...}       │
        │   }                                   │
        │ end                                   │
        └───────────┬──────────────────────────┘
                    │
                    ▼
        ┌──────────────────────────────────────┐
        │ Course.where("slug LIKE '%chemistry%'")
        │                                       │
        │ Returns: Course objects              │
        │ with associated:                     │
        │  - course_modules                    │
        │  - module_items                      │
        │  - lessons, quizzes, labs            │
        └───────────┬──────────────────────────┘
                    │
                    ▼
        ┌──────────────────────────────────────┐
        │ course_summary(course)               │
        │  ├─ id                               │
        │  ├─ title                            │
        │  ├─ slug                             │
        │  ├─ description                      │
        │  ├─ difficulty_level                 │
        │  ├─ estimated_hours                  │
        │  └─ module_count                     │
        └───────────┬──────────────────────────┘
                    │
                    ▼
        ┌──────────────────────────────────────┐
        │ JSON Response:                       │
        │ {                                    │
        │   "success": true,                   │
        │   "courses": [...]                   │
        │ }                                    │
        └──────────────────────────────────────┘
```

---

## Module Creation Flow

```
CREATE                    DATABASE                      API
REQUEST                   OPERATION                     RESPONSE
  │                          │                             │
  ├─ seed file created        │                             │
  │  (module_10_topic.rb)     │                             │
  │                           │                             │
  ├─ rails db:seed ──────────►│ 1. Create Course_Module    │
  │                           │                             │
  │                           │ 2. Create CourseLesson     │
  │                           │                             │
  │                           │ 3. Create ModuleItem       │
  │                           │    (links lesson)           │
  │                           │                             │
  │                           │ 4. Create Quiz             │
  │                           │                             │
  │                           │ 5. Create ModuleItem       │
  │                           │    (links quiz)             │
  │                           │                             │
  │                           │ 6. Create QuizQuestions    │
  │                           │    (multiple)               │
  │                           │                             │
  │                           │ 7. Validate all data       │
  │                           │                             │
  │                    Stored in Database                  │
  │                           │                             │
  │                           │◄─ API Automatically ────────┤
  │                           │   Available                 │
  │                           │                             │
  ├─ Test with curl ────────►│ 4. GET /api/v1/chemistry  │
  │                           │    /courses                 │
  │                           │    ▼                        │
  │                           │    Returns all courses     │
  │                           │    with new module         │
  │                           │                             │
  │                           │◄─ JSON Response ───────────┤
  │                           │   200 OK                    │
  │                           │   {success: true, ...}      │
```

---

## Content Delivery Flow

```
┌─────────────────────────────────────────────────────────────┐
│              STUDENT LEARNING JOURNEY                        │
└──────────────────────┬──────────────────────────────────────┘
                       │
        ┌──────────────▼──────────────┐
        │ 1. Enroll in Course          │
        │    ├─ Create CourseEnrollment│
        │    └─ Set status: "enrolled"│
        └──────────────┬───────────────┘
                       │
        ┌──────────────▼──────────────┐
        │ 2. Browse Modules            │
        │    ├─ GET /courses/:slug     │
        │    ├─ GET /courses/:slug     │
        │    │   /modules              │
        │    └─ Show module_items list │
        └──────────────┬───────────────┘
                       │
        ┌──────────────▼──────────────┐
        │ 3. View Lesson               │
        │    ├─ GET /lessons/:id       │
        │    ├─ Mark lesson start      │
        │    └─ POST /mark_completed   │
        │        (creates              │
        │         LessonCompletion)    │
        └──────────────┬───────────────┘
                       │
        ┌──────────────▼──────────────┐
        │ 4. Take Quiz                 │
        │    ├─ GET /quizzes/:id       │
        │    ├─ GET /questions         │
        │    └─ Create QuizAttempt     │
        └──────────────┬───────────────┘
                       │
        ┌──────────────▼──────────────┐
        │ 5. Submit Answers            │
        │    ├─ POST /submit_answer    │
        │    ├─ Validate with          │
        │    │  question validators    │
        │    ├─ Update QuizAttempt     │
        │    └─ Check if passed        │
        └──────────────┬───────────────┘
                       │
        ┌──────────────▼──────────────┐
        │ 6. Update Progress           │
        │    ├─ Update Module_Progress │
        │    ├─ Update Enrollment      │
        │    ├─ Create LearningEvent   │
        │    │  (for analytics)        │
        │    └─ Check if module/course │
        │       completed              │
        └──────────────┬───────────────┘
                       │
        ┌──────────────▼──────────────┐
        │ 7. Provide Feedback          │
        │    ├─ Show correct answer    │
        │    ├─ Show explanation       │
        │    ├─ Suggest remediation    │
        │    │  (if failed)            │
        │    └─ Award points           │
        └──────────────────────────────┘
```

---

## Index Strategy

```
Table: quizzes
├─ INDEX: question_type
├─ INDEX: difficulty_level
├─ INDEX: skill_dimension
├─ INDEX: (skill_dimension, difficulty)  ◄── Adaptive learning
└─ INDEX: topic

Table: quizzes
├─ INDEX: quiz_id
├─ INDEX: question_type
└─ INDEX: difficulty_level

Table: courses
├─ INDEX: slug (unique)
├─ INDEX: published
└─ INDEX: difficulty_level

Table: course_modules
├─ INDEX: (course_id, slug) (unique)
├─ INDEX: course_id
└─ INDEX: published

Table: lesson_completions
├─ INDEX: (user_id, course_lesson_id) (unique)
├─ INDEX: user_id
└─ INDEX: course_lesson_id

Table: quiz_attempts
├─ INDEX: (user_id, quiz_id)
├─ INDEX: user_id
├─ INDEX: quiz_id
└─ INDEX: passed
```

