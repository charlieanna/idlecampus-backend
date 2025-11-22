# Cross-Course Knowledge Tracking System

## Overview

The Cross-Course Knowledge Tracking System is an intelligent learning advisor that tracks student knowledge across **ALL courses** and provides AI-powered recommendations for what to learn next. It goes beyond per-course tracking to give a holistic view of a student's complete skill profile.

## The Big Picture

```
Student learns across multiple courses:
├── Docker Fundamentals (85% complete)
├── Linux Basics (90% complete)
├── Kubernetes (30% complete)
└── Python (0% not started)

System tracks:
├── Global Skills: { "docker": 85, "linux": 90, "kubernetes": 30, "python": 0 }
├── Strong Areas: ["linux", "docker"]
├── Weak Areas: ["kubernetes"]
├── Learning Goals: ["DevOps Engineer"]

AI Tutor suggests:
"You've mastered Docker (85%) and Linux (90%)! Since you understand
containers, you're READY to complete Kubernetes. It builds directly on
your Docker knowledge. After that, try Python for DevOps automation!"
```

## Key Features

### 1. **Global Skill Profile**
Aggregates knowledge from ALL courses into a single profile:
- Skill levels (0-100) for each technology
- Strong areas (75+ proficiency)
- Weak areas (<40 proficiency)
- Overall level and total points
- Learning goals

### 2. **Course Prerequisites**
Maps course dependencies:
- Required prerequisites (must complete first)
- Recommended prerequisites (helpful but not required)
- Skill requirements (e.g., "Docker: 70%" to start Kubernetes)

### 3. **Learning Paths**
Predefined career paths:
- DevOps Engineer
- Backend Developer
- Go Developer
- System Administrator
- Full Stack Developer

### 4. **AI-Powered Recommendations**
Uses Ollama to suggest next courses based on:
- Current skill levels
- Completed courses
- Learning goals
- Knowledge gaps
- Prerequisites met

### 5. **Automatic Updates**
Skill profile automatically updates when:
- Module completed
- Course finished
- Progress made

## Architecture

### Database Schema

#### `user_skill_profile_v2`
Global knowledge profile for each user.

```typescript
{
  userId: string (primary key)
  skills: { "docker": 85, "kubernetes": 30, ... }
  weakAreas: ["networking", "golang"]
  strongAreas: ["linux", "docker"]
  learningGoals: ["DevOps Engineer", "Backend Developer"]
  totalCoursesStarted: 5
  totalCoursesCompleted: 2
  overallLevel: 8
  totalPoints: 750
  lastUpdated: timestamp
}
```

#### `course_prerequisites_v2`
Defines course relationships.

```typescript
{
  courseId: "kubernetes-basics"
  prerequisiteCourseId: "docker-fundamentals"
  isRequired: true
  skillsRequired: { "docker": 70, "linux": 60 }
}
```

#### `learning_recommendations_v2`
AI-generated course suggestions.

```typescript
{
  id: uuid
  userId: string
  recommendedCourseId: "kubernetes-basics"
  reason: "You've mastered Docker (85%). Kubernetes builds on this..."
  priority: 8 (1-10)
  confidence: 85 (0-100)
  metadata: { prerequisitesMet: true, fillsKnowledgeGap: true }
  isAccepted: boolean
  isDismissed: boolean
  createdAt: timestamp
}
```

### Services

#### `services/skillAggregationService.ts`
Calculates global skill profile from course progress.

**Key Functions:**
- `updateUserSkillProfile(userId)` - Recalculate all skills
- `getSkillProfile(userId)` - Get current profile
- `setLearningGoals(userId, goals)` - Set career goals
- `getSkillLevel(userId, skill)` - Get level for specific skill

**Skill Calculation:**
```typescript
// Course progress → Skill level
0-30%: Basic understanding
31-60%: Moderate proficiency
61-85%: Strong skills
86-100%: Expert level

// Complexity multiplier
Beginner course: 1.0x
Intermediate: 1.3x
Advanced: 1.6x
```

#### `services/coursePrerequisitesService.ts`
Defines course relationships and learning paths.

**Key Data:**
- `COURSE_PREREQUISITES_MAP` - Course dependencies
- `COURSE_SKILL_TAGS` - Skills taught by each course
- `LEARNING_PATHS` - Career path definitions

**Key Functions:**
- `getCoursePrerequisites(courseId)` - Get prerequisites
- `meetsPrerequisites(courseId, userSkills)` - Check if ready
- `getLearningPath(goalId)` - Get career path
- `getCourseSkills(courseId)` - Get skills taught

#### `services/recommendationEngine.ts`
AI-powered course recommendations.

**Key Functions:**
- `generateRecommendations(userId)` - Generate top 5 recommendations
- `getRecommendations(userId)` - Get saved recommendations
- `dismissRecommendation(userId, courseId)` - Hide recommendation
- `acceptRecommendation(userId, courseId)` - Mark as started

**Recommendation Algorithm:**
```
Priority Score (0-10):
+3: Prerequisites met
+4: Fills knowledge gap
+5: Aligns with learning goals
+2: Natural progression (just completed prerequisite)

Confidence Score (0-100):
+30: Prerequisites met
+25: Fills knowledge gap
+35: Aligns with goals
+10: Natural progression
```

### API Endpoints

All endpoints require authentication unless marked optional.

#### Skill Profile

```
GET /api/learning/profile
Get user's global skill profile

Response:
{
  profile: {
    userId: "user123",
    skills: { "docker": 85, "kubernetes": 30 },
    weakAreas: ["kubernetes"],
    strongAreas: ["docker", "linux"],
    learningGoals: ["DevOps Engineer"],
    totalCoursesStarted: 5,
    totalCoursesCompleted: 2,
    overallLevel: 8,
    totalPoints: 750
  }
}
```

```
POST /api/learning/profile/refresh
Recalculate skill profile from latest progress

Response:
{
  profile: {...},
  updated: true
}
```

```
PUT /api/learning/goals
Set learning goals

Body: { goals: ["DevOps Engineer", "Backend Developer"] }

Response: { success: true, goals: [...] }
```

#### Recommendations

```
GET /api/learning/recommendations
Get AI-generated course recommendations

Response:
{
  recommendations: [
    {
      courseId: "kubernetes-basics",
      courseName: "Kubernetes Fundamentals",
      courseDescription: "...",
      reason: "You've mastered Docker (85%). Kubernetes builds...",
      priority: 8,
      confidence: 85,
      metadata: {
        prerequisitesMet: true,
        fillsKnowledgeGap: true,
        alignsWithGoals: true,
        difficulty: "intermediate"
      }
    }
  ],
  count: 5
}
```

```
POST /api/learning/recommendations/generate
Force regenerate recommendations

Response: { recommendations: [...], count: 5, generated: true }
```

```
POST /api/learning/recommendations/:courseId/dismiss
Dismiss a recommendation

Response: { success: true }
```

```
POST /api/learning/recommendations/:courseId/accept
Accept recommendation (mark as started)

Response: { success: true, courseId: "..." }
```

#### Learning Paths

```
GET /api/learning/paths
Get all available learning paths

Response:
{
  paths: {
    "devops-engineer": {
      name: "DevOps Engineer",
      description: "Master containers, orchestration, and CI/CD",
      courses: ["linux-fundamentals", "docker-fundamentals", ...],
      coreSkills: ["docker", "kubernetes", "linux", "ci-cd"]
    },
    ...
  }
}
```

```
GET /api/learning/paths/:goalId
Get specific learning path

Response: { path: {...} }
```

#### Prerequisites

```
GET /api/learning/courses/:courseId/prerequisites
Get prerequisites for a course (optional auth)

Response:
{
  prerequisites: {
    courseId: "kubernetes-basics",
    courseName: "Kubernetes Fundamentals",
    prerequisites: [
      {
        courseId: "docker-fundamentals",
        courseName: "Docker Fundamentals",
        isRequired: true,
        skillsRequired: { "docker": 70 }
      }
    ]
  },
  meetsRequirements: {  // Only if authenticated
    meets: false,
    missing: ["docker-fundamentals"],
    skillGaps: { "docker": { current: 50, required: 70 } }
  }
}
```

## Integration with Progress Tracking

### Automatic Skill Profile Updates

When a module is completed (`courseV2Controller.ts:267-271`):

```typescript
// Update global skill profile
await skillAggService.updateUserSkillProfile(userId);

// Generate new recommendations
await recommendationEngine.generateRecommendations(userId);
```

This ensures the skill profile is always up-to-date and recommendations reflect latest progress.

## Usage Examples

### Frontend: Display Skill Profile

```typescript
async function loadSkillProfile() {
  const response = await fetch('/api/learning/profile');
  const { profile } = await response.json();

  // Display skills
  Object.entries(profile.skills).forEach(([skill, level]) => {
    displaySkillBar(skill, level);
  });

  // Show strong/weak areas
  displayStrongAreas(profile.strongAreas);
  displayWeakAreas(profile.weakAreas);

  // Show overall progress
  displayLevel(profile.overallLevel);
  displayPoints(profile.totalPoints);
}
```

### Frontend: Get Recommendations

```typescript
async function loadRecommendations() {
  const response = await fetch('/api/learning/recommendations');
  const { recommendations } = await response.json();

  recommendations.forEach(rec => {
    displayRecommendation({
      title: rec.courseName,
      reason: rec.reason,
      priority: rec.priority,
      onAccept: () => acceptRecommendation(rec.courseId),
      onDismiss: () => dismissRecommendation(rec.courseId)
    });
  });
}

async function acceptRecommendation(courseId) {
  await fetch(`/api/learning/recommendations/${courseId}/accept`, {
    method: 'POST'
  });

  // Redirect to course
  window.location.href = `/courses/${courseId}`;
}
```

### Frontend: Set Learning Goals

```typescript
async function setGoals(selectedGoals) {
  await fetch('/api/learning/goals', {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ goals: selectedGoals })
  });

  // Refresh recommendations with new goals
  await fetch('/api/learning/recommendations/generate', { method: 'POST' });

  loadRecommendations();
}
```

## Example Scenarios

### Scenario 1: Complete Beginner

```
Initial State:
- Courses Started: 0
- Skills: {}
- Goals: ["DevOps Engineer"]

Recommendations:
1. Linux Fundamentals (Priority: 10)
   "Start here! Linux is the foundation for DevOps. Every tool you'll
    use runs on Linux."

2. Git Fundamentals (Priority: 9)
   "Version control is essential. Learn Git basics before diving into
    DevOps tools."
```

### Scenario 2: Completed Docker, Starting Kubernetes

```
Current State:
- Docker Fundamentals: 100% complete
- Linux Basics: 85% complete
- Skills: { "docker": 95, "linux": 85, "containers": 90 }
- Goals: ["DevOps Engineer"]

Recommendations:
1. Kubernetes Basics (Priority: 10, Confidence: 95%)
   "Perfect timing! You've mastered Docker (95%) and understand Linux.
    Kubernetes is the natural next step for container orchestration."

2. Docker Networking (Priority: 7, Confidence: 80%)
   "Strengthen your Docker knowledge with networking. This will help
    when you learn Kubernetes networking later."

3. CI/CD Pipeline (Priority: 6, Confidence: 70%)
   "You know Docker. Learn to automate deployments with CI/CD."
```

### Scenario 3: Mixed Progress, No Clear Path

```
Current State:
- Docker: 60% complete
- Python: 40% complete
- SQL: 70% complete
- Skills: { "docker": 60, "python": 40, "sql": 70 }
- Goals: Not set

Recommendations:
1. Complete SQL Basics (Priority: 8)
   "You're 70% through SQL. Finish strong! Databases are crucial for
    any developer path."

2. Complete Docker Fundamentals (Priority: 7)
   "You're over halfway through Docker (60%). Complete it to unlock
    Kubernetes and DevOps paths."

3. Python Web Development (Priority: 5)
   "You have Python basics (40%). Ready to build web applications?"
```

## Configuration

### Add New Course Prerequisites

Edit `services/coursePrerequisitesService.ts`:

```typescript
export const COURSE_PREREQUISITES_MAP = {
  'my-new-course': {
    prerequisites: ['prerequisite-course-id'],
    recommended: ['optional-course-id'],
    skillsRequired: { 'required-skill': 70 }
  }
};
```

### Add New Skills

Define skills taught by course:

```typescript
export const COURSE_SKILL_TAGS = {
  'my-course': ['skill1', 'skill2', 'skill3']
};
```

### Add New Learning Path

```typescript
export const LEARNING_PATHS = {
  'my-career-path': {
    name: 'My Career Path',
    description: 'Description here',
    courses: ['course1', 'course2', 'course3'],
    coreSkills: ['skill1', 'skill2']
  }
};
```

## Database Setup

Run migrations to create tables:

```sql
-- Global skill profile
CREATE TABLE user_skill_profile_v2 (
  user_id VARCHAR(255) PRIMARY KEY,
  skills JSONB DEFAULT '{}',
  weak_areas JSONB DEFAULT '[]',
  strong_areas JSONB DEFAULT '[]',
  learning_goals JSONB DEFAULT '[]',
  total_courses_started INTEGER DEFAULT 0,
  total_courses_completed INTEGER DEFAULT 0,
  overall_level INTEGER DEFAULT 1,
  total_points INTEGER DEFAULT 0,
  last_updated TIMESTAMP DEFAULT NOW()
);

-- Course prerequisites
CREATE TABLE course_prerequisites_v2 (
  course_id VARCHAR(255),
  prerequisite_course_id VARCHAR(255),
  is_required BOOLEAN DEFAULT TRUE,
  skills_required JSONB DEFAULT '{}',
  PRIMARY KEY (course_id, prerequisite_course_id)
);

-- Learning recommendations
CREATE TABLE learning_recommendations_v2 (
  id VARCHAR(255) PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id VARCHAR(255) NOT NULL,
  recommended_course_id VARCHAR(255) NOT NULL,
  reason TEXT NOT NULL,
  priority INTEGER DEFAULT 0,
  confidence INTEGER DEFAULT 0,
  metadata JSONB,
  is_accepted BOOLEAN,
  is_dismissed BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Indexes
CREATE INDEX idx_skill_profile_user ON user_skill_profile_v2(user_id);
CREATE INDEX idx_recommendations_user ON learning_recommendations_v2(user_id, is_dismissed);
CREATE INDEX idx_prerequisites_course ON course_prerequisites_v2(course_id);
```

Initialize prerequisites data:

```typescript
import coursePrereqService from './services/coursePrerequisitesService';

// Run once on setup
await coursePrereqService.initializePrerequisites();
```

## Performance Considerations

- **Skill Profile Calculation**: Only updates on module completion (not every item)
- **Recommendation Generation**: Cached, regenerates when:
  - Module completed
  - Learning goals changed
  - Manually requested
- **Ollama Calls**: Async, doesn't block main operations
- **Database Queries**: Optimized with indexes

## Monitoring

### Check Recommendation Quality

```sql
SELECT
  recommended_course_id,
  AVG(confidence) as avg_confidence,
  COUNT(*) as times_recommended,
  SUM(CASE WHEN is_accepted THEN 1 ELSE 0 END) as accepted,
  SUM(CASE WHEN is_dismissed THEN 1 ELSE 0 END) as dismissed
FROM learning_recommendations_v2
GROUP BY recommended_course_id;
```

### Track Skill Growth

```sql
SELECT
  user_id,
  jsonb_array_length(strong_areas) as strong_skills,
  total_courses_completed,
  overall_level
FROM user_skill_profile_v2
ORDER BY overall_level DESC;
```

## Future Enhancements

- [ ] Skill decay over time (reduce level if not practiced)
- [ ] Peer comparison ("You're in top 10% for Docker")
- [ ] Estimated time to complete learning path
- [ ] Skill certification badges
- [ ] Import skills from external sources (LinkedIn, GitHub)
- [ ] Team/organizational skill gap analysis
- [ ] Adaptive difficulty based on skill level
- [ ] Micro-recommendations (specific lessons within courses)

## License

Part of IdleCampus Backend.
