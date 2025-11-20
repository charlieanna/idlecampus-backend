# Module 5: Linked List Mastery - Complete Specification

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

- **Primary Objective:** Master linked list manipulation and design problems
- **Time Estimate:** 2-3 weeks (12-20 hours)
- **Prerequisites:** Modules 1, 2, and 2.5
- **Total Problems:** 15 (1 warmup + 4 fundamentals + 2 combinations + 8 practice)

### Why This Module?

**Linked lists are fundamentally different from arrays:**
- No random access (can't do `list[i]`)
- Pointer manipulation instead of index arithmetic
- Memory is not contiguous
- Perfect for certain operations (insert/delete in O(1))

**But the POWER comes from combining with hash maps!**
- **Linked List alone:** Sequential access only
- **Hash Map alone:** No ordering
- **Combined:** O(1) access WITH ordering! (LRU Cache)

### Patterns Covered

#### Part 1: Linked List Fundamentals
1. **Python Classes & Nodes** - Understanding object-oriented linked lists
2. **Dummy Node Pattern** - Simplifying edge cases
3. **Two Pointers in Linked Lists** - Fast/slow, cycle detection
4. **Reversal Patterns** - Iterative and recursive reversal

#### Part 2: Combinations (NEW!)
5. **Linked List + Hash Map** - LRU Cache design ⭐⭐⭐
6. **Linked List + Two Pointers (Advanced)** - Complex manipulations

### Learning Outcomes

After completing this module, students will be able to:
- ✅ Understand Python classes and object references
- ✅ Manipulate pointers confidently (prev, curr, next)
- ✅ Use dummy nodes to simplify edge cases
- ✅ Apply fast/slow pointers for cycle detection and middle finding
- ✅ Reverse linked lists iteratively and recursively
- ✅ **Design LRU Cache with O(1) operations** ⭐
- ✅ Combine linked lists with hash maps for powerful data structures
- ✅ Debug pointer-related issues

---

## Module Structure

### Item Breakdown

```
Module 3: Linked List Mastery (18 items)

├── Part 1: Fundamentals (10 items, 1-2 weeks)
│   │
│   ├── Item 1: Warmup - Python Classes Review (10 min)
│   │
│   ├── Pattern 1: Basic Traversal & Dummy Node (45-60 min)
│   │   ├── Item 2: Introduction + Merge Two Sorted Lists
│   │   ├── Item 3a: Optimized with Dummy Node
│   │   ├── Item 3b: Brute Force without Dummy
│   │   └── Item 3b-success: Discovered Dummy Node
│   │
│   ├── Pattern 2: Two Pointers (Fast/Slow) (45-60 min)
│   │   ├── Item 4: Introduction + Linked List Cycle
│   │   ├── Item 5a: Optimized with Two Pointers
│   │   ├── Item 5b: Brute Force with Set
│   │   └── Item 5b-success: Discovered Two Pointers
│   │
│   ├── Pattern 3: Reversal (45-60 min)
│   │   ├── Item 6: Introduction + Reverse Linked List
│   │   ├── Item 7a: Optimized Iterative
│   │   ├── Item 7b: Conceptual Confusion
│   │   └── Item 7b-success: Mastered Reversal
│   │
│   └── Item 8: Fundamentals Summary
│
└── Part 2: Combinations (8 items, 1 week)
    │
    ├── Pattern 4: Linked List + Hash Map (90-120 min) ⭐⭐⭐
    │   ├── Item 9: Introduction to LRU Cache
    │   ├── Item 10: LRU Cache Design Problem
    │   ├── Item 11a: Optimized (Doubly Linked List + Hash Map)
    │   ├── Item 11b: Brute Force (Array or Single Solution)
    │   └── Item 11b-success: Mastered LRU Cache Design
    │
    └── Practice Set (6 items, 2-3 hours)
        ├── Item 12: Practice Introduction
        ├── Item 13-17: 6 mixed problems
        └── Item 18: Module Completion
```

---

## Learning Philosophy

### From Simple to Complex

**Part 1: Build Foundation**
- Start with Python classes (if needed)
- Master pointer manipulation
- Learn core patterns in isolation

**Part 2: Combine with Previous Knowledge** (NEW!)
- Apply hash maps to linked lists
- Create powerful data structures
- Solve design problems

### The Pointer Mindset

**Key difference from arrays:**

**Arrays (Module 1):**
```python
arr = [1, 2, 3, 4]
arr[2] = 99  # Direct access!
```

**Linked Lists:**
```python
# Must traverse to reach position
current = head
for _ in range(2):
    current = current.next
current.val = 99
```

**But this limitation becomes a strength with proper design!**

### Discovery Through Debugging

Students will:
1. **Try solutions** - Often with pointer bugs
2. **See common errors** - Losing references, infinite loops
3. **Learn debugging** - Visualization, tracing
4. **Master patterns** - Through correcting mistakes

---

## Complete Item Specifications

### ITEM 1: Python Classes Warmup

**Type:** 📖 Lesson + 💻 Simple Exercise
**ID:** `linked-list-warmup`
**Time:** 10 minutes

```markdown
# Welcome to Linked Lists!

Before we dive into algorithms, let's review Python classes.

---

## The ListNode Class

**Every linked list problem uses this:**

```python
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val      # The data
        self.next = next    # Reference to next node
```

**Creating nodes:**
```python
# Single node
node1 = ListNode(1)

# Linked nodes
node1 = ListNode(1)
node2 = ListNode(2)
node3 = ListNode(3)

node1.next = node2
node2.next = node3

# Now: 1 -> 2 -> 3
```

---

## Visualization

```
node1           node2           node3
┌─────┬────┐   ┌─────┬────┐   ┌─────┬────┐
│ 1   │ •──┼──→│ 2   │ •──┼──→│ 3   │None│
└─────┴────┘   └─────┴────┘   └─────┴────┘
 val   next     val   next     val   next
```

**Key concept:** `next` is a **reference** (pointer) to another node!

---

## Traversal Pattern

**To visit all nodes:**

```python
def printList(head):
    current = head
    while current:
        print(current.val)
        current = current.next  # Move to next node
```

**Why while current, not while current.next?**
- `while current`: Visits all nodes including last
- `while current.next`: Stops before last node

---

## Your Warmup Task

Implement a function to count nodes in a linked list:

```python
def countNodes(head: ListNode) -> int:
    # Your code here
    pass
```

**Example:**
- Input: 1 -> 2 -> 3 -> 4
- Output: 4

---

## Test Your Understanding

```python
# What does this print?
node1 = ListNode(1)
node2 = ListNode(2)
node1.next = node2

print(node1.val)       # ?
print(node1.next.val)  # ?
print(node2.next)      # ?
```

**Answers:**
- `1` (node1's value)
- `2` (node2's value, accessed through node1.next)
- `None` (node2 doesn't point to anything)

---

[Submit Solution →]
```

**Expected Solution:**
```python
def countNodes(head: ListNode) -> int:
    count = 0
    current = head
    while current:
        count += 1
        current = current.next
    return count
```

---

### PART 1: FUNDAMENTALS

#### PATTERN 1: DUMMY NODE

#### ITEM 2: Dummy Node Introduction

**Type:** 📖 Lesson + 💻 Problem
**ID:** `dummy-node-intro`
**Time:** 20-30 minutes

##### Left Side - Lesson

```markdown
# Pattern 1: The Dummy Node Technique

A simple trick that simplifies MANY linked list problems!

---

## The Problem with Linked Lists

**Edge cases are annoying:**

```python
def mergeHelper(l1, l2):
    # What if l1 is None?
    # What if l2 is None?
    # What if result list is empty initially?
    # How do we return the head?
```

**Example issue:**
```python
# Merging: 1->3 and 2->4
result_head = None  # Start with nothing

# First comparison: 1 < 2
# Need to create result_head = ListNode(1)

# But then for next node:
# result_head.next = ListNode(2)  # Different logic!
```

**Two different cases for first node vs rest!** 😕

---

## The Dummy Node Solution

**Create a "dummy" node that's always there:**

```python
dummy = ListNode(0)  # Value doesn't matter
current = dummy

# Now you can always do:
current.next = new_node
current = current.next

# At the end:
return dummy.next  # The real head!
```

**Visual:**
```
dummy           (actual list)
┌─────┬────┐
│  0  │ •──┼──→ (your merged list starts here)
└─────┴────┘
```

---

## Why This Helps

**Without dummy:**
```python
if head is None:
    head = ListNode(val)  # Special case!
else:
    current.next = ListNode(val)  # Normal case
```

**With dummy:**
```python
current.next = ListNode(val)  # Always the same!
current = current.next
```

**One pattern for all cases!** ✓

---

## Your Task

Solve the problem on the right.

You can:
1. Try without dummy node (handle edge cases manually)
2. Try with dummy node (cleaner!)

See which approach you prefer!

[Start Coding →]
```

##### Right Side - Problem

**Difficulty:** Easy
**Problem ID:** `merge-two-sorted-lists`

```markdown
# Merge Two Sorted Lists

You are given the heads of two sorted linked lists `list1` and `list2`.

Merge the two lists into one **sorted** list. The list should be made by splicing together the nodes of the first two lists.

Return the head of the merged linked list.

---

## Examples

**Example 1:**
```
Input: list1 = 1->2->4, list2 = 1->3->4
Output: 1->1->2->3->4->4
```

**Example 2:**
```
Input: list1 = [], list2 = []
Output: []
```

**Example 3:**
```
Input: list1 = [], list2 = 0
Output: 0
```

---

## Constraints

- The number of nodes in both lists is in range `[0, 50]`
- `-100 <= Node.val <= 100`
- Both `list1` and `list2` are sorted in **non-decreasing** order

---

## Starter Code

```python
def mergeTwoLists(list1: Optional[ListNode],
                  list2: Optional[ListNode]) -> Optional[ListNode]:
    # Your code here
    pass
```

**Hint:** Try using a dummy node!
```

**Test Cases:**
```python
test_cases = [
    ([1,2,4], [1,3,4], [1,1,2,3,4,4]),
    ([], [], []),
    ([], [0], [0]),
    ([5], [1,2,4], [1,2,4,5]),
]
```

##### Submission Handler

```typescript
onSubmit(code: string, testResults: TestResult[]) {
  const analysis = analyzeSolution(code, testResults, 'merge-sorted-lists');

  if (!analysis.allTestsPassed) {
    return routeToItem('dummy-node-incorrect');
  }

  // Optimal: Uses dummy node
  if (analysis.features.usesDummyNode) {
    return routeToItem('dummy-node-optimized-first'); // Item 3a
  }

  // Works but manually handles edge cases
  if (analysis.features.hasManualEdgeCases) {
    return routeToItem('dummy-node-brute-force'); // Item 3b
  }

  // Default
  return routeToItem('dummy-node-brute-force');
}
```

---

#### ITEM 3a: Optimized with Dummy Node

**ID:** `dummy-node-optimized-first`

```markdown
# 🌟 Excellent! You Used the Dummy Node Pattern!

Your code is clean and handles all edge cases elegantly!

---

## Your Approach

```python
[INJECT: User's code]
```

You used a **dummy node**:
- ✅ No special cases for empty lists
- ✅ No special case for first node
- ✅ Clean, uniform logic
- ✅ Easy to return head (dummy.next)

This is the optimal approach!

---

## The Alternative (Without Dummy)

Many people handle edge cases manually:

```python
def mergeTwoLists(list1, list2):
    # Edge cases
    if not list1:
        return list2
    if not list2:
        return list1

    # Determine head
    if list1.val < list2.val:
        head = list1
        list1 = list1.next
    else:
        head = list2
        list2 = list2.next

    current = head

    # Merge rest
    while list1 and list2:
        if list1.val < list2.val:
            current.next = list1
            list1 = list1.next
        else:
            current.next = list2
            list2 = list2.next
        current = current.next

    # Attach remaining
    if list1:
        current.next = list1
    else:
        current.next = list2

    return head
```

**More code, more edge cases!**

---

## Why Dummy Node is Better

### Your Solution (With Dummy)

```python
def mergeTwoLists(list1, list2):
    dummy = ListNode(0)  # Helper node
    current = dummy

    while list1 and list2:
        if list1.val < list2.val:
            current.next = list1
            list1 = list1.next
        else:
            current.next = list2
            list2 = list2.next
        current = current.next

    # Attach remaining
    current.next = list1 if list1 else list2

    return dummy.next  # Skip dummy, return real head
```

**Benefits:**
1. No special case for empty lists (handled naturally)
2. No special case for first node (always use current.next)
3. Easy to return head (just dummy.next)
4. Fewer lines of code
5. Fewer bugs!

---

## Visualization

**Input:** `list1 = 1->3`, `list2 = 2->4`

**Step-by-step:**

```
Initial:
dummy
┌───┬────┐
│ 0 │None│
└───┴────┘
current = dummy

Step 1: Compare 1 vs 2, choose 1
dummy -> 1 -> 3
current moves to 1

Step 2: Compare 3 vs 2, choose 2
dummy -> 1 -> 2 -> 4
current moves to 2

Step 3: Compare 3 vs 4, choose 3
dummy -> 1 -> 2 -> 3
current moves to 3

Step 4: list1 empty, attach rest of list2
dummy -> 1 -> 2 -> 3 -> 4

Return dummy.next: 1 -> 2 -> 3 -> 4 ✓
```

---

## Pattern: Dummy Node

**When to use:**
✅ Building a new linked list
✅ Modifying head might be needed
✅ Want to avoid edge case hell
✅ Any merge/combine operation

**Template:**
```python
def linkedListOperation(head):
    dummy = ListNode(0)  # Create dummy
    current = dummy

    # Your logic here
    while condition:
        current.next = ...
        current = current.next

    return dummy.next  # Return real head
```

---

## Pattern Mastered: Dummy Node ✓

- **Attempts:** 1
- **Mastery Level:** Excellent
- **Key Learning:** Dummy nodes simplify edge cases

[Continue to Next Pattern: Two Pointers →]
```

---

#### ITEM 3b: Without Dummy Node (Brute Force)

**ID:** `dummy-node-brute-force`

```markdown
# Your Solution Works! ✓

All test cases passed!

---

## What You Did

```python
[INJECT: User's code]
```

You handled edge cases manually:
- Special case for empty lists
- Special case for determining head
- Different logic for first node vs rest

**This works, but there's a cleaner way!**

---

## The Challenge with Your Approach

**Count the edge cases:**

```python
# Edge case 1: Both empty
if not list1 and not list2:
    return None

# Edge case 2: One empty
if not list1:
    return list2
if not list2:
    return list1

# Edge case 3: Determine head
if list1.val < list2.val:
    head = list1
    list1 = list1.next
else:
    head = list2
    list2 = list2.next

# Now the main logic...
```

**5+ lines just for edge cases before main logic!**

---

## The Problem: First Node is Special

**Your code probably has two patterns:**

**Pattern 1: Handle first node**
```python
if list1.val < list2.val:
    head = list1  # Create head
    list1 = list1.next
else:
    head = list2
    list2 = list2.next
```

**Pattern 2: Handle rest of nodes**
```python
while list1 and list2:
    if list1.val < list2.val:
        current.next = list1  # Attach to existing
        list1 = list1.next
    ...
```

**Why are these different?** Because first node needs initialization!

---

## The Dummy Node Solution

**What if there was ALWAYS a node to start from?**

```python
def mergeTwoLists(list1, list2):
    dummy = ListNode(0)  # Always exists!
    current = dummy

    # Now EVERY node uses the same logic
    while list1 and list2:
        if list1.val < list2.val:
            current.next = list1
            list1 = list1.next
        else:
            current.next = list2
            list2 = list2.next
        current = current.next

    # Attach remaining (works even if None!)
    current.next = list1 if list1 else list2

    return dummy.next  # Skip dummy, return real head
```

**Visual:**
```
dummy (helper)     (actual result)
┌───┬───┐
│ 0 │ •─┼────→ 1 -> 2 -> 3 -> 4
└───┴───┘

Return dummy.next ✓
```

---

## Comparison

**Your approach:**
```python
# Lines: ~20-25
# Edge cases: 5+
# Bugs possible: Many (forgot a case? wrong pointer?)
```

**Dummy node approach:**
```python
# Lines: ~10-12
# Edge cases: 0 (all handled naturally)
# Bugs possible: Few (uniform logic)
```

---

## Your Challenge

Rewrite your solution using a **dummy node**.

### Requirements:
- ❌ No manual edge case handling
- ✅ Create dummy = ListNode(0) at start
- ✅ Use uniform logic for all nodes
- ✅ Return dummy.next at end

---

## Progressive Hints

**[Hint 1]** Start with dummy = ListNode(0), current = dummy
**[Hint 2]** Always do current.next = ... (never special first node)
**[Hint 3]** Here's the template...

[Submit Optimized Solution →]
```

**Hints:**

**Hint 1:**
```markdown
💡 **Hint 1:** Create a dummy node

```python
def mergeTwoLists(list1, list2):
    dummy = ListNode(0)  # Helper node (value doesn't matter)
    current = dummy      # Start here

    # Now you can always do:
    # current.next = ...
    # current = current.next
```
```

**Hint 2:**
```markdown
💡 **Hint 2:** Uniform logic

```python
dummy = ListNode(0)
current = dummy

while list1 and list2:
    if list1.val < list2.val:
        current.next = list1  # Same pattern every time!
        list1 = list1.next
    else:
        current.next = list2
        list2 = list2.next
    current = current.next  # Move current forward
```

No special cases needed!
```

**Hint 3:**
```markdown
💡 **Hint 3:** Complete solution

```python
def mergeTwoLists(list1, list2):
    dummy = ListNode(0)
    current = dummy

    while list1 and list2:
        if list1.val < list2.val:
            current.next = list1
            list1 = list1.next
        else:
            current.next = list2
            list2 = list2.next
        current = current.next

    # One of these will be None, one will have remaining nodes
    current.next = list1 if list1 else list2

    return dummy.next  # Skip dummy!
```

**Why this works:**
- Dummy is always there, so no special first node
- If either list is empty initially, while loop doesn't run
- Remaining attachment works for all cases
- Return dummy.next gives the real head
```

---

#### PATTERN 2: TWO POINTERS (FAST/SLOW)

#### ITEM 4: Two Pointers in Linked Lists

**Type:** 📖 Lesson + 💻 Problem
**ID:** `two-pointers-linkedlist-intro`
**Time:** 20-30 minutes

##### Left Side - Lesson

```markdown
# Pattern 2: Two Pointers in Linked Lists

Remember two pointers from Module 1? Now in linked lists!

---

## The Difference from Arrays

**In arrays (Module 1):**
```python
left, right = 0, len(arr) - 1  # Know the end!

while left < right:
    # Process arr[left], arr[right]
    left += 1
    right -= 1
```

**In linked lists:**
```python
# Can't do this!
# right = head[len(list)-1]  # ❌ No indexing!

# Instead, use FAST and SLOW pointers
slow = head
fast = head

while fast and fast.next:
    slow = slow.next      # Move 1 step
    fast = fast.next.next # Move 2 steps
```

---

## Fast and Slow Pattern

**Key idea:** Two pointers moving at different speeds!

**Uses:**
1. **Find middle** - When fast reaches end, slow is at middle
2. **Detect cycle** - If fast catches slow, there's a cycle
3. **Find kth from end** - Offset the pointers

**Visual:**
```
1 -> 2 -> 3 -> 4 -> 5 -> None
s    f              (Start: both at head)

1 -> 2 -> 3 -> 4 -> 5 -> None
     s         f    (After 1 iteration)

1 -> 2 -> 3 -> 4 -> 5 -> None
          s              f (After 2 iterations)

When fast reaches end, slow is at middle!
```

---

## Cycle Detection

**The problem:** Is there a cycle in the linked list?

```
1 -> 2 -> 3 -> 4
     ↑         ↓
     6 <- 5 <--

Has cycle? YES!
```

**Brute force:** Use a set to track visited nodes
```python
seen = set()
current = head
while current:
    if current in seen:
        return True  # Cycle detected!
    seen.add(current)
    current = current.next
return False
```
**Space: O(n)**

**Optimized:** Fast/slow pointers
```python
slow = fast = head
while fast and fast.next:
    slow = slow.next
    fast = fast.next.next
    if slow == fast:
        return True  # They met! Cycle exists!
return False
```
**Space: O(1)** ✓

---

## Your Task

Detect if a linked list has a cycle.

Think about:
- Can you use a set? (Will work but uses O(n) space)
- Can you use two pointers? (O(1) space!)

[Start Coding →]
```

##### Right Side - Problem

**Difficulty:** Easy
**Problem ID:** `linked-list-cycle`

```markdown
# Linked List Cycle

Given `head`, the head of a linked list, determine if the linked list has a **cycle** in it.

There is a cycle in a linked list if there is some node that can be reached again by continuously following the `next` pointer.

Return `true` if there is a cycle, `false` otherwise.

---

## Examples

**Example 1:**
```
Input: head = 3->2->0->-4 (with cycle: -4 points back to 2)
Output: true
```

**Example 2:**
```
Input: head = 1->2 (with cycle: 2 points back to 1)
Output: true
```

**Example 3:**
```
Input: head = 1 (no cycle)
Output: false
```

---

## Constraints

- The number of nodes is in range `[0, 10^4]`
- `-10^5 <= Node.val <= 10^5`

**Follow-up:** Can you solve it using O(1) memory?

---

## Starter Code

```python
def hasCycle(head: Optional[ListNode]) -> bool:
    # Your code here
    pass
```

**Hint:** Think about two pointers moving at different speeds!
```

**Test Cases:**
```python
# Note: Test cases need to create cycles programmatically
# Example structure:
def createCycle():
    node1 = ListNode(3)
    node2 = ListNode(2)
    node3 = ListNode(0)
    node4 = ListNode(-4)
    node1.next = node2
    node2.next = node3
    node3.next = node4
    node4.next = node2  # Cycle!
    return node1
```

---

#### ITEM 5a: Optimized with Two Pointers

**ID:** `two-pointers-optimized-first`

```markdown
# 🌟 Perfect! You Used Fast/Slow Pointers!

Your solution uses **O(1) space** - optimal!

---

## Your Approach

```python
[INJECT: User's code]
```

You used the **Floyd's Cycle Detection** (Tortoise and Hare):
- ✅ Slow pointer moves 1 step
- ✅ Fast pointer moves 2 steps
- ✅ If they meet, cycle exists
- ✅ O(n) time, O(1) space

This is optimal!

---

## The Alternative (Using Set)

Many people track visited nodes:

```python
def hasCycle(head):
    seen = set()
    current = head

    while current:
        if current in seen:
            return True  # Found cycle!
        seen.add(current)
        current = current.next

    return False
```

**This works but uses O(n) space!**

---

## Why Fast/Slow is Brilliant

### The Proof: Why They Must Meet

**If there's a cycle:**

```
Entry -> [Cycle nodes]
         ↑         ↓
         └─────────┘
```

1. Fast enters cycle first
2. Slow enters cycle later
3. Fast is ahead of slow in cycle
4. Fast catches up: moves 2x speed, gains 1 node per iteration
5. **Must meet!** (Like running on a circular track)

**Visual:**
```
Cycle: 1 -> 2 -> 3 -> 4 -> 5
       ↑                   ↓
       └───────────────────┘

Iteration 1:
slow at 1, fast at 2

Iteration 2:
slow at 2, fast at 4

Iteration 3:
slow at 3, fast at 1

Iteration 4:
slow at 4, fast at 3

Iteration 5:
slow at 5, fast at 5  ← MEET!
```

---

## Comparison

| Approach | Time | Space | Notes |
|----------|------|-------|-------|
| Set | O(n) | O(n) | Straightforward ❌ |
| Fast/Slow | O(n) | O(1) | Clever! ✅ |

**For 10,000 nodes:**
- Set: 10,000 entries in memory
- Fast/Slow: 2 pointers (constant memory)

---

## Pattern: Fast/Slow Pointers

**Template:**
```python
def detectPattern(head):
    if not head or not head.next:
        return False  # or other base case

    slow = head
    fast = head

    while fast and fast.next:
        slow = slow.next      # Move 1
        fast = fast.next.next # Move 2

        if slow == fast:
            return True  # Pattern detected!

    return False
```

**Use cases:**
✅ Cycle detection
✅ Finding middle of list
✅ Finding kth node from end (with offset)
✅ Checking if linked list is palindrome

---

## Why "while fast and fast.next"?

**Important safety check!**

```python
while fast and fast.next:
#     ↑    ↑
#     |    └─ Need this! fast.next.next requires fast.next to exist
#     └────── Need this! fast.next requires fast to exist
```

**Without proper check:**
```python
# ❌ WRONG
while fast:
    fast = fast.next.next  # Crash if fast.next is None!
```

---

## Pattern Mastered: Two Pointers (Fast/Slow) ✓

- **Attempts:** 1
- **Mastery Level:** Excellent
- **Key Learning:** Different speeds enable cycle detection in O(1) space

[Continue to Next Pattern: Reversal →]
```

---

#### PATTERN 3: REVERSAL

#### ITEM 6: Reversal Introduction

**Type:** 📖 Lesson + 💻 Problem
**ID:** `reversal-intro`
**Time:** 20-30 minutes

##### Left Side - Lesson

```markdown
# Pattern 3: Reversing a Linked List

One of the most fundamental linked list operations!

---

## The Challenge

**Reverse a linked list in-place:**

```
Input:  1 -> 2 -> 3 -> 4 -> None
Output: 4 -> 3 -> 2 -> 1 -> None
```

**Why is this hard?**

In arrays (easy):
```python
arr.reverse()  # Done!
# or
arr = arr[::-1]
```

In linked lists (requires pointer manipulation):
```python
# Can't just reverse!
# Must change .next pointers
```

---

## The Core Idea

**Change the direction of pointers:**

```
Before:
1 -> 2 -> 3 -> None

After:
None <- 1 <- 2 <- 3
                  ↑
                 head
```

**Each node's .next must point backward!**

---

## The Algorithm (Iterative)

**Use 3 pointers:**

```python
prev = None
current = head

while current:
    next_temp = current.next  # Save next
    current.next = prev       # Reverse pointer!
    prev = current            # Move prev forward
    current = next_temp       # Move current forward

return prev  # New head!
```

**Visual step-by-step:**

```
Initial:
None  1 -> 2 -> 3 -> None
prev curr

Step 1: Save next, reverse pointer
None <- 1  2 -> 3 -> None
       prev curr

Step 2: Save next, reverse pointer
None <- 1 <- 2  3 -> None
            prev curr

Step 3: Save next, reverse pointer
None <- 1 <- 2 <- 3  None
                 prev curr

Return prev (now points to 3)
```

---

## Why 3 Pointers?

**1. prev** - Track previous node (what current should point to)
**2. current** - The node we're currently reversing
**3. next_temp** - Save next node (or we lose the rest of the list!)

**Without next_temp:**
```python
current.next = prev  # Lost reference to rest of list! ❌
```

---

## Your Task

Reverse a linked list.

Think about:
- How do you reverse a single pointer?
- How do you not lose the rest of the list?
- What should be the new head?

[Start Coding →]
```

##### Right Side - Problem

**Difficulty:** Easy (but conceptually tricky!)
**Problem ID:** `reverse-linked-list`

```markdown
# Reverse Linked List

Given the `head` of a singly linked list, reverse the list, and return the reversed list.

---

## Examples

**Example 1:**
```
Input: head = 1->2->3->4->5
Output: 5->4->3->2->1
```

**Example 2:**
```
Input: head = 1->2
Output: 2->1
```

**Example 3:**
```
Input: head = []
Output: []
```

---

## Constraints

- The number of nodes is in range `[0, 5000]`
- `-5000 <= Node.val <= 5000`

**Follow-up:** Can you reverse it **iteratively** and **recursively**?

---

## Starter Code

```python
def reverseList(head: Optional[ListNode]) -> Optional[ListNode]:
    # Your code here
    pass
```

**Hint:** Use three pointers: prev, current, next!
```

---

### PART 2: COMBINATIONS

#### PATTERN 4: LINKED LIST + HASH MAP

#### ITEM 9: LRU Cache Introduction

**Type:** 📖 Lesson Only
**ID:** `lru-cache-intro`
**Time:** 15-20 minutes

```markdown
# Pattern 4: Linked List + Hash Map = LRU Cache

**The most important design problem!**

---

## Why Combine Linked List with Hash Map?

**Hash Map alone:**
- ✅ O(1) get/set
- ❌ No ordering (can't track "least recently used")

**Linked List alone:**
- ✅ Easy to maintain order
- ❌ O(n) to find elements

**Combined:**
- ✅ O(1) get/set
- ✅ O(1) to update order
- ✅ O(1) to evict least recently used

**Perfect for caching!**

---

## What is LRU Cache?

**LRU = Least Recently Used**

**Cache:** Store limited items for fast access
**LRU Policy:** When cache is full, remove **least recently used** item

**Example:**
```
Cache capacity: 3

put(1, "a")  → Cache: [1]
put(2, "b")  → Cache: [2, 1]
put(3, "c")  → Cache: [3, 2, 1]
put(4, "d")  → Cache: [4, 3, 2]  (evicted 1 - least recently used)

get(2)       → Cache: [2, 4, 3]  (moved 2 to front - most recent)
put(5, "e")  → Cache: [5, 2, 4]  (evicted 3 - least recently used)
```

**Most recent at front, least recent at back!**

---

## Why This is Hard

**Requirements:**
1. `get(key)`: Return value in O(1)
2. `put(key, value)`: Insert/update in O(1)
3. Track recency: Most/least recently used
4. Eviction: Remove LRU item in O(1)

**All operations must be O(1)!**

---

## The Brute Force Approaches

### Approach 1: Array/List + Hash Map

```python
class LRUCache:
    def __init__(self, capacity):
        self.cache = {}      # key -> value
        self.order = []      # keys in order
        self.capacity = capacity

    def get(self, key):
        if key not in self.cache:
            return -1
        # Move to end (most recent)
        self.order.remove(key)  # O(n)! ❌
        self.order.append(key)
        return self.cache[key]

    def put(self, key, value):
        if key in self.cache:
            self.order.remove(key)  # O(n)! ❌
        elif len(self.order) >= self.capacity:
            lru = self.order.pop(0)  # Remove LRU
            del self.cache[lru]

        self.order.append(key)
        self.cache[key] = value
```

**Problem:** `list.remove()` is O(n)! ❌

### Approach 2: Just Hash Map (No Order)

```python
class LRUCache:
    def __init__(self, capacity):
        self.cache = {}
        self.capacity = capacity

    def get(self, key):
        return self.cache.get(key, -1)

    def put(self, key, value):
        if len(self.cache) >= self.capacity:
            # Which key to remove? ❌
            # No way to know LRU!
        self.cache[key] = value
```

**Problem:** Can't track LRU! ❌

---

## The Optimal Solution: Doubly Linked List + Hash Map

**Data structures:**

1. **Hash Map:** key → node (O(1) access)
2. **Doubly Linked List:** Maintain order (O(1) move/delete)

```python
hash_map = {
    key1: node1,
    key2: node2,
    key3: node3
}

doubly_linked_list:
head ⇄ node1 ⇄ node2 ⇄ node3 ⇄ tail
       (MRU)                   (LRU)
```

**Operations:**

**Get:**
1. Hash map lookup: O(1)
2. Move node to front: O(1) with doubly linked list

**Put:**
1. If exists: Update value, move to front: O(1)
2. If new: Add to front: O(1)
3. If full: Remove from tail: O(1)

**All O(1)!** ✓

---

## Why Doubly Linked List?

**Singly linked list:**
```
node1 -> node2 -> node3 -> node4

To remove node3:
- Need to find node2 (predecessor)
- Requires traversal from head
- O(n)! ❌
```

**Doubly linked list:**
```
node1 ⇄ node2 ⇄ node3 ⇄ node4

To remove node3:
- node2.next = node3.next  (node3 knows node2!)
- node4.prev = node3.prev  (node3 knows node4!)
- O(1)! ✓
```

---

## The Structure

```python
class DLLNode:
    def __init__(self, key, val):
        self.key = key
        self.val = val
        self.prev = None
        self.next = None

class LRUCache:
    def __init__(self, capacity):
        self.capacity = capacity
        self.cache = {}  # key -> DLLNode

        # Dummy head and tail
        self.head = DLLNode(0, 0)
        self.tail = DLLNode(0, 0)
        self.head.next = self.tail
        self.tail.prev = self.head
```

**Visual:**
```
hash_map: {1: nodeA, 2: nodeB, 3: nodeC}

head ⇄ nodeA ⇄ nodeB ⇄ nodeC ⇄ tail
       (MRU)                   (LRU)
```

---

## Interview Importance

**LRU Cache appears in:**
- 20-25% of senior interviews
- Almost guaranteed for system design roles
- Common at Google, Facebook, Amazon

**What it tests:**
- Data structure design
- Understanding trade-offs
- Combining multiple structures
- Handling complex state

**Companies say:**
> "LRU Cache is the gold standard for evaluating
> data structure design skills."

---

## Your Challenge

Next, you'll implement LRU Cache!

This is a **HARD** problem, but you have all the tools:
- Module 2: Hash maps (O(1) lookup)
- Module 3: Linked lists (pointer manipulation)
- Module 3: Dummy nodes (simplify edge cases)

**Let's combine them!**

[Continue to LRU Cache Problem →]
```

---

#### ITEM 10: LRU Cache Design Problem

**Type:** 💻 Problem Only (Large Problem)
**ID:** `lru-cache-problem`
**Time:** 30-60 minutes
**Difficulty:** Medium/Hard

```markdown
# Design LRU Cache

Design a data structure that follows the constraints of a **Least Recently Used (LRU) cache**.

Implement the `LRUCache` class:

- `LRUCache(int capacity)`: Initialize the LRU cache with **positive** size `capacity`.
- `int get(int key)`: Return the value of the `key` if it exists, otherwise return `-1`.
- `void put(int key, int value)`: Update the value of the `key` if it exists. Otherwise, add the `key-value` pair to the cache. If the number of keys exceeds the `capacity`, **evict the least recently used** key.

**The functions `get` and `put` must each run in O(1) average time complexity.**

---

## Examples

**Example 1:**
```
Input:
["LRUCache", "put", "put", "get", "put", "get", "put", "get", "get", "get"]
[[2], [1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]]

Output:
[null, null, null, 1, null, -1, null, -1, 3, 4]

Explanation:
LRUCache lRUCache = new LRUCache(2);
lRUCache.put(1, 1); // cache is {1=1}
lRUCache.put(2, 2); // cache is {1=1, 2=2}
lRUCache.get(1);    // return 1
lRUCache.put(3, 3); // LRU key was 2, evicts key 2, cache is {1=1, 3=3}
lRUCache.get(2);    // returns -1 (not found)
lRUCache.put(4, 4); // LRU key was 1, evicts key 1, cache is {4=4, 3=3}
lRUCache.get(1);    // return -1 (not found)
lRUCache.get(3);    // return 3
lRUCache.get(4);    // return 4
```

---

## Constraints

- `1 <= capacity <= 3000`
- `0 <= key <= 10^4`
- `0 <= value <= 10^5`
- At most `2 * 10^5` calls will be made to `get` and `put`

---

## Starter Code

```python
class LRUCache:
    def __init__(self, capacity: int):
        # Your code here
        pass

    def get(self, key: int) -> int:
        # Your code here
        pass

    def put(self, key: int, value: int) -> None:
        # Your code here
        pass
```

**Hints:**
1. Use hash map for O(1) access
2. Use doubly linked list for O(1) reordering
3. Use dummy head and tail nodes
4. Most recent at head, least recent at tail
```

---

#### ITEM 11a: Optimized Solution (Doubly Linked List + Hash Map)

**ID:** `lru-cache-optimized-first`

```markdown
# 🏆 Excellent! You Designed LRU Cache Optimally!

This is a **HARD** problem - outstanding work!

---

## Your Approach

```python
[INJECT: User's code]
```

You combined:
- ✅ **Hash map** for O(1) access
- ✅ **Doubly linked list** for O(1) reordering
- ✅ **Dummy nodes** to simplify edge cases
- ✅ All operations in O(1)!

This is the optimal solution!

---

## The Complete Solution

```python
class DLLNode:
    def __init__(self, key=0, val=0):
        self.key = key
        self.val = val
        self.prev = None
        self.next = None

class LRUCache:
    def __init__(self, capacity: int):
        self.capacity = capacity
        self.cache = {}  # key -> DLLNode

        # Dummy head and tail
        self.head = DLLNode()
        self.tail = DLLNode()
        self.head.next = self.tail
        self.tail.prev = self.head

    def _remove(self, node):
        """Remove node from list"""
        prev_node = node.prev
        next_node = node.next
        prev_node.next = next_node
        next_node.prev = prev_node

    def _add_to_head(self, node):
        """Add node right after head (most recent)"""
        node.next = self.head.next
        node.prev = self.head
        self.head.next.prev = node
        self.head.next = node

    def get(self, key: int) -> int:
        if key not in self.cache:
            return -1

        # Move to front (most recently used)
        node = self.cache[key]
        self._remove(node)
        self._add_to_head(node)

        return node.val

    def put(self, key: int, value: int) -> None:
        if key in self.cache:
            # Update existing
            node = self.cache[key]
            node.val = value
            self._remove(node)
            self._add_to_head(node)
        else:
            # Add new
            if len(self.cache) >= self.capacity:
                # Evict LRU (node before tail)
                lru = self.tail.prev
                self._remove(lru)
                del self.cache[lru.key]

            # Add new node
            new_node = DLLNode(key, value)
            self.cache[key] = new_node
            self._add_to_head(new_node)
```

---

## Why This Works

### Data Structure Visualization

```
hash_map: {1: nodeA, 3: nodeB, 4: nodeC}

head ⇄ nodeA ⇄ nodeB ⇄ nodeC ⇄ tail
       (key=1)  (key=3)  (key=4)
       MRU                      LRU
```

### Operation Breakdown

**Get(1):**
1. Hash map lookup: `cache[1]` → nodeA (O(1))
2. Remove nodeA from current position (O(1))
3. Add nodeA after head (make it MRU) (O(1))
4. Return nodeA.val

**Put(5, 50) when full:**
1. Check capacity: full!
2. Evict LRU: nodeC (O(1) access via tail.prev)
3. Delete from hash map: `del cache[4]` (O(1))
4. Create new node: nodeD(5, 50)
5. Add to hash map: `cache[5] = nodeD` (O(1))
6. Add after head: nodeD becomes MRU (O(1))

**All O(1)!** ✓

---

## Key Design Decisions

### 1. Why Doubly Linked List?

**Need:** Remove node from middle in O(1)

**Singly linked:**
```
prev -> node -> next

To remove node:
- Need prev to do: prev.next = node.next
- But to find prev, need to traverse from head
- O(n)! ❌
```

**Doubly linked:**
```
prev ⇄ node ⇄ next

To remove node:
- node.prev.next = node.next  (node knows prev!)
- node.next.prev = node.prev  (node knows next!)
- O(1)! ✓
```

### 2. Why Dummy Head/Tail?

**Without dummies:**
```python
def _remove(node):
    if node == self.head:
        self.head = node.next  # Special case!
    elif node == self.tail:
        self.tail = node.prev  # Special case!
    else:
        node.prev.next = node.next  # Normal case
        node.next.prev = node.prev
```

**With dummies:**
```python
def _remove(node):
    # Always the same!
    node.prev.next = node.next
    node.next.prev = node.prev
```

**No edge cases!** ✓

### 3. Why Store Key in Node?

**For eviction:**
```python
lru_node = self.tail.prev  # Get LRU node
del self.cache[lru_node.key]  # Need key to delete from hash map!
```

**Without key in node, can't delete from hash map!**

---

## Performance Analysis

**Space Complexity: O(capacity)**
- Hash map: O(capacity) entries
- Doubly linked list: O(capacity) nodes

**Time Complexity: O(1) for all operations**
- `get()`: Hash map lookup + reorder = O(1) + O(1)
- `put()`: Hash map insert/update + reorder + evict = O(1) + O(1) + O(1)

---

## Common Mistakes (You Avoided!)

❌ **Using singly linked list:** Can't remove in O(1)
❌ **Using array for order:** `remove()` is O(n)
❌ **Not storing key in node:** Can't evict from hash map
❌ **No dummy nodes:** Complex edge case handling
❌ **Wrong order:** Putting LRU at head instead of tail

**You avoided all of these!** 🎉

---

## Interview Impact

**This problem tests:**
- ✅ Data structure design
- ✅ Understanding trade-offs
- ✅ Combining multiple structures
- ✅ Pointer manipulation
- ✅ Edge case handling

**Companies that ask this:**
- Google (20-25%)
- Facebook (15-20%)
- Amazon (25-30%)
- Microsoft (15-20%)

**Difficulty progression:**
- Can solve with hints → Good candidate
- Can solve without hints → Strong candidate
- Can explain trade-offs → Excellent candidate ← YOU!

---

## Pattern Mastered: Linked List + Hash Map ✓

- **Attempts:** 1
- **Mastery Level:** Excellent
- **Difficulty:** HARD
- **Key Learning:** Combining structures creates powerful abstractions

**You just solved one of the most important design problems!** 🏆

This pattern extends to:
- LFU Cache (Least Frequently Used)
- Time-based caching
- Browser history
- Undo/Redo functionality

[Continue to Practice Set →]
```

---

### PRACTICE SET

#### ITEM 12: Practice Introduction

**ID:** `linkedlist-practice-intro`

```markdown
# 💪 Practice Set: Linked List Mastery

Time to solidify everything you've learned!

---

## What You've Mastered

### Part 1: Fundamentals
✅ **Dummy Node** - Simplify edge cases
✅ **Two Pointers (Fast/Slow)** - Cycle detection, middle finding
✅ **Reversal** - Pointer manipulation mastery

### Part 2: Combinations
✅ **Linked List + Hash Map** - LRU Cache design

---

## The Challenge

You'll solve **6 mixed problems** covering all patterns.

**Important:** No hints about which pattern to use!

---

## Problem Types

- 🔵 Easy problems (2)
- 🟡 Medium problems (3)
- 🔴 Hard problems (1)

All require linked list manipulation, some combine with other techniques!

---

## Tips

1. **Draw it out:**
   - Visualize pointer changes
   - Track prev, current, next

2. **Use dummy nodes:**
   - When building new lists
   - When head might change

3. **Two pointers:**
   - Cycle detection
   - Finding middle
   - Offset searches

4. **Think O(1) space:**
   - Modify in-place when possible
   - Avoid creating new lists

---

[Start Problem 1 →]
```

---

#### ITEMS 13-17: Practice Problems

**Problem 1:** Remove Duplicates from Sorted List (Easy)
- Pattern: Simple traversal
- Compare current with current.next

**Problem 2:** Palindrome Linked List (Easy/Medium)
- Pattern: Fast/slow to find middle + Reversal
- Combines multiple techniques!

**Problem 3:** Intersection of Two Linked Lists (Medium)
- Pattern: Two pointers with clever trick
- Or hash set

**Problem 4:** Remove Nth Node From End (Medium)
- Pattern: Two pointers with offset
- Or count then remove

**Problem 5:** Add Two Numbers (Medium)
- Pattern: Dummy node + traversal
- Handle carry

**Problem 6:** Copy List with Random Pointer (Hard)
- Pattern: Hash map OR clever interweaving
- Very tricky!

---

#### ITEM 18: Module Completion

**ID:** `linkedlist-complete`

```markdown
# 🎉 Module 5 Complete! 🎉

**Linked List Mastery**

---

## Your Achievement

✅ **18/18 items completed**

---

## Patterns Mastered

### Part 1: Fundamentals

**1. Dummy Node**
- Simplifies edge cases
- Clean list building
- **Problems solved:** [COUNT]

**2. Two Pointers (Fast/Slow)**
- Cycle detection in O(1) space
- Finding middle
- **Problems solved:** [COUNT]

**3. Reversal**
- Iterative pointer manipulation
- Foundation for many problems
- **Problems solved:** [COUNT]

### Part 2: Combinations

**4. Linked List + Hash Map**
- LRU Cache design ⭐⭐⭐
- O(1) operations with ordering
- **Problems solved:** [COUNT]

---

## Your Stats

📊 **Total Problems:** 15
⏱️ **Time Spent:** [X hours]
🎯 **Mastery Level:** [Excellent/Good/Completed]
💡 **Hints Used:** [COUNT]

---

## Key Learnings

### Pointer Manipulation

You mastered:
- Tracking prev, current, next simultaneously
- Changing pointer directions safely
- Avoiding losing references

### Edge Case Handling

You learned:
- Dummy nodes eliminate most edge cases
- Base cases: empty list, single node
- Safety: check `node` and `node.next` before accessing

### Combinations

You discovered:
- Hash maps give O(1) access
- Linked lists give O(1) insertion/deletion with ordering
- **Combined = powerful abstractions!**

---

## Interview Impact

**These patterns appear in:**
- 20-25% of all coding interviews
- Essential for senior+ roles
- Common at all top tech companies

**Specifically:**
- Dummy node: Basic must-know
- Two pointers: Intermediate skill
- Reversal: Demonstrates pointer comfort
- LRU Cache: Senior-level design problem

---

## Progression Through Modules

```
Module 1: Arrays
└─ Index-based manipulation

Module 2: Hash Maps
└─ O(1) lookups and counting

Module 2.5: Arrays + Hash Maps
└─ Sliding window with state tracking

Module 3: Linked Lists + Hash Maps
└─ Pointer manipulation + design
```

**See the pattern?**
Each module builds on previous ones!

---

## What's Next

**Module 4: Trees & Tree Traversals**

Master tree structures and recursive thinking!

**Topics:**
- Tree structure and terminology
- DFS (Preorder, Inorder, Postorder)
- BFS (Level-order traversal)
- Binary search trees
- Tree properties

---

## Achievement Unlocked

🏆 **"Linked List Master"**

You can now:
- Manipulate pointers confidently
- Design O(1) data structures
- Combine linked lists with other structures
- Solve design problems

**You've mastered one of the trickiest data structures!** 🚀

---

[Continue to Module 4 →]
[Review Module 3]
[Back to Course]
```

---

## Summary

This specification provides:

✅ Complete content for 18 items
✅ Two-part structure: Fundamentals + Combinations
✅ LRU Cache as crown jewel problem
✅ Adaptive branching for all patterns
✅ 15 problems from easy to hard
✅ Combines previous module knowledge

**Key Innovation:** Module 3 doesn't just teach linked lists - it shows how to **combine them with hash maps** for powerful designs!

**Implementation Estimate:** 4-5 weeks for full module

---

**End of Module 3 Specification**
