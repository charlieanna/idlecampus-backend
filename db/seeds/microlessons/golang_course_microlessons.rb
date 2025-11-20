# AUTO-GENERATED from golang_course.rb
puts "Creating Microlessons for Go Basics..."

module_var = CourseModule.find_by(slug: 'go-basics')

# === MICROLESSON 1: Introduction to Go ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Introduction to Go',
  content: <<~MARKDOWN,
# Introduction to Go 🚀

# Introduction to Go

    Go (or Golang) is a statically typed, compiled programming language designed at Google. It's known for its simplicity, efficiency, and excellent concurrency support.

    ## Why Learn Go?

    - **Simple and Clean Syntax**: Easy to learn and read
    - **Fast Compilation**: Compiles to native machine code
    - **Built-in Concurrency**: Goroutines and channels make concurrent programming easy
    - **Strong Standard Library**: Rich set of packages included
    - **Used by**: Google, Uber, Netflix, Docker, Kubernetes, and more

    ## Your First Go Program

    ```go
    package main

    import "fmt"

    func main() {
        fmt.Println("Hello, Go!")
    }
    ```

    ### Key Components:
    - `package main`: Every Go program starts with a package declaration
    - `import "fmt"`: Import the format package for I/O operations
    - `func main()`: The entry point of your program
    - `fmt.Println()`: Prints text to the console

    ## Variables and Types

    Go is statically typed. Here are the basic types:

    ```go
    // Variable declarations
    var name string = "John"
    var age int = 30
    var salary float64 = 50000.50
    var isActive bool = true

    // Short declaration (type inference)
    city := "New York"  // string
    count := 42         // int
    ```

    ### Basic Types:
    - **Strings**: `string`
    - **Integers**: `int`, `int8`, `int16`, `int32`, `int64`
    - **Unsigned integers**: `uint`, `uint8`, `uint16`, `uint32`, `uint64`
    - **Floating point**: `float32`, `float64`
    - **Boolean**: `bool`
    - **Byte**: `byte` (alias for uint8)
    - **Rune**: `rune` (alias for int32, represents a Unicode code point)

    ## Control Flow

    ### If Statements
    ```go
    if age >= 18 {
        fmt.Println("Adult")
    } else {
        fmt.Println("Minor")
    }

    // If with initialization
    if num := 10; num > 5 {
        fmt.Println("Greater than 5")
    }
    ```

    ### For Loops
    Go has only one looping construct: `for`

    ```go
    // Traditional for loop
    for i := 0; i < 5; i++ {
        fmt.Println(i)
    }

    // While-style loop
    sum := 0
    for sum < 100 {
        sum += 10
    }

    // Infinite loop
    for {
        // Break out with: break
    }

    // Range over slice
    numbers := []int{1, 2, 3, 4, 5}
    for index, value := range numbers {
        fmt.Printf("Index: %d, Value: %d\\n", index, value)
    }
    ```

    ## Functions

    ```go
    // Basic function
    func greet(name string) {
        fmt.Println("Hello, " + name)
    }

    // Function with return value
    func add(a int, b int) int {
        return a + b
    }

    // Multiple return values
    func divide(a, b float64) (float64, error) {
        if b == 0 {
            return 0, errors.New("division by zero")
        }
        return a / b, nil
    }

    // Named return values
    func calculate(a, b int) (sum int, product int) {
        sum = a + b
        product = a * b
        return  // naked return
    }
    ```

    ## Practice Exercise

    Now try the "Go Slices and Arrays" lab to practice these concepts!
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 1.1: MCQ
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'mcq',
  sequence_order: 1,
  exercise_data: {
    require_pass: true,
    question: 'What is the entry point of a Go program?',
    options: ['func main()', 'init()', 'start()', 'entry()'],
    correct_answer: 0,
    explanation: 'Go programs start execution in package main at func main().',
    difficulty: 'easy'
  }
)

# Exercise 1.2: Code (implement basic functions)
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'code',
  sequence_order: 2,
  exercise_data: {
    files: ['examples/go-basics/lib/mathutil/mathutil.go','examples/go-basics/lib/mathutil/mathutil_test.go'],
    starter_code: <<~GO,
      // examples/go-basics/lib/mathutil/mathutil.go
      package mathutil

      import "errors"

      // Add returns the sum of a and b.
      func Add(a, b int) int {
        // TODO: implement
        return 0
      }

      // Divide returns a/b or error if b==0.
      func Divide(a, b float64) (float64, error) {
        // TODO: implement with division-by-zero guard
        return 0, errors.New("not implemented")
      }
    GO
    tests: {
      run: 'cd examples/go-basics && (go mod init example.com/basics >/dev/null 2>&1 || true) && go test ./... -count=1',
      visible: ['TestAdd', 'TestDivide'],
      hidden: ['TestDivideByZero']
    },
    require_pass: true,
    hints: ['Return a+b from Add', 'Check b==0 in Divide and return an error', 'Use a named error or errors.New']
  }
)

# === MICROLESSON 2: Concurrency vs Parallelism ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Concurrency vs Parallelism',
  content: <<~MARKDOWN,
# Concurrency vs Parallelism 🚀

# Concurrency vs Parallelism

    ## The Difference

    **Concurrency** is about *dealing with* many things at once.
    **Parallelism** is about *doing* many things at once.

    ### Concurrency
    - **Structure**: How you organize your program
    - **Composition**: Breaking down problems into independently executing tasks
    - **Can run on**: Single or multiple cores
    - **Example**: A juggler juggling multiple balls (one person, multiple tasks)

    ### Parallelism
    - **Execution**: Actually running multiple tasks simultaneously
    - **Performance**: Doing multiple computations at the same time
    - **Requires**: Multiple cores/processors
    - **Example**: Multiple jugglers each juggling their own balls

    ## Why Go Excels at Concurrency

    Go was designed from the ground up with concurrency in mind:

    1. **Goroutines**: Lightweight threads managed by Go runtime
    2. **Channels**: Safe communication between goroutines
    3. **Select Statement**: Multiplexing channel operations
    4. **Race Detector**: Built-in tool to find race conditions
    5. **Sync Package**: Primitives for synchronization

    ## Real-World Analogy

    Think of a restaurant:

    ### Concurrent (Single Chef, Multiple Orders)
    ```
    Chef starts cooking Order 1 → While waiting for pasta to boil
    → Starts chopping vegetables for Order 2
    → Pasta done, back to Order 1
    → Continues Order 2
    ```
    One chef handling multiple orders by switching between them.

    ### Parallel (Multiple Chefs, Multiple Orders)
    ```
    Chef 1: Cooking Order 1
    Chef 2: Cooking Order 2
    Chef 3: Cooking Order 3
    (All at the same time)
    ```
    Multiple chefs working simultaneously.

    ## Go's Concurrency Model: CSP

    Go uses **Communicating Sequential Processes (CSP)**:

    > "Don't communicate by sharing memory; share memory by communicating."

    Instead of:
    ```go
    // BAD: Sharing memory (requires locks)
    var counter int
    var mutex sync.Mutex

    mutex.Lock()
    counter++
    mutex.Unlock()
    ```

    Do this:
    ```go
    // GOOD: Communicating via channels
    counterChan := make(chan int)

    go func() {
        counter := 0
        for {
            counter++
            counterChan <- counter
        }
    }()

    value := <-counterChan  // Receive from channel
    ```

    ## When to Use Concurrency

    ✅ **Good Use Cases:**
    - I/O-bound operations (network requests, file operations)
    - Handling multiple client connections
    - Processing independent tasks
    - Event-driven systems
    - Background workers

    ❌ **Not Ideal For:**
    - CPU-bound operations with shared state
    - Simple, fast operations (overhead not worth it)
    - Operations that must be strictly sequential

    ## Performance Characteristics

    ### Goroutines vs OS Threads

    | Feature | Goroutines | OS Threads |
    |---------|------------|------------|
    | Memory | 2 KB initial stack | 1-2 MB stack |
    | Creation | Fast (~microseconds) | Slow (~milliseconds) |
    | Context Switch | Cheap | Expensive |
    | Max Number | Millions | Thousands |
    | Managed By | Go runtime | OS kernel |

    ### Example: 1 Million Goroutines

    ```go
    package main

    import (
        "fmt"
        "runtime"
        "time"
    )

    func main() {
        fmt.Printf("Starting goroutines: %d\\n", runtime.NumGoroutine())

        for i := 0; i < 1000000; i++ {
            go func() {
                time.Sleep(10 * time.Second)
            }()
        }

        time.Sleep(1 * time.Second)
        fmt.Printf("Active goroutines: %d\\n", runtime.NumGoroutine())
        // Output: Active goroutines: 1000001
        // Memory used: ~2 GB (very efficient!)
    }
    ```

    Try doing this with OS threads - your system would crash!

    ## Key Takeaways

    1. **Concurrency** = Structure (composition of independently executing tasks)
    2. **Parallelism** = Execution (simultaneous execution on multiple cores)
    3. Go makes concurrent programming **simple and safe**
    4. Goroutines are **extremely lightweight** compared to threads
    5. Use **channels** to communicate between goroutines
    6. Go's philosophy: **"Share memory by communicating"**

    Next, we'll dive deep into goroutines!
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 2.1: MCQ
Exercise.create!(
  micro_lesson: lesson_2,
  exercise_type: 'mcq',
  sequence_order: 1,
  exercise_data: {
    require_pass: true,
    question: 'Concurrency means...',
    options: [
      'Structuring a program to handle multiple tasks by interleaving progress',
      'Running multiple tasks strictly at the same time on multiple CPUs',
      'Using threads instead of goroutines',
      'Using time.Sleep to coordinate'
    ],
    correct_answer: 0,
    explanation: 'Concurrency is a design to manage multiple tasks; parallelism is simultaneous execution.',
    difficulty: 'easy'
  }
)

# === MICROLESSON 3: Introduction to Goroutines ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Introduction to Goroutines',
  content: <<~MARKDOWN,
# Introduction to Goroutines 🚀

# Introduction to Goroutines

    A **goroutine** is a lightweight thread of execution managed by the Go runtime. They're one of Go's most powerful features!

    ## Creating a Goroutine

    Simply add `go` before a function call:

    ```go
    package main

    import (
        "fmt"
        "time"
    )

    func sayHello() {
        fmt.Println("Hello from goroutine!")
    }

    func main() {
        go sayHello()  // Launch as goroutine

        time.Sleep(1 * time.Second)  // Wait for goroutine to finish
        fmt.Println("Main function")
    }
    ```

    ## How Goroutines Work

    ### Sequential Execution (Normal)
    ```go
    func main() {
        task1()  // Wait for task1 to finish
        task2()  // Then do task2
        task3()  // Then do task3
    }
    // Timeline: [task1] → [task2] → [task3]
    ```

    ### Concurrent Execution (With Goroutines)
    ```go
    func main() {
        go task1()  // Start task1 in background
        go task2()  // Start task2 in background
        go task3()  // Start task3 in background

        time.Sleep(time.Second)  // Wait for them to finish
    }
    // Timeline: [task1, task2, task3] all running concurrently
    ```

    ## Anonymous Function Goroutines

    You can launch goroutines with anonymous functions:

    ```go
    func main() {
        // Launch inline
        go func() {
            fmt.Println("Anonymous goroutine!")
        }()

        // With parameters
        message := "Hello"
        go func(msg string) {
            fmt.Println(msg)
        }(message)  // Pass by value

        time.Sleep(time.Second)
    }
    ```

    ## Multiple Goroutines Example

    ```go
    package main

    import (
        "fmt"
        "time"
    )

    func worker(id int) {
        fmt.Printf("Worker %d starting\\n", id)
        time.Sleep(time.Second)
        fmt.Printf("Worker %d done\\n", id)
    }

    func main() {
        // Launch 5 workers concurrently
        for i := 1; i <= 5; i++ {
            go worker(i)
        }

        // Wait for goroutines to finish
        time.Sleep(2 * time.Second)
        fmt.Println("All workers complete")
    }
    ```

    Output (order may vary):
    ```
    Worker 1 starting
    Worker 3 starting
    Worker 2 starting
    Worker 5 starting
    Worker 4 starting
    Worker 2 done
    Worker 1 done
    Worker 4 done
    Worker 3 done
    Worker 5 done
    All workers complete
    ```

    ## Common Pitfalls

    ### 1. Main Function Exits Too Early

    ❌ **Problem:**
    ```go
    func main() {
        go fmt.Println("Hello")
        // Program exits immediately, goroutine may not run!
    }
    ```

    ✅ **Solution:** Use synchronization (we'll learn WaitGroups next)

    ### 2. Loop Variable Closure

    ❌ **Problem:**
    ```go
    for i := 0; i < 5; i++ {
        go func() {
            fmt.Println(i)  // All goroutines see i=5!
        }()
    }
    ```

    ✅ **Solution:** Pass as parameter
    ```go
    for i := 0; i < 5; i++ {
        go func(num int) {
            fmt.Println(num)  // Each gets its own copy
        }(i)
    }
    ```

    ### 3. Shared Memory Without Synchronization

    ❌ **Problem:**
    ```go
    counter := 0
    for i := 0; i < 1000; i++ {
        go func() {
            counter++  // RACE CONDITION!
        }()
    }
    ```

    ✅ **Solution:** Use channels or sync primitives (coming up next)

    ## Goroutine Lifecycle

    ```
    Create → Runnable → Running → Blocked → Runnable → ... → Dead
                ↑                    ↓
                └────────────────────┘
    ```

    **States:**
    - **Runnable**: Ready to run, waiting for CPU
    - **Running**: Currently executing on a CPU
    - **Blocked**: Waiting for I/O, channel, or sleep
    - **Dead**: Finished execution

    ## The Go Scheduler

    Go uses an **M:N scheduler**:
    - **M goroutines** run on **N OS threads**
    - Go runtime manages the mapping
    - Scheduler is cooperative (goroutines yield at function calls, channel ops, etc.)

    ### GOMAXPROCS

    Controls how many OS threads can execute goroutines simultaneously:

    ```go
    import "runtime"

    func main() {
        // Use all CPU cores
        runtime.GOMAXPROCS(runtime.NumCPU())

        // Or set specific number
        runtime.GOMAXPROCS(4)
    }
    ```

    By default, `GOMAXPROCS = runtime.NumCPU()`

    ## Practical Example: Concurrent Web Scraper

    ```go
    package main

    import (
        "fmt"
        "time"
    )

    func fetchURL(url string) {
        fmt.Printf("Fetching %s...\\n", url)
        time.Sleep(500 * time.Millisecond)  // Simulate network delay
        fmt.Printf("Completed %s\\n", url)
    }

    func main() {
        urls := []string{
            "https://golang.org",
            "https://github.com",
            "https://stackoverflow.com",
            "https://reddit.com",
        }

        start := time.Now()

        // Sequential (slow)
        // for _, url := range urls {
        //     fetchURL(url)
        // }
        // Time: ~2 seconds (4 × 0.5s)

        // Concurrent (fast!)
        for _, url := range urls {
            go fetchURL(url)
        }

        time.Sleep(1 * time.Second)
        elapsed := time.Since(start)
        fmt.Printf("\\nTotal time: %s\\n", elapsed)
        // Time: ~1 second (all run concurrently)
    }
    ```

    ## When to Use Goroutines

    ✅ **Great for:**
    - I/O operations (network, disk, database)
    - Independent tasks that can run concurrently
    - Event handling and message processing
    - Background workers
    - Fan-out/fan-in patterns

    ❌ **Avoid for:**
    - CPU-intensive tasks with dependencies
    - Operations requiring strict ordering
    - Very short-lived tasks (overhead not worth it)

    ## Best Practices

    1. **Always synchronize**: Never let goroutines outlive main without coordination
    2. **Pass data by value**: Avoid sharing pointers between goroutines
    3. **Know when goroutines end**: Use WaitGroups or channels to track completion
    4. **Limit goroutine count**: Don't create millions unnecessarily
    5. **Use contexts**: For cancellation and timeouts

    ## Next Steps

    Now that you understand goroutines, let's learn how they communicate using **channels**!

    Practice what you've learned in the "Go Concurrency Basics" lab!
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 4: Introduction to Channels ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Introduction to Channels',
  content: <<~MARKDOWN,
# Introduction to Channels 🚀

# Introduction to Channels

    **Channels** are Go's way of letting goroutines communicate safely. Think of them as pipes that connect concurrent functions.

    ## Creating Channels

    ```go
    // Create a channel of integers
    ch := make(chan int)

    // Buffered channel (can hold 5 values)
    buffered := make(chan string, 5)

    // Receive-only channel (can only receive)
    var receive <-chan int

    // Send-only channel (can only send)
    var send chan<- int
    ```

    ## Channel Operations

    ### Send
    ```go
    ch <- 42  // Send value 42 to channel ch
    ```

    ### Receive
    ```go
    value := <-ch  // Receive value from channel and assign to value

    // Receive and discard
    <-ch

    // Check if channel is closed
    value, ok := <-ch
    if !ok {
        fmt.Println("Channel closed!")
    }
    ```

    ### Close
    ```go
    close(ch)  // Close the channel (no more sends allowed)
    ```

    ## Basic Example

    ```go
    package main

    import "fmt"

    func sendData(ch chan string) {
        ch <- "Hello from goroutine!"
    }

    func main() {
        // Create channel
        messageChan := make(chan string)

        // Start goroutine
        go sendData(messageChan)

        // Receive from channel (blocks until data arrives)
        message := <-messageChan
        fmt.Println(message)
    }
    ```

    ## Unbuffered vs Buffered Channels

    ### Unbuffered Channels (Default)

    ```go
    ch := make(chan int)  // Unbuffered

    // Send blocks until someone receives
    // Receive blocks until someone sends
    ```

    **Characteristics:**
    - Send blocks until receive happens
    - Receive blocks until send happens
    - Provides **synchronization**
    - Guarantees delivery

    **Visual:**
    ```
    Sender ─────[Handshake]─────> Receiver
            (both must be ready)
    ```

    Example:
    ```go
    func main() {
        ch := make(chan int)

        go func() {
            fmt.Println("Goroutine: Sending...")
            ch <- 42  // Blocks until main receives
            fmt.Println("Goroutine: Sent!")
        }()

        time.Sleep(2 * time.Second)
        fmt.Println("Main: Receiving...")
        value := <-ch  // Blocks until goroutine sends
        fmt.Println("Main: Received", value)
    }
    ```

    Output:
    ```
    Goroutine: Sending...
    (2 second pause)
    Main: Receiving...
    Goroutine: Sent!
    Main: Received 42
    ```

    ### Buffered Channels

    ```go
    ch := make(chan int, 3)  // Buffer size of 3

    // Can send 3 values without blocking
    ch <- 1  // Doesn't block
    ch <- 2  // Doesn't block
    ch <- 3  // Doesn't block
    ch <- 4  // BLOCKS (buffer full)
    ```

    **Visual:**
    ```
    Sender → [Buffer: |||] → Receiver
             (can hold 3 items)
    ```

    Example:
    ```go
    func main() {
        ch := make(chan string, 2)

        // Send 2 values (won't block, buffer holds them)
        ch <- "first"
        ch <- "second"
        // ch <- "third"  // Would block! Buffer full

        // Receive them
        fmt.Println(<-ch)  // "first"
        fmt.Println(<-ch)  // "second"
    }
    ```

    ## Channel Directions

    Restrict channel operations for safety:

    ```go
    // Send-only channel
    func sendOnly(ch chan<- int) {
        ch <- 42
        // value := <-ch  // ERROR: can't receive
    }

    // Receive-only channel
    func receiveOnly(ch <-chan int) {
        value := <-ch
        // ch <- 42  // ERROR: can't send
    }

    func main() {
        ch := make(chan int)

        go sendOnly(ch)
        receiveOnly(ch)
    }
    ```

    ## Range Over Channels

    Loop until channel is closed:

    ```go
    func producer(ch chan int) {
        for i := 0; i < 5; i++ {
            ch <- i
        }
        close(ch)  // Signal: no more data
    }

    func main() {
        ch := make(chan int)

        go producer(ch)

        // Range reads until channel is closed
        for value := range ch {
            fmt.Println(value)
        }
    }
    ```

    Output:
    ```
    0
    1
    2
    3
    4
    ```

    ## Common Patterns

    ### 1. Worker Pool

    ```go
    func worker(id int, jobs <-chan int, results chan<- int) {
        for job := range jobs {
            fmt.Printf("Worker %d processing job %d\\n", id, job)
            time.Sleep(time.Second)
            results <- job * 2
        }
    }

    func main() {
        jobs := make(chan int, 100)
        results := make(chan int, 100)

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

    ### 2. Pipeline

    ```go
    // Stage 1: Generate numbers
    func generate(nums ...int) <-chan int {
        out := make(chan int)
        go func() {
            for _, n := range nums {
                out <- n
            }
            close(out)
        }()
        return out
    }

    // Stage 2: Square numbers
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
        // Pipeline: generate → square
        numbers := generate(1, 2, 3, 4)
        squares := square(numbers)

        // Print results
        for result := range squares {
            fmt.Println(result)
        }
    }
    ```

    Output:
    ```
    1
    4
    9
    16
    ```

    ### 3. Fan-out, Fan-in

    ```go
    func fanOut(input <-chan int, workers int) []<-chan int {
        channels := make([]<-chan int, workers)
        for i := 0; i < workers; i++ {
            channels[i] = doWork(input)
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
                for n := range c {
                    out <- n
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

    ## Deadlock

    **Deadlock** occurs when goroutines are waiting for each other indefinitely.

    ❌ **Causes deadlock:**
    ```go
    func main() {
        ch := make(chan int)
        ch <- 42  // Blocks forever (no receiver)
        fmt.Println(<-ch)
    }
    // fatal error: all goroutines are asleep - deadlock!
    ```

    ✅ **Fixed:**
    ```go
    func main() {
        ch := make(chan int)

        go func() {
            ch <- 42  // Send in goroutine
        }()

        fmt.Println(<-ch)  // Receive in main
    }
    ```

    ## Best Practices

    1. **Close channels from sender side**: Never close from receiver
    2. **Don't close twice**: Panic! Check if closed before closing
    3. **Closing is optional**: For signaling "done" or when using `range`
    4. **Buffered for known capacity**: Use buffered when you know max pending items
    5. **Unbuffered for synchronization**: When you need handshake guarantee

    ## Channel Axioms

    1. Send to `nil` channel blocks forever
    2. Receive from `nil` channel blocks forever
    3. Send to closed channel panics
    4. Receive from closed channel returns zero value immediately
    5. Closing `nil` channel panics
    6. Closing closed channel panics

    Next: Learn the **select** statement for multiplexing channels!
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 4 microlessons for Go Basics"
