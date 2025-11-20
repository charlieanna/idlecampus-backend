# Calculus & Linear Algebra Course - Based on StackExchange Demand
puts "Creating Calculus & Linear Algebra Course..."

# Create Math Course
math_course = Course.find_or_create_by!(slug: 'calculus-linear-algebra') do |course|
  course.title = 'Calculus & Linear Algebra for Data Science'
  course.description = 'Master essential mathematics for machine learning and data science'
  course.difficulty_level = 'intermediate'
  course.certification_track = nil
  course.published = true
  course.sequence_order = 16
  course.estimated_hours = 45
  course.learning_objectives = JSON.generate([
    "Master calculus fundamentals: derivatives, integrals, and optimization",
    "Understand vectors, matrices, and linear transformations",
    "Apply eigenvalues and eigenvectors",
    "Solve systems of linear equations",
    "Use calculus and linear algebra in ML contexts",
    "Implement algorithms with NumPy"
  ])
  course.prerequisites = JSON.generate([
    "High school algebra",
    "Basic Python programming",
    "Mathematical maturity"
  ])
end

puts "Created course: #{math_course.title}"

# Module 1: Calculus Fundamentals
module1 = CourseModule.find_or_create_by!(slug: 'calculus-fundamentals', course: math_course) do |mod|
  mod.title = 'Calculus Fundamentals'
  mod.description = 'Derivatives, gradients, and optimization'
  mod.sequence_order = 1
  mod.estimated_minutes = 180
  mod.published = true
end

lesson1_1 = CourseLesson.find_or_create_by!(title: "Derivatives and Gradients") do |lesson|
  lesson.reading_time_minutes = 40
  lesson.content = <<~MARKDOWN
    # Derivatives and Gradients

    Calculus is the foundation of machine learning optimization. Understanding derivatives is essential for gradient descent and backpropagation.

    ## What is a Derivative?

    **The rate of change of a function**

    ```
    f'(x) = lim(h→0) [f(x+h) - f(x)] / h
    ```

    ### Geometric Interpretation
    - **Slope** of the tangent line at a point
    - **Instantaneous rate** of change

    ### Notation
    ```
    f'(x)    Newton's notation
    df/dx    Leibniz's notation
    ∂f/∂x    Partial derivative
    ∇f       Gradient (vector of partial derivatives)
    ```

    ## Basic Derivative Rules

    ### Power Rule
    ```
    f(x) = x^n
    f'(x) = nx^(n-1)

    Examples:
    f(x) = x^3       →  f'(x) = 3x^2
    f(x) = x^2       →  f'(x) = 2x
    f(x) = x         →  f'(x) = 1
    f(x) = 1         →  f'(x) = 0
    ```

    ### Sum Rule
    ```
    [f(x) + g(x)]' = f'(x) + g'(x)

    Example:
    f(x) = x^2 + 3x + 5
    f'(x) = 2x + 3 + 0 = 2x + 3
    ```

    ### Product Rule
    ```
    [f(x)·g(x)]' = f'(x)·g(x) + f(x)·g'(x)

    Example:
    f(x) = x^2·sin(x)
    f'(x) = 2x·sin(x) + x^2·cos(x)
    ```

    ### Chain Rule
    **Most important for neural networks!**

    ```
    [f(g(x))]' = f'(g(x))·g'(x)

    Example:
    f(x) = (x^2 + 1)^3
    Let u = x^2 + 1
    f(u) = u^3
    f'(x) = 3u^2·2x = 3(x^2 + 1)^2·2x = 6x(x^2 + 1)^2
    ```

    ## Common Derivatives

    ```
    f(x) = e^x       →  f'(x) = e^x
    f(x) = ln(x)     →  f'(x) = 1/x
    f(x) = sin(x)    →  f'(x) = cos(x)
    f(x) = cos(x)    →  f'(x) = -sin(x)
    f(x) = tan(x)    →  f'(x) = sec^2(x)
    f(x) = a^x       →  f'(x) = a^x·ln(a)
    ```

    ## Partial Derivatives

    **Derivatives with respect to one variable, holding others constant**

    ```
    f(x, y) = x^2 + 3xy + y^2

    ∂f/∂x = 2x + 3y   (treat y as constant)
    ∂f/∂y = 3x + 2y   (treat x as constant)
    ```

    ### Example: Linear Regression Loss

    ```
    Loss function:
    L(w, b) = (1/n)Σ(y_i - (wx_i + b))^2

    Partial derivatives:
    ∂L/∂w = -(2/n)Σ x_i(y_i - (wx_i + b))
    ∂L/∂b = -(2/n)Σ (y_i - (wx_i + b))
    ```

    ## The Gradient

    **Vector of all partial derivatives**

    ```
    f(x, y, z) = x^2 + 2y^2 + 3z^2

    ∇f = [∂f/∂x, ∂f/∂y, ∂f/∂z]
       = [2x, 4y, 6z]
    ```

    **The gradient points in the direction of steepest ascent**

    ## Gradient Descent

    **Core optimization algorithm for machine learning**

    ```python
    # Update rule
    θ = θ - α·∇L(θ)

    # where:
    # θ = parameters
    # α = learning rate
    # ∇L(θ) = gradient of loss function
    ```

    ### Python Implementation

    ```python
    import numpy as np

    def gradient_descent(gradient_func, initial_params, learning_rate=0.01, num_iterations=1000):
        params = initial_params

        for i in range(num_iterations):
            # Compute gradient
            gradient = gradient_func(params)

            # Update parameters
            params = params - learning_rate * gradient

            if i % 100 == 0:
                loss = compute_loss(params)
                print(f"Iteration {i}: Loss = {loss}")

        return params
    ```

    ### Example: Minimizing f(x) = x^2

    ```python
    def gradient(x):
        return 2 * x  # f'(x) = 2x

    # Start at x = 10
    x = np.array([10.0])
    learning_rate = 0.1

    for i in range(50):
        grad = gradient(x)
        x = x - learning_rate * grad
        if i % 10 == 0:
            print(f"Iteration {i}: x = {x[0]:.4f}, f(x) = {x[0]**2:.4f}")

    # Output:
    # Iteration 0: x = 8.0000, f(x) = 64.0000
    # Iteration 10: x = 0.8958, f(x) = 0.8024
    # Iteration 20: x = 0.1002, f(x) = 0.0100
    # ...converges to x = 0
    ```

    ## Higher-Order Derivatives

    ### Second Derivative

    ```
    f''(x) = d²f/dx²
    ```

    **Measures curvature (concavity)**
    - f''(x) > 0: concave up (minimum)
    - f''(x) < 0: concave down (maximum)
    - f''(x) = 0: inflection point

    ### Hessian Matrix

    **Matrix of all second-order partial derivatives**

    ```
    For f(x, y):

    H = [∂²f/∂x²    ∂²f/∂x∂y]
        [∂²f/∂y∂x   ∂²f/∂y²  ]
    ```

    Used in Newton's method and second-order optimization.

    ## Optimization

    ### Finding Extrema

    1. **Find critical points**: Set f'(x) = 0
    2. **Test with second derivative**:
       - f''(x) > 0 → local minimum
       - f''(x) < 0 → local maximum

    ### Example

    ```
    f(x) = x^3 - 3x^2 + 2

    1. f'(x) = 3x^2 - 6x = 3x(x - 2) = 0
       Critical points: x = 0, x = 2

    2. f''(x) = 6x - 6
       f''(0) = -6 < 0  → local maximum at x = 0
       f''(2) = 6 > 0   → local minimum at x = 2
    ```

    ## Applications in ML

    ### Activation Functions

    ```python
    # Sigmoid
    def sigmoid(x):
        return 1 / (1 + np.exp(-x))

    def sigmoid_derivative(x):
        s = sigmoid(x)
        return s * (1 - s)

    # ReLU (Rectified Linear Unit)
    def relu(x):
        return np.maximum(0, x)

    def relu_derivative(x):
        return np.where(x > 0, 1, 0)

    # Tanh
    def tanh(x):
        return np.tanh(x)

    def tanh_derivative(x):
        return 1 - np.tanh(x)**2
    ```

    ### Backpropagation

    **Chain rule applied to neural networks**

    ```python
    # Forward pass
    z1 = W1 @ x + b1
    a1 = relu(z1)
    z2 = W2 @ a1 + b2
    output = sigmoid(z2)

    # Backward pass (chain rule)
    dL_dz2 = output - y
    dL_dW2 = dL_dz2 @ a1.T
    dL_da1 = W2.T @ dL_dz2
    dL_dz1 = dL_da1 * relu_derivative(z1)
    dL_dW1 = dL_dz1 @ x.T
    ```

    ### Loss Functions and Their Derivatives

    ```python
    # Mean Squared Error
    def mse_loss(y_pred, y_true):
        return np.mean((y_pred - y_true)**2)

    def mse_derivative(y_pred, y_true):
        return 2 * (y_pred - y_true) / len(y_true)

    # Binary Cross-Entropy
    def bce_loss(y_pred, y_true):
        return -np.mean(y_true * np.log(y_pred) + (1 - y_true) * np.log(1 - y_pred))

    def bce_derivative(y_pred, y_true):
        return -(y_true / y_pred - (1 - y_true) / (1 - y_pred))
    ```

    **Next**: We'll explore vectors and matrices in linear algebra!
  MARKDOWN
  lesson.key_concepts = ['derivatives', 'gradients', 'chain rule', 'gradient descent', 'optimization', 'backpropagation']
end

ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_1) do |item|
  item.sequence_order = 1
  item.required = true
end

# Module 2: Linear Algebra Fundamentals
module2 = CourseModule.find_or_create_by!(slug: 'linear-algebra-fundamentals', course: math_course) do |mod|
  mod.title = 'Linear Algebra Fundamentals'
  mod.description = 'Vectors, matrices, and linear transformations'
  mod.sequence_order = 2
  mod.estimated_minutes = 200
  mod.published = true
end

# Module 3: Eigenvalues and Eigenvectors
module3 = CourseModule.find_or_create_by!(slug: 'eigenvalues-eigenvectors', course: math_course) do |mod|
  mod.title = 'Eigenvalues and Eigenvectors'
  mod.description = 'Spectral decomposition and applications'
  mod.sequence_order = 3
  mod.estimated_minutes = 150
  mod.published = true
end

puts "  ✅ Created modules for Calculus & Linear Algebra course"

puts "\n✅ Calculus & Linear Algebra Course Created!"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
puts "📚 Course: #{math_course.title}"
puts "📖 Modules: #{math_course.course_modules.count}"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
