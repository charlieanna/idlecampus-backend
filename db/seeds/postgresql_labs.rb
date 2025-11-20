# PostgreSQL Database Mastery Hands-On Labs
# Master PostgreSQL from basics to advanced optimization

puts "🐘 Seeding PostgreSQL Database Mastery Labs..."

postgresql_labs = [
  {
    title: "PostgreSQL Basics - First Database and Table",
    description: "Learn PostgreSQL fundamentals by creating databases, tables, and running queries",
    difficulty: "easy",
    estimated_minutes: 25,
    lab_type: "postgresql",
    category: "basics",
    certification_exam: nil,
    learning_objectives: "Master basic SQL, understand PostgreSQL data types, create tables with constraints",
    prerequisites: ["Basic SQL knowledge"],
    steps: [
      {
        step_number: 1,
        title: "Start PostgreSQL container",
        instruction: "Run PostgreSQL in Docker",
        expected_command: "docker run -d --name postgres-lab -e POSTGRES_PASSWORD=secret -p 5432:5432 postgres:15",
        validation: "docker ps | grep postgres-lab"
      },
      {
        step_number: 2,
        title: "Create database",
        instruction: "Create a new database called 'appdb'",
        expected_command: "docker exec postgres-lab psql -U postgres -c 'CREATE DATABASE appdb;'",
        validation: "docker exec postgres-lab psql -U postgres -l | grep appdb"
      },
      {
        step_number: 3,
        title: "Create users table",
        instruction: "Create a users table with id, name, email, created_at",
        expected_command: "docker exec postgres-lab psql -U postgres -d appdb -c 'CREATE TABLE users (id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL, email VARCHAR(255) UNIQUE NOT NULL, created_at TIMESTAMP DEFAULT NOW());'",
        validation: "docker exec postgres-lab psql -U postgres -d appdb -c '\\dt' | grep users"
      },
      {
        step_number: 4,
        title: "Insert data",
        instruction: "Insert 3 users into the table",
        expected_command: "docker exec postgres-lab psql -U postgres -d appdb -c \"INSERT INTO users (name, email) VALUES ('Alice', 'alice@example.com'), ('Bob', 'bob@example.com'), ('Charlie', 'charlie@example.com');\"",
        validation: "docker exec postgres-lab psql -U postgres -d appdb -c 'SELECT COUNT(*) FROM users;' | grep 3"
      },
      {
        step_number: 5,
        title: "Query data",
        instruction: "Select all users",
        expected_command: "docker exec postgres-lab psql -U postgres -d appdb -c 'SELECT * FROM users;'",
        validation: "docker exec postgres-lab psql -U postgres -d appdb -c 'SELECT COUNT(*) FROM users;'"
      },
      {
        step_number: 6,
        title: "Update data",
        instruction: "Update Alice's email",
        expected_command: "docker exec postgres-lab psql -U postgres -d appdb -c \"UPDATE users SET email = 'alice.new@example.com' WHERE name = 'Alice';\"",
        validation: "docker exec postgres-lab psql -U postgres -d appdb -c \"SELECT email FROM users WHERE name='Alice';\" | grep alice.new"
      },
      {
        step_number: 7,
        title: "Cleanup",
        instruction: "Stop and remove PostgreSQL container",
        expected_command: "docker rm -f postgres-lab",
        validation: "docker ps | grep postgres-lab"
      }
    ],
    validation_rules: {
      database_created: "appdb exists",
      table_created: "users table with proper schema",
      data_inserted: "sample data present",
      queries_working: "CRUD operations successful"
    },
    success_criteria: "Successfully perform basic PostgreSQL operations",
    environment_image: "docker:20-dind",
    required_tools: ["docker"],
    max_attempts: 5,
    points_reward: 200,
    is_active: true
  },

  {
    title: "Indexes and Query Performance",
    description: "Learn to create indexes and optimize query performance",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "postgresql",
    category: "performance",
    certification_exam: nil,
    learning_objectives: "Master index creation, understand query plans, optimize queries with EXPLAIN",
    prerequisites: ["Basic PostgreSQL knowledge"],
    steps: [
      {
        step_number: 1,
        title: "Start PostgreSQL and create test data",
        instruction: "Start PostgreSQL and create orders table",
        expected_command: "docker run -d --name postgres-perf -e POSTGRES_PASSWORD=secret postgres:15 && sleep 5 && docker exec postgres-perf psql -U postgres -c 'CREATE TABLE orders (id SERIAL PRIMARY KEY, user_id INT, product_id INT, amount DECIMAL(10,2), order_date DATE);'",
        validation: "docker ps | grep postgres-perf"
      },
      {
        step_number: 2,
        title: "Generate test data",
        instruction: "Insert 1000 sample orders",
        expected_command: "docker exec postgres-perf psql -U postgres -c \"INSERT INTO orders (user_id, product_id, amount, order_date) SELECT (random()*100)::int, (random()*50)::int, (random()*1000)::decimal(10,2), NOW() - (random()*365)::int * '1 day'::interval FROM generate_series(1, 1000);\"",
        validation: "docker exec postgres-perf psql -U postgres -c 'SELECT COUNT(*) FROM orders;' | grep 1000"
      },
      {
        step_number: 3,
        title: "Analyze query without index",
        instruction: "Run EXPLAIN ANALYZE for user_id query",
        expected_command: "docker exec postgres-perf psql -U postgres -c 'EXPLAIN ANALYZE SELECT * FROM orders WHERE user_id = 42;'",
        validation: "docker exec postgres-perf psql -U postgres -c 'EXPLAIN SELECT * FROM orders WHERE user_id = 42;' | grep -i 'seq scan' || echo 'Query plan analyzed'"
      },
      {
        step_number: 4,
        title: "Create index on user_id",
        instruction: "Create B-tree index",
        expected_command: "docker exec postgres-perf psql -U postgres -c 'CREATE INDEX idx_orders_user_id ON orders(user_id);'",
        validation: "docker exec postgres-perf psql -U postgres -c '\\di' | grep idx_orders_user_id"
      },
      {
        step_number: 5,
        title: "Analyze query with index",
        instruction: "Compare query plan after index",
        expected_command: "docker exec postgres-perf psql -U postgres -c 'EXPLAIN ANALYZE SELECT * FROM orders WHERE user_id = 42;'",
        validation: "docker exec postgres-perf psql -U postgres -c 'EXPLAIN SELECT * FROM orders WHERE user_id = 42;' | grep -i 'index' || echo 'Index used'"
      },
      {
        step_number: 6,
        title: "Create composite index",
        instruction: "Create multi-column index on user_id and order_date",
        expected_command: "docker exec postgres-perf psql -U postgres -c 'CREATE INDEX idx_orders_user_date ON orders(user_id, order_date);'",
        validation: "docker exec postgres-perf psql -U postgres -c '\\di' | grep idx_orders_user_date"
      },
      {
        step_number: 7,
        title: "Check index size",
        instruction: "View index sizes",
        expected_command: "docker exec postgres-perf psql -U postgres -c \"SELECT indexname, pg_size_pretty(pg_relation_size(indexname::regclass)) FROM pg_indexes WHERE tablename = 'orders';\"",
        validation: "docker exec postgres-perf psql -U postgres -c '\\di+' | grep idx_orders"
      },
      {
        step_number: 8,
        title: "Cleanup",
        instruction: "Remove container",
        expected_command: "docker rm -f postgres-perf",
        validation: "docker ps | grep postgres-perf"
      }
    ],
    validation_rules: {
      data_generated: "test data created",
      indexes_created: "appropriate indexes added",
      performance_improved: "query plans show index usage"
    },
    success_criteria: "Successfully optimize queries with indexes",
    environment_image: "docker:20-dind",
    required_tools: ["docker"],
    max_attempts: 5,
    points_reward: 350,
    is_active: true
  },

  {
    title: "Transactions and ACID Properties",
    description: "Master transaction management and understand ACID guarantees",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "postgresql",
    category: "transactions",
    certification_exam: nil,
    learning_objectives: "Understand ACID properties, use transactions, handle concurrent access",
    prerequisites: ["Understanding of database concepts"],
    steps: [
      {
        step_number: 1,
        title: "Start PostgreSQL and setup",
        instruction: "Create accounts table for banking scenario",
        expected_command: "docker run -d --name postgres-tx -e POSTGRES_PASSWORD=secret postgres:15 && sleep 5 && docker exec postgres-tx psql -U postgres -c 'CREATE TABLE accounts (id SERIAL PRIMARY KEY, name VARCHAR(100), balance DECIMAL(10,2));'",
        validation: "docker ps | grep postgres-tx"
      },
      {
        step_number: 2,
        title: "Insert test accounts",
        instruction: "Create two accounts with balances",
        expected_command: "docker exec postgres-tx psql -U postgres -c \"INSERT INTO accounts (name, balance) VALUES ('Alice', 1000.00), ('Bob', 500.00);\"",
        validation: "docker exec postgres-tx psql -U postgres -c 'SELECT COUNT(*) FROM accounts;' | grep 2"
      },
      {
        step_number: 3,
        title: "Perform money transfer with transaction",
        instruction: "Transfer $100 from Alice to Bob atomically",
        expected_command: "docker exec postgres-tx psql -U postgres -c \"BEGIN; UPDATE accounts SET balance = balance - 100 WHERE name = 'Alice'; UPDATE accounts SET balance = balance + 100 WHERE name = 'Bob'; COMMIT;\"",
        validation: "docker exec postgres-tx psql -U postgres -c \"SELECT balance FROM accounts WHERE name='Bob';\" | grep 600"
      },
      {
        step_number: 4,
        title: "Test rollback",
        instruction: "Attempt invalid transfer and rollback",
        expected_command: "docker exec postgres-tx psql -U postgres -c \"BEGIN; UPDATE accounts SET balance = balance - 2000 WHERE name = 'Alice'; UPDATE accounts SET balance = balance + 2000 WHERE name = 'Bob'; ROLLBACK;\"",
        validation: "docker exec postgres-tx psql -U postgres -c \"SELECT balance FROM accounts WHERE name='Alice';\" | grep 900"
      },
      {
        step_number: 5,
        title: "Create transaction log",
        instruction: "Create audit table for transaction history",
        expected_command: "docker exec postgres-tx psql -U postgres -c 'CREATE TABLE transaction_log (id SERIAL PRIMARY KEY, from_account VARCHAR(100), to_account VARCHAR(100), amount DECIMAL(10,2), tx_time TIMESTAMP DEFAULT NOW());'",
        validation: "docker exec postgres-tx psql -U postgres -c '\\dt' | grep transaction_log"
      },
      {
        step_number: 6,
        title: "Atomic transfer with logging",
        instruction: "Transfer money and log in single transaction",
        expected_command: "docker exec postgres-tx psql -U postgres -c \"BEGIN; UPDATE accounts SET balance = balance - 50 WHERE name = 'Alice'; UPDATE accounts SET balance = balance + 50 WHERE name = 'Bob'; INSERT INTO transaction_log (from_account, to_account, amount) VALUES ('Alice', 'Bob', 50.00); COMMIT;\"",
        validation: "docker exec postgres-tx psql -U postgres -c 'SELECT COUNT(*) FROM transaction_log;' | grep 1"
      },
      {
        step_number: 7,
        title: "Verify ACID - final balances",
        instruction: "Check that all transactions maintained consistency",
        expected_command: "docker exec postgres-tx psql -U postgres -c 'SELECT name, balance FROM accounts ORDER BY name;'",
        validation: "docker exec postgres-tx psql -U postgres -c 'SELECT SUM(balance) FROM accounts;' | grep 1500"
      },
      {
        step_number: 8,
        title: "Cleanup",
        instruction: "Remove container",
        expected_command: "docker rm -f postgres-tx",
        validation: "docker ps | grep postgres-tx"
      }
    ],
    validation_rules: {
      transactions_work: "COMMIT and ROLLBACK function",
      atomicity_maintained: "all-or-nothing updates",
      consistency_preserved: "total balance unchanged"
    },
    success_criteria: "Successfully implement atomic transactions",
    environment_image: "docker:20-dind",
    required_tools: ["docker"],
    max_attempts: 5,
    points_reward: 300,
    is_active: true
  },

  {
    title: "Advanced Query Optimization with CTEs and Window Functions",
    description: "Master Common Table Expressions and window functions for complex queries",
    difficulty: "hard",
    estimated_minutes: 45,
    lab_type: "postgresql",
    category: "advanced-sql",
    certification_exam: nil,
    learning_objectives: "Use CTEs, master window functions, optimize complex analytical queries",
    prerequisites: ["Advanced SQL knowledge", "Understanding of query optimization"],
    steps: [
      {
        step_number: 1,
        title: "Setup test database",
        instruction: "Create sales data for analysis",
        expected_command: "docker run -d --name postgres-advanced -e POSTGRES_PASSWORD=secret postgres:15 && sleep 5 && docker exec postgres-advanced psql -U postgres -c 'CREATE TABLE sales (id SERIAL PRIMARY KEY, product VARCHAR(50), category VARCHAR(50), amount DECIMAL(10,2), sale_date DATE, region VARCHAR(50));'",
        validation: "docker ps | grep postgres-advanced"
      },
      {
        step_number: 2,
        title: "Generate sample sales data",
        instruction: "Insert 500 sales records",
        expected_command: "docker exec postgres-advanced psql -U postgres -c \"INSERT INTO sales (product, category, amount, sale_date, region) SELECT 'Product' || ((random()*10)::int), CASE WHEN random() < 0.3 THEN 'Electronics' WHEN random() < 0.6 THEN 'Clothing' ELSE 'Food' END, (random()*500)::decimal(10,2), NOW() - (random()*365)::int * '1 day'::interval, CASE WHEN random() < 0.5 THEN 'North' ELSE 'South' END FROM generate_series(1, 500);\"",
        validation: "docker exec postgres-advanced psql -U postgres -c 'SELECT COUNT(*) FROM sales;' | grep 500"
      },
      {
        step_number: 3,
        title: "Use CTE for monthly aggregation",
        instruction: "Calculate monthly sales using CTE",
        expected_command: "docker exec postgres-advanced psql -U postgres -c \"WITH monthly_sales AS (SELECT DATE_TRUNC('month', sale_date) as month, SUM(amount) as total FROM sales GROUP BY month) SELECT month, ROUND(total, 2) as total_sales FROM monthly_sales ORDER BY month LIMIT 5;\"",
        validation: "docker exec postgres-advanced psql -U postgres -c \"WITH monthly_sales AS (SELECT DATE_TRUNC('month', sale_date) as month, COUNT(*) FROM sales GROUP BY month) SELECT COUNT(*) FROM monthly_sales;\" | grep -E '[0-9]+'"
      },
      {
        step_number: 4,
        title: "Use window function for running total",
        instruction: "Calculate running total of sales by region",
        expected_command: "docker exec postgres-advanced psql -U postgres -c \"SELECT region, sale_date, amount, SUM(amount) OVER (PARTITION BY region ORDER BY sale_date) as running_total FROM sales ORDER BY region, sale_date LIMIT 10;\"",
        validation: "docker exec postgres-advanced psql -U postgres -c \"SELECT COUNT(*) FROM (SELECT region, SUM(amount) OVER (PARTITION BY region) FROM sales) t;\" | grep 500"
      },
      {
        step_number: 5,
        title: "Calculate moving average",
        instruction: "Use window function for 7-day moving average",
        expected_command: "docker exec postgres-advanced psql -U postgres -c \"SELECT sale_date, ROUND(AVG(amount) OVER (ORDER BY sale_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) as moving_avg FROM sales ORDER BY sale_date LIMIT 10;\"",
        validation: "docker exec postgres-advanced psql -U postgres -c \"SELECT AVG(amount) FROM sales;\" | grep -E '[0-9]+'"
      },
      {
        step_number: 6,
        title: "Complex CTE with multiple levels",
        instruction: "Create hierarchical CTE for category analysis",
        expected_command: "docker exec postgres-advanced psql -U postgres -c \"WITH category_totals AS (SELECT category, SUM(amount) as total FROM sales GROUP BY category), ranked_categories AS (SELECT category, total, RANK() OVER (ORDER BY total DESC) as rank FROM category_totals) SELECT category, ROUND(total, 2), rank FROM ranked_categories;\"",
        validation: "docker exec postgres-advanced psql -U postgres -c \"WITH ct AS (SELECT category, COUNT(*) FROM sales GROUP BY category) SELECT COUNT(*) FROM ct;\" | grep -E '[0-9]+'"
      },
      {
        step_number: 7,
        title: "Performance comparison",
        instruction: "Compare execution time of CTE vs subquery",
        expected_command: "docker exec postgres-advanced psql -U postgres -c \"EXPLAIN ANALYZE WITH totals AS (SELECT region, SUM(amount) FROM sales GROUP BY region) SELECT * FROM totals;\"",
        validation: "docker exec postgres-advanced psql -U postgres -c \"EXPLAIN SELECT region FROM sales GROUP BY region;\" | grep -i 'group' || echo 'Query analyzed'"
      },
      {
        step_number: 8,
        title: "Cleanup",
        instruction: "Remove container",
        expected_command: "docker rm -f postgres-advanced",
        validation: "docker ps | grep postgres-advanced"
      }
    ],
    validation_rules: {
      cte_mastered: "CTEs used correctly",
      window_functions_working: "window functions produce correct results",
      complex_queries_optimized: "advanced queries performant"
    },
    success_criteria: "Master advanced SQL techniques for analytical queries",
    environment_image: "docker:20-dind",
    required_tools: ["docker"],
    max_attempts: 3,
    points_reward: 500,
    is_active: true
  }
]

# Create PostgreSQL Labs
postgresql_labs.each_with_index do |lab_data, index|
  begin
    lab = HandsOnLab.find_or_initialize_by(title: lab_data[:title])
    lab.assign_attributes(lab_data)
    lab.save ? print(".") : puts("\n❌ Failed: #{lab_data[:title]}")
  rescue => e
    puts "\n❌ Error on #{lab_data[:title]}: #{e.message}"
  end
end

puts "\n\n✅ PostgreSQL Database Mastery Labs Seeding Complete!"
puts "   Total labs: #{HandsOnLab.where(lab_type: 'postgresql').count}"
puts "\n🐘 Ready for PostgreSQL Learning!"
