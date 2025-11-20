# Go Programming Fundamentals
# Generated from database on 2025-11-06
# Original slug: golang-fundamentals

CourseBuilder::DSL.define('golang-fundamentals') do
  course(
    title: "Go Programming Fundamentals",
    description: "Master Go programming with deep focus on concurrency",
    difficulty_level: "intermediate",
    estimated_hours: 10,
    certification_track: "none"
  ) do

    mod "Go Basics" do
      # Module: go-basics

      lesson "Introduction to Go" do
        content <<~MARKDOWN
          # Introduction to Go
          
          Go (or Golang) is a statically typed, compiled programming language designed at Google. It's known for its simplicity, efficiency, and excellent concurrency support.
          
          ## Why Learn Go?
          
          - **Simple and Clean Syntax** - Easy to learn and read
          - **Fast Compilation** - Compiles to native machine code
          - **Built-in Concurrency** - Goroutines and channels make concurrent programming easy
          - **Strong Standard Library** - Rich set of packages for common tasks
          - **Used by Industry Leaders** - Google, Uber, Netflix, Docker, Kubernetes, Dropbox
          
          ## Your First Go Program
          
          ```go
          package main
          
          import "fmt"
          
          func main() {
              fmt.Println("Hello, World!")
          }
          ```
          
          Every Go program starts with a package declaration. The `main` package is special - it defines an executable program. The `main()` function is the entry point of your program.
          
          ## Key Features
          
          - **Static Typing** - Type safety at compile time
          - **Garbage Collection** - Automatic memory management
          - **Fast Execution** - Compiled to machine code
          - **Cross-Platform** - Write once, compile for any OS
        MARKDOWN
        estimated_minutes 10
      end

      lesson "Variables and Types" do
        content <<~MARKDOWN
          # Variables and Types in Go
          
          Go is a statically typed language, meaning variable types are known at compile time.
          
          ## Declaring Variables
          
          There are several ways to declare variables in Go:
          
          ```go
          // Using var keyword with explicit type
          var name string = "John"
          var age int = 30
          
          // Type inference - Go infers the type
          var city = "New York"
          
          // Short declaration (inside functions only)
          country := "USA"
          isActive := true
          ```
          
          ## Basic Types
          
          **Numeric Types:**
          - `int`, `int8`, `int16`, `int32`, `int64` - Signed integers
          - `uint`, `uint8`, `uint16`, `uint32`, `uint64` - Unsigned integers
          - `float32`, `float64` - Floating point numbers
          - `complex64`, `complex128` - Complex numbers
          
          **Other Types:**
          - `string` - Text data (UTF-8 encoded)
          - `bool` - true or false
          - `byte` - Alias for uint8
          - `rune` - Alias for int32, represents a Unicode code point
          
          ## Constants
          
          Constants are declared with the `const` keyword:
          
          ```go
          const Pi = 3.14159
          const MaxUsers = 100
          const AppName = "MyApp"
          ```
          
          ## Zero Values
          
          Variables without an initial value are given their zero value:
          - `0` for numeric types
          - `false` for boolean
          - `""` (empty string) for strings
          - `nil` for pointers, functions, interfaces, slices, channels, and maps
        MARKDOWN
        estimated_minutes 15
      end

      lesson "Functions in Go" do
        content <<~MARKDOWN
          # Functions in Go
          
          Functions are the building blocks of Go programs.
          
          ## Basic Function Syntax
          
          ```go
          func functionName(parameter1 type1, parameter2 type2) returnType {
              // function body
              return value
          }
          ```
          
          ## Examples
          
          ```go
          // Simple function
          func greet(name string) string {
              return "Hello, " + name
          }
          
          // Multiple parameters of same type
          func add(x, y int) int {
              return x + y
          }
          
          // Multiple return values
          func divide(a, b float64) (float64, error) {
              if b == 0 {
                  return 0, errors.New("division by zero")
              }
              return a / b, nil
          }
          ```
          
          ## Named Return Values
          
          ```go
          func split(sum int) (x, y int) {
              x = sum * 4 / 9
              y = sum - x
              return  // naked return
          }
          ```
          
          ## Variadic Functions
          
          Functions can accept a variable number of arguments:
          
          ```go
          func sum(numbers ...int) int {
              total := 0
              for _, num := range numbers {
                  total += num
              }
              return total
          }
          
          result := sum(1, 2, 3, 4, 5)  // 15
          ```
          
          ## Anonymous Functions and Closures
          
          ```go
          // Anonymous function
          multiply := func(x, y int) int {
              return x * y
          }
          
          result := multiply(3, 4)  // 12
          ```
        MARKDOWN
        estimated_minutes 20
      end

      lab "Lab: Hello World in Go", lab_type: "golang" do
        description "Write your first Go program that prints \"Hello, World!\" to the console."

        programming_language "golang"
        starter_code <<~CODE
          package main
          
          import "fmt"
          
          func main() {
              // TODO: Print "Hello, World!" to the console
          }
        CODE

        # Test cases
        test_case do
          name "Test Hello World"
          input ""
          expected_output "Hello, World!"
        end

        difficulty "easy"
        estimated_minutes 10
      end

      lab "Lab: Working with Variables", lab_type: "golang" do
        description "Practice declaring and using variables in Go."

        programming_language "golang"
        starter_code <<~CODE
          package main
          
          import "fmt"
          
          func main() {
              // TODO: Declare variables for name (string), age (int), and height (float64)
              // Set name to "Alice", age to 25, height to 5.6
              // Print them in the format: "Name: Alice, Age: 25, Height: 5.60"
          }
        CODE

        # Test cases
        test_case do
          name "Test variable output"
          input ""
          expected_output "Name: Alice, Age: 25, Height: 5.60"
        end

        difficulty "easy"
        estimated_minutes 15
      end

      lab "Lab: Calculator Function", lab_type: "golang" do
        description "Write a function that adds two numbers and returns the result."

        programming_language "golang"
        starter_code <<~CODE
          package main
          
          import "fmt"
          
          // TODO: Create a function called add that takes two integers and returns their sum
          func add(a, b int) int {
              // Your code here
          }
          
          func main() {
              result := add(5, 3)
              fmt.Println(result)
          }
        CODE

        # Test cases
        test_case do
          name "Test addition"
          input ""
          expected_output "8"
        end

        difficulty "easy"
        estimated_minutes 15
      end

    end

    mod "Data Structures" do
      # Module: data-structures

      lesson "Arrays and Slices" do
        content <<~MARKDOWN
          # Arrays and Slices in Go
          
          ## Arrays
          
          Arrays have a fixed size and are declared with a specific length:
          
          ```go
          // Declare array with 5 elements
          var numbers [5]int
          numbers[0] = 1
          numbers[1] = 2
          
          // Array literal
          fruits := [3]string{"apple", "banana", "orange"}
          
          // Let compiler count
          colors := [...]string{"red", "green", "blue"}
          ```
          
          ## Slices
          
          Slices are dynamic arrays - they can grow and shrink:
          
          ```go
          // Create slice
          numbers := []int{1, 2, 3, 4, 5}
          
          // Add elements
          numbers = append(numbers, 6, 7)
          
          // Create slice with make
          scores := make([]int, 5)      // length 5, capacity 5
          buffer := make([]int, 5, 10)  // length 5, capacity 10
          ```
          
          ## Slice Operations
          
          ```go
          nums := []int{0, 1, 2, 3, 4, 5}
          
          // Slicing
          first3 := nums[0:3]   // [0, 1, 2]
          middle := nums[2:4]   // [2, 3]
          last2 := nums[4:]     // [4, 5]
          
          // Length and capacity
          len(nums)  // 6
          cap(nums)  // 6
          ```
          
          ## Range Loop
          
          ```go
          fruits := []string{"apple", "banana", "orange"}
          
          for index, fruit := range fruits {
              fmt.Printf("%d: %s\n", index, fruit)
          }
          
          // Ignore index with _
          for _, fruit := range fruits {
              fmt.Println(fruit)
          }
          ```
        MARKDOWN
        estimated_minutes 20
      end

      lesson "Maps" do
        content <<~MARKDOWN
          # Maps in Go
          
          Maps are key-value pairs, similar to dictionaries or hash tables in other languages.
          
          ## Creating Maps
          
          ```go
          // Using make
          ages := make(map[string]int)
          ages["John"] = 30
          ages["Jane"] = 25
          
          // Map literal
          scores := map[string]int{
              "Alice": 95,
              "Bob":   87,
              "Carol": 92,
          }
          ```
          
          ## Map Operations
          
          ```go
          // Access value
          age := ages["John"]
          
          // Check if key exists
          age, exists := ages["John"]
          if exists {
              fmt.Println("Found:", age)
          }
          
          // Delete key
          delete(ages, "John")
          
          // Iterate over map
          for name, score := range scores {
              fmt.Printf("%s: %d\n", name, score)
          }
          ```
          
          ## Important Notes
          
          - Maps are reference types
          - Iterating over maps is not guaranteed to be in any order
          - Zero value of a map is `nil`
          - Must initialize map before use (with `make` or literal)
          
          ```go
          var m map[string]int  // nil map
          // m["key"] = 1       // panic: assignment to nil map
          
          m = make(map[string]int)  // Now it's safe to use
          m["key"] = 1
          ```
        MARKDOWN
        estimated_minutes 15
      end

      lesson "Structs" do
        content <<~MARKDOWN
          # Structs in Go
          
          Structs are typed collections of fields - similar to classes in other languages.
          
          ## Defining Structs
          
          ```go
          type Person struct {
              Name    string
              Age     int
              Email   string
              IsAdmin bool
          }
          ```
          
          ## Creating Struct Instances
          
          ```go
          // Using field names
          p1 := Person{
              Name:  "John Doe",
              Age:   30,
              Email: "john@example.com",
          }
          
          // Positional (must match order)
          p2 := Person{"Jane Doe", 25, "jane@example.com", false}
          
          // New returns pointer
          p3 := new(Person)
          p3.Name = "Bob"
          ```
          
          ## Accessing Fields
          
          ```go
          fmt.Println(p1.Name)  // John Doe
          p1.Age = 31           // Modify field
          ```
          
          ## Anonymous Structs
          
          ```go
          point := struct {
              X int
              Y int
          }{
              X: 10,
              Y: 20,
          }
          ```
          
          ## Embedded Structs
          
          ```go
          type Address struct {
              Street string
              City   string
          }
          
          type Employee struct {
              Person          // Embedded
              Address         // Embedded
              EmployeeID int
          }
          
          emp := Employee{
              Person:     Person{Name: "John", Age: 30},
              Address:    Address{City: "NYC"},
              EmployeeID: 12345,
          }
          
          // Access embedded fields directly
          fmt.Println(emp.Name)  // From Person
          fmt.Println(emp.City)  // From Address
          ```
        MARKDOWN
        estimated_minutes 20
      end

      lab "Lab: Working with Slices", lab_type: "golang" do
        description "Create and manipulate slices in Go."

        programming_language "golang"
        starter_code <<~CODE
          package main
          
          import "fmt"
          
          func main() {
              // TODO: Create a slice with numbers 1-5
              // TODO: Append 6, 7, 8 to the slice
              // TODO: Print the length of the slice
              // Expected output: 8
          }
        CODE

        # Test cases
        test_case do
          name "Test slice length"
          input ""
          expected_output "8"
        end

        difficulty "medium"
        estimated_minutes 20
      end

      lab "Lab: Working with Maps", lab_type: "golang" do
        description "Create a map and perform operations on it."

        programming_language "golang"
        starter_code <<~CODE
          package main
          
          import "fmt"
          
          func main() {
              // TODO: Create a map with string keys and int values
              // TODO: Add "apple": 5, "banana": 3, "orange": 7
              // TODO: Print the value for "banana"
              // Expected output: 3
          }
        CODE

        # Test cases
        test_case do
          name "Test map value"
          input ""
          expected_output "3"
        end

        difficulty "medium"
        estimated_minutes 20
      end

    end

    mod "Advanced Concepts" do
      # Module: advanced-concepts

      lesson "Methods" do
        content <<~MARKDOWN
          # Methods in Go
          
          Methods are functions with a special receiver argument.
          
          ## Defining Methods
          
          ```go
          type Rectangle struct {
              Width  float64
              Height float64
          }
          
          // Method with value receiver
          func (r Rectangle) Area() float64 {
              return r.Width * r.Height
          }
          
          // Method with pointer receiver
          func (r *Rectangle) Scale(factor float64) {
              r.Width *= factor
              r.Height *= factor
          }
          ```
          
          ## Using Methods
          
          ```go
          rect := Rectangle{Width: 10, Height: 5}
          
          area := rect.Area()     // 50
          rect.Scale(2)           // Modifies rect
          area = rect.Area()      // 200
          ```
          
          ## Value vs Pointer Receivers
          
          **Value Receiver:**
          - Operates on a copy
          - Cannot modify the original
          - Use when method doesn't need to modify receiver
          
          **Pointer Receiver:**
          - Operates on the original
          - Can modify the receiver
          - Use when method needs to modify receiver or receiver is large
          
          ```go
          type Counter struct {
              count int
          }
          
          // Pointer receiver to modify state
          func (c *Counter) Increment() {
              c.count++
          }
          
          // Value receiver for read-only
          func (c Counter) Value() int {
              return c.count
          }
          ```
        MARKDOWN
        estimated_minutes 20
      end

      lesson "Interfaces" do
        content <<~MARKDOWN
          # Interfaces in Go
          
          Interfaces define behavior - a set of method signatures.
          
          ## Defining Interfaces
          
          ```go
          type Shape interface {
              Area() float64
              Perimeter() float64
          }
          ```
          
          ## Implementing Interfaces
          
          Go uses implicit implementation - no "implements" keyword needed:
          
          ```go
          type Circle struct {
              Radius float64
          }
          
          func (c Circle) Area() float64 {
              return 3.14159 * c.Radius * c.Radius
          }
          
          func (c Circle) Perimeter() float64 {
              return 2 * 3.14159 * c.Radius
          }
          
          type Rectangle struct {
              Width, Height float64
          }
          
          func (r Rectangle) Area() float64 {
              return r.Width * r.Height
          }
          
          func (r Rectangle) Perimeter() float64 {
              return 2 * (r.Width + r.Height)
          }
          ```
          
          ## Using Interfaces
          
          ```go
          func PrintShapeInfo(s Shape) {
              fmt.Printf("Area: %.2f\n", s.Area())
              fmt.Printf("Perimeter: %.2f\n", s.Perimeter())
          }
          
          circle := Circle{Radius: 5}
          rect := Rectangle{Width: 10, Height: 5}
          
          PrintShapeInfo(circle)  // Works!
          PrintShapeInfo(rect)    // Works!
          ```
          
          ## Empty Interface
          
          ```go
          // interface{} accepts any type
          func PrintAnything(value interface{}) {
              fmt.Println(value)
          }
          
          PrintAnything(42)
          PrintAnything("hello")
          PrintAnything(true)
          ```
          
          ## Type Assertions
          
          ```go
          var i interface{} = "hello"
          
          s := i.(string)        // Type assertion
          fmt.Println(s)         // hello
          
          s, ok := i.(string)    // Safe type assertion
          if ok {
              fmt.Println("It's a string:", s)
          }
          ```
        MARKDOWN
        estimated_minutes 25
      end

      lesson "Error Handling" do
        content <<~MARKDOWN
          # Error Handling in Go
          
          Go uses explicit error handling with the built-in `error` type.
          
          ## The Error Interface
          
          ```go
          type error interface {
              Error() string
          }
          ```
          
          ## Returning Errors
          
          ```go
          import "errors"
          
          func divide(a, b float64) (float64, error) {
              if b == 0 {
                  return 0, errors.New("division by zero")
              }
              return a / b, nil
          }
          ```
          
          ## Checking Errors
          
          ```go
          result, err := divide(10, 0)
          if err != nil {
              fmt.Println("Error:", err)
              return
          }
          fmt.Println("Result:", result)
          ```
          
          ## Custom Errors
          
          ```go
          type ValidationError struct {
              Field string
              Issue string
          }
          
          func (e *ValidationError) Error() string {
              return fmt.Sprintf("%s: %s", e.Field, e.Issue)
          }
          
          func validateAge(age int) error {
              if age < 0 {
                  return &ValidationError{
                      Field: "age",
                      Issue: "must be positive",
                  }
              }
              return nil
          }
          ```
          
          ## Error Wrapping (Go 1.13+)
          
          ```go
          import "fmt"
          
          func readConfig() error {
              err := openFile("config.json")
              if err != nil {
                  return fmt.Errorf("failed to read config: %w", err)
              }
              return nil
          }
          
          // Unwrap errors
          err := readConfig()
          if err != nil {
              originalErr := errors.Unwrap(err)
          }
          ```
          
          ## Defer, Panic, and Recover
          
          ```go
          func cleanup() {
              defer func() {
                  if r := recover(); r != nil {
                      fmt.Println("Recovered from:", r)
                  }
              }()
          
              // This will panic
              panic("something went wrong")
          }
          ```
        MARKDOWN
        estimated_minutes 25
      end

      lab "Lab: Implement Methods", lab_type: "golang" do
        description "Create a struct with methods."

        programming_language "golang"
        starter_code <<~CODE
          package main
          
          import "fmt"
          
          type Circle struct {
              Radius float64
          }
          
          // TODO: Implement Area method that returns radius * radius * 3.14
          func (c Circle) Area() float64 {
              // Your code here
          }
          
          func main() {
              circle := Circle{Radius: 5}
              fmt.Printf("%.2f", circle.Area())
          }
        CODE

        # Test cases
        test_case do
          name "Test circle area"
          input ""
          expected_output "78.50"
        end

        difficulty "medium"
        estimated_minutes 25
      end

    end

    mod "Concurrency" do
      # Module: concurrency

      lesson "Goroutines" do
        content <<~MARKDOWN
          # Goroutines - Lightweight Concurrency
          
          Goroutines are lightweight threads managed by the Go runtime. They're one of Go's most powerful features!
          
          ## What are Goroutines?
          
          - Extremely lightweight (start with ~2KB stack)
          - Can have thousands running concurrently
          - Multiplexed onto OS threads by Go runtime
          - Much cheaper than OS threads
          
          ## Creating Goroutines
          
          Use the `go` keyword before a function call:
          
          ```go
          func sayHello() {
              fmt.Println("Hello from goroutine!")
          }
          
          func main() {
              // Launch goroutine
              go sayHello()
          
              // Main continues executing
              fmt.Println("Main function")
          
              // Wait a bit (not ideal, we'll learn better ways)
              time.Sleep(time.Second)
          }
          ```
          
          ## Anonymous Goroutines
          
          ```go
          go func() {
              fmt.Println("Anonymous goroutine")
          }()
          
          // With parameters
          go func(msg string) {
              fmt.Println(msg)
          }("Hello!")
          ```
          
          ## Example: Concurrent Tasks
          
          ```go
          func fetchUser(id int) {
              time.Sleep(100 * time.Millisecond)  // Simulate API call
              fmt.Printf("Fetched user %d\n", id)
          }
          
          func main() {
              // Launch 5 concurrent fetches
              for i := 1; i <= 5; i++ {
                  go fetchUser(i)
              }
          
              time.Sleep(time.Second)  // Wait for goroutines
          }
          ```
          
          ## Important Notes
          
          - Main function doesn't wait for goroutines
          - If main exits, all goroutines are terminated
          - Need synchronization mechanisms (channels, WaitGroups)
          - Goroutines are not guaranteed to execute in any order
        MARKDOWN
        estimated_minutes 20
      end

      lesson "Channels" do
        content <<~MARKDOWN
          # Channels - Communication Between Goroutines
          
          Channels are the pipes that connect concurrent goroutines. They allow you to send and receive values.
          
          ## Creating Channels
          
          ```go
          // Unbuffered channel
          ch := make(chan int)
          
          // Buffered channel (capacity 5)
          ch := make(chan int, 5)
          
          // Channel of strings
          messages := make(chan string)
          ```
          
          ## Sending and Receiving
          
          ```go
          ch := make(chan int)
          
          // Send to channel
          go func() {
              ch <- 42  // Send 42 to channel
          }()
          
          // Receive from channel
          value := <-ch  // Receive from channel
          fmt.Println(value)  // 42
          ```
          
          ## Unbuffered Channels (Synchronous)
          
          ```go
          ch := make(chan string)
          
          go func() {
              ch <- "message"  // Blocks until someone receives
          }()
          
          msg := <-ch  // Blocks until someone sends
          fmt.Println(msg)
          ```
          
          ## Buffered Channels (Asynchronous)
          
          ```go
          ch := make(chan int, 2)  // Buffer size 2
          
          ch <- 1  // Doesn't block
          ch <- 2  // Doesn't block
          // ch <- 3  // Would block - buffer full
          
          fmt.Println(<-ch)  // 1
          fmt.Println(<-ch)  // 2
          ```
          
          ## Closing Channels
          
          ```go
          ch := make(chan int, 3)
          ch <- 1
          ch <- 2
          ch <- 3
          close(ch)  // No more values will be sent
          
          // Receive all values
          for value := range ch {
              fmt.Println(value)  // 1, 2, 3
          }
          ```
          
          ## Channel Directions
          
          ```go
          // Send-only channel
          func sender(ch chan<- int) {
              ch <- 42
          }
          
          // Receive-only channel
          func receiver(ch <-chan int) {
              value := <-ch
              fmt.Println(value)
          }
          ```
          
          ## Example: Worker Pattern
          
          ```go
          func worker(id int, jobs <-chan int, results chan<- int) {
              for job := range jobs {
                  fmt.Printf("Worker %d processing job %d\n", id, job)
                  time.Sleep(time.Second)
                  results <- job * 2
              }
          }
          
          func main() {
              jobs := make(chan int, 10)
              results := make(chan int, 10)
          
              // Start 3 workers
              for w := 1; w <= 3; w++ {
                  go worker(w, jobs, results)
              }
          
              // Send 9 jobs
              for j := 1; j <= 9; j++ {
                  jobs <- j
              }
              close(jobs)
          
              // Collect results
              for a := 1; a <= 9; a++ {
                  <-results
              }
          }
          ```
        MARKDOWN
        estimated_minutes 30
      end

      lesson "Select Statement" do
        content <<~MARKDOWN
          # Select Statement - Multiplexing Channels
          
          The `select` statement lets a goroutine wait on multiple channel operations.
          
          ## Basic Select
          
          ```go
          ch1 := make(chan string)
          ch2 := make(chan string)
          
          go func() {
              time.Sleep(1 * time.Second)
              ch1 <- "from channel 1"
          }()
          
          go func() {
              time.Sleep(2 * time.Second)
              ch2 <- "from channel 2"
          }()
          
          select {
          case msg1 := <-ch1:
              fmt.Println(msg1)
          case msg2 := <-ch2:
              fmt.Println(msg2)
          }
          // Prints "from channel 1" (arrives first)
          ```
          
          ## Select with Default
          
          ```go
          select {
          case msg := <-ch:
              fmt.Println("Received:", msg)
          default:
              fmt.Println("No message received")
          }
          ```
          
          ## Timeout Pattern
          
          ```go
          ch := make(chan string)
          
          go func() {
              time.Sleep(2 * time.Second)
              ch <- "result"
          }()
          
          select {
          case res := <-ch:
              fmt.Println(res)
          case <-time.After(1 * time.Second):
              fmt.Println("Timeout!")
          }
          ```
          
          ## Non-blocking Receive
          
          ```go
          select {
          case msg := <-ch:
              fmt.Println("Received:", msg)
          default:
              fmt.Println("No data available")
          }
          ```
          
          ## Non-blocking Send
          
          ```go
          select {
          case ch <- value:
              fmt.Println("Sent value")
          default:
              fmt.Println("Channel full, dropping value")
          }
          ```
        MARKDOWN
        estimated_minutes 20
      end

      lesson "Sync Package - WaitGroups and Mutexes" do
        content <<~MARKDOWN
          # Sync Package - Advanced Synchronization
          
          ## WaitGroup
          
          WaitGroup waits for a collection of goroutines to finish.
          
          ```go
          import "sync"
          
          func worker(id int, wg *sync.WaitGroup) {
              defer wg.Done()  // Decrement counter when done
          
              fmt.Printf("Worker %d starting\n", id)
              time.Sleep(time.Second)
              fmt.Printf("Worker %d done\n", id)
          }
          
          func main() {
              var wg sync.WaitGroup
          
              for i := 1; i <= 5; i++ {
                  wg.Add(1)  // Increment counter
                  go worker(i, &wg)
              }
          
              wg.Wait()  // Block until counter is 0
              fmt.Println("All workers complete")
          }
          ```
          
          ## Mutex - Mutual Exclusion
          
          Protect shared data from concurrent access:
          
          ```go
          type SafeCounter struct {
              mu    sync.Mutex
              count int
          }
          
          func (c *SafeCounter) Increment() {
              c.mu.Lock()
              defer c.mu.Unlock()
              c.count++
          }
          
          func (c *SafeCounter) Value() int {
              c.mu.Lock()
              defer c.mu.Unlock()
              return c.count
          }
          
          func main() {
              counter := SafeCounter{}
              var wg sync.WaitGroup
          
              // Launch 1000 goroutines
              for i := 0; i < 1000; i++ {
                  wg.Add(1)
                  go func() {
                      defer wg.Done()
                      counter.Increment()
                  }()
              }
          
              wg.Wait()
              fmt.Println("Final count:", counter.Value())  // 1000
          }
          ```
          
          ## RWMutex - Read/Write Mutex
          
          Allows multiple readers OR one writer:
          
          ```go
          type SafeMap struct {
              mu   sync.RWMutex
              data map[string]int
          }
          
          func (m *SafeMap) Get(key string) (int, bool) {
              m.mu.RLock()  // Multiple readers OK
              defer m.mu.RUnlock()
              val, ok := m.data[key]
              return val, ok
          }
          
          func (m *SafeMap) Set(key string, value int) {
              m.mu.Lock()  // Exclusive access
              defer m.mu.Unlock()
              m.data[key] = value
          }
          ```
          
          ## Once - Run Code Once
          
          ```go
          var once sync.Once
          var instance *Singleton
          
          func GetInstance() *Singleton {
              once.Do(func() {
                  instance = &Singleton{}
              })
              return instance
          }
          ```
        MARKDOWN
        estimated_minutes 25
      end

      lab "Lab: Your First Goroutine", lab_type: "golang" do
        description "Launch a goroutine that prints a message."

        programming_language "golang"
        starter_code <<~CODE
          package main
          
          import (
              "fmt"
              "time"
          )
          
          // TODO: Create a function called printMessage that prints "Hello from goroutine!"
          // TODO: In main, launch it as a goroutine and wait 100ms
          func main() {
              // Your code here
              time.Sleep(100 * time.Millisecond)
          }
        CODE

        # Test cases
        test_case do
          name "Test goroutine"
          input ""
          expected_output "Hello from goroutine!"
        end

        difficulty "medium"
        estimated_minutes 20
      end

      lab "Lab: Send and Receive with Channels", lab_type: "golang" do
        description "Use a channel to send a message between goroutines."

        programming_language "golang"
        starter_code <<~CODE
          package main
          
          import "fmt"
          
          func main() {
              // TODO: Create a channel of strings
              // TODO: Launch a goroutine that sends "Hello Channel!" to the channel
              // TODO: Receive from the channel and print it
          }
        CODE

        # Test cases
        test_case do
          name "Test channel"
          input ""
          expected_output "Hello Channel!"
        end

        difficulty "medium"
        estimated_minutes 25
      end

    end

    mod "Advanced Patterns" do
      # Module: advanced-patterns

      lesson "Context Package" do
        content <<~MARKDOWN
          # Context Package - Cancellation and Timeouts
          
          The context package is used to carry deadlines, cancellation signals, and request-scoped values across API boundaries.
          
          ## Creating Contexts
          
          ```go
          import "context"
          
          // Background context
          ctx := context.Background()
          
          // TODO context
          ctx := context.TODO()
          
          // With timeout
          ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
          defer cancel()
          
          // With deadline
          deadline := time.Now().Add(10 * time.Second)
          ctx, cancel := context.WithDeadline(context.Background(), deadline)
          defer cancel()
          
          // With cancellation
          ctx, cancel := context.WithCancel(context.Background())
          defer cancel()
          ```
          
          ## Using Context
          
          ```go
          func doWork(ctx context.Context) error {
              for {
                  select {
                  case <-ctx.Done():
                      return ctx.Err()  // Cancelled or timed out
                  default:
                      // Do work
                      time.Sleep(100 * time.Millisecond)
                  }
              }
          }
          
          func main() {
              ctx, cancel := context.WithTimeout(context.Background(), 2*time.Second)
              defer cancel()
          
              if err := doWork(ctx); err != nil {
                  fmt.Println("Work failed:", err)
              }
          }
          ```
          
          ## Context Values
          
          ```go
          type key string
          
          const userIDKey key = "userID"
          
          func setUserID(ctx context.Context, userID int) context.Context {
              return context.WithValue(ctx, userIDKey, userID)
          }
          
          func getUserID(ctx context.Context) (int, bool) {
              userID, ok := ctx.Value(userIDKey).(int)
              return userID, ok
          }
          ```
        MARKDOWN
        estimated_minutes 20
      end

      lesson "Common Concurrency Patterns" do
        content <<~MARKDOWN
          # Concurrency Patterns in Go
          
          ## 1. Fan-Out, Fan-In
          
          Distribute work to multiple goroutines, then combine results:
          
          ```go
          func fanOut(input <-chan int, workers int) []<-chan int {
              channels := make([]<-chan int, workers)
              for i := 0; i < workers; i++ {
                  channels[i] = worker(input)
              }
              return channels
          }
          
          func fanIn(channels ...<-chan int) <-chan int {
              out := make(chan int)
              var wg sync.WaitGroup
          
              for _, ch := range channels {
                  wg.Add(1)
                  go func(c <-chan int) {
                      defer wg.Done()
                      for val := range c {
                          out <- val
                      }
                  }(ch)
              }
          
              go func() {
                  wg.Wait()
                  close(out)
              }()
          
              return out
          }
          ```
          
          ## 2. Pipeline
          
          Chain multiple stages of processing:
          
          ```go
          func generator(nums ...int) <-chan int {
              out := make(chan int)
              go func() {
                  for _, n := range nums {
                      out <- n
                  }
                  close(out)
              }()
              return out
          }
          
          func square(in <-chan int) <-chan int {
              out := make(chan int)
              go func() {
                  for n := range in {
                      out <- n * n
                  }
                  close(out)
              }()
              return out
          }
          
          func main() {
              // Pipeline: generate -> square
              c := generator(2, 3, 4)
              out := square(c)
          
              for result := range out {
                  fmt.Println(result)  // 4, 9, 16
              }
          }
          ```
          
          ## 3. Worker Pool
          
          ```go
          func workerPool(jobs <-chan int, results chan<- int, workers int) {
              var wg sync.WaitGroup
          
              for i := 0; i < workers; i++ {
                  wg.Add(1)
                  go func() {
                      defer wg.Done()
                      for job := range jobs {
                          results <- job * 2  // Process job
                      }
                  }()
              }
          
              wg.Wait()
              close(results)
          }
          ```
          
          ## 4. Rate Limiting
          
          ```go
          func rateLimiter() {
              limiter := time.Tick(100 * time.Millisecond)
          
              for i := 0; i < 5; i++ {
                  <-limiter  // Wait for tick
                  fmt.Println("Request", i)
              }
          }
          ```
        MARKDOWN
        estimated_minutes 25
      end

    end

  end
end
