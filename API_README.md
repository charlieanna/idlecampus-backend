# Docker & Kubernetes Learning Platform - Backend API

Rails backend API serving Docker and Kubernetes learning content to external React applications.

---

## 🚀 Quick Start

### 1. Start the Server
```bash
rails server -b 0.0.0.0
```
Server runs on: `http://localhost:3000`

### 2. Test the API
Open in browser: `http://localhost:3000/test_cors.html`

### 3. Call from React App
```javascript
fetch('http://localhost:3000/api/v1/learning/session?track=docker')
  .then(res => res.json())
  .then(data => console.log(data.data.modules[0].lessons.length)) // 23 lessons
```

---

## 📚 Available Content

| Track | Lessons | Labs | Status |
|-------|---------|------|--------|
| Docker | 23 | 33 | ✅ Ready |
| Kubernetes | 57 | Multiple | ✅ Ready |

**Total: 80+ interactive lessons + 40+ hands-on labs**

---

## 🔌 API Endpoints

Base URL: `http://localhost:3000/api/v1`

### 1. Get Session & Modules
```bash
GET /learning/session?track={docker|kubernetes}
```
Returns: Session data + all modules + all lessons + mastery scores

### 2. Get Modules Only
```bash
GET /learning/modules?track={docker|kubernetes}
```
Returns: All modules with lessons

### 3. Validate Command
```bash
POST /learning/command?track={docker|kubernetes}
Body: {"command": "docker ps", "lessonId": "codesprout-docker-run"}
```
Returns: Validation result with output

### 4. Complete Command
```bash
POST /learning/complete/command?track={docker|kubernetes}
Body: {"lessonId": "...", "commandIndex": 0}
```
Returns: Confirmation

### 5. Complete Lesson
```bash
POST /learning/complete/lesson?track={docker|kubernetes}
Body: {"lessonId": "..."}
```
Returns: Updated mastery score

### 6. Complete Lab Task
```bash
POST /learning/complete/task?track={docker|kubernetes}
Body: {"labId": "lab_1", "taskIndex": 0}
```
Returns: Confirmation

### 7. Get Mastery Scores
```bash
GET /learning/mastery?track={docker|kubernetes}
```
Returns: All command proficiency scores (0-100%)

---

## 🧪 Test the API

### Browser Test Page
```
http://localhost:3000/test_cors.html
```
Interactive UI to test all endpoints

### curl Examples

**Docker:**
```bash
# Get all Docker lessons
curl "http://localhost:3000/api/v1/learning/session?track=docker" | jq '.data.modules[0].lessons | length'
# Output: 23
```

**Kubernetes:**
```bash
# Get all Kubernetes lessons
curl "http://localhost:3000/api/v1/learning/session?track=kubernetes" | jq '.data.modules[0].lessons | length'
# Output: 57
```

---

## ⚛️ React Integration

### API Client Class
```javascript
class LearningAPI {
  constructor(baseURL = 'http://localhost:3000/api/v1') {
    this.baseURL = baseURL;
  }

  async getSession(track = 'docker') {
    const res = await fetch(`${this.baseURL}/learning/session?track=${track}`);
    return res.json();
  }

  async getModules(track = 'docker') {
    const res = await fetch(`${this.baseURL}/learning/modules?track=${track}`);
    return res.json();
  }

  async validateCommand(command, lessonId, track = 'docker') {
    const res = await fetch(`${this.baseURL}/learning/command?track=${track}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ command, lessonId })
    });
    return res.json();
  }

  async completeLesson(lessonId, track = 'docker') {
    const res = await fetch(`${this.baseURL}/learning/complete/lesson?track=${track}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ lessonId })
    });
    return res.json();
  }

  async getMasteryScores(track = 'docker') {
    const res = await fetch(`${this.baseURL}/learning/mastery?track=${track}`);
    return res.json();
  }
}

export default LearningAPI;
```

### React Component Example
```jsx
import { useState, useEffect } from 'react';
import LearningAPI from './api/LearningAPI';

function App() {
  const [track, setTrack] = useState('docker');
  const [lessons, setLessons] = useState([]);
  const api = new LearningAPI();

  useEffect(() => {
    async function loadCourse() {
      const { data } = await api.getSession(track);
      setLessons(data.modules[0].lessons);
    }
    loadCourse();
  }, [track]);

  return (
    <div>
      <select value={track} onChange={(e) => setTrack(e.target.value)}>
        <option value="docker">Docker ({lessons.length} lessons)</option>
        <option value="kubernetes">Kubernetes</option>
      </select>

      <ul>
        {lessons.map(lesson => (
          <li key={lesson.id}>{lesson.title}</li>
        ))}
      </ul>
    </div>
  );
}
```

---

## 🔐 Authentication

**Current:** Auto-creates demo users (no authentication required)
**For Production:** Implement JWT or API key authentication

### Add JWT (Future)
```ruby
# Gemfile
gem 'jwt'

# app/controllers/continuous_learning_controller.rb
before_action :authenticate_api_user

def authenticate_api_user
  token = request.headers['Authorization']&.split(' ')&.last
  decoded = JWT.decode(token, Rails.application.credentials.secret_key_base)
  @current_user = User.find(decoded[0]['user_id'])
rescue
  render json: { error: 'Unauthorized' }, status: 401
end
```

---

## 🌐 CORS Configuration

**Configured in:** `config/initializers/cors.rb`

**Allowed Origins (Development):**
- `localhost:3000` (Rails)
- `localhost:3001` (Create React App)
- `localhost:5173` (Vite)
- `localhost:5174` (Vite alt)
- `localhost:4173` (Vite preview)

**For Production:**
```ruby
# config/initializers/cors.rb
origins 'https://your-production-domain.com'
```

---

## 📊 Data Models

### Session
```typescript
{
  id: number;
  sessionId: string;
  userId: number;
  stateData: {
    current_chapter: string;
    completed_lessons: string[];
    completed_commands: Record<string, number[]>;
  };
  itemsPresented: number;
  itemsCorrect: number;
  accuracyRate: number;
  currentStreak: number;
}
```

### Lesson
```typescript
{
  id: string;                  // e.g., "codesprout-docker-run"
  title: string;               // Display title
  slug: string;                // URL-friendly identifier
  contentType: "quiz" | "lesson" | "lab";
  content: string;             // Markdown content
  description: string;         // Short description
  commands: Array<{
    command: string;           // Docker/kubectl command
    description: string;       // What it does
    example: string;           // Usage example
  }>;
}
```

### Mastery Score
```typescript
{
  canonicalCommand: string;
  proficiencyScore: number;    // 0-100
  lastUsedAt: string | null;   // ISO timestamp
  totalAttempts: number;
  successfulAttempts: number;
  consecutiveSuccesses: number;
  consecutiveFailures: number;
}
```

---

## 🛠️ Development

### Database
```bash
# Check content
rails console
> InteractiveLearningUnit.where("slug LIKE 'codesprout-%'").count  # 23 Docker lessons
> InteractiveLearningUnit.where("slug LIKE '%kubernetes%'").count  # 57 K8s lessons
> HandsOnLab.where(lab_type: 'docker').count                       # 33 Docker labs
```

### View Logs
```bash
tail -f log/development.log
```

### Restart Server
```bash
# Find process
lsof -ti:3000

# Kill and restart
kill $(lsof -ti:3000)
rails server -b 0.0.0.0
```

---

## 🚢 Production Deployment

Before deploying:

- [ ] Add JWT authentication
- [ ] Update CORS to production domain only
- [ ] Switch to PostgreSQL (not SQLite)
- [ ] Enable HTTPS/SSL
- [ ] Add rate limiting (rack-attack gem)
- [ ] Set up monitoring/logging
- [ ] Configure Redis for caching
- [ ] Add API versioning strategy
- [ ] Set up CI/CD pipeline

---

## 📝 Response Format

All endpoints return consistent format:

**Success:**
```json
{
  "success": true,
  "data": { ... }
}
```

**Error:**
```json
{
  "success": false,
  "error": "Error message"
}
```

---

## 🐛 Troubleshooting

### CORS Errors
- Verify Rails server is running
- Check `config/initializers/cors.rb` includes your origin
- Restart server after CORS changes

### No Lessons Returned
- Verify `track` parameter is correct (`docker` or `kubernetes`)
- Check database has content: `rails console` → `InteractiveLearningUnit.count`

### Commands Not Validating
- Ensure lesson exists with that `lessonId`
- Check command format matches expected syntax

---

## 📚 Files Reference

- **CORS Config:** `config/initializers/cors.rb`
- **Test Page:** `public/test_cors.html`
- **Controller:** `app/controllers/continuous_learning_controller.rb`
- **Docker Content:** `app/services/docker_content_library.rb`
- **Kubernetes Content:** `app/services/kubernetes_content_library.rb`

---

## 🎉 Ready to Build!

Your Rails backend is ready to serve learning content. Build your React app and start consuming the API!

**Test it now:** http://localhost:3000/test_cors.html
