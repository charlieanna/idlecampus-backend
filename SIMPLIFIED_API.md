# Simplified Course API - Quick Start

## What We Simplified

✅ **API-Only Controller** - Uses `ActionController::API` (no sessions, cookies, CSRF)
✅ **Cached YAML Reading** - Parses YAML once, caches for 1 hour
✅ **Minimal CORS** - Only GET methods, simple headers
✅ **No Authentication** - Public course data (can add later if needed)
✅ **Clean Code** - 67 lines total (was 145+ lines)

## Quick Start

### 1. Start Server
```bash
rails server
```

### 2. Test APIs
```bash
# List all courses
curl http://localhost:3000/api/v1/courses

# Get Docker course
curl http://localhost:3000/api/v1/courses/docker-fundamentals

# Get modules
curl http://localhost:3000/api/v1/courses/docker-fundamentals/modules
```

### 3. Edit Course Content
```bash
# Edit any YAML file
vim db/seeds/consolidated_courses/docker-fundamentals/manifest.yml

# Clear cache to see changes
rake courses:clear_cache

# Or just wait 1 hour for auto-refresh
```

## API Endpoints

### GET /api/v1/courses
Returns list of all courses (cached, fast).

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

### GET /api/v1/courses/:slug
Returns full course with modules.

### GET /api/v1/courses/:slug/modules
Returns detailed module and lesson info.

## Caching

**How it works:**
- First request: Reads all YAML files, caches result (1 hour)
- Subsequent requests: Returns cached data (super fast)
- Cache expires: Auto-refreshes after 1 hour

**Manual cache clear:**
```bash
rake courses:clear_cache
```

**In production:**
Change cache duration in `course_file_reader_service.rb`:
```ruby
CACHE_DURATION = 24.hours # or 1.week for stable content
```

## File Structure

```
app/
  controllers/api/v1/
    courses_controller.rb       # 67 lines - simple API controller
  services/
    course_file_reader_service.rb  # YAML reader with caching

db/seeds/consolidated_courses/
  docker-fundamentals/
    manifest.yml
  kubernetes-complete/
    manifest.yml
  ...

lib/tasks/
  courses.rake  # Helper tasks
```

## Performance

- **Uncached:** ~20-50ms (reads YAML files)
- **Cached:** ~2-5ms (returns from cache)
- **Good for:** MVP with hundreds of courses
- **Scale later:** Add Redis cache if needed

## Frontend Integration

### React Example
```javascript
// Fetch courses
const { courses } = await fetch('/api/v1/courses').then(r => r.json());

// Display
courses.map(course => (
  <div key={course.slug}>
    <h2>{course.title}</h2>
    <p>{course.difficulty_level} • {course.estimated_hours}h</p>
  </div>
))
```

### Vue Example
```javascript
async created() {
  const { courses } = await fetch('/api/v1/courses').then(r => r.json());
  this.courses = courses;
}
```

## Development Workflow

1. **Edit YAML files** - Update course content
2. **Clear cache** - `rake courses:clear_cache`
3. **Test API** - `curl http://localhost:3000/api/v1/courses/...`
4. **Commit changes** - Git tracks YAML changes

## What's Not Included (Can Add Later)

- ❌ Authentication (not needed for public course catalog)
- ❌ User enrollments (add when you need progress tracking)
- ❌ Database storage (files are simpler for MVP)
- ❌ Complex filtering (can add if needed)
- ❌ Pagination (9 courses don't need it)

## When to Add Complexity

**Add Database when:**
- Need user progress tracking
- Need enrollments and completions
- Need complex queries/filters
- Have 1000+ courses

**Add Authentication when:**
- Courses should be private
- Need user-specific data
- Want to track who accesses what

**For MVP:** Keep it simple! This works great.

## Summary

✅ **3 API endpoints** - List, show, modules
✅ **9 courses ready** - 889+ lessons total
✅ **Zero database setup** - Just YAML files
✅ **Cached for speed** - 2-5ms response time
✅ **67 lines of code** - Simple to understand

Perfect for MVP! Focus on content quality and UX. 🚀
