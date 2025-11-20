# Teaching & Learning Content Delivery System - Comprehensive Analysis

## EXECUTIVE SUMMARY

The Idle Campus backend implements a sophisticated, multi-layered educational system with adaptive learning, spaced repetition, remediation tracking, and personalized content delivery. The system is highly modular and supports multiple content types (lessons, quizzes, interactive units, labs) with intelligent progression and feedback mechanisms.

---

## 1. COURSE STRUCTURE & ORGANIZATION

### Hierarchical Course Organization
```
Course
  ├── CourseModule (multiple modules per course)
  │   ├── ModuleItem (polymorphic associations)
  │   │   ├── CourseLesson
  │   │   ├── Quiz
  │   │   └── HandsOnLab
  │   └── ModuleProgress (tracks user progress per module)
  │
  └── CourseEnrollment (user enrollments)
```

### Key Models:
- **Course** (`/app/models/course.rb`)
  - Fields: title, slug, description, difficulty_level, certification_track
  - Methods: total_modules, total_items, estimated_duration, enrollment tracking
  
- **CourseModule** (`/app/models/course_module.rb`)
  - Fields: title, slug, description, sequence_order, estimated_minutes
  - Polymorphic relationship with items (lessons, quizzes, labs)
  - Tracks module progress and completion status
  
- **ModuleItem** (`polymorphic join table`)
  - Links courses/modules to lessons, quizzes, and labs
  - Fields: sequence_order, required flag

---

## 2. LESSON MODELS & CONTENT DELIVERY

### Two Lesson Systems:

#### A. CourseLesson (Modern Course System)
**File:** `/app/models/course_lesson.rb`

- Rich content support with **content_sections** (JSONB field)
- Fields:
  - title
  - content (Markdown)
  - video_url (optional)
  - reading_time_minutes
  - key_concepts (JSON array)
  - content_sections (JSONB) - structured lesson sections with IDs and anchors
  
- Relationships:
  - has_many quiz_question_lesson_mappings
  - has_many quiz_questions (through mappings)
  - has_many remediation_activities
  - has_many lesson_completions (tracks user progress)

#### B. Legacy Lesson System
**File:** `/app/models/lesson.rb`

- Basic lesson model for backward compatibility
- Fields: title, content, reading_time_minutes, key_concepts, difficulty_level
- Scopes: published, recent

### LessonCompletion Model
**File:** `/app/models/lesson_completion.rb`

- Tracks when users complete lessons
- Fields: user_id, course_lesson_id, completed_at
- Used for determining progression and completion tracking

---

## 3. QUIZ-TO-LESSON CONNECTIONS

### QuizQuestionLessonMapping
**File:** `/app/models/quiz_question_lesson_mapping.rb`

This is the **critical linking mechanism** between assessment and teaching:

**Key Fields:**
```
quiz_question_id      # The question being answered
course_lesson_id      # The lesson containing relevant content
relevance_weight      # 0-100: how relevant this lesson is to the question
section_anchor        # Specific section in lesson (e.g., "section-1", "concepts-2")
```

**Key Methods:**
- `primary_recommendation?` - Returns true if relevance_weight >= 80
- `section_title()` - Extracts section title from lesson's content_sections array
- `lesson_url_with_anchor()` - Generates deep links to specific lesson sections

**How It Works:**
1. When student answers a quiz question incorrectly
2. System looks up mappings for that question
3. Finds associated lessons, prioritized by relevance_weight
4. Points student to specific lesson section using section_anchor

### Multiple Correct MCQ Support
**QuizQuestion** supports IIT JEE style questions with multiple correct answers:
```ruby
- multiple_correct field (boolean)
- validates at least 2 correct options
- handles array-based user answers
```

---

## 4. CONTENT TYPES & DELIVERY SYSTEMS

### A. Quiz Content
**File:** `/app/models/quiz.rb`

**Types:**
- standard
- review_session (adaptive reviews based on past performance)
- topic_deepdive (focused practice on topics)
- mastery_challenge (high-difficulty assessment)

**Fields:**
- title, description
- time_limit_minutes
- passing_score (default 70)
- max_attempts (null = unlimited)
- shuffle_questions (boolean)
- show_correct_answers (boolean)
- metadata (JSON) - stores parent_quiz_id, adaptive_retry flag, review_item_ids
- quiz_type

**Key Methods:**
```ruby
calculate_score(answers)           # Score calculation
randomized_questions              # Optional question shuffling
best_attempt_for(user)            # Best attempt tracking
adaptive_retry?                   # Check if adaptive retry enabled
parent_quiz                       # Get parent quiz if this is adaptive retry
```

### B. Quiz Questions
**File:** `/app/models/quiz_question.rb`

**Question Types Supported:**
- `mcq` - Multiple choice (single/multiple correct)
- `fill_blank` - Fill in the blank
- `command` - Command-based (Docker, Kubernetes, etc.)
- `true_false` - Boolean questions
- `numerical` - Mathematical with tolerance
- `equation_balance` - Chemistry equations
- `sequence` - Ordering items in correct sequence

**Critical Fields for Adaptive Learning:**
```
difficulty        # -3.0 to +3.0 (IRT difficulty parameter)
discrimination    # 0.1 to 3.0 (how well question distinguishes abilities)
guessing         # 0.0 to 0.5 (pseudo-guessing parameter for IRT)
topic            # Subject/topic for remediation
skill_dimension  # Learning dimension (algebra, coding, etc.)
```

**Explanation/Feedback:**
```ruby
explanation      # Text explanation shown after answer
correct_answer   # For non-MCQ types
options          # JSON array of {text, correct, common_mistake}
```

**Key Methods:**
```ruby
correct_answer?(user_answer)      # Validates answer against question
formatted_correct_answer          # Display-friendly correct answer
shuffled_options                  # Randomized MCQ options
parsed_options                    # Handles JSON/Array parsing of options
```

### C. Interactive Learning Units
**File:** `/app/models/interactive_learning_unit.rb`

**Comprehensive Content Model:**
- concept_explanation (Markdown, max 200 words)
- command_to_learn (primary command being taught)
- command_variations (array of alternative forms)
- practice_hints (array of progressive hints)
- quiz_question_type (mcq, true_false, fill_in_blank)
- quiz_correct_answer
- quiz_explanation
- estimated_minutes (1-10 min)

**Progression Tracking:**
- prerequisites (array of unit slugs)
- completion tracking per user
- mastery_score calculation

**Completion Components (for mastery):**
1. explanation_read (10%)
2. practice_completed (30% - with attempt penalties)
3. quiz_answered (30% - with attempt penalties)
4. scenario_completed (30%)

---

## 5. QUIZ-TO-QUESTION FLOW

### QuizAttempt Model
**File:** `/app/models/quiz_attempt.rb`

**Tracks Every Quiz Attempt:**
```ruby
user_id              # Student taking quiz
quiz_id              # Which quiz
course_enrollment_id # Course context (optional)
started_at           # When started
completed_at         # When submitted
score                # Percentage score
total_questions      # Total questions attempted
correct_answers      # Count of correct
answers              # JSON: {question_id => user_answer}
time_taken_seconds   # Duration
passed               # Boolean (score >= passing_score)
attempt_number       # Which attempt number (1, 2, 3...)
```

**Key Methods:**
```ruby
submit!(user_answers)              # Process submission
calculate_results!                 # Calculate score and results
incorrect_questions                # Get questions answered wrong
correct_questions                  # Get correct answers
answer_for(question)              # Get user's answer for specific Q
performance_level                 # "Excellent", "Pass", "Needs Improvement"
```

**Callbacks:**
- `schedule_spaced_repetition` - Creates review items for incorrect questions
- `update_module_progress` - Updates course module completion
- `update_review_session_fsrs` - Updates FSRS scheduling for review sessions

---

## 6. CONTENT DELIVERY MECHANISMS

### A. Course Lessons Display
**Controller:** `/app/controllers/course_lessons_controller.rb`

**Show Action:**
1. Authenticates user
2. Finds lesson and course context
3. Checks if already completed
4. Finds next item in sequence
5. Tracks lesson start event (LearningEventTracker)
6. Renders lesson content

**Complete Action:**
1. Marks lesson as completed (LessonCompletion record)
2. Updates module progress
3. Awards progress points
4. Tracks completion event
5. Redirects to module view

### B. Quiz Delivery
**Controller:** `/app/controllers/quizzes_controller.rb`

**Sequence:**
1. **Show** - Display quiz details and previous attempts
2. **Start** - Create QuizAttempt, randomize questions (optional)
3. **Take** - Render quiz questions (question by question or all-at-once)
4. **Submit** - Process answers, calculate score, determine pass/fail
5. **Result** - Show score, explanations, remediation recommendations

### C. Results & Explanation Display

After quiz submission:
```ruby
# In QuizAttempt.submit!
- Calculates score
- Determines correct/incorrect questions
- Triggers remediation recommendations
- Updates spaced repetition queue
- Awards points (with bonuses for first attempt/perfect score)
```

**Explanation Access:**
1. Question explanation field shown if enabled
2. Lesson recommendations shown via QuizQuestionLessonMapping
3. Mini-lesson generated via MiniLessonGenerator service
4. Progressive feedback generated via WrongAnswerAnalyzer

---

## 7. REMEDIATION & FEEDBACK SYSTEMS

### A. RemediationActivity Model
**File:** `/app/models/remediation_activity.rb`

**Tracks Remediation Actions:**
```ruby
user_id              # Student
quiz_attempt_id      # Which quiz attempt triggered remediation
quiz_question_id     # Which question was wrong
course_lesson_id     # Which lesson they reviewed
lesson_reviewed      # Did they review the lesson?
improved_on_retry    # Did they answer better on retry?
```

**Key Methods:**
```ruby
mark_as_reviewed!              # Mark when lesson reviewed
mark_improvement!(improved:)   # Track if performance improved
```

**Analytics:**
```ruby
RemediationActivity.effectiveness_rate    # % of reviewed issues that improved
most_reviewed_lessons                     # Which lessons reviewed most
by_topic                                  # Filter by topic
```

### B. RemediationTrackingService
**File:** `/app/services/remediation_tracking_service.rb`

**Comprehensive Remediation System:**

1. **track_lesson_review** - Logs when user reviews a lesson after failing
2. **track_retry_result** - Compares before/after attempts to measure improvement
3. **get_recommended_reviews** - Finds failed questions needing remediation
4. **evaluate_remediation_effectiveness** - ROI on remediation (how much helped)
5. **get_remediation_stats** - Aggregated remediation metrics

**Key Features:**
```ruby
# Recommends lessons for failed questions
failures.each do |question|
  # Map to relevant lessons via QuizQuestionLessonMapping
  # Filter to lessons not yet reviewed
  # Sort by relevance_weight
  recommendations << {
    question_id,
    lesson,
    quiz_attempt_id,
    priority: 'high'
  }
end
```

### C. WrongAnswerAnalyzer Service
**File:** `/app/services/wrong_answer_analyzer.rb`

**Progressive Feedback Generation:**

**Error Classification:**
- no_attempt
- wrong_command
- missing_flags
- syntax_error
- misconception
- conceptual

**Three-Level Feedback + Solution:**
```ruby
feedback = {
  level_1: "General hint",      # Least specific
  level_2: "Topic-specific hint",
  level_3: "Concrete hint",     # Most specific
  solution: "Full explanation"  # Complete answer
}
```

**Example:**
```
Error: missing_flags

Level 1: "You're close! Check if you're missing any required flags."
Level 2: "Compare your command to documentation. Are all required options present?"
Level 3: "Missing flags: --port, --detach"
Solution: [Full explanation from question.explanation field]
```

### D. MiniLessonGenerator Service
**File:** `/app/services/mini_lesson_generator.rb`

**Generates Contextual Teaching:**

For each topic (pods, deployments, services, etc.):
```ruby
{
  title: "Understanding Pods",
  summary: "Brief explanation",
  key_concepts: ["Concept 1", "Concept 2", ...],
  common_commands: ["Command 1", "Command 2"],
  visual_example: "ASCII diagram or analogy",
  question_context: "Why this matters for your question"
}
```

**Renders in remediation modal:**
```erb
<div class="mini-lesson">
  <%= mini_lesson[:title] %>
  <%= mini_lesson[:summary] %>
  
  Key Concepts:
  - <%= concept %>
  
  Common Commands:
  - <%= command %>
  
  Visual: <%= visual_example %>
</div>
```

---

## 8. LEARNING PATHS & PROGRESSION

### A. StudyPlan Model
**File:** `/app/models/study_plan.rb`

**Personalized Learning Paths:**
```ruby
user_id                    # Which student
course_id                  # For which course
daily_target               # Minutes per day (e.g., 60)
weekly_target              # Days per week (1-7)
start_date                 # When plan starts
estimated_completion_date  # Target completion
progress_percentage        # Calculated from enrollment
milestones                 # Array of module milestones
status                     # active, paused, completed, cancelled
```

**Key Methods:**
```ruby
generate_milestones!           # Create milestone for each module
check_and_update_milestones!  # Track milestone completion
behind_schedule?              # Compare progress to expected
ahead_of_schedule?            # Bonus: ahead of target
daily_recommendation          # Adaptive daily targets
```

### B. Module Progress Tracking
**Model:** `ModuleProgress`

**Per-User Module Tracking:**
```ruby
user_id              # Student
course_module_id     # Which module
course_enrollment_id # Course enrollment
started_at           # When started module
completed_at         # When completed
completion_percentage # 0-100%
items_completed      # Count of items done
total_items          # Total items in module
status              # not_started, in_progress, completed
```

**Automatic Updates:**
- Triggered when quiz/lesson completed
- Calculates items_completed by checking LessonCompletion, QuizAttempt, LabSession
- Updates status and completion_percentage
- Sets completed_at when 100% done

### C. Course Enrollment
**Model:** `CourseEnrollment`

**Tracks Course Progress:**
```ruby
user_id              # Student
course_id            # Which course
enrolled_at          # Enrollment date
started_at           # When started
completed_at         # When finished
completion_percentage # Overall progress
total_points         # Points earned
status              # enrolled, in_progress, completed, dropped
current_item        # Current item being worked on (for guided learning)
```

**Key Methods:**
```ruby
enrollment_for(user)    # Find user's enrollment
enrolled?(user)        # Check if enrolled
completion_rate_for(user)
next_module_for(user)   # What to do next
progress_summary_for(user)
```

---

## 9. LEARNING EVENTS & ANALYTICS

### LearningEvent Model
**File:** `/app/models/learning_event.rb`

**Comprehensive Event Tracking:**

**Event Types:**
- quiz_started, quiz_question_answered, quiz_completed
- lesson_started, lesson_completed
- lab_started, lab_step_completed, lab_hint_used, lab_completed
- module_started, module_completed
- course_enrolled
- review_completed
- ab_test_assigned, ab_test_metric

**Event Categories:**
- learning, assessment, practice, review, achievement, experiment

**Tracked Metadata:**
```ruby
event_type              # What happened
event_category          # Category of event
event_data              # JSON details (quiz_id, score, etc.)
skill_dimensions        # Skills being practiced
performance_score       # 0.0-1.0 performance
time_spent_seconds      # Duration
```

### LearningEventTracker Service
**File:** `/app/services/learning_event_tracker.rb`

**Convenience methods for tracking:**
```ruby
LearningEventTracker.quiz_started(user:, quiz:, context:)
LearningEventTracker.quiz_question_answered(user:, question:, answer:, correct:, time_taken:)
LearningEventTracker.quiz_completed(user:, quiz:, attempt:)
LearningEventTracker.lesson_started(user:, lesson:)
LearningEventTracker.lesson_completed(user:, lesson:, time_spent:)
```

---

## 10. ADAPTIVE & SPACED REPETITION

### A. Spaced Repetition via FSRS
**Model:** `SpacedRepetitionItem`

**For Quiz Questions:**
```ruby
user_id              # Student
item_type            # "QuizQuestion"
item_id              # Question ID
next_review_at       # When to review next
review_count         # How many times reviewed
ease_factor          # FSRS ease factor
state                # FSRS scheduling state
last_reviewed_at     # When last reviewed
```

### B. AdaptiveRetryQuizGenerator
**Generates focused practice quizzes:**
- Takes failed attempt
- Selects questions student struggled with
- Optionally includes easier warm-up questions
- Creates adaptive retry quiz with metadata
- Tracks parent_quiz_id for analytics

---

## 11. EXISTING COURSE CONTENT

### IIT JEE Mathematics (Advanced)
**Seed Files:** 
- `/db/seeds/iit_jee_mathematics_algebra.rb` (431 lines, 25 questions)
- `/db/seeds/iit_jee_mathematics_calculus.rb` (969 lines)
- `/db/seeds/iit_jee_mathematics_trigonometry.rb` (358 lines)
- `/db/seeds/iit_jee_mathematics_formulas.rb` (373 lines)

**Topics Covered:**
- Quadratic equations & roots
- Discriminant analysis
- Complex numbers
- Sequences & series
- Coordinate geometry
- Calculus (limits, derivatives, integrals)
- Trigonometric identities

**Question Format:**
```ruby
QuizQuestion.create!(
  quiz: quiz,
  question_type: 'numerical' | 'mcq' | 'equation_balance' | 'sequence',
  question_text: "...",
  correct_answer: "...",
  tolerance: 0.01,  # For numerical
  options: [...],   # For MCQ
  explanation: "Detailed explanation",
  points: 2 | 3,
  difficulty: -0.3 to 0.2,
  discrimination: 1.3,
  guessing: 0.0,
  difficulty_level: 'easy' | 'medium' | 'hard',
  topic: 'quadratic-sum-product',
  skill_dimension: 'algebra'
)
```

### IIT JEE Chemistry
**Seed Files:**
- `/db/seeds/iit_jee_inorganic_chemistry.rb`
- `/db/seeds/iit_jee_organic_chemistry_formulas.rb`
- `/db/seeds/iit_jee_physical_chemistry_formulas.rb`

**Question Types:**
- Numerical (with tolerance for decimal answers)
- MCQ (single and multiple correct - IIT JEE style)
- Equation balancing (chemical equations)
- Sequence (ordering reaction steps)

---

## 12. CONTENT DELIVERY IN VIEWS

### Lesson Display with Content Sections
```erb
<div class="lesson-content">
  <%= lesson.title %>
  <%= markdown(lesson.content) %>
  
  <% lesson.content_sections&.each do |section| %>
    <div id="<%= section['id'] %>">
      <%= markdown(section['content']) %>
    </div>
  <% end %>
</div>
```

### Quiz Results with Explanations
```erb
<% if quiz.show_correct_answers %>
  <% attempt.incorrect_questions.each do |question| %>
    <div class="question-review">
      <h5><%= question.question_text %></h5>
      <p>Your answer: <%= attempt.answer_for(question) %></p>
      <p class="text-danger">Correct: <%= question.formatted_correct_answer %></p>
      
      <% if question.explanation %>
        <div class="alert alert-info">
          <strong>Explanation:</strong> <%= question.explanation %>
        </div>
      <% end %>
      
      <!-- Lesson Recommendations from QuizQuestionLessonMapping -->
      <%= render 'lesson_recommendation_card', 
          mapping: mapping,
          question_id: question.id,
          quiz_attempt_id: attempt.id %>
      
      <!-- Mini-lesson for topic -->
      <%= render 'remediation/mini_lesson', 
          mini_lesson: mini_lesson %>
    </div>
  <% end %>
<% end %>
```

---

## 13. KEY PATTERNS & BEST PRACTICES

### Content Linking Pattern
```
Quiz Question
  ├── explanation field (direct explanation)
  └── quiz_question_lesson_mappings
      └── course_lessons (via relevance_weight)
          └── content_sections (via section_anchor)
```

### Progression Pattern
```
Lesson → Quiz → Assessment
  ↓
  Wrong Answer
  ↓
  WrongAnswerAnalyzer
  ├── classify_error
  ├── generate_progressive_feedback (3 levels)
  └── recommend_remediation
  ↓
  RemediationActivity
  ├── track_lesson_review
  ├── track_retry_result
  └── measure_effectiveness
  ↓
  Next Attempt
```

### Spaced Repetition Pattern
```
Quiz Attempt (failed)
  ↓
  schedule_spaced_repetition (callback)
  ↓
  SpacedRepetitionItem created
  ├── FSRS algorithm
  └── next_review_at scheduled
  ↓
  SpacedRepetitionService
  └── get_review_queue (urgency-sorted)
```

---

## 14. ADAPTIVE LEARNING FEATURES

### IRT-Based Difficulty Matching
**Fields in QuizQuestion:**
```ruby
difficulty       # -3 to +3 logits (student ability units)
discrimination   # 0.1 to 3.0 (item discrimination)
guessing        # 0.0 to 0.5 (pseudo-guessing parameter)
```

**Usage:**
```ruby
# Select questions near student ability
QuizQuestion.for_adaptive(ability, exclude_ids: [])
  .where('difficulty BETWEEN ? AND ?', ability - 1.5, ability + 1.5)
```

### AdaptiveRetryQuizGenerator
```ruby
generator = AdaptiveRetryQuizGenerator.new(quiz_attempt)
retry_quiz = generator.generate_retry_quiz(
  focus_ratio: 0.7,              # 70% incorrect, 30% new
  difficulty_adjustment: 'ease'  # Start easier, build up
)
```

---

## SUMMARY TABLE

| Component | Purpose | Key Files |
|-----------|---------|-----------|
| **Courses** | Organize content hierarchy | Course, CourseModule, ModuleItem |
| **Lessons** | Teach concepts | CourseLesson, content_sections |
| **Quizzes** | Assess understanding | Quiz, QuizQuestion, QuizAttempt |
| **Linking** | Connect Q→L | QuizQuestionLessonMapping |
| **Completion** | Track progress | LessonCompletion, ModuleProgress |
| **Feedback** | Explain answers | WrongAnswerAnalyzer, explanation field |
| **Remediation** | Fix misconceptions | RemediationActivity, RemediationTrackingService |
| **Progression** | Guide learning | StudyPlan, CourseEnrollment |
| **Events** | Analytics | LearningEvent, LearningEventTracker |
| **Spaced Rep** | Long-term retention | SpacedRepetitionItem, FSRS algorithm |

