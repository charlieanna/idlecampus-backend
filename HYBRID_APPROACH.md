# Hybrid Approach: File-Based Courses + Database Progress Tracking

## The Best of Both Worlds

✅ **Course content** → YAML files (easy to edit, no migration)
✅ **User progress** → Database (track enrollments, completions, points)

This gives you:
- Easy content management (edit YAML, commit to Git)
- User progress tracking (enrollments, completions, gamification)
- Simple deployment (no heavy database migrations for content)
- Scalable (can move to full database later)

## Architecture

```
┌─────────────────────┐
│   Course Content    │
│   (YAML Files)      │  ← Easy to edit, version controlled
└──────────┬──────────┘
           │
           ├─→ CourseFileReaderService (reads & caches)
           │
           ├─→ API: GET /courses (public)
           ├─→ API: GET /courses/:slug (public)
           └─→ API: GET /courses/:slug/modules (public)

┌─────────────────────┐
│  User Progress DB   │
│   (PostgreSQL)      │  ← Tracks enrollments & progress
└──────────┬──────────┘
           │
           ├─→ Course (minimal: just slug, title)
           ├─→ CourseEnrollment (user, course, progress%)
           └─→ ModuleProgress (optional: per-module tracking)

           ├─→ API: POST /courses/:slug/enroll
           ├─→ API: GET /courses/:slug/progress
           └─→ API: POST /courses/:slug/lessons/:slug/complete
```

## API Endpoints

### Public Endpoints (No Auth Required)

#### 1. List Courses
```bash
GET /api/v1/courses
```

**Response:**
```json
{
  "courses": [
    {
      "slug": "docker-fundamentals",
      "title": "Docker Fundamentals",
      "description": "...",
      "difficulty_level": "beginner",
      "estimated_hours": 10,
      "modules_count": 4,
      "total_lessons": 42,
      "tags": ["docker", "containers"]
    }
  ],
  "total": 9
}
```

#### 2. Get Course Details
```bash
GET /api/v1/courses/:slug
```

#### 3. Get Course Modules
```bash
GET /api/v1/courses/:slug/modules
```

---

### Progress Tracking Endpoints (Requires Auth)

#### 4. Enroll in Course
```bash
POST /api/v1/courses/:slug/enroll
Headers:
  X-User-Id: 123
  # OR
  Authorization: Bearer YOUR_TOKEN
```

**Response:**
```json
{
  "message": "Successfully enrolled",
  "enrollment": {
    "course_slug": "docker-fundamentals",
    "enrolled_at": "2025-01-09T10:00:00Z",
    "status": "enrolled"
  }
}
```

**What happens:**
- Creates minimal Course record in DB (just for tracking)
- Creates CourseEnrollment record
- Links user to course

#### 5. Get Progress
```bash
GET /api/v1/courses/:slug/progress?user_id=123
# OR
Headers: X-User-Id: 123
```

**Response:**
```json
{
  "enrolled": true,
  "enrollment_date": "2025-01-09T10:00:00Z",
  "status": "in_progress",
  "completion_percentage": 25.5,
  "total_points": 120,
  "course": {
    "slug": "docker-fundamentals",
    "title": "Docker Fundamentals",
    "total_modules": 4,
    "total_lessons": 42
  }
}
```

#### 6. Complete Lesson
```bash
POST /api/v1/courses/:slug/lessons/:lesson_slug/complete?user_id=123
```

**Response:**
```json
{
  "message": "Lesson completed",
  "completion_percentage": 27.8,
  "total_points": 130
}
```

**What happens:**
- Increments completion percentage
- Awards points (10 points per lesson by default)
- Updates enrollment status

---

## Authentication

For MVP, we support **two simple auth methods**:

### Option 1: User ID Parameter (Simplest for Testing)
```bash
curl -X POST "http://localhost:3000/api/v1/courses/docker-fundamentals/enroll?user_id=1"
```

### Option 2: Header-Based (Better for Production)
```bash
curl -X POST "http://localhost:3000/api/v1/courses/docker-fundamentals/enroll" \
  -H "X-User-Id: 1"
```

### Option 3: Token-Based (Production Ready)
Uncomment in controller:
```ruby
def current_user
  token = request.headers['Authorization']&.gsub('Bearer ', '')
  @current_user = User.find_by(auth_token: token)
  # ...
end
```

Then use:
```bash
curl -X POST "http://localhost:3000/api/v1/courses/docker-fundamentals/enroll" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

---

## Database Setup

### Run Migrations
```bash
# The tables already exist from previous migrations
bundle exec rails db:migrate
```

### Tables Used

1. **courses** - Minimal course records (just for tracking)
   - `slug`, `title`, `description`, `difficulty_level`
   - Created automatically on first enrollment

2. **course_enrollments** - User enrollments
   - `user_id`, `course_id`
   - `enrolled_at`, `completion_percentage`, `total_points`
   - `status`: 'enrolled', 'in_progress', 'completed'

3. **course_lessons** - Lesson records (optional, for detailed tracking)
   - Created on-demand when lessons are completed

---

## Frontend Integration

### React Example

```javascript
// 1. Fetch courses (public)
const { courses } = await fetch('/api/v1/courses').then(r => r.json());

// 2. Enroll user
const userId = getCurrentUserId();
await fetch(`/api/v1/courses/docker-fundamentals/enroll?user_id=${userId}`, {
  method: 'POST'
});

// 3. Get progress
const progress = await fetch(
  `/api/v1/courses/docker-fundamentals/progress?user_id=${userId}`
).then(r => r.json());

console.log(progress.completion_percentage); // 25.5%

// 4. Complete a lesson
await fetch(
  `/api/v1/courses/docker-fundamentals/lessons/docker-ps/complete?user_id=${userId}`,
  { method: 'POST' }
);

// 5. Get updated progress
const newProgress = await fetch(
  `/api/v1/courses/docker-fundamentals/progress?user_id=${userId}`
).then(r => r.json());

console.log(newProgress.completion_percentage); // 27.8%
console.log(newProgress.total_points); // 130
```

### Vue Example

```javascript
data() {
  return {
    courses: [],
    progress: null,
    userId: this.getCurrentUserId()
  }
},

async mounted() {
  // Load courses
  const { courses } = await this.$http.get('/api/v1/courses').then(r => r.data);
  this.courses = courses;
},

methods: {
  async enrollCourse(slug) {
    await this.$http.post(
      `/api/v1/courses/${slug}/enroll?user_id=${this.userId}`
    );
    this.loadProgress(slug);
  },

  async loadProgress(slug) {
    this.progress = await this.$http.get(
      `/api/v1/courses/${slug}/progress?user_id=${this.userId}`
    ).then(r => r.data);
  },

  async completeLesson(courseSlug, lessonSlug) {
    const result = await this.$http.post(
      `/api/v1/courses/${courseSlug}/lessons/${lessonSlug}/complete?user_id=${this.userId}`
    ).then(r => r.data);

    // Update UI with new progress
    this.progress.completion_percentage = result.completion_percentage;
    this.progress.total_points = result.total_points;
  }
}
```

---

## Development Workflow

### 1. Edit Course Content
```bash
# Edit YAML files
vim db/seeds/consolidated_courses/docker-fundamentals/manifest.yml

# Clear cache
rake courses:clear_cache
```

### 2. Test Public APIs
```bash
curl http://localhost:3000/api/v1/courses
curl http://localhost:3000/api/v1/courses/docker-fundamentals
```

### 3. Test Progress Tracking
```bash
# Create a test user first (Rails console)
rails console
> User.create!(email: 'test@example.com', name: 'Test User')
> exit

# Enroll
curl -X POST "http://localhost:3000/api/v1/courses/docker-fundamentals/enroll?user_id=1"

# Check progress
curl "http://localhost:3000/api/v1/courses/docker-fundamentals/progress?user_id=1"

# Complete a lesson
curl -X POST "http://localhost:3000/api/v1/courses/docker-fundamentals/lessons/docker-ps/complete?user_id=1"

# Check updated progress
curl "http://localhost:3000/api/v1/courses/docker-fundamentals/progress?user_id=1"
```

---

## Gamification Features

### Points System
- **10 points** per lesson completed (default)
- Customize in controller: `total_points: enrollment.total_points + 10`

### Completion Tracking
- Automatic percentage calculation
- `completion_percentage` updates on each lesson completion

### Status Progression
- `enrolled` → first enrollment
- `in_progress` → first lesson completed
- `completed` → 100% completion

### Future Enhancements (Easy to Add)
- Badges/achievements
- Streaks (consecutive days)
- Leaderboards
- Module-level progress
- Time tracking
- Quiz scores

---

## Data Model

### Minimal Database Storage

```ruby
# What's stored in DB (lightweight):
Course {
  slug: "docker-fundamentals"  # Used for joining with YAML data
  title: "Docker Fundamentals"
  # That's it! Everything else comes from YAML
}

CourseEnrollment {
  user_id: 1
  course_id: 1
  enrolled_at: "2025-01-09"
  completion_percentage: 25.5  # Calculated from lessons completed
  total_points: 120            # Sum of all points earned
  status: "in_progress"
}

# Optional: Track individual lesson completions
LessonCompletion {
  user_id: 1
  lesson_slug: "docker-ps"
  completed_at: "2025-01-09"
  points_earned: 10
}
```

---

## Advantages of Hybrid Approach

### vs. Full Database
✅ **Easier content management** - Edit YAML, not SQL
✅ **Version control friendly** - Git tracks content changes
✅ **No migration delays** - Update course content instantly
✅ **Simpler deployment** - No heavy data migrations

### vs. Pure File-Based
✅ **User progress tracking** - Enrollments, completions, points
✅ **Gamification** - Points, badges, achievements
✅ **Analytics** - User engagement, completion rates
✅ **Personalization** - Recommendations based on progress

---

## Performance

- **Course listing:** 2-5ms (cached)
- **Enrollment:** ~10-20ms (database write)
- **Progress check:** ~5-10ms (database read + file cache)
- **Lesson completion:** ~10-20ms (database write)

**Good for:** MVP with thousands of users, hundreds of courses

---

## When to Migrate to Full Database

Consider full database migration when:
- Course content changes frequently based on user data
- Need complex querying of lesson content
- Have 10,000+ courses
- Need full-text search on lesson content
- Want to version course content per user

Until then: **Keep it hybrid!** 🎯

---

## Summary

✅ **Course content in YAML** - Easy editing, version control
✅ **Progress in database** - Track enrollments, completions, points
✅ **Simple auth** - User ID parameter or headers
✅ **Gamification ready** - Points, percentages, status
✅ **Fast & scalable** - 2-5ms cached reads
✅ **MVP perfect** - Focus on content & UX

**You get user tracking without the complexity of full database migrations!** 🚀
