# Algorithms & Data Structures Problem Database

## Overview

This is a comprehensive database of **4,638 coding interview problems** organized for:
- **Spaced Repetition Learning** - Problems grouped into families for progressive practice
- **Adaptive Learning** - Difficulty progression based on performance
- **Interview Preparation** - Curated by company, topic, and frequency
- **Systematic Coverage** - All major algorithms and data structures topics

## Database Statistics

### Difficulty Distribution
- **Easy**: 1,300 problems (28%)
- **Medium**: 1,606 problems (35%)
- **Hard**: 1,585 problems (34%)
- **Expert**: 147 problems (3%)

### Topic Coverage
- Arrays & Strings: 175 problems
- Trees: 561 problems
- Linked Lists: 248 problems
- Stacks & Queues: 293 problems
- Graphs: 475 problems
- Hash Tables & Sets: 300 problems
- Heaps & Priority Queues: 246 problems
- Sorting & Searching: 344 problems
- Dynamic Programming: 568 problems
- Greedy Algorithms: 246 problems
- Backtracking: 289 problems
- Recursion: 200 problems
- Bit Manipulation: 196 problems
- Math & Number Theory: 300 problems
- System & Object Design: 197 problems

## Setup Instructions

### 1. Run the Migration

```bash
rails db:migrate
```

This adds comprehensive fields to the `problems` table including:
- Problem metadata (difficulty, topic, subtopic, family_id)
- JSONB fields for flexible data (examples, test cases, hints, tags, etc.)
- Adaptive learning fields (success_rate, estimated_time, points)
- Statistics tracking (attempts, average time spent)

### 2. Load the Problems

```bash
# Option 1: Load via seed file
rails runner db/seeds/load_algorithms_problems.rb

# Option 2: Add to main seeds.rb
# echo "load 'db/seeds/load_algorithms_problems.rb'" >> db/seeds.rb
# rails db:seed
```

This will import all 4,638 problems into your database.

## Usage Examples

### Basic Queries

```ruby
# Get all easy problems
Problem.easy_problems

# Get all problems on a specific topic
Problem.by_topic('Arrays & Strings')

# Get problems by company
Problem.by_company('Google')

# Get high-frequency problems
Problem.high_frequency

# Get problems by tag
Problem.by_tag('hash-map')

# Get problems by multiple tags (AND condition)
Problem.by_tags(['dp', 'string'])

# Random problem by difficulty
Problem.random_by_difficulty('medium')

# Daily challenge
Problem.daily_challenge
```

### Spaced Repetition Learning

```ruby
# Get a problem family for progressive learning
family_id = 'array-basics-001'
problems = Problem.by_family(family_id).order(:difficulty_level)

# Practice first problem
current_problem = problems.first

# Get next problem in same family
next_problem = current_problem.next_in_family

# Get all problems in family
family_problems = current_problem.family_problems

# Get next set of problems based on last difficulty
Problem.for_spaced_repetition(family_id, last_difficulty: 'easy')
```

### Adaptive Learning

```ruby
# Record a user's attempt
problem = Problem.find(123)
problem.record_attempt(success: true, time_spent_mins: 25)

# Get recommended next problems based on performance
problem.recommended_next_problems(user_performance: :excelling)
problem.recommended_next_problems(user_performance: :struggling)
problem.recommended_next_problems(user_performance: :medium)

# Check if problem is popular
problem.popular? # Returns true for high/very-high frequency

# Get actual vs expected success rate
problem.actual_success_rate
```

### Interview Preparation

```ruby
# Get interview prep set for a specific company
google_prep = Problem.interview_prep_set(company: 'Google')

# Get mixed difficulty interview prep
mixed_prep = Problem.interview_prep_set(difficulty_mix: true)
# Returns: 30% easy, 50% medium, 20% hard

# Get learning path for a topic (ordered progression)
array_path = Problem.learning_path_for_topic('Arrays & Strings')

# Get related problems
problem = Problem.find(1) # Two Sum
related = problem.get_related_problems

# Get prerequisites
prerequisites = problem.get_prerequisites
```

### Analytics

```ruby
# Topic difficulty distribution
Problem.topic_difficulty_stats('Dynamic Programming')
# => {"easy"=>147, "medium"=>217, "hard"=>187, "expert"=>17}

# Average success rate by difficulty
Problem.avg_success_rate_by_difficulty
# => {"easy"=>0.7, "medium"=>0.4, "hard"=>0.2, "expert"=>0.1}

# Count by topic
Problem.group(:topic).count

# Count by difficulty
Problem.group(:difficulty).count
```

## Problem Structure

Each problem includes:

### Core Information
- `title` - Problem title
- `slug` - URL-friendly identifier
- `description` - Full problem description
- `difficulty` - easy, medium, hard, or expert
- `topic` - Main topic (e.g., "Arrays & Strings")
- `subtopic` - Specific subtopic (e.g., "Sliding Window")
- `family_id` - Groups similar problems for spaced repetition

### Learning Aids
- `examples` - Input/output examples with explanations
- `constraints` - Problem constraints
- `test_cases` - Sample test cases
- `hints` - Progressive hints
- `solution_approach` - High-level solution strategy
- `starter_code` - Code templates (Python, JavaScript, Java)
- `follow_ups` - Extension questions

### Complexity Analysis
- `time_complexity` - Expected time complexity (e.g., "O(n)")
- `space_complexity` - Expected space complexity
- `estimated_time_mins` - Estimated time to solve

### Metadata
- `tags` - Searchable tags (e.g., ['hash-map', 'two-pointers'])
- `companies` - Companies that have asked this question
- `frequency` - How often it appears (very-high, high, medium, low)
- `related_problems` - IDs of related problems
- `prerequisites` - Problems to solve first

### Adaptive Learning
- `success_rate` - Expected success rate
- `points` - Points awarded for completion
- `total_attempts` - Total user attempts
- `successful_attempts` - Successful completions
- `average_time_spent` - Average time spent by users

## Problem Families

Problems are organized into **350+ families** for spaced repetition. Each family contains 10-20 related problems with varying difficulty.

Example families:
- `array-basics-001` - Two Sum and variants (15 problems)
- `array-sliding-window-002` - Sliding window problems (25 problems)
- `array-prefix-sum-003` - Prefix sum problems (20 problems)
- `tree-traversal-024` - Tree traversal problems (80 problems)
- `dp-1d-064` - 1D Dynamic Programming (50 problems)

### Using Problem Families

```ruby
# Get all problems in a family
Problem.where(family_id: 'array-basics-001')

# Get family progression (easy to hard)
Problem.where(family_id: 'array-basics-001').order(:difficulty_level)

# Navigate through family
problem = Problem.find_by(slug: 'two-sum')
next_problem = problem.next_in_family
prev_problem = problem.previous_in_family
```

## API Integration

### Sample Controller Actions

```ruby
class Api::V1::ProblemsController < ApplicationController
  # GET /api/v1/problems
  def index
    @problems = Problem.all
    @problems = @problems.by_difficulty(params[:difficulty]) if params[:difficulty]
    @problems = @problems.by_topic(params[:topic]) if params[:topic]
    @problems = @problems.by_company(params[:company]) if params[:company]

    render json: @problems
  end

  # GET /api/v1/problems/:slug
  def show
    @problem = Problem.find_by!(slug: params[:slug])
    render json: @problem, include: [:related_problems, :prerequisites]
  end

  # GET /api/v1/problems/:slug/family
  def family
    @problem = Problem.find_by!(slug: params[:slug])
    @family_problems = @problem.family_problems
    render json: @family_problems
  end

  # POST /api/v1/problems/:slug/attempt
  def record_attempt
    @problem = Problem.find_by!(slug: params[:slug])
    @problem.record_attempt(
      success: params[:success],
      time_spent_mins: params[:time_spent_mins]
    )
    render json: { success: true, problem: @problem }
  end

  # GET /api/v1/problems/daily-challenge
  def daily_challenge
    @problem = Problem.daily_challenge
    render json: @problem
  end

  # GET /api/v1/problems/interview-prep
  def interview_prep
    @problems = Problem.interview_prep_set(
      company: params[:company],
      difficulty_mix: true
    )
    render json: @problems
  end
end
```

### Sample Routes

```ruby
# config/routes.rb
namespace :api do
  namespace :v1 do
    resources :problems, param: :slug do
      member do
        get :family
        post :attempt
        get :recommended
      end

      collection do
        get :daily_challenge
        get :interview_prep
        get :random
      end
    end
  end
end
```

## Building a Learning Platform

### Spaced Repetition System

```ruby
class LearningPath
  def initialize(user)
    @user = user
  end

  # Get next problem based on spaced repetition algorithm
  def next_problem
    last_attempt = @user.problem_attempts.order(created_at: :desc).first

    if last_attempt.nil?
      # Start with easy problem
      Problem.easy_problems.high_frequency.first
    elsif last_attempt.success?
      # Move to next in family or harder problem
      last_attempt.problem.next_in_family || next_harder_problem(last_attempt.problem)
    else
      # Retry or get easier problem in same topic
      last_attempt.problem.family_problems.easy_problems.first ||
        last_attempt.problem
    end
  end

  private

  def next_harder_problem(current_problem)
    next_difficulty = case current_problem.difficulty
                      when 'easy' then 'medium'
                      when 'medium' then 'hard'
                      when 'hard' then 'expert'
                      else 'easy'
                      end

    Problem.by_topic(current_problem.topic)
           .by_difficulty(next_difficulty)
           .where.not(id: @user.completed_problem_ids)
           .first
  end
end
```

### Adaptive Difficulty

```ruby
class AdaptiveLearning
  def initialize(user)
    @user = user
  end

  # Determine user's current level
  def user_level
    recent_attempts = @user.problem_attempts.last(10)
    success_rate = recent_attempts.count(&:success?) / recent_attempts.count.to_f

    case success_rate
    when 0.8..1.0 then :excelling
    when 0.5..0.79 then :progressing
    when 0.0..0.49 then :struggling
    else :beginner
    end
  end

  # Get personalized recommendations
  def recommended_problems(count: 5)
    level = user_level
    last_problem = @user.problem_attempts.last&.problem

    if last_problem
      last_problem.recommended_next_problems(user_performance: level).limit(count)
    else
      Problem.easy_problems.high_frequency.limit(count)
    end
  end
end
```

## Performance Optimization

### Database Indexes

The migration includes indexes on:
- `slug` (unique)
- `difficulty`
- `topic`
- `family_id`
- `tags` (GIN index for JSONB)

### Caching Recommendations

```ruby
# Cache daily challenge
Rails.cache.fetch("daily_challenge_#{Date.today}", expires_in: 1.day) do
  Problem.daily_challenge
end

# Cache topic stats
Rails.cache.fetch("topic_stats", expires_in: 1.hour) do
  Problem.group(:topic).count
end
```

## Regenerating Problems

To regenerate or modify the problem database:

```bash
# Edit the generator
vim db/seeds/algorithms_problem_generator.rb

# Regenerate JSON
ruby db/seeds/algorithms_problem_generator.rb

# Reload into database
rails runner db/seeds/load_algorithms_problems.rb
```

## File Structure

```
db/
├── migrate/
│   └── 20251110061200_add_comprehensive_fields_to_problems.rb
└── seeds/
    ├── algorithms_problem_generator.rb    # Ruby generator (1,700+ lines)
    ├── algorithms_problems.json            # Generated JSON (4.1MB)
    ├── algorithms_problem_database.json    # Original metadata
    └── load_algorithms_problems.rb         # Seed loader

app/
└── models/
    └── problem.rb                          # Enhanced Problem model
```

## Contributing

To add more problems:

1. Edit `db/seeds/algorithms_problem_generator.rb`
2. Add problems to existing families or create new families
3. Regenerate: `ruby db/seeds/algorithms_problem_generator.rb`
4. Reload: `rails runner db/seeds/load_algorithms_problems.rb`

## Support

For questions or issues:
- Check the Problem model methods: `app/models/problem.rb`
- Review example queries in this README
- Inspect the generated JSON: `db/seeds/algorithms_problems.json`

## License

This problem database is generated for educational and interview preparation purposes.

---

**Happy Coding! 🚀**

Generated: 2025-11-10
Total Problems: 4,638
Problem Families: 350+
Topics Covered: 15
