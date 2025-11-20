# Algorithms Problems - Quick Start Guide

## What You Got

✅ **4,638 coding interview problems** organized into 350+ families
✅ **Complete database schema** with migration
✅ **Enhanced Problem model** with 30+ helper methods
✅ **Spaced repetition support** - problems grouped by similarity
✅ **Adaptive learning** - difficulty progression based on performance
✅ **Interview prep ready** - filtered by company, topic, frequency

## Setup (3 Steps)

```bash
# 1. Run migration
rails db:migrate

# 2. Load problems into database
rails runner db/seeds/load_algorithms_problems.rb

# 3. Start using!
rails console
```

## Common Queries

```ruby
# Get easy problems
Problem.easy_problems

# Get problems by topic
Problem.by_topic('Arrays & Strings')

# Get problems by company
Problem.by_company('Google')

# Get high-frequency problems
Problem.high_frequency

# Get daily challenge
Problem.daily_challenge

# Get interview prep set
Problem.interview_prep_set(company: 'Amazon', difficulty_mix: true)
```

## Spaced Repetition Example

```ruby
# Start with a problem
problem = Problem.find_by(slug: 'two-sum')

# Get similar problems in same family
problem.family_problems

# Get next harder problem in family
problem.next_in_family

# Get previous problem in family
problem.previous_in_family
```

## Adaptive Learning Example

```ruby
# Record user attempt
problem.record_attempt(success: true, time_spent_mins: 20)

# Get recommendations based on performance
problem.recommended_next_problems(user_performance: :excelling)
problem.recommended_next_problems(user_performance: :struggling)
```

## File Locations

- **Migration**: `db/migrate/20251110061200_add_comprehensive_fields_to_problems.rb`
- **Problem Model**: `app/models/problem.rb`
- **Generator**: `db/seeds/algorithms_problem_generator.rb`
- **JSON Data**: `db/seeds/algorithms_problems.json` (4.1MB)
- **Loader**: `db/seeds/load_algorithms_problems.rb`
- **Full Docs**: `ALGORITHMS_PROBLEMS_README.md`

## Stats

- **Total Problems**: 4,638
- **Difficulty**: 28% Easy, 35% Medium, 34% Hard, 3% Expert
- **Topics**: 15 major topics (Arrays, Trees, Graphs, DP, etc.)
- **Problem Families**: 350+ for spaced repetition
- **Companies**: Amazon, Google, Facebook, Microsoft, and 50+ more

## Need Help?

See `ALGORITHMS_PROBLEMS_README.md` for:
- Detailed usage examples
- API integration samples
- Building learning platforms
- Performance optimization tips

**You're all set for coding interview prep! 🎯**
