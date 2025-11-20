# Union Find: From First Principles to Optimal (Granular Progression)

## The Problem: Tracking Connected Components

**Given:** A set of nodes (0, 1, 2, 3, ..., n-1) and edges connecting them.

**Operations:**
- `union(x, y)`: Connect nodes x and y
- `find(x, y)`: Are nodes x and y connected?
- `getAllConnected(x)`: Get all nodes connected to x
- `countComponents()`: How many separate groups?

**Example:**
```
Nodes: 0, 1, 2, 3, 4

Edges: (0,1), (2,3)

Visual:
  0---1    2---3    4

Components: {0,1}, {2,3}, {4}
```

---

## Level 1: Most Basic - Track All Connections Explicitly

### Implementation

Let's start with the MOST obvious approach: for each node, store a list of all nodes it's connected to.

```typescript
class UnionFind {
  private connections: Set<number>[];  // connections[i] = all nodes connected to i
  private n: number;

  constructor(n: number) {
    this.n = n;
    this.connections = [];

    // Each node starts only connected to itself
    for (let i = 0; i < n; i++) {
      this.connections[i] = new Set([i]);
    }
  }

  union(x: number, y: number): void {
    // Merge both connection sets
    let allConnected = new Set([
      ...this.connections[x],
      ...this.connections[y]
    ]);

    // Update ALL nodes in the merged set
    for (let node of allConnected) {
      this.connections[node] = allConnected;
    }
  }

  find(x: number, y: number): boolean {
    return this.connections[x].has(y);
  }

  getAllConnected(x: number): number[] {
    return Array.from(this.connections[x]);
  }

  countComponents(): number {
    let seen = new Set<Set<number>>();
    for (let i = 0; i < this.n; i++) {
      seen.add(this.connections[i]);
    }
    return seen.size;
  }
}
```

### Example Execution

```
Initialize n=5:
  connections[0] = {0}
  connections[1] = {1}
  connections[2] = {2}
  connections[3] = {3}
  connections[4] = {4}

union(0, 1):
  allConnected = {0, 1}
  connections[0] = {0, 1}
  connections[1] = {0, 1}

State:
  connections[0] = {0, 1}
  connections[1] = {0, 1}  ← Both point to same set
  connections[2] = {2}
  connections[3] = {3}
  connections[4] = {4}

union(2, 3):
  allConnected = {2, 3}
  connections[2] = {2, 3}
  connections[3] = {2, 3}

State:
  connections[0] = {0, 1}
  connections[1] = {0, 1}
  connections[2] = {2, 3}
  connections[3] = {2, 3}
  connections[4] = {4}

union(1, 2):
  allConnected = {0, 1, 2, 3}  ← Merge {0,1} and {2,3}!
  connections[0] = {0, 1, 2, 3}
  connections[1] = {0, 1, 2, 3}
  connections[2] = {0, 1, 2, 3}
  connections[3] = {0, 1, 2, 3}

getAllConnected(0):
  return [0, 1, 2, 3]  ✓ All connected nodes!
```

### Complexity Analysis

**Operations:**
- `find(x, y)`: **O(1)** - Just check if y is in connections[x] set ✅
- `getAllConnected(x)`: **O(size of component)** - Already have the set ✅
- `union(x, y)`: **O(size of both components)** - Must update all nodes ⚠️

**Memory:**
- Each node stores reference to its component set
- If all n nodes are connected: n references to a set of size n
- **Space: O(n²)** in worst case ❌

### Bottleneck #1 🚨

**Problem:** When we `union(x, y)`, we must update EVERY node in both components!

**Example:**
```
union(0, 1): Update 2 nodes (0 and 1)
union(0, 2): Update 3 nodes (0, 1, 2)
union(0, 3): Update 4 nodes (0, 1, 2, 3)
...
union(0, n-1): Update n nodes!

Total updates: 2 + 3 + 4 + ... + n = n(n+1)/2 - 1 ≈ O(n²)
```

**For n=100,000:** Building a fully connected graph requires ~5 billion set updates!

**Question:** Can we avoid updating every node's connection set?

---

## Level 2: Representative Concept - Track One "Leader" Per Component

### Key Insight

> Instead of storing all connections for each node, just store which **component** each node belongs to. Represent each component by a single "leader" or "representative" node.

**Change:** `connections[x]` is now just a number (the leader), not a set!

### Implementation

```typescript
class UnionFind {
  private component: number[];  // component[i] = leader of i's component
  private n: number;

  constructor(n: number) {
    this.n = n;
    this.component = [];

    // Each node is its own component leader initially
    for (let i = 0; i < n; i++) {
      this.component[i] = i;
    }
  }

  union(x: number, y: number): void {
    let leaderX = this.component[x];
    let leaderY = this.component[y];

    if (leaderX === leaderY) return;  // Already in same component

    // Merge: change all nodes with leaderY to have leaderX
    for (let i = 0; i < this.n; i++) {
      if (this.component[i] === leaderY) {
        this.component[i] = leaderX;
      }
    }
  }

  find(x: number, y: number): boolean {
    return this.component[x] === this.component[y];
  }

  getAllConnected(x: number): number[] {
    let leader = this.component[x];
    let result: number[] = [];

    for (let i = 0; i < this.n; i++) {
      if (this.component[i] === leader) {
        result.push(i);
      }
    }

    return result;
  }

  countComponents(): number {
    let leaders = new Set<number>();
    for (let i = 0; i < this.n; i++) {
      leaders.add(this.component[i]);
    }
    return leaders.size;
  }
}
```

### Example Execution

```
Initialize n=5:
  component = [0, 1, 2, 3, 4]
  (Each node is its own leader)

union(0, 1):
  leaderX = component[0] = 0
  leaderY = component[1] = 1

  Scan array: change all 1s to 0s
  component = [0, 0, 2, 3, 4]
           //    ↑  Changed!

union(2, 3):
  leaderX = 2, leaderY = 3
  Change all 3s to 2s
  component = [0, 0, 2, 2, 4]

union(1, 2):
  leaderX = component[1] = 0
  leaderY = component[2] = 2

  Change all 2s to 0s
  component = [0, 0, 0, 0, 4]
           //          ↑  ↑  Changed!

getAllConnected(0):
  leader = component[0] = 0
  Scan: nodes with leader=0 are {0, 1, 2, 3}
  return [0, 1, 2, 3] ✓
```

### Complexity Analysis

**Operations:**
- `find(x, y)`: **O(1)** - Compare component IDs ✅
- `union(x, y)`: **O(n)** - Scan entire array to update ❌
- `getAllConnected(x)`: **O(n)** - Scan entire array ⚠️
- `countComponents()`: **O(n)** - Scan to collect unique leaders ⚠️

**Memory:**
- **Space: O(n)** - Just one array! ✅✅

### The Improvement ✅

- Memory reduced from O(n²) to O(n)!
- Simpler structure - just one array

### Bottleneck #2 🚨

**Problem:** Still scanning entire array on every `union`!

**Example for n=100,000:**
```
union(0, 1): Scan 100,000 elements
union(0, 2): Scan 100,000 elements
...
100 unions: 10,000,000 array scans!
```

**Question:** Can we avoid scanning the entire array each time?

---

## Level 3: Parent Pointers - Build a Tree Structure

### Key Insight

> Instead of all nodes directly storing their component leader, create a **tree** where each node points to a "parent", and parents eventually lead to a "root" (the component leader).

**Visual:**
```
Old (flat):
  All nodes in component point directly to leader

  component = [0, 0, 0, 0]
              ↓  ↓  ↓  ↓
              Leader = 0

New (tree):
  Nodes form a tree pointing upward

      0 (root)
     /|\
    1 2 3

  parent[0] = 0  (points to itself)
  parent[1] = 0
  parent[2] = 0
  parent[3] = 0
```

### Implementation

```typescript
class UnionFind {
  private parent: number[];  // parent[i] = parent of node i
  private n: number;

  constructor(n: number) {
    this.n = n;
    this.parent = [];

    // Each node is its own parent (i.e., its own root)
    for (let i = 0; i < n; i++) {
      this.parent[i] = i;
    }
  }

  // Find root of x by following parent pointers
  private findRoot(x: number): number {
    while (this.parent[x] !== x) {
      x = this.parent[x];
    }
    return x;
  }

  union(x: number, y: number): void {
    let rootX = this.findRoot(x);
    let rootY = this.findRoot(y);

    if (rootX === rootY) return;  // Already in same tree

    // Attach one tree to the other - just change one parent!
    this.parent[rootY] = rootX;  // Make rootX the parent of rootY
  }

  find(x: number, y: number): boolean {
    return this.findRoot(x) === this.findRoot(y);
  }

  getAllConnected(x: number): number[] {
    let root = this.findRoot(x);
    let result: number[] = [];

    for (let i = 0; i < this.n; i++) {
      if (this.findRoot(i) === root) {
        result.push(i);
      }
    }

    return result;
  }

  countComponents(): number {
    let roots = new Set<number>();
    for (let i = 0; i < this.n; i++) {
      roots.add(this.findRoot(i));
    }
    return roots.size;
  }
}
```

### Example Execution

```
Initialize n=5:
  parent = [0, 1, 2, 3, 4]

  Each node points to itself (is its own root)

union(0, 1):
  rootX = findRoot(0) = 0
  rootY = findRoot(1) = 1

  parent[1] = 0  // Make 0 the parent of 1

  parent = [0, 0, 2, 3, 4]
           //    ↑  Changed!

  Tree:
    0
    └─1

union(2, 3):
  rootX = findRoot(2) = 2
  rootY = findRoot(3) = 3

  parent[3] = 2

  parent = [0, 0, 2, 2, 4]

  Trees:
    0     2     4
    └─1   └─3

union(1, 2):
  rootX = findRoot(1) = findRoot(0) = 0  // Follow: 1→0
  rootY = findRoot(2) = 2

  parent[2] = 0  // Connect tree rooted at 2 to tree rooted at 0

  parent = [0, 0, 0, 2, 4]
           //       ↑  Changed!

  Tree:
    0
    ├─1
    └─2
      └─3

findRoot(3):
  parent[3] = 2  (not equal to 3)
  → parent[2] = 0  (not equal to 2)
  → parent[0] = 0  (equal! This is root)
  → return 0

  Path: 3 → 2 → 0 ✓
```

### Complexity Analysis

**Operations:**
- `union(x, y)`: **O(tree height)** - Two findRoot calls + O(1) pointer change ⚠️
- `find(x, y)`: **O(tree height)** - Two findRoot calls ⚠️
- `findRoot(x)`: **O(tree height)** - Follow parent pointers ⚠️
- `getAllConnected(x)`: **O(n × tree height)** - findRoot for each node ❌
- `countComponents()`: **O(n × tree height)** - findRoot for each node ❌

**Memory:**
- **Space: O(n)** - Still just one array ✅

### The Improvement ✅

- `union` is now **O(tree height)** instead of O(n)!
- Only changing ONE parent pointer, not scanning entire array!

**Example:**
```
Old approach (Level 2):
  union(0, 1): Scan 100,000 elements

New approach (Level 3):
  union(0, 1):
    findRoot(0) = 1 operation
    findRoot(1) = 1 operation
    parent[1] = 0 = 1 operation
    Total: 3 operations!
```

### Bottleneck #3 🚨

**Problem:** Tree can become UNBALANCED - degenerate into a long chain!

**Worst case - sequential unions:**
```
union(0, 1):  parent = [0, 0, 2, 3, 4]
union(1, 2):  parent = [0, 0, 0, 3, 4]
union(2, 3):  parent = [0, 0, 0, 0, 4]
union(3, 4):  parent = [0, 0, 0, 0, 0]

Resulting tree:
  0
  └─1
    └─2
      └─3
        └─4

findRoot(4): Must follow 4 → 3 → 2 → 1 → 0 = 5 steps!

For n=100,000: Could need 100,000 steps! O(n)
```

**This is WORSE than Level 2!** We traded one problem for another.

**Question:** How can we keep the tree BALANCED?

---

## Level 4: Track Tree Size - Union by Size

### Key Insight

> Always attach the **smaller tree** under the **larger tree**. This keeps trees balanced!

**Why this works:** The deeper tree doesn't get any deeper.

### Implementation

```typescript
class UnionFind {
  private parent: number[];
  private size: number[];  // size[i] = number of nodes in tree rooted at i
  private n: number;

  constructor(n: number) {
    this.n = n;
    this.parent = [];
    this.size = [];

    for (let i = 0; i < n; i++) {
      this.parent[i] = i;
      this.size[i] = 1;  // Each tree has size 1 initially
    }
  }

  private findRoot(x: number): number {
    while (this.parent[x] !== x) {
      x = this.parent[x];
    }
    return x;
  }

  union(x: number, y: number): void {
    let rootX = this.findRoot(x);
    let rootY = this.findRoot(y);

    if (rootX === rootY) return;

    // Attach smaller tree under larger tree
    if (this.size[rootX] < this.size[rootY]) {
      this.parent[rootX] = rootY;
      this.size[rootY] += this.size[rootX];
    } else {
      this.parent[rootY] = rootX;
      this.size[rootX] += this.size[rootY];
    }
  }

  find(x: number, y: number): boolean {
    return this.findRoot(x) === this.findRoot(y);
  }

  getAllConnected(x: number): number[] {
    let root = this.findRoot(x);
    let result: number[] = [];

    for (let i = 0; i < this.n; i++) {
      if (this.findRoot(i) === root) {
        result.push(i);
      }
    }

    return result;
  }

  countComponents(): number {
    let roots = new Set<number>();
    for (let i = 0; i < this.n; i++) {
      roots.add(this.findRoot(i));
    }
    return roots.size;
  }
}
```

### Example Execution - Why Size Matters

**Without union by size (Level 3):**
```
union(0, 1): parent = [0, 0, 2, 3]
union(1, 2): parent = [0, 0, 0, 3]
union(2, 3): parent = [0, 0, 0, 0]

Tree becomes a chain:
  0
  └─1
    └─2
      └─3

Height = 3
```

**With union by size (Level 4):**
```
union(0, 1):
  size[0]=1, size[1]=1 (equal, choose either)
  parent[1] = 0
  size[0] = 2

  parent = [0, 0, 2, 3]
  size = [2, 1, 1, 1]

  Tree:
    0
    └─1

union(1, 2):
  rootX = 0 (size=2)
  rootY = 2 (size=1)

  size[0] > size[2], so attach 2 under 0
  parent[2] = 0
  size[0] = 3

  parent = [0, 0, 0, 3]
  size = [3, 1, 1, 1]

  Tree:
    0
    ├─1
    └─2

union(2, 3):
  rootX = 0 (size=3)
  rootY = 3 (size=1)

  Attach 3 under 0
  parent[3] = 0
  size[0] = 4

  parent = [0, 0, 0, 0]
  size = [4, 1, 1, 1]

  Tree:
    0
    ├─1
    ├─2
    └─3

  Height = 1 (much better than 3!)
```

### Complexity Analysis

**Operations:**
- `union(x, y)`: **O(log n)** - Tree height limited to log n ✅
- `find(x, y)`: **O(log n)** ✅
- `findRoot(x)`: **O(log n)** ✅
- `getAllConnected(x)`: **O(n log n)** ⚠️
- `countComponents()`: **O(n log n)** ⚠️

**Memory:**
- **Space: O(n)** ✅

### The Improvement ✅

- Tree height guaranteed ≤ log n!
- No more degenerate chains

**Why log n?**
- A tree of height h has at least 2^h nodes (by union by size property)
- So if we have n nodes: h ≤ log₂(n)

**Example for n=1,000,000:**
- Level 3 (unbalanced): Could need 1,000,000 steps for findRoot
- Level 4 (union by size): At most ~20 steps (log₂(1,000,000) ≈ 20)

**50,000x improvement!**

### Bottleneck #4 🚨

**Problem:** We're repeatedly traversing long paths during `findRoot`.

**Example:**
```
Tree after many unions:
      0
     /|\
    1 2 3
    |
    4
    |
    5
    |
    6

findRoot(6): 6 → 5 → 4 → 1 → 0  (4 hops)

If we call findRoot(6) many times, we repeat this path traversal!
```

**Question:** Can we make future `findRoot` calls faster?

---

## Level 5: Path Compression - Flatten While Finding

### Key Insight

> When we `findRoot(x)`, make every node on the path point **directly to the root**!

**Before:**
```
    0
    └─1
      └─2
        └─3

findRoot(3): 3 → 2 → 1 → 0
```

**After path compression:**
```
    0
    ├─1
    ├─2
    └─3

All nodes now connect directly to root!
Next findRoot(3): 3 → 0  (single hop!)
```

### Implementation

```typescript
class UnionFind {
  private parent: number[];
  private size: number[];
  private n: number;

  constructor(n: number) {
    this.n = n;
    this.parent = [];
    this.size = [];

    for (let i = 0; i < n; i++) {
      this.parent[i] = i;
      this.size[i] = 1;
    }
  }

  private findRoot(x: number): number {
    // Path compression: make every node point directly to root
    if (this.parent[x] !== x) {
      this.parent[x] = this.findRoot(this.parent[x]);  // Recursive compression
    }
    return this.parent[x];
  }

  union(x: number, y: number): void {
    let rootX = this.findRoot(x);  // Compresses path from x to root
    let rootY = this.findRoot(y);  // Compresses path from y to root

    if (rootX === rootY) return;

    // Union by size
    if (this.size[rootX] < this.size[rootY]) {
      this.parent[rootX] = rootY;
      this.size[rootY] += this.size[rootX];
    } else {
      this.parent[rootY] = rootX;
      this.size[rootX] += this.size[rootY];
    }
  }

  find(x: number, y: number): boolean {
    return this.findRoot(x) === this.findRoot(y);
  }

  getAllConnected(x: number): number[] {
    let root = this.findRoot(x);
    let result: number[] = [];

    for (let i = 0; i < this.n; i++) {
      if (this.findRoot(i) === root) {
        result.push(i);
      }
    }

    return result;
  }

  countComponents(): number {
    let roots = new Set<number>();
    for (let i = 0; i < this.n; i++) {
      roots.add(this.findRoot(i));
    }
    return roots.size;
  }
}
```

### Example Execution - Path Compression in Action

```
Initial tree:
      0
      └─1
        └─2
          └─3
            └─4

parent = [0, 0, 1, 2, 3]

findRoot(4):
  Step 1: parent[4] = 3, so recurse on findRoot(3)
    Step 2: parent[3] = 2, so recurse on findRoot(2)
      Step 3: parent[2] = 1, so recurse on findRoot(1)
        Step 4: parent[1] = 0, so recurse on findRoot(0)
          Step 5: parent[0] = 0, return 0
        parent[1] = 0 (no change)
        return 0
      parent[2] = 0  ← Compressed!
      return 0
    parent[3] = 0  ← Compressed!
    return 0
  parent[4] = 0  ← Compressed!
  return 0

After findRoot(4):
  parent = [0, 0, 0, 0, 0]
       //          ↑  ↑  ↑  All now point directly to 0!

Tree is now flat:
      0
     /|\\
    1 2 3 4

Next findRoot(4):
  parent[4] = 0 (equals 0)
  return 0

  Just ONE operation instead of 5!
```

### Complexity Analysis

**Time Complexity:**
- All operations: **O(α(n))** where α is inverse Ackermann function
- **Effectively O(1) for all practical n**

**α(n) values:**
- α(1) = 1
- α(2) = 2
- α(4) = 3
- α(16) = 4
- α(65536) = 5
- α(2^65536) = 6  ← More atoms than in universe!

For any realistic n, α(n) ≤ 5, so effectively constant time!

**Memory:**
- **Space: O(n)** ✅

### The FINAL Improvement ✅✅✅

Path compression makes the amortized cost of operations **nearly constant**!

**Example for 1,000,000 operations on 100,000 nodes:**
- Without path compression: ~20,000,000 total hops (log n per operation)
- With path compression: ~5,000,000 total hops (α(n) ≈ 4-5 per operation)

**4x improvement, and trees get flatter over time!**

---

## Level 6: Union by Rank Instead of Size (Minor Optimization)

### Key Insight

> Instead of tracking exact size, track **rank** (upper bound on height). Simpler to maintain with path compression.

**Why?** Path compression changes tree structure but we don't want to recompute sizes. Rank is a conservative upper bound that's easier to maintain.

### Implementation

```typescript
class UnionFind {
  private parent: number[];
  private rank: number[];  // Upper bound on tree height
  private n: number;

  constructor(n: number) {
    this.n = n;
    this.parent = [];
    this.rank = [];

    for (let i = 0; i < n; i++) {
      this.parent[i] = i;
      this.rank[i] = 0;  // Initial rank = 0
    }
  }

  private findRoot(x: number): number {
    if (this.parent[x] !== x) {
      this.parent[x] = this.findRoot(this.parent[x]);
    }
    return this.parent[x];
  }

  union(x: number, y: number): void {
    let rootX = this.findRoot(x);
    let rootY = this.findRoot(y);

    if (rootX === rootY) return;

    // Attach lower rank tree under higher rank tree
    if (this.rank[rootX] < this.rank[rootY]) {
      this.parent[rootX] = rootY;
    } else if (this.rank[rootX] > this.rank[rootY]) {
      this.parent[rootY] = rootX;
    } else {
      // Equal rank: attach either way and increment rank
      this.parent[rootY] = rootX;
      this.rank[rootX]++;
    }
  }

  find(x: number, y: number): boolean {
    return this.findRoot(x) === this.findRoot(y);
  }
}
```

### Rank vs Size

**Rank properties:**
- Only increases when merging equal-rank trees
- With path compression, rank is an upper bound (not exact height)
- Simpler to maintain than size

**Both give same O(α(n)) complexity with path compression!**

---

## Complete Summary: The Optimization Journey

| Level | Approach | Union | Find | Space | Key Bottleneck | Fix |
|-------|----------|-------|------|-------|----------------|-----|
| **1** | Store all connections | O(comp size) | O(1) | O(n²) | Update all nodes in component | Use representative |
| **2** | Component leader | O(n) | O(1) | O(n) | Scan entire array | Use tree structure |
| **3** | Parent pointers (tree) | O(h) | O(h) | O(n) | Unbalanced tree | Balance by size |
| **4** | Union by size | O(log n) | O(log n) | O(n) | Repeated path traversal | Compress paths |
| **5** | Path compression | O(α(n)) | O(α(n)) | O(n) | - | - |
| **6** | Rank + compression | O(α(n)) | O(α(n)) | O(n) | **OPTIMAL** ✅ | - |

---

## Micro-Bottlenecks Discovered

1. **Storing full connection sets** → Too much memory, updates expensive
2. **Scanning entire array on union** → Use tree, change one parent
3. **Unbalanced tree** → Union by size/rank keeps balanced
4. **Repeated path traversal** → Path compression flattens tree
5. **Maintaining exact size** → Rank is simpler with compression

Each fix addressed ONE specific bottleneck!

---

## Real Performance Impact

**100,000 nodes, 100,000 union operations:**

| Approach | Total Operations | Time |
|----------|------------------|------|
| Level 1 | ~5 billion set updates | Minutes ❌ |
| Level 2 | ~10 billion array scans | Minutes ❌ |
| Level 3 | ~1 billion path follows (worst case) | Seconds ❌ |
| Level 4 | ~20 million path follows | Milliseconds ✅ |
| Level 5-6 | ~5 million path follows | Milliseconds ✅✅ |

**Path compression gives final 4x improvement on top of union by rank!**

---

This shows how each TINY optimization addresses a SPECIFIC bottleneck, progressively improving from O(n²) memory and O(n) operations to O(n) memory and O(α(n)) ≈ O(1) operations!
