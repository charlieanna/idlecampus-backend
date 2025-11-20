# Python Code Labs - Seed Data
# These are coding editor-based labs for learning Python

puts "Creating Python Code Labs..."

# Lab 1: List Comprehensions
python_lab_1 = HandsOnLab.create!(
  title: 'Python List Comprehensions',
  description: 'Master list comprehensions to transform and filter data efficiently in Python',
  lab_type: 'python',
  lab_format: 'code_editor',
  programming_language: 'python',
  difficulty: 'easy',
  estimated_minutes: 15,
  points_reward: 100,
  max_attempts: 10,
  time_limit_seconds: 5,
  memory_limit_mb: 128,
  published: true,
  sequence_order: 1,

  starter_code: <<~PYTHON,
    def filter_even_numbers(numbers):
        """
        Given a list of numbers, return a new list containing only even numbers.
        Use a list comprehension to solve this problem.

        Args:
            numbers: List of integers

        Returns:
            List of even integers

        Example:
            >>> filter_even_numbers([1, 2, 3, 4, 5, 6])
            [2, 4, 6]
        """
        # Your code here
        pass
  PYTHON

  solution_code: <<~PYTHON,
    def filter_even_numbers(numbers):
        """
        Given a list of numbers, return a new list containing only even numbers.
        Use a list comprehension to solve this problem.

        Args:
            numbers: List of integers

        Returns:
            List of even integers
        """
        return [n for n in numbers if n % 2 == 0]
  PYTHON

  test_cases: [
    {
      description: 'Filter even numbers from mixed list',
      input: 'print(filter_even_numbers([1, 2, 3, 4, 5, 6]))',
      expected_output: '[2, 4, 6]',
      hidden: false
    },
    {
      description: 'Empty list',
      input: 'print(filter_even_numbers([]))',
      expected_output: '[]',
      hidden: false
    },
    {
      description: 'All odd numbers',
      input: 'print(filter_even_numbers([1, 3, 5, 7]))',
      expected_output: '[]',
      hidden: false
    },
    {
      description: 'Large numbers',
      input: 'print(filter_even_numbers([100, 101, 200, 201, 300]))',
      expected_output: '[100, 200, 300]',
      hidden: true
    },
    {
      description: 'Negative numbers',
      input: 'print(filter_even_numbers([-4, -3, -2, -1, 0, 1, 2]))',
      expected_output: '[-4, -2, 0, 2]',
      hidden: true
    }
  ],

  steps: [
    {
      step_number: 1,
      instruction: 'Implement filter_even_numbers using a list comprehension',
      hint: 'Use the modulo operator (%) to check if a number is even. A number is even if n % 2 == 0',
      description: 'Create a list comprehension that filters even numbers'
    }
  ],

  allowed_imports: [],
  is_active: true
)

# Lab 2: Dictionary Operations
python_lab_2 = HandsOnLab.create!(
  title: 'Python Dictionary Transformations',
  description: 'Learn to manipulate dictionaries and transform data structures in Python',
  lab_type: 'python',
  lab_format: 'code_editor',
  programming_language: 'python',
  difficulty: 'medium',
  estimated_minutes: 20,
  points_reward: 150,
  max_attempts: 10,
  time_limit_seconds: 5,
  memory_limit_mb: 128,
  published: true,
  sequence_order: 2,

  starter_code: <<~PYTHON,
    def count_word_frequency(text):
        """
        Count the frequency of each word in the given text.
        Return a dictionary where keys are words and values are their counts.
        Words should be case-insensitive and stripped of punctuation.

        Args:
            text: String containing words

        Returns:
            Dictionary with word frequencies

        Example:
            >>> count_word_frequency("Hello world hello")
            {'hello': 2, 'world': 1}
        """
        # Your code here
        pass
  PYTHON

  solution_code: <<~PYTHON,
    def count_word_frequency(text):
        """
        Count the frequency of each word in the given text.
        """
        import re
        # Remove punctuation and convert to lowercase
        words = re.findall(r'\\w+', text.lower())

        # Count frequencies
        frequency = {}
        for word in words:
            frequency[word] = frequency.get(word, 0) + 1

        return frequency
  PYTHON

  test_cases: [
    {
      description: 'Count words in simple text',
      input: 'print(count_word_frequency("Hello world hello"))',
      expected_output: "{'hello': 2, 'world': 1}",
      hidden: false
    },
    {
      description: 'Handle punctuation',
      input: 'print(count_word_frequency("Hello, world! Hello."))',
      expected_output: "{'hello': 2, 'world': 1}",
      hidden: false
    },
    {
      description: 'Empty string',
      input: 'print(count_word_frequency(""))',
      expected_output: '{}',
      hidden: false
    },
    {
      description: 'Multiple words with different cases',
      input: 'print(count_word_frequency("The quick brown fox jumps over the lazy dog"))',
      expected_output: "{'the': 2, 'quick': 1, 'brown': 1, 'fox': 1, 'jumps': 1, 'over': 1, 'lazy': 1, 'dog': 1}",
      hidden: true
    }
  ],

  steps: [
    {
      step_number: 1,
      instruction: 'Parse text into words, handling punctuation and case',
      hint: 'Use the re.findall() function with pattern r\'\\w+\' to extract words',
      description: 'Extract words from text'
    },
    {
      step_number: 2,
      instruction: 'Count occurrences of each word',
      hint: 'Use a dictionary and the .get() method to track counts',
      description: 'Build frequency dictionary'
    }
  ],

  allowed_imports: ['re'],
  is_active: true
)

# Lab 3: Function Decorators
python_lab_3 = HandsOnLab.create!(
  title: 'Python Function Decorators',
  description: 'Understand and implement function decorators for code reusability',
  lab_type: 'python',
  lab_format: 'code_editor',
  programming_language: 'python',
  difficulty: 'hard',
  estimated_minutes: 30,
  points_reward: 200,
  max_attempts: 15,
  time_limit_seconds: 5,
  memory_limit_mb: 128,
  published: true,
  sequence_order: 3,

  starter_code: <<~PYTHON,
    import time

    def timing_decorator(func):
        """
        Create a decorator that measures and prints the execution time of a function.
        The decorator should print: "Function <name> took <time> seconds"

        Args:
            func: Function to be decorated

        Returns:
            Wrapped function

        Example:
            @timing_decorator
            def slow_function():
                time.sleep(1)

            slow_function()  # Prints: Function slow_function took 1.00 seconds
        """
        # Your code here
        pass
  PYTHON

  solution_code: <<~PYTHON,
    import time

    def timing_decorator(func):
        """
        Create a decorator that measures and prints the execution time of a function.
        """
        def wrapper(*args, **kwargs):
            start_time = time.time()
            result = func(*args, **kwargs)
            end_time = time.time()
            execution_time = end_time - start_time
            print(f"Function {func.__name__} took {execution_time:.2f} seconds")
            return result
        return wrapper
  PYTHON

  test_cases: [
    {
      description: 'Decorator measures execution time',
      input: <<~PYTHON.strip,
        @timing_decorator
        def quick_function():
            return "done"

        result = quick_function()
        print(result)
      PYTHON
      expected_output: /Function quick_function took .* seconds\ndone/,
      hidden: false
    },
    {
      description: 'Decorator works with arguments',
      input: <<~PYTHON.strip,
        @timing_decorator
        def add(a, b):
            return a + b

        result = add(2, 3)
        print(result)
      PYTHON
      expected_output: /Function add took .* seconds\n5/,
      hidden: false
    }
  ],

  steps: [
    {
      step_number: 1,
      instruction: 'Create wrapper function inside the decorator',
      hint: 'The wrapper should accept *args and **kwargs to handle any function signature',
      description: 'Define inner wrapper function'
    },
    {
      step_number: 2,
      instruction: 'Measure execution time using time.time()',
      hint: 'Record start time before calling func, end time after, then calculate difference',
      description: 'Implement timing logic'
    },
    {
      step_number: 3,
      instruction: 'Print timing information and return result',
      hint: 'Use f-string to format output: f"Function {func.__name__} took {time:.2f} seconds"',
      description: 'Format and display results'
    }
  ],

  allowed_imports: ['time'],
  is_active: true
)

# Lab 4: File Processing
python_lab_4 = HandsOnLab.create!(
  title: 'Python File Processing',
  description: 'Work with files and process text data line by line',
  lab_type: 'python',
  lab_format: 'code_editor',
  programming_language: 'python',
  difficulty: 'medium',
  estimated_minutes: 25,
  points_reward: 150,
  max_attempts: 10,
  time_limit_seconds: 5,
  memory_limit_mb: 128,
  published: true,
  sequence_order: 4,

  starter_code: <<~PYTHON,
    def count_lines_and_words(text):
        """
        Count the number of lines and words in the given text.
        Return a dictionary with 'lines' and 'words' keys.

        Args:
            text: String containing multiple lines

        Returns:
            Dictionary with line count and word count

        Example:
            >>> count_lines_and_words("Hello world\\nPython is great")
            {'lines': 2, 'words': 5}
        """
        # Your code here
        pass
  PYTHON

  solution_code: <<~PYTHON,
    def count_lines_and_words(text):
        """
        Count the number of lines and words in the given text.
        """
        lines = text.split('\\n')
        line_count = len(lines)

        word_count = 0
        for line in lines:
            words = line.split()
            word_count += len(words)

        return {'lines': line_count, 'words': word_count}
  PYTHON

  test_cases: [
    {
      description: 'Count lines and words in simple text',
      input: 'print(count_lines_and_words("Hello world\\nPython is great"))',
      expected_output: "{'lines': 2, 'words': 5}",
      hidden: false
    },
    {
      description: 'Single line',
      input: 'print(count_lines_and_words("Hello world"))',
      expected_output: "{'lines': 1, 'words': 2}",
      hidden: false
    },
    {
      description: 'Empty string',
      input: 'print(count_lines_and_words(""))',
      expected_output: "{'lines': 1, 'words': 0}",
      hidden: false
    },
    {
      description: 'Multiple lines with varying word counts',
      input: 'print(count_lines_and_words("Line one\\nLine two has more words\\nThree"))',
      expected_output: "{'lines': 3, 'words': 8}",
      hidden: true
    }
  ],

  steps: [
    {
      step_number: 1,
      instruction: 'Split text into lines',
      hint: 'Use the .split() method with "\\n" as delimiter',
      description: 'Parse lines from text'
    },
    {
      step_number: 2,
      instruction: 'Count words in each line',
      hint: 'For each line, use .split() without arguments to split on whitespace',
      description: 'Count total words'
    }
  ],

  allowed_imports: [],
  is_active: true
)

puts "Created #{HandsOnLab.code_editor_labs.python_labs.count} Python code labs"
puts "Python labs: #{HandsOnLab.python_labs.pluck(:title).join(', ')}"
