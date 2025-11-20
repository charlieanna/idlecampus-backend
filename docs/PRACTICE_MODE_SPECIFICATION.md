# Practice Mode Specification: Post-Module Continuous Learning

## Overview

After completing all 13 modules (Modules 0-12), users enter **Practice Mode** - an intelligent, adaptive system that uses spaced repetition and failure tracking to maintain and deepen mastery across all 438+ algorithm problems.

---

## System Goals

1. **Spaced Repetition Mastery**: Use FSRS algorithm to schedule reviews at optimal intervals
2. **Adaptive Learning**: Adjust difficulty and problem selection based on user performance
3. **Failure Analysis**: Track mistakes and weaknesses, then target remediation
4. **Family-Based Learning**: Group problems by pattern families for deeper understanding
5. **Long-term Retention**: Prevent skill decay through intelligent review scheduling

---

## Architecture Components

### 1. Practice Mode State Machine

```typescript
enum PracticeMode {
  MODULE_LEARNING = 'module_learning',    // Modules 0-12 in progress
  PRACTICE_UNLOCKED = 'practice_unlocked', // All modules complete, practice available
  ACTIVE_PRACTICE = 'active_practice',     // Currently in practice session
  MASTERY_REVIEW = 'mastery_review'        // Periodic mastery verification
}
```

**Trigger**: User completes all module keystones → `PRACTICE_UNLOCKED`

---

### 2. Enhanced Progress Tracking Schema

Extends existing `userProgressStore.ts` with practice-specific data:

```typescript
interface PracticeModeData {
  // Session Management
  totalPracticeSessions: number;
  currentStreak: number;
  longestStreak: number;
  lastPracticeDate: Date;

  // Problem Queue Management
  reviewQueue: ProblemReview[];          // Problems due for review
  learningQueue: string[];                // New problems to learn
  buriedProblems: string[];               // Temporarily suspended

  // Performance Analytics
  weeklyStats: WeeklyPracticeStats[];
  conceptWeaknesses: Map<string, WeaknessMetrics>;
  problemFamilyMastery: Map<string, FamilyMastery>;

  // Adaptive Parameters
  currentDifficulty: 'easy' | 'medium' | 'hard';
  targetAccuracy: number;                 // Dynamic target (60-80%)
  reviewPressure: number;                 // 0-100, affects new/review ratio
}

interface ProblemReview {
  problemId: string;
  dueDate: Date;
  stability: number;                      // Days until 90% retention (FSRS)
  difficulty: number;                     // Internal difficulty rating
  intervalModifier: number;               // User-specific adjustment
  lapses: number;                         // Times failed after "learned"
  priority: number;                       // Calculated priority score
}

interface WeaknessMetrics {
  concept: string;
  failureRate: number;                    // % of attempts that fail
  avgTimeToSolve: number;                 // Seconds
  lastFailure: Date;
  consecutiveFailures: number;
  needsRemediation: boolean;              // Triggers focused practice
}

interface FamilyMastery {
  familyId: string;                       // e.g., "two-pointers-opposite-ends"
  problemsAttempted: number;
  problemsMastered: number;               // Stability > 21 days
  averageStability: number;
  familyDifficulty: number;               // Learned difficulty for this user
}
```

---

### 3. Intelligent Problem Selection Algorithm

**File**: `lib/learning/PracticeModeSelector.ts`

```typescript
class PracticeModeSelector {
  /**
   * Selects next problem using multi-factor scoring:
   * - Spaced repetition urgency (overdue reviews prioritized)
   * - Weakness targeting (recent failures get priority)
   * - Family diversity (avoid repeating same pattern)
   * - Difficulty balancing (maintain target success rate)
   */
  selectNextProblem(userData: PracticeModeData): Problem {
    const now = new Date();

    // 1. Check for OVERDUE reviews (critical priority)
    const overdueReviews = userData.reviewQueue
      .filter(r => r.dueDate < now)
      .sort((a, b) => b.priority - a.priority);

    if (overdueReviews.length > 0) {
      return this.selectFromReviews(overdueReviews, userData);
    }

    // 2. Balance new vs. review based on review pressure
    const reviewPressure = this.calculateReviewPressure(userData);

    if (reviewPressure > 70 || Math.random() < 0.4) {
      // 40% of time: Review upcoming problems
      return this.selectReviewProblem(userData);
    } else {
      // 60% of time: Learn new problem
      return this.selectNewProblem(userData);
    }
  }

  private selectReviewProblem(userData: PracticeModeData): Problem {
    // Prioritize by:
    // 1. Due soon (next 24 hours)
    // 2. High lapse count (struggled before)
    // 3. Weak concept area
    // 4. Low stability (forgotten quickly)

    const scores = userData.reviewQueue.map(review => ({
      problemId: review.problemId,
      score: this.calculateReviewScore(review, userData)
    }));

    scores.sort((a, b) => b.score - a.score);
    return getProblemById(scores[0].problemId);
  }

  private calculateReviewScore(review: ProblemReview, userData: PracticeModeData): number {
    const hoursTilDue = (review.dueDate.getTime() - Date.now()) / (1000 * 60 * 60);

    let score = 0;

    // Urgency component (0-40 points)
    if (hoursTilDue < 0) {
      score += 40; // Overdue
    } else if (hoursTilDue < 24) {
      score += 30; // Due today
    } else if (hoursTilDue < 72) {
      score += 20; // Due this week
    }

    // Struggle component (0-30 points)
    score += Math.min(review.lapses * 10, 30);

    // Weakness component (0-20 points)
    const problem = getProblemById(review.problemId);
    const weakness = userData.conceptWeaknesses.get(problem.concept);
    if (weakness?.needsRemediation) {
      score += 20;
    }

    // Stability component (0-10 points)
    if (review.stability < 7) {
      score += 10; // Very unstable, needs frequent review
    }

    return score;
  }

  private selectNewProblem(userData: PracticeModeData): Problem {
    // Strategy:
    // 1. Identify weakest concept areas
    // 2. Find problem families with low mastery
    // 3. Select appropriate difficulty
    // 4. Ensure variety (don't repeat same family)

    const weakConcepts = this.getWeakestConcepts(userData, 5);
    const recentFamilies = this.getRecentFamilies(userData, 3);

    // Filter problems:
    const candidates = allProblems.filter(p => {
      // Must be from weak concept
      if (!weakConcepts.includes(p.concept)) return false;

      // Avoid recently practiced families
      if (recentFamilies.includes(p.familyId)) return false;

      // Match current difficulty level
      if (!this.isDifficultyAppropriate(p, userData)) return false;

      // Not already mastered
      const history = userData.problemHistory[p.id];
      if (history && history.stability > 21) return false;

      return true;
    });

    // Random selection from top candidates (variety)
    const topCandidates = candidates.slice(0, 10);
    return topCandidates[Math.floor(Math.random() * topCandidates.length)];
  }

  private calculateReviewPressure(userData: PracticeModeData): number {
    const now = Date.now();
    const oneDayMs = 24 * 60 * 60 * 1000;

    const dueSoon = userData.reviewQueue.filter(r =>
      r.dueDate.getTime() - now < oneDayMs
    ).length;

    const overdue = userData.reviewQueue.filter(r =>
      r.dueDate.getTime() < now
    ).length;

    // Pressure increases with overdue and upcoming reviews
    return Math.min((overdue * 10 + dueSoon * 5), 100);
  }
}
```

---

### 4. Spaced Repetition Scheduler (FSRS)

**File**: `lib/learning/SpacedRepetitionScheduler.ts`

Uses the FSRS (Free Spaced Repetition Scheduler) algorithm already partially implemented:

```typescript
interface FSRSCard {
  stability: number;      // Days until 90% retention probability
  difficulty: number;     // Learned difficulty (0-10)
  elapsedDays: number;   // Days since last review
  scheduledDays: number; // Days until next review
  reps: number;          // Total review count
  lapses: number;        // Times forgotten
}

class SpacedRepetitionScheduler {
  /**
   * FSRS Core Formula: R(t) = e^(-t/S)
   * R = Retention probability
   * t = Time since review (days)
   * S = Stability (days until 90% retention)
   */

  scheduleNextReview(
    problemId: string,
    result: 'again' | 'hard' | 'good' | 'easy',
    card: FSRSCard
  ): ProblemReview {
    const { stability, difficulty, elapsedDays, lapses, reps } = card;

    let newStability: number;
    let newDifficulty: number;
    let newLapses = lapses;

    switch (result) {
      case 'again': // Failed
        newStability = this.calculateNewStability(stability, difficulty, 'again');
        newDifficulty = Math.min(difficulty + 2, 10);
        newLapses += 1;
        break;

      case 'hard': // Struggled
        newStability = this.calculateNewStability(stability, difficulty, 'hard');
        newDifficulty = Math.min(difficulty + 0.5, 10);
        break;

      case 'good': // Solved correctly
        newStability = this.calculateNewStability(stability, difficulty, 'good');
        newDifficulty = Math.max(difficulty - 0.1, 0);
        break;

      case 'easy': // Solved easily
        newStability = this.calculateNewStability(stability, difficulty, 'easy');
        newDifficulty = Math.max(difficulty - 0.5, 0);
        break;
    }

    // Calculate next review date
    const intervalDays = this.calculateInterval(newStability, result);
    const dueDate = new Date(Date.now() + intervalDays * 24 * 60 * 60 * 1000);

    return {
      problemId,
      dueDate,
      stability: newStability,
      difficulty: newDifficulty,
      intervalModifier: 1.0,
      lapses: newLapses,
      priority: this.calculatePriority(newStability, newLapses)
    };
  }

  private calculateNewStability(
    oldStability: number,
    difficulty: number,
    grade: 'again' | 'hard' | 'good' | 'easy'
  ): number {
    // Simplified FSRS stability calculation
    const gradeMultipliers = {
      again: 0.3,  // Sharp decay when forgotten
      hard: 1.2,   // Slight increase
      good: 2.5,   // Standard increase
      easy: 4.0    // Large increase
    };

    const baseStability = oldStability * gradeMultipliers[grade];

    // Difficulty modifier (harder problems = slower growth)
    const difficultyPenalty = 1 - (difficulty / 20);

    return Math.max(baseStability * difficultyPenalty, 0.5);
  }

  private calculateInterval(stability: number, grade: string): number {
    // Return interval based on desired retention (90%)
    const retentionTarget = 0.9;
    const interval = stability * Math.log(retentionTarget) / Math.log(0.9);

    // Minimum intervals by grade
    const minIntervals = {
      again: 0.1,  // 2.4 hours
      hard: 1,     // 1 day
      good: 1,     // 1 day
      easy: 3      // 3 days
    };

    return Math.max(interval, minIntervals[grade] || 1);
  }

  private calculatePriority(stability: number, lapses: number): number {
    // Lower stability + more lapses = higher priority
    const stabilityScore = Math.max(0, 100 - stability * 2);
    const lapseScore = lapses * 15;

    return stabilityScore + lapseScore;
  }
}
```

---

### 5. Failure Tracking & Adaptive Remediation

**File**: `lib/learning/FailureAnalyzer.ts`

```typescript
class FailureAnalyzer {
  /**
   * Analyzes failure patterns and triggers remediation
   */
  analyzeFailure(
    problemId: string,
    attemptData: AttemptData,
    userData: PracticeModeData
  ): RemediationPlan {
    const problem = getProblemById(problemId);

    // Update weakness metrics
    const weakness = userData.conceptWeaknesses.get(problem.concept) || {
      concept: problem.concept,
      failureRate: 0,
      avgTimeToSolve: 0,
      consecutiveFailures: 0,
      lastFailure: new Date(),
      needsRemediation: false
    };

    weakness.consecutiveFailures += 1;
    weakness.lastFailure = new Date();
    weakness.failureRate = this.recalculateFailureRate(problem.concept, userData);

    // Trigger remediation if needed
    if (this.shouldTriggerRemediation(weakness)) {
      return this.createRemediationPlan(weakness, userData);
    }

    return null;
  }

  private shouldTriggerRemediation(weakness: WeaknessMetrics): boolean {
    return (
      weakness.consecutiveFailures >= 3 ||          // 3 fails in a row
      weakness.failureRate > 0.6 ||                 // >60% failure rate
      (weakness.failureRate > 0.4 && weakness.avgTimeToSolve > 600) // Struggling
    );
  }

  private createRemediationPlan(
    weakness: WeaknessMetrics,
    userData: PracticeModeData
  ): RemediationPlan {
    const concept = weakness.concept;

    return {
      type: 'CONCEPT_REVIEW',
      concept,
      actions: [
        {
          type: 'REVISIT_LESSON',
          lessonId: this.getLessonForConcept(concept),
          reason: 'Review fundamental patterns'
        },
        {
          type: 'SOLVE_EASIER_PROBLEMS',
          problemIds: this.getEasierProblems(concept, userData),
          reason: 'Build confidence with easier variants'
        },
        {
          type: 'FOCUSED_PRACTICE',
          duration: 'next_5_problems',
          filter: { concept, maxDifficulty: 'medium' },
          reason: 'Intensive practice in weak area'
        }
      ],
      estimatedDuration: '30-60 minutes'
    };
  }

  trackSuccess(
    problemId: string,
    attemptData: AttemptData,
    userData: PracticeModeData
  ): void {
    const problem = getProblemById(problemId);
    const weakness = userData.conceptWeaknesses.get(problem.concept);

    if (weakness) {
      // Reset consecutive failures on success
      weakness.consecutiveFailures = 0;

      // Gradually improve failure rate
      weakness.failureRate = this.recalculateFailureRate(problem.concept, userData);

      // Remove remediation flag if improved
      if (weakness.failureRate < 0.3) {
        weakness.needsRemediation = false;
      }
    }
  }
}

interface RemediationPlan {
  type: 'CONCEPT_REVIEW' | 'FAMILY_PRACTICE' | 'DIFFICULTY_ADJUSTMENT';
  concept: string;
  actions: RemediationAction[];
  estimatedDuration: string;
}

interface RemediationAction {
  type: 'REVISIT_LESSON' | 'SOLVE_EASIER_PROBLEMS' | 'FOCUSED_PRACTICE' | 'WATCH_SOLUTION';
  lessonId?: string;
  problemIds?: string[];
  duration?: string;
  filter?: ProblemFilter;
  reason: string;
}
```

---

### 6. Practice Session Flow

```typescript
interface PracticeSession {
  sessionId: string;
  startTime: Date;
  endTime?: Date;
  problemsAttempted: string[];
  results: Map<string, SessionResult>;
  sessionGoal: SessionGoal;
}

interface SessionGoal {
  type: 'TIME_BASED' | 'PROBLEM_COUNT' | 'CONCEPT_MASTERY';
  target: number;                    // Minutes, count, or mastery %
  current: number;
  completed: boolean;
}

interface SessionResult {
  problemId: string;
  result: 'again' | 'hard' | 'good' | 'easy';
  timeSpent: number;
  hintsUsed: number;
  submissionCount: number;
  code: string;
  testResults: TestResult[];
}

class PracticeSessionManager {
  startSession(goalType: string, targetValue: number): PracticeSession {
    return {
      sessionId: generateId(),
      startTime: new Date(),
      problemsAttempted: [],
      results: new Map(),
      sessionGoal: {
        type: goalType,
        target: targetValue,
        current: 0,
        completed: false
      }
    };
  }

  async getNextProblem(session: PracticeSession, userData: PracticeModeData): Promise<Problem> {
    const selector = new PracticeModeSelector();
    const problem = selector.selectNextProblem(userData);

    session.problemsAttempted.push(problem.id);
    return problem;
  }

  recordResult(
    session: PracticeSession,
    problemId: string,
    result: SessionResult,
    userData: PracticeModeData
  ): void {
    session.results.set(problemId, result);

    // Update spaced repetition schedule
    const scheduler = new SpacedRepetitionScheduler();
    const card = this.getCardData(problemId, userData);
    const nextReview = scheduler.scheduleNextReview(problemId, result.result, card);

    // Update review queue
    this.updateReviewQueue(userData, nextReview);

    // Analyze for failures
    const analyzer = new FailureAnalyzer();
    if (result.result === 'again') {
      const plan = analyzer.analyzeFailure(problemId, result, userData);
      if (plan) {
        this.executePlan(plan, userData);
      }
    } else {
      analyzer.trackSuccess(problemId, result, userData);
    }

    // Update session progress
    this.updateSessionProgress(session);
  }

  private updateSessionProgress(session: PracticeSession): void {
    const goal = session.sessionGoal;

    switch (goal.type) {
      case 'TIME_BASED':
        const elapsed = (Date.now() - session.startTime.getTime()) / 60000;
        goal.current = elapsed;
        break;

      case 'PROBLEM_COUNT':
        goal.current = session.problemsAttempted.length;
        break;

      case 'CONCEPT_MASTERY':
        // Calculate current mastery %
        goal.current = this.calculateMasteryProgress(session);
        break;
    }

    goal.completed = goal.current >= goal.target;
  }
}
```

---

## User Interface Components

### 1. Practice Dashboard

**File**: `client/src/pages/PracticeDashboard.tsx`

**Features:**
- Review queue visualization (overdue, due today, upcoming)
- Weekly practice statistics (heatmap calendar)
- Concept mastery radar chart
- Current streak and session goals
- Quick start buttons (5/10/20 min sessions)

### 2. Practice Problem View

**Enhancements to existing problem view:**
- After-solve self-grading: "Again | Hard | Good | Easy"
- Time tracking display
- Hint usage counter
- Family context: "This is a Two Pointers (Opposite Ends) problem"
- Related problems in family (after solving)

### 3. Progress Analytics

**File**: `client/src/pages/PracticeAnalytics.tsx`

**Metrics:**
- Retention curve (FSRS predicted vs actual)
- Concept weakness heatmap
- Problem family mastery breakdown
- Average time per difficulty
- Success rate trends over time

---

## Implementation Phases

### Phase 1: Foundation (Week 1)
- [ ] Extend `userProgressStore` with practice mode schema
- [ ] Implement `PracticeModeSelector` with multi-factor scoring
- [ ] Build `SpacedRepetitionScheduler` with FSRS algorithm
- [ ] Create database migrations for practice data

### Phase 2: Core Features (Week 2)
- [ ] Implement `FailureAnalyzer` and remediation system
- [ ] Build `PracticeSessionManager`
- [ ] Create Practice Dashboard UI
- [ ] Add self-grading interface to problem view

### Phase 3: Intelligence (Week 3)
- [ ] Implement adaptive difficulty adjustment
- [ ] Add family-based problem clustering
- [ ] Build review queue prioritization
- [ ] Create weakness detection algorithms

### Phase 4: Analytics & Polish (Week 4)
- [ ] Build Practice Analytics dashboard
- [ ] Add retention prediction charts
- [ ] Implement streak tracking and gamification
- [ ] Performance optimization and testing

---

## Key Metrics for Success

1. **Retention Rate**: >80% of problems reviewed at correct intervals
2. **Weakness Detection**: Identify struggling concepts within 5 attempts
3. **Adaptive Accuracy**: Maintain 60-70% success rate (optimal learning zone)
4. **Review Adherence**: <10% overdue reviews in queue
5. **Long-term Mastery**: >90% problems with stability >21 days after 6 months

---

## Integration with Existing Systems

### With Module System
- Practice mode unlocks after completing all 13 module keystones
- Users can return to modules for remediation
- Module completion certificates displayed in practice dashboard

### With Learning Engine
- Reuses existing `learningEngine.ts` concept sequencing
- Extends with practice-specific selectors
- Maintains compatibility with chapter-based learning

### With Progress Store
- Builds on existing `userProgressStore.ts`
- Backwards compatible with current progress data
- Adds practice-specific fields without breaking changes

---

## Technical Considerations

### Performance
- Index review queue by due date for fast queries
- Cache problem metadata to reduce lookups
- Lazy load analytics data

### Data Storage
- Primary: Client-side localStorage (offline-first)
- Optional: PostgreSQL sync for multi-device
- Export/import functionality for backup

### Privacy
- All practice data stays local by default
- Opt-in anonymous analytics for improvement
- GDPR-compliant data deletion

---

## Future Enhancements

1. **Social Features**: Compare progress with peers (anonymized)
2. **Problem Authoring**: Community-contributed problems
3. **Interview Simulation**: Timed mock interviews with random problems
4. **Collaborative Practice**: Pair programming mode
5. **Mobile App**: Native iOS/Android with practice reminders
6. **AI Tutor**: Personalized explanations for failed attempts

---

## Conclusion

This practice mode transforms IdleCampus from a **structured curriculum** into a **lifelong learning companion**, ensuring users maintain and deepen their algorithmic skills through scientifically-proven spaced repetition and adaptive learning techniques.
