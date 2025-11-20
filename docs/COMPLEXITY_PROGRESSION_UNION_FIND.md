# Union Find: Complexity Progression

## Overview

This document shows the progressive optimization of Union Find (Disjoint Set) from naive implementations to the optimal solution. Each step identifies bottlenecks and shows incremental improvements.

---

## The Problem

**Given:** A set of elements that need to be grouped into disjoint (non-overlapping) sets.

**Operations needed:**
- `find(x)`: Which set does element x belong to?
- `union(x, y)`: Merge the sets containing x and y

**Common use cases:**
- Detecting cycles in graphs
- Finding connected components
- Kruskal's MST algorithm
- Network connectivity

---

## ✅ Solution 1: Brute Force with Array

### Implementation

```typescript
class UnionFind {
  private parent: number[];

  constructor(n: number) {
    this.parent = new Array(n);
    for (let i = 0; i < n; i++) {
      this.parent[i] = i;  // Each element is its own parent
    }
  }

  find(x: number): number {
    return this.parent[x];  // Direct lookup
  }

  union(x: number, y: number): void {
    let rootX = this.find(x);
    let rootY = this.find(y);

    if (rootX === rootY) return;  // Already in same set

    // Merge: update ALL elements with rootY to rootX
    for (let i = 0; i < this.parent.length; i++) {
      if (this.parent[i] === rootY) {
        this.parent[i] = rootX;
      }
    }
  }
}
```

### Complexity Analysis

**Time Complexity:**
- `find(x)`: **O(1)** - Direct array lookup ✅
- `union(x, y)`: **O(n)** - Must scan entire array ❌

**Space Complexity:** O(n)

### Example Execution

```
Initial: [0, 1, 2, 3, 4]  (each element points to itself)

union(0, 1):
  Find roots: root(0)=0, root(1)=1
  Update all 1s to 0: [0, 0, 2, 3, 4]

union(2, 3):
  Find roots: root(2)=2, root(3)=3
  Update all 3s to 2: [0, 0, 2, 2, 4]

union(1, 2):
  Find roots: root(1)=0, root(2)=2
  Update all 2s to 0: [0, 0, 0, 0, 4]
```

### The Bottleneck 🚨

**Problem:** Union operation requires scanning the entire array to update all elements!

For n=100,000 elements:
- 100 union operations = 100 × 100,000 = **10,000,000 array updates!**

**Question:** Can we avoid updating every element during union?

---

## ✅ Solution 2: Tree Structure (Quick Find → Quick Union)

### Key Insight

> Instead of making all elements directly point to the root, create a **tree structure** where elements point to their parent.

**Change:** `parent[x]` now means "parent of x" not "root of x"

### Implementation

```typescript
class UnionFind {
  private parent: number[];

  constructor(n: number) {
    this.parent = new Array(n);
    for (let i = 0; i < n; i++) {
      this.parent[i] = i;  // Still self-parent initially
    }
  }

  find(x: number): number {
    // Follow parent pointers until root (where parent[x] === x)
    while (this.parent[x] !== x) {
      x = this.parent[x];
    }
    return x;
  }

  union(x: number, y: number): void {
    let rootX = this.find(x);
    let rootY = this.find(y);

    if (rootX === rootY) return;

    // Simply connect one root to another - O(1)!
    this.parent[rootY] = rootX;
  }
}
```

### Complexity Analysis

**Time Complexity:**
- `find(x)`: **O(tree height)** - Worse case O(n) if tree degenerates ⚠️
- `union(x, y)`: **O(tree height)** - Two finds + O(1) update

**Space Complexity:** O(n)

### Example Execution

```
Initial: [0, 1, 2, 3, 4]

union(0, 1):
  parent[1] = 0
  Result: [0, 0, 2, 3, 4]

  Tree structure:
    0
    └─1

union(2, 3):
  parent[3] = 2
  Result: [0, 0, 2, 2, 4]

    0     2     4
    └─1   └─3

union(1, 2):
  find(1) = 0 (follow: 1→0)
  find(2) = 2
  parent[2] = 0
  Result: [0, 0, 0, 2, 4]

    0     4
    ├─1
    └─2
      └─3
```

### The Improvement ✅

- **Union is now O(1)** for the connection itself!
- No more scanning entire array

### The NEW Bottleneck 🚨

**Problem:** Tree can become unbalanced (long chains)!

**Worst case** - Linear chain:
```
union(0, 1), union(1, 2), union(2, 3), ..., union(n-2, n-1)

Results in:
  0
  └─1
    └─2
      └─3
        └─4
          └─...
            └─n-1

find(n-1) requires n steps! O(n)
```

**Question:** How can we keep the tree balanced?

---

## ✅ Solution 3: Union by Rank (Balancing)

### Key Insight

> Always attach the **smaller tree** under the **larger tree** to keep trees balanced!

Track tree "rank" (approximate height) for each root.

### Implementation

```typescript
class UnionFind {
  private parent: number[];
  private rank: number[];  // Track tree height

  constructor(n: number) {
    this.parent = new Array(n);
    this.rank = new Array(n).fill(0);  // Initial rank = 0

    for (let i = 0; i < n; i++) {
      this.parent[i] = i;
    }
  }

  find(x: number): number {
    while (this.parent[x] !== x) {
      x = this.parent[x];
    }
    return x;
  }

  union(x: number, y: number): void {
    let rootX = this.find(x);
    let rootY = this.find(y);

    if (rootX === rootY) return;

    // Union by rank: attach smaller tree under larger
    if (this.rank[rootX] < this.rank[rootY]) {
      this.parent[rootX] = rootY;
    } else if (this.rank[rootX] > this.rank[rootY]) {
      this.parent[rootY] = rootX;
    } else {
      // Same rank: attach either way, increase rank
      this.parent[rootY] = rootX;
      this.rank[rootX]++;
    }
  }
}
```

### Complexity Analysis

**Time Complexity:**
- `find(x)`: **O(log n)** - Tree height limited by log n ✅
- `union(x, y)`: **O(log n)** - Two finds + O(1) update

**Space Complexity:** O(n)

### Example Execution

```
Initial:
  parent: [0, 1, 2, 3, 4]
  rank:   [0, 0, 0, 0, 0]

union(0, 1):
  rank[0] == rank[1] == 0
  → Attach 1 under 0, increment rank[0]

  parent: [0, 0, 2, 3, 4]
  rank:   [1, 0, 0, 0, 0]

  Tree:
    0 (rank=1)
    └─1 (rank=0)

union(2, 3):
  rank[2] == rank[3] == 0
  → Attach 3 under 2, increment rank[2]

  parent: [0, 0, 2, 2, 4]
  rank:   [1, 0, 1, 0, 0]

  Trees:
    0 (rank=1)     2 (rank=1)     4 (rank=0)
    └─1            └─3

union(0, 2):
  rank[0] == rank[2] == 1
  → Attach 2 under 0, increment rank[0]

  parent: [0, 0, 0, 2, 4]
  rank:   [2, 0, 1, 0, 0]

  Tree:
    0 (rank=2)
    ├─1 (rank=0)
    └─2 (rank=1)
      └─3 (rank=0)
```

### The Improvement ✅

- Tree height guaranteed to be **O(log n)**
- No more degenerate chains!
- Both operations now O(log n)

### Why This Works

**Proof sketch:** A tree of rank r has at least 2^r nodes.
- Rank 0: 1 node (2^0)
- Rank 1: 2+ nodes (2^1)
- Rank 2: 4+ nodes (2^2)
- ...
- Rank r: 2^r nodes

Therefore: If we have n nodes, max rank = log n!

### Can We Do Better? 🤔

---

## ✅ Solution 4: Path Compression (Near Constant Time!)

### Key Insight

> During `find(x)`, make every node on the path point **directly to the root!**

This flattens the tree over time.

### Implementation

```typescript
class UnionFind {
  private parent: number[];
  private rank: number[];

  constructor(n: number) {
    this.parent = new Array(n);
    this.rank = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
      this.parent[i] = i;
    }
  }

  find(x: number): number {
    // Path compression: make every node point to root
    if (this.parent[x] !== x) {
      this.parent[x] = this.find(this.parent[x]);  // Recursive compression
    }
    return this.parent[x];
  }

  union(x: number, y: number): void {
    let rootX = this.find(x);  // find() compresses paths!
    let rootY = this.find(y);

    if (rootX === rootY) return;

    // Union by rank
    if (this.rank[rootX] < this.rank[rootY]) {
      this.parent[rootX] = rootY;
    } else if (this.rank[rootX] > this.rank[rootY]) {
      this.parent[rootY] = rootX;
    } else {
      this.parent[rootY] = rootX;
      this.rank[rootX]++;
    }
  }
}
```

### Path Compression in Action

**Before compression:**
```
    0
    └─1
      └─2
        └─3
          └─4

find(4):
  Path: 4 → 3 → 2 → 1 → 0
```

**After find(4) with path compression:**
```
    0
    ├─1
    ├─2
    ├─3
    └─4

All nodes now point directly to root!
```

**Next find(4):**
```
  Path: 4 → 0  (single hop!)
```

### Complexity Analysis

**Time Complexity:**
- `find(x)`: **O(α(n))** - Inverse Ackermann function ✅✅✅
- `union(x, y)`: **O(α(n))** - Two finds + O(1) update

where α(n) ≈ 4 for all practical n (even n = 2^65536!)

**Effectively constant time!** 🚀

**Space Complexity:** O(n)

### Example Execution

```
Initial tree after some unions (without compression):
    0
    ├─1
    └─2
      └─3
        └─4

find(4):
  Step 1: parent[4] = 3, not root
    → Recursively find(3)
  Step 2: parent[3] = 2, not root
    → Recursively find(2)
  Step 3: parent[2] = 0, not root
    → Recursively find(0)
  Step 4: parent[0] = 0, is root!
    → Return 0

  Now compress paths on the way back:
  - parent[2] = 0 (was pointing to 0, stays 0)
  - parent[3] = 0 (was pointing to 2, now 0!)
  - parent[4] = 0 (was pointing to 3, now 0!)

Result:
    0
    ├─1
    ├─2
    ├─3
    └─4

All nodes now have path length 1 to root!
```

---

## ✅ Solution 5: OPTIMAL - Path Compression + Union by Rank

### Complete Implementation

This is the industry-standard Union Find implementation used in production code!

```typescript
class UnionFind {
  private parent: number[];
  private rank: number[];
  private count: number;  // Number of connected components

  constructor(n: number) {
    this.parent = new Array(n);
    this.rank = new Array(n).fill(0);
    this.count = n;  // Initially all separate

    for (let i = 0; i < n; i++) {
      this.parent[i] = i;
    }
  }

  find(x: number): number {
    // Path compression
    if (this.parent[x] !== x) {
      this.parent[x] = this.find(this.parent[x]);
    }
    return this.parent[x];
  }

  union(x: number, y: number): boolean {
    let rootX = this.find(x);
    let rootY = this.find(y);

    if (rootX === rootY) return false;  // Already connected

    // Union by rank
    if (this.rank[rootX] < this.rank[rootY]) {
      this.parent[rootX] = rootY;
    } else if (this.rank[rootX] > this.rank[rootY]) {
      this.parent[rootY] = rootX;
    } else {
      this.parent[rootY] = rootX;
      this.rank[rootX]++;
    }

    this.count--;  // One less component
    return true;
  }

  connected(x: number, y: number): boolean {
    return this.find(x) === this.find(y);
  }

  getCount(): number {
    return this.count;
  }
}
```

### Final Complexity

**Time Complexity:**
- All operations: **O(α(n))** ≈ **O(1)** for practical purposes ✅✅✅

**Space Complexity:** O(n)

---

## Summary: The Journey

| Approach | Find | Union | Bottleneck | Fix |
|----------|------|-------|------------|-----|
| **1. Brute Force Array** | O(1) | O(n) | Scanning entire array | Use tree structure |
| **2. Quick Union** | O(n) | O(n) | Unbalanced trees | Balance by rank |
| **3. Union by Rank** | O(log n) | O(log n) | Tree height still log n | Compress paths |
| **4. Path Compression** | O(α(n)) | O(α(n)) | - | - |
| **5. Both Optimizations** | O(α(n)) | O(α(n)) | **OPTIMAL** ✅ | - |

---

## Key Takeaways

### Progressive Optimization Pattern

1. **Start simple** - Brute force array (easy to understand)
2. **Identify bottleneck** - Scanning entire array is slow
3. **Apply structure** - Use trees to avoid full scans
4. **New bottleneck emerges** - Unbalanced trees
5. **Balance the structure** - Union by rank
6. **Further optimize** - Path compression flattens trees
7. **Combine techniques** - Both optimizations together achieve near-constant time!

### When to Use Each Version

- **Educational**: Start with brute force, show progression
- **Interviews**: Know all versions, explain tradeoffs
- **Production**: Always use path compression + union by rank

### Real-World Performance

For n = 1,000,000 elements and 1,000,000 operations:

- **Brute Force**: ~500 billion operations (minutes) ❌
- **Quick Union (unbalanced)**: ~500 million operations (seconds) ⚠️
- **Union by Rank**: ~20 million operations (milliseconds) ✅
- **Path Compression + Rank**: ~4 million operations (milliseconds) ✅✅

**The optimizations give us a 100-1000x speedup!**

---

## Usage Examples

### Problem: Number of Connected Components

```typescript
function countComponents(n: number, edges: number[][]): number {
  let uf = new UnionFind(n);

  for (let [u, v] of edges) {
    uf.union(u, v);
  }

  return uf.getCount();
}
```

### Problem: Graph Valid Tree

```typescript
function validTree(n: number, edges: number[][]): boolean {
  // Tree must have exactly n-1 edges
  if (edges.length !== n - 1) return false;

  let uf = new UnionFind(n);

  for (let [u, v] of edges) {
    // If already connected, adding this edge creates a cycle
    if (!uf.union(u, v)) return false;
  }

  return true;
}
```

### Problem: Accounts Merge

```typescript
function accountsMerge(accounts: string[][]): string[][] {
  let uf = new UnionFind(accounts.length);
  let emailToId = new Map<string, number>();

  // Union accounts with same emails
  for (let i = 0; i < accounts.length; i++) {
    for (let j = 1; j < accounts[i].length; j++) {
      let email = accounts[i][j];

      if (emailToId.has(email)) {
        uf.union(i, emailToId.get(email)!);
      } else {
        emailToId.set(email, i);
      }
    }
  }

  // Group by component
  let components = new Map<number, Set<string>>();

  for (let [email, id] of emailToId) {
    let root = uf.find(id);
    if (!components.has(root)) {
      components.set(root, new Set());
    }
    components.get(root)!.add(email);
  }

  // Build result
  let result: string[][] = [];
  for (let [id, emails] of components) {
    result.push([accounts[id][0], ...Array.from(emails).sort()]);
  }

  return result;
}
```

---

This progression shows how we go from O(n) to O(α(n)) ≈ O(1) through incremental, motivated improvements!
