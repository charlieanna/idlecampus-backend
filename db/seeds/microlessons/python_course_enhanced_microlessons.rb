# AUTO-GENERATED from python_course_enhanced.rb
puts "Creating Microlessons for Python Basics..."

module_var = CourseModule.find_by(slug: 'python-basics')

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

## What is this?
A concise explanation of the concept.
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
  sequence_order: 14,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 15: Lesson 15 ===
lesson_15 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 15',
  content: <<~MARKDOWN,
# Microlesson 🚀

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
  sequence_order: 15,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 16: Lesson 16 ===
lesson_16 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 16',
  content: <<~MARKDOWN,
# Microlesson 🚀

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
  sequence_order: 16,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 17: Lesson 17 ===
lesson_17 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 17',
  content: <<~MARKDOWN,
# Microlesson 🚀

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
  sequence_order: 17,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 18: Lesson 18 ===
lesson_18 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 18',
  content: <<~MARKDOWN,
# Microlesson 🚀

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
  sequence_order: 18,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 19: Lesson 19 ===
lesson_19 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 19',
  content: <<~MARKDOWN,
# Microlesson 🚀

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
  sequence_order: 19,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 20: Lesson 20 ===
lesson_20 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 20',
  content: <<~MARKDOWN,
# Microlesson 🚀

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
  sequence_order: 20,
  estimated_minutes: 2,
  difficulty: 'easy',
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

# === MICROLESSON 32: Lesson 32 ===
lesson_32 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 32',
  content: <<~MARKDOWN,
# Microlesson 🚀

## What is this?
A concise explanation of the concept.
  MARKDOWN
  sequence_order: 32,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 32 microlessons for Python Basics"
