# AI Tutor System Documentation

## Overview

The AI Tutor System is an intelligent learning companion that tracks student progress, detects learning patterns, and provides personalized guidance, motivation, and support throughout their learning journey.

## Features

### 1. **Adaptive Messaging**
- **Welcome Messages**: Greets new students or welcomes them back after breaks
- **Motivation**: Encourages students who are struggling with concepts
- **Celebration**: Celebrates achievements like level-ups, streaks, and module completions
- **Hints**: Provides contextual help when students are stuck on exercises
- **Gentle Nudges**: Reminds inactive students to continue learning

### 2. **Smart Triggers**
The tutor automatically detects these situations:
- First visit to a course
- Returning after 7+ days inactive
- Struggling (3+ wrong attempts on an exercise)
- Level up (every 100 points)
- Module completion
- Streak milestones (7, 14, 30 days)
- 14+ days of inactivity

### 3. **Personalization**
- Configurable tone: friendly, professional, enthusiastic
- Adjustable frequency: minimal, normal, frequent
- Mute option for focused learning
- Context-aware messages based on course and progress

## Architecture

### Database Schema

#### `tutor_messages_v2`
Stores all tutor interactions with students.

```typescript
{
  id: string (UUID)
  userId: string
  courseId: string (optional)
  messageType: 'welcome' | 'motivation' | 'celebration' | 'hint' | 'nudge'
  trigger: string (what caused this message)
  message: text (the actual message content)
  metadata: jsonb (additional context)
  isDismissed: boolean
  isRead: boolean
  createdAt: timestamp
}
```

#### `user_tutor_preferences_v2`
User preferences for tutor behavior.

```typescript
{
  userId: string (primary key)
  enabled: boolean (default: true)
  tone: 'friendly' | 'professional' | 'enthusiastic'
  frequency: 'minimal' | 'normal' | 'frequent'
  mutedUntil: timestamp (optional)
  preferences: jsonb
  updatedAt: timestamp
}
```

### Services

#### `services/ollamaService.ts`
Connects to local Ollama instance for AI text generation.

**Key Functions:**
- `generate(prompt, options)` - Core text generation
- `generateTutorMessage(context)` - Create personalized tutor messages
- `generateHint(context)` - Generate hints for struggling students
- `explainConcept(context)` - Explain topics in simpler terms
- `isAvailable()` - Check if Ollama is running
- `listModels()` - List available AI models

#### `services/aiTutorService.ts`
Main tutor logic with trigger detection and message generation.

**Key Functions:**
- `checkForTutorMessage(userId, courseId, action, metadata)` - Detect if tutor should respond
- `generateHintForExercise(...)` - Create exercise-specific hints
- `getUnreadMessages(userId)` - Fetch unread tutor messages
- `markMessageAsRead(messageId)` - Mark message as read
- `dismissMessage(messageId)` - Dismiss a message
- `updateUserTutorPreferences(userId, updates)` - Update user settings

### API Endpoints

All endpoints require authentication.

#### Get Unread Messages
```
GET /api/tutor/messages
Response: { messages: TutorMessage[], count: number }
```

#### Mark Message as Read
```
POST /api/tutor/messages/:id/read
Response: { success: true }
```

#### Dismiss Message
```
POST /api/tutor/messages/:id/dismiss
Response: { success: true }
```

#### Request Hint
```
POST /api/tutor/hint
Body: {
  courseId: string
  exerciseId: string
  exerciseTitle: string
  exerciseType: string
}
Response: { hint: string, exerciseId: string, generatedAt: Date }
```

#### Get Tutor Preferences
```
GET /api/tutor/preferences
Response: { enabled: boolean, tone: string, frequency: string }
```

#### Update Tutor Preferences
```
PUT /api/tutor/preferences
Body: {
  enabled?: boolean
  tone?: 'friendly' | 'professional' | 'enthusiastic'
  frequency?: 'minimal' | 'normal' | 'frequent'
  mutedUntil?: string (ISO date)
}
Response: { success: true }
```

#### Check Ollama Status
```
GET /api/tutor/status
Response: {
  available: boolean
  models: string[]
  url: string
  model: string
  status: 'online' | 'offline'
}
```

#### Manual Trigger (for testing)
```
POST /api/tutor/trigger
Body: {
  courseId: string
  action: string
  metadata?: any
}
Response: { messageGenerated: boolean, message: TutorMessage | null }
```

## Integration Points

The tutor is automatically integrated into:

### 1. **Course Access** (`getCourseById`)
- Welcomes new students on first visit
- Welcomes back students after 7+ days inactive

### 2. **Progress Updates** (`updateProgress`)
- Celebrates level-ups (every 100 points)
- Celebrates module completions
- Tracks learning activity

### 3. **Exercise Validation** (`validateExercise`)
- Detects struggling (3+ wrong attempts)
- Offers motivational messages or hints

## Setup Instructions

### Prerequisites

1. **Ollama Service**
   - Install Ollama: https://ollama.ai
   - Pull a model: `ollama pull llama3.2`
   - Verify it's running: `curl http://localhost:11434/api/tags`

2. **Node.js Dependencies**
   ```bash
   npm install express @types/express axios drizzle-orm zod
   ```

3. **Environment Variables**
   ```bash
   # .env
   OLLAMA_URL=http://localhost:11434
   OLLAMA_MODEL=llama3.2
   ```

### Database Migration

Run migrations to create the tutor tables:

```sql
-- Create tutor_messages_v2 table
CREATE TABLE tutor_messages_v2 (
  id VARCHAR(255) PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id VARCHAR(255) NOT NULL,
  course_id VARCHAR(255),
  message_type VARCHAR(50) NOT NULL,
  trigger VARCHAR(100) NOT NULL,
  message TEXT NOT NULL,
  metadata JSONB,
  is_dismissed BOOLEAN DEFAULT FALSE,
  is_read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Create user_tutor_preferences_v2 table
CREATE TABLE user_tutor_preferences_v2 (
  user_id VARCHAR(255) PRIMARY KEY,
  enabled BOOLEAN DEFAULT TRUE,
  tone VARCHAR(50) DEFAULT 'friendly',
  frequency VARCHAR(50) DEFAULT 'normal',
  muted_until TIMESTAMP,
  preferences JSONB,
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Create indexes
CREATE INDEX idx_tutor_messages_user ON tutor_messages_v2(user_id);
CREATE INDEX idx_tutor_messages_unread ON tutor_messages_v2(user_id, is_read, is_dismissed);
```

### Running the System

If you have a separate Node.js/Express server:

1. **Register Routes**
   ```typescript
   import tutorRoutes from './routes/aiTutor';
   app.use('/api/tutor', tutorRoutes);
   ```

2. **Start Ollama**
   ```bash
   ollama serve
   ```

3. **Test the System**
   ```bash
   curl http://localhost:3000/api/tutor/status
   ```

## Usage Examples

### Frontend Integration

#### Check for Tutor Messages
```typescript
async function checkTutorMessages() {
  const response = await fetch('/api/tutor/messages');
  const { messages } = await response.json();

  if (messages.length > 0) {
    // Display tutor message in UI
    showTutorWidget(messages[0]);
  }
}
```

#### Request a Hint
```typescript
async function requestHint(exerciseId: string) {
  const response = await fetch('/api/tutor/hint', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      courseId: currentCourse.id,
      exerciseId: exerciseId,
      exerciseTitle: 'Docker Volumes',
      exerciseType: 'quiz'
    })
  });

  const { hint } = await response.json();
  displayHint(hint);
}
```

#### Update Preferences
```typescript
async function muteTutorFor24Hours() {
  const mutedUntil = new Date();
  mutedUntil.setHours(mutedUntil.getHours() + 24);

  await fetch('/api/tutor/preferences', {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      mutedUntil: mutedUntil.toISOString()
    })
  });
}
```

## Trigger Examples

### 1. Welcome Message (First Visit)
```
Trigger: User opens course for the first time
Action: 'start_course'

Tutor: "Welcome to Docker Fundamentals! I'm your learning companion.
I'll be here to guide you, celebrate your progress, and help when
you're stuck. Let's start this journey together!"
```

### 2. Motivation (Struggling)
```
Trigger: 3 wrong attempts on "Docker Volumes" quiz
Action: 'complete_exercise'

Tutor: "Docker Volumes can be tricky! You're putting in solid effort.
Think of volumes like external hard drives that persist even when
containers are deleted. Want to review the lesson or try again?"
```

### 3. Celebration (Level Up)
```
Trigger: Reached Level 5
Action: 'progress_update'

Tutor: "Amazing! You just leveled up to Level 5! You've mastered
50+ concepts. Your dedication is really paying off. Ready to tackle
the next challenge?"
```

### 4. Gentle Nudge (Inactive)
```
Trigger: 14 days since last activity
Action: 'inactive_check'

Tutor: "Hey there! It's been two weeks since you practiced Kubernetes.
Life gets busy, I get it. But you were doing great! Ready to pick up
where you left off?"
```

## Customization

### Adjust Tutor Personality

Edit prompts in `services/ollamaService.ts`:

```typescript
function buildTutorPrompt(context) {
  // Change base personality here
  let basePrompt = `You are an ${context.tone} coding tutor...`;

  // Customize for different message types
  switch (context.messageType) {
    case 'motivation':
      // Make it more or less encouraging
      basePrompt += `Be VERY empathetic and inspiring...`;
      break;
  }
}
```

### Add New Triggers

In `services/aiTutorService.ts`:

```typescript
function detectTrigger(action, behavior, metadata) {
  // Add your custom trigger
  if (behavior.fastLearner && action === 'complete_exercise') {
    return 'challenge_advanced_learner';
  }
}
```

### Change Frequency Thresholds

In `services/aiTutorService.ts`:

```typescript
const thresholds = {
  minimal: 48,   // Adjust: hours between messages
  normal: 12,
  frequent: 1
};
```

## Performance Considerations

- **Ollama Response Time**: 2-5 seconds per generation
- **Frequency Limits**: Prevents message spam
- **Async Operations**: Tutor checks don't block main operations
- **Caching**: Consider caching common message templates

## Monitoring

### Check Tutor Activity
```sql
SELECT
  message_type,
  COUNT(*) as count,
  AVG(CASE WHEN is_read THEN 1 ELSE 0 END) as read_rate
FROM tutor_messages_v2
WHERE created_at > NOW() - INTERVAL '7 days'
GROUP BY message_type;
```

### Student Engagement
```sql
SELECT
  u.user_id,
  COUNT(DISTINCT tm.id) as messages_received,
  COUNT(DISTINCT CASE WHEN tm.is_read THEN tm.id END) as messages_read
FROM user_course_progress_v2 u
LEFT JOIN tutor_messages_v2 tm ON tm.user_id = u.user_id
GROUP BY u.user_id;
```

## Troubleshooting

### Ollama Not Available
```bash
# Check if Ollama is running
curl http://localhost:11434/api/tags

# Start Ollama
ollama serve

# Check logs
journalctl -u ollama -f
```

### No Messages Generated
- Check user preferences (might be muted)
- Verify frequency thresholds
- Check trigger conditions
- Review Ollama logs

### Slow Response Times
- Use smaller model (llama3.2:1b instead of llama3.2)
- Reduce temperature/tokens
- Consider caching common messages
- Run Ollama with GPU acceleration

## Future Enhancements

- [ ] Sentiment analysis of student responses
- [ ] Adaptive difficulty recommendations
- [ ] Study time optimization suggestions
- [ ] Peer comparison insights
- [ ] Progress prediction and goal setting
- [ ] Voice/chat interface
- [ ] Multi-language support
- [ ] Integration with calendar/reminders

## License

This AI Tutor system is part of IdleCampus Backend.

## Support

For issues or questions about the AI Tutor system, please contact the development team or open an issue in the repository.
