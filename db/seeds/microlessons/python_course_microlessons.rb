# AUTO-GENERATED from python_course.rb
puts "Creating Microlessons for Python Basics..."

module_var = CourseModule.find_by(slug: 'python-basics')

# === MICROLESSON 1: Hello, Python! ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Hello, Python!',
  content: <<~MARKDOWN,
# Hello, Python! 🚀

# Hello, Python!

    Welcome to Python! Python is one of the most popular programming languages, known for its simplicity and readability.

    ## Your First Program

    Let's start with the traditional "Hello, World!" program:

    ```python
    print("Hello, World!")
    ```

    That's it! Just one line. The `print()` function displays text on the screen.

    ### Try It Yourself
    ```python
    print("Welcome to Python!")
    print("My name is Python")
    print(2 + 2)  # Prints: 4
    ```

    ## Variables: Storing Information

    Variables let you store data for later use:

    ```python
    # Creating variables
    name = "Alice"
    age = 25
    height = 5.6
    is_student = True

    # Using variables
    print(name)  # Prints: Alice
    print(age)   # Prints: 25
    ```

    ### Variable Naming Rules
    ✅ **Good names:**
    - `user_name`
    - `age`
    - `total_price`
    - `is_active`

    ❌ **Invalid names:**
    - `2students` (can't start with number)
    - `user-name` (can't use hyphens)
    - `class` (reserved keyword)

    ## Data Types

    Python has several built-in data types:

    ### 1. Strings (Text)
    ```python
    greeting = "Hello"
    name = 'Alice'  # Single or double quotes
    message = """This is a
    multi-line string"""
    ```

    **String Operations:**
    ```python
    # Concatenation
    first_name = "John"
    last_name = "Doe"
    full_name = first_name + " " + last_name  # "John Doe"

    # Repetition
    laugh = "ha" * 3  # "hahaha"

    # Length
    len("Python")  # 6

    # Indexing (starts at 0)
    word = "Python"
    word[0]  # 'P'
    word[-1]  # 'n' (last character)

    # Slicing
    word[0:3]  # 'Pyt'
    word[2:]   # 'thon'
    ```

    ### 2. Numbers
    ```python
    # Integers (whole numbers)
    age = 25
    year = 2024
    negative = -10

    # Floats (decimal numbers)
    price = 19.99
    temperature = -3.5
    pi = 3.14159

    # Arithmetic operations
    x = 10
    y = 3

    print(x + y)   # Addition: 13
    print(x - y)   # Subtraction: 7
    print(x * y)   # Multiplication: 30
    print(x / y)   # Division: 3.333...
    print(x // y)  # Integer division: 3
    print(x % y)   # Modulus (remainder): 1
    print(x ** y)  # Exponentiation: 1000
    ```

    ### 3. Booleans (True/False)
    ```python
    is_raining = True
    is_sunny = False

    # Comparisons return booleans
    age = 18
    print(age >= 18)  # True
    print(age < 18)   # False
    print(age == 18)  # True (equal to)
    print(age != 18)  # False (not equal to)
    ```

    ## Type Conversion

    Convert between types:

    ```python
    # String to number
    age_str = "25"
    age_num = int(age_str)  # 25

    # Number to string
    score = 100
    score_str = str(score)  # "100"

    # String to float
    price = float("19.99")  # 19.99

    # Check type
    type(42)         # <class 'int'>
    type("hello")    # <class 'str'>
    type(3.14)       # <class 'float'>
    type(True)       # <class 'bool'>
    ```

    ## Comments

    Comments help explain your code:

    ```python
    # This is a single-line comment

    """
    This is a multi-line comment.
    It can span multiple lines.
    Use it for longer explanations.
    """

    x = 5  # Inline comment
    ```

    ## Input from User

    Get user input:

    ```python
    name = input("What is your name? ")
    print("Hello, " + name + "!")

    # Note: input() always returns a string
    age_str = input("What is your age? ")
    age = int(age_str)  # Convert to number
    print("You are", age, "years old")
    ```

    ## String Formatting

    ### f-strings (Modern, Recommended)
    ```python
    name = "Alice"
    age = 25

    message = f"My name is {name} and I am {age} years old"
    print(message)
    # Output: My name is Alice and I am 25 years old

    # Expressions inside f-strings
    x = 10
    y = 5
    print(f"The sum of {x} and {y} is {x + y}")
    # Output: The sum of 10 and 5 is 15
    ```

    ### .format() Method
    ```python
    message = "My name is {} and I am {} years old".format(name, age)
    ```

    ### % Operator (Old Style)
    ```python
    message = "My name is %s and I am %d years old" % (name, age)
    ```

    ## Practice Exercise

    Try this:
    ```python
    # 1. Create variables
    favorite_food = "pizza"
    servings = 3
    price_per_serving = 2.50

    # 2. Calculate total price
    total = servings * price_per_serving

    # 3. Print a message
    print(f"I love {favorite_food}!")
    print(f"{servings} servings cost ${total}")
    ```

    ## Common Mistakes to Avoid

    ❌ **Wrong:**
    ```python
    # Undefined variable
    print(age)  # Error if age not defined

    # Type mismatch
    "5" + 5  # Error: can't add string and number

    # Wrong comparison
    age = "25"
    age > 18  # Error: comparing string and number
    ```

    ✅ **Correct:**
    ```python
    # Define before use
    age = 25
    print(age)

    # Convert types
    "5" + str(5)  # "55"
    int("5") + 5  # 10

    # Compare same types
    age = 25
    age > 18  # True
    ```

    ## Next Steps

    Great job! You've learned:
    - ✅ How to print output
    - ✅ Variables and data types
    - ✅ Basic operations
    - ✅ User input
    - ✅ String formatting

    Next, we'll learn about control flow (if statements and loops)!
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 2: If Statements & Conditions ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'If Statements & Conditions',
  content: <<~MARKDOWN,
# If Statements & Conditions 🚀

# If Statements & Conditions

    **If statements** let your program make decisions based on conditions.

    ## Basic If Statement

    ```python
    age = 18

    if age >= 18:
        print("You are an adult")
    ```

    ### Syntax:
    - Start with `if`
    - Condition that evaluates to True or False
    - Colon `:`
    - **Indented** code block (4 spaces or 1 tab)

    ## If-Else

    Execute different code based on condition:

    ```python
    temperature = 25

    if temperature > 30:
        print("It's hot outside!")
    else:
        print("It's not too hot")
    ```

    ## If-Elif-Else

    Check multiple conditions:

    ```python
    score = 85

    if score >= 90:
        grade = "A"
    elif score >= 80:
        grade = "B"
    elif score >= 70:
        grade = "C"
    elif score >= 60:
        grade = "D"
    else:
        grade = "F"

    print(f"Your grade is: {grade}")
    ```

    **Important:** Python checks conditions top-to-bottom and stops at the first True condition.

    ## Comparison Operators

    | Operator | Meaning | Example |
    |----------|---------|---------|
    | `==` | Equal to | `x == 5` |
    | `!=` | Not equal to | `x != 5` |
    | `>` | Greater than | `x > 5` |
    | `<` | Less than | `x < 5` |
    | `>=` | Greater than or equal | `x >= 5` |
    | `<=` | Less than or equal | `x <= 5` |

    ```python
    x = 10

    print(x == 10)  # True
    print(x != 10)  # False
    print(x > 5)    # True
    print(x < 5)    # False
    ```

    ## Logical Operators

    Combine multiple conditions:

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

    ### Combining Multiple Conditions
    ```python
    age = 25
    has_ticket = True
    has_id = True

    if (age >= 18 and has_ticket) and has_id:
        print("Welcome to the concert!")
    else:
        print("Entry denied")
    ```

    ## Nested If Statements

    If statements inside if statements:

    ```python
    age = 20
    has_license = True

    if age >= 18:
        print("You are old enough")

        if has_license:
            print("You can drive")
        else:
            print("Get a license first")
    else:
        print("You are too young")
    ```

    ## Membership Operators

    Check if value exists in a sequence:

    ```python
    # in operator
    fruits = ["apple", "banana", "cherry"]

    if "apple" in fruits:
        print("Apple is available!")

    # not in operator
    if "mango" not in fruits:
        print("No mangoes here")

    # Works with strings too
    message = "Hello, World!"
    if "World" in message:
        print("Found it!")
    ```

    ## Identity Operators

    Check if variables are the same object:

    ```python
    x = None

    if x is None:
        print("x is None")

    if x is not None:
        print("x has a value")
    ```

    ## Truthy and Falsy Values

    Python considers some values as False:

    ### Falsy Values:
    - `False`
    - `None`
    - `0`, `0.0`
    - `""` (empty string)
    - `[]` (empty list)
    - `{}` (empty dict)
    - `()` (empty tuple)

    ### Everything Else is Truthy

    ```python
    name = ""

    if name:
        print(f"Hello, {name}!")
    else:
        print("Name is empty")

    # More examples
    if []:
        print("This won't print")  # Empty list is falsy

    if [1, 2, 3]:
        print("List has items")  # Non-empty list is truthy
    ```

    ## Ternary Operator (One-Line If)

    Shorter syntax for simple if-else:

    ```python
    # Regular if-else
    age = 20
    if age >= 18:
        status = "adult"
    else:
        status = "minor"

    # Ternary operator
    status = "adult" if age >= 18 else "minor"

    # Another example
    x = 10
    y = 20
    max_value = x if x > y else y
    ```

    ## Common Patterns

    ### 1. Checking Multiple Values
    ```python
    status = "pending"

    if status in ["pending", "processing", "queued"]:
        print("Please wait...")
    ```

    ### 2. Default Values
    ```python
    name = input("Enter your name (or press Enter): ")

    # Use default if empty
    name = name if name else "Guest"
    print(f"Welcome, {name}!")
    ```

    ### 3. Range Checking
    ```python
    age = 25

    if 18 <= age < 65:
        print("Working age")
    ```

    ### 4. Validating Input
    ```python
    password = input("Enter password: ")

    if len(password) < 8:
        print("Password too short")
    elif not any(c.isdigit() for c in password):
        print("Password needs a number")
    elif not any(c.isupper() for c in password):
        print("Password needs an uppercase letter")
    else:
        print("Password is strong!")
    ```

    ## Practice Exercise

    Let's build a simple number guessing game:

    ```python
    secret_number = 7
    guess = int(input("Guess a number between 1-10: "))

    if guess == secret_number:
        print("🎉 Correct! You guessed it!")
    elif guess < secret_number:
        print("📉 Too low! Try again.")
    else:
        print("📈 Too high! Try again.")
    ```

    ## Common Mistakes

    ❌ **Wrong:**
    ```python
    # Missing colon
    if age >= 18
        print("Adult")

    # Using = instead of ==
    if age = 18:  # Assignment, not comparison
        print("Adult")

    # No indentation
    if age >= 18:
    print("Adult")  # Error!
    ```

    ✅ **Correct:**
    ```python
    if age >= 18:
        print("Adult")
    ```

    ## Next: Loops

    Now that you can make decisions, let's learn how to repeat actions with **loops**!
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 3: Python Lists ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Python Lists',
  content: <<~MARKDOWN,
# Python Lists 🚀

# Python Lists

    **Lists** are ordered collections that can hold multiple items. They're one of the most useful data structures in Python!

    ## Creating Lists

    ```python
    # Empty list
    my_list = []

    # List with items
    numbers = [1, 2, 3, 4, 5]
    fruits = ["apple", "banana", "cherry"]

    # Mixed types (not common, but possible)
    mixed = [1, "hello", 3.14, True]

    # Using list() constructor
    numbers = list(range(5))  # [0, 1, 2, 3, 4]
    ```

    ## Accessing Items

    ### Indexing (starts at 0)
    ```python
    fruits = ["apple", "banana", "cherry", "date"]

    print(fruits[0])   # "apple" (first item)
    print(fruits[1])   # "banana"
    print(fruits[-1])  # "date" (last item)
    print(fruits[-2])  # "cherry" (second from end)
    ```

    ### Slicing
    ```python
    numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

    print(numbers[2:5])    # [2, 3, 4]
    print(numbers[:3])     # [0, 1, 2] (from start)
    print(numbers[7:])     # [7, 8, 9] (to end)
    print(numbers[::2])    # [0, 2, 4, 6, 8] (every 2nd item)
    print(numbers[::-1])   # [9, 8, 7, ...] (reversed)
    ```

    ## Modifying Lists

    Lists are **mutable** (can be changed):

    ```python
    fruits = ["apple", "banana", "cherry"]

    # Change an item
    fruits[1] = "blueberry"
    print(fruits)  # ["apple", "blueberry", "cherry"]

    # Add to end
    fruits.append("date")
    print(fruits)  # ["apple", "blueberry", "cherry", "date"]

    # Insert at position
    fruits.insert(1, "banana")  # Insert at index 1
    print(fruits)  # ["apple", "banana", "blueberry", "cherry", "date"]

    # Remove by value
    fruits.remove("blueberry")

    # Remove by index
    removed = fruits.pop(0)  # Removes and returns "apple"

    # Remove last item
    last = fruits.pop()  # Removes and returns last item

    # Clear all items
    fruits.clear()
    ```

    ## List Operations

    ```python
    # Length
    numbers = [1, 2, 3, 4, 5]
    print(len(numbers))  # 5

    # Concatenation
    list1 = [1, 2, 3]
    list2 = [4, 5, 6]
    combined = list1 + list2  # [1, 2, 3, 4, 5, 6]

    # Repetition
    zeros = [0] * 5  # [0, 0, 0, 0, 0]

    # Membership
    if 3 in numbers:
        print("Found 3!")

    # Count occurrences
    numbers = [1, 2, 2, 3, 2, 4]
    print(numbers.count(2))  # 3

    # Find index
    print(numbers.index(3))  # 3 (index of first occurrence)
    ```

    ## Sorting and Reversing

    ```python
    numbers = [5, 2, 8, 1, 9]

    # Sort (modifies original)
    numbers.sort()
    print(numbers)  # [1, 2, 5, 8, 9]

    # Sort descending
    numbers.sort(reverse=True)
    print(numbers)  # [9, 8, 5, 2, 1]

    # sorted() - creates new sorted list
    original = [5, 2, 8, 1, 9]
    sorted_list = sorted(original)
    print(original)      # [5, 2, 8, 1, 9] (unchanged)
    print(sorted_list)   # [1, 2, 5, 8, 9]

    # Reverse (modifies original)
    numbers.reverse()

    # reversed() - returns iterator
    reversed_list = list(reversed(original))
    ```

    ## Looping Through Lists

    ### Using for loop
    ```python
    fruits = ["apple", "banana", "cherry"]

    # Loop through values
    for fruit in fruits:
        print(fruit)

    # Loop with index
    for i in range(len(fruits)):
        print(f"{i}: {fruits[i]}")

    # enumerate() - better way to get index and value
    for index, fruit in enumerate(fruits):
        print(f"{index}: {fruit}")

    # Start enumerate at 1
    for num, fruit in enumerate(fruits, start=1):
        print(f"{num}. {fruit}")
    ```

    ## List Comprehensions

    Create lists in a concise way:

    ### Basic syntax
    ```python
    # Traditional way
    squares = []
    for x in range(10):
        squares.append(x ** 2)

    # List comprehension
    squares = [x ** 2 for x in range(10)]
    print(squares)  # [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
    ```

    ### With condition
    ```python
    # Only even numbers
    evens = [x for x in range(20) if x % 2 == 0]
    print(evens)  # [0, 2, 4, 6, 8, 10, 12, 14, 16, 18]

    # Transform strings
    fruits = ["apple", "banana", "cherry"]
    upper_fruits = [fruit.upper() for fruit in fruits]
    print(upper_fruits)  # ["APPLE", "BANANA", "CHERRY"]

    # Filter and transform
    numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    even_squares = [x ** 2 for x in numbers if x % 2 == 0]
    print(even_squares)  # [4, 16, 36, 64, 100]
    ```

    ### Nested comprehensions
    ```python
    # 2D matrix
    matrix = [[i * j for j in range(3)] for i in range(3)]
    print(matrix)
    # [[0, 0, 0],
    #  [0, 1, 2],
    #  [0, 2, 4]]

    # Flatten nested list
    nested = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    flat = [num for sublist in nested for num in sublist]
    print(flat)  # [1, 2, 3, 4, 5, 6, 7, 8, 9]
    ```

    ## Common List Methods

    | Method | Description | Example |
    |--------|-------------|---------|
    | `append(x)` | Add item to end | `lst.append(5)` |
    | `extend(iterable)` | Add all items from iterable | `lst.extend([4,5,6])` |
    | `insert(i, x)` | Insert at index | `lst.insert(0, 'first')` |
    | `remove(x)` | Remove first occurrence | `lst.remove('apple')` |
    | `pop([i])` | Remove and return item | `lst.pop(0)` |
    | `clear()` | Remove all items | `lst.clear()` |
    | `index(x)` | Find index of value | `lst.index('banana')` |
    | `count(x)` | Count occurrences | `lst.count(5)` |
    | `sort()` | Sort in place | `lst.sort()` |
    | `reverse()` | Reverse in place | `lst.reverse()` |
    | `copy()` | Create shallow copy | `new = lst.copy()` |

    ## Copying Lists

    ```python
    # Wrong way - creates reference
    list1 = [1, 2, 3]
    list2 = list1  # Both point to same list!
    list2.append(4)
    print(list1)  # [1, 2, 3, 4] - original changed!

    # Correct ways
    list2 = list1.copy()       # Method 1
    list2 = list1[:]           # Method 2
    list2 = list(list1)        # Method 3

    # Deep copy (for nested lists)
    import copy
    nested = [[1, 2], [3, 4]]
    deep_copy = copy.deepcopy(nested)
    ```

    ## Practical Examples

    ### 1. Finding Min/Max
    ```python
    numbers = [23, 45, 12, 67, 34]
    print(min(numbers))  # 12
    print(max(numbers))  # 67
    print(sum(numbers))  # 181
    ```

    ### 2. Filtering
    ```python
    ages = [15, 22, 17, 30, 12, 19, 25]
    adults = [age for age in ages if age >= 18]
    print(adults)  # [22, 30, 19, 25]
    ```

    ### 3. Removing Duplicates
    ```python
    numbers = [1, 2, 2, 3, 4, 4, 5]
    unique = list(set(numbers))  # [1, 2, 3, 4, 5]
    # Note: order not guaranteed with set
    ```

    ### 4. List as Stack (LIFO)
    ```python
    stack = []
    stack.append(1)  # Push
    stack.append(2)
    stack.append(3)
    top = stack.pop()  # Pop (3)
    ```

    ### 5. List as Queue (FIFO) - use deque instead
    ```python
    from collections import deque
    queue = deque([1, 2, 3])
    queue.append(4)      # Add to end
    first = queue.popleft()  # Remove from start (1)
    ```

    ## Practice Time!

    Now try the **Python List Comprehensions** lab to practice what you've learned!
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 3 microlessons for Python Basics"
