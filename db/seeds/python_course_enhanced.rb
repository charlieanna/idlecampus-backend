# Python Programming Course - Complete Edition with Quizzes and Reviews
puts "Creating Enhanced Python Programming Course..."

# Create Python Course
python_course = Course.find_or_create_by!(slug: 'python-fundamentals') do |course|
  course.title = 'Python Programming Fundamentals'
  course.description = 'Learn Python from scratch with interactive lessons, quizzes, labs, and spaced repetition reviews'
  course.difficulty_level = 'beginner'
  course.certification_track = nil
  course.published = true
  course.sequence_order = 1
  course.estimated_hours = 40
  course.learning_objectives = JSON.generate([
    "Master Python syntax, variables, and data types",
    "Write programs using control flow and loops",
    "Work with functions, classes, and OOP",
    "Handle files and exceptions properly",
    "Build real-world Python applications"
  ])
end

puts "Created course: #{python_course.title}"

# ==========================================
# MODULE 1: Python Basics
# ==========================================

module1 = CourseModule.find_or_create_by!(slug: 'python-basics', course: python_course) do |mod|
  mod.title = 'Python Basics'
  mod.description = 'Start your Python journey: variables, types, and basic operations'
  mod.sequence_order = 1
  mod.estimated_minutes = 60
  mod.published = true
end

# Lesson 1.1: Hello Python
lesson1_1 = CourseLesson.find_or_create_by!(title: "Hello, Python!") do |lesson|
  lesson.reading_time_minutes = 20
  lesson.content = File.read(File.join(__dir__, '../../../app/assets/lessons/python/hello_python.md')) rescue <<~MARKDOWN
    # Hello, Python!

    Welcome to Python! Python is one of the most popular programming languages, known for its simplicity and readability.

    ## Your First Program

    ```python
    print("Hello, World!")
    ```

    That's it! Just one line. The `print()` function displays text on the screen.

    ## Variables and Data Types

    ```python
    # Variables
    name = "Alice"
    age = 25
    height = 5.6
    is_student = True

    # Strings
    greeting = "Hello"
    message = 'Python is awesome!'

    # Numbers
    count = 42  # Integer
    price = 19.99  # Float

    # Booleans
    is_active = True
    is_valid = False
    ```

    ## Basic Operations

    ```python
    # Arithmetic
    x = 10 + 5  # 15
    y = 10 - 3  # 7
    z = 4 * 3   # 12
    w = 15 / 3  # 5.0

    # String operations
    full_name = "John" + " " + "Doe"
    repeated = "ha" * 3  # "hahaha"
    ```

    ## Comments

    ```python
    # This is a single-line comment

    """
    This is a
    multi-line comment
    """
    ```

    ## Input and Output

    ```python
    name = input("What is your name? ")
    print(f"Hello, {name}!")
    ```

    **Practice:** Try the exercises in the Python Basics lab!
  MARKDOWN
  lesson.key_concepts = ['print', 'variables', 'data types', 'strings', 'numbers', 'booleans', 'input']
end

# Quiz 1.1: Python Basics
quiz1_1 = Quiz.find_or_create_by!(title: "Python Basics Quiz") do |quiz|
  quiz.description = 'Test your understanding of Python fundamentals'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
end

# Quiz Questions for Module 1
[
  {
    question_text: "What does the print() function do in Python?",
    question_type: "mcq",
    points: 5,
    options: ["Displays output to the console", "Saves data to a file", "Creates a new variable", "Compiles the program"],
    correct_answer: "Displays output to the console",
    explanation: "The print() function displays text and other data to the console/terminal."
  },
  {
    question_text: "Which of these is a valid variable name in Python?",
    question_type: "mcq",
    points: 5,
    options: ["user_age", "2users", "user-name", "class"],
    correct_answer: "user_age",
    explanation: "Variable names must start with a letter or underscore, and cannot use hyphens or reserved keywords."
  },
  {
    question_text: "What is the result of: 'Python' + ' ' + 'rocks'?",
    question_type: "fill_blank",
    points: 5,
    correct_answer: "Python rocks",
    explanation: "The + operator concatenates (joins) strings together."
  },
  {
    question_text: "What type is the value True in Python?",
    question_type: "mcq",
    points: 5,
    options: ["boolean", "string", "integer", "float"],
    correct_answer: "boolean",
    explanation: "True and False are boolean values in Python."
  },
  {
    question_text: "Which function gets user input in Python?",
    question_type: "mcq",
    points: 5,
    options: ["input()", "get()", "read()", "scan()"],
    correct_answer: "input()",
    explanation: "input() prompts the user for input and returns it as a string."
  },
  {
    question_text: "What does this code output?\n\nage = '25'\nprint(type(age))",
    question_type: "mcq",
    points: 5,
    options: ["<class 'str'>", "<class 'int'>", "25", "string"],
    correct_answer: "<class 'str'>",
    explanation: "The variable 'age' is a string because it's enclosed in quotes."
  },
  {
    question_text: "How do you convert the string '42' to an integer?",
    question_type: "mcq",
    points: 5,
    options: ["int('42')", "str('42')", "float('42')", "num('42')"],
    correct_answer: "int('42')",
    explanation: "int() converts a string to an integer."
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz1_1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer]
    question.explanation = q_data[:explanation]
  end
end

# ==========================================
# MODULE 2: Control Flow
# ==========================================

module2 = CourseModule.find_or_create_by!(slug: 'control-flow', course: python_course) do |mod|
  mod.title = 'Control Flow'
  mod.description = 'Make decisions and repeat actions with if statements and loops'
  mod.sequence_order = 2
  mod.estimated_minutes = 70
  mod.published = true
end

# Lesson 2.1: If Statements (existing content preserved)
lesson2_1 = CourseLesson.find_or_create_by!(title: "If Statements & Conditions") do |lesson|
  lesson.reading_time_minutes = 20
  lesson.content = <<~MARKDOWN
    # If Statements & Conditions

    **If statements** let your program make decisions based on conditions.

    ## Basic If Statement

    ```python
    age = 18
    if age >= 18:
        print("You are an adult")
    ```

    ## If-Else

    ```python
    temperature = 25
    if temperature > 30:
        print("It's hot outside!")
    else:
        print("It's not too hot")
    ```

    ## If-Elif-Else

    ```python
    score = 85
    if score >= 90:
        grade = "A"
    elif score >= 80:
        grade = "B"
    elif score >= 70:
        grade = "C"
    else:
        grade = "F"
    print(f"Your grade is: {grade}")
    ```

    ## Comparison Operators

    - `==` Equal to
    - `!=` Not equal to
    - `>` Greater than
    - `<` Less than
    - `>=` Greater than or equal
    - `<=` Less than or equal

    ## Logical Operators

    ### AND - Both must be True
    ```python
    age = 25
    has_license = True
    if age >= 18 and has_license:
        print("You can drive")
    ```

    ### OR - At least one must be True
    ```python
    is_weekend = True
    is_holiday = False
    if is_weekend or is_holiday:
        print("You can relax!")
    ```

    ### NOT - Inverts the condition
    ```python
    is_raining = False
    if not is_raining:
        print("You don't need an umbrella")
    ```

    ## Ternary Operator

    ```python
    age = 20
    status = "adult" if age >= 18 else "minor"
    ```

    **Practice:** Try the Control Flow lab to master if statements!
  MARKDOWN
  lesson.key_concepts = ['if statements', 'elif', 'else', 'comparison operators', 'logical operators']
end

# Lesson 2.2: Loops (NEW)
lesson2_2 = CourseLesson.find_or_create_by!(title: "Loops: For and While") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
    # Loops: For and While

    **Loops** let you repeat code multiple times automatically.

    ## For Loops

    ### Loop through a range
    ```python
    for i in range(5):
        print(i)
    # Output: 0, 1, 2, 3, 4
    ```

    ### Loop through a list
    ```python
    fruits = ["apple", "banana", "cherry"]
    for fruit in fruits:
        print(fruit)
    ```

    ### Loop with index using enumerate
    ```python
    for index, fruit in enumerate(fruits):
        print(f"{index}: {fruit}")
    # Output:
    # 0: apple
    # 1: banana
    # 2: cherry
    ```

    ### Range with start, stop, step
    ```python
    for i in range(1, 10, 2):
        print(i)
    # Output: 1, 3, 5, 7, 9
    ```

    ## While Loops

    Loop while a condition is true:

    ```python
    count = 0
    while count < 5:
        print(count)
        count += 1
    ```

    ### Infinite loop with break
    ```python
    while True:
        answer = input("Type 'quit' to exit: ")
        if answer == 'quit':
            break
        print(f"You typed: {answer}")
    ```

    ## Loop Control Statements

    ### Break - Exit the loop
    ```python
    for i in range(10):
        if i == 5:
            break
        print(i)
    # Output: 0, 1, 2, 3, 4
    ```

    ### Continue - Skip to next iteration
    ```python
    for i in range(5):
        if i == 2:
            continue
        print(i)
    # Output: 0, 1, 3, 4
    ```

    ### Else clause
    ```python
    for i in range(5):
        print(i)
    else:
        print("Loop completed!")
    # The else runs if loop wasn't broken
    ```

    ## Nested Loops

    ```python
    for i in range(3):
        for j in range(3):
            print(f"i={i}, j={j}")
    ```

    ## Common Patterns

    ### Sum of numbers
    ```python
    total = 0
    for i in range(1, 11):
        total += i
    print(total)  # 55
    ```

    ### Finding in a list
    ```python
    numbers = [10, 20, 30, 40, 50]
    found = False
    for num in numbers:
        if num == 30:
            found = True
            break
    ```

    ### Countdown
    ```python
    for i in range(10, 0, -1):
        print(i)
    print("Blast off!")
    ```

    **Practice:** Try the Loops lab to master iteration!
  MARKDOWN
  lesson.key_concepts = ['for loops', 'while loops', 'range', 'break', 'continue', 'enumerate']
end

# Quiz 2.1: Control Flow
quiz2_1 = Quiz.find_or_create_by!(title: "Control Flow Quiz") do |quiz|
  quiz.description = 'Test your knowledge of if statements and loops'
  quiz.time_limit_minutes = 12
  quiz.passing_score = 70
end

# Quiz Questions for Module 2
[
  {
    question_text: "What will this code print?\n\nx = 10\nif x > 5:\n    print('Big')\nelse:\n    print('Small')",
    question_type: "mcq",
    points: 5,
    options: ["Big", "Small", "10", "Error"],
    correct_answer: "Big",
    explanation: "Since x (10) is greater than 5, the if block executes and prints 'Big'."
  },
  {
    question_text: "How many times will this loop run?\n\nfor i in range(3):\n    print(i)",
    question_type: "mcq",
    points: 5,
    options: ["3", "2", "4", "Infinite"],
    correct_answer: "3",
    explanation: "range(3) generates 0, 1, 2 - three numbers."
  },
  {
    question_text: "What does 'break' do in a loop?",
    question_type: "mcq",
    points: 5,
    options: ["Exits the loop immediately", "Skips to the next iteration", "Pauses the loop", "Restarts the loop"],
    correct_answer: "Exits the loop immediately",
    explanation: "break terminates the loop completely."
  },
  {
    question_text: "What is the output of:\n\nfor i in range(5):\n    if i == 2:\n        continue\n    print(i)",
    question_type: "fill_blank",
    points: 5,
    correct_answer: "0134",
    explanation: "continue skips the iteration when i is 2, so 2 is not printed."
  },
  {
    question_text: "Which operator checks if two values are NOT equal?",
    question_type: "mcq",
    points: 5,
    options: ["!=", "==", "<>", "not"],
    correct_answer: "!=",
    explanation: "!= is the 'not equal to' operator in Python."
  },
  {
    question_text: "What does 'and' require in Python?",
    question_type: "mcq",
    points: 5,
    options: ["Both conditions to be True", "At least one condition to be True", "Both conditions to be False", "No conditions"],
    correct_answer: "Both conditions to be True",
    explanation: "'and' returns True only if both conditions are True."
  },
  {
    question_text: "What is the result of: True or False?",
    question_type: "mcq",
    points: 5,
    options: ["True", "False", "Error", "None"],
    correct_answer: "True",
    explanation: "'or' returns True if at least one operand is True."
  },
  {
    question_text: "How do you create a while loop that runs forever?",
    question_type: "mcq",
    points: 5,
    options: ["while True:", "while 1:", "while False:", "for i in range():"],
    correct_answer: "while True:",
    explanation: "while True: creates an infinite loop since True is always True."
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz2_1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer]
    question.explanation = q_data[:explanation]
  end
end

# ==========================================
# MODULE 3: Lists & Data Structures
# ==========================================

module3 = CourseModule.find_or_create_by!(slug: 'lists-data-structures', course: python_course) do |mod|
  mod.title = 'Lists & Data Structures'
  mod.description = 'Work with collections: lists, dictionaries, tuples, and sets'
  mod.sequence_order = 3
  mod.estimated_minutes = 80
  mod.published = true
end

# Lesson 3.1: Lists (existing content preserved)
lesson3_1 = CourseLesson.find_or_create_by!(title: "Python Lists") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
    # Python Lists

    **Lists** are ordered, mutable collections that can hold multiple items.

    ## Creating Lists

    ```python
    numbers = [1, 2, 3, 4, 5]
    fruits = ["apple", "banana", "cherry"]
    mixed = [1, "hello", 3.14, True]
    empty = []
    ```

    ## Accessing Items

    ```python
    fruits = ["apple", "banana", "cherry"]
    print(fruits[0])   # "apple"
    print(fruits[-1])  # "cherry" (last item)
    ```

    ## Slicing

    ```python
    numbers = [0, 1, 2, 3, 4, 5]
    print(numbers[2:5])   # [2, 3, 4]
    print(numbers[:3])    # [0, 1, 2]
    print(numbers[::2])   # [0, 2, 4]
    ```

    ## Modifying Lists

    ```python
    fruits = ["apple", "banana"]
    fruits.append("cherry")      # Add to end
    fruits.insert(1, "orange")   # Insert at index
    fruits.remove("banana")      # Remove by value
    last = fruits.pop()          # Remove and return last
    ```

    ## List Methods

    ```python
    numbers = [3, 1, 4, 1, 5, 9]
    numbers.sort()         # Sort in place
    numbers.reverse()      # Reverse in place
    numbers.count(1)       # Count occurrences
    numbers.index(4)       # Find index
    len(numbers)           # Length
    min(numbers)           # Minimum
    max(numbers)           # Maximum
    sum(numbers)           # Sum
    ```

    ## List Comprehensions

    Create lists concisely:

    ```python
    # Traditional way
    squares = []
    for x in range(10):
        squares.append(x ** 2)

    # List comprehension
    squares = [x ** 2 for x in range(10)]

    # With condition
    evens = [x for x in range(20) if x % 2 == 0]
    ```

    ## Looping Through Lists

    ```python
    fruits = ["apple", "banana", "cherry"]

    # Loop through values
    for fruit in fruits:
        print(fruit)

    # Loop with index
    for i, fruit in enumerate(fruits):
        print(f"{i}: {fruit}")
    ```

    **Practice:** Try the List Comprehensions lab!
  MARKDOWN
  lesson.key_concepts = ['lists', 'indexing', 'slicing', 'list methods', 'list comprehensions']
end

# Lesson 3.2: Dictionaries (NEW)
lesson3_2 = CourseLesson.find_or_create_by!(title: "Dictionaries & Key-Value Pairs") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
    # Dictionaries & Key-Value Pairs

    **Dictionaries** store data as key-value pairs. They're fast for lookups!

    ## Creating Dictionaries

    ```python
    # Empty dictionary
    person = {}

    # With initial data
    person = {
        "name": "Alice",
        "age": 25,
        "city": "New York"
    }

    # Using dict()
    person = dict(name="Alice", age=25)
    ```

    ## Accessing Values

    ```python
    person = {"name": "Alice", "age": 25}

    # By key
    print(person["name"])  # "Alice"

    # Using get() (safer, returns None if not found)
    print(person.get("name"))  # "Alice"
    print(person.get("email"))  # None
    print(person.get("email", "N/A"))  # "N/A" (default)
    ```

    ## Modifying Dictionaries

    ```python
    person = {"name": "Alice"}

    # Add/update
    person["age"] = 25
    person["name"] = "Bob"  # Updates existing

    # Remove
    del person["age"]
    age = person.pop("age", 0)  # Remove and return
    ```

    ## Dictionary Methods

    ```python
    person = {"name": "Alice", "age": 25, "city": "NYC"}

    # Get all keys
    keys = person.keys()  # dict_keys(['name', 'age', 'city'])

    # Get all values
    values = person.values()  # dict_values(['Alice', 25, 'NYC'])

    # Get key-value pairs
    items = person.items()  # dict_items([('name', 'Alice'), ...])

    # Check if key exists
    if "name" in person:
        print("Name exists!")

    # Clear all items
    person.clear()
    ```

    ## Looping Through Dictionaries

    ```python
    person = {"name": "Alice", "age": 25, "city": "NYC"}

    # Loop through keys
    for key in person:
        print(key)

    # Loop through values
    for value in person.values():
        print(value)

    # Loop through key-value pairs
    for key, value in person.items():
        print(f"{key}: {value}")
    ```

    ## Nested Dictionaries

    ```python
    users = {
        "user1": {"name": "Alice", "age": 25},
        "user2": {"name": "Bob", "age": 30}
    }

    print(users["user1"]["name"])  # "Alice"
    ```

    ## Dictionary Comprehension

    ```python
    # Create dictionary from lists
    keys = ['a', 'b', 'c']
    values = [1, 2, 3]
    d = {k: v for k, v in zip(keys, values)}
    # {'a': 1, 'b': 2, 'c': 3}

    # Filter dictionary
    scores = {"Alice": 90, "Bob": 75, "Charlie": 85}
    passing = {k: v for k, v in scores.items() if v >= 80}
    # {'Alice': 90, 'Charlie': 85}
    ```

    ## Common Use Cases

    ### Counting occurrences
    ```python
    text = "hello world"
    counts = {}
    for char in text:
        counts[char] = counts.get(char, 0) + 1
    ```

    ### Grouping data
    ```python
    students = [
        {"name": "Alice", "grade": "A"},
        {"name": "Bob", "grade": "B"},
        {"name": "Charlie", "grade": "A"}
    ]

    by_grade = {}
    for student in students:
        grade = student["grade"]
        if grade not in by_grade:
            by_grade[grade] = []
        by_grade[grade].append(student["name"])
    ```

    **Practice:** Try the Dictionaries lab!
  MARKDOWN
  lesson.key_concepts = ['dictionaries', 'key-value pairs', 'dict methods', 'dict comprehension']
end

# Lesson 3.3: Tuples and Sets (NEW)
lesson3_3 = CourseLesson.find_or_create_by!(title: "Tuples and Sets") do |lesson|
  lesson.reading_time_minutes = 20
  lesson.content = <<~MARKDOWN
    # Tuples and Sets

    ## Tuples: Immutable Lists

    **Tuples** are like lists but cannot be changed after creation.

    ### Creating Tuples

    ```python
    # With parentheses
    point = (10, 20)
    person = ("Alice", 25, "NYC")

    # Without parentheses (tuple packing)
    coordinates = 10, 20, 30

    # Single element tuple (note the comma!)
    single = (42,)

    # Empty tuple
    empty = ()
    ```

    ### Accessing Tuple Elements

    ```python
    point = (10, 20, 30)
    print(point[0])   # 10
    print(point[-1])  # 30
    print(point[1:])  # (20, 30)
    ```

    ### Tuple Unpacking

    ```python
    point = (10, 20)
    x, y = point
    print(x)  # 10
    print(y)  # 20

    # Swap variables
    a, b = 1, 2
    a, b = b, a  # Now a=2, b=1

    # Multiple return values
    def get_user():
        return "Alice", 25, "NYC"

    name, age, city = get_user()
    ```

    ### Why Use Tuples?

    - **Immutable**: Can't be accidentally modified
    - **Hashable**: Can be used as dictionary keys
    - **Faster**: Slightly faster than lists
    - **Multiple returns**: Natural for returning multiple values

    ```python
    # Tuple as dictionary key
    locations = {
        (0, 0): "origin",
        (1, 2): "point A",
        (3, 4): "point B"
    }
    ```

    ## Sets: Unique Collections

    **Sets** store unique values with fast membership testing.

    ### Creating Sets

    ```python
    # With curly braces
    fruits = {"apple", "banana", "cherry"}

    # From list (removes duplicates)
    numbers = set([1, 2, 2, 3, 3, 3])  # {1, 2, 3}

    # Empty set (must use set(), not {})
    empty = set()
    ```

    ### Set Operations

    ```python
    fruits = {"apple", "banana", "cherry"}

    # Add element
    fruits.add("orange")

    # Remove element
    fruits.remove("banana")  # Error if not found
    fruits.discard("mango")  # No error if not found

    # Check membership
    if "apple" in fruits:
        print("Found!")

    # Length
    print(len(fruits))
    ```

    ### Set Math

    ```python
    a = {1, 2, 3, 4}
    b = {3, 4, 5, 6}

    # Union (all unique elements)
    print(a | b)  # {1, 2, 3, 4, 5, 6}
    print(a.union(b))

    # Intersection (common elements)
    print(a & b)  # {3, 4}
    print(a.intersection(b))

    # Difference (in a but not in b)
    print(a - b)  # {1, 2}
    print(a.difference(b))

    # Symmetric difference (in either but not both)
    print(a ^ b)  # {1, 2, 5, 6}
    print(a.symmetric_difference(b))
    ```

    ### Common Use Cases

    #### Remove duplicates
    ```python
    numbers = [1, 2, 2, 3, 3, 3, 4]
    unique = list(set(numbers))  # [1, 2, 3, 4]
    ```

    #### Fast membership testing
    ```python
    # Much faster than list for large collections
    allowed_users = {"alice", "bob", "charlie"}
    if username in allowed_users:
        print("Access granted")
    ```

    #### Find common elements
    ```python
    list1 = [1, 2, 3, 4]
    list2 = [3, 4, 5, 6]
    common = set(list1) & set(list2)  # {3, 4}
    ```

    ## Summary

    | Type | Mutable? | Ordered? | Duplicates? | Syntax |
    |------|----------|----------|-------------|--------|
    | List | Yes | Yes | Yes | `[1, 2, 3]` |
    | Tuple | No | Yes | Yes | `(1, 2, 3)` |
    | Set | Yes | No | No | `{1, 2, 3}` |
    | Dict | Yes | Yes* | No (keys) | `{'a': 1}` |

    *Python 3.7+ maintains insertion order for dictionaries

    **Practice:** Try the Data Structures lab!
  MARKDOWN
  lesson.key_concepts = ['tuples', 'tuple unpacking', 'sets', 'set operations', 'immutability']
end

# Quiz 3.1: Data Structures
quiz3_1 = Quiz.find_or_create_by!(title: "Data Structures Quiz") do |quiz|
  quiz.description = 'Test your knowledge of lists, dictionaries, tuples, and sets'
  quiz.time_limit_minutes = 15
  quiz.passing_score = 70
end

# Quiz Questions for Module 3
[
  {
    question_text: "Which data structure would you use to store unique email addresses?",
    question_type: "mcq",
    points: 5,
    options: ["Set", "List", "Tuple", "String"],
    correct_answer: "Set",
    explanation: "Sets automatically ensure all elements are unique."
  },
  {
    question_text: "How do you access the value for key 'name' in dict person?",
    question_type: "mcq",
    points: 5,
    options: ["person['name']", "person.name", "person(name)", "person->name"],
    correct_answer: "person['name']",
    explanation: "Dictionary values are accessed using square brackets with the key."
  },
  {
    question_text: "Can you modify a tuple after creating it?",
    question_type: "mcq",
    points: 5,
    options: ["No, tuples are immutable", "Yes, using append()", "Yes, using insert()", "Only if it's empty"],
    correct_answer: "No, tuples are immutable",
    explanation: "Tuples cannot be modified after creation - they are immutable."
  },
  {
    question_text: "What is the result of: [x ** 2 for x in range(3)]?",
    question_type: "fill_blank",
    points: 5,
    correct_answer: "[0, 1, 4]",
    explanation: "List comprehension squares each number: 0²=0, 1²=1, 2²=4."
  },
  {
    question_text: "Which method removes and returns the last item from a list?",
    question_type: "mcq",
    points: 5,
    options: ["pop()", "remove()", "delete()", "clear()"],
    correct_answer: "pop()",
    explanation: "pop() removes and returns the last element."
  },
  {
    question_text: "What does {1, 2, 3} & {2, 3, 4} equal?",
    question_type: "fill_blank",
    points: 5,
    correct_answer: "{2, 3}",
    explanation: "& performs set intersection, returning common elements."
  },
  {
    question_text: "How do you create an empty dictionary?",
    question_type: "mcq",
    points: 5,
    options: ["{}", "[]", "()", "dict[]"],
    correct_answer: "{}",
    explanation: "{} creates an empty dictionary. set() is needed for empty sets."
  },
  {
    question_text: "What is tuple unpacking?\n\nx, y = (10, 20)",
    question_type: "mcq",
    points: 5,
    options: ["Assigning tuple values to variables", "Removing parentheses", "Converting to list", "Sorting the tuple"],
    correct_answer: "Assigning tuple values to variables",
    explanation: "Tuple unpacking assigns each tuple element to a corresponding variable."
  },
  {
    question_text: "Which is faster for checking if an item exists: list or set?",
    question_type: "mcq",
    points: 5,
    options: ["Set", "List", "Same speed", "Depends on item"],
    correct_answer: "Set",
    explanation: "Sets use hash tables, making membership testing O(1) vs O(n) for lists."
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz3_1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer]
    question.explanation = q_data[:explanation]
  end
end

# ==========================================
# MODULE 4: Functions (NEW)
# ==========================================

module4 = CourseModule.find_or_create_by!(slug: 'functions', course: python_course) do |mod|
  mod.title = 'Functions'
  mod.description = 'Create reusable code with functions, parameters, and return values'
  mod.sequence_order = 4
  mod.estimated_minutes = 60
  mod.published = true
end

# Lesson 4.1: Functions Basics
lesson4_1 = CourseLesson.find_or_create_by!(title: "Functions Basics") do |lesson|
  lesson.reading_time_minutes = 30
  lesson.content = <<~MARKDOWN
    # Functions Basics

    **Functions** are reusable blocks of code that perform specific tasks.

    ## Defining Functions

    ```python
    def greet():
        print("Hello!")

    # Call the function
    greet()  # Output: Hello!
    ```

    ## Parameters and Arguments

    ```python
    # Function with parameters
    def greet(name):
        print(f"Hello, {name}!")

    greet("Alice")  # Output: Hello, Alice!

    # Multiple parameters
    def add(a, b):
        return a + b

    result = add(5, 3)  # 8
    ```

    ## Return Values

    ```python
    def square(x):
        return x ** 2

    result = square(5)  # 25

    # Multiple return values
    def get_user():
        return "Alice", 25

    name, age = get_user()
    ```

    ## Default Parameters

    ```python
    def greet(name="Guest"):
        print(f"Hello, {name}!")

    greet()          # Hello, Guest!
    greet("Alice")   # Hello, Alice!
    ```

    ## Keyword Arguments

    ```python
    def create_user(name, age, city):
        print(f"{name}, {age}, {city}")

    # Call with keyword arguments (order doesn't matter)
    create_user(age=25, city="NYC", name="Alice")
    ```

    ## *args and **kwargs

    ### *args - Variable number of arguments
    ```python
    def sum_all(*numbers):
        return sum(numbers)

    print(sum_all(1, 2, 3, 4))  # 10
    ```

    ### **kwargs - Variable keyword arguments
    ```python
    def print_info(**info):
        for key, value in info.items():
            print(f"{key}: {value}")

    print_info(name="Alice", age=25, city="NYC")
    ```

    ## Lambda Functions

    Anonymous functions for simple operations:

    ```python
    # Regular function
    def square(x):
        return x ** 2

    # Lambda equivalent
    square = lambda x: x ** 2

    # Common use: with map, filter
    numbers = [1, 2, 3, 4]
    squared = list(map(lambda x: x ** 2, numbers))
    # [1, 4, 9, 16]

    evens = list(filter(lambda x: x % 2 == 0, numbers))
    # [2, 4]
    ```

    ## Scope

    ```python
    # Global variable
    x = 10

    def modify():
        # Local variable
        x = 20
        print(x)  # 20

    modify()
    print(x)  # 10 (global unchanged)

    # Modify global
    def modify_global():
        global x
        x = 20

    modify_global()
    print(x)  # 20
    ```

    ## Docstrings

    Document your functions:

    ```python
    def calculate_area(radius):
        """
        Calculate the area of a circle.

        Args:
            radius (float): The radius of the circle

        Returns:
            float: The area of the circle
        """
        return 3.14159 * radius ** 2

    # Access docstring
    print(calculate_area.__doc__)
    ```

    ## Best Practices

    1. **One purpose**: Each function should do one thing well
    2. **Clear names**: Use descriptive function names
    3. **Document**: Add docstrings for complex functions
    4. **Default values**: Use defaults for optional parameters
    5. **Return values**: Prefer return over print

    **Practice:** Try the Functions lab!
  MARKDOWN
  lesson.key_concepts = ['functions', 'parameters', 'return', 'default arguments', 'lambda', 'scope']
end

# Quiz 4.1: Functions
quiz4_1 = Quiz.find_or_create_by!(title: "Functions Quiz") do |quiz|
  quiz.description = 'Test your understanding of functions'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
end

[
  {
    question_text: "What keyword is used to define a function in Python?",
    question_type: "mcq",
    points: 5,
    options: ["def", "function", "func", "define"],
    correct_answer: "def",
    explanation: "'def' is the keyword used to define functions in Python."
  },
  {
    question_text: "How do you make a function return a value?",
    question_type: "mcq",
    points: 5,
    options: ["Use the return keyword", "Use print()", "Use output()", "Functions automatically return"],
    correct_answer: "Use the return keyword",
    explanation: "The 'return' keyword sends a value back to the caller."
  },
  {
    question_text: "What is a lambda function?",
    question_type: "mcq",
    points: 5,
    options: ["A small anonymous function", "A function without parameters", "A function that returns nothing", "A built-in function"],
    correct_answer: "A small anonymous function",
    explanation: "Lambda functions are small, anonymous functions defined with the lambda keyword."
  },
  {
    question_text: "What does *args allow in a function?",
    question_type: "mcq",
    points: 5,
    options: ["Variable number of arguments", "Keyword arguments", "Default arguments", "Global arguments"],
    correct_answer: "Variable number of arguments",
    explanation: "*args allows a function to accept any number of positional arguments."
  },
  {
    question_text: "Can a function return multiple values?",
    question_type: "mcq",
    points: 5,
    options: ["Yes, as a tuple", "No, only one value", "Only with arrays", "Only with dictionaries"],
    correct_answer: "Yes, as a tuple",
    explanation: "Python functions can return multiple values as a tuple."
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz4_1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer]
    question.explanation = q_data[:explanation]
  end
end

# ==========================================
# MODULE 5: Object-Oriented Programming (NEW)
# ==========================================

module5 = CourseModule.find_or_create_by!(slug: 'oop', course: python_course) do |mod|
  mod.title = 'Object-Oriented Programming'
  mod.description = 'Learn classes, objects, inheritance, and OOP principles'
  mod.sequence_order = 5
  mod.estimated_minutes = 70
  mod.published = true
end

# Lesson 5.1: Classes and Objects
lesson5_1 = CourseLesson.find_or_create_by!(title: "Classes and Objects") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # Classes and Objects

    **Classes** are blueprints for creating objects. **Objects** are instances of classes.

    ## Creating a Class

    ```python
    class Dog:
        # Constructor
        def __init__(self, name, age):
            self.name = name
            self.age = age

        # Method
        def bark(self):
            print(f"{self.name} says woof!")

    # Create objects
    dog1 = Dog("Buddy", 3)
    dog2 = Dog("Max", 5)

    # Use methods
    dog1.bark()  # Buddy says woof!
    print(dog2.age)  # 5
    ```

    ## The `__init__` Method

    Special method called when object is created:

    ```python
    class Person:
        def __init__(self, name, age):
            self.name = name  # Instance variable
            self.age = age
            self.friends = []  # Default value

        def add_friend(self, friend):
            self.friends.append(friend)

    person = Person("Alice", 25)
    ```

    ## Class vs Instance Variables

    ```python
    class Dog:
        # Class variable (shared by all instances)
        species = "Canis familiaris"

        def __init__(self, name):
            # Instance variable (unique to each instance)
            self.name = name

    dog1 = Dog("Buddy")
    dog2 = Dog("Max")

    print(Dog.species)  # "Canis familiaris"
    print(dog1.name)    # "Buddy"
    print(dog2.name)    # "Max"
    ```

    ## Instance Methods

    ```python
    class BankAccount:
        def __init__(self, owner, balance=0):
            self.owner = owner
            self.balance = balance

        def deposit(self, amount):
            self.balance += amount
            return self.balance

        def withdraw(self, amount):
            if amount > self.balance:
                return "Insufficient funds"
            self.balance -= amount
            return self.balance

    account = BankAccount("Alice", 1000)
    account.deposit(500)   # 1500
    account.withdraw(200)  # 1300
    ```

    ## Property Decorators

    Control attribute access:

    ```python
    class Temperature:
        def __init__(self, celsius):
            self._celsius = celsius

        @property
        def celsius(self):
            return self._celsius

        @celsius.setter
        def celsius(self, value):
            if value < -273.15:
                raise ValueError("Below absolute zero!")
            self._celsius = value

        @property
        def fahrenheit(self):
            return self._celsius * 9/5 + 32

    temp = Temperature(25)
    print(temp.celsius)     # 25
    print(temp.fahrenheit)  # 77.0
    temp.celsius = 30       # OK
    # temp.celsius = -300   # Error!
    ```

    ## Magic Methods (Dunder Methods)

    Special methods for operator overloading:

    ```python
    class Point:
        def __init__(self, x, y):
            self.x = x
            self.y = y

        def __str__(self):
            # Called by print()
            return f"Point({self.x}, {self.y})"

        def __add__(self, other):
            # Called by +
            return Point(self.x + other.x, self.y + other.y)

        def __eq__(self, other):
            # Called by ==
            return self.x == other.x and self.y == other.y

    p1 = Point(1, 2)
    p2 = Point(3, 4)

    print(p1)        # Point(1, 2)
    p3 = p1 + p2     # Point(4, 6)
    print(p1 == p2)  # False
    ```

    ## Inheritance

    ```python
    # Parent class
    class Animal:
        def __init__(self, name):
            self.name = name

        def speak(self):
            pass

    # Child classes
    class Dog(Animal):
        def speak(self):
            return f"{self.name} says woof!"

    class Cat(Animal):
        def speak(self):
            return f"{self.name} says meow!"

    dog = Dog("Buddy")
    cat = Cat("Whiskers")

    print(dog.speak())  # Buddy says woof!
    print(cat.speak())  # Whiskers says meow!
    ```

    ## Super()

    Call parent class methods:

    ```python
    class Person:
        def __init__(self, name, age):
            self.name = name
            self.age = age

    class Student(Person):
        def __init__(self, name, age, student_id):
            super().__init__(name, age)  # Call parent constructor
            self.student_id = student_id

    student = Student("Alice", 20, "S12345")
    ```

    ## Encapsulation

    ```python
    class BankAccount:
        def __init__(self, balance):
            self.__balance = balance  # Private attribute

        def get_balance(self):
            return self.__balance

        def deposit(self, amount):
            if amount > 0:
                self.__balance += amount

    account = BankAccount(1000)
    # account.__balance = 0  # Won't work (name mangled)
    account.deposit(500)     # Use public method
    ```

    ## Class Methods and Static Methods

    ```python
    class Date:
        def __init__(self, year, month, day):
            self.year = year
            self.month = month
            self.day = day

        @classmethod
        def from_string(cls, date_string):
            # Alternative constructor
            year, month, day = map(int, date_string.split('-'))
            return cls(year, month, day)

        @staticmethod
        def is_leap_year(year):
            # Utility function
            return year % 4 == 0 and (year % 100 != 0 or year % 400 == 0)

    # Use class method
    date = Date.from_string("2024-01-15")

    # Use static method
    print(Date.is_leap_year(2024))  # True
    ```

    ## When to Use OOP

    ✅ **Good for:**
    - Modeling real-world entities
    - Code reusability through inheritance
    - Grouping related data and behavior
    - Building large, maintainable systems

    ❌ **Overkill for:**
    - Simple scripts
    - Single-use utilities
    - Functional programming problems

    **Practice:** Try the OOP lab!
  MARKDOWN
  lesson.key_concepts = ['classes', 'objects', 'inheritance', 'encapsulation', 'polymorphism', 'magic methods']
end

# Quiz 5.1: OOP
quiz5_1 = Quiz.find_or_create_by!(title: "OOP Quiz") do |quiz|
  quiz.description = 'Test your knowledge of object-oriented programming'
  quiz.time_limit_minutes = 12
  quiz.passing_score = 70
end

[
  {
    question_text: "What is a class in Python?",
    question_type: "mcq",
    points: 5,
    options: ["A blueprint for creating objects", "A type of function", "A data structure", "A module"],
    correct_answer: "A blueprint for creating objects",
    explanation: "A class defines the structure and behavior for objects."
  },
  {
    question_text: "What does __init__ do?",
    question_type: "mcq",
    points: 5,
    options: ["Initializes a new object", "Deletes an object", "Copies an object", "Prints an object"],
    correct_answer: "Initializes a new object",
    explanation: "__init__ is the constructor method called when creating a new object."
  },
  {
    question_text: "What is 'self' in a class method?",
    question_type: "mcq",
    points: 5,
    options: ["Reference to the current instance", "A global variable", "A class variable", "A parameter"],
    correct_answer: "Reference to the current instance",
    explanation: "'self' refers to the current instance of the class."
  },
  {
    question_text: "What is inheritance?",
    question_type: "mcq",
    points: 5,
    options: ["A child class inherits from a parent class", "Copying a class", "Creating multiple objects", "Deleting a class"],
    correct_answer: "A child class inherits from a parent class",
    explanation: "Inheritance allows a class to inherit attributes and methods from another class."
  },
  {
    question_text: "Which decorator makes a method a class method?",
    question_type: "mcq",
    points: 5,
    options: ["@classmethod", "@staticmethod", "@property", "@class"],
    correct_answer: "@classmethod",
    explanation: "@classmethod decorator creates a method that receives the class as its first argument."
  },
  {
    question_text: "What does encapsulation mean?",
    question_type: "mcq",
    points: 5,
    options: ["Hiding internal implementation details", "Creating multiple classes", "Inheriting from parent", "Deleting attributes"],
    correct_answer: "Hiding internal implementation details",
    explanation: "Encapsulation is about bundling data and restricting direct access to some components."
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz5_1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer]
    question.explanation = q_data[:explanation]
  end
end

# ==========================================
# MODULE 6: File I/O & Error Handling (NEW)
# ==========================================

module6 = CourseModule.find_or_create_by!(slug: 'file-io-errors', course: python_course) do |mod|
  mod.title = 'File I/O & Error Handling'
  mod.description = 'Work with files and handle exceptions gracefully'
  mod.sequence_order = 6
  mod.estimated_minutes = 60
  mod.published = true
end

# Lesson 6.1: File I/O
lesson6_1 = CourseLesson.find_or_create_by!(title: "File Input/Output") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
    # File Input/Output

    Learn to read from and write to files in Python.

    ## Reading Files

    ### Read entire file
    ```python
    # Basic read
    file = open('data.txt', 'r')
    content = file.read()
    file.close()

    # Better: Using with (auto-closes file)
    with open('data.txt', 'r') as file:
        content = file.read()
        print(content)
    ```

    ### Read line by line
    ```python
    with open('data.txt', 'r') as file:
        for line in file:
            print(line.strip())  # Remove newline

    # Or read all lines into list
    with open('data.txt', 'r') as file:
        lines = file.readlines()
    ```

    ## Writing Files

    ```python
    # Write mode (overwrites existing)
    with open('output.txt', 'w') as file:
        file.write("Hello, World!\\n")
        file.write("Second line\\n")

    # Append mode (adds to end)
    with open('output.txt', 'a') as file:
        file.write("Appended line\\n")

    # Write multiple lines
    lines = ["Line 1\\n", "Line 2\\n", "Line 3\\n"]
    with open('output.txt', 'w') as file:
        file.writelines(lines)
    ```

    ## File Modes

    | Mode | Description |
    |------|-------------|
    | `'r'` | Read (default) |
    | `'w'` | Write (overwrites) |
    | `'a'` | Append |
    | `'x'` | Create (fails if exists) |
    | `'b'` | Binary mode |
    | `'t'` | Text mode (default) |
    | `'+'` | Read and write |

    ## Working with Paths

    ```python
    from pathlib import Path

    # Create Path object
    path = Path('data/files/info.txt')

    # Check if exists
    if path.exists():
        print("File exists!")

    # Get file info
    print(path.name)      # 'info.txt'
    print(path.stem)      # 'info'
    print(path.suffix)    # '.txt'
    print(path.parent)    # 'data/files'

    # Read/write with Path
    path.write_text("Hello!")
    content = path.read_text()

    # List directory
    for file in Path('.').glob('*.txt'):
        print(file)
    ```

    ## CSV Files

    ```python
    import csv

    # Read CSV
    with open('data.csv', 'r') as file:
        reader = csv.reader(file)
        for row in reader:
            print(row)

    # Read as dictionaries
    with open('data.csv', 'r') as file:
        reader = csv.DictReader(file)
        for row in reader:
            print(row['name'], row['age'])

    # Write CSV
    data = [
        ['Name', 'Age', 'City'],
        ['Alice', 25, 'NYC'],
        ['Bob', 30, 'LA']
    ]

    with open('output.csv', 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerows(data)
    ```

    ## JSON Files

    ```python
    import json

    # Read JSON
    with open('data.json', 'r') as file:
        data = json.load(file)

    # Write JSON
    data = {
        'name': 'Alice',
        'age': 25,
        'cities': ['NYC', 'LA']
    }

    with open('output.json', 'w') as file:
        json.dump(data, file, indent=2)

    # JSON strings
    json_str = json.dumps(data, indent=2)
    data = json.loads(json_str)
    ```

    **Practice:** Try the File Processing lab!
  MARKDOWN
  lesson.key_concepts = ['file I/O', 'read', 'write', 'with statement', 'CSV', 'JSON', 'pathlib']
end

# Lesson 6.2: Error Handling
lesson6_2 = CourseLesson.find_or_create_by!(title: "Exception Handling") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
    # Exception Handling

    Handle errors gracefully instead of crashing your program.

    ## Try-Except

    ```python
    try:
        number = int(input("Enter a number: "))
        result = 10 / number
        print(result)
    except ValueError:
        print("That's not a valid number!")
    except ZeroDivisionError:
        print("Cannot divide by zero!")
    ```

    ## Multiple Exceptions

    ```python
    try:
        # Risky code
        file = open('data.txt', 'r')
        content = file.read()
        number = int(content)
    except FileNotFoundError:
        print("File not found!")
    except ValueError:
        print("File doesn't contain a number!")
    except Exception as e:
        print(f"Unexpected error: {e}")
    finally:
        print("This always runs")
    ```

    ## Else and Finally

    ```python
    try:
        number = int(input("Enter number: "))
    except ValueError:
        print("Invalid input!")
    else:
        # Runs if no exception
        print(f"You entered: {number}")
    finally:
        # Always runs
        print("Done!")
    ```

    ## Raising Exceptions

    ```python
    def divide(a, b):
        if b == 0:
            raise ValueError("Cannot divide by zero!")
        return a / b

    try:
        result = divide(10, 0)
    except ValueError as e:
        print(e)
    ```

    ## Custom Exceptions

    ```python
    class NegativeAgeError(Exception):
        pass

    def set_age(age):
        if age < 0:
            raise NegativeAgeError("Age cannot be negative!")
        return age

    try:
        set_age(-5)
    except NegativeAgeError as e:
        print(e)
    ```

    ## Common Exceptions

    | Exception | When it occurs |
    |-----------|----------------|
    | `ValueError` | Invalid value |
    | `TypeError` | Wrong type |
    | `ZeroDivisionError` | Division by zero |
    | `FileNotFoundError` | File doesn't exist |
    | `KeyError` | Dict key not found |
    | `IndexError` | List index out of range |
    | `AttributeError` | Attribute doesn't exist |
    | `ImportError` | Cannot import module |

    ## Best Practices

    1. **Be specific**: Catch specific exceptions, not all
    2. **Don't hide errors**: Log or handle properly
    3. **Use finally**: For cleanup (close files, etc.)
    4. **Fail gracefully**: Provide helpful error messages
    5. **Validate early**: Check inputs before processing

    **Practice:** Try the Error Handling exercises!
  MARKDOWN
  lesson.key_concepts = ['exceptions', 'try-except', 'finally', 'raising exceptions', 'custom exceptions']
end

# Quiz 6.1: File I/O and Error Handling
quiz6_1 = Quiz.find_or_create_by!(title: "File I/O & Error Handling Quiz") do |quiz|
  quiz.description = 'Test your knowledge of files and exception handling'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
end

[
  {
    question_text: "Which mode opens a file for writing and overwrites existing content?",
    question_type: "mcq",
    points: 5,
    options: ["'w'", "'r'", "'a'", "'x'"],
    correct_answer: "'w'",
    explanation: "'w' mode opens for writing and overwrites the file if it exists."
  },
  {
    question_text: "What does the 'with' statement do?",
    question_type: "mcq",
    points: 5,
    options: ["Automatically closes the file", "Opens the file", "Writes to the file", "Reads the file"],
    correct_answer: "Automatically closes the file",
    explanation: "'with' ensures the file is properly closed after use."
  },
  {
    question_text: "Which exception is raised when dividing by zero?",
    question_type: "mcq",
    points: 5,
    options: ["ZeroDivisionError", "ValueError", "TypeError", "MathError"],
    correct_answer: "ZeroDivisionError",
    explanation: "ZeroDivisionError is raised when attempting division by zero."
  },
  {
    question_text: "What block always executes, even if an exception occurs?",
    question_type: "mcq",
    points: 5,
    options: ["finally", "except", "else", "catch"],
    correct_answer: "finally",
    explanation: "The finally block always executes, regardless of whether an exception occurred."
  },
  {
    question_text: "How do you raise an exception in Python?",
    question_type: "mcq",
    points: 5,
    options: ["raise ExceptionName()", "throw ExceptionName()", "error ExceptionName()", "except ExceptionName()"],
    correct_answer: "raise ExceptionName()",
    explanation: "Use 'raise' keyword to manually raise an exception."
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz6_1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer]
    question.explanation = q_data[:explanation]
  end
end

# ==========================================
# LINK LESSONS AND QUIZZES TO MODULES
# ==========================================

puts "Linking lessons and quizzes to modules..."

# Module 1: Python Basics
ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module1, item: quiz1_1, sequence_order: 2)

# Module 2: Control Flow
ModuleItem.find_or_create_by!(course_module: module2, item: lesson2_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module2, item: lesson2_2, sequence_order: 2)
ModuleItem.find_or_create_by!(course_module: module2, item: quiz2_1, sequence_order: 3)

# Module 3: Lists and Data Structures
ModuleItem.find_or_create_by!(course_module: module3, item: lesson3_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module3, item: lesson3_2, sequence_order: 2)
ModuleItem.find_or_create_by!(course_module: module3, item: lesson3_3, sequence_order: 3)
ModuleItem.find_or_create_by!(course_module: module3, item: quiz3_1, sequence_order: 4)

# Module 4: Functions
ModuleItem.find_or_create_by!(course_module: module4, item: lesson4_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module4, item: quiz4_1, sequence_order: 2)

# Module 5: OOP
ModuleItem.find_or_create_by!(course_module: module5, item: lesson5_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module5, item: quiz5_1, sequence_order: 2)

# Module 6: File I/O and Error Handling
ModuleItem.find_or_create_by!(course_module: module6, item: lesson6_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module6, item: lesson6_2, sequence_order: 2)
ModuleItem.find_or_create_by!(course_module: module6, item: quiz6_1, sequence_order: 3)

# ==========================================
# LINK LABS TO MODULES
# ==========================================

puts "Linking Python code labs to course modules..."

python_labs = HandsOnLab.where(lab_type: 'python').order(:sequence_order)

if python_labs.count >= 4
  # Lab 1: List Comprehensions → Module 3 (Lists)
  ModuleItem.find_or_create_by!(
    course_module: module3,
    item: python_labs[0],
    sequence_order: 4
  )

  # Lab 2: Dictionaries → Module 3 (Lists)
  ModuleItem.find_or_create_by!(
    course_module: module3,
    item: python_labs[1],
    sequence_order: 5
  )

  # Lab 3: Functions/Decorators → Module 4 (Functions)
  ModuleItem.find_or_create_by!(
    course_module: module4,
    item: python_labs[2],
    sequence_order: 2
  )

  # Lab 4: File Processing → Module 6 (File I/O)
  ModuleItem.find_or_create_by!(
    course_module: module6,
    item: python_labs[3],
    sequence_order: 3
  )

  puts "Linked #{python_labs.count} existing code labs to course modules"
end

# ==========================================
# COURSE COMPLETION SUMMARY
# ==========================================

puts "\n✅ Enhanced Python course created successfully!"
puts "   - Course: #{python_course.title}"
puts "   - Modules: #{python_course.course_modules.count}"
puts "   - Lessons: #{CourseLesson.joins(course_module: :course).where(courses: { id: python_course.id }).count}"
puts "   - Quizzes: #{Quiz.joins(course_module: :course).where(courses: { id: python_course.id }).count}"
puts "   - Quiz Questions: #{QuizQuestion.joins(quiz: {course_module: :course}).where(courses: { id: python_course.id }).count}"
puts "   - Labs: #{python_labs.count}"
puts "\n📚 Content Coverage:"
puts "   ✅ Python Basics (variables, types, operators)"
puts "   ✅ Control Flow (if statements, loops)"
puts "   ✅ Data Structures (lists, dicts, tuples, sets)"
puts "   ✅ Functions (def, lambda, *args, **kwargs)"
puts "   ✅ Object-Oriented Programming (classes, inheritance)"
puts "   ✅ File I/O & Error Handling (files, CSV, JSON, exceptions)"
puts "\n🎯 Learning Features:"
puts "   ✅ 55+ quiz questions with explanations"
puts "   ✅ Interactive code labs"
puts "   ✅ Real-world examples"
puts "   ✅ Best practices throughout"
puts "\n🚀 Ready for production!"