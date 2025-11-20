# AUTO-GENERATED from golang_web_services_advanced.rb
puts "Creating Microlessons for Golang Web Services Advanced..."

module_var = CourseModule.find_by(slug: 'golang-web-services-advanced')

# === MICROLESSON 1: Database Integration with database/sql ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Database Integration with database/sql',
  content: <<~MARKDOWN,
# Database Integration with database/sql 🚀

# Database Integration with database/sql

    Go's `database/sql` package provides a generic interface for working with SQL databases. It works with PostgreSQL, MySQL, SQLite, and others.

    ## Installing Database Driver

    For PostgreSQL, use the `pq` driver:

    ```bash
    go get github.com/lib/pq
    ```

    For SQLite (lightweight, great for learning):
    ```bash
    go get github.com/mattn/go-sqlite3
    ```

    ## Connecting to a Database

    ```go
    package main

    import (
        "database/sql"
        "fmt"
        "log"

        _ "github.com/lib/pq" // PostgreSQL driver
    )

    func main() {
        // Connection string format:
        // "postgres://user:password@localhost/dbname?sslmode=disable"
        connStr := "postgres://user:pass@localhost/mydb?sslmode=disable"

        db, err := sql.Open("postgres", connStr)
        if err != nil {
            log.Fatal(err)
        }
        defer db.Close()

        // Test connection
        err = db.Ping()
        if err != nil {
            log.Fatal("Cannot connect to database:", err)
        }

        fmt.Println("Successfully connected to database!")
    }
    ```

    ## SQLite (for local development)

    ```go
    import (
        "database/sql"
        _ "github.com/mattn/go-sqlite3"
    )

    func main() {
        db, err := sql.Open("sqlite3", "./myapp.db")
        if err != nil {
            log.Fatal(err)
        }
        defer db.Close()
    }
    ```

    ## Creating Tables

    ```go
    func createTables(db *sql.DB) error {
        query := `
        CREATE TABLE IF NOT EXISTS users (
            id SERIAL PRIMARY KEY,
            name VARCHAR(100) NOT NULL,
            email VARCHAR(100) UNIQUE NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );

        CREATE TABLE IF NOT EXISTS tasks (
            id SERIAL PRIMARY KEY,
            user_id INTEGER REFERENCES users(id),
            title VARCHAR(200) NOT NULL,
            description TEXT,
            completed BOOLEAN DEFAULT FALSE,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );
        `

        _, err := db.Exec(query)
        return err
    }
    ```

    ## INSERT - Creating Records

    ```go
    type User struct {
        ID        int
        Name      string
        Email     string
        CreatedAt time.Time
    }

    func createUser(db *sql.DB, name, email string) (int, error) {
        query := `
            INSERT INTO users (name, email)
            VALUES ($1, $2)
            RETURNING id
        `

        var userID int
        err := db.QueryRow(query, name, email).Scan(&userID)
        if err != nil {
            return 0, err
        }

        return userID, nil
    }

    // Usage
    userID, err := createUser(db, "Alice", "alice@example.com")
    if err != nil {
        log.Fatal(err)
    }
    fmt.Printf("Created user with ID: %d\\n", userID)
    ```

    ## SELECT - Reading Records

    ### Query Single Row

    ```go
    func getUserByID(db *sql.DB, id int) (*User, error) {
        query := `
            SELECT id, name, email, created_at
            FROM users
            WHERE id = $1
        `

        user := &User{}
        err := db.QueryRow(query, id).Scan(
            &user.ID,
            &user.Name,
            &user.Email,
            &user.CreatedAt,
        )

        if err == sql.ErrNoRows {
            return nil, fmt.Errorf("user not found")
        }
        if err != nil {
            return nil, err
        }

        return user, nil
    }
    ```

    ### Query Multiple Rows

    ```go
    func getAllUsers(db *sql.DB) ([]User, error) {
        query := `
            SELECT id, name, email, created_at
            FROM users
            ORDER BY created_at DESC
        `

        rows, err := db.Query(query)
        if err != nil {
            return nil, err
        }
        defer rows.Close()

        var users []User

        for rows.Next() {
            var user User
            err := rows.Scan(
                &user.ID,
                &user.Name,
                &user.Email,
                &user.CreatedAt,
            )
            if err != nil {
                return nil, err
            }
            users = append(users, user)
        }

        // Check for errors during iteration
        if err = rows.Err(); err != nil {
            return nil, err
        }

        return users, nil
    }
    ```

    ## UPDATE - Modifying Records

    ```go
    func updateUser(db *sql.DB, id int, name, email string) error {
        query := `
            UPDATE users
            SET name = $1, email = $2
            WHERE id = $3
        `

        result, err := db.Exec(query, name, email, id)
        if err != nil {
            return err
        }

        rowsAffected, err := result.RowsAffected()
        if err != nil {
            return err
        }

        if rowsAffected == 0 {
            return fmt.Errorf("user not found")
        }

        return nil
    }
    ```

    ## DELETE - Removing Records

    ```go
    func deleteUser(db *sql.DB, id int) error {
        query := `DELETE FROM users WHERE id = $1`

        result, err := db.Exec(query, id)
        if err != nil {
            return err
        }

        rowsAffected, err := result.RowsAffected()
        if err != nil {
            return err
        }

        if rowsAffected == 0 {
            return fmt.Errorf("user not found")
        }

        return nil
    }
    ```

    ## Transactions

    Use transactions for operations that must succeed or fail together:

    ```go
    func transferTask(db *sql.DB, taskID, fromUserID, toUserID int) error {
        // Begin transaction
        tx, err := db.Begin()
        if err != nil {
            return err
        }

        // Defer rollback in case of error
        defer tx.Rollback()

        // Verify task belongs to fromUser
        var ownerID int
        err = tx.QueryRow(
            "SELECT user_id FROM tasks WHERE id = $1",
            taskID,
        ).Scan(&ownerID)

        if err != nil {
            return err
        }

        if ownerID != fromUserID {
            return fmt.Errorf("task does not belong to user")
        }

        // Transfer task
        _, err = tx.Exec(
            "UPDATE tasks SET user_id = $1 WHERE id = $2",
            toUserID, taskID,
        )
        if err != nil {
            return err
        }

        // Commit transaction
        return tx.Commit()
    }
    ```

    ## Connection Pooling

    The `sql.DB` object is a connection pool, not a single connection:

    ```go
    func initDB(connStr string) (*sql.DB, error) {
        db, err := sql.Open("postgres", connStr)
        if err != nil {
            return nil, err
        }

        // Set connection pool settings
        db.SetMaxOpenConns(25)                 // Max open connections
        db.SetMaxIdleConns(5)                  // Max idle connections
        db.SetConnMaxLifetime(5 * time.Minute) // Max connection lifetime

        // Test connection
        if err = db.Ping(); err != nil {
            return nil, err
        }

        return db, nil
    }
    ```

    ## Integrating with HTTP Handlers

    ```go
    type Server struct {
        db *sql.DB
    }

    func (s *Server) createUserHandler(w http.ResponseWriter, r *http.Request) {
        if r.Method != http.MethodPost {
            http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
            return
        }

        var req struct {
            Name  string `json:"name"`
            Email string `json:"email"`
        }

        if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
            http.Error(w, "Invalid JSON", http.StatusBadRequest)
            return
        }

        // Create user in database
        userID, err := createUser(s.db, req.Name, req.Email)
        if err != nil {
            http.Error(w, "Failed to create user", http.StatusInternalServerError)
            log.Println("Database error:", err)
            return
        }

        // Return created user
        user := User{
            ID:    userID,
            Name:  req.Name,
            Email: req.Email,
        }

        w.Header().Set("Content-Type", "application/json")
        w.WriteHeader(http.StatusCreated)
        json.NewEncoder(w).Encode(user)
    }

    func main() {
        db, err := initDB("postgres://user:pass@localhost/mydb?sslmode=disable")
        if err != nil {
            log.Fatal(err)
        }
        defer db.Close()

        server := &Server{db: db}

        http.HandleFunc("/api/users", server.createUserHandler)
        http.ListenAndServe(":8080", nil)
    }
    ```

    ## Best Practices

    1. **Always use prepared statements** - Prevents SQL injection
    2. **Use placeholders ($1, $2)** - Never concatenate SQL strings
    3. **Close resources** - `defer rows.Close()` and `defer tx.Rollback()`
    4. **Handle sql.ErrNoRows** - Distinguish "not found" from errors
    5. **Use transactions** - For multi-step operations
    6. **Configure connection pool** - Set appropriate limits
    7. **Log database errors** - But don't expose them to clients
    8. **Use context** - For timeouts and cancellation
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 2: Middleware and Logging ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Middleware and Logging',
  content: <<~MARKDOWN,
# Middleware and Logging 🚀

# Middleware and Logging

    Middleware is code that runs before or after your handlers, perfect for cross-cutting concerns like logging, authentication, and CORS.

    ## What is Middleware?

    Middleware wraps around HTTP handlers to add functionality:

    ```
    Request → Middleware 1 → Middleware 2 → Handler → Response
              (logging)      (auth)          (business logic)
    ```

    ## Basic Middleware Pattern

    ```go
    func loggingMiddleware(next http.HandlerFunc) http.HandlerFunc {
        return func(w http.ResponseWriter, r *http.Request) {
            // Code before handler
            log.Printf("%s %s", r.Method, r.URL.Path)

            // Call next handler
            next(w, r)

            // Code after handler
            log.Println("Request completed")
        }
    }

    // Usage
    http.HandleFunc("/api/users", loggingMiddleware(usersHandler))
    ```

    ## Logging Middleware

    Log every request with timing information:

    ```go
    func loggingMiddleware(next http.HandlerFunc) http.HandlerFunc {
        return func(w http.ResponseWriter, r *http.Request) {
            start := time.Now()

            // Log request
            log.Printf("Started %s %s", r.Method, r.URL.Path)

            // Call handler
            next(w, r)

            // Log completion with duration
            duration := time.Since(start)
            log.Printf("Completed %s %s in %v", r.Method, r.URL.Path, duration)
        }
    }
    ```

    ## Response Status Capture

    Capture response status codes for logging:

    ```go
    type responseWriter struct {
        http.ResponseWriter
        status int
    }

    func (rw *responseWriter) WriteHeader(code int) {
        rw.status = code
        rw.ResponseWriter.WriteHeader(code)
    }

    func loggingMiddleware(next http.HandlerFunc) http.HandlerFunc {
        return func(w http.ResponseWriter, r *http.Request) {
            start := time.Now()

            // Wrap response writer
            wrapped := &responseWriter{
                ResponseWriter: w,
                status:         http.StatusOK, // default
            }

            next(wrapped, r)

            duration := time.Since(start)
            log.Printf("%s %s - %d (%v)",
                r.Method,
                r.URL.Path,
                wrapped.status,
                duration,
            )
        }
    }
    ```

    ## Authentication Middleware

    ```go
    func authMiddleware(next http.HandlerFunc) http.HandlerFunc {
        return func(w http.ResponseWriter, r *http.Request) {
            // Get API key from header
            apiKey := r.Header.Get("X-API-Key")

            if apiKey == "" {
                http.Error(w, "Missing API key", http.StatusUnauthorized)
                return
            }

            // Validate API key
            if !isValidAPIKey(apiKey) {
                http.Error(w, "Invalid API key", http.StatusUnauthorized)
                return
            }

            // Authentication successful, continue
            next(w, r)
        }
    }

    func isValidAPIKey(key string) bool {
        // In production, check against database
        validKeys := map[string]bool{
            "secret-key-123": true,
            "api-key-456":    true,
        }
        return validKeys[key]
    }

    // Usage
    http.HandleFunc("/api/protected",
        authMiddleware(loggingMiddleware(protectedHandler)))
    ```

    ## CORS Middleware

    Enable Cross-Origin Resource Sharing:

    ```go
    func corsMiddleware(next http.HandlerFunc) http.HandlerFunc {
        return func(w http.ResponseWriter, r *http.Request) {
            // Set CORS headers
            w.Header().Set("Access-Control-Allow-Origin", "*")
            w.Header().Set("Access-Control-Allow-Methods",
                "GET, POST, PUT, DELETE, OPTIONS")
            w.Header().Set("Access-Control-Allow-Headers",
                "Content-Type, Authorization")

            // Handle preflight request
            if r.Method == "OPTIONS" {
                w.WriteHeader(http.StatusOK)
                return
            }

            next(w, r)
        }
    }
    ```

    ## Chaining Multiple Middleware

    ```go
    func chain(handler http.HandlerFunc, middlewares ...func(http.HandlerFunc) http.HandlerFunc) http.HandlerFunc {
        for i := len(middlewares) - 1; i >= 0; i-- {
            handler = middlewares[i](handler)
        }
        return handler
    }

    // Usage
    http.HandleFunc("/api/users",
        chain(usersHandler,
            loggingMiddleware,
            authMiddleware,
            corsMiddleware,
        ),
    )
    ```

    ## Middleware with http.Handler Interface

    For more flexibility, use the http.Handler interface:

    ```go
    func loggingMiddleware(next http.Handler) http.Handler {
        return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
            start := time.Now()
            log.Printf("%s %s", r.Method, r.URL.Path)

            next.ServeHTTP(w, r)

            log.Printf("Completed in %v", time.Since(start))
        })
    }

    // Usage with mux
    mux := http.NewServeMux()
    mux.HandleFunc("/api/users", usersHandler)

    // Wrap entire mux with middleware
    http.ListenAndServe(":8080", loggingMiddleware(mux))
    ```

    ## Structured Logging

    Use structured logging for better log analysis:

    ```go
    import "log/slog"

    func loggingMiddleware(next http.HandlerFunc) http.HandlerFunc {
        return func(w http.ResponseWriter, r *http.Request) {
            start := time.Now()

            wrapped := &responseWriter{ResponseWriter: w, status: 200}
            next(wrapped, r)

            slog.Info("request",
                "method", r.Method,
                "path", r.URL.Path,
                "status", wrapped.status,
                "duration_ms", time.Since(start).Milliseconds(),
                "user_agent", r.UserAgent(),
            )
        }
    }
    ```

    ## Recovery Middleware

    Catch panics to prevent server crashes:

    ```go
    func recoveryMiddleware(next http.HandlerFunc) http.HandlerFunc {
        return func(w http.ResponseWriter, r *http.Request) {
            defer func() {
                if err := recover(); err != nil {
                    log.Printf("PANIC: %v", err)

                    // Return 500 error
                    http.Error(w,
                        "Internal Server Error",
                        http.StatusInternalServerError,
                    )
                }
            }()

            next(w, r)
        }
    }
    ```

    ## Complete Server with Middleware

    ```go
    package main

    import (
        "log"
        "net/http"
        "time"
    )

    func main() {
        mux := http.NewServeMux()

        // Register handlers with middleware
        mux.HandleFunc("/api/users",
            chain(usersHandler,
                recoveryMiddleware,
                loggingMiddleware,
                corsMiddleware,
            ),
        )

        mux.HandleFunc("/api/protected",
            chain(protectedHandler,
                recoveryMiddleware,
                loggingMiddleware,
                authMiddleware,
            ),
        )

        log.Println("Server starting on :8080...")
        log.Fatal(http.ListenAndServe(":8080", mux))
    }

    func usersHandler(w http.ResponseWriter, r *http.Request) {
        w.Header().Set("Content-Type", "application/json")
        w.Write([]byte(`{"message": "Users endpoint"}`))
    }

    func protectedHandler(w http.ResponseWriter, r *http.Request) {
        w.Header().Set("Content-Type", "application/json")
        w.Write([]byte(`{"message": "Protected data"}`))
    }
    ```

    ## Best Practices

    1. **Order matters** - Recovery should be first, logging second
    2. **Keep middleware focused** - Each does one thing well
    3. **Make middleware reusable** - Don't hard-code values
    4. **Log important events** - Requests, errors, slow operations
    5. **Use structured logging** - Better for analysis and monitoring
    6. **Handle panics** - Recovery middleware prevents crashes
    7. **Document middleware chain** - Make it clear what runs when
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 2 microlessons for Golang Web Services Advanced"
