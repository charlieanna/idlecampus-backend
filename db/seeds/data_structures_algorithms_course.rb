# Data Structures & Algorithms Course
puts "Creating Data Structures & Algorithms Course..."

dsa_course = Course.find_or_create_by!(slug: 'data-structures-algorithms') do |course|
  course.title = 'Data Structures & Algorithms'
  course.description = 'Master essential CS fundamentals for technical interviews and problem-solving'
  course.difficulty_level = 'intermediate'
  course.published = true
  course.sequence_order = 24
  course.estimated_hours = 60
  course.learning_objectives = JSON.generate([
    "Understand Big O notation and complexity analysis",
    "Implement arrays, linked lists, stacks, and queues",
    "Master trees, graphs, and hash tables",
    "Apply sorting and searching algorithms",
    "Solve problems with dynamic programming",
    "Ace technical coding interviews"
  ])
end

puts "Created course: #{dsa_course.title}"

# ==========================================
# MODULE 1: Complexity Analysis & Big O
# ==========================================

module1 = CourseModule.find_or_create_by!(slug: 'complexity-analysis', course: dsa_course) do |mod|
  mod.title = 'Complexity Analysis & Big O'
  mod.sequence_order = 1
  mod.estimated_minutes = 100
  mod.published = true
end

lesson1_1 = CourseLesson.find_or_create_by!(title: "Big O Notation") do |lesson|
  lesson.reading_time_minutes = 30
  lesson.content = <<~MARKDOWN
    # Big O Notation

    **Big O** describes the worst-case time or space complexity as input size grows.

    ## Common Complexities (Best to Worst)

    | Big O | Name | Example |
    |-------|------|---------|
    | O(1) | Constant | Array access, hash lookup |
    | O(log n) | Logarithmic | Binary search |
    | O(n) | Linear | Array traversal |
    | O(n log n) | Linearithmic | Merge sort, quick sort |
    | O(n²) | Quadratic | Nested loops, bubble sort |
    | O(2ⁿ) | Exponential | Recursive fibonacci |
    | O(n!) | Factorial | Permutations |

    ## O(1) - Constant Time

    ```python
    def get_first(arr):
        return arr[0]  # Always 1 operation

    # O(1) - regardless of array size
    ```

    ## O(n) - Linear Time

    ```python
    def find_max(arr):
        max_val = arr[0]
        for num in arr:  # n iterations
            if num > max_val:
                max_val = num
        return max_val

    # O(n) - time grows with input size
    ```

    ## O(n²) - Quadratic Time

    ```python
    def find_pairs(arr):
        pairs = []
        for i in range(len(arr)):        # n iterations
            for j in range(len(arr)):    # n iterations
                if i != j:
                    pairs.append((arr[i], arr[j]))
        return pairs

    # O(n²) - nested loops
    ```

    ## O(log n) - Logarithmic Time

    ```python
    def binary_search(arr, target):
        left, right = 0, len(arr) - 1

        while left <= right:
            mid = (left + right) // 2
            if arr[mid] == target:
                return mid
            elif arr[mid] < target:
                left = mid + 1  # Eliminate half
            else:
                right = mid - 1  # Eliminate half

        return -1

    # O(log n) - halves search space each iteration
    # 1000 items = ~10 steps, 1M items = ~20 steps
    ```

    ## Rules for Calculating Big O

    ### 1. Drop Constants

    ```python
    def example(arr):
        print(arr[0])     # O(1)
        print(arr[1])     # O(1)

        for x in arr:     # O(n)
            print(x)

    # O(1) + O(1) + O(n) = O(2 + n) → O(n)
    # Drop constants: O(n)
    ```

    ### 2. Drop Non-Dominant Terms

    ```python
    def example(arr):
        for x in arr:              # O(n)
            print(x)

        for i in arr:              # O(n²)
            for j in arr:
                print(i, j)

    # O(n) + O(n²) = O(n² + n) → O(n²)
    # Drop non-dominant: O(n²)
    ```

    ### 3. Different Inputs = Different Variables

    ```python
    def intersect(arr1, arr2):
        for a in arr1:       # O(a)
            for b in arr2:   # O(b)
                if a == b:
                    print(a, b)

    # O(a × b) NOT O(n²)
    # Different inputs!
    ```

    ## Space Complexity

    **Memory used relative to input size**

    ```python
    def example1(arr):
        total = 0              # O(1) space
        for num in arr:
            total += num
        return total
    # Space: O(1)

    def example2(arr):
        copy = arr.copy()      # O(n) space
        return copy
    # Space: O(n)

    def example3(n):
        matrix = [[0]*n for _ in range(n)]  # O(n²) space
        return matrix
    # Space: O(n²)
    ```

    ## Interview Tips

    1. **Always state assumptions**: "Assuming array is sorted..."
    2. **Start with brute force**: O(n²) solution first, then optimize
    3. **Trade space for time**: Hash tables trade O(n) space for O(1) lookups
    4. **Look for patterns**: Two pointers, sliding window, divide & conquer

    **Next**: We'll implement fundamental data structures!
  MARKDOWN
  lesson.key_concepts = ['Big O', 'time complexity', 'space complexity', 'algorithm analysis']
end

ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_1) do |item|
  item.sequence_order = 1
  item.required = true
end

# ==========================================
# MODULE 2: Arrays, Lists, Stacks & Queues
# ==========================================

module2 = CourseModule.find_or_create_by!(slug: 'linear-structures', course: dsa_course) do |mod|
  mod.title = 'Arrays, Lists, Stacks & Queues'
  mod.sequence_order = 2
  mod.estimated_minutes = 180
  mod.published = true
end

lesson2_1 = CourseLesson.find_or_create_by!(title: "Arrays and Linked Lists") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # Arrays and Linked Lists

    ## Arrays

    **Contiguous memory, fixed or dynamic size**

    ### Operations

    | Operation | Time Complexity |
    |-----------|----------------|
    | Access by index | O(1) |
    | Search | O(n) |
    | Insert at end | O(1) amortized |
    | Insert at start | O(n) |
    | Delete | O(n) |

    ```python
    # Array operations
    arr = [1, 2, 3, 4, 5]

    # Access: O(1)
    print(arr[2])  # 3

    # Search: O(n)
    def find(arr, target):
        for i, val in enumerate(arr):
            if val == target:
                return i
        return -1

    # Insert at end: O(1) amortized
    arr.append(6)

    # Insert at start: O(n) - shifts all elements
    arr.insert(0, 0)  # [0, 1, 2, 3, 4, 5, 6]

    # Delete: O(n)
    arr.pop(2)  # Remove index 2
    ```

    ### Common Array Problems

    **Two Sum Problem**

    ```python
    def two_sum(nums, target):
        seen = {}  # val -> index

        for i, num in enumerate(nums):
            complement = target - num
            if complement in seen:
                return [seen[complement], i]
            seen[num] = i

        return []

    # Time: O(n), Space: O(n)
    ```

    **Remove Duplicates (In-place)**

    ```python
    def remove_duplicates(nums):
        if not nums:
            return 0

        write_idx = 1
        for read_idx in range(1, len(nums)):
            if nums[read_idx] != nums[read_idx - 1]:
                nums[write_idx] = nums[read_idx]
                write_idx += 1

        return write_idx

    # Time: O(n), Space: O(1)
    ```

    ## Linked Lists

    **Nodes with pointers, dynamic size**

    ```python
    class ListNode:
        def __init__(self, val=0, next=None):
            self.val = val
            self.next = next
    ```

    ### Operations

    | Operation | Time Complexity |
    |-----------|----------------|
    | Access | O(n) |
    | Search | O(n) |
    | Insert at start | O(1) |
    | Insert at end | O(n) or O(1) with tail pointer |
    | Delete | O(n) |

    ```python
    class LinkedList:
        def __init__(self):
            self.head = None

        def insert_at_start(self, val):
            new_node = ListNode(val)
            new_node.next = self.head
            self.head = new_node
            # O(1)

        def insert_at_end(self, val):
            new_node = ListNode(val)

            if not self.head:
                self.head = new_node
                return

            current = self.head
            while current.next:
                current = current.next
            current.next = new_node
            # O(n)

        def delete(self, val):
            if not self.head:
                return

            if self.head.val == val:
                self.head = self.head.next
                return

            current = self.head
            while current.next:
                if current.next.val == val:
                    current.next = current.next.next
                    return
                current = current.next
            # O(n)
    ```

    ### Common Linked List Problems

    **Reverse Linked List**

    ```python
    def reverse_list(head):
        prev = None
        current = head

        while current:
            next_node = current.next
            current.next = prev
            prev = current
            current = next_node

        return prev

    # Time: O(n), Space: O(1)
    ```

    **Detect Cycle (Floyd's Algorithm)**

    ```python
    def has_cycle(head):
        slow = fast = head

        while fast and fast.next:
            slow = slow.next
            fast = fast.next.next

            if slow == fast:
                return True

        return False

    # Time: O(n), Space: O(1)
    ```

    **Merge Two Sorted Lists**

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

        current.next = l1 or l2
        return dummy.next

    # Time: O(m + n), Space: O(1)
    ```

    ## Arrays vs Linked Lists

    | Feature | Array | Linked List |
    |---------|-------|-------------|
    | Access | O(1) | O(n) |
    | Insert at start | O(n) | O(1) |
    | Insert at end | O(1) | O(n) or O(1) |
    | Memory | Contiguous | Scattered |
    | Cache locality | Better | Worse |
    | Memory overhead | Low | High (pointers) |

    **When to use:**
    - **Array**: Random access needed, memory cache important
    - **Linked List**: Frequent insertions/deletions at start

    **Next**: Stacks and Queues!
  MARKDOWN
  lesson.key_concepts = ['arrays', 'linked lists', 'two pointers', 'fast and slow pointers']
end

ModuleItem.find_or_create_by!(course_module: module2, item: lesson2_1) do |item|
  item.sequence_order = 1
  item.required = true
end

lesson2_2 = CourseLesson.find_or_create_by!(title: "Stacks and Queues") do |lesson|
  lesson.reading_time_minutes = 30
  lesson.content = <<~MARKDOWN
    # Stacks and Queues

    ## Stack (LIFO - Last In, First Out)

    **Like a stack of plates - add/remove from top**

    ```python
    class Stack:
        def __init__(self):
            self.items = []

        def push(self, item):
            self.items.append(item)  # O(1)

        def pop(self):
            if not self.is_empty():
                return self.items.pop()  # O(1)
            return None

        def peek(self):
            if not self.is_empty():
                return self.items[-1]  # O(1)
            return None

        def is_empty(self):
            return len(self.items) == 0

        def size(self):
            return len(self.items)

    # All operations: O(1)
    ```

    ### Common Stack Problems

    **Valid Parentheses**

    ```python
    def is_valid(s):
        stack = []
        mapping = {')': '(', '}': '{', ']': '['}

        for char in s:
            if char in mapping:
                top = stack.pop() if stack else '#'
                if mapping[char] != top:
                    return False
            else:
                stack.append(char)

        return len(stack) == 0

    # Time: O(n), Space: O(n)
    # Example: "({[]})" → True
    #          "({[})" → False
    ```

    **Evaluate Reverse Polish Notation**

    ```python
    def eval_rpn(tokens):
        stack = []
        operators = {'+', '-', '*', '/'}

        for token in tokens:
            if token in operators:
                b = stack.pop()
                a = stack.pop()

                if token == '+': result = a + b
                elif token == '-': result = a - b
                elif token == '*': result = a * b
                else: result = int(a / b)

                stack.append(result)
            else:
                stack.append(int(token))

        return stack[0]

    # Example: ["2", "1", "+", "3", "*"] → ((2 + 1) * 3) = 9
    ```

    ## Queue (FIFO - First In, First Out)

    **Like a line of people - add to back, remove from front**

    ```python
    from collections import deque

    class Queue:
        def __init__(self):
            self.items = deque()

        def enqueue(self, item):
            self.items.append(item)  # O(1)

        def dequeue(self):
            if not self.is_empty():
                return self.items.popleft()  # O(1)
            return None

        def front(self):
            if not self.is_empty():
                return self.items[0]  # O(1)
            return None

        def is_empty(self):
            return len(self.items) == 0

        def size(self):
            return len(self.items)

    # All operations: O(1)
    ```

    ### Common Queue Problems

    **Implement Stack using Queues**

    ```python
    from collections import deque

    class MyStack:
        def __init__(self):
            self.q = deque()

        def push(self, x):
            self.q.append(x)
            # Rotate to make last element first
            for _ in range(len(self.q) - 1):
                self.q.append(self.q.popleft())

        def pop(self):
            return self.q.popleft()

        def top(self):
            return self.q[0]
    ```

    **Sliding Window Maximum**

    ```python
    from collections import deque

    def max_sliding_window(nums, k):
        result = []
        dq = deque()  # stores indices

        for i, num in enumerate(nums):
            # Remove indices outside window
            while dq and dq[0] < i - k + 1:
                dq.popleft()

            # Remove smaller elements
            while dq and nums[dq[-1]] < num:
                dq.pop()

            dq.append(i)

            # Add to result after first window
            if i >= k - 1:
                result.append(nums[dq[0]])

        return result

    # Time: O(n), Space: O(k)
    # Example: nums = [1,3,-1,-3,5,3,6,7], k = 3
    # Output: [3,3,5,5,6,7]
    ```

    ## Real-World Applications

    ### Stack
    - **Browser history** (back button)
    - **Undo/Redo** functionality
    - **Function call stack**
    - **Expression evaluation**
    - **Backtracking algorithms**

    ### Queue
    - **Task scheduling**
    - **Breadth-First Search (BFS)**
    - **Print spooler**
    - **Request handling** in web servers
    - **Message queues** (RabbitMQ, Kafka)

    **Next**: Trees and Graphs!
  MARKDOWN
  lesson.key_concepts = ['stack', 'queue', 'LIFO', 'FIFO', 'deque']
end

ModuleItem.find_or_create_by!(course_module: module2, item: lesson2_2) do |item|
  item.sequence_order = 2
  item.required = true
end

# ==========================================
# MODULE 3: Trees & Graphs
# ==========================================

module3 = CourseModule.find_or_create_by!(slug: 'trees-graphs', course: dsa_course) do |mod|
  mod.title = 'Trees & Graphs'
  mod.sequence_order = 3
  mod.estimated_minutes = 200
  mod.published = true
end

lesson3_1 = CourseLesson.find_or_create_by!(title: "Binary Trees and BST") do |lesson|
  lesson.reading_time_minutes = 40
  lesson.content = <<~MARKDOWN
    # Binary Trees and Binary Search Trees

    ## Binary Tree

    **Each node has at most 2 children**

    ```python
    class TreeNode:
        def __init__(self, val=0, left=None, right=None):
            self.val = val
            self.left = left
            self.right = right
    ```

    ### Tree Traversals

    **In-Order (Left → Root → Right)**

    ```python
    def inorder(root):
        if not root:
            return []
        return inorder(root.left) + [root.val] + inorder(root.right)

    # For BST, returns sorted order!
    # Time: O(n), Space: O(h) where h = height
    ```

    **Pre-Order (Root → Left → Right)**

    ```python
    def preorder(root):
        if not root:
            return []
        return [root.val] + preorder(root.left) + preorder(root.right)

    # Good for copying tree structure
    ```

    **Post-Order (Left → Right → Root)**

    ```python
    def postorder(root):
        if not root:
            return []
        return postorder(root.left) + postorder(root.right) + [root.val]

    # Good for deleting tree (delete children first)
    ```

    **Level-Order (BFS)**

    ```python
    from collections import deque

    def level_order(root):
        if not root:
            return []

        result = []
        queue = deque([root])

        while queue:
            level = []
            for _ in range(len(queue)):
                node = queue.popleft()
                level.append(node.val)

                if node.left:
                    queue.append(node.left)
                if node.right:
                    queue.append(node.right)

            result.append(level)

        return result

    # Time: O(n), Space: O(w) where w = max width
    ```

    ## Binary Search Tree (BST)

    **Left subtree < Root < Right subtree**

    ```python
    class BST:
        def __init__(self):
            self.root = None

        def insert(self, val):
            self.root = self._insert(self.root, val)

        def _insert(self, node, val):
            if not node:
                return TreeNode(val)

            if val < node.val:
                node.left = self._insert(node.left, val)
            else:
                node.right = self._insert(node.right, val)

            return node

        def search(self, val):
            return self._search(self.root, val)

        def _search(self, node, val):
            if not node or node.val == val:
                return node

            if val < node.val:
                return self._search(node.left, val)
            return self._search(node.right, val)

        # Time: O(h) average O(log n), worst O(n)
    ```

    ### Common Tree Problems

    **Maximum Depth**

    ```python
    def max_depth(root):
        if not root:
            return 0

        left_depth = max_depth(root.left)
        right_depth = max_depth(root.right)

        return 1 + max(left_depth, right_depth)

    # Time: O(n), Space: O(h)
    ```

    **Validate BST**

    ```python
    def is_valid_bst(root):
        def validate(node, min_val, max_val):
            if not node:
                return True

            if not (min_val < node.val < max_val):
                return False

            return (validate(node.left, min_val, node.val) and
                    validate(node.right, node.val, max_val))

        return validate(root, float('-inf'), float('inf'))

    # Time: O(n), Space: O(h)
    ```

    **Lowest Common Ancestor**

    ```python
    def lowest_common_ancestor(root, p, q):
        if not root or root == p or root == q:
            return root

        left = lowest_common_ancestor(root.left, p, q)
        right = lowest_common_ancestor(root.right, p, q)

        if left and right:
            return root

        return left or right

    # Time: O(n), Space: O(h)
    ```

    **Serialize and Deserialize**

    ```python
    def serialize(root):
        def dfs(node):
            if not node:
                vals.append('#')
                return
            vals.append(str(node.val))
            dfs(node.left)
            dfs(node.right)

        vals = []
        dfs(root)
        return ','.join(vals)

    def deserialize(data):
        def dfs():
            val = next(vals)
            if val == '#':
                return None
            node = TreeNode(int(val))
            node.left = dfs()
            node.right = dfs()
            return node

        vals = iter(data.split(','))
        return dfs()
    ```

    ## Tree Properties

    - **Complete Binary Tree**: All levels filled except last, filled left to right
    - **Full Binary Tree**: Every node has 0 or 2 children
    - **Perfect Binary Tree**: All internal nodes have 2 children, all leaves same level
    - **Balanced Tree**: Height difference of subtrees ≤ 1

    **Height of balanced tree**: O(log n)
    **Height of unbalanced tree**: O(n)

    **Next**: Graphs and Graph Algorithms!
  MARKDOWN
  lesson.key_concepts = ['binary tree', 'BST', 'tree traversal', 'recursion', 'DFS', 'BFS']
end

ModuleItem.find_or_create_by!(course_module: module3, item: lesson3_1) do |item|
  item.sequence_order = 1
  item.required = true
end

# ==========================================
# MODULE 4: Sorting & Searching
# ==========================================

module4 = CourseModule.find_or_create_by!(slug: 'sorting-searching', course: dsa_course) do |mod|
  mod.title = 'Sorting & Searching Algorithms'
  mod.sequence_order = 4
  mod.estimated_minutes = 150
  mod.published = true
end

lesson4_1 = CourseLesson.find_or_create_by!(title: "Sorting Algorithms") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # Sorting Algorithms

    ## Comparison of Sorting Algorithms

    | Algorithm | Time (Best) | Time (Avg) | Time (Worst) | Space | Stable |
    |-----------|-------------|------------|--------------|-------|--------|
    | Bubble Sort | O(n) | O(n²) | O(n²) | O(1) | Yes |
    | Selection Sort | O(n²) | O(n²) | O(n²) | O(1) | No |
    | Insertion Sort | O(n) | O(n²) | O(n²) | O(1) | Yes |
    | Merge Sort | O(n log n) | O(n log n) | O(n log n) | O(n) | Yes |
    | Quick Sort | O(n log n) | O(n log n) | O(n²) | O(log n) | No |
    | Heap Sort | O(n log n) | O(n log n) | O(n log n) | O(1) | No |

    ## Quick Sort

    **Divide and conquer, pick pivot, partition**

    ```python
    def quick_sort(arr):
        if len(arr) <= 1:
            return arr

        pivot = arr[len(arr) // 2]
        left = [x for x in arr if x < pivot]
        middle = [x for x in arr if x == pivot]
        right = [x for x in arr if x > pivot]

        return quick_sort(left) + middle + quick_sort(right)

    # Average: O(n log n), Worst: O(n²)
    # Space: O(log n) for recursion
    ```

    **In-place Quick Sort**

    ```python
    def quick_sort_inplace(arr, low=0, high=None):
        if high is None:
            high = len(arr) - 1

        if low < high:
            pi = partition(arr, low, high)
            quick_sort_inplace(arr, low, pi - 1)
            quick_sort_inplace(arr, pi + 1, high)

        return arr

    def partition(arr, low, high):
        pivot = arr[high]
        i = low - 1

        for j in range(low, high):
            if arr[j] <= pivot:
                i += 1
                arr[i], arr[j] = arr[j], arr[i]

        arr[i + 1], arr[high] = arr[high], arr[i + 1]
        return i + 1
    ```

    ## Merge Sort

    **Divide and conquer, always O(n log n)**

    ```python
    def merge_sort(arr):
        if len(arr) <= 1:
            return arr

        mid = len(arr) // 2
        left = merge_sort(arr[:mid])
        right = merge_sort(arr[mid:])

        return merge(left, right)

    def merge(left, right):
        result = []
        i = j = 0

        while i < len(left) and j < len(right):
            if left[i] <= right[j]:
                result.append(left[i])
                i += 1
            else:
                result.append(right[j])
                j += 1

        result.extend(left[i:])
        result.extend(right[j:])
        return result

    # Time: O(n log n), Space: O(n)
    # Stable sort!
    ```

    ## Binary Search

    **Search in sorted array**

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

        return -1

    # Time: O(log n), Space: O(1)
    ```

    **Binary Search Variations**

    ```python
    # Find first occurrence
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

    # Find insertion position
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

    ## Interview Tips

    1. **Always ask if input is sorted** - enables binary search
    2. **For small datasets**: Simple sorts (insertion) are fine
    3. **For large datasets**: Use O(n log n) sorts
    4. **Need stable sort?** Use merge sort or insertion sort
    5. **Limited memory?** Use in-place sorts (quick sort, heap sort)

    **Next**: Dynamic Programming!
  MARKDOWN
  lesson.key_concepts = ['sorting', 'quick sort', 'merge sort', 'binary search', 'divide and conquer']
end

ModuleItem.find_or_create_by!(course_module: module4, item: lesson4_1) do |item|
  item.sequence_order = 1
  item.required = true
end

# ==========================================
# MODULE 5: Dynamic Programming
# ==========================================

module5 = CourseModule.find_or_create_by!(slug: 'dynamic-programming', course: dsa_course) do |mod|
  mod.title = 'Dynamic Programming'
  mod.sequence_order = 5
  mod.estimated_minutes = 170
  mod.published = true
end

lesson5_1 = CourseLesson.find_or_create_by!(title: "Dynamic Programming Fundamentals") do |lesson|
  lesson.reading_time_minutes = 40
  lesson.content = <<~MARKDOWN
    # Dynamic Programming Fundamentals

    **DP = Recursion + Memoization (or Tabulation)**

    ## When to Use DP

    1. **Optimal Substructure**: Solution can be built from subproblems
    2. **Overlapping Subproblems**: Same subproblems solved multiple times

    ## Fibonacci Example

    ### Naive Recursion: O(2ⁿ)

    ```python
    def fib(n):
        if n <= 1:
            return n
        return fib(n-1) + fib(n-2)

    # fib(5) calls fib(3) twice, fib(2) three times!
    # Exponential time!
    ```

    ### Memoization (Top-Down): O(n)

    ```python
    def fib_memo(n, memo=None):
        if memo is None:
            memo = {}

        if n in memo:
            return memo[n]

        if n <= 1:
            return n

        memo[n] = fib_memo(n-1, memo) + fib_memo(n-2, memo)
        return memo[n]

    # Time: O(n), Space: O(n)
    ```

    ### Tabulation (Bottom-Up): O(n)

    ```python
    def fib_tab(n):
        if n <= 1:
            return n

        dp = [0] * (n + 1)
        dp[1] = 1

        for i in range(2, n + 1):
            dp[i] = dp[i-1] + dp[i-2]

        return dp[n]

    # Time: O(n), Space: O(n)
    ```

    ### Space-Optimized: O(1)

    ```python
    def fib_optimized(n):
        if n <= 1:
            return n

        prev, curr = 0, 1
        for _ in range(2, n + 1):
            prev, curr = curr, prev + curr

        return curr

    # Time: O(n), Space: O(1)
    ```

    ## Classic DP Problems

    ### Climbing Stairs

    ```python
    def climb_stairs(n):
        if n <= 2:
            return n

        dp = [0] * (n + 1)
        dp[1], dp[2] = 1, 2

        for i in range(3, n + 1):
            dp[i] = dp[i-1] + dp[i-2]

        return dp[n]

    # Can take 1 or 2 steps at a time
    # How many ways to reach step n?
    # Time: O(n), Space: O(n)
    ```

    ### Coin Change

    ```python
    def coin_change(coins, amount):
        dp = [float('inf')] * (amount + 1)
        dp[0] = 0

        for i in range(1, amount + 1):
            for coin in coins:
                if i >= coin:
                    dp[i] = min(dp[i], dp[i - coin] + 1)

        return dp[amount] if dp[amount] != float('inf') else -1

    # Example: coins = [1,2,5], amount = 11
    # Output: 3 (5+5+1)
    # Time: O(amount × coins), Space: O(amount)
    ```

    ### Longest Common Subsequence

    ```python
    def longest_common_subsequence(text1, text2):
        m, n = len(text1), len(text2)
        dp = [[0] * (n + 1) for _ in range(m + 1)]

        for i in range(1, m + 1):
            for j in range(1, n + 1):
                if text1[i-1] == text2[j-1]:
                    dp[i][j] = dp[i-1][j-1] + 1
                else:
                    dp[i][j] = max(dp[i-1][j], dp[i][j-1])

        return dp[m][n]

    # Example: "abcde", "ace" → 3
    # Time: O(m×n), Space: O(m×n)
    ```

    ### 0/1 Knapsack

    ```python
    def knapsack(weights, values, capacity):
        n = len(weights)
        dp = [[0] * (capacity + 1) for _ in range(n + 1)]

        for i in range(1, n + 1):
            for w in range(1, capacity + 1):
                if weights[i-1] <= w:
                    # Max of: take item or don't take item
                    dp[i][w] = max(
                        values[i-1] + dp[i-1][w - weights[i-1]],
                        dp[i-1][w]
                    )
                else:
                    dp[i][w] = dp[i-1][w]

        return dp[n][capacity]

    # Time: O(n×capacity), Space: O(n×capacity)
    ```

    ### House Robber

    ```python
    def rob(nums):
        if not nums:
            return 0
        if len(nums) == 1:
            return nums[0]

        dp = [0] * len(nums)
        dp[0] = nums[0]
        dp[1] = max(nums[0], nums[1])

        for i in range(2, len(nums)):
            # Max of: rob current + skip adjacent, or skip current
            dp[i] = max(nums[i] + dp[i-2], dp[i-1])

        return dp[-1]

    # Can't rob adjacent houses
    # Time: O(n), Space: O(n)
    ```

    ## DP Pattern Recognition

    ### 1D DP
    - Fibonacci, Climbing Stairs, House Robber
    - Usually involves making decision at each step

    ### 2D DP
    - Longest Common Subsequence, Edit Distance, Knapsack
    - Usually involves two sequences or constraints

    ### DP on Strings
    - LCS, Edit Distance, Palindrome Partitioning
    - Build solution character by character

    ### DP on Trees
    - Maximum Path Sum, Diameter of Binary Tree
    - Solve for subtrees first

    ## DP Approach

    1. **Define dp state**: What does dp[i] represent?
    2. **Find recurrence relation**: dp[i] = function(dp[i-1], dp[i-2], ...)
    3. **Initialize base cases**: dp[0], dp[1]
    4. **Determine iteration order**: Usually bottom-up
    5. **Return final answer**: Usually dp[n]

    ## Interview Tips

    1. Start with brute force recursion
    2. Identify overlapping subproblems
    3. Add memoization (top-down)
    4. Convert to tabulation if needed (bottom-up)
    5. Optimize space if possible

    **Practice makes perfect with DP!**
  MARKDOWN
  lesson.key_concepts = ['dynamic programming', 'memoization', 'tabulation', 'optimal substructure', 'overlapping subproblems']
end

ModuleItem.find_or_create_by!(course_module: module5, item: lesson5_1) do |item|
  item.sequence_order = 1
  item.required = true
end

puts "\n✅ Data Structures & Algorithms Course Created!"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
puts "📚 Course: #{dsa_course.title}"
puts "📖 Modules: #{dsa_course.course_modules.count}"
puts "📝 Comprehensive lessons covering interview essentials"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
