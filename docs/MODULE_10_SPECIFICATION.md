# Module 10: Heaps & Priority Queues

## Overview
This module teaches heap data structures and priority queue patterns through adaptive learning. Students learn heap operations, solve Top K problems, implement efficient algorithms using heaps, and combine heaps with other data structures.

**Total Items**: 14
**Estimated Time**: 4-5 hours
**Prerequisites**: Module 1 (Arrays), Module 2 (Hash Maps), Module 4 (Trees - for heap tree structure)

---

## Learning Philosophy

Following the IdleCampus adaptive learning approach:
1. **Present Problem First**: User encounters the problem before seeing heap solution
2. **Detect Approach**: Analyze if user writes brute force (sort) or optimal (heap)
3. **Adaptive Branching**: Different learning paths based on user's solution
4. **Guide, Don't Give Away**: Help user discover when heaps are better than sorting
5. **Brute Force → Optimization**: From O(n log n) sorting to O(n log k) heap

---

## Module Structure

### Part 1: Heap Fundamentals (Items 1-5)
- What is a heap?
- Min-heap vs max-heap
- Heap operations (insert, extract, peek)
- Top K problems

### Part 2: Advanced Heap Applications (Items 6-11)
- K-way merge problems
- Sliding window with heap
- Meeting rooms and intervals
- Heap with custom comparators

### Part 3: Heap + Other Data Structures (Items 12-14)
- Heap + Hash Map
- Median maintenance (two heaps)
- Priority-based scheduling

---

## Detailed Item Specifications

### **ITEM 1: Introduction to Heaps**
**Type**: Lesson Only
**Duration**: 5 minutes

**Content**:
```
# Heaps & Priority Queues

A **heap** is a specialized tree-based data structure that maintains a priority order.

## Key Properties:

**Min-Heap**: Parent ≤ children (smallest at top)
**Max-Heap**: Parent ≥ children (largest at top)

```
Min-Heap:              Max-Heap:
    1                      9
   / \                    / \
  3   2                  7   8
 / \ / \                / \ / \
4  5 6  7              3  4 5  6
```

## Why Heaps?

**Problem**: Find top K largest elements in array

❌ **Sort entire array**: O(n log n)
✅ **Use min-heap of size K**: O(n log k)

When k << n (e.g., k=10, n=1,000,000), heap is much faster!

## Heap Operations:

```typescript
// JavaScript doesn't have built-in heap, but here's the interface:

class MinHeap {
  insert(val: number): void;        // O(log n)
  extractMin(): number;             // O(log n)
  peek(): number;                   // O(1)
  size(): number;                   // O(1)
}
```

## Array Representation:

Heaps are typically stored as arrays:
```
Index:  0  1  2  3  4  5  6
Value:  1  3  2  4  5  6  7

For node at index i:
- Parent: Math.floor((i-1)/2)
- Left child: 2*i + 1
- Right child: 2*i + 2
```

## When to Use Heaps:

✅ Top K problems (largest/smallest K elements)
✅ K-way merge (merge K sorted lists)
✅ Streaming data (find median, Kth largest)
✅ Priority-based processing
✅ Dijkstra's algorithm (shortest path)

## Why Heaps Matter:
10-15% of FAANG interviews involve heaps or priority queues!

Let's learn to use heaps effectively.
```

**Next**: Item 2

---

### **ITEM 2: Kth Largest Element**
**Type**: Lesson + Problem
**Duration**: 12-15 minutes

**Left Panel (Lesson)**:
```
# Your First Heap Problem

**Problem**: Find the kth largest element in array.

```
Input: nums = [3, 2, 1, 5, 6, 4], k = 2
Output: 5
```

## Approach 1: Sort (Brute Force)
```typescript
function findKthLargest(nums: number[], k: number): number {
  nums.sort((a, b) => b - a);
  return nums[k - 1];
}
```
Time: O(n log n)

## Approach 2: Min-Heap (Optimal for small k)

Keep min-heap of size k with k largest elements:
- If heap size < k: add element
- If new element > heap min: remove min, add new element
- After processing all: heap min is kth largest!

```typescript
function findKthLargest(nums: number[], k: number): number {
  let minHeap = new MinHeap();

  for (let num of nums) {
    minHeap.insert(num);
    if (minHeap.size() > k) {
      minHeap.extractMin();  // Remove smallest
    }
  }

  return minHeap.peek();  // Kth largest
}
```

Time: O(n log k) - better when k << n!

## Approach 3: Quickselect (Advanced)
Time: O(n) average, but heap is more reliable!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `heap-1` (Kth Largest Element in an Array)

**Solution Analysis**:

```typescript
// OPTIMAL FOR SMALL K: Min-heap O(n log k)
function findKthLargest(nums: number[], k: number): number {
  let minHeap = new MinHeap();

  for (let num of nums) {
    minHeap.insert(num);
    if (minHeap.size() > k) {
      minHeap.extractMin();
    }
  }

  return minHeap.peek();
}

// ACCEPTABLE: Sort O(n log n)
function findKthLargest(nums: number[], k: number): number {
  nums.sort((a, b) => b - a);
  return nums[k - 1];
}

// ADVANCED: Quickselect O(n) average
function findKthLargest(nums: number[], k: number): number {
  // Quickselect implementation
}
```

**State Machine Routing**:

```typescript
if (solution.usesMinHeap()) {
  return "item-3-heap-implementation";
} else if (solution.usesSort()) {
  return "item-2a-why-heap-better";
} else {
  return "item-2b-heap-hint";
}
```

---

### **ITEM 2A: Why Heap is Better**
**Type**: Lesson Only
**Duration**: 3 minutes
**Condition**: User used sorting

**Content**:
```
# From Sorting to Heap

Your sorting solution works:

```typescript
nums.sort((a, b) => b - a);
return nums[k - 1];
```

Time: O(n log n)

But consider: **Do you need to sort the entire array?**

## Key Insight:
To find kth largest, you only need to track k elements!

## Min-Heap Approach:

Maintain heap of k largest elements:
```typescript
let minHeap = new MinHeap();

for (let num of nums) {
  minHeap.insert(num);
  if (minHeap.size() > k) {
    minHeap.extractMin();  // Remove smallest
  }
}

return minHeap.peek();  // Kth largest is at top!
```

Time: O(n log k)

## When This Matters:

**Small k** (k = 10, n = 1,000,000):
- Sort: O(1,000,000 * log 1,000,000) ≈ 20,000,000 operations
- Heap: O(1,000,000 * log 10) ≈ 3,300,000 operations

**6x faster!**

**Large k** (k = n/2):
- Both similar, sorting might be simpler

Use heap when **k << n**!
```

**Next**: Item 3

---

### **ITEM 2B: Heap Hint**
**Type**: Lesson Only
**Duration**: 2 minutes

**Content**:
```
# Hint: Track Only K Elements

You don't need to track all n elements - just the k largest!

## Strategy:
Use a **min-heap** of size k:
- Smallest element at top
- As you process array, keep only k largest

## Logic:
```typescript
let minHeap = new MinHeap();

for (let num of nums) {
  minHeap.insert(num);

  // If heap too large, remove smallest
  if (minHeap.size() > k) {
    minHeap.extractMin();
  }
}

// After processing all:
// Heap contains k largest elements
// Top of min-heap is kth largest!
return minHeap.peek();
```

## Why Min-Heap?
We want to quickly remove the smallest among the k largest elements!

Try implementing this approach →
```

**Next**: Item 2 (resubmit)

---

### **ITEM 3: Implementing a Min-Heap**
**Type**: Lesson Only
**Duration**: 5 minutes

**Content**:
```
# Building a Min-Heap in TypeScript

JavaScript doesn't have a built-in heap, so let's implement one!

## Min-Heap Implementation:

```typescript
class MinHeap {
  private heap: number[] = [];

  insert(val: number): void {
    this.heap.push(val);
    this.bubbleUp(this.heap.length - 1);
  }

  extractMin(): number {
    if (this.heap.length === 0) throw new Error("Heap is empty");
    if (this.heap.length === 1) return this.heap.pop()!;

    let min = this.heap[0];
    this.heap[0] = this.heap.pop()!;
    this.bubbleDown(0);
    return min;
  }

  peek(): number {
    return this.heap[0];
  }

  size(): number {
    return this.heap.length;
  }

  private bubbleUp(index: number): void {
    while (index > 0) {
      let parentIndex = Math.floor((index - 1) / 2);
      if (this.heap[index] >= this.heap[parentIndex]) break;

      // Swap with parent
      [this.heap[index], this.heap[parentIndex]] =
        [this.heap[parentIndex], this.heap[index]];
      index = parentIndex;
    }
  }

  private bubbleDown(index: number): void {
    while (true) {
      let smallest = index;
      let left = 2 * index + 1;
      let right = 2 * index + 2;

      if (left < this.heap.length && this.heap[left] < this.heap[smallest]) {
        smallest = left;
      }
      if (right < this.heap.length && this.heap[right] < this.heap[smallest]) {
        smallest = right;
      }

      if (smallest === index) break;

      [this.heap[index], this.heap[smallest]] =
        [this.heap[smallest], this.heap[index]];
      index = smallest;
    }
  }
}
```

## Max-Heap:
Just flip comparisons (< becomes >, >= becomes <=)

You can use this implementation in your solutions!
```

**Next**: Item 4

---

### **ITEM 4: Top K Frequent Elements**
**Type**: Lesson + Problem
**Duration**: 15-18 minutes

**Left Panel (Lesson)**:
```
# Heap + Hash Map: Top K Frequent

**Problem**: Return k most frequent elements.

```
Input: nums = [1,1,1,2,2,3], k = 2
Output: [1, 2]
```

## Approach:

1. **Count frequencies** with hash map: O(n)
2. **Use min-heap** of size k to track top k frequent: O(n log k)

## Implementation:

```typescript
function topKFrequent(nums: number[], k: number): number[] {
  // Step 1: Count frequencies
  let freq = new Map<number, number>();
  for (let num of nums) {
    freq.set(num, (freq.get(num) || 0) + 1);
  }

  // Step 2: Min-heap of [num, frequency] pairs
  let minHeap = new MinHeap<[number, number]>((a, b) => a[1] - b[1]);

  for (let [num, count] of freq) {
    minHeap.insert([num, count]);
    if (minHeap.size() > k) {
      minHeap.extractMin();
    }
  }

  // Step 3: Extract results
  return minHeap.toArray().map(([num, _]) => num);
}
```

This combines **Hash Map** (Module 2) with **Heap**!

## Alternative: Bucket Sort
O(n) but less general. Heap approach works for any comparison!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `heap-2` (Top K Frequent Elements)

**Next**: Item 5

---

### **ITEM 5: Kth Smallest Element in Sorted Matrix**
**Type**: Problem Only
**Duration**: 15-18 minutes

**Left Panel (Problem Context)**:
```
# Practice: Heap on 2D Data

**Problem**: Find kth smallest element in n x n matrix where each row and column is sorted.

```
Input:
[
  [1,  5,  9],
  [10, 11, 13],
  [12, 13, 15]
]
k = 8

Output: 13
```

## Hint:
Use min-heap! Start with first element of each row.

Each time you extract minimum:
- Add the next element from that row to heap

This is similar to merging k sorted lists!

```typescript
// Start with (value, row, col) tuples
minHeap.insert([matrix[0][0], 0, 0]);

// Extract k times
for (let i = 0; i < k; i++) {
  let [val, row, col] = minHeap.extractMin();
  if (last iteration) return val;
  // Add next element from same row
}
```
```

**Right Panel (Problem)**: `heap-3` (Kth Smallest Element in a Sorted Matrix)

**Next**: Item 6

---

### **ITEM 6: Merge K Sorted Lists**
**Type**: Lesson + Problem
**Duration**: 15-20 minutes

**Left Panel (Lesson)**:
```
# K-Way Merge with Heap

**Problem**: Merge k sorted linked lists into one sorted list.

```
Input:
[
  1 → 4 → 5,
  1 → 3 → 4,
  2 → 6
]

Output: 1 → 1 → 2 → 3 → 4 → 4 → 5 → 6
```

## Approach:

Use min-heap to track smallest element from each list:

1. Add first node from each list to heap
2. Extract minimum node
3. Add that node's next to heap
4. Repeat until heap empty

## Implementation:

```typescript
function mergeKLists(lists: ListNode[]): ListNode | null {
  let minHeap = new MinHeap<ListNode>((a, b) => a.val - b.val);

  // Add first node from each list
  for (let head of lists) {
    if (head) minHeap.insert(head);
  }

  let dummy = new ListNode(0);
  let current = dummy;

  while (minHeap.size() > 0) {
    let node = minHeap.extractMin();
    current.next = node;
    current = current.next;

    if (node.next) {
      minHeap.insert(node.next);
    }
  }

  return dummy.next;
}
```

Time: O(N log k) where N = total nodes, k = number of lists
Space: O(k) for heap

This is a classic **k-way merge** pattern!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `heap-4` (Merge k Sorted Lists)

**Next**: Item 7

---

### **ITEM 7: Find Median from Data Stream**
**Type**: Lesson + Problem
**Duration**: 18-20 minutes

**Left Panel (Lesson)**:
```
# Two Heaps: Median Maintenance

**Problem**: Efficiently find median as numbers are added.

```
addNum(1)    → median = 1
addNum(2)    → median = 1.5
addNum(3)    → median = 2
```

## Key Insight:
Use **two heaps** to maintain median!

**Max-Heap** (left side): smaller half
**Min-Heap** (right side): larger half

```
Small half        Large half
(max-heap)       (min-heap)
   1 2 3    |    5 6 7
            ↑
         median
```

## Median:
- If heaps equal size: average of both tops
- If different size: top of larger heap

## Implementation:

```typescript
class MedianFinder {
  private maxHeap: MaxHeap;  // Smaller half
  private minHeap: MinHeap;  // Larger half

  constructor() {
    this.maxHeap = new MaxHeap();
    this.minHeap = new MinHeap();
  }

  addNum(num: number): void {
    // Add to max heap first
    this.maxHeap.insert(num);

    // Balance: move max from left to right
    this.minHeap.insert(this.maxHeap.extractMax());

    // Keep maxHeap size >= minHeap size
    if (this.maxHeap.size() < this.minHeap.size()) {
      this.maxHeap.insert(this.minHeap.extractMin());
    }
  }

  findMedian(): number {
    if (this.maxHeap.size() > this.minHeap.size()) {
      return this.maxHeap.peek();
    }
    return (this.maxHeap.peek() + this.minHeap.peek()) / 2;
  }
}
```

Time: O(log n) per add, O(1) for median
Space: O(n)

This is a **HARD** problem frequently asked in interviews!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `heap-5` (Find Median from Data Stream)

**Next**: Item 8

---

### **ITEM 8: Sliding Window Maximum**
**Type**: Lesson + Problem
**Duration**: 15-18 minutes

**Left Panel (Lesson)**:
```
# Sliding Window with Deque/Heap

**Problem**: Find maximum in each sliding window of size k.

```
Input: nums = [1,3,-1,-3,5,3,6,7], k = 3
Output: [3,3,5,5,6,7]

Window [1  3  -1] → max = 3
Window [3  -1  -3] → max = 3
Window [-1  -3  5] → max = 5
...
```

## Approach 1: Max-Heap with Lazy Deletion

```typescript
function maxSlidingWindow(nums: number[], k: number): number[] {
  let maxHeap = new MaxHeap<[number, number]>((a, b) => b[0] - a[0]);
  let result: number[] = [];

  for (let i = 0; i < nums.length; i++) {
    maxHeap.insert([nums[i], i]);

    if (i >= k - 1) {
      // Remove elements outside window
      while (maxHeap.peek()[1] <= i - k) {
        maxHeap.extractMax();
      }
      result.push(maxHeap.peek()[0]);
    }
  }

  return result;
}
```

Time: O(n log n)

## Approach 2: Monotonic Deque (Optimal)

O(n) using deque, but heap approach is more intuitive!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `heap-6` (Sliding Window Maximum)

**Next**: Item 9

---

### **ITEM 9: Task Scheduler**
**Type**: Lesson + Problem
**Duration**: 15-20 minutes

**Left Panel (Lesson)**:
```
# Greedy + Heap: Task Scheduling

**Problem**: Schedule tasks with cooling period. Same task must wait n intervals.

```
Input: tasks = ["A","A","A","B","B","B"], n = 2
Output: 8

Explanation: A → B → idle → A → B → idle → A → B
```

## Strategy:

1. Count task frequencies
2. Use max-heap to always schedule most frequent task
3. Track cooling period with queue

## Implementation:

```typescript
function leastInterval(tasks: string[], n: number): number {
  // Count frequencies
  let freq = new Map<string, number>();
  for (let task of tasks) {
    freq.set(task, (freq.get(task) || 0) + 1);
  }

  // Max-heap of frequencies
  let maxHeap = new MaxHeap<number>();
  for (let count of freq.values()) {
    maxHeap.insert(count);
  }

  let time = 0;
  let cooldown: [number, number][] = [];  // [count, available_time]

  while (maxHeap.size() > 0 || cooldown.length > 0) {
    time++;

    if (maxHeap.size() > 0) {
      let count = maxHeap.extractMax() - 1;
      if (count > 0) {
        cooldown.push([count, time + n]);
      }
    }

    // Move tasks from cooldown back to heap
    if (cooldown.length > 0 && cooldown[0][1] === time) {
      maxHeap.insert(cooldown.shift()![0]);
    }
  }

  return time;
}
```

This combines **greedy** + **heap** beautifully!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `heap-7` (Task Scheduler)

**Next**: Item 10

---

### **ITEM 10: Meeting Rooms II**
**Type**: Lesson + Problem
**Duration**: 15-18 minutes

**Left Panel (Lesson)**:
```
# Min-Heap for Interval Problems

**Problem**: Minimum meeting rooms needed given intervals.

```
Input: [[0,30], [5,10], [15,20]]
Output: 2

Explanation:
Room 1: [0,30]
Room 2: [5,10], [15,20]
```

## Strategy:

1. Sort intervals by start time
2. Use min-heap to track end times of active meetings
3. For each meeting:
   - Remove ended meetings from heap
   - Add current meeting's end time
   - Heap size = rooms needed at this moment

## Implementation:

```typescript
function minMeetingRooms(intervals: number[][]): number {
  if (intervals.length === 0) return 0;

  // Sort by start time
  intervals.sort((a, b) => a[0] - b[0]);

  // Min-heap of end times
  let minHeap = new MinHeap<number>();
  minHeap.insert(intervals[0][1]);

  for (let i = 1; i < intervals.length; i++) {
    // If earliest meeting ended, reuse room
    if (minHeap.peek() <= intervals[i][0]) {
      minHeap.extractMin();
    }

    minHeap.insert(intervals[i][1]);
  }

  return minHeap.size();
}
```

Time: O(n log n) for sort + O(n log n) for heap = O(n log n)
Space: O(n)

Try solving this problem on the right →
```

**Right Panel (Problem)**: `heap-8` (Meeting Rooms II)

**Next**: Item 11

---

### **ITEM 11: Reorganize String**
**Type**: Problem Only
**Duration**: 15-18 minutes

**Left Panel (Problem Context)**:
```
# Practice: Greedy Heap Reconstruction

**Problem**: Rearrange string so no two same characters are adjacent.

```
Input: s = "aab"
Output: "aba"

Input: s = "aaab"
Output: "" (impossible)
```

## Hint:
Use max-heap of character frequencies!

1. Count frequencies
2. Always pick most frequent character
3. After using, put in "cooldown" (can't use next iteration)
4. If we need a character but heap is empty → impossible

```typescript
function reorganizeString(s: string): string {
  // Count frequencies
  let freq = new Map<string, number>();
  for (let char of s) {
    freq.set(char, (freq.get(char) || 0) + 1);
  }

  // Max-heap of [char, count]
  let maxHeap = new MaxHeap<[string, number]>((a, b) => b[1] - a[1]);
  for (let [char, count] of freq) {
    maxHeap.insert([char, count]);
  }

  let result = "";
  let prev: [string, number] | null = null;

  while (maxHeap.size() > 0) {
    let [char, count] = maxHeap.extractMax();
    result += char;

    // Add previous back to heap
    if (prev && prev[1] > 0) {
      maxHeap.insert(prev);
    }

    // Update prev
    prev = [char, count - 1];
  }

  return result.length === s.length ? result : "";
}
```
```

**Right Panel (Problem)**: `heap-9` (Reorganize String)

**Next**: Item 12

---

### **ITEM 12: K Closest Points to Origin**
**Type**: Problem Only
**Duration**: 12-15 minutes

**Left Panel (Problem Context)**:
```
# Practice: Distance-Based Heap

**Problem**: Find k closest points to origin (0, 0).

```
Input: points = [[1,3], [-2,2], [5,8], [0,1]], k = 2
Output: [[-2,2], [0,1]]
```

## Hint:
Use max-heap of size k based on distance!

Distance = x² + y² (no need for sqrt - comparison is same)

```typescript
function kClosest(points: number[][], k: number): number[][] {
  // Max-heap of [point, distance]
  let maxHeap = new MaxHeap<[number[], number]>((a, b) => b[1] - a[1]);

  for (let point of points) {
    let dist = point[0] ** 2 + point[1] ** 2;
    maxHeap.insert([point, dist]);

    if (maxHeap.size() > k) {
      maxHeap.extractMax();
    }
  }

  return maxHeap.toArray().map(([point, _]) => point);
}
```

Why max-heap? We want to remove the **farthest** when heap exceeds k!
```

**Right Panel (Problem)**: `heap-10` (K Closest Points to Origin)

**Next**: Item 13

---

### **ITEM 13: Ugly Number II**
**Type**: Lesson + Problem
**Duration**: 18-20 minutes

**Left Panel (Lesson)**:
```
# Advanced Heap: Multiple Streams

**Problem**: Find nth ugly number (only factors 2, 3, 5).

```
Ugly numbers: 1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15, ...

Input: n = 10
Output: 12
```

## Key Insight:
Every ugly number is 2, 3, or 5 times a previous ugly number!

Use **min-heap** + **set** to avoid duplicates:

```typescript
function nthUglyNumber(n: number): number {
  let minHeap = new MinHeap<number>();
  let seen = new Set<number>();

  minHeap.insert(1);
  seen.add(1);

  let ugly = 1;
  let factors = [2, 3, 5];

  for (let i = 0; i < n; i++) {
    ugly = minHeap.extractMin();

    for (let factor of factors) {
      let next = ugly * factor;
      if (!seen.has(next)) {
        seen.add(next);
        minHeap.insert(next);
      }
    }
  }

  return ugly;
}
```

Time: O(n log n)
Space: O(n)

This combines **Heap** + **Hash Set**!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `heap-11` (Ugly Number II)

**Next**: Item 14

---

### **ITEM 14: Smallest Range Covering Elements from K Lists**
**Type**: Problem Only
**Duration**: 20-25 minutes

**Left Panel (Problem Context)**:
```
# Challenge: K-Way Min-Max Tracking

**Problem**: Find smallest range that includes at least one number from each of k lists.

```
Input:
[
  [4, 10, 15, 24, 26],
  [0, 9, 12, 20],
  [5, 18, 22, 30]
]

Output: [20, 24]
Explanation: Contains 20 from list 2, 22 from list 3, 24 from list 1
```

## Hint:
Use min-heap + track current maximum!

1. Start with first element from each list in heap
2. Track current max
3. Range = [heap.min, current max]
4. Extract min, add next from that list
5. Update max if needed
6. Track smallest range seen

This is a **HARD** problem combining multiple heap techniques!
```

**Right Panel (Problem)**: `heap-12` (Smallest Range Covering Elements from K Lists)

**Next**: Module complete!

---

## Module Completion

After Item 14, show:

```
# 🎉 Module 10 Complete!

You've mastered:
✅ Heap fundamentals (min-heap, max-heap)
✅ Heap operations and implementation
✅ Top K problems
✅ K-way merge patterns
✅ Two heaps technique (median finding)
✅ Heap + Hash Map combinations
✅ Greedy + Heap strategies

## Key Patterns Learned:

1. **Top K**: Use heap of size k (min-heap for largest, max-heap for smallest)
2. **K-Way Merge**: Min-heap to track smallest from each stream
3. **Two Heaps**: Median maintenance with max-heap + min-heap
4. **Greedy + Heap**: Task scheduling, string reorganization
5. **Heap + Hash Map**: Top K frequent, ugly numbers

## When to Use Heaps:
- Top/Bottom K problems
- Merging K sorted arrays/lists
- Streaming data (median, Kth largest)
- Priority-based scheduling
- Interval problems

## Time Complexities:
- Insert: O(log n)
- Extract min/max: O(log n)
- Peek: O(1)
- Build heap: O(n)

## Problems Solved: 12

Next: **Module 11: Backtracking** →
```

---

## Problems Required

This module requires these problems in `/lib/content/problems/heaps.ts`:

1. `heap-1`: Kth Largest Element in an Array (MEDIUM) ⭐⭐⭐ CRITICAL
2. `heap-2`: Top K Frequent Elements (MEDIUM) ⭐⭐⭐ CRITICAL
3. `heap-3`: Kth Smallest Element in a Sorted Matrix (MEDIUM)
4. `heap-4`: Merge k Sorted Lists (HARD) ⭐⭐⭐ CRITICAL
5. `heap-5`: Find Median from Data Stream (HARD) ⭐⭐⭐ CRITICAL
6. `heap-6`: Sliding Window Maximum (HARD)
7. `heap-7`: Task Scheduler (MEDIUM) ⭐⭐⭐ CRITICAL
8. `heap-8`: Meeting Rooms II (MEDIUM) ⭐⭐⭐ CRITICAL
9. `heap-9`: Reorganize String (MEDIUM)
10. `heap-10`: K Closest Points to Origin (MEDIUM)
11. `heap-11`: Ugly Number II (MEDIUM)
12. `heap-12`: Smallest Range Covering Elements from K Lists (HARD)

---

This specification covers the critical heap patterns seen in 10-15% of FAANG interviews.
