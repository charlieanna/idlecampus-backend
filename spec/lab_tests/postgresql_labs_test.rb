#!/usr/bin/env ruby
# PostgreSQL Labs Automated Tests

require_relative 'test_helper'

class PostgreSQLLabsTest
  include LabTestHelper

  def self.test_basics_lab
    LabTestHelper.test_lab(
      "PostgreSQL Basics - First Database and Table",
      [
        {
          step_number: 1,
          title: "Start PostgreSQL container",
          command: "docker run -d --name postgres-lab -e POSTGRES_PASSWORD=secret -p 15432:5432 postgres:15",
          validation: "docker ps --filter name=postgres-lab --format '{{.Names}}'",
          timeout: 60
        },
        {
          step_number: 2,
          title: "Wait for PostgreSQL to be ready",
          command: "sleep 5 && docker exec postgres-lab pg_isready -U postgres",
          validation: "docker exec postgres-lab pg_isready -U postgres",
          timeout: 15
        },
        {
          step_number: 3,
          title: "Create database",
          command: "docker exec postgres-lab psql -U postgres -c 'CREATE DATABASE appdb;'",
          validation: "docker exec postgres-lab psql -U postgres -l | grep appdb"
        },
        {
          step_number: 4,
          title: "Create users table",
          command: "docker exec postgres-lab psql -U postgres -d appdb -c 'CREATE TABLE users (id SERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL, email VARCHAR(255) UNIQUE NOT NULL, created_at TIMESTAMP DEFAULT NOW());'",
          validation: "docker exec postgres-lab psql -U postgres -d appdb -c '\\dt' | grep users"
        },
        {
          step_number: 5,
          title: "Insert data",
          command: "docker exec postgres-lab psql -U postgres -d appdb -c \"INSERT INTO users (name, email) VALUES ('Alice', 'alice@example.com'), ('Bob', 'bob@example.com'), ('Charlie', 'charlie@example.com');\"",
          validation: "docker exec postgres-lab psql -U postgres -d appdb -c 'SELECT COUNT(*) FROM users;' | grep 3"
        },
        {
          step_number: 6,
          title: "Query data",
          command: "docker exec postgres-lab psql -U postgres -d appdb -c 'SELECT * FROM users;'",
          validation: "docker exec postgres-lab psql -U postgres -d appdb -c 'SELECT COUNT(*) FROM users;' | grep 3"
        },
        {
          step_number: 7,
          title: "Update data",
          command: "docker exec postgres-lab psql -U postgres -d appdb -c \"UPDATE users SET email = 'alice.new@example.com' WHERE name = 'Alice';\"",
          validation: "docker exec postgres-lab psql -U postgres -d appdb -c \"SELECT email FROM users WHERE name='Alice';\" | grep alice.new"
        }
      ],
      cleanup_containers: ['postgres-lab']
    )
  end

  def self.test_indexes_lab
    LabTestHelper.test_lab(
      "Indexes and Query Performance",
      [
        {
          step_number: 1,
          title: "Start PostgreSQL container",
          command: "docker run -d --name postgres-perf -e POSTGRES_PASSWORD=secret -p 15433:5432 postgres:15",
          validation: "docker ps --filter name=postgres-perf --format '{{.Names}}'",
          timeout: 60
        },
        {
          step_number: 2,
          title: "Wait for PostgreSQL",
          command: "sleep 5 && docker exec postgres-perf pg_isready -U postgres",
          validation: "docker exec postgres-perf pg_isready -U postgres",
          timeout: 15
        },
        {
          step_number: 3,
          title: "Create orders table",
          command: "docker exec postgres-perf psql -U postgres -c 'CREATE TABLE orders (id SERIAL PRIMARY KEY, user_id INT, product_id INT, amount DECIMAL(10,2), order_date DATE);'",
          validation: "docker exec postgres-perf psql -U postgres -c '\\dt' | grep orders"
        },
        {
          step_number: 4,
          title: "Generate test data",
          command: "docker exec postgres-perf psql -U postgres -c \"INSERT INTO orders (user_id, product_id, amount, order_date) SELECT (random()*100)::int, (random()*50)::int, (random()*1000)::decimal(10,2), NOW() - (random()*365)::int * '1 day'::interval FROM generate_series(1, 1000);\"",
          validation: "docker exec postgres-perf psql -U postgres -c 'SELECT COUNT(*) FROM orders;' | grep 1000",
          timeout: 20
        },
        {
          step_number: 5,
          title: "Analyze query without index",
          command: "docker exec postgres-perf psql -U postgres -c 'EXPLAIN SELECT * FROM orders WHERE user_id = 42;'",
          validation: "docker exec postgres-perf psql -U postgres -c 'EXPLAIN SELECT * FROM orders WHERE user_id = 42;' | grep -i 'scan'"
        },
        {
          step_number: 6,
          title: "Create index on user_id",
          command: "docker exec postgres-perf psql -U postgres -c 'CREATE INDEX idx_orders_user_id ON orders(user_id);'",
          validation: "docker exec postgres-perf psql -U postgres -c '\\di' | grep idx_orders_user_id"
        },
        {
          step_number: 7,
          title: "Verify index exists",
          command: "docker exec postgres-perf psql -U postgres -c \"SELECT indexname FROM pg_indexes WHERE tablename = 'orders';\"",
          validation: "docker exec postgres-perf psql -U postgres -c \"SELECT indexname FROM pg_indexes WHERE tablename = 'orders';\" | grep idx_orders_user_id"
        }
      ],
      cleanup_containers: ['postgres-perf']
    )
  end

  def self.test_transactions_lab
    LabTestHelper.test_lab(
      "Transactions and ACID Properties",
      [
        {
          step_number: 1,
          title: "Start PostgreSQL container",
          command: "docker run -d --name postgres-tx -e POSTGRES_PASSWORD=secret -p 15434:5432 postgres:15",
          validation: "docker ps --filter name=postgres-tx --format '{{.Names}}'",
          timeout: 60
        },
        {
          step_number: 2,
          title: "Wait for PostgreSQL",
          command: "sleep 5 && docker exec postgres-tx pg_isready -U postgres",
          validation: "docker exec postgres-tx pg_isready -U postgres",
          timeout: 15
        },
        {
          step_number: 3,
          title: "Create accounts table",
          command: "docker exec postgres-tx psql -U postgres -c 'CREATE TABLE accounts (id SERIAL PRIMARY KEY, name VARCHAR(100), balance DECIMAL(10,2));'",
          validation: "docker exec postgres-tx psql -U postgres -c '\\dt' | grep accounts"
        },
        {
          step_number: 4,
          title: "Insert test accounts",
          command: "docker exec postgres-tx psql -U postgres -c \"INSERT INTO accounts (name, balance) VALUES ('Alice', 1000.00), ('Bob', 500.00);\"",
          validation: "docker exec postgres-tx psql -U postgres -c 'SELECT COUNT(*) FROM accounts;' | grep 2"
        },
        {
          step_number: 5,
          title: "Perform transaction",
          command: "docker exec postgres-tx psql -U postgres -c \"BEGIN; UPDATE accounts SET balance = balance - 100 WHERE name = 'Alice'; UPDATE accounts SET balance = balance + 100 WHERE name = 'Bob'; COMMIT;\"",
          validation: "docker exec postgres-tx psql -U postgres -c \"SELECT balance FROM accounts WHERE name='Bob';\" | grep 600"
        },
        {
          step_number: 6,
          title: "Test rollback",
          command: "docker exec postgres-tx psql -U postgres -c \"BEGIN; UPDATE accounts SET balance = balance - 2000 WHERE name = 'Alice'; ROLLBACK;\"",
          validation: "docker exec postgres-tx psql -U postgres -c \"SELECT balance FROM accounts WHERE name='Alice';\" | grep 900"
        },
        {
          step_number: 7,
          title: "Verify consistency",
          command: "docker exec postgres-tx psql -U postgres -c 'SELECT SUM(balance) FROM accounts;'",
          validation: "docker exec postgres-tx psql -U postgres -c 'SELECT SUM(balance) FROM accounts;' | grep 1500"
        }
      ],
      cleanup_containers: ['postgres-tx']
    )
  end

  def self.run_all_tests
    puts "\n🐘 PostgreSQL Labs Test Suite"
    puts "=" * 80

    results = []
    results << test_basics_lab
    results << test_indexes_lab
    results << test_transactions_lab

    total = results.size
    passed = results.count { |r| r[:success] }
    failed = total - passed

    puts "\n" + "=" * 80
    puts "PostgreSQL Labs Test Summary"
    puts "=" * 80
    puts "Total Labs Tested: #{total}"
    puts "Passed: #{passed} ✅"
    puts "Failed: #{failed} #{'❌' if failed > 0}"
    puts "=" * 80

    { total: total, passed: passed, failed: failed, results: results }
  end
end

# Run tests if executed directly
if __FILE__ == $0
  unless LabTestHelper.docker_available?
    puts "❌ Docker is not available. Please ensure Docker is installed and running."
    exit 1
  end

  LabTestHelper.cleanup_all_test_containers
  result = PostgreSQLLabsTest.run_all_tests
  exit(result[:failed] > 0 ? 1 : 0)
end
