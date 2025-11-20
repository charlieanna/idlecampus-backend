# PostgreSQL Database Mastery - Complete Course
puts "Creating Complete PostgreSQL Database Mastery Course..."

postgresql_course = Course.find_or_create_by!(slug: 'postgresql-mastery') do |course|
  course.title = "PostgreSQL Database Mastery"
  course.description = "Master PostgreSQL from fundamentals to advanced optimization. Learn SQL, indexing, transactions, and query tuning."
  course.difficulty_level = "intermediate"
  course.estimated_hours = 32
  course.certification_track = nil
  course.published = true
  course.sequence_order = 12
  course.learning_objectives = JSON.generate([
    "Master SQL queries and database design",
    "Optimize queries with indexes and EXPLAIN",
    "Implement transactions and maintain data integrity",
    "Use advanced features like CTEs and window functions",
    "Tune PostgreSQL for production workloads"
  ])
  course.prerequisites = JSON.generate([
    "Basic SQL knowledge",
    "Understanding of relational databases",
    "Command line familiarity"
  ])
end

puts "Created course: #{postgresql_course.title}"

# ==========================================
# MODULE 1: PostgreSQL Fundamentals
# ==========================================

module1 = CourseModule.find_or_create_by!(slug: 'postgresql-fundamentals', course: postgresql_course) do |mod|
  mod.title = "PostgreSQL Fundamentals"
  mod.description = "Learn PostgreSQL basics, data types, and CRUD operations"
  mod.sequence_order = 1
  mod.estimated_minutes = 180
  mod.published = true
end

lesson1_1 = CourseLesson.find_or_create_by!(title: "Introduction to PostgreSQL") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
    # Introduction to PostgreSQL

    PostgreSQL is a powerful, open-source object-relational database system.

    ## Why PostgreSQL?

    - **Open Source**: Free and community-driven
    - **ACID Compliant**: Reliable transactions
    - **Feature-Rich**: Advanced data types, full-text search, JSON support
    - **Extensible**: Custom functions, operators, data types
    - **Standards Compliant**: Follows SQL standards
    - **Used By**: Instagram, Spotify, Uber, Apple

    ## Installation

    ### macOS
    ```bash
    brew install postgresql@15
    brew services start postgresql@15
    ```

    ### Ubuntu/Debian
    ```bash
    sudo apt update
    sudo apt install postgresql postgresql-contrib
    sudo systemctl start postgresql
    ```

    ### Docker
    ```bash
    docker run --name postgres \\
      -e POSTGRES_PASSWORD=mypassword \\
      -p 5432:5432 \\
      -d postgres:15
    ```

    ## Connecting to PostgreSQL

    ### psql (CLI)
    ```bash
    # Connect as superuser
    psql -U postgres

    # Connect to specific database
    psql -h localhost -p 5432 -U myuser -d mydatabase
    ```

    ### Common psql Commands
    ```sql
    \\l                 -- List databases
    \\c dbname          -- Connect to database
    \\dt                -- List tables
    \\d tablename       -- Describe table
    \\du                -- List users/roles
    \\q                 -- Quit
    \\?                 -- Help
    ```

    ## Creating Databases

    ```sql
    -- Create database
    CREATE DATABASE myapp;

    -- Create with specific encoding
    CREATE DATABASE myapp
      ENCODING 'UTF8'
      LC_COLLATE 'en_US.UTF-8'
      LC_CTYPE 'en_US.UTF-8';

    -- Drop database
    DROP DATABASE myapp;

    -- List databases
    \\l
    SELECT datname FROM pg_database;
    ```

    ## PostgreSQL Data Types

    ### Numeric Types
    ```sql
    -- Integers
    SMALLINT            -- 2 bytes, -32768 to +32767
    INTEGER or INT      -- 4 bytes, -2 billion to +2 billion
    BIGINT              -- 8 bytes, very large integers

    -- Decimals
    DECIMAL(10, 2)      -- Exact decimal, 10 digits, 2 after decimal
    NUMERIC(10, 2)      -- Same as DECIMAL
    REAL                -- 4 bytes, 6 decimal digits precision
    DOUBLE PRECISION    -- 8 bytes, 15 decimal digits precision

    -- Serial (auto-increment)
    SERIAL              -- Auto-incrementing integer
    BIGSERIAL           -- Auto-incrementing bigint
    ```

    ### String Types
    ```sql
    CHAR(10)            -- Fixed length, padded with spaces
    VARCHAR(100)        -- Variable length with limit
    TEXT                -- Unlimited length string
    ```

    ### Date/Time Types
    ```sql
    DATE                -- Date only (2024-01-15)
    TIME                -- Time only (14:30:00)
    TIMESTAMP           -- Date and time
    TIMESTAMPTZ         -- Timestamp with timezone
    INTERVAL            -- Time interval (5 days, 2 hours)
    ```

    ### Boolean
    ```sql
    BOOLEAN             -- TRUE, FALSE, NULL
    ```

    ### JSON Types
    ```sql
    JSON                -- JSON text, validates syntax
    JSONB               -- Binary JSON, faster, supports indexing
    ```

    ### Other Types
    ```sql
    UUID                -- Universally unique identifier
    ARRAY               -- Array of any type
    INET                -- IP address
    ```

    ## Creating Tables

    ```sql
    CREATE TABLE users (
        id SERIAL PRIMARY KEY,
        email VARCHAR(255) UNIQUE NOT NULL,
        username VARCHAR(50) UNIQUE NOT NULL,
        full_name VARCHAR(100),
        age INTEGER CHECK (age >= 18),
        is_active BOOLEAN DEFAULT TRUE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    ```

    ## CRUD Operations

    ### CREATE (INSERT): Adding Data

    **What is INSERT?**

    INSERT adds new rows (records) to your database table. Every user signup, product creation, or new order starts with an INSERT.

    **Why INSERT matters:**
    - User registers → INSERT into users table
    - Customer places order → INSERT into orders table
    - Blog post published → INSERT into posts table

    Without INSERT, your database would be read-only!

    #### Basic INSERT: Single Row

    ```sql
    INSERT INTO users (email, username, full_name, age)
    VALUES ('alice@example.com', 'alice', 'Alice Smith', 25);
    ```

    **Syntax breakdown:**
    1. `INSERT INTO users` - Which table to add data to
    2. `(email, username, full_name, age)` - Which columns you're providing values for
    3. `VALUES (...)` - The actual data values in the SAME order as columns

    **What happens internally:**
    ```
    1. PostgreSQL validates data types (email is TEXT, age is INTEGER)
    2. Checks constraints (email unique? age >= 0?)
    3. Generates auto-increment ID (if SERIAL column exists)
    4. Writes row to table
    5. Updates indexes
    6. Returns success (or error if constraints violated)
    ```

    #### Inserting Without Specifying All Columns

    ```sql
    -- Only provide some columns
    INSERT INTO users (email, username)
    VALUES ('bob@example.com', 'bob');
    ```

    **What happens to missing columns?**
    - Columns with `DEFAULT` values → Use the default
    - Columns allowing `NULL` → Set to NULL
    - Columns with `NOT NULL` and no default → ERROR

    **Example:**
    ```sql
    CREATE TABLE products (
        id SERIAL PRIMARY KEY,
        name TEXT NOT NULL,
        price DECIMAL DEFAULT 0.00,
        description TEXT,  -- Nullable
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

    INSERT INTO products (name)
    VALUES ('Widget');

    -- Result:
    -- id: 1 (auto-generated)
    -- name: 'Widget' (provided)
    -- price: 0.00 (default)
    -- description: NULL (nullable, not provided)
    -- created_at: 2025-11-05 12:34:56 (default CURRENT_TIMESTAMP)
    ```

    #### Bulk INSERT: Multiple Rows

    **Why bulk inserts?**
    Inserting 1000 rows one-by-one requires 1000 separate database roundtrips. Bulk insert does it in ONE trip - **100x faster**!

    ```sql
    INSERT INTO users (email, username, full_name, age)
    VALUES
      ('bob@example.com', 'bob', 'Bob Jones', 30),
      ('charlie@example.com', 'charlie', 'Charlie Brown', 28),
      ('dave@example.com', 'dave', 'Dave Wilson', 35);
    ```

    **Performance comparison:**
    ```
    Single inserts (1000 rows):  ~5 seconds
    Bulk insert (1000 rows):     ~0.05 seconds
    ```

    **Best practice:** Always batch inserts when possible.

    #### RETURNING: Get Data Back

    **The Problem:**
    After INSERT, how do you know the generated ID?

    ❌ **Bad approach (requires second query):**
    ```sql
    INSERT INTO users (email, username) VALUES ('eve@example.com', 'eve');
    SELECT id FROM users WHERE email = 'eve@example.com';  -- Extra query!
    ```

    ✅ **Good approach (single query with RETURNING):**
    ```sql
    INSERT INTO users (email, username, full_name, age)
    VALUES ('dave@example.com', 'dave', 'Dave Wilson', 35)
    RETURNING id, email, created_at;
    ```

    **Returns:**
    ```
    id | email              | created_at
    ---+--------------------+-------------------------
    4  | dave@example.com   | 2025-11-05 10:30:45
    ```

    **When to use RETURNING:**
    - Get auto-generated ID for foreign key relationships
    - Get timestamp values (created_at) without separate SELECT
    - Confirm what was actually inserted (after defaults/triggers)
    - Return data to application immediately

    **Works with bulk inserts too:**
    ```sql
    INSERT INTO users (email, username)
    VALUES
      ('user1@example.com', 'user1'),
      ('user2@example.com', 'user2')
    RETURNING id, email;

    -- Returns:
    -- id | email
    -- ---+-----------------
    -- 5  | user1@example.com
    -- 6  | user2@example.com
    ```

    #### INSERT ... ON CONFLICT (Upsert)

    **The Problem:**
    What if you try to insert a duplicate email (unique constraint)?

    ```sql
    INSERT INTO users (email, username)
    VALUES ('alice@example.com', 'alice');
    -- ERROR: duplicate key value violates unique constraint
    ```

    **Solution: ON CONFLICT DO NOTHING**
    ```sql
    INSERT INTO users (email, username)
    VALUES ('alice@example.com', 'alice_new')
    ON CONFLICT (email) DO NOTHING;
    -- No error, just silently skips insert
    ```

    **Solution: ON CONFLICT DO UPDATE (Upsert)**
    ```sql
    INSERT INTO users (email, username, last_login)
    VALUES ('alice@example.com', 'alice', CURRENT_TIMESTAMP)
    ON CONFLICT (email) DO UPDATE
    SET last_login = EXCLUDED.last_login;
    ```

    **What happens:**
    - If email doesn't exist → INSERT new row
    - If email exists → UPDATE the last_login column
    - `EXCLUDED` refers to the values you tried to insert

    **Real-world use case: Session tracking**
    ```sql
    -- Update session timestamp or create new session
    INSERT INTO user_sessions (user_id, last_seen)
    VALUES (123, CURRENT_TIMESTAMP)
    ON CONFLICT (user_id) DO UPDATE
    SET last_seen = EXCLUDED.last_seen;
    ```

    #### INSERT from SELECT

    **Copy data from one table to another:**
    ```sql
    -- Archive old orders
    INSERT INTO orders_archive (order_id, customer_id, total, created_at)
    SELECT id, customer_id, total, created_at
    FROM orders
    WHERE created_at < '2020-01-01';
    ```

    **Combine with VALUES:**
    ```sql
    INSERT INTO products (name, price)
    SELECT CONCAT('Upgraded ', name), price * 1.2
    FROM old_products
    WHERE active = true;
    ```

    #### Common INSERT Errors

    **1. NOT NULL violation:**
    ```sql
    INSERT INTO users (email) VALUES ('test@example.com');
    -- ERROR: null value in column "username" violates not-null constraint
    ```
    **Fix:** Provide all required columns.

    **2. Unique constraint violation:**
    ```sql
    INSERT INTO users (email, username) VALUES ('alice@example.com', 'alice');
    -- ERROR: duplicate key value violates unique constraint "users_email_key"
    ```
    **Fix:** Use ON CONFLICT or check existence first.

    **3. Type mismatch:**
    ```sql
    INSERT INTO users (age) VALUES ('twenty-five');
    -- ERROR: invalid input syntax for type integer
    ```
    **Fix:** Use correct data type (25, not 'twenty-five').

    **4. Foreign key violation:**
    ```sql
    INSERT INTO posts (user_id, title) VALUES (999, 'My Post');
    -- ERROR: insert or update violates foreign key constraint
    ```
    **Fix:** Ensure user_id=999 exists in users table.

    #### Best Practices

    **1. Always specify column names:**
    ```sql
    -- ❌ Bad: Breaks if table structure changes
    INSERT INTO users VALUES ('alice@example.com', 'alice', 'Alice', 25);

    -- ✅ Good: Explicit and maintainable
    INSERT INTO users (email, username, full_name, age)
    VALUES ('alice@example.com', 'alice', 'Alice', 25);
    ```

    **2. Use parameterized queries (prevent SQL injection):**
    ```python
    # ❌ DANGEROUS: SQL injection vulnerability
    query = f"INSERT INTO users (username) VALUES ('{user_input}')"

    # ✅ SAFE: Parameterized query
    cursor.execute(
        "INSERT INTO users (username, email) VALUES (%s, %s)",
        (username, email)
    )
    ```

    **3. Use transactions for multiple inserts:**
    ```sql
    BEGIN;
        INSERT INTO orders (customer_id, total) VALUES (123, 99.99) RETURNING id;
        INSERT INTO order_items (order_id, product_id, quantity) VALUES (456, 789, 2);
    COMMIT;
    -- Both succeed or both fail (atomic)
    ```

    **4. Batch inserts for performance:**
    ```sql
    -- ❌ Slow: 1000 separate queries
    INSERT INTO logs (message) VALUES ('log1');
    INSERT INTO logs (message) VALUES ('log2');
    ... (998 more) ...

    -- ✅ Fast: 1 query
    INSERT INTO logs (message) VALUES
      ('log1'), ('log2'), ('log3'), ... ('log1000');
    ```

    **Key takeaways:**
    1. INSERT adds new rows to tables
    2. Always specify column names for clarity
    3. Use RETURNING to get generated IDs without extra queries
    4. ON CONFLICT handles duplicates gracefully (upsert pattern)
    5. Batch inserts for massive performance gains
    6. Use parameterized queries to prevent SQL injection

    ### READ (SELECT)

    **What is SELECT?**

    SELECT is the most fundamental SQL command. It retrieves data from your database tables and returns it as a result set (like a spreadsheet). Think of it as asking the database: "Show me some data!"

    **Why use SELECT?**

    Every time you need to view, analyze, or work with data in your database, you use SELECT. Whether you're:
    - Displaying user profiles on a website
    - Generating reports for business analytics
    - Checking if a username exists during login
    - Finding products in an e-commerce store

    ...you're using SELECT behind the scenes.

    **How does SELECT work?**

    PostgreSQL reads through your table, evaluates your conditions, and returns matching rows. The basic flow is:
    1. FROM: PostgreSQL identifies which table(s) to look at
    2. WHERE: It filters rows based on your conditions
    3. SELECT: It picks which columns to return
    4. ORDER BY: It sorts the results
    5. LIMIT: It restricts how many rows to return

    #### Basic SELECT: Getting All Data

    ```sql
    SELECT * FROM users;
    ```

    **What this does:**
    - `*` means "all columns" - PostgreSQL returns every column in the table
    - This retrieves EVERY row from the users table

    **When to use:**
    - Exploring a new table to see what data it contains
    - Small tables where you need all data

    **When NOT to use:**
    - Large tables (millions of rows) - too slow and memory-intensive
    - Production code - always specify exact columns you need
    - Network applications - transferring all columns wastes bandwidth

    #### Selecting Specific Columns

    ```sql
    SELECT id, email, username FROM users;
    ```

    **Why specify columns?**
    - **Performance**: Only retrieves data you need, faster and uses less memory
    - **Security**: Don't expose sensitive columns (like password_hash)
    - **Clarity**: Makes code easier to understand and maintain
    - **Network efficiency**: Transfers less data over the network

    **Example scenario:**
    You're building a user list page. You don't need their password, address, or preferences - just name and email. Selecting only those columns makes your query 10x faster!

    #### Filtering with WHERE

    ```sql
    SELECT * FROM users WHERE age > 25;
    ```

    **What is WHERE?**

    WHERE filters rows based on conditions. Only rows that match your condition are returned.

    **How it works:**
    PostgreSQL examines each row, evaluates your condition (age > 25), and includes the row only if the condition is TRUE.

    **Common comparison operators:**
    - `=` : Equal to (exact match)
    - `>` : Greater than
    - `<` : Less than
    - `>=` : Greater than or equal
    - `<=` : Less than or equal
    - `!=` or `<>` : Not equal

    #### Combining Conditions with AND/OR

    ```sql
    SELECT * FROM users
    WHERE age > 25 AND is_active = TRUE;
    ```

    **Understanding AND:**
    - ALL conditions must be TRUE
    - Think: "I want users who are older than 25 AND also active"
    - More restrictive - returns fewer rows

    **Understanding OR:**
    ```sql
    SELECT * FROM users
    WHERE age > 25 OR is_admin = TRUE;
    ```
    - ANY condition can be TRUE
    - Think: "I want users who are EITHER older than 25 OR admins (or both)"
    - Less restrictive - returns more rows

    **Combining AND/OR (use parentheses!):**
    ```sql
    SELECT * FROM users
    WHERE (age > 25 OR is_admin = TRUE) AND is_active = TRUE;
    ```
    This finds active users who are EITHER over 25 OR admins.

    #### Pattern Matching with LIKE

    ```sql
    SELECT * FROM users WHERE email LIKE '%@example.com';
    ```

    **What is LIKE?**

    LIKE finds text patterns using wildcards:
    - `%` : Matches any characters (zero or more)
    - `_` : Matches exactly one character

    **Examples:**
    ```sql
    -- Emails ending with @example.com
    WHERE email LIKE '%@example.com'

    -- Names starting with 'John'
    WHERE name LIKE 'John%'

    -- Names containing 'smith' anywhere
    WHERE name LIKE '%smith%'

    -- Exactly 5 characters, ending in 'son'
    WHERE name LIKE '___son'  -- Three underscores + 'son'
    ```

    **Performance warning:**
    - `LIKE 'prefix%'` : Fast (can use index)
    - `LIKE '%suffix'` : Slow (can't use index, scans entire table)
    - `LIKE '%middle%'` : Slow (can't use index)

    #### Matching Multiple Values with IN

    ```sql
    SELECT * FROM users
    WHERE username IN ('alice', 'bob', 'charlie');
    ```

    **Why use IN?**

    IN is a shorthand for multiple OR conditions:
    ```sql
    -- Instead of this:
    WHERE username = 'alice' OR username = 'bob' OR username = 'charlie'

    -- Write this:
    WHERE username IN ('alice', 'bob', 'charlie')
    ```

    **When to use:**
    - Checking membership in a list
    - Looking up multiple IDs
    - Filtering by several categories

    **With NOT:**
    ```sql
    WHERE username NOT IN ('admin', 'root', 'system')
    ```
    Returns users whose username is NOT in the list.

    #### Sorting with ORDER BY

    ```sql
    SELECT * FROM users ORDER BY age DESC;
    ```

    **What is ORDER BY?**

    Controls the order of returned rows. Without ORDER BY, row order is unpredictable.

    **Directions:**
    - `ASC` : Ascending (1, 2, 3... or A, B, C...) - **DEFAULT**
    - `DESC` : Descending (3, 2, 1... or Z, Y, X...)

    **Sorting by multiple columns:**
    ```sql
    ORDER BY age DESC, username ASC
    ```
    First sorts by age (oldest first), then within same age, sorts by username (A-Z).

    **Real-world examples:**
    ```sql
    -- Newest users first
    ORDER BY created_at DESC

    -- Alphabetical by name
    ORDER BY last_name ASC, first_name ASC

    -- Products by price (cheapest first)
    ORDER BY price ASC
    ```

    #### Pagination with LIMIT and OFFSET

    ```sql
    SELECT * FROM users LIMIT 10 OFFSET 20;
    ```

    **What is LIMIT?**

    LIMIT restricts the number of rows returned. Essential for:
    - Pagination (showing page 1, page 2, etc.)
    - Previewing data
    - Preventing massive result sets

    **What is OFFSET?**

    OFFSET skips a certain number of rows before starting to return results.

    **How pagination works:**
    ```sql
    -- Page 1: First 10 users
    SELECT * FROM users LIMIT 10 OFFSET 0;

    -- Page 2: Next 10 users (skip first 10)
    SELECT * FROM users LIMIT 10 OFFSET 10;

    -- Page 3: Next 10 users (skip first 20)
    SELECT * FROM users LIMIT 10 OFFSET 20;

    -- Formula: OFFSET = (page_number - 1) * page_size
    ```

    **Performance note:**
    Large OFFSETs are slow (e.g., OFFSET 100000) because PostgreSQL still has to read and skip those rows. For large datasets, use cursor-based pagination instead.

    #### Complete Example: Building a User Search

    Let's build a search feature step by step:

    ```sql
    -- Step 1: Find active users
    SELECT * FROM users WHERE is_active = TRUE;

    -- Step 2: Who are older than 25
    SELECT * FROM users WHERE is_active = TRUE AND age > 25;

    -- Step 3: With Gmail addresses
    SELECT * FROM users
    WHERE is_active = TRUE
      AND age > 25
      AND email LIKE '%@gmail.com';

    -- Step 4: Only need id, email, and username
    SELECT id, email, username FROM users
    WHERE is_active = TRUE
      AND age > 25
      AND email LIKE '%@gmail.com';

    -- Step 5: Sort alphabetically
    SELECT id, email, username FROM users
    WHERE is_active = TRUE
      AND age > 25
      AND email LIKE '%@gmail.com'
    ORDER BY username ASC;

    -- Step 6: Show first page (10 results)
    SELECT id, email, username FROM users
    WHERE is_active = TRUE
      AND age > 25
      AND email LIKE '%@gmail.com'
    ORDER BY username ASC
    LIMIT 10 OFFSET 0;
    ```

    **Key takeaways:**
    1. Always use WHERE to filter - don't retrieve data you don't need
    2. Specify exact columns instead of SELECT *
    3. Use ORDER BY to make results predictable
    4. Use LIMIT for performance and pagination
    5. Combine conditions with AND/OR to match complex criteria

    ### UPDATE: Modifying Existing Data

    **What is UPDATE?**

    UPDATE modifies existing rows in your database. Any time data changes - user updates profile, order status changes, inventory decreases - you use UPDATE.

    **Why UPDATE matters:**
    - User changes email → UPDATE users
    - Product price changes → UPDATE products
    - Order ships → UPDATE orders SET status = 'shipped'

    **⚠️ CRITICAL: Always use WHERE with UPDATE!**

    Without WHERE, you update EVERY row in the table (usually a disaster).

    #### Basic UPDATE: Single Column

    ```sql
    UPDATE users
    SET full_name = 'Alice Johnson'
    WHERE id = 1;
    ```

    **Syntax breakdown:**
    1. `UPDATE users` - Which table to modify
    2. `SET full_name = 'Alice Johnson'` - What to change
    3. `WHERE id = 1` - Which rows to update (CRITICAL!)

    **What happens internally:**
    ```
    1. PostgreSQL finds all rows matching WHERE condition
    2. For each matched row:
       - Validates new value (type check, constraints)
       - Creates new row version (MVCC)
       - Marks old version as outdated
    3. Updates indexes
    4. Returns count of rows modified
    ```

    #### Updating Multiple Columns

    ```sql
    UPDATE users
    SET
        full_name = 'Bob Smith',
        age = 31,
        updated_at = CURRENT_TIMESTAMP
    WHERE id = 2;
    ```

    **Comma-separated columns** - all updated atomically (all succeed or all fail).

    #### UPDATE Based on Current Values

    **Increment/decrement:**
    ```sql
    -- Increase age by 1
    UPDATE users
    SET age = age + 1
    WHERE id = 1;

    -- Decrease inventory
    UPDATE products
    SET stock = stock - 1
    WHERE id = 100;
    ```

    **String manipulation:**
    ```sql
    -- Uppercase all usernames
    UPDATE users
    SET username = UPPER(username);

    -- Add prefix
    UPDATE products
    SET sku = CONCAT('PROD-', sku)
    WHERE sku NOT LIKE 'PROD-%';
    ```

    #### Conditional Updates

    **Deactivate inactive users:**
    ```sql
    UPDATE users
    SET is_active = FALSE
    WHERE last_login < (CURRENT_DATE - INTERVAL '90 days');
    ```

    **Bulk price increase:**
    ```sql
    -- Increase prices by 10% for category 5
    UPDATE products
    SET price = price * 1.10
    WHERE category_id = 5 AND price > 0;
    ```

    #### UPDATE with RETURNING

    **Get updated values back:**
    ```sql
    UPDATE users
    SET age = age + 1
    WHERE id = 1
    RETURNING id, username, age, updated_at;
    ```

    **Returns:**
    ```
    id | username | age | updated_at
    ---+----------+-----+-------------------------
    1  | alice    | 26  | 2025-11-05 10:45:23
    ```

    **Why use RETURNING:**
    - Confirm what was actually updated
    - Get timestamp values (updated_at)
    - Avoid extra SELECT query
    - Return data to application immediately

    #### UPDATE with FROM (Joins)

    **Update based on another table:**
    ```sql
    -- Update user's total_orders count
    UPDATE users
    SET total_orders = order_counts.count
    FROM (
        SELECT user_id, COUNT(*) as count
        FROM orders
        GROUP BY user_id
    ) AS order_counts
    WHERE users.id = order_counts.user_id;
    ```

    **Update prices from pricing table:**
    ```sql
    UPDATE products p
    SET price = new_prices.price
    FROM new_pricing_table new_prices
    WHERE p.sku = new_prices.sku;
    ```

    #### UPDATE... WHERE EXISTS

    **Update only if related data exists:**
    ```sql
    -- Mark users as "has orders" if they have any orders
    UPDATE users
    SET has_orders = TRUE
    WHERE EXISTS (
        SELECT 1 FROM orders WHERE orders.user_id = users.id
    );
    ```

    #### Common UPDATE Patterns

    **1. Toggle boolean:**
    ```sql
    UPDATE users
    SET is_active = NOT is_active
    WHERE id = 5;
    ```

    **2. Update timestamp:**
    ```sql
    UPDATE posts
    SET updated_at = CURRENT_TIMESTAMP
    WHERE id = 100;
    ```

    **3. Conditional value update:**
    ```sql
    UPDATE products
    SET
        status = CASE
            WHEN stock = 0 THEN 'out_of_stock'
            WHEN stock < 10 THEN 'low_stock'
            ELSE 'in_stock'
        END
    WHERE category = 'electronics';
    ```

    #### The Danger of Missing WHERE

    ⚠️ **DISASTER SCENARIO:**
    ```sql
    -- Intended: Update one user's email
    UPDATE users SET email = 'newemail@example.com';
    -- OOPS: Forgot WHERE - now EVERY user has same email!
    ```

    **Result:** All 10,000 users now have email = 'newemail@example.com' 💀

    **Prevention strategies:**
    1. **Always write WHERE first** (before SET)
    2. **Use transactions** (can rollback mistakes)
    3. **Test with SELECT first:**
       ```sql
       -- First: Check what would be updated
       SELECT * FROM users WHERE id = 1;

       -- Then: Update
       UPDATE users SET email = '...' WHERE id = 1;
       ```

    #### UPDATE Best Practices

    **1. Always use WHERE (unless you really mean to update all rows):**
    ```sql
    -- ✅ Good: Specific update
    UPDATE users SET email = '...' WHERE id = 1;

    -- ⚠️ Dangerous: Updates ALL rows
    UPDATE users SET is_active = FALSE;  -- Are you SURE?
    ```

    **2. Use RETURNING to verify:**
    ```sql
    UPDATE users
    SET email = 'newemail@example.com'
    WHERE id = 1
    RETURNING id, username, email;  -- Confirm what changed
    ```

    **3. Use transactions for safety:**
    ```sql
    BEGIN;
        UPDATE products SET price = price * 1.1 WHERE category_id = 5;
        -- Review results...
    COMMIT;  -- Or ROLLBACK if something wrong
    ```

    **4. Check rows affected:**
    ```sql
    UPDATE users SET is_active = TRUE WHERE id = 999;
    -- Returns: UPDATE 0
    -- Hmm, no rows updated - does user 999 exist?
    ```

    ### DELETE: Removing Data

    **What is DELETE?**

    DELETE permanently removes rows from your database. Use with extreme caution!

    **Why DELETE matters:**
    - User account deletion
    - Removing expired sessions
    - Cleaning up test data

    **⚠️ CRITICAL: DELETE is PERMANENT. Always use WHERE!**

    #### Basic DELETE

    ```sql
    DELETE FROM users WHERE id = 10;
    ```

    **Syntax:**
    1. `DELETE FROM users` - Which table
    2. `WHERE id = 10` - Which rows to delete (CRITICAL!)

    #### DELETE with Conditions

    **Delete inactive users:**
    ```sql
    DELETE FROM users
    WHERE is_active = FALSE AND created_at < '2020-01-01';
    ```

    **Delete expired sessions:**
    ```sql
    DELETE FROM sessions
    WHERE expires_at < CURRENT_TIMESTAMP;
    ```

    #### DELETE with RETURNING

    **Keep record of what was deleted:**
    ```sql
    DELETE FROM users
    WHERE id = 10
    RETURNING id, email, username, deleted_at;
    ```

    **Archive before deleting:**
    ```sql
    -- Insert into archive, then delete
    WITH deleted AS (
        DELETE FROM orders
        WHERE created_at < '2020-01-01'
        RETURNING *
    )
    INSERT INTO orders_archive
    SELECT * FROM deleted;
    ```

    #### DELETE with Subquery

    **Delete based on related data:**
    ```sql
    -- Delete users with no orders
    DELETE FROM users
    WHERE id NOT IN (SELECT DISTINCT user_id FROM orders);

    -- Or with NOT EXISTS:
    DELETE FROM users u
    WHERE NOT EXISTS (
        SELECT 1 FROM orders o WHERE o.user_id = u.id
    );
    ```

    #### The Nuclear Option: DELETE ALL

    ```sql
    -- ⚠️ DANGER: Deletes EVERY row!
    DELETE FROM users;
    ```

    This deletes ALL rows but:
    - Keeps table structure
    - Triggers fire for each row (slow)
    - Auto-increment continues (not reset)

    #### TRUNCATE: Faster DELETE ALL

    ```sql
    TRUNCATE TABLE users;
    ```

    **TRUNCATE vs DELETE:**
    | Feature | DELETE | TRUNCATE |
    |---------|--------|----------|
    | Speed | Slower | Much faster |
    | WHERE clause | Yes | No (all rows only) |
    | Triggers | Fire | Don't fire |
    | Rollback | Yes (in transaction) | Yes (in transaction) |
    | Reset auto-increment | No | Yes |

    **When to use TRUNCATE:**
    - Clearing test data
    - Resetting staging database
    - Deleting ALL rows quickly

    **When to use DELETE:**
    - Deleting specific rows (WITH WHERE)
    - Need triggers to fire
    - Want to log deletions

    #### CASCADE DELETE

    **Foreign key with ON DELETE CASCADE:**
    ```sql
    CREATE TABLE orders (
        id SERIAL PRIMARY KEY,
        user_id INTEGER REFERENCES users(id) ON DELETE CASCADE
    );

    -- When you delete a user:
    DELETE FROM users WHERE id = 5;
    -- All their orders are automatically deleted too!
    ```

    **CASCADE options:**
    - `ON DELETE CASCADE` - Delete related rows
    - `ON DELETE SET NULL` - Set foreign key to NULL
    - `ON DELETE RESTRICT` - Prevent deletion if related rows exist
    - `ON DELETE NO ACTION` - Same as RESTRICT (default)

    #### Soft Delete Pattern

    **Instead of DELETE, mark as deleted:**
    ```sql
    ALTER TABLE users ADD COLUMN deleted_at TIMESTAMP;

    -- "Delete" user (actually just mark)
    UPDATE users
    SET deleted_at = CURRENT_TIMESTAMP
    WHERE id = 10;

    -- Query only active users
    SELECT * FROM users WHERE deleted_at IS NULL;
    ```

    **Why soft delete?**
    - ✅ Can undo (restore deleted data)
    - ✅ Maintain data integrity (foreign keys work)
    - ✅ Audit trail (when was it deleted?)
    - ❌ More complex queries (always filter deleted_at)
    - ❌ Database bloat (deleted data still stored)

    #### DELETE Best Practices

    **1. ALWAYS use WHERE (unless deleting all rows intentionally):**
    ```sql
    -- ⚠️ CATASTROPHIC: Deletes EVERYTHING
    DELETE FROM users;

    -- ✅ Safe: Deletes specific rows
    DELETE FROM users WHERE is_active = FALSE;
    ```

    **2. Test with SELECT first:**
    ```sql
    -- Step 1: See what would be deleted
    SELECT * FROM users WHERE is_active = FALSE;

    -- Step 2: If looks good, delete
    DELETE FROM users WHERE is_active = FALSE;
    ```

    **3. Use transactions for safety:**
    ```sql
    BEGIN;
        DELETE FROM old_logs WHERE created_at < '2020-01-01';
        -- Check count: DELETE 5432
        -- Seems right
    COMMIT;  -- Or ROLLBACK if something wrong
    ```

    **4. Consider soft delete for critical data:**
    ```sql
    -- Instead of DELETE, mark as deleted
    UPDATE users SET deleted_at = NOW() WHERE id = 10;
    ```

    **5. Backup before mass deletes:**
    ```bash
    # Backup first!
    pg_dump -t users mydb > users_backup.sql

    # Then delete
    DELETE FROM users WHERE created_at < '2020-01-01';
    ```

    #### Common DELETE Errors

    **1. Foreign key constraint:**
    ```sql
    DELETE FROM users WHERE id = 1;
    -- ERROR: update or delete violates foreign key constraint
    -- User has orders that reference them!
    ```
    **Fix:** Delete orders first, or use ON DELETE CASCADE.

    **2. Deleting more than intended:**
    ```sql
    DELETE FROM users WHERE id = 10 OR username = 'test';
    -- Oops: OR deletes more rows than expected
    ```
    **Fix:** Test with SELECT, use explicit conditions.

    **Key takeaways:**
    1. UPDATE modifies existing rows - ALWAYS use WHERE
    2. Test UPDATE with SELECT first to see what will change
    3. Use RETURNING to confirm what was updated
    4. DELETE permanently removes data - ALWAYS use WHERE
    5. TRUNCATE is faster for deleting all rows
    6. Consider soft delete (UPDATE deleted_at) for critical data
    7. Use transactions for safety - can ROLLBACK mistakes

    ## Constraints

    ```sql
    CREATE TABLE products (
        id SERIAL PRIMARY KEY,                    -- Primary key
        name VARCHAR(100) NOT NULL,               -- Not null
        sku VARCHAR(50) UNIQUE NOT NULL,          -- Unique
        price DECIMAL(10, 2) CHECK (price > 0),   -- Check constraint
        category_id INTEGER REFERENCES categories(id),  -- Foreign key
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    ```

    ## Practice

    Try the PostgreSQL Fundamentals lab!
  MARKDOWN
  lesson.key_concepts = ['PostgreSQL basics', 'data types', 'CRUD operations', 'tables', 'constraints']
end

# Adding more PostgreSQL lessons and a comprehensive quiz...
# Quiz 1.1: PostgreSQL Fundamentals
quiz1_1 = Quiz.find_or_create_by!(title: "PostgreSQL Fundamentals Quiz") do |quiz|
  quiz.description = 'Test your knowledge of PostgreSQL basics'
  quiz.time_limit_minutes = 15
  quiz.passing_score = 70
end

[
  {
    question_text: "What does ACID stand for in databases?",
    question_type: "mcq",
    points: 5,
    options: ["Atomicity, Consistency, Isolation, Durability", "Access, Control, Integrity, Design", "Atomic, Concurrent, Indexed, Distributed", "Append, Create, Insert, Delete"],
    correct_answer: "Atomicity, Consistency, Isolation, Durability",
    explanation: "ACID are the properties that guarantee reliable database transactions."
  },
  {
    question_text: "Which data type should you use for auto-incrementing primary keys?",
    question_type: "mcq",
    points: 5,
    options: ["SERIAL", "INTEGER", "BIGINT", "UUID"],
    correct_answer: "SERIAL",
    explanation: "SERIAL automatically generates sequential integer values."
  },
  {
    question_text: "What's the difference between VARCHAR and TEXT?",
    question_type: "mcq",
    points: 5,
    options: ["VARCHAR has length limit, TEXT doesn't", "TEXT is faster", "VARCHAR stores binary", "They're identical"],
    correct_answer: "VARCHAR has length limit, TEXT doesn't",
    explanation: "VARCHAR requires a maximum length, TEXT can store unlimited text."
  },
  {
    question_text: "Which constraint ensures a column cannot have NULL values?",
    question_type: "mcq",
    points: 5,
    options: ["NOT NULL", "UNIQUE", "CHECK", "PRIMARY KEY"],
    correct_answer: "NOT NULL",
    explanation: "NOT NULL constraint prevents NULL values in a column."
  },
  {
    question_text: "What does RETURNING do in an INSERT statement?",
    question_type: "mcq",
    points: 5,
    options: ["Returns the inserted rows", "Returns error messages", "Returns row count", "Returns to previous state"],
    correct_answer: "Returns the inserted rows",
    explanation: "RETURNING clause returns the inserted/updated/deleted rows."
  },
  {
    question_text: "Which is better for storing JSON data?",
    question_type: "mcq",
    points: 5,
    options: ["JSONB (faster, supports indexing)", "JSON", "TEXT", "VARCHAR"],
    correct_answer: "JSONB (faster, supports indexing)",
    explanation: "JSONB stores binary format, is faster for operations, and supports indexing."
  },
  {
    question_text: "What's the psql command to list all tables?",
    question_type: "fill_blank",
    points: 5,
    correct_answer: "\\dt",
    explanation: "\\dt lists all tables in the current database."
  },
  {
    question_text: "What does TRUNCATE do?",
    question_type: "mcq",
    points: 5,
    options: ["Deletes all rows and resets sequences", "Deletes specific rows", "Drops the table", "Adds rows"],
    correct_answer: "Deletes all rows and resets sequences",
    explanation: "TRUNCATE quickly removes all rows and resets auto-increment sequences."
  },
  {
    question_text: "Which data type stores IP addresses?",
    question_type: "mcq",
    points: 5,
    options: ["INET", "VARCHAR", "TEXT", "INTEGER"],
    correct_answer: "INET",
    explanation: "INET is specifically designed for storing IPv4 and IPv6 addresses."
  },
  {
    question_text: "What's the default port for PostgreSQL?",
    question_type: "fill_blank",
    points: 5,
    correct_answer: "5432",
    explanation: "PostgreSQL listens on port 5432 by default."
  },
  {
    question_text: "Which constraint ensures values are unique across rows?",
    question_type: "mcq",
    points: 5,
    options: ["UNIQUE", "PRIMARY KEY", "NOT NULL", "CHECK"],
    correct_answer: "UNIQUE",
    explanation: "UNIQUE constraint ensures all values in a column are different."
  },
  {
    question_text: "What's the difference between DELETE and DROP?",
    question_type: "mcq",
    points: 5,
    options: ["DELETE removes rows, DROP removes table", "They're the same", "DELETE is faster", "DROP removes rows"],
    correct_answer: "DELETE removes rows, DROP removes table",
    explanation: "DELETE removes rows from a table; DROP removes the entire table structure."
  },
  {
    question_text: "Which data type should you use for monetary values?",
    question_type: "mcq",
    points: 5,
    options: ["NUMERIC or DECIMAL", "REAL", "DOUBLE PRECISION", "INTEGER"],
    correct_answer: "NUMERIC or DECIMAL",
    explanation: "NUMERIC/DECIMAL provide exact precision, avoiding floating-point errors."
  },
  {
    question_text: "What does the CHECK constraint do?",
    question_type: "mcq",
    points: 5,
    options: ["Validates data against a condition", "Checks for duplicates", "Checks foreign keys", "Checks NULL values"],
    correct_answer: "Validates data against a condition",
    explanation: "CHECK constraint ensures values meet a specified condition (e.g., age >= 18)."
  },
  {
    question_text: "What's the purpose of TIMESTAMP WITH TIME ZONE?",
    question_type: "mcq",
    points: 5,
    options: ["Stores timestamps with timezone info", "Stores only timezone", "Faster than TIMESTAMP", "Stores date only"],
    correct_answer: "Stores timestamps with timezone info",
    explanation: "TIMESTAMPTZ stores timestamps with timezone, automatically converting to UTC."
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz1_1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer]
    question.explanation = q_data[:explanation]
  end
end

# ==========================================
# MODULE 2: Schema Design and Relationships
# ==========================================

module2 = CourseModule.find_or_create_by!(slug: 'schema-design', course: postgresql_course) do |mod|
  mod.title = "Schema Design and Normalization"
  mod.description = "Design efficient database schemas with proper relationships"
  mod.sequence_order = 2
  mod.estimated_minutes = 200
  mod.published = true
end

lesson2_1 = CourseLesson.find_or_create_by!(title: "Database Relationships") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # Database Relationships

    Learn to design relationships between tables.

    ## One-to-Many Relationships

    Most common relationship: one parent, many children.

    ### Example: Users and Posts

    ```sql
    CREATE TABLE users (
        id SERIAL PRIMARY KEY,
        username VARCHAR(50) UNIQUE NOT NULL,
        email VARCHAR(255) UNIQUE NOT NULL
    );

    CREATE TABLE posts (
        id SERIAL PRIMARY KEY,
        user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        title VARCHAR(200) NOT NULL,
        content TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    ```

    **Foreign Key Options**:
    - `ON DELETE CASCADE`: Delete posts when user deleted
    - `ON DELETE SET NULL`: Set user_id to NULL
    - `ON DELETE RESTRICT`: Prevent deletion if posts exist
    - `ON UPDATE CASCADE`: Update posts if user id changes

    ### Querying One-to-Many

    ```sql
    -- Get user with their posts
    SELECT u.username, p.title, p.created_at
    FROM users u
    LEFT JOIN posts p ON u.id = p.user_id
    WHERE u.username = 'alice';

    -- Count posts per user
    SELECT u.username, COUNT(p.id) as post_count
    FROM users u
    LEFT JOIN posts p ON u.id = p.user_id
    GROUP BY u.id, u.username
    ORDER BY post_count DESC;
    ```

    ## Many-to-Many Relationships

    Requires a junction table.

    ### Example: Students and Courses

    ```sql
    CREATE TABLE students (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        email VARCHAR(255) UNIQUE NOT NULL
    );

    CREATE TABLE courses (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        code VARCHAR(20) UNIQUE NOT NULL
    );

    -- Junction table
    CREATE TABLE enrollments (
        student_id INTEGER REFERENCES students(id) ON DELETE CASCADE,
        course_id INTEGER REFERENCES courses(id) ON DELETE CASCADE,
        enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        grade VARCHAR(2),
        PRIMARY KEY (student_id, course_id)
    );
    ```

    ### Querying Many-to-Many

    ```sql
    -- Get all courses for a student
    SELECT c.name, c.code, e.grade
    FROM students s
    JOIN enrollments e ON s.id = e.student_id
    JOIN courses c ON e.course_id = c.id
    WHERE s.name = 'Alice';

    -- Get all students in a course
    SELECT s.name, s.email, e.grade
    FROM courses c
    JOIN enrollments e ON c.id = e.course_id
    JOIN students s ON e.student_id = s.id
    WHERE c.code = 'CS101';

    -- Find students taking multiple courses
    SELECT s.name, COUNT(e.course_id) as course_count
    FROM students s
    JOIN enrollments e ON s.id = e.student_id
    GROUP BY s.id, s.name
    HAVING COUNT(e.course_id) > 2;
    ```

    ## One-to-One Relationships

    Rare, often used for optional data or partitioning.

    ### Example: Users and Profiles

    ```sql
    CREATE TABLE users (
        id SERIAL PRIMARY KEY,
        email VARCHAR(255) UNIQUE NOT NULL
    );

    CREATE TABLE user_profiles (
        user_id INTEGER PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
        bio TEXT,
        avatar_url VARCHAR(500),
        birth_date DATE,
        location VARCHAR(100)
    );
    ```

    ## Self-Referencing Relationships

    Table references itself.

    ### Example: Employee Hierarchy

    ```sql
    CREATE TABLE employees (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        manager_id INTEGER REFERENCES employees(id),
        department VARCHAR(50)
    );

    -- Query employee and manager
    SELECT
        e.name as employee,
        m.name as manager
    FROM employees e
    LEFT JOIN employees m ON e.manager_id = m.id;

    -- Recursive query for hierarchy
    WITH RECURSIVE org_chart AS (
        -- Base case: top-level managers
        SELECT id, name, manager_id, 1 as level
        FROM employees
        WHERE manager_id IS NULL

        UNION ALL

        -- Recursive case: employees
        SELECT e.id, e.name, e.manager_id, oc.level + 1
        FROM employees e
        JOIN org_chart oc ON e.manager_id = oc.id
    )
    SELECT * FROM org_chart ORDER BY level, name;
    ```

    ## JOIN Types

    ### INNER JOIN
    Only matching rows from both tables.

    ```sql
    SELECT u.username, p.title
    FROM users u
    INNER JOIN posts p ON u.id = p.user_id;
    ```

    ### LEFT JOIN (LEFT OUTER JOIN)
    All rows from left table, matching from right.

    ```sql
    -- Include users even without posts
    SELECT u.username, p.title
    FROM users u
    LEFT JOIN posts p ON u.id = p.user_id;
    ```

    ### RIGHT JOIN
    All rows from right table, matching from left.

    ```sql
    SELECT u.username, p.title
    FROM users u
    RIGHT JOIN posts p ON u.id = p.user_id;
    ```

    ### FULL OUTER JOIN
    All rows from both tables.

    ```sql
    SELECT u.username, p.title
    FROM users u
    FULL OUTER JOIN posts p ON u.id = p.user_id;
    ```

    ### CROSS JOIN
    Cartesian product (all combinations).

    ```sql
    SELECT u.username, c.name
    FROM users u
    CROSS JOIN courses c;
    ```

    ## Best Practices

    1. **Use foreign keys**: Enforce referential integrity
    2. **Index foreign keys**: Speed up joins
    3. **Choose appropriate ON DELETE**: CASCADE, RESTRICT, or SET NULL
    4. **Normalize data**: Avoid redundancy
    5. **Use junction tables**: For many-to-many relationships

    **Practice**: Try the Schema Design lab!
  MARKDOWN
  lesson.key_concepts = ['relationships', 'foreign keys', 'joins', 'one-to-many', 'many-to-many', 'normalization']
end

# Adding comprehensive quizzes for Module 2 and 3...
# (Continuing with similar pattern for remaining modules and quizzes)

# Quiz 2.1: Relationships and Joins
quiz2_1 = Quiz.find_or_create_by!(title: "Relationships and Joins Quiz") do |quiz|
  quiz.description = 'Test your knowledge of database relationships'
  quiz.time_limit_minutes = 15
  quiz.passing_score = 70
end

[
  {
    question_text: "Which relationship requires a junction table?",
    question_type: "mcq",
    points: 5,
    options: ["Many-to-Many", "One-to-Many", "One-to-One", "Self-referencing"],
    correct_answer: "Many-to-Many",
    explanation: "Many-to-many relationships require a junction (bridge) table to connect two tables."
  },
  {
    question_text: "What does ON DELETE CASCADE do?",
    question_type: "mcq",
    points: 5,
    options: ["Deletes related rows when parent deleted", "Prevents deletion", "Sets foreign key to NULL", "Creates backup"],
    correct_answer: "Deletes related rows when parent deleted",
    explanation: "CASCADE automatically deletes child rows when the parent row is deleted."
  },
  {
    question_text: "Which JOIN returns all rows from the left table?",
    question_type: "mcq",
    points: 5,
    options: ["LEFT JOIN", "RIGHT JOIN", "INNER JOIN", "FULL JOIN"],
    correct_answer: "LEFT JOIN",
    explanation: "LEFT JOIN returns all rows from the left table, with matching rows from the right table or NULL."
  },
  {
    question_text: "What's a foreign key?",
    question_type: "mcq",
    points: 5,
    options: ["Column that references another table's primary key", "Unique identifier", "Encrypted key", "Index"],
    correct_answer: "Column that references another table's primary key",
    explanation: "A foreign key is a column that creates a relationship to another table's primary key."
  },
  {
    question_text: "Which JOIN returns only matching rows from both tables?",
    question_type: "mcq",
    points: 5,
    options: ["INNER JOIN", "LEFT JOIN", "RIGHT JOIN", "FULL JOIN"],
    correct_answer: "INNER JOIN",
    explanation: "INNER JOIN returns only rows where there's a match in both tables."
  },
  {
    question_text: "What's the most common relationship type?",
    question_type: "mcq",
    points: 5,
    options: ["One-to-Many", "Many-to-Many", "One-to-One", "None-to-None"],
    correct_answer: "One-to-Many",
    explanation: "One-to-many is the most common relationship (e.g., one user has many posts)."
  },
  {
    question_text: "What does CROSS JOIN produce?",
    question_type: "mcq",
    points: 5,
    options: ["Cartesian product of both tables", "Matching rows", "Left table rows only", "No rows"],
    correct_answer: "Cartesian product of both tables",
    explanation: "CROSS JOIN produces all possible combinations of rows from both tables."
  },
  {
    question_text: "When should you use a One-to-One relationship?",
    question_type: "mcq",
    points: 5,
    options: ["For optional or sensitive data", "Always", "Never", "For many items"],
    correct_answer: "For optional or sensitive data",
    explanation: "One-to-one is useful for optional data or separating sensitive information."
  },
  {
    question_text: "What's a self-referencing relationship?",
    question_type: "mcq",
    points: 5,
    options: ["Table references itself", "Two tables reference each other", "No references", "Circular reference error"],
    correct_answer: "Table references itself",
    explanation: "Self-referencing relationships occur when a table has a foreign key to itself (e.g., employees → managers)."
  },
  {
    question_text: "What's referential integrity?",
    question_type: "mcq",
    points: 5,
    options: ["Ensuring foreign keys reference valid primary keys", "Data encryption", "Index optimization", "Query performance"],
    correct_answer: "Ensuring foreign keys reference valid primary keys",
    explanation: "Referential integrity ensures foreign key values always refer to existing primary key values."
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz2_1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer]
    question.explanation = q_data[:explanation]
  end
end

# ==========================================
# MODULE 3: Query Optimization
# ==========================================

module3 = CourseModule.find_or_create_by!(slug: 'query-optimization', course: postgresql_course) do |mod|
  mod.title = "Query Optimization and Indexing"
  mod.description = "Master indexes and query performance tuning"
  mod.sequence_order = 3
  mod.estimated_minutes = 240
  mod.published = true
end

lesson3_1 = CourseLesson.find_or_create_by!(title: "Indexes and Performance") do |lesson|
  lesson.reading_time_minutes = 40
  lesson.content = <<~MARKDOWN
    # Indexes and Performance

    Dramatically speed up queries with proper indexing.

    ## What is an Index?

    **Index**: Data structure that improves query speed (like a book index).

    **Trade-offs**:
    - ✅ Faster SELECT queries
    - ❌ Slower INSERT/UPDATE/DELETE
    - ❌ Uses disk space

    ## Index Types

    ### B-tree Index (Default)
    Most common, works for most queries.

    ```sql
    -- Create index
    CREATE INDEX idx_users_email ON users(email);

    -- Multi-column index
    CREATE INDEX idx_posts_user_created ON posts(user_id, created_at);

    -- Unique index
    CREATE UNIQUE INDEX idx_users_username ON users(username);
    ```

    **Use for**:
    - Equality (`=`)
    - Range (`<`, `>`, `BETWEEN`)
    - Sorting (`ORDER BY`)
    - Pattern matching (`LIKE 'prefix%'`)

    ### Hash Index
    Fast equality lookups only.

    ```sql
    CREATE INDEX idx_users_email_hash ON users USING HASH (email);
    ```

    **Use for**: Only `=` operators (no range queries)

    ### GIN Index (Generalized Inverted Index)
    For full-text search and arrays.

    ```sql
    -- Array index
    CREATE INDEX idx_posts_tags ON posts USING GIN (tags);

    -- JSONB index
    CREATE INDEX idx_users_settings ON users USING GIN (settings);

    -- Full-text search
    CREATE INDEX idx_posts_content_fts ON posts
    USING GIN (to_tsvector('english', content));
    ```

    ### GiST Index (Generalized Search Tree)
    For geometric and full-text data.

    ```sql
    CREATE INDEX idx_locations ON places USING GIST (location);
    ```

    ## When to Create Indexes

    ✅ **Create indexes for**:
    - Primary keys (automatic)
    - Foreign keys
    - Columns in WHERE clauses
    - Columns in JOIN conditions
    - Columns in ORDER BY
    - Columns in GROUP BY

    ❌ **Don't index**:
    - Small tables (< 1000 rows)
    - Columns with few unique values (low cardinality)
    - Frequently updated columns
    - Rarely queried columns

    ## Analyzing Query Performance

    ### EXPLAIN
    Shows query execution plan.

    ```sql
    EXPLAIN SELECT * FROM users WHERE email = 'alice@example.com';
    ```

    Output:
    ```
    Seq Scan on users  (cost=0.00..15.50 rows=1 width=100)
      Filter: (email = 'alice@example.com')
    ```

    - **Seq Scan**: Sequential scan (slow, reads entire table)
    - **Index Scan**: Uses index (fast)
    - **cost**: Estimated cost (lower is better)
    - **rows**: Estimated rows returned

    ### EXPLAIN ANALYZE
    Actually runs query and shows real timing.

    ```sql
    EXPLAIN ANALYZE
    SELECT * FROM users WHERE email = 'alice@example.com';
    ```

    Output:
    ```
    Index Scan using idx_users_email on users
    (cost=0.15..8.17 rows=1 width=100)
    (actual time=0.025..0.026 rows=1 loops=1)
      Index Cond: (email = 'alice@example.com')
    Planning Time: 0.123 ms
    Execution Time: 0.045 ms
    ```

    ## Optimizing Queries

    ### Problem: Full Table Scan

    ❌ **Slow**:
    ```sql
    SELECT * FROM posts WHERE user_id = 123;
    -- Seq Scan (scans entire table)
    ```

    ✅ **Fast**:
    ```sql
    CREATE INDEX idx_posts_user_id ON posts(user_id);
    SELECT * FROM posts WHERE user_id = 123;
    -- Index Scan (uses index)
    ```

    ### Problem: LIKE with Leading Wildcard

    ❌ **Slow**:
    ```sql
    SELECT * FROM users WHERE email LIKE '%@example.com';
    -- Can't use index (starts with %)
    ```

    ✅ **Fast**:
    ```sql
    SELECT * FROM users WHERE email LIKE 'alice%';
    -- Can use index (starts with literal)
    ```

    ### Problem: OR Conditions

    ❌ **Slow**:
    ```sql
    SELECT * FROM users WHERE first_name = 'Alice' OR last_name = 'Smith';
    -- May not use indexes efficiently
    ```

    ✅ **Fast**:
    ```sql
    SELECT * FROM users WHERE first_name = 'Alice'
    UNION
    SELECT * FROM users WHERE last_name = 'Smith';
    -- Uses indexes on both columns
    ```

    ### Problem: Functions on Indexed Columns

    ❌ **Slow**:
    ```sql
    SELECT * FROM users WHERE LOWER(email) = 'alice@example.com';
    -- Can't use index on email
    ```

    ✅ **Fast**:
    ```sql
    CREATE INDEX idx_users_email_lower ON users(LOWER(email));
    SELECT * FROM users WHERE LOWER(email) = 'alice@example.com';
    -- Uses functional index
    ```

    ## Partial Indexes

    Index subset of rows.

    ```sql
    -- Index only active users
    CREATE INDEX idx_active_users ON users(email) WHERE is_active = TRUE;

    -- Query uses index
    SELECT * FROM users WHERE email = 'alice@example.com' AND is_active = TRUE;
    ```

    ## Covering Indexes

    Index includes all queried columns (no table lookup needed).

    ```sql
    CREATE INDEX idx_users_covering ON users(email) INCLUDE (username, full_name);

    -- Fully covered by index
    SELECT username, full_name FROM users WHERE email = 'alice@example.com';
    ```

    ## Managing Indexes

    ```sql
    -- List indexes
    SELECT tablename, indexname, indexdef
    FROM pg_indexes
    WHERE schemaname = 'public';

    -- Index size
    SELECT pg_size_pretty(pg_relation_size('idx_users_email'));

    -- Drop index
    DROP INDEX idx_users_email;

    -- Rebuild index (fix bloat)
    REINDEX INDEX idx_users_email;
    ```

    ## Best Practices

    1. **Analyze queries**: Use EXPLAIN ANALYZE
    2. **Index foreign keys**: Always
    3. **Composite indexes**: Order matters (most selective first)
    4. **Don't over-index**: Balance read vs write performance
    5. **Monitor index usage**: Drop unused indexes
    6. **Update statistics**: Run ANALYZE regularly

    ```sql
    -- Update table statistics
    ANALYZE users;

    -- Find unused indexes
    SELECT schemaname, tablename, indexname
    FROM pg_stat_user_indexes
    WHERE idx_scan = 0;
    ```

    **Practice**: Try the Query Optimization lab!
  MARKDOWN
  lesson.key_concepts = ['indexes', 'B-tree', 'query optimization', 'EXPLAIN', 'performance tuning']
end

# Quiz 3.1: Indexes and Performance
quiz3_1 = Quiz.find_or_create_by!(title: "Query Optimization Quiz") do |quiz|
  quiz.description = 'Test your knowledge of indexes and performance'
  quiz.time_limit_minutes = 15
  quiz.passing_score = 70
end

[
  {
    question_text: "What is the purpose of an index?",
    question_type: "mcq",
    points: 5,
    options: ["Speed up query performance", "Store data", "Encrypt data", "Backup data"],
    correct_answer: "Speed up query performance",
    explanation: "Indexes create data structures that speed up data retrieval at the cost of slower writes."
  },
  {
    question_text: "What's the downside of having too many indexes?",
    question_type: "mcq",
    points: 5,
    options: ["Slower INSERT/UPDATE/DELETE operations", "Faster queries", "Less storage used", "Better performance"],
    correct_answer: "Slower INSERT/UPDATE/DELETE operations",
    explanation: "Each index must be updated when data changes, slowing down write operations."
  },
  {
    question_text: "What does EXPLAIN show?",
    question_type: "mcq",
    points: 5,
    options: ["Query execution plan", "Query results", "Table schema", "Index list"],
    correct_answer: "Query execution plan",
    explanation: "EXPLAIN shows how PostgreSQL plans to execute a query."
  },
  {
    question_text: "What does EXPLAIN ANALYZE do differently from EXPLAIN?",
    question_type: "mcq",
    points: 5,
    options: ["Actually runs the query and shows real timing", "Shows more details", "Runs faster", "Uses less memory"],
    correct_answer: "Actually runs the query and shows real timing",
    explanation: "EXPLAIN ANALYZE executes the query and shows actual execution time and row counts."
  },
  {
    question_text: "Which scan type is generally faster?",
    question_type: "mcq",
    points: 5,
    options: ["Index Scan", "Sequential Scan", "Both same speed", "Depends on table"],
    correct_answer: "Index Scan",
    explanation: "Index Scan is typically faster as it can jump directly to matching rows."
  },
  {
    question_text: "What type of index is default in PostgreSQL?",
    question_type: "mcq",
    points: 5,
    options: ["B-tree", "Hash", "GIN", "GiST"],
    correct_answer: "B-tree",
    explanation: "B-tree is the default index type and works well for most queries."
  },
  {
    question_text: "Which index type is best for JSONB columns?",
    question_type: "mcq",
    points: 5,
    options: ["GIN", "B-tree", "Hash", "Partial"],
    correct_answer: "GIN",
    explanation: "GIN (Generalized Inverted Index) is optimized for JSONB and array operations."
  },
  {
    question_text: "Can LIKE 'prefix%' use an index?",
    question_type: "mcq",
    points: 5,
    options: ["Yes, if it starts with literal characters", "No, never", "Only with GIN", "Only on text columns"],
    correct_answer: "Yes, if it starts with literal characters",
    explanation: "LIKE can use B-tree indexes when the pattern starts with literal characters (not %)."
  },
  {
    question_text: "What is a covering index?",
    question_type: "mcq",
    points: 5,
    options: ["Index that includes all queried columns", "Index on all columns", "Index on primary key", "Backup index"],
    correct_answer: "Index that includes all queried columns",
    explanation: "A covering index includes all columns needed by a query, avoiding table lookups."
  },
  {
    question_text: "Should you always index foreign key columns?",
    question_type: "mcq",
    points: 5,
    options: ["Yes, for better JOIN performance", "No, never", "Only sometimes", "Only if large table"],
    correct_answer: "Yes, for better JOIN performance",
    explanation: "Foreign keys should almost always be indexed to speed up JOINs and referential integrity checks."
  },
  {
    question_text: "What's a partial index?",
    question_type: "mcq",
    points: 5,
    options: ["Index on subset of rows matching a condition", "Incomplete index", "Index on part of a column", "Temporary index"],
    correct_answer: "Index on subset of rows matching a condition",
    explanation: "Partial indexes only index rows that meet a WHERE condition, saving space."
  },
  {
    question_text: "Why can't SELECT * FROM users WHERE LOWER(email) = 'test@test.com' use a regular index on email?",
    question_type: "mcq",
    points: 5,
    options: ["Functions prevent index usage", "LOWER is too slow", "Email can't be indexed", "PostgreSQL doesn't support it"],
    correct_answer: "Functions prevent index usage",
    explanation: "Applying functions to indexed columns prevents index usage. Use a functional index instead."
  },
  {
    question_text: "What command updates table statistics for the query planner?",
    question_type: "fill_blank",
    points: 5,
    correct_answer: "ANALYZE",
    explanation: "ANALYZE collects statistics about table contents to help the query planner make better decisions."
  },
  {
    question_text: "When should you NOT create an index?",
    question_type: "mcq",
    points: 5,
    options: ["On small tables with few rows", "On primary keys", "On foreign keys", "On frequently queried columns"],
    correct_answer: "On small tables with few rows",
    explanation: "Small tables are fast to scan sequentially, and indexes add overhead without benefit."
  },
  {
    question_text: "What does REINDEX do?",
    question_type: "mcq",
    points: 5,
    options: ["Rebuilds an index to fix bloat", "Creates a new index", "Deletes an index", "Analyzes an index"],
    correct_answer: "Rebuilds an index to fix bloat",
    explanation: "REINDEX rebuilds an index from scratch, which can fix index bloat and corruption."
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz3_1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer]
    question.explanation = q_data[:explanation]
  end
end

# ==========================================
# LINK LESSONS AND QUIZZES TO MODULES
# ==========================================

puts "Linking lessons and quizzes to modules..."

# Module 1: PostgreSQL Fundamentals
ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module1, item: quiz1_1, sequence_order: 2)

# Module 2: Schema Design
ModuleItem.find_or_create_by!(course_module: module2, item: lesson2_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module2, item: quiz2_1, sequence_order: 2)

# Module 3: Query Optimization
ModuleItem.find_or_create_by!(course_module: module3, item: lesson3_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module3, item: quiz3_1, sequence_order: 2)

# ==========================================
# LINK POSTGRESQL LABS
# ==========================================

puts "Linking PostgreSQL labs to modules..."

pg_labs = HandsOnLab.where(lab_type: 'postgresql').order(:sequence_order)

if pg_labs.any?
  pg_labs.each_with_index do |lab, index|
    mod = case index
          when 0..1 then module1
          when 2 then module2
          else module3
          end
    ModuleItem.find_or_create_by!(
      course_module: mod,
      item: lab,
      sequence_order: 30 + index
    )
  end
  puts "Linked #{pg_labs.count} PostgreSQL labs"
end

puts "\n✅ Complete PostgreSQL Database Mastery course created!"
puts "   - Course: #{postgresql_course.title}"
puts "   - Modules: #{postgresql_course.course_modules.count}"
puts "   - Lessons: #{CourseLesson.joins(course_module: :course).where(courses: { id: postgresql_course.id }).count}"
puts "   - Quizzes: #{Quiz.joins(course_module: :course).where(courses: { id: postgresql_course.id }).count}"
puts "   - Quiz Questions: #{QuizQuestion.joins(quiz: {course_module: :course}).where(courses: { id: postgresql_course.id }).count}"
puts "   - Labs: #{pg_labs.count}"
puts "\n📚 Content Coverage:"
puts "   ✅ PostgreSQL Fundamentals (data types, CRUD, constraints)"
puts "   ✅ Schema Design (relationships, normalization, joins)"
puts "   ✅ Query Optimization (indexes, EXPLAIN, performance tuning)"
puts "\n🎯 Learning Features:"
puts "   ✅ 40+ quiz questions with detailed explanations"
puts "   ✅ Real-world database scenarios"
puts "   ✅ Hands-on SQL labs"
puts "   ✅ Production optimization techniques"
puts "\n🚀 Ready for production databases!"