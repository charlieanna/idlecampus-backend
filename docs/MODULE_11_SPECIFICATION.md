# Module 11: Backtracking & Recursion Trees

## Overview
This module teaches the critical skill of **drawing recursion trees before coding**, then using those trees to master backtracking algorithms and recognize when memoization helps. Students learn to visualize recursive problems, identify repeated subproblems, and decide between pure backtracking and memoization.

**Total Items**: 18
**Estimated Time**: 5-6 hours
**Prerequisites**: Module 1 (Arrays), Module 4 (Trees - for recursion), Module 6 (Graphs - for DFS)

---

## Core Philosophy: Tree → Code

**🎯 The Most Important Lesson**: Always draw the recursion tree BEFORE writing code.

The tree tells you:
1. **What choices** you have at each step (branches)
2. **When to stop** (base cases at leaves)
3. **If nodes repeat** (same subproblem → use memoization!)
4. **The code structure** (tree traversal pattern)

Without the tree, you're coding blind. With the tree, the solution becomes clear.

---

## Learning Philosophy

Following the IdleCampus adaptive learning approach with tree-first methodology:
1. **Draw Tree First**: Before any code, visualize the recursion tree
2. **Analyze the Tree**: Identify decision points, base cases, repeated nodes
3. **Tree → Template**: Let the tree structure guide your code
4. **Detect Patterns**: Pure backtracking vs. backtracking + memoization
5. **Adaptive Branching**: Different learning paths based on tree understanding

---

## Module Structure

### Part 0: The Power of Drawing Trees FIRST (Items 1-3) ⭐ NEW
- Why tree visualization is critical
- How to draw recursion trees
- Reading trees to find repeated work
- When memoization helps

### Part 1: Tree-Driven Backtracking (Items 4-9)
- Subsets: draw tree → code
- Combinations and permutations: tree reveals structure
- Handling duplicates: visualize what gets skipped

### Part 2: Trees + Memoization (Items 10-11) ⭐ NEW
- When trees show repeated nodes
- Climbing stairs: pure backtracking vs. memo
- Combination sum: identifying cacheable subproblems

### Part 3: Constraint Satisfaction (Items 12-15)
- N-Queens: tree helps visualize pruning
- Sudoku solver
- Word search
- Palindrome partitioning

### Part 4: Advanced Backtracking (Items 16-18)
- Letter combinations
- Generate parentheses
- Restore IP addresses

---

## Detailed Item Specifications

---

## PART 0: THE POWER OF DRAWING TREES FIRST

### **ITEM 1: Why Draw the Tree Before Coding?**
**Type**: Lesson Only
**Duration**: 8 minutes

**Content**:
```
# The #1 Skill: Visualize BEFORE You Code

## The Problem Most Engineers Face:

When solving recursive/backtracking problems, many developers:
❌ Jump straight to coding
❌ Get lost in the recursion
❌ Miss optimization opportunities
❌ Can't debug when things go wrong

## The Solution: Draw the Tree First! 🌳

Before writing a single line of code, **draw the recursion tree**.

## What is a Recursion Tree?

A visual representation where:
- **Root**: Initial problem/state
- **Branches**: Decisions/choices you can make
- **Nodes**: States at each recursive call
- **Leaves**: Base cases (where recursion stops)

## Example: Fibonacci

```
Problem: fib(4)

Tree:
                 fib(4)
              /          \
          fib(3)         fib(2)
         /      \       /      \
     fib(2)   fib(1) fib(1)  fib(0)
     /    \
  fib(1) fib(0)
```

## What the Tree Reveals:

1. **Repeated Nodes** 👀
   - See `fib(2)` twice, `fib(1)` three times!
   - This is REPEATED WORK
   - → **Use memoization!**

2. **Decision Structure**
   - Each node makes same type of decisions
   - → Reveals the recursive pattern

3. **Base Cases**
   - Leaves show where recursion stops
   - → `fib(0)` and `fib(1)`

4. **Time Complexity**
   - Count nodes → O(2^n) for fib without memo
   - With memo: O(n) (each fib(k) computed once)

## The Tree → Code Process:

### 1️⃣ Draw the tree for a small example
### 2️⃣ Look for patterns:
   - What decisions at each node?
   - What's the base case?
   - **Do any nodes repeat?** ⭐
### 3️⃣ Write code that follows the tree structure
### 4️⃣ If nodes repeat → add memoization

## Real Interview Scenario:

**Without tree**: "Um... I'll try recursion... let me think..."
→ 10 minutes of confused coding
→ Wrong solution

**With tree**: "Let me draw the recursion tree first..."
→ 2 minutes of drawing
→ "I see nodes repeat here, so I'll use a memo"
→ Correct solution in 5 minutes

## The Golden Rule:

**If you can't draw the tree, you can't write the code.**

**If you can draw the tree, the code writes itself.**

Let's learn how to draw these trees!
```

**Next**: Item 2

---

### **ITEM 2: How to Draw Recursion Trees**
**Type**: Interactive Lesson
**Duration**: 12 minutes

**Content**:
```
# Drawing Recursion Trees: Step-by-Step

## Problem: Climbing Stairs

You're climbing a staircase with `n` steps.
You can climb 1 or 2 steps at a time.
How many different ways can you reach the top?

Example: n = 3
Answer: 3 ways
- 1 + 1 + 1
- 1 + 2
- 2 + 1

## Step 1: Identify the Root

Root = initial problem = "climb 3 stairs"

```
        climb(3)
```

## Step 2: What Decisions Can You Make?

At each step, you can:
- Climb 1 stair → moves to climb(n-1)
- Climb 2 stairs → moves to climb(n-2)

```
           climb(3)
          /         \
     [take 1]    [take 2]
       /              \
   climb(2)        climb(1)
```

## Step 3: Continue Until Base Cases

Base cases: climb(0) = 1 way (you're there!), climb(1) = 1 way

```
              climb(3)
            /         \
        climb(2)      climb(1) ✓
       /        \
   climb(1) ✓  climb(0) ✓
   /      \
climb(0)✓ climb(-1)❌
```

## Step 4: Analyze the Tree! 👀

**Count the nodes:**
- `climb(2)` appears 1 time
- `climb(1)` appears 2 times ← **REPEATED!**
- `climb(0)` appears 2 times ← **REPEATED!**

**This tells us:**
1. Without memoization: recalculating same values
2. With memoization: each value computed once
3. Pattern: `climb(n) = climb(n-1) + climb(n-2)`

## Step 5: Tree → Code

**Pure Backtracking (slow):**
```typescript
function climbStairs(n: number): number {
  if (n <= 1) return 1;  // Base case (from tree)

  // Two branches from tree
  return climbStairs(n - 1) + climbStairs(n - 2);
}
```
Time: O(2^n) ← counted from tree nodes

**With Memoization (fast):**
```typescript
function climbStairs(n: number): number {
  let memo: number[] = [];

  function climb(n: number): number {
    if (n <= 1) return 1;

    if (memo[n] !== undefined) return memo[n];  // Skip repeated work!

    memo[n] = climb(n - 1) + climb(n - 2);
    return memo[n];
  }

  return climb(n);
}
```
Time: O(n) ← each node computed once

## The Tree Made This Obvious!

Drawing the tree took 2 minutes.
The tree showed us:
✅ The recursive structure
✅ The base cases
✅ **The repeated nodes → need memo**
✅ The time complexity

Without the tree, we might miss the repeated work!

## Your Turn: Draw These Trees 📝

Try drawing the recursion tree for:

1. **Fibonacci**: `fib(5)`
   - What repeats?

2. **Subsets**: `[1, 2, 3]`
   - What decisions at each node?
   - How many leaves?

Next, we'll see how trees help you decide: "pure backtracking or memoization?"
```

**Next**: Item 3

---

### **ITEM 3: Reading Trees: When to Use Memoization**
**Type**: Lesson + Exercise
**Duration**: 15 minutes

**Content**:
```
# Tree Detective: Finding Repeated Subproblems

## The Key Question:

After drawing your recursion tree, ask:
**"Do any nodes with the same state appear multiple times?"**

- **YES** → Use memoization! 🎯
- **NO** → Pure backtracking is fine ✓

## Example 1: Fibonacci (Needs Memo)

```
                 fib(4)
              /          \
          fib(3)         fib(2) ← appears twice!
         /      \       /      \
     fib(2) ← fib(1) fib(1)  fib(0)
     /    \
  fib(1) fib(0)
```

**Analysis:**
- `fib(2)` computed 2 times
- `fib(1)` computed 3 times
- `fib(0)` computed 2 times

**Verdict:** USE MEMOIZATION ✓
- Memo key: the number `n`
- `memo[n] = fib(n)`

## Example 2: Generate All Subsets (No Memo Needed)

```
Input: [1, 2, 3]

                    []
          /                  \
    [include 1]          [skip 1]
        [1]                  []
      /     \              /    \
    [1,2]   [1]          [2]    []
    /  \    / \          / \    / \
[1,2,3][1,2][1,3][1] [2,3][2][3][]
```

**Analysis:**
- Every node is UNIQUE!
- Path `[1,2]` is different from `[2]` or `[3]`
- No repeated subproblems

**Verdict:** Pure backtracking, NO memo needed ✓

## Example 3: Coin Change (Needs Memo!)

```
Problem: Make amount=4 with coins [1,2,3]

                  amount=4
           /        |         \
     [use 1]    [use 2]     [use 3]
        /           |            \
   amount=3     amount=2      amount=1
    /  |  \      /    \         /    \
 [1][2][3]   [1]  [2]       [1]  [skip]

Notice: amount=2 appears MULTIPLE times
        amount=1 appears MULTIPLE times
```

**Analysis:**
- `amount=3` might appear multiple times through different coin paths
- `amount=2` definitely repeats
- Same subproblem reached via different choices

**Verdict:** USE MEMOIZATION ✓
- Memo key: remaining amount
- `memo[amount] = minCoins(amount)`

## How to Identify Repeated Nodes:

### ✅ Nodes Repeat When:
1. **Same input state** can be reached via different decisions
2. The recursive calls depend only on **current state**, not the path taken
3. Examples: fib(n), climb stairs, coin change, edit distance

### ❌ Nodes Don't Repeat When:
1. Each node represents a **unique path** or **unique combination**
2. The state includes the entire path taken so far
3. Examples: generate subsets, permutations, N-Queens, path finding

## The Memo Decision Tree:

```
Start: Draw recursion tree
         |
         ↓
   Do nodes repeat?
     /          \
   YES          NO
    |            |
    ↓            ↓
Add memo    Pure backtracking

Memo makes:   No memo needed,
O(2^n) → O(n*k)  stay O(2^n)
```

## Practice: You Decide! 🎯

For each problem, draw a small tree and decide:

1. **Problem**: Generate all permutations of [1,2,3]
   - Draw tree for small case
   - Do nodes repeat?
   - **Answer**: NO - each path is unique → no memo

2. **Problem**: Longest Common Subsequence
   ```
   lcs("abc", "adc")
   ```
   - Draw tree (compare characters)
   - Do nodes repeat?
   - **Answer**: YES - same (i,j) positions reached multiple ways → use memo!

3. **Problem**: Combination Sum (unlimited use)
   ```
   coins = [2,3], target = 5
   ```
   - Draw tree
   - Do nodes repeat?
   - **Answer**: YES - same remaining target reached via different orders → use memo if we care about count, not combinations

## Key Insight:

**The tree doesn't lie.**

If you see the same node twice in your tree:
→ You're doing repeated work
→ Memoization will help
→ Transform backtracking into dynamic programming!

Now let's apply this tree-first approach to actual backtracking problems!
```

**Next**: Item 4 (Begin Part 1: Tree-Driven Backtracking)

---

## PART 1: TREE-DRIVEN BACKTRACKING

### **ITEM 4: Subsets - Tree First, Code Second**
**Type**: Lesson + Problem
**Duration**: 15-18 minutes

**Left Panel (Lesson)**:
```
# Applying Tree-First: Generate All Subsets

**Problem**: Generate all subsets of an array.

```
Input: [1, 2, 3]
Output: [[], [1], [2], [3], [1,2], [1,3], [2,3], [1,2,3]]
```

## STEP 1: Draw the Tree First! 🌳

Before any code, let's visualize:

```
                       []
                /              \
          [include 1]      [skip 1]
              [1]              []
            /     \          /     \
        [inc 2] [skip 2] [inc 2] [skip 2]
          [1,2]    [1]      [2]      []
         /    \   /  \     /   \    /  \
       [1,2,3][1,2][1,3][1] [2,3][2][3][]
                  ↑
                  All 8 subsets at leaves!
```

## STEP 2: Analyze the Tree

**What do we see?**
1. **Decision at each node**: Include current element OR skip it
2. **Two branches** from each node
3. **Base case**: When we've considered all elements (leaves)
4. **Total leaves**: 2³ = 8 subsets
5. **Do nodes repeat?** NO! Each path is unique

**Conclusion**: Pure backtracking, no memoization needed ✓

## STEP 3: Tree → Code Pattern

The tree reveals the structure:

```
Root: empty set []
At each element:
  - Branch 1: Include it
  - Branch 2: Skip it
Leaves: Complete subsets
```

## Alternative Tree View (Include Only):

Some prefer this visualization:

```
                    []
            /       |        \
         [1]       [2]       [3]
        /   \        \
     [1,2] [1,3]    [2,3]
      /
  [1,2,3]
```

Here we say: "From current subset, try adding each remaining element"

## STEP 4: Implement Following Tree Structure

**Approach 1: Include/Exclude branches**
```typescript
function subsets(nums: number[]): number[][] {
  let result: number[][] = [];

  function backtrack(index: number, path: number[]) {
    // Base case: processed all elements
    if (index === nums.length) {
      result.push([...path]);
      return;
    }

    // Branch 1: Include nums[index]
    path.push(nums[index]);
    backtrack(index + 1, path);
    path.pop();

    // Branch 2: Exclude nums[index]
    backtrack(index + 1, path);
  }

  backtrack(0, []);
  return result;
}
```

**Approach 2: Add each remaining (classic backtracking)**
```typescript
function subsets(nums: number[]): number[][] {
  let result: number[][] = [];

  function backtrack(start: number, path: number[]) {
    // Add current subset (every node is a subset!)
    result.push([...path]);

    // Try adding each remaining element
    for (let i = start; i < nums.length; i++) {
      path.push(nums[i]);           // Make choice
      backtrack(i + 1, path);       // Recurse
      path.pop();                   // Backtrack
    }
  }

  backtrack(0, []);
  return result;
}
```

Both follow the tree! Choose what makes sense to you.

## STEP 5: Complexity from Tree

- **Nodes in tree**: O(2ⁿ)
- **Time**: O(n * 2ⁿ) - visit all nodes, copy takes O(n)
- **Space**: O(n) for recursion depth

**The tree made this clear!**

Try solving this problem on the right →
```

**Right Panel (Problem)**: `backtrack-1` (Subsets)

**Solution Analysis**:

```typescript
// OPTIMAL: Backtracking
function subsets(nums: number[]): number[][] {
  let result: number[][] = [];

  function backtrack(start: number, path: number[]) {
    result.push([...path]);

    for (let i = start; i < nums.length; i++) {
      path.push(nums[i]);
      backtrack(i + 1, path);
      path.pop();
    }
  }

  backtrack(0, []);
  return result;
}

// ALSO OPTIMAL: Iterative bit manipulation
function subsets(nums: number[]): number[][] {
  let result: number[][] = [];
  let n = nums.length;

  for (let i = 0; i < (1 << n); i++) {  // 2^n combinations
    let subset: number[] = [];
    for (let j = 0; j < n; j++) {
      if (i & (1 << j)) {
        subset.push(nums[j]);
      }
    }
    result.push(subset);
  }

  return result;
}
```

**Next**: Item 5

---

### **ITEM 5: Permutations - Tree Shows the Pattern**
**Type**: Lesson + Problem
**Duration**: 15-18 minutes

**Left Panel (Lesson)**:
```
# Permutations: Let the Tree Guide You

**Problem**: Generate all permutations of array [1,2,3]

## STEP 1: Draw the Tree First! 🌳

```
                    []
         /          |          \
       [1]         [2]         [3]
      /   \        /  \        /  \
   [1,2] [1,3]  [2,1] [2,3]  [3,1] [3,2]
     |     |      |     |      |     |
  [1,2,3][1,3,2][2,1,3][2,3,1][3,1,2][3,2,1]
```

## STEP 2: Analyze the Tree

**What do we see?**
1. At root: Choose any of 3 elements
2. At level 2: Choose any remaining (2 left)
3. At level 3: Choose last remaining (1 left)
4. **Total leaves**: 3! = 6 permutations
5. **Do nodes repeat?** NO! Each path is unique

**Key difference from Subsets:**
- Subsets: Each element "include or skip" → 2 branches
- Permutations: Each element "which one next?" → n branches

## STEP 3: Tree → Code

The tree shows: **Track which elements are used**

```typescript
function permute(nums: number[]): number[][] {
  let result: number[][] = [];

  function backtrack(path: number[], used: boolean[]) {
    // Base case: used all elements (reached leaf)
    if (path.length === nums.length) {
      result.push([...path]);
      return;
    }

    // Try each unused element (tree branches)
    for (let i = 0; i < nums.length; i++) {
      if (used[i]) continue;

      path.push(nums[i]);
      used[i] = true;
      backtrack(path, used);
      path.pop();
      used[i] = false;
    }
  }

  backtrack([], new Array(nums.length).fill(false));
  return result;
}
```

Time: O(n! * n) - count nodes in tree
Space: O(n) - tree depth

Try solving this →
```

**Right Panel (Problem)**: `backtrack-3` (Permutations)

**Next**: Item 6

---

### **ITEM 6: Combinations - Tree Reveals Pruning**
**Type**: Lesson + Problem
**Duration**: 15 minutes

**Left Panel (Lesson)**:
```
# Combinations: Tree Shows When to Prune

**Problem**: Generate all combinations of k=2 numbers from n=4

## STEP 1: Draw the Tree

```
                    []
         /     |      |     \
       [1]   [2]    [3]    [4]
      / | \   |  \    \
   [1,2][1,3][1,4] [2,3][2,4] [3,4]
```

Notice: We only go forward (1→2, not 2→1) to avoid duplicates!

## STEP 2: Analyze + Prune

**Pruning opportunity from tree:**

If we're at `path = [1]` and need k=2 total:
- Still need: 2 - 1 = 1 more
- Available: [2,3,4] = 3 elements
- 3 >= 1 ✓ continue

If we're at `path = [3]` and need k=2 total:
- Still need: 2 - 1 = 1 more
- Available: [4] = 1 element
- 1 >= 1 ✓ continue

If we're at `path = [4]` and need k=2 total:
- Still need: 2 - 1 = 1 more
- Available: [] = 0 elements
- 0 < 1 ✗ **PRUNE THIS BRANCH!**

The tree visualization makes pruning obvious!

## STEP 3: Tree → Code with Pruning

```typescript
function combine(n: number, k: number): number[][] {
  let result: number[][] = [];

  function backtrack(start: number, path: number[]) {
    // Base case: reached desired length (leaf)
    if (path.length === k) {
      result.push([...path]);
      return;
    }

    // Pruning from tree analysis!
    let needed = k - path.length;
    let available = n - start + 1;
    if (available < needed) return; // ← Tree showed us this!

    for (let i = start; i <= n; i++) {
      path.push(i);
      backtrack(i + 1, path);
      path.pop();
    }
  }

  backtrack(1, []);
  return result;
}
```

Without drawing the tree, you might miss the pruning optimization!

Try solving this →
```

**Right Panel (Problem)**: `backtrack-4` (Combinations)

**Next**: Item 7

---

### **ITEM 7: Combination Sum**
**Type**: Lesson + Problem
**Duration**: 15-18 minutes

**Left Panel (Lesson)**:
```
# Combination Sum: Reuse Elements

**Problem**: Find all combinations that sum to target=7
candidates = [2, 3, 7]

## Draw the Tree First:

```
                    target=7
           /         |          \
        [2]→5      [3]→4       [7]→0 ✓
       / | \       / | \
   [2]→3 [3]→2  [7]→-3❌ [3]→1 [7]→-3❌
   /|\   /|\      /|\
[2]→1 [3]→0✓  [2]→0✓ [3]→-1❌
      [7]→-6❌  [7]→-5❌

Leaves marked ✓: [[7], [2,2,3], [2,3,2]]
Notice [2,2,3] and [2,3,2] are same! How to avoid?
→ Always go forward in array to avoid reordering!
```

Try solving this →
```

**Right Panel (Problem)**: `backtrack-5` (Combination Sum)

**Next**: Item 8

---

### **ITEM 8: Subsets II (With Duplicates)**
**Type**: Lesson + Problem
**Duration**: 15 minutes

**Left Panel (Lesson)**:
```
# Handling Duplicates: Tree Shows What to Skip

**Problem**: Generate subsets from [1, 2, 2] - no duplicate subsets!

## Draw the Tree (without handling duplicates):

```
                    []
          /                  \
        [1]                  []
      /     \              /    \
    [1,2]   [1]         [2]     []
    /  \    / \         / \     / \
[1,2,2][1,2][1,2][1] [2,2][2] [2] []
           ↑     ↑            ↑   ↑
        DUPLICATES!          DUPLICATES!
```

The tree reveals the problem: same subsets appear multiple times!

## Solution: Sort + Skip at Same Level

```
After sorting [1,2,2]:

                    []
          /                  \
        [1]                  []
      /     \                 |  (skip 2nd 2)
    [1,2]   [1]              [2]
    /  \      \               \
[1,2,2][1,2] [1,2]           [2,2]
```

Skip when: `i > start && nums[i] == nums[i-1]`

This means: "Skip if same as previous at THIS LEVEL"

```typescript
function subsetsWithDup(nums: number[]): number[][] {
  nums.sort((a, b) => a - b);
  let result: number[][] = [];

  function backtrack(start: number, path: number[]) {
    result.push([...path]);

    for (let i = start; i < nums.length; i++) {
      // Skip duplicates at same level (tree analysis!)
      if (i > start && nums[i] === nums[i - 1]) continue;

      path.push(nums[i]);
      backtrack(i + 1, path);
      path.pop();
    }
  }

  backtrack(0, []);
  return result;
}
```

The tree made the duplicate pattern visible!

Try solving this →
```

**Right Panel (Problem)**: `backtrack-2` (Subsets II)

**Next**: Item 9

---

### **ITEM 9: Generate Parentheses**
**Type**: Lesson + Problem
**Duration**: 15-18 minutes

**Left Panel (Lesson)**:
```
# Generate Parentheses: Tree with Constraints

**Problem**: Generate all valid n=2 pairs of parentheses

## Draw the Tree:

```
                    ""
             /             \
          "("              ")" ← INVALID (can't start with close)
         /     \
      "( ("    "( )"
      /   \      /  \
   "(()"  "(((" "()("|"())" ← "()(" invalid (close>open)
   /  \     |      |     \
"(())" "(()(" "((()))" "()()" "()()(" ← invalid

Valid leaves: "(())", "((()))", "()()", ...
```

**Tree reveals:**
- Can add '(' if `open < n`
- Can add ')' if `close < open`
- These constraints PRUNE invalid branches!

```typescript
function generateParenthesis(n: number): string[] {
  let result: string[] = [];

  function backtrack(path: string, open: number, close: number) {
    if (path.length === 2 * n) {
      result.push(path);
      return;
    }

    // Tree branch 1: add '(' if allowed
    if (open < n) {
      backtrack(path + '(', open + 1, close);
    }

    // Tree branch 2: add ')' if allowed
    if (close < open) {
      backtrack(path + ')', open, close + 1);
    }
  }

  backtrack('', 0, 0);
  return result;
}
```

Try solving this →
```

**Right Panel (Problem)**: `backtrack-11` (Generate Parentheses)

**Next**: Item 10 (Begin Part 2: Trees + Memoization)

---

## PART 2: TREES + MEMOIZATION

### **ITEM 10: When Trees Reveal Repeated Work**
**Type**: Lesson + Problem
**Duration**: 18-20 minutes

**Content**:
```
# The Bridge: Backtracking → Dynamic Programming

So far we've seen pure backtracking where **every node is unique**.

But what if we drew a tree where **nodes repeat**?

## Problem: Climbing Stairs (Revisited)

Count ways to climb n=4 stairs (1 or 2 steps at a time)

## Draw the Complete Tree:

```
                    climb(4)
                 /            \
            climb(3)         climb(2) ← appears again below!
           /        \        /        \
      climb(2)   climb(1) climb(1)  climb(0)
      /      \      |        |         |
  climb(1) climb(0) 1        1         1
    /   \      |
climb(0) -1    1
   |
   1
```

**Analysis:**
- `climb(2)` computed TWICE
- `climb(1)` computed THREE times
- `climb(0)` computed THREE times

This is WASTED WORK! The tree revealed it!

## Solution: Memoization

```typescript
// WITHOUT memo - O(2^n) from tree node count
function climbStairs(n: number): number {
  if (n <= 1) return 1;
  return climbStairs(n - 1) + climbStairs(n - 2);
}

// WITH memo - O(n) - each node computed once!
function climbStairs(n: number): number {
  let memo: Map<number, number> = new Map();

  function climb(n: number): number {
    if (n <= 1) return 1;

    if (memo.has(n)) return memo.get(n)!; // ← Skip repeated work!

    let result = climb(n - 1) + climb(n - 2);
    memo.set(n, result);
    return result;
  }

  return climb(n);
}
```

## The Tree Shows the Difference:

```
WITHOUT MEMO (expand everything):
                climb(4)
             /            \
        climb(3)         climb(2)
       /      \          /      \
   climb(2) climb(1) climb(1) climb(0)
   /    \
climb(1) climb(0)

Count nodes: 9 function calls for n=4!


WITH MEMO (cache results):
                climb(4)
             /            \
        climb(3)         climb(2) ← return cached!
       /      \
   climb(2) ← return cached!
      |
   climb(1)
      |
   climb(0)

Count nodes: 5 unique function calls for n=4!
```

## How to Recognize:

After drawing the tree, ask:
1. **Do same nodes appear multiple times?** YES → memo helps!
2. **What uniquely identifies a node?** That's your memo key!
   - For climb: the number `n`
   - For fib: the number `n`
   - For coin change: remaining amount
   - For LCS: indices (i, j)

## Practice: Fibonacci with Tree

**Problem:** fib(5)

**Your turn:**
1. Draw the tree for fib(5)
2. Circle all repeated nodes
3. Add memoization with the key being `n`
4. Calculate: how many calls without memo vs with memo?

Try implementing this →
```

**Right Panel (Problem)**: `dp-basics-1` (Climbing Stairs with memo)

**Next**: Item 11

---

### **ITEM 11: Combination Sum with Memoization**
**Type**: Advanced Lesson + Problem
**Duration**: 20-25 minutes

**Content**:
```
# Advanced: When to Memo in Backtracking

## Problem: Combination Sum

Find number of ways (not the combinations themselves!) to make target=4 with coins [1,2,3]

## Draw the Tree:

```
                  amount=4
           /        |         \
       [use 1]   [use 2]    [use 3]
          |         |           |
      amount=3  amount=2    amount=1
      /  |  \    /    \       /    \
    [1][2][3] [1]  [2]     [1]    [skip]
     |   |  |  |    |       |
    a=2 a=1 a=0 a=1 a=0    a=0
```

**Notice:**
- `amount=3` appears once
- `amount=2` appears TWICE (after using [1,1] and directly [2])
- `amount=1` appears MANY times

For larger targets, repetition grows exponentially!

## Without Memo: Generate All Combinations

If you want to LIST all combinations:
```typescript
function combinationSum(coins: number[], target: number): number[][] {
  let result: number[][] = [];

  function backtrack(remain: number, start: number, path: number[]) {
    if (remain === 0) {
      result.push([...path]);
      return;
    }
    if (remain < 0) return;

    for (let i = start; i < coins.length; i++) {
      path.push(coins[i]);
      backtrack(remain - coins[i], i, path); // ← Can reuse coin
      path.pop();
    }
  }

  backtrack(target, 0, []);
  return result;  // Returns: [[1,1,1,1], [1,1,2], [2,2], [1,3]]
}
```

NO memo needed because we need all unique paths!

## With Memo: Count Combinations

If you only want to COUNT combinations:
```typescript
function combinationSum4(coins: number[], target: number): number {
  let memo: Map<number, number> = new Map();

  function count(remain: number): number {
    if (remain === 0) return 1;
    if (remain < 0) return 0;

    if (memo.has(remain)) return memo.get(remain)!; // ← Use cached!

    let total = 0;
    for (let coin of coins) {
      total += count(remain - coin);
    }

    memo.set(remain, total);
    return total;
  }

  return count(target);
}
```

WITH memo because we only care about count, not paths!

## The Decision:

```
Question: What am I returning?

├─ Returning ALL paths/combinations/permutations?
│  └─ NO MEMO (each path is unique)
│     Examples: Generate subsets, permutations, combinations
│
└─ Returning COUNT / MIN / MAX / BOOLEAN?
   └─ CHECK TREE for repeated nodes
      ├─ Nodes repeat? USE MEMO
      │  Examples: Coin change count, climbing stairs, fibonacci
      └─ Nodes don't repeat? NO MEMO
         (Rare for counting problems)
```

## Key Insight:

**The tree tells you everything:**
- Drawing tree for "generate all" → unique paths → no memo
- Drawing tree for "count ways" → repeated nodes → use memo!

This is the bridge from backtracking to dynamic programming!

Try solving: Count ways to make target=5 with coins [1,2,3] →
```

**Right Panel (Problem)**: `dp-basics-2` (Combination Sum IV with memo)

**Next**: Item 12 (Begin Part 3: Constraint Satisfaction)

---

## PART 3: CONSTRAINT SATISFACTION

### **ITEM 12: N-Queens - Tree Visualizes Pruning**
**Type**: Lesson + Problem
**Duration**: 20-25 minutes

**Left Panel (Lesson)**:
```
# Classic Constraint Satisfaction: N-Queens

**Problem**: Place 4 queens on 4×4 board so no two attack each other

## Draw the Tree (n=4):

```
Row 0: Try each column
                    root
         /      |        |       \
      col=0   col=1    col=2   col=3
        Q...   .Q..     ..Q.    ...Q

Row 1: For each, try columns that don't conflict
      Q...
     / | | \
   .Q.. ❌  ❌  ...Q
         ↑   ↑
    conflicts!

   .Q..
   / | \ \
 Q... ❌ ❌ ...Q
  ↑  conflicts

And so on...
```

**Tree reveals:**
- Massive pruning! Most branches are invalid
- Track attacked columns and diagonals to prune early
- Without tree, hard to see the pruning strategy

## Strategy from Tree Analysis:

1. Place one queen per row (tree levels = rows)
2. For each row, try each column (branches)
3. **Prune** if column/diagonal already attacked
4. Track 3 constraints:
   - Column: `col` value
   - Diagonal \: `row - col` constant
   - Diagonal /: `row + col` constant

```typescript
function solveNQueens(n: number): string[][] {
  let result: string[][] = [];
  let board = Array(n).fill(0).map(() => Array(n).fill('.'));

  // Track attacked positions (for pruning!)
  let cols = new Set<number>();
  let diag1 = new Set<number>();  // row - col
  let diag2 = new Set<number>();  // row + col

  function backtrack(row: number) {
    if (row === n) {
      result.push(board.map(r => r.join('')));
      return;
    }

    for (let col = 0; col < n; col++) {
      // PRUNING: Check constraints before recursing
      if (cols.has(col) ||
          diag1.has(row - col) ||
          diag2.has(row + col)) {
        continue;  // ← Tree branch pruned!
      }

      // Make choice
      board[row][col] = 'Q';
      cols.add(col);
      diag1.add(row - col);
      diag2.add(row + col);

      backtrack(row + 1);

      // Backtrack
      board[row][col] = '.';
      cols.delete(col);
      diag1.delete(row - col);
      diag2.delete(row + col);
    }
  }

  backtrack(0);
  return result;
}
```

Time: O(n!) but heavily pruned
Space: O(n) for recursion

The tree visualization makes the pruning strategy obvious!

Try solving this →
```

**Right Panel (Problem)**: `backtrack-6` (N-Queens)

**Next**: Item 13

---

### **ITEM 13: Sudoku Solver**
**Type**: Lesson + Problem
**Duration**: 20-25 minutes

**Left Panel (Lesson)**:
```
# Classic Backtracking: N-Queens

**Problem**: Place N queens on N×N chessboard so no two attack each other.

```
Input: n = 4
Output: [
  [".Q..",
   "...Q",
   "Q...",
   "..Q."],

  ["..Q.",
   "Q...",
   "...Q",
   ".Q.."]
]
```

## Constraints:
Queens attack same row, column, and diagonals.

## Strategy:
Place one queen per row, track used columns and diagonals.

## Implementation:

```typescript
function solveNQueens(n: number): string[][] {
  let result: string[][] = [];
  let board = Array(n).fill(0).map(() => Array(n).fill('.'));

  // Track attacked positions
  let cols = new Set<number>();
  let diag1 = new Set<number>();  // row - col
  let diag2 = new Set<number>();  // row + col

  function backtrack(row: number) {
    if (row === n) {
      result.push(board.map(r => r.join('')));
      return;
    }

    for (let col = 0; col < n; col++) {
      // Check if position is safe
      if (cols.has(col) ||
          diag1.has(row - col) ||
          diag2.has(row + col)) {
        continue;
      }

      // Make choice
      board[row][col] = 'Q';
      cols.add(col);
      diag1.add(row - col);
      diag2.add(row + col);

      backtrack(row + 1);

      // Backtrack
      board[row][col] = '.';
      cols.delete(col);
      diag1.delete(row - col);
      diag2.delete(row + col);
    }
  }

  backtrack(0);
  return result;
}
```

## Diagonal Formulas:
- **Top-left to bottom-right**: `row - col` is constant
- **Top-right to bottom-left**: `row + col` is constant

This is a classic **constraint satisfaction** problem!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `backtrack-6` (N-Queens)

**Next**: Item 8

---

### **ITEM 8: Sudoku Solver**
**Type**: Problem Only
**Duration**: 25-30 minutes

**Left Panel (Problem Context)**:
```
# Challenge: Sudoku Solver

**Problem**: Solve a Sudoku puzzle.

Rules:
- Each row must contain 1-9 without repetition
- Each column must contain 1-9 without repetition
- Each 3×3 sub-box must contain 1-9 without repetition

## Hint:
Use backtracking!

1. Find next empty cell
2. Try digits 1-9
3. For each valid digit:
   - Place it
   - Recursively solve rest
   - If successful, done!
   - Otherwise, backtrack (remove digit)

Track used digits with sets for each row, column, and 3×3 box.

```typescript
function solveSudoku(board: string[][]): void {
  let rows = Array(9).fill(0).map(() => new Set<string>());
  let cols = Array(9).fill(0).map(() => new Set<string>());
  let boxes = Array(9).fill(0).map(() => new Set<string>());

  // Initialize sets with existing numbers
  for (let i = 0; i < 9; i++) {
    for (let j = 0; j < 9; j++) {
      if (board[i][j] !== '.') {
        let num = board[i][j];
        rows[i].add(num);
        cols[j].add(num);
        boxes[Math.floor(i/3) * 3 + Math.floor(j/3)].add(num);
      }
    }
  }

  function backtrack(): boolean {
    // Find next empty cell
    for (let i = 0; i < 9; i++) {
      for (let j = 0; j < 9; j++) {
        if (board[i][j] !== '.') continue;

        // Try digits 1-9
        for (let num = 1; num <= 9; num++) {
          let numStr = String(num);
          let boxIdx = Math.floor(i/3) * 3 + Math.floor(j/3);

          // Check if valid
          if (rows[i].has(numStr) ||
              cols[j].has(numStr) ||
              boxes[boxIdx].has(numStr)) {
            continue;
          }

          // Make choice
          board[i][j] = numStr;
          rows[i].add(numStr);
          cols[j].add(numStr);
          boxes[boxIdx].add(numStr);

          if (backtrack()) return true;

          // Backtrack
          board[i][j] = '.';
          rows[i].delete(numStr);
          cols[j].delete(numStr);
          boxes[boxIdx].delete(numStr);
        }

        return false;  // No valid digit found
      }
    }

    return true;  // All cells filled
  }

  backtrack();
}
```

This is a **HARD** problem combining backtracking with constraint tracking!
```

**Right Panel (Problem)**: `backtrack-7` (Sudoku Solver)

**Next**: Item 9

---

### **ITEM 9: Word Search**
**Type**: Lesson + Problem
**Duration**: 15-18 minutes

**Left Panel (Lesson)**:
```
# Backtracking on 2D Grid

**Problem**: Find if word exists in grid. Can move horizontally or vertically.

```
Input:
board = [
  ['A','B','C','E'],
  ['S','F','C','S'],
  ['A','D','E','E']
]
word = "ABCCED"

Output: true
```

## Strategy:
DFS + backtracking from each cell:

```typescript
function exist(board: string[][], word: string): boolean {
  let rows = board.length;
  let cols = board[0].length;

  function backtrack(row: number, col: number, index: number): boolean {
    // Base case: found word
    if (index === word.length) return true;

    // Bounds check
    if (row < 0 || row >= rows ||
        col < 0 || col >= cols ||
        board[row][col] !== word[index]) {
      return false;
    }

    // Mark as visited
    let temp = board[row][col];
    board[row][col] = '#';

    // Try all 4 directions
    let found = backtrack(row + 1, col, index + 1) ||
                backtrack(row - 1, col, index + 1) ||
                backtrack(row, col + 1, index + 1) ||
                backtrack(row, col - 1, index + 1);

    // Backtrack: restore cell
    board[row][col] = temp;

    return found;
  }

  // Try starting from each cell
  for (let i = 0; i < rows; i++) {
    for (let j = 0; j < cols; j++) {
      if (backtrack(i, j, 0)) return true;
    }
  }

  return false;
}
```

## Key Technique:
Temporarily mark visited cells to avoid reusing them!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `backtrack-8` (Word Search)

**Next**: Item 10

---

### **ITEM 10: Palindrome Partitioning**
**Type**: Lesson + Problem
**Duration**: 15-18 minutes

**Left Panel (Lesson)**:
```
# String Partitioning with Backtracking

**Problem**: Partition string into palindrome substrings.

```
Input: s = "aab"
Output: [["a","a","b"], ["aa","b"]]
```

## Strategy:
At each position, try all possible palindrome prefixes:

```typescript
function partition(s: string): string[][] {
  let result: string[][] = [];

  function isPalindrome(str: string): boolean {
    let left = 0, right = str.length - 1;
    while (left < right) {
      if (str[left++] !== str[right--]) return false;
    }
    return true;
  }

  function backtrack(start: number, path: string[]) {
    // Base case: reached end
    if (start === s.length) {
      result.push([...path]);
      return;
    }

    // Try all possible palindrome prefixes
    for (let end = start + 1; end <= s.length; end++) {
      let substring = s.slice(start, end);

      if (isPalindrome(substring)) {
        path.push(substring);
        backtrack(end, path);
        path.pop();
      }
    }
  }

  backtrack(0, []);
  return result;
}
```

## Optimization:
Precompute palindrome checks with 2D DP!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `backtrack-9` (Palindrome Partitioning)

**Next**: Item 11

---

### **ITEM 11: Letter Combinations of Phone Number**
**Type**: Problem Only
**Duration**: 12-15 minutes

**Left Panel (Problem Context)**:
```
# Practice: Mapping-Based Backtracking

**Problem**: Generate all letter combinations from phone number.

```
Input: digits = "23"
Output: ["ad","ae","af","bd","be","bf","cd","ce","cf"]

Mapping:
2 → "abc"
3 → "def"
4 → "ghi"
...
```

## Hint:
For each digit, try each corresponding letter:

```typescript
function letterCombinations(digits: string): string[] {
  if (!digits) return [];

  let phone = {
    '2': 'abc', '3': 'def', '4': 'ghi',
    '5': 'jkl', '6': 'mno', '7': 'pqrs',
    '8': 'tuv', '9': 'wxyz'
  };

  let result: string[] = [];

  function backtrack(index: number, path: string) {
    if (index === digits.length) {
      result.push(path);
      return;
    }

    let letters = phone[digits[index]];
    for (let letter of letters) {
      backtrack(index + 1, path + letter);
    }
  }

  backtrack(0, '');
  return result;
}
```

This is a classic backtracking problem!
```

**Right Panel (Problem)**: `backtrack-10` (Letter Combinations of a Phone Number)

**Next**: Item 12

---

### **ITEM 12: Generate Parentheses**
**Type**: Lesson + Problem
**Duration**: 15-18 minutes

**Left Panel (Lesson)**:
```
# Constrained Generation with Backtracking

**Problem**: Generate all valid combinations of n pairs of parentheses.

```
Input: n = 3
Output: ["((()))","(()())","(())()","()(())","()()()"]
```

## Constraints:
1. Can't add ')' if it would make more ')' than '('
2. Can't add '(' if we've used all n

## Implementation:

```typescript
function generateParenthesis(n: number): string[] {
  let result: string[] = [];

  function backtrack(path: string, open: number, close: number) {
    // Base case: used all parentheses
    if (path.length === 2 * n) {
      result.push(path);
      return;
    }

    // Can add '(' if we haven't used all n
    if (open < n) {
      backtrack(path + '(', open + 1, close);
    }

    // Can add ')' if it won't exceed '('
    if (close < open) {
      backtrack(path + ')', open, close + 1);
    }
  }

  backtrack('', 0, 0);
  return result;
}
```

## Key Insight:
Track `open` and `close` counts to enforce constraints!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `backtrack-11` (Generate Parentheses)

**Next**: Item 13

---

### **ITEM 13: Combination Sum II**
**Type**: Problem Only
**Duration**: 15-18 minutes

**Left Panel (Problem Context)**:
```
# Practice: Duplicates + No Reuse

**Problem**: Find combinations that sum to target. Each number used at most once, array contains duplicates.

```
Input: candidates = [10,1,2,7,6,1,5], target = 8
Output: [[1,1,6], [1,2,5], [1,7], [2,6]]
```

## Hint:
Combine techniques from:
- Combination Sum (basic structure)
- Subsets II (handling duplicates)

```typescript
function combinationSum2(candidates: number[], target: number): number[][] {
  candidates.sort((a, b) => a - b);  // Sort for duplicate handling
  let result: number[][] = [];

  function backtrack(start: number, path: number[], sum: number) {
    if (sum === target) {
      result.push([...path]);
      return;
    }
    if (sum > target) return;

    for (let i = start; i < candidates.length; i++) {
      // Skip duplicates at same level
      if (i > start && candidates[i] === candidates[i - 1]) continue;

      path.push(candidates[i]);
      backtrack(i + 1, path, sum + candidates[i]);  // i+1: no reuse
      path.pop();
    }
  }

  backtrack(0, [], 0);
  return result;
}
```
```

**Right Panel (Problem)**: `backtrack-12` (Combination Sum II)

**Next**: Item 14

---

### **ITEM 14: Restore IP Addresses**
**Type**: Problem Only
**Duration**: 18-20 minutes

**Left Panel (Problem Context)**:
```
# Practice: Partition with Validation

**Problem**: Restore valid IP addresses from string.

```
Input: s = "25525511135"
Output: ["255.255.11.135", "255.255.111.35"]
```

## Constraints:
- Must have exactly 4 segments
- Each segment: 0-255
- No leading zeros (except "0" itself)

## Hint:
Backtrack with validation:

```typescript
function restoreIpAddresses(s: string): string[] {
  let result: string[] = [];

  function isValid(segment: string): boolean {
    if (segment.length === 0 || segment.length > 3) return false;
    if (segment[0] === '0' && segment.length > 1) return false;  // Leading zero
    let num = parseInt(segment);
    return num >= 0 && num <= 255;
  }

  function backtrack(start: number, path: string[]) {
    // Base case: 4 segments
    if (path.length === 4) {
      if (start === s.length) {
        result.push(path.join('.'));
      }
      return;
    }

    // Try segments of length 1, 2, 3
    for (let len = 1; len <= 3; len++) {
      if (start + len > s.length) break;

      let segment = s.slice(start, start + len);
      if (isValid(segment)) {
        path.push(segment);
        backtrack(start + len, path);
        path.pop();
      }
    }
  }

  backtrack(0, []);
  return result;
}
```
```

**Right Panel (Problem)**: `backtrack-13` (Restore IP Addresses)

**Next**: Item 15

---

### **ITEM 15: Word Search II**
**Type**: Problem Only
**Duration**: 25-30 minutes

**Left Panel (Problem Context)**:
```
# Challenge: Trie + Backtracking

**Problem**: Find all words from list that exist in grid.

```
Input:
board = [
  ['o','a','a','n'],
  ['e','t','a','e'],
  ['i','h','k','r'],
  ['i','f','l','v']
]
words = ["oath","pea","eat","rain"]

Output: ["eat","oath"]
```

## Hint:
Combine **Trie** (for efficient word lookup) with **backtracking** (grid search)!

1. Build Trie from words
2. DFS from each cell
3. At each step, check if prefix exists in Trie
4. If word found, add to result
5. Prune: stop if prefix not in Trie

This is a **HARD** problem combining multiple advanced techniques!

```typescript
class TrieNode {
  children: Map<string, TrieNode> = new Map();
  word: string | null = null;
}

function findWords(board: string[][], words: string[]): string[] {
  // Build Trie
  let root = new TrieNode();
  for (let word of words) {
    let node = root;
    for (let char of word) {
      if (!node.children.has(char)) {
        node.children.set(char, new TrieNode());
      }
      node = node.children.get(char)!;
    }
    node.word = word;
  }

  let result = new Set<string>();

  function backtrack(row: number, col: number, node: TrieNode) {
    let char = board[row][col];
    if (!node.children.has(char)) return;

    let nextNode = node.children.get(char)!;
    if (nextNode.word) {
      result.add(nextNode.word);
    }

    // Mark visited
    board[row][col] = '#';

    // Try 4 directions
    let directions = [[0,1], [0,-1], [1,0], [-1,0]];
    for (let [dr, dc] of directions) {
      let newR = row + dr, newC = col + dc;
      if (newR >= 0 && newR < board.length &&
          newC >= 0 && newC < board[0].length &&
          board[newR][newC] !== '#') {
        backtrack(newR, newC, nextNode);
      }
    }

    // Backtrack
    board[row][col] = char;
  }

  for (let i = 0; i < board.length; i++) {
    for (let j = 0; j < board[0].length; j++) {
      backtrack(i, j, root);
    }
  }

  return Array.from(result);
}
```
```

**Right Panel (Problem)**: `backtrack-14` (Word Search II)

**Next**: Module complete!

---

## Module Completion

After Item 15, show:

```
# 🎉 Module 11 Complete!

You've mastered:
✅ Backtracking fundamentals and template
✅ Generating combinations, permutations, subsets
✅ Constraint satisfaction (N-Queens, Sudoku)
✅ Grid-based backtracking (word search)
✅ String partitioning and generation
✅ Handling duplicates in backtracking
✅ Pruning for optimization

## Key Patterns Learned:

1. **Basic Template**: try → recurse → backtrack
2. **Subsets/Combinations**: Include or skip each element
3. **Permutations**: Track used elements
4. **Constraint Satisfaction**: Check validity before recursing
5. **Pruning**: Stop early when solution impossible
6. **Grid Backtracking**: Mark visited, explore 4 directions, restore

## The Backtracking Recipe:
1. Define decision space (what choices?)
2. Define constraints (what's valid?)
3. Define goal (when complete?)
4. Implement: choose → explore → unchoose

## Time Complexities:
- Subsets: O(2ⁿ)
- Permutations: O(n!)
- Combinations: O(C(n,k))
- N-Queens: O(n!)
- Sudoku: O(9^(empty cells))

## Problems Solved: 14

Next: **Module 12: Tries & Advanced String Patterns** →
```

---

## Problems Required

This module requires these problems in `/lib/content/problems/backtracking.ts`:

1. `backtrack-1`: Subsets (MEDIUM)
2. `backtrack-2`: Subsets II (MEDIUM)
3. `backtrack-3`: Permutations (MEDIUM) ⭐⭐⭐ CRITICAL
4. `backtrack-4`: Combinations (MEDIUM)
5. `backtrack-5`: Combination Sum (MEDIUM) ⭐⭐⭐ CRITICAL
6. `backtrack-6`: N-Queens (HARD) ⭐⭐⭐ CRITICAL
7. `backtrack-7`: Sudoku Solver (HARD)
8. `backtrack-8`: Word Search (MEDIUM) ⭐⭐⭐ CRITICAL
9. `backtrack-9`: Palindrome Partitioning (MEDIUM)
10. `backtrack-10`: Letter Combinations of a Phone Number (MEDIUM)
11. `backtrack-11`: Generate Parentheses (MEDIUM) ⭐⭐⭐ CRITICAL
12. `backtrack-12`: Combination Sum II (MEDIUM)
13. `backtrack-13`: Restore IP Addresses (MEDIUM)
14. `backtrack-14`: Word Search II (HARD) ⭐⭐⭐ CRITICAL

---

This specification covers backtracking patterns seen in 10-15% of FAANG interviews.
