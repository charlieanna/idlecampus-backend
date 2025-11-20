# AUTO-GENERATED from coding_interview_course.rb
puts "Creating Microlessons for Arrays Hashing..."

module_var = CourseModule.find_by(slug: 'arrays-hashing')

# === MICROLESSON 1: Practice Question ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 2: Lesson 2 ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 2',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Common Array Patterns

    ## Pattern 1: Frequency Counter

    Use a hash map to count occurrences:

    ```python
    def is_anagram(s1, s2):
        if len(s1) != len(s2):
            return False

        count = {}
        for char in s1:
            count[char] = count.get(char, 0) + 1

        for char in s2:
            if char not in count:
                return False
            count[char] -= 1
            if count[char] < 0:
                return False

        return True
    ```

    ## Pattern 2: Multiple Pointers

    Use multiple pointers to traverse array:

    ```python
    def three_sum(nums):
        nums.sort()
        result = []

        for i in range(len(nums) - 2):
            if i > 0 and nums[i] == nums[i-1]:
                continue

            left, right = i + 1, len(nums) - 1
            while left < right:
                current_sum = nums[i] + nums[left] + nums[right]
                if current_sum == 0:
                    result.append([nums[i], nums[left], nums[right]])
                    while left < right and nums[left] == nums[left+1]:
                        left += 1
                    while left < right and nums[right] == nums[right-1]:
                        right -= 1
                    left += 1
                    right -= 1
                elif current_sum < 0:
                    left += 1
                else:
                    right -= 1

        return result
    ```

    ## Pattern 3: Prefix Sum

    Precompute cumulative sums for range queries:

    ```python
    def subarray_sum(nums, k):
        count = 0
        prefix_sum = 0
        sum_count = {0: 1}

        for num in nums:
            prefix_sum += num
            if prefix_sum - k in sum_count:
                count += sum_count[prefix_sum - k]
            sum_count[prefix_sum] = sum_count.get(prefix_sum, 0) + 1

        return count
    ```

    ## Pattern 4: Kadane's Algorithm

    Find maximum subarray sum:

    ```python
    def max_subarray(nums):
        max_sum = current_sum = nums[0]

        for num in nums[1:]:
            current_sum = max(num, current_sum + num)
            max_sum = max(max_sum, current_sum)

        return max_sum
    ```

    ## Key Takeaways

    1. **Recognize the pattern**: Most problems follow common templates
    2. **Choose right data structure**: Array vs HashMap vs Set
    3. **Consider sorting**: Often simplifies the problem
    4. **Handle edge cases**: Duplicates, empty inputs, negative numbers
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 3: Lesson 3 ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 3',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Binary Tree Fundamentals

    ## Introduction
    Trees are hierarchical data structures essential for many interview problems. Binary trees, where each node has at most two children, are the most common.

    ## Tree Terminology

    - **Root**: The top node of the tree
    - **Leaf**: A node with no children
    - **Height**: Length of the longest path from root to leaf
    - **Depth**: Length of path from root to a specific node
    - **Level**: All nodes at the same depth

    ## Tree Traversals

    ### 1. Depth-First Search (DFS)

    #### Inorder (Left, Root, Right)
    ```python
    def inorder(root):
        if not root:
            return []
        return inorder(root.left) + [root.val] + inorder(root.right)
    ```

    #### Preorder (Root, Left, Right)
    ```python
    def preorder(root):
        if not root:
            return []
        return [root.val] + preorder(root.left) + preorder(root.right)
    ```

    #### Postorder (Left, Right, Root)
    ```python
    def postorder(root):
        if not root:
            return []
        return postorder(root.left) + postorder(root.right) + [root.val]
    ```

    ### 2. Breadth-First Search (BFS)

    Level-order traversal using queue:

    ```python
    from collections import deque

    def level_order(root):
        if not root:
            return []

        result = []
        queue = deque([root])

        while queue:
            level_size = len(queue)
            current_level = []

            for _ in range(level_size):
                node = queue.popleft()
                current_level.append(node.val)

                if node.left:
                    queue.append(node.left)
                if node.right:
                    queue.append(node.right)

            result.append(current_level)

        return result
    ```

    ## Binary Search Trees (BST)

    ### Properties
    - Left subtree contains values less than root
    - Right subtree contains values greater than root
    - Both subtrees are also BSTs

    ### BST Operations

    #### Search - O(log n) average, O(n) worst
    ```python
    def search_bst(root, val):
        if not root:
            return None
        if root.val == val:
            return root
        elif val < root.val:
            return search_bst(root.left, val)
        else:
            return search_bst(root.right, val)
    ```

    #### Insert - O(log n) average, O(n) worst
    ```python
    def insert_bst(root, val):
        if not root:
            return TreeNode(val)

        if val < root.val:
            root.left = insert_bst(root.left, val)
        else:
            root.right = insert_bst(root.right, val)

        return root
    ```

    ## Common Patterns

    ### 1. Recursive Approach
    - Define base case (usually null node)
    - Process current node
    - Recursively process children

    ### 2. Iterative with Stack/Queue
    - Use stack for DFS
    - Use queue for BFS

    ### 3. Path Problems
    - Track path as you traverse
    - Use backtracking for all paths

    ## Key Insights

    1. **Choose traversal wisely**: Inorder for BST gives sorted order
    2. **Consider both recursive and iterative**: Iterative saves call stack
    3. **Track additional info**: Height, parent pointers, etc.
    4. **Handle edge cases**: Empty tree, single node, skewed trees
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 4: Lesson 4 ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 4',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Graph Algorithms

    ## Graph Representation

    ### 1. Adjacency List
    ```python
    graph = {
        'A': ['B', 'C'],
        'B': ['A', 'D', 'E'],
        'C': ['A', 'F'],
        'D': ['B'],
        'E': ['B', 'F'],
        'F': ['C', 'E']
    }
    ```

    ### 2. Adjacency Matrix
    ```python
    # For nodes 0, 1, 2, 3
    graph = [
        [0, 1, 1, 0],
        [1, 0, 1, 1],
        [1, 1, 0, 1],
        [0, 1, 1, 0]
    ]
    ```

    ## Graph Traversals

    ### Depth-First Search (DFS)

    #### Recursive Implementation
    ```python
    def dfs_recursive(graph, node, visited=None):
        if visited is None:
            visited = set()

        visited.add(node)
        print(node)

        for neighbor in graph[node]:
            if neighbor not in visited:
                dfs_recursive(graph, neighbor, visited)

        return visited
    ```

    #### Iterative Implementation
    ```python
    def dfs_iterative(graph, start):
        visited = set()
        stack = [start]

        while stack:
            node = stack.pop()
            if node not in visited:
                visited.add(node)
                print(node)

                for neighbor in graph[node]:
                    if neighbor not in visited:
                        stack.append(neighbor)

        return visited
    ```

    ### Breadth-First Search (BFS)

    ```python
    from collections import deque

    def bfs(graph, start):
        visited = set([start])
        queue = deque([start])

        while queue:
            node = queue.popleft()
            print(node)

            for neighbor in graph[node]:
                if neighbor not in visited:
                    visited.add(neighbor)
                    queue.append(neighbor)

        return visited
    ```

    ## Common Graph Problems

    ### 1. Connected Components
    ```python
    def count_components(n, edges):
        graph = {i: [] for i in range(n)}
        for a, b in edges:
            graph[a].append(b)
            graph[b].append(a)

        visited = set()
        components = 0

        def dfs(node):
            visited.add(node)
            for neighbor in graph[node]:
                if neighbor not in visited:
                    dfs(neighbor)

        for i in range(n):
            if i not in visited:
                dfs(i)
                components += 1

        return components
    ```

    ### 2. Cycle Detection

    #### Undirected Graph
    ```python
    def has_cycle_undirected(graph):
        visited = set()

        def dfs(node, parent):
            visited.add(node)

            for neighbor in graph[node]:
                if neighbor not in visited:
                    if dfs(neighbor, node):
                        return True
                elif parent != neighbor:
                    return True

            return False

        for node in graph:
            if node not in visited:
                if dfs(node, -1):
                    return True

        return False
    ```

    #### Directed Graph (Using Colors)
    ```python
    def has_cycle_directed(graph):
        WHITE, GRAY, BLACK = 0, 1, 2
        colors = {node: WHITE for node in graph}

        def dfs(node):
            colors[node] = GRAY

            for neighbor in graph[node]:
                if colors[neighbor] == GRAY:
                    return True
                if colors[neighbor] == WHITE:
                    if dfs(neighbor):
                        return True

            colors[node] = BLACK
            return False

        for node in graph:
            if colors[node] == WHITE:
                if dfs(node):
                    return True

        return False
    ```

    ### 3. Topological Sort
    ```python
    def topological_sort(graph):
        in_degree = {node: 0 for node in graph}

        for node in graph:
            for neighbor in graph[node]:
                in_degree[neighbor] += 1

        queue = deque([node for node in in_degree if in_degree[node] == 0])
        result = []

        while queue:
            node = queue.popleft()
            result.append(node)

            for neighbor in graph[node]:
                in_degree[neighbor] -= 1
                if in_degree[neighbor] == 0:
                    queue.append(neighbor)

        return result if len(result) == len(graph) else []
    ```

    ## Key Insights

    1. **Choose right representation**: Adjacency list for sparse graphs
    2. **Track visited nodes**: Prevent infinite loops
    3. **BFS for shortest path**: In unweighted graphs
    4. **DFS for exploration**: Path existence, cycles, components
    5. **Consider directed vs undirected**: Different algorithms apply
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 5: Lesson 5 ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 5',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Introduction to Dynamic Programming

    ## What is Dynamic Programming?

    Dynamic Programming (DP) is an optimization technique that solves complex problems by breaking them down into simpler subproblems. It's based on the principle of **optimal substructure** and **overlapping subproblems**.

    ## Key Concepts

    ### 1. Overlapping Subproblems
    The problem can be broken down into subproblems that are reused multiple times.

    ### 2. Optimal Substructure
    The optimal solution contains optimal solutions to subproblems.

    ### 3. Memoization vs Tabulation

    #### Top-Down (Memoization)
    ```python
    def fib_memo(n, memo={}):
        if n in memo:
            return memo[n]
        if n <= 1:
            return n

        memo[n] = fib_memo(n-1, memo) + fib_memo(n-2, memo)
        return memo[n]
    ```

    #### Bottom-Up (Tabulation)
    ```python
    def fib_tab(n):
        if n <= 1:
            return n

        dp = [0] * (n + 1)
        dp[1] = 1

        for i in range(2, n + 1):
            dp[i] = dp[i-1] + dp[i-2]

        return dp[n]
    ```

    ## Classic DP Problems

    ### 1. Climbing Stairs
    ```python
    def climb_stairs(n):
        if n <= 2:
            return n

        # dp[i] = ways to reach step i
        prev2, prev1 = 1, 2

        for i in range(3, n + 1):
            current = prev1 + prev2
            prev2, prev1 = prev1, current

        return prev1
    ```

    ### 2. House Robber
    ```python
    def rob(nums):
        if not nums:
            return 0
        if len(nums) == 1:
            return nums[0]

        # dp[i] = max money robbed up to house i
        prev2 = nums[0]
        prev1 = max(nums[0], nums[1])

        for i in range(2, len(nums)):
            current = max(prev1, prev2 + nums[i])
            prev2, prev1 = prev1, current

        return prev1
    ```

    ### 3. Coin Change
    ```python
    def coin_change(coins, amount):
        # dp[i] = min coins needed for amount i
        dp = [float('inf')] * (amount + 1)
        dp[0] = 0

        for i in range(1, amount + 1):
            for coin in coins:
                if coin <= i:
                    dp[i] = min(dp[i], dp[i - coin] + 1)

        return dp[amount] if dp[amount] != float('inf') else -1
    ```

    ## DP Patterns

    ### Pattern 1: Linear DP
    - Problems on arrays/sequences
    - State: dp[i] represents solution for first i elements
    - Examples: Maximum subarray, House Robber

    ### Pattern 2: Grid DP
    - Problems on 2D grids
    - State: dp[i][j] represents solution at position (i, j)
    - Examples: Unique Paths, Minimum Path Sum

    ### Pattern 3: Interval DP
    - Problems on intervals/subarrays
    - State: dp[i][j] represents solution for interval [i, j]
    - Examples: Longest Palindromic Substring, Burst Balloons

    ### Pattern 4: Knapsack DP
    - Selection problems with constraints
    - State: dp[i][w] represents solution using first i items with weight w
    - Examples: 0/1 Knapsack, Subset Sum

    ## Steps to Solve DP Problems

    1. **Identify if it's a DP problem**
       - Can be broken into subproblems
       - Subproblems overlap
       - Has optimal substructure

    2. **Define the state**
       - What does dp[i] or dp[i][j] represent?

    3. **Define the recurrence relation**
       - How to compute dp[i] from previous states?

    4. **Identify base cases**
       - What are the smallest subproblems?

    5. **Determine iteration order**
       - In what order to fill the DP table?

    6. **Optimize space if possible**
       - Can we use rolling array?

    ## Key Insights

    1. **Start with recursion**: Write recursive solution first
    2. **Add memoization**: Cache results to avoid recomputation
    3. **Convert to tabulation**: Build bottom-up for better space
    4. **Optimize space**: Use only necessary previous states
    5. **Practice recognition**: Learn to identify DP patterns quickly
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 6: Lesson 6 ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 6',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Linked List Fundamentals

    ## Introduction
    Linked lists are linear data structures where elements are stored in nodes, with each node containing data and a reference to the next node.

    ## Types of Linked Lists

    ### 1. Singly Linked List
    ```python
    class ListNode:
        def __init__(self, val=0, next=None):
            self.val = val
            self.next = next
    ```

    ### 2. Doubly Linked List
    ```python
    class DoublyListNode:
        def __init__(self, val=0, prev=None, next=None):
            self.val = val
            self.prev = prev
            self.next = next
    ```

    ## Common Operations

    ### Traversal
    ```python
    def traverse(head):
        current = head
        while current:
            print(current.val)
            current = current.next
    ```

    ### Insertion at Beginning
    ```python
    def insert_at_beginning(head, val):
        new_node = ListNode(val)
        new_node.next = head
        return new_node
    ```

    ### Deletion
    ```python
    def delete_node(head, val):
        if not head:
            return None

        if head.val == val:
            return head.next

        current = head
        while current.next and current.next.val != val:
            current = current.next

        if current.next:
            current.next = current.next.next

        return head
    ```

    ## Key Patterns

    ### 1. Two Pointers (Fast & Slow)

    #### Find Middle
    ```python
    def find_middle(head):
        slow = fast = head
        while fast and fast.next:
            slow = slow.next
            fast = fast.next.next
        return slow
    ```

    #### Detect Cycle
    ```python
    def has_cycle(head):
        slow = fast = head
        while fast and fast.next:
            slow = slow.next
            fast = fast.next.next
            if slow == fast:
                return True
        return False
    ```

    ### 2. Reversal

    #### Iterative Reversal
    ```python
    def reverse_list(head):
        prev = None
        current = head

        while current:
            next_temp = current.next
            current.next = prev
            prev = current
            current = next_temp

        return prev
    ```

    #### Recursive Reversal
    ```python
    def reverse_list_recursive(head):
        if not head or not head.next:
            return head

        new_head = reverse_list_recursive(head.next)
        head.next.next = head
        head.next = None

        return new_head
    ```

    ### 3. Merge Operations

    #### Merge Two Sorted Lists
    ```python
    def merge_two_lists(l1, l2):
        dummy = ListNode(0)
        current = dummy

        while l1 and l2:
            if l1.val <= l2.val:
                current.next = l1
                l1 = l1.next
            else:
                current.next = l2
                l2 = l2.next
            current = current.next

        current.next = l1 if l1 else l2
        return dummy.next
    ```

    ## Common Problems

    ### Remove N-th Node from End
    ```python
    def remove_nth_from_end(head, n):
        dummy = ListNode(0)
        dummy.next = head
        first = second = dummy

        # Move first n+1 steps ahead
        for _ in range(n + 1):
            first = first.next

        # Move both until first reaches end
        while first:
            first = first.next
            second = second.next

        second.next = second.next.next
        return dummy.next
    ```

    ## Time & Space Complexity

    | Operation | Time | Space |
    |-----------|------|-------|
    | Access    | O(n) | O(1)  |
    | Search    | O(n) | O(1)  |
    | Insert (beginning) | O(1) | O(1) |
    | Insert (end) | O(n) | O(1) |
    | Delete    | O(n) | O(1)  |

    ## Tips for Linked List Problems

    1. **Use dummy nodes**: Simplifies edge cases at head
    2. **Draw diagrams**: Visualize pointer manipulations
    3. **Handle null checks**: Prevent null pointer exceptions
    4. **Consider recursion**: Often cleaner for certain operations
    5. **Two-pointer technique**: Powerful for many problems
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 7: Lesson 7 ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 7',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Interview Problem-Solving Framework

    ## The UMPIRE Method

    ### U - Understand
    - Read the problem carefully
    - Ask clarifying questions
    - Identify inputs and outputs
    - Clarify edge cases

    ### M - Match
    - Identify problem pattern
    - Match to known algorithms
    - Consider similar problems

    ### P - Plan
    - Outline your approach
    - Consider time/space complexity
    - Discuss trade-offs

    ### I - Implement
    - Write clean, readable code
    - Use meaningful variable names
    - Add comments for complex logic

    ### R - Review
    - Test with examples
    - Check edge cases
    - Verify complexity

    ### E - Evaluate
    - Analyze time complexity
    - Analyze space complexity
    - Discuss optimizations

    ## Common Patterns to Recognize

    ### 1. Frequency Counter Pattern
    **When to use**: Comparing frequencies, anagrams, duplicates

    ```python
    from collections import Counter

    def is_anagram(s1, s2):
        return Counter(s1) == Counter(s2)
    ```

    ### 2. Two Pointers Pattern
    **When to use**: Sorted arrays, palindromes, pairs

    ```python
    def is_palindrome(s):
        left, right = 0, len(s) - 1
        while left < right:
            if s[left] != s[right]:
                return False
            left += 1
            right -= 1
        return True
    ```

    ### 3. Sliding Window Pattern
    **When to use**: Subarrays, substrings, consecutive elements

    ```python
    def max_sum_subarray(arr, k):
        window_sum = sum(arr[:k])
        max_sum = window_sum

        for i in range(k, len(arr)):
            window_sum += arr[i] - arr[i-k]
            max_sum = max(max_sum, window_sum)

        return max_sum
    ```

    ### 4. Fast & Slow Pointers
    **When to use**: Cycles, middle element, linked lists

    ```python
    def has_cycle(head):
        slow = fast = head
        while fast and fast.next:
            slow = slow.next
            fast = fast.next.next
            if slow == fast:
                return True
        return False
    ```

    ### 5. Merge Intervals Pattern
    **When to use**: Overlapping intervals, scheduling

    ```python
    def merge_intervals(intervals):
        intervals.sort(key=lambda x: x[0])
        merged = [intervals[0]]

        for interval in intervals[1:]:
            if merged[-1][1] >= interval[0]:
                merged[-1][1] = max(merged[-1][1], interval[1])
            else:
                merged.append(interval)

        return merged
    ```

    ## Time Complexity Analysis

    ### Common Time Complexities
    - O(1): Constant - Hash table lookup
    - O(log n): Logarithmic - Binary search
    - O(n): Linear - Single loop
    - O(n log n): Linearithmic - Efficient sorting
    - O(n²): Quadratic - Nested loops
    - O(2^n): Exponential - Recursive subsets

    ### Space Complexity Considerations
    - In-place algorithms: O(1) extra space
    - Hash tables/sets: O(n) space
    - Recursion: O(h) call stack, h = height

    ## Communication Tips

    1. **Think out loud**: Verbalize your thought process
    2. **Ask questions**: Clarify requirements and constraints
    3. **Start simple**: Begin with brute force, then optimize
    4. **Test as you go**: Use small examples to verify
    5. **Handle edge cases**: Empty inputs, single elements, extremes

    ## Common Mistakes to Avoid

    1. **Jumping to code**: Plan before implementing
    2. **Ignoring edge cases**: Always consider boundaries
    3. **Not testing**: Verify with examples
    4. **Poor naming**: Use descriptive variable names
    5. **No complexity analysis**: Always discuss time/space
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 8: Lesson 8 ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 8',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Array Fundamentals & Hash Tables

    ## Introduction
    Arrays and hash tables are the foundation of most coding interview problems. Understanding their properties and trade-offs is crucial for interview success.

    ## Arrays

    ### Time Complexity
    - **Access**: O(1) - Direct index access
    - **Search**: O(n) - Linear search
    - **Insertion**: O(n) - Requires shifting elements
    - **Deletion**: O(n) - Requires shifting elements

    ### Common Patterns

    #### 1. Two-Pointer Technique
    ```python
    def two_sum_sorted(nums, target):
        left, right = 0, len(nums) - 1
        while left < right:
            current_sum = nums[left] + nums[right]
            if current_sum == target:
                return [left, right]
            elif current_sum < target:
                left += 1
            else:
                right -= 1
        return []
    ```

    #### 2. Sliding Window
    ```python
    def max_sum_subarray(nums, k):
        window_sum = sum(nums[:k])
        max_sum = window_sum

        for i in range(k, len(nums)):
            window_sum = window_sum - nums[i-k] + nums[i]
            max_sum = max(max_sum, window_sum)

        return max_sum
    ```

    ## Hash Tables

    ### Time Complexity
    - **Access**: N/A - No ordering
    - **Search**: O(1) average, O(n) worst
    - **Insertion**: O(1) average, O(n) worst
    - **Deletion**: O(1) average, O(n) worst

    ### When to Use Hash Tables
    1. **Counting frequencies**: Count occurrences of elements
    2. **Finding pairs**: Two Sum, Three Sum problems
    3. **Detecting duplicates**: Check if element exists
    4. **Grouping data**: Group anagrams, categorize items

    ### Example: Two Sum Problem
    ```python
    def two_sum(nums, target):
        seen = {}
        for i, num in enumerate(nums):
            complement = target - num
            if complement in seen:
                return [seen[complement], i]
            seen[num] = i
        return []
    ```

    ## Key Insights

    1. **Trade Space for Time**: Hash tables often trade memory for speed
    2. **Sorted Arrays**: Enable binary search and two-pointer techniques
    3. **In-place Operations**: Minimize space complexity when possible
    4. **Edge Cases**: Empty arrays, single element, duplicates

    ## Practice Tips
    - Start with brute force, then optimize
    - Consider sorting as a preprocessing step
    - Think about what information to store in hash tables
    - Always verify constraints (array size, value ranges)
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 9: Lesson 9 ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 9',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Common Array Patterns

    ## Pattern 1: Frequency Counter

    Use a hash map to count occurrences:

    ```python
    def is_anagram(s1, s2):
        if len(s1) != len(s2):
            return False

        count = {}
        for char in s1:
            count[char] = count.get(char, 0) + 1

        for char in s2:
            if char not in count:
                return False
            count[char] -= 1
            if count[char] < 0:
                return False

        return True
    ```

    ## Pattern 2: Multiple Pointers

    Use multiple pointers to traverse array:

    ```python
    def three_sum(nums):
        nums.sort()
        result = []

        for i in range(len(nums) - 2):
            if i > 0 and nums[i] == nums[i-1]:
                continue

            left, right = i + 1, len(nums) - 1
            while left < right:
                current_sum = nums[i] + nums[left] + nums[right]
                if current_sum == 0:
                    result.append([nums[i], nums[left], nums[right]])
                    while left < right and nums[left] == nums[left+1]:
                        left += 1
                    while left < right and nums[right] == nums[right-1]:
                        right -= 1
                    left += 1
                    right -= 1
                elif current_sum < 0:
                    left += 1
                else:
                    right -= 1

        return result
    ```

    ## Pattern 3: Prefix Sum

    Precompute cumulative sums for range queries:

    ```python
    def subarray_sum(nums, k):
        count = 0
        prefix_sum = 0
        sum_count = {0: 1}

        for num in nums:
            prefix_sum += num
            if prefix_sum - k in sum_count:
                count += sum_count[prefix_sum - k]
            sum_count[prefix_sum] = sum_count.get(prefix_sum, 0) + 1

        return count
    ```

    ## Pattern 4: Kadane's Algorithm

    Find maximum subarray sum:

    ```python
    def max_subarray(nums):
        max_sum = current_sum = nums[0]

        for num in nums[1:]:
            current_sum = max(num, current_sum + num)
            max_sum = max(max_sum, current_sum)

        return max_sum
    ```

    ## Key Takeaways

    1. **Recognize the pattern**: Most problems follow common templates
    2. **Choose right data structure**: Array vs HashMap vs Set
    3. **Consider sorting**: Often simplifies the problem
    4. **Handle edge cases**: Duplicates, empty inputs, negative numbers
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 10: Lesson 10 ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 10',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Binary Tree Fundamentals

    ## Introduction
    Trees are hierarchical data structures essential for many interview problems. Binary trees, where each node has at most two children, are the most common.

    ## Tree Terminology

    - **Root**: The top node of the tree
    - **Leaf**: A node with no children
    - **Height**: Length of the longest path from root to leaf
    - **Depth**: Length of path from root to a specific node
    - **Level**: All nodes at the same depth

    ## Tree Traversals

    ### 1. Depth-First Search (DFS)

    #### Inorder (Left, Root, Right)
    ```python
    def inorder(root):
        if not root:
            return []
        return inorder(root.left) + [root.val] + inorder(root.right)
    ```

    #### Preorder (Root, Left, Right)
    ```python
    def preorder(root):
        if not root:
            return []
        return [root.val] + preorder(root.left) + preorder(root.right)
    ```

    #### Postorder (Left, Right, Root)
    ```python
    def postorder(root):
        if not root:
            return []
        return postorder(root.left) + postorder(root.right) + [root.val]
    ```

    ### 2. Breadth-First Search (BFS)

    Level-order traversal using queue:

    ```python
    from collections import deque

    def level_order(root):
        if not root:
            return []

        result = []
        queue = deque([root])

        while queue:
            level_size = len(queue)
            current_level = []

            for _ in range(level_size):
                node = queue.popleft()
                current_level.append(node.val)

                if node.left:
                    queue.append(node.left)
                if node.right:
                    queue.append(node.right)

            result.append(current_level)

        return result
    ```

    ## Binary Search Trees (BST)

    ### Properties
    - Left subtree contains values less than root
    - Right subtree contains values greater than root
    - Both subtrees are also BSTs

    ### BST Operations

    #### Search - O(log n) average, O(n) worst
    ```python
    def search_bst(root, val):
        if not root:
            return None
        if root.val == val:
            return root
        elif val < root.val:
            return search_bst(root.left, val)
        else:
            return search_bst(root.right, val)
    ```

    #### Insert - O(log n) average, O(n) worst
    ```python
    def insert_bst(root, val):
        if not root:
            return TreeNode(val)

        if val < root.val:
            root.left = insert_bst(root.left, val)
        else:
            root.right = insert_bst(root.right, val)

        return root
    ```

    ## Common Patterns

    ### 1. Recursive Approach
    - Define base case (usually null node)
    - Process current node
    - Recursively process children

    ### 2. Iterative with Stack/Queue
    - Use stack for DFS
    - Use queue for BFS

    ### 3. Path Problems
    - Track path as you traverse
    - Use backtracking for all paths

    ## Key Insights

    1. **Choose traversal wisely**: Inorder for BST gives sorted order
    2. **Consider both recursive and iterative**: Iterative saves call stack
    3. **Track additional info**: Height, parent pointers, etc.
    4. **Handle edge cases**: Empty tree, single node, skewed trees
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 11: Lesson 11 ===
lesson_11 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 11',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Graph Algorithms

    ## Graph Representation

    ### 1. Adjacency List
    ```python
    graph = {
        'A': ['B', 'C'],
        'B': ['A', 'D', 'E'],
        'C': ['A', 'F'],
        'D': ['B'],
        'E': ['B', 'F'],
        'F': ['C', 'E']
    }
    ```

    ### 2. Adjacency Matrix
    ```python
    # For nodes 0, 1, 2, 3
    graph = [
        [0, 1, 1, 0],
        [1, 0, 1, 1],
        [1, 1, 0, 1],
        [0, 1, 1, 0]
    ]
    ```

    ## Graph Traversals

    ### Depth-First Search (DFS)

    #### Recursive Implementation
    ```python
    def dfs_recursive(graph, node, visited=None):
        if visited is None:
            visited = set()

        visited.add(node)
        print(node)

        for neighbor in graph[node]:
            if neighbor not in visited:
                dfs_recursive(graph, neighbor, visited)

        return visited
    ```

    #### Iterative Implementation
    ```python
    def dfs_iterative(graph, start):
        visited = set()
        stack = [start]

        while stack:
            node = stack.pop()
            if node not in visited:
                visited.add(node)
                print(node)

                for neighbor in graph[node]:
                    if neighbor not in visited:
                        stack.append(neighbor)

        return visited
    ```

    ### Breadth-First Search (BFS)

    ```python
    from collections import deque

    def bfs(graph, start):
        visited = set([start])
        queue = deque([start])

        while queue:
            node = queue.popleft()
            print(node)

            for neighbor in graph[node]:
                if neighbor not in visited:
                    visited.add(neighbor)
                    queue.append(neighbor)

        return visited
    ```

    ## Common Graph Problems

    ### 1. Connected Components
    ```python
    def count_components(n, edges):
        graph = {i: [] for i in range(n)}
        for a, b in edges:
            graph[a].append(b)
            graph[b].append(a)

        visited = set()
        components = 0

        def dfs(node):
            visited.add(node)
            for neighbor in graph[node]:
                if neighbor not in visited:
                    dfs(neighbor)

        for i in range(n):
            if i not in visited:
                dfs(i)
                components += 1

        return components
    ```

    ### 2. Cycle Detection

    #### Undirected Graph
    ```python
    def has_cycle_undirected(graph):
        visited = set()

        def dfs(node, parent):
            visited.add(node)

            for neighbor in graph[node]:
                if neighbor not in visited:
                    if dfs(neighbor, node):
                        return True
                elif parent != neighbor:
                    return True

            return False

        for node in graph:
            if node not in visited:
                if dfs(node, -1):
                    return True

        return False
    ```

    #### Directed Graph (Using Colors)
    ```python
    def has_cycle_directed(graph):
        WHITE, GRAY, BLACK = 0, 1, 2
        colors = {node: WHITE for node in graph}

        def dfs(node):
            colors[node] = GRAY

            for neighbor in graph[node]:
                if colors[neighbor] == GRAY:
                    return True
                if colors[neighbor] == WHITE:
                    if dfs(neighbor):
                        return True

            colors[node] = BLACK
            return False

        for node in graph:
            if colors[node] == WHITE:
                if dfs(node):
                    return True

        return False
    ```

    ### 3. Topological Sort
    ```python
    def topological_sort(graph):
        in_degree = {node: 0 for node in graph}

        for node in graph:
            for neighbor in graph[node]:
                in_degree[neighbor] += 1

        queue = deque([node for node in in_degree if in_degree[node] == 0])
        result = []

        while queue:
            node = queue.popleft()
            result.append(node)

            for neighbor in graph[node]:
                in_degree[neighbor] -= 1
                if in_degree[neighbor] == 0:
                    queue.append(neighbor)

        return result if len(result) == len(graph) else []
    ```

    ## Key Insights

    1. **Choose right representation**: Adjacency list for sparse graphs
    2. **Track visited nodes**: Prevent infinite loops
    3. **BFS for shortest path**: In unweighted graphs
    4. **DFS for exploration**: Path existence, cycles, components
    5. **Consider directed vs undirected**: Different algorithms apply
  MARKDOWN
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 12: Lesson 12 ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 12',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Introduction to Dynamic Programming

    ## What is Dynamic Programming?

    Dynamic Programming (DP) is an optimization technique that solves complex problems by breaking them down into simpler subproblems. It's based on the principle of **optimal substructure** and **overlapping subproblems**.

    ## Key Concepts

    ### 1. Overlapping Subproblems
    The problem can be broken down into subproblems that are reused multiple times.

    ### 2. Optimal Substructure
    The optimal solution contains optimal solutions to subproblems.

    ### 3. Memoization vs Tabulation

    #### Top-Down (Memoization)
    ```python
    def fib_memo(n, memo={}):
        if n in memo:
            return memo[n]
        if n <= 1:
            return n

        memo[n] = fib_memo(n-1, memo) + fib_memo(n-2, memo)
        return memo[n]
    ```

    #### Bottom-Up (Tabulation)
    ```python
    def fib_tab(n):
        if n <= 1:
            return n

        dp = [0] * (n + 1)
        dp[1] = 1

        for i in range(2, n + 1):
            dp[i] = dp[i-1] + dp[i-2]

        return dp[n]
    ```

    ## Classic DP Problems

    ### 1. Climbing Stairs
    ```python
    def climb_stairs(n):
        if n <= 2:
            return n

        # dp[i] = ways to reach step i
        prev2, prev1 = 1, 2

        for i in range(3, n + 1):
            current = prev1 + prev2
            prev2, prev1 = prev1, current

        return prev1
    ```

    ### 2. House Robber
    ```python
    def rob(nums):
        if not nums:
            return 0
        if len(nums) == 1:
            return nums[0]

        # dp[i] = max money robbed up to house i
        prev2 = nums[0]
        prev1 = max(nums[0], nums[1])

        for i in range(2, len(nums)):
            current = max(prev1, prev2 + nums[i])
            prev2, prev1 = prev1, current

        return prev1
    ```

    ### 3. Coin Change
    ```python
    def coin_change(coins, amount):
        # dp[i] = min coins needed for amount i
        dp = [float('inf')] * (amount + 1)
        dp[0] = 0

        for i in range(1, amount + 1):
            for coin in coins:
                if coin <= i:
                    dp[i] = min(dp[i], dp[i - coin] + 1)

        return dp[amount] if dp[amount] != float('inf') else -1
    ```

    ## DP Patterns

    ### Pattern 1: Linear DP
    - Problems on arrays/sequences
    - State: dp[i] represents solution for first i elements
    - Examples: Maximum subarray, House Robber

    ### Pattern 2: Grid DP
    - Problems on 2D grids
    - State: dp[i][j] represents solution at position (i, j)
    - Examples: Unique Paths, Minimum Path Sum

    ### Pattern 3: Interval DP
    - Problems on intervals/subarrays
    - State: dp[i][j] represents solution for interval [i, j]
    - Examples: Longest Palindromic Substring, Burst Balloons

    ### Pattern 4: Knapsack DP
    - Selection problems with constraints
    - State: dp[i][w] represents solution using first i items with weight w
    - Examples: 0/1 Knapsack, Subset Sum

    ## Steps to Solve DP Problems

    1. **Identify if it's a DP problem**
       - Can be broken into subproblems
       - Subproblems overlap
       - Has optimal substructure

    2. **Define the state**
       - What does dp[i] or dp[i][j] represent?

    3. **Define the recurrence relation**
       - How to compute dp[i] from previous states?

    4. **Identify base cases**
       - What are the smallest subproblems?

    5. **Determine iteration order**
       - In what order to fill the DP table?

    6. **Optimize space if possible**
       - Can we use rolling array?

    ## Key Insights

    1. **Start with recursion**: Write recursive solution first
    2. **Add memoization**: Cache results to avoid recomputation
    3. **Convert to tabulation**: Build bottom-up for better space
    4. **Optimize space**: Use only necessary previous states
    5. **Practice recognition**: Learn to identify DP patterns quickly
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 13: Lesson 13 ===
lesson_13 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 13',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Linked List Fundamentals

    ## Introduction
    Linked lists are linear data structures where elements are stored in nodes, with each node containing data and a reference to the next node.

    ## Types of Linked Lists

    ### 1. Singly Linked List
    ```python
    class ListNode:
        def __init__(self, val=0, next=None):
            self.val = val
            self.next = next
    ```

    ### 2. Doubly Linked List
    ```python
    class DoublyListNode:
        def __init__(self, val=0, prev=None, next=None):
            self.val = val
            self.prev = prev
            self.next = next
    ```

    ## Common Operations

    ### Traversal
    ```python
    def traverse(head):
        current = head
        while current:
            print(current.val)
            current = current.next
    ```

    ### Insertion at Beginning
    ```python
    def insert_at_beginning(head, val):
        new_node = ListNode(val)
        new_node.next = head
        return new_node
    ```

    ### Deletion
    ```python
    def delete_node(head, val):
        if not head:
            return None

        if head.val == val:
            return head.next

        current = head
        while current.next and current.next.val != val:
            current = current.next

        if current.next:
            current.next = current.next.next

        return head
    ```

    ## Key Patterns

    ### 1. Two Pointers (Fast & Slow)

    #### Find Middle
    ```python
    def find_middle(head):
        slow = fast = head
        while fast and fast.next:
            slow = slow.next
            fast = fast.next.next
        return slow
    ```

    #### Detect Cycle
    ```python
    def has_cycle(head):
        slow = fast = head
        while fast and fast.next:
            slow = slow.next
            fast = fast.next.next
            if slow == fast:
                return True
        return False
    ```

    ### 2. Reversal

    #### Iterative Reversal
    ```python
    def reverse_list(head):
        prev = None
        current = head

        while current:
            next_temp = current.next
            current.next = prev
            prev = current
            current = next_temp

        return prev
    ```

    #### Recursive Reversal
    ```python
    def reverse_list_recursive(head):
        if not head or not head.next:
            return head

        new_head = reverse_list_recursive(head.next)
        head.next.next = head
        head.next = None

        return new_head
    ```

    ### 3. Merge Operations

    #### Merge Two Sorted Lists
    ```python
    def merge_two_lists(l1, l2):
        dummy = ListNode(0)
        current = dummy

        while l1 and l2:
            if l1.val <= l2.val:
                current.next = l1
                l1 = l1.next
            else:
                current.next = l2
                l2 = l2.next
            current = current.next

        current.next = l1 if l1 else l2
        return dummy.next
    ```

    ## Common Problems

    ### Remove N-th Node from End
    ```python
    def remove_nth_from_end(head, n):
        dummy = ListNode(0)
        dummy.next = head
        first = second = dummy

        # Move first n+1 steps ahead
        for _ in range(n + 1):
            first = first.next

        # Move both until first reaches end
        while first:
            first = first.next
            second = second.next

        second.next = second.next.next
        return dummy.next
    ```

    ## Time & Space Complexity

    | Operation | Time | Space |
    |-----------|------|-------|
    | Access    | O(n) | O(1)  |
    | Search    | O(n) | O(1)  |
    | Insert (beginning) | O(1) | O(1) |
    | Insert (end) | O(n) | O(1) |
    | Delete    | O(n) | O(1)  |

    ## Tips for Linked List Problems

    1. **Use dummy nodes**: Simplifies edge cases at head
    2. **Draw diagrams**: Visualize pointer manipulations
    3. **Handle null checks**: Prevent null pointer exceptions
    4. **Consider recursion**: Often cleaner for certain operations
    5. **Two-pointer technique**: Powerful for many problems
  MARKDOWN
  sequence_order: 13,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 14: Lesson 14 ===
lesson_14 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 14',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Interview Problem-Solving Framework

    ## The UMPIRE Method

    ### U - Understand
    - Read the problem carefully
    - Ask clarifying questions
    - Identify inputs and outputs
    - Clarify edge cases

    ### M - Match
    - Identify problem pattern
    - Match to known algorithms
    - Consider similar problems

    ### P - Plan
    - Outline your approach
    - Consider time/space complexity
    - Discuss trade-offs

    ### I - Implement
    - Write clean, readable code
    - Use meaningful variable names
    - Add comments for complex logic

    ### R - Review
    - Test with examples
    - Check edge cases
    - Verify complexity

    ### E - Evaluate
    - Analyze time complexity
    - Analyze space complexity
    - Discuss optimizations

    ## Common Patterns to Recognize

    ### 1. Frequency Counter Pattern
    **When to use**: Comparing frequencies, anagrams, duplicates

    ```python
    from collections import Counter

    def is_anagram(s1, s2):
        return Counter(s1) == Counter(s2)
    ```

    ### 2. Two Pointers Pattern
    **When to use**: Sorted arrays, palindromes, pairs

    ```python
    def is_palindrome(s):
        left, right = 0, len(s) - 1
        while left < right:
            if s[left] != s[right]:
                return False
            left += 1
            right -= 1
        return True
    ```

    ### 3. Sliding Window Pattern
    **When to use**: Subarrays, substrings, consecutive elements

    ```python
    def max_sum_subarray(arr, k):
        window_sum = sum(arr[:k])
        max_sum = window_sum

        for i in range(k, len(arr)):
            window_sum += arr[i] - arr[i-k]
            max_sum = max(max_sum, window_sum)

        return max_sum
    ```

    ### 4. Fast & Slow Pointers
    **When to use**: Cycles, middle element, linked lists

    ```python
    def has_cycle(head):
        slow = fast = head
        while fast and fast.next:
            slow = slow.next
            fast = fast.next.next
            if slow == fast:
                return True
        return False
    ```

    ### 5. Merge Intervals Pattern
    **When to use**: Overlapping intervals, scheduling

    ```python
    def merge_intervals(intervals):
        intervals.sort(key=lambda x: x[0])
        merged = [intervals[0]]

        for interval in intervals[1:]:
            if merged[-1][1] >= interval[0]:
                merged[-1][1] = max(merged[-1][1], interval[1])
            else:
                merged.append(interval)

        return merged
    ```

    ## Time Complexity Analysis

    ### Common Time Complexities
    - O(1): Constant - Hash table lookup
    - O(log n): Logarithmic - Binary search
    - O(n): Linear - Single loop
    - O(n log n): Linearithmic - Efficient sorting
    - O(n²): Quadratic - Nested loops
    - O(2^n): Exponential - Recursive subsets

    ### Space Complexity Considerations
    - In-place algorithms: O(1) extra space
    - Hash tables/sets: O(n) space
    - Recursion: O(h) call stack, h = height

    ## Communication Tips

    1. **Think out loud**: Verbalize your thought process
    2. **Ask questions**: Clarify requirements and constraints
    3. **Start simple**: Begin with brute force, then optimize
    4. **Test as you go**: Use small examples to verify
    5. **Handle edge cases**: Empty inputs, single elements, extremes

    ## Common Mistakes to Avoid

    1. **Jumping to code**: Plan before implementing
    2. **Ignoring edge cases**: Always consider boundaries
    3. **Not testing**: Verify with examples
    4. **Poor naming**: Use descriptive variable names
    5. **No complexity analysis**: Always discuss time/space
  MARKDOWN
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 15: arrays — Practice ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'arrays — Practice',
  content: <<~MARKDOWN,
# arrays — Practice 🚀

Arrays provide constant-time access to elements by index because the memory address can be calculated directly.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['arrays'],
  prerequisite_ids: []
)

# === MICROLESSON 16: graph_traversal — Practice ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'graph_traversal — Practice',
  content: <<~MARKDOWN,
# graph_traversal — Practice 🚀

BFS explores nodes level by level, which requires FIFO ordering provided by a queue.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['graph_traversal'],
  prerequisite_ids: []
)

# === MICROLESSON 17: linked_list_operations — Practice ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'linked_list_operations — Practice',
  content: <<~MARKDOWN,
# linked_list_operations — Practice 🚀

Inserting at the beginning only requires updating the head pointer, which is a constant-time operation.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 17,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: ['linked_list_operations'],
  prerequisite_ids: []
)

# === MICROLESSON 18: Practice Question ===
lesson_18 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 18,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 19: Practice Question ===
lesson_19 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 19,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 20: Practice Question ===
lesson_20 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 20,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 21: Practice Question ===
lesson_21 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 21,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 22: Practice Question ===
lesson_22 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 22,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 23: Practice Question ===
lesson_23 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 23,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 24: Practice Question ===
lesson_24 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 24,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 25: Practice Question ===
lesson_25 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 25,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 26: Practice Question ===
lesson_26 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 26,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 27: Practice Question ===
lesson_27 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 27,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 28: Practice Question ===
lesson_28 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 28,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 29: Practice Question ===
lesson_29 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 29,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 30: Practice Question ===
lesson_30 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 30,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 31: Practice Question ===
lesson_31 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 31,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 32: Practice Question ===
lesson_32 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 32,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 33: Practice Question ===
lesson_33 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 33,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 34: Practice Question ===
lesson_34 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 34,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 35: Practice Question ===
lesson_35 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 35,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 36: Practice Question ===
lesson_36 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 36,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 37: Lesson 37 ===
lesson_37 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 37',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Array Fundamentals & Hash Tables

    ## Introduction
    Arrays and hash tables are the foundation of most coding interview problems. Understanding their properties and trade-offs is crucial for interview success.

    ## Arrays

    ### Time Complexity
    - **Access**: O(1) - Direct index access
    - **Search**: O(n) - Linear search
    - **Insertion**: O(n) - Requires shifting elements
    - **Deletion**: O(n) - Requires shifting elements

    ### Common Patterns

    #### 1. Two-Pointer Technique
    ```python
    def two_sum_sorted(nums, target):
        left, right = 0, len(nums) - 1
        while left < right:
            current_sum = nums[left] + nums[right]
            if current_sum == target:
                return [left, right]
            elif current_sum < target:
                left += 1
            else:
                right -= 1
        return []
    ```

    #### 2. Sliding Window
    ```python
    def max_sum_subarray(nums, k):
        window_sum = sum(nums[:k])
        max_sum = window_sum

        for i in range(k, len(nums)):
            window_sum = window_sum - nums[i-k] + nums[i]
            max_sum = max(max_sum, window_sum)

        return max_sum
    ```

    ## Hash Tables

    ### Time Complexity
    - **Access**: N/A - No ordering
    - **Search**: O(1) average, O(n) worst
    - **Insertion**: O(1) average, O(n) worst
    - **Deletion**: O(1) average, O(n) worst

    ### When to Use Hash Tables
    1. **Counting frequencies**: Count occurrences of elements
    2. **Finding pairs**: Two Sum, Three Sum problems
    3. **Detecting duplicates**: Check if element exists
    4. **Grouping data**: Group anagrams, categorize items

    ### Example: Two Sum Problem
    ```python
    def two_sum(nums, target):
        seen = {}
        for i, num in enumerate(nums):
            complement = target - num
            if complement in seen:
                return [seen[complement], i]
            seen[num] = i
        return []
    ```

    ## Key Insights

    1. **Trade Space for Time**: Hash tables often trade memory for speed
    2. **Sorted Arrays**: Enable binary search and two-pointer techniques
    3. **In-place Operations**: Minimize space complexity when possible
    4. **Edge Cases**: Empty arrays, single element, duplicates

    ## Practice Tips
    - Start with brute force, then optimize
    - Consider sorting as a preprocessing step
    - Think about what information to store in hash tables
    - Always verify constraints (array size, value ranges)
  MARKDOWN
  sequence_order: 37,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 37 microlessons for Arrays Hashing"
