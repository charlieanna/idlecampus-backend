# Module 9: Dynamic Programming Foundations

## Overview
This module teaches dynamic programming (DP) through adaptive learning. Students learn to recognize DP patterns, master 1D and 2D DP, understand memoization vs tabulation, and solve classic DP problems that appear frequently in interviews.

**Total Items**: 18
**Estimated Time**: 5-6 hours
**Prerequisites**: Module 1 (Arrays), Module 2 (Hash Maps), Module 4 (Trees - for recursion understanding)

---

## Learning Philosophy

Following the IdleCampus adaptive learning approach:
1. **Present Problem First**: User encounters the problem before seeing DP
2. **Detect Approach**: Analyze if user writes brute force recursion, memoization, or tabulation
3. **Adaptive Branching**: Different learning paths based on user's solution
4. **Guide, Don't Give Away**: Help user discover overlapping subproblems
5. **Brute Force → Optimization**: From recursion to memoization to tabulation

---

## Module Structure

### Part 1: DP Fundamentals & 1D DP (Items 1-9)
- What is Dynamic Programming?
- Recognizing overlapping subproblems
- Memoization (top-down)
- Tabulation (bottom-up)
- Classic 1D DP: Fibonacci, Climbing Stairs, House Robber

### Part 2: 2D DP (Items 10-15)
- Grid path problems
- Longest Common Subsequence (LCS)
- Edit Distance
- Matrix DP patterns

### Part 3: DP Optimization & Combinations (Items 16-18)
- Space optimization
- DP + Hash Map
- Partition problems

---

## Detailed Item Specifications

### **ITEM 1: Introduction to Dynamic Programming**
**Type**: Lesson Only
**Duration**: 5 minutes

**Content**:
```
# Dynamic Programming: Optimize by Remembering

Dynamic Programming (DP) is an optimization technique that solves problems by breaking them into overlapping subproblems.

## Key Concept:
**Don't recompute the same thing twice - remember and reuse!**

## When to Use DP:

1. **Optimal substructure**: Optimal solution contains optimal solutions to subproblems
2. **Overlapping subproblems**: Same subproblems computed multiple times

## Classic Example: Fibonacci

**Naive Recursion** (exponential time):
```typescript
function fib(n: number): number {
  if (n <= 1) return n;
  return fib(n - 1) + fib(n - 2);
}

// fib(5) calls:
//   fib(4) + fib(3)
//     fib(3) + fib(2)  +  fib(2) + fib(1)
//       ...
// fib(3) computed twice!
// fib(2) computed three times!
```

Time: O(2ⁿ) - exponential!

**With Memoization** (linear time):
```typescript
function fib(n: number, memo: Map<number, number> = new Map()): number {
  if (n <= 1) return n;
  if (memo.has(n)) return memo.get(n)!;  // Reuse!

  let result = fib(n - 1, memo) + fib(n - 2, memo);
  memo.set(n, result);
  return result;
}
```

Time: O(n) - each fib(i) computed once!

## Two Approaches:

1. **Memoization (Top-Down)**: Recursion + cache
2. **Tabulation (Bottom-Up)**: Iterative, build table from base cases

## Why DP Matters:
20-25% of FAANG interviews involve DP problems!

Let's learn to recognize and solve DP problems.
```

**Next**: Item 2

---

### **ITEM 2: First DP Problem - Climbing Stairs**
**Type**: Lesson + Problem
**Duration**: 12-15 minutes

**Left Panel (Lesson)**:
```
# Your First DP Problem

**Problem**: You're climbing stairs. You can take 1 or 2 steps. How many distinct ways to reach the top?

```
Input: n = 3
Output: 3
Explanation:
  1. 1 + 1 + 1
  2. 1 + 2
  3. 2 + 1
```

## Think About:
- How would you compute this recursively?
- Are there repeated computations?
- Can you reuse previous results?

## Hint:
To reach step `n`, you could have come from step `n-1` (1 step) or `n-2` (2 steps).

Try solving this problem on the right →
```

**Right Panel (Problem)**: `dp-1` (Climbing Stairs)

**Solution Analysis**:

```typescript
// OPTIMAL: Tabulation O(n) time, O(1) space
function climbStairs(n: number): number {
  if (n <= 2) return n;

  let prev2 = 1;  // ways to reach step 1
  let prev1 = 2;  // ways to reach step 2

  for (let i = 3; i <= n; i++) {
    let current = prev1 + prev2;
    prev2 = prev1;
    prev1 = current;
  }

  return prev1;
}

// GOOD: Tabulation O(n) time, O(n) space
function climbStairs(n: number): number {
  if (n <= 2) return n;

  let dp = new Array(n + 1);
  dp[1] = 1;
  dp[2] = 2;

  for (let i = 3; i <= n; i++) {
    dp[i] = dp[i - 1] + dp[i - 2];
  }

  return dp[n];
}

// ACCEPTABLE: Memoization O(n) time, O(n) space
function climbStairs(n: number): number {
  let memo = new Map<number, number>();

  function climb(n: number): number {
    if (n <= 2) return n;
    if (memo.has(n)) return memo.get(n)!;

    let result = climb(n - 1) + climb(n - 2);
    memo.set(n, result);
    return result;
  }

  return climb(n);
}

// SUBOPTIMAL: Plain recursion O(2ⁿ)
function climbStairs(n: number): number {
  if (n <= 2) return n;
  return climbStairs(n - 1) + climbStairs(n - 2);
}
```

**State Machine Routing**:

```typescript
if (solution.isTabulation() && solution.isSpaceOptimized()) {
  return "item-3-dp-patterns";
} else if (solution.isTabulation()) {
  return "item-3-dp-patterns";
} else if (solution.isMemoization()) {
  return "item-2a-tabulation-approach";
} else if (solution.isPlainRecursion()) {
  return "item-2b-add-memoization";
} else {
  return "item-2c-dp-hint";
}
```

---

### **ITEM 2A: From Memoization to Tabulation**
**Type**: Lesson Only
**Duration**: 4 minutes
**Condition**: User wrote memoization

**Content**:
```
# From Top-Down to Bottom-Up

Your memoization solution works great:

```typescript
function climbStairs(n: number): number {
  let memo = new Map<number, number>();

  function climb(n: number): number {
    if (n <= 2) return n;
    if (memo.has(n)) return memo.get(n)!;

    let result = climb(n - 1) + climb(n - 2);
    memo.set(n, result);
    return result;
  }

  return climb(n);
}
```

✅ Time: O(n)
✅ Space: O(n)

## Alternative: Tabulation (Bottom-Up)

Instead of recursion + cache, build the table iteratively:

```typescript
function climbStairs(n: number): number {
  if (n <= 2) return n;

  let dp = [0, 1, 2];  // dp[i] = ways to reach step i

  for (let i = 3; i <= n; i++) {
    dp[i] = dp[i - 1] + dp[i - 2];
  }

  return dp[n];
}
```

## Benefits of Tabulation:
- No recursion overhead
- Often easier to optimize space
- Clearer iteration order

## Space Optimization:
We only need the last two values!

```typescript
function climbStairs(n: number): number {
  if (n <= 2) return n;

  let prev2 = 1, prev1 = 2;

  for (let i = 3; i <= n; i++) {
    let current = prev1 + prev2;
    prev2 = prev1;
    prev1 = current;
  }

  return prev1;
}
```

Space: O(n) → O(1) 🎯

Both approaches (memoization and tabulation) are valid!
```

**Next**: Item 3

---

### **ITEM 2B: Add Memoization**
**Type**: Lesson Only
**Duration**: 3 minutes
**Condition**: User wrote plain recursion

**Content**:
```
# From Exponential to Linear

Your recursive solution is correct but inefficient:

```typescript
function climbStairs(n: number): number {
  if (n <= 2) return n;
  return climbStairs(n - 1) + climbStairs(n - 2);
}
```

Time: O(2ⁿ) - exponential!

## The Problem:
You're recomputing the same values many times.

```
climbStairs(5)
  = climbStairs(4) + climbStairs(3)
      = [climbStairs(3) + climbStairs(2)] + [climbStairs(2) + climbStairs(1)]
                                              ↑ computed twice!
```

## The Fix: Memoization

Cache results to avoid recomputation:

```typescript
function climbStairs(n: number): number {
  let memo = new Map<number, number>();

  function climb(n: number): number {
    if (n <= 2) return n;
    if (memo.has(n)) return memo.get(n)!;  // Return cached result

    let result = climb(n - 1) + climb(n - 2);
    memo.set(n, result);  // Cache before returning
    return result;
  }

  return climb(n);
}
```

Time: O(2ⁿ) → O(n) 🎯

Each `climb(i)` is computed at most once!

Try adding memoization to your solution →
```

**Next**: Item 2 (resubmit)

---

### **ITEM 2C: DP Hint**
**Type**: Lesson Only
**Duration**: 3 minutes

**Content**:
```
# Hint: Break Down the Problem

To reach step `n`, where could you have come from?

→ Step `n-1` (then take 1 step)
→ Step `n-2` (then take 2 steps)

## Recurrence Relation:
```
ways(n) = ways(n-1) + ways(n-2)
```

## Base Cases:
```
ways(1) = 1  (only one way: one step)
ways(2) = 2  (two ways: 1+1 or 2)
```

## Implementation:

```typescript
function climbStairs(n: number): number {
  if (n <= 2) return n;

  // Either use recursion + memoization:
  let memo = new Map();
  function climb(n) {
    if (n <= 2) return n;
    if (memo.has(n)) return memo.get(n);
    let result = climb(n - 1) + climb(n - 2);
    memo.set(n, result);
    return result;
  }
  return climb(n);

  // OR use bottom-up tabulation:
  let dp = [0, 1, 2];
  for (let i = 3; i <= n; i++) {
    dp[i] = dp[i - 1] + dp[i - 2];
  }
  return dp[n];
}
```

Try implementing one of these approaches →
```

**Next**: Item 2 (resubmit)

---

### **ITEM 3: DP Pattern Recognition**
**Type**: Lesson Only
**Duration**: 4 minutes

**Content**:
```
# Recognizing DP Problems

How do you know a problem needs DP?

## Three Key Signs:

**1. Asks for optimum value** (minimum, maximum, longest, etc.)
   - "What's the minimum cost?"
   - "What's the longest subsequence?"

**2. Asks for number of ways**
   - "How many ways to...?"
   - "Count the number of..."

**3. Can be broken into similar subproblems**
   - Decision at each step
   - Subproblems overlap

## Classic DP Problem Types:

1. **0/1 Knapsack**: Include or exclude each item
2. **Unbounded Knapsack**: Unlimited copies of items
3. **Fibonacci-like**: Combine previous states
4. **Grid DP**: Path from top-left to bottom-right
5. **String DP**: Longest common subsequence, edit distance
6. **Partition DP**: Break string/array into parts

## The DP Recipe:

1. **Define state**: What does dp[i] represent?
2. **Find recurrence**: How does dp[i] relate to previous states?
3. **Base cases**: What are the simplest cases?
4. **Order of computation**: What order to fill the table?
5. **Optimize space**: Can we use less memory?

Let's practice recognizing and solving DP problems!
```

**Next**: Item 4

---

### **ITEM 4: House Robber**
**Type**: Lesson + Problem
**Duration**: 12-15 minutes

**Left Panel (Lesson)**:
```
# 1D DP: House Robber

**Problem**: Rob houses for maximum money. Can't rob two adjacent houses (alarm!).

```
Input: [2, 7, 9, 3, 1]
Output: 12
Explanation: Rob house 0 (2) + house 2 (9) + house 4 (1) = 12
```

## DP State Definition:
`dp[i]` = maximum money you can rob from houses 0 to i

## Recurrence Relation:
At each house, you have two choices:
1. **Rob it**: `nums[i] + dp[i-2]` (skip previous house)
2. **Don't rob it**: `dp[i-1]` (take previous max)

```
dp[i] = max(nums[i] + dp[i-2], dp[i-1])
```

## Base Cases:
```
dp[0] = nums[0]
dp[1] = max(nums[0], nums[1])
```

Try solving this problem on the right →
```

**Right Panel (Problem)**: `dp-2` (House Robber)

**Solution Analysis**:

```typescript
// OPTIMAL: Tabulation with space optimization O(n) time, O(1) space
function rob(nums: number[]): number {
  if (nums.length === 1) return nums[0];

  let prev2 = nums[0];
  let prev1 = Math.max(nums[0], nums[1]);

  for (let i = 2; i < nums.length; i++) {
    let current = Math.max(nums[i] + prev2, prev1);
    prev2 = prev1;
    prev1 = current;
  }

  return prev1;
}

// GOOD: Tabulation O(n) time, O(n) space
function rob(nums: number[]): number {
  if (nums.length === 1) return nums[0];

  let dp = new Array(nums.length);
  dp[0] = nums[0];
  dp[1] = Math.max(nums[0], nums[1]);

  for (let i = 2; i < nums.length; i++) {
    dp[i] = Math.max(nums[i] + dp[i - 2], dp[i - 1]);
  }

  return dp[nums.length - 1];
}
```

**Next**: Item 5

---

### **ITEM 5: House Robber II (Circular)**
**Type**: Problem Only
**Duration**: 12-15 minutes

**Left Panel (Problem Context)**:
```
# Practice: Circular Constraint

**Problem**: Houses are in a circle (first and last are adjacent). Can't rob both!

```
Input: [2, 3, 2]
Output: 3
Explanation: Can't rob house 0 and 2 (adjacent in circle), so rob house 1
```

## Hint:
Break into two subproblems:
1. Rob houses 0 to n-2 (exclude last house)
2. Rob houses 1 to n-1 (exclude first house)

Return the maximum of both!

```typescript
function rob(nums: number[]): number {
  if (nums.length === 1) return nums[0];

  function robLinear(start: number, end: number): number {
    // House Robber I logic from previous problem
  }

  return Math.max(
    robLinear(0, nums.length - 2),
    robLinear(1, nums.length - 1)
  );
}
```
```

**Right Panel (Problem)**: `dp-3` (House Robber II)

**Next**: Item 6

---

### **ITEM 6: Coin Change**
**Type**: Lesson + Problem
**Duration**: 15-18 minutes

**Left Panel (Lesson)**:
```
# Unbounded Knapsack: Coin Change

**Problem**: Minimum number of coins to make amount. Unlimited coins of each denomination.

```
Input: coins = [1, 2, 5], amount = 11
Output: 3
Explanation: 11 = 5 + 5 + 1
```

## DP State:
`dp[i]` = minimum coins needed to make amount i

## Recurrence:
For each amount `i`, try using each coin:

```
dp[i] = min(dp[i - coin] + 1) for all coins where coin <= i
```

## Implementation:

```typescript
function coinChange(coins: number[], amount: number): number {
  let dp = new Array(amount + 1).fill(Infinity);
  dp[0] = 0;  // Base case: 0 coins for amount 0

  for (let i = 1; i <= amount; i++) {
    for (let coin of coins) {
      if (coin <= i) {
        dp[i] = Math.min(dp[i], dp[i - coin] + 1);
      }
    }
  }

  return dp[amount] === Infinity ? -1 : dp[amount];
}
```

Time: O(amount * coins.length)
Space: O(amount)

Try solving this problem on the right →
```

**Right Panel (Problem)**: `dp-4` (Coin Change)

**Next**: Item 7

---

### **ITEM 7: Longest Increasing Subsequence**
**Type**: Lesson + Problem
**Duration**: 15-20 minutes

**Left Panel (Lesson)**:
```
# Classic DP: Longest Increasing Subsequence (LIS)

**Problem**: Find length of longest strictly increasing subsequence.

```
Input: [10, 9, 2, 5, 3, 7, 101, 18]
Output: 4
Explanation: [2, 3, 7, 101] or [2, 3, 7, 18]
```

## DP State:
`dp[i]` = length of LIS ending at index i

## Recurrence:
For each position `i`, look at all previous positions `j < i`:
- If `nums[j] < nums[i]`, we can extend LIS ending at j

```
dp[i] = max(dp[j] + 1) for all j < i where nums[j] < nums[i]
```

## Implementation:

```typescript
function lengthOfLIS(nums: number[]): number {
  let dp = new Array(nums.length).fill(1);  // Each element is LIS of length 1

  for (let i = 1; i < nums.length; i++) {
    for (let j = 0; j < i; j++) {
      if (nums[j] < nums[i]) {
        dp[i] = Math.max(dp[i], dp[j] + 1);
      }
    }
  }

  return Math.max(...dp);
}
```

Time: O(n²)
Space: O(n)

**Note**: There's an O(n log n) solution using binary search, but the DP approach is more intuitive!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `dp-5` (Longest Increasing Subsequence)

**Next**: Item 8

---

### **ITEM 8: Word Break**
**Type**: Lesson + Problem
**Duration**: 15-18 minutes

**Left Panel (Lesson)**:
```
# DP with String Partitioning

**Problem**: Can you segment string into words from dictionary?

```
Input: s = "leetcode", wordDict = ["leet", "code"]
Output: true
Explanation: "leetcode" = "leet" + "code"

Input: s = "applepenapple", wordDict = ["apple", "pen"]
Output: true
Explanation: "applepenapple" = "apple" + "pen" + "apple"
```

## DP State:
`dp[i]` = true if s[0...i-1] can be segmented

## Recurrence:
For each position `i`, try all possible last words:
- Check if s[j...i-1] is in dictionary
- If yes and dp[j] is true, then dp[i] is true

```
dp[i] = true if there exists j where:
  - dp[j] is true
  - s[j...i-1] is in wordDict
```

## Implementation:

```typescript
function wordBreak(s: string, wordDict: string[]): boolean {
  let wordSet = new Set(wordDict);
  let dp = new Array(s.length + 1).fill(false);
  dp[0] = true;  // Empty string

  for (let i = 1; i <= s.length; i++) {
    for (let j = 0; j < i; j++) {
      if (dp[j] && wordSet.has(s.slice(j, i))) {
        dp[i] = true;
        break;
      }
    }
  }

  return dp[s.length];
}
```

Time: O(n² * m) where m = average word length
Space: O(n)

This combines **DP** + **Hash Set**!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `dp-6` (Word Break)

**Next**: Item 9

---

### **ITEM 9: Decode Ways**
**Type**: Problem Only
**Duration**: 12-15 minutes

**Left Panel (Problem Context)**:
```
# Practice: 1D DP with Constraints

**Problem**: Count ways to decode a digit string. 'A' = 1, 'B' = 2, ..., 'Z' = 26.

```
Input: "12"
Output: 2
Explanation: "12" = "AB" (1,2) or "L" (12)

Input: "226"
Output: 3
Explanation: "BZ" (2,26), "VF" (22,6), or "BBF" (2,2,6)
```

## Hint:
`dp[i]` = number of ways to decode s[0...i-1]

At each position, you can:
1. Decode single digit (if valid: 1-9)
2. Decode two digits (if valid: 10-26)

```
dp[i] = 0
if s[i-1] is valid single digit: dp[i] += dp[i-1]
if s[i-2:i] is valid two digits: dp[i] += dp[i-2]
```

Watch out for '0' - it can only be part of "10" or "20"!
```

**Right Panel (Problem)**: `dp-7` (Decode Ways)

**Next**: Item 10

---

### **ITEM 10: Introduction to 2D DP**
**Type**: Lesson Only
**Duration**: 4 minutes

**Content**:
```
# 2D Dynamic Programming

Welcome to Part 2! Now we tackle problems with **two dimensions**.

## When to Use 2D DP:

- **Two sequences** (LCS, edit distance)
- **Grid problems** (paths, minimum sum)
- **Two choice dimensions** (knapsack, partition)

## 2D DP Pattern:

```typescript
let dp = Array(rows).fill(0).map(() => Array(cols).fill(0));

// Fill base cases (first row, first column)
for (let i = 0; i < rows; i++) dp[i][0] = baseValue;
for (let j = 0; j < cols; j++) dp[0][j] = baseValue;

// Fill rest of table
for (let i = 1; i < rows; i++) {
  for (let j = 1; j < cols; j++) {
    dp[i][j] = someFunction(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]);
  }
}

return dp[rows-1][cols-1];
```

## Typical Recurrence Patterns:

**Grid path**: `dp[i][j] = dp[i-1][j] + dp[i][j-1]`
**Minimum path**: `dp[i][j] = min(dp[i-1][j], dp[i][j-1]) + grid[i][j]`
**LCS**: `dp[i][j] = dp[i-1][j-1] + 1` (if match) else `max(dp[i-1][j], dp[i][j-1])`

Let's practice!
```

**Next**: Item 11

---

### **ITEM 11: Unique Paths**
**Type**: Lesson + Problem
**Duration**: 12-15 minutes

**Left Panel (Lesson)**:
```
# 2D DP: Grid Paths

**Problem**: Count unique paths from top-left to bottom-right. Can only move right or down.

```
3x7 grid:
Start → → → → → → ↓
    ↓ ↓ ↓ ↓ ↓ ↓ ↓
    → → → → → → End

Output: 28 unique paths
```

## DP State:
`dp[i][j]` = number of paths to reach cell (i, j)

## Recurrence:
Can only reach (i,j) from (i-1,j) or (i,j-1):

```
dp[i][j] = dp[i-1][j] + dp[i][j-1]
```

## Base Cases:
```
dp[0][j] = 1  (only one way: all right)
dp[i][0] = 1  (only one way: all down)
```

## Implementation:

```typescript
function uniquePaths(m: number, n: number): number {
  let dp = Array(m).fill(0).map(() => Array(n).fill(0));

  // Base cases
  for (let i = 0; i < m; i++) dp[i][0] = 1;
  for (let j = 0; j < n; j++) dp[0][j] = 1;

  // Fill table
  for (let i = 1; i < m; i++) {
    for (let j = 1; j < n; j++) {
      dp[i][j] = dp[i-1][j] + dp[i][j-1];
    }
  }

  return dp[m-1][n-1];
}
```

Time: O(m * n)
Space: O(m * n) - can optimize to O(n)!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `dp-8` (Unique Paths)

**Next**: Item 12

---

### **ITEM 12: Minimum Path Sum**
**Type**: Problem Only
**Duration**: 12-15 minutes

**Left Panel (Problem Context)**:
```
# Practice: Grid DP with Values

**Problem**: Find path from top-left to bottom-right with minimum sum. Move only right or down.

```
Input:
[
  [1, 3, 1],
  [1, 5, 1],
  [4, 2, 1]
]

Output: 7
Explanation: 1 → 3 → 1 → 1 → 1
```

## Hint:
`dp[i][j]` = minimum path sum to reach (i, j)

```
dp[i][j] = grid[i][j] + min(dp[i-1][j], dp[i][j-1])
```

Similar to Unique Paths, but instead of adding counts, we're finding minimum!
```

**Right Panel (Problem)**: `dp-9` (Minimum Path Sum)

**Next**: Item 13

---

### **ITEM 13: Longest Common Subsequence (LCS)**
**Type**: Lesson + Problem
**Duration**: 15-20 minutes

**Left Panel (Lesson)**:
```
# Classic 2D DP: Longest Common Subsequence

**Problem**: Find length of longest subsequence common to both strings.

```
Input: text1 = "abcde", text2 = "ace"
Output: 3
Explanation: "ace" is the longest common subsequence
```

## DP State:
`dp[i][j]` = LCS length for text1[0...i-1] and text2[0...j-1]

## Recurrence:

**If characters match**: `text1[i-1] === text2[j-1]`
```
dp[i][j] = dp[i-1][j-1] + 1
```

**If characters don't match**:
```
dp[i][j] = max(dp[i-1][j], dp[i][j-1])
```

## Implementation:

```typescript
function longestCommonSubsequence(text1: string, text2: string): number {
  let m = text1.length, n = text2.length;
  let dp = Array(m + 1).fill(0).map(() => Array(n + 1).fill(0));

  for (let i = 1; i <= m; i++) {
    for (let j = 1; j <= n; j++) {
      if (text1[i-1] === text2[j-1]) {
        dp[i][j] = dp[i-1][j-1] + 1;
      } else {
        dp[i][j] = Math.max(dp[i-1][j], dp[i][j-1]);
      }
    }
  }

  return dp[m][n];
}
```

Time: O(m * n)
Space: O(m * n)

This is one of the most important DP patterns!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `dp-10` (Longest Common Subsequence)

**Next**: Item 14

---

### **ITEM 14: Edit Distance**
**Type**: Lesson + Problem
**Duration**: 18-20 minutes

**Left Panel (Lesson)**:
```
# Advanced 2D DP: Edit Distance (Levenshtein Distance)

**Problem**: Minimum operations to convert word1 to word2. Operations: insert, delete, replace.

```
Input: word1 = "horse", word2 = "ros"
Output: 3
Explanation:
horse → rorse (replace 'h' with 'r')
rorse → rose (remove 'r')
rose → ros (remove 'e')
```

## DP State:
`dp[i][j]` = min edits to convert word1[0...i-1] to word2[0...j-1]

## Recurrence:

**If characters match**: `word1[i-1] === word2[j-1]`
```
dp[i][j] = dp[i-1][j-1]  (no operation needed)
```

**If characters don't match**, try all three operations:
```
dp[i][j] = 1 + min(
  dp[i-1][j],    // Delete from word1
  dp[i][j-1],    // Insert into word1
  dp[i-1][j-1]   // Replace
)
```

## Base Cases:
```
dp[i][0] = i  (delete all i characters)
dp[0][j] = j  (insert all j characters)
```

## Implementation:

```typescript
function minDistance(word1: string, word2: string): number {
  let m = word1.length, n = word2.length;
  let dp = Array(m + 1).fill(0).map(() => Array(n + 1).fill(0));

  // Base cases
  for (let i = 0; i <= m; i++) dp[i][0] = i;
  for (let j = 0; j <= n; j++) dp[0][j] = j;

  for (let i = 1; i <= m; i++) {
    for (let j = 1; j <= n; j++) {
      if (word1[i-1] === word2[j-1]) {
        dp[i][j] = dp[i-1][j-1];
      } else {
        dp[i][j] = 1 + Math.min(
          dp[i-1][j],    // Delete
          dp[i][j-1],    // Insert
          dp[i-1][j-1]   // Replace
        );
      }
    }
  }

  return dp[m][n];
}
```

This is a **HARD** problem frequently asked in FAANG interviews!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `dp-11` (Edit Distance)

**Next**: Item 15

---

### **ITEM 15: Maximal Square**
**Type**: Problem Only
**Duration**: 15-18 minutes

**Left Panel (Problem Context)**:
```
# Practice: 2D DP on Matrix

**Problem**: Find largest square of 1s in binary matrix.

```
Input:
[
  ['1','0','1','0','0'],
  ['1','0','1','1','1'],
  ['1','1','1','1','1'],
  ['1','0','0','1','0']
]

Output: 4  (2x2 square)
```

## Hint:
`dp[i][j]` = side length of largest square with bottom-right corner at (i,j)

If matrix[i][j] === '1':
```
dp[i][j] = min(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]) + 1
```

Why? A square at (i,j) is limited by the smallest square from three neighbors!
```

**Right Panel (Problem)**: `dp-12` (Maximal Square)

**Next**: Item 16

---

### **ITEM 16: Partition Equal Subset Sum**
**Type**: Lesson + Problem
**Duration**: 15-20 minutes

**Left Panel (Lesson)**:
```
# 0/1 Knapsack: Partition Problem

**Problem**: Can you partition array into two subsets with equal sum?

```
Input: [1, 5, 11, 5]
Output: true
Explanation: [1, 5, 5] and [11] both sum to 11
```

## Key Insight:
If total sum is odd, impossible!
If total sum is even, find if there's a subset with sum = total / 2.

This becomes: **Can we make target sum with given numbers?**

## DP State:
`dp[i][j]` = can we make sum j using first i numbers?

## Recurrence:

For each number nums[i-1], we can:
1. **Include it**: `dp[i-1][j - nums[i-1]]` (if j >= nums[i-1])
2. **Exclude it**: `dp[i-1][j]`

```
dp[i][j] = dp[i-1][j] || dp[i-1][j - nums[i-1]]
```

## Implementation:

```typescript
function canPartition(nums: number[]): boolean {
  let total = nums.reduce((a, b) => a + b, 0);
  if (total % 2 !== 0) return false;

  let target = total / 2;
  let dp = Array(nums.length + 1).fill(false).map(() =>
    Array(target + 1).fill(false)
  );

  // Base case: sum 0 is always possible
  for (let i = 0; i <= nums.length; i++) {
    dp[i][0] = true;
  }

  for (let i = 1; i <= nums.length; i++) {
    for (let j = 1; j <= target; j++) {
      dp[i][j] = dp[i-1][j];  // Exclude
      if (j >= nums[i-1]) {
        dp[i][j] = dp[i][j] || dp[i-1][j - nums[i-1]];  // Include
      }
    }
  }

  return dp[nums.length][target];
}
```

Time: O(n * sum)
Space: O(n * sum) - can optimize to O(sum)!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `dp-13` (Partition Equal Subset Sum)

**Next**: Item 17

---

### **ITEM 17: Target Sum**
**Type**: Lesson + Problem
**Duration**: 15-18 minutes

**Left Panel (Lesson)**:
```
# DP + Hash Map: Target Sum

**Problem**: Assign + or - to each number to reach target. Count ways.

```
Input: nums = [1, 1, 1, 1, 1], target = 3
Output: 5
Explanation:
-1 + 1 + 1 + 1 + 1 = 3
+1 - 1 + 1 + 1 + 1 = 3
+1 + 1 - 1 + 1 + 1 = 3
+1 + 1 + 1 - 1 + 1 = 3
+1 + 1 + 1 + 1 - 1 = 3
```

## Approach 1: DFS with Memoization

```typescript
function findTargetSumWays(nums: number[], target: number): number {
  let memo = new Map<string, number>();

  function dfs(index: number, currentSum: number): number {
    if (index === nums.length) {
      return currentSum === target ? 1 : 0;
    }

    let key = `${index},${currentSum}`;
    if (memo.has(key)) return memo.get(key)!;

    let add = dfs(index + 1, currentSum + nums[index]);
    let subtract = dfs(index + 1, currentSum - nums[index]);

    let result = add + subtract;
    memo.set(key, result);
    return result;
  }

  return dfs(0, 0);
}
```

## Approach 2: Convert to Subset Sum (Advanced)

This can be converted to: "Find subsets with sum = (target + total) / 2"

Try solving this problem on the right →
```

**Right Panel (Problem)**: `dp-14` (Target Sum)

**Next**: Item 18

---

### **ITEM 18: Maximum Product Subarray**
**Type**: Problem Only
**Duration**: 15-18 minutes

**Left Panel (Problem Context)**:
```
# Practice: DP with Positive/Negative Tracking

**Problem**: Find contiguous subarray with largest product.

```
Input: [2, 3, -2, 4]
Output: 6
Explanation: [2, 3] has product 6

Input: [-2, 0, -1]
Output: 0
```

## Hint:
Track both **maximum** and **minimum** products ending at each position!

Why minimum? Negative * negative = positive!

```
maxProduct[i] = max(
  nums[i],
  maxProduct[i-1] * nums[i],
  minProduct[i-1] * nums[i]  // If nums[i] is negative!
)

minProduct[i] = min(
  nums[i],
  maxProduct[i-1] * nums[i],
  minProduct[i-1] * nums[i]
)
```

This is a clever DP variation!
```

**Right Panel (Problem)**: `dp-15` (Maximum Product Subarray)

**Next**: Module complete!

---

## Module Completion

After Item 18, show:

```
# 🎉 Module 9 Complete!

You've mastered:
✅ DP fundamentals (memoization vs tabulation)
✅ 1D DP (Fibonacci, House Robber, Coin Change, LIS)
✅ 2D DP (Grid paths, LCS, Edit Distance)
✅ 0/1 Knapsack pattern
✅ DP + Hash Map combinations
✅ Space optimization techniques

## Key Patterns Learned:

1. **Fibonacci-like**: Combine previous states
2. **Knapsack**: Include/exclude decisions
3. **Grid DP**: Path finding, minimum/maximum paths
4. **String DP**: LCS, edit distance, word break
5. **Partition DP**: Subset sum, equal partition

## DP Recipe:
1. Define state (what does dp[i] mean?)
2. Find recurrence relation
3. Identify base cases
4. Determine computation order
5. Optimize space if possible

## Time Complexities:
- 1D DP: Usually O(n)
- 2D DP: Usually O(m * n)
- DP with hash map: O(n) with O(n) space for memoization

## Problems Solved: 15

Next: **Module 10: Heaps & Priority Queues** →
```

---

## Problems Required

This module requires these problems in `/lib/content/problems/dynamicProgramming.ts`:

1. `dp-1`: Climbing Stairs (EASY)
2. `dp-2`: House Robber (MEDIUM) ⭐⭐⭐ CRITICAL
3. `dp-3`: House Robber II (MEDIUM)
4. `dp-4`: Coin Change (MEDIUM) ⭐⭐⭐ CRITICAL
5. `dp-5`: Longest Increasing Subsequence (MEDIUM) ⭐⭐⭐ CRITICAL
6. `dp-6`: Word Break (MEDIUM) ⭐⭐⭐ CRITICAL
7. `dp-7`: Decode Ways (MEDIUM)
8. `dp-8`: Unique Paths (MEDIUM)
9. `dp-9`: Minimum Path Sum (MEDIUM)
10. `dp-10`: Longest Common Subsequence (MEDIUM) ⭐⭐⭐ CRITICAL
11. `dp-11`: Edit Distance (HARD) ⭐⭐⭐ CRITICAL
12. `dp-12`: Maximal Square (MEDIUM)
13. `dp-13`: Partition Equal Subset Sum (MEDIUM) ⭐⭐⭐ CRITICAL
14. `dp-14`: Target Sum (MEDIUM)
15. `dp-15`: Maximum Product Subarray (MEDIUM) ⭐⭐⭐ CRITICAL

---

This specification covers the foundational DP patterns seen in 20-25% of FAANG interviews.
