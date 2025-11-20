# Go Web Services Module - Week 7
# RESTful API development with net/http and database integration

puts "\n🌐 Seeding Go Web Services Module (Week 7)..."

# Ensure course exists
go_course = Course.find_or_create_by!(slug: 'golang-fundamentals') do |course|
  course.title = 'Go Programming Fundamentals'
  course.description = 'Master Go programming with focus on concurrency, testing, and production readiness'
  course.difficulty_level = 'intermediate'
  course.published = true
  course.sequence_order = 2
  course.estimated_hours = 40
end

# Module: Building RESTful Web Services
web_services_mod = CourseModule.find_or_create_by!(course: go_course, slug: 'go-web-services') do |mod|
  mod.title = 'Building RESTful Web Services'
  mod.description = 'Learn to build production-ready REST APIs with net/http, JSON handling, and database integration'
  mod.sequence_order = 6
  mod.estimated_minutes = 240
  mod.published = true
  mod.learning_objectives = [
    'Design clean RESTful API endpoints',
    'Build HTTP servers using net/http package',
    'Handle JSON requests and responses',
    'Integrate PostgreSQL database with Go',
    'Implement middleware for logging and authentication',
    'Structure Go web applications for production'
  ]
end

# Lesson 1: REST API Design Basics
lesson1 = Lesson.find_or_create_by!(slug: 'rest-api-design-basics') do |lesson|
  lesson.title = 'REST API Design Basics'
  lesson.content = <<~MARKDOWN
    # REST API Design Basics

    REST (Representational State Transfer) is an architectural style for designing networked applications. RESTful APIs are the backbone of modern web services.

    ## What is REST?

    REST is built around resources and HTTP methods. A resource is any data or object that can be accessed via a URI.

    **Key Principles:**
    - **Client-Server Architecture** - Separation of concerns
    - **Stateless** - Each request contains all needed information
    - **Cacheable** - Responses can be cached for performance
    - **Uniform Interface** - Standard HTTP methods and status codes

    ## HTTP Methods (Verbs)

    RESTful APIs use HTTP methods to indicate the desired action:

    | Method | Purpose | Example |
    |--------|---------|---------|
    | GET | Retrieve resource(s) | `GET /api/users` - List users |
    | POST | Create new resource | `POST /api/users` - Create user |
    | PUT | Update entire resource | `PUT /api/users/123` - Update user 123 |
    | PATCH | Partially update resource | `PATCH /api/users/123` - Update name only |
    | DELETE | Remove resource | `DELETE /api/users/123` - Delete user 123 |

    ## Resource Naming Conventions

    **Good practices:**
    ```
    GET    /api/v1/books          # List all books
    GET    /api/v1/books/42       # Get book with ID 42
    POST   /api/v1/books          # Create a new book
    PUT    /api/v1/books/42       # Update book 42
    DELETE /api/v1/books/42       # Delete book 42
    GET    /api/v1/books/42/reviews  # Get reviews for book 42
    ```

    **Best practices:**
    - Use nouns, not verbs (✅ `/books` not ❌ `/getBooks`)
    - Use plural nouns (✅ `/books` not ❌ `/book`)
    - Use lowercase and hyphens (✅ `/user-profiles` not ❌ `/UserProfiles`)
    - Include API version (✅ `/api/v1/books`)
    - Keep URLs shallow (avoid deep nesting)

    ## HTTP Status Codes

    Use appropriate status codes to indicate the result:

    **Success (2xx):**
    - `200 OK` - Successful GET, PUT, PATCH
    - `201 Created` - Successful POST (resource created)
    - `204 No Content` - Successful DELETE (no response body)

    **Client Errors (4xx):**
    - `400 Bad Request` - Invalid request data
    - `401 Unauthorized` - Authentication required
    - `403 Forbidden` - Authenticated but not authorized
    - `404 Not Found` - Resource doesn't exist
    - `422 Unprocessable Entity` - Validation failed

    **Server Errors (5xx):**
    - `500 Internal Server Error` - Server-side error
    - `503 Service Unavailable` - Server is down

    ## JSON Request/Response Format

    Modern REST APIs use JSON for data exchange:

    **Request (POST /api/v1/books):**
    ```json
    {
      "title": "Learning Go",
      "author": "Jon Bodner",
      "isbn": "978-1492077213",
      "year": 2021
    }
    ```

    **Response (201 Created):**
    ```json
    {
      "id": 123,
      "title": "Learning Go",
      "author": "Jon Bodner",
      "isbn": "978-1492077213",
      "year": 2021,
      "created_at": "2025-11-07T10:30:00Z"
    }
    ```

    ## Example API Design

    Let's design a simple **Task Management API**:

    ```
    # Tasks
    GET    /api/v1/tasks           # List all tasks
    POST   /api/v1/tasks           # Create new task
    GET    /api/v1/tasks/:id       # Get specific task
    PUT    /api/v1/tasks/:id       # Update task
    DELETE /api/v1/tasks/:id       # Delete task
    PATCH  /api/v1/tasks/:id/complete  # Mark task complete

    # Query parameters for filtering/pagination
    GET /api/v1/tasks?status=completed&page=2&limit=10
    ```

    ## Best Practices Summary

    1. **Use HTTP methods correctly** - GET for reading, POST for creating, etc.
    2. **Return appropriate status codes** - Don't use 200 for everything
    3. **Version your API** - `/api/v1/` allows future changes
    4. **Use JSON** - Industry standard for REST APIs
    5. **Be consistent** - Same patterns across all endpoints
    6. **Document your API** - Make it easy for others to use
  MARKDOWN
  lesson.estimated_minutes = 25
  lesson.sequence_order = 1
  lesson.published = true
end

# Lesson 2: Building HTTP Servers with net/http
lesson2 = Lesson.find_or_create_by!(slug: 'go-net-http-server') do |lesson|
  lesson.title = 'Building HTTP Servers with net/http'
  lesson.content = <<~MARKDOWN
    # Building HTTP Servers with net/http

    Go's standard library includes the powerful `net/http` package for building web servers and clients. No external frameworks needed!

    ## Your First HTTP Server

    ```go
    package main

    import (
        "fmt"
        "net/http"
    )

    func helloHandler(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "Hello, World!")
    }

    func main() {
        http.HandleFunc("/", helloHandler)

        fmt.Println("Server starting on :8080...")
        http.ListenAndServe(":8080", nil)
    }
    ```

    **Key components:**
    - `http.HandleFunc` - Registers a handler function for a path
    - `http.ResponseWriter` - Interface for writing the HTTP response
    - `http.Request` - Contains all request information
    - `http.ListenAndServe` - Starts the server on specified port

    ## Handler Functions

    Handler functions have this signature:
    ```go
    func(w http.ResponseWriter, r *http.Request)
    ```

    **Example with different paths:**
    ```go
    func main() {
        http.HandleFunc("/", homeHandler)
        http.HandleFunc("/about", aboutHandler)
        http.HandleFunc("/api/users", usersHandler)

        http.ListenAndServe(":8080", nil)
    }

    func homeHandler(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "Welcome Home!")
    }

    func aboutHandler(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "About Page")
    }
    ```

    ## Reading Request Information

    The `*http.Request` object contains all request details:

    ```go
    func requestInfoHandler(w http.ResponseWriter, r *http.Request) {
        // HTTP Method (GET, POST, etc.)
        method := r.Method

        // Request URL path
        path := r.URL.Path

        // Query parameters
        name := r.URL.Query().Get("name")

        // Headers
        userAgent := r.Header.Get("User-Agent")

        fmt.Fprintf(w, "Method: %s\\nPath: %s\\nName: %s\\n",
            method, path, name)
    }
    ```

    ## Handling Different HTTP Methods

    ```go
    func userHandler(w http.ResponseWriter, r *http.Request) {
        switch r.Method {
        case http.MethodGet:
            // Handle GET - retrieve users
            fmt.Fprintf(w, "Getting users")

        case http.MethodPost:
            // Handle POST - create user
            fmt.Fprintf(w, "Creating user")

        case http.MethodPut:
            // Handle PUT - update user
            fmt.Fprintf(w, "Updating user")

        case http.MethodDelete:
            // Handle DELETE - remove user
            fmt.Fprintf(w, "Deleting user")

        default:
            // Method not allowed
            w.WriteHeader(http.StatusMethodNotAllowed)
            fmt.Fprintf(w, "Method not allowed")
        }
    }
    ```

    ## Setting Response Status Codes

    ```go
    func handler(w http.ResponseWriter, r *http.Request) {
        // Set status code (must be called before writing body)
        w.WriteHeader(http.StatusCreated) // 201

        // Write response body
        fmt.Fprintf(w, "Resource created")
    }
    ```

    **Common status codes:**
    ```go
    w.WriteHeader(http.StatusOK)                // 200
    w.WriteHeader(http.StatusCreated)           // 201
    w.WriteHeader(http.StatusBadRequest)        // 400
    w.WriteHeader(http.StatusNotFound)          // 404
    w.WriteHeader(http.StatusInternalServerError) // 500
    ```

    ## Setting Response Headers

    ```go
    func jsonHandler(w http.ResponseWriter, r *http.Request) {
        // Set content type header
        w.Header().Set("Content-Type", "application/json")

        // Set custom headers
        w.Header().Set("X-Custom-Header", "value")

        // Write response
        fmt.Fprintf(w, `{"message": "Hello"}`)
    }
    ```

    ## Using http.ServeMux (Router)

    For more control, create your own ServeMux:

    ```go
    func main() {
        mux := http.NewServeMux()

        mux.HandleFunc("/", homeHandler)
        mux.HandleFunc("/api/users", usersHandler)
        mux.HandleFunc("/api/tasks", tasksHandler)

        // Start server with custom mux
        http.ListenAndServe(":8080", mux)
    }
    ```

    ## Concurrent Request Handling

    **Important:** The Go HTTP server automatically handles each request in its own goroutine!

    ```go
    func slowHandler(w http.ResponseWriter, r *http.Request) {
        // This runs in its own goroutine
        time.Sleep(2 * time.Second)
        fmt.Fprintf(w, "Done!")
    }
    // Multiple concurrent requests won't block each other
    ```

    **Thread safety considerations:**
    - Global variables need synchronization (mutex or channels)
    - Each request runs concurrently
    - Database connections should use connection pooling

    ## Graceful Shutdown

    ```go
    func main() {
        mux := http.NewServeMux()
        mux.HandleFunc("/", homeHandler)

        server := &http.Server{
            Addr:    ":8080",
            Handler: mux,
        }

        // Start server in goroutine
        go func() {
            fmt.Println("Server starting on :8080...")
            if err := server.ListenAndServe(); err != nil {
                log.Fatal(err)
            }
        }()

        // Wait for interrupt signal
        quit := make(chan os.Signal, 1)
        signal.Notify(quit, os.Interrupt)
        <-quit

        fmt.Println("Shutting down server...")
        ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
        defer cancel()

        if err := server.Shutdown(ctx); err != nil {
            log.Fatal("Server forced to shutdown:", err)
        }

        fmt.Println("Server exited")
    }
    ```

    ## Best Practices

    1. **Always check HTTP methods** - Use switch statements
    2. **Set status codes explicitly** - Don't rely on defaults
    3. **Set Content-Type header** - Especially for JSON responses
    4. **Handle errors properly** - Return appropriate error status codes
    5. **Be aware of concurrency** - Handlers run in separate goroutines
    6. **Implement graceful shutdown** - For production servers
  MARKDOWN
  lesson.estimated_minutes = 30
  lesson.sequence_order = 2
  lesson.published = true
end

# Lesson 3: JSON Request/Response Handling
lesson3 = Lesson.find_or_create_by!(slug: 'go-json-handling') do |lesson|
  lesson.title = 'JSON Request/Response Handling'
  lesson.content = <<~MARKDOWN
    # JSON Request/Response Handling

    Modern REST APIs communicate using JSON. Go's `encoding/json` package makes it easy to work with JSON data.

    ## Structs for JSON Data

    Define structs to represent your API data:

    ```go
    type User struct {
        ID        int       `json:"id"`
        Name      string    `json:"name"`
        Email     string    `json:"email"`
        CreatedAt time.Time `json:"created_at"`
    }

    type Task struct {
        ID          int    `json:"id"`
        Title       string `json:"title"`
        Description string `json:"description"`
        Completed   bool   `json:"completed"`
    }
    ```

    **Struct tags:**
    - `json:"field_name"` - Specify JSON field name (snake_case)
    - `json:"field,omitempty"` - Omit field if empty/zero value
    - `json:"-"` - Never include this field in JSON

    ## Sending JSON Responses

    ### Method 1: Using json.Marshal

    ```go
    func getUserHandler(w http.ResponseWriter, r *http.Request) {
        user := User{
            ID:    1,
            Name:  "John Doe",
            Email: "john@example.com",
            CreatedAt: time.Now(),
        }

        // Set content type
        w.Header().Set("Content-Type", "application/json")

        // Marshal to JSON
        jsonData, err := json.Marshal(user)
        if err != nil {
            w.WriteHeader(http.StatusInternalServerError)
            fmt.Fprintf(w, `{"error": "Failed to marshal JSON"}`)
            return
        }

        w.WriteHeader(http.StatusOK)
        w.Write(jsonData)
    }
    ```

    ### Method 2: Using json.NewEncoder (Recommended)

    ```go
    func getUserHandler(w http.ResponseWriter, r *http.Request) {
        user := User{
            ID:    1,
            Name:  "John Doe",
            Email: "john@example.com",
            CreatedAt: time.Now(),
        }

        w.Header().Set("Content-Type", "application/json")
        w.WriteHeader(http.StatusOK)

        // Encode directly to response writer
        json.NewEncoder(w).Encode(user)
    }
    ```

    ## Sending JSON Arrays

    ```go
    func listUsersHandler(w http.ResponseWriter, r *http.Request) {
        users := []User{
            {ID: 1, Name: "Alice", Email: "alice@example.com"},
            {ID: 2, Name: "Bob", Email: "bob@example.com"},
            {ID: 3, Name: "Carol", Email: "carol@example.com"},
        }

        w.Header().Set("Content-Type", "application/json")
        json.NewEncoder(w).Encode(users)
    }
    ```

    ## Reading JSON Request Bodies

    ```go
    type CreateUserRequest struct {
        Name  string `json:"name"`
        Email string `json:"email"`
    }

    func createUserHandler(w http.ResponseWriter, r *http.Request) {
        // Only accept POST
        if r.Method != http.MethodPost {
            w.WriteHeader(http.StatusMethodNotAllowed)
            return
        }

        var req CreateUserRequest

        // Decode JSON body
        err := json.NewDecoder(r.Body).Decode(&req)
        if err != nil {
            w.WriteHeader(http.StatusBadRequest)
            json.NewEncoder(w).Encode(map[string]string{
                "error": "Invalid JSON",
            })
            return
        }
        defer r.Body.Close()

        // Validate input
        if req.Name == "" || req.Email == "" {
            w.WriteHeader(http.StatusBadRequest)
            json.NewEncoder(w).Encode(map[string]string{
                "error": "Name and email are required",
            })
            return
        }

        // Create user (simplified)
        user := User{
            ID:    123,
            Name:  req.Name,
            Email: req.Email,
            CreatedAt: time.Now(),
        }

        w.Header().Set("Content-Type", "application/json")
        w.WriteHeader(http.StatusCreated)
        json.NewEncoder(w).Encode(user)
    }
    ```

    ## Parsing URL Path Parameters

    Extract IDs from URLs like `/api/users/123`:

    ```go
    func getUserByIDHandler(w http.ResponseWriter, r *http.Request) {
        // Extract ID from path
        // For path: /api/users/123
        path := r.URL.Path
        parts := strings.Split(path, "/")

        if len(parts) < 4 {
            w.WriteHeader(http.StatusBadRequest)
            return
        }

        idStr := parts[3] // "123"
        id, err := strconv.Atoi(idStr)
        if err != nil {
            w.WriteHeader(http.StatusBadRequest)
            json.NewEncoder(w).Encode(map[string]string{
                "error": "Invalid user ID",
            })
            return
        }

        // Fetch user by ID (simplified)
        user := User{ID: id, Name: "John", Email: "john@example.com"}

        w.Header().Set("Content-Type", "application/json")
        json.NewEncoder(w).Encode(user)
    }
    ```

    ## Parsing Query Parameters

    Handle URLs like `/api/users?role=admin&page=2`:

    ```go
    func searchUsersHandler(w http.ResponseWriter, r *http.Request) {
        // Get query parameters
        query := r.URL.Query()

        role := query.Get("role")      // "admin"
        pageStr := query.Get("page")   // "2"

        page := 1
        if pageStr != "" {
            p, err := strconv.Atoi(pageStr)
            if err == nil {
                page = p
            }
        }

        // Use parameters in logic
        fmt.Printf("Searching users: role=%s, page=%d\\n", role, page)

        // Return filtered results
        users := []User{
            {ID: 1, Name: "Admin User", Email: "admin@example.com"},
        }

        w.Header().Set("Content-Type", "application/json")
        json.NewEncoder(w).Encode(users)
    }
    ```

    ## Error Response Format

    Consistent error responses improve API usability:

    ```go
    type ErrorResponse struct {
        Error   string `json:"error"`
        Message string `json:"message,omitempty"`
        Code    int    `json:"code"`
    }

    func sendError(w http.ResponseWriter, statusCode int, message string) {
        w.Header().Set("Content-Type", "application/json")
        w.WriteHeader(statusCode)

        errorResp := ErrorResponse{
            Error:   http.StatusText(statusCode),
            Message: message,
            Code:    statusCode,
        }

        json.NewEncoder(w).Encode(errorResp)
    }

    // Usage
    func handler(w http.ResponseWriter, r *http.Request) {
        if someError {
            sendError(w, http.StatusBadRequest, "Invalid input data")
            return
        }
    }
    ```

    ## Complete REST Endpoint Example

    ```go
    type Book struct {
        ID     int    `json:"id"`
        Title  string `json:"title"`
        Author string `json:"author"`
        ISBN   string `json:"isbn"`
    }

    var books = []Book{
        {ID: 1, Title: "Learning Go", Author: "Jon Bodner", ISBN: "978-1492077213"},
    }
    var nextID = 2

    func booksHandler(w http.ResponseWriter, r *http.Request) {
        switch r.Method {
        case http.MethodGet:
            // List all books
            w.Header().Set("Content-Type", "application/json")
            json.NewEncoder(w).Encode(books)

        case http.MethodPost:
            // Create new book
            var book Book
            if err := json.NewDecoder(r.Body).Decode(&book); err != nil {
                sendError(w, http.StatusBadRequest, "Invalid JSON")
                return
            }

            book.ID = nextID
            nextID++
            books = append(books, book)

            w.Header().Set("Content-Type", "application/json")
            w.WriteHeader(http.StatusCreated)
            json.NewEncoder(w).Encode(book)

        default:
            sendError(w, http.StatusMethodNotAllowed, "Method not allowed")
        }
    }
    ```

    ## Best Practices

    1. **Always set Content-Type** - `application/json` for JSON responses
    2. **Use struct tags** - Control JSON field names and behavior
    3. **Validate input** - Check for required fields and valid data
    4. **Consistent error format** - Standard error response structure
    5. **Use json.NewEncoder** - More efficient than Marshal for responses
    6. **Close request body** - `defer r.Body.Close()`
    7. **Handle edge cases** - Empty arrays, null values, missing fields
  MARKDOWN
  lesson.estimated_minutes = 30
  lesson.sequence_order = 3
  lesson.published = true
end

# Link lessons to module
[lesson1, lesson2, lesson3].each_with_index do |lesson, index|
  ModuleItem.find_or_create_by!(course_module: web_services_mod, item: lesson) do |mi|
    mi.sequence_order = index + 1
    mi.required = true
  end
end

puts "✅ Go Web Services Module seeded: #{web_services_mod.slug}"
puts "   - #{lesson1.title}"
puts "   - #{lesson2.title}"
puts "   - #{lesson3.title}"
