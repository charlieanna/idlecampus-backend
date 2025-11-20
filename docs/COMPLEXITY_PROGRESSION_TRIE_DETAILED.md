# Trie: From First Principles to Optimal (Granular Progression)

## The Problem: Dictionary with Prefix Queries

**Given:** A collection of words that we need to:
- `insert(word)`: Add a word to dictionary
- `search(word)`: Check if exact word exists
- `startsWith(prefix)`: Check if any word starts with prefix
- `getWordsWithPrefix(prefix)`: Get all words starting with prefix

**Example:**
```
Dictionary: "cat", "car", "card", "dog", "door"

search("car") → true
search("cars") → false
startsWith("ca") → true (cat, car, card)
startsWith("do") → true (dog, door)
getWordsWithPrefix("ca") → ["cat", "car", "card"]
```

---

## Level 1: Most Basic - Understand String Comparison Cost

### Let's Start at the VERY Beginning

Before we build any data structure, let's understand: **How do we check if two strings are equal?**

```typescript
function stringsEqual(s1: string, s2: string): boolean {
  // First check: different lengths?
  if (s1.length !== s2.length) return false;

  // Compare character by character
  for (let i = 0; i < s1.length; i++) {
    if (s1[i] !== s2[i]) {
      return false;
    }
  }

  return true;
}
```

**Cost:** Must compare up to `m` characters (where m = string length)
**Complexity:** O(m) per comparison

### Example

```
stringsEqual("cat", "car"):
  Length check: 3 === 3 ✓
  s1[0] === s2[0]? 'c' === 'c' ✓
  s1[1] === s2[1]? 'a' === 'a' ✓
  s1[2] === s2[2]? 't' === 'r' ✗
  return false

  3 character comparisons
```

**Key insight:** We can't avoid comparing characters! Checking if two strings are equal fundamentally costs O(m).

**Question:** If we have n words in dictionary and check each one, what's the cost?

---

## Level 2: Array of Strings - Most Obvious Approach

### Implementation

```typescript
class Dictionary {
  private words: string[];

  constructor() {
    this.words = [];
  }

  insert(word: string): void {
    // Just add to end - O(1)
    this.words.push(word);
  }

  search(word: string): boolean {
    // Check each word
    for (let w of this.words) {
      if (w === word) return true;  // O(m) comparison
    }
    return false;
  }

  startsWith(prefix: string): boolean {
    // Check if any word starts with prefix
    for (let word of this.words) {
      if (this.hasPrefix(word, prefix)) return true;
    }
    return false;
  }

  private hasPrefix(word: string, prefix: string): boolean {
    if (word.length < prefix.length) return false;

    for (let i = 0; i < prefix.length; i++) {
      if (word[i] !== prefix[i]) return false;
    }

    return true;
  }

  getWordsWithPrefix(prefix: string): string[] {
    let result: string[] = [];

    for (let word of this.words) {
      if (this.hasPrefix(word, prefix)) {
        result.push(word);
      }
    }

    return result;
  }
}
```

### Example Execution

```
words = []

insert("cat"):
  words = ["cat"]

insert("car"):
  words = ["cat", "car"]

insert("dog"):
  words = ["cat", "car", "dog"]

search("car"):
  Check "cat" === "car"?
    'c' === 'c' ✓
    'a' === 'a' ✓
    't' === 'r' ✗  → Not equal

  Check "car" === "car"?
    'c' === 'c' ✓
    'a' === 'a' ✓
    'r' === 'r' ✓  → Equal! return true

  Checked 2 words, did 6 character comparisons

startsWith("ca"):
  Check "cat" starts with "ca"?
    'c' === 'c' ✓
    'a' === 'a' ✓  → Yes! return true

  Checked 1 word, did 2 character comparisons
```

### Complexity Analysis

**Operations:**
- `insert(word)`: **O(1)** - Just append to array ✅
- `search(word)`: **O(n × m)** - Check n words, m comparisons each ❌
- `startsWith(prefix)`: **O(n × m)** - Check n words ❌
- `getWordsWithPrefix(prefix)`: **O(n × m)** - Check all n words ❌

where n = number of words, m = average word length

**Memory:**
- **Space: O(n × m)** - Store all words ✅

### Bottleneck #1 🚨

**Problem:** Must check EVERY word for search and prefix queries!

**Example with 100,000 words:**
```
search("cat"):
  Worst case: Compare against all 100,000 words
  If average word length = 10: 1,000,000 character comparisons!

startsWith("ca"):
  Must check all 100,000 words
  Even though only ~1,000 words start with "ca"!
```

**Question:** Can we avoid checking words we know DON'T match?

---

## Level 3: Hash Set - Optimize Exact Search

### Key Insight

> Use a hash table for O(1) lookup of exact words!

**How hashing works:**
```
hash("cat") → compute hash value → 1847
words[1847] = "cat"

To search:
hash("cat") → 1847 → lookup words[1847] → found!
```

### Implementation

```typescript
class Dictionary {
  private words: Set<string>;

  constructor() {
    this.words = new Set();
  }

  insert(word: string): void {
    this.words.add(word);  // O(m) to hash the word
  }

  search(word: string): boolean {
    return this.words.has(word);  // O(m) to hash + O(1) lookup
  }

  startsWith(prefix: string): boolean {
    // Still must check all words! No improvement yet
    for (let word of this.words) {
      if (this.hasPrefix(word, prefix)) return true;
    }
    return false;
  }

  private hasPrefix(word: string, prefix: string): boolean {
    if (word.length < prefix.length) return false;

    for (let i = 0; i < prefix.length; i++) {
      if (word[i] !== prefix[i]) return false;
    }

    return true;
  }

  getWordsWithPrefix(prefix: string): string[] {
    let result: string[] = [];

    for (let word of this.words) {
      if (this.hasPrefix(word, prefix)) {
        result.push(word);
      }
    }

    return result;
  }
}
```

### Complexity Analysis

**Operations:**
- `insert(word)`: **O(m)** - Hash the word ✅
- `search(word)`: **O(m)** - Hash + lookup ✅✅
- `startsWith(prefix)`: **O(n × m)** - Still check all words ❌
- `getWordsWithPrefix(prefix)`: **O(n × m)** ❌

**Memory:**
- **Space: O(n × m)** ✅

### The Improvement ✅

- `search` improved from O(n × m) to O(m)!
- For 100,000 words: 100,000x faster search!

### Bottleneck #2 🚨

**Problem:** Prefix queries STILL check every word!

Hash tables destroy order information - we can't use prefix structure.

**Example:**
```
words = {"cat", "car", "card", "dog", "door"}

startsWith("ca"):
  Must check ALL 5 words:
  ✓ cat starts with ca
  ✓ car starts with ca
  ✓ card starts with ca
  ✗ dog doesn't
  ✗ door doesn't

  No way to skip "dog" and "door"!
```

**Question:** Can we group words by prefix somehow?

---

## Level 4: Sorted Array - Group Similar Words

### Key Insight

> If we sort words alphabetically, words with same prefix are ADJACENT!

**Example:**
```
Sorted: ["car", "card", "cat", "dog", "door"]
         └─────────┘  ← All "ca" words together!
                       └──────────┘  ← All "do" words together!
```

### Implementation

```typescript
class Dictionary {
  private words: string[];

  constructor() {
    this.words = [];
  }

  insert(word: string): void {
    // Binary search to find insert position
    let left = 0, right = this.words.length;

    while (left < right) {
      let mid = Math.floor((left + right) / 2);

      if (this.words[mid] < word) {
        left = mid + 1;
      } else {
        right = mid;
      }
    }

    // Insert at position 'left'
    this.words.splice(left, 0, word);  // O(n) to shift elements!
  }

  search(word: string): boolean {
    // Binary search
    let left = 0, right = this.words.length - 1;

    while (left <= right) {
      let mid = Math.floor((left + right) / 2);

      if (this.words[mid] === word) return true;

      if (this.words[mid] < word) {
        left = mid + 1;
      } else {
        right = mid - 1;
      }
    }

    return false;
  }

  startsWith(prefix: string): boolean {
    // Binary search for first word >= prefix
    let left = 0, right = this.words.length - 1;

    while (left <= right) {
      let mid = Math.floor((left + right) / 2);

      if (this.words[mid] < prefix) {
        left = mid + 1;
      } else {
        right = mid - 1;
      }
    }

    // Check if word at 'left' starts with prefix
    if (left < this.words.length) {
      return this.hasPrefix(this.words[left], prefix);
    }

    return false;
  }

  private hasPrefix(word: string, prefix: string): boolean {
    if (word.length < prefix.length) return false;

    for (let i = 0; i < prefix.length; i++) {
      if (word[i] !== prefix[i]) return false;
    }

    return true;
  }

  getWordsWithPrefix(prefix: string): string[] {
    // Find first word with prefix
    let start = 0;
    let left = 0, right = this.words.length;

    while (left < right) {
      let mid = Math.floor((left + right) / 2);

      if (this.words[mid] < prefix) {
        left = mid + 1;
      } else {
        right = mid;
      }
    }
    start = left;

    // Collect all consecutive words with prefix
    let result: string[] = [];
    while (start < this.words.length &&
           this.hasPrefix(this.words[start], prefix)) {
      result.push(this.words[start]);
      start++;
    }

    return result;
  }
}
```

### Example Execution

```
words = []

insert("dog"):
  Binary search finds position 0
  words = ["dog"]

insert("cat"):
  Binary search:
    mid=0: "dog" > "cat", search left
    Insert at position 0
  words = ["cat", "dog"]

insert("car"):
  Binary search:
    mid=0: "cat" > "car", search left
    Insert at position 0... wait, need more steps
  Final position: 1 (between "cat" and "dog")
  words = ["cat", "car", "dog"]

Actually, let's see fully sorted:
  words = ["car", "cat", "dog"]

startsWith("ca"):
  Binary search for first word >= "ca":
    mid=1: "cat" >= "ca", search left
    mid=0: "car" >= "ca", search left
    left=0

  Check words[0] = "car" starts with "ca"? YES!
  return true

  Only checked 2 positions in binary search + 1 prefix check!
```

### Complexity Analysis

**Operations:**
- `insert(word)`: **O(log n × m + n)** - Binary search O(log n × m), splice O(n) ⚠️
- `search(word)`: **O(log n × m)** - Binary search with string comparisons ✅
- `startsWith(prefix)`: **O(log n × m)** - Binary search ✅
- `getWordsWithPrefix(prefix)`: **O(log n × m + k)** where k = matches ✅

**Memory:**
- **Space: O(n × m)** ✅

### The Improvement ✅

- `search` improved to O(log n × m) instead of O(n × m)
- `startsWith` improved to O(log n × m) instead of O(n × m)
- For 100,000 words: ~17 comparisons instead of 100,000!

### Bottleneck #3 🚨

**Problem 1:** Insert is O(n) because of array splice (shifting elements)

**Problem 2:** Still doing FULL string comparisons at each binary search step

**Example:**
```
Binary search comparing "catastrophe" against many words:

Compare "catastrophe" vs "car":
  'c' === 'c' ✓
  'a' === 'a' ✓
  't' === 'r' ✗  → "catastrophe" > "car"

Compare "catastrophe" vs "cat":
  'c' === 'c' ✓
  'a' === 'a' ✓
  't' === 't' ✓  → Need to continue comparing...

We compare 'c', 'a', 't' MULTIPLE times during binary search!
```

**Question:** Can we avoid re-comparing shared prefixes?

---

## Level 5: Hash Map by First Character - Simple Bucketing

### Key Insight

> Group words by first character! Reduces search space by ~26x for English.

```
Dictionary:
  'a' → ["apple", "ant"]
  'b' → ["bat", "ball"]
  'c' → ["cat", "car", "card"]
  'd' → ["dog", "door"]
```

### Implementation

```typescript
class Dictionary {
  private buckets: Map<string, string[]>;

  constructor() {
    this.buckets = new Map();
  }

  insert(word: string): void {
    if (word.length === 0) return;

    let firstChar = word[0];

    if (!this.buckets.has(firstChar)) {
      this.buckets.set(firstChar, []);
    }

    this.buckets.get(firstChar)!.push(word);
  }

  search(word: string): boolean {
    if (word.length === 0) return false;

    let firstChar = word[0];

    if (!this.buckets.has(firstChar)) return false;

    // Only search words starting with same letter!
    for (let w of this.buckets.get(firstChar)!) {
      if (w === word) return true;
    }

    return false;
  }

  startsWith(prefix: string): boolean {
    if (prefix.length === 0) return true;

    let firstChar = prefix[0];

    if (!this.buckets.has(firstChar)) return false;

    for (let word of this.buckets.get(firstChar)!) {
      if (this.hasPrefix(word, prefix)) return true;
    }

    return false;
  }

  private hasPrefix(word: string, prefix: string): boolean {
    if (word.length < prefix.length) return false;

    for (let i = 0; i < prefix.length; i++) {
      if (word[i] !== prefix[i]) return false;
    }

    return true;
  }
}
```

### Complexity Analysis

Assuming uniform distribution across letters:

**Operations:**
- `insert(word)`: **O(1)** - Just append to bucket ✅
- `search(word)`: **O((n/26) × m)** ≈ **O(n × m)** - Still linear in bucket ⚠️
- `startsWith(prefix)`: **O((n/26) × m)** ⚠️

**Memory:**
- **Space: O(n × m + 26)** ≈ O(n × m) ✅

### The Improvement ✅

- ~26x smaller search space
- Fast insert again!

### Bottleneck #4 🚨

**Problem:** Only bucketed by first character! Still checking many words.

**Example:**
```
Bucket 'c' contains: ["cat", "car", "card", "cow", "cup", "can", ...]

search("cat"): Still must check all 'c' words!

startsWith("ca"): Still checks "cow", "cup" even though they don't match!
```

**Question:** What if we bucket by first TWO characters? Or three? Or...?

---

## Level 6: Multi-Level Bucketing - Almost a Trie!

### Key Insight

> Bucket by first character, then within each bucket, bucket by SECOND character, and so on!

**This is a TREE structure:**
```
root
 ├─ c
 │  ├─ a
 │  │  ├─ t (word: "cat")
 │  │  └─ r (word: "car")
 │  │     └─ d (word: "card")
 │  └─ o
 │     └─ w (word: "cow")
 └─ d
    └─ o
       └─ g (word: "dog")
```

**We just invented a TRIE!**

### Implementation - First Version

```typescript
class TrieNode {
  children: Map<string, TrieNode>;
  isEndOfWord: boolean;

  constructor() {
    this.children = new Map();
    this.isEndOfWord = false;
  }
}

class Dictionary {
  private root: TrieNode;

  constructor() {
    this.root = new TrieNode();
  }

  insert(word: string): void {
    let node = this.root;

    // Walk down tree, creating nodes as needed
    for (let char of word) {
      if (!node.children.has(char)) {
        node.children.set(char, new TrieNode());
      }

      node = node.children.get(char)!;
    }

    // Mark end of word
    node.isEndOfWord = true;
  }

  search(word: string): boolean {
    let node = this.root;

    // Walk down tree following characters
    for (let char of word) {
      if (!node.children.has(char)) {
        return false;  // Path doesn't exist!
      }

      node = node.children.get(char)!;
    }

    // Must be marked as end of word
    return node.isEndOfWord;
  }

  startsWith(prefix: string): boolean {
    let node = this.root;

    // Just need to find the path
    for (let char of prefix) {
      if (!node.children.has(char)) {
        return false;
      }

      node = node.children.get(char)!;
    }

    return true;  // Found entire prefix path!
  }
}
```

### Example Execution

```
root = new TrieNode()

insert("cat"):
  node = root
  char = 'c': root has no 'c', create new node
    root.children['c'] = new TrieNode()
    node = root.children['c']
  char = 'a': node has no 'a', create new node
    node.children['a'] = new TrieNode()
    node = node.children['a']
  char = 't': node has no 't', create new node
    node.children['t'] = new TrieNode()
    node = node.children['t']
  node.isEndOfWord = true

Tree:
  root
   └─ c
      └─ a
         └─ t*  (* = end of word)

insert("car"):
  node = root
  char = 'c': root.children['c'] EXISTS!
    node = root.children['c']
  char = 'a': node.children['a'] EXISTS!
    node = node.children['a']
  char = 'r': node has no 'r', create new node
    node.children['r'] = new TrieNode()
    node = node.children['r']
  node.isEndOfWord = true

Tree:
  root
   └─ c
      └─ a
         ├─ t*
         └─ r*

Notice: "ca" is shared! Only stored ONCE!

insert("card"):
  Walk to 'r' (all nodes exist)
  Create 'd' node
  Mark 'd' as end of word

Tree:
  root
   └─ c
      └─ a
         ├─ t*
         └─ r*
            └─ d*

search("car"):
  node = root
  char = 'c': root.children['c'] exists → move to it
  char = 'a': node.children['a'] exists → move to it
  char = 'r': node.children['r'] exists → move to it
  node.isEndOfWord? YES!
  return true

  Only 3 lookups! No string comparisons!

search("ca"):
  Walk to 'a' node
  node.isEndOfWord? NO!
  return false
  (Even though "cat" and "car" exist, "ca" itself isn't a word)

startsWith("ca"):
  node = root
  char = 'c': exists → move to it
  char = 'a': exists → move to it
  return true

  Found the path! Don't need to check isEndOfWord for prefix query.
```

### Complexity Analysis

**Operations:**
- `insert(word)`: **O(m)** - Visit each character once ✅✅
- `search(word)`: **O(m)** - Visit each character once ✅✅
- `startsWith(prefix)`: **O(m)** - Visit each character once ✅✅

where m = word/prefix length (INDEPENDENT of dictionary size n!)

**Memory:**
- **Space: O(total characters in all words)**
- But shared prefixes only stored once!
- Example: 100,000 words starting with "un" share the same "un" path

### The BREAKTHROUGH ✅✅✅

**All operations are O(m) - independent of dictionary size!**

**Comparison for dictionary with 100,000 words:**
```
search("cat"):
  Array: Check up to 100,000 words = 300,000 character comparisons
  Hash Set: Hash "cat" = 3 operations + O(1) lookup
  Trie: Follow 3 edges = 3 operations

startsWith("ca"):
  Array: Check all 100,000 words = 200,000 character comparisons
  Hash Set: Check all 100,000 words = 200,000 character comparisons
  Sorted: Binary search ~17 comparisons × 2 chars = 34 operations
  Trie: Follow 2 edges = 2 operations!
```

**Trie is 100,000x better for prefix queries!**

### Bottleneck #5 🚨 (Minor)

**Problem:** Using Map for children - what if alphabet is small (a-z)?

Map operations have some overhead:
- Hash function
- Collision handling
- Pointer indirection

**Question:** For limited alphabet, can we use a faster structure?

---

## Level 7: Array Children for Small Alphabets

### Key Insight

> If alphabet is known and small (e.g., a-z = 26 letters), use array instead of Map!

**Array lookup: O(1) with no hashing overhead**

### Implementation

```typescript
class TrieNode {
  children: (TrieNode | null)[];  // Size 26 for a-z
  isEndOfWord: boolean;

  constructor() {
    this.children = new Array(26).fill(null);
    this.isEndOfWord = false;
  }
}

class Dictionary {
  private root: TrieNode;

  constructor() {
    this.root = new TrieNode();
  }

  private charToIndex(char: string): number {
    return char.charCodeAt(0) - 'a'.charCodeAt(0);
  }

  insert(word: string): void {
    let node = this.root;

    for (let char of word) {
      let index = this.charToIndex(char);

      if (node.children[index] === null) {
        node.children[index] = new TrieNode();
      }

      node = node.children[index]!;
    }

    node.isEndOfWord = true;
  }

  search(word: string): boolean {
    let node = this.root;

    for (let char of word) {
      let index = this.charToIndex(char);

      if (node.children[index] === null) {
        return false;
      }

      node = node.children[index]!;
    }

    return node.isEndOfWord;
  }

  startsWith(prefix: string): boolean {
    let node = this.root;

    for (let char of prefix) {
      let index = this.charToIndex(char);

      if (node.children[index] === null) {
        return false;
      }

      node = node.children[index]!;
    }

    return true;
  }
}
```

### Complexity Analysis

**Operations:**
- All operations: **O(m)** with **faster constant factor** ✅✅✅
  - No hashing
  - Direct array indexing
  - Better cache locality

**Memory:**
- Per node: **26 pointers** (even if only 1-2 used)
- More space if alphabet is sparse
- Less space if alphabet is dense

### Comparison: Map vs Array

**Map (Level 6):**
- ✅ Works with any characters (Unicode)
- ✅ Space efficient for sparse/large alphabets
- ⚠️ Slower Map operations

**Array (Level 7):**
- ✅ Faster - direct array indexing
- ✅ Better for small alphabets (a-z)
- ❌ Wastes space for sparse alphabets
- ❌ Doesn't work for Unicode

**Choose based on use case!**

---

## Complete Summary: The Optimization Journey

| Level | Approach | Insert | Search | Prefix | Space | Key Bottleneck | Fix |
|-------|----------|--------|--------|--------|-------|----------------|-----|
| **1** | String comparison | - | - | - | - | Understand O(m) cost | Build structures |
| **2** | Array of strings | O(1) | O(n×m) | O(n×m) | O(n×m) | Check every word | Hash for search |
| **3** | Hash Set | O(m) | O(m) | O(n×m) | O(n×m) | Prefix still checks all | Sort words |
| **4** | Sorted Array | O(n) | O(log n×m) | O(log n×m) | O(n×m) | Insert O(n), repeat comparisons | Bucket by char |
| **5** | Hash by 1st char | O(1) | O(n×m) | O(n×m) | O(n×m) | Still check bucket | Multi-level bucket |
| **6** | Trie (Map) | O(m) | O(m) | O(m) | O(nodes) | Map overhead | Array for small alphabet |
| **7** | Trie (Array) | O(m) | O(m) | O(m) | O(nodes×26) | **OPTIMAL** ✅ | - |

---

## Micro-Bottlenecks Discovered

1. **String comparison is O(m)** → Can't avoid, but can minimize
2. **Checking all n words** → Use hash set for exact match
3. **Prefix queries check all words** → Sort groups by prefix
4. **Insert shifts array** → Use tree structure
5. **Repeating character comparisons** → Share prefixes in tree
6. **Only bucket by first char** → Multi-level bucketing (Trie!)
7. **Map has overhead** → Array for small alphabets

Each fix addressed ONE specific inefficiency!

---

## Visual: How Trie Shares Prefixes

**Words:** "cat", "cats", "catastrophe", "car", "card", "dog"

**Without Trie (Array):**
```
words[0] = "cat"         = c a t
words[1] = "cats"        = c a t s
words[2] = "catastrophe" = c a t a s t r o p h e
words[3] = "car"         = c a r
words[4] = "card"        = c a r d
words[5] = "dog"         = d o g

Total characters stored: 3+4+11+3+4+3 = 28
"ca" stored 4 separate times!
```

**With Trie:**
```
        root
         / \
        c   d
        |   |
        a   o
       / \  |
      t   r g*
      |   |
      *   d*
      |
      s*
      |
      a
      |
      s
      |
      t
      |
      r
      |
      o
      |
      p
      |
      h
      |
      e*

Nodes: ~15-20 (depending on structure)
"ca" stored ONCE, shared by all "ca-" words!
```

---

## Real Performance Impact

**100,000 word dictionary, average word length 10:**

| Operation | Array | Hash Set | Trie |
|-----------|-------|----------|------|
| Insert "cat" | 1 op | 3 ops (hash) | 3 ops (walk tree) |
| Search "cat" | ~50,000 word checks<br/>~500,000 char comparisons | 3 ops (hash)<br/>+ O(1) lookup | 3 ops (walk tree) |
| Prefix "ca" | ~50,000 word checks<br/>~100,000 char comparisons | ~50,000 word checks<br/>~100,000 char comparisons | 2 ops (walk tree) |

**Trie gives 50,000x improvement for prefix queries!**

**Memory:**
- Array: ~1MB for 100K words
- Hash Set: ~1-2MB (hash overhead)
- Trie: ~500KB-1MB (shared prefixes!)

Trie uses LESS memory by sharing common prefixes!

---

## When Each Approach Wins

**Use Array:**
- Very small dictionary (< 100 words)
- Rarely searched
- Simplicity matters

**Use Hash Set:**
- Only exact word lookups (no prefix queries)
- Large dictionary
- Fast search critical

**Use Sorted Array:**
- Read-heavy (few inserts)
- Occasional prefix queries
- Memory constrained

**Use Trie:**
- ✅ Auto-complete / type-ahead
- ✅ Frequent prefix queries
- ✅ Many words with shared prefixes
- ✅ Dictionary operations
- ✅ Word games (Boggle, Scrabble)

---

This shows the journey from O(n×m) linear scan to O(m) tree walk through discovering that prefix sharing is the KEY insight!
