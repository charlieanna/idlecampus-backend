# Module 12: Tries & Advanced String Patterns

## Overview
This module teaches Trie data structures and advanced string manipulation patterns. Students learn to build and use Tries, solve string matching problems, and master advanced string algorithms.

**Total Items**: 10
**Estimated Time**: 3-4 hours
**Prerequisites**: Module 1 (Arrays), Module 2 (Hash Maps), Module 4 (Trees)

---

## Learning Philosophy

Following the IdleCampus adaptive learning approach:
1. **Present Problem First**: User encounters the problem before seeing Trie solution
2. **Detect Approach**: Analyze if user writes brute force or Trie-based solution
3. **Adaptive Branching**: Different learning paths based on user's solution
4. **Guide, Don't Give Away**: Help user discover when Tries optimize lookups
5. **Brute Force → Optimization**: From O(n*m) to O(n+m) with Trie

---

## Module Structure

### Part 1: Trie Fundamentals (Items 1-5)
- What is a Trie?
- Implement Trie (insert, search, startsWith)
- Word search with Trie
- Prefix matching

### Part 2: Advanced String Patterns (Items 6-10)
- String matching algorithms
- Palindrome detection
- Anagram grouping
- Longest common prefix

---

## Detailed Item Specifications

### **ITEM 1: Introduction to Tries**
**Type**: Lesson Only
**Duration**: 5 minutes

**Content**:
```
# Tries (Prefix Trees)

A Trie is a tree-like data structure specialized for string operations, especially prefix matching.

## Structure:

```
Trie containing "cat", "car", "card":

        root
         |
         c
         |
         a
        / \
       t   r
           |
           d
```

## Why Tries?

**Problem**: Check if word exists in dictionary of 100,000 words.

Hash Set: O(m) where m = word length
Trie: O(m) but also enables prefix queries!

## Key Operations:

```typescript
class TrieNode {
  children: Map<string, TrieNode> = new Map();
  isEndOfWord: boolean = false;
}

class Trie {
  root = new TrieNode();

  insert(word: string): void {
    let node = this.root;
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
    return true;  // Found entire prefix path
  }
}
```

## Time Complexity:
- Insert: O(m)
- Search: O(m)
- StartsWith: O(m)

where m = length of word/prefix

## Space: O(total characters in all words)

## When to Use Tries:

✅ Auto-complete / type-ahead
✅ Spell checker
✅ IP routing tables
✅ Word games (Boggle, Scrabble)
✅ Prefix matching problems

Let's master Tries!
```

**Next**: Item 2

---

### **ITEM 2: Implement Trie**
**Type**: Lesson + Problem
**Duration**: 15-18 minutes

**Left Panel (Lesson)**:
```
# Implement a Trie

**Problem**: Implement insert, search, and startsWith operations.

## Full Implementation:

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

    for (let char of word) {
      if (!node.children.has(char)) {
        return false;
      }
      node = node.children.get(char)!;
    }

    return node.isEndOfWord;
  }

  startsWith(prefix: string): boolean {
    let node = this.root;

    for (let char of prefix) {
      if (!node.children.has(char)) {
        return false;
      }
      node = node.children.get(char)!;
    }

    return true;
  }
}
```

Try implementing this on the right →
```

**Right Panel (Problem)**: `trie-1` (Implement Trie)

**Next**: Item 3

---

### **ITEM 3: Add and Search Word**
**Type**: Lesson + Problem
**Duration**: 15-18 minutes

**Left Panel (Lesson)**:
```
# Trie with Wildcard Search

**Problem**: Support '.' as wildcard (matches any character).

```
addWord("bad")
addWord("dad")
addWord("mad")

search("pad") → false
search("bad") → true
search(".ad") → true
search("b..") → true
```

## Implementation:

```typescript
class WordDictionary {
  private root: TrieNode;

  addWord(word: string): void {
    // Same as Trie insert
  }

  search(word: string): boolean {
    return this.searchFrom(word, 0, this.root);
  }

  private searchFrom(word: string, index: number, node: TrieNode): boolean {
    if (index === word.length) {
      return node.isEndOfWord;
    }

    let char = word[index];

    if (char === '.') {
      // Wildcard: try all children
      for (let child of node.children.values()) {
        if (this.searchFrom(word, index + 1, child)) {
          return true;
        }
      }
      return false;
    } else {
      // Regular character
      if (!node.children.has(char)) return false;
      return this.searchFrom(word, index + 1, node.children.get(char)!);
    }
  }
}
```

## Key: Recursion for wildcard!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `trie-2` (Design Add and Search Words Data Structure)

**Next**: Item 4

---

### **ITEM 4: Word Search II (Trie + Backtracking)**
**Type**: Lesson + Problem
**Duration**: 20-25 minutes

**Left Panel (Lesson)**:
```
# Combining Trie with Backtracking

We solved this in Module 9, but let's understand the Trie optimization!

**Problem**: Find all words from dictionary in grid.

## Without Trie: O(words * cells * 4^wordLength)
For each word, DFS from each cell.

## With Trie: O(cells * 4^maxWordLength)
One DFS, prune using Trie!

## Key Optimization:

```typescript
function backtrack(row: number, col: number, node: TrieNode) {
  let char = board[row][col];

  // Prune: if char not in Trie, stop immediately!
  if (!node.children.has(char)) return;

  let nextNode = node.children.get(char)!;

  // Found a word?
  if (nextNode.word) {
    result.add(nextNode.word);
    nextNode.word = null;  // Avoid duplicates
  }

  // Continue DFS
  board[row][col] = '#';  // Mark visited

  for (let [dr, dc] of directions) {
    let newR = row + dr, newC = col + dc;
    if (isValid(newR, newC)) {
      backtrack(newR, newC, nextNode);
    }
  }

  board[row][col] = char;  // Restore
}
```

## Why Trie is Better:
- Prunes impossible paths early
- Finds all words in one pass
- No repeated work

This is covered in Module 9, but understanding the Trie optimization is key!
```

**Right Panel (Problem)**: Reference to Module 9's Word Search II

**Next**: Item 5

---

### **ITEM 5: Longest Word in Dictionary**
**Type**: Problem Only
**Duration**: 15-18 minutes

**Left Panel (Problem Context)**:
```
# Practice: Trie + DFS

**Problem**: Find longest word that can be built one character at a time.

```
Input: words = ["w","wo","wor","worl","world"]
Output: "world"
Explanation: Can build: w → wo → wor → worl → world
```

## Hint:
Build Trie, then DFS to find longest buildable word!

```typescript
function longestWord(words: string[]): string {
  // Build Trie
  let root = new TrieNode();
  for (let word of words) {
    let node = root;
    for (let char of word) {
      if (!node.children.has(char)) {
        node.children.set(char, new TrieNode());
      }
      node = node.children.get(char)!;
    }
    node.word = word;
  }

  let longest = "";

  function dfs(node: TrieNode) {
    if (node.word && node.word.length > longest.length) {
      longest = node.word;
    } else if (node.word && node.word.length === longest.length && node.word < longest) {
      longest = node.word;  // Lexicographically smaller
    }

    // Only explore children that are also end-of-word
    for (let child of node.children.values()) {
      if (child.word) {  // Can be built!
        dfs(child);
      }
    }
  }

  dfs(root);
  return longest;
}
```
```

**Right Panel (Problem)**: `trie-3` (Longest Word in Dictionary)

**Next**: Item 6

---

### **ITEM 6: Palindrome Pairs**
**Type**: Lesson + Problem
**Duration**: 25-30 minutes

**Left Panel (Lesson)**:
```
# Advanced: Palindrome Pairs

**Problem**: Find all pairs (i, j) where words[i] + words[j] is a palindrome.

```
Input: words = ["abcd","dcba","lls","s","sssll"]
Output: [[0,1],[1,0],[3,2],[2,4]]

Explanation:
"abcd" + "dcba" = "abcddcba" (palindrome)
"dcba" + "abcd" = "dcbaabcd" (palindrome)
"s" + "lls" = "slls" (palindrome)
"lls" + "sssll" = "llsssssll" (palindrome)
```

## Strategy:

For each word, find:
1. Words that are reverse of it
2. Words where word + reverse(suffix) is palindrome
3. Words where reverse(prefix) + word is palindrome

Use Trie or HashMap for efficient lookup!

This is a **HARD** problem combining multiple techniques!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `trie-4` (Palindrome Pairs)

**Next**: Item 7

---

### **ITEM 7: Group Anagrams**
**Type**: Lesson + Problem
**Duration**: 12-15 minutes

**Left Panel (Lesson)**:
```
# String Patterns: Anagrams

**Problem**: Group strings that are anagrams.

```
Input: strs = ["eat","tea","tan","ate","nat","bat"]
Output: [["bat"],["nat","tan"],["ate","eat","tea"]]
```

## Approach 1: Sort as Key

```typescript
function groupAnagrams(strs: string[]): string[][] {
  let map = new Map<string, string[]>();

  for (let str of strs) {
    let key = str.split('').sort().join('');
    if (!map.has(key)) map.set(key, []);
    map.get(key)!.push(str);
  }

  return Array.from(map.values());
}
```

Time: O(n * m log m) where m = max word length

## Approach 2: Character Count as Key

```typescript
function groupAnagrams(strs: string[]): string[][] {
  let map = new Map<string, string[]>();

  for (let str of strs) {
    let count = new Array(26).fill(0);
    for (let char of str) {
      count[char.charCodeAt(0) - 97]++;
    }
    let key = count.join('#');

    if (!map.has(key)) map.set(key, []);
    map.get(key)!.push(str);
  }

  return Array.from(map.values());
}
```

Time: O(n * m) - better!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `string-1` (Group Anagrams)

**Next**: Item 8

---

### **ITEM 8: Longest Common Prefix**
**Type**: Problem Only
**Duration**: 10-12 minutes

**Left Panel (Problem Context)**:
```
# Practice: Prefix Finding

**Problem**: Find longest common prefix among array of strings.

```
Input: strs = ["flower","flow","flight"]
Output: "fl"

Input: strs = ["dog","racecar","car"]
Output: "" (no common prefix)
```

## Approach 1: Horizontal Scanning

```typescript
function longestCommonPrefix(strs: string[]): string {
  if (!strs.length) return "";

  let prefix = strs[0];

  for (let i = 1; i < strs.length; i++) {
    while (!strs[i].startsWith(prefix)) {
      prefix = prefix.slice(0, -1);
      if (!prefix) return "";
    }
  }

  return prefix;
}
```

## Approach 2: Vertical Scanning (compare character by character)

## Approach 3: Trie (build Trie, find common path)

All have O(total characters) complexity!
```

**Right Panel (Problem)**: `string-2` (Longest Common Prefix)

**Next**: Item 9

---

### **ITEM 9: Valid Anagram**
**Type**: Problem Only
**Duration**: 8-10 minutes

**Left Panel (Problem Context)**:
```
# Practice: Character Counting

**Problem**: Check if two strings are anagrams.

```
Input: s = "anagram", t = "nagaram"
Output: true

Input: s = "rat", t = "car"
Output: false
```

## Approaches:

**1. Sort and compare**: O(n log n)
```typescript
function isAnagram(s: string, t: string): boolean {
  if (s.length !== t.length) return false;
  return s.split('').sort().join('') === t.split('').sort().join('');
}
```

**2. Character count**: O(n)
```typescript
function isAnagram(s: string, t: string): boolean {
  if (s.length !== t.length) return false;

  let count = new Map<string, number>();

  for (let char of s) {
    count.set(char, (count.get(char) || 0) + 1);
  }

  for (let char of t) {
    if (!count.has(char)) return false;
    count.set(char, count.get(char)! - 1);
    if (count.get(char)! < 0) return false;
  }

  return true;
}
```
```

**Right Panel (Problem)**: `string-3` (Valid Anagram)

**Next**: Item 10

---

### **ITEM 10: Longest Palindromic Substring**
**Type**: Lesson + Problem
**Duration**: 15-18 minutes

**Left Panel (Lesson)**:
```
# Finding Palindromes: Expand Around Center

**Problem**: Find longest palindromic substring.

```
Input: s = "babad"
Output: "bab" or "aba"

Input: s = "cbbd"
Output: "bb"
```

## Approach: Expand Around Center

For each possible center, expand outward:

```typescript
function longestPalindrome(s: string): string {
  if (!s || s.length < 1) return "";

  let start = 0, maxLen = 0;

  function expandAroundCenter(left: number, right: number): number {
    while (left >= 0 && right < s.length && s[left] === s[right]) {
      left--;
      right++;
    }
    return right - left - 1;  // Length of palindrome
  }

  for (let i = 0; i < s.length; i++) {
    // Odd length palindrome (center is single character)
    let len1 = expandAroundCenter(i, i);

    // Even length palindrome (center is between two characters)
    let len2 = expandAroundCenter(i, i + 1);

    let len = Math.max(len1, len2);

    if (len > maxLen) {
      maxLen = len;
      start = i - Math.floor((len - 1) / 2);
    }
  }

  return s.substring(start, start + maxLen);
}
```

Time: O(n²)
Space: O(1)

**Advanced**: Manacher's Algorithm achieves O(n) but is complex!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `string-4` (Longest Palindromic Substring)

**Next**: Module complete!

---

## Module Completion

After Item 10, show:

```
# 🎉 Module 12 Complete!

You've mastered:
✅ Trie data structure and operations
✅ Trie with wildcard search
✅ Combining Trie with other algorithms
✅ Advanced string patterns (anagrams, palindromes)
✅ Prefix matching and searching
✅ String manipulation techniques

## Key Patterns Learned:

1. **Trie Operations**: Insert, search, prefix matching
2. **Trie + Backtracking**: Word search optimization
3. **Anagram Detection**: Sort vs character count
4. **Palindrome Finding**: Expand around center
5. **Hash Map for Grouping**: Group anagrams, count patterns

## When to Use Tries:
- Prefix matching / auto-complete
- Dictionary lookups with prefix queries
- Word games and puzzles
- IP routing
- Spell checking

## Time Complexities:
- Trie insert/search: O(m) where m = word length
- Anagram detection: O(n) with counting
- Palindrome expand: O(n²)

## Problems Solved: 10

Next: **Module 13: Advanced Topics & Mastery** →
```

---

## Problems Required

This module requires these problems in `/lib/content/problems/tries.ts` and `/lib/content/problems/strings.ts`:

**Tries**:
1. `trie-1`: Implement Trie (Prefix Tree) (MEDIUM) ⭐⭐⭐ CRITICAL
2. `trie-2`: Design Add and Search Words Data Structure (MEDIUM) ⭐⭐⭐ CRITICAL
3. `trie-3`: Longest Word in Dictionary (MEDIUM)
4. `trie-4`: Palindrome Pairs (HARD)

**Strings**:
1. `string-1`: Group Anagrams (MEDIUM) ⭐⭐⭐ CRITICAL
2. `string-2`: Longest Common Prefix (EASY)
3. `string-3`: Valid Anagram (EASY)
4. `string-4`: Longest Palindromic Substring (MEDIUM) ⭐⭐⭐ CRITICAL

---

This specification covers Trie and string patterns seen in 8-12% of FAANG interviews.
