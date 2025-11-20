# Go Pointers Lesson and Lab - Week 2
# Critical missing content from data structures module

puts "\n👉 Seeding Go Pointers Lesson..."

# Ensure course exists
go_course = Course.find_by!(slug: 'golang-fundamentals')

# Find or create Data Structures module
data_structures_mod = CourseModule.find_or_create_by!(course: go_course, slug: 'data-structures') do |mod|
  mod.title = 'Data Structures'
  mod.description = 'Learn about arrays, slices, maps, structs, and pointers in Go'
  mod.sequence_order = 2
  mod.estimated_minutes = 120
  mod.published = true
  mod.learning_objectives = [
    'Work with arrays and slices',
    'Use maps for key-value storage',
    'Define and use structs',
    'Understand pointers and memory addresses',
    'Know when to use pointers vs values'
  ]
end

# Lesson: Pointers in Go
pointers_lesson = Lesson.find_or_create_by!(slug: 'go-pointers') do |lesson|
  lesson.title = 'Pointers in Go'
  lesson.content = <<~MARKDOWN
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
  lesson.estimated_minutes = 25
  lesson.sequence_order = 4
  lesson.published = true
end

# Lab: Pointers and Struct Manipulation
pointers_lab = HandsOnLab.find_or_create_by!(title: 'Lab: Pointers and Struct Manipulation') do |lab|
  lab.description = 'Practice using pointers to modify structs and avoid copying'
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

    import "fmt"

    type Person struct {
        Name string
        Age  int
    }

    // TODO: Implement updateAge that takes a pointer to Person and updates the age
    func updateAge(p *Person, newAge int) {
        // Your code here
    }

    // TODO: Implement createPerson that returns a pointer to a new Person
    func createPerson(name string, age int) *Person {
        // Your code here
    }

    // TODO: Implement swap that swaps two integer values using pointers
    func swap(a *int, b *int) {
        // Your code here
    }

    func main() {
        // Test updateAge
        person := Person{Name: "Alice", Age: 25}
        updateAge(&person, 30)
        fmt.Println(person.Age)  // Should print: 30

        // Test createPerson
        p := createPerson("Bob", 35)
        fmt.Println(p.Name, p.Age)  // Should print: Bob 35

        // Test swap
        x, y := 10, 20
        swap(&x, &y)
        fmt.Println(x, y)  // Should print: 20 10
    }
  GOLANG

  lab.scenario_narrative = <<~MD
    Practice using pointers to modify data and create new structs.

    **Implement three functions:**

    1. `updateAge(p *Person, newAge int)` - Updates the age field of a Person
    2. `createPerson(name string, age int) *Person` - Returns a pointer to a new Person
    3. `swap(a *int, b *int)` - Swaps the values of two integers

    **Requirements:**
    - Use pointers to modify original values
    - Return pointers from factory functions
    - Properly dereference pointers when needed
  MD

  lab.steps = [
    {
      step_number: 1,
      title: 'Implement updateAge',
      instruction: 'Update the Age field of the Person that p points to',
      hint: 'p.Age = newAge (Go auto-dereferences struct pointers)'
    },
    {
      step_number: 2,
      title: 'Implement createPerson',
      instruction: 'Create and return a pointer to a new Person struct',
      hint: 'return &Person{Name: name, Age: age}'
    },
    {
      step_number: 3,
      title: 'Implement swap',
      instruction: 'Swap the values at addresses a and b',
      hint: 'temp := *a; *a = *b; *b = temp'
    }
  ]

  lab.learning_objectives = [
    'Use pointers to modify original values',
    'Return pointers from functions',
    'Understand pointer dereferencing',
    'Work with pointer syntax'
  ]

  lab.test_cases = [
    {
      name: 'updateAge modifies original',
      input: 'Person{Age: 25} updated to 30',
      expected_output: '30',
      is_hidden: false
    },
    {
      name: 'createPerson returns pointer',
      input: 'createPerson("Bob", 35)',
      expected_output: 'Bob 35',
      is_hidden: false
    },
    {
      name: 'swap exchanges values',
      input: 'swap 10 and 20',
      expected_output: '20 10',
      is_hidden: false
    }
  ]
end

# Link lesson and lab to module
ModuleItem.find_or_create_by!(course_module: data_structures_mod, item: pointers_lesson) do |mi|
  mi.sequence_order = 4
  mi.required = true
end

ModuleItem.find_or_create_by!(course_module: data_structures_mod, item: pointers_lab) do |mi|
  mi.sequence_order = 5
  mi.required = true
end

puts "✅ Go Pointers content seeded:"
puts "   - #{pointers_lesson.title}"
puts "   - #{pointers_lab.title}"
