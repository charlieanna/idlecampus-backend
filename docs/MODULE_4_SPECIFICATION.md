# Module 4: Array + Hash Map Combinations - Complete Specification

**Version:** 1.0
**Status:** Final Design
**Last Updated:** 2025-11-10

---

## Table of Contents

1. [Overview](#overview)
2. [Module Structure](#module-structure)
3. [Learning Philosophy](#learning-philosophy)
4. [Complete Item Specifications](#complete-item-specifications)
5. [Adaptive Learning Flows](#adaptive-learning-flows)
6. [State Machine Implementation](#state-machine-implementation)
7. [Solution Analysis System](#solution-analysis-system)
8. [Data Models](#data-models)

---

## Overview

### Module Goals

- **Primary Objective:** Master combining array iteration with hash map techniques
- **Time Estimate:** 1-2 weeks (10-16 hours)
- **Prerequisites:** Module 1 (Array Iteration) AND Module 2 (Hash Map Fundamentals)
- **Total Problems:** 11 (1 warmup + 3 intro + 7 practice)

### Why This Module?

**Real interviews rarely test single patterns!**

Most medium/hard problems require **combining techniques**:
- Sliding Window alone: Track window boundaries
- Hash Map alone: Store and lookup data
- **Combined:** Track complex window state efficiently! 🔥

### Patterns Covered

1. **Sliding Window + Hash Set** - Uniqueness tracking in windows
2. **Sliding Window + Hash Map (Frequency)** - Character/element frequencies in windows
3. **Variable-Size Window Template** - Expand/shrink based on conditions
4. **Two Pointers + Hash Map** - Enhanced pair-finding patterns

### Learning Outcomes

After completing this module, students will be able to:
- ✅ Recognize when to combine sliding window with hash maps
- ✅ Implement variable-size sliding windows with complex conditions
- ✅ Track frequencies efficiently in moving windows
- ✅ Solve substring/subarray problems with constraints
- ✅ Optimize O(n³) or O(n²) solutions to O(n) using combined patterns
- ✅ Master the most common interview pattern combination

---

## Module Structure

### Item Breakdown

```
Module 2.5: Array + Hash Map Combinations (14 items)
├── Item 1: Foundation - Why Combine Patterns? (10 min)
│
├── Pattern 1: Sliding Window + Hash Set (45-60 min)
│   ├── Item 2: Introduction + Longest Substring Without Repeating
│   ├── Item 3a: Optimized First Try (O(n) with set)
│   ├── Item 3b: Brute Force Path (O(n²) or O(n³))
│   └── Item 3b-success: Optimized Successfully
│
├── Pattern 2: Sliding Window + Frequency Map (60-90 min)
│   ├── Item 4: Introduction to Frequency Tracking
│   ├── Item 5: Minimum Window Substring ⭐⭐⭐ (CRITICAL!)
│   ├── Item 6a: Optimized First Try
│   ├── Item 6b: Brute Force Path (O(n²×m) or worse)
│   └── Item 6b-success: Optimized Successfully
│
├── Pattern 3: Variable Window Template (30-45 min)
│   ├── Item 7: Template Introduction
│   ├── Item 8: Longest Substring with K Distinct
│   └── Master the expand/shrink pattern
│
└── Practice Set (3-4 hours)
    ├── Item 9: Practice Introduction
    ├── Item 10-14: 7 mixed problems
    └── Item 15: Module Completion Celebration
```

---

## Learning Philosophy

### The Power of Combination

**Students have learned:**
- **Module 1:** Sliding window for O(n) subarray traversal
- **Module 2:** Hash maps for O(1) lookups and counting

**Now they discover:**
> **Sliding Window + Hash Map = One of the MOST POWERFUL patterns in coding interviews!**

### Discovery Through Complexity Reduction

Following the proven approach:

1. **Student attempts problem** - Likely checks every substring (O(n²) or O(n³))
2. **System analyzes** - Detects nested loops or repeated work
3. **Guide to combination** - Show how hash map tracks window state
4. **Student optimizes** - Discovers the power of combining patterns
5. **Pattern mastery** - Understanding emerges from experience

### Key Insight: Dynamic Window State

**Without hash map in window:**
- Must recalculate window properties: O(k) per window
- Total: O(n×k) or worse

**With hash map tracking window:**
- Update window state in O(1)
- Total: O(n) - each element processed once!

---

## Complete Item Specifications

### ITEM 1: Foundation - Why Combine Patterns?

**Type:** 📖 Lesson Only
**ID:** `combination-intro`
**Time:** 10 minutes

```markdown
# Module 2.5: Combining Patterns

Welcome to one of the most powerful techniques in coding interviews!

---

## What You've Learned So Far

### Module 1: Array Iteration
✅ Sliding Window - Track subarrays efficiently
✅ Two Pointers - Find pairs in O(n)
✅ Array Partitioning - Rearrange in-place

### Module 2: Hash Maps
✅ O(1) lookups - Find elements instantly
✅ Frequency counting - Track occurrences
✅ Prefix sums - Subarray sum problems

---

## The Reality of Interviews

**Real problems rarely test ONE pattern!**

Most medium/hard problems require **combining** techniques.

### Example: Longest Substring Without Repeating Characters

**Can you use sliding window alone?**
```python
left = 0
max_len = 0

for right in range(len(s)):
    # How do you check if s[right] is duplicate in [left:right]?
    # Need to search [left:right] → O(n) per iteration
    # Total: O(n²) ❌
```

**Can you use hash map alone?**
```python
seen = set()
# How do you maintain a "window" of unique characters?
# Hash map alone doesn't track window boundaries
```

**Combining them:**
```python
seen = set()  # Hash map for O(1) lookup!
left = 0      # Sliding window boundaries!

for right in range(len(s)):
    while s[right] in seen:  # O(1) check!
        seen.remove(s[left])  # O(1) removal
        left += 1

    seen.add(s[right])
    max_len = max(max_len, right - left + 1)
# Total: O(n) ✓
```

**Magic! O(n²) → O(n) by combining patterns!**

---

## Why This Combination is Powerful

### Sliding Window Provides:
- Efficient subarray/substring traversal
- O(n) time guarantee (each element processed once)
- Window boundary management

### Hash Map Provides:
- O(1) lookup - "Is X in window?"
- O(1) insert/delete - Add/remove from window state
- Frequency tracking - "How many times does X appear?"

### Combined Power:
- Track complex window properties in O(1)
- No nested loops for validation
- Handle dynamic constraints efficiently

---

## Common Problem Types

This combination solves:

✅ **Substring problems with constraints:**
- Without repeating characters
- With exactly/at most K distinct characters
- Anagram/permutation matching
- Character frequency requirements

✅ **Subarray problems with conditions:**
- Sum/product constraints with state tracking
- K distinct elements
- Unique element requirements

✅ **Advanced window problems:**
- Minimum/maximum window size
- Multiple simultaneous constraints
- Dynamic validity checking

---

## What You'll Learn

In this module, you'll master:

1. **Sliding Window + Hash Set**
   - Track uniqueness in windows
   - O(n) time, O(k) space

2. **Sliding Window + Hash Map (Frequency)**
   - Track character/element counts
   - Most versatile pattern

3. **Variable-Size Window Template**
   - Expand and shrink based on conditions
   - Universal problem-solving template

4. **Advanced Applications**
   - Multiple constraints
   - Optimization problems

---

## Interview Importance

**This pattern combination appears in:**
- 25-30% of Google interviews
- 20-25% of Facebook interviews
- 30-35% of Amazon interviews
- Common in Microsoft, Apple, Uber

**Problems you'll be able to solve:**
- Longest Substring Without Repeating Characters (Easy/Medium)
- Minimum Window Substring (Hard) ⭐⭐⭐
- Find All Anagrams in String (Medium)
- Longest Substring with K Distinct (Medium)
- Permutation in String (Medium)
- Character Replacement (Medium)

---

## Ready?

Let's start with the simplest combination: Sliding Window + Hash Set!

[Continue to Pattern 1 →]
```

---

### PATTERN 1: SLIDING WINDOW + HASH SET

#### ITEM 2: Sliding Window + Hash Set Introduction

**Type:** 📖 Lesson + 💻 Problem (Side-by-side)
**ID:** `sliding-window-set-intro`
**Time:** 20-30 minutes

##### Left Side - Lesson

```markdown
# Pattern 1: Sliding Window + Hash Set

Track uniqueness in a moving window!

---

## The Problem

**Find the longest substring without repeating characters.**

```
s = "abcabcbb"

Answer: "abc" (length 3)
```

---

## The Challenge

How do you:
1. Track which characters are in current window?
2. Detect when a duplicate appears?
3. Shrink the window when needed?

**All efficiently?**

---

## First Instinct: Brute Force

Check every possible substring:

```python
for i in range(len(s)):           # Start
    for j in range(i, len(s)):    # End
        substring = s[i:j+1]
        if has_no_duplicates(substring):  # How?
            max_len = max(max_len, j - i + 1)
```

**Problems:**
- Nested loops: O(n²)
- Checking duplicates: O(n)
- **Total: O(n³)** 😱

---

## Your Task

Solve the problem on the right **your way**.

Think about:
- How can you avoid checking every substring?
- Can you maintain a "window" of unique characters?
- How do you detect duplicates quickly?

[Start Coding →]
```

##### Right Side - Problem

**Difficulty:** Medium
**Problem ID:** `longest-substring-no-repeat`

```markdown
# Longest Substring Without Repeating Characters

Given a string `s`, find the length of the **longest substring** without repeating characters.

---

## Examples

**Example 1:**
- Input: `s = "abcabcbb"`
- Output: `3`
- Explanation: The answer is "abc", with length 3

**Example 2:**
- Input: `s = "bbbbb"`
- Output: `1`
- Explanation: The answer is "b", with length 1

**Example 3:**
- Input: `s = "pwwkew"`
- Output: `3`
- Explanation: The answer is "wke", with length 3
  Notice "pwke" is a subsequence, not a substring

**Example 4:**
- Input: `s = ""`
- Output: `0`

---

## Constraints

- `0 <= s.length <= 50,000`
- `s` consists of English letters, digits, symbols and spaces

---

## Starter Code

```python
def lengthOfLongestSubstring(s: str) -> int:
    # Your code here
    pass
```
```

**Test Cases:**
```python
test_cases = [
    ("abcabcbb", 3),
    ("bbbbb", 1),
    ("pwwkew", 3),
    ("", 0),
    ("au", 2),
    ("dvdf", 3),
    ("abcdefg", 7),
]
```

##### Submission Handler

```typescript
onSubmit(code: string, testResults: TestResult[]) {
  const analysis = analyzeSolution(code, testResults, 'longest-substring-no-repeat');

  if (!analysis.allTestsPassed) {
    return routeToItem('sliding-window-set-incorrect');
  }

  // Optimal: Sliding window + hash set O(n)
  if (analysis.timeComplexity === 'O(n)' &&
      (analysis.features.usesSlidingWindow && analysis.features.usesSet)) {
    return routeToItem('sliding-window-set-optimized-first'); // Item 3a
  }

  // Brute force: Check all substrings O(n²) or O(n³)
  if (analysis.timeComplexity === 'O(n²)' ||
      analysis.timeComplexity === 'O(n³)' ||
      analysis.features.hasNestedLoops) {
    return routeToItem('sliding-window-set-brute-force'); // Item 3b
  }

  // Default
  return routeToItem('sliding-window-set-brute-force');
}
```

---

#### ITEM 3a: Optimized First Try

**Trigger:** User submits O(n) solution with sliding window + set
**ID:** `sliding-window-set-optimized-first`
**Type:** 📖 Explanation + Auto-advance

```markdown
# 🌟 Brilliant! You Combined Patterns Perfectly!

You used **Sliding Window + Hash Set** for O(n) solution!

---

## Your Approach

**Your code:**
```python
[INJECT: User's submitted code]
```

You combined two patterns:
- ✅ **Sliding window** for efficient traversal
- ✅ **Hash set** for O(1) duplicate detection
- ✅ O(n) time, O(k) space (k = alphabet size)

This is optimal!

---

## The Brute Force Alternative

Most people check every substring:

```python
def lengthOfLongestSubstring(s: str) -> int:
    max_len = 0

    for i in range(len(s)):           # O(n)
        for j in range(i, len(s)):    # O(n)
            substring = s[i:j+1]

            # Check for duplicates
            if len(substring) == len(set(substring)):  # O(n)
                max_len = max(max_len, j - i + 1)

    return max_len
```

**Time Complexity: O(n³)** 😱

---

## Comparison

Let's analyze with **n = 50,000**:

| Approach | Time | Operations | Runtime |
|----------|------|------------|---------|
| Brute Force | O(n³) | ~125 trillion | Days! ❌ |
| Your Solution | O(n) | ~50,000 | <0.1s ✅ |

**Your solution is millions of times faster!** 🚀

---

## Why Brute Force is Slow

**Three nested operations:**

```python
for i in range(n):                    # O(n)
    for j in range(i, n):             # O(n)
        substring = s[i:j+1]
        if no_duplicates(substring):  # O(n) - check each char
            ...

Total: O(n³)
```

For n=50,000:
- Substrings to check: ~1,250,000,000
- Characters to check per substring: ~25,000 average
- **Total: ~31 trillion operations** 😱

---

## Your Insight: Sliding Window + Hash Set

**The key optimizations:**

### 1. Sliding Window (Not nested loops)
```python
left = 0
for right in range(len(s)):  # Single pass!
    # Maintain window [left, right]
```
Each element processed at most twice (once added, once removed).
**Time: O(n)**

### 2. Hash Set (O(1) duplicate detection)
```python
seen = set()

if s[right] in seen:  # O(1) instead of O(n)!
    # Duplicate detected instantly
```
No need to scan the window!

### 3. Dynamic Window Adjustment
```python
while s[right] in seen:
    seen.remove(s[left])  # O(1)
    left += 1             # Shrink window
```
Window grows and shrinks efficiently.

---

## Visualization

**Input:** `s = "abcabcbb"`

**Step-by-step:**

```
Step 1: right=0, s[0]='a'
Window: [a]
seen = {'a'}
max_len = 1

Step 2: right=1, s[1]='b'
Window: [a,b]
seen = {'a','b'}
max_len = 2

Step 3: right=2, s[2]='c'
Window: [a,b,c]
seen = {'a','b','c'}
max_len = 3 ← Current max

Step 4: right=3, s[3]='a'
'a' in seen? YES! Duplicate!
Shrink: remove s[left]='a', left++
Window: [b,c]
seen = {'b','c'}
Now add 'a'
Window: [b,c,a]
seen = {'b','c','a'}
max_len = 3

Step 5: right=4, s[4]='b'
'b' in seen? YES! Duplicate!
Shrink: remove 'b', then 'c', left++, left++
Window: [a]
seen = {'a'}
Add 'b'
Window: [a,b]
seen = {'a','b'}
max_len = 3

...continuing...
```

**Final answer: 3** ✓

---

## Pattern: Sliding Window + Hash Set

**Core template:**
```python
def lengthOfLongestSubstring(s: str) -> int:
    seen = set()
    left = 0
    max_len = 0

    for right in range(len(s)):
        # Shrink window while invalid (duplicate exists)
        while s[right] in seen:
            seen.remove(s[left])
            left += 1

        # Window is valid now, expand
        seen.add(s[right])
        max_len = max(max_len, right - left + 1)

    return max_len
```

**Key components:**
1. **Hash set** - Track window contents
2. **Two pointers** - Window boundaries
3. **While loop** - Shrink until valid
4. **Update result** - After each valid window

---

## When to Use This Pattern

✅ **Substring/subarray with uniqueness constraint:**
- No repeating elements
- Distinct elements only
- Checking membership

✅ **Characteristics:**
- Need O(1) "is element in window?" check
- Binary state (present or not)
- Don't need counts

---

## Pattern Mastered: Sliding Window + Hash Set ✓

- **Attempts:** 1
- **Mastery Level:** Excellent
- **Key Learning:** Hash set enables O(1) duplicate detection in windows

**You just learned the foundation for more complex combinations!**

[Continue to Pattern 2: Sliding Window + Frequency Map →]
```

**Data to Save:**
```typescript
{
  patternId: 'sliding-window-set',
  status: 'mastered',
  attempts: 1,
  masteryLevel: 'excellent',
  path: 'optimized-first',
  timeSpent: calculateTime(),
  masteredAt: new Date(),
}
```

---

#### ITEM 3b: Brute Force Path

**Trigger:** User submits O(n²) or O(n³) solution
**ID:** `sliding-window-set-brute-force`
**Type:** 📖 Feedback Lesson + 💻 Same Problem

```markdown
# Your Solution Works! ✓

All test cases passed!

---

## What You Did

**Your code:**
```python
[INJECT: User's code]
```

You likely **checked every substring** with nested loops:

```python
for i in range(len(s)):           # Start position
    for j in range(i, len(s)):    # End position
        substring = s[i:j+1]
        if no_duplicates(substring):  # Check each substring
            max_len = max(max_len, len(substring))
```

**This works but is very slow!**

---

## Time Complexity Analysis

**Your approach: O(n²) or O(n³)**

Breaking it down:
- Outer loop: n iterations
- Inner loop: n iterations
- Checking duplicates: O(1) to O(n) depending on method

**Best case: O(n²)**
If you use set for checking: `len(substring) == len(set(substring))`

**Worst case: O(n³)**
If you manually check each character: nested comparison

---

## Real-World Impact

### Scenario 1: Small input
- n = 100
- Operations: ~1,000,000
- Runtime: ~10ms ⚠️

### Scenario 2: Medium input
- n = 1,000
- Operations: ~1,000,000,000
- Runtime: ~10 seconds ❌

### Scenario 3: Large input (real constraints!)
- n = 50,000
- Operations: ~125,000,000,000,000
- Runtime: **Days!** ❌❌❌

---

## The Problem: Redundant Work

You're creating and checking many overlapping substrings:

```
s = "abcabc"

Substrings checked:
"a", "ab", "abc", "abca", "abcab", "abcabc"
"b", "bc", "bca", "bcab", "bcabc"
"c", "ca", "cab", "cabc"
"a", "ab", "abc"
"b", "bc"
"c"

Total: n(n+1)/2 ≈ n²/2 substrings
Each check: O(1) to O(n)
```

**Massive redundancy!**

---

## The Key Insight: Maintain a Window

Instead of checking every substring from scratch:

**Question:** 🤔 What if you maintained ONE window and just adjusted it?

**Example:**
```
s = "abcabc"

Window: [a,b,c]     ← "abc" is valid
Add 'a': [a,b,c,a]  ← Duplicate!
Remove first 'a': [b,c,a]  ← Valid again!
Add 'b': [b,c,a,b]  ← Duplicate!
Remove first 'b': [c,a,b]  ← Valid again!
...
```

**Instead of O(n²) substrings, process each character ONCE!**

---

## The Challenge: Detecting Duplicates Quickly

**Brute force detection:**
```python
def has_duplicates(substring):
    for i in range(len(substring)):
        for j in range(i+1, len(substring)):
            if substring[i] == substring[j]:
                return True
    return False
# O(n²) per check!
```

**Question:** 🤔 How can you check if character exists in window in O(1)?

**Answer:** Hash set!

```python
seen = set()  # Characters in current window

if char in seen:  # O(1) lookup!
    # Duplicate!
else:
    seen.add(char)  # O(1) insert
```

---

## Your Challenge

Optimize to **O(n)** using sliding window + hash set.

### Requirements:
- ❌ No nested loops for checking substrings
- ✅ Maintain a single window [left, right]
- ✅ Use hash set to track characters in window
- ✅ Detect duplicates in O(1)
- ✅ Each character processed at most twice (added once, removed once)

---

## Progressive Hints

**[Hint 1]** Use two pointers (left, right) for window boundaries
**[Hint 2]** Use hash set to store characters in current window
**[Hint 3]** Here's the template...

[Submit Optimized Solution →]
```

**Progressive Hints:**

**Hint 1:**
```markdown
💡 **Hint 1:** Sliding window approach

Use two pointers to maintain a window:

```python
left = 0
max_len = 0

for right in range(len(s)):
    # Current window: [left, right]
    # Add s[right] to window
    # If duplicate, shrink from left
    # Update max_len
```

Each character added exactly once (by right pointer).
```

**Hint 2:**
```markdown
💡 **Hint 2:** Hash set for O(1) duplicate detection

```python
seen = set()  # Characters in current window
left = 0
max_len = 0

for right in range(len(s)):
    # Check if s[right] already in window
    if s[right] in seen:  # O(1) check!
        # Duplicate! Need to shrink window
        pass

    seen.add(s[right])
```

But how to shrink the window?
```

**Hint 3:**
```markdown
💡 **Hint 3:** Complete template

```python
def lengthOfLongestSubstring(s: str) -> int:
    seen = set()
    left = 0
    max_len = 0

    for right in range(len(s)):
        # Shrink window while duplicate exists
        while s[right] in seen:
            seen.remove(s[left])  # Remove from set
            left += 1             # Shrink window

        # Now window is valid (no duplicates)
        seen.add(s[right])
        max_len = max(max_len, right - left + 1)

    return max_len
```

**Key insight:** The `while` loop shrinks window until duplicate is removed.
Each element removed at most once, so still O(n) overall!
```

---

#### ITEM 3b-success: Optimized Successfully

**ID:** `sliding-window-set-optimized-success`

```markdown
# 🎉 Excellent! You Combined the Patterns!

Your new solution runs in **O(n)** time!

---

## Before and After

### Your First Solution: O(n²) or O(n³)

```python
[INJECT: Brute force code]
```

- Nested loops: Check all substrings ❌
- For n=50,000: Trillions of operations

### Your Optimized Solution: O(n)

```python
[INJECT: Optimized code]
```

- Single pass: Sliding window ✅
- For n=50,000: ~50,000 operations

**Millions of times faster!** 🚀

---

## What You Discovered

**Sliding Window + Hash Set!**

```python
seen = set()
left = 0
max_len = 0

for right in range(len(s)):
    # Shrink while duplicate
    while s[right] in seen:
        seen.remove(s[left])
        left += 1

    # Expand window
    seen.add(s[right])
    max_len = max(max_len, right - left + 1)
```

---

## Detailed Visualization

**Input:** `s = "pwwkew"`

**Step 1:** `right=0, s[0]='p'`
```
Window: [p]
seen = {'p'}
left=0, right=0
max_len = 1
```

**Step 2:** `right=1, s[1]='w'`
```
'w' in seen? No
Window: [p,w]
seen = {'p','w'}
max_len = 2
```

**Step 3:** `right=2, s[2]='w'`
```
'w' in seen? YES! Duplicate!

Shrink:
  Remove s[left]='p', left=1
  Window: [w]
  seen = {'w'}
  Still 'w' in seen? YES!

  Remove s[left]='w', left=2
  Window: []
  seen = {}
  'w' in seen? NO! Stop shrinking.

Now add s[right]='w'
Window: [w]
seen = {'w'}
max_len = 2 (unchanged)
```

**Step 4:** `right=3, s[3]='k'`
```
'k' in seen? No
Window: [w,k]
seen = {'w','k'}
max_len = 2
```

**Step 5:** `right=4, s[4]='e'`
```
'e' in seen? No
Window: [w,k,e]
seen = {'w','k','e'}
max_len = 3 ← New max!
```

**Step 6:** `right=5, s[5]='w'`
```
'w' in seen? YES! Duplicate!

Shrink:
  Remove 'w', left=3
  Window: [k,e]
  seen = {'k','e'}

Add 'w'
Window: [k,e,w]
seen = {'k','e','w'}
max_len = 3
```

**Answer: 3** ✓ (substring "wke" or "kew")

---

## Key Insight: The While Loop

```python
while s[right] in seen:
    seen.remove(s[left])
    left += 1
```

**Why while, not if?**

Because we might need to remove multiple characters!

**Example:** `s = "abba"`
```
Window: [a,b]
Add 'b': 'b' in seen? YES!
Remove 'a', left++: Window: [b], seen={'b'}
'b' still in seen? YES!
Remove 'b', left++: Window: [], seen={}
Now add 'b': Window: [b]
```

---

## Time Complexity Proof

**Claim:** O(n) time, even with while loop

**Proof:**
- `right` pointer: Moves from 0 to n-1 → n iterations
- `left` pointer: Only moves forward, from 0 to n-1 max
- Each element:
  - Added to set once (by right)
  - Removed from set once (by left)
- Each operation (add/remove/check) is O(1)

**Total: O(n)** ✓

---

## Pattern: Sliding Window + Hash Set

**When to use:**
✅ Substring/subarray problems
✅ Uniqueness constraint (no duplicates)
✅ Finding longest/shortest window
✅ Need O(1) membership checking

**Template:**
```python
def slidingWindowSet(arr):
    window_set = set()
    left = 0
    result = 0

    for right in range(len(arr)):
        # Shrink while condition violated
        while condition_violated(window_set, arr[right]):
            window_set.remove(arr[left])
            left += 1

        # Expand window
        window_set.add(arr[right])

        # Update result
        result = max(result, right - left + 1)

    return result
```

---

## Pattern Mastered: Sliding Window + Hash Set ✓

- **Attempts:** 2
- **Mastery Level:** Good
- **Key Learning:** Combining patterns optimizes O(n²) → O(n)

**You just learned the foundation for the next pattern!**

[Continue to Pattern 2: Sliding Window + Frequency Map →]
```

---

### PATTERN 2: SLIDING WINDOW + FREQUENCY MAP

#### ITEM 4: Frequency Map Introduction

**Type:** 📖 Lesson Only
**ID:** `sliding-window-frequency-intro`
**Time:** 10 minutes

```markdown
# Pattern 2: Sliding Window + Frequency Map

The most versatile combination!

---

## Leveling Up from Hash Set

**You learned:** Sliding Window + Hash Set
- Tracks presence/absence (binary: in or not in)
- Perfect for uniqueness constraints

**Now learn:** Sliding Window + Hash Map (Frequency)
- Tracks **counts** of each element
- Much more powerful!
- Solves more complex problems

---

## Why Frequency Tracking?

Many problems need more than "is X in window?":

### Example Problems:

**1. Minimum Window Substring** ⭐⭐⭐
```
s = "ADOBECODEBANC", t = "ABC"
Find smallest window in s containing all of t

Need to track:
- How many 'A's are in window?
- How many 'B's are in window?
- Do we have all required characters?
```

**2. Find All Anagrams**
```
s = "cbaebabacd", p = "abc"
Find all anagram substrings of p in s

Need to track:
- Character frequencies in window
- Compare with target frequencies
```

**3. Longest Substring with K Distinct**
```
s = "eceba", k = 2
Find longest substring with at most k distinct characters

Need to track:
- How many distinct characters in window?
- Frequency of each character (to remove when count=0)
```

---

## Hash Set vs Hash Map

| Feature | Hash Set | Hash Map (Frequency) |
|---------|----------|----------------------|
| Stores | Presence only | Counts |
| Check | `x in set` | `map[x]` |
| Update | `add(x)`, `remove(x)` | `map[x] += 1`, `map[x] -= 1` |
| Use case | Uniqueness | Frequency constraints |
| Example | No repeating chars | Anagram matching |

---

## The Pattern Structure

```python
def slidingWindowFrequency(s, target):
    # Frequency map for window
    window = {}

    # Track what we need (varies by problem)
    need = {}  # or other state

    left = 0
    result = ...

    for right in range(len(s)):
        # Expand: add s[right] to window
        char = s[right]
        window[char] = window.get(char, 0) + 1

        # Update state based on new character
        # ...

        # Shrink: while window invalid or optimal
        while condition:
            # Update result if needed

            # Remove s[left] from window
            char = s[left]
            window[char] -= 1
            if window[char] == 0:
                del window[char]  # Optional: clean up
            left += 1

    return result
```

---

## Key Operations

### Adding to window:
```python
window[char] = window.get(char, 0) + 1
```

### Removing from window:
```python
window[char] -= 1
if window[char] == 0:
    del window[char]  # Keep map clean
```

### Checking frequency:
```python
if window.get(char, 0) >= need.get(char, 0):
    # Have enough of this character
```

---

## What You'll Master

Next, you'll solve **Minimum Window Substring** - one of the most important interview problems!

This problem:
- Appears in 15-20% of top tech interviews
- Tests multiple skills simultaneously
- Has elegant O(n) solution with this pattern

**It's challenging, but you have all the tools!**

[Continue to Minimum Window Substring →]
```

---

#### ITEM 5: Minimum Window Substring Problem

**Type:** 📖 Lesson + 💻 Problem
**ID:** `minimum-window-substring-intro`
**Time:** 30-45 minutes
**Difficulty:** Hard (but achievable!)

##### Left Side - Lesson

```markdown
# Minimum Window Substring

**The most important sliding window + hash map problem!**

---

## The Problem

Given strings `s` and `t`, find the **minimum window** in `s` that contains all characters of `t`.

```
s = "ADOBECODEBANC"
t = "ABC"

Answer: "BANC"
```

**Why minimum?**
- "ADOBEC" contains all of "ABC" (A, B, C ✓)
- "BANC" also contains all, but is shorter!

---

## The Challenge

**What makes this hard:**

1. Window size is unknown (variable)
2. Must contain ALL characters of `t`
3. Characters can appear multiple times
4. Need to find MINIMUM window

**Example:**
```
s = "ADOBECODEBANC"
t = "ABC"

Windows containing ABC:
"ADOBEC"     ← 6 chars
"ODEBANC"    ← 7 chars
"ODECODEBA"  ← 10 chars
"BANC"       ← 4 chars ✓ MINIMUM!
```

---

## Your Task

This is a **HARD** problem, but you can solve it!

**Think about:**
- How do you know if window is valid (contains all of t)?
- How do you shrink the window while keeping it valid?
- How do you track character frequencies?

**Hint:** You'll need two hash maps!

[Start Coding →]
```

##### Right Side - Problem

**Difficulty:** Hard
**Problem ID:** `minimum-window-substring`

```markdown
# Minimum Window Substring

Given two strings `s` and `t` of lengths `m` and `n` respectively, return the **minimum window substring** of `s` such that every character in `t` (including duplicates) is included in the window. If there is no such substring, return the empty string `""`.

---

## Examples

**Example 1:**
- Input: `s = "ADOBECODEBANC", t = "ABC"`
- Output: `"BANC"`
- Explanation: The minimum window substring "BANC" includes 'A', 'B', and 'C' from string t.

**Example 2:**
- Input: `s = "a", t = "a"`
- Output: `"a"`
- Explanation: The entire string s is the minimum window.

**Example 3:**
- Input: `s = "a", t = "aa"`
- Output: `""`
- Explanation: Both 'a's from t must be included in the window.
  Since the largest window of s only has one 'a', return empty string.

---

## Constraints

- `m == s.length`
- `n == t.length`
- `1 <= m, n <= 100,000`
- `s` and `t` consist of uppercase and lowercase English letters

**Follow up:** Could you find an algorithm that runs in O(m + n) time?

---

## Starter Code

```python
def minWindow(s: str, t: str) -> str:
    # Your code here
    # This is a HARD problem!
    pass
```
```

**Test Cases:**
```python
test_cases = [
    ("ADOBECODEBANC", "ABC", "BANC"),
    ("a", "a", "a"),
    ("a", "aa", ""),
    ("ab", "b", "b"),
    ("abc", "cba", "abc"),
    ("cabwefgewcwaefgcf", "cae", "cwae"),
]
```

##### Submission Handler

```typescript
onSubmit(code: string, testResults: TestResult[]) {
  const analysis = analyzeSolution(code, testResults, 'minimum-window-substring');

  if (!analysis.allTestsPassed) {
    return routeToItem('minimum-window-incorrect');
  }

  // Optimal: Sliding window + two frequency maps O(n)
  if (analysis.timeComplexity === 'O(n)' &&
      analysis.features.usesSlidingWindow &&
      analysis.features.usesFrequencyMap) {
    return routeToItem('minimum-window-optimized-first'); // Item 6a
  }

  // Brute force: Check all substrings O(n²×m) or worse
  if (analysis.features.hasNestedLoops) {
    return routeToItem('minimum-window-brute-force'); // Item 6b
  }

  // Default
  return routeToItem('minimum-window-brute-force');
}
```

---

#### ITEM 6a: Optimized First Try

**ID:** `minimum-window-optimized-first`

```markdown
# 🌟 Amazing! You Solved a HARD Problem!

You used **Sliding Window + Frequency Maps** for O(m+n) solution!

---

## Your Approach

```python
[INJECT: User's code]
```

You mastered the most complex sliding window pattern:
- ✅ Two frequency maps (need and window)
- ✅ Track how many characters are "formed"
- ✅ Expand to make window valid
- ✅ Shrink to minimize while staying valid
- ✅ O(m+n) time, O(k) space

**This is a HARD problem - excellent work!** 🏆

---

## The Brute Force Alternative

Check every possible substring:

```python
def minWindow(s: str, t: str) -> str:
    min_len = float('inf')
    result = ""

    for i in range(len(s)):           # O(m)
        for j in range(i, len(s)):    # O(m)
            window = s[i:j+1]

            if contains_all(window, t):  # O(n)
                if len(window) < min_len:
                    min_len = len(window)
                    result = window

    return result
```

**Time: O(m² × n)** where m=len(s), n=len(t)

---

## Comparison

For s with 100,000 chars, t with 1,000 chars:

| Approach | Time | Operations | Runtime |
|----------|------|------------|---------|
| Brute Force | O(m²×n) | ~10 trillion | Hours ❌ |
| Your Solution | O(m+n) | ~101,000 | <0.1s ✅ |

**Your solution is 100 million times faster!** 🚀

---

## Why This Solution is Brilliant

### Problem Complexity

This problem combines:
1. Variable-size window
2. Multiple character requirements
3. Frequency tracking (not just presence)
4. Minimization objective
5. Edge cases (duplicates, missing chars)

**All solved elegantly with sliding window + frequency maps!**

---

## The Key Insights

### 1. Track What You Need
```python
need = {}
for char in t:
    need[char] = need.get(char, 0) + 1

# Example: t = "ABC"
# need = {'A': 1, 'B': 1, 'C': 1}

# Example: t = "AABC"
# need = {'A': 2, 'B': 1, 'C': 1}
```

### 2. Track What You Have
```python
window = {}  # Current window frequencies
formed = 0   # How many char requirements met
required = len(need)  # How many distinct chars needed
```

### 3. Expand Until Valid
```python
for right in range(len(s)):
    char = s[right]
    window[char] = window.get(char, 0) + 1

    # Did this satisfy a requirement?
    if char in need and window[char] == need[char]:
        formed += 1
```

### 4. Shrink While Valid
```python
while formed == required:  # Window is valid!
    # Update minimum
    if (right - left + 1) < min_len:
        min_len = right - left + 1
        result = s[left:right+1]

    # Try to shrink
    char = s[left]
    window[char] -= 1
    if char in need and window[char] < need[char]:
        formed -= 1  # Lost a requirement
    left += 1
```

---

## Detailed Visualization

**Input:** `s = "ADOBECODEBANC", t = "ABC"`

**Setup:**
```
need = {'A': 1, 'B': 1, 'C': 1}
required = 3
```

**Expanding phase:**
```
right=0, s[0]='A'
window={'A':1}, formed=1
Not valid yet (formed < required)

right=1, s[1]='D'
window={'A':1, 'D':1}, formed=1

right=2, s[2]='O'
window={'A':1, 'D':1, 'O':1}, formed=1

right=3, s[3]='B'
window={'A':1, 'D':1, 'O':1, 'B':1}, formed=2

right=4, s[4]='E'
window={'A':1, 'D':1, 'O':1, 'B':1, 'E':1}, formed=2

right=5, s[5]='C'
window={'A':1, 'D':1, 'O':1, 'B':1, 'E':1, 'C':1}, formed=3 ✓
NOW VALID! Window: "ADOBEC" (length 6)
```

**Shrinking phase:**
```
Try to shrink from left:
Remove 'A': formed becomes 2, INVALID
Can't shrink more

right=6, s[6]='O'
Window valid again? No

right=7, s[7]='D'
...continue expanding...

right=9, s[9]='B'
Add 'B': window={'A':2, ...}, formed=3 ✓
Now can shrink!
Remove 'A': window={'A':1, ...}, still valid
Remove 'D': window={'A':1, ...}, still valid
Remove 'O': window={'A':1, 'B':1, 'E':1, 'C':1}, still valid
Remove 'B': formed=2, INVALID, stop
Window: "ODEBANC" (length 7)

...continuing...

Eventually find "BANC" (length 4)
```

---

## Pattern: Sliding Window + Frequency Map

**Template:**
```python
def minWindow(s: str, t: str) -> str:
    if not t or not s:
        return ""

    # Count what we need
    need = {}
    for char in t:
        need[char] = need.get(char, 0) + 1

    required = len(need)
    formed = 0

    # Sliding window
    window = {}
    left = 0
    min_len = float('inf')
    result = ""

    for right in range(len(s)):
        # Expand
        char = s[right]
        window[char] = window.get(char, 0) + 1

        if char in need and window[char] == need[char]:
            formed += 1

        # Shrink
        while formed == required and left <= right:
            # Update result
            if right - left + 1 < min_len:
                min_len = right - left + 1
                result = s[left:right+1]

            # Remove from window
            char = s[left]
            window[char] -= 1
            if char in need and window[char] < need[char]:
                formed -= 1
            left += 1

    return result
```

---

## Why This Problem is Important

**Interview frequency:**
- Google: 15-20% of interviews
- Facebook: 10-15%
- Amazon: 15-20%
- Microsoft: 10-15%

**What it tests:**
- Hash map proficiency
- Sliding window mastery
- Complex state tracking
- Edge case handling
- Optimization skills

**Companies say:**
> "If a candidate can solve Minimum Window Substring optimally,
> they understand advanced algorithmic patterns."

---

## Pattern Mastered: Sliding Window + Frequency Map ✓

- **Attempts:** 1
- **Mastery Level:** Excellent
- **Difficulty:** HARD
- **Key Learning:** Frequency maps enable complex constraint tracking

**You just solved one of the most important interview problems!** 🏆

This skill will serve you in countless similar problems!

[Continue to Practice Set →]
```

---

#### ITEM 6b: Brute Force Path

**ID:** `minimum-window-brute-force`

```markdown
# Your Solution Works! ✓

All test cases passed!

---

## What You Did

```python
[INJECT: User's code]
```

You likely checked all possible substrings:

```python
for i in range(len(s)):           # Start
    for j in range(i, len(s)):    # End
        substring = s[i:j+1]
        if contains_all(substring, t):
            if len(substring) < min_len:
                min_window = substring
```

**This works but is very slow!**

---

## Time Complexity: O(m²×n)

Where m = len(s), n = len(t)

Breaking down:
- Outer loop: m iterations
- Inner loop: m iterations
- Checking if substring contains all of t: O(n)

**Total: m × m × n = O(m²×n)**

---

## Real-World Impact

### Scenario 1: Small input
- m = 100, n = 10
- Operations: ~100,000
- Runtime: ~1ms ✅

### Scenario 2: Medium input
- m = 1,000, n = 100
- Operations: ~100,000,000
- Runtime: ~10s ❌

### Scenario 3: Large input
- m = 100,000, n = 1,000
- Operations: ~10 trillion
- Runtime: **Hours!** ❌❌❌

---

## The Problem: Massive Redundancy

You're checking millions of substrings:

```
s = "ADOBECODEBANC"

Substrings checked:
"A", "AD", "ADO", "ADOB", ..., "ADOBECODEBANC"
"D", "DO", "DOB", ..., "DOBECODEBANC"
"O", "OB", "OBE", ..., "OBECODEBANC"
...

Total: m(m+1)/2 ≈ m²/2 substrings!
```

**Each check takes O(n) time!**

---

## The Key Insight: Maintain One Window

Instead of checking every substring:

**Current approach:**
```
Check [A]
Check [A,D]
Check [A,D,O]
Check [A,D,O,B]
...
```

**Better approach:**
```
Window starts: [A]
Expand: [A,D]
Expand: [A,D,O]
Expand: [A,D,O,B]
Expand: [A,D,O,B,E]
Expand: [A,D,O,B,E,C] ← Valid!
Now shrink:
  [D,O,B,E,C] ← Still valid?
  [O,B,E,C] ← Still valid?
  ...
```

**Process each character once!**

---

## The Challenge: Tracking Requirements

**Question 1:** How do you know if window contains all of t?

**Brute force answer:**
```python
def contains_all(window, t):
    for char in t:
        if char not in window:
            return False
        # Also need to check counts!
    return True
# O(n) per check
```

**Better answer:** Track frequencies!
```python
need = {'A': 1, 'B': 1, 'C': 1}  # From t
window = {'A': 2, 'B': 1, 'C': 1, 'D': 1}  # Current window

# Check if window has enough of each
for char in need:
    if window.get(char, 0) < need[char]:
        return False
return True
# Still O(n), but done while expanding, not separately!
```

---

## Your Challenge

Optimize to **O(m+n)** using sliding window + frequency maps.

### Requirements:
- ❌ No nested loops checking substrings
- ✅ Maintain one window [left, right]
- ✅ Use hash map to track what you need (from t)
- ✅ Use hash map to track what you have (in window)
- ✅ Expand when window invalid, shrink when valid

---

## Progressive Hints

**[Hint 1]** Count character frequencies needed from t
**[Hint 2]** Track "formed" count - how many requirements met
**[Hint 3]** Here's the complete template...

[Submit Optimized Solution →]
```

**Progressive Hints:**

**Hint 1:**
```markdown
💡 **Hint 1:** Count what you need

```python
# First, count characters in t
need = {}
for char in t:
    need[char] = need.get(char, 0) + 1

# Example: t = "ABC"
# need = {'A': 1, 'B': 1, 'C': 1}

# Example: t = "AABC"
# need = {'A': 2, 'B': 1, 'C': 1}

# Now track how many distinct chars need to satisfy
required = len(need)  # 3 for "ABC"
```
```

**Hint 2:**
```markdown
💡 **Hint 2:** Track progress toward requirement

```python
need = {'A': 1, 'B': 1, 'C': 1}
window = {}
formed = 0  # How many char requirements are met
required = 3

for right in range(len(s)):
    char = s[right]
    window[char] = window.get(char, 0) + 1

    # Did this satisfy a requirement?
    if char in need and window[char] == need[char]:
        formed += 1

    # Is window valid?
    if formed == required:
        # All requirements met!
        # Try to shrink window now
```
```

**Hint 3:**
```markdown
💡 **Hint 3:** Complete solution

```python
def minWindow(s: str, t: str) -> str:
    if not t or not s:
        return ""

    # Count what we need
    need = {}
    for char in t:
        need[char] = need.get(char, 0) + 1

    required = len(need)
    formed = 0

    # Sliding window
    window = {}
    left = 0
    min_len = float('inf')
    result = ""

    for right in range(len(s)):
        # Expand: add character
        char = s[right]
        window[char] = window.get(char, 0) + 1

        if char in need and window[char] == need[char]:
            formed += 1

        # Shrink: while window valid
        while formed == required:
            # Update minimum
            if right - left + 1 < min_len:
                min_len = right - left + 1
                result = s[left:right+1]

            # Try to shrink
            char = s[left]
            window[char] -= 1
            if char in need and window[char] < need[char]:
                formed -= 1
            left += 1

    return result
```

**Key points:**
- `formed` tracks how many character requirements are fully met
- Expand until `formed == required`
- Shrink while maintaining `formed == required`
- Update minimum in shrinking phase
```

---

#### ITEM 6b-success: Optimized Successfully

**ID:** `minimum-window-optimized-success`

```markdown
# 🎉 Brilliant! You Solved a HARD Problem!

Your new solution runs in **O(m+n)** time!

---

## Before and After

### Your First Solution: O(m²×n)

```python
[INJECT: Brute force code]
```

- Nested loops checking substrings ❌
- For m=100K, n=1K: Trillions of operations

### Your Optimized Solution: O(m+n)

```python
[INJECT: Optimized code]
```

- Single pass with intelligent shrinking ✅
- For m=100K, n=1K: ~101K operations

**100 million times faster!** 🚀

---

## What You Mastered

**Sliding Window + Frequency Map** for complex constraints!

```python
# Track requirements
need = {}
for char in t:
    need[char] = need.get(char, 0) + 1

# Track window state
window = {}
formed = 0
required = len(need)

# Sliding window
for right in range(len(s)):
    # Expand
    char = s[right]
    window[char] = window.get(char, 0) + 1
    if char in need and window[char] == need[char]:
        formed += 1

    # Shrink while valid
    while formed == required:
        # Update result
        # Remove from left
```

---

## Why This Solution is Beautiful

### 1. Clever State Tracking

**Instead of:** Checking all characters every time
**You do:** Track integer `formed` (0 to required)

```python
formed = 0  # None satisfied

# After adding 'A': window['A'] reaches need['A']
formed = 1  # One requirement satisfied

# After adding 'B': window['B'] reaches need['B']
formed = 2  # Two requirements satisfied

# After adding 'C': window['C'] reaches need['C']
formed = 3  # All requirements satisfied! ✓
```

**Checking validity: O(1) instead of O(n)!**

### 2. Two-Phase Approach

**Expanding phase:**
```
Add characters until window valid (formed == required)
```

**Shrinking phase:**
```
Remove characters while keeping window valid
Update minimum in this phase!
```

**Why shrink?** To find the MINIMUM window!

### 3. Amortized O(n) Time

```
Each character:
- Added once (by right pointer)
- Removed once (by left pointer)
- Processed at most twice!

Total: O(m) for s + O(n) for t = O(m+n)
```

---

## Complete Walkthrough

**Input:** `s = "ADOBECODEBANC", t = "ABC"`

**Setup:**
```python
need = {'A': 1, 'B': 1, 'C': 1}
window = {}
required = 3
formed = 0
min_len = inf
left = 0
```

**Expanding:**
```
right=0, char='A'
window={'A':1}, formed=1 (A satisfied)

right=1, char='D'
window={'A':1, 'D':1}, formed=1

right=2, char='O'
window={'A':1, 'D':1, 'O':1}, formed=1

right=3, char='B'
window={'A':1, 'D':1, 'O':1, 'B':1}, formed=2 (B satisfied)

right=4, char='E'
window={...,'E':1}, formed=2

right=5, char='C'
window={...,'C':1}, formed=3 (C satisfied!) ✓

NOW formed == required! Start shrinking!
```

**Shrinking (at right=5):**
```
Current window: "ADOBEC" (length 6)
min_len = 6, result = "ADOBEC"

Try remove left=0, char='A'
window['A'] becomes 0, formed becomes 2
Stop shrinking (no longer valid)
```

**Continue expanding:**
```
right=6..8: Add 'O','D','E'
formed still 2 (missing A)

right=9, char='B'
window={'A':1, 'B':2, ...}, formed still 2

right=10, char='A'
window={'A':2, 'B':2, ...}, formed=3 ✓
Valid again!
```

**Shrinking (at right=10):**
```
Current: "ODECODEBA" (11 chars from left=1)
Can we shrink?

Remove left=1, char='D': still valid
Remove left=2, char='O': still valid
Remove left=3, char='B': window['B']=1, still valid
Remove left=4, char='E': still valid
Remove left=5, char='C': formed=2, stop

Best window so far: "CODEBA" (length 6)
Not better than "ADOBEC"
```

**Continue...**
```
right=11, char='N'
right=12, char='C'
window={...,'C':1}, formed=3 ✓

Shrinking:
Current: "CODEBANC" (from left=5)
Remove 'C': formed=2, stop

...more shrinking...

Eventually find: "BANC" (length 4) ✓
```

**Answer: "BANC"** ✓

---

## Pattern Mastered: Sliding Window + Frequency Map ✓

- **Attempts:** 2
- **Mastery Level:** Good
- **Difficulty:** HARD
- **Key Learning:** Intelligent state tracking enables O(n) solutions

**You just solved one of THE most important interview problems!** 🏆

This pattern appears in:
- Minimum Window Substring (this one)
- Find All Anagrams in String
- Permutation in String
- Longest Substring with K Distinct
- And many more!

---

[Continue to Practice Set →]
```

---

### PATTERN 3: VARIABLE WINDOW TEMPLATE

#### ITEM 7: Universal Template Introduction

**Type:** 📖 Lesson + 💻 Problem
**ID:** `variable-window-template`
**Time:** 20-30 minutes

```markdown
# Pattern 3: The Universal Variable Window Template

Master the template that solves dozens of problems!

---

## What You've Learned

**So far:**
1. Sliding Window + Hash Set
2. Sliding Window + Frequency Map

**Now:** The universal template that unifies them all!

---

## The Universal Pattern

```python
def slidingWindowTemplate(s, target):
    # 1. Initialize window state
    window = {}  # or set, or dict, or multiple variables
    left = 0
    result = ...  # What you're optimizing

    # 2. Expand window
    for right in range(len(s)):
        # Add s[right] to window
        # Update window state

        # 3. Shrink window (while condition met)
        while window_condition_violated():
            # Update result if needed
            # Remove s[left] from window
            # Update window state
            left += 1

        # 4. Update result (optional, depends on problem)
        result = update(result, window)

    return result
```

---

## Key Decisions for Each Problem

### 1. What to track in window?
- **Uniqueness:** Set
- **Frequencies:** Hash map (dict)
- **Count:** Integer
- **Multiple constraints:** Multiple structures

### 2. When to shrink?
- **Fixed size:** When `right - left + 1 > k`
- **Constraint violated:** When condition no longer met
- **Looking for minimum:** As soon as valid
- **Looking for maximum:** Never shrink (just track max)

### 3. When to update result?
- **In shrinking loop:** For minimum problems
- **After shrinking:** For maximum problems
- **Both:** For counting problems

---

## Example Problem: Longest Substring with K Distinct

**Problem:** Find longest substring with at most k distinct characters.

```
s = "eceba", k = 2
Answer: 3 (substring "ece")
```

**Apply template:**

```python
def lengthOfLongestSubstringKDistinct(s: str, k: int) -> int:
    # 1. Initialize
    window = {}  # char -> count
    left = 0
    max_len = 0

    # 2. Expand
    for right in range(len(s)):
        char = s[right]
        window[char] = window.get(char, 0) + 1

        # 3. Shrink while violated (>k distinct)
        while len(window) > k:
            left_char = s[left]
            window[left_char] -= 1
            if window[left_char] == 0:
                del window[left_char]
            left += 1

        # 4. Update result
        max_len = max(max_len, right - left + 1)

    return max_len
```

**See how it fits the template?**

---

## Your Task

Solve the problem on the right using this template!

[Start Coding →]
```

**Right Side - Problem:**

```markdown
# Longest Substring with At Most K Distinct Characters

Given a string `s` and an integer `k`, return the length of the longest substring of `s` that contains at most `k` distinct characters.

---

## Examples

**Example 1:**
- Input: `s = "eceba", k = 2`
- Output: `3`
- Explanation: The substring is "ece" with length 3

**Example 2:**
- Input: `s = "aa", k = 1`
- Output: `2`
- Explanation: The substring is "aa" with length 2

---

## Constraints

- `1 <= s.length <= 50,000`
- `0 <= k <= 50`

---

## Starter Code

```python
def lengthOfLongestSubstringKDistinct(s: str, k: int) -> int:
    # Use the template!
    pass
```
```

---

### PRACTICE SET

#### ITEM 9: Practice Introduction

**ID:** `combination-practice-intro`

```markdown
# 💪 Practice Set: Combining Patterns

Time to apply everything you've learned!

---

## What You've Mastered

✅ **Sliding Window + Hash Set** - Uniqueness tracking
✅ **Sliding Window + Frequency Map** - Complex constraints
✅ **Variable Window Template** - Universal approach

---

## The Challenge

You'll solve **7 mixed problems** covering all patterns.

**Important:** We won't tell you which pattern to use!

---

## Problem Types

- 🔵 Medium problems (5)
- 🟡 Hard problems (2)

All require combining array and hash map techniques!

---

## Tips

1. **Identify the constraint:**
   - Uniqueness → Hash set
   - Frequencies → Hash map
   - Fixed size → Simple sliding window

2. **Apply the template:**
   - Initialize window state
   - Expand and update
   - Shrink when needed
   - Update result

3. **Think O(n):**
   - If you're writing nested loops, reconsider!
   - Each element should be processed at most twice

---

[Start Problem 1 →]
```

---

#### ITEMS 10-14: Practice Problems

**Problem 1:** Find All Anagrams in String (Medium)
- Pattern: Sliding Window + Frequency Map
- Fixed size window = length of pattern

**Problem 2:** Permutation in String (Medium)
- Pattern: Sliding Window + Frequency Map
- Similar to anagrams

**Problem 3:** Fruit Into Baskets (Medium)
- Pattern: Sliding Window + Hash Map
- Longest subarray with at most 2 distinct elements
- Same as K Distinct with k=2

**Problem 4:** Max Consecutive Ones III (Medium)
- Pattern: Sliding Window + Counter
- At most K zeros can be flipped

**Problem 5:** Longest Repeating Character Replacement (Medium)
- Pattern: Sliding Window + Frequency Map
- At most K characters can be changed

**Problem 6:** Substring with Concatenation of All Words (Hard)
- Pattern: Sliding Window + Hash Map
- Very challenging!

**Problem 7:** Subarrays with K Different Integers (Hard)
- Pattern: Sliding Window (two passes)
- Advanced technique

---

#### ITEM 15: Module Completion

**ID:** `combination-complete`

```markdown
# 🎉 Module 4 Complete! 🎉

**Array + Hash Map Combinations**

---

## Your Achievement

✅ **14/14 items completed**

---

## Patterns Mastered

### 1. Sliding Window + Hash Set
- Uniqueness tracking in windows
- O(n) time, O(k) space
- **Problems solved:** [COUNT]

### 2. Sliding Window + Frequency Map
- Complex constraint tracking
- Most versatile pattern
- **Problems solved:** [COUNT]

### 3. Variable Window Template
- Universal problem-solving approach
- Expand and shrink strategically
- **Problems solved:** [COUNT]

---

## Your Stats

📊 **Total Problems:** 11
⏱️ **Time Spent:** [X hours]
🎯 **Mastery Level:** [Excellent/Good/Completed]
💡 **Hints Used:** [COUNT]

---

## Key Learnings

### The Power of Combination

**Single patterns:**
- Sliding Window: O(n) traversal
- Hash Map: O(1) operations

**Combined:**
- O(n) solutions to problems that seem O(n²) or O(n³)!
- Track complex state efficiently
- Handle dynamic constraints

### Problems You Can Now Solve

You mastered patterns that appear in:
- ✅ Longest Substring Without Repeating
- ✅ Minimum Window Substring ⭐⭐⭐
- ✅ Find All Anagrams
- ✅ Permutation in String
- ✅ K Distinct Characters
- ✅ And dozens more!

---

## Interview Impact

**These patterns appear in:**
- 30-40% of top tech company interviews
- Especially common at Google, Facebook, Amazon
- Core to understanding "hard" problems

**What hiring managers say:**
> "Candidates who understand variable-size
> sliding windows with state tracking
> demonstrate advanced algorithmic thinking."

---

## What's Next

**Module 3: Linked List Mastery**

Learn pointer manipulation and node-based patterns!

**Topics:**
- Python class basics
- Dummy node technique
- Two pointers in linked lists
- Reversal patterns
- Advanced modifications

---

## Achievement Unlocked

🏆 **"Pattern Combinator"**

You can now:
- Recognize when to combine techniques
- Optimize O(n²) or O(n³) to O(n)
- Track complex state efficiently
- Solve hard interview problems

**You're now in the top tier of problem solvers!** 🚀

---

[Continue to Module 3 →]
[Review Module 2.5]
[Back to Course]
```

---

## Summary

This specification provides:

✅ Complete content for all 14 items (later expanded to 15)
✅ Adaptive branching for patterns
✅ Universal sliding window template
✅ 7 practice problems
✅ Covers THE most important interview pattern combination
✅ Includes Minimum Window Substring (critical problem!)

**Implementation Estimate:** 3-4 weeks for full module

**Special Note:** This module teaches the pattern combination that appears most frequently in medium/hard interview problems. Mastery of this module significantly increases interview success rates!

---

**End of Module 2.5 Specification**
