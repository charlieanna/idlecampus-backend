# User Progress Tracking & Review System

## Overview

This system tracks user progress through courses and automatically generates review sessions when users return after a period of inactivity. It solves the problem of users losing their place and forgetting content when they return to a course.

## Key Features

1. **Progress Persistence**: Users always resume from where they left off
2. **Time-Gap Detection**: Tracks how long users have been away
3. **Automatic Review Sessions**: Generates review content based on absence duration
4. **Smart Resume Points**: Shows review sessions or continuation points as appropriate

## Database Changes

### New Fields on `course_enrollments` Table

```ruby
- last_accessed_at (datetime) - When user last visited the course
- needs_review (boolean) - Whether user needs a review session
- time_away_days (integer) - How many days user has been away
- last_completed_item_type (string) - Type of last completed item
- last_completed_item_id (bigint) - ID of last completed item
```

### New `review_sessions` Table

```ruby
- user_id (references users)
- course_enrollment_id (references course_enrollments)
- course_id (references courses)
- days_since_last_visit (integer)
- review_type (string) - Type of review: quick_refresh, comprehensive_review, forgotten_content
- items_to_review (jsonb) - Array of items user should review
- review_modules (jsonb) - Generated review content
- items_reviewed (integer) - Progress tracking
- total_items (integer)
- completed (boolean)
- started_at, completed_at (datetime)
- time_spent_seconds (integer)
```

## Review Types Based on Time Away

| Days Away | Review Type | Description |
|-----------|-------------|-------------|
| 0-2 | None | Recent activity, continue normally |
| 3-7 | Quick Refresh | Brief recap of key concepts (5-10 items) |
| 8-14 | Comprehensive Review | Thorough review session (15-20 items) |
| 15+ | Forgotten Content | Extensive review with exercises (20-25 items) |

## API Endpoints

### 1. Get Course Progress (Enhanced)
```
GET /api/v1/courses/:slug/progress
Headers: X-User-Id: <user_id>
```

**Response:**
```json
{
  "enrolled": true,
  "status": "in_progress",
  "completion_percentage": 45,
  "total_points": 120,
  "last_accessed_at": "2025-11-05T10:30:00Z",
  "days_since_last_access": 5,
  "course": {
    "slug": "docker-fundamentals",
    "title": "Docker Fundamentals"
  },
  "resume_point": {
    "type": "review_session",
    "review_type": "quick_refresh",
    "message": "Welcome back! It's been 5 days. Let's do a quick refresh before continuing."
  },
  "review_status": {
    "needs_review": true,
    "review_type": "quick_refresh",
    "message": "Welcome back! It's been 5 days. Let's do a quick refresh before continuing."
  },
  "current_position": {
    "current_item": {
      "type": "InteractiveLearningUnit",
      "id": 123,
      "title": "Docker Volumes",
      "slug": "docker-volumes"
    },
    "current_module": {
      "id": 45,
      "title": "Data Persistence",
      "progress": {
        "status": "in_progress",
        "completion_percentage": 60
      }
    }
  }
}
```

### 2. Track Course Access
```
POST /api/v1/courses/:slug/track_access
Headers: X-User-Id: <user_id>
```

**Purpose:** Call this when user accesses a course to update `last_accessed_at`

**Response:**
```json
{
  "message": "Access tracked",
  "last_accessed_at": "2025-11-10T12:00:00Z",
  "needs_review": false
}
```

### 3. Get Resume Point
```
GET /api/v1/courses/:slug/resume_point
Headers: X-User-Id: <user_id>
```

**Response:**
```json
{
  "resume_point": {
    "type": "review_session",
    "review_type": "comprehensive_review",
    "message": "It's been 10 days since your last visit. We recommend a review session to refresh your memory."
  },
  "days_since_last_access": 10
}
```

### 4. Create Review Session
```
POST /api/v1/courses/:slug/review_session
Headers: X-User-Id: <user_id>
```

**Response:**
```json
{
  "message": "Review session created",
  "review_session": {
    "id": 456,
    "review_type": "quick_refresh",
    "days_since_last_visit": 5,
    "total_items": 8,
    "review_modules": [
      {
        "type": "recap",
        "title": "Quick Recap",
        "description": "A quick review of key concepts you've learned",
        "estimated_minutes": 5,
        "content": {
          "format": "summary",
          "sections": [...]
        }
      },
      {
        "type": "quiz",
        "title": "Quick Concept Check",
        "description": "Test your memory with a few key questions",
        "estimated_minutes": 5,
        "question_count": 5,
        "passing_score": 60
      }
    ],
    "items_to_review": [
      {
        "type": "InteractiveLearningUnit",
        "id": 100,
        "title": "Container Basics",
        "priority": 15
      },
      ...
    ]
  }
}
```

## Usage Flow

### Frontend Implementation

```javascript
// 1. When user opens a course
async function openCourse(courseSlug, userId) {
  // Track access
  await fetch(`/api/v1/courses/${courseSlug}/track_access`, {
    method: 'POST',
    headers: { 'X-User-Id': userId }
  });

  // Get progress and resume point
  const response = await fetch(`/api/v1/courses/${courseSlug}/progress`, {
    headers: { 'X-User-Id': userId }
  });
  const data = await response.json();

  // Check if review is needed
  if (data.resume_point.type === 'review_session') {
    // Show review session UI
    showReviewPrompt(data.review_status.message);

    // If user accepts review
    const reviewSession = await createReviewSession(courseSlug, userId);
    showReviewContent(reviewSession);
  } else if (data.resume_point.type === 'resume') {
    // Continue from where they left off
    navigateToItem(data.resume_point.item);
  } else {
    // Start from beginning
    startCourse();
  }
}

// 2. Create review session
async function createReviewSession(courseSlug, userId) {
  const response = await fetch(`/api/v1/courses/${courseSlug}/review_session`, {
    method: 'POST',
    headers: { 'X-User-Id': userId }
  });
  return await response.json();
}
```

## Services

### ProgressTrackerService

Handles all progress tracking operations:

```ruby
tracker = ProgressTrackerService.new(user, course_or_enrollment)

# Track access
tracker.track_access!

# Track item completion
tracker.track_completion!(item)

# Get resume point
tracker.get_resume_point
# => { type: 'review_session', review_type: 'quick_refresh', ... }

# Get full progress details
tracker.get_progress_details
# => { enrollment: {...}, current_position: {...}, review_status: {...}, ... }

# Check if review needed
tracker.should_show_review?
# => true/false

# Create review session
tracker.create_review_session_if_needed
# => ReviewSession object
```

### ReviewModuleGenerator

Generates dynamic review content based on what user has learned:

```ruby
generator = ReviewModuleGenerator.new(enrollment, 'quick_refresh')
result = generator.generate

# Returns:
# {
#   items: [ array of items to review ],
#   modules: [ generated review modules ]
# }
```

## Model Methods

### CourseEnrollment

```ruby
enrollment = CourseEnrollment.find(...)

# Track access
enrollment.touch_access!

# Record item completion
enrollment.record_item_completion!(item)

# Calculate time away
enrollment.calculate_time_away
# => 5 (days)

# Check if review needed
enrollment.check_review_needed!
# => true/false

# Get review type needed
enrollment.review_type_needed
# => 'quick_refresh', 'comprehensive_review', or 'forgotten_content'

# Get resume point
enrollment.resume_point
# => { type: ..., message: ..., ... }

# Get review message
enrollment.review_message
# => "Welcome back! It's been 5 days. Let's do a quick refresh..."
```

### ReviewSession

```ruby
session = ReviewSession.find(...)

# Start session
session.start!

# Record item reviewed
session.record_item_reviewed!

# Complete session
session.complete!

# Get progress
session.progress_percentage
# => 60
```

## Running the Migrations

```bash
# Run migrations to add new fields and tables
rails db:migrate

# Or with bundle exec
bundle exec rails db:migrate
```

## Testing the System

### 1. Test Basic Progress Tracking

```ruby
user = User.first
course = Course.find_by(slug: 'docker-fundamentals')

# Enroll user
enrollment = CourseEnrollment.create!(
  user: user,
  course: course,
  status: 'enrolled'
)

# Simulate user accessing course
enrollment.touch_access!
enrollment.last_accessed_at
# => current time

# Simulate time passing (in console)
enrollment.update_column(:last_accessed_at, 5.days.ago)

# Check if review needed
enrollment.check_review_needed!
# => true

enrollment.review_type_needed
# => 'quick_refresh'
```

### 2. Test Review Session Generation

```ruby
# Create review session
tracker = ProgressTrackerService.new(user, enrollment)
review_session = tracker.create_review_session_if_needed

# Check generated content
review_session.review_modules
review_session.items_to_review
review_session.total_items
```

### 3. Test API Endpoints

```bash
# Get progress
curl -X GET http://localhost:3000/api/v1/courses/docker-fundamentals/progress \
  -H "X-User-Id: 1"

# Track access
curl -X POST http://localhost:3000/api/v1/courses/docker-fundamentals/track_access \
  -H "X-User-Id: 1"

# Get resume point
curl -X GET http://localhost:3000/api/v1/courses/docker-fundamentals/resume_point \
  -H "X-User-Id: 1"

# Create review session
curl -X POST http://localhost:3000/api/v1/courses/docker-fundamentals/review_session \
  -H "X-User-Id: 1"
```

## Best Practices

### 1. Call track_access! on every course visit
```ruby
# In your controller or before_action
def track_course_access
  if @enrollment
    tracker = ProgressTrackerService.new(current_user, @enrollment)
    tracker.track_access!
  end
end
```

### 2. Update current_item as user progresses
```ruby
# When user completes an item
enrollment.set_next_current_item!(completed_item)
```

### 3. Show review prompts in the UI
```javascript
// Check resume point and show appropriate UI
if (resumePoint.type === 'review_session') {
  showReviewModal({
    message: resumePoint.message,
    reviewType: resumePoint.review_type,
    onAccept: () => startReviewSession(),
    onSkip: () => continueFromCurrentItem()
  });
}
```

### 4. Track review session completion
```ruby
# When user completes review
review_session.complete!

# This will:
# - Set completed = true
# - Set completed_at timestamp
# - Clear needs_review flag on enrollment
```

## Future Enhancements

1. **Adaptive Review**: Adjust review content based on user's mastery scores
2. **Spaced Repetition**: Integrate with existing spaced repetition system
3. **Review Scheduling**: Allow users to schedule review sessions
4. **Review Analytics**: Track review session effectiveness
5. **Mobile Notifications**: Remind users to review when they've been away
6. **Personalized Messages**: Customize review prompts based on user behavior

## Troubleshooting

### Review session not showing
- Check that `last_accessed_at` is set
- Verify user has made progress (completion_percentage > 0)
- Ensure at least 3 days have passed since last visit

### Items not appearing in review
- Verify user has completed items (check lesson_completions, learning_unit_progresses)
- Check that items are properly associated with modules
- Look at ReviewModuleGenerator logs for item collection

### Progress not saving
- Ensure `track_access!` is being called
- Check that `current_item` is being updated on completion
- Verify enrollment exists for user+course combination
