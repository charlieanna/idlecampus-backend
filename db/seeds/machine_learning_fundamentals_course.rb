# Machine Learning Fundamentals Course - Based on StackExchange Demand
puts "Creating Machine Learning Fundamentals Course..."

# Create ML Course
ml_course = Course.find_or_create_by!(slug: 'machine-learning-fundamentals') do |course|
  course.title = 'Machine Learning Fundamentals'
  course.description = 'Master supervised and unsupervised learning algorithms with hands-on Python implementations'
  course.difficulty_level = 'intermediate'
  course.certification_track = nil
  course.published = true
  course.sequence_order = 17
  course.estimated_hours = 50
  course.learning_objectives = JSON.generate([
    "Understand ML concepts and workflow",
    "Implement linear and logistic regression",
    "Build decision trees and random forests",
    "Apply clustering and dimensionality reduction",
    "Evaluate model performance",
    "Deploy ML models"
  ])
  course.prerequisites = JSON.generate([
    "Python programming",
    "NumPy and Pandas basics",
    "Basic statistics and linear algebra"
  ])
end

puts "Created course: #{ml_course.title}"

# ========================================
# Module 1: Introduction to Machine Learning
# ========================================

module1 = CourseModule.find_or_create_by!(slug: 'ml-introduction', course: ml_course) do |mod|
  mod.title = 'Introduction to Machine Learning'
  mod.description = 'ML concepts, types, and workflow'
  mod.sequence_order = 1
  mod.estimated_minutes = 120
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Understand what machine learning is",
    "Distinguish between ML types and paradigms",
    "Learn the ML workflow and best practices",
    "Set up Python environment for ML"
  ])
end

# Lesson 1.1: What is Machine Learning?
lesson1_1 = CourseLesson.create!(
  title: "What is Machine Learning?",
  content: <<~MARKDOWN,
    # What is Machine Learning?

    Machine Learning (ML) is a subset of artificial intelligence that enables computers to learn from data without being explicitly programmed.

    ## Traditional Programming vs Machine Learning

    ### Traditional Programming
    ```
    Input + Program → Output
    Example: Calculate tax = income * tax_rate
    ```

    ### Machine Learning
    ```
    Input + Output → Program (Model)
    Example: Given house features and prices, learn to predict prices
    ```

    ## Why Machine Learning?

    ### 1. Problems Too Complex to Program
    - Image recognition
    - Speech recognition
    - Natural language understanding
    - Handwriting recognition

    ### 2. Adaptive Systems
    - Email spam filters that adapt to new spam techniques
    - Recommendation systems that learn user preferences
    - Trading algorithms that adapt to market conditions

    ### 3. Data Mining
    - Discover patterns in large datasets
    - Customer segmentation
    - Fraud detection
    - Medical diagnosis

    ## Types of Machine Learning

    ### 1. Supervised Learning
    **Learn from labeled data**

    - Input: Features (X)
    - Output: Labels (y)
    - Goal: Learn mapping f: X → y

    **Examples:**
    - Email classification (spam/not spam)
    - House price prediction
    - Image classification
    - Medical diagnosis

    **Common Algorithms:**
    - Linear Regression
    - Logistic Regression
    - Decision Trees
    - Random Forests
    - Support Vector Machines (SVM)
    - Neural Networks

    ### 2. Unsupervised Learning
    **Learn from unlabeled data**

    - Input: Features (X) only
    - No labels
    - Goal: Find hidden patterns or structure

    **Examples:**
    - Customer segmentation
    - Anomaly detection
    - Dimensionality reduction
    - Topic modeling

    **Common Algorithms:**
    - K-Means Clustering
    - Hierarchical Clustering
    - DBSCAN
    - PCA (Principal Component Analysis)
    - t-SNE

    ### 3. Reinforcement Learning
    **Learn from interaction with environment**

    - Agent takes actions
    - Receives rewards/penalties
    - Goal: Maximize cumulative reward

    **Examples:**
    - Game playing (AlphaGo)
    - Robotics
    - Self-driving cars
    - Resource optimization

    ## The Machine Learning Workflow

    ### 1. Problem Definition
    - What are we trying to predict?
    - What type of ML problem is this?
    - What metrics will we use?

    ### 2. Data Collection
    - Gather relevant data
    - More data often = better models
    - Ensure data quality

    ### 3. Data Exploration (EDA)
    - Visualize distributions
    - Check for missing values
    - Identify outliers
    - Understand relationships

    ### 4. Data Preprocessing
    - Handle missing values
    - Encode categorical variables
    - Feature scaling/normalization
    - Feature engineering

    ### 5. Train/Test Split
    - Split data into training and testing sets
    - Typical split: 70-80% train, 20-30% test
    - Use cross-validation for robust evaluation

    ### 6. Model Selection
    - Choose appropriate algorithm
    - Consider complexity vs performance
    - Start simple, then increase complexity

    ### 7. Model Training
    - Fit model to training data
    - Tune hyperparameters
    - Use validation set or cross-validation

    ### 8. Model Evaluation
    - Test on unseen data
    - Calculate performance metrics
    - Compare with baseline

    ### 9. Model Deployment
    - Deploy to production
    - Monitor performance
    - Retrain as needed

    ## Key Concepts

    ### Features (X)
    Input variables used to make predictions

    ```python
    # Example: House price prediction
    features = [
        'square_feet',
        'num_bedrooms',
        'num_bathrooms',
        'age',
        'location'
    ]
    ```

    ### Labels (y)
    The target variable we're trying to predict

    ```python
    # Example: House price prediction
    label = 'price'
    ```

    ### Training Set
    Data used to train the model (learn patterns)

    ### Test Set
    Data used to evaluate model performance (unseen data)

    ### Validation Set
    Data used to tune hyperparameters (separate from test)

    ### Overfitting
    Model learns training data too well, performs poorly on new data

    ```
    Training accuracy: 99%
    Test accuracy: 60%  ← Overfitting!
    ```

    **Solutions:**
    - Use more training data
    - Reduce model complexity
    - Regularization
    - Cross-validation
    - Early stopping

    ### Underfitting
    Model is too simple to capture patterns

    ```
    Training accuracy: 65%
    Test accuracy: 63%  ← Underfitting!
    ```

    **Solutions:**
    - Increase model complexity
    - Add more features
    - Train longer
    - Reduce regularization

    ### Bias-Variance Tradeoff

    **High Bias (Underfitting)**
    - Model is too simple
    - Poor performance on train and test

    **High Variance (Overfitting)**
    - Model is too complex
    - Great on train, poor on test

    **Sweet Spot**
    - Balanced complexity
    - Good performance on both

    ## When to Use Machine Learning

    ### ✅ Good Fit for ML
    - Pattern exists but hard to code explicitly
    - Lots of data available
    - Problem can be framed as prediction/classification
    - Examples: spam detection, recommendation systems

    ### ❌ Not Good Fit for ML
    - Simple rule-based solution exists
    - Little data available
    - Need 100% accuracy (safety-critical)
    - Interpretability is crucial
    - Examples: basic calculator, if-else rules

    ## ML vs Related Fields

    ### Machine Learning vs Statistics
    - **Statistics**: Focus on inference, understanding relationships
    - **ML**: Focus on prediction, generalization to new data
    - Significant overlap in techniques

    ### Machine Learning vs Deep Learning
    - **ML**: Includes all learning algorithms
    - **Deep Learning**: Subset using neural networks with many layers
    - DL excels at unstructured data (images, text, audio)

    ### Machine Learning vs Data Science
    - **Data Science**: Broader field including ML, statistics, visualization
    - **ML**: Focus on building predictive models
    - Data scientists use ML as one tool among many

    ## Real-World Applications

    ### Computer Vision
    - Face recognition
    - Object detection
    - Medical image analysis
    - Autonomous vehicles

    ### Natural Language Processing
    - Machine translation
    - Sentiment analysis
    - Chatbots
    - Text summarization

    ### Healthcare
    - Disease diagnosis
    - Drug discovery
    - Patient risk prediction
    - Medical imaging

    ### Finance
    - Fraud detection
    - Credit scoring
    - Algorithmic trading
    - Risk assessment

    ### E-commerce
    - Product recommendations
    - Customer segmentation
    - Price optimization
    - Churn prediction

    ## Getting Started with ML in Python

    ### Essential Libraries

    ```python
    # Data manipulation
    import numpy as np
    import pandas as pd

    # Visualization
    import matplotlib.pyplot as plt
    import seaborn as sns

    # Machine Learning
    from sklearn.model_selection import train_test_split
    from sklearn.preprocessing import StandardScaler
    from sklearn.linear_model import LinearRegression
    from sklearn.metrics import mean_squared_error, r2_score

    # Deep Learning (optional)
    import tensorflow as tf
    import torch
    ```

    ### Basic ML Example

    ```python
    import numpy as np
    from sklearn.linear_model import LinearRegression
    from sklearn.model_selection import train_test_split
    from sklearn.metrics import mean_squared_error

    # Generate sample data
    np.random.seed(42)
    X = np.random.rand(100, 1) * 10  # Feature
    y = 2 * X + 1 + np.random.randn(100, 1) * 2  # Target with noise

    # Split data
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )

    # Create and train model
    model = LinearRegression()
    model.fit(X_train, y_train)

    # Make predictions
    y_pred = model.predict(X_test)

    # Evaluate
    mse = mean_squared_error(y_test, y_pred)
    print(f"Mean Squared Error: {mse:.2f}")

    # Model parameters
    print(f"Coefficient: {model.coef_[0][0]:.2f}")
    print(f"Intercept: {model.intercept_[0]:.2f}")
    ```

    ## Ethical Considerations

    ### Bias and Fairness
    - Models can perpetuate or amplify biases in training data
    - Test for fairness across different groups
    - Consider societal impact

    ### Privacy
    - Protect sensitive personal information
    - Use anonymization and encryption
    - Comply with regulations (GDPR, CCPA)

    ### Transparency
    - Explain model decisions when possible
    - Use interpretable models for critical applications
    - Document limitations

    ### Safety and Security
    - Test thoroughly before deployment
    - Monitor for adversarial attacks
    - Have fallback mechanisms

    ## Key Takeaways

    1. **ML learns from data** - No explicit programming of rules
    2. **Three main types** - Supervised, unsupervised, reinforcement
    3. **Workflow is iterative** - Experiment, evaluate, improve
    4. **Overfitting vs underfitting** - Balance model complexity
    5. **More data helps** - Generally leads to better models
    6. **Start simple** - Simple models before complex ones
    7. **Evaluate properly** - Use separate test set
    8. **Consider ethics** - Bias, privacy, transparency
    9. **Python is standard** - scikit-learn, TensorFlow, PyTorch
    10. **Practice is key** - Work on real projects to learn

    ## Next Steps

    - Set up Python environment with ML libraries
    - Download datasets from Kaggle or UCI ML Repository
    - Start with simple regression/classification problems
    - Join ML communities (r/MachineLearning, Kaggle)
    - Take online courses (Coursera, fast.ai)
    - Read research papers (arxiv.org)
    - Build projects and share on GitHub

    Remember: **Machine Learning is learned by doing!**
  MARKDOWN
  course_module: module1,
  sequence_order: 1,
  estimated_minutes: 50,
  published: true
)

# Lesson 1.2: Python for Machine Learning
lesson1_2 = CourseLesson.create!(
  title: "Python Setup and Essential Libraries",
  content: <<~MARKDOWN,
    # Python Setup and Essential Libraries

    Python is the dominant language for machine learning due to its simplicity and extensive ecosystem of libraries.

    ## Setting Up Your Environment

    ### Option 1: Anaconda (Recommended for Beginners)

    Anaconda is a distribution that includes Python and many ML libraries pre-installed.

    **Installation:**
    1. Download from [anaconda.com](https://www.anaconda.com/download)
    2. Run installer
    3. Verify installation:

    ```bash
    conda --version
    python --version
    ```

    **Create ML environment:**
    ```bash
    conda create -n ml_env python=3.10
    conda activate ml_env
    conda install numpy pandas scikit-learn matplotlib seaborn jupyter
    ```

    ### Option 2: pip and Virtual Environment

    ```bash
    # Create virtual environment
    python -m venv ml_env

    # Activate
    # On Mac/Linux:
    source ml_env/bin/activate
    # On Windows:
    ml_env\\Scripts\\activate

    # Install libraries
    pip install numpy pandas scikit-learn matplotlib seaborn jupyter
    ```

    ### Option 3: Google Colab (Cloud-based, Free)

    - Go to [colab.research.google.com](https://colab.research.google.com)
    - No installation needed
    - Free GPU access
    - Great for learning

    ## Essential Libraries

    ### 1. NumPy - Numerical Computing

    **Purpose:** Fast numerical operations on arrays

    ```python
    import numpy as np

    # Create arrays
    arr = np.array([1, 2, 3, 4, 5])
    matrix = np.array([[1, 2], [3, 4]])

    # Operations
    print(arr * 2)  # [2 4 6 8 10]
    print(arr.mean())  # 3.0
    print(matrix.shape)  # (2, 2)

    # Useful functions
    np.random.rand(3, 3)  # Random 3x3 matrix
    np.zeros((2, 3))  # 2x3 matrix of zeros
    np.ones((3, 2))  # 3x2 matrix of ones
    np.arange(0, 10, 2)  # [0 2 4 6 8]
    np.linspace(0, 1, 5)  # 5 evenly spaced values
    ```

    **Why it matters for ML:**
    - ML models work with numerical arrays
    - Fast vectorized operations
    - Matrix operations for linear algebra

    ### 2. Pandas - Data Manipulation

    **Purpose:** Working with structured data (tables)

    ```python
    import pandas as pd

    # Create DataFrame
    data = {
        'name': ['Alice', 'Bob', 'Charlie'],
        'age': [25, 30, 35],
        'salary': [50000, 60000, 70000]
    }
    df = pd.DataFrame(data)

    # View data
    print(df.head())
    print(df.info())
    print(df.describe())

    # Select columns
    df['name']
    df[['name', 'age']]

    # Filter rows
    df[df['age'] > 25]

    # Add column
    df['bonus'] = df['salary'] * 0.1

    # Read files
    df = pd.read_csv('data.csv')
    df = pd.read_excel('data.xlsx')

    # Handle missing values
    df.dropna()  # Remove rows with missing values
    df.fillna(0)  # Fill missing values with 0

    # Group and aggregate
    df.groupby('age')['salary'].mean()
    ```

    **Why it matters for ML:**
    - Most ML data comes in tabular format
    - Easy data exploration and cleaning
    - Integrates with scikit-learn

    ### 3. Matplotlib - Visualization

    **Purpose:** Creating plots and charts

    ```python
    import matplotlib.pyplot as plt

    # Line plot
    x = [1, 2, 3, 4, 5]
    y = [2, 4, 6, 8, 10]
    plt.plot(x, y)
    plt.xlabel('X axis')
    plt.ylabel('Y axis')
    plt.title('Simple Line Plot')
    plt.show()

    # Scatter plot
    plt.scatter(x, y)
    plt.show()

    # Histogram
    data = np.random.randn(1000)
    plt.hist(data, bins=30)
    plt.show()

    # Multiple subplots
    fig, axes = plt.subplots(1, 2, figsize=(12, 4))
    axes[0].plot(x, y)
    axes[1].scatter(x, y)
    plt.show()
    ```

    ### 4. Seaborn - Statistical Visualization

    **Purpose:** Beautiful statistical plots

    ```python
    import seaborn as sns

    # Load sample dataset
    tips = sns.load_dataset('tips')

    # Distribution plot
    sns.histplot(tips['total_bill'], bins=30)
    plt.show()

    # Scatter with regression line
    sns.regplot(x='total_bill', y='tip', data=tips)
    plt.show()

    # Categorical plot
    sns.boxplot(x='day', y='total_bill', data=tips)
    plt.show()

    # Correlation heatmap
    correlation = tips.corr()
    sns.heatmap(correlation, annot=True, cmap='coolwarm')
    plt.show()

    # Pairplot (multiple relationships)
    sns.pairplot(tips, hue='sex')
    plt.show()
    ```

    ### 5. scikit-learn - Machine Learning

    **Purpose:** ML algorithms and tools

    ```python
    from sklearn.model_selection import train_test_split
    from sklearn.preprocessing import StandardScaler
    from sklearn.linear_model import LogisticRegression
    from sklearn.metrics import accuracy_score, confusion_matrix

    # Example workflow
    # 1. Load data
    from sklearn.datasets import load_iris
    iris = load_iris()
    X, y = iris.data, iris.target

    # 2. Split data
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )

    # 3. Scale features
    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)

    # 4. Train model
    model = LogisticRegression()
    model.fit(X_train_scaled, y_train)

    # 5. Make predictions
    y_pred = model.predict(X_test_scaled)

    # 6. Evaluate
    accuracy = accuracy_score(y_test, y_pred)
    print(f"Accuracy: {accuracy:.2f}")
    ```

    ## Jupyter Notebook

    **Interactive coding environment for ML**

    ### Starting Jupyter
    ```bash
    jupyter notebook
    # or
    jupyter lab
    ```

    ### Benefits
    - Write code in cells
    - See output immediately
    - Mix code, text, and visualizations
    - Great for experimentation and learning

    ### Essential Shortcuts
    - `Shift + Enter`: Run cell
    - `A`: Insert cell above
    - `B`: Insert cell below
    - `DD`: Delete cell
    - `M`: Change to markdown
    - `Y`: Change to code

    ## Complete Example: End-to-End ML Project

    ```python
    # 1. Import libraries
    import numpy as np
    import pandas as pd
    import matplotlib.pyplot as plt
    import seaborn as sns
    from sklearn.model_selection import train_test_split
    from sklearn.preprocessing import StandardScaler
    from sklearn.linear_model import LogisticRegression
    from sklearn.metrics import accuracy_score, classification_report, confusion_matrix

    # 2. Load data
    from sklearn.datasets import load_breast_cancer
    data = load_breast_cancer()
    X = pd.DataFrame(data.data, columns=data.feature_names)
    y = data.target

    # 3. Explore data
    print(f"Dataset shape: {X.shape}")
    print(f"Target distribution: {np.bincount(y)}")
    print(X.head())
    print(X.describe())

    # 4. Visualize
    plt.figure(figsize=(10, 6))
    sns.countplot(x=y)
    plt.title('Class Distribution')
    plt.show()

    # Feature correlation
    plt.figure(figsize=(12, 8))
    correlation = X.iloc[:, :10].corr()  # First 10 features
    sns.heatmap(correlation, annot=True, cmap='coolwarm')
    plt.show()

    # 5. Split data
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )

    # 6. Preprocess
    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)

    # 7. Train model
    model = LogisticRegression(max_iter=10000)
    model.fit(X_train_scaled, y_train)

    # 8. Make predictions
    y_pred = model.predict(X_test_scaled)

    # 9. Evaluate
    accuracy = accuracy_score(y_test, y_pred)
    print(f"Accuracy: {accuracy:.4f}")
    print("\\nClassification Report:")
    print(classification_report(y_test, y_pred))

    # Confusion Matrix
    cm = confusion_matrix(y_test, y_pred)
    plt.figure(figsize=(8, 6))
    sns.heatmap(cm, annot=True, fmt='d', cmap='Blues')
    plt.title('Confusion Matrix')
    plt.ylabel('True Label')
    plt.xlabel('Predicted Label')
    plt.show()
    ```

    ## Common Patterns in ML Code

    ### 1. Loading Data
    ```python
    # CSV file
    df = pd.read_csv('data.csv')

    # Excel file
    df = pd.read_excel('data.xlsx')

    # JSON file
    df = pd.read_json('data.json')

    # From scikit-learn
    from sklearn.datasets import load_iris
    data = load_iris()
    X, y = data.data, data.target
    ```

    ### 2. Train-Test Split
    ```python
    from sklearn.model_selection import train_test_split

    X_train, X_test, y_train, y_test = train_test_split(
        X, y,
        test_size=0.2,  # 20% for testing
        random_state=42,  # For reproducibility
        stratify=y  # Maintain class distribution
    )
    ```

    ### 3. Feature Scaling
    ```python
    from sklearn.preprocessing import StandardScaler, MinMaxScaler

    # Standardization (mean=0, std=1)
    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)  # Use same scaler!

    # Normalization (0 to 1)
    scaler = MinMaxScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)
    ```

    ### 4. Model Training Pattern
    ```python
    # 1. Create model
    model = SomeModel(hyperparameters)

    # 2. Train model
    model.fit(X_train, y_train)

    # 3. Make predictions
    y_pred = model.predict(X_test)

    # 4. Evaluate
    accuracy = accuracy_score(y_test, y_pred)
    ```

    ## Debugging Tips

    ### Check Data Shape
    ```python
    print(X_train.shape)  # (samples, features)
    print(y_train.shape)  # (samples,)
    ```

    ### Check for Missing Values
    ```python
    print(df.isnull().sum())
    ```

    ### Check Data Types
    ```python
    print(df.dtypes)
    ```

    ### Check Value Ranges
    ```python
    print(df.describe())
    ```

    ### Visualize Distributions
    ```python
    df.hist(figsize=(15, 10), bins=30)
    plt.show()
    ```

    ## Best Practices

    ### 1. Version Control
    ```python
    # Check library versions
    import sklearn
    import pandas as pd
    print(f"scikit-learn: {sklearn.__version__}")
    print(f"pandas: {pd.__version__}")
    ```

    ### 2. Set Random Seeds
    ```python
    np.random.seed(42)
    # Ensures reproducible results
    ```

    ### 3. Save Models
    ```python
    import joblib

    # Save
    joblib.dump(model, 'model.pkl')

    # Load
    model = joblib.load('model.pkl')
    ```

    ### 4. Document Your Work
    ```python
    """
    This script trains a logistic regression model
    on the iris dataset.

    Author: Your Name
    Date: 2024-01-01
    """
    ```

    ## Resources

    ### Official Documentation
    - NumPy: docs.scipy.org/doc/numpy
    - Pandas: pandas.pydata.org/docs
    - scikit-learn: scikit-learn.org/stable
    - Matplotlib: matplotlib.org

    ### Practice Datasets
    - Kaggle: kaggle.com/datasets
    - UCI ML Repository: archive.ics.uci.edu/ml
    - scikit-learn built-in: sklearn.datasets

    ### Communities
    - r/MachineLearning (Reddit)
    - Kaggle Forums
    - Stack Overflow
    - ML Discord servers

    ## Key Takeaways

    1. **Use Anaconda or virtual environments** - Keep projects isolated
    2. **NumPy for arrays** - Foundation of ML computing
    3. **Pandas for data** - Tables and data manipulation
    4. **Matplotlib/Seaborn for viz** - Understand data visually
    5. **scikit-learn for ML** - Comprehensive ML library
    6. **Jupyter for experiments** - Interactive development
    7. **Follow patterns** - Load → Split → Scale → Train → Evaluate
    8. **Save your work** - Models, notebooks, scripts
    9. **Use documentation** - It's comprehensive and helpful
    10. **Practice daily** - Consistency beats intensity

    ## Next Steps

    - Install Python and ML libraries
    - Complete a Jupyter notebook tutorial
    - Load a dataset and explore it
    - Create visualizations
    - Train your first model
    - Join Kaggle and try a beginner competition
  MARKDOWN
  course_module: module1,
  sequence_order: 2,
  estimated_minutes: 40,
  published: true
)

# Lesson 1.3: Data Preprocessing
lesson1_3 = CourseLesson.create!(
  title: "Data Preprocessing Fundamentals",
  content: <<~MARKDOWN,
    # Data Preprocessing Fundamentals

    **"Garbage in, garbage out"** - Your model is only as good as your data. Data preprocessing is crucial for ML success.

    ## Why Preprocessing Matters

    ### Problems with Raw Data
    - Missing values
    - Inconsistent formats
    - Outliers
    - Different scales
    - Categorical data
    - Imbalanced classes

    ### Impact on Models
    - Poor data → Poor predictions
    - Some algorithms require scaled data
    - Missing values cause errors
    - Outliers skew models

    ## Handling Missing Values

    ### 1. Detect Missing Values

    ```python
    import pandas as pd
    import numpy as np

    # Check for missing values
    print(df.isnull().sum())
    print(df.isnull().sum() / len(df) * 100)  # Percentage

    # Visualize missing values
    import seaborn as sns
    import matplotlib.pyplot as plt

    sns.heatmap(df.isnull(), cbar=False, cmap='viridis')
    plt.show()
    ```

    ### 2. Strategies for Handling Missing Values

    #### A. Remove Missing Data
    ```python
    # Remove rows with any missing value
    df_clean = df.dropna()

    # Remove rows where specific column is missing
    df_clean = df.dropna(subset=['column_name'])

    # Remove columns with >50% missing values
    threshold = 0.5
    df_clean = df.dropna(thresh=int(threshold * len(df)), axis=1)
    ```

    #### B. Imputation (Fill Missing Values)

    **Mean/Median/Mode:**
    ```python
    from sklearn.impute import SimpleImputer

    # Mean imputation (for numerical features)
    imputer = SimpleImputer(strategy='mean')
    df['age'] = imputer.fit_transform(df[['age']])

    # Median (better for skewed data)
    imputer = SimpleImputer(strategy='median')
    df['salary'] = imputer.fit_transform(df[['salary']])

    # Most frequent (for categorical)
    imputer = SimpleImputer(strategy='most_frequent')
    df['city'] = imputer.fit_transform(df[['city']])

    # Constant value
    imputer = SimpleImputer(strategy='constant', fill_value=0)
    df['missing_col'] = imputer.fit_transform(df[['missing_col']])
    ```

    **Forward/Backward Fill:**
    ```python
    # Forward fill (use previous value)
    df['column'].fillna(method='ffill')

    # Backward fill (use next value)
    df['column'].fillna(method='bfill')
    ```

    **Interpolation:**
    ```python
    # Linear interpolation
    df['temperature'].interpolate(method='linear')

    # Time-based interpolation
    df['value'].interpolate(method='time')
    ```

    ## Feature Scaling

    ### Why Scale?
    - Many ML algorithms are sensitive to feature scales
    - Features with larger values dominate
    - Gradient descent converges faster with scaled features

    ### 1. Standardization (Z-score Normalization)

    Transform data to have mean=0 and std=1

    ```python
    from sklearn.preprocessing import StandardScaler

    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)  # Don't fit on test!

    # Formula: z = (x - mean) / std
    ```

    **When to use:**
    - Most algorithms (SVM, logistic regression, neural networks)
    - When features follow normal distribution

    ### 2. Normalization (Min-Max Scaling)

    Transform data to fixed range [0, 1]

    ```python
    from sklearn.preprocessing import MinMaxScaler

    scaler = MinMaxScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)

    # Formula: x_scaled = (x - min) / (max - min)
    ```

    **When to use:**
    - When you need bounded values
    - Neural networks
    - Image data (pixels already 0-255)

    ### 3. Robust Scaling

    Uses median and IQR (robust to outliers)

    ```python
    from sklearn.preprocessing import RobustScaler

    scaler = RobustScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)

    # Formula: (x - median) / IQR
    ```

    **When to use:**
    - Data has many outliers

    ## Encoding Categorical Variables

    ### 1. Label Encoding

    Convert categories to numbers (0, 1, 2, ...)

    ```python
    from sklearn.preprocessing import LabelEncoder

    le = LabelEncoder()
    df['city_encoded'] = le.fit_transform(df['city'])

    # Example:
    # 'New York' → 0
    # 'London' → 1
    # 'Tokyo' → 2
    ```

    **⚠️ Warning:** Only use for ordinal data (has natural order)

    ### 2. One-Hot Encoding

    Create binary column for each category

    ```python
    # Using pandas
    df_encoded = pd.get_dummies(df, columns=['city'], drop_first=False)

    # Using sklearn
    from sklearn.preprocessing import OneHotEncoder

    encoder = OneHotEncoder(sparse=False, drop='first')
    city_encoded = encoder.fit_transform(df[['city']])

    # Example:
    # 'New York' → [1, 0, 0]
    # 'London' → [0, 1, 0]
    # 'Tokyo' → [0, 0, 1]
    ```

    **When to use:**
    - Nominal categories (no order)
    - Most ML algorithms

    ### 3. Ordinal Encoding

    Map categories to integers with meaningful order

    ```python
    from sklearn.preprocessing import OrdinalEncoder

    # Define order
    education_order = ['High School', 'Bachelor', 'Master', 'PhD']

    encoder = OrdinalEncoder(categories=[education_order])
    df['education_encoded'] = encoder.fit_transform(df[['education']])

    # High School → 0
    # Bachelor → 1
    # Master → 2
    # PhD → 3
    ```

    ## Handling Outliers

    ### 1. Detect Outliers

    ```python
    # Using IQR method
    Q1 = df['salary'].quantile(0.25)
    Q3 = df['salary'].quantile(0.75)
    IQR = Q3 - Q1

    lower_bound = Q1 - 1.5 * IQR
    upper_bound = Q3 + 1.5 * IQR

    outliers = df[(df['salary'] < lower_bound) | (df['salary'] > upper_bound)]
    print(f"Number of outliers: {len(outliers)}")

    # Using Z-score
    from scipy import stats
    z_scores = stats.zscore(df['salary'])
    outliers = df[np.abs(z_scores) > 3]
    ```

    ### 2. Handle Outliers

    ```python
    # Remove outliers
    df_no_outliers = df[(df['salary'] >= lower_bound) & (df['salary'] <= upper_bound)]

    # Cap outliers (Winsorization)
    df['salary_capped'] = df['salary'].clip(lower=lower_bound, upper=upper_bound)

    # Transform data (log transform for right-skewed)
    df['log_salary'] = np.log1p(df['salary'])
    ```

    ## Feature Engineering

    ### 1. Creating New Features

    ```python
    # Date features
    df['date'] = pd.to_datetime(df['date'])
    df['year'] = df['date'].dt.year
    df['month'] = df['date'].dt.month
    df['day_of_week'] = df['date'].dt.dayofweek
    df['is_weekend'] = df['day_of_week'].isin([5, 6]).astype(int)

    # Mathematical transformations
    df['price_per_sqft'] = df['price'] / df['square_feet']
    df['bmi'] = df['weight'] / (df['height'] ** 2)

    # Binning (discretization)
    df['age_group'] = pd.cut(
        df['age'],
        bins=[0, 18, 35, 50, 100],
        labels=['young', 'adult', 'middle_aged', 'senior']
    )

    # Polynomial features
    from sklearn.preprocessing import PolynomialFeatures
    poly = PolynomialFeatures(degree=2, include_bias=False)
    X_poly = poly.fit_transform(X)
    ```

    ### 2. Feature Selection

    ```python
    # Correlation-based selection
    correlation = df.corr()
    high_corr = correlation[abs(correlation['target']) > 0.5]['target']
    print(high_corr)

    # Remove highly correlated features
    correlation_matrix = df.corr().abs()
    upper_triangle = correlation_matrix.where(
        np.triu(np.ones(correlation_matrix.shape), k=1).astype(bool)
    )
    to_drop = [col for col in upper_triangle.columns if any(upper_triangle[col] > 0.95)]
    df_reduced = df.drop(columns=to_drop)
    ```

    ## Complete Preprocessing Pipeline

    ```python
    import pandas as pd
    import numpy as np
    from sklearn.model_selection import train_test_split
    from sklearn.preprocessing import StandardScaler, OneHotEncoder
    from sklearn.impute import SimpleImputer
    from sklearn.compose import ColumnTransformer
    from sklearn.pipeline import Pipeline

    # Load data
    df = pd.read_csv('data.csv')

    # 1. Identify feature types
    numerical_features = ['age', 'salary', 'experience']
    categorical_features = ['city', 'education']
    target = 'target'

    # 2. Separate X and y
    X = df[numerical_features + categorical_features]
    y = df[target]

    # 3. Train-test split
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )

    # 4. Create preprocessing pipelines
    numerical_pipeline = Pipeline([
        ('imputer', SimpleImputer(strategy='median')),
        ('scaler', StandardScaler())
    ])

    categorical_pipeline = Pipeline([
        ('imputer', SimpleImputer(strategy='most_frequent')),
        ('encoder', OneHotEncoder(drop='first', sparse=False))
    ])

    # 5. Combine pipelines
    preprocessor = ColumnTransformer([
        ('num', numerical_pipeline, numerical_features),
        ('cat', categorical_pipeline, categorical_features)
    ])

    # 6. Fit and transform
    X_train_processed = preprocessor.fit_transform(X_train)
    X_test_processed = preprocessor.transform(X_test)

    print(f"Original shape: {X_train.shape}")
    print(f"Processed shape: {X_train_processed.shape}")
    ```

    ## Best Practices

    ### 1. Always Split First
    ```python
    # ✅ Correct order
    X_train, X_test = train_test_split(X, y)
    scaler.fit(X_train)  # Only fit on training data
    X_train_scaled = scaler.transform(X_train)
    X_test_scaled = scaler.transform(X_test)

    # ❌ Wrong - causes data leakage
    X_scaled = scaler.fit_transform(X)  # Fits on all data!
    X_train, X_test = train_test_split(X_scaled, y)
    ```

    ### 2. Save Preprocessors
    ```python
    import joblib

    # Save
    joblib.dump(preprocessor, 'preprocessor.pkl')

    # Load and use
    preprocessor = joblib.load('preprocessor.pkl')
    X_new_processed = preprocessor.transform(X_new)
    ```

    ### 3. Document Decisions
    ```python
    """
    Preprocessing decisions:
    - Imputed age with median (right-skewed distribution)
    - Removed salary outliers beyond 3 IQR
    - Standardized numerical features (for logistic regression)
    - One-hot encoded city (nominal variable)
    - Ordinal encoded education (has natural order)
    """
    ```

    ### 4. Validate Preprocessing
    ```python
    # Check for remaining missing values
    assert X_train_processed.isna().sum().sum() == 0

    # Check scaling
    print(f"Mean: {X_train_processed.mean():.2f}")
    print(f"Std: {X_train_processed.std():.2f}")

    # Check shapes match
    assert X_train_processed.shape[0] == len(y_train)
    ```

    ## Common Pitfalls

    ### 1. Data Leakage
    ```python
    # ❌ Fitting scaler on full dataset
    scaler.fit(X)  # Sees test data!

    # ✅ Fit only on training data
    scaler.fit(X_train)
    ```

    ### 2. Forgetting to Transform Test Data
    ```python
    # ❌ Forgot to scale test data
    model.fit(X_train_scaled, y_train)
    model.predict(X_test)  # Not scaled!

    # ✅ Scale test data same way
    model.fit(X_train_scaled, y_train)
    model.predict(X_test_scaled)
    ```

    ### 3. Using Mean for Skewed Data
    ```python
    # ❌ Mean sensitive to outliers
    imputer = SimpleImputer(strategy='mean')

    # ✅ Median robust to outliers
    imputer = SimpleImputer(strategy='median')
    ```

    ## Key Takeaways

    1. **Preprocess before modeling** - Essential step
    2. **Handle missing values** - Impute or remove
    3. **Scale features** - Standardize or normalize
    4. **Encode categories** - One-hot for nominal, ordinal for ordered
    5. **Handle outliers** - Remove, cap, or transform
    6. **Split first** - Avoid data leakage
    7. **Use pipelines** - Organize preprocessing steps
    8. **Save preprocessors** - Use same transform at inference
    9. **Validate thoroughly** - Check for issues
    10. **Document decisions** - Why you did what you did

    ## Next Steps

    - Practice preprocessing on Kaggle datasets
    - Build preprocessing pipelines
    - Experiment with different strategies
    - Learn feature engineering techniques
    - Study domain-specific preprocessing
  MARKDOWN
  course_module: module1,
  sequence_order: 3,
  estimated_minutes: 30,
  published: true
)

puts "  ✅ Created #{module1.course_lessons.count} lessons for Module 1"

# ========================================
# Module 2: Supervised Learning
# ========================================

module2 = CourseModule.find_or_create_by!(slug: 'supervised-learning', course: ml_course) do |mod|
  mod.title = 'Supervised Learning'
  mod.description = 'Regression and classification algorithms'
  mod.sequence_order = 2
  mod.estimated_minutes = 240
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Master linear and logistic regression",
    "Build decision tree and random forest models",
    "Understand SVM and KNN algorithms",
    "Apply ensemble methods"
  ])
end

# Lesson 2.1: Linear Regression
lesson2_1 = CourseLesson.create!(
  title: "Linear Regression",
  content: <<~MARKDOWN,
    # Linear Regression

    Linear regression is one of the most fundamental and widely-used ML algorithms for predicting continuous values.

    ## What is Linear Regression?

    **Goal:** Model the relationship between input features (X) and a continuous output (y) using a linear equation.

    ### Simple Linear Regression
    One feature predicting one target:

    ```
    y = mx + b
    y = β₀ + β₁x
    ```

    **Example:**
    ```
    House Price = β₀ + β₁ × Square Feet
    ```

    ### Multiple Linear Regression
    Multiple features predicting one target:

    ```
    y = β₀ + β₁x₁ + β₂x₂ + ... + βₙxₙ
    ```

    **Example:**
    ```
    House Price = β₀ + β₁×sqft + β₂×bedrooms + β₃×age + β₄×location_score
    ```

    ## Key Concepts

    ### Coefficients (β)
    - **β₀ (Intercept):** Value when all features = 0
    - **β₁, β₂, ... (Slopes):** Change in y for one unit change in x

    ### Residuals (Errors)
    ```
    Residual = Actual - Predicted
    e = y - ŷ
    ```

    ### Best Fit Line
    The line that minimizes the sum of squared residuals (SSR)

    ## How It Works

    ### 1. Cost Function (MSE - Mean Squared Error)
    ```
    MSE = (1/n) Σ(yᵢ - ŷᵢ)²
    ```

    **Goal:** Minimize MSE by finding optimal β values

    ### 2. Optimization Methods

    #### Normal Equation (Closed-form)
    ```
    β = (X^T X)^(-1) X^T y
    ```
    - Exact solution
    - Fast for small datasets
    - Can be slow for large datasets

    #### Gradient Descent
    ```
    β := β - α ∂J/∂β
    ```
    - Iterative approach
    - Works for large datasets
    - Need to tune learning rate (α)

    ## Python Implementation

    ### Using scikit-learn

    ```python
    import numpy as np
    import pandas as pd
    from sklearn.linear_model import LinearRegression
    from sklearn.model_selection import train_test_split
    from sklearn.metrics import mean_squared_error, r2_score
    import matplotlib.pyplot as plt

    # Generate sample data
    np.random.seed(42)
    X = np.random.rand(100, 1) * 10  # Square feet (in 1000s)
    y = 50 + 30 * X + np.random.randn(100, 1) * 10  # Price with noise

    # Split data
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )

    # Create and train model
    model = LinearRegression()
    model.fit(X_train, y_train)

    # Make predictions
    y_pred = model.predict(X_test)

    # Evaluate
    mse = mean_squared_error(y_test, y_pred)
    rmse = np.sqrt(mse)
    r2 = r2_score(y_test, y_pred)

    print(f"Coefficient: {model.coef_[0][0]:.2f}")
    print(f"Intercept: {model.intercept_[0]:.2f}")
    print(f"RMSE: {rmse:.2f}")
    print(f"R² Score: {r2:.4f}")

    # Visualize
    plt.scatter(X_test, y_test, color='blue', label='Actual')
    plt.plot(X_test, y_pred, color='red', label='Predicted')
    plt.xlabel('Square Feet (1000s)')
    plt.ylabel('Price ($1000s)')
    plt.legend()
    plt.show()
    ```

    ### Multiple Linear Regression

    ```python
    # Load dataset
    from sklearn.datasets import fetch_california_housing
    data = fetch_california_housing()
    X = pd.DataFrame(data.data, columns=data.feature_names)
    y = data.target

    # Split and scale
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )

    from sklearn.preprocessing import StandardScaler
    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)

    # Train model
    model = LinearRegression()
    model.fit(X_train_scaled, y_train)

    # Predictions
    y_pred = model.predict(X_test_scaled)

    # Feature importance
    feature_importance = pd.DataFrame({
        'feature': X.columns,
        'coefficient': model.coef_
    }).sort_values('coefficient', key=abs, ascending=False)

    print(feature_importance)
    ```

    ## Evaluation Metrics

    ### 1. Mean Absolute Error (MAE)
    ```python
    mae = mean_absolute_error(y_test, y_pred)
    # Average absolute difference
    ```

    ### 2. Mean Squared Error (MSE)
    ```python
    mse = mean_squared_error(y_test, y_pred)
    # Average squared difference (penalizes large errors)
    ```

    ### 3. Root Mean Squared Error (RMSE)
    ```python
    rmse = np.sqrt(mse)
    # Same unit as target variable
    ```

    ### 4. R² Score (Coefficient of Determination)
    ```python
    r2 = r2_score(y_test, y_pred)
    # Proportion of variance explained (0-1, higher is better)
    # 1.0 = perfect predictions
    # 0.0 = as good as predicting mean
    ```

    ## Assumptions of Linear Regression

    ### 1. Linearity
    Relationship between X and y is linear

    **Check:** Scatter plot of X vs y
    ```python
    plt.scatter(X, y)
    plt.show()
    ```

    ### 2. Independence
    Observations are independent

    ### 3. Homoscedasticity
    Constant variance of residuals

    **Check:** Residual plot
    ```python
    residuals = y_test - y_pred
    plt.scatter(y_pred, residuals)
    plt.axhline(y=0, color='r', linestyle='--')
    plt.xlabel('Predicted')
    plt.ylabel('Residuals')
    plt.show()
    ```

    ### 4. Normality
    Residuals are normally distributed

    **Check:** Q-Q plot or histogram
    ```python
    import scipy.stats as stats
    stats.probplot(residuals.flatten(), dist="norm", plot=plt)
    plt.show()
    ```

    ### 5. No Multicollinearity
    Features are not highly correlated

    **Check:** Correlation matrix
    ```python
    import seaborn as sns
    sns.heatmap(X.corr(), annot=True, cmap='coolwarm')
    plt.show()
    ```

    ## Handling Violations

    ### Non-linearity
    - Add polynomial features
    - Transform variables (log, sqrt)
    - Use non-linear models

    ### Heteroscedasticity
    - Transform target variable
    - Use weighted regression
    - Use robust standard errors

    ### Multicollinearity
    - Remove correlated features
    - Use Ridge/Lasso regression
    - Use PCA

    ## Regularization

    ### Ridge Regression (L2)
    Adds penalty for large coefficients

    ```python
    from sklearn.linear_model import Ridge

    ridge = Ridge(alpha=1.0)  # alpha controls regularization
    ridge.fit(X_train_scaled, y_train)
    y_pred = ridge.predict(X_test_scaled)
    ```

    **When to use:**
    - Multicollinearity
    - Many features
    - Prevent overfitting

    ### Lasso Regression (L1)
    Can shrink coefficients to zero (feature selection)

    ```python
    from sklearn.linear_model import Lasso

    lasso = Lasso(alpha=0.1)
    lasso.fit(X_train_scaled, y_train)

    # See which features were selected
    selected_features = X.columns[lasso.coef_ != 0]
    print(f"Selected features: {list(selected_features)}")
    ```

    **When to use:**
    - Feature selection
    - Many irrelevant features

    ### Elastic Net
    Combines L1 and L2

    ```python
    from sklearn.linear_model import ElasticNet

    elastic = ElasticNet(alpha=0.1, l1_ratio=0.5)
    elastic.fit(X_train_scaled, y_train)
    ```

    ## Polynomial Regression

    Capture non-linear relationships

    ```python
    from sklearn.preprocessing import PolynomialFeatures

    # Create polynomial features
    poly = PolynomialFeatures(degree=2, include_bias=False)
    X_train_poly = poly.fit_transform(X_train)
    X_test_poly = poly.transform(X_test)

    # Train linear regression on polynomial features
    model = LinearRegression()
    model.fit(X_train_poly, y_train)
    y_pred = model.predict(X_test_poly)
    ```

    ## Real-World Example

    ```python
    # House price prediction
    import pandas as pd
    from sklearn.linear_model import LinearRegression
    from sklearn.model_selection import train_test_split, cross_val_score
    from sklearn.preprocessing import StandardScaler
    from sklearn.metrics import mean_absolute_error, r2_score

    # Load data (example)
    # df = pd.read_csv('houses.csv')

    # Feature engineering
    df['age'] = 2024 - df['year_built']
    df['total_rooms'] = df['bedrooms'] + df['bathrooms']
    df['price_per_sqft'] = df['price'] / df['sqft']

    # Select features
    features = ['sqft', 'bedrooms', 'bathrooms', 'age', 'garage', 'location_score']
    X = df[features]
    y = df['price']

    # Handle missing values
    from sklearn.impute import SimpleImputer
    imputer = SimpleImputer(strategy='median')
    X = imputer.fit_transform(X)

    # Split
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )

    # Scale
    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)

    # Train
    model = LinearRegression()
    model.fit(X_train_scaled, y_train)

    # Cross-validation
    cv_scores = cross_val_score(model, X_train_scaled, y_train,
                                cv=5, scoring='r2')
    print(f"CV R² scores: {cv_scores}")
    print(f"Mean CV R²: {cv_scores.mean():.4f}")

    # Test evaluation
    y_pred = model.predict(X_test_scaled)
    mae = mean_absolute_error(y_test, y_pred)
    r2 = r2_score(y_test, y_pred)

    print(f"\\nTest MAE: ${mae:,.0f}")
    print(f"Test R²: {r2:.4f}")

    # Feature importance
    feature_importance = pd.DataFrame({
        'feature': features,
        'coefficient': model.coef_
    }).sort_values('coefficient', key=abs, ascending=False)

    print(f"\\nTop features:\\n{feature_importance.head()}")
    ```

    ## Advantages

    ✅ Simple and interpretable
    ✅ Fast to train
    ✅ Works well for linear relationships
    ✅ Provides feature importance (coefficients)
    ✅ No hyperparameters (basic version)

    ## Disadvantages

    ❌ Assumes linearity
    ❌ Sensitive to outliers
    ❌ Requires assumptions to be met
    ❌ Can't capture complex non-linear patterns
    ❌ Prone to overfitting with many features

    ## When to Use Linear Regression

    ### ✅ Good Fit
    - Linear relationship exists
    - Continuous target variable
    - Need interpretability
    - Small to medium datasets
    - Baseline model

    ### ❌ Not Good Fit
    - Highly non-linear relationships
    - Need to capture complex patterns
    - Categorical target (use classification)

    ## Best Practices

    1. **Check assumptions** before trusting results
    2. **Scale features** for regularized regression
    3. **Handle outliers** appropriately
    4. **Use cross-validation** for robust evaluation
    5. **Try regularization** to prevent overfitting
    6. **Feature engineering** can improve performance
    7. **Start simple** before trying complex models

    ## Key Takeaways

    1. **Linear regression models linear relationships** between features and target
    2. **Minimizes MSE** to find best fit line
    3. **R² score** measures goodness of fit
    4. **Check assumptions** for valid inference
    5. **Regularization** prevents overfitting
    6. **Polynomial features** capture non-linearity
    7. **Interpretable** - easy to understand coefficients
    8. **Great baseline** - always try first for regression

    ## Next Steps

    - Practice with real datasets
    - Try Ridge and Lasso regression
    - Experiment with polynomial features
    - Learn logistic regression for classification
    - Study gradient descent in depth
  MARKDOWN
  course_module: module2,
  sequence_order: 1,
  estimated_minutes: 60,
  published: true
)

# Lesson 2.2: Logistic Regression
lesson2_2 = CourseLesson.create!(
  title: "Logistic Regression",
  content: <<~MARKDOWN,
    # Logistic Regression

    Despite its name, logistic regression is a **classification** algorithm, not regression. It predicts the probability that an instance belongs to a particular class.

    ## What is Logistic Regression?

    **Goal:** Predict probability of a binary outcome (0 or 1, yes or no, true or false)

    ### Key Difference from Linear Regression

    **Linear Regression:**
    ```
    y = β₀ + β₁x₁ + ... + βₙxₙ
    Output: Continuous value (-∞ to +∞)
    ```

    **Logistic Regression:**
    ```
    P(y=1) = 1 / (1 + e^(-(β₀ + β₁x₁ + ... + βₙxₙ)))
    Output: Probability (0 to 1)
    ```

    ## The Sigmoid Function

    Transforms linear output to probability

    ```python
    def sigmoid(z):
        return 1 / (1 + np.exp(-z))
    ```

    **Properties:**
    - Output range: 0 to 1
    - S-shaped curve
    - z = 0 → σ(z) = 0.5
    - z → ∞ → σ(z) → 1
    - z → -∞ → σ(z) → 0

    ```python
    import numpy as np
    import matplotlib.pyplot as plt

    z = np.linspace(-10, 10, 100)
    sigma = 1 / (1 + np.exp(-z))

    plt.plot(z, sigma)
    plt.axhline(y=0.5, color='r', linestyle='--', label='Decision boundary')
    plt.xlabel('z (linear combination)')
    plt.ylabel('σ(z) - Probability')
    plt.title('Sigmoid Function')
    plt.legend()
    plt.grid(True)
    plt.show()
    ```

    ## Binary Classification

    ### Decision Rule
    ```
    if P(y=1|X) >= 0.5: predict class 1
    else: predict class 0
    ```

    ### Example: Email Spam Detection
    ```
    Input: email features (word counts, sender, etc.)
    Output: P(spam) = 0.85 → Classify as SPAM
    ```

    ## Python Implementation

    ### Basic Example

    ```python
    import numpy as np
    from sklearn.linear_model import LogisticRegression
    from sklearn.model_selection import train_test_split
    from sklearn.preprocessing import StandardScaler
    from sklearn.metrics import accuracy_score, confusion_matrix, classification_report

    # Generate sample data
    from sklearn.datasets import make_classification
    X, y = make_classification(
        n_samples=1000,
        n_features=4,
        n_classes=2,
        random_state=42
    )

    # Split data
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )

    # Scale features (important for logistic regression!)
    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)

    # Create and train model
    model = LogisticRegression(random_state=42)
    model.fit(X_train_scaled, y_train)

    # Make predictions
    y_pred = model.predict(X_test_scaled)
    y_pred_proba = model.predict_proba(X_test_scaled)

    # Evaluate
    accuracy = accuracy_score(y_test, y_pred)
    print(f"Accuracy: {accuracy:.4f}")
    print(f"\\nClassification Report:\\n{classification_report(y_test, y_pred)}")

    # Show probabilities for first 5 samples
    print(f"\\nPredicted probabilities (first 5):")
    for i in range(5):
        print(f"Sample {i}: P(class 0)={y_pred_proba[i][0]:.4f}, "
              f"P(class 1)={y_pred_proba[i][1]:.4f} → Predicted: {y_pred[i]}")
    ```

    ## Evaluation Metrics

    ### 1. Confusion Matrix

    ```python
    from sklearn.metrics import confusion_matrix
    import seaborn as sns

    cm = confusion_matrix(y_test, y_pred)
    sns.heatmap(cm, annot=True, fmt='d', cmap='Blues')
    plt.title('Confusion Matrix')
    plt.ylabel('True Label')
    plt.xlabel('Predicted Label')
    plt.show()

    # Structure:
    # [[TN  FP]
    #  [FN  TP]]
    ```

    ### 2. Accuracy
    ```python
    accuracy = (TP + TN) / (TP + TN + FP + FN)
    ```
    - Percentage of correct predictions
    - **Not good for imbalanced datasets!**

    ### 3. Precision
    ```python
    precision = TP / (TP + FP)
    ```
    - Of predicted positives, how many are correct?
    - **Use when false positives are costly**
    - Example: Spam detection (don't want to lose important emails)

    ### 4. Recall (Sensitivity)
    ```python
    recall = TP / (TP + FN)
    ```
    - Of actual positives, how many did we find?
    - **Use when false negatives are costly**
    - Example: Disease detection (don't want to miss sick patients)

    ### 5. F1 Score
    ```python
    f1 = 2 × (precision × recall) / (precision + recall)
    ```
    - Harmonic mean of precision and recall
    - **Use for balanced metric**

    ### 6. ROC Curve and AUC

    ```python
    from sklearn.metrics import roc_curve, roc_auc_score

    # Get probabilities
    y_proba = model.predict_proba(X_test_scaled)[:, 1]

    # Calculate ROC curve
    fpr, tpr, thresholds = roc_curve(y_test, y_proba)
    auc = roc_auc_score(y_test, y_proba)

    # Plot
    plt.plot(fpr, tpr, label=f'ROC Curve (AUC = {auc:.2f})')
    plt.plot([0, 1], [0, 1], 'k--', label='Random')
    plt.xlabel('False Positive Rate')
    plt.ylabel('True Positive Rate')
    plt.title('ROC Curve')
    plt.legend()
    plt.show()
    ```

    **AUC (Area Under Curve):**
    - 1.0 = Perfect classifier
    - 0.5 = Random classifier
    - Higher is better

    ## Multiclass Classification

    ### One-vs-Rest (OvR)
    Train N binary classifiers (one per class)

    ```python
    # Automatically handles multiclass
    model = LogisticRegression(multi_class='ovr')
    model.fit(X_train, y_train)
    ```

    ### Multinomial
    Single model with softmax function

    ```python
    model = LogisticRegression(multi_class='multinomial', solver='lbfgs')
    model.fit(X_train, y_train)
    ```

    ### Example: Iris Classification

    ```python
    from sklearn.datasets import load_iris

    iris = load_iris()
    X, y = iris.data, iris.target

    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )

    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)

    model = LogisticRegression(multi_class='multinomial', max_iter=1000)
    model.fit(X_train_scaled, y_train)

    y_pred = model.predict(X_test_scaled)
    print(f"Accuracy: {accuracy_score(y_test, y_pred):.4f}")
    print(f"\\n{classification_report(y_test, y_pred, target_names=iris.target_names)}")
    ```

    ## Regularization

    ### L1 Regularization (Lasso)
    ```python
    model = LogisticRegression(penalty='l1', solver='liblinear', C=1.0)
    ```
    - Feature selection (some coefficients → 0)
    - Use when many irrelevant features

    ### L2 Regularization (Ridge) - Default
    ```python
    model = LogisticRegression(penalty='l2', C=1.0)
    ```
    - Shrinks coefficients
    - Prevents overfitting
    - **C parameter:** Inverse of regularization strength
      - Small C = Strong regularization
      - Large C = Weak regularization

    ### Example: Tuning C

    ```python
    from sklearn.model_selection import cross_val_score

    C_values = [0.001, 0.01, 0.1, 1, 10, 100]
    scores = []

    for C in C_values:
        model = LogisticRegression(C=C, max_iter=1000)
        cv_scores = cross_val_score(model, X_train_scaled, y_train, cv=5)
        scores.append(cv_scores.mean())
        print(f"C={C}: {cv_scores.mean():.4f}")

    # Plot
    plt.plot(C_values, scores, marker='o')
    plt.xscale('log')
    plt.xlabel('C (Regularization)')
    plt.ylabel('Cross-validation Score')
    plt.title('Tuning Regularization Parameter')
    plt.show()
    ```

    ## Decision Boundary Visualization

    ```python
    import numpy as np
    import matplotlib.pyplot as plt
    from sklearn.datasets import make_classification

    # Generate 2D data for visualization
    X, y = make_classification(
        n_samples=200,
        n_features=2,
        n_redundant=0,
        n_informative=2,
        random_state=42,
        n_clusters_per_class=1
    )

    # Train model
    model = LogisticRegression()
    model.fit(X, y)

    # Create mesh
    x_min, x_max = X[:, 0].min() - 1, X[:, 0].max() + 1
    y_min, y_max = X[:, 1].min() - 1, X[:, 1].max() + 1
    xx, yy = np.meshgrid(np.arange(x_min, x_max, 0.02),
                         np.arange(y_min, y_max, 0.02))

    # Predict on mesh
    Z = model.predict(np.c_[xx.ravel(), yy.ravel()])
    Z = Z.reshape(xx.shape)

    # Plot
    plt.contourf(xx, yy, Z, alpha=0.4, cmap='RdYlBu')
    plt.scatter(X[:, 0], X[:, 1], c=y, cmap='RdYlBu', edgecolor='black')
    plt.xlabel('Feature 1')
    plt.ylabel('Feature 2')
    plt.title('Decision Boundary')
    plt.show()
    ```

    ## Real-World Example: Customer Churn Prediction

    ```python
    import pandas as pd
    from sklearn.linear_model import LogisticRegression
    from sklearn.model_selection import train_test_split, GridSearchCV
    from sklearn.preprocessing import StandardScaler
    from sklearn.metrics import classification_report, roc_auc_score

    # Assume we have customer data
    # df = pd.read_csv('customer_data.csv')

    # Feature engineering
    df['tenure_months'] = df['tenure_years'] * 12
    df['avg_monthly_spend'] = df['total_spend'] / df['tenure_months']
    df['support_ticket_rate'] = df['support_tickets'] / df['tenure_months']

    # Select features
    features = [
        'tenure_months',
        'avg_monthly_spend',
        'support_ticket_rate',
        'age',
        'num_products',
        'satisfaction_score'
    ]

    X = df[features]
    y = df['churned']  # Binary: 0 = stayed, 1 = churned

    # Handle missing values
    from sklearn.impute import SimpleImputer
    imputer = SimpleImputer(strategy='median')
    X = imputer.fit_transform(X)

    # Split
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, stratify=y, random_state=42
    )

    # Scale
    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)

    # Hyperparameter tuning
    param_grid = {
        'C': [0.001, 0.01, 0.1, 1, 10],
        'penalty': ['l1', 'l2'],
        'solver': ['liblinear']
    }

    grid_search = GridSearchCV(
        LogisticRegression(max_iter=1000),
        param_grid,
        cv=5,
        scoring='roc_auc',
        n_jobs=-1
    )

    grid_search.fit(X_train_scaled, y_train)
    print(f"Best parameters: {grid_search.best_params_}")
    print(f"Best CV AUC: {grid_search.best_score_:.4f}")

    # Train final model
    best_model = grid_search.best_estimator_

    # Predictions
    y_pred = best_model.predict(X_test_scaled)
    y_pred_proba = best_model.predict_proba(X_test_scaled)[:, 1]

    # Evaluation
    print(f"\\nTest AUC: {roc_auc_score(y_test, y_pred_proba):.4f}")
    print(f"\\n{classification_report(y_test, y_pred)}")

    # Feature importance
    feature_importance = pd.DataFrame({
        'feature': features,
        'coefficient': best_model.coef_[0]
    }).sort_values('coefficient', key=abs, ascending=False)

    print(f"\\nTop risk factors for churn:\\n{feature_importance}")

    # Predict churn probability for new customers
    # new_customer = [[12, 50, 0.5, 35, 2, 7]]  # Example
    # churn_probability = best_model.predict_proba(
    #     scaler.transform(new_customer)
    # )[0][1]
    # print(f"Churn probability: {churn_probability:.2%}")
    ```

    ## Handling Imbalanced Data

    ### 1. Class Weights
    ```python
    model = LogisticRegression(class_weight='balanced')
    # Automatically adjusts for class imbalance
    ```

    ### 2. Custom Weights
    ```python
    model = LogisticRegression(class_weight={0: 1, 1: 10})
    # Penalize misclassifying class 1 (minority) more
    ```

    ### 3. Threshold Tuning
    ```python
    # Instead of default 0.5 threshold
    y_proba = model.predict_proba(X_test_scaled)[:, 1]
    y_pred_custom = (y_proba >= 0.3).astype(int)  # Lower threshold
    ```

    ## Advantages

    ✅ Probabilistic output (interpretable)
    ✅ Works well for linearly separable classes
    ✅ Fast to train
    ✅ No hyperparameters (basic version)
    ✅ Handles multiclass naturally
    ✅ Feature importance via coefficients

    ## Disadvantages

    ❌ Assumes linear decision boundary
    ❌ Can't capture complex relationships
    ❌ Sensitive to feature scaling
    ❌ Requires more data for many features
    ❌ Not great for highly imbalanced data

    ## When to Use Logistic Regression

    ### ✅ Good Fit
    - Binary or multiclass classification
    - Need probability estimates
    - Linearly separable classes
    - Need interpretability
    - Baseline classification model

    ### ❌ Not Good Fit
    - Highly non-linear decision boundaries
    - Very complex patterns
    - Very high-dimensional data

    ## Best Practices

    1. **Always scale features** (crucial!)
    2. **Use cross-validation** for robust evaluation
    3. **Check for class imbalance** and handle appropriately
    4. **Tune regularization (C)** to prevent overfitting
    5. **Use appropriate metrics** for your problem
    6. **Consider threshold tuning** for imbalanced data
    7. **Start with logistic regression** before complex models

    ## Key Takeaways

    1. **Logistic regression = classification** algorithm
    2. **Sigmoid function** converts linear output to probability
    3. **Outputs probabilities** (0 to 1)
    4. **Decision boundary** is linear
    5. **Regularization** prevents overfitting
    6. **Choose metrics** based on problem (accuracy, precision, recall, F1, AUC)
    7. **Handle imbalanced data** with class weights or threshold tuning
    8. **Great baseline** for classification problems

    ## Next Steps

    - Practice with real classification datasets
    - Experiment with different metrics
    - Learn ROC curves and AUC in depth
    - Try decision trees for non-linear boundaries
    - Study threshold tuning techniques
  MARKDOWN
  course_module: module2,
  sequence_order: 2,
  estimated_minutes: 60,
  published: true
)

# Lesson 2.3: Decision Trees and Random Forests
lesson2_3 = CourseLesson.create!(
  title: "Decision Trees and Random Forests",
  content: <<~MARKDOWN,
    # Decision Trees and Random Forests

    Decision trees are intuitive, interpretable models that make decisions by asking a series of questions. Random Forests ensemble multiple trees for better performance.

    ## Decision Trees

    ### What is a Decision Tree?

    A tree-like model that makes decisions by splitting data based on feature values.

    **Example: Should I play tennis today?**
    ```
    Outlook = Sunny?
    ├─ Yes → Humidity = High?
    │  ├─ Yes → Don't Play
    │  └─ No → Play
    └─ No → Wind = Strong?
       ├─ Yes → Don't Play
       └─ No → Play
    ```

    ### Key Components

    1. **Root Node:** First decision (top)
    2. **Internal Nodes:** Decisions/tests
    3. **Branches:** Outcomes of tests
    4. **Leaf Nodes:** Final predictions

    ## How Decision Trees Work

    ### Building a Tree (CART Algorithm)

    **Goal:** Split data to create pure (homogeneous) groups

    #### 1. Choose Best Split
    At each node, find the feature and threshold that best separates classes

    #### 2. Splitting Criteria

    **For Classification:**

    **Gini Impurity:**
    ```
    Gini = 1 - Σ(pᵢ²)

    Perfect split (pure): Gini = 0
    Random split: Gini = 0.5 (binary)
    ```

    **Entropy (Information Gain):**
    ```
    Entropy = -Σ(pᵢ × log₂(pᵢ))
    Information Gain = Entropy(parent) - Weighted Entropy(children)
    ```

    **For Regression:**

    **MSE (Mean Squared Error):**
    ```
    MSE = (1/n) Σ(yᵢ - ŷ)²
    Goal: Minimize MSE
    ```

    #### 3. Stopping Criteria
    - Max depth reached
    - Min samples per node
    - No improvement in impurity
    - All samples same class

    ## Python Implementation

    ### Classification Tree

    ```python
    from sklearn.tree import DecisionTreeClassifier
    from sklearn.datasets import load_iris
    from sklearn.model_selection import train_test_split
    from sklearn.metrics import accuracy_score, classification_report
    import matplotlib.pyplot as plt
    from sklearn import tree

    # Load data
    iris = load_iris()
    X, y = iris.data, iris.target

    # Split
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )

    # Create and train model
    dt = DecisionTreeClassifier(
        max_depth=3,
        min_samples_split=5,
        min_samples_leaf=2,
        random_state=42
    )
    dt.fit(X_train, y_train)

    # Predictions
    y_pred = dt.predict(X_test)
    accuracy = accuracy_score(y_test, y_pred)
    print(f"Accuracy: {accuracy:.4f}")
    print(f"\\n{classification_report(y_test, y_pred, target_names=iris.target_names)}")

    # Visualize tree
    plt.figure(figsize=(15, 10))
    tree.plot_tree(
        dt,
        feature_names=iris.feature_names,
        class_names=iris.target_names,
        filled=True,
        rounded=True
    )
    plt.title('Decision Tree Visualization')
    plt.show()

    # Feature importance
    import pandas as pd
    feature_importance = pd.DataFrame({
        'feature': iris.feature_names,
        'importance': dt.feature_importances_
    }).sort_values('importance', ascending=False)
    print(f"\\nFeature Importance:\\n{feature_importance}")
    ```

    ### Regression Tree

    ```python
    from sklearn.tree import DecisionTreeRegressor
    from sklearn.datasets import fetch_california_housing
    from sklearn.metrics import mean_squared_error, r2_score

    # Load data
    data = fetch_california_housing()
    X, y = data.data, data.target

    # Split
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )

    # Train
    dt_reg = DecisionTreeRegressor(
        max_depth=5,
        min_samples_split=20,
        random_state=42
    )
    dt_reg.fit(X_train, y_train)

    # Evaluate
    y_pred = dt_reg.predict(X_test)
    mse = mean_squared_error(y_test, y_pred)
    r2 = r2_score(y_test, y_pred)

    print(f"MSE: {mse:.4f}")
    print(f"RMSE: {np.sqrt(mse):.4f}")
    print(f"R² Score: {r2:.4f}")
    ```

    ## Hyperparameters

    ### Controlling Tree Complexity

    #### 1. max_depth
    ```python
    dt = DecisionTreeClassifier(max_depth=5)
    ```
    - Maximum depth of tree
    - Deeper trees = more complex, prone to overfitting
    - Typical range: 3-10

    #### 2. min_samples_split
    ```python
    dt = DecisionTreeClassifier(min_samples_split=10)
    ```
    - Minimum samples required to split node
    - Higher = simpler tree
    - Default: 2

    #### 3. min_samples_leaf
    ```python
    dt = DecisionTreeClassifier(min_samples_leaf=5)
    ```
    - Minimum samples in leaf node
    - Higher = smoother decision boundary

    #### 4. max_features
    ```python
    dt = DecisionTreeClassifier(max_features='sqrt')
    ```
    - Number of features to consider for best split
    - Options: int, 'sqrt', 'log2', None (all)

    ### Hyperparameter Tuning

    ```python
    from sklearn.model_selection import GridSearchCV

    param_grid = {
        'max_depth': [3, 5, 7, 10],
        'min_samples_split': [2, 5, 10],
        'min_samples_leaf': [1, 2, 4],
        'criterion': ['gini', 'entropy']
    }

    grid_search = GridSearchCV(
        DecisionTreeClassifier(random_state=42),
        param_grid,
        cv=5,
        scoring='accuracy',
        n_jobs=-1
    )

    grid_search.fit(X_train, y_train)
    print(f"Best parameters: {grid_search.best_params_}")
    print(f"Best CV score: {grid_search.best_score_:.4f}")

    # Use best model
    best_dt = grid_search.best_estimator_
    y_pred = best_dt.predict(X_test)
    print(f"Test accuracy: {accuracy_score(y_test, y_pred):.4f}")
    ```

    ## Random Forests

    ### What is Random Forest?

    **Ensemble of decision trees** that vote on predictions

    **Key Ideas:**
    1. **Bootstrap Aggregating (Bagging):** Train each tree on random subset
    2. **Feature Randomness:** Each split considers random subset of features
    3. **Majority Voting:** Combine predictions from all trees

    ### Why Random Forests Work

    - **Reduces Overfitting:** Individual trees overfit, but ensemble averages out errors
    - **Reduces Variance:** More stable than single tree
    - **Better Generalization:** More robust to noise

    ## Python Implementation

    ### Classification

    ```python
    from sklearn.ensemble import RandomForestClassifier
    from sklearn.datasets import make_classification

    # Generate data
    X, y = make_classification(
        n_samples=1000,
        n_features=20,
        n_informative=15,
        random_state=42
    )

    # Split
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )

    # Train Random Forest
    rf = RandomForestClassifier(
        n_estimators=100,      # Number of trees
        max_depth=10,
        min_samples_split=5,
        min_samples_leaf=2,
        max_features='sqrt',   # sqrt(n_features) for each split
        random_state=42,
        n_jobs=-1              # Use all CPU cores
    )

    rf.fit(X_train, y_train)

    # Predictions
    y_pred = rf.predict(X_test)
    y_pred_proba = rf.predict_proba(X_test)

    # Evaluate
    accuracy = accuracy_score(y_test, y_pred)
    print(f"Accuracy: {accuracy:.4f}")
    print(f"\\n{classification_report(y_test, y_pred)}")

    # Feature importance
    import pandas as pd
    feature_names = [f'feature_{i}' for i in range(X.shape[1])]
    feature_importance = pd.DataFrame({
        'feature': feature_names,
        'importance': rf.feature_importances_
    }).sort_values('importance', ascending=False)

    # Plot top 10 features
    top_features = feature_importance.head(10)
    plt.figure(figsize=(10, 6))
    plt.barh(top_features['feature'], top_features['importance'])
    plt.xlabel('Importance')
    plt.title('Top 10 Feature Importances')
    plt.gca().invert_yaxis()
    plt.show()
    ```

    ### Regression

    ```python
    from sklearn.ensemble import RandomForestRegressor

    # Train
    rf_reg = RandomForestRegressor(
        n_estimators=100,
        max_depth=10,
        random_state=42,
        n_jobs=-1
    )

    rf_reg.fit(X_train, y_train)

    # Predictions
    y_pred = rf_reg.predict(X_test)

    # Evaluate
    mse = mean_squared_error(y_test, y_pred)
    r2 = r2_score(y_test, y_pred)

    print(f"MSE: {mse:.4f}")
    print(f"R² Score: {r2:.4f}")
    ```

    ## Hyperparameters

    ### Key Parameters

    #### 1. n_estimators
    ```python
    rf = RandomForestClassifier(n_estimators=100)
    ```
    - Number of trees in forest
    - More trees = better performance but slower
    - Typical range: 100-500
    - **More is usually better** (diminishing returns)

    #### 2. max_features
    ```python
    rf = RandomForestClassifier(max_features='sqrt')
    ```
    - Features to consider at each split
    - Classification: 'sqrt' (√n_features)
    - Regression: 'log2' or n_features/3

    #### 3. max_depth
    ```python
    rf = RandomForestClassifier(max_depth=10)
    ```
    - Maximum depth of each tree
    - None = grow until pure leaves (can overfit)
    - Typical range: 10-50

    ### Tuning Random Forest

    ```python
    from sklearn.model_selection import RandomizedSearchCV
    from scipy.stats import randint

    param_distributions = {
        'n_estimators': [100, 200, 300, 400, 500],
        'max_depth': [10, 20, 30, 40, 50, None],
        'min_samples_split': [2, 5, 10],
        'min_samples_leaf': [1, 2, 4],
        'max_features': ['sqrt', 'log2']
    }

    random_search = RandomizedSearchCV(
        RandomForestClassifier(random_state=42),
        param_distributions,
        n_iter=50,         # Try 50 random combinations
        cv=5,
        scoring='accuracy',
        n_jobs=-1,
        random_state=42
    )

    random_search.fit(X_train, y_train)
    print(f"Best parameters: {random_search.best_params_}")
    print(f"Best CV score: {random_search.best_score_:.4f}")
    ```

    ## Feature Importance

    ```python
    # Train model
    rf = RandomForestClassifier(n_estimators=100, random_state=42)
    rf.fit(X_train, y_train)

    # Get importances
    importances = rf.feature_importances_
    indices = np.argsort(importances)[::-1]

    # Plot
    plt.figure(figsize=(10, 6))
    plt.title('Feature Importances')
    plt.bar(range(X.shape[1]), importances[indices])
    plt.xlabel('Feature Index')
    plt.ylabel('Importance')
    plt.show()

    # Print top features
    print("Top 5 features:")
    for i in range(5):
        print(f"{i+1}. Feature {indices[i]}: {importances[indices[i]]:.4f}")
    ```

    ## Out-of-Bag (OOB) Error

    Built-in validation without separate validation set

    ```python
    rf = RandomForestClassifier(
        n_estimators=100,
        oob_score=True,    # Enable OOB evaluation
        random_state=42
    )

    rf.fit(X_train, y_train)

    print(f"OOB Score: {rf.oob_score_:.4f}")
    # OOB score approximates cross-validation score
    ```

    ## Real-World Example: Credit Card Fraud Detection

    ```python
    import pandas as pd
    from sklearn.ensemble import RandomForestClassifier
    from sklearn.model_selection import train_test_split, cross_val_score
    from sklearn.metrics import classification_report, confusion_matrix, roc_auc_score
    import seaborn as sns

    # Load data (example)
    # df = pd.read_csv('credit_card_transactions.csv')

    # Features
    features = [
        'amount',
        'transaction_hour',
        'days_since_last_transaction',
        'num_transactions_24h',
        'avg_transaction_amount',
        'is_international',
        'merchant_category'
    ]

    X = df[features]
    y = df['is_fraud']  # 0 = legitimate, 1 = fraud

    # Handle categorical
    X = pd.get_dummies(X, columns=['merchant_category'], drop_first=True)

    # Split (stratify to handle imbalance)
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, stratify=y, random_state=42
    )

    # Train Random Forest with class weights for imbalance
    rf = RandomForestClassifier(
        n_estimators=200,
        max_depth=20,
        min_samples_split=10,
        min_samples_leaf=4,
        max_features='sqrt',
        class_weight='balanced',  # Handle imbalanced data
        random_state=42,
        n_jobs=-1
    )

    # Cross-validation
    cv_scores = cross_val_score(rf, X_train, y_train, cv=5, scoring='roc_auc')
    print(f"CV AUC scores: {cv_scores}")
    print(f"Mean CV AUC: {cv_scores.mean():.4f} (+/- {cv_scores.std()*2:.4f})")

    # Train final model
    rf.fit(X_train, y_train)

    # Predictions
    y_pred = rf.predict(X_test)
    y_pred_proba = rf.predict_proba(X_test)[:, 1]

    # Evaluation
    print(f"\\nTest AUC: {roc_auc_score(y_test, y_pred_proba):.4f}")
    print(f"\\n{classification_report(y_test, y_pred)}")

    # Confusion matrix
    cm = confusion_matrix(y_test, y_pred)
    plt.figure(figsize=(8, 6))
    sns.heatmap(cm, annot=True, fmt='d', cmap='Blues')
    plt.title('Confusion Matrix')
    plt.ylabel('True Label')
    plt.xlabel('Predicted Label')
    plt.show()

    # Feature importance
    feature_importance = pd.DataFrame({
        'feature': X.columns,
        'importance': rf.feature_importances_
    }).sort_values('importance', ascending=False)

    print(f"\\nTop Fraud Indicators:\\n{feature_importance.head(10)}")

    # Threshold tuning for imbalanced data
    from sklearn.metrics import precision_recall_curve

    precision, recall, thresholds = precision_recall_curve(y_test, y_pred_proba)

    # Find optimal threshold
    f1_scores = 2 * (precision * recall) / (precision + recall)
    optimal_idx = np.argmax(f1_scores)
    optimal_threshold = thresholds[optimal_idx]

    print(f"\\nOptimal threshold: {optimal_threshold:.4f}")
    y_pred_optimized = (y_pred_proba >= optimal_threshold).astype(int)
    print(f"\\nOptimized predictions:\\n{classification_report(y_test, y_pred_optimized)}")
    ```

    ## Comparison: Decision Tree vs Random Forest

    | Aspect | Decision Tree | Random Forest |
    |--------|---------------|---------------|
    | **Complexity** | Simple | Complex |
    | **Training Speed** | Fast | Slower |
    | **Prediction Speed** | Very Fast | Moderate |
    | **Overfitting** | Prone | Resistant |
    | **Interpretability** | High | Low |
    | **Performance** | Good | Better |
    | **Variance** | High | Low |
    | **Feature Importance** | Yes | Yes (more robust) |

    ## Advantages

    ### Decision Trees
    ✅ Easy to understand and visualize
    ✅ No feature scaling needed
    ✅ Handles non-linear relationships
    ✅ Handles mixed data types
    ✅ Fast predictions

    ### Random Forests
    ✅ More accurate than single tree
    ✅ Reduces overfitting
    ✅ Handles missing values well
    ✅ Works with high-dimensional data
    ✅ Provides feature importance
    ✅ Robust to outliers

    ## Disadvantages

    ### Decision Trees
    ❌ Prone to overfitting
    ❌ High variance (unstable)
    ❌ Biased toward dominant classes

    ### Random Forests
    ❌ Less interpretable
    ❌ Slower training and prediction
    ❌ Large memory footprint
    ❌ Can overfit noisy data with many trees

    ## When to Use

    ### Decision Trees
    - Need interpretability
    - Small datasets
    - Quick baseline model
    - Feature engineering

    ### Random Forests
    - Need high accuracy
    - Complex relationships
    - Large datasets
    - Feature importance analysis
    - Don't need interpretability

    ## Best Practices

    1. **Start with default parameters** then tune
    2. **Use more trees** (100-500) for better performance
    3. **Use OOB score** for quick validation
    4. **Handle imbalanced data** with class_weight='balanced'
    5. **Use feature importance** for feature selection
    6. **Consider memory** with large datasets
    7. **Use n_jobs=-1** to parallelize training

    ## Key Takeaways

    1. **Decision trees** split data based on features
    2. **Gini/Entropy** measure split quality
    3. **Prone to overfitting** without constraints
    4. **Random Forest** ensembles multiple trees
    5. **Bagging + feature randomness** reduces overfitting
    6. **Feature importance** helps understand data
    7. **Random Forest** usually beats single tree
    8. **Trade-off:** Accuracy vs interpretability

    ## Next Steps

    - Practice with real datasets
    - Visualize decision trees
    - Tune Random Forest hyperparameters
    - Try gradient boosting (XGBoost, LightGBM)
    - Learn ensemble methods
  MARKDOWN
  course_module: module2,
  sequence_order: 3,
  estimated_minutes: 70,
  published: true
)

puts "  ✅ Created #{module2.course_lessons.count} lessons for Module 2: Supervised Learning"

puts "  ✅ Created Module 2: Supervised Learning"

# ========================================
# Module 3: Unsupervised Learning
# ========================================

module3 = CourseModule.find_or_create_by!(slug: 'unsupervised-learning', course: ml_course) do |mod|
  mod.title = 'Unsupervised Learning'
  mod.description = 'Clustering and dimensionality reduction'
  mod.sequence_order = 3
  mod.estimated_minutes = 180
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Apply K-Means and hierarchical clustering",
    "Use PCA for dimensionality reduction",
    "Perform anomaly detection",
    "Apply t-SNE for visualization"
  ])
end

# Lesson 3.1: K-Means Clustering
lesson3_1 = CourseLesson.create!(
  title: "K-Means Clustering",
  content: <<~MARKDOWN,
    # K-Means Clustering

    K-Means is one of the most popular unsupervised learning algorithms for grouping similar data points together.

    ## What is Clustering?

    **Goal:** Group similar data points together without predefined labels

    **Key Difference from Classification:**
    - **Classification (Supervised):** Learn from labeled data
    - **Clustering (Unsupervised):** Find patterns in unlabeled data

    ## K-Means Algorithm

    ### How It Works

    1. **Choose K:** Decide number of clusters
    2. **Initialize:** Randomly place K centroids
    3. **Assign:** Assign each point to nearest centroid
    4. **Update:** Move centroids to center of assigned points
    5. **Repeat:** Steps 3-4 until convergence

    ### Mathematical Objective

    Minimize within-cluster sum of squares (WCSS):
    ```
    WCSS = Σ Σ ||xᵢ - μⱼ||²
    ```
    Where:
    - xᵢ = data point
    - μⱼ = centroid of cluster j

    ## Python Implementation

    ### Basic Example

    ```python
    import numpy as np
    import matplotlib.pyplot as plt
    from sklearn.cluster import KMeans
    from sklearn.datasets import make_blobs

    # Generate sample data
    X, y_true = make_blobs(
        n_samples=300,
        centers=4,
        cluster_std=0.60,
        random_state=42
    )

    # Create K-Means model
    kmeans = KMeans(
        n_clusters=4,
        init='k-means++',  # Smart initialization
        n_init=10,         # Number of times to run with different centroids
        max_iter=300,      # Maximum iterations
        random_state=42
    )

    # Fit and predict
    kmeans.fit(X)
    y_pred = kmeans.predict(X)

    # Get cluster centers
    centers = kmeans.cluster_centers_

    # Visualize
    plt.figure(figsize=(10, 6))
    plt.scatter(X[:, 0], X[:, 1], c=y_pred, cmap='viridis', marker='o', edgecolor='k', s=50)
    plt.scatter(centers[:, 0], centers[:, 1], c='red', marker='X', s=200, edgecolor='k', label='Centroids')
    plt.xlabel('Feature 1')
    plt.ylabel('Feature 2')
    plt.title('K-Means Clustering')
    plt.legend()
    plt.show()

    print(f"Inertia (WCSS): {kmeans.inertia_:.2f}")
    ```

    ## Choosing K (Number of Clusters)

    ### 1. Elbow Method

    Plot WCSS vs number of clusters, look for "elbow"

    ```python
    wcss = []
    K_range = range(1, 11)

    for k in K_range:
        kmeans = KMeans(n_clusters=k, random_state=42)
        kmeans.fit(X)
        wcss.append(kmeans.inertia_)

    # Plot elbow curve
    plt.figure(figsize=(10, 6))
    plt.plot(K_range, wcss, 'bo-')
    plt.xlabel('Number of Clusters (K)')
    plt.ylabel('WCSS (Inertia)')
    plt.title('Elbow Method')
    plt.grid(True)
    plt.show()
    ```

    **How to interpret:**
    - Look for the "elbow" - where the rate of decrease sharply shifts
    - Choose K at the elbow point

    ### 2. Silhouette Score

    Measures how similar a point is to its own cluster vs other clusters

    ```python
    from sklearn.metrics import silhouette_score

    silhouette_scores = []
    K_range = range(2, 11)

    for k in K_range:
        kmeans = KMeans(n_clusters=k, random_state=42)
        y_pred = kmeans.fit_predict(X)
        score = silhouette_score(X, y_pred)
        silhouette_scores.append(score)
        print(f"K={k}: Silhouette Score = {score:.4f}")

    # Plot
    plt.figure(figsize=(10, 6))
    plt.plot(K_range, silhouette_scores, 'bo-')
    plt.xlabel('Number of Clusters (K)')
    plt.ylabel('Silhouette Score')
    plt.title('Silhouette Score vs K')
    plt.grid(True)
    plt.show()
    ```

    **Score interpretation:**
    - Range: -1 to 1
    - Close to 1: Well-clustered
    - Close to 0: Overlapping clusters
    - Negative: Wrong cluster assignment

    ## Real-World Example: Customer Segmentation

    ```python
    import pandas as pd
    from sklearn.preprocessing import StandardScaler
    from sklearn.cluster import KMeans
    import seaborn as sns

    # Load customer data (example)
    # df = pd.read_csv('customers.csv')

    # Select features for clustering
    features = ['age', 'annual_income', 'spending_score']
    X = df[features]

    # Handle missing values
    from sklearn.impute import SimpleImputer
    imputer = SimpleImputer(strategy='median')
    X = imputer.fit_transform(X)

    # Scale features (important for K-Means!)
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)

    # Find optimal K using elbow method
    wcss = []
    for k in range(1, 11):
        kmeans = KMeans(n_clusters=k, random_state=42)
        kmeans.fit(X_scaled)
        wcss.append(kmeans.inertia_)

    plt.figure(figsize=(10, 6))
    plt.plot(range(1, 11), wcss, 'bo-')
    plt.xlabel('Number of Clusters')
    plt.ylabel('WCSS')
    plt.title('Elbow Method')
    plt.show()

    # Train with optimal K (let's say K=4)
    optimal_k = 4
    kmeans = KMeans(n_clusters=optimal_k, random_state=42)
    df['cluster'] = kmeans.fit_predict(X_scaled)

    # Analyze clusters
    cluster_profile = df.groupby('cluster')[features].mean()
    print("\\nCluster Profiles:")
    print(cluster_profile)

    # Visualize clusters (2D)
    plt.figure(figsize=(12, 5))

    plt.subplot(1, 2, 1)
    plt.scatter(df['age'], df['annual_income'], c=df['cluster'], cmap='viridis')
    plt.xlabel('Age')
    plt.ylabel('Annual Income')
    plt.title('Clusters: Age vs Income')
    plt.colorbar(label='Cluster')

    plt.subplot(1, 2, 2)
    plt.scatter(df['annual_income'], df['spending_score'], c=df['cluster'], cmap='viridis')
    plt.xlabel('Annual Income')
    plt.ylabel('Spending Score')
    plt.title('Clusters: Income vs Spending')
    plt.colorbar(label='Cluster')

    plt.tight_layout()
    plt.show()

    # Name clusters based on characteristics
    cluster_names = {
        0: 'Low Income, Low Spending',
        1: 'High Income, High Spending',
        2: 'High Income, Low Spending',
        3: 'Low Income, High Spending'
    }
    df['segment'] = df['cluster'].map(cluster_names)

    # Count by segment
    print("\\nCustomer Distribution:")
    print(df['segment'].value_counts())
    ```

    ## Advantages

    ✅ Simple and easy to understand
    ✅ Fast and efficient (linear complexity)
    ✅ Works well with spherical clusters
    ✅ Scales to large datasets
    ✅ Easy to implement

    ## Disadvantages

    ❌ Need to specify K beforehand
    ❌ Sensitive to initialization (random centroids)
    ❌ Sensitive to outliers
    ❌ Assumes spherical clusters
    ❌ Sensitive to feature scaling
    ❌ Can't find clusters of different sizes/densities

    ## Initialization Methods

    ### 1. Random Initialization (default)
    Randomly select K points as initial centroids

    ### 2. K-Means++ (recommended)
    Smart initialization that spreads out initial centroids

    ```python
    kmeans = KMeans(n_clusters=4, init='k-means++', random_state=42)
    ```

    **Why K-Means++:**
    - Faster convergence
    - Better final clusters
    - Reduces impact of initialization

    ## Handling Limitations

    ### 1. Dealing with Outliers

    ```python
    # Remove outliers before clustering
    from scipy import stats
    z_scores = np.abs(stats.zscore(X))
    X_no_outliers = X[(z_scores < 3).all(axis=1)]

    # Or use outlier-robust algorithm (DBSCAN, etc.)
    ```

    ### 2. Non-Spherical Clusters

    ```python
    # Use other algorithms:
    from sklearn.cluster import DBSCAN, AgglomerativeClustering

    # DBSCAN for arbitrary shapes
    dbscan = DBSCAN(eps=0.5, min_samples=5)
    labels = dbscan.fit_predict(X)
    ```

    ### 3. Feature Scaling

    ```python
    # Always scale before K-Means!
    from sklearn.preprocessing import StandardScaler

    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)
    ```

    ## Evaluation Metrics

    ### 1. Inertia (WCSS)
    ```python
    inertia = kmeans.inertia_
    # Lower is better (but can always reduce by increasing K)
    ```

    ### 2. Silhouette Score
    ```python
    from sklearn.metrics import silhouette_score
    score = silhouette_score(X, labels)
    # Range: -1 to 1 (higher is better)
    ```

    ### 3. Calinski-Harabasz Index
    ```python
    from sklearn.metrics import calinski_harabasz_score
    score = calinski_harabasz_score(X, labels)
    # Higher is better
    ```

    ### 4. Davies-Bouldin Index
    ```python
    from sklearn.metrics import davies_bouldin_score
    score = davies_bouldin_score(X, labels)
    # Lower is better
    ```

    ## Mini-Batch K-Means

    Faster version for large datasets

    ```python
    from sklearn.cluster import MiniBatchKMeans

    mbk = MiniBatchKMeans(
        n_clusters=4,
        batch_size=100,
        random_state=42
    )

    mbk.fit(X)
    labels = mbk.predict(X)

    # Much faster for large datasets (millions of samples)
    ```

    ## Practical Applications

    ### 1. Customer Segmentation
    - Group customers by behavior
    - Targeted marketing
    - Personalized recommendations

    ### 2. Image Compression
    - Reduce number of colors
    - Cluster similar colors

    ```python
    from sklearn.cluster import KMeans
    import matplotlib.pyplot as plt
    from PIL import Image

    # Load image
    img = np.array(Image.open('photo.jpg'))
    h, w, c = img.shape

    # Reshape to (n_pixels, 3)
    pixels = img.reshape(-1, 3)

    # Cluster colors
    kmeans = KMeans(n_clusters=16, random_state=42)
    kmeans.fit(pixels)
    compressed_pixels = kmeans.cluster_centers_[kmeans.labels_]

    # Reshape back
    compressed_img = compressed_pixels.reshape(h, w, c).astype('uint8')

    # Display
    plt.figure(figsize=(12, 6))
    plt.subplot(1, 2, 1)
    plt.imshow(img)
    plt.title('Original')
    plt.axis('off')

    plt.subplot(1, 2, 2)
    plt.imshow(compressed_img)
    plt.title(f'Compressed (K={16})')
    plt.axis('off')
    plt.show()
    ```

    ### 3. Document Clustering
    - Group similar documents
    - Topic discovery

    ### 4. Anomaly Detection
    - Points far from all centroids = anomalies

    ```python
    # Get distances to nearest centroid
    distances = kmeans.transform(X).min(axis=1)

    # Points with large distances are anomalies
    threshold = np.percentile(distances, 95)
    anomalies = distances > threshold

    print(f"Number of anomalies: {anomalies.sum()}")
    ```

    ## Best Practices

    1. **Always scale features** before K-Means
    2. **Use elbow method + silhouette** to choose K
    3. **Try K-Means++** initialization
    4. **Run multiple times** with different random states
    5. **Remove outliers** if they affect clustering
    6. **Visualize results** to validate clusters
    7. **Profile clusters** to understand characteristics
    8. **Domain knowledge** helps choose K

    ## Key Takeaways

    1. **K-Means groups similar points** into K clusters
    2. **Minimizes WCSS** by iteratively updating centroids
    3. **Need to choose K** beforehand (use elbow/silhouette)
    4. **Sensitive to scaling** - always standardize
    5. **Assumes spherical clusters** of similar size
    6. **Fast and scalable** to large datasets
    7. **K-Means++** initialization improves results
    8. **Evaluate with silhouette** or other metrics

    ## Next Steps

    - Practice with real datasets
    - Try different K values
    - Learn hierarchical clustering
    - Explore DBSCAN for arbitrary shapes
    - Apply to customer segmentation problems
  MARKDOWN
  course_module: module3,
  sequence_order: 1,
  estimated_minutes: 60,
  published: true
)

# Lesson 3.2: PCA and Dimensionality Reduction
lesson3_2 = CourseLesson.create!(
  title: "PCA and Dimensionality Reduction",
  content: <<~MARKDOWN,
    # PCA and Dimensionality Reduction

    Principal Component Analysis (PCA) is a powerful technique for reducing the number of features while preserving most of the variance in your data.

    ## The Curse of Dimensionality

    ### Problems with High Dimensions

    1. **Increased computation time**
    2. **More data needed** to avoid overfitting
    3. **Visualization difficulties**
    4. **Feature redundancy** (correlated features)

    ### Example
    ```
    100 features × 10,000 samples = 1,000,000 data points
    Reduced to 10 features = 100,000 data points (10x reduction)
    ```

    ## What is PCA?

    **Goal:** Find new axes (principal components) that capture maximum variance

    ### Key Ideas

    1. **Find directions of maximum variance**
    2. **Project data onto these directions**
    3. **Keep top K components**
    4. **Reduce dimensionality**

    ### Principal Components

    - **PC1:** Direction of maximum variance
    - **PC2:** Direction of 2nd maximum variance (perpendicular to PC1)
    - **PC3:** Direction of 3rd maximum variance (perpendicular to PC1 & PC2)
    - And so on...

    ## Python Implementation

    ### Basic Example

    ```python
    import numpy as np
    import pandas as pd
    from sklearn.decomposition import PCA
    from sklearn.preprocessing import StandardScaler
    import matplotlib.pyplot as plt

    # Generate sample data
    from sklearn.datasets import load_iris
    iris = load_iris()
    X = iris.data  # 4 features
    y = iris.target

    # IMPORTANT: Scale data before PCA
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)

    # Apply PCA to reduce from 4D to 2D
    pca = PCA(n_components=2)
    X_pca = pca.fit_transform(X_scaled)

    print(f"Original shape: {X.shape}")
    print(f"Transformed shape: {X_pca.shape}")

    # Explained variance
    print(f"\\nExplained variance ratio: {pca.explained_variance_ratio_}")
    print(f"Total variance explained: {pca.explained_variance_ratio_.sum():.4f}")

    # Visualize
    plt.figure(figsize=(10, 6))
    scatter = plt.scatter(X_pca[:, 0], X_pca[:, 1], c=y, cmap='viridis', edgecolor='k')
    plt.xlabel(f'PC1 ({pca.explained_variance_ratio_[0]:.2%} variance)')
    plt.ylabel(f'PC2 ({pca.explained_variance_ratio_[1]:.2%} variance)')
    plt.title('PCA: Iris Dataset')
    plt.colorbar(scatter, label='Species')
    plt.show()
    ```

    ## Choosing Number of Components

    ### 1. Explained Variance

    ```python
    # Fit PCA with all components
    pca_full = PCA()
    pca_full.fit(X_scaled)

    # Plot cumulative explained variance
    cumsum = np.cumsum(pca_full.explained_variance_ratio_)

    plt.figure(figsize=(10, 6))
    plt.plot(range(1, len(cumsum) + 1), cumsum, 'bo-')
    plt.xlabel('Number of Components')
    plt.ylabel('Cumulative Explained Variance')
    plt.title('Explained Variance vs Components')
    plt.axhline(y=0.95, color='r', linestyle='--', label='95% threshold')
    plt.legend()
    plt.grid(True)
    plt.show()

    # Find number of components for 95% variance
    n_components_95 = np.argmax(cumsum >= 0.95) + 1
    print(f"Components needed for 95% variance: {n_components_95}")
    ```

    ### 2. Scree Plot

    ```python
    plt.figure(figsize=(10, 6))
    plt.bar(range(1, len(pca_full.explained_variance_ratio_) + 1),
            pca_full.explained_variance_ratio_)
    plt.xlabel('Principal Component')
    plt.ylabel('Explained Variance Ratio')
    plt.title('Scree Plot')
    plt.show()
    ```

    **How to interpret:**
    - Look for "elbow" where variance drops significantly
    - Keep components before the elbow

    ### 3. Set Variance Threshold

    ```python
    # Keep 95% of variance automatically
    pca = PCA(n_components=0.95)
    X_pca = pca.fit_transform(X_scaled)

    print(f"Number of components kept: {pca.n_components_}")
    print(f"Total variance retained: {pca.explained_variance_ratio_.sum():.4f}")
    ```

    ## Understanding Components

    ### Component Loadings

    Show how original features contribute to each component

    ```python
    # Get component loadings
    components_df = pd.DataFrame(
        pca.components_,
        columns=iris.feature_names,
        index=[f'PC{i+1}' for i in range(pca.n_components_)]
    )

    print("Component Loadings:")
    print(components_df)

    # Visualize loadings
    plt.figure(figsize=(10, 6))
    sns.heatmap(components_df, annot=True, cmap='coolwarm', center=0)
    plt.title('PCA Component Loadings')
    plt.show()
    ```

    **Interpretation:**
    - Large positive value: Feature increases with component
    - Large negative value: Feature decreases with component
    - Near zero: Feature doesn't affect component

    ## Real-World Example: Dimensionality Reduction for ML

    ```python
    import pandas as pd
    from sklearn.decomposition import PCA
    from sklearn.preprocessing import StandardScaler
    from sklearn.ensemble import RandomForestClassifier
    from sklearn.model_selection import train_test_split, cross_val_score
    import time

    # Load high-dimensional dataset
    from sklearn.datasets import load_digits
    digits = load_digits()
    X = digits.data  # 64 features (8x8 images)
    y = digits.target

    # Split data
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )

    # Scale data
    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)

    # === Without PCA ===
    print("=" * 50)
    print("WITHOUT PCA (64 features)")
    print("=" * 50)

    start = time.time()
    rf_full = RandomForestClassifier(n_estimators=100, random_state=42)
    rf_full.fit(X_train_scaled, y_train)
    time_full = time.time() - start

    score_full = rf_full.score(X_test_scaled, y_test)
    cv_scores_full = cross_val_score(rf_full, X_train_scaled, y_train, cv=5)

    print(f"Training time: {time_full:.2f}s")
    print(f"Test accuracy: {score_full:.4f}")
    print(f"CV accuracy: {cv_scores_full.mean():.4f} (+/- {cv_scores_full.std()*2:.4f})")

    # === With PCA ===
    print("\\n" + "=" * 50)
    print("WITH PCA (Reduced to 95% variance)")
    print("=" * 50)

    # Apply PCA
    pca = PCA(n_components=0.95)
    X_train_pca = pca.fit_transform(X_train_scaled)
    X_test_pca = pca.transform(X_test_scaled)

    print(f"Reduced from {X_train_scaled.shape[1]} to {X_train_pca.shape[1]} features")
    print(f"Variance retained: {pca.explained_variance_ratio_.sum():.4f}")

    start = time.time()
    rf_pca = RandomForestClassifier(n_estimators=100, random_state=42)
    rf_pca.fit(X_train_pca, y_train)
    time_pca = time.time() - start

    score_pca = rf_pca.score(X_test_pca, y_test)
    cv_scores_pca = cross_val_score(rf_pca, X_train_pca, y_train, cv=5)

    print(f"Training time: {time_pca:.2f}s ({time_full/time_pca:.1f}x speedup)")
    print(f"Test accuracy: {score_pca:.4f}")
    print(f"CV accuracy: {cv_scores_pca.mean():.4f} (+/- {cv_scores_pca.std()*2:.4f})")

    # Summary
    print("\\n" + "=" * 50)
    print("SUMMARY")
    print("=" * 50)
    print(f"Feature reduction: {X.shape[1]} → {X_train_pca.shape[1]} "
          f"({X_train_pca.shape[1]/X.shape[1]:.1%})")
    print(f"Speed improvement: {time_full/time_pca:.1f}x faster")
    print(f"Accuracy change: {score_pca - score_full:+.4f}")
    ```

    ## PCA for Visualization

    ### Visualize High-Dimensional Data in 2D/3D

    ```python
    from sklearn.datasets import load_wine
    import matplotlib.pyplot as plt
    from mpl_toolkits.mplot3d import Axes3D

    # Load dataset (13 features)
    wine = load_wine()
    X = wine.data
    y = wine.target

    # Scale
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)

    # PCA to 2D
    pca_2d = PCA(n_components=2)
    X_2d = pca_2d.fit_transform(X_scaled)

    # PCA to 3D
    pca_3d = PCA(n_components=3)
    X_3d = pca_3d.fit_transform(X_scaled)

    # Plot 2D
    plt.figure(figsize=(14, 6))

    plt.subplot(1, 2, 1)
    for i, target_name in enumerate(wine.target_names):
        plt.scatter(X_2d[y==i, 0], X_2d[y==i, 1], label=target_name, alpha=0.8)
    plt.xlabel(f'PC1 ({pca_2d.explained_variance_ratio_[0]:.2%})')
    plt.ylabel(f'PC2 ({pca_2d.explained_variance_ratio_[1]:.2%})')
    plt.title(f'PCA 2D (Total: {pca_2d.explained_variance_ratio_.sum():.2%} variance)')
    plt.legend()
    plt.grid(True)

    # Plot 3D
    ax = plt.subplot(1, 2, 2, projection='3d')
    for i, target_name in enumerate(wine.target_names):
        ax.scatter(X_3d[y==i, 0], X_3d[y==i, 1], X_3d[y==i, 2], label=target_name, alpha=0.8)
    ax.set_xlabel(f'PC1 ({pca_3d.explained_variance_ratio_[0]:.2%})')
    ax.set_ylabel(f'PC2 ({pca_3d.explained_variance_ratio_[1]:.2%})')
    ax.set_zlabel(f'PC3 ({pca_3d.explained_variance_ratio_[2]:.2%})')
    ax.set_title(f'PCA 3D (Total: {pca_3d.explained_variance_ratio_.sum():.2%} variance)')
    ax.legend()

    plt.tight_layout()
    plt.show()
    ```

    ## Inverse Transform

    Reconstruct original data from reduced dimensions

    ```python
    # Original data
    X_original = X_scaled

    # Apply PCA
    pca = PCA(n_components=2)
    X_reduced = pca.fit_transform(X_original)

    # Reconstruct
    X_reconstructed = pca.inverse_transform(X_reduced)

    # Calculate reconstruction error
    reconstruction_error = np.mean((X_original - X_reconstructed) ** 2)
    print(f"Reconstruction error: {reconstruction_error:.6f}")

    # Visualize (for images)
    # Original vs reconstructed
    ```

    ## Other Dimensionality Reduction Techniques

    ### 1. t-SNE (t-Distributed Stochastic Neighbor Embedding)

    Better for visualization, preserves local structure

    ```python
    from sklearn.manifold import TSNE

    tsne = TSNE(n_components=2, random_state=42)
    X_tsne = tsne.fit_transform(X_scaled)

    plt.scatter(X_tsne[:, 0], X_tsne[:, 1], c=y, cmap='viridis')
    plt.title('t-SNE Visualization')
    plt.colorbar()
    plt.show()
    ```

    **PCA vs t-SNE:**
    - **PCA:** Linear, fast, preserves global structure
    - **t-SNE:** Non-linear, slower, preserves local structure, better for visualization

    ### 2. Truncated SVD (for sparse data)

    ```python
    from sklearn.decomposition import TruncatedSVD

    # Works with sparse matrices (e.g., text data)
    svd = TruncatedSVD(n_components=50)
    X_reduced = svd.fit_transform(X_sparse)
    ```

    ### 3. UMAP (Uniform Manifold Approximation and Projection)

    ```python
    import umap

    reducer = umap.UMAP(n_components=2, random_state=42)
    X_umap = reducer.fit_transform(X_scaled)

    plt.scatter(X_umap[:, 0], X_umap[:, 1], c=y, cmap='viridis')
    plt.title('UMAP Visualization')
    plt.show()
    ```

    ## Advantages

    ✅ Reduces dimensionality while preserving variance
    ✅ Removes correlated features
    ✅ Speeds up training
    ✅ Reduces overfitting
    ✅ Enables visualization of high-D data
    ✅ Removes noise

    ## Disadvantages

    ❌ Components are not interpretable
    ❌ Requires feature scaling
    ❌ Linear method (may miss non-linear patterns)
    ❌ Sensitive to outliers
    ❌ Can't apply to new data without retraining

    ## When to Use PCA

    ### ✅ Good Fit
    - High-dimensional data (many features)
    - Correlated features
    - Need faster training
    - Visualization needed
    - Reduce overfitting

    ### ❌ Not Good Fit
    - Features already independent
    - Need interpretability
    - Non-linear relationships
    - Very few features

    ## Best Practices

    1. **Always scale data first** (PCA is sensitive to scale)
    2. **Choose components** based on explained variance (e.g., 95%)
    3. **Check cumulative variance** to understand information loss
    4. **Use for preprocessing** before ML algorithms
    5. **Consider t-SNE/UMAP** for visualization only
    6. **Save scaler and PCA** for transforming new data
    7. **Interpret components** via loadings if needed

    ## Key Takeaways

    1. **PCA reduces dimensions** while preserving variance
    2. **Principal components** are uncorrelated
    3. **Always scale** before PCA
    4. **Choose components** based on variance threshold
    5. **Speeds up ML** and reduces overfitting
    6. **Great for visualization** of high-D data
    7. **Linear method** - may miss non-linear patterns
    8. **Components not interpretable** like original features

    ## Next Steps

    - Practice with high-dimensional datasets
    - Experiment with different variance thresholds
    - Compare PCA vs t-SNE for visualization
    - Apply PCA before ML models
    - Learn about kernel PCA for non-linear patterns
  MARKDOWN
  course_module: module3,
  sequence_order: 2,
  estimated_minutes: 60,
  published: true
)

puts "  ✅ Created #{module3.course_lessons.count} lessons for Module 3: Unsupervised Learning"

puts "  ✅ Created Module 3: Unsupervised Learning"

# ========================================
# Module 4: Model Evaluation and Deployment
# ========================================

module4 = CourseModule.find_or_create_by!(slug: 'ml-evaluation-deployment', course: ml_course) do |mod|
  mod.title = 'Model Evaluation and Deployment'
  mod.description = 'Cross-validation, metrics, and production ML'
  mod.sequence_order = 4
  mod.estimated_minutes = 160
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Use cross-validation effectively",
    "Choose appropriate evaluation metrics",
    "Tune hyperparameters systematically",
    "Deploy models to production"
  ])
end

# Lesson 4.1: Cross-Validation and Model Selection
lesson4_1 = CourseLesson.create!(
  title: "Cross-Validation and Model Selection",
  content: <<~MARKDOWN,
    # Cross-Validation and Model Selection

    Cross-validation is a crucial technique for evaluating ML models and estimating their performance on unseen data.

    ## The Problem with Train/Test Split

    ### Single Split Issues

    ```python
    # Single train/test split
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)
    model.fit(X_train, y_train)
    score = model.score(X_test, y_test)
    ```

    **Problems:**
    - **High variance:** Performance depends on which data points end up in test set
    - **Wasted data:** Test set not used for training
    - **Overfitting risk:** Might tune model to perform well on this specific test set

    ## What is Cross-Validation?

    **Idea:** Split data into K folds, train on K-1 folds, test on 1 fold, repeat K times

    **Benefits:**
    - More reliable performance estimate
    - Uses all data for both training and testing
    - Reduces variance in performance estimates

    ## K-Fold Cross-Validation

    ### How It Works

    1. Split data into K equal folds
    2. For each fold:
       - Train on K-1 folds
       - Test on remaining fold
    3. Average the K scores

    ### Python Implementation

    ```python
    from sklearn.model_selection import cross_val_score
    from sklearn.linear_model import LogisticRegression
    from sklearn.datasets import load_iris

    # Load data
    iris = load_iris()
    X, y = iris.data, iris.target

    # Create model
    model = LogisticRegression(max_iter=1000)

    # 5-fold cross-validation
    scores = cross_val_score(model, X, y, cv=5, scoring='accuracy')

    print(f"Fold scores: {scores}")
    print(f"Mean accuracy: {scores.mean():.4f}")
    print(f"Standard deviation: {scores.std():.4f}")
    print(f"95% confidence interval: {scores.mean():.4f} (+/- {scores.std() * 2:.4f})")
    ```

    ## Types of Cross-Validation

    ### 1. K-Fold CV (Standard)

    ```python
    from sklearn.model_selection import KFold

    kf = KFold(n_splits=5, shuffle=True, random_state=42)

    for train_index, test_index in kf.split(X):
        X_train, X_test = X[train_index], X[test_index]
        y_train, y_test = y[train_index], y[test_index]

        model.fit(X_train, y_train)
        score = model.score(X_test, y_test)
        print(f"Fold score: {score:.4f}")
    ```

    **When to use:** Standard choice for most problems

    ### 2. Stratified K-Fold (For Classification)

    Maintains class distribution in each fold

    ```python
    from sklearn.model_selection import StratifiedKFold

    skf = StratifiedKFold(n_splits=5, shuffle=True, random_state=42)
    scores = cross_val_score(model, X, y, cv=skf, scoring='accuracy')

    print(f"Stratified CV scores: {scores}")
    print(f"Mean: {scores.mean():.4f}")
    ```

    **When to use:**
    - Imbalanced classification problems
    - Small datasets
    - **Recommended default for classification**

    ### 3. Leave-One-Out CV (LOOCV)

    K = n (number of samples)

    ```python
    from sklearn.model_selection import LeaveOneOut

    loo = LeaveOneOut()
    scores = cross_val_score(model, X, y, cv=loo)

    print(f"LOOCV accuracy: {scores.mean():.4f}")
    ```

    **Pros:**
    - Uses maximum data for training
    - Low bias

    **Cons:**
    - Computationally expensive
    - High variance

    **When to use:** Very small datasets only

    ### 4. Time Series Split

    Respects temporal order

    ```python
    from sklearn.model_selection import TimeSeriesSplit

    tss = TimeSeriesSplit(n_splits=5)

    for train_index, test_index in tss.split(X):
        X_train, X_test = X[train_index], X[test_index]
        y_train, y_test = y[train_index], y[test_index]

        # Train always comes before test (no data leakage)
        print(f"Train: {train_index.min()}-{train_index.max()} | "
              f"Test: {test_index.min()}-{test_index.max()}")
    ```

    **When to use:** Time series data (stock prices, weather, etc.)

    ## Choosing K

    ### Common Choices

    - **K=5 or K=10:** Most common, good balance
    - **K=3:** Faster, more variance
    - **K=20:** More computation, lower variance

    ### Trade-offs

    **Small K (e.g., 3):**
    - Faster
    - More bias (less training data per fold)
    - More variance (fewer folds to average)

    **Large K (e.g., 10, 20):**
    - Slower
    - Less bias (more training data per fold)
    - Less variance (more folds to average)

    **Rule of thumb:** K=5 or K=10 for most problems

    ## Cross-Validation for Different Tasks

    ### Classification

    ```python
    from sklearn.model_selection import cross_val_score
    from sklearn.ensemble import RandomForestClassifier

    rf = RandomForestClassifier(n_estimators=100, random_state=42)

    # Multiple metrics
    accuracy = cross_val_score(rf, X, y, cv=5, scoring='accuracy')
    precision = cross_val_score(rf, X, y, cv=5, scoring='precision_weighted')
    recall = cross_val_score(rf, X, y, cv=5, scoring='recall_weighted')
    f1 = cross_val_score(rf, X, y, cv=5, scoring='f1_weighted')

    print(f"Accuracy: {accuracy.mean():.4f} (+/- {accuracy.std()*2:.4f})")
    print(f"Precision: {precision.mean():.4f} (+/- {precision.std()*2:.4f})")
    print(f"Recall: {recall.mean():.4f} (+/- {recall.std()*2:.4f})")
    print(f"F1: {f1.mean():.4f} (+/- {f1.std()*2:.4f})")
    ```

    ### Regression

    ```python
    from sklearn.linear_model import Ridge

    ridge = Ridge(alpha=1.0)

    # Multiple metrics
    r2 = cross_val_score(ridge, X, y, cv=5, scoring='r2')
    mse = cross_val_score(ridge, X, y, cv=5, scoring='neg_mean_squared_error')
    mae = cross_val_score(ridge, X, y, cv=5, scoring='neg_mean_absolute_error')

    print(f"R²: {r2.mean():.4f}")
    print(f"MSE: {-mse.mean():.4f}")  # Negative because sklearn returns negative MSE
    print(f"MAE: {-mae.mean():.4f}")
    ```

    ## Model Selection

    ### Comparing Multiple Models

    ```python
    from sklearn.linear_model import LogisticRegression
    from sklearn.tree import DecisionTreeClassifier
    from sklearn.ensemble import RandomForestClassifier
    from sklearn.svm import SVC
    from sklearn.naive_bayes import GaussianNB

    models = {
        'Logistic Regression': LogisticRegression(max_iter=1000),
        'Decision Tree': DecisionTreeClassifier(random_state=42),
        'Random Forest': RandomForestClassifier(n_estimators=100, random_state=42),
        'SVM': SVC(random_state=42),
        'Naive Bayes': GaussianNB()
    }

    results = {}

    for name, model in models.items():
        scores = cross_val_score(model, X, y, cv=5, scoring='accuracy')
        results[name] = {
            'mean': scores.mean(),
            'std': scores.std()
        }
        print(f"{name:20s}: {scores.mean():.4f} (+/- {scores.std()*2:.4f})")

    # Find best model
    best_model_name = max(results, key=lambda k: results[k]['mean'])
    print(f"\\nBest model: {best_model_name}")
    ```

    ## Cross-Validation with Preprocessing

    ### The Wrong Way (Data Leakage!)

    ```python
    # ❌ WRONG - Scaling before split causes data leakage!
    from sklearn.preprocessing import StandardScaler

    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)  # Uses ALL data including test!

    scores = cross_val_score(model, X_scaled, y, cv=5)
    # This is cheating! Model has seen test data statistics
    ```

    ### The Right Way (Using Pipeline)

    ```python
    # ✅ CORRECT - Pipeline ensures no data leakage
    from sklearn.pipeline import Pipeline

    pipeline = Pipeline([
        ('scaler', StandardScaler()),
        ('model', LogisticRegression(max_iter=1000))
    ])

    scores = cross_val_score(pipeline, X, y, cv=5, scoring='accuracy')
    print(f"Accuracy: {scores.mean():.4f} (+/- {scores.std()*2:.4f})")

    # Scaler is fit only on training folds, not test fold!
    ```

    ## Nested Cross-Validation

    For hyperparameter tuning AND model evaluation

    ```python
    from sklearn.model_selection import GridSearchCV, cross_val_score
    from sklearn.ensemble import RandomForestClassifier

    # Inner CV: Hyperparameter tuning
    param_grid = {
        'n_estimators': [50, 100, 200],
        'max_depth': [5, 10, None]
    }

    rf = RandomForestClassifier(random_state=42)
    grid_search = GridSearchCV(rf, param_grid, cv=3, scoring='accuracy')

    # Outer CV: Model evaluation
    outer_scores = cross_val_score(grid_search, X, y, cv=5, scoring='accuracy')

    print(f"Nested CV accuracy: {outer_scores.mean():.4f} (+/- {outer_scores.std()*2:.4f})")
    ```

    **Why nested CV:**
    - Inner CV: Find best hyperparameters
    - Outer CV: Evaluate model with best hyperparameters
    - Prevents overfitting to validation set

    ## Real-World Example

    ```python
    import pandas as pd
    import numpy as np
    from sklearn.model_selection import cross_val_score, StratifiedKFold
    from sklearn.pipeline import Pipeline
    from sklearn.preprocessing import StandardScaler
    from sklearn.impute import SimpleImputer
    from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
    from sklearn.linear_model import LogisticRegression
    from sklearn.svm import SVC
    import matplotlib.pyplot as plt

    # Load data (example)
    # df = pd.read_csv('data.csv')

    X = df.drop('target', axis=1)
    y = df['target']

    # Create pipelines for different models
    models = {
        'Logistic Regression': Pipeline([
            ('imputer', SimpleImputer(strategy='median')),
            ('scaler', StandardScaler()),
            ('model', LogisticRegression(max_iter=1000))
        ]),
        'Random Forest': Pipeline([
            ('imputer', SimpleImputer(strategy='median')),
            ('model', RandomForestClassifier(n_estimators=100, random_state=42))
        ]),
        'Gradient Boosting': Pipeline([
            ('imputer', SimpleImputer(strategy='median')),
            ('model', GradientBoostingClassifier(random_state=42))
        ]),
        'SVM': Pipeline([
            ('imputer', SimpleImputer(strategy='median')),
            ('scaler', StandardScaler()),
            ('model', SVC(random_state=42))
        ])
    }

    # Stratified K-Fold for imbalanced data
    cv = StratifiedKFold(n_splits=5, shuffle=True, random_state=42)

    # Evaluate all models
    results = []

    for name, pipeline in models.items():
        scores = cross_val_score(pipeline, X, y, cv=cv, scoring='roc_auc', n_jobs=-1)
        results.append({
            'Model': name,
            'Mean AUC': scores.mean(),
            'Std AUC': scores.std(),
            'Scores': scores
        })
        print(f"{name:20s}: AUC = {scores.mean():.4f} (+/- {scores.std()*2:.4f})")

    # Visualize results
    results_df = pd.DataFrame(results)
    results_df = results_df.sort_values('Mean AUC', ascending=False)

    plt.figure(figsize=(10, 6))
    plt.errorbar(
        range(len(results_df)),
        results_df['Mean AUC'],
        yerr=results_df['Std AUC']*2,
        fmt='o',
        markersize=10,
        capsize=5
    )
    plt.xticks(range(len(results_df)), results_df['Model'], rotation=45)
    plt.ylabel('AUC Score')
    plt.title('Model Comparison with 95% Confidence Intervals')
    plt.grid(True, alpha=0.3)
    plt.tight_layout()
    plt.show()

    # Select best model
    best_model_name = results_df.iloc[0]['Model']
    print(f"\\nBest model: {best_model_name}")

    # Train best model on full data
    best_pipeline = models[best_model_name]
    best_pipeline.fit(X, y)
    ```

    ## Common Scoring Metrics

    ### Classification

    ```python
    scoring_options = [
        'accuracy',
        'precision',
        'recall',
        'f1',
        'roc_auc',
        'average_precision',
        'precision_weighted',
        'recall_weighted',
        'f1_weighted'
    ]
    ```

    ### Regression

    ```python
    scoring_options = [
        'r2',
        'neg_mean_squared_error',
        'neg_mean_absolute_error',
        'neg_root_mean_squared_error'
    ]
    ```

    ## Best Practices

    1. **Use Stratified K-Fold** for classification (maintains class balance)
    2. **Use Pipeline** to prevent data leakage
    3. **Choose K=5 or K=10** for most problems
    4. **Report mean AND std** to show variance
    5. **Use appropriate metric** for your problem
    6. **Nested CV** when tuning hyperparameters
    7. **Time Series Split** for temporal data
    8. **Set random_state** for reproducibility

    ## Common Mistakes

    ### 1. Data Leakage

    ```python
    # ❌ WRONG
    scaler.fit(X)  # Fits on ALL data
    X_scaled = scaler.transform(X)
    cross_val_score(model, X_scaled, y, cv=5)

    # ✅ CORRECT
    pipeline = Pipeline([('scaler', StandardScaler()), ('model', model)])
    cross_val_score(pipeline, X, y, cv=5)
    ```

    ### 2. Not Using Stratification

    ```python
    # ❌ For imbalanced classification
    cross_val_score(model, X, y, cv=5)

    # ✅ Better
    cv = StratifiedKFold(n_splits=5)
    cross_val_score(model, X, y, cv=cv)
    ```

    ### 3. Testing on Training Data

    ```python
    # ❌ WRONG
    model.fit(X_train, y_train)
    score = model.score(X_train, y_train)  # Cheating!

    # ✅ CORRECT
    model.fit(X_train, y_train)
    score = model.score(X_test, y_test)  # Unseen data
    ```

    ## Advantages

    ✅ More reliable performance estimate
    ✅ Uses all data for training and testing
    ✅ Reduces overfitting risk
    ✅ Detects high variance models
    ✅ Better than single train/test split

    ## Disadvantages

    ❌ More computationally expensive
    ❌ Not suitable for very large datasets (use holdout instead)
    ❌ Can be slow with large K or complex models

    ## When to Use

    ### ✅ Use Cross-Validation
    - Model selection
    - Hyperparameter tuning
    - Small to medium datasets
    - Need reliable performance estimate

    ### ❌ Use Simple Train/Test Split
    - Very large datasets
    - Time/compute constraints
    - Production deployment (train on all data)

    ## Key Takeaways

    1. **Cross-validation** gives more reliable performance estimates
    2. **K=5 or K=10** is standard choice
    3. **Stratified K-Fold** for classification
    4. **Use Pipeline** to prevent data leakage
    5. **Report mean ± std** for confidence intervals
    6. **Nested CV** for hyperparameter tuning
    7. **Time Series Split** for temporal data
    8. **Always use unseen data** for final evaluation

    ## Next Steps

    - Practice with different CV strategies
    - Learn hyperparameter tuning with GridSearchCV
    - Study evaluation metrics in depth
    - Implement nested cross-validation
    - Learn about cross-validation for time series
  MARKDOWN
  course_module: module4,
  sequence_order: 1,
  estimated_minutes: 60,
  published: true
)

# Lesson 4.2: Hyperparameter Tuning
lesson4_2 = CourseLesson.create!(
  title: "Hyperparameter Tuning",
  content: <<~MARKDOWN,
    # Hyperparameter Tuning

    Hyperparameters are settings that control the learning process. Tuning them properly can significantly improve model performance.

    ## Hyperparameters vs Parameters

    ### Parameters (Learned)
    - **Learned from data** during training
    - Examples: weights in neural networks, coefficients in linear regression

    ### Hyperparameters (Set Before Training)
    - **Set before training** begins
    - Control the learning process
    - Examples: learning rate, number of trees, max depth

    ## Common Hyperparameters by Algorithm

    ### Random Forest

    ```python
    RandomForestClassifier(
        n_estimators=100,        # Number of trees
        max_depth=None,          # Max depth of trees
        min_samples_split=2,     # Min samples to split node
        min_samples_leaf=1,      # Min samples in leaf
        max_features='sqrt',     # Features per split
        random_state=42
    )
    ```

    ### Gradient Boosting

    ```python
    GradientBoostingClassifier(
        n_estimators=100,        # Number of boosting stages
        learning_rate=0.1,       # Shrinks contribution of each tree
        max_depth=3,             # Max depth of trees
        subsample=1.0,           # Fraction of samples for training each tree
        random_state=42
    )
    ```

    ### SVM

    ```python
    SVC(
        C=1.0,                   # Regularization parameter
        kernel='rbf',            # Kernel type
        gamma='scale',           # Kernel coefficient
        random_state=42
    )
    ```

    ### Logistic Regression

    ```python
    LogisticRegression(
        C=1.0,                   # Inverse of regularization strength
        penalty='l2',            # Regularization type
        solver='lbfgs',          # Optimization algorithm
        max_iter=100
    )
    ```

    ## Grid Search

    **Idea:** Try all combinations of hyperparameters

    ### Basic Example

    ```python
    from sklearn.model_selection import GridSearchCV
    from sklearn.ensemble import RandomForestClassifier
    from sklearn.datasets import load_iris

    # Load data
    iris = load_iris()
    X, y = iris.data, iris.target

    # Define parameter grid
    param_grid = {
        'n_estimators': [50, 100, 200],
        'max_depth': [3, 5, 7, None],
        'min_samples_split': [2, 5, 10]
    }

    # Create model
    rf = RandomForestClassifier(random_state=42)

    # Grid search
    grid_search = GridSearchCV(
        rf,
        param_grid,
        cv=5,                    # 5-fold cross-validation
        scoring='accuracy',
        n_jobs=-1,               # Use all CPU cores
        verbose=1
    )

    # Fit
    grid_search.fit(X, y)

    # Results
    print(f"Best parameters: {grid_search.best_params_}")
    print(f"Best CV score: {grid_search.best_score_:.4f}")

    # Use best model
    best_model = grid_search.best_estimator_
    ```

    ### Analyzing Results

    ```python
    import pandas as pd

    # Convert results to DataFrame
    results_df = pd.DataFrame(grid_search.cv_results_)

    # View top 10 configurations
    results_df = results_df.sort_values('rank_test_score')
    print(results_df[['params', 'mean_test_score', 'std_test_score', 'rank_test_score']].head(10))

    # Visualize (for 2 hyperparameters)
    import matplotlib.pyplot as plt
    import numpy as np

    # Extract results for visualization
    scores = grid_search.cv_results_['mean_test_score']
    scores = scores.reshape(len(param_grid['n_estimators']),
                           len(param_grid['max_depth']))

    plt.figure(figsize=(10, 6))
    plt.imshow(scores, interpolation='nearest', cmap='viridis')
    plt.xlabel('max_depth')
    plt.ylabel('n_estimators')
    plt.colorbar(label='Accuracy')
    plt.xticks(np.arange(len(param_grid['max_depth'])), param_grid['max_depth'])
    plt.yticks(np.arange(len(param_grid['n_estimators'])), param_grid['n_estimators'])
    plt.title('Grid Search Results')
    plt.show()
    ```

    ## Randomized Search

    **Idea:** Try random combinations (faster than grid search)

    ### When to Use

    - Large hyperparameter space
    - Limited computational budget
    - Want to explore more broadly

    ### Example

    ```python
    from sklearn.model_selection import RandomizedSearchCV
    from scipy.stats import randint, uniform

    # Define distributions to sample from
    param_distributions = {
        'n_estimators': randint(50, 500),           # Random int between 50-500
        'max_depth': randint(3, 20),                # Random int between 3-20
        'min_samples_split': randint(2, 20),
        'min_samples_leaf': randint(1, 10),
        'max_features': ['sqrt', 'log2', None],
        'bootstrap': [True, False]
    }

    rf = RandomForestClassifier(random_state=42)

    # Randomized search
    random_search = RandomizedSearchCV(
        rf,
        param_distributions,
        n_iter=50,              # Try 50 random combinations
        cv=5,
        scoring='accuracy',
        n_jobs=-1,
        random_state=42,
        verbose=1
    )

    random_search.fit(X, y)

    print(f"Best parameters: {random_search.best_params_}")
    print(f"Best CV score: {random_search.best_score_:.4f}")
    ```

    ## Comparison: Grid vs Random Search

    | Aspect | Grid Search | Random Search |
    |--------|-------------|---------------|
    | **Coverage** | Exhaustive | Random sample |
    | **Speed** | Slower | Faster |
    | **Best for** | Small param space | Large param space |
    | **Reproducible** | Yes | Yes (with seed) |
    | **Efficiency** | Lower | Higher |

    ```python
    # Grid Search: 3 × 4 × 3 = 36 combinations
    param_grid = {
        'n_estimators': [50, 100, 200],
        'max_depth': [3, 5, 7, None],
        'min_samples_split': [2, 5, 10]
    }

    # Random Search: Try 50 random combinations
    # Much more efficient for large spaces!
    ```

    ## Advanced: Bayesian Optimization

    **Idea:** Use past evaluations to choose next hyperparameters

    ### Using Optuna

    ```python
    import optuna
    from sklearn.ensemble import RandomForestClassifier
    from sklearn.model_selection import cross_val_score

    def objective(trial):
        # Suggest hyperparameters
        n_estimators = trial.suggest_int('n_estimators', 50, 500)
        max_depth = trial.suggest_int('max_depth', 3, 20)
        min_samples_split = trial.suggest_int('min_samples_split', 2, 20)

        # Create model
        rf = RandomForestClassifier(
            n_estimators=n_estimators,
            max_depth=max_depth,
            min_samples_split=min_samples_split,
            random_state=42
        )

        # Evaluate
        scores = cross_val_score(rf, X, y, cv=5, scoring='accuracy')
        return scores.mean()

    # Create study
    study = optuna.create_study(direction='maximize')
    study.optimize(objective, n_trials=100)

    print(f"Best parameters: {study.best_params}")
    print(f"Best CV score: {study.best_value:.4f}")

    # Visualize optimization history
    optuna.visualization.plot_optimization_history(study)
    ```

    ## Hyperparameter Tuning with Pipeline

    ```python
    from sklearn.pipeline import Pipeline
    from sklearn.preprocessing import StandardScaler
    from sklearn.svm import SVC

    # Create pipeline
    pipeline = Pipeline([
        ('scaler', StandardScaler()),
        ('svm', SVC())
    ])

    # Define parameters (use pipeline step name prefix)
    param_grid = {
        'svm__C': [0.1, 1, 10, 100],
        'svm__kernel': ['linear', 'rbf'],
        'svm__gamma': ['scale', 'auto', 0.1, 0.01]
    }

    grid_search = GridSearchCV(pipeline, param_grid, cv=5, scoring='accuracy')
    grid_search.fit(X, y)

    print(f"Best parameters: {grid_search.best_params_}")
    ```

    ## Real-World Example: Complete Tuning Workflow

    ```python
    import pandas as pd
    import numpy as np
    from sklearn.model_selection import train_test_split, RandomizedSearchCV, cross_val_score
    from sklearn.ensemble import RandomForestClassifier
    from sklearn.metrics import classification_report, confusion_matrix
    from scipy.stats import randint
    import matplotlib.pyplot as plt
    import seaborn as sns

    # Load data
    from sklearn.datasets import load_breast_cancer
    data = load_breast_cancer()
    X, y = data.data, data.target

    # Split data (hold out final test set)
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42, stratify=y
    )

    # Define hyperparameter space
    param_distributions = {
        'n_estimators': randint(100, 500),
        'max_depth': [5, 10, 15, 20, None],
        'min_samples_split': randint(2, 20),
        'min_samples_leaf': randint(1, 10),
        'max_features': ['sqrt', 'log2', None],
        'bootstrap': [True, False],
        'class_weight': ['balanced', None]
    }

    # Create model
    rf = RandomForestClassifier(random_state=42)

    # Randomized search with stratified k-fold
    random_search = RandomizedSearchCV(
        rf,
        param_distributions,
        n_iter=100,                    # Try 100 combinations
        cv=5,                          # 5-fold CV
        scoring='roc_auc',             # Optimize for AUC
        n_jobs=-1,
        random_state=42,
        verbose=1,
        return_train_score=True
    )

    # Fit
    print("Starting hyperparameter search...")
    random_search.fit(X_train, y_train)

    print(f"\\nBest parameters: {random_search.best_params_}")
    print(f"Best CV AUC: {random_search.best_score_:.4f}")

    # Analyze results
    results_df = pd.DataFrame(random_search.cv_results_)
    results_df = results_df.sort_values('rank_test_score')

    print(f"\\nTop 5 configurations:")
    print(results_df[['params', 'mean_test_score', 'std_test_score']].head())

    # Check for overfitting
    plt.figure(figsize=(10, 6))
    plt.scatter(results_df['mean_train_score'], results_df['mean_test_score'], alpha=0.5)
    plt.plot([0, 1], [0, 1], 'r--', label='Perfect fit')
    plt.xlabel('Training Score')
    plt.ylabel('Validation Score')
    plt.title('Training vs Validation Scores')
    plt.legend()
    plt.grid(True, alpha=0.3)
    plt.show()

    # Get best model
    best_model = random_search.best_estimator_

    # Evaluate on test set
    y_pred = best_model.predict(X_test)
    y_pred_proba = best_model.predict_proba(X_test)[:, 1]

    from sklearn.metrics import roc_auc_score
    test_auc = roc_auc_score(y_test, y_pred_proba)

    print(f"\\nTest set AUC: {test_auc:.4f}")
    print(f"\\nClassification Report:")
    print(classification_report(y_test, y_pred, target_names=data.target_names))

    # Confusion matrix
    cm = confusion_matrix(y_test, y_pred)
    plt.figure(figsize=(8, 6))
    sns.heatmap(cm, annot=True, fmt='d', cmap='Blues',
                xticklabels=data.target_names,
                yticklabels=data.target_names)
    plt.title('Confusion Matrix')
    plt.ylabel('True Label')
    plt.xlabel('Predicted Label')
    plt.show()

    # Feature importance
    feature_importance = pd.DataFrame({
        'feature': data.feature_names,
        'importance': best_model.feature_importances_
    }).sort_values('importance', ascending=False)

    plt.figure(figsize=(10, 8))
    plt.barh(feature_importance.head(10)['feature'],
             feature_importance.head(10)['importance'])
    plt.xlabel('Importance')
    plt.title('Top 10 Most Important Features')
    plt.gca().invert_yaxis()
    plt.tight_layout()
    plt.show()
    ```

    ## Tuning Strategies

    ### 1. Coarse to Fine

    ```python
    # Step 1: Coarse search (wide range, fewer values)
    param_grid_coarse = {
        'n_estimators': [50, 200, 500],
        'max_depth': [5, 15, None]
    }
    grid_coarse = GridSearchCV(rf, param_grid_coarse, cv=5)
    grid_coarse.fit(X_train, y_train)

    # Step 2: Fine search (narrow range around best, more values)
    param_grid_fine = {
        'n_estimators': [150, 200, 250],
        'max_depth': [13, 15, 17]
    }
    grid_fine = GridSearchCV(rf, param_grid_fine, cv=5)
    grid_fine.fit(X_train, y_train)
    ```

    ### 2. One-at-a-Time

    ```python
    # Tune each hyperparameter separately (faster but misses interactions)

    # Step 1: Tune n_estimators
    param_grid_1 = {'n_estimators': [50, 100, 200, 300, 500]}
    # ... find best n_estimators

    # Step 2: Fix n_estimators, tune max_depth
    param_grid_2 = {'max_depth': [5, 10, 15, 20, None]}
    # ... and so on
    ```

    ## Tips for Effective Tuning

    ### 1. Start with Default Parameters

    ```python
    # Baseline with defaults
    rf_default = RandomForestClassifier(random_state=42)
    baseline_score = cross_val_score(rf_default, X, y, cv=5).mean()
    print(f"Baseline score: {baseline_score:.4f}")

    # Only tune if baseline is insufficient
    ```

    ### 2. Understand Hyperparameter Effects

    - **n_estimators:** More is usually better (diminishing returns)
    - **max_depth:** Controls overfitting (lower = less overfit)
    - **learning_rate:** Lower = better but slower
    - **C (SVM/LogReg):** Lower = more regularization

    ### 3. Use Domain Knowledge

    ```python
    # If you know data is complex, try deeper trees
    param_grid = {
        'max_depth': [15, 20, 25, None],  # Focus on deeper trees
        # ...
    }
    ```

    ### 4. Monitor for Overfitting

    ```python
    # Check train vs validation scores
    random_search = RandomizedSearchCV(
        rf, param_distributions,
        n_iter=50,
        cv=5,
        return_train_score=True  # Important!
    )

    # If train score >> validation score → overfitting
    ```

    ## Common Pitfalls

    ### 1. Data Leakage

    ```python
    # ❌ WRONG - Tuning on test set
    grid_search.fit(X_test, y_test)

    # ✅ CORRECT - Separate train/validation/test
    # Train: For training
    # Validation: For hyperparameter tuning (via CV)
    # Test: For final evaluation (never used in tuning!)
    ```

    ### 2. Overfitting to Validation Set

    ```python
    # ❌ WRONG - Trying too many combinations
    # Leads to overfitting the validation set

    # ✅ BETTER - Use nested CV
    from sklearn.model_selection import cross_val_score
    outer_scores = cross_val_score(grid_search, X, y, cv=5)
    ```

    ### 3. Not Setting random_state

    ```python
    # ❌ Non-reproducible
    RandomForestClassifier()

    # ✅ Reproducible
    RandomForestClassifier(random_state=42)
    ```

    ## Best Practices

    1. **Hold out test set** - Never use for tuning
    2. **Use cross-validation** - More reliable than single validation set
    3. **Start broad, then narrow** - Coarse to fine search
    4. **Random search first** - Explore space efficiently
    5. **Monitor overfitting** - Check train vs validation scores
    6. **Set random_state** - For reproducibility
    7. **Use appropriate metric** - Match business objective
    8. **Don't over-tune** - Risk overfitting to validation set

    ## Advantages

    ✅ Can significantly improve performance
    ✅ Finds optimal model configuration
    ✅ Automated process
    ✅ Works with any scikit-learn model

    ## Disadvantages

    ❌ Computationally expensive
    ❌ Risk of overfitting to validation set
    ❌ May not find global optimum (grid/random)
    ❌ Requires computational resources

    ## Key Takeaways

    1. **Hyperparameters control learning** process
    2. **Grid search** tries all combinations (exhaustive)
    3. **Random search** more efficient for large spaces
    4. **Use cross-validation** for reliable estimates
    5. **Pipeline** prevents data leakage
    6. **Start broad, refine** - coarse to fine
    7. **Monitor for overfitting** - check train vs validation
    8. **Hold out test set** - final evaluation only

    ## Next Steps

    - Practice tuning different algorithms
    - Try Bayesian optimization (Optuna)
    - Learn about AutoML tools
    - Study learning curves
    - Experiment with nested cross-validation
  MARKDOWN
  course_module: module4,
  sequence_order: 2,
  estimated_minutes: 60,
  published: true
)

puts "  ✅ Created #{module4.course_lessons.count} lessons for Module 4: Model Evaluation and Deployment"

puts "  ✅ Created Module 4: Model Evaluation and Deployment"

puts "  ✅ Created Machine Learning course with #{ml_course.course_modules.count} modules"

puts "\n✅ Machine Learning Fundamentals Course Created!"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
puts "📚 Course: #{ml_course.title}"
puts "📖 Modules: #{ml_course.course_modules.count}"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
