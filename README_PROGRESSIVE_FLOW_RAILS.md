# Progressive Flow System - Rails Backend

Complete Ruby on Rails backend implementation for the Progressive Flow gamified learning system.

## Overview

This Rails backend provides a comprehensive API for a gamified system design learning platform with:
- **61 Progressive Challenges** across 5 difficulty levels
- **Gamification**: XP, levels, achievements, streaks, daily challenges
- **Skill Trees**: Track mastery across system design concepts
- **Leaderboards**: Global, friends, and challenge-specific rankings
- **Learning Tracks**: Organized learning paths from fundamentals to advanced topics

## Tech Stack

- **Ruby**: 3.2+
- **Rails**: 7.0+
- **Database**: PostgreSQL 14+ with UUID support
- **API**: RESTful JSON API

## Database Schema

The system uses 17 PostgreSQL tables:

### Core Tables
- `progressive_user_stats` - User XP, level, streaks
- `progressive_learning_tracks` - Learning paths (3 tracks)
- `progressive_challenges` - 61 system design challenges
- `progressive_challenge_levels` - 5 levels per challenge (305 total levels)
- `progressive_user_challenge_progress` - User progress through challenges

### Gamification Tables
- `progressive_level_attempts` - Individual level attempt records
- `progressive_achievements` - Achievement definitions
- `progressive_user_achievements` - Unlocked achievements
- `progressive_xp_transactions` - XP award history
- `progressive_daily_challenges` - Daily challenge assignments
- `progressive_notifications` - User notifications
- `progressive_skills` - Skill definitions
- `progressive_user_skills` - User skill levels

### Additional Tables
- `progressive_challenge_prerequisites` - Challenge unlock logic
- `progressive_user_badges` - Badge awards
- `progressive_leaderboard_entries` - Cached leaderboard data
- `progressive_learning_paths` - Custom learning paths

## Installation & Setup

### 1. Prerequisites

```bash
# Ensure Ruby 3.2+ is installed
ruby --version

# Ensure PostgreSQL 14+ is installed
psql --version

# Install dependencies
bundle install
```

### 2. Database Setup

```bash
# Create database
rails db:create

# Run migrations
rails db:migrate

# Load seed data (optional)
rails db:seed
```

### 3. Configuration

Create `.env` file:

```env
DATABASE_URL=postgresql://localhost/progressive_flow_development
RAILS_ENV=development
SECRET_KEY_BASE=your_secret_key_base_here

# CORS origins (comma-separated)
CORS_ORIGINS=http://localhost:5173,http://localhost:3000

# JWT configuration (if using authentication)
JWT_SECRET=your_jwt_secret_here
JWT_EXPIRATION=24h
```

### 4. Routes Integration

Add to your main `config/routes.rb`:

```ruby
Rails.application.routes.draw do
  # ... other routes ...
  
  # Progressive Flow Routes
  eval(File.read(Rails.root.join('config', 'routes_progressive_flow.rb')))
end
```

### 5. Running the Server

```bash
# Development
rails server

# Production
RAILS_ENV=production rails server
```

The API will be available at `http://localhost:3000/api/v1/progressive/*`

## API Documentation

### Base URL
```
http://localhost:3000/api/v1/progressive
```

### Authentication
Most endpoints require authentication via JWT token in the Authorization header:
```
Authorization: Bearer <token>
```

---

## API Endpoints

### Learning Tracks

#### GET /tracks
Get all learning tracks

**Response:**
```json
{
  "success": true,
  "data": {
    "tracks": [
      {
        "id": "uuid",
        "name": "Fundamentals Track",
        "description": "Master the basics",
        "challenge_count": 20,
        "estimated_hours": 40
      }
    ]
  }
}
```

### Challenges

#### GET /challenges
Get all challenges with user progress

**Query Parameters:**
- `track_id` (optional) - Filter by track
- `difficulty` (optional) - Filter by difficulty
- `unlocked_only` (optional) - Only show unlocked challenges

#### POST /challenges/:id/levels/:level_number/complete
Complete a challenge level

**Request Body:**
```json
{
  "design_data": {...},
  "test_results": {
    "passed": 15,
    "failed": 0,
    "total": 15
  },
  "time_spent": 1200,
  "attempt_number": 1
}
```

### User Progress

#### GET /user/progress
Get user's overall progress

#### GET /user/stats
Get detailed user statistics

#### GET /user/achievements
Get user's achievements

#### GET /user/skills
Get user's skill levels

### Leaderboards

#### GET /leaderboard/global
Get global leaderboard

**Query Parameters:**
- `period` - all_time | weekly | monthly | yearly
- `limit` - Number of entries (default: 100)

#### GET /leaderboard/challenge/:challenge_id
Get challenge-specific leaderboard

### Daily Challenges

#### GET /daily-challenges
Get today's daily challenges

#### POST /daily-challenges/:id/complete
Mark daily challenge as completed

#### GET /daily-challenges/history
Get daily challenge completion history

---

## Service Classes

The backend includes several service classes for business logic:

### ProgressiveXpService
Handles XP calculations and awards
- `award_xp(user, amount, source, metadata)`
- `calculate_level_xp(challenge, level_number, attempt_data)`
- `calculate_level_from_xp(total_xp)`

### ProgressiveAchievementService
Manages achievement checking and unlocking
- `check_all_achievements(user)`
- `unlock_achievement(user, achievement)`
- `check_after_level_completion(user, challenge, level)`

### ProgressiveSkillService
Handles skill progression
- `award_skill_xp(user, skill_slug, xp_amount)`
- `award_skills_for_challenge(user, challenge, level_number)`
- `get_skill_tree(user)`

### ProgressiveDailyChallengeService
Manages daily challenges
- `generate_daily_challenges(user, date)`
- `calculate_daily_streak(user)`

### ProgressiveLeaderboardService
Provides leaderboard data
- `global_leaderboard(period, limit, user)`
- `challenge_leaderboard(challenge_id, limit)`
- `track_leaderboard(track_id, limit)`

## Gamification Formulas

### XP Calculation
```ruby
# Base XP per level
Level 1 (Connectivity): 50 XP
Level 2 (Capacity): 75 XP
Level 3 (Optimization): 100 XP
Level 4 (Resilience): 150 XP
Level 5 (Excellence): 200 XP

# Difficulty multipliers
Beginner: 1.0x
Intermediate: 1.5x
Advanced: 2.0x
Expert: 3.0x

# Bonuses
First Attempt: 1.5x
Perfect Score: 1.2x
Speed Bonus: 1.1x
Daily Challenge: 1.5x
```

### Level Progression
```ruby
# XP required for level
xp_for_level(level) = 1000 * (level - 1)^1.5

# Examples:
Level 2: 1,000 XP
Level 5: 8,000 XP
Level 10: 28,531 XP
Level 20: 82,744 XP
```

### Rank Names
- Novice: Level 1-5
- Apprentice: Level 6-10
- Practitioner: Level 11-15
- Expert: Level 16-20
- Master: Level 21+

## Frontend Integration

The API is designed to work seamlessly with the React frontend located at:
```
frontend/src/apps/system-design/progressive/
```

### CORS Configuration
Add to `config/application.rb`:
```ruby
config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV['CORS_ORIGINS']&.split(',') || 'http://localhost:5173'
    resource '/api/*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options],
      credentials: true
  end
end
```

## Files Created

### Database Migrations (6 files)
1. `db/migrate/20241122000001_create_progressive_flow_user_stats.rb`
2. `db/migrate/20241122000002_create_progressive_learning_tracks.rb`
3. `db/migrate/20241122000003_create_progressive_challenges.rb`
4. `db/migrate/20241122000004_create_progressive_challenge_levels.rb`
5. `db/migrate/20241122000005_create_progressive_user_challenge_progress.rb`
6. `db/migrate/20241122000006_create_progressive_flow_gamification_tables.rb`

### ActiveRecord Models (4 files)
1. `app/models/progressive_user_stat.rb`
2. `app/models/progressive_challenge.rb`
3. `app/models/progressive_user_challenge_progress.rb`
4. `app/models/progressive_models.rb`

### API Controllers (6 files)
1. `app/controllers/api/v1/progressive_flow_controller.rb`
2. `app/controllers/api/v1/progressive_challenges_controller.rb`
3. `app/controllers/api/v1/progressive_users_controller.rb`
4. `app/controllers/api/v1/progressive_leaderboards_controller.rb`
5. `app/controllers/api/v1/progressive_achievements_controller.rb`
6. `app/controllers/api/v1/progressive_daily_challenges_controller.rb`

### Service Classes (5 files)
1. `app/services/progressive_xp_service.rb`
2. `app/services/progressive_achievement_service.rb`
3. `app/services/progressive_skill_service.rb`
4. `app/services/progressive_daily_challenge_service.rb`
5. `app/services/progressive_leaderboard_service.rb`

### Configuration
1. `config/routes_progressive_flow.rb`

## Testing

```bash
# Run all tests
rails test

# Run specific test file
rails test test/models/progressive_challenge_test.rb

# Run with coverage
COVERAGE=true rails test
```

## Deployment

### Heroku
```bash
# Create app
heroku create your-app-name

# Add PostgreSQL
heroku addons:create heroku-postgresql:hobby-dev

# Deploy
git push heroku main

# Run migrations
heroku run rails db:migrate

# Seed data
heroku run rails db:seed
```

### Docker
```bash
# Build image
docker build -t progressive-flow-api .

# Run container
docker run -p 3000:3000 progressive-flow-api
```

## Support & Documentation

- **Database Schema**: See `PROGRESSIVE_FLOW_DATABASE_SCHEMA.md`
- **Gamification Formulas**: See `GAMIFICATION_FORMULAS.md`
- **Node.js API Reference**: See `backend/README_PROGRESSIVE_FLOW_API.md`

## License

MIT