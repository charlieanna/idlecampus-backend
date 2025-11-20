# AUTO-GENERATED from python_advanced_course.rb
puts "Creating Microlessons for Decorators Higher Order..."

module_var = CourseModule.find_by(slug: 'decorators-higher-order')

# === MICROLESSON 1: Lesson 1 ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 1',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Understanding Decorators

    **Decorators** are a powerful Python feature that allows you to modify or enhance functions and classes without changing their source code.

    ## Functions as First-Class Objects

    In Python, functions are first-class objects - they can be:
    - Assigned to variables
    - Passed as arguments
    - Returned from other functions
    - Stored in data structures

    ```python
    def greet(name):
        return f"Hello, {name}!"

    # Assign to variable
    say_hello = greet
    print(say_hello("Alice"))  # Hello, Alice!

    # Store in list
    functions = [greet, len, str]
    ```

    ## Higher-Order Functions

    Functions that take functions as arguments or return functions:

    ```python
    # Function that takes function as argument
    def apply_twice(func, arg):
        return func(func(arg))

    def add_five(x):
        return x + 5

    result = apply_twice(add_five, 10)  # (10 + 5) + 5 = 20

    # Function that returns function
    def make_multiplier(n):
        def multiplier(x):
            return x * n
        return multiplier

    times_three = make_multiplier(3)
    print(times_three(5))  # 15
    ```

    ## Closures

    **Inner functions that remember values from their enclosing scope**

    ```python
    def make_counter():
        count = 0  # Enclosed variable

        def counter():
            nonlocal count  # Access enclosing scope
            count += 1
            return count

        return counter

    # Each counter has its own closure
    counter1 = make_counter()
    counter2 = make_counter()

    print(counter1())  # 1
    print(counter1())  # 2
    print(counter2())  # 1 - independent counter
    ```

    ## Basic Decorator

    **Wrapper function that modifies behavior:**

    ```python
    def my_decorator(func):
        def wrapper():
            print("Before function call")
            result = func()
            print("After function call")
            return result
        return wrapper

    # Manual decoration
    def say_hello():
        print("Hello!")

    say_hello = my_decorator(say_hello)
    say_hello()
    # Output:
    # Before function call
    # Hello!
    # After function call
    ```

    ## The @ Syntax

    **Syntactic sugar for decorators:**

    ```python
    @my_decorator
    def say_hello():
        print("Hello!")

    # Equivalent to: say_hello = my_decorator(say_hello)
    ```

    ## Decorators with Arguments

    ```python
    # Decorator that accepts any arguments
    def my_decorator(func):
        def wrapper(*args, **kwargs):
            print(f"Called {func.__name__} with {args}, {kwargs}")
            result = func(*args, **kwargs)
            print(f"Returned {result}")
            return result
        return wrapper

    @my_decorator
    def add(a, b):
        return a + b

    add(2, 3)
    # Called add with (2, 3), {}
    # Returned 5
    ```

    ## Preserving Function Metadata

    ```python
    from functools import wraps

    def my_decorator(func):
        @wraps(func)  # Preserves func's metadata
        def wrapper(*args, **kwargs):
            return func(*args, **kwargs)
        return wrapper

    @my_decorator
    def example():
        """This is the docstring"""
        pass

    print(example.__name__)  # 'example' (not 'wrapper')
    print(example.__doc__)   # 'This is the docstring'
    ```

    ## Practical Decorators

    ### Timing Decorator

    ```python
    import time
    from functools import wraps

    def timing_decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            start = time.time()
            result = func(*args, **kwargs)
            end = time.time()
            print(f"{func.__name__} took {end - start:.4f} seconds")
            return result
        return wrapper

    @timing_decorator
    def slow_function():
        time.sleep(1)
        return "Done"

    slow_function()  # slow_function took 1.0001 seconds
    ```

    ### Caching/Memoization

    ```python
    from functools import lru_cache

    @lru_cache(maxsize=128)
    def fibonacci(n):
        if n < 2:
            return n
        return fibonacci(n-1) + fibonacci(n-2)

    # Much faster due to caching!
    print(fibonacci(100))
    ```

    ### Logging Decorator

    ```python
    import logging

    def log_calls(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            logging.info(f"Calling {func.__name__}")
            result = func(*args, **kwargs)
            logging.info(f"{func.__name__} returned {result}")
            return result
        return wrapper

    @log_calls
    def divide(a, b):
        return a / b
    ```

    ### Authentication Decorator

    ```python
    def require_auth(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            if not is_authenticated():
                raise PermissionError("Authentication required")
            return func(*args, **kwargs)
        return wrapper

    @require_auth
    def delete_user(user_id):
        # Only runs if authenticated
        pass
    ```

    ## Decorators with Parameters

    **Need an extra level of nesting:**

    ```python
    def repeat(times):
        def decorator(func):
            @wraps(func)
            def wrapper(*args, **kwargs):
                for _ in range(times):
                    result = func(*args, **kwargs)
                return result
            return wrapper
        return decorator

    @repeat(3)
    def greet(name):
        print(f"Hello, {name}!")

    greet("Alice")
    # Hello, Alice!
    # Hello, Alice!
    # Hello, Alice!
    ```

    ### Retry Decorator

    ```python
    import time

    def retry(max_attempts=3, delay=1):
        def decorator(func):
            @wraps(func)
            def wrapper(*args, **kwargs):
                for attempt in range(max_attempts):
                    try:
                        return func(*args, **kwargs)
                    except Exception as e:
                        if attempt == max_attempts - 1:
                            raise
                        print(f"Attempt {attempt + 1} failed, retrying...")
                        time.sleep(delay)
            return wrapper
        return decorator

    @retry(max_attempts=3, delay=2)
    def unstable_api_call():
        # May fail randomly
        pass
    ```

    ## Class Decorators

    **Decorators can also modify classes:**

    ```python
    def singleton(cls):
        instances = {}

        @wraps(cls)
        def get_instance(*args, **kwargs):
            if cls not in instances:
                instances[cls] = cls(*args, **kwargs)
            return instances[cls]

        return get_instance

    @singleton
    class Database:
        def __init__(self):
            print("Connecting to database...")

    db1 = Database()  # Connecting to database...
    db2 = Database()  # (no output - same instance)
    print(db1 is db2)  # True
    ```

    ## Stacking Decorators

    ```python
    @decorator1
    @decorator2
    @decorator3
    def my_function():
        pass

    # Equivalent to:
    # my_function = decorator1(decorator2(decorator3(my_function)))
    # Innermost decorator executes first
    ```

    ### Example: Stacked Decorators

    ```python
    @timing_decorator
    @log_calls
    @retry(max_attempts=3)
    def complex_operation():
        # Retries if fails, logs calls, times execution
        pass
    ```

    ## Built-in Decorators

    ### @property

    ```python
    class Circle:
        def __init__(self, radius):
            self._radius = radius

        @property
        def radius(self):
            return self._radius

        @radius.setter
        def radius(self, value):
            if value < 0:
                raise ValueError("Radius must be positive")
            self._radius = value

        @property
        def area(self):
            return 3.14159 * self._radius ** 2

    c = Circle(5)
    print(c.radius)  # 5 (calls getter)
    c.radius = 10    # Calls setter
    print(c.area)    # Computed property
    ```

    ### @staticmethod and @classmethod

    ```python
    class MathUtils:
        @staticmethod
        def add(a, b):
            return a + b  # No self, no cls

        @classmethod
        def from_string(cls, string):
            # Can create instances
            return cls(int(string))
    ```

    **Next**: We'll explore generators and the iteration protocol!
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 2: Lesson 2 ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 2',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Understanding Decorators

    **Decorators** are a powerful Python feature that allows you to modify or enhance functions and classes without changing their source code.

    ## Functions as First-Class Objects

    In Python, functions are first-class objects - they can be:
    - Assigned to variables
    - Passed as arguments
    - Returned from other functions
    - Stored in data structures

    ```python
    def greet(name):
        return f"Hello, {name}!"

    # Assign to variable
    say_hello = greet
    print(say_hello("Alice"))  # Hello, Alice!

    # Store in list
    functions = [greet, len, str]
    ```

    ## Higher-Order Functions

    Functions that take functions as arguments or return functions:

    ```python
    # Function that takes function as argument
    def apply_twice(func, arg):
        return func(func(arg))

    def add_five(x):
        return x + 5

    result = apply_twice(add_five, 10)  # (10 + 5) + 5 = 20

    # Function that returns function
    def make_multiplier(n):
        def multiplier(x):
            return x * n
        return multiplier

    times_three = make_multiplier(3)
    print(times_three(5))  # 15
    ```

    ## Closures

    **Inner functions that remember values from their enclosing scope**

    ```python
    def make_counter():
        count = 0  # Enclosed variable

        def counter():
            nonlocal count  # Access enclosing scope
            count += 1
            return count

        return counter

    # Each counter has its own closure
    counter1 = make_counter()
    counter2 = make_counter()

    print(counter1())  # 1
    print(counter1())  # 2
    print(counter2())  # 1 - independent counter
    ```

    ## Basic Decorator

    **Wrapper function that modifies behavior:**

    ```python
    def my_decorator(func):
        def wrapper():
            print("Before function call")
            result = func()
            print("After function call")
            return result
        return wrapper

    # Manual decoration
    def say_hello():
        print("Hello!")

    say_hello = my_decorator(say_hello)
    say_hello()
    # Output:
    # Before function call
    # Hello!
    # After function call
    ```

    ## The @ Syntax

    **Syntactic sugar for decorators:**

    ```python
    @my_decorator
    def say_hello():
        print("Hello!")

    # Equivalent to: say_hello = my_decorator(say_hello)
    ```

    ## Decorators with Arguments

    ```python
    # Decorator that accepts any arguments
    def my_decorator(func):
        def wrapper(*args, **kwargs):
            print(f"Called {func.__name__} with {args}, {kwargs}")
            result = func(*args, **kwargs)
            print(f"Returned {result}")
            return result
        return wrapper

    @my_decorator
    def add(a, b):
        return a + b

    add(2, 3)
    # Called add with (2, 3), {}
    # Returned 5
    ```

    ## Preserving Function Metadata

    ```python
    from functools import wraps

    def my_decorator(func):
        @wraps(func)  # Preserves func's metadata
        def wrapper(*args, **kwargs):
            return func(*args, **kwargs)
        return wrapper

    @my_decorator
    def example():
        """This is the docstring"""
        pass

    print(example.__name__)  # 'example' (not 'wrapper')
    print(example.__doc__)   # 'This is the docstring'
    ```

    ## Practical Decorators

    ### Timing Decorator

    ```python
    import time
    from functools import wraps

    def timing_decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            start = time.time()
            result = func(*args, **kwargs)
            end = time.time()
            print(f"{func.__name__} took {end - start:.4f} seconds")
            return result
        return wrapper

    @timing_decorator
    def slow_function():
        time.sleep(1)
        return "Done"

    slow_function()  # slow_function took 1.0001 seconds
    ```

    ### Caching/Memoization

    ```python
    from functools import lru_cache

    @lru_cache(maxsize=128)
    def fibonacci(n):
        if n < 2:
            return n
        return fibonacci(n-1) + fibonacci(n-2)

    # Much faster due to caching!
    print(fibonacci(100))
    ```

    ### Logging Decorator

    ```python
    import logging

    def log_calls(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            logging.info(f"Calling {func.__name__}")
            result = func(*args, **kwargs)
            logging.info(f"{func.__name__} returned {result}")
            return result
        return wrapper

    @log_calls
    def divide(a, b):
        return a / b
    ```

    ### Authentication Decorator

    ```python
    def require_auth(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            if not is_authenticated():
                raise PermissionError("Authentication required")
            return func(*args, **kwargs)
        return wrapper

    @require_auth
    def delete_user(user_id):
        # Only runs if authenticated
        pass
    ```

    ## Decorators with Parameters

    **Need an extra level of nesting:**

    ```python
    def repeat(times):
        def decorator(func):
            @wraps(func)
            def wrapper(*args, **kwargs):
                for _ in range(times):
                    result = func(*args, **kwargs)
                return result
            return wrapper
        return decorator

    @repeat(3)
    def greet(name):
        print(f"Hello, {name}!")

    greet("Alice")
    # Hello, Alice!
    # Hello, Alice!
    # Hello, Alice!
    ```

    ### Retry Decorator

    ```python
    import time

    def retry(max_attempts=3, delay=1):
        def decorator(func):
            @wraps(func)
            def wrapper(*args, **kwargs):
                for attempt in range(max_attempts):
                    try:
                        return func(*args, **kwargs)
                    except Exception as e:
                        if attempt == max_attempts - 1:
                            raise
                        print(f"Attempt {attempt + 1} failed, retrying...")
                        time.sleep(delay)
            return wrapper
        return decorator

    @retry(max_attempts=3, delay=2)
    def unstable_api_call():
        # May fail randomly
        pass
    ```

    ## Class Decorators

    **Decorators can also modify classes:**

    ```python
    def singleton(cls):
        instances = {}

        @wraps(cls)
        def get_instance(*args, **kwargs):
            if cls not in instances:
                instances[cls] = cls(*args, **kwargs)
            return instances[cls]

        return get_instance

    @singleton
    class Database:
        def __init__(self):
            print("Connecting to database...")

    db1 = Database()  # Connecting to database...
    db2 = Database()  # (no output - same instance)
    print(db1 is db2)  # True
    ```

    ## Stacking Decorators

    ```python
    @decorator1
    @decorator2
    @decorator3
    def my_function():
        pass

    # Equivalent to:
    # my_function = decorator1(decorator2(decorator3(my_function)))
    # Innermost decorator executes first
    ```

    ### Example: Stacked Decorators

    ```python
    @timing_decorator
    @log_calls
    @retry(max_attempts=3)
    def complex_operation():
        # Retries if fails, logs calls, times execution
        pass
    ```

    ## Built-in Decorators

    ### @property

    ```python
    class Circle:
        def __init__(self, radius):
            self._radius = radius

        @property
        def radius(self):
            return self._radius

        @radius.setter
        def radius(self, value):
            if value < 0:
                raise ValueError("Radius must be positive")
            self._radius = value

        @property
        def area(self):
            return 3.14159 * self._radius ** 2

    c = Circle(5)
    print(c.radius)  # 5 (calls getter)
    c.radius = 10    # Calls setter
    print(c.area)    # Computed property
    ```

    ### @staticmethod and @classmethod

    ```python
    class MathUtils:
        @staticmethod
        def add(a, b):
            return a + b  # No self, no cls

        @classmethod
        def from_string(cls, string):
            # Can create instances
            return cls(int(string))
    ```

    **Next**: We'll explore generators and the iteration protocol!
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 2 microlessons for Decorators Higher Order"
