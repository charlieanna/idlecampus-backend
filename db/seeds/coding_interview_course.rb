# Coding Interview Preparation Course Seed Data
# This creates a comprehensive coding interview course with adaptive learning

puts "Creating Coding Interview Course..."

# Create the main course
coding_course = Course.find_or_create_by!(slug: 'coding-interview-mastery') do |course|
  course.title = 'Coding Interview Mastery'
  course.description = 'Master algorithmic problem-solving and data structures for technical interviews. This course covers essential patterns and techniques used in coding interviews at top tech companies.'
  course.difficulty_level = 'intermediate'
  course.certification_track = 'none'
  course.published = true
  course.sequence_order = 8
  course.estimated_hours = 25
  course.learning_objectives = JSON.generate([
    'Solve array and string manipulation problems efficiently',
    'Master two-pointer and sliding window techniques',
    'Implement tree and graph traversal algorithms',
    'Apply dynamic programming to optimization problems',
    'Analyze time and space complexity',
    'Recognize and apply common problem-solving patterns'
  ])
end

# Module 1: Arrays & Hashing
module1 = CourseModule.find_or_create_by!(slug: 'arrays-hashing', course: coding_course) do |mod|
  mod.title = 'Arrays & Hashing'
  mod.description = 'Master fundamental array operations and hash table techniques'
  mod.sequence_order = 1
  mod.estimated_minutes = 180
  mod.published = true
end

# Module 1 Lessons
lesson1_1 = CourseLesson.find_or_create_by!(title: "Array Fundamentals & Hash Tables") do |lesson|
  lesson.reading_time_minutes = 20
  lesson.content = <<~MARKDOWN
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
  lesson.key_concepts = ['arrays', 'hash tables', 'two pointers', 'sliding window', 'time complexity']
end

lesson1_2 = CourseLesson.find_or_create_by!(title: "Common Array Patterns") do |lesson|
  lesson.reading_time_minutes = 15
  lesson.content = <<~MARKDOWN
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
  lesson.key_concepts = ['frequency counter', 'multiple pointers', 'prefix sum', 'kadanes algorithm']
end

# Module 1 Quiz
quiz1 = Quiz.find_or_create_by!(title: "Arrays & Hashing Assessment") do |quiz|
  quiz.description = 'Test your understanding of array and hash table techniques'
  quiz.time_limit_minutes = 15
  quiz.passing_score = 70
  quiz.quiz_type = 'standard'
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

# Module 1 Quiz Questions with Adaptive Parameters
QuizQuestion.find_or_create_by!(quiz: quiz1, sequence_order: 1) do |q|
  q.question_text = "What is the time complexity of accessing an element by index in an array?"
  q.question_type = "mcq"
  q.points = 5
  q.options = ["O(1)", "O(n)", "O(log n)", "O(n²)"]
  q.correct_answer = "O(1)"
  q.explanation = "Arrays provide constant-time access to elements by index because the memory address can be calculated directly."
  q.difficulty = -1.0  # Easy
  q.discrimination = 1.0
  q.guessing = 0.25
  q.skill_dimension = 'coding_arrays'
  q.topic = 'arrays'
end

QuizQuestion.find_or_create_by!(quiz: quiz1, sequence_order: 2) do |q|
  q.question_text = "Which data structure would be most efficient for checking if an element exists in a collection?"
  q.question_type = "mcq"
  q.points = 5
  q.options = ["Array", "Hash Set", "Linked List", "Stack"]
  q.correct_answer = "Hash Set"
  q.explanation = "Hash Sets provide O(1) average-case lookup time, making them ideal for existence checks."
  q.difficulty = -0.5  # Easy-Medium
  q.discrimination = 1.2
  q.guessing = 0.25
  q.skill_dimension = 'coding_arrays'
  q.topic = 'hash_tables'
end

QuizQuestion.find_or_create_by!(quiz: quiz1, sequence_order: 3) do |q|
  q.question_text = "In the Two Sum problem, why is using a hash map more efficient than nested loops?"
  q.question_type = "mcq"
  q.points = 5
  q.options = [
    "It reduces time complexity from O(n²) to O(n)",
    "It uses less memory",
    "It's easier to implement",
    "It works with unsorted arrays only"
  ]
  q.correct_answer = "It reduces time complexity from O(n²) to O(n)"
  q.explanation = "A hash map allows us to check for the complement in O(1) time, reducing overall complexity from O(n²) to O(n)."
  q.difficulty = 0.0  # Medium
  q.discrimination = 1.5
  q.guessing = 0.25
  q.skill_dimension = 'coding_arrays'
  q.topic = 'optimization'
end

QuizQuestion.find_or_create_by!(quiz: quiz1, sequence_order: 4) do |q|
  q.question_text = "What is the space complexity of the sliding window technique for finding maximum sum subarray?"
  q.question_type = "mcq"
  q.points = 5
  q.options = ["O(1)", "O(k)", "O(n)", "O(n²)"]
  q.correct_answer = "O(1)"
  q.explanation = "Sliding window only needs to track the current window sum, requiring constant extra space."
  q.difficulty = 0.5  # Medium-Hard
  q.discrimination = 1.6
  q.guessing = 0.25
  q.skill_dimension = 'coding_arrays'
  q.topic = 'space_complexity'
end

QuizQuestion.find_or_create_by!(quiz: quiz1, sequence_order: 5) do |q|
  q.question_text = "Which technique would you use to find all triplets in an array that sum to zero?"
  q.question_type = "mcq"
  q.points = 5
  q.options = [
    "Single pointer",
    "Two pointers after sorting",
    "Sliding window",
    "Binary search only"
  ]
  q.correct_answer = "Two pointers after sorting"
  q.explanation = "Sort the array, fix one element, then use two pointers to find pairs that sum to the negative of the fixed element."
  q.difficulty = 1.0  # Hard
  q.discrimination = 1.8
  q.guessing = 0.25
  q.skill_dimension = 'coding_arrays'
  q.topic = 'two_pointers'
end

# Module 1 Labs
lab1_1 = HandsOnLab.find_or_create_by!(title: "Two Sum") do |lab|
  lab.description = "Given an array of integers and a target sum, return indices of two numbers that add up to the target."
  lab.lab_type = 'python'
  lab.lab_format = 'code_editor'
  lab.programming_language = 'python'
  lab.difficulty = 'easy'
  lab.starter_code = <<~CODE
    def two_sum(nums, target):
        """
        Given an array of integers nums and an integer target,
        return indices of the two numbers that add up to target.

        You may assume that each input has exactly one solution,
        and you may not use the same element twice.

        Example:
        Input: nums = [2,7,11,15], target = 9
        Output: [0,1]
        Explanation: nums[0] + nums[1] = 2 + 7 = 9
        """
        # Your code here
        pass
  CODE
  lab.solution_code = <<~CODE
    def two_sum(nums, target):
        seen = {}
        for i, num in enumerate(nums):
            complement = target - num
            if complement in seen:
                return [seen[complement], i]
            seen[num] = i
        return []
  CODE
  lab.test_cases = [
    {input: "[2,7,11,15], 9", expected_output: "[0,1]", hidden: false},
    {input: "[3,2,4], 6", expected_output: "[1,2]", hidden: false},
    {input: "[3,3], 6", expected_output: "[0,1]", hidden: true},
    {input: "[-1,-2,-3,-4,-5], -8", expected_output: "[2,4]", hidden: true}
  ]
  lab.estimated_minutes = 15
  lab.points_reward = 10
  # Instructions:"Implement the two_sum function using a hash map for O(n) time complexity."
end

lab1_2 = HandsOnLab.find_or_create_by!(title: "Valid Anagram") do |lab|
  lab.description = "Determine if two strings are anagrams of each other."
  lab.lab_type = 'python'
  lab.lab_format = 'code_editor'
  lab.programming_language = 'python'
  lab.difficulty = 'easy'
  lab.starter_code = <<~CODE
    def is_anagram(s, t):
        """
        Given two strings s and t, return true if t is an anagram of s.

        An anagram is a word formed by rearranging the letters of another word,
        using all the original letters exactly once.

        Example:
        Input: s = "anagram", t = "nagaram"
        Output: true
        """
        # Your code here
        pass
  CODE
  lab.solution_code = <<~CODE
    def is_anagram(s, t):
        if len(s) != len(t):
            return False

        count = {}
        for char in s:
            count[char] = count.get(char, 0) + 1

        for char in t:
            if char not in count:
                return False
            count[char] -= 1
            if count[char] < 0:
                return False

        return True
  CODE
  lab.test_cases = [
    {input: '"anagram", "nagaram"', expected_output: "true", hidden: false},
    {input: '"rat", "car"', expected_output: "false", hidden: false},
    {input: '"a", "a"', expected_output: "true", hidden: true},
    {input: '"ab", "ba"', expected_output: "true", hidden: true}
  ]
  lab.estimated_minutes = 10
  lab.points_reward = 10
  # Instructions:"Use a hash map to count character frequencies."
end

lab1_3 = HandsOnLab.find_or_create_by!(title: "Group Anagrams") do |lab|
  lab.description = "Group an array of strings by their anagrams."
  lab.lab_type = 'python'
  lab.lab_format = 'code_editor'
  lab.programming_language = 'python'
  lab.difficulty = 'medium'
  lab.starter_code = <<~CODE
    def group_anagrams(strs):
        """
        Given an array of strings, group the anagrams together.

        Example:
        Input: strs = ["eat","tea","tan","ate","nat","bat"]
        Output: [["bat"],["nat","tan"],["ate","eat","tea"]]

        Note: Order of groups and strings within groups doesn't matter.
        """
        # Your code here
        pass
  CODE
  lab.solution_code = <<~CODE
    def group_anagrams(strs):
        from collections import defaultdict
        groups = defaultdict(list)

        for s in strs:
            # Sort the string to use as key
            key = ''.join(sorted(s))
            groups[key].append(s)

        return list(groups.values())
  CODE
  lab.test_cases = [
    {input: '["eat","tea","tan","ate","nat","bat"]', expected_output: '[["bat"],["nat","tan"],["ate","eat","tea"]]', hidden: false},
    {input: '[""]', expected_output: '[[""]]', hidden: false},
    {input: '["a"]', expected_output: '[["a"]]', hidden: true}
  ]
  lab.estimated_minutes = 20
  lab.points_reward = 15
  # Instructions:"Use sorted strings as keys in a hash map to group anagrams."
end

# Link Module 1 items
ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_2, sequence_order: 2)
ModuleItem.find_or_create_by!(course_module: module1, item: quiz1, sequence_order: 3)
ModuleItem.find_or_create_by!(course_module: module1, item: lab1_1, sequence_order: 4)
ModuleItem.find_or_create_by!(course_module: module1, item: lab1_2, sequence_order: 5)
ModuleItem.find_or_create_by!(course_module: module1, item: lab1_3, sequence_order: 6)

# Module 2: Trees & Graphs
module2 = CourseModule.find_or_create_by!(slug: 'trees-graphs', course: coding_course) do |mod|
  mod.title = 'Trees & Graphs'
  mod.description = 'Master tree traversals and graph algorithms'
  mod.sequence_order = 2
  mod.estimated_minutes = 240
  mod.published = true
end

# Module 2 Lessons
lesson2_1 = CourseLesson.find_or_create_by!(title: "Binary Tree Fundamentals") do |lesson|
  lesson.reading_time_minutes = 20
  lesson.content = <<~MARKDOWN
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
  lesson.key_concepts = ['binary tree', 'tree traversal', 'DFS', 'BFS', 'BST']
end

lesson2_2 = CourseLesson.find_or_create_by!(title: "Graph Algorithms") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
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
  lesson.key_concepts = ['graphs', 'DFS', 'BFS', 'cycle detection', 'topological sort']
end

# Module 2 Quiz
quiz2 = Quiz.find_or_create_by!(title: "Trees & Graphs Assessment") do |quiz|
  quiz.description = 'Test your understanding of tree and graph algorithms'
  quiz.time_limit_minutes = 20
  quiz.passing_score = 70
  quiz.quiz_type = 'standard'
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

# Module 2 Quiz Questions
QuizQuestion.find_or_create_by!(quiz: quiz2, sequence_order: 1) do |q|
  q.question_text = "What traversal order gives sorted values for a Binary Search Tree?"
  q.question_type = "mcq"
  q.points = 5
  q.options = ["Preorder", "Inorder", "Postorder", "Level-order"]
  q.correct_answer = "Inorder"
  q.explanation = "Inorder traversal (left, root, right) visits nodes in ascending order for a BST."
  q.difficulty = -0.5
  q.discrimination = 1.2
  q.guessing = 0.25
  q.skill_dimension = 'coding_trees'
  q.topic = 'tree_traversal'
end

QuizQuestion.find_or_create_by!(quiz: quiz2, sequence_order: 2) do |q|
  q.question_text = "Which data structure is typically used for BFS implementation?"
  q.question_type = "mcq"
  q.points = 5
  q.options = ["Stack", "Queue", "Heap", "Hash Table"]
  q.correct_answer = "Queue"
  q.explanation = "BFS explores nodes level by level, which requires FIFO ordering provided by a queue."
  q.difficulty = -1.0
  q.discrimination = 1.0
  q.guessing = 0.25
  q.skill_dimension = 'coding_graphs'
  q.topic = 'graph_traversal'
end

QuizQuestion.find_or_create_by!(quiz: quiz2, sequence_order: 3) do |q|
  q.question_text = "What is the time complexity of DFS on a graph with V vertices and E edges?"
  q.question_type = "mcq"
  q.points = 5
  q.options = ["O(V)", "O(E)", "O(V + E)", "O(V × E)"]
  q.correct_answer = "O(V + E)"
  q.explanation = "DFS visits each vertex once and examines each edge once, resulting in O(V + E) time."
  q.difficulty = 0.0
  q.discrimination = 1.5
  q.guessing = 0.25
  q.skill_dimension = 'coding_graphs'
  q.topic = 'complexity_analysis'
end

QuizQuestion.find_or_create_by!(quiz: quiz2, sequence_order: 4) do |q|
  q.question_text = "Which algorithm is best for detecting cycles in a directed graph?"
  q.question_type = "mcq"
  q.points = 5
  q.options = [
    "BFS only",
    "DFS with color marking",
    "Union-Find",
    "Dijkstra's algorithm"
  ]
  q.correct_answer = "DFS with color marking"
  q.explanation = "DFS with three colors (white, gray, black) efficiently detects cycles in directed graphs."
  q.difficulty = 1.0
  q.discrimination = 1.8
  q.guessing = 0.25
  q.skill_dimension = 'coding_graphs'
  q.topic = 'cycle_detection'
end

QuizQuestion.find_or_create_by!(quiz: quiz2, sequence_order: 5) do |q|
  q.question_text = "What is the height of a balanced binary tree with n nodes?"
  q.question_type = "mcq"
  q.points = 5
  q.options = ["O(n)", "O(log n)", "O(√n)", "O(1)"]
  q.correct_answer = "O(log n)"
  q.explanation = "A balanced binary tree maintains height of O(log n) by ensuring subtrees differ by at most 1 level."
  q.difficulty = 0.5
  q.discrimination = 1.6
  q.guessing = 0.25
  q.skill_dimension = 'coding_trees'
  q.topic = 'tree_properties'
end

# Module 2 Labs
lab2_1 = HandsOnLab.find_or_create_by!(title: "Maximum Depth of Binary Tree") do |lab|
  lab.description = "Find the maximum depth of a binary tree."
  lab.lab_type = 'python'
  lab.lab_format = 'code_editor'
  lab.programming_language = 'python'
  lab.difficulty = 'easy'
  lab.starter_code = <<~CODE
    class TreeNode:
        def __init__(self, val=0, left=None, right=None):
            self.val = val
            self.left = left
            self.right = right

    def max_depth(root):
        """
        Given the root of a binary tree, return its maximum depth.

        The maximum depth is the number of nodes along the longest path
        from the root node down to the farthest leaf node.

        Example:
        Input: root = [3,9,20,null,null,15,7]
        Output: 3
        """
        # Your code here
        pass
  CODE
  lab.solution_code = <<~CODE
    def max_depth(root):
        if not root:
            return 0

        left_depth = max_depth(root.left)
        right_depth = max_depth(root.right)

        return 1 + max(left_depth, right_depth)
  CODE
  lab.test_cases = [
    {input: "[3,9,20,null,null,15,7]", expected_output: "3", hidden: false},
    {input: "[1,null,2]", expected_output: "2", hidden: false},
    {input: "[]", expected_output: "0", hidden: true},
    {input: "[0]", expected_output: "1", hidden: true}
  ]
  lab.estimated_minutes = 10
  lab.points_reward = 10
  # Instructions:"Use recursion to find the maximum depth of left and right subtrees."
end

lab2_2 = HandsOnLab.find_or_create_by!(title: "Validate Binary Search Tree") do |lab|
  lab.description = "Determine if a binary tree is a valid BST."
  lab.lab_type = 'python'
  lab.lab_format = 'code_editor'
  lab.programming_language = 'python'
  lab.difficulty = 'medium'
  lab.starter_code = <<~CODE
    class TreeNode:
        def __init__(self, val=0, left=None, right=None):
            self.val = val
            self.left = left
            self.right = right

    def is_valid_bst(root):
        """
        Given the root of a binary tree, determine if it is a valid BST.

        A valid BST has:
        - Left subtree contains only nodes with values less than root
        - Right subtree contains only nodes with values greater than root
        - Both subtrees are also valid BSTs

        Example:
        Input: root = [2,1,3]
        Output: true
        """
        # Your code here
        pass
  CODE
  lab.solution_code = <<~CODE
    def is_valid_bst(root):
        def validate(node, min_val, max_val):
            if not node:
                return True

            if node.val <= min_val or node.val >= max_val:
                return False

            return (validate(node.left, min_val, node.val) and
                    validate(node.right, node.val, max_val))

        return validate(root, float('-inf'), float('inf'))
  CODE
  lab.test_cases = [
    {input: "[2,1,3]", expected_output: "true", hidden: false},
    {input: "[5,1,4,null,null,3,6]", expected_output: "false", hidden: false},
    {input: "[1]", expected_output: "true", hidden: true}
  ]
  lab.estimated_minutes = 20
  lab.points_reward = 15
  # Instructions:"Use recursion with min/max boundaries to validate BST property."
end

# Link Module 2 items
ModuleItem.find_or_create_by!(course_module: module2, item: lesson2_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module2, item: lesson2_2, sequence_order: 2)
ModuleItem.find_or_create_by!(course_module: module2, item: quiz2, sequence_order: 3)
ModuleItem.find_or_create_by!(course_module: module2, item: lab2_1, sequence_order: 4)
ModuleItem.find_or_create_by!(course_module: module2, item: lab2_2, sequence_order: 5)

# Module 3: Dynamic Programming
module3 = CourseModule.find_or_create_by!(slug: 'dynamic-programming', course: coding_course) do |mod|
  mod.title = 'Dynamic Programming'
  mod.description = 'Master dynamic programming patterns and optimization techniques'
  mod.sequence_order = 3
  mod.estimated_minutes = 180
  mod.published = true
end

# Module 3 Lessons
lesson3_1 = CourseLesson.find_or_create_by!(title: "Introduction to Dynamic Programming") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
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
  lesson.key_concepts = ['dynamic programming', 'memoization', 'tabulation', 'optimal substructure', 'overlapping subproblems']
end

# Module 3 Quiz
quiz3 = Quiz.find_or_create_by!(title: "Dynamic Programming Assessment") do |quiz|
  quiz.description = 'Test your understanding of dynamic programming concepts'
  quiz.time_limit_minutes = 15
  quiz.passing_score = 70
  quiz.quiz_type = 'standard'
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

# Module 3 Quiz Questions
QuizQuestion.find_or_create_by!(quiz: quiz3, sequence_order: 1) do |q|
  q.question_text = "What are the two key properties a problem must have for dynamic programming to be applicable?"
  q.question_type = "mcq"
  q.points = 5
  q.options = [
    "Recursion and iteration",
    "Optimal substructure and overlapping subproblems",
    "Sorting and searching",
    "Divide and conquer"
  ]
  q.correct_answer = "Optimal substructure and overlapping subproblems"
  q.explanation = "DP requires that optimal solutions contain optimal solutions to subproblems, and that subproblems repeat."
  q.difficulty = -0.5
  q.discrimination = 1.2
  q.guessing = 0.25
  q.skill_dimension = 'coding_dp'
  q.topic = 'dp_fundamentals'
end

QuizQuestion.find_or_create_by!(quiz: quiz3, sequence_order: 2) do |q|
  q.question_text = "What is the time complexity of the bottom-up Fibonacci solution using dynamic programming?"
  q.question_type = "mcq"
  q.points = 5
  q.options = ["O(2^n)", "O(n²)", "O(n)", "O(log n)"]
  q.correct_answer = "O(n)"
  q.explanation = "Bottom-up DP computes each Fibonacci number exactly once, resulting in O(n) time complexity."
  q.difficulty = 0.0
  q.discrimination = 1.5
  q.guessing = 0.25
  q.skill_dimension = 'coding_dp'
  q.topic = 'complexity_analysis'
end

QuizQuestion.find_or_create_by!(quiz: quiz3, sequence_order: 3) do |q|
  q.question_text = "In the Coin Change problem, what does dp[i] represent?"
  q.question_type = "mcq"
  q.points = 5
  q.options = [
    "Number of ways to make amount i",
    "Minimum coins needed for amount i",
    "Maximum coins that fit in amount i",
    "The i-th coin denomination"
  ]
  q.correct_answer = "Minimum coins needed for amount i"
  q.explanation = "In Coin Change, dp[i] stores the minimum number of coins needed to make amount i."
  q.difficulty = 0.5
  q.discrimination = 1.6
  q.guessing = 0.25
  q.skill_dimension = 'coding_dp'
  q.topic = 'dp_state_definition'
end

QuizQuestion.find_or_create_by!(quiz: quiz3, sequence_order: 4) do |q|
  q.question_text = "Which approach typically uses less memory: top-down memoization or bottom-up tabulation?"
  q.question_type = "mcq"
  q.points = 5
  q.options = [
    "Top-down memoization",
    "Bottom-up tabulation",
    "They use the same amount",
    "It depends on the problem"
  ]
  q.correct_answer = "It depends on the problem"
  q.explanation = "Memory usage varies: memoization only stores computed states, while tabulation can often be space-optimized with rolling arrays."
  q.difficulty = 1.0
  q.discrimination = 1.8
  q.guessing = 0.25
  q.skill_dimension = 'coding_dp'
  q.topic = 'dp_optimization'
end

# Module 3 Labs
lab3_1 = HandsOnLab.find_or_create_by!(title: "Climbing Stairs") do |lab|
  lab.description = "Count the number of distinct ways to climb stairs."
  lab.lab_type = 'python'
  lab.lab_format = 'code_editor'
  lab.programming_language = 'python'
  lab.difficulty = 'easy'
  lab.starter_code = <<~CODE
    def climb_stairs(n):
        """
        You are climbing a staircase. It takes n steps to reach the top.
        Each time you can climb 1 or 2 steps.
        Return the number of distinct ways to climb to the top.

        Example:
        Input: n = 3
        Output: 3
        Explanation: There are 3 ways to climb:
        1. 1 step + 1 step + 1 step
        2. 1 step + 2 steps
        3. 2 steps + 1 step
        """
        # Your code here
        pass
  CODE
  lab.solution_code = <<~CODE
    def climb_stairs(n):
        if n <= 2:
            return n

        prev2, prev1 = 1, 2

        for i in range(3, n + 1):
            current = prev1 + prev2
            prev2, prev1 = prev1, current

        return prev1
  CODE
  lab.test_cases = [
    {input: "2", expected_output: "2", hidden: false},
    {input: "3", expected_output: "3", hidden: false},
    {input: "4", expected_output: "5", hidden: true},
    {input: "5", expected_output: "8", hidden: true}
  ]
  lab.estimated_minutes = 15
  lab.points_reward = 10
  # Instructions:"Use dynamic programming to count ways. This is essentially the Fibonacci sequence."
end

lab3_2 = HandsOnLab.find_or_create_by!(title: "House Robber") do |lab|
  lab.description = "Maximize money robbed without robbing adjacent houses."
  lab.lab_type = 'python'
  lab.lab_format = 'code_editor'
  lab.programming_language = 'python'
  lab.difficulty = 'medium'
  lab.starter_code = <<~CODE
    def rob(nums):
        """
        You are a robber planning to rob houses along a street.
        Each house has money, but you cannot rob adjacent houses.
        Return the maximum amount of money you can rob.

        Example:
        Input: nums = [2,7,9,3,1]
        Output: 12
        Explanation: Rob house 0 (money = 2), house 2 (money = 9),
                     and house 4 (money = 1). Total = 2 + 9 + 1 = 12
        """
        # Your code here
        pass
  CODE
  lab.solution_code = <<~CODE
    def rob(nums):
        if not nums:
            return 0
        if len(nums) == 1:
            return nums[0]

        prev2 = nums[0]
        prev1 = max(nums[0], nums[1])

        for i in range(2, len(nums)):
            current = max(prev1, prev2 + nums[i])
            prev2, prev1 = prev1, current

        return prev1
  CODE
  lab.test_cases = [
    {input: "[1,2,3,1]", expected_output: "4", hidden: false},
    {input: "[2,7,9,3,1]", expected_output: "12", hidden: false},
    {input: "[2,1,1,2]", expected_output: "4", hidden: true}
  ]
  lab.estimated_minutes = 20
  lab.points_reward = 15
  # Instructions:"Use DP to track maximum money at each house, considering the constraint."
end

# Link Module 3 items
ModuleItem.find_or_create_by!(course_module: module3, item: lesson3_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module3, item: quiz3, sequence_order: 2)
ModuleItem.find_or_create_by!(course_module: module3, item: lab3_1, sequence_order: 3)
ModuleItem.find_or_create_by!(course_module: module3, item: lab3_2, sequence_order: 4)

# Module 4: Linked Lists
module4 = CourseModule.find_or_create_by!(slug: 'linked-lists', course: coding_course) do |mod|
  mod.title = 'Linked Lists'
  mod.description = 'Master linked list manipulation and common patterns'
  mod.sequence_order = 4
  mod.estimated_minutes = 150
  mod.published = true
end

# Module 4 Lessons
lesson4_1 = CourseLesson.find_or_create_by!(title: "Linked List Fundamentals") do |lesson|
  lesson.reading_time_minutes = 20
  lesson.content = <<~MARKDOWN
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
  lesson.key_concepts = ['linked lists', 'two pointers', 'reversal', 'cycle detection', 'dummy node']
end

# Module 4 Quiz
quiz4 = Quiz.find_or_create_by!(title: "Linked Lists Assessment") do |quiz|
  quiz.description = 'Test your understanding of linked list operations'
  quiz.time_limit_minutes = 15
  quiz.passing_score = 70
  quiz.quiz_type = 'standard'
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

# Module 4 Quiz Questions
QuizQuestion.find_or_create_by!(quiz: quiz4, sequence_order: 1) do |q|
  q.question_text = "What is the time complexity of inserting at the beginning of a linked list?"
  q.question_type = "mcq"
  q.points = 5
  q.options = ["O(1)", "O(n)", "O(log n)", "O(n²)"]
  q.correct_answer = "O(1)"
  q.explanation = "Inserting at the beginning only requires updating the head pointer, which is a constant-time operation."
  q.difficulty = -1.0
  q.discrimination = 1.0
  q.guessing = 0.25
  q.skill_dimension = 'coding_linked_lists'
  q.topic = 'linked_list_operations'
end

QuizQuestion.find_or_create_by!(quiz: quiz4, sequence_order: 2) do |q|
  q.question_text = "Which technique is used to find the middle of a linked list in one pass?"
  q.question_type = "mcq"
  q.points = 5
  q.options = [
    "Single pointer",
    "Fast and slow pointers",
    "Stack",
    "Recursion"
  ]
  q.correct_answer = "Fast and slow pointers"
  q.explanation = "Fast pointer moves twice as fast as slow pointer. When fast reaches end, slow is at middle."
  q.difficulty = 0.0
  q.discrimination = 1.5
  q.guessing = 0.25
  q.skill_dimension = 'coding_linked_lists'
  q.topic = 'two_pointers'
end

QuizQuestion.find_or_create_by!(quiz: quiz4, sequence_order: 3) do |q|
  q.question_text = "What is the purpose of using a dummy node in linked list problems?"
  q.question_type = "mcq"
  q.points = 5
  q.options = [
    "To store extra data",
    "To simplify edge cases at the head",
    "To improve time complexity",
    "To detect cycles"
  ]
  q.correct_answer = "To simplify edge cases at the head"
  q.explanation = "Dummy nodes eliminate special handling for operations at the head of the list."
  q.difficulty = 0.5
  q.discrimination = 1.6
  q.guessing = 0.25
  q.skill_dimension = 'coding_linked_lists'
  q.topic = 'linked_list_patterns'
end

# Module 4 Labs
lab4_1 = HandsOnLab.find_or_create_by!(title: "Reverse Linked List") do |lab|
  lab.description = "Reverse a singly linked list."
  lab.lab_type = 'python'
  lab.lab_format = 'code_editor'
  lab.programming_language = 'python'
  lab.difficulty = 'easy'
  lab.starter_code = <<~CODE
    class ListNode:
        def __init__(self, val=0, next=None):
            self.val = val
            self.next = next

    def reverse_list(head):
        """
        Given the head of a singly linked list, reverse the list
        and return the reversed list.

        Example:
        Input: head = [1,2,3,4,5]
        Output: [5,4,3,2,1]
        """
        # Your code here
        pass
  CODE
  lab.solution_code = <<~CODE
    def reverse_list(head):
        prev = None
        current = head

        while current:
            next_temp = current.next
            current.next = prev
            prev = current
            current = next_temp

        return prev
  CODE
  lab.test_cases = [
    {input: "[1,2,3,4,5]", expected_output: "[5,4,3,2,1]", hidden: false},
    {input: "[1,2]", expected_output: "[2,1]", hidden: false},
    {input: "[]", expected_output: "[]", hidden: true}
  ]
  lab.estimated_minutes = 15
  lab.points_reward = 10
  # Instructions:"Use three pointers to reverse the links between nodes."
end

lab4_2 = HandsOnLab.find_or_create_by!(title: "Merge Two Sorted Lists") do |lab|
  lab.description = "Merge two sorted linked lists into one sorted list."
  lab.lab_type = 'python'
  lab.lab_format = 'code_editor'
  lab.programming_language = 'python'
  lab.difficulty = 'easy'
  lab.starter_code = <<~CODE
    class ListNode:
        def __init__(self, val=0, next=None):
            self.val = val
            self.next = next

    def merge_two_lists(l1, l2):
        """
        Merge two sorted linked lists and return it as a sorted list.

        Example:
        Input: l1 = [1,2,4], l2 = [1,3,4]
        Output: [1,1,2,3,4,4]
        """
        # Your code here
        pass
  CODE
  lab.solution_code = <<~CODE
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
  CODE
  lab.test_cases = [
    {input: "[1,2,4], [1,3,4]", expected_output: "[1,1,2,3,4,4]", hidden: false},
    {input: "[], []", expected_output: "[]", hidden: false},
    {input: "[], [0]", expected_output: "[0]", hidden: true}
  ]
  lab.estimated_minutes = 15
  lab.points_reward = 10
  # Instructions:"Use a dummy node and compare values from both lists."
end

# Link Module 4 items
ModuleItem.find_or_create_by!(course_module: module4, item: lesson4_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module4, item: quiz4, sequence_order: 2)
ModuleItem.find_or_create_by!(course_module: module4, item: lab4_1, sequence_order: 3)
ModuleItem.find_or_create_by!(course_module: module4, item: lab4_2, sequence_order: 4)

# Module 5: Problem-Solving Strategies
module5 = CourseModule.find_or_create_by!(slug: 'problem-solving-strategies', course: coding_course) do |mod|
  mod.title = 'Problem-Solving Strategies'
  mod.description = 'Learn systematic approaches to tackle coding interview problems'
  mod.sequence_order = 5
  mod.estimated_minutes = 120
  mod.published = true
end

# Module 5 Lessons
lesson5_1 = CourseLesson.find_or_create_by!(title: "Interview Problem-Solving Framework") do |lesson|
  lesson.reading_time_minutes = 15
  lesson.content = <<~MARKDOWN
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
  lesson.key_concepts = ['UMPIRE method', 'problem patterns', 'complexity analysis', 'interview strategy']
end

# Module 5 Quiz
quiz5 = Quiz.find_or_create_by!(title: "Problem-Solving Strategies Assessment") do |quiz|
  quiz.description = 'Test your understanding of problem-solving approaches'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
  quiz.quiz_type = 'standard'
  quiz.max_attempts = 3
  quiz.shuffle_questions = true
end

# Module 5 Quiz Questions
QuizQuestion.find_or_create_by!(quiz: quiz5, sequence_order: 1) do |q|
  q.question_text = "What does the 'M' in UMPIRE stand for?"
  q.question_type = "mcq"
  q.points = 5
  q.options = ["Memorize", "Match", "Measure", "Modify"]
  q.correct_answer = "Match"
  q.explanation = "Match means identifying the problem pattern and matching it to known algorithms."
  q.difficulty = -1.0
  q.discrimination = 1.0
  q.guessing = 0.25
  q.skill_dimension = 'coding_strategies'
  q.topic = 'problem_solving'
end

QuizQuestion.find_or_create_by!(quiz: quiz5, sequence_order: 2) do |q|
  q.question_text = "Which pattern would you use to find the longest substring without repeating characters?"
  q.question_type = "mcq"
  q.points = 5
  q.options = [
    "Two pointers",
    "Sliding window",
    "Fast & slow pointers",
    "Merge intervals"
  ]
  q.correct_answer = "Sliding window"
  q.explanation = "Sliding window is ideal for finding optimal subarrays or substrings with specific properties."
  q.difficulty = 0.5
  q.discrimination = 1.6
  q.guessing = 0.25
  q.skill_dimension = 'coding_strategies'
  q.topic = 'pattern_recognition'
end

QuizQuestion.find_or_create_by!(quiz: quiz5, sequence_order: 3) do |q|
  q.question_text = "What is the time complexity of merge sort?"
  q.question_type = "mcq"
  q.points = 5
  q.options = ["O(n)", "O(n log n)", "O(n²)", "O(2^n)"]
  q.correct_answer = "O(n log n)"
  q.explanation = "Merge sort divides the array in half log n times and merges in O(n) time at each level."
  q.difficulty = 0.0
  q.discrimination = 1.5
  q.guessing = 0.25
  q.skill_dimension = 'coding_strategies'
  q.topic = 'complexity_analysis'
end

# Link Module 5 items
ModuleItem.find_or_create_by!(course_module: module5, item: lesson5_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module5, item: quiz5, sequence_order: 2)

puts "Coding Interview Course created successfully!"
puts "- #{coding_course.course_modules.count} modules"
puts "- #{CourseLesson.joins(module_items: :course_module).where(course_modules: {course_id: coding_course.id}).distinct.count} lessons"
puts "- #{Quiz.joins(module_items: :course_module).where(course_modules: {course_id: coding_course.id}).distinct.count} quizzes"
puts "- #{QuizQuestion.joins(quiz: {module_items: :course_module}).where(course_modules: {course_id: coding_course.id}).count} quiz questions"
puts "- #{HandsOnLab.joins(module_items: :course_module).where(course_modules: {course_id: coding_course.id}).distinct.count} coding labs"