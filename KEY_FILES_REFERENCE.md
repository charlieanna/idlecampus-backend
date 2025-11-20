# Quick Reference: Key Files for Teaching & Learning

## CRITICAL LINKING MODELS

| File | Purpose | Key Fields |
|------|---------|-----------|
| `/app/models/quiz_question_lesson_mapping.rb` | **Core linking** between quiz questions and lessons | quiz_question_id, course_lesson_id, relevance_weight, section_anchor |
| `/app/models/course_lesson.rb` | Modern lesson model with content sections | title, content, video_url, content_sections (JSONB), key_concepts |
| `/app/models/quiz_question.rb` | Questions with explanation and adaptive metadata | question_type, explanation, difficulty, discrimination, guessing |
| `/app/models/quiz_attempt.rb` | Tracks each quiz attempt and score | score, correct_answers, answers (JSON), passed, attempt_number |

## REMEDIATION & FEEDBACK

| File | Purpose | Key Feature |
|------|---------|------------|
| `/app/services/remediation_tracking_service.rb` | Tracks remediation effectiveness | track_lesson_review, evaluate_remediation_effectiveness, get_recommended_reviews |
| `/app/services/wrong_answer_analyzer.rb` | Progressive feedback generation | 3-level feedback + solution, error classification |
| `/app/models/remediation_activity.rb` | Records when users review lessons | lesson_reviewed, improved_on_retry flags |
| `/app/services/mini_lesson_generator.rb` | Generates contextual mini-lessons | Topic-based explanations with examples |

## LEARNING PROGRESSION & TRACKING

| File | Purpose | Key Fields |
|------|---------|-----------|
| `/app/models/study_plan.rb` | Personalized learning paths | daily_target, milestones, progress_percentage, status |
| `/app/models/lesson_completion.rb` | Records lesson completions | user_id, course_lesson_id, completed_at |
| `/app/models/module_progress.rb` | Tracks module progress | completion_percentage, items_completed, status |
| `/app/models/course_enrollment.rb` | Tracks course enrollment | completion_percentage, total_points, current_item |
| `/app/models/learning_event.rb` | Analytics event tracking | event_type, event_category, event_data (JSON), skill_dimensions |

## SPACED REPETITION & ADAPTIVE

| File | Purpose | Key Feature |
|------|---------|------------|
| `/app/models/spaced_repetition_item.rb` | FSRS scheduling for reviews | next_review_at, ease_factor, review_count |
| `/app/services/spaced_repetition_service.rb` | Manages review queue | schedule_review, get_review_queue, get_items_by_criteria |
| `/app/services/adaptive_practice_service.rb` | Question selection based on ability | select_next_question, submit_answer |
| `/app/services/adaptive_content_selector.rb` | Prioritizes content by urgency | 10 priority levels from critical to new content |

## CONTROLLERS (ENTRY POINTS)

| File | Actions | Purpose |
|------|---------|---------|
| `/app/controllers/course_lessons_controller.rb` | show, complete | Display lessons and track completion |
| `/app/controllers/quizzes_controller.rb` | show, start, submit, result | Quiz delivery and result handling |
| `/app/controllers/remediation_controller.rb` | track_lesson_review, mini_lesson | Remediation tracking and feedback |
| `/app/controllers/quiz_attempts_controller.rb` | adaptive_retry | Generate adaptive retry quizzes |
| `/app/controllers/adaptive_practice_controller.rb` | - | Adaptive question selection |

## DATABASE MIGRATIONS (Schema)

| Migration | Tables | Purpose |
|-----------|--------|---------|
| `20251030020100_create_course_system.rb` | courses, course_modules, course_lessons, quizzes, quiz_questions, module_items | Core course hierarchy |
| `20251030211840_create_quiz_question_lesson_mappings.rb` | quiz_question_lesson_mappings | Link questions to lessons |
| `20251030211844_create_remediation_activities.rb` | remediation_activities | Track remediation |
| `20251030020200_create_lesson_completions.rb` | lesson_completions | Track lesson completion |
| `20251030211847_add_content_sections_to_course_lesson.rb` | course_lessons.content_sections | Structured lesson sections (JSONB) |

## EXISTING COURSE CONTENT

| Seed File | Topic | Content Level | Questions |
|-----------|-------|--------|-----------|
| `iit_jee_mathematics_algebra.rb` | Quadratic equations, complex numbers | Advanced | 25+ |
| `iit_jee_mathematics_calculus.rb` | Limits, derivatives, integrals | Advanced | 40+ |
| `iit_jee_mathematics_trigonometry.rb` | Trig identities and equations | Advanced | 20+ |
| `iit_jee_inorganic_chemistry.rb` | Periodic table, bonding, d-block | Advanced | 100+ |
| `iit_jee_organic_chemistry_formulas.rb` | Organic reactions, mechanisms | Advanced | 50+ |
| `iit_jee_physical_chemistry_formulas.rb` | Electrochemistry, solutions | Advanced | 50+ |

---

## QUESTION TYPE SUPPORT

### Standard Types (all quizzes)
- **mcq** - Multiple choice (single or multiple correct)
- **fill_blank** - Fill in the blank text
- **true_false** - Boolean questions
- **command** - Command-based questions (Docker, Kubernetes, etc.)

### Subject-Specific Types
- **numerical** - Math with tolerance range (for IIT JEE Math/Chemistry)
- **equation_balance** - Chemical equations (Chemistry)
- **sequence** - Order items correctly (Chemistry reaction steps)

---

## KEY ADAPTIVE FEATURES

### IRT Parameters in QuizQuestion
```
difficulty: -3.0 to +3.0     # Question difficulty (logits)
discrimination: 0.1 to 3.0   # Ability to discriminate levels
guessing: 0.0 to 0.5         # Pseudo-guessing probability
```

### Content Matching Mechanism
```
Quiz Question (failed)
    ↓
quiz_question_lesson_mappings
    ↓
CourseLesson (sorted by relevance_weight)
    ↓
content_sections (via section_anchor anchor)
    ↓
Deep-linked to specific section
```

---

## WORKFLOW EXAMPLES

### Quiz → Feedback Flow
1. Student submits quiz answers
2. QuizAttempt.submit! calculates score
3. For each incorrect question:
   - Get question.explanation
   - Find QuizQuestionLessonMapping (sorted by relevance_weight)
   - Get recommended lesson + section_anchor
   - Generate WrongAnswerAnalyzer feedback (3 levels)
   - Generate MiniLessonGenerator contextual lesson
   - Create RemediationActivity record
4. Add questions to SpacedRepetitionItem queue
5. Show results with explanations and recommendations

### Remediation Tracking Flow
1. Student views lesson after failing question
2. RemediationTrackingService.track_lesson_review called
3. RemediationActivity marked as lesson_reviewed = true
4. Student takes retry quiz
5. RemediationTrackingService.track_retry_result compares answers
6. Evaluates if student improved on originally wrong questions
7. RemediationActivity.improved_on_retry set if performance improved
8. effectiveness_rate calculated: (improved / total_reviewed * 100)

### Spaced Repetition Flow
1. Quiz attempt fails
2. QuizAttempt callback: schedule_spaced_repetition
3. For each incorrect question:
   - Create SpacedRepetitionItem with FSRS schedule
   - Calculate next_review_at (typically 1 day)
4. SpacedRepetitionService generates review queue
5. Questions ranked by urgency (overdue > due today > new reviews)
6. Student reviews, FSRS ease_factor updated
7. Next review date recalculated

---

## NO GRE CONTENT FOUND

Search Results:
- No GRE, GMAT, Quantitative, or Verbal content in codebase
- No GRE-specific models or controllers
- System is ready to add GRE content (seeds, courses, questions)
- Would integrate with existing QuizQuestion/QuestionLesson mapping system

---

## SUGGESTED GRE INTEGRATION POINTS

1. Create seed files for GRE courses
   - GRE Quantitative (Algebra, Arithmetic, Geometry, Data Analysis)
   - GRE Verbal (Reading Comprehension, Text Completion, Sentence Equivalence)
   
2. Create CourseLesson content for each topic
   - Use content_sections for structured explanations
   - Link key concepts to formulas and theorems
   
3. Create QuizQuestion objects with IRT metadata
   - difficulty calibrated to GRE standards (-1.5 to +1.5)
   - discrimination values based on past GRE data
   
4. Map questions to lessons via QuizQuestionLessonMapping
   - Set relevance_weight (0-100)
   - Use section_anchor for deep linking
   
5. Create lesson explanations and hints
   - Use explanation field for detailed walkthrough
   - Use WrongAnswerAnalyzer for progressive feedback
   - Use MiniLessonGenerator for quick refreshers

