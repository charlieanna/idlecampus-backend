# IdleCampus Backend

Rails API backend for the IdleCampus educational platform.

## Architecture Overview

### Course Content Storage

**IMPORTANT: Course content is ONLY fetched from YAML files, NOT from the database.**

- **Course Content Source**: All course data (titles, descriptions, modules, lessons) is stored in YAML manifest files located in `/db/seeds/consolidated_courses/`
- **Course Fetching**: Use `CourseFileReaderService` to load course content from YAML files
- **Database Usage**: The database is ONLY used for user-specific data:
  - Course enrollments (`course_enrollments`)
  - User progress tracking (`module_progresses`)
  - Quiz attempts (`quiz_attempts`)
  - User achievements (`user_course_achievements`)

### Why YAML-Only for Courses?

1. **Version Control**: Course content changes can be tracked in git
2. **Easy Editing**: Courses can be edited as YAML files without database migrations
3. **Portability**: Courses can be easily shared and imported
4. **No Sync Issues**: Single source of truth (YAML files)

### Course Directory Structure

```
/db/seeds/consolidated_courses/
├── aws-cloud-fundamentals/
│   └── manifest.yml
├── docker-fundamentals/
│   └── manifest.yml
├── kubernetes-complete/
│   └── manifest.yml
└── [other courses...]
```

### How to Fetch Courses

```ruby
# Get all courses
courses = CourseFileReaderService.all_courses

# Get a specific course by slug
course = CourseFileReaderService.find_course('docker-fundamentals')

# Get course modules
modules = CourseFileReaderService.find_course('docker-fundamentals')['modules']
```

### Database Models (User Data Only)

- `CourseEnrollment` - Tracks which users are enrolled in which courses
- `ModuleProgress` - Tracks user progress through course modules
- `QuizAttempt` - Stores user quiz attempt records
- `CourseAchievement` - Defines available achievements/badges
- `UserCourseAchievement` - Tracks which users earned which achievements

## Setup

### Ruby version
- Ruby 3.x

### System dependencies
- PostgreSQL
- Redis (for caching)

### Configuration
1. Copy `.env.example` to `.env` and configure environment variables
2. Update database credentials in `config/database.yml`

### Database creation
```bash
rails db:create
rails db:migrate
```

### Database initialization
The database only stores user-specific data. Course content is loaded from YAML files automatically.

### How to run the test suite
```bash
rails test
```

### Caching
Course data from YAML files is cached in Redis with a 1-hour expiration to improve performance.

## API Endpoints

All course content endpoints use `CourseFileReaderService` to fetch data from YAML files:

- `GET /api/v1/courses` - List all courses
- `GET /api/v1/courses/:slug` - Get course details
- `GET /api/v1/courses/:slug/modules` - Get course modules
- `GET /api/v1/courses/:slug/progress` - Get user progress (combines YAML course data with DB progress tracking)

## Deployment

[Add deployment instructions here]
