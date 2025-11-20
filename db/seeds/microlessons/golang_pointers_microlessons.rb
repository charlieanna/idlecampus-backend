# AUTO-GENERATED from golang_pointers.rb
puts "Creating Microlessons for Golang Pointers..."

module_var = CourseModule.find_by(slug: 'golang-pointers')

# === MICROLESSON 1: Pointers in Go ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Pointers in Go',
  content: <<~MARKDOWN,
# Pointers in Go 🚀

# Pointers in Go

    Pointers are variables that store memory addresses. Understanding pointers is essential for efficient Go programming and is crucial for working with methods and large data structures.

    ## What is a Pointer?

    A pointer holds the memory address of a value, not the value itself.

    ```go
    var x int = 42
    var p *int = &x  // p is a pointer to an int

    fmt.Println(x)   // 42 (the value)
    fmt.Println(&x)  // 0xc0000140b8 (memory address)
    fmt.Println(p)   // 0xc0000140b8 (same address)
    fmt.Println(*p)  // 42 (dereference - get the value at address)
    ```

    **Key operators:**
    - `&` - Address-of operator (gets memory address)
    - `*` - Dereference operator (gets value at address)
    - `*Type` - Pointer type declaration

    ## Why Use Pointers?

    **1. Modify Original Values**

    Without pointers, Go passes values by copy:

    ```go
    func increment(x int) {
        x = x + 1
        fmt.Println("Inside:", x)  // 11
    }

    func main() {
        num := 10
        increment(num)
        fmt.Println("Outside:", num)  // Still 10! (not modified)
    }
    ```

    With pointers, you can modify the original:

    ```go
    func increment(x *int) {
        *x = *x + 1  // Modify value at address
    }

    func main() {
        num := 10
        increment(&num)  // Pass address
        fmt.Println(num)  // 11 (modified!)
    }
    ```

    **2. Avoid Copying Large Structures**

    Passing large structs by value copies all data. Pointers are more efficient:

    ```go
    type LargeStruct struct {
        data [1000000]int
    }

    // Inefficient - copies entire struct
    func processByValue(ls LargeStruct) {
        // Works with a copy
    }

    // Efficient - passes only address (8 bytes)
    func processByPointer(ls *LargeStruct) {
        // Works with original
    }
    ```

    ## Declaring and Using Pointers

    ```go
    var x int = 10

    // Method 1: Declare pointer and assign
    var p *int
    p = &x

    // Method 2: Short declaration
    p := &x

    // Method 3: Using new() - allocates memory
    p := new(int)  // p points to a new int (zero value)
    *p = 42        // Set the value

    fmt.Println(*p)  // 42
    ```

    ## Nil Pointers

    A pointer with no value is `nil`:

    ```go
    var p *int
    fmt.Println(p)  // nil

    if p == nil {
        fmt.Println("Pointer is nil")
    }

    // Dereferencing nil pointer causes panic!
    // *p = 10  // panic: runtime error
    ```

    ## Pointers and Structs

    Pointers are commonly used with structs:

    ```go
    type Person struct {
        Name string
        Age  int
    }

    func main() {
        // Method 1: Regular struct
        p1 := Person{Name: "Alice", Age: 25}

        // Method 2: Pointer to struct using &
        p2 := &Person{Name: "Bob", Age: 30}

        // Method 3: Using new
        p3 := new(Person)
        p3.Name = "Carol"
        p3.Age = 28

        // Accessing fields (Go auto-dereferences)
        fmt.Println(p2.Name)  // Bob (same as (*p2).Name)
    }
    ```

    **Go's convenience:** You can use `.` on pointer to struct (Go dereferences automatically):

    ```go
    p := &Person{Name: "Alice"}

    // These are equivalent:
    p.Name = "Bob"
    (*p).Name = "Bob"

    // Both work, but first is more idiomatic
    ```

    ## Modifying Struct Fields

    ```go
    type Counter struct {
        count int
    }

    // Won't modify original (receives copy)
    func incrementByValue(c Counter) {
        c.count++
    }

    // Will modify original (receives pointer)
    func incrementByPointer(c *Counter) {
        c.count++
    }

    func main() {
        counter := Counter{count: 0}

        incrementByValue(counter)
        fmt.Println(counter.count)  // 0 (not changed)

        incrementByPointer(&counter)
        fmt.Println(counter.count)  // 1 (changed!)
    }
    ```

    ## When to Use Pointers vs Values

    **Use Pointers when:**
    - ✅ Function needs to modify the value
    - ✅ Struct is large (avoid copying overhead)
    - ✅ You need to represent "no value" (nil)
    - ✅ Sharing data between goroutines (with proper sync)

    **Use Values when:**
    - ✅ Data is small (ints, bools, small structs)
    - ✅ Value should not be modified
    - ✅ Simplicity is preferred
    - ✅ You want immutability

    ## Slice and Map Pointers

    **Important:** Slices and maps are already reference types! You usually don't need pointers to them:

    ```go
    // ❌ Usually unnecessary
    func addToSlice(s *[]int, val int) {
        *s = append(*s, val)
    }

    // ✅ Better - slices are already references
    func addToSlice(s []int, val int) []int {
        return append(s, val)
    }

    // Maps work similarly
    func updateMap(m map[string]int) {
        m["key"] = 10  // Modifies original map
    }
    ```

    ## Common Pointer Patterns

    ### 1. Factory Functions

    ```go
    func NewPerson(name string, age int) *Person {
        return &Person{
            Name: name,
            Age:  age,
        }
    }

    p := NewPerson("Alice", 25)
    ```

    ### 2. Optional Fields

    ```go
    type Config struct {
        Host    string
        Port    *int  // Optional - can be nil
        Timeout *int  // Optional
    }

    config := Config{
        Host: "localhost",
        Port: intPtr(8080),  // Helper function
    }

    func intPtr(i int) *int {
        return &i
    }
    ```

    ### 3. Linked Lists

    ```go
    type Node struct {
        Value int
        Next  *Node  // Points to next node (or nil)
    }

    head := &Node{Value: 1}
    head.Next = &Node{Value: 2}
    head.Next.Next = &Node{Value: 3}
    ```

    ## Pointer Pitfalls

    ### 1. Loop Variable Pointers

    ```go
    // ❌ WRONG - all pointers point to same variable
    var pointers []*int
    for i := 0; i < 3; i++ {
        pointers = append(pointers, &i)
    }
    // All pointers point to i (final value: 3)

    // ✅ CORRECT - create new variable each iteration
    var pointers []*int
    for i := 0; i < 3; i++ {
        num := i  // New variable
        pointers = append(pointers, &num)
    }
    ```

    ### 2. Nil Pointer Dereference

    ```go
    var p *int
    // *p = 10  // ❌ PANIC - nil pointer

    // ✅ Always check for nil
    if p != nil {
        *p = 10
    }
    ```

    ## Performance Considerations

    From benchmarks, for small structs (< 32 bytes), passing by value is often faster than pointers due to CPU cache efficiency. For larger structs, pointers are more efficient.

    ```go
    type SmallStruct struct {
        x, y int
    }
    // Pass by value - efficient (16 bytes)

    type LargeStruct struct {
        data [1000]int
    }
    // Pass by pointer - efficient (avoids 8KB copy)
    ```

    ## Summary

    - **Pointers store memory addresses, not values**
    - **`&` gets address, `*` dereferences (gets value)**
    - **Use pointers to modify original values**
    - **Use pointers to avoid copying large structs**
    - **Slices and maps are already references**
    - **Nil pointers are valid but dangerous to dereference**
    - **Consider size and mutability when choosing pointers vs values**
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
    question: 'Which operator dereferences a pointer in Go?',
    options: ['*', '&', '->', '@'],
    correct_answer: 0,
    explanation: '*p reads the value at the address held in p; &x gets x\'s address.',
    difficulty: 'easy'
  }
)

# Exercise 1.2: Code (increment by pointer)
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'code',
  sequence_order: 2,
  exercise_data: {
    files: ['examples/go-pointers/counter/counter.go','examples/go-pointers/counter/counter_test.go'],
    starter_code: <<~GO,
      // examples/go-pointers/counter/counter.go
      package counter

      // Inc increments *v by 1 using pointer semantics.
      func Inc(v *int) {
        // TODO: implement
      }
    GO
    tests: {
      run: 'cd examples/go-pointers && (go mod init example.com/pointers >/dev/null 2>&1 || true) && go test ./... -count=1',
      visible: ['TestInc'],
      hidden: ['TestIncMany']
    },
    require_pass: true,
    hints: ['Use *v to read/write the pointed value', 'Handle nil? (not required here)']
  }
)

puts "✓ Created 1 microlessons for Golang Pointers"
