# Module 3: Bit Manipulation & Math

## Overview
This module teaches bit manipulation techniques and mathematical problem-solving. Students learn bitwise operations, common bit tricks, mathematical patterns, and number theory basics for interviews.

**Total Items**: 12
**Estimated Time**: 3-4 hours
**Prerequisites**: Module 1 (Arrays), Module 2 (Hash Maps)

---

## Learning Philosophy

Following the IdleCampus adaptive learning approach:
1. **Present Problem First**: User encounters the problem before seeing bit manipulation solution
2. **Detect Approach**: Analyze if user writes brute force or optimized bit solution
3. **Adaptive Branching**: Different learning paths based on user's solution
4. **Guide, Don't Give Away**: Help user discover bit manipulation patterns
5. **Brute Force → Optimization**: From O(n) to O(1) with bit tricks

---

## Module Structure

### Part 1: Bit Manipulation Fundamentals (Items 1-7)
- Binary representation
- Bitwise operators (&, |, ^, ~, <<, >>)
- Common bit tricks
- Single number problems
- Counting bits

### Part 2: Mathematical Patterns (Items 8-12)
- Prime numbers
- GCD and LCM
- Power and modulo
- Factorial and combinations
- Math-based problems

---

## Detailed Item Specifications

### **ITEM 1: Introduction to Bit Manipulation**
**Type**: Lesson Only
**Duration**: 5 minutes

**Content**:
```
# Bit Manipulation: Working with Binary

Bit manipulation uses bitwise operators to perform operations at the bit level.

## Binary Representation:

```
Decimal → Binary
5  →  101
10 →  1010
15 →  1111
```

## Bitwise Operators:

**AND (&)**: 1 if both bits are 1
```
  101  (5)
& 011  (3)
-----
  001  (1)
```

**OR (|)**: 1 if either bit is 1
```
  101  (5)
| 011  (3)
-----
  111  (7)
```

**XOR (^)**: 1 if bits are different
```
  101  (5)
^ 011  (3)
-----
  110  (6)
```

**NOT (~)**: Flip all bits
```
~101 → 010  (in limited bits)
```

**Left Shift (<<)**: Multiply by 2
```
5 << 1 = 10   (101 → 1010)
5 << 2 = 20   (101 → 10100)
```

**Right Shift (>>)**: Divide by 2
```
10 >> 1 = 5   (1010 → 101)
10 >> 2 = 2   (1010 → 10)
```

## Common Bit Tricks:

**Check if i-th bit is set**:
```typescript
(n & (1 << i)) !== 0
```

**Set i-th bit**:
```typescript
n | (1 << i)
```

**Clear i-th bit**:
```typescript
n & ~(1 << i)
```

**Toggle i-th bit**:
```typescript
n ^ (1 << i)
```

**Check if power of 2**:
```typescript
n > 0 && (n & (n - 1)) === 0
```

**Count set bits** (Brian Kernighan's algorithm):
```typescript
let count = 0;
while (n > 0) {
  n &= (n - 1);  // Remove rightmost set bit
  count++;
}
```

## Why Bit Manipulation?

✅ **Fast**: Bitwise operations are very fast
✅ **Space-efficient**: Can pack multiple values in one number
✅ **Interview favorite**: 5-8% of problems use bit manipulation

Let's master bit manipulation!
```

**Next**: Item 2

---

### **ITEM 2: Single Number**
**Type**: Lesson + Problem
**Duration**: 10-12 minutes

**Left Panel (Lesson)**:
```
# XOR Magic: Single Number

**Problem**: Every element appears twice except one. Find it.

```
Input: [2, 2, 1]
Output: 1

Input: [4, 1, 2, 1, 2]
Output: 4
```

## Key Insight: XOR Properties

1. **a ^ a = 0** (XOR with itself is 0)
2. **a ^ 0 = a** (XOR with 0 is itself)
3. **Commutative**: a ^ b ^ a = a ^ a ^ b = 0 ^ b = b

## Solution:

```typescript
function singleNumber(nums: number[]): number {
  let result = 0;

  for (let num of nums) {
    result ^= num;
  }

  return result;
}
```

Time: O(n)
Space: O(1) - no extra space!

## Why It Works:

```
[4, 1, 2, 1, 2]
= 4 ^ 1 ^ 2 ^ 1 ^ 2
= 4 ^ (1 ^ 1) ^ (2 ^ 2)
= 4 ^ 0 ^ 0
= 4
```

This is a classic XOR trick!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `bit-1` (Single Number)

**Next**: Item 3

---

### **ITEM 3: Number of 1 Bits**
**Type**: Lesson + Problem
**Duration**: 10-12 minutes

**Left Panel (Lesson)**:
```
# Counting Set Bits (Hamming Weight)

**Problem**: Count the number of '1' bits.

```
Input: n = 11 (binary: 1011)
Output: 3
```

## Approach 1: Check Each Bit

```typescript
function hammingWeight(n: number): number {
  let count = 0;

  for (let i = 0; i < 32; i++) {
    if (n & (1 << i)) {
      count++;
    }
  }

  return count;
}
```

Time: O(32) = O(1)

## Approach 2: Brian Kernighan's Algorithm

```typescript
function hammingWeight(n: number): number {
  let count = 0;

  while (n > 0) {
    n &= (n - 1);  // Remove rightmost 1
    count++;
  }

  return count;
}
```

Time: O(number of 1 bits) - faster!

## Why `n &= (n - 1)` Removes Rightmost 1:

```
n     = 1011000
n-1   = 1010111
n&(n-1) = 1010000  (rightmost 1 removed!)
```

Try solving this problem on the right →
```

**Right Panel (Problem)**: `bit-2` (Number of 1 Bits)

**Next**: Item 4

---

### **ITEM 4: Counting Bits**
**Type**: Problem Only
**Duration**: 12-15 minutes

**Left Panel (Problem Context)**:
```
# Practice: DP + Bit Manipulation

**Problem**: Count bits for all numbers from 0 to n.

```
Input: n = 5
Output: [0, 1, 1, 2, 1, 2]

Explanation:
0 → 0     → 0 ones
1 → 1     → 1 one
2 → 10    → 1 one
3 → 11    → 2 ones
4 → 100   → 1 one
5 → 101   → 2 ones
```

## Hint 1: DP Pattern

```
bits[i] = bits[i >> 1] + (i & 1)
```

i >> 1 removes last bit, i & 1 checks if last bit is 1.

## Hint 2: Alternative DP

```
bits[i] = bits[i & (i-1)] + 1
```

i & (i-1) removes rightmost 1, then add 1 for it!

Try implementing both approaches!
```

**Right Panel (Problem)**: `bit-3` (Counting Bits)

**Next**: Item 5

---

### **ITEM 5: Reverse Bits**
**Type**: Problem Only
**Duration**: 10-12 minutes

**Left Panel (Problem Context)**:
```
# Practice: Bit Reversal

**Problem**: Reverse bits of a 32-bit unsigned integer.

```
Input: n = 00000010100101000001111010011100
Output:    00111001011110000010100101000000
```

## Approach:

Build result bit by bit:

```typescript
function reverseBits(n: number): number {
  let result = 0;

  for (let i = 0; i < 32; i++) {
    // Get rightmost bit of n
    let bit = n & 1;

    // Shift result left and add bit
    result = (result << 1) | bit;

    // Shift n right
    n >>= 1;
  }

  return result >>> 0;  // Convert to unsigned
}
```

Each iteration:
1. Extract rightmost bit from n
2. Add it to result (at left)
3. Shift n right
```

**Right Panel (Problem)**: `bit-4` (Reverse Bits)

**Next**: Item 6

---

### **ITEM 6: Missing Number**
**Type**: Lesson + Problem
**Duration**: 12-15 minutes

**Left Panel (Lesson)**:
```
# XOR to Find Missing

**Problem**: Array contains n distinct numbers from 0 to n. Find the missing number.

```
Input: [3, 0, 1]
Output: 2

Input: [0, 1]
Output: 2
```

## Approach 1: Math (Sum)

```typescript
function missingNumber(nums: number[]): number {
  let n = nums.length;
  let expectedSum = (n * (n + 1)) / 2;
  let actualSum = nums.reduce((a, b) => a + b, 0);
  return expectedSum - actualSum;
}
```

Time: O(n), Space: O(1)

## Approach 2: XOR

```typescript
function missingNumber(nums: number[]): number {
  let xor = nums.length;  // Start with n

  for (let i = 0; i < nums.length; i++) {
    xor ^= i ^ nums[i];
  }

  return xor;
}
```

Why? XOR all numbers 0 to n with all numbers in array.
Duplicates cancel out, only missing remains!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `bit-5` (Missing Number)

**Next**: Item 7

---

### **ITEM 7: Sum of Two Integers**
**Type**: Problem Only
**Duration**: 15-18 minutes

**Left Panel (Problem Context)**:
```
# Challenge: Addition Without + Operator

**Problem**: Add two integers without using + or -.

```
Input: a = 1, b = 2
Output: 3
```

## Hint: Bit Manipulation

Addition = XOR + carry

```
  5 (101)
+ 3 (011)
-------

XOR gives sum without carry:
  101
^ 011
-----
  110  (but this is 6, not 8!)

AND << 1 gives carry:
  101
& 011
-----
  001  << 1 = 010

Repeat until carry = 0:
  110
^ 010
-----
  100

Carry:
  110
& 010
-----
  010 << 1 = 100

Continue until carry = 0...
```

```typescript
function getSum(a: number, b: number): number {
  while (b !== 0) {
    let carry = (a & b) << 1;  // Carry
    a = a ^ b;                 // Sum without carry
    b = carry;                 // Next carry
  }
  return a;
}
```
```

**Right Panel (Problem)**: `bit-6` (Sum of Two Integers)

**Next**: Item 8

---

### **ITEM 8: Happy Number**
**Type**: Lesson + Problem
**Duration**: 12-15 minutes

**Left Panel (Lesson)**:
```
# Math Pattern: Cycle Detection

**Problem**: A happy number eventually reaches 1 when replaced by sum of squares of digits. Determine if happy.

```
Input: n = 19
Output: true

Explanation:
19 → 1² + 9² = 82
82 → 8² + 2² = 68
68 → 6² + 8² = 100
100 → 1² + 0² + 0² = 1  (happy!)

Input: n = 2
Output: false (cycles forever)
```

## Approach: Detect Cycle

```typescript
function isHappy(n: number): boolean {
  let seen = new Set<number>();

  while (n !== 1 && !seen.has(n)) {
    seen.add(n);
    n = getSumOfSquares(n);
  }

  return n === 1;
}

function getSumOfSquares(n: number): number {
  let sum = 0;

  while (n > 0) {
    let digit = n % 10;
    sum += digit * digit;
    n = Math.floor(n / 10);
  }

  return sum;
}
```

Time: O(log n) per iteration
Space: O(log n) for set

Try solving this problem on the right →
```

**Right Panel (Problem)**: `math-1` (Happy Number)

**Next**: Item 9

---

### **ITEM 9: Pow(x, n)**
**Type**: Lesson + Problem
**Duration**: 15-18 minutes

**Left Panel (Lesson)**:
```
# Fast Exponentiation

**Problem**: Implement pow(x, n).

## Naive: O(n)
```typescript
let result = 1;
for (let i = 0; i < n; i++) {
  result *= x;
}
```

## Optimized: O(log n) - Fast Exponentiation

Key insight: x^n = (x²)^(n/2)

```typescript
function myPow(x: number, n: number): number {
  if (n === 0) return 1;
  if (n < 0) {
    x = 1 / x;
    n = -n;
  }

  let result = 1;

  while (n > 0) {
    if (n % 2 === 1) {
      result *= x;
    }
    x *= x;      // Square x
    n = Math.floor(n / 2);  // Halve n
  }

  return result;
}
```

## Example: 2^10

```
2^10 = (2²)^5 = 4^5
4^5 = 4 * 4^4 = 4 * (4²)^2 = 4 * 16^2
16^2 = (16²)^1 = 256^1 = 256
Result = 4 * 256 = 1024
```

Only 4 multiplications instead of 10!

Try solving this problem on the right →
```

**Right Panel (Problem)**: `math-2` (Pow(x, n))

**Next**: Item 10

---

### **ITEM 10: Sqrt(x) - Newton's Method**
**Type**: Problem Only
**Duration**: 12-15 minutes

**Left Panel (Problem Context)**:
```
# Practice: Mathematical Approximation

We solved this with binary search in Module 7. Now try Newton's Method!

**Problem**: Implement sqrt(x) using Newton's Method.

## Newton's Method:

For finding sqrt(S):
```
x_{n+1} = (x_n + S/x_n) / 2
```

Start with x_0 = S, iterate until convergence.

```typescript
function mySqrt(x: number): number {
  if (x === 0) return 0;

  let guess = x;

  while (true) {
    let nextGuess = (guess + x / guess) / 2;

    if (Math.abs(guess - nextGuess) < 1) {
      return Math.floor(nextGuess);
    }

    guess = nextGuess;
  }
}
```

This converges very fast (quadratic convergence)!

Compare this to binary search approach from Module 7.
```

**Right Panel (Problem)**: Reference to Module 5's Sqrt(x)

**Next**: Item 11

---

### **ITEM 11: Factorial Trailing Zeroes**
**Type**: Lesson + Problem
**Duration**: 12-15 minutes

**Left Panel (Lesson)**:
```
# Math Insight: Counting Factors

**Problem**: Count trailing zeroes in n!

```
Input: n = 5
Output: 1
Explanation: 5! = 120, one trailing zero

Input: n = 10
Output: 2
Explanation: 10! = 3628800, two trailing zeros
```

## Key Insight:

Trailing zeros come from factors of 10 = 2 × 5.

In n!, there are always more 2s than 5s, so count 5s!

## Count 5s:

```typescript
function trailingZeroes(n: number): number {
  let count = 0;

  while (n >= 5) {
    n = Math.floor(n / 5);
    count += n;
  }

  return count;
}
```

## Why?

n/5 counts multiples of 5
n/25 counts multiples of 25 (extra 5)
n/125 counts multiples of 125 (extra 5)
...

Example: n = 25
- 25/5 = 5 (5, 10, 15, 20, 25)
- 25/25 = 1 (25 has two 5s)
Total = 6 trailing zeros

Try solving this problem on the right →
```

**Right Panel (Problem)**: `math-3` (Factorial Trailing Zeroes)

**Next**: Item 12

---

### **ITEM 12: Excel Sheet Column Number**
**Type**: Problem Only
**Duration**: 10-12 minutes

**Left Panel (Problem Context)**:
```
# Practice: Base-26 Conversion

**Problem**: Convert Excel column title to number.

```
A → 1
B → 2
...
Z → 26
AA → 27
AB → 28
```

## Approach: Base-26 System

```typescript
function titleToNumber(columnTitle: string): number {
  let result = 0;

  for (let char of columnTitle) {
    let digit = char.charCodeAt(0) - 'A'.charCodeAt(0) + 1;
    result = result * 26 + digit;
  }

  return result;
}
```

## Example: "AB"
```
A → 1
result = 0 * 26 + 1 = 1

B → 2
result = 1 * 26 + 2 = 28
```

Similar to converting binary/hexadecimal to decimal!

**Reverse problem**: Number to column title is slightly trickier (Module 13).
```

**Right Panel (Problem)**: `math-4` (Excel Sheet Column Number)

**Next**: Module complete!

---

## Module Completion

After Item 12, show:

```
# 🎉 Module 3 Complete!

You've mastered:
✅ Bitwise operators (&, |, ^, ~, <<, >>)
✅ Common bit manipulation tricks
✅ XOR patterns (single number, missing number)
✅ Bit counting and reversal
✅ Mathematical patterns and algorithms
✅ Fast exponentiation
✅ Number theory basics

## Key Patterns Learned:

1. **XOR**: Finding unique/missing elements
2. **Bit Counting**: Brian Kernighan's algorithm
3. **Power of 2**: n & (n-1) === 0
4. **Fast Exponentiation**: O(log n) instead of O(n)
5. **Factor Counting**: Trailing zeros, GCD patterns

## Common Bit Tricks:
- Check bit: (n & (1 << i)) !== 0
- Set bit: n | (1 << i)
- Clear bit: n & ~(1 << i)
- Toggle bit: n ^ (1 << i)
- Remove rightmost 1: n & (n-1)

## Time Complexities:
- Most bit operations: O(1) or O(# bits)
- Fast exponentiation: O(log n)
- Bit counting: O(# of 1 bits)

## Problems Solved: 12

Next: **Module 4: Array + Hash Map Combinations** →
```

---

## Problems Required

This module requires these problems in `/lib/content/problems/bitManipulation.ts` and `/lib/content/problems/math.ts`:

**Bit Manipulation**:
1. `bit-1`: Single Number (EASY)
2. `bit-2`: Number of 1 Bits (EASY)
3. `bit-3`: Counting Bits (EASY)
4. `bit-4`: Reverse Bits (EASY)
5. `bit-5`: Missing Number (EASY)
6. `bit-6`: Sum of Two Integers (MEDIUM)

**Math**:
1. `math-1`: Happy Number (EASY)
2. `math-2`: Pow(x, n) (MEDIUM)
3. `math-3`: Factorial Trailing Zeroes (MEDIUM)
4. `math-4`: Excel Sheet Column Number (EASY)

---

This specification covers bit manipulation and math patterns seen in 5-8% of FAANG interviews.
