# Pandas & NumPy Data Science Course - Based on StackExchange Demand
puts "Creating Pandas & NumPy Data Science Course..."

# Create Data Science Course
data_science_course = Course.find_or_create_by!(slug: 'pandas-numpy-data-science') do |course|
  course.title = 'Data Science with Pandas & NumPy'
  course.description = 'Master data analysis, manipulation, and scientific computing with Python's most popular libraries'
  course.difficulty_level = 'intermediate'
  course.certification_track = nil
  course.published = true
  course.sequence_order = 12
  course.estimated_hours = 28
  course.learning_objectives = JSON.generate([
    "Master NumPy arrays and vectorized operations",
    "Perform data manipulation with Pandas DataFrames",
    "Clean and prepare data for analysis",
    "Conduct exploratory data analysis (EDA)",
    "Visualize data effectively",
    "Apply statistical analysis techniques"
  ])
  course.prerequisites = JSON.generate([
    "Python programming fundamentals",
    "Basic mathematics and statistics knowledge"
  ])
end

puts "Created course: #{data_science_course.title}"

# ==========================================
# MODULE 1: NumPy Fundamentals
# ==========================================

module1 = CourseModule.find_or_create_by!(slug: 'numpy-fundamentals', course: data_science_course) do |mod|
  mod.title = 'NumPy Fundamentals'
  mod.description = 'Master NumPy arrays and vectorized operations'
  mod.sequence_order = 1
  mod.estimated_minutes = 100
  mod.published = true
end

lesson1_1 = CourseLesson.find_or_create_by!(title: "Introduction to NumPy") do |lesson|
  lesson.reading_time_minutes = 30
  lesson.content = <<~MARKDOWN
    # Introduction to NumPy

    NumPy (Numerical Python) is the foundation of scientific computing in Python, providing high-performance multidimensional arrays and mathematical functions.

    ## Why NumPy?

    **Vectorization**: Operations on entire arrays without loops
    - 10-100x faster than pure Python
    - C-optimized under the hood
    - Efficient memory usage

    ## NumPy Arrays

    ### Creating Arrays

    ```python
    import numpy as np

    # From list
    arr = np.array([1, 2, 3, 4, 5])
    print(arr)  # [1 2 3 4 5]

    # 2D array
    matrix = np.array([[1, 2, 3], [4, 5, 6]])
    print(matrix)
    # [[1 2 3]
    #  [4 5 6]]

    # Using built-in functions
    zeros = np.zeros((3, 4))        # 3x4 array of zeros
    ones = np.ones((2, 3))          # 2x3 array of ones
    empty = np.empty((2, 2))        # Uninitialized
    eye = np.eye(4)                 # 4x4 identity matrix

    # Ranges
    range_arr = np.arange(0, 10, 2)  # [0 2 4 6 8]
    linspace = np.linspace(0, 1, 5)   # 5 numbers from 0 to 1

    # Random
    random_arr = np.random.rand(3, 3)  # Uniform [0, 1)
    randn = np.random.randn(3, 3)      # Normal distribution
    randint = np.random.randint(0, 10, (3, 3))  # Random integers
    ```

    ### Array Properties

    ```python
    arr = np.array([[1, 2, 3], [4, 5, 6]])

    print(arr.shape)    # (2, 3) - dimensions
    print(arr.ndim)     # 2 - number of dimensions
    print(arr.size)     # 6 - total elements
    print(arr.dtype)    # int64 - data type
    print(arr.itemsize) # 8 - bytes per element
    ```

    ## Data Types

    ```python
    # Specify dtype
    int_arr = np.array([1, 2, 3], dtype=np.int32)
    float_arr = np.array([1, 2, 3], dtype=np.float64)
    bool_arr = np.array([True, False], dtype=np.bool_)

    # Convert types
    float_arr = int_arr.astype(np.float64)
    ```

    ## Indexing and Slicing

    ```python
    arr = np.array([0, 10, 20, 30, 40])

    # Basic indexing
    print(arr[0])      # 0
    print(arr[-1])     # 40

    # Slicing [start:stop:step]
    print(arr[1:4])    # [10 20 30]
    print(arr[::2])    # [0 20 40] - every 2nd element
    print(arr[::-1])   # [40 30 20 10 0] - reverse

    # 2D arrays
    matrix = np.array([[1, 2, 3],
                       [4, 5, 6],
                       [7, 8, 9]])

    print(matrix[0, 0])      # 1 - first row, first col
    print(matrix[1, :])      # [4 5 6] - second row
    print(matrix[:, 1])      # [2 5 8] - second column
    print(matrix[0:2, 1:3])  # Subarray
    ```

    ## Boolean Indexing

    ```python
    arr = np.array([1, 2, 3, 4, 5])

    # Create boolean mask
    mask = arr > 2
    print(mask)  # [False False  True  True  True]

    # Select elements
    print(arr[mask])  # [3 4 5]

    # Compact form
    print(arr[arr > 2])  # [3 4 5]

    # Multiple conditions
    print(arr[(arr > 1) & (arr < 5)])  # [2 3 4]
    ```

    ## Reshaping Arrays

    ```python
    arr = np.arange(12)  # [0 1 2 3 4 5 6 7 8 9 10 11]

    # Reshape to 2D
    reshaped = arr.reshape(3, 4)
    # [[ 0  1  2  3]
    #  [ 4  5  6  7]
    #  [ 8  9 10 11]]

    # Flatten
    flat = reshaped.flatten()  # [0 1 2 ... 11]
    flat = reshaped.ravel()    # Faster, returns view

    # Transpose
    transposed = reshaped.T
    ```

    ## Vectorized Operations

    **KEY ADVANTAGE**: No loops needed!

    ```python
    arr = np.array([1, 2, 3, 4, 5])

    # Arithmetic (element-wise)
    print(arr + 10)      # [11 12 13 14 15]
    print(arr * 2)       # [2 4 6 8 10]
    print(arr ** 2)      # [1 4 9 16 25]
    print(1 / arr)       # [1.  0.5  0.333...]

    # Array-array operations
    arr2 = np.array([5, 4, 3, 2, 1])
    print(arr + arr2)    # [6 6 6 6 6]
    print(arr * arr2)    # [5 8 9 8 5]

    # Comparisons
    print(arr > 3)       # [False False False  True  True]
    ```

    ### Performance Comparison

    ```python
    import time

    # Pure Python
    python_list = list(range(1000000))
    start = time.time()
    result = [x * 2 for x in python_list]
    print(f"Python: {time.time() - start:.4f}s")

    # NumPy
    numpy_arr = np.arange(1000000)
    start = time.time()
    result = numpy_arr * 2
    print(f"NumPy: {time.time() - start:.4f}s")

    # NumPy is 10-100x faster!
    ```

    ## Mathematical Functions

    ```python
    arr = np.array([1, 4, 9, 16, 25])

    # Universal functions (ufuncs)
    print(np.sqrt(arr))       # [1. 2. 3. 4. 5.]
    print(np.exp(arr))        # Exponential
    print(np.log(arr))        # Natural log
    print(np.sin(arr))        # Sine
    print(np.abs(arr))        # Absolute value

    # Aggregations
    arr = np.array([1, 2, 3, 4, 5])
    print(arr.sum())          # 15
    print(arr.mean())         # 3.0
    print(arr.std())          # Standard deviation
    print(arr.min())          # 1
    print(arr.max())          # 5
    print(arr.argmax())       # 4 - index of max value
    ```

    ## Broadcasting

    **Operate on arrays of different shapes**

    ```python
    # Add scalar to array
    arr = np.array([[1, 2, 3],
                    [4, 5, 6]])
    print(arr + 10)
    # [[11 12 13]
    #  [14 15 16]]

    # Add row to matrix
    row = np.array([1, 0, 1])
    print(arr + row)
    # [[2 2 4]
    #  [5 5 7]]

    # Add column to matrix
    col = np.array([[10], [20]])
    print(arr + col)
    # [[11 12 13]
    #  [24 25 26]]
    ```

    **Next**: We'll explore Pandas DataFrames for structured data.
  MARKDOWN
  lesson.key_concepts = ['NumPy arrays', 'vectorization', 'indexing', 'slicing', 'broadcasting', 'ufuncs']
end

ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_1) do |item|
  item.sequence_order = 1
  item.required = true
end

quiz1 = Quiz.find_or_create_by!(title: "NumPy Fundamentals Quiz") do |quiz|
  quiz.description = 'Test your NumPy knowledge'
  quiz.time_limit_minutes = 20
  quiz.passing_score = 70
end

[
  {
    question_text: "What is the main advantage of NumPy arrays over Python lists?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "Vectorized operations are much faster", correct: true },
      { text: "They can store more data", correct: false },
      { text: "They are easier to create", correct: false },
      { text: "They use more memory", correct: false }
    ]),
    explanation: "NumPy arrays support vectorized operations that are implemented in C, making them 10-100x faster than Python list comprehensions.",
    difficulty_level: "easy"
  },
  {
    question_text: "What does arr.reshape(3, 4) do to a 12-element array?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "Creates a 3x4 matrix", correct: true },
      { text: "Creates a 4x3 matrix", correct: false },
      { text: "Adds 12 elements", correct: false },
      { text: "Returns an error", correct: false }
    ]),
    explanation: "reshape(3, 4) reorganizes the array into 3 rows and 4 columns, requiring exactly 12 elements (3 × 4 = 12).",
    difficulty_level: "easy"
  },
  {
    question_text: "What is broadcasting in NumPy?",
    question_type: "fill_blank",
    points: 10,
    correct_answer: "operating on arrays of different shapes|operations on different shaped arrays",
    explanation: "Broadcasting allows NumPy to perform operations on arrays of different shapes by automatically expanding smaller arrays.",
    difficulty_level: "medium"
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer] if q_data[:correct_answer]
    question.explanation = q_data[:explanation]
    question.difficulty_level = q_data[:difficulty_level]
  end
end

ModuleItem.find_or_create_by!(course_module: module1, item: quiz1) do |item|
  item.sequence_order = 2
  item.required = true
end

puts "  ✅ Created module: #{module1.title}"

# ==========================================
# MODULE 2: Pandas DataFrames
# ==========================================

module2 = CourseModule.find_or_create_by!(slug: 'pandas-dataframes', course: data_science_course) do |mod|
  mod.title = 'Pandas DataFrames'
  mod.description = 'Master data manipulation with Pandas'
  mod.sequence_order = 2
  mod.estimated_minutes = 120
  mod.published = true
end

lesson2_1 = CourseLesson.find_or_create_by!(title: "Pandas DataFrame Basics") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # Pandas DataFrame Basics

    Pandas provides high-performance data structures for data analysis, built on top of NumPy.

    ## DataFrame Structure

    **2D labeled data structure with columns of potentially different types**

    ```python
    import pandas as pd

    # Create from dictionary
    data = {
        'name': ['Alice', 'Bob', 'Charlie', 'David'],
        'age': [25, 30, 35, 28],
        'city': ['NY', 'LA', 'Chicago', 'Houston'],
        'salary': [70000, 80000, 90000, 75000]
    }

    df = pd.DataFrame(data)
    print(df)
    #       name  age     city  salary
    # 0    Alice   25       NY   70000
    # 1      Bob   30       LA   80000
    # 2  Charlie   35  Chicago   90000
    # 3    David   28  Houston   75000
    ```

    ### Creating DataFrames

    ```python
    # From CSV
    df = pd.read_csv('data.csv')

    # From Excel
    df = pd.read_excel('data.xlsx', sheet_name='Sheet1')

    # From dictionary of arrays
    df = pd.DataFrame({
        'A': np.arange(4),
        'B': np.random.randn(4)
    })

    # From list of dictionaries
    data = [
        {'a': 1, 'b': 2},
        {'a': 5, 'b': 10}
    ]
    df = pd.DataFrame(data)

    # From NumPy array
    arr = np.array([[1, 2], [3, 4]])
    df = pd.DataFrame(arr, columns=['A', 'B'])
    ```

    ## Exploring Data

    ```python
    # First/last rows
    df.head()          # First 5 rows
    df.head(10)        # First 10 rows
    df.tail(3)         # Last 3 rows

    # Basic info
    df.info()          # Column types, non-null counts
    df.describe()      # Statistical summary
    df.shape           # (rows, cols)
    df.columns         # Column names
    df.index           # Row indices
    df.dtypes          # Data types

    # Quick stats
    df.mean()          # Mean of numeric columns
    df.median()
    df.std()           # Standard deviation
    df.count()         # Non-null count
    df.min()
    df.max()
    ```

    ## Selecting Data

    ### Columns

    ```python
    # Single column (returns Series)
    ages = df['age']

    # Multiple columns (returns DataFrame)
    subset = df[['name', 'salary']]

    # New column
    df['bonus'] = df['salary'] * 0.1
    ```

    ### Rows

    ```python
    # By position (iloc)
    first_row = df.iloc[0]           # First row
    first_3 = df.iloc[0:3]           # First 3 rows
    specific = df.iloc[[0, 2, 4]]    # Rows 0, 2, 4

    # By label (loc)
    row = df.loc[0]                  # Row with index 0
    rows = df.loc[0:2]               # Inclusive!

    # Boolean indexing
    high_salary = df[df['salary'] > 75000]
    young = df[df['age'] < 30]

    # Multiple conditions
    result = df[(df['age'] > 25) & (df['salary'] > 70000)]
    ```

    ### Cell Access

    ```python
    # At specific position
    value = df.iloc[0, 1]           # Row 0, column 1

    # By label
    value = df.loc[0, 'age']        # Row 0, 'age' column

    # Fast access
    value = df.at[0, 'age']         # Faster for single value
    ```

    ## Filtering Data

    ```python
    # Simple filter
    df_filtered = df[df['age'] > 30]

    # Multiple conditions
    df_filtered = df[
        (df['age'] > 25) &
        (df['city'] == 'NY') |
        (df['salary'] > 80000)
    ]

    # String methods
    df_filtered = df[df['name'].str.contains('A')]
    df_filtered = df[df['name'].str.startswith('B')]

    # isin() for multiple values
    cities = ['NY', 'LA']
    df_filtered = df[df['city'].isin(cities)]

    # NOT operator
    df_filtered = df[~df['city'].isin(cities)]
    ```

    ## Sorting

    ```python
    # By single column
    df_sorted = df.sort_values('age')

    # Descending
    df_sorted = df.sort_values('salary', ascending=False)

    # Multiple columns
    df_sorted = df.sort_values(['city', 'age'])

    # Sort index
    df_sorted = df.sort_index()
    ```

    ## Handling Missing Data

    ```python
    # Check for missing data
    df.isnull()          # Boolean DataFrame
    df.isnull().sum()    # Count per column
    df.notnull()         # Inverse

    # Drop missing
    df.dropna()          # Drop rows with any NaN
    df.dropna(subset=['age'])  # Drop if 'age' is NaN
    df.dropna(axis=1)    # Drop columns with NaN

    # Fill missing
    df.fillna(0)         # Fill with 0
    df.fillna(method='ffill')  # Forward fill
    df.fillna(method='bfill')  # Backward fill
    df['age'].fillna(df['age'].mean())  # Fill with mean
    ```

    ## Grouping and Aggregation

    ```python
    # Group by single column
    grouped = df.groupby('city')

    # Aggregate functions
    grouped.mean()       # Mean per group
    grouped.sum()
    grouped.count()
    grouped.max()
    grouped.min()

    # Multiple aggregations
    grouped.agg({
        'salary': ['mean', 'max', 'min'],
        'age': 'mean'
    })

    # Group by multiple columns
    grouped = df.groupby(['city', 'department'])
    ```

    ## Applying Functions

    ```python
    # Apply to column
    df['age_doubled'] = df['age'].apply(lambda x: x * 2)

    # Apply to row
    df.apply(lambda row: row['salary'] / row['age'], axis=1)

    # Apply to DataFrame
    df.applymap(lambda x: x * 2)  # To every element
    ```

    ## Merging DataFrames

    ```python
    # Sample data
    df1 = pd.DataFrame({'id': [1, 2, 3], 'value': [10, 20, 30]})
    df2 = pd.DataFrame({'id': [1, 2, 4], 'score': [100, 200, 400]})

    # Merge (SQL-like join)
    merged = pd.merge(df1, df2, on='id', how='inner')
    # id  value  score
    #  1     10    100
    #  2     20    200

    # Join types: 'inner', 'outer', 'left', 'right'
    merged = pd.merge(df1, df2, on='id', how='outer')

    # Concatenate
    pd.concat([df1, df2])        # Vertically (rows)
    pd.concat([df1, df2], axis=1) # Horizontally (columns)
    ```

    ## Pivot Tables

    ```python
    # Create pivot table
    pivot = df.pivot_table(
        values='salary',
        index='city',
        columns='department',
        aggfunc='mean'
    )

    # Multiple aggregations
    pivot = df.pivot_table(
        values='salary',
        index='city',
        aggfunc=['mean', 'sum', 'count']
    )
    ```

    **Next**: We'll cover data cleaning and preparation techniques.
  MARKDOWN
  lesson.key_concepts = ['DataFrame', 'Series', 'indexing', 'filtering', 'groupby', 'merge', 'pivot table']
end

ModuleItem.find_or_create_by!(course_module: module2, item: lesson2_1) do |item|
  item.sequence_order = 1
  item.required = true
end

puts "  ✅ Created module: #{module2.title}"

puts "\n✅ Pandas & NumPy Data Science Course Created!"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
puts "📚 Course: #{data_science_course.title}"
puts "📖 Modules: #{data_science_course.course_modules.count}"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
