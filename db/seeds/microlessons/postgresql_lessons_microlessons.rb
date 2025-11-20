# AUTO-GENERATED from postgresql_lessons.rb
puts "Creating Microlessons for Postgresql Lessons..."

module_var = CourseModule.find_by(slug: 'postgresql-lessons')

# === MICROLESSON 1: Introduction to SQL SELECT Statements ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Introduction to SQL SELECT Statements',
  content: <<~MARKDOWN,
# Introduction to SQL SELECT Statements 🚀

# Introduction to SQL SELECT Statements

      SQL (Structured Query Language) is the standard language for interacting with relational databases. The most fundamental SQL operation is the **SELECT** statement, which allows you to retrieve data from database tables.

      ## Basic SELECT Syntax

      The simplest form of a SELECT statement is:

      ```sql
      SELECT column1, column2, ...
      FROM table_name;
      ```

      To select all columns from a table:

      ```sql
      SELECT * FROM table_name;
      ```

      ## The WHERE Clause

      The WHERE clause is used to filter records based on specific conditions:

      ```sql
      SELECT * FROM users
      WHERE age > 25;
      ```

      ### Common WHERE Operators

      - `=` : Equal to
      - `>` : Greater than
      - `<` : Less than
      - `>=` : Greater than or equal to
      - `<=` : Less than or equal to
      - `!=` or `<>` : Not equal to
      - `LIKE` : Pattern matching
      - `IN` : Match any value in a list
      - `BETWEEN` : Within a range

      ## Examples

      **Select specific columns:**
      ```sql
      SELECT name, email FROM users;
      ```

      **Filter by condition:**
      ```sql
      SELECT name, city FROM users
      WHERE city = 'New York';
      ```

      **Multiple conditions:**
      ```sql
      SELECT * FROM users
      WHERE age > 30 AND city = 'Boston';
      ```

      ## Practice Time!

      Now you're ready to practice SELECT statements with the hands-on lab. You'll work with a real users table and write queries to retrieve specific data.

## Key Points

- SELECT statement

- WHERE clause

- Filtering data
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['SELECT statement', 'WHERE clause', 'Filtering data', 'SQL operators'],
  prerequisite_ids: []
)

# === MICROLESSON 2: SQL Aggregate Functions and GROUP BY ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'SQL Aggregate Functions and GROUP BY',
  content: <<~MARKDOWN,
# SQL Aggregate Functions and GROUP BY 🚀

# SQL Aggregate Functions and GROUP BY

      Aggregate functions perform calculations on multiple rows of data and return a single value. They are essential for data analysis and reporting.

      ## Common Aggregate Functions

      ### COUNT()
      Counts the number of rows:
      ```sql
      SELECT COUNT(*) FROM users;
      SELECT COUNT(DISTINCT city) FROM users;
      ```

      ### SUM()
      Adds up numeric values:
      ```sql
      SELECT SUM(price) FROM orders;
      ```

      ### AVG()
      Calculates the average:
      ```sql
      SELECT AVG(age) FROM users;
      ```

      ### MAX() and MIN()
      Find maximum and minimum values:
      ```sql
      SELECT MAX(price), MIN(price) FROM products;
      ```

      ## GROUP BY Clause

      GROUP BY groups rows with the same values into summary rows:

      ```sql
      SELECT city, COUNT(*) as user_count
      FROM users
      GROUP BY city;
      ```

      ## HAVING Clause

      HAVING filters grouped results (like WHERE for aggregates):

      ```sql
      SELECT city, COUNT(*) as user_count
      FROM users
      GROUP BY city
      HAVING COUNT(*) > 5;
      ```

      ## Examples

      **Count users by city:**
      ```sql
      SELECT city, COUNT(*) FROM users
      GROUP BY city;
      ```

      **Average age by city:**
      ```sql
      SELECT city, AVG(age) as avg_age
      FROM users
      GROUP BY city;
      ```

      **Cities with more than 3 users:**
      ```sql
      SELECT city, COUNT(*) as count
      FROM users
      GROUP BY city
      HAVING COUNT(*) > 3;
      ```

      Ready to practice aggregate functions? Let's move to the lab!

## Key Points

- Aggregate functions

- GROUP BY

- HAVING clause
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Aggregate functions', 'GROUP BY', 'HAVING clause', 'COUNT, SUM, AVG'],
  prerequisite_ids: []
)

# === MICROLESSON 3: Understanding SQL Joins ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Understanding SQL Joins',
  content: <<~MARKDOWN,
# Understanding SQL Joins 🚀

# Understanding SQL Joins

      Joins are used to combine rows from two or more tables based on a related column. They are fundamental to working with relational databases.

      ## Types of Joins

      ### INNER JOIN
      Returns records that have matching values in both tables:
      ```sql
      SELECT users.name, orders.order_date
      FROM users
      INNER JOIN orders ON users.id = orders.user_id;
      ```

      ### LEFT JOIN (LEFT OUTER JOIN)
      Returns all records from the left table and matched records from the right:
      ```sql
      SELECT users.name, orders.order_date
      FROM users
      LEFT JOIN orders ON users.id = orders.user_id;
      ```

      ### RIGHT JOIN
      Returns all records from the right table and matched records from the left.

      ### FULL OUTER JOIN
      Returns all records when there's a match in either table.

      ## Join Syntax

      Basic join pattern:
      ```sql
      SELECT columns
      FROM table1
      JOIN table2 ON table1.column = table2.column;
      ```

      ## Multiple Joins

      You can join more than two tables:
      ```sql
      SELECT u.name, o.order_date, p.product_name
      FROM users u
      JOIN orders o ON u.id = o.user_id
      JOIN products p ON o.product_id = p.id;
      ```

      ## Table Aliases

      Use aliases to make queries more readable:
      ```sql
      SELECT u.name, o.total
      FROM users u
      JOIN orders o ON u.id = o.user_id;
      ```

      ## Examples

      **Users with their orders:**
      ```sql
      SELECT users.name, orders.total
      FROM users
      INNER JOIN orders ON users.id = orders.user_id;
      ```

      **All users, even without orders:**
      ```sql
      SELECT users.name, orders.total
      FROM users
      LEFT JOIN orders ON users.id = orders.user_id;
      ```

      Now practice joining tables in the lab!

## Key Points

- INNER JOIN

- LEFT JOIN

- Table relationships
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['INNER JOIN', 'LEFT JOIN', 'Table relationships', 'Join conditions'],
  prerequisite_ids: []
)

# === MICROLESSON 4: Introduction to SQL SELECT Statements ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Introduction to SQL SELECT Statements',
  content: <<~MARKDOWN,
# Introduction to SQL SELECT Statements 🚀

# Introduction to SQL SELECT Statements

      SQL (Structured Query Language) is the standard language for interacting with relational databases. The most fundamental SQL operation is the **SELECT** statement, which allows you to retrieve data from database tables.

      ## Basic SELECT Syntax

      The simplest form of a SELECT statement is:

      ```sql
      SELECT column1, column2, ...
      FROM table_name;
      ```

      To select all columns from a table:

      ```sql
      SELECT * FROM table_name;
      ```

      ## The WHERE Clause

      The WHERE clause is used to filter records based on specific conditions:

      ```sql
      SELECT * FROM users
      WHERE age > 25;
      ```

      ### Common WHERE Operators

      - `=` : Equal to
      - `>` : Greater than
      - `<` : Less than
      - `>=` : Greater than or equal to
      - `<=` : Less than or equal to
      - `!=` or `<>` : Not equal to
      - `LIKE` : Pattern matching
      - `IN` : Match any value in a list
      - `BETWEEN` : Within a range

      ## Examples

      **Select specific columns:**
      ```sql
      SELECT name, email FROM users;
      ```

      **Filter by condition:**
      ```sql
      SELECT name, city FROM users
      WHERE city = 'New York';
      ```

      **Multiple conditions:**
      ```sql
      SELECT * FROM users
      WHERE age > 30 AND city = 'Boston';
      ```

      ## Practice Time!

      Now you're ready to practice SELECT statements with the hands-on lab. You'll work with a real users table and write queries to retrieve specific data.

## Key Points

- SELECT statement

- WHERE clause

- Filtering data
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['SELECT statement', 'WHERE clause', 'Filtering data', 'SQL operators'],
  prerequisite_ids: []
)

# === MICROLESSON 5: SQL Aggregate Functions and GROUP BY ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'SQL Aggregate Functions and GROUP BY',
  content: <<~MARKDOWN,
# SQL Aggregate Functions and GROUP BY 🚀

# SQL Aggregate Functions and GROUP BY

      Aggregate functions perform calculations on multiple rows of data and return a single value. They are essential for data analysis and reporting.

      ## Common Aggregate Functions

      ### COUNT()
      Counts the number of rows:
      ```sql
      SELECT COUNT(*) FROM users;
      SELECT COUNT(DISTINCT city) FROM users;
      ```

      ### SUM()
      Adds up numeric values:
      ```sql
      SELECT SUM(price) FROM orders;
      ```

      ### AVG()
      Calculates the average:
      ```sql
      SELECT AVG(age) FROM users;
      ```

      ### MAX() and MIN()
      Find maximum and minimum values:
      ```sql
      SELECT MAX(price), MIN(price) FROM products;
      ```

      ## GROUP BY Clause

      GROUP BY groups rows with the same values into summary rows:

      ```sql
      SELECT city, COUNT(*) as user_count
      FROM users
      GROUP BY city;
      ```

      ## HAVING Clause

      HAVING filters grouped results (like WHERE for aggregates):

      ```sql
      SELECT city, COUNT(*) as user_count
      FROM users
      GROUP BY city
      HAVING COUNT(*) > 5;
      ```

      ## Examples

      **Count users by city:**
      ```sql
      SELECT city, COUNT(*) FROM users
      GROUP BY city;
      ```

      **Average age by city:**
      ```sql
      SELECT city, AVG(age) as avg_age
      FROM users
      GROUP BY city;
      ```

      **Cities with more than 3 users:**
      ```sql
      SELECT city, COUNT(*) as count
      FROM users
      GROUP BY city
      HAVING COUNT(*) > 3;
      ```

      Ready to practice aggregate functions? Let's move to the lab!

## Key Points

- Aggregate functions

- GROUP BY

- HAVING clause
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['Aggregate functions', 'GROUP BY', 'HAVING clause', 'COUNT, SUM, AVG'],
  prerequisite_ids: []
)

# === MICROLESSON 6: Understanding SQL Joins ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Understanding SQL Joins',
  content: <<~MARKDOWN,
# Understanding SQL Joins 🚀

# Understanding SQL Joins

      Joins are used to combine rows from two or more tables based on a related column. They are fundamental to working with relational databases.

      ## Types of Joins

      ### INNER JOIN
      Returns records that have matching values in both tables:
      ```sql
      SELECT users.name, orders.order_date
      FROM users
      INNER JOIN orders ON users.id = orders.user_id;
      ```

      ### LEFT JOIN (LEFT OUTER JOIN)
      Returns all records from the left table and matched records from the right:
      ```sql
      SELECT users.name, orders.order_date
      FROM users
      LEFT JOIN orders ON users.id = orders.user_id;
      ```

      ### RIGHT JOIN
      Returns all records from the right table and matched records from the left.

      ### FULL OUTER JOIN
      Returns all records when there's a match in either table.

      ## Join Syntax

      Basic join pattern:
      ```sql
      SELECT columns
      FROM table1
      JOIN table2 ON table1.column = table2.column;
      ```

      ## Multiple Joins

      You can join more than two tables:
      ```sql
      SELECT u.name, o.order_date, p.product_name
      FROM users u
      JOIN orders o ON u.id = o.user_id
      JOIN products p ON o.product_id = p.id;
      ```

      ## Table Aliases

      Use aliases to make queries more readable:
      ```sql
      SELECT u.name, o.total
      FROM users u
      JOIN orders o ON u.id = o.user_id;
      ```

      ## Examples

      **Users with their orders:**
      ```sql
      SELECT users.name, orders.total
      FROM users
      INNER JOIN orders ON users.id = orders.user_id;
      ```

      **All users, even without orders:**
      ```sql
      SELECT users.name, orders.total
      FROM users
      LEFT JOIN orders ON users.id = orders.user_id;
      ```

      Now practice joining tables in the lab!

## Key Points

- INNER JOIN

- LEFT JOIN

- Table relationships
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['INNER JOIN', 'LEFT JOIN', 'Table relationships', 'Join conditions'],
  prerequisite_ids: []
)

puts "✓ Created 6 microlessons for Postgresql Lessons"
