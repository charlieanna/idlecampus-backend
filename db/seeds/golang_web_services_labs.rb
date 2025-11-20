# Go Web Services Labs - Week 7
# Hands-on labs for building REST APIs

puts "\n🧪 Seeding Go Web Services Labs..."

# Ensure course and module exist
go_course = Course.find_by!(slug: 'golang-fundamentals')
web_services_mod = CourseModule.find_by!(course: go_course, slug: 'go-web-services')

# Lab 1: Simple HTTP Server
lab1 = HandsOnLab.find_or_create_by!(title: 'Lab: Build Your First HTTP Server') do |lab|
  lab.description = 'Create a basic HTTP server that responds to different routes'
  lab.lab_type = 'golang'
  lab.lab_format = 'code_editor'
  lab.programming_language = 'golang'
  lab.difficulty = 'easy'
  lab.estimated_minutes = 20
  lab.points_reward = 100
  lab.is_active = true
  lab.time_limit_seconds = 10
  lab.memory_limit_mb = 128

  lab.starter_code = <<~GOLANG
    package main

    import (
        "fmt"
        "net/http"
    )

    // TODO: Implement homeHandler that returns "Welcome Home!"
    func homeHandler(w http.ResponseWriter, r *http.Request) {
        // Your code here
    }

    // TODO: Implement aboutHandler that returns "About Page"
    func aboutHandler(w http.ResponseWriter, r *http.Request) {
        // Your code here
    }

    func main() {
        // TODO: Register handlers for "/" and "/about"
        // TODO: Start server on port 8080
    }
  GOLANG

  lab.scenario_narrative = <<~MD
    Build a simple web server with two routes:
    - `/` should return "Welcome Home!"
    - `/about` should return "About Page"

    The server should listen on port 8080.
  MD

  lab.steps = [
    {
      step_number: 1,
      title: 'Implement homeHandler',
      instruction: 'Write a handler that responds with "Welcome Home!"',
      hint: 'Use fmt.Fprintf(w, "Welcome Home!")'
    },
    {
      step_number: 2,
      title: 'Implement aboutHandler',
      instruction: 'Write a handler that responds with "About Page"',
      hint: 'Similar to homeHandler'
    },
    {
      step_number: 3,
      title: 'Register handlers and start server',
      instruction: 'Use http.HandleFunc and http.ListenAndServe',
      hint: 'http.ListenAndServe(":8080", nil)'
    }
  ]

  lab.learning_objectives = [
    'Create HTTP handler functions',
    'Register routes with http.HandleFunc',
    'Start an HTTP server'
  ]

  lab.test_cases = [
    {
      name: 'Home route returns correct message',
      input: 'GET /',
      expected_output: 'Welcome Home!',
      is_hidden: false
    },
    {
      name: 'About route returns correct message',
      input: 'GET /about',
      expected_output: 'About Page',
      is_hidden: false
    }
  ]
end

# Lab 2: JSON API Endpoint
lab2 = HandsOnLab.find_or_create_by!(title: 'Lab: Create a JSON API Endpoint') do |lab|
  lab.description = 'Build an API endpoint that returns JSON data'
  lab.lab_type = 'golang'
  lab.lab_format = 'code_editor'
  lab.programming_language = 'golang'
  lab.difficulty = 'medium'
  lab.estimated_minutes = 25
  lab.points_reward = 150
  lab.is_active = true
  lab.time_limit_seconds = 10
  lab.memory_limit_mb = 128

  lab.starter_code = <<~GOLANG
    package main

    import (
        "encoding/json"
        "net/http"
    )

    type User struct {
        ID    int    `json:"id"`
        Name  string `json:"name"`
        Email string `json:"email"`
    }

    // TODO: Implement handler that returns a JSON array of users
    func usersHandler(w http.ResponseWriter, r *http.Request) {
        users := []User{
            {ID: 1, Name: "Alice", Email: "alice@example.com"},
            {ID: 2, Name: "Bob", Email: "bob@example.com"},
        }

        // TODO: Set Content-Type header to application/json
        // TODO: Encode users to JSON and write to response
    }

    func main() {
        http.HandleFunc("/api/users", usersHandler)
        http.ListenAndServe(":8080", nil)
    }
  GOLANG

  lab.scenario_narrative = <<~MD
    Create an API endpoint that returns a list of users in JSON format.

    The endpoint `/api/users` should return:
    ```json
    [
      {"id": 1, "name": "Alice", "email": "alice@example.com"},
      {"id": 2, "name": "Bob", "email": "bob@example.com"}
    ]
    ```

    Make sure to set the correct Content-Type header!
  MD

  lab.steps = [
    {
      step_number: 1,
      title: 'Set Content-Type header',
      instruction: 'Set the response header to application/json',
      hint: 'w.Header().Set("Content-Type", "application/json")'
    },
    {
      step_number: 2,
      title: 'Encode JSON response',
      instruction: 'Use json.NewEncoder to encode the users slice',
      hint: 'json.NewEncoder(w).Encode(users)'
    }
  ]

  lab.learning_objectives = [
    'Return JSON responses from handlers',
    'Set HTTP headers correctly',
    'Use encoding/json package'
  ]

  lab.test_cases = [
    {
      name: 'Returns valid JSON array',
      input: 'GET /api/users',
      expected_output: '[{"id":1,"name":"Alice","email":"alice@example.com"},{"id":2,"name":"Bob","email":"bob@example.com"}]',
      is_hidden: false
    },
    {
      name: 'Content-Type is application/json',
      input: 'GET /api/users',
      expected_output: 'Content-Type: application/json',
      is_hidden: true
    }
  ]
end

# Lab 3: Handle POST Requests with JSON
lab3 = HandsOnLab.find_or_create_by!(title: 'Lab: Handle JSON POST Requests') do |lab|
  lab.description = 'Create an endpoint that accepts JSON data via POST'
  lab.lab_type = 'golang'
  lab.lab_format = 'code_editor'
  lab.programming_language = 'golang'
  lab.difficulty = 'medium'
  lab.estimated_minutes = 30
  lab.points_reward = 175
  lab.is_active = true
  lab.time_limit_seconds = 10
  lab.memory_limit_mb = 128

  lab.starter_code = <<~GOLANG
    package main

    import (
        "encoding/json"
        "net/http"
    )

    type Task struct {
        ID    int    `json:"id"`
        Title string `json:"title"`
        Done  bool   `json:"done"`
    }

    var tasks []Task
    var nextID = 1

    func createTaskHandler(w http.ResponseWriter, r *http.Request) {
        // TODO: Only accept POST requests
        if r.Method != http.MethodPost {
            w.WriteHeader(http.StatusMethodNotAllowed)
            return
        }

        var task Task

        // TODO: Decode JSON from request body
        // TODO: Assign ID to task
        // TODO: Add task to tasks slice
        // TODO: Return created task with status 201
    }

    func main() {
        http.HandleFunc("/api/tasks", createTaskHandler)
        http.ListenAndServe(":8080", nil)
    }
  GOLANG

  lab.scenario_narrative = <<~MD
    Build an endpoint that creates tasks from JSON POST requests.

    **Requirements:**
    - Only accept POST requests (return 405 for others)
    - Parse JSON from request body
    - Assign an auto-incrementing ID
    - Add task to the tasks slice
    - Return the created task with status 201

    **Example request:**
    ```json
    POST /api/tasks
    {"title": "Learn Go", "done": false}
    ```

    **Example response:**
    ```json
    {"id": 1, "title": "Learn Go", "done": false}
    ```
  MD

  lab.steps = [
    {
      step_number: 1,
      title: 'Decode JSON body',
      instruction: 'Use json.NewDecoder to parse the request body',
      hint: 'json.NewDecoder(r.Body).Decode(&task)'
    },
    {
      step_number: 2,
      title: 'Assign ID and add to slice',
      instruction: 'Set task.ID = nextID, increment nextID, append to tasks',
      hint: 'task.ID = nextID; nextID++; tasks = append(tasks, task)'
    },
    {
      step_number: 3,
      title: 'Return created task',
      instruction: 'Set status 201 and encode task as JSON',
      hint: 'w.WriteHeader(http.StatusCreated); json.NewEncoder(w).Encode(task)'
    }
  ]

  lab.learning_objectives = [
    'Parse JSON from POST request bodies',
    'Return appropriate HTTP status codes',
    'Build a simple in-memory data store'
  ]

  lab.test_cases = [
    {
      name: 'Creates task with ID',
      input: 'POST /api/tasks {"title":"Test Task","done":false}',
      expected_output: '{"id":1,"title":"Test Task","done":false}',
      is_hidden: false
    },
    {
      name: 'Returns 201 status',
      input: 'POST /api/tasks {"title":"Another","done":true}',
      expected_output: 'Status: 201',
      is_hidden: true
    },
    {
      name: 'Rejects non-POST requests',
      input: 'GET /api/tasks',
      expected_output: 'Status: 405',
      is_hidden: false
    }
  ]
end

# Lab 4: Full CRUD REST API
lab4 = HandsOnLab.find_or_create_by!(title: 'Lab: Build a Complete REST API') do |lab|
  lab.description = 'Implement a full CRUD API for managing books'
  lab.lab_type = 'golang'
  lab.lab_format = 'code_editor'
  lab.programming_language = 'golang'
  lab.difficulty = 'hard'
  lab.estimated_minutes = 45
  lab.points_reward = 250
  lab.is_active = true
  lab.time_limit_seconds = 15
  lab.memory_limit_mb = 256

  lab.starter_code = <<~GOLANG
    package main

    import (
        "encoding/json"
        "net/http"
        "strconv"
        "strings"
    )

    type Book struct {
        ID     int    `json:"id"`
        Title  string `json:"title"`
        Author string `json:"author"`
        ISBN   string `json:"isbn"`
    }

    var books []Book
    var nextID = 1

    func booksHandler(w http.ResponseWriter, r *http.Request) {
        switch r.Method {
        case http.MethodGet:
            // TODO: Return all books
        case http.MethodPost:
            // TODO: Create new book
        default:
            w.WriteHeader(http.StatusMethodNotAllowed)
        }
    }

    func bookHandler(w http.ResponseWriter, r *http.Request) {
        // Extract ID from path /api/books/123
        parts := strings.Split(r.URL.Path, "/")
        if len(parts) < 4 {
            w.WriteHeader(http.StatusBadRequest)
            return
        }

        id, err := strconv.Atoi(parts[3])
        if err != nil {
            w.WriteHeader(http.StatusBadRequest)
            return
        }

        switch r.Method {
        case http.MethodGet:
            // TODO: Get book by ID
        case http.MethodPut:
            // TODO: Update book
        case http.MethodDelete:
            // TODO: Delete book
        default:
            w.WriteHeader(http.StatusMethodNotAllowed)
        }
    }

    func main() {
        http.HandleFunc("/api/books", booksHandler)
        http.HandleFunc("/api/books/", bookHandler)
        http.ListenAndServe(":8080", nil)
    }
  GOLANG

  lab.scenario_narrative = <<~MD
    Build a complete REST API for managing books with full CRUD operations.

    **Endpoints to implement:**

    1. `GET /api/books` - List all books
    2. `POST /api/books` - Create a new book
    3. `GET /api/books/:id` - Get a specific book
    4. `PUT /api/books/:id` - Update a book
    5. `DELETE /api/books/:id` - Delete a book

    **Requirements:**
    - Use in-memory storage (books slice)
    - Return 404 if book not found
    - Return 201 for successful creation
    - Return proper JSON responses
    - Handle errors gracefully
  MD

  lab.steps = [
    {
      step_number: 1,
      title: 'Implement GET /api/books',
      instruction: 'Return all books as JSON array',
      hint: 'json.NewEncoder(w).Encode(books)'
    },
    {
      step_number: 2,
      title: 'Implement POST /api/books',
      instruction: 'Create new book, assign ID, add to slice, return 201',
      hint: 'Decode body, set ID, append, return with StatusCreated'
    },
    {
      step_number: 3,
      title: 'Implement GET /api/books/:id',
      instruction: 'Find book by ID and return it, or 404 if not found',
      hint: 'Loop through books, if found return it, else WriteHeader(404)'
    },
    {
      step_number: 4,
      title: 'Implement PUT /api/books/:id',
      instruction: 'Update existing book or return 404',
      hint: 'Find book, decode new data, update fields'
    },
    {
      step_number: 5,
      title: 'Implement DELETE /api/books/:id',
      instruction: 'Remove book from slice or return 404',
      hint: 'Find index, use append to remove: books = append(books[:i], books[i+1:]...)'
    }
  ]

  lab.learning_objectives = [
    'Build a complete CRUD REST API',
    'Handle URL path parameters',
    'Manage in-memory data structures',
    'Return appropriate status codes for all operations'
  ]

  lab.test_cases = [
    {
      name: 'List books returns empty array initially',
      input: 'GET /api/books',
      expected_output: '[]',
      is_hidden: false
    },
    {
      name: 'Create book returns 201 with ID',
      input: 'POST /api/books {"title":"Go Programming","author":"John Doe","isbn":"123"}',
      expected_output: '{"id":1,"title":"Go Programming","author":"John Doe","isbn":"123"}',
      is_hidden: false
    },
    {
      name: 'Get book by ID returns book',
      input: 'GET /api/books/1',
      expected_output: '{"id":1,"title":"Go Programming","author":"John Doe","isbn":"123"}',
      is_hidden: false
    },
    {
      name: 'Get non-existent book returns 404',
      input: 'GET /api/books/999',
      expected_output: 'Status: 404',
      is_hidden: true
    },
    {
      name: 'Update book changes data',
      input: 'PUT /api/books/1 {"title":"Advanced Go","author":"Jane Smith","isbn":"456"}',
      expected_output: '{"id":1,"title":"Advanced Go","author":"Jane Smith","isbn":"456"}',
      is_hidden: false
    },
    {
      name: 'Delete book removes it',
      input: 'DELETE /api/books/1',
      expected_output: 'Status: 204',
      is_hidden: false
    }
  ]
end

# Link labs to module
[lab1, lab2, lab3, lab4].each_with_index do |lab, index|
  ModuleItem.find_or_create_by!(course_module: web_services_mod, item: lab) do |mi|
    mi.sequence_order = index + 10
    mi.required = true
  end
end

puts "✅ Go Web Services Labs seeded:"
puts "   - #{lab1.title}"
puts "   - #{lab2.title}"
puts "   - #{lab3.title}"
puts "   - #{lab4.title}"
