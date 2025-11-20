# UPSC API Quick Reference

All endpoints are prefixed with `/api/v1/upsc`

## 📊 Dashboard

```
GET /dashboard           # Complete dashboard
GET /dashboard/overview  # Overview stats
GET /dashboard/progress  # Progress tracking
GET /dashboard/analytics # Detailed analytics
```

## 📚 Subjects

```
GET    /subjects          # List all
GET    /subjects/prelims  # Prelims only
GET    /subjects/mains    # Mains only
GET    /subjects/optional # Optional only
GET    /subjects/:id      # Get one
POST   /subjects          # Create
PATCH  /subjects/:id      # Update
DELETE /subjects/:id      # Delete
```

## 📖 Topics

```
GET  /topics                      # List all
GET  /topics/high_yield           # High-yield only
GET  /topics/:id                  # Get one
POST /topics                      # Create
POST /topics/:id/start_learning   # Start learning
POST /topics/:id/complete         # Mark complete
```

**Filters**: `?subject_id=1&difficulty=medium&high_yield=true&root_only=true`

## ❓ Questions

```
GET  /questions                    # List (paginated)
GET  /questions/random             # Random questions
GET  /questions/:id                # Get one
POST /questions/:id/verify_answer  # Verify answer
POST /questions                    # Create
```

**Filters**: `?topic_id=1&difficulty=hard&pyq_only=true&year=2023&page=1&per_page=20`

## 📝 Tests

```
GET  /tests                           # List all tests
GET  /tests/my_attempts               # My attempts
GET  /tests/:id                       # Get test
POST /tests/:id/start                 # Start test
POST /tests/attempts/:id/submit_answer # Submit single answer
POST /tests/attempts/:id/submit        # Submit test
GET  /tests/attempts/:id/results       # Get results
```

**Filters**: `?test_type=full_test&status=live&subject_id=1`

## ✍️ Writing Questions

```
GET /writing_questions       # List all
GET /writing_questions/daily # Today's question
GET /writing_questions/:id   # Get one
```

**Filters**: `?question_type=essay&topic_id=1&difficulty=hard&daily=true`

## 📄 User Answers

```
GET  /user_answers                        # List my answers
GET  /user_answers/statistics             # Statistics
POST /user_answers                        # Submit answer
POST /user_answers/:id/request_evaluation # Request AI eval
```

**Submit**: `POST /user_answers?auto_evaluate=true`

**Filters**: `?status=evaluated&question_id=1`

## 📰 News Articles

```
GET /news_articles            # List all
GET /news_articles/today      # Today's news
GET /news_articles/this_week  # This week
GET /news_articles/important  # Important only
GET /news_articles/categories # List categories
```

**Filters**: `?category=politics&importance=high&from_date=2024-01-01&tags=economy,policy`

## 📅 Study Plans

```
GET  /study_plans            # List all
GET  /study_plans/active     # Active plan
POST /study_plans/generate   # Generate plan
POST /study_plans/:id/activate # Activate
```

**Generate**: `POST /study_plans/generate?target_date=2025-06-01&attempt_number=1`

## ✅ Daily Tasks

```
GET  /daily_tasks            # List all
GET  /daily_tasks/today      # Today's tasks
GET  /daily_tasks/week       # This week
GET  /daily_tasks/statistics # Statistics
POST /daily_tasks/bulk_create # Create multiple
POST /daily_tasks/:id/complete # Mark complete
```

**Filters**: `?date=2024-11-06&status=pending&priority=high&overdue=true`

## 🔄 Revisions

```
GET  /revisions                  # List all
GET  /revisions/today            # Today's revisions
GET  /revisions/upcoming         # Upcoming (7 days)
GET  /revisions/statistics       # Statistics
POST /revisions/schedule_topic   # Schedule topic
POST /revisions/:id/complete     # Mark complete
```

**Complete**: `POST /revisions/:id/complete?performance_rating=4&notes=Difficult`

---

## 🔑 Common Query Parameters

- `page=1` - Page number (default: 1)
- `per_page=20` - Items per page (default: 20)
- `subject_id=1` - Filter by subject
- `topic_id=1` - Filter by topic
- `difficulty=medium` - Filter by difficulty (easy/medium/hard)
- `status=pending` - Filter by status
- `date=2024-11-06` - Filter by date
- `from_date=2024-01-01` - From date
- `to_date=2024-12-31` - To date
- `today=true` - Today's items
- `overdue=true` - Overdue items

---

## 📤 Response Format

### Success
```json
{
  "success": true,
  "message": "Success",
  "data": { ... }
}
```

### Error
```json
{
  "success": false,
  "message": "Error occurred",
  "errors": ["Error details"]
}
```

### Paginated
```json
{
  "success": true,
  "data": {
    "items": [...],
    "meta": {
      "current_page": 1,
      "total_pages": 10,
      "total_count": 100,
      "per_page": 20
    }
  }
}
```

---

## 🧪 Quick Test Commands

```bash
# Dashboard
curl http://localhost:3000/api/v1/upsc/dashboard | jq

# Today's tasks
curl http://localhost:3000/api/v1/upsc/daily_tasks/today | jq

# High-yield topics
curl http://localhost:3000/api/v1/upsc/topics?high_yield=true | jq

# Random questions
curl "http://localhost:3000/api/v1/upsc/questions/random?count=5&difficulty=medium" | jq

# This week's news
curl http://localhost:3000/api/v1/upsc/news_articles/this_week | jq

# Generate study plan
curl -X POST "http://localhost:3000/api/v1/upsc/study_plans/generate?target_date=2025-06-01&attempt_number=1" | jq
```

---

## 🎯 Base URL

**Development**: `http://localhost:3000/api/v1/upsc`
**Production**: `https://yourdomain.com/api/v1/upsc`

---

**Pro Tip**: Use `| jq` to pretty-print JSON responses in terminal!
