# Module 8: Graphs & BFS/DFS

## Overview
This module teaches graph data structures and traversal algorithms through adaptive learning. Students learn graph representation, master DFS and BFS on graphs, and solve classic graph problems like cycle detection, shortest paths, and connected components.

**Total Items**: 20
**Estimated Time**: 5-6 hours
**Prerequisites**: Module 1 (Arrays), Module 2 (Hash Maps), Module 4 (Trees)

---

## Learning Philosophy

Following the IdleCampus adaptive learning approach:
1. **Present Problem First**: User encounters the problem before seeing the pattern
2. **Detect Approach**: Analyze if user writes iterative/DFS/BFS solution
3. **Adaptive Branching**: Different learning paths based on user's solution
4. **Guide, Don't Give Away**: Provide hints and understanding, never the answer
5. **Brute Force → Optimization**: Help user understand graph traversal techniques

---

## Module Structure

### Part 1: Graph Fundamentals & DFS (Items 1-8)
- Graph representation (adjacency list, matrix)
- DFS on graphs
- Visited tracking and cycle detection
- Connected components

### Part 2: BFS & Shortest Paths (Items 9-14)
- BFS on graphs
- Shortest path in unweighted graphs
- Level-order processing
- Multi-source BFS

### Part 3: Advanced Graph Problems (Items 15-20)
- Topological sort
- Union-Find (Disjoint Set)
- Graph + Hash Map combinations
- Island problems and matrix DFS

---

## Detailed Item Specifications

### **ITEM 1: Introduction to Graphs**
**Type**: Lesson Only
**Duration**: 5 minutes

**Content**:
```
# Graphs: Connected Data Structures

A graph is a collection of **nodes** (vertices) connected by **edges**.

## Types of Graphs:

**Undirected Graph**: Edges have no direction
```
  1 --- 2
  |     |
  3 --- 4
```

**Directed Graph** (Digraph): Edges have direction
```
  1 → 2
  ↓   ↓
  3 → 4
```

**Weighted Graph**: Edges have weights/costs
```
    5
  1 --- 2
  |     |
  3     10
  |     |
  3 --- 4
    2
```

## Graph Representation:

**Adjacency List** (most common):
```typescript
let graph = new Map<number, number[]>();
graph.set(1, [2, 3]);  // Node 1 connects to 2 and 3
graph.set(2, [1, 4]);
graph.set(3, [1, 4]);
graph.set(4, [2, 3]);
```

**Adjacency Matrix**:
```typescript
let matrix = [
  [0, 1, 1, 0],  // Node 0 connects to 1, 2
  [1, 0, 0, 1],  // Node 1 connects to 0, 3
  [1, 0, 0, 1],  // Node 2 connects to 0, 3
  [0, 1, 1, 0]   // Node 3 connects to 1, 2
];
```

## Common Graph Problems:
- Is there a path between two nodes?
- What's the shortest path?
- Does the graph have cycles?
- How many connected components?
- What's the order of dependencies? (topological sort)

## Why Graphs Matter:
- Social networks (friends, followers)
- Map navigation (roads, routes)
- Web pages (links)
- Dependencies (build systems, course prerequisites)
- 15-20% of FAANG interviews involve graphs!

Let's start with graph traversal.
```

**Next**: Item 2

---

### **ITEM 2: First Graph Problem - Clone Graph**
**Type**: Lesson + Problem
**Duration**: 12-15 minutes

**Left Panel (Lesson)**:
```
# Your First Graph Problem

**Problem**: Clone (deep copy) an undirected graph.

```
Input:
  1 --- 2
  |     |
  4 --- 3

Output: A complete copy (new nodes, same structure)
```

Node definition:
```typescript
class Node {
  val: number;
  neighbors: Node[];
}
```

## Think About:
- How do you visit all nodes?
- How do you avoid visiting the same node twice?
- How do you map old nodes to new nodes?

## Key Insight:
You need to **traverse the graph** (visit all nodes) and maintain a mapping from old to new nodes.

Try solving this problem on the right →
```

**Right Panel (Problem)**: `graph-1` (Clone Graph)

**Solution Analysis**:

```typescript
// OPTIMAL: DFS with hash map
function cloneGraph(node: Node | null): Node | null {
  if (!node) return null;

  let map = new Map<Node, Node>();  // old → new mapping

  function dfs(node: Node): Node {
    if (map.has(node)) return map.get(node)!;

    // Create clone
    let clone = new Node(node.val);
    map.set(node, clone);  // Map before recursion!

    // Clone neighbors
    for (let neighbor of node.neighbors) {
      clone.neighbors.push(dfs(neighbor));
    }

    return clone;
  }

  return dfs(node);
}

// ALSO OPTIMAL: BFS with hash map
function cloneGraph(node: Node | null): Node | null {
  if (!node) return null;

  let map = new Map<Node, Node>();
  let queue = [node];

  // Create clone of start node
  map.set(node, new Node(node.val));

  while (queue.length > 0) {
    let current = queue.shift()!;

    for (let neighbor of current.neighbors) {
      if (!map.has(neighbor)) {
        map.set(neighbor, new Node(neighbor.val));
        queue.push(neighbor);
      }
      map.get(current)!.neighbors.push(map.get(neighbor)!);
    }
  }

  return map.get(node)!;
}
```

**State Machine Routing**:

```typescript
if (solution.isDFS() && solution.usesHashMap()) {
  return "item-3-dfs-explained";
} else if (solution.isBFS() && solution.usesHashMap()) {
  return "item-3-bfs-explained";
} else {
  return "item-2a-graph-traversal-hint";
}
```

---

### **ITEM 2A: Graph Traversal Hint**
**Type**: Lesson Only
**Duration**: 3 minutes

**Content**:
```
# Hint: Traversal + Mapping

To clone a graph, you need two things:

1. **Traverse all nodes** (visit every node)
2. **Map old nodes to new nodes** (avoid creating duplicates)

## Pattern:

```typescript
function cloneGraph(node: Node | null): Node | null {
  if (!node) return null;

  let map = new Map<Node, Node>();  // old → new

  function dfs(oldNode: Node): Node {
    // Already cloned?
    if (map.has(oldNode)) return map.get(oldNode)!;

    // Create clone
    let newNode = new Node(oldNode.val);
    map.set(oldNode, newNode);  // IMPORTANT: set before recursion!

    // Clone neighbors (recursive DFS)
    for (let neighbor of oldNode.neighbors) {
      newNode.neighbors.push(dfs(neighbor));
    }

    return newNode;
  }

  return dfs(node);
}
```

## Why Map Before Recursion?
Prevents infinite loops in cyclic graphs!

Try implementing this approach →
```

**Next**: Item 2 (resubmit)

---

### **ITEM 3: DFS on Graphs Explained**
**Type**: Lesson Only
**Duration**: 4 minutes
**Condition**: User wrote DFS solution

**Content**:
```
# Depth-First Search (DFS) on Graphs

Excellent! Your solution uses **DFS** - the same pattern as trees, but with **cycle handling**.

## DFS on Trees vs Graphs:

**Trees**:
```typescript
function dfs(node: TreeNode | null) {
  if (!node) return;
  process(node);
  dfs(node.left);
  dfs(node.right);
}
```

**Graphs** (need visited tracking):
```typescript
function dfs(node: Node, visited: Set<Node>) {
  if (visited.has(node)) return;  // Prevent cycles!
  visited.add(node);

  process(node);

  for (let neighbor of node.neighbors) {
    dfs(neighbor, visited);
  }
}
```

## Key Difference:
**Graphs can have cycles**, so we need a `visited` set to avoid infinite loops!

## DFS Pattern for Graphs:

```typescript
function dfs(graph: Map<number, number[]>, start: number) {
  let visited = new Set<number>();

  function visit(node: number) {
    if (visited.has(node)) return;
    visited.add(node);

    // Process node
    console.log(node);

    // Visit neighbors
    for (let neighbor of graph.get(node) || []) {
      visit(neighbor);
    }
  }

  visit(start);
}
```

Let's practice DFS on more graph problems!
```

**Next**: Item 4

---

### **ITEM 3: BFS on Graphs Explained**
**Type**: Lesson Only (Alternative)
**Duration**: 4 minutes
**Condition**: User wrote BFS solution

**Content**:
```
# Breadth-First Search (BFS) on Graphs

Great! Your solution uses **BFS** - level-by-level exploration with cycle handling.

## BFS Pattern for Graphs:

```typescript
function bfs(graph: Map<number, number[]>, start: number) {
  let visited = new Set<number>();
  let queue = [start];
  visited.add(start);

  while (queue.length > 0) {
    let node = queue.shift()!;

    // Process node
    console.log(node);

    // Add unvisited neighbors to queue
    for (let neighbor of graph.get(node) || []) {
      if (!visited.has(neighbor)) {
        visited.add(neighbor);
        queue.push(neighbor);
      }
    }
  }
}
```

## Key Points:
1. **Mark visited when adding to queue** (not when processing)
2. Use **queue** for FIFO (first in, first out)
3. BFS finds **shortest paths** in unweighted graphs!

## BFS vs DFS:

**BFS**:
- Uses queue
- Explores by levels
- Finds shortest path
- More memory (queue can be large)

**DFS**:
- Uses recursion/stack
- Explores deeply first
- Less memory (recursion stack)
- Doesn't guarantee shortest path

Both are important! Let's practice more.
```

**Next**: Item 4

---

### **ITEM 4: Number of Islands**
**Type**: Lesson + Problem
**Duration**: 12-15 minutes

**Left Panel (Lesson)**:
```
# DFS Application: Number of Islands

**Problem**: Count islands in a 2D grid. '1' is land, '0' is water. Islands are connected horizontally or vertically.

```
Input:
[
  ['1','1','0','0','0'],
  ['1','1','0','0','0'],
  ['0','0','1','0','0'],
  ['0','0','0','1','1']
]

Output: 3 islands
```

## Key Insight:
This is a **graph problem in disguise**!

Each land cell is a node. Edges connect adjacent land cells.

## Approach:
1. Iterate through grid
2. When you find unvisited land ('1'), it's a new island
3. Use DFS to mark all connected land as visited
4. Count how many times we start a new DFS

```typescript
function numIslands(grid: string[][]): number {
  let count = 0;

  function dfs(row: number, col: number) {
    // Bounds check and water check
    if (row < 0 || row >= grid.length ||
        col < 0 || col >= grid[0].length ||
        grid[row][col] === '0') {
      return;
    }

    grid[row][col] = '0';  // Mark as visited

    // Visit 4 neighbors
    dfs(row + 1, col);
    dfs(row - 1, col);
    dfs(row, col + 1);
    dfs(row, col - 1);
  }

  for (let i = 0; i < grid.length; i++) {
    for (let j = 0; j < grid[0].length; j++) {
      if (grid[i][j] === '1') {
        count++;
        dfs(i, j);  // Mark entire island
      }
    }
  }

  return count;
}
```

Try solving this problem on the right →
```

**Right Panel (Problem)**: `graph-2` (Number of Islands)

**Solution Analysis**:

```typescript
// OPTIMAL: DFS marking cells as visited
function numIslands(grid: string[][]): number {
  if (!grid.length) return 0;

  let count = 0;
  let rows = grid.length;
  let cols = grid[0].length;

  function dfs(r: number, c: number) {
    if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] === '0') {
      return;
    }

    grid[r][c] = '0';  // Mark visited

    dfs(r + 1, c);
    dfs(r - 1, c);
    dfs(r, c + 1);
    dfs(r, c - 1);
  }

  for (let i = 0; i < rows; i++) {
    for (let j = 0; j < cols; j++) {
      if (grid[i][j] === '1') {
        count++;
        dfs(i, j);
      }
    }
  }

  return count;
}

// ALSO GOOD: Use separate visited set
function numIslands(grid: string[][]): number {
  let visited = new Set<string>();
  let count = 0;

  function dfs(r: number, c: number) {
    let key = `${r},${c}`;
    if (r < 0 || r >= rows || c < 0 || c >= cols ||
        grid[r][c] === '0' || visited.has(key)) {
      return;
    }

    visited.add(key);
    dfs(r + 1, c);
    dfs(r - 1, c);
    dfs(r, c + 1);
    dfs(r, c - 1);
  }

  // ... rest same
}
```

**Next**: Item 5

---

### **ITEM 5: Max Area of Island**
**Type**: Problem Only
**Duration**: 10-12 minutes

**Left Panel (Problem Context)**:
```
# Practice: Max Area of Island

Similar to Number of Islands, but now return the **maximum island area**.

**Problem**: Find the largest island area.

```
Input:
[
  [0,0,1,0,0],
  [0,0,0,0,0],
  [0,0,0,1,1],
  [0,1,0,0,1],
  [0,1,0,0,1]
]

Output: 4  (bottom-right island)
```

## Hint:
Use DFS, but return the area count from each DFS call!

```typescript
function dfs(row: number, col: number): number {
  // Base cases return 0
  // Otherwise: return 1 + dfs(neighbors)
}
```
```

**Right Panel (Problem)**: `graph-3` (Max Area of Island)

**Next**: Item 6

---

### **ITEM 6: Course Schedule (Cycle Detection)**
**Type**: Lesson + Problem
**Duration**: 15-18 minutes

**Left Panel (Lesson)**:
```
# Cycle Detection with DFS

**Problem**: Can you finish all courses given prerequisites?

```
Input: numCourses = 2, prerequisites = [[1,0]]
Output: true
Explanation: Take course 0, then course 1

Input: numCourses = 2, prerequisites = [[1,0], [0,1]]
Output: false
Explanation: Circular dependency! Can't complete.
```

## Key Insight:
This is a **directed graph cycle detection** problem!

Courses are nodes, prerequisites are directed edges.
If there's a cycle, you can't complete all courses.

## DFS Cycle Detection:

Track each node's state:
- **Unvisited** (0): Haven't explored yet
- **Visiting** (1): Currently in DFS path
- **Visited** (2): Completely processed

If we reach a "Visiting" node, we found a cycle!

```typescript
function canFinish(numCourses: number, prerequisites: number[][]): boolean {
  // Build adjacency list
  let graph = new Map<number, number[]>();
  for (let [course, prereq] of prerequisites) {
    if (!graph.has(course)) graph.set(course, []);
    graph.get(course)!.push(prereq);
  }

  let state = new Array(numCourses).fill(0);  // 0=unvisited, 1=visiting, 2=visited

  function hasCycle(course: number): boolean {
    if (state[course] === 1) return true;   // Cycle!
    if (state[course] === 2) return false;  // Already checked

    state[course] = 1;  // Mark as visiting

    for (let prereq of graph.get(course) || []) {
      if (hasCycle(prereq)) return true;
    }

    state[course] = 2;  // Mark as visited
    return false;
  }

  for (let i = 0; i < numCourses; i++) {
    if (hasCycle(i)) return false;
  }

  return true;
}
```

Try solving this problem on the right →
```

**Right Panel (Problem)**: `graph-4` (Course Schedule)

**Next**: Item 7

---

### **ITEM 7: Course Schedule II (Topological Sort)**
**Type**: Lesson + Problem
**Duration**: 15-18 minutes

**Left Panel (Lesson)**:
```
# Topological Sort

**Problem**: Return the order to take courses.

```
Input: numCourses = 4, prerequisites = [[1,0], [2,0], [3,1], [3,2]]
Output: [0, 1, 2, 3] or [0, 2, 1, 3]

Explanation:
  0 → 1 → 3
  0 → 2 ↗
```

## Topological Sort:
Linear ordering of nodes where all dependencies come before dependents.

## DFS Approach:
Use **postorder** - add node to result AFTER visiting all dependencies.

```typescript
function findOrder(numCourses: number, prerequisites: number[][]): number[] {
  let graph = new Map<number, number[]>();
  for (let [course, prereq] of prerequisites) {
    if (!graph.has(course)) graph.set(course, []);
    graph.get(course)!.push(prereq);
  }

  let state = new Array(numCourses).fill(0);
  let result: number[] = [];

  function dfs(course: number): boolean {
    if (state[course] === 1) return false;  // Cycle
    if (state[course] === 2) return true;   // Already processed

    state[course] = 1;  // Visiting

    for (let prereq of graph.get(course) || []) {
      if (!dfs(prereq)) return false;
    }

    state[course] = 2;  // Visited
    result.push(course);  // Add in postorder!
    return true;
  }

  for (let i = 0; i < numCourses; i++) {
    if (!dfs(i)) return [];  // Cycle detected
  }

  return result;  // Already in topological order!
}
```

Try solving this problem on the right →
```

**Right Panel (Problem)**: `graph-5` (Course Schedule II)

**Next**: Item 8

---

### **ITEM 8: Pacific Atlantic Water Flow**
**Type**: Problem Only
**Duration**: 15-18 minutes

**Left Panel (Problem Context)**:
```
# Practice: Multi-Source DFS

**Problem**: Find cells where water can flow to both Pacific and Atlantic oceans.

```
Grid (heights):
[
  [1, 2, 2, 3, 5],
  [3, 2, 3, 4, 4],
  [2, 4, 5, 3, 1],
  [6, 7, 1, 4, 5],
  [5, 1, 1, 2, 4]
]

Pacific touches top and left edges
Atlantic touches bottom and right edges

Output: Cells that can reach both oceans
```

## Hint:
Instead of DFS from each cell, do **reverse DFS** from ocean edges!

1. DFS from Pacific edges (top, left) → mark reachable cells
2. DFS from Atlantic edges (bottom, right) → mark reachable cells
3. Return cells marked by both

This is **multi-source DFS** - a common pattern!
```

**Right Panel (Problem)**: `graph-6` (Pacific Atlantic Water Flow)

**Next**: Item 9

---

### **ITEM 9: Introduction to BFS on Graphs**
**Type**: Lesson Only
**Duration**: 4 minutes

**Content**:
```
# BFS: The Shortest Path Algorithm

Welcome to Part 2! While DFS goes deep, **BFS explores level by level**.

## When to Use BFS:

✅ **Finding shortest path** (unweighted graph)
✅ Level-order traversal
✅ Minimum steps problems
✅ Multi-source problems

## BFS Pattern:

```typescript
function bfs(graph: Map<number, number[]>, start: number) {
  let visited = new Set<number>();
  let queue = [start];
  visited.add(start);

  while (queue.length > 0) {
    let node = queue.shift()!;

    // Process node
    console.log(node);

    // Add unvisited neighbors
    for (let neighbor of graph.get(node) || []) {
      if (!visited.has(neighbor)) {
        visited.add(neighbor);
        queue.push(neighbor);
      }
    }
  }
}
```

## Key Insight:
**BFS visits nodes in order of distance from start.**

Level 0: Start node
Level 1: Neighbors of start
Level 2: Neighbors of level 1
...

This guarantees **shortest path** in unweighted graphs!

Let's practice BFS problems.
```

**Next**: Item 10

---

### **ITEM 10: Shortest Path in Binary Matrix**
**Type**: Lesson + Problem
**Duration**: 12-15 minutes

**Left Panel (Lesson)**:
```
# BFS for Shortest Path

**Problem**: Find shortest clear path in binary matrix (0 = clear, 1 = blocked). Can move in 8 directions.

```
Input:
[
  [0,0,0],
  [1,1,0],
  [1,1,0]
]

Output: 4
Path: (0,0) → (0,1) → (0,2) → (1,2) → (2,2)
```

## Why BFS?
BFS explores by **distance levels**, so the first time we reach the target is the shortest path!

## BFS with Distance Tracking:

```typescript
function shortestPathBinaryMatrix(grid: number[][]): number {
  if (grid[0][0] === 1) return -1;

  let n = grid.length;
  let queue: [number, number, number][] = [[0, 0, 1]];  // row, col, distance
  let visited = new Set<string>();
  visited.add("0,0");

  let directions = [
    [-1,-1], [-1,0], [-1,1],
    [0,-1],          [0,1],
    [1,-1],  [1,0],  [1,1]
  ];

  while (queue.length > 0) {
    let [row, col, dist] = queue.shift()!;

    if (row === n - 1 && col === n - 1) return dist;

    for (let [dr, dc] of directions) {
      let newR = row + dr;
      let newC = col + dc;
      let key = `${newR},${newC}`;

      if (newR >= 0 && newR < n && newC >= 0 && newC < n &&
          grid[newR][newC] === 0 && !visited.has(key)) {
        visited.add(key);
        queue.push([newR, newC, dist + 1]);
      }
    }
  }

  return -1;
}
```

Try solving this problem on the right →
```

**Right Panel (Problem)**: `graph-7` (Shortest Path in Binary Matrix)

**Next**: Item 11

---

### **ITEM 11: Rotting Oranges (Multi-Source BFS)**
**Type**: Lesson + Problem
**Duration**: 12-15 minutes

**Left Panel (Lesson)**:
```
# Multi-Source BFS

**Problem**: Fresh oranges become rotten if adjacent to rotten orange (every minute). How many minutes until all oranges rot?

```
Input:
[
  [2,1,1],
  [1,1,0],
  [0,1,1]
]

Output: 4

Minute 0: [2,1,1]   Minute 1: [2,2,1]   Minute 2: [2,2,2]
          [1,1,0]             [2,1,0]             [2,2,0]
          [0,1,1]             [0,1,1]             [0,2,1]

Minute 3: [2,2,2]   Minute 4: [2,2,2]
          [2,2,0]             [2,2,0]
          [0,2,2]             [0,2,2]
```

## Key Insight:
**Start BFS from ALL rotten oranges simultaneously!**

This is **multi-source BFS** - add all starting points to queue initially.

```typescript
function orangesRotting(grid: number[][]): number {
  let queue: [number, number][] = [];
  let fresh = 0;

  // Find all initial rotten oranges and count fresh
  for (let i = 0; i < grid.length; i++) {
    for (let j = 0; j < grid[0].length; j++) {
      if (grid[i][j] === 2) queue.push([i, j]);
      if (grid[i][j] === 1) fresh++;
    }
  }

  if (fresh === 0) return 0;

  let minutes = 0;
  let directions = [[0,1], [0,-1], [1,0], [-1,0]];

  while (queue.length > 0) {
    let size = queue.length;  // Process entire level

    for (let i = 0; i < size; i++) {
      let [row, col] = queue.shift()!;

      for (let [dr, dc] of directions) {
        let newR = row + dr, newC = col + dc;

        if (newR >= 0 && newR < grid.length &&
            newC >= 0 && newC < grid[0].length &&
            grid[newR][newC] === 1) {
          grid[newR][newC] = 2;
          fresh--;
          queue.push([newR, newC]);
        }
      }
    }

    minutes++;
  }

  return fresh === 0 ? minutes - 1 : -1;
}
```

Try solving this problem on the right →
```

**Right Panel (Problem)**: `graph-8` (Rotting Oranges)

**Next**: Item 12

---

### **ITEM 12: Word Ladder**
**Type**: Lesson + Problem
**Duration**: 15-20 minutes

**Left Panel (Lesson)**:
```
# BFS for Shortest Transformation

**Problem**: Transform beginWord to endWord, changing one letter at a time. Each intermediate word must be in wordList.

```
Input:
beginWord = "hit"
endWord = "cog"
wordList = ["hot","dot","dog","lot","log","cog"]

Output: 5
Explanation: hit → hot → dot → dog → cog
```

## Key Insight:
This is a **shortest path problem** in disguise!

Graph:
- Nodes = words
- Edges = one letter difference

Use **BFS** to find shortest path!

## Implementation:

```typescript
function ladderLength(beginWord: string, endWord: string, wordList: string[]): number {
  let wordSet = new Set(wordList);
  if (!wordSet.has(endWord)) return 0;

  let queue: [string, number][] = [[beginWord, 1]];
  let visited = new Set<string>();
  visited.add(beginWord);

  while (queue.length > 0) {
    let [word, steps] = queue.shift()!;

    if (word === endWord) return steps;

    // Try changing each letter
    for (let i = 0; i < word.length; i++) {
      for (let c = 97; c <= 122; c++) {  // 'a' to 'z'
        let newWord = word.slice(0, i) + String.fromCharCode(c) + word.slice(i + 1);

        if (wordSet.has(newWord) && !visited.has(newWord)) {
          visited.add(newWord);
          queue.push([newWord, steps + 1]);
        }
      }
    }
  }

  return 0;
}
```

Try solving this problem on the right →
```

**Right Panel (Problem)**: `graph-9` (Word Ladder)

**Next**: Item 13

---

### **ITEM 13: 01 Matrix**
**Type**: Problem Only
**Duration**: 12-15 minutes

**Left Panel (Problem Context)**:
```
# Practice: Multi-Source BFS

**Problem**: For each cell, find distance to nearest 0.

```
Input:
[
  [0,0,0],
  [0,1,0],
  [1,1,1]
]

Output:
[
  [0,0,0],
  [0,1,0],
  [1,2,1]
]
```

## Hint:
Use **multi-source BFS** starting from all 0 cells!

1. Add all 0 cells to queue initially
2. BFS from all 0s simultaneously
3. Track distance as you expand

This is more efficient than BFS from each cell individually.
```

**Right Panel (Problem)**: `graph-10` (01 Matrix)

**Next**: Item 14

---

### **ITEM 14: Walls and Gates**
**Type**: Problem Only
**Duration**: 12-15 minutes

**Left Panel (Problem Context)**:
```
# Practice: Multi-Source BFS

**Problem**: Fill each room with distance to nearest gate.

```
Input:
INF  -1  0  INF
INF INF INF  -1
INF  -1 INF  -1
  0  -1 INF INF

(INF = empty room, 0 = gate, -1 = wall)

Output:
  3  -1   0   1
  2   2   1  -1
  1  -1   2  -1
  0  -1   3   4
```

## Hint:
Multi-source BFS from all gates (0 cells)!

Similar to 01 Matrix and Rotting Oranges pattern.
```

**Right Panel (Problem)**: `graph-11` (Walls and Gates)

**Next**: Item 15

---

### **ITEM 15: Union-Find Introduction**
**Type**: Lesson Only
**Duration**: 5 minutes

**Content**:
```
# Union-Find (Disjoint Set Union)

Union-Find is a data structure for tracking **connected components**.

## Two Operations:

**Find**: Which component does this element belong to?
**Union**: Merge two components

## Implementation:

```typescript
class UnionFind {
  private parent: number[];
  private rank: number[];

  constructor(n: number) {
    this.parent = Array.from({length: n}, (_, i) => i);  // Each element is its own parent
    this.rank = new Array(n).fill(0);
  }

  find(x: number): number {
    if (this.parent[x] !== x) {
      this.parent[x] = this.find(this.parent[x]);  // Path compression
    }
    return this.parent[x];
  }

  union(x: number, y: number): boolean {
    let rootX = this.find(x);
    let rootY = this.find(y);

    if (rootX === rootY) return false;  // Already in same set

    // Union by rank
    if (this.rank[rootX] < this.rank[rootY]) {
      this.parent[rootX] = rootY;
    } else if (this.rank[rootX] > this.rank[rootY]) {
      this.parent[rootY] = rootX;
    } else {
      this.parent[rootY] = rootX;
      this.rank[rootX]++;
    }

    return true;
  }
}
```

## Time Complexity:
Nearly O(1) for both find and union (amortized α(n) where α is inverse Ackermann)

## When to Use:
- Detecting cycles in undirected graphs
- Finding connected components
- Minimum spanning tree (Kruskal's algorithm)
- Dynamic connectivity

Let's practice!
```

**Next**: Item 16

---

### **ITEM 16: Number of Connected Components**
**Type**: Lesson + Problem
**Duration**: 12-15 minutes

**Left Panel (Lesson)**:
```
# Union-Find for Connected Components

**Problem**: Count connected components in undirected graph.

```
Input: n = 5, edges = [[0,1], [1,2], [3,4]]
Output: 2

Components: {0,1,2} and {3,4}
```

## Union-Find Approach:

```typescript
function countComponents(n: number, edges: number[][]): number {
  let uf = new UnionFind(n);
  let components = n;

  for (let [u, v] of edges) {
    if (uf.union(u, v)) {
      components--;  // Merged two components
    }
  }

  return components;
}
```

## Alternative: DFS

```typescript
function countComponents(n: number, edges: number[][]): number {
  let graph = new Map<number, number[]>();
  for (let [u, v] of edges) {
    if (!graph.has(u)) graph.set(u, []);
    if (!graph.has(v)) graph.set(v, []);
    graph.get(u)!.push(v);
    graph.get(v)!.push(u);
  }

  let visited = new Set<number>();
  let count = 0;

  function dfs(node: number) {
    if (visited.has(node)) return;
    visited.add(node);
    for (let neighbor of graph.get(node) || []) {
      dfs(neighbor);
    }
  }

  for (let i = 0; i < n; i++) {
    if (!visited.has(i)) {
      count++;
      dfs(i);
    }
  }

  return count;
}
```

Both approaches work! Union-Find is often cleaner for this problem.

Try solving it on the right →
```

**Right Panel (Problem)**: `graph-12` (Number of Connected Components in an Undirected Graph)

**Next**: Item 17

---

### **ITEM 17: Graph Valid Tree**
**Type**: Lesson + Problem
**Duration**: 15-18 minutes

**Left Panel (Lesson)**:
```
# Validating Trees with Union-Find

**Problem**: Check if edges form a valid tree.

```
Input: n = 5, edges = [[0,1], [0,2], [0,3], [1,4]]
Output: true

Input: n = 5, edges = [[0,1], [1,2], [2,3], [1,3], [1,4]]
Output: false (has cycle!)
```

## Tree Properties:

A graph is a valid tree if and only if:
1. **Exactly n - 1 edges** (for n nodes)
2. **No cycles**
3. **All nodes connected** (one component)

## Union-Find Approach:

```typescript
function validTree(n: number, edges: number[][]): boolean {
  // Property 1: Must have exactly n-1 edges
  if (edges.length !== n - 1) return false;

  let uf = new UnionFind(n);

  // Property 2: No cycles
  for (let [u, v] of edges) {
    if (!uf.union(u, v)) {
      return false;  // Cycle detected!
    }
  }

  // Property 3: All connected (implied by n-1 edges and no cycles)
  return true;
}
```

## Key Insight:
If we have **exactly n-1 edges** and **no cycles**, the graph is guaranteed to be a tree!

Try solving it on the right →
```

**Right Panel (Problem)**: `graph-13` (Graph Valid Tree)

**Next**: Item 18

---

### **ITEM 18: Redundant Connection**
**Type**: Problem Only
**Duration**: 12-15 minutes

**Left Panel (Problem Context)**:
```
# Practice: Cycle Detection with Union-Find

**Problem**: Find the edge that, when removed, makes the graph a tree.

```
Input: edges = [[1,2], [1,3], [2,3]]
Output: [2,3]

Explanation:
After adding [1,2] and [1,3], adding [2,3] creates a cycle.
```

## Hint:
Use Union-Find to detect when adding an edge creates a cycle.

The first edge that connects two nodes **already in the same component** is the redundant one!

```typescript
let uf = new UnionFind(n);

for (let [u, v] of edges) {
  if (!uf.union(u, v)) {
    return [u, v];  // This edge creates a cycle!
  }
}
```
```

**Right Panel (Problem)**: `graph-14` (Redundant Connection)

**Next**: Item 19

---

### **ITEM 19: Accounts Merge (Graph + Hash Map)**
**Type**: Lesson + Problem
**Duration**: 18-20 minutes

**Left Panel (Lesson)**:
```
# Complex Graph Problem: Accounts Merge

**Problem**: Merge accounts that share emails.

```
Input:
[
  ["John","john@mail.com","john_work@mail.com"],
  ["John","john@mail.com","john_home@mail.com"],
  ["Mary","mary@mail.com"]
]

Output:
[
  ["John","john@mail.com","john_home@mail.com","john_work@mail.com"],
  ["Mary","mary@mail.com"]
]
```

## Key Insight:
This is a **graph problem**!
- Each email is a node
- If two emails belong to same account, they're connected
- Find connected components of emails

## Union-Find Approach:

```typescript
function accountsMerge(accounts: string[][]): string[][] {
  let emailToName = new Map<string, string>();
  let emailToId = new Map<string, number>();
  let id = 0;

  // Map emails to IDs
  for (let account of accounts) {
    let name = account[0];
    for (let i = 1; i < account.length; i++) {
      let email = account[i];
      emailToName.set(email, name);
      if (!emailToId.has(email)) {
        emailToId.set(email, id++);
      }
    }
  }

  let uf = new UnionFind(id);

  // Union emails in same account
  for (let account of accounts) {
    let firstEmailId = emailToId.get(account[1])!;
    for (let i = 2; i < account.length; i++) {
      uf.union(firstEmailId, emailToId.get(account[i])!);
    }
  }

  // Group emails by root
  let components = new Map<number, string[]>();
  for (let [email, emailId] of emailToId) {
    let root = uf.find(emailId);
    if (!components.has(root)) components.set(root, []);
    components.get(root)!.push(email);
  }

  // Build result
  let result: string[][] = [];
  for (let emails of components.values()) {
    emails.sort();
    let name = emailToName.get(emails[0])!;
    result.push([name, ...emails]);
  }

  return result;
}
```

This combines **Union-Find** + **Hash Maps** beautifully!

Try solving it on the right →
```

**Right Panel (Problem)**: `graph-15` (Accounts Merge)

**Next**: Item 20

---

### **ITEM 20: Alien Dictionary**
**Type**: Problem Only
**Duration**: 20-25 minutes

**Left Panel (Problem Context)**:
```
# Challenge: Topological Sort from Ordering

**Problem**: Derive alien language character order from sorted alien dictionary.

```
Input: ["wrt","wrf","er","ett","rftt"]
Output: "wertf"

Explanation:
w < e (from "wrt" < "er")
t < f (from "wrt" < "wrf")
r < t (from "er" < "ett")
e < r (from "er" < "ett")

Order: w → e → r → t → f
```

## Hint:
1. Build directed graph from word comparisons
2. Compare consecutive words to find character ordering
3. Use topological sort to find final order
4. Watch for cycles (invalid input)!

This is a **HARD** problem combining graph building + topological sort!
```

**Right Panel (Problem)**: `graph-16` (Alien Dictionary)

**Next**: Module complete!

---

## Module Completion

After Item 20, show:

```
# 🎉 Module 8 Complete!

You've mastered:
✅ Graph representation (adjacency list, matrix)
✅ DFS on graphs (cycle detection, connected components)
✅ BFS on graphs (shortest paths, multi-source)
✅ Topological sort
✅ Union-Find (Disjoint Set Union)
✅ Complex graph problems (islands, word ladder, accounts merge)

## Key Patterns Learned:

1. **DFS**: Explore deeply, use for cycle detection and paths
2. **BFS**: Explore by levels, use for shortest paths
3. **Multi-Source BFS**: Start from multiple nodes simultaneously
4. **Topological Sort**: Linear ordering of directed acyclic graph
5. **Union-Find**: Efficiently track and merge connected components
6. **Graph + Hash Map**: Complex problems combining multiple techniques

## Time Complexities:
- DFS/BFS: O(V + E) where V = vertices, E = edges
- Union-Find: Nearly O(1) per operation
- Topological Sort: O(V + E)

## Problems Solved: 16

Next: **Module 9: Dynamic Programming Foundations** →
```

---

## Problems Required

This module requires these problems to exist in `/lib/content/problems/graphs.ts`:

1. `graph-1`: Clone Graph (MEDIUM)
2. `graph-2`: Number of Islands (MEDIUM) ⭐⭐⭐ CRITICAL
3. `graph-3`: Max Area of Island (MEDIUM)
4. `graph-4`: Course Schedule (MEDIUM) ⭐⭐⭐ CRITICAL
5. `graph-5`: Course Schedule II (MEDIUM) ⭐⭐⭐ CRITICAL
6. `graph-6`: Pacific Atlantic Water Flow (MEDIUM)
7. `graph-7`: Shortest Path in Binary Matrix (MEDIUM)
8. `graph-8`: Rotting Oranges (MEDIUM) ⭐⭐⭐ CRITICAL
9. `graph-9`: Word Ladder (HARD) ⭐⭐⭐ CRITICAL
10. `graph-10`: 01 Matrix (MEDIUM)
11. `graph-11`: Walls and Gates (MEDIUM)
12. `graph-12`: Number of Connected Components in an Undirected Graph (MEDIUM)
13. `graph-13`: Graph Valid Tree (MEDIUM)
14. `graph-14`: Redundant Connection (MEDIUM)
15. `graph-15`: Accounts Merge (MEDIUM) ⭐⭐⭐ CRITICAL
16. `graph-16`: Alien Dictionary (HARD) ⭐⭐⭐ CRITICAL

---

This specification follows the adaptive learning pattern and covers the critical graph patterns seen in 15-20% of FAANG interviews.
