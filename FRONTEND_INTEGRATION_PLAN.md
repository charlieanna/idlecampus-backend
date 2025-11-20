# Frontend Integration Plan

## Current State ✅

We have successfully analyzed all microlessons:

- **102 courses** with **1,208 complete microlessons**
- All courses have a `manifest.yml` with metadata
- Individual microlessons are in `course-name/microlessons/*.yml`
- Course catalog exported to `course_catalog.json`

## Issues Found

1. **2 courses with missing files**:
   - `git-fundamentals`: Missing 1 lesson (lesson-2)
   - `intro-linux-shell`: Missing 23 practice questions

2. **Incomplete course metadata**:
   - Most courses lack descriptions
   - No difficulty levels specified
   - No estimated completion times

3. **Many incomplete courses**:
   - Manifests reference more lessons than exist
   - Need to decide: create missing lessons or update manifests?

## Recommended Steps Before Frontend Integration

### Phase 1: Course Organization & Metadata 📝

#### 1.1 Group Related Courses into Learning Paths

**Chemistry Learning Path** (25 courses → 3-5 major courses)
- General Chemistry (combine atomic structure, bonding, states of matter, etc.)
- Organic Chemistry (combine alcohols, aldehydes, amines, etc.)
- Physical Chemistry (combine equilibrium, kinetics, electrochemistry)
- Inorganic Chemistry (combine d-block, f-block, coordination compounds)

**Docker/Kubernetes Learning Path** (12 courses → 2-3 major courses)
- Docker Fundamentals (combine basics, containers, images, volumes, networks)
- Docker Advanced (compose, swarm, security)
- Kubernetes (combine kubectl, certification, complete guide)

**Programming Fundamentals** (keep separate or group by language)
- Python Track
- Go Track
- Rust Track
- JavaScript/TypeScript Track

#### 1.2 Enrich Course Metadata

For each course, add:
```yaml
course:
  slug: docker-basics
  title: Docker Basics
  description: "Learn containerization with Docker..." # ADD THIS
  estimated_hours: 4 # ADD THIS
  level: beginner # ADD THIS (beginner/intermediate/advanced)
  prerequisites: [] # ADD THIS
  learning_outcomes: # ADD THIS
    - Understand container concepts
    - Run and manage containers
    - ...
  tags: [docker, devops, containers] # ADD THIS
```

#### 1.3 Define Module Structure

Instead of "Default Module", create meaningful modules:
```yaml
modules:
  - slug: introduction
    title: Introduction to Docker
    description: "Core concepts and installation"
    order: 1
    lessons: [...]

  - slug: containers
    title: Working with Containers
    description: "Create, run, and manage containers"
    order: 2
    lessons: [...]
```

### Phase 2: Content Quality Assurance 🔍

#### 2.1 Fix Missing Lessons
- Create missing `git-fundamentals/lesson-2.yml`
- Add practice questions for `intro-linux-shell` or update manifest

#### 2.2 Validate All Microlessons
Run validation script to ensure each YAML has:
- Valid structure (title, content, exercises)
- All required fields populated
- Exercises have correct answers
- No broken references

#### 2.3 Create Course Progression
For each course:
1. Review lesson order - does it make pedagogical sense?
2. Add prerequisite lessons within course
3. Add difficulty progression markers
4. Ensure smooth learning curve

### Phase 3: Create Master Curriculum 🗺️

#### 3.1 Define Learning Tracks
```json
{
  "tracks": [
    {
      "id": "devops-engineer",
      "title": "DevOps Engineer Path",
      "courses": [
        "linux-basics",
        "git-fundamentals",
        "docker-fundamentals",
        "kubernetes-fundamentals",
        "cicd-fundamentals"
      ]
    },
    {
      "id": "backend-developer",
      "title": "Backend Developer Path",
      "courses": [
        "python-basics",
        "databases",
        "api-development",
        "system-design"
      ]
    }
  ]
}
```

#### 3.2 Create Course Relationships
```yaml
# In each manifest
course:
  recommended_next: [docker-compose, kubernetes-basics]
  related_courses: [linux-basics, bash-scripting]
  difficulty_level: beginner
```

### Phase 4: Database Schema & Seeding 💾

#### 4.1 Review Database Models
Ensure Rails models support:
- Courses with metadata
- Modules within courses
- Microlessons with exercises
- Learning tracks
- Prerequisites
- User progress tracking

#### 4.2 Create Seed Scripts
```ruby
# db/seeds/load_courses.rb
# Parse all manifests and microlessons
# Insert into PostgreSQL with proper relationships
```

#### 4.3 Add Search & Filtering
- Tag-based search
- Difficulty filtering
- Duration filtering
- Track filtering

### Phase 5: API Development 🚀

#### 5.1 RESTful Endpoints
```
GET  /api/v1/courses
GET  /api/v1/courses/:id
GET  /api/v1/courses/:id/modules
GET  /api/v1/modules/:id/microlessons
GET  /api/v1/microlessons/:id
POST /api/v1/exercises/:id/submit
GET  /api/v1/tracks
GET  /api/v1/tracks/:id/courses
```

#### 5.2 Progress Tracking
```
POST /api/v1/progress/microlessons/:id/start
POST /api/v1/progress/microlessons/:id/complete
GET  /api/v1/users/:id/progress
GET  /api/v1/users/:id/next-lesson
```

#### 5.3 Search & Discovery
```
GET /api/v1/search?q=docker&level=beginner
GET /api/v1/courses/recommended
```

## Priority Order

1. **Phase 1.1** - Group related courses (Chemistry, Docker/K8s) ⭐ **START HERE**
2. **Phase 1.2** - Add basic metadata (description, level, hours)
3. **Phase 2.1** - Fix 2 courses with missing files
4. **Phase 3.1** - Define 3-5 main learning tracks
5. **Phase 4** - Database schema + seeding
6. **Phase 5** - API development

## Questions to Answer

1. **Course Organization**: Should we combine related courses or keep them separate?
   - Example: 8 Docker courses → 2-3 comprehensive courses?

2. **Incomplete Courses**: What to do about courses with missing lessons?
   - Create the missing content?
   - Or update manifests to only reference existing lessons?

3. **Chemistry Courses**: 25 chemistry courses - organize by:
   - Subject area (organic, inorganic, physical)?
   - Difficulty level (high school → undergrad)?
   - Indian exam syllabus (JEE, NEET)?

4. **Target Audience**: Who is the primary user?
   - Students (high school, college)?
   - Professionals (career switchers)?
   - Determines how we organize and present content

## Next Steps

**You decide**: Should we start by organizing related courses (Phase 1.1), or jump straight to enriching metadata and then building the API?

I recommend starting with **Phase 1.1** - analyzing and organizing related courses - so we understand the big picture before technical implementation.
