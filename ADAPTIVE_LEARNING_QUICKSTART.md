# Adaptive Learning System - Quick Start

## 🚀 What You Got

A complete **struggle detection and intervention system** that:

✅ **Detects** when users struggle (via struggle score 0.0-1.0)
✅ **Recommends** prerequisite problems automatically
✅ **Adjusts** difficulty based on performance
✅ **Prevents** burnout with break suggestions
✅ **Tracks** learning paths with topic/difficulty performance
✅ **Provides** personalized daily practice sets

## 📦 Setup (3 Steps)

```bash
# 1. Run migrations
rails db:migrate

# 2. Add routes to config/routes.rb
# Copy contents from config/routes_adaptive_learning.rb

# 3. Test it!
rails console
```

## 🎯 Core Concept: Struggle Detection

### Struggle Score Formula

```ruby
score = 0.0
score += 0.5 if attempts >= 5        # Multiple failures
score += 0.3 if hints_used >= 4      # Hint dependency
score += 0.5 if gave_up              # Gave up
score += 0.4 if viewed_solution      # Looked at solution
score += 0.4 if errors >= 6          # Many errors
score += 0.5 if time_ratio > 3.0     # Took 3x longer

# If score > 0.6 → User is STRUGGLING
```

## 🔄 How It Works (Example)

### Scenario: User Struggles

```
1. User attempts "Three Sum" (medium)
   ❌ Failed after 60 min (estimated: 30 min)
   ❌ Used 4 hints
   ❌ Made 5 errors
   → Struggle Score: 0.8

2. System automatically:
   ✓ Detects struggling
   ✓ Finds prerequisites
   ✓ Recommends easier problems

3. API Response:
   {
     "next_action": {
       "action": "review_prerequisites",
       "message": "Let's build a stronger foundation first",
       "problems": [
         "Two Sum (easy)",
         "Two Sum II (easy)",
         "Array Basics (easy)"
       ]
     },
     "struggle_analysis": {
       "struggling": true,
       "struggle_score": 0.8,
       "factors": {
         "hints_used": true,
         "many_errors": true
       }
     }
   }

4. User completes prerequisites → System recommends retry
```

## 📡 API Endpoints

### 1. Record Attempt (with auto struggle detection)

```bash
POST /api/v1/adaptive_learning/record_attempt

{
  "problem_slug": "two-sum",
  "attempt": {
    "success": false,
    "time_spent_seconds": 1800,
    "hints_used": 3,
    "syntax_errors": 2,
    "gave_up": false
  }
}

# Returns:
# - Attempt details
# - Next recommended action
# - Struggle analysis (if struggling)
```

### 2. Get Next Problem (adaptive)

```bash
GET /api/v1/adaptive_learning/next_problem

# Returns:
# - "standard" → Normal progression
# - "prerequisite" → Must complete prereqs first
# - "intervention" → User struggling, easier problems
# - "break" → Recommend taking a break
```

### 3. Get Prerequisites (when struggling)

```bash
GET /api/v1/adaptive_learning/prerequisites/three-sum

# Returns:
{
  "struggling": true,
  "prerequisites": [
    { "title": "Two Sum", "difficulty": "easy" },
    { "title": "Two Pointers Basics", "difficulty": "easy" }
  ],
  "message": "These 2 problems will help build the foundation"
}
```

### 4. Daily Practice Set

```bash
GET /api/v1/adaptive_learning/daily_practice

# Returns 3 problems:
# - 1 from weak topic (easier)
# - 1 at current level
# - 1 challenge problem
```

### 5. Learning Path Status

```bash
GET /api/v1/adaptive_learning/learning_path

# Returns:
# - Current difficulty & topic
# - Success rates by topic/difficulty
# - Weak/strong topics
# - Current streak
# - Personalized suggestions
```

### 6. Struggle Analysis

```bash
GET /api/v1/adaptive_learning/struggle_analysis

# Detects patterns:
# - Repeated failures
# - Hint dependency
# - Time struggles
# - Topic-specific struggles

# Provides interventions:
# - Review basics
# - Practice independently
# - Timed practice
# - Targeted practice
```

## 💻 Usage Examples

### Backend (Rails)

```ruby
# Record an attempt
user = User.find(1)
service = AdaptiveLearningService.new(user)

result = service.record_attempt(problem, {
  success: false,
  time_spent_seconds: 1800,
  hints_used: 4,
  gave_up: false
})

# Check if struggling
if result[:attempt].struggling?
  # Get prerequisites
  prereqs = result[:attempt].get_prerequisite_recommendations

  # Get easier alternatives
  easier = result[:attempt].get_easier_alternatives
end

# Get next recommendation
recommendation = service.recommend_next_problem

# Get daily practice
daily = service.generate_daily_practice
```

### Frontend (JavaScript)

```javascript
// Record attempt with struggle detection
const submitSolution = async (code) => {
  const response = await fetch('/api/v1/adaptive_learning/record_attempt', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      problem_slug: 'two-sum',
      attempt: {
        success: testsPassed,
        time_spent_seconds: elapsedTime,
        hints_used: hintsCount,
        syntax_errors: syntaxErrorCount
      }
    })
  });

  const data = await response.json();

  // Show struggle intervention if detected
  if (data.struggle_analysis?.struggling) {
    showStruggleDialog(data.next_action);
  } else {
    showSuccessDialog(data.next_action);
  }
};

// Get next problem
const getNextProblem = async () => {
  const response = await fetch('/api/v1/adaptive_learning/next_problem');
  const data = await response.json();

  switch (data.recommendation.type) {
    case 'intervention':
      // User struggling - show support message
      showIntervention(data.recommendation);
      break;
    case 'prerequisite':
      // Complete prerequisites first
      showPrerequisites(data.recommendation);
      break;
    case 'break':
      // Recommend break
      showBreakSuggestion(data.recommendation);
      break;
    default:
      // Normal progression
      showNextProblem(data.recommendation.problem);
  }
};
```

## 🎓 Key Models

### ProblemAttempt

```ruby
# Tracks each attempt with struggle detection
ProblemAttempt.create!(
  user: user,
  problem: problem,
  success: false,
  hints_used: 3,
  # ... auto-calculates struggle_score
)

# Methods:
attempt.struggling?                    # => true/false
attempt.struggle_score                 # => 0.0-1.0
attempt.recommended_next_action        # => next steps
attempt.get_prerequisite_recommendations
attempt.get_easier_alternatives
```

### LearningPath

```ruby
# One per user, tracks overall progress
learning_path = user.learning_path

# Check status:
learning_path.currently_struggling?    # => true/false
learning_path.should_take_break?       # => true/false
learning_path.recommended_difficulty   # => 'easy'/'medium'/'hard'

# Get recommendations:
learning_path.next_recommended_problem
learning_path.daily_practice_set
learning_path.learning_suggestions
learning_path.weakest_topic
learning_path.strongest_topic
```

## 🔍 Struggle Patterns Detected

1. **Repeated Failures**: ≥3 fails in last 10 attempts
2. **Hint Dependency**: Used ≥3 hints in 3+ problems
3. **Time Struggles**: Taking >2x estimated time
4. **Topic Struggles**: Failing ≥2 problems in same topic

## 🎯 Intervention Strategies

### When Struggling

1. **Immediate**: Show prerequisite problems
2. **After 2+ struggles**: Recommend easier difficulty
3. **After 3+ struggles**: Suggest break
4. **Pattern detected**: Provide targeted practice

### When Excelling

1. **Success rate >80%**: Increase difficulty
2. **5+ streak**: Offer challenge problems
3. **Topic mastery**: Introduce new topics

## 📊 Tracking Metrics

```ruby
# User level
user.problem_success_rate          # Overall success %
user.current_problem_streak        # Current streak
user.is_struggling?                # Currently struggling?

# Learning path level
path.overall_success_rate          # 72.5%
path.topic_performance             # Per-topic stats
path.difficulty_performance        # Per-difficulty stats
path.weak_topics                   # ["DP", "Graphs"]
path.strong_topics                 # ["Arrays"]
path.current_streak                # 5 days
```

## 🎨 UI Recommendations

### Show When Struggling

```jsx
<StruggleAlert>
  <Title>Let's Adjust Your Learning Path</Title>
  <Message>I notice you're finding this challenging.</Message>

  <StruggleFactors>
    ✓ Multiple attempts (5)
    ✓ Used many hints (4)
    ✓ Took longer than expected
  </StruggleFactors>

  <Recommendation>
    <h3>Try these fundamentals first:</h3>
    <ProblemList problems={prerequisites} />
    <Button>Start with easier problems</Button>
  </Recommendation>
</StruggleAlert>
```

### Show Learning Path Progress

```jsx
<LearningDashboard>
  <Streak count={5} emoji="🔥" />
  <SuccessRate value={72.5} />

  <TopicPerformance>
    <TopicBar topic="Arrays" rate={85} status="strong" />
    <TopicBar topic="Trees" rate={45} status="weak" />
    <TopicBar topic="Graphs" rate={60} />
  </TopicPerformance>

  <Suggestions>
    {suggestions.map(s => (
      <SuggestionCard type={s.type} message={s.message} />
    ))}
  </Suggestions>
</LearningDashboard>
```

## 📁 Files Created

```
db/migrate/
├── 20251110062000_create_problem_attempts.rb
└── 20251110062100_create_learning_paths.rb

app/models/
├── problem_attempt.rb      # Struggle detection
└── learning_path.rb         # Adaptive path management

app/services/
└── adaptive_learning_service.rb

app/controllers/api/v1/
└── adaptive_learning_controller.rb

config/
└── routes_adaptive_learning.rb

Documentation/
├── ADAPTIVE_LEARNING_GUIDE.md      # Full guide
└── ADAPTIVE_LEARNING_QUICKSTART.md # This file
```

## ✅ Quick Test

```ruby
rails console

# Create a struggling attempt
user = User.first
problem = Problem.find_by(slug: 'two-sum')

attempt = user.problem_attempts.create!(
  problem: problem,
  success: false,
  time_spent_seconds: 3600,
  hints_used: 5,
  syntax_errors: 3
)

# Check if struggling
attempt.struggling?         # => true
attempt.struggle_score      # => 0.8+

# Get recommendations
action = attempt.recommended_next_action
# => { action: "review_prerequisites", problems: [...] }

# Check learning path
path = user.learning_path
path.currently_struggling?  # => true
path.learning_suggestions   # => Array of suggestions
```

## 🎯 Next Steps

1. **Add routes** to `config/routes.rb`
2. **Test API endpoints** with Postman/curl
3. **Build frontend** struggle detection UI
4. **Monitor metrics** to tune thresholds
5. **Customize messages** for your audience

---

**Questions?** Check `ADAPTIVE_LEARNING_GUIDE.md` for detailed documentation!

**You're all set!** 🎉 The system will now automatically detect struggles and provide intelligent interventions.
