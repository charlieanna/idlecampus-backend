# Position-Based Spaced Repetition

## Overview

Instead of using time-based spaced repetition (FSRS with days/hours), this system uses **position-based** tracking optimized for **intensive interview prep sessions** where users solve many problems in a stretch.

---

## Key Concept: Global Problem Counter

Instead of tracking "days since last practice," we track **"problems solved since last practice"**.

```typescript
globalProblemCounter: 50  // User has solved 50 total problems in practice mode
```

---

## How It Works

### Example Session

```
User starts practice mode:
- globalProblemCounter: 0

Problem 1 (Two Pointers): Solved - Grade: "good"
- globalProblemCounter: 1
- Schedule review after 8-12 problems
- reviewInterval: 10 (random between 8-12)

Problem 2 (Sliding Window): Solved - Grade: "easy"
- globalProblemCounter: 2
- Schedule review after 15-20 problems
- reviewInterval: 17

Problem 3-10: Solved (various concepts)
- globalProblemCounter: 10

Problem 11: System checks - "Two Pointers problem is due!"
- problemsSolvedSince = 10 (current counter) - 1 (last practiced) = 9
- reviewInterval = 10
- 9 < 10, so not quite due yet

Problem 12: Two Pointers problem selected for review
- problemsSolvedSince = 11
- 11 >= 10, so it's time to review!
```

---

## Review Intervals (Position-Based)

Instead of days, we use **problem counts**:

| Grade | Time-Based (Old) | Position-Based (New) | Meaning |
|-------|------------------|----------------------|---------|
| **Again** | 2.4 hours | 1-2 problems | Immediate review |
| **Hard** | 1 day | 3-5 problems | Short-term review |
| **Good** | 1-3 days | 8-12 problems | Medium-term review |
| **Easy** | 3-7 days | 15-20 problems | Long-term mastery |

---

## Concept Decay

Tracks how long it's been since practicing each concept:

```typescript
conceptDecay: {
  'two-pointers': {
    concept: 'two-pointers',
    problemsSolvedSince: 15,        // 15 problems since last two-pointers
    lastPracticedAt: 10,             // Last practiced at counter = 10
    needsReview: true                // Exceeds threshold (8 problems)
  }
}
```

### Decay Thresholds

```typescript
concept: {
  low: 3,       // Review after 3-5 new problems
  medium: 8,    // Medium decay after 8-12 problems (needs review)
  high: 15      // High decay after 15-20 problems (urgent)
}

family: {
  low: 5,       // Review family after 5-8 problems
  medium: 12,   // Medium decay
  high: 25      // High decay
}
```

---

## Family Decay

Same concept, but for problem families:

```typescript
familyDecay: {
  'two-pointers-opposite-ends': {
    familyId: 'two-pointers-opposite-ends',
    problemsSolvedSince: 20,
    lastPracticedAt: 5,
    needsReview: true
  }
}
```

---

## Problem Selection Strategy

1. **Urgent Reviews** (highest priority)
   - Problems where `problemsSolvedSince >= reviewInterval`

2. **Forced Review** (every 5 problems)
   - `problemsUntilNextReview` counts down
   - When it hits 0, force a review problem
   - Resets to 5 after review

3. **Decayed Concepts**
   - Concepts where `problemsSolvedSince >= 8`
   - Selects from previously practiced problems in that concept

4. **Decayed Families**
   - Families where `problemsSolvedSince >= 12`

5. **New Problems** (60% of time)
   - Targets weak concepts
   - Avoids recently practiced families
   - Matches current difficulty

---

## Advantages for Interview Prep

### 1. Session-Aware
```
Traditional (Time-Based):
- Day 1: Solve 20 problems
- Day 2: All 20 problems "due" tomorrow
- Not helpful during intensive study

Position-Based:
- Problem 1-20: Solved
- Problem 21: Review problem #1 (if marked "again")
- Problem 30: Review problem #5 (if marked "good")
- Natural spacing within session
```

### 2. Adaptive to Study Intensity
```
Slow Study (5 problems/day):
- "Good" grade = review in ~2 days
- "Easy" grade = review in ~3-4 days

Intense Study (50 problems/day):
- "Good" grade = review same day (after 8 more problems)
- "Easy" grade = review next day (after 15 more problems)
```

### 3. Prevents Concept Decay
```
After solving 8 problems in other concepts:
- System forces review of old concepts
- Maintains variety
- Prevents forgetting
```

---

## Implementation Example

### User Solving Problems

```typescript
// Problem 1: Two Pointers (solved with "good")
globalProblemCounter: 0 → 1
reviewQueue.push({
  problemId: "two-sum",
  problemsSolvedSince: 0,           // Just solved
  reviewInterval: 10,               // Review after 10 more problems
  lastReviewedAt: 1,                // Solved at counter = 1
  mastery: 'reviewing'
})

// Problems 2-10: Other concepts
globalProblemCounter: 1 → 10

// Problem 11: System checks reviews
updateDecayCounters(practiceData, 10)
// Updates: problemsSolvedSince = 10 - 1 = 9

// Problem 12: Two Pointers due!
problemsSolvedSince = 11 - 1 = 10
reviewInterval = 10
10 >= 10 → DUE FOR REVIEW!
```

### Concept Decay Tracking

```typescript
// After solving 3 sliding window problems at counter = 5
conceptDecay['sliding-window'] = {
  concept: 'sliding-window',
  problemsSolvedSince: 0,
  lastPracticedAt: 5,
  needsReview: false
}

// At counter = 15 (10 problems later)
updateDecayCounters(practiceData, 15)
conceptDecay['sliding-window'].problemsSolvedSince = 15 - 5 = 10
conceptDecay['sliding-window'].needsReview = true  // Exceeds threshold (8)

// System prioritizes sliding window problems
```

---

## Comparison: Time vs Position

### Scenario: User solves 30 problems in one day

**Time-Based (FSRS)**:
```
Problem 1 (00:00): Solved → Review in 1 day (tomorrow 00:00)
Problem 10 (01:00): Solved → Review in 1 day (tomorrow 01:00)
Problem 20 (02:00): Solved → Review in 1 day (tomorrow 02:00)
Problem 30 (03:00): Solved → Review in 1 day (tomorrow 03:00)

Result: All 30 problems "due" tomorrow
Not helpful for intensive study!
```

**Position-Based**:
```
Problem 1: Solved → Review after 10 problems
Problem 10: Solved → Review after 10 problems
Problem 11: Review Problem 1 (10 problems later)
Problem 20: Solved → Review after 10 problems
Problem 21: Review Problem 10 (10 problems later)
Problem 30: Solved → Review after 10 problems
Problem 31: Review Problem 20 (10 problems later)

Result: Natural spacing within and across sessions
Perfect for intensive study!
```

---

## Configuration

Default thresholds (tunable):

```typescript
const DEFAULT_THRESHOLDS = {
  concept: {
    low: 3,       // Review after 3-5 new problems
    medium: 8,    // Medium decay after 8-12 problems
    high: 15      // High decay after 15-20 problems (urgent)
  },
  family: {
    low: 5,       // Review family after 5-8 problems
    medium: 12,   // Medium decay after 12-18 problems
    high: 25      // High decay after 25-35 problems
  }
};

const REVIEW_INTERVALS = {
  again: { min: 1, max: 2 },     // 1-2 problems
  hard:  { min: 3, max: 5 },     // 3-5 problems
  good:  { min: 8, max: 12 },    // 8-12 problems
  easy:  { min: 15, max: 20 }    // 15-20 problems
};

const newProblemsBeforeReview = 5;  // Force review every 5 problems
```

---

## Benefits

1. **Works for any study pace** (1 problem/day or 100 problems/day)
2. **Natural spacing** within intensive sessions
3. **Prevents concept decay** through position-based tracking
4. **Maintains variety** with family rotation
5. **Adaptive to user performance** (harder problems → shorter intervals)
6. **Session-aware** (not dependent on time passage)

---

## Usage Example

```typescript
// Start practice mode
practiceMode.globalProblemCounter = 0;

// Solve problems
for (let i = 0; i < 50; i++) {
  const problem = selector.selectNextProblem(allProblems, practiceData, history);

  const result = await solveProblem(problem);
  const grade = selfGrade(result); // 'again' | 'hard' | 'good' | 'easy'

  // Increment counter
  practiceMode.globalProblemCounter++;

  // Update review queue (position-based)
  updateReviewQueue(problem.id, grade);

  // Update decay counters
  updateDecayCounters(practiceData, practiceMode.globalProblemCounter);
}

// Review queue now has problems due at specific positions
// Example: Problem #1 due after 10 problems, Problem #5 due after 8 problems, etc.
```

---

## Conclusion

Position-based spaced repetition is **perfect for interview prep** because it:
- Works naturally with intensive study sessions
- Maintains spacing without relying on calendar time
- Tracks concept/family decay by problem count, not days
- Adapts to any study pace automatically

Instead of "review in 3 days," it's **"review after 10 problems"** - which makes sense for users grinding LeetCode!
