require 'json'

# Simple titleize method
class String
  def titleize
    self.split(/[\s_-]/).map(&:capitalize).join(' ')
  end
end

# Microlesson content templates for each DSA family/concept
class MicrolessonGenerator
  CONCEPT_DEFINITIONS = {
    # Arrays & Strings
    'array-basics-001' => {
      title: 'Array Basics',
      description: 'Fundamental operations on arrays including traversal, access, and manipulation',
      theory: <<~MARKDOWN,
        ## What are Arrays?

        Arrays are contiguous memory blocks that store elements of the same type. They provide O(1) random access but O(n) insertion/deletion.

        **Key Properties:**
        - Fixed or dynamic size
        - Zero-indexed access
        - Contiguous memory allocation
        - Cache-friendly due to locality

        **Time Complexities:**
        - Access: O(1)
        - Search (unsorted): O(n)
        - Insert at end: O(1) amortized
        - Insert at position: O(n)
        - Delete: O(n)
      MARKDOWN
      patterns: <<~MARKDOWN,
        ## Common Patterns

        ### 1. Iteration
        ```python
        for i in range(len(arr)):
            process(arr[i])
        ```

        ### 2. Reverse Iteration
        ```python
        for i in range(len(arr) - 1, -1, -1):
            process(arr[i])
        ```

        ### 3. In-place Modification
        ```python
        for i in range(len(arr)):
            arr[i] = transform(arr[i])
        ```
      MARKDOWN
      when_to_use: 'Use arrays when you need fast random access, know the size in advance, or need cache-efficient sequential access.',
      common_pitfalls: [
        'Index out of bounds errors',
        'Not considering edge cases (empty array, single element)',
        'Forgetting that arrays are zero-indexed',
        'Modifying array while iterating'
      ]
    },

    'array-sliding-window-002' => {
      title: 'Sliding Window',
      description: 'Efficient technique for processing subarrays or substrings by maintaining a window',
      theory: <<~MARKDOWN,
        ## Sliding Window Technique

        The sliding window pattern is used to solve problems involving subarrays, substrings, or sequential data where you need to find optimal subarrays.

        **Types of Sliding Windows:**

        ### 1. Fixed-Size Window
        Window size is predetermined and constant throughout.

        ### 2. Dynamic-Size Window
        Window expands and contracts based on conditions.

        **Key Characteristics:**
        - Reduces time complexity from O(n²) or O(n³) to O(n)
        - Maintains state as window moves
        - Uses two pointers (left and right)

        **When Window is Valid:**
        - Fixed size: when right - left + 1 == k
        - Dynamic: when condition is satisfied
      MARKDOWN
      patterns: <<~MARKDOWN,
        ## Common Patterns

        ### Pattern 1: Fixed Window
        ```python
        def fixed_window(arr, k):
            window_sum = sum(arr[:k])  # Initial window
            max_sum = window_sum

            for i in range(k, len(arr)):
                # Slide window: remove left, add right
                window_sum = window_sum - arr[i-k] + arr[i]
                max_sum = max(max_sum, window_sum)

            return max_sum
        ```

        ### Pattern 2: Dynamic Window (Expand/Contract)
        ```python
        def dynamic_window(s):
            left = 0
            char_set = set()
            max_length = 0

            for right in range(len(s)):
                # Expand window
                while s[right] in char_set:
                    # Contract window if invalid
                    char_set.remove(s[left])
                    left += 1

                char_set.add(s[right])
                max_length = max(max_length, right - left + 1)

            return max_length
        ```

        ### Pattern 3: Window with HashMap
        ```python
        def window_with_map(s, k):
            char_count = {}
            left = 0

            for right in range(len(s)):
                char_count[s[right]] = char_count.get(s[right], 0) + 1

                # Maintain window constraint
                if len(char_count) > k:
                    char_count[s[left]] -= 1
                    if char_count[s[left]] == 0:
                        del char_count[s[left]]
                    left += 1
        ```
      MARKDOWN
      when_to_use: 'Use sliding window for problems involving contiguous subarrays/substrings, finding min/max/optimal subarray, or problems with "longest/shortest/maximum/minimum substring/subarray" keywords.',
      common_pitfalls: [
        'Not handling window shrinking correctly',
        'Off-by-one errors in window size calculation',
        'Forgetting to update window state when sliding',
        'Not initializing the first window properly',
        'Confusing when to expand vs contract'
      ]
    },

    'array-two-pointers-004' => {
      title: 'Two Pointers',
      description: 'Using two pointers moving toward each other or in same direction to solve array problems efficiently',
      theory: <<~MARKDOWN,
        ## Two Pointers Technique

        Two pointers is an algorithmic pattern where we use two indices to traverse data structures, typically arrays or linked lists.

        **Types:**

        ### 1. Opposite Direction (Converging)
        Pointers start at both ends and move toward each other.
        - **Use cases:** Palindrome check, pair sum problems, reversing

        ### 2. Same Direction (Chasing)
        Both pointers move in the same direction at different speeds.
        - **Use cases:** Removing duplicates, partitioning, fast-slow pointer

        ### 3. Sliding Window (Special Case)
        Left and right pointers define a window that slides/expands.

        **Time Complexity:** Usually O(n) - each pointer traverses once
      MARKDOWN
      patterns: <<~MARKDOWN,
        ## Common Patterns

        ### Pattern 1: Opposite Direction
        ```python
        def two_sum_sorted(arr, target):
            left, right = 0, len(arr) - 1

            while left < right:
                current_sum = arr[left] + arr[right]

                if current_sum == target:
                    return [left, right]
                elif current_sum < target:
                    left += 1  # Need larger sum
                else:
                    right -= 1  # Need smaller sum

            return []
        ```

        ### Pattern 2: Same Direction (Remove Duplicates)
        ```python
        def remove_duplicates(arr):
            if not arr:
                return 0

            write_ptr = 1  # Where to write next unique element

            for read_ptr in range(1, len(arr)):
                if arr[read_ptr] != arr[read_ptr - 1]:
                    arr[write_ptr] = arr[read_ptr]
                    write_ptr += 1

            return write_ptr  # New length
        ```

        ### Pattern 3: Partition (Dutch National Flag)
        ```python
        def partition(arr, pivot):
            left, right = 0, len(arr) - 1
            i = 0

            while i <= right:
                if arr[i] < pivot:
                    arr[i], arr[left] = arr[left], arr[i]
                    left += 1
                    i += 1
                elif arr[i] > pivot:
                    arr[i], arr[right] = arr[right], arr[i]
                    right -= 1
                else:
                    i += 1
        ```
      MARKDOWN
      when_to_use: 'Use two pointers for sorted arrays, palindrome problems, pair/triplet sums, partitioning, or when you need to optimize from O(n²) to O(n).',
      common_pitfalls: [
        'Not handling edge cases (empty, single element)',
        'Off-by-one errors in pointer boundaries',
        'Infinite loops from not moving pointers',
        'Using two pointers on unsorted data (when sorting is required)',
        'Forgetting to check left < right condition'
      ]
    },

    'array-prefix-sum-003' => {
      title: 'Prefix Sum',
      description: 'Precomputing cumulative sums for efficient range sum queries',
      theory: <<~MARKDOWN,
        ## Prefix Sum Technique

        Prefix sum (or cumulative sum) is a preprocessing technique where we compute the sum of elements from the start up to each index.

        **Definition:**
        ```
        prefix[i] = arr[0] + arr[1] + ... + arr[i]
        ```

        **Key Insight:**
        Range sum from index i to j can be computed in O(1):
        ```
        sum(i, j) = prefix[j] - prefix[i-1]
        ```

        **Applications:**
        - Range sum queries
        - Subarray sum problems
        - Count subarrays with given sum
        - 2D matrix sum queries

        **Complexity:**
        - Preprocessing: O(n)
        - Query: O(1)
        - Space: O(n)
      MARKDOWN
      patterns: <<~MARKDOWN,
        ## Common Patterns

        ### Pattern 1: Basic Prefix Sum
        ```python
        def build_prefix_sum(arr):
            prefix = [0] * (len(arr) + 1)  # Extra space for easier range query

            for i in range(len(arr)):
                prefix[i + 1] = prefix[i] + arr[i]

            return prefix

        def range_sum(prefix, i, j):
            """Sum from index i to j (inclusive)"""
            return prefix[j + 1] - prefix[i]
        ```

        ### Pattern 2: Prefix Sum with HashMap (Subarray Sum = K)
        ```python
        def subarray_sum_equals_k(arr, k):
            prefix_sum = 0
            sum_count = {0: 1}  # Handle subarrays starting from index 0
            count = 0

            for num in arr:
                prefix_sum += num

                # If (prefix_sum - k) exists, we found subarrays
                if prefix_sum - k in sum_count:
                    count += sum_count[prefix_sum - k]

                sum_count[prefix_sum] = sum_count.get(prefix_sum, 0) + 1

            return count
        ```

        ### Pattern 3: 2D Prefix Sum
        ```python
        def build_2d_prefix(matrix):
            rows, cols = len(matrix), len(matrix[0])
            prefix = [[0] * (cols + 1) for _ in range(rows + 1)]

            for i in range(1, rows + 1):
                for j in range(1, cols + 1):
                    prefix[i][j] = (matrix[i-1][j-1] +
                                   prefix[i-1][j] +
                                   prefix[i][j-1] -
                                   prefix[i-1][j-1])
            return prefix

        def query_2d(prefix, r1, c1, r2, c2):
            """Sum of submatrix from (r1,c1) to (r2,c2)"""
            return (prefix[r2+1][c2+1] -
                   prefix[r1][c2+1] -
                   prefix[r2+1][c1] +
                   prefix[r1][c1])
        ```
      MARKDOWN
      when_to_use: 'Use prefix sum when you have multiple range sum queries, need to find subarrays with specific sum properties, or optimize subarray sum calculations from O(n) to O(1) per query.',
      common_pitfalls: [
        'Off-by-one errors in indexing',
        'Not handling empty subarrays (prefix[0] = 0)',
        'Forgetting to include overlap correction in 2D prefix sum',
        'Not considering negative numbers in sum',
        'Overflow issues with large sums'
      ]
    },

    # Graph Algorithms
    'graph-union-find-041' => {
      title: 'Union Find (Disjoint Set Union)',
      description: 'Efficient data structure for tracking disjoint sets and performing union/find operations',
      theory: <<~MARKDOWN,
        ## Union Find Data Structure

        Union Find (also called Disjoint Set Union or DSU) is a data structure that tracks elements partitioned into disjoint sets and supports two operations efficiently:

        **Operations:**
        1. **Find:** Determine which set an element belongs to
        2. **Union:** Merge two sets into one

        **Key Concepts:**

        ### Parent Array Representation
        Each element points to its parent. Root of tree represents the set.

        ### Path Compression
        During find operation, make nodes point directly to root.
        - Flattens tree structure
        - Speeds up future operations

        ### Union by Rank/Size
        When merging, attach smaller tree under root of larger tree.
        - Keeps trees balanced
        - Prevents degeneration to linked list

        **Time Complexity:**
        - Without optimization: O(n) per operation
        - With path compression + union by rank: O(α(n)) ≈ O(1)
        - α(n) is inverse Ackermann function (grows extremely slowly)

        **Space Complexity:** O(n)
      MARKDOWN
      patterns: <<~MARKDOWN,
        ## Common Patterns

        ### Pattern 1: Basic Union Find
        ```python
        class UnionFind:
            def __init__(self, n):
                self.parent = list(range(n))  # Each node is its own parent
                self.rank = [0] * n          # Track tree height
                self.components = n           # Number of disjoint sets

            def find(self, x):
                """Find root with path compression"""
                if self.parent[x] != x:
                    self.parent[x] = self.find(self.parent[x])  # Path compression
                return self.parent[x]

            def union(self, x, y):
                """Union by rank"""
                root_x, root_y = self.find(x), self.find(y)

                if root_x == root_y:
                    return False  # Already in same set

                # Union by rank: attach smaller tree under larger
                if self.rank[root_x] < self.rank[root_y]:
                    self.parent[root_x] = root_y
                elif self.rank[root_x] > self.rank[root_y]:
                    self.parent[root_y] = root_x
                else:
                    self.parent[root_y] = root_x
                    self.rank[root_x] += 1

                self.components -= 1
                return True

            def connected(self, x, y):
                """Check if two elements are in same set"""
                return self.find(x) == self.find(y)

            def count_components(self):
                """Get number of disjoint sets"""
                return self.components
        ```

        ### Pattern 2: Union by Size (Alternative)
        ```python
        class UnionFindBySize:
            def __init__(self, n):
                self.parent = list(range(n))
                self.size = [1] * n  # Track component size instead of rank

            def find(self, x):
                if self.parent[x] != x:
                    self.parent[x] = self.find(self.parent[x])
                return self.parent[x]

            def union(self, x, y):
                root_x, root_y = self.find(x), self.find(y)

                if root_x == root_y:
                    return False

                # Attach smaller component to larger
                if self.size[root_x] < self.size[root_y]:
                    self.parent[root_x] = root_y
                    self.size[root_y] += self.size[root_x]
                else:
                    self.parent[root_y] = root_x
                    self.size[root_x] += self.size[root_y]

                return True

            def get_size(self, x):
                """Get size of component containing x"""
                return self.size[self.find(x)]
        ```

        ### Pattern 3: Detect Cycle in Graph
        ```python
        def has_cycle(n, edges):
            """Detect cycle in undirected graph using Union Find"""
            uf = UnionFind(n)

            for u, v in edges:
                if uf.connected(u, v):
                    return True  # Cycle detected
                uf.union(u, v)

            return False
        ```

        ### Pattern 4: Count Connected Components
        ```python
        def count_components(n, edges):
            """Count connected components in graph"""
            uf = UnionFind(n)

            for u, v in edges:
                uf.union(u, v)

            return uf.count_components()
        ```

        ### Pattern 5: Kruskal's MST Algorithm
        ```python
        def kruskal_mst(n, edges):
            """Find Minimum Spanning Tree using Union Find"""
            # Sort edges by weight
            edges.sort(key=lambda x: x[2])

            uf = UnionFind(n)
            mst_edges = []
            mst_weight = 0

            for u, v, weight in edges:
                if uf.union(u, v):  # If not in same component
                    mst_edges.append((u, v, weight))
                    mst_weight += weight

                    if len(mst_edges) == n - 1:
                        break  # MST complete

            return mst_edges, mst_weight
        ```
      MARKDOWN
      when_to_use: 'Use Union Find for: dynamic connectivity problems, detecting cycles in undirected graphs, finding connected components, Kruskal\'s MST algorithm, or any problem involving merging/grouping elements.',
      common_pitfalls: [
        'Forgetting path compression (makes operations slow)',
        'Not using union by rank/size (creates unbalanced trees)',
        'Using Union Find for directed graphs (use SCC algorithms instead)',
        'Not initializing parent array correctly',
        'Forgetting to check if elements are already connected before union',
        'Trying to use for shortest path (use Dijkstra/BFS instead)'
      ]
    },

    'graph-dfs-036' => {
      title: 'Depth First Search (DFS)',
      description: 'Graph traversal algorithm that explores as far as possible along each branch',
      theory: <<~MARKDOWN,
        ## DFS Algorithm

        DFS explores a graph by going as deep as possible along each branch before backtracking.

        **Characteristics:**
        - Uses stack (implicit via recursion or explicit)
        - Explores deeply before broadly
        - Memory efficient for deep graphs

        **Applications:**
        - Path finding
        - Cycle detection
        - Topological sorting
        - Connected components
        - Maze solving

        **Complexity:**
        - Time: O(V + E)
        - Space: O(V) for recursion stack
      MARKDOWN
      patterns: <<~MARKDOWN,
        ## Common Patterns

        ### Pattern 1: Recursive DFS
        ```python
        def dfs_recursive(graph, node, visited):
            visited.add(node)
            process(node)

            for neighbor in graph[node]:
                if neighbor not in visited:
                    dfs_recursive(graph, neighbor, visited)
        ```

        ### Pattern 2: Iterative DFS with Stack
        ```python
        def dfs_iterative(graph, start):
            visited = set()
            stack = [start]

            while stack:
                node = stack.pop()

                if node in visited:
                    continue

                visited.add(node)
                process(node)

                for neighbor in graph[node]:
                    if neighbor not in visited:
                        stack.append(neighbor)
        ```

        ### Pattern 3: Detect Cycle in Directed Graph
        ```python
        def has_cycle(graph):
            WHITE, GRAY, BLACK = 0, 1, 2
            color = {node: WHITE for node in graph}

            def dfs(node):
                color[node] = GRAY

                for neighbor in graph[node]:
                    if color[neighbor] == GRAY:
                        return True  # Back edge = cycle
                    if color[neighbor] == WHITE and dfs(neighbor):
                        return True

                color[node] = BLACK
                return False

            return any(dfs(node) for node in graph if color[node] == WHITE)
        ```
      MARKDOWN
      when_to_use: 'Use DFS for path finding, topological sort, detecting cycles, finding strongly connected components, or exploring all paths.',
      common_pitfalls: [
        'Stack overflow with deep recursion',
        'Not marking nodes as visited (infinite loops)',
        'Confusing DFS with BFS applications',
        'Not handling disconnected components'
      ]
    },

    'graph-bfs-037' => {
      title: 'Breadth First Search (BFS)',
      description: 'Graph traversal that explores all neighbors before going deeper',
      theory: <<~MARKDOWN,
        ## BFS Algorithm

        BFS explores graph level by level, visiting all neighbors before moving to next level.

        **Characteristics:**
        - Uses queue
        - Finds shortest path in unweighted graphs
        - Explores breadth before depth

        **Applications:**
        - Shortest path (unweighted)
        - Level-order traversal
        - Finding nearest nodes
        - Web crawling

        **Complexity:**
        - Time: O(V + E)
        - Space: O(V) for queue
      MARKDOWN
      patterns: <<~MARKDOWN,
        ## Common Patterns

        ### Pattern 1: Basic BFS
        ```python
        from collections import deque

        def bfs(graph, start):
            visited = {start}
            queue = deque([start])

            while queue:
                node = queue.popleft()
                process(node)

                for neighbor in graph[node]:
                    if neighbor not in visited:
                        visited.add(neighbor)
                        queue.append(neighbor)
        ```

        ### Pattern 2: BFS with Distance Tracking
        ```python
        def bfs_shortest_path(graph, start, target):
            visited = {start}
            queue = deque([(start, 0)])  # (node, distance)

            while queue:
                node, dist = queue.popleft()

                if node == target:
                    return dist

                for neighbor in graph[node]:
                    if neighbor not in visited:
                        visited.add(neighbor)
                        queue.append((neighbor, dist + 1))

            return -1  # Target not reachable
        ```
      MARKDOWN
      when_to_use: 'Use BFS for shortest path in unweighted graphs, level-order traversal, finding connected components at same distance, or minimum steps problems.',
      common_pitfalls: [
        'Using BFS for weighted graphs (use Dijkstra)',
        'Not using queue (using stack makes it DFS)',
        'Marking visited too late (duplicates in queue)',
        'Not handling disconnected graphs'
      ]
    },

    # Dynamic Programming
    'dp-1d-dp-064' => {
      title: '1D Dynamic Programming',
      description: 'DP problems with single-dimensional state space',
      theory: <<~MARKDOWN,
        ## 1D Dynamic Programming

        Problems where optimal solution depends on solutions to subproblems with single parameter.

        **Approach:**
        1. Define state: dp[i] = optimal value for subproblem ending at i
        2. Find recurrence relation
        3. Identify base cases
        4. Determine computation order
        5. Return final answer

        **Common Problems:**
        - Fibonacci
        - Climbing stairs
        - House robber
        - Maximum subarray
        - Coin change
      MARKDOWN
      patterns: <<~MARKDOWN,
        ## Common Patterns

        ### Pattern 1: Simple Recurrence
        ```python
        def climb_stairs(n):
            if n <= 2:
                return n

            dp = [0] * (n + 1)
            dp[1], dp[2] = 1, 2

            for i in range(3, n + 1):
                dp[i] = dp[i-1] + dp[i-2]

            return dp[n]
        ```

        ### Pattern 2: Choice at Each Step
        ```python
        def house_robber(nums):
            if not nums:
                return 0
            if len(nums) == 1:
                return nums[0]

            dp = [0] * len(nums)
            dp[0] = nums[0]
            dp[1] = max(nums[0], nums[1])

            for i in range(2, len(nums)):
                # Choose: rob current + skip previous, or skip current
                dp[i] = max(nums[i] + dp[i-2], dp[i-1])

            return dp[-1]
        ```

        ### Pattern 3: Space Optimization
        ```python
        def fib_optimized(n):
            if n <= 1:
                return n

            prev2, prev1 = 0, 1

            for i in range(2, n + 1):
                curr = prev1 + prev2
                prev2, prev1 = prev1, curr

            return prev1
        ```
      MARKDOWN
      when_to_use: 'Use 1D DP when problem has optimal substructure with single parameter, overlapping subproblems, and each state depends on previous states.',
      common_pitfalls: [
        'Not identifying base cases correctly',
        'Wrong computation order',
        'Not considering all transitions',
        'Off-by-one errors in indexing'
      ]
    },

    # More concepts will be added below...

    # Trees
    'tree-binary-tree-traversal-024' => {
      title: 'Binary Tree Traversal',
      description: 'Systematic ways to visit all nodes in a binary tree',
      theory: <<~MARKDOWN,
        ## Binary Tree Traversal Methods

        Traversal is the process of visiting all nodes in a tree in a specific order.

        **Four Main Traversals:**

        ### 1. Inorder (Left-Root-Right)
        - Visits left subtree, then root, then right subtree
        - For BST: visits nodes in sorted order
        - Use: Expression tree evaluation, sorted output

        ### 2. Preorder (Root-Left-Right)
        - Visits root first, then left, then right
        - Use: Copying tree, prefix notation

        ### 3. Postorder (Left-Right-Root)
        - Visits children before root
        - Use: Deleting tree, postfix notation, calculating tree size

        ### 4. Level Order (BFS)
        - Visits nodes level by level
        - Use: Finding level, shortest path, serialization

        **Complexity:** O(n) time, O(h) space for recursive (h = height)
      MARKDOWN
      patterns: <<~MARKDOWN,
        ## Common Patterns

        ### Pattern 1: Recursive Inorder
        ```python
        def inorder(root, result=[]):
            if root:
                inorder(root.left, result)
                result.append(root.val)
                inorder(root.right, result)
            return result
        ```

        ### Pattern 2: Iterative Inorder (Stack)
        ```python
        def inorder_iterative(root):
            result, stack = [], []
            curr = root

            while curr or stack:
                # Go to leftmost node
                while curr:
                    stack.append(curr)
                    curr = curr.left

                # Process node
                curr = stack.pop()
                result.append(curr.val)

                # Move to right subtree
                curr = curr.right

            return result
        ```

        ### Pattern 3: Level Order (BFS with Queue)
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

        ### Pattern 4: Morris Traversal (O(1) Space)
        ```python
        def morris_inorder(root):
            result = []
            curr = root

            while curr:
                if not curr.left:
                    result.append(curr.val)
                    curr = curr.right
                else:
                    # Find inorder predecessor
                    pred = curr.left
                    while pred.right and pred.right != curr:
                        pred = pred.right

                    if not pred.right:
                        pred.right = curr  # Create thread
                        curr = curr.left
                    else:
                        pred.right = None  # Remove thread
                        result.append(curr.val)
                        curr = curr.right

            return result
        ```
      MARKDOWN
      when_to_use: 'Use tree traversal for: visiting all nodes, searching, copying trees, converting to arrays, finding paths, or any operation requiring systematic node visiting.',
      common_pitfalls: [
        'Stack overflow with deep recursive trees',
        'Not handling null/empty trees',
        'Confusing traversal orders',
        'Forgetting to track level in level-order traversal',
        'Modifying tree structure during traversal'
      ]
    },

    'tree-bst-operations-025' => {
      title: 'Binary Search Tree Operations',
      description: 'Efficient operations on BST including search, insert, delete',
      theory: <<~MARKDOWN,
        ## Binary Search Tree (BST)

        A BST is a binary tree where for each node:
        - All values in left subtree < node value
        - All values in right subtree > node value

        **Key Properties:**
        - Inorder traversal gives sorted sequence
        - Average case: O(log n) for search, insert, delete
        - Worst case: O(n) if tree becomes skewed

        **Operations:**
        - Search: Follow BST property to find value
        - Insert: Find correct position and add node
        - Delete: Three cases - leaf, one child, two children
        - Find Min/Max: Go leftmost/rightmost
      MARKDOWN
      patterns: <<~MARKDOWN,
        ## Common Patterns

        ### Pattern 1: BST Search
        ```python
        def search_bst(root, target):
            if not root or root.val == target:
                return root

            if target < root.val:
                return search_bst(root.left, target)
            return search_bst(root.right, target)
        ```

        ### Pattern 2: BST Insert
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

        ### Pattern 3: BST Delete
        ```python
        def delete_bst(root, key):
            if not root:
                return None

            if key < root.val:
                root.left = delete_bst(root.left, key)
            elif key > root.val:
                root.right = delete_bst(root.right, key)
            else:
                # Node to delete found
                # Case 1: Leaf or one child
                if not root.left:
                    return root.right
                if not root.right:
                    return root.left

                # Case 2: Two children
                # Find inorder successor (min in right subtree)
                successor = find_min(root.right)
                root.val = successor.val
                root.right = delete_bst(root.right, successor.val)

            return root

        def find_min(node):
            while node.left:
                node = node.left
            return node
        ```

        ### Pattern 4: Validate BST
        ```python
        def is_valid_bst(root, min_val=float('-inf'), max_val=float('inf')):
            if not root:
                return True

            if not (min_val < root.val < max_val):
                return False

            return (is_valid_bst(root.left, min_val, root.val) and
                   is_valid_bst(root.right, root.val, max_val))
        ```
      MARKDOWN
      when_to_use: 'Use BST for: maintaining sorted data with fast operations, range queries, finding closest elements, or when you need logarithmic search in dynamic data.',
      common_pitfalls: [
        'Not handling duplicate values consistently',
        'Forgetting to check BST validity',
        'Not handling edge cases in delete (leaf, one child, two children)',
        'Creating unbalanced BST (use AVL/Red-Black for balance)',
        'Not updating parent pointers if maintaining them'
      ]
    },

    'tree-trie-031' => {
      title: 'Trie (Prefix Tree)',
      description: 'Tree-based data structure for efficient string operations and prefix searches',
      theory: <<~MARKDOWN,
        ## Trie Data Structure

        A Trie (prefix tree) is a tree where each node represents a character, and paths represent strings.

        **Properties:**
        - Root represents empty string
        - Each path from root represents a prefix
        - Nodes can mark end of word

        **Operations:**
        - Insert: O(m) where m = string length
        - Search: O(m)
        - Prefix Search: O(p) where p = prefix length
        - Space: O(ALPHABET_SIZE * N * M) worst case

        **Use Cases:**
        - Autocomplete
        - Spell checker
        - IP routing
        - Dictionary implementation
      MARKDOWN
      patterns: <<~MARKDOWN,
        ## Common Patterns

        ### Pattern 1: Basic Trie Implementation
        ```python
        class TrieNode:
            def __init__(self):
                self.children = {}  # char -> TrieNode
                self.is_end_of_word = False

        class Trie:
            def __init__(self):
                self.root = TrieNode()

            def insert(self, word):
                node = self.root
                for char in word:
                    if char not in node.children:
                        node.children[char] = TrieNode()
                    node = node.children[char]
                node.is_end_of_word = True

            def search(self, word):
                node = self.root
                for char in word:
                    if char not in node.children:
                        return False
                    node = node.children[char]
                return node.is_end_of_word

            def starts_with(self, prefix):
                node = self.root
                for char in prefix:
                    if char not in node.children:
                        return False
                    node = node.children[char]
                return True
        ```

        ### Pattern 2: Word Search with Trie
        ```python
        def find_words(board, words):
            # Build trie from words
            trie = Trie()
            for word in words:
                trie.insert(word)

            result = set()

            def dfs(i, j, node, path):
                if node.is_end_of_word:
                    result.add(path)

                if (i < 0 or i >= len(board) or j < 0 or j >= len(board[0]) or
                    board[i][j] == '#'):
                    return

                char = board[i][j]
                if char not in node.children:
                    return

                board[i][j] = '#'  # Mark visited

                for di, dj in [(0,1), (1,0), (0,-1), (-1,0)]:
                    dfs(i+di, j+dj, node.children[char], path+char)

                board[i][j] = char  # Restore

            for i in range(len(board)):
                for j in range(len(board[0])):
                    dfs(i, j, trie.root, "")

            return list(result)
        ```

        ### Pattern 3: Autocomplete with Trie
        ```python
        class TrieWithSuggestions(Trie):
            def get_suggestions(self, prefix):
                node = self.root
                for char in prefix:
                    if char not in node.children:
                        return []
                    node = node.children[char]

                # DFS to collect all words with this prefix
                suggestions = []
                self._collect_words(node, prefix, suggestions)
                return suggestions

            def _collect_words(self, node, current, suggestions):
                if node.is_end_of_word:
                    suggestions.append(current)

                for char, child_node in node.children.items():
                    self._collect_words(child_node, current + char, suggestions)
        ```
      MARKDOWN
      when_to_use: 'Use Trie for: prefix matching, autocomplete, spell checking, storing dictionary, IP routing, or when you need fast prefix-based operations.',
      common_pitfalls: [
        'High memory usage with large alphabets',
        'Not handling case sensitivity correctly',
        'Forgetting to mark end of words',
        'Not cleaning up unused nodes (memory leaks)',
        'Confusing search() with startsWith()'
      ]
    },

    'linked-list-basics-011' => {
      title: 'Linked List Basics',
      description: 'Fundamental operations on singly linked lists',
      theory: <<~MARKDOWN,
        ## Linked Lists

        A linked list is a linear data structure where elements are stored in nodes. Each node contains data and a pointer to the next node.

        **Types:**
        - Singly Linked List: One pointer (next)
        - Doubly Linked List: Two pointers (next, prev)
        - Circular Linked List: Last node points to first

        **Advantages:**
        - Dynamic size
        - Efficient insertions/deletions at beginning: O(1)
        - No memory waste

        **Disadvantages:**
        - No random access: O(n) to access element
        - Extra memory for pointers
        - Not cache-friendly

        **Complexity:**
        - Access: O(n)
        - Search: O(n)
        - Insert at head: O(1)
        - Insert at position: O(n)
        - Delete: O(n)
      MARKDOWN
      patterns: <<~MARKDOWN,
        ## Common Patterns

        ### Pattern 1: Node Definition
        ```python
        class ListNode:
            def __init__(self, val=0, next=None):
                self.val = val
                self.next = next
        ```

        ### Pattern 2: Traversal
        ```python
        def traverse(head):
            current = head
            while current:
                process(current.val)
                current = current.next
        ```

        ### Pattern 3: Insert at Beginning
        ```python
        def insert_at_head(head, val):
            new_node = ListNode(val)
            new_node.next = head
            return new_node  # New head
        ```

        ### Pattern 4: Delete Node
        ```python
        def delete_node(head, val):
            # Handle deletion at head
            if head and head.val == val:
                return head.next

            current = head
            while current and current.next:
                if current.next.val == val:
                    current.next = current.next.next
                    break
                current = current.next

            return head
        ```

        ### Pattern 5: Reverse Linked List
        ```python
        def reverse_list(head):
            prev = None
            current = head

            while current:
                next_temp = current.next  # Save next
                current.next = prev        # Reverse pointer
                prev = current             # Move prev forward
                current = next_temp        # Move current forward

            return prev  # New head
        ```

        ### Pattern 6: Find Middle (Fast & Slow Pointers)
        ```python
        def find_middle(head):
            slow = fast = head

            while fast and fast.next:
                slow = slow.next
                fast = fast.next.next

            return slow  # Middle node
        ```
      MARKDOWN
      when_to_use: 'Use linked lists when: frequent insertions/deletions at beginning, size varies frequently, no random access needed, or implementing stacks/queues.',
      common_pitfalls: [
        'Losing reference to head',
        'Not handling null/empty list',
        'Not updating pointers correctly during insertion/deletion',
        'Memory leaks from not cleaning up nodes',
        'Infinite loops from incorrect pointer updates',
        'Not considering edge cases (single node, two nodes)'
      ]
    },

    'stack-basic-stack-016' => {
      title: 'Stack Basics',
      description: 'LIFO data structure with push, pop, and peek operations',
      theory: <<~MARKDOWN,
        ## Stack Data Structure

        A stack is a LIFO (Last-In-First-Out) data structure where elements are added and removed from the same end (top).

        **Core Operations:**
        - **Push:** Add element to top - O(1)
        - **Pop:** Remove element from top - O(1)
        - **Peek/Top:** View top element - O(1)
        - **isEmpty:** Check if empty - O(1)

        **Implementations:**
        - Array-based: Fixed or dynamic size
        - Linked list-based: Dynamic size

        **Applications:**
        - Function call stack
        - Undo/redo operations
        - Expression evaluation
        - Backtracking
        - Browser history
      MARKDOWN
      patterns: <<~MARKDOWN,
        ## Common Patterns

        ### Pattern 1: Array-based Stack
        ```python
        class Stack:
            def __init__(self):
                self.items = []

            def push(self, item):
                self.items.append(item)

            def pop(self):
                if not self.is_empty():
                    return self.items.pop()
                return None

            def peek(self):
                if not self.is_empty():
                    return self.items[-1]
                return None

            def is_empty(self):
                return len(self.items) == 0

            def size(self):
                return len(self.items)
        ```

        ### Pattern 2: Valid Parentheses
        ```python
        def is_valid_parentheses(s):
            stack = []
            pairs = {'(': ')', '[': ']', '{': '}'}

            for char in s:
                if char in pairs:  # Opening bracket
                    stack.append(char)
                else:  # Closing bracket
                    if not stack or pairs[stack.pop()] != char:
                        return False

            return len(stack) == 0
        ```

        ### Pattern 3: Min Stack (O(1) min operation)
        ```python
        class MinStack:
            def __init__(self):
                self.stack = []
                self.min_stack = []

            def push(self, val):
                self.stack.append(val)
                if not self.min_stack or val <= self.min_stack[-1]:
                    self.min_stack.append(val)

            def pop(self):
                if self.stack:
                    val = self.stack.pop()
                    if val == self.min_stack[-1]:
                        self.min_stack.pop()
                    return val

            def get_min(self):
                return self.min_stack[-1] if self.min_stack else None
        ```
      MARKDOWN
      when_to_use: 'Use stacks for: nested structures, parsing/evaluation, undo operations, DFS traversal, backtracking, or any LIFO access pattern.',
      common_pitfalls: [
        'Not checking if stack is empty before pop/peek',
        'Stack overflow with limited memory',
        'Using stack when queue is needed (FIFO vs LIFO)',
        'Not handling edge cases (empty stack operations)'
      ]
    },

    'heap-min-heap-052' => {
      title: 'Min Heap & Priority Queue',
      description: 'Binary heap maintaining minimum element at root for efficient priority-based operations',
      theory: <<~MARKDOWN,
        ## Min Heap Data Structure

        A min heap is a complete binary tree where each parent node is smaller than or equal to its children. The minimum element is always at the root.

        **Properties:**
        - Complete binary tree
        - Parent ≤ Children (min heap property)
        - Root contains minimum element
        - Height: O(log n)

        **Array Representation:**
        - Parent of i: (i-1)//2
        - Left child of i: 2*i + 1
        - Right child of i: 2*i + 2

        **Operations:**
        - Insert: O(log n) - Add at end, bubble up
        - Extract Min: O(log n) - Remove root, bubble down
        - Get Min: O(1) - Return root
        - Heapify: O(n) - Build heap from array

        **Applications:**
        - Priority queues
        - Dijkstra's algorithm
        - Huffman coding
        - K-way merge
        - Finding median in stream
      MARKDOWN
      patterns: <<~MARKDOWN,
        ## Common Patterns

        ### Pattern 1: Using Python's heapq (Min Heap)
        ```python
        import heapq

        # Create heap
        heap = []

        # Insert elements
        heapq.heappush(heap, 5)
        heapq.heappush(heap, 3)
        heapq.heappush(heap, 7)

        # Get minimum (peek)
        min_val = heap[0]  # O(1)

        # Extract minimum
        min_val = heapq.heappop(heap)  # O(log n)

        # Heapify existing list
        arr = [5, 3, 7, 1]
        heapq.heapify(arr)  # O(n)
        ```

        ### Pattern 2: K Smallest Elements
        ```python
        def k_smallest(arr, k):
            # Use max heap to keep k smallest
            # Negate values for max heap behavior
            heap = []

            for num in arr:
                heapq.heappush(heap, -num)
                if len(heap) > k:
                    heapq.heappop(heap)

            return [-x for x in heap]
        ```

        ### Pattern 3: Merge K Sorted Lists
        ```python
        def merge_k_sorted(lists):
            heap = []
            result = []

            # Push first element of each list
            for i, lst in enumerate(lists):
                if lst:
                    heapq.heappush(heap, (lst[0], i, 0))  # (value, list_idx, elem_idx)

            while heap:
                val, list_idx, elem_idx = heapq.heappop(heap)
                result.append(val)

                # Add next element from same list
                if elem_idx + 1 < len(lists[list_idx]):
                    next_val = lists[list_idx][elem_idx + 1]
                    heapq.heappush(heap, (next_val, list_idx, elem_idx + 1))

            return result
        ```

        ### Pattern 4: Custom Priority Queue with Objects
        ```python
        import heapq

        class Task:
            def __init__(self, priority, name):
                self.priority = priority
                self.name = name

            def __lt__(self, other):
                return self.priority < other.priority

        pq = []
        heapq.heappush(pq, Task(3, "Low priority"))
        heapq.heappush(pq, Task(1, "High priority"))

        highest_priority = heapq.heappop(pq)
        ```
      MARKDOWN
      when_to_use: 'Use min heap for: finding minimum element repeatedly, priority queue implementation, k smallest elements, merging sorted arrays, or scheduling tasks by priority.',
      common_pitfalls: [
        'Confusing min heap and max heap (Python heapq is min heap)',
        'Forgetting to negate values for max heap simulation',
        'Not maintaining heap property after modifications',
        'Trying to find k largest with min heap directly',
        'Not handling empty heap operations',
        'Comparing uncomparable objects without __lt__'
      ]
    },

    'backtrack-permutations-081' => {
      title: 'Permutations & Backtracking',
      description: 'Generating all permutations using backtracking technique',
      theory: <<~MARKDOWN,
        ## Backtracking for Permutations

        Backtracking is a general algorithmic technique for finding all (or some) solutions by incrementally building candidates and abandoning candidates ("backtracking") when they fail to satisfy constraints.

        **Permutation:** Arrangement of elements in specific order
        - n elements have n! permutations
        - Order matters: [1,2,3] ≠ [3,2,1]

        **Backtracking Process:**
        1. Choose: Make a choice
        2. Explore: Recursively explore consequences
        3. Unchoose: Backtrack and try different choice

        **Complexity:**
        - Time: O(n! × n) - n! permutations, O(n) to copy each
        - Space: O(n) for recursion stack
      MARKDOWN
      patterns: <<~MARKDOWN,
        ## Common Patterns

        ### Pattern 1: Basic Permutations
        ```python
        def permute(nums):
            result = []

            def backtrack(current, remaining):
                # Base case: no elements remaining
                if not remaining:
                    result.append(current[:])
                    return

                for i in range(len(remaining)):
                    # Choose
                    current.append(remaining[i])

                    # Explore with remaining elements
                    new_remaining = remaining[:i] + remaining[i+1:]
                    backtrack(current, new_remaining)

                    # Unchoose (backtrack)
                    current.pop()

            backtrack([], nums)
            return result
        ```

        ### Pattern 2: Permutations with Swapping
        ```python
        def permute_swap(nums):
            result = []

            def backtrack(start):
                if start == len(nums):
                    result.append(nums[:])
                    return

                for i in range(start, len(nums)):
                    # Swap
                    nums[start], nums[i] = nums[i], nums[start]

                    # Recurse
                    backtrack(start + 1)

                    # Backtrack (swap back)
                    nums[start], nums[i] = nums[i], nums[start]

            backtrack(0)
            return result
        ```

        ### Pattern 3: Permutations with Duplicates
        ```python
        def permute_unique(nums):
            result = []
            nums.sort()  # Sort to group duplicates

            def backtrack(current, used):
                if len(current) == len(nums):
                    result.append(current[:])
                    return

                for i in range(len(nums)):
                    # Skip if used or duplicate
                    if used[i]:
                        continue
                    if i > 0 and nums[i] == nums[i-1] and not used[i-1]:
                        continue

                    # Choose
                    current.append(nums[i])
                    used[i] = True

                    # Explore
                    backtrack(current, used)

                    # Unchoose
                    current.pop()
                    used[i] = False

            backtrack([], [False] * len(nums))
            return result
        ```

        ### Pattern 4: Next Permutation
        ```python
        def next_permutation(nums):
            # Find first decreasing element from right
            i = len(nums) - 2
            while i >= 0 and nums[i] >= nums[i + 1]:
                i -= 1

            if i >= 0:  # Not last permutation
                # Find element just larger than nums[i]
                j = len(nums) - 1
                while nums[j] <= nums[i]:
                    j -= 1
                nums[i], nums[j] = nums[j], nums[i]

            # Reverse suffix
            nums[i + 1:] = reversed(nums[i + 1:])
        ```
      MARKDOWN
      when_to_use: 'Use backtracking for permutations when: need all arrangements, solving constraint satisfaction, generating sequences, or exploring all possibilities with pruning.',
      common_pitfalls: [
        'Not making a copy when storing result (shallow copy issues)',
        'Forgetting to backtrack (undo choices)',
        'Not handling duplicates correctly',
        'Stack overflow with large inputs',
        'Not pruning unnecessary branches',
        'Modifying input array without restoring'
      ]
    },

    'sort-search-binary-search-059' => {
      title: 'Binary Search',
      description: 'Efficient search algorithm for sorted arrays using divide and conquer',
      theory: <<~MARKDOWN,
        ## Binary Search Algorithm

        Binary search is a divide-and-conquer algorithm that finds the position of a target value in a sorted array by repeatedly dividing the search interval in half.

        **Requirements:**
        - Array must be sorted
        - Random access to elements

        **Process:**
        1. Compare target with middle element
        2. If equal, return position
        3. If target < middle, search left half
        4. If target > middle, search right half
        5. Repeat until found or search space empty

        **Complexity:**
        - Time: O(log n) - halves search space each iteration
        - Space: O(1) iterative, O(log n) recursive

        **Variations:**
        - Find exact match
        - Find first/last occurrence
        - Find insert position
        - Find in rotated array
      MARKDOWN
      patterns: <<~MARKDOWN,
        ## Common Patterns

        ### Pattern 1: Basic Binary Search
        ```python
        def binary_search(arr, target):
            left, right = 0, len(arr) - 1

            while left <= right:
                mid = left + (right - left) // 2  # Avoid overflow

                if arr[mid] == target:
                    return mid
                elif arr[mid] < target:
                    left = mid + 1
                else:
                    right = mid - 1

            return -1  # Not found
        ```

        ### Pattern 2: Find First Occurrence
        ```python
        def find_first(arr, target):
            left, right = 0, len(arr) - 1
            result = -1

            while left <= right:
                mid = left + (right - left) // 2

                if arr[mid] == target:
                    result = mid
                    right = mid - 1  # Continue searching left
                elif arr[mid] < target:
                    left = mid + 1
                else:
                    right = mid - 1

            return result
        ```

        ### Pattern 3: Find Insert Position
        ```python
        def search_insert(arr, target):
            left, right = 0, len(arr)

            while left < right:
                mid = left + (right - left) // 2

                if arr[mid] < target:
                    left = mid + 1
                else:
                    right = mid

            return left
        ```

        ### Pattern 4: Binary Search on Answer (Minimize/Maximize)
        ```python
        def minimize_max_distance(arr, k):
            def can_place(min_dist):
                """Check if we can place k elements with min_dist apart"""
                count, last_pos = 1, arr[0]

                for i in range(1, len(arr)):
                    if arr[i] - last_pos >= min_dist:
                        count += 1
                        last_pos = arr[i]
                        if count == k:
                            return True
                return False

            left, right = 1, arr[-1] - arr[0]
            result = 0

            while left <= right:
                mid = (left + right) // 2
                if can_place(mid):
                    result = mid
                    left = mid + 1  # Try larger distance
                else:
                    right = mid - 1

            return result
        ```

        ### Pattern 5: Search in Rotated Sorted Array
        ```python
        def search_rotated(arr, target):
            left, right = 0, len(arr) - 1

            while left <= right:
                mid = (left + right) // 2

                if arr[mid] == target:
                    return mid

                # Determine which half is sorted
                if arr[left] <= arr[mid]:  # Left half sorted
                    if arr[left] <= target < arr[mid]:
                        right = mid - 1
                    else:
                        left = mid + 1
                else:  # Right half sorted
                    if arr[mid] < target <= arr[right]:
                        left = mid + 1
                    else:
                        right = mid - 1

            return -1
        ```
      MARKDOWN
      when_to_use: 'Use binary search for: searching in sorted arrays, finding boundaries, optimization problems (binary search on answer), minimizing/maximizing with monotonic functions.',
      common_pitfalls: [
        'Off-by-one errors in boundary conditions',
        'Integer overflow in mid calculation (use left + (right-left)//2)',
        'Using on unsorted arrays',
        'Wrong loop condition (left <= right vs left < right)',
        'Not considering empty array',
        'Infinite loops from incorrect boundary updates'
      ]
    }
  }

  # Concepts without custom content will get generated content
  def self.generate_microlesson(family_id, problems)
    # If we have custom content, use it
    if CONCEPT_DEFINITIONS[family_id]
      return generate_custom_microlesson(family_id, problems)
    end

    # Otherwise, generate basic microlesson from problem data
    generate_basic_microlesson(family_id, problems)
  end

  def self.generate_custom_microlesson(family_id, problems)
    definition = CONCEPT_DEFINITIONS[family_id]
    sample_problems = problems.sort_by { |p| p['difficulty'] }.take(5)

    content = <<~MARKDOWN
      # #{definition[:title]}

      #{definition[:description]}

      ---

      #{definition[:theory]}

      ---

      #{definition[:patterns]}

      ---

      ## When to Use This Technique

      #{definition[:when_to_use]}

      ---

      ## Common Pitfalls to Avoid

      #{definition[:common_pitfalls].map { |p| "- #{p}" }.join("\n")}

      ---

      ## Practice Problems

      Start with these problems to master this concept:

      #{sample_problems.map.with_index do |p, i|
        "### #{i + 1}. #{p['title']} [#{p['difficulty'].capitalize}]\n\n" +
        "#{p['description']}\n\n" +
        "**Complexity:** Time O(#{p['time_complexity']}), Space O(#{p['space_complexity']})\n\n" +
        (p['hints']&.any? ? "**Hint:** #{p['hints'].first}\n\n" : "")
      end.join("\n")}

      ---

      ## Key Takeaways

      - #{definition[:title]} is essential for #{definition[:description].downcase}
      - Time complexity improvements can be significant with this technique
      - Practice problems in order of difficulty to build intuition
      - Focus on recognizing patterns in problem statements
    MARKDOWN

    {
      family_id: family_id,
      title: definition[:title],
      content: content,
      reading_time_minutes: estimate_reading_time(content),
      key_concepts: extract_key_concepts(definition),
      problem_count: problems.length
    }
  end

  def self.generate_basic_microlesson(family_id, problems)
    # Extract info from family_id and problems
    parts = family_id.split('-')
    topic = parts[0].titleize
    concept = parts[1..-2].join(' ').titleize

    first_problem = problems.first
    sample_problems = problems.sort_by { |p| p['difficulty'] }.take(5)

    content = <<~MARKDOWN
      # #{concept}

      Master #{concept} - a key concept in #{first_problem['topic']}.

      ---

      ## Overview

      **Topic:** #{first_problem['topic']}
      **Subtopic:** #{first_problem['subtopic']}
      **Problems Available:** #{problems.length}
      **Difficulty Range:** #{problems.map { |p| p['difficulty'] }.uniq.join(', ')}

      ---

      ## What You'll Learn

      #{concept} is fundamental to solving #{first_problem['topic'].downcase} problems efficiently.
      This microlesson covers:

      - Core concepts and theory
      - Common patterns and templates
      - Time and space complexity analysis
      - Practical problem-solving techniques

      ---

      ## Key Concepts

      ### Time Complexity
      Most problems in this family: **#{problems.first['time_complexity']}**

      ### Space Complexity
      Typical space requirement: **#{problems.first['space_complexity']}**

      ### Common Tags
      #{problems.flat_map { |p| p['tags'] }.uniq.take(5).map { |t| "`#{t}`" }.join(', ')}

      ---

      ## Starter Template

      ```python
      #{problems.first['starter_code']['python']}
      ```

      ---

      ## Practice Problems

      Work through these problems in order to build mastery:

      #{sample_problems.map.with_index do |p, i|
        "### #{i + 1}. #{p['title']} [#{p['difficulty'].capitalize}]\n\n" +
        "#{p['description']}\n\n" +
        "**Time:** O(#{p['time_complexity']}), **Space:** O(#{p['space_complexity']})\n\n" +
        (p['hints']&.any? ? "**Hint:** #{p['hints'].first}\n\n" : "") +
        "**Companies:** #{p['companies']&.take(3)&.join(', ')}\n\n"
      end.join("\n")}

      ---

      ## Success Metrics

      - **Average Success Rate:** #{(problems.map { |p| p['success_rate'] }.sum / problems.length * 100).round}%
      - **Average Time:** #{(problems.map { |p| p['estimated_time_mins'] }.sum / problems.length).round} minutes per problem
      - **Total Points:** #{problems.map { |p| p['points'] }.sum} points available

      ---

      ## Next Steps

      After mastering #{concept}:

      1. Complete all #{problems.length} problems in this family
      2. Focus on optimizing your solutions
      3. Move to related concepts
      4. Practice timed problem-solving
    MARKDOWN

    {
      family_id: family_id,
      title: concept,
      content: content,
      reading_time_minutes: estimate_reading_time(content),
      key_concepts: [concept, first_problem['subtopic'], first_problem['topic']],
      problem_count: problems.length
    }
  end

  def self.estimate_reading_time(content)
    words = content.split.length
    (words / 200.0).ceil * 5  # 200 words per minute, round to 5 min intervals
  end

  def self.extract_key_concepts(definition)
    concepts = [definition[:title]]

    # Extract from common pitfalls and patterns
    if definition[:patterns] =~ /### Pattern \d+: (.+)/
      $1.split(',').each { |p| concepts << p.strip }
    end

    concepts.take(5)
  end
end

# Main execution
puts "Loading problems database..."
problems_data = JSON.parse(File.read('db/seeds/algorithms_problems.json'))
all_problems = problems_data['problems']

puts "Found #{all_problems.length} problems"

# Group problems by family
problems_by_family = all_problems.group_by { |p| p['family_id'] }

puts "Found #{problems_by_family.keys.length} families"
puts "\nGenerating microlessons..."

microlessons = []

problems_by_family.each do |family_id, problems|
  puts "  - Generating microlesson for #{family_id} (#{problems.length} problems)"
  microlesson = MicrolessonGenerator.generate_microlesson(family_id, problems)
  microlessons << microlesson
end

# Write output
output_file = 'db/seeds/generated_dsa_microlessons.json'
File.write(output_file, JSON.pretty_generate(microlessons))

puts "\n✅ Generated #{microlessons.length} microlessons"
puts "📝 Output saved to: #{output_file}"
puts "\nSummary:"
puts "  - Total families: #{problems_by_family.keys.length}"
puts "  - Total problems: #{all_problems.length}"
puts "  - Custom templates: #{MicrolessonGenerator::CONCEPT_DEFINITIONS.keys.length}"
puts "  - Auto-generated: #{microlessons.length - MicrolessonGenerator::CONCEPT_DEFINITIONS.keys.length}"
