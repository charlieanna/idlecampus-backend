# Adaptive Learning System - Complete Guide

## 🎯 Overview

This adaptive learning system automatically detects when users struggle with problems and provides intelligent interventions including:

- **Prerequisite recommendations** - Directs users to foundational problems
- **Difficulty adjustment** - Suggests easier problems when struggling
- **Pattern detection** - Identifies recurring struggle patterns
- **Personalized learning paths** - Adapts to individual performance
- **Break recommendations** - Prevents burnout

## 📊 How It Works

### 1. Struggle Detection

The system tracks multiple indicators to determine if a user is struggling:

#### Struggle Score Calculation (0.0 to 1.0)

```ruby
score = 0.0

# Multiple failed attempts
score += 0.3 if attempts_count >= 3
score += 0.5 if attempts_count >= 5

# Used many hints
score += 0.2 if hints_used >= 2
score += 0.3 if hints_used >= 4

# Gave up or viewed solution
score += 0.5 if gave_up
score += 0.4 if viewed_solution

# Many errors
score += 0.2 if total_errors >= 3
score += 0.4 if total_errors >= 6

# Took too long (>2x estimated time)
score += 0.3 if time_ratio > 2.0
score += 0.5 if time_ratio > 3.0
```

**Struggle Threshold**: Score > 0.6 means user is struggling

#### Confidence Levels

- **gave_up**: Struggle score > 0.7 and gave up
- **struggling**: Struggle score > 0.7
- **uncertain**: Struggle score > 0.4
- **confident**: Struggle score ≤ 0.4

### 2. Automatic Interventions

When struggling is detected, the system provides different interventions:

#### A. Prerequisite Recommendations

```ruby
# When user struggles on a problem
GET /api/v1/adaptive_learning/prerequisites/:problem_slug

Response:
{
  "struggling": true,
  "prerequisites": [
    { "id": 1, "title": "Two Sum", "difficulty": "easy" },
    { "id": 5, "title": "Array Basics", "difficulty": "easy" }
  ],
  "message": "These 2 problems will help build the foundation you need."
}
```

**How Prerequisites are Selected:**

1. **Explicit Prerequisites** - Problems marked as prerequisites
2. **Easier Family Problems** - Easier problems in same family
3. **Topic Fundamentals** - Easy problems in same topic

#### B. Easier Alternative Problems

```ruby
# System automatically suggests easier alternatives
attempt.get_easier_alternatives

# Returns:
# - Easier problems in same family
# - Easier problems with similar tags
# - Problems from prerequisite chain
```

#### C. Break Recommendations

```ruby
# If user failed last 3 attempts with high struggle scores
learning_path.should_take_break? # => true

Response:
{
  "type": "break",
  "message": "Take a break and come back refreshed!",
  "suggested_break_duration": "1-2 hours",
  "alternative_activities": [
    "Review your notes",
    "Watch tutorial videos"
  ]
}
```

### 3. Learning Path Adaptation

The system maintains a personalized learning path for each user:

```ruby
LearningPath attributes:
- current_problem
- current_topic
- current_difficulty
- overall_success_rate
- topic_performance: { "Arrays": { success_rate: 75, problems_solved: 10 } }
- difficulty_performance: { "easy": 0.9, "medium": 0.6, "hard": 0.3 }
- weak_topics: ["Dynamic Programming", "Graphs"]
- strong_topics: ["Arrays & Strings"]
- recommended_problems: [array of problem IDs]
- prerequisite_queue: [problems to complete before advancing]
```

#### Difficulty Progression

```ruby
Recommended Difficulty Based on Success Rate:

90-100%: Increase difficulty
70-89%:  Maintain current difficulty
50-69%:  Maintain or decrease slightly
< 50%:   Decrease difficulty
```

## 🔄 User Flow Examples

### Example 1: User Struggling with Medium Problem

```
1. User attempts "Three Sum" (medium) - FAILS
   - Took 60 minutes (estimated: 30 min)
   - Used 4 hints
   - Made 5 errors
   - Struggle Score: 0.8 → STRUGGLING

2. System Response:
   {
     "action": "review_prerequisites",
     "message": "Let's build a stronger foundation first",
     "problems": [
       "Two Sum (easy)",
       "Two Sum II (easy)",
       "Array Basics Review (easy)"
     ]
   }

3. User completes "Two Sum" - SUCCESS
   - Fast solve (8 minutes)
   - No hints needed
   - Confidence: "confident"

4. System Response:
   {
     "action": "practice_more",
     "message": "Good! Let's practice similar problems",
     "problems": [
       "Two Sum III",
       "Two Sum - Data Structure Design"
     ]
   }

5. After completing 3 easy problems successfully:
   {
     "action": "try_again",
     "message": "Ready to retry Three Sum? You've built the skills!",
     "problem": "Three Sum"
   }
```

### Example 2: User Excelling

```
1. User completes 5 medium problems - ALL SUCCESS
   - Current streak: 5
   - Success rate: 92%

2. System Response:
   {
     "type": "advancement",
     "title": "Ready to Level Up!",
     "message": "You're mastering medium problems. Time for hard?",
     "recommended_problems": [
       "Trapping Rain Water (hard)",
       "Median of Two Sorted Arrays (hard)"
     ]
   }
```

### Example 3: Mixed Performance (Adaptive)

```
1. User's Recent Performance:
   - Arrays: 85% success (strong)
   - Trees: 45% success (weak)
   - Graphs: 60% success (medium)

2. Daily Practice Set:
   {
     "problems": [
       "Binary Tree Problem (easy)" ← Weak topic, easier difficulty
       "Array Sorting (medium)"     ← Strong topic, current difficulty
       "Graph Challenge (hard)"     ← Challenge problem
     ]
   }

3. Improvement Plan for Trees:
   {
     "topic": "Trees",
     "current_performance": 45%,
     "recommended_problems": [
       5 easy tree problems,
       5 medium tree problems
     ],
     "milestones": [
       "Complete 5 easy problems",
       "Complete 5 medium problems",
       "Achieve 70% success rate"
     ]
   }
```

## 🔧 Implementation Guide

### 1. Setup

```bash
# Run migrations
rails db:migrate

# This creates:
# - problem_attempts table
# - learning_paths table
# - Indexes for performance
```

### 2. Record Problem Attempts

```ruby
# Frontend submits attempt
POST /api/v1/adaptive_learning/record_attempt

{
  "problem_slug": "two-sum",
  "attempt": {
    "success": false,
    "time_spent_seconds": 1800,
    "submitted_code": "def twoSum(nums, target)...",
    "test_results": [
      { "test": 1, "passed": true },
      { "test": 2, "passed": false }
    ],
    "hints_used": 3,
    "hints_viewed": [1, 2, 3],
    "syntax_errors": 0,
    "logic_errors": 2,
    "compilation_errors": 0,
    "gave_up": false,
    "viewed_solution": false,
    "started_at": "2025-11-10T10:00:00Z"
  }
}

# Response includes:
{
  "success": true,
  "attempt": { ... },
  "next_action": {
    "action": "try_easier",
    "message": "Let's try a similar but easier problem",
    "problems": [...]
  },
  "struggle_analysis": {
    "struggling": true,
    "struggle_score": 0.75,
    "factors": {
      "hints_used": true,
      "many_errors": true
    }
  }
}
```

### 3. Get Next Recommended Problem

```ruby
GET /api/v1/adaptive_learning/next_problem

Response:
{
  "recommendation": {
    "type": "intervention", // or "standard", "prerequisite", "break"
    "title": "Let's Build a Stronger Foundation",
    "message": "I see you're finding this challenging...",
    "problem": { ... },
    "why_this_problem": "This will help strengthen your Arrays skills"
  },
  "learning_path": {
    "current_streak": 3,
    "success_rate": 68.5,
    "struggling": false
  }
}
```

### 4. Get Daily Practice Set

```ruby
GET /api/v1/adaptive_learning/daily_practice

Response:
{
  "practice_set": {
    "title": "Your Daily Practice",
    "date": "2025-11-10",
    "problems": [
      { /* weak topic problem */ },
      { /* current difficulty problem */ },
      { /* challenge problem */ }
    ],
    "suggestions": [
      {
        "type": "improvement",
        "title": "Strengthen Dynamic Programming",
        "action": "practice_weak_topic"
      }
    ],
    "stats": {
      "current_streak": 5,
      "success_rate": 72.3,
      "total_solved": 45
    }
  }
}
```

### 5. Monitor Learning Path

```ruby
GET /api/v1/adaptive_learning/learning_path

Response:
{
  "learning_path": {
    "current_problem": { ... },
    "current_topic": "Arrays & Strings",
    "current_difficulty": "medium",
    "overall_success_rate": 72.5,
    "topic_performance": {
      "Arrays & Strings": { "success_rate": 85, "problems_solved": 12 },
      "Trees": { "success_rate": 45, "problems_solved": 6 }
    },
    "difficulty_performance": {
      "easy": 0.92,
      "medium": 0.68,
      "hard": 0.35
    },
    "weak_topics": ["Trees", "Graphs"],
    "strong_topics": ["Arrays & Strings"],
    "current_streak": 5,
    "total_problems_solved": 45,
    "suggestions": [
      {
        "type": "improvement",
        "title": "Strengthen Trees",
        "message": "Practice more Trees problems to build confidence"
      }
    ]
  }
}
```

### 6. Struggle Analysis

```ruby
GET /api/v1/adaptive_learning/struggle_analysis

Response:
{
  "analysis": {
    "struggling": true,
    "patterns": {
      "repeated_failures": {
        "detected": true,
        "count": 4,
        "severity": "medium"
      },
      "hint_dependency": {
        "detected": true,
        "count": 3,
        "average_hints": 3.2
      },
      "time_struggles": {
        "detected": false,
        "count": 1
      },
      "topic_struggles": {
        "detected": true,
        "topics": ["Dynamic Programming", "Graphs"],
        "count": 2
      }
    },
    "interventions": [
      {
        "type": "repeated_failures",
        "message": "Try reviewing the fundamental concepts",
        "action": "review_basics"
      },
      {
        "type": "topic_weakness",
        "message": "Focus on mastering: Dynamic Programming, Graphs",
        "action": "targeted_practice",
        "topics": ["Dynamic Programming", "Graphs"]
      }
    ]
  }
}
```

## 📱 Frontend Integration Examples

### React Component Example

```javascript
// When user submits solution
const handleSubmit = async (code, testResults) => {
  const response = await fetch('/api/v1/adaptive_learning/record_attempt', {
    method: 'POST',
    body: JSON.stringify({
      problem_slug: currentProblem.slug,
      attempt: {
        success: testResults.allPassed,
        time_spent_seconds: getElapsedTime(),
        submitted_code: code,
        test_results: testResults.results,
        hints_used: hintsUsed,
        hints_viewed: viewedHints,
        syntax_errors: syntaxErrors,
        logic_errors: logicErrors,
        started_at: startTime
      }
    })
  });

  const data = await response.json();

  // Show struggle analysis if detected
  if (data.struggle_analysis?.struggling) {
    showStruggleDialog({
      score: data.struggle_analysis.struggle_score,
      factors: data.struggle_analysis.factors,
      nextAction: data.next_action
    });
  } else {
    // Show next recommended problem
    showNextProblem(data.next_action);
  }
};

// Struggle Dialog Component
const StruggleDialog = ({ score, factors, nextAction }) => (
  <Dialog>
    <DialogTitle>Let's Adjust Your Learning Path</DialogTitle>
    <DialogContent>
      <p>I notice you're finding this challenging. Here's what I recommend:</p>

      <StruggleIndicators factors={factors} />

      <h4>{nextAction.message}</h4>

      {nextAction.action === 'review_prerequisites' && (
        <ProblemList
          title="Start with these fundamentals:"
          problems={nextAction.problems}
        />
      )}

      {nextAction.action === 'try_easier' && (
        <ProblemList
          title="Try these easier variations:"
          problems={nextAction.problems}
        />
      )}
    </DialogContent>
  </Dialog>
);

// Daily Practice Component
const DailyPractice = () => {
  const [practiceSet, setPracticeSet] = useState(null);

  useEffect(() => {
    fetch('/api/v1/adaptive_learning/daily_practice')
      .then(res => res.json())
      .then(data => setPracticeSet(data.practice_set));
  }, []);

  return (
    <div>
      <h2>🎯 Your Daily Practice</h2>
      <StreakDisplay streak={practiceSet.stats.current_streak} />

      <div className="problems">
        {practiceSet.problems.map((problem, idx) => (
          <ProblemCard
            key={problem.id}
            problem={problem}
            badge={getPracticeBadge(idx)} // "Weak Topic", "Current Level", "Challenge"
          />
        ))}
      </div>

      <SuggestionsList suggestions={practiceSet.suggestions} />
    </div>
  );
};
```

## 🎓 Best Practices

### 1. When to Show Interventions

**Show immediately:**
- Struggle score > 0.7
- User gave up
- 3+ failed attempts on same problem

**Show after session:**
- User completed 3+ problems with declining performance
- Detected pattern struggles

**Don't interrupt:**
- First or second attempt
- User is actively solving
- During timed challenges

### 2. Balancing Challenge and Support

```ruby
# Good balance:
- 30% problems at or below mastery level (confidence building)
- 50% problems at current level (skill development)
- 20% challenge problems (growth)

# Adjust based on performance:
if success_rate > 0.8
  # Increase challenge problems to 40%
elsif success_rate < 0.5
  # Increase confidence building to 50%
end
```

### 3. Preventing Burnout

```ruby
# Check for burnout indicators:
- Long session duration (> 2 hours)
- Declining performance trend
- Multiple struggles in a row
- High stress indicators (rapid submissions, many errors)

# Recommend break when:
learning_path.should_take_break? # => true
```

## 📈 Analytics & Insights

### Track These Metrics

```ruby
# User Progress Metrics
- Success rate trend (7-day, 30-day)
- Problems solved per day/week
- Average time per difficulty
- Streak statistics
- Topic mastery levels

# Struggle Metrics
- Struggle frequency by topic
- Common failure patterns
- Prerequisite completion impact
- Intervention effectiveness

# Engagement Metrics
- Daily active users
- Average session duration
- Problems attempted per session
- Return rate after struggling
```

## 🚀 Advanced Features

### 1. Spaced Repetition Integration

```ruby
# Review problems user struggled with after intervals
review_intervals = [1.day, 3.days, 7.days, 14.days, 30.days]

# Schedule review
ProblemAttempt.struggling.each do |attempt|
  schedule_review(attempt.problem, review_intervals)
end
```

### 2. Peer Comparison (Anonymized)

```ruby
# Show how user compares to peers
peer_stats = User.where(created_at: user.created_at - 30.days..user.created_at + 30.days)
                 .average(:overall_success_rate)

if user.overall_success_rate > peer_stats
  "You're performing above average!"
else
  "Keep practicing - you've got this!"
end
```

### 3. Learning Style Adaptation

```ruby
# Detect learning style
learning_style = detect_learning_style(user)

case learning_style
when :visual_learner
  # More diagram-based problems
  # Video explanations
when :practice_focused
  # More similar problems
  # Less theory
when :theory_first
  # More explanations
  # Detailed solutions
end
```

## 📋 API Routes Summary

```ruby
# config/routes.rb
namespace :api do
  namespace :v1 do
    namespace :adaptive_learning do
      get :next_problem
      post :record_attempt
      get :daily_practice
      get :improvement_plan
      get :struggle_analysis
      get :learning_path
      post :set_learning_style
      get 'prerequisites/:problem_slug', to: 'adaptive_learning#prerequisites'
      get 'similar_problems/:problem_slug', to: 'adaptive_learning#similar_problems'
      get :stats
    end
  end
end
```

## 🎯 Success Metrics

Monitor these to ensure system effectiveness:

1. **Reduced Struggle Rate**: Users struggling less over time
2. **Increased Completion Rate**: More problems solved successfully
3. **Better Retention**: Users returning after struggling
4. **Topic Mastery**: Improvement in weak topics after intervention
5. **User Satisfaction**: Feedback on helpfulness of recommendations

---

**Built with ❤️ for adaptive learning**

For questions or improvements, refer to the codebase or create an issue.
