# PostgreSQL Interactive SQL Labs
# Learn PostgreSQL through hands-on SQL query practice

puts "🐘 Seeding PostgreSQL Interactive SQL Labs..."

postgresql_sql_labs = [
  {
    title: "SQL Basics - SELECT and Filtering",
    description: "Master fundamental SQL SELECT queries and WHERE clause filtering",
    difficulty: "easy",
    estimated_minutes: 20,
    lab_type: "postgresql",
    lab_format: "code_editor",
    programming_language: "sql",
    category: "basics",
    certification_exam: nil,
    learning_objectives: "Master SELECT statements, WHERE clause, comparison operators, and basic filtering",
    prerequisites: ["Basic understanding of databases"],
    starter_code: "-- Write your SQL query here\nSELECT * FROM users;",
    schema_setup: <<~SQL,
      CREATE TABLE users (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        email VARCHAR(255) UNIQUE NOT NULL,
        age INTEGER,
        city VARCHAR(100),
        created_at TIMESTAMP DEFAULT NOW()
      );
    SQL
    sample_data: <<~SQL,
      INSERT INTO users (name, email, age, city) VALUES
        ('Alice Johnson', 'alice@example.com', 28, 'New York'),
        ('Bob Smith', 'bob@example.com', 35, 'Los Angeles'),
        ('Charlie Brown', 'charlie@example.com', 22, 'Chicago'),
        ('Diana Prince', 'diana@example.com', 30, 'New York'),
        ('Eve Williams', 'eve@example.com', 45, 'Boston');
    SQL
    test_cases: [
      {
        name: "Select all users",
        query: "SELECT * FROM users;",
        expected_result: [
          { "id" => 1, "name" => "Alice Johnson", "email" => "alice@example.com", "age" => 28, "city" => "New York" },
          { "id" => 2, "name" => "Bob Smith", "email" => "bob@example.com", "age" => 35, "city" => "Los Angeles" },
          { "id" => 3, "name" => "Charlie Brown", "email" => "charlie@example.com", "age" => 22, "city" => "Chicago" },
          { "id" => 4, "name" => "Diana Prince", "email" => "diana@example.com", "age" => 30, "city" => "New York" },
          { "id" => 5, "name" => "Eve Williams", "email" => "eve@example.com", "age" => 45, "city" => "Boston" }
        ]
      },
      {
        name: "Select users from New York",
        query: "SELECT name, city FROM users WHERE city = 'New York';",
        expected_result: [
          { "name" => "Alice Johnson", "city" => "New York" },
          { "name" => "Diana Prince", "city" => "New York" }
        ]
      },
      {
        name: "Select users older than 30",
        query: "SELECT name, age FROM users WHERE age > 30 ORDER BY age;",
        expected_result: [
          { "name" => "Bob Smith", "age" => 35 },
          { "name" => "Eve Williams", "age" => 45 }
        ]
      }
    ],
    hints: [
      "Use SELECT * to select all columns",
      "Use WHERE clause to filter results",
      "Comparison operators: =, >, <, >=, <=, !=",
      "Use ORDER BY to sort results"
    ],
    validation_rules: {
      syntax_correct: "SQL syntax is valid",
      results_match: "Query returns expected results",
      efficient_query: "Query uses appropriate filtering"
    },
    success_criteria: "Successfully write SELECT queries with WHERE clause filtering",
    max_attempts: 5,
    points_reward: 150,
    is_active: true
  },

  {
    title: "SQL Aggregation - COUNT, SUM, AVG",
    description: "Learn SQL aggregate functions and GROUP BY clause",
    difficulty: "easy",
    estimated_minutes: 25,
    lab_type: "postgresql",
    lab_format: "code_editor",
    programming_language: "sql",
    category: "aggregation",
    certification_exam: nil,
    learning_objectives: "Master aggregate functions (COUNT, SUM, AVG, MIN, MAX) and GROUP BY",
    prerequisites: ["Basic SQL SELECT queries"],
    starter_code: "-- Calculate aggregate statistics\nSELECT COUNT(*) FROM orders;",
    schema_setup: <<~SQL,
      CREATE TABLE orders (
        id SERIAL PRIMARY KEY,
        user_id INTEGER,
        product VARCHAR(100),
        category VARCHAR(50),
        amount DECIMAL(10,2),
        order_date DATE
      );
    SQL
    sample_data: <<~SQL,
      INSERT INTO orders (user_id, product, category, amount, order_date) VALUES
        (1, 'Laptop', 'Electronics', 1200.00, '2024-01-15'),
        (2, 'Phone', 'Electronics', 800.00, '2024-01-16'),
        (1, 'Shirt', 'Clothing', 45.00, '2024-01-17'),
        (3, 'Headphones', 'Electronics', 150.00, '2024-01-18'),
        (2, 'Jeans', 'Clothing', 60.00, '2024-01-19'),
        (1, 'Tablet', 'Electronics', 500.00, '2024-01-20'),
        (3, 'Shoes', 'Clothing', 80.00, '2024-01-21');
    SQL
    test_cases: [
      {
        name: "Count total orders",
        query: "SELECT COUNT(*) as total_orders FROM orders;",
        expected_result: [{ "total_orders" => 7 }]
      },
      {
        name: "Calculate total revenue",
        query: "SELECT SUM(amount) as total_revenue FROM orders;",
        expected_result: [{ "total_revenue" => 2835.00 }]
      },
      {
        name: "Average order amount",
        query: "SELECT ROUND(AVG(amount), 2) as avg_amount FROM orders;",
        expected_result: [{ "avg_amount" => 405.00 }]
      },
      {
        name: "Revenue by category",
        query: "SELECT category, SUM(amount) as total FROM orders GROUP BY category ORDER BY total DESC;",
        expected_result: [
          { "category" => "Electronics", "total" => 2650.00 },
          { "category" => "Clothing", "total" => 185.00 }
        ]
      },
      {
        name: "Orders per user",
        query: "SELECT user_id, COUNT(*) as order_count FROM orders GROUP BY user_id ORDER BY user_id;",
        expected_result: [
          { "user_id" => 1, "order_count" => 3 },
          { "user_id" => 2, "order_count" => 2 },
          { "user_id" => 3, "order_count" => 2 }
        ]
      }
    ],
    hints: [
      "COUNT(*) counts all rows",
      "SUM() adds up numeric values",
      "AVG() calculates average",
      "Use GROUP BY to group results",
      "Use ROUND() to limit decimal places"
    ],
    validation_rules: {
      aggregates_correct: "Aggregate functions used properly",
      grouping_correct: "GROUP BY clause used correctly",
      results_accurate: "Calculations are accurate"
    },
    success_criteria: "Successfully use aggregate functions and GROUP BY",
    max_attempts: 5,
    points_reward: 200,
    is_active: true
  },

  {
    title: "SQL Joins - Combining Tables",
    description: "Master INNER JOIN, LEFT JOIN, and multi-table queries",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "postgresql",
    lab_format: "code_editor",
    programming_language: "sql",
    category: "joins",
    certification_exam: nil,
    learning_objectives: "Master different types of JOINs, understand relationships, combine data from multiple tables",
    prerequisites: ["SQL basics", "Understanding of table relationships"],
    starter_code: "-- Join users and orders tables\nSELECT u.name, o.product\nFROM users u\nJOIN orders o ON u.id = o.user_id;",
    schema_setup: <<~SQL,
      CREATE TABLE customers (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100),
        email VARCHAR(255)
      );
      
      CREATE TABLE orders (
        id SERIAL PRIMARY KEY,
        customer_id INTEGER,
        product VARCHAR(100),
        amount DECIMAL(10,2),
        order_date DATE
      );
      
      CREATE TABLE reviews (
        id SERIAL PRIMARY KEY,
        order_id INTEGER,
        rating INTEGER,
        comment TEXT
      );
    SQL
    sample_data: <<~SQL,
      INSERT INTO customers (name, email) VALUES
        ('Alice', 'alice@example.com'),
        ('Bob', 'bob@example.com'),
        ('Charlie', 'charlie@example.com');
      
      INSERT INTO orders (customer_id, product, amount, order_date) VALUES
        (1, 'Laptop', 1200.00, '2024-01-15'),
        (1, 'Mouse', 25.00, '2024-01-16'),
        (2, 'Keyboard', 80.00, '2024-01-17'),
        (3, 'Monitor', 300.00, '2024-01-18');
      
      INSERT INTO reviews (order_id, rating, comment) VALUES
        (1, 5, 'Excellent laptop!'),
        (2, 4, 'Good mouse'),
        (3, 5, 'Great keyboard');
    SQL
    test_cases: [
      {
        name: "INNER JOIN customers and orders",
        query: "SELECT c.name, o.product, o.amount FROM customers c INNER JOIN orders o ON c.id = o.customer_id ORDER BY c.name, o.product;",
        expected_result: [
          { "name" => "Alice", "product" => "Laptop", "amount" => 1200.00 },
          { "name" => "Alice", "product" => "Mouse", "amount" => 25.00 },
          { "name" => "Bob", "product" => "Keyboard", "amount" => 80.00 },
          { "name" => "Charlie", "product" => "Monitor", "amount" => 300.00 }
        ]
      },
      {
        name: "LEFT JOIN to find all customers",
        query: "SELECT c.name, COUNT(o.id) as order_count FROM customers c LEFT JOIN orders o ON c.id = o.customer_id GROUP BY c.name ORDER BY c.name;",
        expected_result: [
          { "name" => "Alice", "order_count" => 2 },
          { "name" => "Bob", "order_count" => 1 },
          { "name" => "Charlie", "order_count" => 1 }
        ]
      },
      {
        name: "Three-table JOIN",
        query: "SELECT c.name, o.product, r.rating FROM customers c JOIN orders o ON c.id = o.customer_id JOIN reviews r ON o.id = r.order_id ORDER BY c.name;",
        expected_result: [
          { "name" => "Alice", "product" => "Laptop", "rating" => 5 },
          { "name" => "Alice", "product" => "Mouse", "rating" => 4 },
          { "name" => "Bob", "product" => "Keyboard", "rating" => 5 }
        ]
      }
    ],
    hints: [
      "INNER JOIN returns only matching rows from both tables",
      "LEFT JOIN returns all rows from left table, matching rows from right",
      "Use table aliases (u, o) for cleaner queries",
      "JOIN conditions use ON clause",
      "Can chain multiple JOINs together"
    ],
    validation_rules: {
      joins_correct: "JOIN syntax is correct",
      relationships_understood: "Table relationships used properly",
      results_complete: "All required data retrieved"
    },
    success_criteria: "Successfully join multiple tables and retrieve related data",
    max_attempts: 5,
    points_reward: 300,
    is_active: true
  },

  {
    title: "Subqueries and Nested SELECT",
    description: "Master subqueries, correlated subqueries, and EXISTS clause",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "postgresql",
    lab_format: "code_editor",
    programming_language: "sql",
    category: "advanced-sql",
    certification_exam: nil,
    learning_objectives: "Master subqueries in SELECT, WHERE, and FROM clauses, understand correlated subqueries",
    prerequisites: ["SQL joins", "Aggregate functions"],
    starter_code: "-- Find users with above-average order amounts\nSELECT name FROM users\nWHERE user_id IN (\n  SELECT user_id FROM orders\n  WHERE amount > (SELECT AVG(amount) FROM orders)\n);",
    schema_setup: <<~SQL,
      CREATE TABLE employees (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100),
        department VARCHAR(50),
        salary DECIMAL(10,2),
        manager_id INTEGER
      );
    SQL
    sample_data: <<~SQL,
      INSERT INTO employees (name, department, salary, manager_id) VALUES
        ('Alice', 'Engineering', 120000, NULL),
        ('Bob', 'Engineering', 95000, 1),
        ('Charlie', 'Engineering', 85000, 1),
        ('Diana', 'Sales', 90000, NULL),
        ('Eve', 'Sales', 75000, 4),
        ('Frank', 'Marketing', 70000, NULL);
    SQL
    test_cases: [
      {
        name: "Find employees earning above average",
        query: "SELECT name, salary FROM employees WHERE salary > (SELECT AVG(salary) FROM employees) ORDER BY salary DESC;",
        expected_result: [
          { "name" => "Alice", "salary" => 120000.00 },
          { "name" => "Bob", "salary" => 95000.00 },
          { "name" => "Diana", "salary" => 90000.00 }
        ]
      },
      {
        name: "Find departments with average salary > 80000",
        query: "SELECT department, AVG(salary) as avg_salary FROM employees GROUP BY department HAVING AVG(salary) > 80000 ORDER BY avg_salary DESC;",
        expected_result: [
          { "department" => "Engineering", "avg_salary" => 100000.00 },
          { "department" => "Sales", "avg_salary" => 82500.00 }
        ]
      },
      {
        name: "Correlated subquery - find managers",
        query: "SELECT name, department FROM employees e WHERE EXISTS (SELECT 1 FROM employees WHERE manager_id = e.id) ORDER BY name;",
        expected_result: [
          { "name" => "Alice", "department" => "Engineering" },
          { "name" => "Diana", "department" => "Sales" }
        ]
      }
    ],
    hints: [
      "Subqueries can be used in WHERE, SELECT, and FROM clauses",
      "Use IN for matching multiple values",
      "EXISTS checks if subquery returns any rows",
      "Correlated subqueries reference outer query",
      "HAVING filters groups after GROUP BY"
    ],
    validation_rules: {
      subqueries_correct: "Subquery syntax is valid",
      logic_sound: "Query logic is correct",
      performance_acceptable: "Query is reasonably efficient"
    },
    success_criteria: "Successfully use subqueries for complex data retrieval",
    max_attempts: 5,
    points_reward: 350,
    is_active: true
  },

  {
    title: "Window Functions - Advanced Analytics",
    description: "Master window functions: ROW_NUMBER, RANK, LAG, LEAD",
    difficulty: "hard",
    estimated_minutes: 40,
    lab_type: "postgresql",
    lab_format: "code_editor",
    programming_language: "sql",
    category: "advanced-analytics",
    certification_exam: nil,
    learning_objectives: "Master window functions, understand PARTITION BY and ORDER BY, calculate running totals",
    prerequisites: ["Advanced SQL", "Understanding of aggregates"],
    starter_code: "-- Calculate running total using window function\nSELECT \n  order_date,\n  amount,\n  SUM(amount) OVER (ORDER BY order_date) as running_total\nFROM orders;",
    schema_setup: <<~SQL,
      CREATE TABLE sales (
        id SERIAL PRIMARY KEY,
        sale_date DATE,
        product VARCHAR(100),
        region VARCHAR(50),
        amount DECIMAL(10,2)
      );
    SQL
    sample_data: <<~SQL,
      INSERT INTO sales (sale_date, product, region, amount) VALUES
        ('2024-01-01', 'Widget', 'North', 100.00),
        ('2024-01-02', 'Gadget', 'North', 150.00),
        ('2024-01-03', 'Widget', 'South', 120.00),
        ('2024-01-04', 'Gadget', 'South', 180.00),
        ('2024-01-05', 'Widget', 'North', 110.00),
        ('2024-01-06', 'Gadget', 'North', 160.00);
    SQL
    test_cases: [
      {
        name: "ROW_NUMBER - rank sales by date",
        query: "SELECT sale_date, amount, ROW_NUMBER() OVER (ORDER BY sale_date) as row_num FROM sales ORDER BY sale_date;",
        expected_result: [
          { "sale_date" => "2024-01-01", "amount" => 100.00, "row_num" => 1 },
          { "sale_date" => "2024-01-02", "amount" => 150.00, "row_num" => 2 },
          { "sale_date" => "2024-01-03", "amount" => 120.00, "row_num" => 3 },
          { "sale_date" => "2024-01-04", "amount" => 180.00, "row_num" => 4 },
          { "sale_date" => "2024-01-05", "amount" => 110.00, "row_num" => 5 },
          { "sale_date" => "2024-01-06", "amount" => 160.00, "row_num" => 6 }
        ]
      },
      {
        name: "Running total by region",
        query: "SELECT region, sale_date, amount, SUM(amount) OVER (PARTITION BY region ORDER BY sale_date) as running_total FROM sales ORDER BY region, sale_date;",
        expected_result: [
          { "region" => "North", "sale_date" => "2024-01-01", "amount" => 100.00, "running_total" => 100.00 },
          { "region" => "North", "sale_date" => "2024-01-02", "amount" => 150.00, "running_total" => 250.00 },
          { "region" => "North", "sale_date" => "2024-01-05", "amount" => 110.00, "running_total" => 360.00 },
          { "region" => "North", "sale_date" => "2024-01-06", "amount" => 160.00, "running_total" => 520.00 },
          { "region" => "South", "sale_date" => "2024-01-03", "amount" => 120.00, "running_total" => 120.00 },
          { "region" => "South", "sale_date" => "2024-01-04", "amount" => 180.00, "running_total" => 300.00 }
        ]
      },
      {
        name: "LAG function - compare with previous day",
        query: "SELECT sale_date, amount, LAG(amount) OVER (ORDER BY sale_date) as prev_amount FROM sales ORDER BY sale_date;",
        expected_result: [
          { "sale_date" => "2024-01-01", "amount" => 100.00, "prev_amount" => nil },
          { "sale_date" => "2024-01-02", "amount" => 150.00, "prev_amount" => 100.00 },
          { "sale_date" => "2024-01-03", "amount" => 120.00, "prev_amount" => 150.00 },
          { "sale_date" => "2024-01-04", "amount" => 180.00, "prev_amount" => 120.00 },
          { "sale_date" => "2024-01-05", "amount" => 110.00, "prev_amount" => 180.00 },
          { "sale_date" => "2024-01-06", "amount" => 160.00, "prev_amount" => 110.00 }
        ]
      }
    ],
    hints: [
      "Window functions use OVER clause",
      "PARTITION BY creates separate windows per group",
      "ORDER BY within OVER determines calculation order",
      "ROW_NUMBER assigns unique sequential numbers",
      "LAG/LEAD access previous/next row values",
      "Running totals use SUM() OVER (ORDER BY...)"
    ],
    validation_rules: {
      window_syntax_correct: "Window function syntax valid",
      partitioning_correct: "PARTITION BY used properly",
      results_accurate: "Calculations are correct"
    },
    success_criteria: "Master window functions for advanced analytical queries",
    max_attempts: 3,
    points_reward: 500,
    is_active: true
  }
]

# Create PostgreSQL SQL Labs
postgresql_sql_labs.each_with_index do |lab_data, index|
  begin
    lab = HandsOnLab.find_or_initialize_by(title: lab_data[:title])
    lab.assign_attributes(lab_data)
    if lab.save
      print(".")
    else
      puts "\n❌ Failed: #{lab_data[:title]}"
      puts "   Errors: #{lab.errors.full_messages.join(', ')}"
    end
  rescue => e
    puts "\n❌ Error on #{lab_data[:title]}: #{e.message}"
    puts "   Backtrace: #{e.backtrace.first(3).join("\n   ")}"
  end
end

puts "\n\n✅ PostgreSQL Interactive SQL Labs Seeding Complete!"
puts "   Total SQL labs: #{HandsOnLab.where(lab_type: 'postgresql', lab_format: 'code_editor').count}"
puts "\n🐘 Ready for Interactive SQL Learning!"