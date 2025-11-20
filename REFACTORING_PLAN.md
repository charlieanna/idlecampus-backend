# IdleCampus Backend Refactoring Plan
## Scaling to Support 10-20 Courses with Advanced Learning Features

---

## Executive Summary

Your Rails backend is already well-architected with solid foundations. This plan outlines strategic refactoring to:
- **Eliminate duplication** across course APIs
- **Standardize course addition** to a 30-minute process
- **Enhance performance** with intelligent caching
- **Support React frontend** with optimized API structure
- **Scale to 20+ courses** without architectural changes

**Current State**: 11 courses, polymorphic content system, adaptive learning
**Target State**: Unified API, database-driven content, sub-hour course deployment

---

## Phase 1: API Consolidation & Standardization

### Problem
Currently you have 11 separate API controllers (one per course):
```
app/controllers/api/v1/
├── docker_track/
├── kubernetes_track/
├── chemistry/
├── mathematics/
├── linux_track/
└── ... (6 more)
```

Each duplicates ~200 lines of nearly identical code.

### Solution: Unified Course API

**Create a single, generic course API structure:**

```ruby
# NEW Structure
app/controllers/api/v1/
├── courses_controller.rb           # List all courses
├── course_modules_controller.rb    # Get modules for any course
├── course_items_controller.rb      # Get items (lessons/labs/quizzes)
├── labs_controller.rb              # Lab execution (all types)
├── quizzes_controller.rb           # Quiz submission & grading
├── progress_controller.rb          # Progress tracking
├── adaptive_learning_controller.rb # Personalization & recommendations
└── reviews_controller.rb           # Spaced repetition reviews
```

**API Endpoints:**
```
# Course Discovery
GET  /api/v1/courses
GET  /api/v1/courses/:course_id
GET  /api/v1/courses/:course_id/modules
GET  /api/v1/courses/:course_id/modules/:module_id/items

# Learning
GET  /api/v1/items/:item_id                    # Any item type
POST /api/v1/items/:item_id/complete           # Mark complete
GET  /api/v1/items/:item_id/next               # Adaptive next item

# Labs (Terminal & Code Editor)
POST /api/v1/labs/:lab_id/start                # Initialize lab
POST /api/v1/labs/:lab_id/execute              # Run command/code
POST /api/v1/labs/:lab_id/submit               # Submit for grading
GET  /api/v1/labs/:lab_id/status               # Check execution status

# Quizzes
POST /api/v1/quizzes/:quiz_id/submit           # Submit answers
GET  /api/v1/quizzes/:quiz_id/results          # Get results

# Adaptive Learning & Personalization
GET  /api/v1/users/:user_id/learning_path      # Personalized path
GET  /api/v1/users/:user_id/recommendations    # Next items to study
GET  /api/v1/users/:user_id/mastery_levels     # Concept mastery

# Reviews (Spaced Repetition)
GET  /api/v1/reviews/due                       # Items due for review
POST /api/v1/reviews/:item_id/complete         # Complete review
```

**Benefits:**
- Add new course: **Update database only** (no code changes)
- React frontend: **Single API client** for all courses
- Maintenance: **One codebase** instead of 11

---

## Phase 2: Database-Driven Course Configuration

### Problem
Course content is partially hardcoded in lib/ directory.

### Solution: Move Everything to Database

**Enhanced Schema:**

```ruby
# Core Course Structure (Already exists - enhance)
courses
├── id
├── name                      # "Docker Fundamentals"
├── slug                      # "docker-track" (URL-friendly)
├── category                  # "containers", "math", "chemistry"
├── difficulty_level          # beginner/intermediate/advanced
├── estimated_hours
├── description
├── icon_url
├── color_scheme              # JSON: { primary: "#007bff", ... }
├── settings                  # JSON: course-specific config
└── status                    # draft/published/archived

# Lab Configuration (NEW - extend existing HandsOnLab)
lab_configurations
├── id
├── lab_id (FK: hands_on_labs)
├── lab_type                  # "terminal" | "code_editor" | "jupyter"
├── editor_language           # "python", "javascript", "bash", etc.
├── execution_environment     # JSON: Docker image, resources, etc.
├── starter_code              # TEXT: Initial code for editor
├── test_suite                # JSON: Automated tests
├── validation_rules          # JSON: How to grade submission
└── hints                     # JSON: Progressive hints system

# Quiz Metadata (Enhance existing)
quizzes
├── quiz_type                 # "multiple_choice", "coding", "essay"
├── time_limit_minutes
├── passing_score
├── randomize_questions
├── show_correct_answers
└── adaptive_difficulty       # Boolean: adjust based on performance

# Adaptive Learning Config (NEW)
adaptive_learning_rules
├── id
├── course_id
├── rule_type                 # "prerequisite", "remediation", "enrichment"
├── conditions                # JSON: { mastery_threshold: 0.8, ... }
├── actions                   # JSON: What items to recommend
└── priority

# Personalization Settings (NEW)
user_learning_preferences
├── user_id
├── course_id
├── preferred_difficulty
├── learning_pace             # "slow", "moderate", "fast"
├── preferred_content_types   # JSON: ["video", "text", "interactive"]
└── notification_settings
```

**Migration Strategy:**
1. Extend existing models (don't rebuild)
2. Create migration for new fields
3. Data migration script for existing content
4. Backfill from lib/ hardcoded content

---

## Phase 3: Smart Content Type System

### Current System (Good Foundation)
You already have polymorphic content via `CourseItem`:
- `CourseLesson`
- `InteractiveLearningUnit`
- `Quiz`
- `HandsOnLab`

### Enhancement: Lab Type Abstraction

**Create Lab Strategy Pattern:**

```ruby
# app/models/labs/
labs/
├── base_lab.rb              # Abstract base class
├── terminal_lab.rb          # Terminal-based execution
├── code_editor_lab.rb       # Code editor with language support
├── jupyter_lab.rb           # Jupyter notebooks (future)
└── visual_editor_lab.rb     # Block-based coding (future)

# Example Implementation
class Labs::TerminalLab < Labs::BaseLab
  def execute(command, session_id)
    DockerExecutor.run(
      image: config.docker_image,
      command: command,
      session: session_id,
      timeout: config.timeout
    )
  end

  def validate(output)
    ValidationEngine.check(output, config.validation_rules)
  end
end

class Labs::CodeEditorLab < Labs::BaseLab
  def execute(code, language)
    CodeRunner.execute(
      code: code,
      language: language,
      tests: config.test_suite,
      timeout: config.timeout
    )
  end

  def provide_hints(attempt_count)
    HintEngine.progressive_hints(config.hints, attempt_count)
  end
end
```

**Benefits:**
- Easy to add new lab types (VR, simulations, etc.)
- Consistent interface for React frontend
- Isolated testing per lab type

---

## Phase 4: Adaptive Learning & Personalization Engine

### Leverage Existing FSRS System

You already have sophisticated spaced repetition. **Enhance with:**

```ruby
# app/services/adaptive_learning/
adaptive_learning/
├── path_generator.rb        # Generates personalized learning paths
├── difficulty_adjuster.rb   # Adjusts content difficulty
├── remediation_engine.rb    # Identifies weak areas (already exists)
├── recommendation_engine.rb # Next-item recommendations
└── mastery_tracker.rb       # Tracks concept mastery (enhance existing)

# Example: Dynamic Path Generation
class AdaptiveLearning::PathGenerator
  def initialize(user, course)
    @user = user
    @course = course
    @mastery_levels = MasteryTracker.for_user_course(user, course)
  end

  def generate_path
    # 1. Assess current mastery levels
    # 2. Identify knowledge gaps
    # 3. Select appropriate difficulty
    # 4. Balance content types (lessons, labs, quizzes)
    # 5. Apply spaced repetition schedule
    # 6. Factor in user preferences

    path = []
    path << select_foundational_items
    path << select_progressive_items
    path << inject_review_items
    path << suggest_enrichment_items
    path
  end

  private

  def select_progressive_items
    # Use existing ProgressiveDifficultySelector
    # Enhanced with personalization
  end
end
```

**Personalization Features:**
1. **Learning Pace Adjustment**: Fast/medium/slow learners
2. **Content Type Preference**: More labs vs. more reading
3. **Difficulty Calibration**: Based on performance history
4. **Time-Based Scheduling**: When user prefers to study
5. **Remediation Loops**: Auto-retry weak concepts

---

## Phase 5: React Frontend Integration

### Optimized API Design for React

**1. Reduce API Calls with Smart Bundling:**

```ruby
# Instead of multiple calls, bundle related data
GET /api/v1/courses/:id/full
{
  course: { ... },
  modules: [ ... ],
  progress: { completion: 45%, mastery: 72% },
  next_items: [ ... ],
  due_reviews: 3
}
```

**2. Real-Time Updates via ActionCable:**

```ruby
# app/channels/
learning_channel.rb      # Real-time progress updates
lab_execution_channel.rb # Live lab output streaming
quiz_channel.rb          # Live quiz timer/events
```

**React Benefits:**
- WebSocket for live lab output (terminal streaming)
- Optimistic UI updates
- Offline-first with service workers
- Progressive loading

**3. GraphQL Alternative (Optional):**

Consider GraphQL for complex queries:
```graphql
query LearningDashboard {
  user {
    currentCourses {
      progress
      nextItems(limit: 5)
      dueReviews
    }
  }
}
```

---

## Phase 6: Performance & Caching Strategy

### Current Issue
Courses/modules rebuilt on every request.

### Solution: Multi-Layer Caching

```ruby
# 1. Redis Caching Layer
class Course < ApplicationRecord
  def self.cached_with_modules(course_id)
    Rails.cache.fetch("course:#{course_id}:full", expires_in: 1.hour) do
      Course.includes(:modules, :items).find(course_id).as_json(
        include: { modules: { include: :items } }
      )
    end
  end
end

# 2. Fragment Caching in Controllers
def show
  @course = Course.find(params[:id])
  render json: Rails.cache.fetch("course:#{@course.id}:api:v#{@course.updated_at.to_i}") do
    CourseSerializer.new(@course).as_json
  end
end

# 3. HTTP Caching Headers
def show
  @course = Course.find(params[:id])

  if stale?(last_modified: @course.updated_at, etag: @course)
    render json: @course
  end
end

# 4. Background Cache Warming
class CacheWarmerJob < ApplicationJob
  def perform
    Course.published.each do |course|
      Course.cached_with_modules(course.id)
    end
  end
end
```

**Cache Invalidation:**
```ruby
# app/models/concerns/cache_sweeper.rb
module CacheSweeper
  extend ActiveSupport::Concern

  included do
    after_save :clear_cache
    after_destroy :clear_cache
  end

  def clear_cache
    Rails.cache.delete_matched("course:#{course_id}:*")
  end
end
```

---

## Phase 7: Automated Testing & Quality Assurance

### Test Strategy for Course Content

```ruby
# spec/support/course_factory.rb
# Make it trivial to test new courses

FactoryBot.define do
  factory :course_with_full_content do
    transient do
      modules_count { 3 }
      lessons_per_module { 4 }
      labs_per_module { 2 }
      quizzes_per_module { 1 }
    end

    after(:create) do |course, evaluator|
      create_list(:course_module_with_items,
                  evaluator.modules_count,
                  course: course)
    end
  end
end

# spec/requests/api/v1/courses_spec.rb
RSpec.describe "Courses API", type: :request do
  describe "GET /api/v1/courses/:id" do
    let(:course) { create(:course_with_full_content) }

    it "returns complete course structure" do
      get "/api/v1/courses/#{course.id}"

      expect(response).to have_http_status(:success)
      expect(json['modules'].size).to eq(3)
      expect(json['modules'][0]['items'].size).to eq(7) # 4 lessons + 2 labs + 1 quiz
    end
  end
end
```

**Integration Testing:**
- Test each lab type execution
- Test adaptive learning path generation
- Test quiz grading logic
- Test progress tracking accuracy

---

## Phase 8: Course Authoring Workflow

### Make Adding a Course Trivial

**Option A: Admin Dashboard (React)**
Build a React admin UI where educators can:
1. Create course outline (drag-and-drop modules)
2. Add items (lessons, labs, quizzes)
3. Configure lab environments
4. Set adaptive learning rules
5. Preview & publish

**Option B: Course DSL (Developer-Friendly)**

```ruby
# db/seeds/courses/docker_fundamentals.rb
Course.build do
  name "Docker Fundamentals"
  slug "docker-track"
  category "containers"

  module "Introduction to Docker" do
    lesson "What is Docker?" do
      content_markdown "path/to/lesson1.md"
      video_url "https://..."
      estimated_minutes 15
    end

    terminal_lab "Your First Container" do
      description "Run your first Docker container"
      docker_image "ubuntu:20.04"

      steps [
        { instruction: "Pull the Ubuntu image", command: "docker pull ubuntu:20.04" },
        { instruction: "Run the container", command: "docker run -it ubuntu:20.04" }
      ]

      validation do
        check_output_contains "ubuntu"
        check_exit_code 0
      end
    end

    quiz "Docker Basics Quiz" do
      question "What is a Docker container?", type: :multiple_choice do
        option "A virtual machine", correct: false
        option "An isolated process", correct: true
        option "A programming language", correct: false
      end
    end
  end

  module "Advanced Docker" do
    # ...
  end
end
```

**Option C: JSON/YAML Import**
Allow importing courses from structured files:

```yaml
# courses/docker-fundamentals.yml
name: Docker Fundamentals
slug: docker-track
modules:
  - name: Introduction
    items:
      - type: lesson
        title: What is Docker?
        content_path: lessons/docker-intro.md
      - type: terminal_lab
        title: First Container
        config:
          docker_image: ubuntu:20.04
          steps: [...]
```

**Recommended: Start with Option C (YAML), build Option A later**

---

## Implementation Roadmap

### Sprint 1: Foundation (Week 1-2)
- [ ] Create unified courses controller
- [ ] Consolidate API endpoints
- [ ] Add course slug routing
- [ ] Update schema for lab_type
- [ ] Write integration tests

**Deliverable**: Single API endpoint working for 2-3 courses

### Sprint 2: Lab System (Week 3-4)
- [ ] Extract lab types (terminal, code_editor)
- [ ] Create LabExecutor strategy pattern
- [ ] Add code execution service
- [ ] Implement lab validation engine
- [ ] Build WebSocket streaming for labs

**Deliverable**: Both lab types working via unified API

### Sprint 3: Adaptive Learning (Week 5-6)
- [ ] Build PathGenerator service
- [ ] Enhance mastery tracking
- [ ] Create RecommendationEngine
- [ ] Add personalization preferences
- [ ] Implement difficulty adjustment

**Deliverable**: Personalized learning paths per user

### Sprint 4: Performance (Week 7)
- [ ] Implement Redis caching
- [ ] Add HTTP cache headers
- [ ] Create cache warming jobs
- [ ] Database query optimization
- [ ] Add monitoring/instrumentation

**Deliverable**: <100ms API response times

### Sprint 5: Course Authoring (Week 8-9)
- [ ] Design YAML course schema
- [ ] Build course importer
- [ ] Create validation system
- [ ] Write course authoring docs
- [ ] Migrate 2-3 existing courses

**Deliverable**: Add new course in 30 minutes

### Sprint 6: Testing & Polish (Week 10)
- [ ] Comprehensive test coverage
- [ ] API documentation (OpenAPI/Swagger)
- [ ] React integration examples
- [ ] Performance testing
- [ ] Security audit

**Deliverable**: Production-ready system

---

## Success Metrics

### Before Refactoring
- Add new course: **2-3 days** (duplicate controller, models, etc.)
- API response time: **500-1000ms** (no caching)
- Code duplication: **~2000 lines** across 11 controllers
- Test coverage: **Unknown**

### After Refactoring
- Add new course: **30 minutes** (YAML import)
- API response time: **<100ms** (Redis caching)
- Code duplication: **0** (unified controllers)
- Test coverage: **>90%**

---

## Risk Mitigation

### Breaking Changes
- Keep old API routes during migration
- Version API (`/api/v2/`)
- Gradual migration per course

### Data Migration
- Run migrations in staging first
- Create rollback scripts
- Test with production data snapshots

### Performance
- Load test with realistic data (1000 users, 20 courses)
- Monitor Redis memory usage
- Set up alerts for slow queries

---

## Technology Stack Recommendations

### Already Using (Keep)
- Rails 6.0
- PostgreSQL
- Redis
- Sidekiq
- RSpec

### Add for Enhanced Functionality
- **Bullet** (N+1 query detection)
- **Rack::Attack** (Rate limiting)
- **Jbuilder** (JSON templating)
- **ActiveModel::Serializers** (API serialization)
- **Pundit** (Authorization)

### React Frontend Stack (Suggestion)
- **React Query** (Data fetching/caching)
- **Zustand** (State management)
- **CodeMirror** (Code editor for labs)
- **xterm.js** (Terminal emulator for terminal labs)
- **TailwindCSS** (Styling)

---

## Next Steps

1. **Review this plan** - Discuss priorities and adjustments
2. **Spike on unified API** - Prototype one course using new API
3. **Data model updates** - Create migrations for new schema
4. **Choose authoring method** - YAML, DSL, or admin UI
5. **Start Sprint 1** - Begin implementation

---

## Questions to Discuss

1. **Timeline**: Is 10-week timeline acceptable, or need faster MVP?
2. **Lab Priority**: Terminal labs first, or both types simultaneously?
3. **Course Authoring**: Technical team using YAML/DSL, or need non-technical admin UI?
4. **Authentication**: JWT, OAuth, or API keys for React frontend?
5. **Deployment**: Current infrastructure (AWS, Docker, K8s)?
6. **Existing Courses**: Migrate all 11 courses, or start fresh with 2-3?

---

**Ready to start? Let's prioritize and begin Sprint 1!**
