# Course API Guide - File-Based (MVP)

## Overview

This is a **simple, file-based course API** perfect for MVP. No database migration needed - courses are served directly from YAML files!

## Why File-Based?

✅ **Simple** - No database setup or migrations
✅ **Fast iteration** - Edit YAML files, see changes immediately
✅ **Version control friendly** - All content in Git
✅ **Easy to update** - Just edit YAML and commit
✅ **Perfect for MVP** - Focus on content quality, not infrastructure

## How It Works

```
YAML Files (db/seeds/consolidated_courses/)
    ↓
CourseFileReaderService (reads YAML)
    ↓
CoursesController (serves JSON API)
    ↓
Frontend (consumes API)
```

## API Endpoints

All endpoints work immediately - no migration required!

### Base URL
```
http://localhost:3000/api/v1
```

---

### 1. List All Courses

**GET** `/api/v1/courses`

Returns all courses from YAML manifests.

**Example Request:**
```bash
curl http://localhost:3000/api/v1/courses
```

**Example Response:**
```json
{
  "courses": [
    {
      "slug": "docker-fundamentals",
      "title": "Docker Fundamentals",
      "description": "Master containerization with Docker...",
      "difficulty_level": "beginner",
      "estimated_hours": 10,
      "modules_count": 4,
      "total_lessons": 42,
      "tags": ["docker", "containers", "devops", "beginner"]
    },
    {
      "slug": "kubernetes-complete",
      "title": "Kubernetes Complete",
      "description": "Complete Kubernetes guide...",
      "difficulty_level": "intermediate",
      "estimated_hours": 30,
      "modules_count": 8,
      "total_lessons": 164,
      "tags": ["kubernetes", "k8s", "orchestration"]
    }
    ...
  ],
  "total": 9
}
```

---

### 2. Get Course Details

**GET** `/api/v1/courses/:slug`

Returns full course details including all modules.

**Example Request:**
```bash
curl http://localhost:3000/api/v1/courses/docker-fundamentals
```

**Example Response:**
```json
{
  "course": {
    "slug": "docker-fundamentals",
    "title": "Docker Fundamentals",
    "description": "Master containerization with Docker. Learn to build, run, and manage containers...",
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
    "tags": ["docker", "containers", "devops", "beginner"],
    "related_courses": ["docker-advanced", "kubernetes-fundamentals"],
    "recommended_next": "docker-advanced",
    "modules_count": 4,
    "total_lessons": 42,
    "modules": [
      {
        "slug": "introduction-to-docker",
        "title": "Introduction to Docker",
        "description": "Get started with Docker...",
        "sequence_order": 1,
        "estimated_hours": 2,
        "estimated_minutes": 120,
        "lessons_count": 4
      },
      {
        "slug": "working-with-containers",
        "title": "Working with Containers",
        "description": "Master the complete container lifecycle...",
        "sequence_order": 2,
        "estimated_hours": 4,
        "estimated_minutes": 240,
        "lessons_count": 20
      }
      ...
    ]
  }
}
```

---

### 3. Get Course Modules (Detailed)

**GET** `/api/v1/courses/:slug/modules`

Returns detailed module information with lesson lists.

**Example Request:**
```bash
curl http://localhost:3000/api/v1/courses/docker-fundamentals/modules
```

**Example Response:**
```json
{
  "course": {
    "slug": "docker-fundamentals",
    "title": "Docker Fundamentals"
  },
  "modules": [
    {
      "slug": "introduction-to-docker",
      "title": "Introduction to Docker",
      "description": "Get started with Docker - understand containers...",
      "sequence_order": 1,
      "estimated_hours": 2,
      "estimated_minutes": 120,
      "learning_outcomes": [],
      "lessons_count": 4,
      "lessons": [
        {
          "slug": "docker-ps-listing-running-containers",
          "title": "Docker Ps Listing Running Containers",
          "sequence_order": 1,
          "type": "lesson",
          "duration_estimate": "10 min"
        },
        {
          "slug": "docker-run-creating-and-starting-containers",
          "title": "Docker Run Creating And Starting Containers",
          "sequence_order": 2,
          "type": "lesson",
          "duration_estimate": "10 min"
        }
        ...
      ]
    }
    ...
  ],
  "total": 4
}
```

---

## Available Courses

### 9 Consolidated Courses (Ready Now!)

1. **Docker Fundamentals** - 42 lessons, 10 hours, Beginner
2. **Docker Advanced** - 15 lessons, 8 hours, Intermediate
3. **Kubernetes Complete** - 164 lessons, 30 hours, Intermediate-Advanced
4. **Physical Chemistry Complete** - 212 lessons, 20 hours, Intermediate
5. **Inorganic Chemistry Complete** - 206 lessons, 18 hours, Intermediate
6. **Organic Chemistry Complete** - 196 lessons, 25 hours, Intermediate-Advanced
7. **Linux & Shell Fundamentals** - 23 lessons, 8 hours, Beginner
8. **DevOps Essentials** - 19 lessons, 10 hours, Intermediate
9. **AWS Cloud Fundamentals** - 12 lessons, 8 hours, Intermediate

---

## How to Add/Edit Courses

### 1. Edit Existing Course

Just edit the YAML file:

```bash
vim db/seeds/consolidated_courses/docker-fundamentals/manifest.yml
```

Changes are **immediately available** on next API request (no restart needed in development).

### 2. Add New Course

Create a new directory with `manifest.yml`:

```bash
mkdir -p db/seeds/consolidated_courses/my-new-course
```

Create `manifest.yml`:
```yaml
course:
  slug: my-new-course
  title: My New Course
  description: Learn something awesome
  estimated_hours: 5
  level: beginner
  prerequisites:
    - Basic programming knowledge
  learning_outcomes:
    - Understand core concepts
    - Build practical projects
  tags:
    - programming
    - beginner

modules:
  - slug: module-1
    title: Getting Started
    description: Introduction to the course
    order: 1
    estimated_hours: 2
    lessons:
      - lesson-1-introduction
      - lesson-2-setup
      - lesson-3-first-steps
```

That's it! The course is now available via API.

---

## Implementation Details

### CourseFileReaderService

Located: `app/services/course_file_reader_service.rb`

**Key Methods:**
- `all_courses` - Returns array of all courses
- `find_course(slug)` - Find specific course by slug
- `course_with_modules(slug)` - Get course with full module details

**How it works:**
1. Scans `db/seeds/consolidated_courses/` for `manifest.yml` files
2. Parses YAML using Ruby's YAML library
3. Transforms to consistent hash structure
4. Returns data ready for JSON serialization

**Caching (Future):**
Currently reads files on every request. For production, add Rails caching:
```ruby
Rails.cache.fetch('all_courses', expires_in: 1.hour) do
  CourseFileReaderService.all_courses
end
```

---

## Testing

### Quick Test
```bash
# Start Rails server
rails server

# Test in another terminal
curl http://localhost:3000/api/v1/courses | jq
curl http://localhost:3000/api/v1/courses/docker-fundamentals | jq
curl http://localhost:3000/api/v1/courses/docker-fundamentals/modules | jq
```

### With HTTPie (prettier output)
```bash
http http://localhost:3000/api/v1/courses
http http://localhost:3000/api/v1/courses/docker-fundamentals
```

---

## Performance Considerations

### Current Performance (MVP - Good Enough)
- Reads YAML files on each request
- ~10-50ms response time (fast enough for MVP)
- Works fine for hundreds of courses

### Future Optimizations (if needed)
1. **Add caching** - Cache parsed courses in memory
2. **Preload on startup** - Load all courses once at boot
3. **Use Redis** - Cache in Redis for multi-server setups

For MVP: **Don't optimize prematurely!** File-based is fast enough.

---

## Frontend Integration

### React/Vue Example
```javascript
// Fetch all courses
const response = await fetch('http://localhost:3000/api/v1/courses');
const data = await response.json();
console.log(data.courses); // Array of courses

// Fetch specific course
const course = await fetch('http://localhost:3000/api/v1/courses/docker-fundamentals');
const courseData = await course.json();
console.log(courseData.course); // Course object with modules
```

### Display Course List
```jsx
function CourseList() {
  const [courses, setCourses] = useState([]);

  useEffect(() => {
    fetch('http://localhost:3000/api/v1/courses')
      .then(res => res.json())
      .then(data => setCourses(data.courses));
  }, []);

  return (
    <div>
      {courses.map(course => (
        <div key={course.slug}>
          <h3>{course.title}</h3>
          <p>{course.description}</p>
          <span>{course.difficulty_level} • {course.estimated_hours} hours</span>
          <span>{course.modules_count} modules • {course.total_lessons} lessons</span>
        </div>
      ))}
    </div>
  );
}
```

---

## Troubleshooting

### "Empty courses array"
- Check that YAML files exist in `db/seeds/consolidated_courses/`
- Verify file permissions
- Check Rails logs for parsing errors

### "Course not found"
- Verify slug matches YAML file: `course.slug` in manifest.yml
- Check for typos (use hyphens, not underscores)
- Ensure manifest.yml is valid YAML

### "Slow API responses"
- Add caching (see Performance section)
- Use smaller test datasets
- Check for large YAML files

---

## Future Enhancements (Post-MVP)

When you're ready to scale beyond MVP:

1. **Add Database** (Optional)
   - Use the `CourseLoaderService` already built
   - Run `rake courses:load_consolidated`
   - Switch controller to use database queries

2. **Add User Progress Tracking**
   - Store enrollments in database
   - Track lesson completion
   - Calculate progress percentages

3. **Add Search/Filtering**
   - Filter by difficulty level
   - Filter by tags
   - Search course content

4. **Add Content Delivery**
   - Serve lesson markdown files
   - Add video URLs
   - Include downloadable resources

---

## Summary

✅ **No database required** - Works immediately
✅ **Edit YAML files** - Changes reflect instantly
✅ **Simple to maintain** - Version control friendly
✅ **Perfect for MVP** - Focus on content and UX

**Ready to use!** Just start your Rails server and hit the APIs.

For questions or issues, check `log/development.log` for errors.
