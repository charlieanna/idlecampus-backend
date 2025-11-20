# Course Adaptation System

## Overview

The Course Adaptation System automatically tracks when users struggle during labs and generates recommendations to improve course content. When multiple users struggle with the same lab or concept, the system flags it for review and suggests specific adaptations like adding more practice, better explanations, or hints.

## Key Features

1. **Automatic Struggle Detection**: Analyzes lab sessions to detect when users are struggling
2. **Struggle Scoring**: Calculates a struggle score (0-1) based on multiple factors
3. **Aggregation**: Combines struggles across multiple users to identify systemic issues
4. **Smart Recommendations**: Suggests specific adaptations based on struggle patterns
5. **Review Workflow**: Allows instructors to review, approve, and implement adaptations

## Architecture

### Models

#### `LabSession`
- Extended with struggle tracking fields:
  - `struggle_score` (decimal): Calculated struggle score (0-1)
  - `struggle_indicators` (JSON): Detailed breakdown of struggle factors
  - `flagged_for_review` (boolean): Critical struggles flagged for immediate review

#### `HandsOnLab`
- Extended with aggregate metrics:
  - `total_struggles` (integer): Count of users who struggled
  - `average_struggle_score` (decimal): Average struggle score
  - `needs_adaptation` (boolean): Flag indicating adaptation needed

#### `CourseAdaptation`
- Tracks needed course changes:
  - `adaptable` (polymorphic): Lab, module, or lesson needing adaptation
  - `adaptation_type`: Type of change needed (add_practice, add_explanation, etc.)
  - `severity`: low, medium, high, critical
  - `status`: pending, in_review, approved, implemented, dismissed
  - `affected_users_count`: Number of users struggling
  - `average_struggle_score`: Average struggle score
  - `common_failure_points`: Array of specific pain points
  - `common_errors`: Array of recurring errors
  - `suggested_changes`: Recommended improvements

### Services

#### `LabStruggleAnalyzer`
Analyzes individual lab sessions to detect struggles.

**Struggle Score Components:**
1. **Hints Usage** (max 0.25): More hints = higher struggle
2. **Time Taken** (max 0.25): Taking 2x+ expected time
3. **Validation Failures** (max 0.25): Failed step validations
4. **Error Patterns** (max 0.15): Recurring error types
5. **Completion Ratio** (max 0.10): Low completion percentage

**Methods:**
- `calculate_struggle_score()`: Returns score 0.0 to 1.0
- `struggling?()`: Returns true if score >= 0.6
- `critical_struggle?()`: Returns true if score >= 0.8
- `identify_pain_points()`: Returns array of specific issues
- `recommended_interventions()`: Returns suggested actions

#### `CourseAdaptationService`
Aggregates struggles and manages course adaptations.

**Methods:**
- `record_lab_struggle(lab_session:, ...)`: Records struggle for adaptation tracking
- `analyze_lab_struggles(lab_id)`: Analyzes all struggles for a lab
- `analyze_module_struggles(module_id)`: Analyzes struggles across module
- `auto_suggest_adaptations()`: Auto-creates adaptations for struggling content
- `adaptation_summary()`: Dashboard summary
- `pending_adaptations()`: Gets all pending adaptations grouped by severity

## Usage

### Automatic Struggle Tracking

Struggles are automatically tracked when:
1. Lab session is completed
2. Struggle score is calculated via `lab_session.calculate_struggle_score!`
3. If struggling (score >= 0.6), recorded for adaptation via `record_for_adaptation!`

### Manual Struggle Calculation

```ruby
# For an active or completed lab session
lab_session = LabSession.find(session_id)
lab_session.calculate_struggle_score!

# Check if struggling
if lab_session.struggling?
  pain_points = lab_session.pain_points
  interventions = lab_session.recommended_interventions
end
```

### Analyzing Lab Struggles

```ruby
# Get analysis for a specific lab
analysis = CourseAdaptationService.analyze_lab_struggles(lab_id)
# Returns:
# {
#   lab: <HandsOnLab>,
#   total_struggles: 5,
#   average_struggle_score: 0.72,
#   common_pain_points: {"validation_failures" => 3, "time_exceeded" => 2},
#   common_errors: ["permission_errors" => 2, "syntax_errors" => 1],
#   recommendations: [
#     {type: 'add_explanation', priority: 'high', suggestion: '...'},
#     ...
#   ]
# }
```

### Auto-Suggesting Adaptations

```ruby
# Scan all labs and create adaptations where needed
adaptations = CourseAdaptationService.auto_suggest_adaptations
# Creates CourseAdaptation records for labs with >= 3 struggling users
```

## API Endpoints

### GET `/api/v1/course_adaptations`
List course adaptations with filtering.

**Query Parameters:**
- `status`: Filter by status (pending, in_review, approved, implemented, dismissed)
- `severity`: Filter by severity (low, medium, high, critical)
- `adaptable_type`: Filter by type (HandsOnLab, CourseModule)
- `group_by`: Group results (e.g., "severity")
- `page`, `per_page`: Pagination

**Example:**
```bash
GET /api/v1/course_adaptations?status=pending&severity=critical
```

**Response:**
```json
{
  "success": true,
  "adaptations": [
    {
      "id": 1,
      "adaptable_type": "HandsOnLab",
      "adaptable_id": 42,
      "adaptable_title": "Docker Networking Basics",
      "adaptation_type": "add_explanation",
      "adaptation_type_label": "Add explanation",
      "severity": "critical",
      "severity_label": "🔴 Critical",
      "status": "pending",
      "status_label": "⏳ Pending",
      "reason": "5 users struggling: Multiple validation failures; Taking 2.5x longer than expected",
      "affected_users_count": 5,
      "average_struggle_score": 0.78,
      "created_at": "2025-11-10T12:00:00Z"
    }
  ],
  "pagination": {...}
}
```

### GET `/api/v1/course_adaptations/summary`
Dashboard summary of all adaptations.

**Response:**
```json
{
  "success": true,
  "summary": {
    "total_pending": 15,
    "total_in_review": 3,
    "critical": 2,
    "high_priority": 7,
    "by_type": {
      "add_explanation": 5,
      "add_hints": 4,
      "simplify_content": 3,
      "add_practice": 3
    },
    "recent_adaptations": [...]
  }
}
```

### GET `/api/v1/course_adaptations/:id`
Get detailed information about a specific adaptation.

**Response:**
```json
{
  "success": true,
  "adaptation": {
    "id": 1,
    ...
    "common_failure_points": [
      "User failed on steps: 2, 3",
      "Multiple validation failures (5)"
    ],
    "common_errors": ["permission_errors", "command_not_found"],
    "suggested_changes": "Add clearer validation instructions and expected output examples\n\nProvide progressive hints for step 2",
    "recommended_resources": []
  }
}
```

### GET `/api/v1/course_adaptations/lab/:lab_id/analysis`
Analyze struggles for a specific lab.

**Response:**
```json
{
  "success": true,
  "analysis": {
    "lab": {...},
    "total_struggles": 5,
    "average_struggle_score": 0.72,
    "common_pain_points": {
      "validation_failures": 3,
      "time_exceeded": 2,
      "step_failures": 4
    },
    "common_errors": {
      "permission_errors": 2,
      "command_not_found": 1
    },
    "recommendations": [
      {
        "type": "add_explanation",
        "priority": "high",
        "suggestion": "Add more detailed explanations for validation requirements"
      },
      {
        "type": "add_hints",
        "priority": "high",
        "suggestion": "Add progressive hints for difficult steps"
      }
    ]
  }
}
```

### POST `/api/v1/course_adaptations/:id/approve`
Approve an adaptation (admin/instructor only).

**Response:**
```json
{
  "success": true,
  "message": "Adaptation approved successfully",
  "adaptation": {...}
}
```

### POST `/api/v1/course_adaptations/:id/dismiss`
Dismiss an adaptation (admin/instructor only).

**Body:**
```json
{
  "reason": "Already addressed in recent update"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Adaptation dismissed",
  "adaptation": {...}
}
```

### POST `/api/v1/course_adaptations/:id/implement`
Mark adaptation as implemented (admin/instructor only).

**Body:**
```json
{
  "implementation_notes": "Added 3 new hints and expanded validation examples"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Adaptation marked as implemented",
  "adaptation": {...}
}
```

### POST `/api/v1/course_adaptations/auto_suggest`
Automatically scan and create adaptations (admin/instructor only).

**Response:**
```json
{
  "success": true,
  "message": "Created 8 adaptation suggestions",
  "adaptations": [...]
}
```

## Workflow

### 1. User Takes Lab
```
User starts lab → Lab session created with status: active
↓
User works through steps (commands, validations, hints)
↓
System tracks: hints_used, validation_results, errors, time_spent
↓
User completes lab → Lab session status: completed
```

### 2. Automatic Struggle Detection
```
Lab session completed
↓
calculate_struggle_score! is called automatically
↓
Struggle score calculated (0.0 to 1.0)
  - Hints usage
  - Time taken vs expected
  - Validation failures
  - Error patterns
  - Completion ratio
↓
If score >= 0.6 (struggling):
  - struggle_indicators saved
  - flagged_for_review = true (if score >= 0.8)
  - record_for_adaptation! triggered
```

### 3. Course Adaptation Creation
```
record_for_adaptation! called
↓
CourseAdaptationService.record_lab_struggle
↓
Find or create CourseAdaptation for this lab
↓
Update adaptation:
  - Increment affected_users_count
  - Update average_struggle_score
  - Add failure points
  - Add common errors
  - Update suggested_changes
↓
Recalculate severity based on:
  - Number of affected users
  - Average struggle score
  - Count of failure points
```

### 4. Review and Implementation
```
Instructor views pending adaptations
↓
Reviews details: pain points, errors, suggestions
↓
Makes decision:
  ├─ Approve → Status: approved
  ├─ Dismiss → Status: dismissed (with reason)
  └─ Mark In Review → Status: in_review
↓
Implements changes (adds hints, explanations, etc.)
↓
Marks as Implemented → Status: implemented
```

## Thresholds and Constants

### Struggle Detection
- **Struggling Threshold**: 0.6 (60%)
- **Critical Threshold**: 0.8 (80%)
- **Minimum Affected Users**: 3 users needed before creating adaptation

### Severity Calculation
- **Low**: Score 0-2
  - Few users (1-2) or low struggle scores
- **Medium**: Score 3-4
  - 3-4 users or moderate struggle (0.6-0.7)
- **High**: Score 5-6
  - 5-9 users or high struggle (0.7-0.8)
- **Critical**: Score 7+
  - 10+ users or very high struggle (0.8+)

## Best Practices

### For Developers

1. **Always calculate struggle scores** when completing lab sessions
2. **Use callbacks** to automatically trigger adaptation recording
3. **Monitor aggregate metrics** on labs to identify trends
4. **Run auto_suggest_adaptations** periodically (e.g., daily via cron job)

### For Instructors

1. **Review pending adaptations** regularly (check dashboard)
2. **Prioritize critical and high severity** adaptations first
3. **Look at common failure points** to understand root causes
4. **Implement suggestions** and mark adaptations as implemented
5. **Dismiss with reasons** if adaptation is not applicable

### For Admins

1. **Monitor adaptation trends** across all courses
2. **Identify problematic labs** with high struggle rates
3. **Allocate resources** to address critical adaptations
4. **Track implementation rates** to ensure issues are resolved

## Database Schema

### Migration: `create_course_adaptations`

```ruby
create_table :course_adaptations do |t|
  t.references :adaptable, polymorphic: true, null: false
  t.references :course_module, foreign_key: true
  t.string :adaptation_type, null: false
  t.string :severity, default: 'medium'
  t.text :reason, null: false
  t.json :struggle_metrics, default: {}
  t.integer :affected_users_count, default: 0
  t.decimal :average_struggle_score, precision: 3, scale: 2
  t.json :common_failure_points, default: []
  t.json :common_errors, default: []
  t.string :status, default: 'pending'
  t.text :resolution_notes
  t.datetime :reviewed_at
  t.references :reviewed_by, foreign_key: { to_table: :users }
  t.datetime :implemented_at
  t.text :suggested_changes
  t.json :recommended_resources, default: []
  t.timestamps
end

# Lab session extensions
add_column :lab_sessions, :struggle_score, :decimal, precision: 3, scale: 2
add_column :lab_sessions, :struggle_indicators, :json, default: {}
add_column :lab_sessions, :flagged_for_review, :boolean, default: false

# Hands-on lab extensions
add_column :hands_on_labs, :total_struggles, :integer, default: 0
add_column :hands_on_labs, :average_struggle_score, :decimal, precision: 3, scale: 2
add_column :hands_on_labs, :needs_adaptation, :boolean, default: false
```

## Testing

Run the migration:
```bash
rails db:migrate
```

Test struggle detection:
```ruby
# In rails console
lab_session = LabSession.last
lab_session.calculate_struggle_score!
puts lab_session.struggle_score
puts lab_session.struggling?
puts lab_session.pain_points.inspect
```

Test adaptation creation:
```ruby
# Trigger adaptation
lab_session.record_for_adaptation! if lab_session.struggling?

# View adaptations
CourseAdaptation.pending.each do |adaptation|
  puts "#{adaptation.severity_label} - #{adaptation.summary}"
end
```

Test API endpoints:
```bash
# Get pending adaptations
curl http://localhost:3000/api/v1/course_adaptations?status=pending

# Get summary
curl http://localhost:3000/api/v1/course_adaptations/summary

# Analyze lab struggles
curl http://localhost:3000/api/v1/course_adaptations/lab/42/analysis
```

## Future Enhancements

1. **ML-based Predictions**: Use machine learning to predict struggles before they happen
2. **Automated A/B Testing**: Test different adaptations to see which work best
3. **Personalized Interventions**: Customize interventions based on user learning style
4. **Real-time Alerts**: Notify instructors immediately when critical struggles occur
5. **Adaptation Analytics**: Track effectiveness of implemented adaptations
6. **Multi-level Aggregation**: Roll up struggles from labs → modules → courses
7. **Integration with LMS**: Push adaptations to external learning management systems

## Support

For questions or issues, please contact the development team or open an issue in the project repository.
