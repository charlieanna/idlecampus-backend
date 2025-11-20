# Trie: Complexity Progression

## Overview

This document shows the progressive optimization from naive string operations to the Trie (Prefix Tree) data structure. Each step identifies bottlenecks and shows incremental improvements.

---

## The Problem

**Given:** A dictionary of words, support these operations:
- `insert(word)`: Add a word to the dictionary
- `search(word)`: Check if a word exists
- `startsWith(prefix)`: Check if any word starts with prefix

**Common use cases:**
- Auto-complete / type-ahead
- Spell checkers
- IP routing tables
- Word games (Boggle, Scrabble)
- Dictionary lookups with prefix queries

---

## ✅ Solution 1: Brute Force with Array

### Implementation

```typescript
class Dictionary {
  private words: string[];

  constructor() {
    this.words = [];
  }

  insert(word: string): void {
    this.words.push(word);
  }

  search(word: string): boolean {
    for (let w of this.words) {
      if (w === word) return true;
    }
    return false;
  }

  startsWith(prefix: string): boolean {
    for (let word of this.words) {
      if (word.startsWith(prefix)) return true;
    }
    return false;
  }
}
```

### Complexity Analysis

**Time Complexity:**
- `insert(word)`: **O(1)** - Just append to array ✅
- `search(word)`: **O(n × m)** - Check all n words, each comparison O(m) ❌
- `startsWith(prefix)`: **O(n × m)** - Check all n words ❌

where n = number of words, m = average word length

**Space Complexity:** O(n × m) - Store all words

### Example Execution

```
insert("cat"): words = ["cat"]
insert("car"): words = ["cat", "car"]
insert("card"): words = ["cat", "car", "card"]

search("car"):
  Check "cat" === "car"? No
  Check "car" === "car"? Yes! ✓

startsWith("ca"):
  Check "cat".startsWith("ca")? Yes! ✓
```

### The Bottleneck 🚨

**Problem 1:** Search is O(n) - must check every word!

For dictionary with 100,000 words:
- Every search checks all 100,000 words
- If average word length is 10, that's 1,000,000 character comparisons!

**Problem 2:** No way to prune search space for prefix queries!

**Question:** Can we avoid checking every word?

---

## ✅ Solution 2: Hash Set (Optimize search, lose prefix capability)

### Key Insight

> Use a hash set for O(1) search!

### Implementation

```typescript
class Dictionary {
  private words: Set<string>;

  constructor() {
    this.words = new Set();
  }

  insert(word: string): void {
    this.words.add(word);
  }

  search(word: string): boolean {
    return this.words.has(word);  // O(1) hash lookup!
  }

  startsWith(prefix: string): boolean {
    // Still O(n × m) - must check all words
    for (let word of this.words) {
      if (word.startsWith(prefix)) return true;
    }
    return false;
  }
}
```

### Complexity Analysis

**Time Complexity:**
- `insert(word)`: **O(m)** - Hash the word ✅
- `search(word)`: **O(m)** - Hash lookup ✅✅
- `startsWith(prefix)`: **O(n × m)** - Still must check all words ❌

**Space Complexity:** O(n × m)

### The Improvement ✅

- **Search is now O(m)** - huge improvement!

### The REMAINING Bottleneck 🚨

**Problem:** Prefix queries still require checking every word!

**Use case:** Auto-complete where user types "ca" and wants all matches:
- Must scan all 100,000 words checking if they start with "ca"

**Question:** How can we optimize prefix queries?

---

## ✅ Solution 3: Sorted Array + Binary Search

### Key Insight

> Sort words alphabetically - words with same prefix are adjacent!

### Implementation

```typescript
class Dictionary {
  private words: string[];

  constructor() {
    this.words = [];
  }

  insert(word: string): void {
    // Insert in sorted position
    let left = 0, right = this.words.length;

    while (left < right) {
      let mid = Math.floor((left + right) / 2);
      if (this.words[mid] < word) {
        left = mid + 1;
      } else {
        right = mid;
      }
    }

    this.words.splice(left, 0, word);
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

    // Check if found word starts with prefix
    return left < this.words.length && this.words[left].startsWith(prefix);
  }
}
```

### Complexity Analysis

**Time Complexity:**
- `insert(word)`: **O(n + m)** - Binary search O(log n × m) + splice O(n) ⚠️
- `search(word)`: **O(log n × m)** - Binary search ✅
- `startsWith(prefix)`: **O(log n × m)** - Binary search ✅

**Space Complexity:** O(n × m)

### The Improvement ✅

- Prefix queries now O(log n) instead of O(n)!

### The REMAINING Bottleneck 🚨

**Problem 1:** Insert is O(n) due to array splice

**Problem 2:** Still comparing entire strings at each binary search step

**Question:** Can we avoid comparing full strings and make insert faster?

---

## ✅ Solution 4: Trie (Prefix Tree) - The Optimal Structure!

### Key Insight

> Share common prefixes! Build a tree where each path from root represents a word.

**Example:**
```
Words: "cat", "car", "card", "dog"

Trie structure:
        root
        / \
       c   d
       |   |
       a   o
      / \  |
     t   r g
         |
         d
```

- `c→a→t` = "cat"
- `c→a→r` = "car"
- `c→a→r→d` = "card"
- `d→o→g` = "dog"

**Key benefit:** Common prefix "ca" is stored only ONCE!

### Implementation

```typescript
class TrieNode {
  children: Map<string, TrieNode>;
  isEndOfWord: boolean;

  constructor() {
    this.children = new Map();
    this.isEndOfWord = false;
  }
}

class Trie {
  private root: TrieNode;

  constructor() {
    this.root = new TrieNode();
  }

  insert(word: string): void {
    let node = this.root;

    // Walk down the tree, creating nodes as needed
    for (let char of word) {
      if (!node.children.has(char)) {
        node.children.set(char, new TrieNode());
      }
      node = node.children.get(char)!;
    }

    node.isEndOfWord = true;
  }

  search(word: string): boolean {
    let node = this.root;

    // Walk down following the characters
    for (let char of word) {
      if (!node.children.has(char)) {
        return false;  // Path doesn't exist
      }
      node = node.children.get(char)!;
    }

    return node.isEndOfWord;  // Must be marked as word
  }

  startsWith(prefix: string): boolean {
    let node = this.root;

    // Walk down following the prefix
    for (let char of prefix) {
      if (!node.children.has(char)) {
        return false;
      }
      node = node.children.get(char)!;
    }

    return true;  // Found the entire prefix path
  }
}
```

### Complexity Analysis

**Time Complexity:**
- `insert(word)`: **O(m)** - Visit each character once ✅✅
- `search(word)`: **O(m)** - Visit each character once ✅✅
- `startsWith(prefix)`: **O(m)** - Visit each character once ✅✅

where m = length of word/prefix (independent of dictionary size!)

**Space Complexity:** O(total characters across all words)
- But shared prefixes save space!
- Example: 100,000 words starting with "un" share the same "un" path

### Example Execution

```
insert("cat"):
  root → c (new) → a (new) → t (new, mark as word)

insert("car"):
  root → c (exists) → a (exists) → r (new, mark as word)

  Trie:
        root
         |
         c
         |
         a
        / \
       t*  r*

insert("card"):
  root → c → a → r (exists) → d (new, mark as word)

  Trie:
        root
         |
         c
         |
         a
        / \
       t*  r*
           |
           d*

search("car"):
  root → has 'c'? Yes
       → c → has 'a'? Yes
            → a → has 'r'? Yes
                 → r → isEndOfWord? Yes ✓

startsWith("ca"):
  root → has 'c'? Yes
       → c → has 'a'? Yes ✓
  (Found entire prefix path!)

startsWith("do"):
  root → has 'd'? No ✗
  (Immediately know no words start with "do")
```

### The KEY Improvements ✅✅✅

1. **All operations O(m)** - independent of dictionary size!
2. **Prefix sharing** - "cat" and "car" share "ca" path
3. **Early termination** - Know immediately if prefix doesn't exist
4. **Space efficient** for common prefixes

---

## ✅ Solution 5: Trie with Array (Space Optimization for Lowercase)

### Key Insight

> If limited alphabet (e.g., only lowercase a-z), use array instead of Map for children!

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

class Trie {
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

**Time Complexity:**
- All operations: **O(m)** with **O(1) child lookup** ✅✅✅

**Space Complexity:**
- Per node: **O(26)** = O(1) constant
- Total: O(number of nodes × 26)

### Tradeoffs

**Array approach:**
- ✅ Faster lookup (array indexing vs Map lookup)
- ❌ More space if alphabet is large or sparse
- ✅ Better cache locality

**Map approach (previous solution):**
- ✅ Space efficient for large/sparse alphabets
- ✅ Works with any characters (Unicode)
- ⚠️ Slightly slower Map operations

**Use array when:** Alphabet is small and dense (e.g., lowercase English letters)

**Use Map when:** Alphabet is large, sparse, or Unicode

---

## ✅ Solution 6: Trie with Advanced Features

### Adding Useful Methods

```typescript
class TrieNode {
  children: Map<string, TrieNode>;
  isEndOfWord: boolean;
  word?: string;  // Store actual word at end nodes
  wordCount: number;  // How many times this word was inserted

  constructor() {
    this.children = new Map();
    this.isEndOfWord = false;
    this.wordCount = 0;
  }
}

class Trie {
  private root: TrieNode;
  private wordCount: number;  // Total words in trie

  constructor() {
    this.root = new TrieNode();
    this.wordCount = 0;
  }

  insert(word: string): void {
    let node = this.root;

    for (let char of word) {
      if (!node.children.has(char)) {
        node.children.set(char, new TrieNode());
      }
      node = node.children.get(char)!;
    }

    if (!node.isEndOfWord) {
      this.wordCount++;
    }

    node.isEndOfWord = true;
    node.word = word;
    node.wordCount++;
  }

  search(word: string): boolean {
    let node = this.root;

    for (let char of word) {
      if (!node.children.has(char)) return false;
      node = node.children.get(char)!;
    }

    return node.isEndOfWord;
  }

  startsWith(prefix: string): boolean {
    let node = this.root;

    for (let char of prefix) {
      if (!node.children.has(char)) return false;
      node = node.children.get(char)!;
    }

    return true;
  }

  // NEW: Get all words with given prefix
  getWordsWithPrefix(prefix: string): string[] {
    let node = this.root;

    // Navigate to prefix
    for (let char of prefix) {
      if (!node.children.has(char)) return [];
      node = node.children.get(char)!;
    }

    // DFS to collect all words from this node
    let words: string[] = [];

    function dfs(node: TrieNode) {
      if (node.isEndOfWord && node.word) {
        words.push(node.word);
      }

      for (let child of node.children.values()) {
        dfs(child);
      }
    }

    dfs(node);
    return words;
  }

  // NEW: Auto-complete (limit to k suggestions)
  autoComplete(prefix: string, k: number): string[] {
    let allWords = this.getWordsWithPrefix(prefix);
    return allWords.slice(0, k);
  }

  // NEW: Delete a word
  delete(word: string): boolean {
    return this.deleteHelper(this.root, word, 0);
  }

  private deleteHelper(node: TrieNode, word: string, index: number): boolean {
    if (index === word.length) {
      if (!node.isEndOfWord) return false;  // Word doesn't exist

      node.isEndOfWord = false;
      node.word = undefined;
      node.wordCount--;

      // Return true if node has no children (can be deleted)
      return node.children.size === 0;
    }

    let char = word[index];
    if (!node.children.has(char)) return false;

    let childNode = node.children.get(char)!;
    let shouldDeleteChild = this.deleteHelper(childNode, word, index + 1);

    if (shouldDeleteChild) {
      node.children.delete(char);
      // Return true if this node can also be deleted
      return !node.isEndOfWord && node.children.size === 0;
    }

    return false;
  }

  // NEW: Count total words
  size(): number {
    return this.wordCount;
  }

  // NEW: Get longest common prefix
  longestCommonPrefix(): string {
    let prefix = "";
    let node = this.root;

    while (node.children.size === 1 && !node.isEndOfWord) {
      let [char, child] = node.children.entries().next().value;
      prefix += char;
      node = child;
    }

    return prefix;
  }
}
```

### Advanced Features Complexity

- `getWordsWithPrefix(prefix)`: **O(m + k)** where k = number of matching words
- `autoComplete(prefix, k)`: **O(m + min(k, total_words))**
- `delete(word)`: **O(m)**
- `longestCommonPrefix()`: **O(m)** where m = length of LCP

---

## Summary: The Journey

| Approach | Insert | Search | Prefix Query | Space | Notes |
|----------|--------|--------|--------------|-------|-------|
| **1. Array** | O(1) | O(n×m) | O(n×m) | O(n×m) | Must check all words |
| **2. Hash Set** | O(m) | O(m) | O(n×m) | O(n×m) | Good search, bad prefix |
| **3. Sorted + Binary** | O(n+m) | O(log n×m) | O(log n×m) | O(n×m) | Insert slow (splice) |
| **4. Trie (Map)** | O(m) | O(m) | O(m) | O(nodes×M) | **OPTIMAL** ✅ |
| **5. Trie (Array)** | O(m) | O(m) | O(m) | O(nodes×26) | Faster for small alphabet |

---

## Key Takeaways

### Progressive Optimization Pattern

1. **Start simple** - Array of strings (easy to understand)
2. **Optimize search** - Hash set for O(1) lookup
3. **Bottleneck emerges** - Prefix queries still O(n)
4. **Try sorting** - Binary search helps but insert is slow
5. **Fundamental insight** - Share common prefixes in a tree!
6. **Final optimization** - Array vs Map based on alphabet size

### When to Use Trie

✅ **Use Trie when:**
- Prefix queries are common (auto-complete)
- Many words share common prefixes
- Need to list all words with prefix
- Dictionary operations (insert, search, prefix)
- Limited alphabet (even better with array)

❌ **Don't use Trie when:**
- Only need exact word lookup (Hash Set is simpler)
- No prefix queries needed
- Memory is very constrained
- Words have little prefix overlap

### Real-World Performance

For dictionary with 100,000 words, average length 10:

**Search "cat":**
- Array: Check 100,000 words × 10 chars = 1,000,000 comparisons ❌
- Hash Set: Hash "cat" (3 chars) + O(1) lookup = ~3 operations ✅
- Trie: Follow 3 edges = 3 operations ✅

**Find words starting with "ca":**
- Array: Check 100,000 words × 2 chars = 200,000 comparisons ❌
- Hash Set: Check 100,000 words × 2 chars = 200,000 comparisons ❌
- Trie: Follow 2 edges + collect results = 2 + k operations ✅✅

**Trie shines for prefix operations!**

---

## Usage Examples

### Auto-Complete System

```typescript
class AutoComplete {
  private trie: Trie;

  constructor(words: string[]) {
    this.trie = new Trie();
    for (let word of words) {
      this.trie.insert(word);
    }
  }

  getSuggestions(prefix: string, limit: number = 10): string[] {
    return this.trie.autoComplete(prefix, limit);
  }
}

let ac = new AutoComplete(["apple", "application", "apply", "banana"]);
console.log(ac.getSuggestions("app", 5));
// Output: ["apple", "application", "apply"]
```

### Spell Checker

```typescript
class SpellChecker {
  private trie: Trie;

  constructor(dictionary: string[]) {
    this.trie = new Trie();
    for (let word of dictionary) {
      this.trie.insert(word.toLowerCase());
    }
  }

  isCorrect(word: string): boolean {
    return this.trie.search(word.toLowerCase());
  }

  getSuggestions(word: string): string[] {
    // Simple approach: get words with same prefix
    for (let len = word.length; len > 0; len--) {
      let prefix = word.substring(0, len);
      let suggestions = this.trie.getWordsWithPrefix(prefix);
      if (suggestions.length > 0) {
        return suggestions.slice(0, 5);
      }
    }
    return [];
  }
}
```

### Word Search Game (Boggle)

```typescript
function findWords(board: string[][], words: string[]): string[] {
  // Build Trie of words to search
  let trie = new Trie();
  for (let word of words) {
    trie.insert(word);
  }

  let found = new Set<string>();

  function dfs(row: number, col: number, node: TrieNode, path: string) {
    // Trie pruning: if current path not in trie, stop!
    if (!node) return;

    if (node.isEndOfWord) {
      found.add(path);
    }

    // Mark visited
    let char = board[row][col];
    board[row][col] = '#';

    // Try all 4 directions
    let dirs = [[0,1], [1,0], [0,-1], [-1,0]];
    for (let [dr, dc] of dirs) {
      let newR = row + dr, newC = col + dc;

      if (newR >= 0 && newR < board.length &&
          newC >= 0 && newC < board[0].length &&
          board[newR][newC] !== '#') {

        let nextChar = board[newR][newC];
        if (node.children.has(nextChar)) {
          dfs(newR, newC, node.children.get(nextChar)!,
              path + nextChar);
        }
      }
    }

    // Restore
    board[row][col] = char;
  }

  // Start DFS from each cell
  for (let i = 0; i < board.length; i++) {
    for (let j = 0; j < board[0].length; j++) {
      let char = board[i][j];
      if (trie.root.children.has(char)) {
        dfs(i, j, trie.root.children.get(char)!, char);
      }
    }
  }

  return Array.from(found);
}
```

---

This progression shows how we go from O(n×m) to O(m) through structural insights about prefix sharing!
