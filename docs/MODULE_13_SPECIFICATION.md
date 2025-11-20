# Module 13: Advanced Topics & Mastery

## Overview
This final module covers advanced algorithms, mixed-technique problems, and interview strategies. Students consolidate their learning, tackle complex multi-pattern problems, and prepare for real interviews.

**Total Items**: 10
**Estimated Time**: 3-4 hours
**Prerequisites**: All previous modules

---

## Learning Philosophy

This module focuses on:
1. **Integration**: Combining multiple techniques in one problem
2. **Pattern Recognition**: Quickly identifying which approach to use
3. **Optimization**: Choosing the best solution among alternatives
4. **Interview Readiness**: Communication, trade-offs, edge cases

---

## Module Structure

### Part 1: Multi-Pattern Problems (Items 1-5)
- Problems requiring 2+ techniques
- When to use which data structure
- Trade-off analysis

### Part 2: Advanced Algorithms (Items 6-8)
- Advanced DP
- Complex graph problems
- Optimization techniques

### Part 3: Interview Mastery (Items 9-10)
- Mock interview problems
- Communication strategies
- Debugging and edge cases

---

## Detailed Item Specifications

### **ITEM 1: LRU Cache**
**Type**: Lesson + Problem
**Duration**: 25-30 minutes

**Left Panel (Lesson)**:
```
# Design Problem: LRU Cache

**Problem**: Implement Least Recently Used cache with O(1) get and put.

## Requirements:
- get(key): Return value if exists, -1 otherwise
- put(key, value): Insert/update. If at capacity, remove LRU item.

## Data Structures Needed:

1. **Hash Map**: O(1) lookup
2. **Doubly Linked List**: O(1) move to front, O(1) remove LRU

## Implementation:

```typescript
class ListNode {
  key: number;
  value: number;
  prev: ListNode | null = null;
  next: ListNode | null = null;

  constructor(key: number, value: number) {
    this.key = key;
    this.value = value;
  }
}

class LRUCache {
  private capacity: number;
  private map: Map<number, ListNode>;
  private head: ListNode;  // Most recent (dummy)
  private tail: ListNode;  // Least recent (dummy)

  constructor(capacity: number) {
    this.capacity = capacity;
    this.map = new Map();

    // Dummy head and tail
    this.head = new ListNode(0, 0);
    this.tail = new ListNode(0, 0);
    this.head.next = this.tail;
    this.tail.prev = this.head;
  }

  get(key: number): number {
    if (!this.map.has(key)) return -1;

    let node = this.map.get(key)!;

    // Move to front (most recently used)
    this.remove(node);
    this.addToFront(node);

    return node.value;
  }

  put(key: number, value: number): void {
    if (this.map.has(key)) {
      // Update existing
      let node = this.map.get(key)!;
      node.value = value;
      this.remove(node);
      this.addToFront(node);
    } else {
      // Add new
      if (this.map.size === this.capacity) {
        // Remove LRU (before tail)
        let lru = this.tail.prev!;
        this.remove(lru);
        this.map.delete(lru.key);
      }

      let newNode = new ListNode(key, value);
      this.map.set(key, newNode);
      this.addToFront(newNode);
    }
  }

  private remove(node: ListNode): void {
    node.prev!.next = node.next;
    node.next!.prev = node.prev;
  }

  private addToFront(node: ListNode): void {
    node.next = this.head.next;
    node.prev = this.head;
    this.head.next!.prev = node;
    this.head.next = node;
  }
}
```

This combines **Hash Map** + **Linked List** from Modules 2 and 3!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `design-1` (LRU Cache)

**Next**: Item 2

---

### **ITEM 2: Sliding Window Maximum (Deque)**
**Type**: Lesson + Problem
**Duration**: 20-25 minutes

**Left Panel (Lesson)**:
```
# Advanced: Monotonic Deque

We solved this with heap in Module 8. Now learn the O(n) solution!

**Problem**: Find maximum in each sliding window of size k.

## Heap Solution: O(n log n)
## Deque Solution: O(n)

## Monotonic Deque Approach:

Keep deque of indices in **decreasing order** of values:

```typescript
function maxSlidingWindow(nums: number[], k: number): number[] {
  let result: number[] = [];
  let deque: number[] = [];  // Store indices

  for (let i = 0; i < nums.length; i++) {
    // Remove indices outside window
    while (deque.length > 0 && deque[0] <= i - k) {
      deque.shift();
    }

    // Remove smaller elements (they'll never be max)
    while (deque.length > 0 && nums[deque[deque.length - 1]] < nums[i]) {
      deque.pop();
    }

    deque.push(i);

    // Add to result (window is complete)
    if (i >= k - 1) {
      result.push(nums[deque[0]]);  // Front is maximum
    }
  }

  return result;
}
```

## Why It Works:

Deque maintains indices in decreasing value order.
Front is always the maximum in current window!

Time: O(n) - each element pushed/popped once
Space: O(k)

Try implementing this optimal solution →
```

**Right Panel (Problem)**: Reference to Module 8's Sliding Window Maximum

**Next**: Item 3

---

### **ITEM 3: Trapping Rain Water**
**Type**: Lesson + Problem
**Duration**: 20-25 minutes

**Left Panel (Lesson)**:
```
# Multi-Approach Problem

**Problem**: Compute how much rainwater can be trapped.

```
Input: height = [0,1,0,2,1,0,1,3,2,1,2,1]
Output: 6

   █
   █ water water █
 █ █ water █ water water █ water █
```

## Approach 1: Brute Force O(n²)

For each position, find max left and max right, water = min(maxLeft, maxRight) - height[i].

## Approach 2: Two Arrays O(n), O(n)

Precompute maxLeft and maxRight arrays.

```typescript
function trap(height: number[]): number {
  let n = height.length;
  if (n === 0) return 0;

  let maxLeft = new Array(n);
  let maxRight = new Array(n);

  maxLeft[0] = height[0];
  for (let i = 1; i < n; i++) {
    maxLeft[i] = Math.max(maxLeft[i - 1], height[i]);
  }

  maxRight[n - 1] = height[n - 1];
  for (let i = n - 2; i >= 0; i--) {
    maxRight[i] = Math.max(maxRight[i + 1], height[i]);
  }

  let water = 0;
  for (let i = 0; i < n; i++) {
    water += Math.min(maxLeft[i], maxRight[i]) - height[i];
  }

  return water;
}
```

## Approach 3: Two Pointers O(n), O(1) ⭐ Optimal

```typescript
function trap(height: number[]): number {
  let left = 0, right = height.length - 1;
  let maxLeft = 0, maxRight = 0;
  let water = 0;

  while (left < right) {
    if (height[left] < height[right]) {
      if (height[left] >= maxLeft) {
        maxLeft = height[left];
      } else {
        water += maxLeft - height[left];
      }
      left++;
    } else {
      if (height[right] >= maxRight) {
        maxRight = height[right];
      } else {
        water += maxRight - height[right];
      }
      right--;
    }
  }

  return water;
}
```

This uses **Two Pointers** from Module 1!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `advanced-1` (Trapping Rain Water)

**Next**: Item 4

---

### **ITEM 4: Regular Expression Matching**
**Type**: Problem Only
**Duration**: 30-35 minutes

**Left Panel (Problem Context)**:
```
# Challenge: Advanced DP

**Problem**: Implement regular expression matching with '.' and '*'.

```
Input: s = "aa", p = "a*"
Output: true

Input: s = "ab", p = ".*"
Output: true

Input: s = "mississippi", p = "mis*is*p*."
Output: false
```

## Hint: 2D DP

`dp[i][j]` = does s[0...i-1] match p[0...j-1]?

Cases:
1. If p[j-1] is regular char or '.': `dp[i][j] = dp[i-1][j-1] && match(s[i-1], p[j-1])`
2. If p[j-1] is '*':
   - Match zero: `dp[i][j] = dp[i][j-2]`
   - Match one+: `dp[i][j] = dp[i-1][j] && match(s[i-1], p[j-2])`

This is a **HARD** problem requiring careful DP design!

```typescript
function isMatch(s: string, p: string): boolean {
  let m = s.length, n = p.length;
  let dp = Array(m + 1).fill(false).map(() => Array(n + 1).fill(false));

  dp[0][0] = true;

  // Handle patterns like a*, a*b*, etc.
  for (let j = 2; j <= n; j++) {
    if (p[j - 1] === '*') {
      dp[0][j] = dp[0][j - 2];
    }
  }

  for (let i = 1; i <= m; i++) {
    for (let j = 1; j <= n; j++) {
      if (p[j - 1] === '*') {
        // Match zero
        dp[i][j] = dp[i][j - 2];

        // Match one or more
        if (matches(s[i - 1], p[j - 2])) {
          dp[i][j] = dp[i][j] || dp[i - 1][j];
        }
      } else {
        // Regular character or '.'
        if (matches(s[i - 1], p[j - 1])) {
          dp[i][j] = dp[i - 1][j - 1];
        }
      }
    }
  }

  return dp[m][n];
}

function matches(s: string, p: string): boolean {
  return p === '.' || s === p;
}
```
```

**Right Panel (Problem)**: `advanced-2` (Regular Expression Matching)

**Next**: Item 5

---

### **ITEM 5: Largest Rectangle in Histogram**
**Type**: Lesson + Problem
**Duration**: 25-30 minutes

**Left Panel (Lesson)**:
```
# Stack-Based Optimization

**Problem**: Find largest rectangle in histogram.

```
Input: heights = [2,1,5,6,2,3]
Output: 10
Explanation: Rectangle of height 5, width 2 (heights 5 and 6)
```

## Approach: Monotonic Stack

For each bar, find:
- Left boundary: first bar shorter on left
- Right boundary: first bar shorter on right

Use stack to track indices in increasing height order:

```typescript
function largestRectangleArea(heights: number[]): number {
  let stack: number[] = [];
  let maxArea = 0;

  for (let i = 0; i <= heights.length; i++) {
    let h = i === heights.length ? 0 : heights[i];

    while (stack.length > 0 && h < heights[stack[stack.length - 1]]) {
      let height = heights[stack.pop()!];
      let width = stack.length === 0 ? i : i - stack[stack.length - 1] - 1;
      maxArea = Math.max(maxArea, height * width);
    }

    stack.push(i);
  }

  return maxArea;
}
```

Time: O(n) - each element pushed/popped once
Space: O(n)

This uses **Monotonic Stack** - an advanced pattern!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `advanced-3` (Largest Rectangle in Histogram)

**Next**: Item 6

---

### **ITEM 6: Maximal Rectangle**
**Type**: Problem Only
**Duration**: 30-35 minutes

**Left Panel (Problem Context)**:
```
# Challenge: Combining Techniques

**Problem**: Find largest rectangle in binary matrix.

```
Input:
[
  ["1","0","1","0","0"],
  ["1","0","1","1","1"],
  ["1","1","1","1","1"],
  ["1","0","0","1","0"]
]

Output: 6
```

## Hint: Reduce to Histogram Problem!

For each row, compute heights of consecutive 1s:
- Row 0: [1, 0, 1, 0, 0]
- Row 1: [2, 0, 2, 1, 1]
- Row 2: [3, 1, 3, 2, 2]
- Row 3: [4, 0, 0, 3, 0]

For each row, find largest rectangle using Module 12 Item 5!

This combines **DP** (building heights) + **Stack** (histogram)!

```typescript
function maximalRectangle(matrix: string[][]): number {
  if (matrix.length === 0) return 0;

  let rows = matrix.length;
  let cols = matrix[0].length;
  let heights = new Array(cols).fill(0);
  let maxArea = 0;

  for (let i = 0; i < rows; i++) {
    // Update heights
    for (let j = 0; j < cols; j++) {
      if (matrix[i][j] === '1') {
        heights[j]++;
      } else {
        heights[j] = 0;
      }
    }

    // Find largest rectangle for this histogram
    maxArea = Math.max(maxArea, largestRectangleArea(heights));
  }

  return maxArea;
}

// Use function from Item 5
function largestRectangleArea(heights: number[]): number {
  // Implementation from Item 5
}
```
```

**Right Panel (Problem)**: `advanced-4` (Maximal Rectangle)

**Next**: Item 7

---

### **ITEM 7: Shortest Path in Weighted Graph (Dijkstra)**
**Type**: Lesson + Problem
**Duration**: 25-30 minutes

**Left Panel (Lesson)**:
```
# Graph Algorithm: Dijkstra's Algorithm

**Problem**: Find shortest path in weighted graph (all weights positive).

## Algorithm:

Use min-heap to always explore shortest distance first:

```typescript
function dijkstra(graph: Map<number, [number, number][]>, start: number, end: number): number {
  // graph: node → [[neighbor, weight], ...]

  let distances = new Map<number, number>();
  let minHeap = new MinHeap<[number, number]>((a, b) => a[1] - b[1]);  // [node, dist]

  distances.set(start, 0);
  minHeap.insert([start, 0]);

  while (minHeap.size() > 0) {
    let [node, dist] = minHeap.extractMin();

    if (node === end) return dist;

    if (dist > (distances.get(node) || Infinity)) continue;

    for (let [neighbor, weight] of graph.get(node) || []) {
      let newDist = dist + weight;

      if (newDist < (distances.get(neighbor) || Infinity)) {
        distances.set(neighbor, newDist);
        minHeap.insert([neighbor, newDist]);
      }
    }
  }

  return -1;  // No path
}
```

Time: O((V + E) log V) with heap
Space: O(V)

This combines **Graphs** (Module 6) + **Heaps** (Module 8)!

Try solving a Dijkstra problem on the right →
```

**Right Panel (Problem)**: `advanced-5` (Network Delay Time - Dijkstra application)

**Next**: Item 8

---

### **ITEM 8: Longest Palindromic Subsequence**
**Type**: Problem Only
**Duration**: 20-25 minutes

**Left Panel (Problem Context)**:
```
# Practice: Advanced DP

**Problem**: Find length of longest palindromic subsequence.

```
Input: s = "bbbab"
Output: 4
Explanation: "bbbb" is the longest palindromic subsequence
```

## Hint: 2D DP

`dp[i][j]` = LPS length in s[i...j]

Recurrence:
- If s[i] === s[j]: `dp[i][j] = dp[i+1][j-1] + 2`
- Else: `dp[i][j] = max(dp[i+1][j], dp[i][j-1])`

```typescript
function longestPalindromeSubseq(s: string): number {
  let n = s.length;
  let dp = Array(n).fill(0).map(() => Array(n).fill(0));

  // Base case: single character
  for (let i = 0; i < n; i++) {
    dp[i][i] = 1;
  }

  // Fill diagonally
  for (let len = 2; len <= n; len++) {
    for (let i = 0; i <= n - len; i++) {
      let j = i + len - 1;

      if (s[i] === s[j]) {
        dp[i][j] = dp[i + 1][j - 1] + 2;
      } else {
        dp[i][j] = Math.max(dp[i + 1][j], dp[i][j - 1]);
      }
    }
  }

  return dp[0][n - 1];
}
```

Similar to LCS from Module 7!
```

**Right Panel (Problem)**: `advanced-6` (Longest Palindromic Subsequence)

**Next**: Item 9

---

### **ITEM 9: Mock Interview Problem**
**Type**: Lesson + Problem
**Duration**: 45 minutes

**Left Panel (Lesson)**:
```
# Mock Interview: Multi-Pattern Problem

This item simulates a real interview with a complex problem.

**Problem**: Design a data structure that supports:
- insert(val): Insert value
- remove(val): Remove value
- getRandom(): Return random element in O(1)

All operations must be O(1) average time!

## Interview Process:

1. **Understand**: Clarify requirements
   - Can we have duplicates? (No)
   - Does getRandom need to be uniformly random? (Yes)

2. **Examples**: Walk through examples

3. **Approach**: Discuss data structures
   - Array for O(1) getRandom
   - HashMap for O(1) insert/remove lookup
   - Combine both!

4. **Implementation**: Code the solution

5. **Test**: Walk through test cases

6. **Optimize**: Discuss trade-offs

## Solution:

```typescript
class RandomizedSet {
  private map: Map<number, number>;  // val → index in array
  private arr: number[];

  constructor() {
    this.map = new Map();
    this.arr = [];
  }

  insert(val: number): boolean {
    if (this.map.has(val)) return false;

    this.arr.push(val);
    this.map.set(val, this.arr.length - 1);
    return true;
  }

  remove(val: number): boolean {
    if (!this.map.has(val)) return false;

    // Swap with last element
    let index = this.map.get(val)!;
    let lastVal = this.arr[this.arr.length - 1];

    this.arr[index] = lastVal;
    this.map.set(lastVal, index);

    // Remove last
    this.arr.pop();
    this.map.delete(val);

    return true;
  }

  getRandom(): number {
    let randomIndex = Math.floor(Math.random() * this.arr.length);
    return this.arr[randomIndex];
  }
}
```

Practice explaining your approach clearly!
```

**Right Panel (Problem)**: `advanced-7` (Insert Delete GetRandom O(1))

**Next**: Item 10

---

### **ITEM 10: Interview Strategies & Next Steps**
**Type**: Lesson Only
**Duration**: 10 minutes

**Content**:
```
# 🎓 Congratulations - You've Completed All Modules!

## What You've Mastered:

✅ **Module 1**: Array Iteration (Two Pointers, Sliding Window)
✅ **Module 2**: Hash Maps (Two Sum, Frequency Counting)
✅ **Module 2.5**: Arrays + Hash Maps
✅ **Module 3**: Linked Lists + Hash Maps
✅ **Module 4**: Trees & Traversals (DFS, BFS)
✅ **Module 5**: Binary Search & Sorting
✅ **Module 6**: Graphs & BFS/DFS
✅ **Module 7**: Dynamic Programming
✅ **Module 8**: Heaps & Priority Queues
✅ **Module 9**: Backtracking
✅ **Module 10**: Tries & Advanced Strings
✅ **Module 11**: Bit Manipulation & Math
✅ **Module 12**: Advanced Topics

## Interview Strategies:

### 1. Problem-Solving Framework

**UMPIRE** Method:
- **U**nderstand: Clarify requirements, ask questions
- **M**atch: Identify pattern (which module?)
- **P**lan: Outline approach before coding
- **I**mplement: Write clean, working code
- **R**eview: Test with examples
- **E**valuate: Discuss time/space complexity, optimizations

### 2. Communication Tips

✅ **Think aloud**: Explain your thought process
✅ **Ask clarifying questions**: Edge cases, constraints
✅ **Start with brute force**: Then optimize
✅ **Write clean code**: Variable names, structure
✅ **Test thoroughly**: Happy path, edge cases, errors

### 3. Time Management

- 5 min: Understand + Examples
- 5 min: Plan approach
- 20 min: Implement
- 5 min: Test + Optimize

### 4. Pattern Recognition Speed

When you see a problem, ask:
- **Array + target?** → Two pointers or hash map
- **Subarray/substring?** → Sliding window
- **Optimize recursion?** → Memoization/DP
- **Find top K?** → Heap
- **All combinations?** → Backtracking
- **Shortest path?** → BFS
- **Cycle detection?** → Floyd's algorithm or DFS
- **Prefix matching?** → Trie

### 5. Common Pitfalls to Avoid

❌ Jumping to code too quickly
❌ Not testing with edge cases
❌ Silent coding (not communicating)
❌ Giving up when stuck
❌ Overcomplicating the solution

### 6. Next Steps

1. **Practice Consistently**: 2-3 problems daily
2. **Mock Interviews**: Practice with friends or platforms
3. **Review Mistakes**: Learn from failed attempts
4. **Company-Specific Prep**: Research target companies
5. **System Design**: For senior roles

## You're Ready! 🚀

You now have:
- **200+ problems** solved
- **12 modules** of patterns mastered
- **All major algorithms** covered
- **Interview strategies** learned

Go ace those interviews!

---

### Final Resources:

- **Continue Practice**: Keep solving problems daily
- **Review Weak Areas**: Revisit modules where you struggled
- **Time Yourself**: Practice under interview conditions
- **Stay Current**: Learn new patterns as they emerge

## Good luck with your interviews! 🎉
```

**Next**: Module complete! Course complete!

---

## Module Completion

After Item 10, show:

```
# 🎉🎉 IdleCampus Complete! 🎉🎉

You've finished all 12 modules and mastered coding interviews!

## Total Achievement:
- **200+ Problems** solved
- **12 Modules** completed
- **50+ Patterns** mastered
- **Interview-Ready** ✓

## What's Next:

1. **Keep Practicing**: Consistency is key
2. **Mock Interviews**: Simulate real conditions
3. **Apply Strategically**: Target your dream companies
4. **Stay Confident**: You've put in the work!

Remember: **You're not just learning algorithms, you're building problem-solving skills that last a career.**

## Share Your Success! 🌟

Completed IdleCampus? Share your journey and help others!

---

**Now go land that dream job!** 💼🚀
```

---

## Problems Required

This module requires these problems in `/lib/content/problems/advanced.ts`:

1. `design-1`: LRU Cache (MEDIUM) ⭐⭐⭐ CRITICAL
2. `advanced-1`: Trapping Rain Water (HARD) ⭐⭐⭐ CRITICAL
3. `advanced-2`: Regular Expression Matching (HARD) ⭐⭐⭐ CRITICAL
4. `advanced-3`: Largest Rectangle in Histogram (HARD) ⭐⭐⭐ CRITICAL
5. `advanced-4`: Maximal Rectangle (HARD)
6. `advanced-5`: Network Delay Time (MEDIUM) - Dijkstra's Algorithm
7. `advanced-6`: Longest Palindromic Subsequence (MEDIUM)
8. `advanced-7`: Insert Delete GetRandom O(1) (MEDIUM)

---

## Course Summary

**Total Modules**: 12
**Total Problems**: 200+
**Coverage**: All major FAANG interview patterns

This completes the IdleCampus adaptive learning curriculum!
