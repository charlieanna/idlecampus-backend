# Course Migration & API Guide

## Overview

This guide explains how to migrate courses from YAML/JSON files into the database and access them through APIs.

## Migration Process

### Prerequisites

1. Ensure the database is set up and migrations are run:
   ```bash
   bundle exec rails db:migrate
   ```

2. Verify the course data files exist:
   - `db/seeds/consolidated_courses/*/manifest.yml` - 9 consolidated courses
   - `course_catalog.json` - 130 courses
   - `chemistry_courses.json` - 39 chemistry courses
   - `linux_devops_courses.json` - 11 Linux/DevOps courses

### Step 1: Load Consolidated Courses

The consolidated courses have the most complete structure with YAML manifests. Load them first:

```bash
bundle exec rake courses:load_consolidated
```

This will:
- Parse all YAML manifests in `db/seeds/consolidated_courses/`
- Create Course records with metadata
- Create CourseModule records for each module
- Create CourseLesson records for each lesson
- Link lessons to modules via ModuleItem (polymorphic)
- Set all courses to published status

Expected output:
```
================================================================================
Loading Consolidated Courses from YAML Manifests
================================================================================

Found 9 course manifests to load:
  - docker-fundamentals
  - docker-advanced
  - kubernetes-complete
  - physical-chemistry-complete
  - inorganic-chemistry-complete
  - organic-chemistry-complete
  - linux-shell-fundamentals
  - devops-essentials
  - aws-cloud-fundamentals

--------------------------------------------------------------------------------
Loading: docker-fundamentals
--------------------------------------------------------------------------------
✓ Course created/updated: Docker Fundamentals
  ✓ Module created/updated: Introduction to Docker
    ✓ Lesson linked: Docker Ps Listing Running Containers
    ✓ Lesson linked: Docker Run Creating And Starting Containers
    ...
✅ Successfully loaded: Docker Fundamentals (4 modules, 42 items)

...

================================================================================
SUMMARY
================================================================================
Total manifests found: 9
Successfully loaded: 9
Failed: 0

✅ Loaded Courses:
  - Docker Fundamentals (docker-fundamentals)
    Modules: 4
    Total Items: 42
    Estimated Hours: 10
  ...

================================================================================
Total courses in database: 9
Total modules in database: 36
Total lessons in database: 150+
================================================================================
```

### Step 2: Verify Migration

Check courses were loaded correctly:

```bash
# List all courses
bundle exec rake courses:list

# Show statistics
bundle exec rake courses:stats
```

### Step 3: Clear Courses (if needed)

To start over or reset:

```bash
bundle exec rake courses:clear
```

⚠️ **Warning**: This will delete ALL courses, modules, and related data!

## API Endpoints

### Base URL
```
http://localhost:3000/api/v1
```

### 1. List All Courses

**Endpoint**: `GET /api/v1/courses`

**Description**: Get a list of all published courses

**Response**:
```json
{
  "courses": [
    {
      "id": 1,
      "slug": "docker-fundamentals",
      "title": "Docker Fundamentals",
      "description": "Master containerization with Docker...",
      "certification_track": null,
      "difficulty_level": "beginner",
      "estimated_hours": 10,
      "modules_count": 4,
      "total_items": 42
    },
    ...
  ],
  "total": 9
}
```

**Example**:
```bash
curl http://localhost:3000/api/v1/courses
```

### 2. Get Course Details

**Endpoint**: `GET /api/v1/courses/:slug`

**Description**: Get full details of a specific course including all modules

**Parameters**:
- `slug` (path) - Course slug (e.g., "docker-fundamentals")

**Response**:
```json
{
  "course": {
    "id": 1,
    "slug": "docker-fundamentals",
    "title": "Docker Fundamentals",
    "description": "Master containerization with Docker...",
    "certification_track": null,
    "difficulty_level": "beginner",
    "estimated_hours": 10,
    "learning_objectives": [
      "Understand containerization concepts and benefits",
      "Run and manage Docker containers",
      "Create and optimize Docker images",
      "Implement data persistence with volumes",
      "Debug and troubleshoot containers"
    ],
    "prerequisites": [
      "Basic Linux command-line knowledge",
      "Understanding of terminal/shell"
    ],
    "published": true,
    "modules_count": 4,
    "total_items": 42,
    "modules": [
      {
        "id": 1,
        "slug": "introduction-to-docker",
        "title": "Introduction to Docker",
        "description": "Get started with Docker...",
        "sequence_order": 1,
        "estimated_minutes": 120,
        "items_count": 4
      },
      ...
    ]
  }
}
```

**Example**:
```bash
curl http://localhost:3000/api/v1/courses/docker-fundamentals
```

### 3. Get Course Modules with Items

**Endpoint**: `GET /api/v1/courses/:slug/modules`

**Description**: Get detailed module information including all lessons, quizzes, and labs

**Parameters**:
- `slug` (path) - Course slug (e.g., "docker-fundamentals")

**Response**:
```json
{
  "course": {
    "id": 1,
    "slug": "docker-fundamentals",
    "title": "Docker Fundamentals"
  },
  "modules": [
    {
      "id": 1,
      "slug": "introduction-to-docker",
      "title": "Introduction to Docker",
      "description": "Get started with Docker...",
      "sequence_order": 1,
      "estimated_minutes": 120,
      "learning_objectives": [
        "Understand container basics",
        "Run your first container"
      ],
      "items_count": 4,
      "items": [
        {
          "id": 1,
          "type": "CourseLesson",
          "type_display": "Lesson",
          "title": "Docker Ps Listing Running Containers",
          "sequence_order": 1,
          "required": true,
          "duration_estimate": "10 min",
          "item_id": 42
        },
        {
          "id": 2,
          "type": "Quiz",
          "type_display": "Quiz",
          "title": "Container Basics Quiz",
          "sequence_order": 2,
          "required": true,
          "duration_estimate": "15 min",
          "item_id": 15
        },
        ...
      ]
    },
    ...
  ],
  "total": 4
}
```

**Example**:
```bash
curl http://localhost:3000/api/v1/courses/docker-fundamentals/modules
```

## Database Schema

### Tables

1. **courses** - Main course metadata
   - `id`, `slug`, `title`, `description`
   - `difficulty_level` (beginner/intermediate/advanced)
   - `estimated_hours`
   - `certification_track`
   - `learning_objectives`, `prerequisites`
   - `published`, `sequence_order`

2. **course_modules** - Course modules/chapters
   - `id`, `course_id`, `slug`, `title`, `description`
   - `sequence_order`, `estimated_minutes`
   - `learning_objectives`
   - `published`

3. **course_lessons** - Individual lessons
   - `id`, `title`, `content` (markdown)
   - `video_url`, `reading_time_minutes`
   - `key_concepts`

4. **module_items** - Polymorphic join table
   - `id`, `course_module_id`
   - `item_type` (CourseLesson, Quiz, HandsOnLab, etc.)
   - `item_id`
   - `sequence_order`, `required`

5. **quizzes** - Quiz metadata
6. **quiz_questions** - Quiz questions
7. **course_enrollments** - User enrollments
8. **module_progresses** - Progress tracking

## Implementation Details

### CourseLoaderService

Located: `app/services/course_loader_service.rb`

Responsibilities:
- Parse YAML manifest files
- Create/update Course records
- Create/update CourseModule records
- Create CourseLesson records
- Link lessons to modules via ModuleItem
- Handle errors and logging

Usage:
```ruby
loader = CourseLoaderService.new('path/to/manifest.yml')
course = loader.load!

if course
  puts "Success! #{course.title}"
else
  puts "Errors: #{loader.errors.join(', ')}"
end
```

### API Controller

Located: `app/controllers/api/v1/courses_controller.rb`

Key Methods:
- `index` - List all published courses
- `show` - Get course details
- `modules` - Get module and item details

Serialization:
- `serialize_course_summary` - Basic course info for listings
- `serialize_course_detail` - Full course details with modules
- `serialize_module_detail` - Module with all items
- `serialize_module_item` - Individual lesson/quiz/lab

## Testing

### Manual API Testing

```bash
# Test course listing
curl -X GET http://localhost:3000/api/v1/courses | jq

# Test course details
curl -X GET http://localhost:3000/api/v1/courses/docker-fundamentals | jq

# Test module details
curl -X GET http://localhost:3000/api/v1/courses/docker-fundamentals/modules | jq
```

### Rails Console Testing

```ruby
# Check course count
Course.count

# Get a course
course = Course.find_by(slug: 'docker-fundamentals')

# Check modules
course.course_modules.count
course.total_items

# Check lessons
CourseLesson.count
```

## Next Steps

1. ✅ Load consolidated courses (9 courses with complete YAML manifests)
2. ⏳ Load courses from JSON files (course_catalog.json, chemistry_courses.json, etc.)
3. ⏳ Add lesson content (currently placeholders)
4. ⏳ Create additional API endpoints:
   - GET `/api/v1/lessons/:id` - Get lesson content
   - GET `/api/v1/quizzes/:id` - Get quiz details
   - POST `/api/v1/courses/:slug/enroll` - Enroll in course
5. ⏳ Add authentication and authorization
6. ⏳ Add progress tracking APIs
7. ⏳ Frontend integration

## Troubleshooting

### "Course not found" error
- Ensure courses are loaded: `rake courses:list`
- Check slug is correct (use hyphens, not underscores)
- Verify course is published

### Empty modules/items
- Check YAML manifest structure
- Verify lesson files exist
- Review loader logs for errors

### Migration failures
- Run `rails db:migrate` first
- Check database connectivity
- Review migration files in `db/migrate/`

## Course Inventory

### Consolidated Courses (9)
1. Docker Fundamentals - 42 lessons, 10 hours, Beginner
2. Docker Advanced - 15 lessons, 8 hours, Intermediate
3. Kubernetes Complete - 164 lessons, 30 hours, Intermediate-Advanced
4. Physical Chemistry Complete - 212 lessons, 20 hours, Intermediate
5. Inorganic Chemistry Complete - 206 lessons, 18 hours, Intermediate
6. Organic Chemistry Complete - 196 lessons, 25 hours, Intermediate-Advanced
7. Linux & Shell Fundamentals - 23 lessons, 8 hours, Beginner
8. DevOps Essentials - 19 lessons, 10 hours, Intermediate
9. AWS Cloud Fundamentals - 12 lessons, 8 hours, Intermediate

### Additional Courses (143+)
- Chemistry courses from `chemistry_courses.json` (39 courses)
- Linux/DevOps courses from `linux_devops_courses.json` (11 courses)
- General courses from `course_catalog.json` (130 courses)
- Ruby seed files in `db/seeds/` (162 files)

## Support

For issues or questions:
- Check logs: `tail -f log/development.log`
- Review database: `rails dbconsole`
- Run tests: `rake courses:stats`
