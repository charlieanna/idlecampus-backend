# Module 7: Binary Search & Sorting

## Overview
This module teaches binary search patterns and sorting techniques through adaptive learning. Students learn to recognize when to use binary search, master its variations, and understand sorting algorithms for optimal problem-solving.

**Total Items**: 16
**Estimated Time**: 4-5 hours
**Prerequisites**: Module 1 (Arrays), Module 2 (Hash Maps)

---

## Learning Philosophy

Following the IdleCampus adaptive learning approach:
1. **Present Problem First**: User encounters the problem before seeing the pattern
2. **Detect Approach**: Analyze if user writes linear search (O(n)) or binary search (O(log n))
3. **Adaptive Branching**: Different learning paths based on user's solution
4. **Guide, Don't Give Away**: Provide hints and understanding, never the answer
5. **Brute Force → Optimization**: Help user understand WHY binary search is better

---

## Module Structure

### Part 1: Binary Search Fundamentals (Items 1-8)
- Understanding binary search
- Search variations (exact match, insert position, boundaries)
- Common pitfalls (infinite loops, off-by-one errors)

### Part 2: Advanced Binary Search (Items 9-13)
- Rotated arrays
- Peak finding
- Binary search on answer space
- 2D matrix search

### Part 3: Sorting & Combinations (Items 14-16)
- Understanding sorting algorithms
- When to sort vs use hash map
- Custom comparators

---

## Detailed Item Specifications

### **ITEM 1: Introduction to Binary Search**
**Type**: Lesson Only
**Duration**: 4 minutes

**Content**:
```
# Binary Search: The Power of Divide and Conquer

Binary search is one of the most fundamental algorithms in computer science.

## Key Concept:
**If your data is sorted, you can search in O(log n) instead of O(n).**

## The Idea:
Instead of checking every element, eliminate half the search space each step.

```
Searching for 7 in [1, 3, 5, 7, 9, 11, 13]:

Linear Search (O(n)):
Check: 1? 3? 5? 7? ✓  → 4 comparisons

Binary Search (O(log n)):
Check middle (7): Found! → 1 comparison
```

## Binary Search Pattern:

```typescript
function binarySearch(nums: number[], target: number): number {
  let left = 0;
  let right = nums.length - 1;

  while (left <= right) {
    let mid = Math.floor((left + right) / 2);

    if (nums[mid] === target) {
      return mid;  // Found!
    } else if (nums[mid] < target) {
      left = mid + 1;  // Search right half
    } else {
      right = mid - 1;  // Search left half
    }
  }

  return -1;  // Not found
}
```

## Key Points:
- **Requires sorted data**
- Time: O(log n) vs O(n)
- Space: O(1)
- **Critical**: Avoid infinite loops with correct boundary updates

## Why It Matters:
10-15% of FAANG interviews involve binary search or its variations.

Let's try your first binary search problem!
```

**Next**: Item 2

---

### **ITEM 2: First Binary Search Problem**
**Type**: Lesson + Problem
**Duration**: 8-12 minutes

**Left Panel (Lesson)**:
```
# Your First Binary Search

**Problem**: Find the index of target in a sorted array. Return -1 if not found.

```
Input: nums = [1, 3, 5, 7, 9, 11], target = 7
Output: 3

Input: nums = [1, 3, 5, 7, 9, 11], target = 4
Output: -1
```

## Think About:
- How can you avoid checking every element?
- Can you eliminate half the array each step?
- What should `left` and `right` pointers track?

Try solving this problem on the right →
```

**Right Panel (Problem)**: `binary-search-1` (Binary Search)

**Solution Analysis**:

```typescript
// OPTIMAL: Binary search O(log n)
function search(nums: number[], target: number): number {
  let left = 0;
  let right = nums.length - 1;

  while (left <= right) {
    let mid = Math.floor((left + right) / 2);

    if (nums[mid] === target) {
      return mid;
    } else if (nums[mid] < target) {
      left = mid + 1;
    } else {
      right = mid - 1;
    }
  }

  return -1;
}

// SUBOPTIMAL: Linear search O(n)
function search(nums: number[], target: number): number {
  for (let i = 0; i < nums.length; i++) {
    if (nums[i] === target) return i;
  }
  return -1;
}

// INCORRECT: Binary search with infinite loop bug
function search(nums: number[], target: number): number {
  let left = 0;
  let right = nums.length - 1;

  while (left < right) {  // Should be <=
    let mid = Math.floor((left + right) / 2);

    if (nums[mid] === target) {
      return mid;
    } else if (nums[mid] < target) {
      left = mid;  // Bug! Should be mid + 1
    } else {
      right = mid;  // Bug! Should be mid - 1
    }
  }

  return -1;
}
```

**State Machine Routing**:

```typescript
if (solution.isBinarySearch() && solution.isCorrect()) {
  // PATH A: Great! Found binary search naturally
  return "item-3-search-insert";
} else if (solution.isLinearSearch() && solution.isCorrect()) {
  // PATH B: Works but inefficient
  return "item-2a-why-binary-search";
} else if (solution.isBinarySearch() && solution.hasInfiniteLoop()) {
  // PATH C: Close! Boundary bug
  return "item-2b-boundary-fix";
} else {
  // PATH D: Need guidance
  return "item-2c-binary-search-hint";
}
```

---

### **ITEM 2A: Why Binary Search is Better**
**Type**: Lesson Only
**Duration**: 3 minutes
**Condition**: User wrote linear search

**Content**:
```
# Linear Search Works, But...

Your solution is correct:

```typescript
function search(nums: number[], target: number): number {
  for (let i = 0; i < nums.length; i++) {
    if (nums[i] === target) return i;
  }
  return -1;
}
```

✅ Correct
❌ Time: O(n) - checks every element

## Why This Matters:

**Small arrays** (n = 10):
- Linear: 10 comparisons max
- Binary: 4 comparisons max

**Large arrays** (n = 1,000,000):
- Linear: 1,000,000 comparisons max
- Binary: 20 comparisons max 🚀

## The Key Insight:
The array is **already sorted**! We can use this to our advantage.

## Binary Search Pattern:

Instead of checking every element:
1. Start with middle element
2. Too small? Search right half
3. Too large? Search left half
4. Repeat until found or search space is empty

```typescript
function search(nums: number[], target: number): number {
  let left = 0, right = nums.length - 1;

  while (left <= right) {
    let mid = Math.floor((left + right) / 2);

    if (nums[mid] === target) return mid;
    else if (nums[mid] < target) left = mid + 1;
    else right = mid - 1;
  }

  return -1;
}
```

Time: O(n) → O(log n) 🎯

Try implementing binary search!
```

**Next**: Item 2 (resubmit)

---

### **ITEM 2B: Boundary Bug Fix**
**Type**: Lesson Only
**Duration**: 3 minutes
**Condition**: User has infinite loop bug

**Content**:
```
# Binary Search Bug: Infinite Loops

Your solution has a common binary search bug:

❌ **Infinite Loop**:
```typescript
while (left < right) {  // Bug 1: Should be <=
  let mid = Math.floor((left + right) / 2);
  if (nums[mid] < target) {
    left = mid;  // Bug 2: Should be mid + 1
  } else {
    right = mid;  // Bug 3: Should be mid - 1
  }
}
```

## What Goes Wrong:

If `left = 0, right = 1, mid = 0, nums[mid] < target`:
- `left = mid` → `left = 0` (no progress!)
- Loop never ends

## The Fix:

✅ **Correct Binary Search**:
```typescript
while (left <= right) {  // ✓ Use <=
  let mid = Math.floor((left + right) / 2);

  if (nums[mid] === target) {
    return mid;
  } else if (nums[mid] < target) {
    left = mid + 1;  // ✓ Exclude mid
  } else {
    right = mid - 1;  // ✓ Exclude mid
  }
}
```

## Key Rules:
1. **While condition**: `left <= right` (check when they're equal)
2. **Update left**: `left = mid + 1` (mid already checked)
3. **Update right**: `right = mid - 1` (mid already checked)

This ensures we always make progress and never create infinite loops!

Try again with these fixes →
```

**Next**: Item 2 (resubmit)

---

### **ITEM 2C: Binary Search Hint**
**Type**: Lesson Only
**Duration**: 3 minutes
**Condition**: User didn't solve correctly

**Content**:
```
# Hint: Divide and Conquer

Think about how you'd search in a phone book:
- Don't start from page 1!
- Open to middle
- Too early? Search second half
- Too late? Search first half

## Binary Search Template:

```typescript
function search(nums: number[], target: number): number {
  let left = 0;
  let right = nums.length - 1;

  while (left <= right) {
    // Find middle
    let mid = Math.floor((left + right) / 2);

    if (nums[mid] === target) {
      return ???;  // Found it!
    } else if (nums[mid] < target) {
      // Target is in right half
      left = ???;  // How do we search right half?
    } else {
      // Target is in left half
      right = ???;  // How do we search left half?
    }
  }

  return -1;  // Not found
}
```

## Key Insights:
- `mid` is already checked, so exclude it from next search
- `left = mid + 1` means "search everything to the right of mid"
- `right = mid - 1` means "search everything to the left of mid"

Try implementing this approach →
```

**Next**: Item 2 (resubmit)

---

### **ITEM 3: Search Insert Position**
**Type**: Lesson + Problem
**Duration**: 10-12 minutes

**Left Panel (Lesson)**:
```
# Binary Search Variation: Insert Position

**Problem**: Find target index. If not found, return the index where it would be inserted.

```
Input: nums = [1, 3, 5, 7], target = 5
Output: 2  (found at index 2)

Input: nums = [1, 3, 5, 7], target = 2
Output: 1  (would be inserted between 1 and 3)

Input: nums = [1, 3, 5, 7], target = 0
Output: 0  (would be inserted at beginning)
```

## Key Insight:
When binary search **doesn't find** the target, what do `left` and `right` represent?

Think about where the search ends when target is missing.

Try solving this problem on the right →
```

**Right Panel (Problem)**: `binary-search-2` (Search Insert Position)

**Solution Analysis**:

```typescript
// OPTIMAL: Binary search returns left pointer
function searchInsert(nums: number[], target: number): number {
  let left = 0;
  let right = nums.length - 1;

  while (left <= right) {
    let mid = Math.floor((left + right) / 2);

    if (nums[mid] === target) {
      return mid;
    } else if (nums[mid] < target) {
      left = mid + 1;
    } else {
      right = mid - 1;
    }
  }

  // Key insight: left is the insert position!
  return left;
}

// SUBOPTIMAL: Linear search
function searchInsert(nums: number[], target: number): number {
  for (let i = 0; i < nums.length; i++) {
    if (nums[i] >= target) return i;
  }
  return nums.length;
}
```

**State Machine Routing**:

```typescript
if (solution.isBinarySearch() && solution.returnsLeft()) {
  return "item-4-first-last-position";
} else if (solution.isLinearSearch()) {
  return "item-3a-optimize";
} else {
  return "item-3b-hint-left-pointer";
}
```

---

### **ITEM 3A: Optimize to Binary Search**
**Type**: Lesson Only
**Duration**: 3 minutes

**Content**:
```
# From O(n) to O(log n)

Your linear search works:

```typescript
for (let i = 0; i < nums.length; i++) {
  if (nums[i] >= target) return i;
}
```

But we can use binary search!

## Key Insight:
When binary search ends without finding target:
- `left` points to where target **should be inserted**
- This is exactly what we need!

```typescript
function searchInsert(nums: number[], target: number): number {
  let left = 0, right = nums.length - 1;

  while (left <= right) {
    let mid = Math.floor((left + right) / 2);

    if (nums[mid] === target) return mid;
    else if (nums[mid] < target) left = mid + 1;
    else right = mid - 1;
  }

  return left;  // Insert position!
}
```

**Why `left`?**
- If target > all elements, `left` = `nums.length`
- If target < all elements, `left` = 0
- Otherwise, `left` is right after the last element < target

Time: O(n) → O(log n)
```

**Next**: Item 4

---

### **ITEM 3B: Hint - Left Pointer**
**Type**: Lesson Only
**Duration**: 2 minutes

**Content**:
```
# Hint: What Does Left Represent?

When binary search ends (left > right), where is the left pointer?

## Trace Through Example:
```
nums = [1, 3, 5, 7], target = 2

Initial: left=0, right=3
  mid=1, nums[1]=3 > 2 → right=0

Next: left=0, right=0
  mid=0, nums[0]=1 < 2 → left=1

Next: left=1, right=0
  left > right, exit loop

left = 1  ← Insert position!
```

## Key Insight:
`left` is always the insert position when search ends.

Try returning `left` instead of -1 when target isn't found →
```

**Next**: Item 3 (resubmit)

---

### **ITEM 4: Find First and Last Position**
**Type**: Lesson + Problem
**Duration**: 12-15 minutes

**Left Panel (Lesson)**:
```
# Binary Search Variation: Find Boundaries

**Problem**: Find the first and last occurrence of target in sorted array.

```
Input: nums = [5, 7, 7, 8, 8, 10], target = 8
Output: [3, 4]

Input: nums = [5, 7, 7, 8, 8, 10], target = 6
Output: [-1, -1]
```

## Approach:
Run binary search **twice**:
1. Find **leftmost** (first) occurrence
2. Find **rightmost** (last) occurrence

## Leftmost Binary Search:
When `nums[mid] === target`, don't return immediately!
Continue searching **left** to find first occurrence.

```typescript
function findFirst(nums: number[], target: number): number {
  let left = 0, right = nums.length - 1;
  let result = -1;

  while (left <= right) {
    let mid = Math.floor((left + right) / 2);

    if (nums[mid] === target) {
      result = mid;      // Record potential answer
      right = mid - 1;   // Keep searching left!
    } else if (nums[mid] < target) {
      left = mid + 1;
    } else {
      right = mid - 1;
    }
  }

  return result;
}
```

## Your Turn:
Implement both `findFirst` and `findLast`.

Try solving this problem on the right →
```

**Right Panel (Problem)**: `binary-search-3` (Find First and Last Position of Element in Sorted Array)

**Solution Analysis**:

```typescript
// OPTIMAL: Two binary searches O(log n)
function searchRange(nums: number[], target: number): number[] {
  function findFirst(nums: number[], target: number): number {
    let left = 0, right = nums.length - 1, result = -1;

    while (left <= right) {
      let mid = Math.floor((left + right) / 2);

      if (nums[mid] === target) {
        result = mid;
        right = mid - 1;  // Keep searching left
      } else if (nums[mid] < target) {
        left = mid + 1;
      } else {
        right = mid - 1;
      }
    }

    return result;
  }

  function findLast(nums: number[], target: number): number {
    let left = 0, right = nums.length - 1, result = -1;

    while (left <= right) {
      let mid = Math.floor((left + right) / 2);

      if (nums[mid] === target) {
        result = mid;
        left = mid + 1;  // Keep searching right
      } else if (nums[mid] < target) {
        left = mid + 1;
      } else {
        right = mid - 1;
      }
    }

    return result;
  }

  return [findFirst(nums, target), findLast(nums, target)];
}

// SUBOPTIMAL: Find one, then expand O(n) worst case
function searchRange(nums: number[], target: number): number[] {
  // Find any occurrence with binary search
  let idx = binarySearch(nums, target);
  if (idx === -1) return [-1, -1];

  // Expand left and right (O(n) if all elements are target!)
  let left = idx, right = idx;
  while (left > 0 && nums[left - 1] === target) left--;
  while (right < nums.length - 1 && nums[right + 1] === target) right++;

  return [left, right];
}
```

**Next**: Item 5

---

### **ITEM 5: Find Peak Element**
**Type**: Lesson + Problem
**Duration**: 12-15 minutes

**Left Panel (Lesson)**:
```
# Binary Search on Unsorted Data

**Problem**: Find a peak element (greater than its neighbors).

```
Input: nums = [1, 2, 3, 1]
Output: 2  (index 2, value is 3)

Input: nums = [1, 2, 1, 3, 5, 6, 4]
Output: 5  (index 5, value is 6)
```

## Key Insight:
**You can use binary search even when the array isn't sorted!**

The trick: Use binary search to find the direction of increase.

## Logic:
```
At mid:
- If nums[mid] < nums[mid + 1]: Peak is on the right
- If nums[mid] > nums[mid + 1]: Peak is on the left (or mid itself)
```

## Why This Works:
- If we move towards increasing values, we must hit a peak eventually
- Array edges are treated as -∞

Try solving this problem on the right →
```

**Right Panel (Problem)**: `binary-search-4` (Find Peak Element)

**Solution Analysis**:

```typescript
// OPTIMAL: Binary search O(log n)
function findPeakElement(nums: number[]): number {
  let left = 0;
  let right = nums.length - 1;

  while (left < right) {
    let mid = Math.floor((left + right) / 2);

    if (nums[mid] < nums[mid + 1]) {
      // Peak is on the right
      left = mid + 1;
    } else {
      // Peak is on the left (or at mid)
      right = mid;
    }
  }

  return left;  // left === right at a peak
}

// SUBOPTIMAL: Linear scan O(n)
function findPeakElement(nums: number[]): number {
  for (let i = 0; i < nums.length - 1; i++) {
    if (nums[i] > nums[i + 1]) {
      return i;
    }
  }
  return nums.length - 1;
}
```

**Next**: Item 6

---

### **ITEM 6: Search in Rotated Sorted Array**
**Type**: Lesson + Problem
**Duration**: 15-18 minutes

**Left Panel (Lesson)**:
```
# Binary Search on Rotated Array

**Problem**: Array was sorted, then rotated. Find target in O(log n).

```
Original: [0, 1, 2, 4, 5, 6, 7]
Rotated:  [4, 5, 6, 7, 0, 1, 2]  (rotated at index 4)

Target: 0
Output: 4
```

## Key Insight:
After rotation, **at least one half is always sorted**.

```
[4, 5, 6, 7, 0, 1, 2]
 ^        ^        ^
 L       mid       R

Left half [4, 5, 6, 7]: sorted ✓
Right half [0, 1, 2]: sorted ✓
```

## Algorithm:
1. Find which half is sorted
2. Check if target is in the sorted half
3. If yes, search that half
4. If no, search the other half

```typescript
if (nums[left] <= nums[mid]) {
  // Left half is sorted
  if (target >= nums[left] && target < nums[mid]) {
    // Target in sorted left half
    right = mid - 1;
  } else {
    // Target in right half
    left = mid + 1;
  }
} else {
  // Right half is sorted
  // Similar logic...
}
```

This is tricky! Try solving it on the right →
```

**Right Panel (Problem)**: `binary-search-5` (Search in Rotated Sorted Array)

**Solution Analysis**:

```typescript
// OPTIMAL: Binary search O(log n)
function search(nums: number[], target: number): number {
  let left = 0;
  let right = nums.length - 1;

  while (left <= right) {
    let mid = Math.floor((left + right) / 2);

    if (nums[mid] === target) return mid;

    // Determine which half is sorted
    if (nums[left] <= nums[mid]) {
      // Left half is sorted
      if (target >= nums[left] && target < nums[mid]) {
        right = mid - 1;  // Target in sorted left half
      } else {
        left = mid + 1;   // Target in right half
      }
    } else {
      // Right half is sorted
      if (target > nums[mid] && target <= nums[right]) {
        left = mid + 1;   // Target in sorted right half
      } else {
        right = mid - 1;  // Target in left half
      }
    }
  }

  return -1;
}

// SUBOPTIMAL: Linear search O(n)
function search(nums: number[], target: number): number {
  return nums.indexOf(target);
}
```

**State Machine Routing**:

```typescript
if (solution.isBinarySearch() && solution.handlesRotation()) {
  return "item-7-minimum-rotated";
} else if (solution.isLinearSearch()) {
  return "item-6a-optimize-rotation";
} else {
  return "item-6b-rotation-hint";
}
```

---

### **ITEM 6A: Optimizing Rotated Search**
**Type**: Lesson Only
**Duration**: 4 minutes

**Content**:
```
# From O(n) to O(log n) on Rotated Array

Your linear search works but doesn't use the sorted property:

```typescript
return nums.indexOf(target);  // O(n)
```

## Key Insight:
**At least one half is always sorted** after rotation.

```
[4, 5, 6, 7, 0, 1, 2]
 L        M        R

Left [4,5,6,7]: sorted (nums[L] <= nums[M])
Right [0,1,2]: also sorted
```

## Binary Search Logic:

```typescript
while (left <= right) {
  let mid = Math.floor((left + right) / 2);

  if (nums[mid] === target) return mid;

  // Which half is sorted?
  if (nums[left] <= nums[mid]) {
    // Left is sorted: can we eliminate it?
    if (target >= nums[left] && target < nums[mid]) {
      right = mid - 1;  // Target in left
    } else {
      left = mid + 1;   // Target in right
    }
  } else {
    // Right is sorted: can we eliminate it?
    if (target > nums[mid] && target <= nums[right]) {
      left = mid + 1;   // Target in right
    } else {
      right = mid - 1;  // Target in left
    }
  }
}
```

Time: O(n) → O(log n)

Try implementing this approach →
```

**Next**: Item 7

---

### **ITEM 6B: Rotation Hint**
**Type**: Lesson Only
**Duration**: 3 minutes

**Content**:
```
# Hint: One Half is Always Sorted

After rotation, look at any split:

```
[4, 5, 6, 7, 0, 1, 2]
 L        M        R
```

Compare `nums[L]` and `nums[M]`:
- If `nums[L] <= nums[M]`: **Left half is sorted** [4,5,6,7]
- Otherwise: **Right half is sorted** [0,1,2]

## Once You Know Which Half is Sorted:
Check if target is in the sorted half's range:
- Yes? Search that half
- No? Search the other half

## Template:
```typescript
if (nums[left] <= nums[mid]) {
  // Left half [left...mid] is sorted
  if (target >= nums[left] && target < nums[mid]) {
    // Target in sorted range
    right = mid - 1;
  } else {
    left = mid + 1;
  }
} else {
  // Right half [mid...right] is sorted
  // Similar logic
}
```

Try implementing this approach →
```

**Next**: Item 6 (resubmit)

---

### **ITEM 7: Find Minimum in Rotated Sorted Array**
**Type**: Problem Only
**Duration**: 10-12 minutes

**Left Panel (Problem Context)**:
```
# Practice: Find Minimum in Rotated Array

Now that you understand rotated arrays, try this variation:

**Problem**: Find the minimum element in a rotated sorted array.

```
Input: [3, 4, 5, 1, 2]
Output: 1

Input: [4, 5, 6, 7, 0, 1, 2]
Output: 0

Input: [11, 13, 15, 17]  (not rotated)
Output: 11
```

## Hint:
The minimum is at the "rotation point" where `nums[i] < nums[i-1]`.

Can you use binary search to find it in O(log n)?
```

**Right Panel (Problem)**: `binary-search-6` (Find Minimum in Rotated Sorted Array)

**Next**: Item 8

---

### **ITEM 8: Sqrt(x)**
**Type**: Lesson + Problem
**Duration**: 10-12 minutes

**Left Panel (Lesson)**:
```
# Binary Search on Answer Space

**Problem**: Implement `sqrt(x)` without using built-in functions. Return integer part.

```
Input: 8
Output: 2  (sqrt(8) = 2.828..., return 2)

Input: 4
Output: 2  (sqrt(4) = 2.000)
```

## Key Insight:
**Binary search doesn't require a sorted array!**

You can binary search on the **answer space** (possible answers).

## Logic:
For `sqrt(x)`, answer is in range `[0, x]`.
- Try middle value `mid`
- If `mid * mid === x`: found exact answer
- If `mid * mid < x`: answer is `mid` or higher
- If `mid * mid > x`: answer is lower than `mid`

```typescript
function mySqrt(x: number): number {
  let left = 0, right = x;

  while (left <= right) {
    let mid = Math.floor((left + right) / 2);
    let square = mid * mid;

    if (square === x) return mid;
    else if (square < x) left = mid + 1;
    else right = mid - 1;
  }

  return right;  // Floor of sqrt
}
```

This pattern works for many "find the answer" problems!

Try solving it on the right →
```

**Right Panel (Problem)**: `binary-search-7` (Sqrt(x))

**Next**: Item 9

---

### **ITEM 9: Koko Eating Bananas**
**Type**: Lesson + Problem
**Duration**: 15-18 minutes

**Left Panel (Lesson)**:
```
# Advanced: Binary Search on Answer

**Problem**: Koko can eat K bananas per hour. What's the minimum K to finish all piles in H hours?

```
Input: piles = [3, 6, 7, 11], h = 8
Output: 4

Explanation:
- At speed 4: takes 1 + 2 + 2 + 3 = 8 hours ✓
- At speed 3: takes 1 + 2 + 3 + 4 = 10 hours ✗
```

## Key Insight:
Binary search on the **eating speed K** (answer space).

## Logic:
- Minimum K: 1 banana/hour
- Maximum K: max(piles) bananas/hour
- For each K, calculate time needed
- Find minimum K where time <= H

```typescript
function minEatingSpeed(piles: number[], h: number): number {
  function canFinish(k: number): boolean {
    let hours = 0;
    for (let pile of piles) {
      hours += Math.ceil(pile / k);
    }
    return hours <= h;
  }

  let left = 1;
  let right = Math.max(...piles);

  while (left < right) {
    let mid = Math.floor((left + right) / 2);

    if (canFinish(mid)) {
      right = mid;  // Try slower speed
    } else {
      left = mid + 1;  // Need faster speed
    }
  }

  return left;
}
```

This is a **very common FAANG interview pattern**!

Try solving it on the right →
```

**Right Panel (Problem)**: `binary-search-8` (Koko Eating Bananas)

**Next**: Item 10

---

### **ITEM 10: Search 2D Matrix**
**Type**: Lesson + Problem
**Duration**: 10-12 minutes

**Left Panel (Lesson)**:
```
# Binary Search on 2D Matrix

**Problem**: Search in a 2D matrix where:
- Each row is sorted
- First element of each row > last element of previous row

```
Matrix:
[
  [1,  3,  5,  7],
  [10, 11, 16, 20],
  [23, 30, 34, 60]
]

Target: 3
Output: true
```

## Key Insight:
This matrix is essentially a **sorted 1D array** reshaped into 2D!

```
1D view: [1, 3, 5, 7, 10, 11, 16, 20, 23, 30, 34, 60]
```

## Approach:
Binary search treating it as 1D array:
- Convert 1D index to 2D: `row = idx / cols`, `col = idx % cols`

```typescript
function searchMatrix(matrix: number[][], target: number): boolean {
  let rows = matrix.length;
  let cols = matrix[0].length;

  let left = 0;
  let right = rows * cols - 1;

  while (left <= right) {
    let mid = Math.floor((left + right) / 2);
    let row = Math.floor(mid / cols);
    let col = mid % cols;
    let value = matrix[row][col];

    if (value === target) return true;
    else if (value < target) left = mid + 1;
    else right = mid - 1;
  }

  return false;
}
```

Try solving it on the right →
```

**Right Panel (Problem)**: `binary-search-9` (Search a 2D Matrix)

**Next**: Item 11

---

### **ITEM 11: Search 2D Matrix II**
**Type**: Problem Only
**Duration**: 12-15 minutes

**Left Panel (Problem Context)**:
```
# Practice: Search 2D Matrix II

A harder variation:

**Problem**: Search in a 2D matrix where:
- Each row is sorted left to right
- Each column is sorted top to bottom
- **BUT rows are NOT fully sorted relative to each other**

```
Matrix:
[
  [1,  4,  7,  11, 15],
  [2,  5,  8,  12, 19],
  [3,  6,  9,  16, 22],
  [10, 13, 14, 17, 24],
  [18, 21, 23, 26, 30]
]

Target: 5
Output: true
```

## Hint:
Start from **top-right** or **bottom-left** corner.
Why? These positions have a useful property for elimination!

Top-right (15):
- Everything below is larger
- Everything left is smaller

You can eliminate a row or column each step!
```

**Right Panel (Problem)**: `binary-search-10` (Search a 2D Matrix II)

**Next**: Item 12

---

### **ITEM 12: Time-Based Key-Value Store**
**Type**: Lesson + Problem
**Duration**: 15-20 minutes

**Left Panel (Lesson)**:
```
# Binary Search + Hash Map Combination

**Problem**: Implement a time-based key-value store.

```
set("foo", "bar", timestamp=1)
set("foo", "bar2", timestamp=4)

get("foo", timestamp=1)  → "bar"
get("foo", timestamp=3)  → "bar"  (latest <= 3)
get("foo", timestamp=4)  → "bar2"
get("foo", timestamp=5)  → "bar2" (latest <= 5)
```

## Data Structure:
```typescript
{
  "foo": [
    {value: "bar", timestamp: 1},
    {value: "bar2", timestamp: 4}
  ]
}
```

## Get Logic:
For each key, timestamps are sorted (set in order).
Use **binary search** to find largest timestamp <= target!

```typescript
class TimeMap {
  private store: Map<string, Array<{value: string, timestamp: number}>>;

  get(key: string, timestamp: number): string {
    if (!this.store.has(key)) return "";

    let values = this.store.get(key)!;

    // Binary search for largest timestamp <= target
    let left = 0, right = values.length - 1;
    let result = "";

    while (left <= right) {
      let mid = Math.floor((left + right) / 2);

      if (values[mid].timestamp <= timestamp) {
        result = values[mid].value;
        left = mid + 1;  // Try to find later timestamp
      } else {
        right = mid - 1;
      }
    }

    return result;
  }
}
```

This combines **hash maps** (Module 2) with **binary search** (this module)!

Try solving it on the right →
```

**Right Panel (Problem)**: `binary-search-11` (Time Based Key-Value Store)

**Next**: Item 13

---

### **ITEM 13: Median of Two Sorted Arrays**
**Type**: Problem Only
**Duration**: 20-25 minutes

**Left Panel (Problem Context)**:
```
# Challenge: Median of Two Sorted Arrays

This is a **HARD** problem that uses advanced binary search.

**Problem**: Find median of two sorted arrays in O(log(m+n)) time.

```
Input: nums1 = [1, 3], nums2 = [2]
Output: 2.0

Input: nums1 = [1, 2], nums2 = [3, 4]
Output: 2.5  (average of 2 and 3)
```

## Hint:
Use binary search to find the correct **partition** of both arrays.

The partition divides arrays so:
- Left side has (m+n)/2 elements
- max(left side) <= min(right side)

This is one of the most challenging binary search problems!
```

**Right Panel (Problem)**: `binary-search-12` (Median of Two Sorted Arrays)

**Next**: Item 14

---

### **ITEM 14: Understanding Sorting**
**Type**: Lesson Only
**Duration**: 5 minutes

**Content**:
```
# Sorting: When and Why

Welcome to Part 3! Let's understand when to sort vs use other approaches.

## Common Sorting Algorithms:

**Quick Sort**: O(n log n) average, O(n²) worst
- Built-in `Array.sort()` uses this (or similar)
- In-place, unstable

**Merge Sort**: O(n log n) guaranteed
- Stable sort
- Requires O(n) extra space

**Heap Sort**: O(n log n)
- In-place
- Useful when you only need top K elements

## When to Sort:

✅ **Sort first** when:
- Finding duplicates/duplicates check
- Finding kth largest/smallest
- Merging intervals
- Two-pointer problems with sorted constraint

❌ **Don't sort** when:
- Hash map can solve in O(n)
- Relative order matters (stable vs unstable)
- Modifying original array is bad

## Classic Decision:

**Problem**: Find if array has duplicate.

Option 1: Sort then check neighbors - O(n log n)
Option 2: Use hash set - O(n) ✓ Better!

**Problem**: Find kth largest element.

Option 1: Sort entire array - O(n log n)
Option 2: Use quickselect - O(n) ✓ Better!
Option 3: Use min-heap of size k - O(n log k) ✓ If k is small

Let's practice!
```

**Next**: Item 15

---

### **ITEM 15: Merge Intervals**
**Type**: Lesson + Problem
**Duration**: 12-15 minutes

**Left Panel (Lesson)**:
```
# Sorting Strategy: Merge Intervals

**Problem**: Merge overlapping intervals.

```
Input: [[1,3], [2,6], [8,10], [15,18]]
Output: [[1,6], [8,10], [15,18]]

Explanation: [1,3] and [2,6] overlap → merge to [1,6]
```

## Key Insight:
**Sort by start time**, then merge linearly!

## Algorithm:
```typescript
function merge(intervals: number[][]): number[][] {
  // Sort by start time
  intervals.sort((a, b) => a[0] - b[0]);

  let result: number[][] = [intervals[0]];

  for (let i = 1; i < intervals.length; i++) {
    let current = intervals[i];
    let last = result[result.length - 1];

    if (current[0] <= last[1]) {
      // Overlapping: merge
      last[1] = Math.max(last[1], current[1]);
    } else {
      // Not overlapping: add new
      result.push(current);
    }
  }

  return result;
}
```

Time: O(n log n) for sorting + O(n) for merging = **O(n log n)**

Try solving it on the right →
```

**Right Panel (Problem)**: `sorting-1` (Merge Intervals)

**Next**: Item 16

---

### **ITEM 16: Largest Number**
**Type**: Lesson + Problem
**Duration**: 12-15 minutes

**Left Panel (Lesson)**:
```
# Custom Comparators

**Problem**: Arrange numbers to form the largest number.

```
Input: [3, 30, 34, 5, 9]
Output: "9534330"

Why? 9-5-34-3-30 forms larger number than other arrangements.
```

## Key Insight:
Sort with **custom comparator**!

Compare concatenations:
- "3" + "30" = "330"
- "30" + "3" = "303"
- "330" > "303" → "3" should come before "30"

## Custom Sort:

```typescript
function largestNumber(nums: number[]): string {
  // Convert to strings
  let strs = nums.map(n => String(n));

  // Custom comparator: which concatenation is larger?
  strs.sort((a, b) => {
    let ab = a + b;
    let ba = b + a;
    return ba.localeCompare(ab);  // Descending order
  });

  // Edge case: all zeros
  if (strs[0] === "0") return "0";

  return strs.join("");
}
```

Time: O(n log n) with custom comparator

Try solving it on the right →
```

**Right Panel (Problem)**: `sorting-2` (Largest Number)

**Next**: Module complete!

---

## Module Completion

After Item 16, show:

```
# 🎉 Module 7 Complete!

You've mastered:
✅ Binary search fundamentals
✅ Binary search variations (boundaries, peaks, rotation)
✅ Binary search on answer space
✅ 2D matrix searching
✅ Sorting strategies and custom comparators
✅ Combining binary search with hash maps

## Key Patterns Learned:

1. **Standard Binary Search**: O(log n) search on sorted array
2. **Finding Boundaries**: Leftmost/rightmost occurrence
3. **Rotated Arrays**: One half is always sorted
4. **Answer Space Search**: Binary search on possible answers
5. **Sort vs Hash Map**: When to use which approach

## Time Complexities Mastered:
- Linear search: O(n) → Binary search: O(log n)
- Sorting overhead: O(n log n)
- Binary search on answer: O(log n * validation time)

## Problems Solved: 16

Next: **Module 8: Graphs & BFS/DFS** →
```

---

## Problems Required

This module requires these problems to exist in `/lib/content/problems/binarySearch.ts` and `/lib/content/problems/sorting.ts`:

### Binary Search:
1. `binary-search-1`: Binary Search (EASY)
2. `binary-search-2`: Search Insert Position (EASY)
3. `binary-search-3`: Find First and Last Position (MEDIUM)
4. `binary-search-4`: Find Peak Element (MEDIUM)
5. `binary-search-5`: Search in Rotated Sorted Array (MEDIUM) ⭐⭐⭐ CRITICAL
6. `binary-search-6`: Find Minimum in Rotated Sorted Array (MEDIUM)
7. `binary-search-7`: Sqrt(x) (EASY)
8. `binary-search-8`: Koko Eating Bananas (MEDIUM) ⭐⭐⭐ CRITICAL
9. `binary-search-9`: Search a 2D Matrix (MEDIUM)
10. `binary-search-10`: Search a 2D Matrix II (MEDIUM)
11. `binary-search-11`: Time Based Key-Value Store (MEDIUM) ⭐⭐⭐ CRITICAL
12. `binary-search-12`: Median of Two Sorted Arrays (HARD) ⭐⭐⭐ CRITICAL

### Sorting:
1. `sorting-1`: Merge Intervals (MEDIUM) ⭐⭐⭐ CRITICAL
2. `sorting-2`: Largest Number (MEDIUM)

---

## State Machine Summary

```typescript
// Item 2: First binary search
if (binarySearch && correct) → Item 3
else if (linearSearch && correct) → Item 2A (why binary search) → Item 2 (retry)
else if (binarySearch && infiniteLoop) → Item 2B (boundary fix) → Item 2 (retry)
else → Item 2C (hint) → Item 2 (retry)

// Item 3: Search insert position
if (binarySearch && returnsLeft) → Item 4
else if (linearSearch) → Item 3A (optimize) → Item 4
else → Item 3B (hint) → Item 3 (retry)

// Item 6: Rotated array
if (binarySearch && handlesRotation) → Item 7
else if (linearSearch) → Item 6A (optimize) → Item 7
else → Item 6B (hint) → Item 6 (retry)
```

---

This specification follows the adaptive learning pattern and prepares students for binary search problems appearing in 10-15% of FAANG interviews.
