# Module 6: Trees & Tree Traversals

## Overview
This module teaches tree data structures and traversal techniques through adaptive learning. Students learn to recognize tree patterns, master DFS (Depth-First Search) and BFS (Breadth-First Search) traversals, and combine trees with hash maps for advanced problems.

**Total Items**: 18
**Estimated Time**: 4-5 hours
**Prerequisites**: Module 1 (Arrays), Module 2 (Hash Maps)

---

## Learning Philosophy

Following the IdleCampus adaptive learning approach:
1. **Present Problem First**: User encounters the problem before seeing the pattern
2. **Detect Approach**: Analyze if user writes iterative/brute force or recursive/optimal solution
3. **Adaptive Branching**: Different learning paths based on user's solution
4. **Guide, Don't Give Away**: Provide hints and understanding, never the answer
5. **Brute Force → Optimization**: Help user understand WHY recursion/iteration works better

---

## Module Structure

### Part 1: Tree Fundamentals & DFS (Items 1-10)
- Understanding tree structure
- Recursive DFS patterns (preorder, inorder, postorder)
- Tree depth and path problems

### Part 2: BFS & Level-Order Traversal (Items 11-14)
- Queue-based BFS
- Level-by-level processing

### Part 3: Trees + Hash Map Combinations (Items 15-18)
- Path sum problems with hash maps
- Tree construction from traversals
- Complex tree queries

---

## Detailed Item Specifications

### **ITEM 1: Introduction to Trees**
**Type**: Lesson Only
**Duration**: 3 minutes

**Content**:
```
# Trees: Hierarchical Data Structures

A tree is a hierarchical data structure consisting of nodes connected by edges.

## Key Concepts:
- **Root**: Top node with no parent
- **Child**: Node directly connected below another node
- **Parent**: Node directly connected above
- **Leaf**: Node with no children
- **Subtree**: A node and all its descendants
- **Height**: Longest path from node to leaf
- **Depth**: Distance from root to node

## Tree Node Structure:
```typescript
class TreeNode {
  val: number;
  left: TreeNode | null;
  right: TreeNode | null;

  constructor(val: number) {
    this.val = val;
    this.left = null;
    this.right = null;
  }
}
```

## Why Trees Matter:
- File systems (folders/files)
- DOM structure in web browsers
- Decision trees in ML
- Database indexes (B-trees)
- 15-20% of FAANG interviews involve trees

Let's start with the most fundamental tree operation: traversal.
```

**Next**: Item 2

---

### **ITEM 2: First Tree Problem**
**Type**: Lesson + Problem
**Duration**: 8-12 minutes

**Left Panel (Lesson)**:
```
# Your First Tree Problem

Before we explain tree traversal techniques, let's see if you can solve this problem:

**Problem**: Given a binary tree, find its maximum depth.

The maximum depth is the number of nodes along the longest path from root to leaf.

## Think About:
- How would you explore all nodes?
- How do you track the longest path?
- Can you break this into smaller subproblems?

Try solving this problem on the right →
```

**Right Panel (Problem)**: `tree-1` (Maximum Depth of Binary Tree)

**Solution Analysis**:

```typescript
// Detect user's approach:

// PATH A: User writes recursive DFS (optimal O(n) time, O(h) space)
function maxDepth(root: TreeNode | null): number {
  if (!root) return 0;
  return 1 + Math.max(maxDepth(root.left), maxDepth(root.right));
}

// PATH B: User writes iterative level-order (correct but more complex)
function maxDepth(root: TreeNode | null): number {
  if (!root) return 0;
  let queue = [root];
  let depth = 0;
  while (queue.length > 0) {
    let size = queue.length;
    for (let i = 0; i < size; i++) {
      let node = queue.shift()!;
      if (node.left) queue.push(node.left);
      if (node.right) queue.push(node.right);
    }
    depth++;
  }
  return depth;
}

// PATH C: User struggles or writes incorrect solution
```

**State Machine Routing**:

```typescript
if (solution.isRecursiveDFS() && solution.isCorrect()) {
  // PATH A: Excellent! Recognized recursion naturally
  return "item-3a-dfs-natural";
} else if (solution.isIterativeBFS() && solution.isCorrect()) {
  // PATH B: Correct but more complex approach
  return "item-3b-bfs-first";
} else {
  // PATH C: Need guidance
  return "item-3c-hint-recursion";
}
```

---

### **ITEM 3A: DFS Pattern Recognition (Path A)**
**Type**: Lesson Only
**Duration**: 4 minutes
**Condition**: User wrote recursive DFS solution

**Content**:
```
# Excellent! You Discovered DFS

Your recursive solution is using **Depth-First Search (DFS)**:

```typescript
function maxDepth(root: TreeNode | null): number {
  if (!root) return 0;
  return 1 + Math.max(maxDepth(root.left), maxDepth(root.right));
}
```

## Why This Works:

1. **Base Case**: Empty tree has depth 0
2. **Recursive Case**: Current node adds 1 to the max of left/right subtrees
3. **Trust the Recursion**: Each call solves a smaller subproblem

## DFS Traversal Orders:

There are 3 ways to traverse a tree with DFS:

**Preorder**: Root → Left → Right
**Inorder**: Left → Root → Right
**Postorder**: Left → Right → Root

Your solution uses **postorder** thinking: process children first, then use their results.

## Time & Space:
- Time: O(n) - visit every node once
- Space: O(h) - recursion stack where h = height

Let's practice another DFS problem →
```

**Next**: Item 4

---

### **ITEM 3B: BFS Approach (Path B)**
**Type**: Lesson Only
**Duration**: 4 minutes
**Condition**: User wrote iterative BFS solution

**Content**:
```
# You Used BFS (Breadth-First Search)!

Your iterative solution processes the tree level-by-level:

```typescript
function maxDepth(root: TreeNode | null): number {
  if (!root) return 0;
  let queue = [root];
  let depth = 0;
  while (queue.length > 0) {
    let size = queue.length;  // Process entire level
    for (let i = 0; i < size; i++) {
      let node = queue.shift()!;
      if (node.left) queue.push(node.left);
      if (node.right) queue.push(node.right);
    }
    depth++;
  }
  return depth;
}
```

## Why This Works:
- Uses a **queue** to track nodes
- Processes one level at a time
- Counts levels = depth

## Trade-offs:
✅ Correct and clear logic
✅ Good for level-based problems
❌ More verbose for simple problems
❌ Uses more space O(w) where w = max width

## Simpler Approach: Recursion

For this problem, recursion is simpler:
```typescript
function maxDepth(root: TreeNode | null): number {
  if (!root) return 0;
  return 1 + Math.max(maxDepth(root.left), maxDepth(root.right));
}
```

Both approaches work! Let's learn when to use each →
```

**Next**: Item 4

---

### **ITEM 3C: Hint - Recursion (Path C)**
**Type**: Lesson Only
**Duration**: 3 minutes
**Condition**: User didn't solve correctly

**Content**:
```
# Hint: Think Recursively

Trees are **recursive structures**: each subtree is itself a tree!

## Key Insight:
The depth of a tree = 1 + max(depth of left subtree, depth of right subtree)

## Start with Base Case:
What's the depth of an empty tree (null)?
→ 0

## Recursive Case:
If tree exists:
1. Find depth of left subtree (trust recursion!)
2. Find depth of right subtree (trust recursion!)
3. Return 1 + max of both

## Try Again:
```typescript
function maxDepth(root: TreeNode | null): number {
  // Base case: empty tree
  if (!root) return ???;

  // Recursive case: 1 + max of subtrees
  return 1 + Math.max(???, ???);
}
```

Try implementing this approach →
```

**Next**: Item 2 (resubmit)

---

### **ITEM 4: Preorder Traversal Pattern**
**Type**: Lesson + Problem
**Duration**: 8-12 minutes

**Left Panel (Lesson)**:
```
# DFS: Preorder Traversal

**Preorder** means: Root → Left → Right

## When to Use:
- Creating a copy of the tree
- Prefix expression evaluation
- Serialization

## The Pattern:
```typescript
function preorder(root: TreeNode | null): number[] {
  if (!root) return [];

  // Process root FIRST
  let result = [root.val];

  // Then left subtree
  result.push(...preorder(root.left));

  // Then right subtree
  result.push(...preorder(root.right));

  return result;
}
```

## Your Turn:
Given a tree, return all node values in preorder.

Example:
```
    1
   / \
  2   3
 / \
4   5

Output: [1, 2, 4, 5, 3]
```

Solve this problem on the right →
```

**Right Panel (Problem)**: `tree-2` (Binary Tree Preorder Traversal)

**Solution Analysis**:

```typescript
// OPTIMAL: Recursive preorder
function preorderTraversal(root: TreeNode | null): number[] {
  if (!root) return [];
  return [root.val, ...preorderTraversal(root.left), ...preorderTraversal(root.right)];
}

// ALSO CORRECT: Iterative with stack
function preorderTraversal(root: TreeNode | null): number[] {
  if (!root) return [];
  let result: number[] = [];
  let stack = [root];

  while (stack.length > 0) {
    let node = stack.pop()!;
    result.push(node.val);
    if (node.right) stack.push(node.right);  // Right first!
    if (node.left) stack.push(node.left);    // Then left
  }

  return result;
}
```

**State Machine Routing**:

```typescript
if (solution.isRecursive() && solution.isPreorder()) {
  return "item-5-inorder";
} else if (solution.isIterativeStack() && solution.isPreorder()) {
  return "item-4a-iterative-insight";
} else {
  return "item-4b-preorder-hint";
}
```

---

### **ITEM 4A: Iterative DFS Insight**
**Type**: Lesson Only
**Duration**: 3 minutes
**Condition**: User wrote iterative stack solution

**Content**:
```
# Iterative DFS with Stack

Great! You discovered that recursion can be converted to iteration using a stack:

```typescript
function preorderTraversal(root: TreeNode | null): number[] {
  if (!root) return [];
  let result: number[] = [];
  let stack = [root];

  while (stack.length > 0) {
    let node = stack.pop()!;
    result.push(node.val);           // Process root
    if (node.right) stack.push(node.right);  // Right first
    if (node.left) stack.push(node.left);    // Then left (to pop first)
  }

  return result;
}
```

## Key Insight:
**Recursion uses the call stack. Iteration uses an explicit stack.**

## Why Push Right Before Left?
Stack is LIFO (Last In, First Out). We want to process left first, so we push right first!

## When to Use Iterative:
- Very deep trees (avoid stack overflow)
- Need to pause/resume traversal
- Explicit control over traversal

For most problems, recursion is simpler and clearer.
```

**Next**: Item 5

---

### **ITEM 4B: Preorder Hint**
**Type**: Lesson Only
**Duration**: 2 minutes
**Condition**: User's solution incorrect

**Content**:
```
# Hint: Root → Left → Right

Preorder means process in this order:
1. **Root** (current node)
2. **Left** subtree
3. **Right** subtree

## Template:
```typescript
function preorder(root: TreeNode | null): number[] {
  // Base case
  if (!root) return [];

  // 1. Process root
  let result = [root.val];

  // 2. Process left subtree
  result.push(...preorder(root.left));

  // 3. Process right subtree
  result.push(...preorder(root.right));

  return result;
}
```

Try again with this template →
```

**Next**: Item 4 (resubmit)

---

### **ITEM 5: Inorder Traversal Pattern**
**Type**: Lesson + Problem
**Duration**: 8-12 minutes

**Left Panel (Lesson)**:
```
# DFS: Inorder Traversal

**Inorder** means: Left → Root → Right

## When to Use:
- Binary Search Trees (BST) → sorted order!
- Expression trees → infix notation
- Finding kth smallest/largest

## The Pattern:
```typescript
function inorder(root: TreeNode | null): number[] {
  if (!root) return [];

  let result: number[] = [];

  // Process left subtree FIRST
  result.push(...inorder(root.left));

  // Then root
  result.push(root.val);

  // Then right subtree
  result.push(...inorder(root.right));

  return result;
}
```

## Critical Insight:
For a **Binary Search Tree**, inorder traversal gives **sorted values**!

```
    4
   / \
  2   6
 / \ / \
1  3 5  7

Inorder: [1, 2, 3, 4, 5, 6, 7]  ← Sorted!
```

## Your Turn:
Implement inorder traversal.

Solve this problem on the right →
```

**Right Panel (Problem)**: `tree-3` (Binary Tree Inorder Traversal)

**Solution Analysis**: Similar pattern to Item 4 (recursive vs iterative)

**Next**: Item 6

---

### **ITEM 6: Postorder Traversal Pattern**
**Type**: Lesson + Problem
**Duration**: 8-12 minutes

**Left Panel (Lesson)**:
```
# DFS: Postorder Traversal

**Postorder** means: Left → Right → Root

## When to Use:
- Deleting a tree (delete children first!)
- Calculating tree height
- Postfix expression evaluation
- **Bottom-up** computation

## The Pattern:
```typescript
function postorder(root: TreeNode | null): number[] {
  if (!root) return [];

  let result: number[] = [];

  // Process left subtree first
  result.push(...postorder(root.left));

  // Then right subtree
  result.push(...postorder(root.right));

  // Finally, root (process LAST)
  result.push(root.val);

  return result;
}
```

## Why "Post" order?
We process the root **after** (post) its children. This is perfect for bottom-up problems!

## Your Turn:
Implement postorder traversal.

Solve this problem on the right →
```

**Right Panel (Problem)**: `tree-4` (Binary Tree Postorder Traversal)

**Next**: Item 7

---

### **ITEM 7: Path Sum Problem**
**Type**: Lesson + Problem
**Duration**: 10-15 minutes

**Left Panel (Lesson)**:
```
# Applying DFS: Path Sum

Now let's apply DFS to a real problem:

**Problem**: Does the tree have a root-to-leaf path that sums to a target?

```
    5
   / \
  4   8
 /   / \
11  13  4
   /  \   \
  7    2   1

Target: 22
Path: 5 → 4 → 11 → 2 = 22 ✓
```

## Think About:
- How do you track the current sum?
- What's the base case (leaf node)?
- Can you use recursion?

Try solving this problem on the right →
```

**Right Panel (Problem)**: `tree-5` (Path Sum)

**Solution Analysis**:

```typescript
// OPTIMAL: Recursive DFS with sum tracking
function hasPathSum(root: TreeNode | null, targetSum: number): boolean {
  if (!root) return false;

  // Leaf node: check if path sum equals target
  if (!root.left && !root.right) {
    return root.val === targetSum;
  }

  // Recursive case: check left or right subtree with remaining sum
  let remaining = targetSum - root.val;
  return hasPathSum(root.left, remaining) || hasPathSum(root.right, remaining);
}

// SUBOPTIMAL: Track entire path array (unnecessary space)
function hasPathSum(root: TreeNode | null, targetSum: number): boolean {
  let paths: number[][] = [];

  function dfs(node: TreeNode | null, path: number[]) {
    if (!node) return;
    path.push(node.val);
    if (!node.left && !node.right) {
      paths.push([...path]);
    }
    dfs(node.left, path);
    dfs(node.right, path);
    path.pop();
  }

  dfs(root, []);
  return paths.some(p => p.reduce((a,b) => a+b, 0) === targetSum);
}
```

**State Machine Routing**:

```typescript
if (solution.isOptimal()) {
  return "item-8-inverted-tree";
} else if (solution.tracksFullPath()) {
  return "item-7a-space-optimization";
} else {
  return "item-7b-path-sum-hint";
}
```

---

### **ITEM 7A: Space Optimization Insight**
**Type**: Lesson Only
**Duration**: 3 minutes

**Content**:
```
# Optimizing Space Complexity

Your solution works, but stores entire paths unnecessarily:

❌ **What you did**: Track entire path array
✅ **Better approach**: Just track the remaining sum

## Compare:

**Your Approach** (O(n) space for paths):
```typescript
function dfs(node, path, target) {
  path.push(node.val);  // Store entire path
  if (isLeaf(node)) {
    let sum = path.reduce((a,b) => a+b);
    if (sum === target) found = true;
  }
  // ...
}
```

**Optimal Approach** (O(h) space for recursion only):
```typescript
function hasPathSum(root, targetSum) {
  if (!root) return false;
  if (isLeaf(root)) return root.val === targetSum;

  let remaining = targetSum - root.val;
  return hasPathSum(root.left, remaining) ||
         hasPathSum(root.right, remaining);
}
```

## Key Insight:
We don't need to remember the entire path, just the **remaining sum** to find!

Space: O(n) → O(h) where h = height
```

**Next**: Item 8

---

### **ITEM 7B: Path Sum Hint**
**Type**: Lesson Only
**Duration**: 2 minutes

**Content**:
```
# Hint: Track the Remaining Sum

Think recursively:
1. **Base case**: If we reach a leaf, does the remaining sum equal the leaf's value?
2. **Recursive case**: Subtract current node's value and check left OR right subtree

## Template:
```typescript
function hasPathSum(root: TreeNode | null, targetSum: number): boolean {
  // Empty tree
  if (!root) return false;

  // Leaf node: check if we've found the target
  if (!root.left && !root.right) {
    return root.val === ???;
  }

  // Recursive case: check subtrees with remaining sum
  let remaining = ???;
  return hasPathSum(root.left, remaining) || hasPathSum(root.right, remaining);
}
```

Try again with this template →
```

**Next**: Item 7 (resubmit)

---

### **ITEM 8: Invert Binary Tree**
**Type**: Lesson + Problem
**Duration**: 8-12 minutes

**Left Panel (Lesson)**:
```
# Tree Manipulation: Invert Binary Tree

Famous problem: Google rejected someone who couldn't solve this in an interview!

**Problem**: Flip the tree horizontally (swap all left and right children).

```
Before:           After:
    4                4
   / \              / \
  2   7            7   2
 / \ / \          / \ / \
1  3 6  9        9  6 3  1
```

## Think About:
- What operation do you need to do at each node?
- Should you do it top-down or bottom-up?
- Can you modify the tree in-place?

This is a classic recursive problem. Try solving it on the right →
```

**Right Panel (Problem)**: `tree-6` (Invert Binary Tree)

**Solution Analysis**:

```typescript
// OPTIMAL: Simple recursive swap
function invertTree(root: TreeNode | null): TreeNode | null {
  if (!root) return null;

  // Swap children
  [root.left, root.right] = [root.right, root.left];

  // Recursively invert subtrees
  invertTree(root.left);
  invertTree(root.right);

  return root;
}

// ALSO OPTIMAL: Postorder (swap after recursion)
function invertTree(root: TreeNode | null): TreeNode | null {
  if (!root) return null;

  // Invert subtrees first
  let left = invertTree(root.left);
  let right = invertTree(root.right);

  // Then swap
  root.left = right;
  root.right = left;

  return root;
}
```

**Next**: Item 9

---

### **ITEM 9: Symmetric Tree**
**Type**: Lesson + Problem
**Duration**: 10-15 minutes

**Left Panel (Lesson)**:
```
# Two-Pointer Pattern in Trees

**Problem**: Check if a tree is symmetric (mirror of itself).

```
Symmetric:          Not Symmetric:
    1                   1
   / \                 / \
  2   2               2   2
 / \ / \               \   \
3  4 4  3               3   3
```

## Key Insight:
This is like **two pointers**, but on trees!

Compare two nodes simultaneously:
- Left subtree's left child ↔ Right subtree's right child
- Left subtree's right child ↔ Right subtree's left child

## Your Turn:
Write a helper function that compares two nodes for symmetry.

Try solving this problem on the right →
```

**Right Panel (Problem)**: `tree-7` (Symmetric Tree)

**Solution Analysis**:

```typescript
// OPTIMAL: Recursive two-pointer approach
function isSymmetric(root: TreeNode | null): boolean {
  function isMirror(left: TreeNode | null, right: TreeNode | null): boolean {
    if (!left && !right) return true;
    if (!left || !right) return false;

    return left.val === right.val &&
           isMirror(left.left, right.right) &&
           isMirror(left.right, right.left);
  }

  return isMirror(root, root);
}
```

**Next**: Item 10

---

### **ITEM 10: Same Tree**
**Type**: Problem Only
**Duration**: 8-10 minutes

**Left Panel (Problem Context)**:
```
# Practice: Same Tree

Now that you understand recursive tree comparison, try this:

**Problem**: Check if two trees are identical (same structure and values).

This is simpler than the symmetric tree problem. You can use a similar approach!
```

**Right Panel (Problem)**: `tree-8` (Same Tree)

**Next**: Item 11

---

### **ITEM 11: Introduction to BFS**
**Type**: Lesson Only
**Duration**: 4 minutes

**Content**:
```
# Breadth-First Search (BFS)

You've mastered **DFS** (Depth-First Search) which goes deep into the tree.

Now let's learn **BFS** (Breadth-First Search) which explores level by level.

## DFS vs BFS:

**DFS** (uses recursion/stack):
```
    1
   / \
  2   3
 / \
4   5

Visit order: 1 → 2 → 4 → 5 → 3
```

**BFS** (uses queue):
```
    1
   / \
  2   3
 / \
4   5

Visit order: 1 → 2 → 3 → 4 → 5  (level by level!)
```

## BFS Pattern:

```typescript
function bfs(root: TreeNode | null) {
  if (!root) return;

  let queue = [root];

  while (queue.length > 0) {
    let node = queue.shift()!;  // Dequeue

    process(node);  // Do something with node

    // Enqueue children
    if (node.left) queue.push(node.left);
    if (node.right) queue.push(node.right);
  }
}
```

## When to Use BFS:
- Level-order traversal
- Shortest path problems
- Finding nodes at specific depth
- **Width/breadth matters more than depth**
```

**Next**: Item 12

---

### **ITEM 12: Level Order Traversal**
**Type**: Lesson + Problem
**Duration**: 10-15 minutes

**Left Panel (Lesson)**:
```
# Level Order Traversal

**Problem**: Return values grouped by level.

```
    3
   / \
  9  20
    /  \
   15   7

Output: [[3], [9, 20], [15, 7]]
```

## The Pattern:

```typescript
function levelOrder(root: TreeNode | null): number[][] {
  if (!root) return [];

  let result: number[][] = [];
  let queue = [root];

  while (queue.length > 0) {
    let levelSize = queue.length;  // Key: capture size before loop
    let currentLevel: number[] = [];

    for (let i = 0; i < levelSize; i++) {
      let node = queue.shift()!;
      currentLevel.push(node.val);

      if (node.left) queue.push(node.left);
      if (node.right) queue.push(node.right);
    }

    result.push(currentLevel);
  }

  return result;
}
```

## Critical Insight:
**Capture `queue.length` before the loop!** This tells you how many nodes are in the current level.

Try solving this problem on the right →
```

**Right Panel (Problem)**: `tree-9` (Binary Tree Level Order Traversal)

**Solution Analysis**:

```typescript
// OPTIMAL: BFS with level tracking
function levelOrder(root: TreeNode | null): number[][] {
  if (!root) return [];

  let result: number[][] = [];
  let queue = [root];

  while (queue.length > 0) {
    let levelSize = queue.length;
    let currentLevel: number[] = [];

    for (let i = 0; i < levelSize; i++) {
      let node = queue.shift()!;
      currentLevel.push(node.val);

      if (node.left) queue.push(node.left);
      if (node.right) queue.push(node.right);
    }

    result.push(currentLevel);
  }

  return result;
}

// SUBOPTIMAL: Store depth with each node (extra space)
function levelOrder(root: TreeNode | null): number[][] {
  if (!root) return [];

  let result: number[][] = [];
  let queue: [TreeNode, number][] = [[root, 0]];

  while (queue.length > 0) {
    let [node, depth] = queue.shift()!;

    if (!result[depth]) result[depth] = [];
    result[depth].push(node.val);

    if (node.left) queue.push([node.left, depth + 1]);
    if (node.right) queue.push([node.right, depth + 1]);
  }

  return result;
}
```

**Next**: Item 13

---

### **ITEM 13: Right Side View**
**Type**: Lesson + Problem
**Duration**: 10-15 minutes

**Left Panel (Lesson)**:
```
# BFS Application: Right Side View

**Problem**: Return the rightmost node at each level (what you'd see from the right side).

```
    1
   / \
  2   3
   \   \
    5   4

Output: [1, 3, 4]
```

## Think About:
- How can you identify the rightmost node at each level?
- Can you use level-order traversal?
- When do you know you've reached the last node in a level?

This builds on the level order pattern. Try solving it on the right →
```

**Right Panel (Problem)**: `tree-10` (Binary Tree Right Side View)

**Solution Analysis**:

```typescript
// OPTIMAL: Take last node of each level
function rightSideView(root: TreeNode | null): number[] {
  if (!root) return [];

  let result: number[] = [];
  let queue = [root];

  while (queue.length > 0) {
    let levelSize = queue.length;

    for (let i = 0; i < levelSize; i++) {
      let node = queue.shift()!;

      // Last node in level? Add to result
      if (i === levelSize - 1) {
        result.push(node.val);
      }

      if (node.left) queue.push(node.left);
      if (node.right) queue.push(node.right);
    }
  }

  return result;
}

// ALSO OPTIMAL: DFS with depth tracking (clever!)
function rightSideView(root: TreeNode | null): number[] {
  let result: number[] = [];

  function dfs(node: TreeNode | null, depth: number) {
    if (!node) return;

    // First time visiting this depth? It's the rightmost (if we go right first)
    if (depth === result.length) {
      result.push(node.val);
    }

    dfs(node.right, depth + 1);  // Visit right first!
    dfs(node.left, depth + 1);
  }

  dfs(root, 0);
  return result;
}
```

**Next**: Item 14

---

### **ITEM 14: Zigzag Level Order**
**Type**: Problem Only
**Duration**: 10-12 minutes

**Left Panel (Problem Context)**:
```
# Practice: Zigzag Level Order

**Problem**: Return level order traversal, but alternate direction each level.

```
    3
   / \
  9  20
    /  \
   15   7

Output: [[3], [20, 9], [15, 7]]
         →     ←        →
```

## Hint:
Use level order traversal, but reverse every other level.

You can either:
- Reverse the array after building each level
- Use a flag to determine insertion order
```

**Right Panel (Problem)**: `tree-11` (Binary Tree Zigzag Level Order Traversal)

**Next**: Item 15

---

### **ITEM 15: Path Sum with Hash Map**
**Type**: Lesson + Problem
**Duration**: 12-18 minutes

**Left Panel (Lesson)**:
```
# Trees + Hash Maps: Path Sum III

Welcome to Part 3! Now we combine trees with hash maps for powerful solutions.

**Problem**: Count paths that sum to target (path doesn't have to start at root!).

```
    10
   /  \
  5   -3
 / \    \
3   2   11
   / \    \
  3  -2   1

Target: 8

Paths:
- 5 → 3
- 5 → 2 → 1
- -3 → 11
```

## Brute Force: O(n²)
For each node, check all paths starting from that node.

## Optimal: O(n) with Prefix Sum + Hash Map
Similar to **Subarray Sum Equals K** from Module 2!

Key insight: Use hash map to store prefix sums as you traverse.

```typescript
prefixSum[current] - prefixSum[previous] = target
→ prefixSum[previous] = prefixSum[current] - target
```

Try solving this problem on the right →
```

**Right Panel (Problem)**: `tree-12` (Path Sum III)

**Solution Analysis**:

```typescript
// OPTIMAL: DFS with prefix sum hash map (O(n) time, O(n) space)
function pathSum(root: TreeNode | null, targetSum: number): number {
  let count = 0;
  let prefixSums = new Map<number, number>();
  prefixSums.set(0, 1);  // Base case: empty path

  function dfs(node: TreeNode | null, currentSum: number) {
    if (!node) return;

    currentSum += node.val;

    // How many paths end at current node with target sum?
    let complement = currentSum - targetSum;
    if (prefixSums.has(complement)) {
      count += prefixSums.get(complement)!;
    }

    // Add current sum to map
    prefixSums.set(currentSum, (prefixSums.get(currentSum) || 0) + 1);

    // Recurse
    dfs(node.left, currentSum);
    dfs(node.right, currentSum);

    // Backtrack: remove current sum
    prefixSums.set(currentSum, prefixSums.get(currentSum)! - 1);
  }

  dfs(root, 0);
  return count;
}

// SUBOPTIMAL: O(n²) brute force
function pathSum(root: TreeNode | null, targetSum: number): number {
  if (!root) return 0;

  // Count paths starting from root
  let count = countPathsFrom(root, targetSum);

  // Count paths in left and right subtrees
  count += pathSum(root.left, targetSum);
  count += pathSum(root.right, targetSum);

  return count;
}

function countPathsFrom(node: TreeNode | null, remaining: number): number {
  if (!node) return 0;

  let count = node.val === remaining ? 1 : 0;
  count += countPathsFrom(node.left, remaining - node.val);
  count += countPathsFrom(node.right, remaining - node.val);

  return count;
}
```

**State Machine Routing**:

```typescript
if (solution.usesPrefixSumHashMap() && solution.hasBacktracking()) {
  return "item-16-lca";
} else if (solution.isBruteForce() && solution.isCorrect()) {
  return "item-15a-optimize-with-hashmap";
} else {
  return "item-15b-hint-prefix-sum";
}
```

---

### **ITEM 15A: Optimization with Hash Map**
**Type**: Lesson Only
**Duration**: 5 minutes

**Content**:
```
# From O(n²) to O(n) with Hash Map

Your brute force works but visits paths multiple times.

## Your Approach: O(n²)
For each node, check all paths starting from that node.
```typescript
function pathSum(root, targetSum) {
  // For each node, count paths from that node
  let count = countFrom(root, targetSum);
  count += pathSum(root.left, targetSum);  // Recur left
  count += pathSum(root.right, targetSum); // Recur right
  return count;
}
```

## Optimal Approach: O(n) with Prefix Sum

Use the **exact same pattern** as "Subarray Sum Equals K" from Module 2!

```typescript
function pathSum(root, targetSum) {
  let prefixSums = new Map();
  prefixSums.set(0, 1);  // Base case

  function dfs(node, currentSum) {
    if (!node) return;

    currentSum += node.val;

    // How many previous paths have sum = (current - target)?
    let complement = currentSum - targetSum;
    count += prefixSums.get(complement) || 0;

    // Add current sum
    prefixSums.set(currentSum, (prefixSums.get(currentSum) || 0) + 1);

    dfs(node.left, currentSum);
    dfs(node.right, currentSum);

    // Backtrack!
    prefixSums.set(currentSum, prefixSums.get(currentSum) - 1);
  }

  dfs(root, 0);
}
```

## Key Insight:
Prefix sum + hash map works on trees too, not just arrays!

Time: O(n² ) → O(n)
```

**Next**: Item 16

---

### **ITEM 15B: Hint - Prefix Sum Pattern**
**Type**: Lesson Only
**Duration**: 3 minutes

**Content**:
```
# Hint: Remember Subarray Sum?

This is the SAME pattern as "Subarray Sum Equals K" from Module 2!

## Recall:
```typescript
// For arrays:
prefixSum[j] - prefixSum[i] = target
→ Look for: prefixSum[i] = prefixSum[j] - target
```

## For trees:
As you DFS through the tree, maintain:
1. **Current prefix sum** from root to current node
2. **Hash map** of all prefix sums seen on current path
3. Check: `currentSum - target` in hash map?

## Don't Forget:
**Backtrack!** When returning from recursion, remove current sum from map.

Try implementing this approach →
```

**Next**: Item 15 (resubmit)

---

### **ITEM 16: Lowest Common Ancestor**
**Type**: Lesson + Problem
**Duration**: 12-15 minutes

**Left Panel (Lesson)**:
```
# Lowest Common Ancestor (LCA)

**Problem**: Find the lowest (deepest) ancestor shared by two nodes.

```
        3
       / \
      5   1
     / \ / \
    6  2 0  8
      / \
     7   4

LCA(5, 1) = 3
LCA(5, 4) = 5  (node can be ancestor of itself!)
LCA(6, 4) = 5
```

## Think About:
- How do you know if a node is the LCA?
- What information do you need from left and right subtrees?
- Can you use postorder traversal (process children first)?

This is a classic postorder problem. Try solving it on the right →
```

**Right Panel (Problem)**: `tree-13` (Lowest Common Ancestor of Binary Tree)

**Solution Analysis**:

```typescript
// OPTIMAL: Postorder DFS
function lowestCommonAncestor(
  root: TreeNode | null,
  p: TreeNode,
  q: TreeNode
): TreeNode | null {
  if (!root || root === p || root === q) return root;

  let left = lowestCommonAncestor(root.left, p, q);
  let right = lowestCommonAncestor(root.right, p, q);

  // Both found in different subtrees? Current node is LCA
  if (left && right) return root;

  // Otherwise return whichever is non-null
  return left || right;
}
```

**Next**: Item 17

---

### **ITEM 17: Serialize and Deserialize**
**Type**: Lesson + Problem
**Duration**: 15-20 minutes

**Left Panel (Lesson)**:
```
# Serialize and Deserialize Tree

**Problem**: Convert tree to string, and reconstruct tree from string.

```
    1
   / \
  2   3
     / \
    4   5

Serialize: "1,2,null,null,3,4,null,null,5,null,null"
Deserialize: Reconstruct the tree
```

## Key Decisions:
1. **Which traversal?** Preorder makes reconstruction easiest
2. **How to mark nulls?** Use "null" or "#"
3. **How to parse?** Queue for deserialization

## Preorder Serialization:
```typescript
function serialize(root: TreeNode | null): string {
  if (!root) return "null";

  return root.val + "," +
         serialize(root.left) + "," +
         serialize(root.right);
}
```

Try implementing both serialize and deserialize on the right →
```

**Right Panel (Problem)**: `tree-14` (Serialize and Deserialize Binary Tree)

**Next**: Item 18

---

### **ITEM 18: Construct Tree from Traversals**
**Type**: Lesson + Problem
**Duration**: 15-20 minutes

**Left Panel (Lesson)**:
```
# Construct Tree from Inorder + Preorder

**Problem**: Given inorder and preorder traversals, reconstruct the tree.

```
Preorder: [3, 9, 20, 15, 7]  (Root → Left → Right)
Inorder:  [9, 3, 15, 20, 7]  (Left → Root → Right)

Result:
    3
   / \
  9  20
    /  \
   15   7
```

## Key Insights:

1. **Preorder[0]** is always the root
2. Find root in **inorder** → everything left is left subtree, right is right subtree
3. Recursively build left and right subtrees

## Optimization:
Use a **hash map** to find root position in inorder in O(1) instead of O(n).

Time: O(n²) → O(n) with hash map!

This combines trees + hash maps perfectly. Try solving it on the right →
```

**Right Panel (Problem)**: `tree-15` (Construct Binary Tree from Preorder and Inorder Traversal)

**Solution Analysis**:

```typescript
// OPTIMAL: Recursive with hash map for inorder indices
function buildTree(preorder: number[], inorder: number[]): TreeNode | null {
  // Build hash map for O(1) lookups
  let inorderMap = new Map<number, number>();
  for (let i = 0; i < inorder.length; i++) {
    inorderMap.set(inorder[i], i);
  }

  function build(preStart: number, preEnd: number, inStart: number, inEnd: number): TreeNode | null {
    if (preStart > preEnd) return null;

    let rootVal = preorder[preStart];
    let root = new TreeNode(rootVal);

    let inorderRootIdx = inorderMap.get(rootVal)!;
    let leftSize = inorderRootIdx - inStart;

    root.left = build(preStart + 1, preStart + leftSize, inStart, inorderRootIdx - 1);
    root.right = build(preStart + leftSize + 1, preEnd, inorderRootIdx + 1, inEnd);

    return root;
  }

  return build(0, preorder.length - 1, 0, inorder.length - 1);
}

// SUBOPTIMAL: Find root in inorder with indexOf (O(n) per call → O(n²) total)
function buildTree(preorder: number[], inorder: number[]): TreeNode | null {
  if (preorder.length === 0) return null;

  let rootVal = preorder[0];
  let root = new TreeNode(rootVal);

  let inorderRootIdx = inorder.indexOf(rootVal);  // O(n) search

  root.left = buildTree(
    preorder.slice(1, inorderRootIdx + 1),
    inorder.slice(0, inorderRootIdx)
  );
  root.right = buildTree(
    preorder.slice(inorderRootIdx + 1),
    inorder.slice(inorderRootIdx + 1)
  );

  return root;
}
```

**Next**: Module complete!

---

## Module Completion

After Item 18, show:

```
# 🎉 Module 6 Complete!

You've mastered:
✅ Tree fundamentals and structure
✅ DFS traversals (preorder, inorder, postorder)
✅ Recursive tree algorithms
✅ BFS and level-order traversal
✅ Trees + Hash Maps for O(n) solutions
✅ Tree construction and serialization

## Key Patterns Learned:

1. **DFS Recursion**: Most tree problems are recursive
2. **Base Case**: Always handle null nodes
3. **Postorder for Bottom-Up**: Process children first, then use results
4. **BFS for Levels**: Use queue + capture level size
5. **Trees + Hash Maps**: Prefix sums, fast lookups, O(n²) → O(n)

## Problems Solved: 15

Next: **Module 7: Binary Search & Sorting** →
```

---

## Problems Required

This module requires these problems to exist in `/lib/content/problems/trees.ts`:

1. `tree-1`: Maximum Depth of Binary Tree (EASY)
2. `tree-2`: Binary Tree Preorder Traversal (EASY)
3. `tree-3`: Binary Tree Inorder Traversal (EASY)
4. `tree-4`: Binary Tree Postorder Traversal (EASY)
5. `tree-5`: Path Sum (EASY)
6. `tree-6`: Invert Binary Tree (EASY)
7. `tree-7`: Symmetric Tree (EASY)
8. `tree-8`: Same Tree (EASY)
9. `tree-9`: Binary Tree Level Order Traversal (MEDIUM)
10. `tree-10`: Binary Tree Right Side View (MEDIUM)
11. `tree-11`: Binary Tree Zigzag Level Order Traversal (MEDIUM)
12. `tree-12`: Path Sum III (MEDIUM) ⭐⭐⭐ CRITICAL
13. `tree-13`: Lowest Common Ancestor of Binary Tree (MEDIUM) ⭐⭐⭐ CRITICAL
14. `tree-14`: Serialize and Deserialize Binary Tree (HARD)
15. `tree-15`: Construct Binary Tree from Preorder and Inorder Traversal (MEDIUM)

---

## State Machine Summary

```typescript
// Item 2: First tree problem
if (recursiveDFS && correct) → Item 3A (DFS natural)
else if (iterativeBFS && correct) → Item 3B (BFS first)
else → Item 3C (hint) → Item 2 (retry)

// Item 4: Preorder traversal
if (recursive && correct) → Item 5
else if (iterativeStack && correct) → Item 4A (iterative insight) → Item 5
else → Item 4B (hint) → Item 4 (retry)

// Item 7: Path sum
if (optimal) → Item 8
else if (tracksFullPath) → Item 7A (space optimization) → Item 8
else → Item 7B (hint) → Item 7 (retry)

// Item 15: Path sum III
if (prefixSumHashMap && backtracking) → Item 16
else if (bruteForce && correct) → Item 15A (optimize) → Item 16
else → Item 15B (hint) → Item 15 (retry)
```

---

## Implementation Notes

1. **Solution Analyzer**: Must detect:
   - Recursive vs iterative approaches
   - DFS vs BFS
   - Space complexity (full path tracking vs optimal)
   - Hash map usage and backtracking

2. **UI Components**:
   - Tree visualization widget
   - Preorder/inorder/postorder highlighting
   - BFS level-by-level animation
   - Path highlighting for path sum problems

3. **Test Cases**:
   - Empty trees
   - Single node
   - Skewed trees (all left or all right)
   - Complete binary trees
   - Trees with negative values (for path sum)

---

This specification follows the exact adaptive learning pattern established in Modules 1-3 and prepares students for the critical tree patterns seen in 15-20% of FAANG interviews.
