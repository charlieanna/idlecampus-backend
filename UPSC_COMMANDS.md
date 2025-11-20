# UPSC Platform - Quick Command Reference

## Setup Commands

```bash
# 1. Run migrations
rails db:migrate

# 2. Load seed data
rails runner db/seeds/upsc_seeds.rb

# 3. Open console
rails console

# 4. Check database
rails dbconsole
\dt upsc_*  # List all UPSC tables
```

## Verification Commands

```bash
# Check record counts
rails runner "
puts 'Subjects: ' + Upsc::Subject.count.to_s
puts 'Topics: ' + Upsc::Topic.count.to_s
puts 'Questions: ' + Upsc::Question.count.to_s
puts 'Tests: ' + Upsc::Test.count.to_s
puts 'Writing Questions: ' + Upsc::WritingQuestion.count.to_s
puts 'News Articles: ' + Upsc::NewsArticle.count.to_s
"
```

## Rails Console Examples

### Subjects
```ruby
# Get all subjects
Upsc::Subject.all

# Prelims subjects
Upsc::Subject.prelims

# Mains subjects
Upsc::Subject.mains

# Optional subjects
Upsc::Subject.optional

# Specific subject
prelims_gs = Upsc::Subject.find_by(code: 'PRELIMS_GS')
prelims_gs.name
prelims_gs.total_marks
```

### Topics
```ruby
# Root topics
Upsc::Topic.root_topics

# High-yield topics
Upsc::Topic.high_yield

# Specific topic with children
history = Upsc::Topic.find_by(slug: 'indian-history')
history.child_topics
history.full_path

# Topic hierarchy
topic = Upsc::Topic.find_by(slug: 'modern-india')
topic.parent_topic.name  # => "Indian History"
```

### Questions
```ruby
# All questions
Upsc::Question.all

# By difficulty
Upsc::Question.by_difficulty('easy')
Upsc::Question.by_difficulty('medium')
Upsc::Question.by_difficulty('hard')

# Previous Year Questions
Upsc::Question.pyqs

# By subject
subject = Upsc::Subject.find_by(code: 'PRELIMS_GS')
Upsc::Question.by_subject(subject.id)

# Question details
q = Upsc::Question.first
q.question_text
q.options
q.correct_answer
q.explanation
q.is_pyq?
q.accuracy_percentage
```

### Tests
```ruby
# Live tests
Upsc::Test.live

# Upcoming tests
Upsc::Test.upcoming

# Specific test
test = Upsc::Test.first
test.title
test.duration_minutes
test.total_marks
test.questions.count
test.questions_count
```

### Mock Test Simulation
```ruby
# Get or create test user
user = User.first_or_create!(email: 'test@upsc.com')

# Create student profile
profile = user.create_upsc_student_profile!(
  target_exam_date: 1.year.from_now,
  attempt_number: 1,
  medium_of_exam: 'english',
  study_hours_per_day: 8
)

# Start a test
test = Upsc::Test.first
attempt = user.upsc_user_test_attempts.create!(
  upsc_test: test,
  started_at: Time.current
)

# Submit answers
test.questions.each_with_index do |question, index|
  # Simulate answering (B for first, A for rest)
  answer = index == 0 ? 'B' : 'A'
  time_spent = rand(30..120)  # Random time between 30-120 seconds
  attempt.submit_answer(question.id, answer, time_spent)
end

# Submit test
attempt.submit_test!

# Check results
puts "Score: #{attempt.score}/#{test.total_marks}"
puts "Percentage: #{attempt.percentage}%"
puts "Correct: #{attempt.correct_answers}"
puts "Wrong: #{attempt.wrong_answers}"
puts "Unanswered: #{attempt.unanswered}"
puts "Time taken: #{attempt.time_taken_minutes} minutes"

# View analysis
attempt.analysis
```

### Writing Questions
```ruby
# Daily questions
Upsc::WritingQuestion.for_date(Date.current)

# By type
Upsc::WritingQuestion.by_type('essay')
Upsc::WritingQuestion.by_type('case_study')

# PYQs
Upsc::WritingQuestion.pyqs

# Question details
wq = Upsc::WritingQuestion.first
wq.question_text
wq.word_limit
wq.marks
wq.key_points
wq.suggested_structure
```

### Answer Submission
```ruby
# Submit an answer
user = User.first
writing_q = Upsc::WritingQuestion.first

answer = user.upsc_user_answers.create!(
  upsc_writing_question: writing_q,
  answer_text: "This is my answer to the question... [your answer text]",
  submission_type: 'typed',
  submitted_at: Time.current
)

answer.word_count  # Automatically calculated
answer.status
```

### Current Affairs
```ruby
# Today's news
Upsc::NewsArticle.daily_news

# This week's news
Upsc::NewsArticle.weekly_roundup(0)  # 0 = current week

# Featured articles
Upsc::NewsArticle.featured

# By category
Upsc::NewsArticle.by_category('economy')
Upsc::NewsArticle.by_category('polity')

# High relevance
Upsc::NewsArticle.high_relevance

# Article details
article = Upsc::NewsArticle.first
article.title
article.summary
article.categories
article.key_points
article.exam_perspective
```

### Study Plan
```ruby
# Create study plan
user = User.first
plan = user.upsc_study_plans.create!(
  plan_name: "My UPSC 2026 Preparation",
  start_date: Date.current,
  target_exam_date: Date.current + 365,
  is_active: true
)

plan.total_days
plan.days_remaining
plan.current_phase
plan.phase_breakdown
```

### Daily Tasks
```ruby
# Today's tasks
user = User.first
Upsc::DailyTask.today.where(user: user)

# Create a task
task = user.upsc_daily_tasks.create!(
  task_date: Date.current,
  task_type: 'study',
  title: 'Complete Modern History Chapter 1',
  estimated_minutes: 120,
  priority: 'high'
)

# Complete a task
task.mark_complete(110)  # Took 110 minutes

# Today's summary
Upsc::DailyTask.today_summary(user)
```

### Spaced Repetition
```ruby
# Schedule revision
user = User.first
topic = Upsc::Topic.first

Upsc::Revision.schedule_next_revision(user, topic, 4)  # 4 = good performance

# Today's revisions
user.upsc_revisions.due_today

# Overdue revisions
user.upsc_revisions.overdue

# Complete a revision
revision = user.upsc_revisions.pending.first
revision.mark_complete(4, 45)  # Rating: 4/5, Time: 45 minutes
```

### User Progress
```ruby
# Get user's progress
user = User.first
topic = Upsc::Topic.first

progress = user.upsc_user_progress.find_or_create_by!(upsc_topic: topic)

# Update progress
progress.start!
progress.update_progress(50)  # 50% complete
progress.mark_complete!

# Track revision
progress.record_revision

# Check status
progress.status
progress.completion_percentage
progress.needs_revision?
progress.time_since_last_access
```

## Adding More Content

### Add a Subject
```ruby
Upsc::Subject.create!(
  name: "Public Administration (Optional)",
  code: "OPT_PUBLIC_ADMIN",
  exam_type: "mains",
  total_marks: 500,
  is_optional: true,
  is_active: true,
  order_index: 10,
  color_code: "#9333EA"
)
```

### Add Topics
```ruby
subject = Upsc::Subject.find_by(code: 'PRELIMS_GS')

topic = subject.topics.create!(
  name: "Indian Art & Culture",
  slug: "art-culture",
  description: "Dance, Music, Architecture, Literature",
  difficulty_level: "intermediate",
  estimated_hours: 50,
  is_high_yield: true,
  pyq_frequency: 18,
  order_index: 8
)

# Add sub-topics
topic.child_topics.create!(
  upsc_subject_id: subject.id,
  name: "Classical Dances",
  slug: "classical-dances",
  difficulty_level: "beginner",
  estimated_hours: 10,
  tags: ["bharatanatyam", "kathak", "odissi"]
)
```

### Add Questions
```ruby
Upsc::Question.create!(
  upsc_subject: Upsc::Subject.find_by(code: 'PRELIMS_GS'),
  question_type: 'mcq',
  difficulty: 'medium',
  marks: 2,
  negative_marks: 0.66,
  question_text: "Which of the following is a classical dance form from Kerala?",
  options: [
    {id: 'A', text: 'Kathakali', is_correct: true},
    {id: 'B', text: 'Bharatanatyam', is_correct: false},
    {id: 'C', text: 'Kathak', is_correct: false},
    {id: 'D', text: 'Odissi', is_correct: false}
  ],
  correct_answer: 'A',
  explanation: "Kathakali is a classical dance-drama form originating from Kerala.",
  tags: ["art_culture", "dance"],
  relevance_score: 75,
  status: 'active'
)
```

### Add News Article
```ruby
Upsc::NewsArticle.create!(
  title: "India Launches New Space Mission",
  slug: "india-space-mission-2025",
  summary: "ISRO successfully launched a new satellite mission...",
  full_content: "Detailed content here...",
  source: "ISRO",
  published_date: Date.current,
  categories: ["science_tech", "space"],
  tags: ["isro", "satellite", "technology"],
  relevance_score: 85,
  importance_level: "medium",
  exam_perspective: "Important for GS3 - Science & Technology",
  key_points: [
    "New satellite launched",
    "Advanced communication capabilities",
    "India's space program progress"
  ],
  status: 'published'
)
```

## Useful Queries

```ruby
# Total questions by difficulty
Upsc::Question.group(:difficulty).count

# Topics by difficulty
Upsc::Topic.group(:difficulty_level).count

# Tests by type
Upsc::Test.group(:test_type).count

# News by category
Upsc::NewsArticle.published.group(:importance_level).count

# User test performance over time
user = User.first
user.upsc_user_test_attempts.submitted.order(:submitted_at).pluck(:submitted_at, :score)

# Topic completion rate
user = User.first
completed = user.upsc_user_progress.completed.count
total = Upsc::Topic.count
completion_rate = (completed.to_f / total * 100).round(2)
```

## Cleanup Commands (Use Carefully!)

```ruby
# Delete all UPSC data (WARNING: Irreversible!)
Upsc::UserProgress.delete_all
Upsc::Revision.delete_all
Upsc::DailyTask.delete_all
Upsc::StudyPlan.delete_all
Upsc::UserAnswer.delete_all
Upsc::UserTestAttempt.delete_all
Upsc::TestQuestion.delete_all
Upsc::Test.delete_all
Upsc::WritingQuestion.delete_all
Upsc::Question.delete_all
Upsc::NewsArticle.delete_all
Upsc::Topic.delete_all
Upsc::StudentProfile.delete_all
Upsc::Subject.delete_all

# Then re-run seeds
rails runner db/seeds/upsc_seeds.rb
```

## Rollback Migrations (If Needed)

```bash
# Rollback last migration
rails db:rollback

# Rollback multiple migrations
rails db:rollback STEP=14  # Rollback last 14 UPSC migrations

# Check migration status
rails db:migrate:status

# Re-run migrations
rails db:migrate
```
