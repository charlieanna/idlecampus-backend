# Go Programming Course - Enhanced with Quizzes and Additional Modules
puts "Creating Enhanced Go Programming Course..."

# Create Go Course
go_course = Course.find_or_create_by!(slug: 'golang-fundamentals') do |course|
  course.title = 'Go Programming Fundamentals'
  course.description = 'Master Go programming with deep focus on concurrency, goroutines, channels, and production-ready code'
  course.difficulty_level = 'intermediate'
  course.certification_track = nil
  course.published = true
  course.sequence_order = 2
  course.estimated_hours = 35
  course.learning_objectives = JSON.generate([
    "Master Go syntax, types, and functions",
    "Build concurrent programs with goroutines and channels",
    "Implement interfaces and write idiomatic Go code",
    "Test Go applications effectively",
    "Build production-ready Go applications"
  ])
end

puts "Created course: #{go_course.title}"

# ==========================================
# MODULE 1: Go Basics (existing content preserved)
# ==========================================

module1 = CourseModule.find_or_create_by!(slug: 'go-basics', course: go_course) do |mod|
  mod.title = 'Go Basics'
  mod.description = 'Learn Go fundamentals: syntax, types, functions, and control flow'
  mod.sequence_order = 1
  mod.estimated_minutes = 60
  mod.published = true
end

# Existing Lesson 1.1 preserved from original file
lesson1_1 = CourseLesson.find_or_create_by!(title: "Introduction to Go") do |lesson|
  lesson.reading_time_minutes = 20
  lesson.content = <<~MARKDOWN
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

    ### What is Static Typing?

    **Static typing** means every variable has a fixed type that must be known at compile time. Once a variable is declared as a string, it can ONLY hold strings - never numbers or booleans.

    **Why does this matter?**
    - **Catches errors early**: Type mismatches are caught before your program runs
    - **Better performance**: No runtime type checking overhead
    - **Better tooling**: IDEs can provide accurate autocomplete and refactoring
    - **Self-documenting**: The code clearly shows what type of data it works with

    **Contrast with dynamic typing (Python, JavaScript):**
    ```python
    # Python - type changes at runtime
    x = "hello"    # x is a string
    x = 42         # Now x is an integer - allowed!
    x = True       # Now x is a boolean - allowed!
    ```

    ```go
    // Go - type is fixed at compile time
    var x string = "hello"  // x is a string
    x = 42                   // ERROR: cannot assign int to string
    ```

    ### Variable Declaration: Two Ways

    **Method 1: Explicit type declaration with `var`**
    ```go
    var name string = "John"
    var age int = 30
    var salary float64 = 50000.50
    var isActive bool = true
    ```

    **What happens here:**
    1. `var` keyword tells Go "I'm declaring a variable"
    2. `name` is the variable name
    3. `string` explicitly specifies the type
    4. `"John"` is the initial value

    **When to use:**
    - Package-level variables (outside functions)
    - When you want to be explicit about the type
    - When declaring without initialization: `var count int` (defaults to 0)

    **Method 2: Short declaration with `:=` (type inference)**
    ```go
    city := "New York"  // Go infers type: string
    count := 42         // Go infers type: int
    price := 19.99      // Go infers type: float64
    active := true      // Go infers type: bool
    ```

    **How type inference works:**
    Go's compiler examines the value on the right side and determines the type:
    - Text in quotes → `string`
    - Whole numbers → `int`
    - Decimal numbers → `float64`
    - `true`/`false` → `bool`

    **When to use `:=`:**
    - Inside functions (most common)
    - When the type is obvious from the value
    - Shorter, more readable code

    **Cannot use `:=` for:**
    - Package-level variables
    - Redeclaration (can only use once per variable name in a scope)

    ### Understanding Integer Types

    Go provides multiple integer types based on size:

    **Signed integers (can be negative):**
    - `int8`: -128 to 127 (1 byte)
    - `int16`: -32,768 to 32,767 (2 bytes)
    - `int32`: -2 billion to +2 billion (4 bytes)
    - `int64`: Very large numbers (8 bytes)
    - `int`: Size depends on system (32-bit or 64-bit)

    **Unsigned integers (only positive):**
    - `uint8`: 0 to 255
    - `uint16`: 0 to 65,535
    - `uint32`: 0 to 4 billion
    - `uint64`: 0 to 18 quintillion
    - `uint`: Size depends on system

    **When to use which:**
    - **Use `int` by default** - most common, Go compiler optimizes it
    - **Use `int64` for timestamps** - Unix timestamps require 64 bits
    - **Use `uint8` for bytes** - representing raw byte data
    - **Use specific sizes** only when interfacing with hardware/protocols that require exact sizes

    **Example: Why size matters**
    ```go
    var age int8 = 127     // OK
    age = 128              // ERROR: 128 doesn't fit in int8 (max is 127)

    var distance uint32 = 4000000000  // OK
    var distance2 uint16 = 4000000000 // ERROR: too big for uint16
    ```

    ### String Type

    **What is a string in Go?**

    A string is a **read-only** slice of bytes representing text encoded in UTF-8.

    ```go
    name := "Alice"
    greeting := "Hello, 世界"  // UTF-8 supports all Unicode characters
    ```

    **Key properties:**
    - **Immutable**: Once created, strings cannot be modified
    - **UTF-8 encoded**: Supports international characters
    - **Not arrays**: Strings are more than just character arrays

    **Why immutability matters:**
    ```go
    name := "Alice"
    name[0] = 'B'  // ERROR: cannot modify string

    // To "change" a string, create a new one:
    name = "Bob"   // OK: creates new string, assigns to name
    ```

    This prevents bugs where multiple parts of code accidentally modify shared strings.

    ### Float Types

    **Two floating-point types:**
    - `float32`: Single precision (6-7 decimal digits accuracy)
    - `float64`: Double precision (15-16 decimal digits accuracy)

    ```go
    var price float32 = 19.99
    var precise float64 = 3.141592653589793
    ```

    **When to use:**
    - **Use `float64` by default** - more accurate, and it's what Go literals default to
    - **Use `float32`** only when memory is critical (like graphics, large arrays)

    **Important: Floating-point precision issues**
    ```go
    // Floats can't represent all decimal numbers exactly
    var x float64 = 0.1 + 0.2
    fmt.Println(x)  // 0.30000000000000004 (not exactly 0.3!)
    ```

    **For money calculations, NEVER use float!** Use integers (cents) or the `decimal` package.

    ### Boolean Type

    **Simple true/false:**
    ```go
    var isActive bool = true
    var hasPermission bool = false
    ```

    **Used for:**
    - Control flow (if statements)
    - Flags and switches
    - Comparison results

    **Boolean operations:**
    ```go
    isAdult := age >= 18           // Comparison returns bool
    canVote := isAdult && isCitizen // && (AND)
    needsHelp := isChild || isElderly // || (OR)
    isInvalid := !isValid          // ! (NOT)
    ```

    ### Special Types: Byte and Rune

    **Byte (alias for uint8):**
    ```go
    var b byte = 'A'  // Single character (ASCII)
    ```
    Used for raw binary data, file I/O, network protocols.

    **Rune (alias for int32):**
    ```go
    var r rune = '世'  // Unicode character
    ```

    **Why runes exist:**
    ```go
    text := "Hello, 世界"
    fmt.Println(len(text))  // 13 (bytes, not characters!)

    // Count actual characters (runes):
    chars := []rune(text)
    fmt.Println(len(chars))  // 9 (actual characters)
    ```

    Strings are byte sequences, but runes let you work with actual characters.

    ### Zero Values: Go's Safety Net

    **Every type has a "zero value"** - variables without initialization automatically get this:

    ```go
    var name string      // "" (empty string)
    var count int        // 0
    var price float64    // 0.0
    var active bool      // false
    var ptr *int         // nil (null pointer)
    ```

    **Why this is important:**
    - **No undefined behavior**: Variables always have a valid value
    - **No null pointer exceptions** from uninitialized variables
    - **Predictable**: You know exactly what an uninitialized variable contains

    ### Type Conversion (Not Coercion!)

    Go requires **explicit type conversion** - no automatic conversions:

    ```go
    var x int = 42
    var y float64 = x        // ERROR: cannot assign int to float64

    var y float64 = float64(x)  // OK: explicit conversion
    ```

    **Common conversions:**
    ```go
    // Number conversions
    var i int = 42
    var f float64 = float64(i)
    var u uint = uint(i)

    // String conversions
    var num int = 65
    var s string = string(num)        // "A" (ASCII 65)
    var s2 string = strconv.Itoa(num) // "65" (number as text)

    // String to number
    str := "123"
    num, err := strconv.Atoi(str)  // 123, nil
    ```

    **Why no automatic conversion?**
    Explicit conversions prevent subtle bugs. You must consciously decide when to convert types.

    ### Practical Example: Type Safety in Action

    ```go
    // Function that calculates price with tax
    func calculateTotal(price float64, taxRate float64) float64 {
        return price * (1 + taxRate)
    }

    // Usage
    itemPrice := 29.99
    tax := 0.08  // 8%

    total := calculateTotal(itemPrice, tax)
    fmt.Printf("Total: $%.2f\n", total)  // Total: $32.39

    // This won't compile (type safety!):
    quantity := 3  // int
    total = calculateTotal(quantity, tax)  // ERROR: cannot use int as float64

    // Must explicitly convert:
    total = calculateTotal(float64(quantity), tax)  // OK
    ```

    **Key takeaways:**
    1. Static typing catches errors at compile time, not runtime
    2. Use `int` and `float64` as defaults unless you have specific needs
    3. The `:=` operator is your friend for concise variable declarations
    4. Go's zero values ensure variables are always initialized
    5. Explicit type conversion prevents subtle bugs

    ## Slices and Arrays

    ### Arrays: Fixed-Size Collections

    **What is an array?**

    An array is a **fixed-size**, numbered sequence of elements of the same type. Once you create an array, its size CANNOT change.

    ```go
    // Array declaration: [size]type
    var numbers [5]int = [5]int{1, 2, 3, 4, 5}

    // Shorter syntax
    nums := [3]int{10, 20, 30}

    // Let Go count the size
    items := [...]string{"a", "b", "c"}  // Size is 3
    ```

    **Key properties:**
    - **Fixed size**: Size is part of the type (`[5]int` is different from `[10]int`)
    - **Value type**: Arrays are copied when passed to functions (not references!)
    - **Memory efficient**: Stored contiguously in memory
    - **Rarely used**: Most Go code uses slices instead

    **Why arrays are rarely used:**
    ```go
    func process(arr [5]int) {  // Only accepts arrays of exactly 5 ints!
        // ...
    }

    nums1 := [5]int{1, 2, 3, 4, 5}
    nums2 := [10]int{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}

    process(nums1)  // OK
    process(nums2)  // ERROR: [10]int is not [5]int
    ```

    This inflexibility is why slices were created.

    ### Slices: Dynamic-Size Collections

    **What is a slice?**

    A slice is a **dynamic-size**, flexible view into an underlying array. Think of it as a "window" that can grow and shrink.

    **Anatomy of a slice:**
    A slice is actually three things:
    1. **Pointer**: Points to the first element in the underlying array
    2. **Length**: Number of elements in the slice (use `len()`)
    3. **Capacity**: Maximum elements the slice can hold before needing reallocation (use `cap()`)

    ```
    Underlying array: [A][B][C][D][E][F][G][H]
                       ↑
    Slice:            ptr  len=3  cap=8
    View:             [A][B][C]
    ```

    **Creating slices:**
    ```go
    // From a literal (most common)
    fruits := []string{"apple", "banana", "cherry"}

    // Make a slice with specific length and capacity
    scores := make([]int, 0, 10)
    // length=0 (empty now), capacity=10 (can hold 10 before reallocation)

    // Make with length (defaults to zero values)
    values := make([]int, 5)  // [0, 0, 0, 0, 0]

    // From an array
    arr := [5]int{1, 2, 3, 4, 5}
    slice := arr[1:4]  // [2, 3, 4] (from index 1 to 3)
    ```

    ### Understanding Length vs Capacity

    **Length** (`len`): How many elements are in the slice right now
    **Capacity** (`cap`): How many elements the slice can hold before needing more memory

    ```go
    s := make([]int, 3, 5)
    fmt.Println(len(s))  // 3 (current elements)
    fmt.Println(cap(s))  // 5 (max before reallocation)

    // The slice looks like: [0, 0, 0] with room for 2 more
    ```

    **Why capacity matters:**
    When you append beyond capacity, Go allocates a NEW, larger array and copies everything over - expensive!

    ### Appending to Slices

    **The append() function:**
    ```go
    fruits := []string{"apple", "banana"}
    fruits = append(fruits, "cherry")      // Add one element
    fruits = append(fruits, "date", "fig") // Add multiple
    fmt.Println(fruits)  // [apple banana cherry date fig]
    ```

    **CRITICAL: append returns a NEW slice!**
    ```go
    fruits := []string{"apple", "banana"}
    append(fruits, "cherry")  // ❌ WRONG: doesn't modify fruits!

    fruits = append(fruits, "cherry")  // ✅ CORRECT: assigns result
    ```

    **How append works internally:**

    **Case 1: Capacity available**
    ```go
    s := make([]int, 2, 5)  // len=2, cap=5
    s = append(s, 10)       // Fits within capacity
    // No new allocation, just increases length
    ```

    **Case 2: No capacity - reallocation needed**
    ```go
    s := []int{1, 2, 3}     // len=3, cap=3
    s = append(s, 4)        // Exceeds capacity!

    // Go does:
    // 1. Allocates new array (usually 2x capacity)
    // 2. Copies all existing elements
    // 3. Adds new element
    // 4. Returns new slice pointing to new array
    ```

    **Performance tip:**
    If you know final size, pre-allocate capacity:
    ```go
    // ❌ Slow: multiple reallocations
    s := []int{}
    for i := 0; i < 1000; i++ {
        s = append(s, i)  // Reallocates ~10 times
    }

    // ✅ Fast: one allocation
    s := make([]int, 0, 1000)
    for i := 0; i < 1000; i++ {
        s = append(s, i)  // No reallocations!
    }
    ```

    ### Slice Operations

    **Accessing elements:**
    ```go
    fruits := []string{"apple", "banana", "cherry"}
    first := fruits[0]      // "apple"
    last := fruits[len(fruits)-1]  // "cherry"
    ```

    **Slicing (creating sub-slices):**
    ```go
    numbers := []int{0, 1, 2, 3, 4, 5}

    slice1 := numbers[1:4]   // [1, 2, 3] (index 1 to 3)
    slice2 := numbers[:3]    // [0, 1, 2] (start to index 2)
    slice3 := numbers[2:]    // [2, 3, 4, 5] (index 2 to end)
    slice4 := numbers[:]     // [0, 1, 2, 3, 4, 5] (full slice)
    ```

    **Syntax: `[start:end]`**
    - Includes `start` index
    - Excludes `end` index
    - Creates a NEW slice pointing to SAME underlying array

    **⚠️ WARNING: Slices share memory!**
    ```go
    original := []int{1, 2, 3, 4, 5}
    slice := original[1:4]  // [2, 3, 4]

    slice[0] = 99           // Modifies slice
    fmt.Println(original)   // [1, 99, 3, 4, 5] - original changed too!
    ```

    They share the same underlying array! To avoid this, use `copy()`:
    ```go
    original := []int{1, 2, 3, 4, 5}
    slice := make([]int, 3)
    copy(slice, original[1:4])  // Copies data, no sharing

    slice[0] = 99
    fmt.Println(original)  // [1, 2, 3, 4, 5] - unchanged
    ```

    ### When to Use Arrays vs Slices

    **Use arrays when:**
    - Size is fixed and known at compile time
    - You need guaranteed size (cryptographic keys, coordinates)
    - Passing by value is desired (want a copy)

    **Use slices when (99% of the time):**
    - Size is dynamic or unknown
    - You want to pass by reference (no copying)
    - Working with functions that process collections

    ### Common Slice Patterns

    **Check if empty:**
    ```go
    if len(slice) == 0 {
        fmt.Println("Empty slice")
    }
    ```

    **Iterate over slice:**
    ```go
    fruits := []string{"apple", "banana", "cherry"}

    // With index and value
    for i, fruit := range fruits {
        fmt.Printf("%d: %s\n", i, fruit)
    }

    // Value only (ignore index with _)
    for _, fruit := range fruits {
        fmt.Println(fruit)
    }

    // Index only
    for i := range fruits {
        fmt.Println(i)
    }
    ```

    **Remove element (tricky!):**
    ```go
    // Remove element at index 2
    fruits := []string{"apple", "banana", "cherry", "date"}
    i := 2

    // Method: append slices before and after the element
    fruits = append(fruits[:i], fruits[i+1:]...)
    // Result: ["apple", "banana", "date"]
    ```

    **Key takeaways:**
    1. Arrays are fixed-size, slices are dynamic - use slices almost always
    2. Slices are references - modifying a slice can affect others sharing the same array
    3. append() returns a new slice - always assign the result
    4. Pre-allocate capacity with make() for better performance
    5. Slices are the foundation of many Go data structures

    ## Maps: Key-Value Storage

    ### What is a Map?

    A **map** is Go's built-in hash table data structure that stores key-value pairs. Think of it like a real dictionary: you look up a word (key) to get its definition (value).

    **Real-world analogy:**
    - Phone book: Name (key) → Phone number (value)
    - Student grades: Student ID (key) → Grade (value)
    - Configuration: Setting name (key) → Setting value (value)

    **Why use maps?**
    - **Fast lookups**: O(1) average time to find a value by key
    - **Dynamic**: Can add/remove entries anytime
    - **Flexible keys**: Use strings, ints, or any comparable type as keys

    ### Creating Maps

    **Method 1: Literal syntax (most common)**
    ```go
    // Map syntax: map[KeyType]ValueType
    ages := map[string]int{
        "Alice": 25,
        "Bob":   30,
    }
    ```

    **Method 2: Using make()**
    ```go
    // Create empty map
    scores := make(map[string]int)

    // Create with capacity hint (performance optimization)
    users := make(map[string]User, 100)  // Expect ~100 entries
    ```

    **Method 3: Declaration (nil map - read-only!)**
    ```go
    var settings map[string]string  // nil map
    // ⚠️ Cannot add to nil map! Will panic
    // settings["key"] = "value"  // PANIC!

    // Must initialize first:
    settings = make(map[string]string)
    settings["key"] = "value"  // OK
    ```

    ### Adding and Updating Values

    **Adding/updating is the same operation:**
    ```go
    ages := make(map[string]int)

    // Add new entry
    ages["Alice"] = 25      // Alice didn't exist, now she does

    // Update existing entry
    ages["Alice"] = 26      // Alice's age updated to 26
    ```

    **There's no difference between add and update!** If the key exists, it updates; if not, it adds.

    **Bulk initialization:**
    ```go
    inventory := map[string]int{
        "apples":  50,
        "bananas": 30,
        "oranges": 20,
    }
    ```

    ### Retrieving Values

    **Basic retrieval:**
    ```go
    ages := map[string]int{
        "Alice": 25,
        "Bob":   30,
    }

    age := ages["Alice"]  // 25
    ```

    **What happens if key doesn't exist?**
    ```go
    age := ages["Charlie"]  // Returns zero value (0 for int)
    ```

    ⚠️ **Problem**: Can't tell if Charlie doesn't exist or if Charlie's age is actually 0!

    **Solution: Two-value retrieval (the "comma ok" idiom)**
    ```go
    age, exists := ages["Alice"]
    if exists {
        fmt.Printf("Alice is %d years old\n", age)
    } else {
        fmt.Println("Alice not found")
    }

    // Or check directly:
    if age, ok := ages["Charlie"]; ok {
        fmt.Println("Charlie:", age)
    } else {
        fmt.Println("Charlie not found")  // This runs
    }
    ```

    **How it works:**
    - First value: The value associated with the key (or zero value if not found)
    - Second value: Boolean indicating if the key exists

    ### Deleting Entries

    **Use the built-in delete() function:**
    ```go
    ages := map[string]int{
        "Alice": 25,
        "Bob":   30,
    }

    delete(ages, "Bob")  // Removes Bob from map
    ```

    **Important behaviors:**
    - Deleting a non-existent key: Does nothing (no error)
    - Deleting from a nil map: Does nothing (no panic)

    ```go
    delete(ages, "Charlie")  // OK - Charlie doesn't exist, no-op

    var nilMap map[string]int
    delete(nilMap, "key")    // OK - does nothing
    ```

    ### Iterating Over Maps

    **Use range loop:**
    ```go
    ages := map[string]int{
        "Alice": 25,
        "Bob":   30,
        "Charlie": 35,
    }

    // Iterate over key-value pairs
    for name, age := range ages {
        fmt.Printf("%s is %d years old\n", name, age)
    }

    // Iterate over keys only
    for name := range ages {
        fmt.Println(name)
    }

    // Iterate over values only (ignore keys with _)
    for _, age := range ages {
        fmt.Println(age)
    }
    ```

    ⚠️ **CRITICAL: Map iteration order is RANDOM!**
    ```go
    // Run this multiple times - order changes each time:
    for name := range ages {
        fmt.Println(name)
    }
    // Output could be: Alice, Bob, Charlie
    // Or: Charlie, Alice, Bob
    // Or: Bob, Charlie, Alice
    ```

    **Why random?** Go intentionally randomizes iteration order to prevent you from relying on it. Hash maps have no inherent order!

    **Need sorted output?** Extract keys, sort them, then iterate:
    ```go
    // Get all keys
    names := make([]string, 0, len(ages))
    for name := range ages {
        names = append(names, name)
    }

    // Sort keys
    sort.Strings(names)

    // Iterate in sorted order
    for _, name := range names {
        fmt.Printf("%s: %d\n", name, ages[name])
    }
    ```

    ### Checking Map Length

    ```go
    ages := map[string]int{
        "Alice": 25,
        "Bob":   30,
    }

    count := len(ages)  // 2

    // Check if empty
    if len(ages) == 0 {
        fmt.Println("No entries")
    }
    ```

    ### Maps are Reference Types

    **Maps are passed by reference, not copied:**
    ```go
    func addYear(ages map[string]int) {
        for name := range ages {
            ages[name]++  // Modifies original map!
        }
    }

    ages := map[string]int{"Alice": 25}
    addYear(ages)
    fmt.Println(ages["Alice"])  // 26 - original map changed!
    ```

    This is different from slices (which are also references but to an underlying array). Maps are ALWAYS references.

    ### Common Patterns

    **1. Count occurrences:**
    ```go
    words := []string{"apple", "banana", "apple", "cherry", "banana", "apple"}
    counts := make(map[string]int)

    for _, word := range words {
        counts[word]++  // Zero value (0) + 1 = 1 for first occurrence
    }

    fmt.Println(counts)  // map[apple:3 banana:2 cherry:1]
    ```

    **2. Group items:**
    ```go
    students := []struct{Name string; Grade string}{
        {"Alice", "A"},
        {"Bob", "B"},
        {"Charlie", "A"},
        {"Dave", "B"},
    }

    byGrade := make(map[string][]string)

    for _, student := range students {
        byGrade[student.Grade] = append(byGrade[student.Grade], student.Name)
    }

    // Result: map[A:[Alice Charlie] B:[Bob Dave]]
    ```

    **3. Set (map with bool values):**
    ```go
    seen := make(map[string]bool)

    words := []string{"apple", "banana", "apple", "cherry"}
    unique := []string{}

    for _, word := range words {
        if !seen[word] {
            seen[word] = true
            unique = append(unique, word)
        }
    }

    // unique = ["apple", "banana", "cherry"]
    ```

    Or use empty struct for memory efficiency:
    ```go
    seen := make(map[string]struct{})  // struct{} takes 0 bytes!
    seen["key"] = struct{}{}

    if _, exists := seen["key"]; exists {
        // Key is in set
    }
    ```

    ### Valid Key Types

    **Keys must be comparable** (can use `==` and `!=`):

    ✅ **Valid key types:**
    - Strings, integers, floats, booleans
    - Pointers
    - Arrays (if element type is comparable)
    - Structs (if all fields are comparable)
    - Interfaces (if dynamic type is comparable)

    ❌ **Invalid key types:**
    - Slices (not comparable)
    - Maps (not comparable)
    - Functions (not comparable)

    ```go
    // ✅ OK
    map[string]int           // String keys
    map[int]string           // Int keys
    map[[3]int]bool          // Array keys

    // ❌ ERROR
    map[[]int]bool           // Slice keys - won't compile!
    map[map[string]int]bool  // Map keys - won't compile!
    ```

    ### Performance Characteristics

    **Time complexity:**
    - Lookup: O(1) average
    - Insert: O(1) average
    - Delete: O(1) average

    **Space complexity:**
    Maps use more memory than slices due to hash table overhead. Pre-allocate capacity if you know the size:

    ```go
    // Bad: Multiple rehashes
    m := make(map[string]int)
    for i := 0; i < 10000; i++ {
        m[fmt.Sprint(i)] = i  // Frequent resizing
    }

    // Good: Single allocation
    m := make(map[string]int, 10000)  // Pre-allocated
    for i := 0; i < 10000; i++ {
        m[fmt.Sprint(i)] = i  // No resizing
    }
    ```

    ### Map vs Slice: When to Use Which?

    **Use Map when:**
    - ✅ Need fast lookups by key
    - ✅ Keys are not sequential integers
    - ✅ Need to check existence
    - ✅ Order doesn't matter

    **Use Slice when:**
    - ✅ Sequential access (index 0, 1, 2...)
    - ✅ Order matters
    - ✅ Need to sort
    - ✅ Lower memory overhead

    **Example:**
    ```go
    // Good: User IDs aren't sequential
    userCache := map[string]*User{
        "user123": &User{Name: "Alice"},
        "user789": &User{Name: "Bob"},
    }

    // Good: Sequential high scores
    highScores := []int{1000, 950, 900, 850}  // Already ordered
    ```

    ### Common Mistakes

    **1. Adding to nil map:**
    ```go
    var m map[string]int
    m["key"] = 1  // PANIC: assignment to nil map

    // Fix: Initialize first
    m = make(map[string]int)
    m["key"] = 1  // OK
    ```

    **2. Not checking existence:**
    ```go
    age := ages["Unknown"]  // Returns 0 - but does Unknown exist?

    // Better:
    if age, ok := ages["Unknown"]; ok {
        // Use age
    }
    ```

    **3. Concurrent access without synchronization:**
    ```go
    // ⚠️ RACE CONDITION - will crash!
    m := make(map[string]int)

    go func() { m["key"] = 1 }()
    go func() { m["key"] = 2 }()

    // Fix: Use sync.Mutex or sync.Map
    ```

    ### Key Takeaways

    1. Maps store key-value pairs with O(1) lookup time
    2. Use `make()` to create empty maps (avoid nil maps)
    3. Use the "comma ok" idiom to check if keys exist
    4. Map iteration order is RANDOM - don't rely on it
    5. Maps are reference types - passed functions modify the original
    6. Only comparable types can be map keys (no slices, maps, or functions)
    7. Pre-allocate capacity for better performance with large maps

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

    ## Structs

    ```go
    type Person struct {
        Name string
        Age  int
    }

    // Create struct
    person := Person{Name: "Alice", Age: 25}
    fmt.Println(person.Name)

    // Struct methods
    func (p Person) Greet() {
        fmt.Printf("Hi, I'm %s\\n", p.Name)
    }

    person.Greet()
    ```

    **Practice:** Try the Go Basics lab!
  MARKDOWN
  lesson.key_concepts = ['variables', 'types', 'functions', 'control flow', 'slices', 'maps', 'structs']
end

# Lesson 1.2: Structs - Comprehensive Teaching
lesson1_2 = CourseLesson.find_or_create_by!(title: "Structs: Building Custom Types") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
    # Structs: Building Custom Types

    ### What is a Struct?

    A **struct** (short for "structure") is a **composite data type** that groups together variables (called fields) under a single name. Think of it as a blueprint for creating custom types that model real-world entities.

    **Real-world analogy:**
    - A Person has: name, age, email
    - A Car has: make, model, year, color
    - A Book has: title, author, pages, ISBN

    Structs let you model these entities in code!

    ### Defining Structs

    **Basic syntax:**
    ```go
    type StructName struct {
        FieldName FieldType
        AnotherField AnotherType
    }
    ```

    **Example: Person struct**
    ```go
    type Person struct {
        Name    string
        Age     int
        Email   string
        IsActive bool
    }
    ```

    **Key points:**
    - `type` keyword declares a new type
    - `Person` is the name of your custom type
    - `struct` indicates it's a structure
    - Each field has a name and type
    - Field names starting with capital letters are **exported** (public)
    - Field names starting with lowercase are **unexported** (private to package)

    ### Creating Struct Instances

    **Method 1: Literal with field names (recommended)**
    ```go
    person := Person{
        Name:     "Alice",
        Age:      25,
        Email:    "alice@example.com",
        IsActive: true,
    }
    ```

    **Why this is best:**
    - Clear and self-documenting
    - Order doesn't matter
    - Can omit fields (they get zero values)
    - Resistant to changes in struct definition

    **Method 2: Positional arguments**
    ```go
    person := Person{"Alice", 25, "alice@example.com", true}
    ```

    ⚠️ **Not recommended because:**
    - Must provide ALL fields in exact order
    - Breaks if struct changes
    - Hard to read (what does each value mean?)

    **Method 3: Empty struct (all zero values)**
    ```go
    var person Person  // All fields have zero values
    // person.Name = ""
    // person.Age = 0
    // person.Email = ""
    // person.IsActive = false
    ```

    **Method 4: new() function**
    ```go
    person := new(Person)  // Returns *Person (pointer)
    // All fields are zero values
    ```

    ### Accessing and Modifying Fields

    **Dot notation:**
    ```go
    person := Person{
        Name: "Alice",
        Age:  25,
    }

    // Access fields
    fmt.Println(person.Name)  // "Alice"
    fmt.Println(person.Age)   // 25

    // Modify fields
    person.Age = 26
    person.Email = "alice@newdomain.com"

    fmt.Println(person.Age)  // 26
    ```

    ### Anonymous Structs

    **Define and use without creating a named type:**
    ```go
    // Useful for one-off data structures
    config := struct {
        Host string
        Port int
    }{
        Host: "localhost",
        Port: 8080,
    }

    fmt.Println(config.Host)  // "localhost"
    ```

    **Common use cases:**
    - Configuration objects
    - Test data
    - JSON unmarshaling
    - Quick data grouping

    ### Nested Structs

    **Structs can contain other structs:**
    ```go
    type Address struct {
        Street  string
        City    string
        ZipCode string
    }

    type Person struct {
        Name    string
        Age     int
        Address Address  // Nested struct
    }

    person := Person{
        Name: "Alice",
        Age:  25,
        Address: Address{
            Street:  "123 Main St",
            City:    "Springfield",
            ZipCode: "12345",
        },
    }

    // Access nested fields
    fmt.Println(person.Address.City)  // "Springfield"
    ```

    ### Struct Embedding (Composition)

    **Go doesn't have inheritance, but has composition:**
    ```go
    type Employee struct {
        Person        // Embedded struct (no field name)
        EmployeeID string
        Department string
    }

    employee := Employee{
        Person: Person{
            Name: "Bob",
            Age:  30,
        },
        EmployeeID: "E12345",
        Department: "Engineering",
    }

    // Can access embedded fields directly!
    fmt.Println(employee.Name)  // "Bob" (promoted from Person)
    fmt.Println(employee.Age)   // 30

    // Or through the embedded struct
    fmt.Println(employee.Person.Name)  // "Bob"
    ```

    **How field promotion works:**
    - Embedded struct fields are "promoted" to parent
    - Can access them as if they're in the parent struct
    - If there's a name conflict, use explicit path

    ### Comparing Structs

    **Structs are comparable if all their fields are comparable:**
    ```go
    type Point struct {
        X, Y int
    }

    p1 := Point{X: 1, Y: 2}
    p2 := Point{X: 1, Y: 2}
    p3 := Point{X: 3, Y: 4}

    fmt.Println(p1 == p2)  // true (same values)
    fmt.Println(p1 == p3)  // false (different values)
    ```

    **Not comparable if contains slices, maps, or functions:**
    ```go
    type Container struct {
        Items []int  // Slice makes it non-comparable
    }

    c1 := Container{Items: []int{1, 2, 3}}
    c2 := Container{Items: []int{1, 2, 3}}
    // c1 == c2  // ERROR: invalid operation!
    ```

    ### Struct Tags

    **Metadata attached to struct fields:**
    ```go
    type User struct {
        Name  string \`json:"name"\`
        Email string \`json:"email" validate:"required,email"\`
        Age   int    \`json:"age,omitempty"\`
    }
    ```

    **Common uses:**
    - JSON marshaling/unmarshaling
    - Database column mapping
    - Validation rules
    - Documentation

    **Example with JSON:**
    ```go
    import "encoding/json"

    type Person struct {
        Name string \`json:"name"\`
        Age  int    \`json:"age"\`
    }

    person := Person{Name: "Alice", Age: 25}

    // Marshal to JSON
    jsonData, _ := json.Marshal(person)
    fmt.Println(string(jsonData))
    // Output: {"name":"Alice","age":25}

    // Unmarshal from JSON
    var p2 Person
    json.Unmarshal(jsonData, &p2)
    fmt.Println(p2.Name)  // "Alice"
    ```

    ### Zero Values for Structs

    **Uninitialized fields get zero values:**
    ```go
    type Stats struct {
        Count   int     // 0
        Average float64 // 0.0
        Name    string  // ""
        Active  bool    // false
    }

    var stats Stats
    fmt.Println(stats.Count)    // 0
    fmt.Println(stats.Average)  // 0.0
    fmt.Println(stats.Name)     // ""
    fmt.Println(stats.Active)   // false
    ```

    ### Structs as Function Parameters

    **Structs are passed by value (copied):**
    ```go
    func updateAge(p Person, newAge int) {
        p.Age = newAge  // Modifies COPY, not original!
    }

    person := Person{Name: "Alice", Age: 25}
    updateAge(person, 26)
    fmt.Println(person.Age)  // Still 25! (original unchanged)
    ```

    **To modify original, use pointer (covered in Pointers lesson):**
    ```go
    func updateAge(p *Person, newAge int) {
        p.Age = newAge  // Modifies original!
    }

    person := Person{Name: "Alice", Age: 25}
    updateAge(&person, 26)
    fmt.Println(person.Age)  // 26 (original modified)
    ```

    ### Practical Example: Modeling a Book Store

    ```go
    type Book struct {
        Title       string
        Author      string
        ISBN        string
        Price       float64
        InStock     bool
        PublishedYear int
    }

    type Order struct {
        OrderID   string
        Customer  string
        Books     []Book  // Slice of Books
        Total     float64
        CreatedAt time.Time
    }

    // Create books
    book1 := Book{
        Title:     "The Go Programming Language",
        Author:    "Alan Donovan",
        ISBN:      "978-0134190440",
        Price:     44.99,
        InStock:   true,
        PublishedYear: 2015,
    }

    book2 := Book{
        Title:     "Learning Go",
        Author:    "Jon Bodner",
        ISBN:      "978-1492077213",
        Price:     49.99,
        InStock:   true,
        PublishedYear: 2021,
    }

    // Create order
    order := Order{
        OrderID:   "ORD-001",
        Customer:  "Alice",
        Books:     []Book{book1, book2},
        Total:     book1.Price + book2.Price,
        CreatedAt: time.Now(),
    }

    fmt.Printf("Order %s for %s: $%.2f\\n",
        order.OrderID, order.Customer, order.Total)
    ```

    ### Empty Struct

    **The struct with no fields:**
    ```go
    type Empty struct{}
    ```

    **Why use it?**
    - Takes **0 bytes** of memory!
    - Useful for signaling (like in channels)
    - Used in sets (map[string]struct{})

    **Example: Set implementation**
    ```go
    // Set of strings using empty struct
    seen := make(map[string]struct{})

    // Add to set
    seen["apple"] = struct{}{}
    seen["banana"] = struct{}{}

    // Check if in set
    if _, exists := seen["apple"]; exists {
        fmt.Println("apple is in the set")
    }
    ```

    ### Best Practices

    **1. Use meaningful field names:**
    ```go
    // ❌ Bad
    type P struct {
        n string
        a int
    }

    // ✅ Good
    type Person struct {
        Name string
        Age  int
    }
    ```

    **2. Export only what's necessary:**
    ```go
    type User struct {
        Name     string  // Exported (public)
        email    string  // Unexported (private)
        password string  // Unexported (private)
    }
    ```

    **3. Use named fields in literals:**
    ```go
    // ✅ Good - clear and maintainable
    person := Person{
        Name: "Alice",
        Age:  25,
    }

    // ❌ Bad - hard to read, brittle
    person := Person{"Alice", 25}
    ```

    **4. Consider using pointers for large structs:**
    ```go
    // Copying a large struct is expensive
    type LargeStruct struct {
        Data [1000000]int
    }

    // ✅ Pass pointer instead
    func process(s *LargeStruct) {
        // Work with pointer, no copying
    }
    ```

    **5. Use composition over complex nesting:**
    ```go
    // ✅ Good - flat and composable
    type Address struct {
        Street, City, ZipCode string
    }

    type Person struct {
        Name string
        Address Address
    }

    // ❌ Bad - deeply nested
    type Person struct {
        Name string
        Address struct {
            Street struct {
                Number int
                Name string
            }
            City string
        }
    }
    ```

    ### When to Use Structs

    **Use structs when:**
    - ✅ Modeling entities (User, Product, Order)
    - ✅ Grouping related data
    - ✅ Creating custom types with methods
    - ✅ Working with JSON/databases
    - ✅ Need value semantics (copy behavior)

    **Don't use structs when:**
    - ❌ Simple key-value pairs (use map)
    - ❌ Ordered collection (use slice)
    - ❌ Only need one field (use basic type)

    ### Key Takeaways

    1. Structs group related fields into custom types
    2. Use named field initialization for clarity
    3. Struct embedding provides composition (not inheritance)
    4. Structs are passed by value (copied) by default
    5. Zero values make structs safe to use without initialization
    6. Struct tags provide metadata for encoding/validation
    7. Empty struct (struct{}) uses zero memory
    8. Export fields (capital letter) only when needed

    **Next:** Learn about **Methods** to add behavior to your structs!
  MARKDOWN
  lesson.key_concepts = ['structs', 'custom types', 'struct embedding', 'composition', 'struct tags', 'value types']
end

# Lesson 1.3: Methods - Comprehensive Teaching
lesson1_3 = CourseLesson.find_or_create_by!(title: "Methods: Adding Behavior to Types") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
    # Methods: Adding Behavior to Types

    ### What is a Method?

    A **method** is a function with a special **receiver** argument that attaches the function to a type. Think of methods as actions that a type can perform.

    **Key difference:**
    - **Function**: Standalone, not tied to any type
    - **Method**: Belongs to a type, called on instances of that type

    ### Method Syntax

    **Basic structure:**
    ```go
    func (receiver ReceiverType) MethodName(parameters) returnType {
        // Method body
    }
    ```

    **Example:**
    ```go
    type Person struct {
        Name string
        Age  int
    }

    // Method with receiver
    func (p Person) Greet() string {
        return "Hello, I'm " + p.Name
    }

    // Usage
    person := Person{Name: "Alice", Age: 25}
    message := person.Greet()  // Call method on instance
    fmt.Println(message)  // "Hello, I'm Alice"
    ```

    **Anatomy:**
    - `(p Person)` - The receiver (like "this" or "self" in other languages)
    - `p` - Receiver variable name (by convention, use first letter of type)
    - `Person` - The type this method belongs to
    - `Greet()` - Method name
    - Called with: `person.Greet()`

    ### Value Receivers vs Pointer Receivers

    This is **CRITICAL** to understand! The type of receiver determines whether you modify the original or a copy.

    **Value Receiver (receives a copy):**
    ```go
    func (p Person) HaveBirthday() {
        p.Age++  // Modifies COPY, not original!
    }

    person := Person{Name: "Alice", Age: 25}
    person.HaveBirthday()
    fmt.Println(person.Age)  // Still 25! (unchanged)
    ```

    **Pointer Receiver (receives a reference):**
    ```go
    func (p *Person) HaveBirthday() {
        p.Age++  // Modifies ORIGINAL!
    }

    person := Person{Name: "Alice", Age: 25}
    person.HaveBirthday()  // Go automatically takes address
    fmt.Println(person.Age)  // 26! (changed)
    ```

    ### When to Use Pointer Receivers

    **Use pointer receivers when:**

    **1. You need to modify the receiver**
    ```go
    type Counter struct {
        Count int
    }

    // ✅ Pointer receiver - modifies original
    func (c *Counter) Increment() {
        c.Count++
    }

    counter := Counter{Count: 0}
    counter.Increment()
    fmt.Println(counter.Count)  // 1
    ```

    **2. The struct is large (avoid copying)**
    ```go
    type LargeData struct {
        Data [1000000]int
    }

    // ✅ Pointer receiver - avoids copying 4MB of data!
    func (ld *LargeData) Process() {
        // Work with the data
    }
    ```

    **3. Consistency - if any method needs pointer, use pointer for all**
    ```go
    type User struct {
        Name  string
        Email string
    }

    // ✅ All methods use pointer receivers for consistency
    func (u *User) UpdateName(name string) {
        u.Name = name
    }

    func (u *User) UpdateEmail(email string) {
        u.Email = email
    }

    func (u *User) GetFullInfo() string {
        return u.Name + " <" + u.Email + ">"
    }
    ```

    ### When to Use Value Receivers

    **Use value receivers when:**

    **1. Method doesn't modify the receiver**
    ```go
    type Point struct {
        X, Y int
    }

    // ✅ Value receiver - just reading data
    func (p Point) Distance() float64 {
        return math.Sqrt(float64(p.X*p.X + p.Y*p.Y))
    }
    ```

    **2. Receiver is a small struct (few bytes)**
    ```go
    type Color struct {
        R, G, B uint8  // Only 3 bytes total
    }

    // ✅ Value receiver - cheap to copy
    func (c Color) String() string {
        return fmt.Sprintf("#%02x%02x%02x", c.R, c.G, c.B)
    }
    ```

    **3. Working with basic types or immutable data**
    ```go
    type Temperature float64

    // ✅ Value receiver - basic type
    func (t Temperature) Celsius() float64 {
        return float64(t)
    }

    func (t Temperature) Fahrenheit() float64 {
        return float64(t)*9/5 + 32
    }
    ```

    ### Automatic Pointer/Value Conversion

    **Go is smart - it converts automatically:**
    ```go
    type Person struct {
        Name string
    }

    func (p *Person) UpdateName(name string) {
        p.Name = name
    }

    // All these work:
    person := Person{Name: "Alice"}
    person.UpdateName("Bob")  // Go converts to (&person).UpdateName("Bob")

    ptrPerson := &Person{Name: "Charlie"}
    ptrPerson.UpdateName("Dave")  // Already a pointer
    ```

    **Behind the scenes:**
    - `person.UpdateName()` → Go automatically converts to `(&person).UpdateName()`
    - `ptrPerson.UpdateName()` → Already a pointer, no conversion needed

    ### Methods on Non-Struct Types

    **You can define methods on ANY type you create:**
    ```go
    type Celsius float64

    func (c Celsius) Fahrenheit() float64 {
        return float64(c)*9/5 + 32
    }

    func (c Celsius) String() string {
        return fmt.Sprintf("%.2f°C", c)
    }

    temp := Celsius(25.0)
    fmt.Println(temp.String())       // "25.00°C"
    fmt.Println(temp.Fahrenheit())   // 77.0
    ```

    **⚠️ Cannot define methods on types from other packages:**
    ```go
    // ❌ ERROR: Cannot define methods on built-in types
    func (s string) Reverse() string {
        // Won't compile!
    }

    // ✅ CORRECT: Create your own type
    type MyString string

    func (s MyString) Reverse() string {
        runes := []rune(s)
        for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
            runes[i], runes[j] = runes[j], runes[i]
        }
        return string(runes)
    }
    ```

    ### Practical Example: Bank Account

    ```go
    type BankAccount struct {
        Owner   string
        Balance float64
    }

    // Pointer receiver - modifies balance
    func (ba *BankAccount) Deposit(amount float64) error {
        if amount <= 0 {
            return fmt.Errorf("deposit amount must be positive")
        }
        ba.Balance += amount
        return nil
    }

    // Pointer receiver - modifies balance
    func (ba *BankAccount) Withdraw(amount float64) error {
        if amount <= 0 {
            return fmt.Errorf("withdrawal amount must be positive")
        }
        if amount > ba.Balance {
            return fmt.Errorf("insufficient funds")
        }
        ba.Balance -= amount
        return nil
    }

    // Value receiver - just reading data
    func (ba BankAccount) GetBalance() float64 {
        return ba.Balance
    }

    // Value receiver - just formatting
    func (ba BankAccount) String() string {
        return fmt.Sprintf("%s's account: $%.2f", ba.Owner, ba.Balance)
    }

    // Usage
    account := BankAccount{Owner: "Alice", Balance: 1000.0}
    account.Deposit(500.0)
    account.Withdraw(200.0)
    fmt.Println(account)  // "Alice's account: $1300.00"
    ```

    ### Method Chaining

    **Return the receiver to enable chaining:**
    ```go
    type StringBuilder struct {
        text string
    }

    func (sb *StringBuilder) Append(s string) *StringBuilder {
        sb.text += s
        return sb  // Return pointer for chaining
    }

    func (sb *StringBuilder) String() string {
        return sb.text
    }

    // Chain methods
    result := new(StringBuilder).
        Append("Hello").
        Append(" ").
        Append("World").
        String()

    fmt.Println(result)  // "Hello World"
    ```

    ### Methods vs Functions: When to Use Which?

    **Use methods when:**
    - ✅ Behavior belongs to a type (like Person.Greet())
    - ✅ Need to modify state of the receiver
    - ✅ Working with interfaces (methods satisfy interfaces)
    - ✅ Grouping related operations (account.Deposit, account.Withdraw)

    **Use functions when:**
    - ✅ Utility operations (not tied to specific type)
    - ✅ Working with multiple types
    - ✅ Pure functions (no state)

    **Example comparison:**
    ```go
    // ✅ Method - belongs to Rectangle
    func (r Rectangle) Area() float64 {
        return r.Width * r.Height
    }

    // ✅ Function - works with any two numbers
    func Add(a, b int) int {
        return a + b
    }
    ```

    ### Method Sets and Interfaces

    **This is important for interfaces (covered later):**

    **Value receiver methods:**
    - Can be called on values and pointers
    - Part of both value's and pointer's method set

    **Pointer receiver methods:**
    - Can be called on pointers and values (Go converts)
    - Only part of pointer's method set (important for interfaces!)

    ```go
    type Counter struct {
        Count int
    }

    func (c Counter) GetCount() int {      // Value receiver
        return c.Count
    }

    func (c *Counter) Increment() {        // Pointer receiver
        c.Count++
    }

    // Both work:
    counter := Counter{Count: 0}
    counter.GetCount()    // Value receiver - works
    counter.Increment()   // Pointer receiver - Go converts to &counter

    ptr := &Counter{Count: 0}
    ptr.GetCount()        // Value receiver - Go dereferences
    ptr.Increment()       // Pointer receiver - works directly
    ```

    ### Common Patterns

    **1. Constructor Pattern:**
    ```go
    type User struct {
        name  string  // unexported
        email string  // unexported
    }

    // Constructor function
    func NewUser(name, email string) *User {
        return &User{
            name:  name,
            email: email,
        }
    }

    // Getter methods
    func (u *User) Name() string {
        return u.name
    }

    func (u *User) Email() string {
        return u.email
    }

    // Setter with validation
    func (u *User) SetEmail(email string) error {
        if !strings.Contains(email, "@") {
            return fmt.Errorf("invalid email")
        }
        u.email = email
        return nil
    }
    ```

    **2. Builder Pattern:**
    ```go
    type QueryBuilder struct {
        table  string
        fields []string
        where  string
    }

    func NewQuery() *QueryBuilder {
        return &QueryBuilder{}
    }

    func (qb *QueryBuilder) Table(table string) *QueryBuilder {
        qb.table = table
        return qb
    }

    func (qb *QueryBuilder) Select(fields ...string) *QueryBuilder {
        qb.fields = fields
        return qb
    }

    func (qb *QueryBuilder) Where(condition string) *QueryBuilder {
        qb.where = condition
        return qb
    }

    func (qb *QueryBuilder) Build() string {
        return fmt.Sprintf("SELECT %s FROM %s WHERE %s",
            strings.Join(qb.fields, ", "),
            qb.table,
            qb.where)
    }

    // Usage - fluent interface
    query := NewQuery().
        Table("users").
        Select("name", "email").
        Where("age > 18").
        Build()
    ```

    ### Best Practices

    **1. Use consistent receiver names:**
    ```go
    // ✅ Good - use first letter(s) of type
    func (p *Person) SetName(name string)
    func (p *Person) GetName() string

    // ❌ Bad - inconsistent receiver names
    func (p *Person) SetName(name string)
    func (person *Person) GetName() string
    ```

    **2. Don't mix receiver types (except for good reason):**
    ```go
    // ❌ Bad - mixed receiver types
    func (p Person) GetName() string    // Value
    func (p *Person) SetName(name string) // Pointer

    // ✅ Good - consistent pointer receivers
    func (p *Person) GetName() string
    func (p *Person) SetName(name string)
    ```

    **3. Use pointer receivers by default (unless you have a reason not to):**
    ```go
    // ✅ Safe default - use pointer receivers
    func (u *User) UpdateEmail(email string) {
        u.email = email
    }

    func (u *User) GetEmail() string {
        return u.email
    }
    ```

    **4. Keep methods focused and simple:**
    ```go
    // ✅ Good - each method does one thing
    func (u *User) Validate() error
    func (u *User) Save() error
    func (u *User) Delete() error

    // ❌ Bad - method does too much
    func (u *User) ValidateSaveAndNotify() error
    ```

    ### Key Takeaways

    1. Methods attach behavior to types using receivers
    2. **Pointer receivers (`*T`)** modify the original - use for mutations or large structs
    3. **Value receivers (`T`)** work on copies - use for immutable operations or small types
    4. Go automatically converts between values and pointers for method calls
    5. Use consistent receiver types across all methods of a type
    6. Methods enable interfaces and polymorphism in Go
    7. Return the receiver from methods to enable chaining
    8. Use methods when behavior belongs to a type, functions for utilities

    **Next:** Learn about **Pointers and Values** to understand memory and performance!
  MARKDOWN
  lesson.key_concepts = ['methods', 'receivers', 'pointer receivers', 'value receivers', 'method sets', 'method chaining']
end

# Lesson 1.4: Pointers and Values - Comprehensive Teaching
lesson1_4 = CourseLesson.find_or_create_by!(title: "Pointers and Values: Memory and Performance") do |lesson|
  lesson.reading_time_minutes = 30
  lesson.content = <<~MARKDOWN
    # Pointers and Values: Memory and Performance

    ### What are Pointers?

    A **pointer** is a variable that stores the **memory address** of another variable. Instead of holding a value directly, it "points to" where the value is stored in memory.

    **Real-world analogy:**
    - **Value**: Your house (the actual thing)
    - **Pointer**: Your home address (tells you where to find the house)

    ### Why Pointers Matter

    **Two fundamental ways to pass data in programming:**

    **1. Pass by Value (copy):**
    - Creates a copy of the data
    - Modifications don't affect original
    - Can be expensive for large data

    **2. Pass by Reference (pointer):**
    - Passes memory address
    - Modifications affect original
    - Efficient for large data

    ### Pointer Syntax

    **Two operators:**
    - `&` (ampersand) - "address of" operator
    - `*` (asterisk) - "dereference" operator

    **Basic example:**
    ```go
    x := 42        // Regular variable
    p := &x        // p is a pointer to x (stores address of x)
    fmt.Println(*p) // *p dereferences pointer (gets value at address)

    *p = 21        // Change value at address
    fmt.Println(x)  // x is now 21!
    ```

    **Step by step:**
    1. `x := 42` - Create variable x with value 42
    2. `p := &x` - Get address of x, store in pointer p
    3. `*p` - Dereference p to get value (42)
    4. `*p = 21` - Change value at that address
    5. `x` - Original variable now has new value (21)

    ### Memory Diagram

    ```
    Memory Address | Variable | Value
    ───────────────┼──────────┼───────
    0x1000         | x        | 42
    0x2000         | p        | 0x1000 (points to x)

    After *p = 21:

    Memory Address | Variable | Value
    ───────────────┼──────────┼───────
    0x1000         | x        | 21  ← changed!
    0x2000         | p        | 0x1000
    ```

    ### Creating Pointers

    **Method 1: Address-of operator (&)**
    ```go
    x := 42
    p := &x  // p is *int (pointer to int)
    fmt.Printf("Value: %d, Address: %p\\n", x, p)
    ```

    **Method 2: new() function**
    ```go
    p := new(int)  // Allocates memory, returns pointer
    *p = 42        // Set value at that address
    fmt.Println(*p) // 42
    ```

    **What new() does:**
    1. Allocates memory for the type
    2. Initializes to zero value
    3. Returns pointer to that memory

    ### Pointer Types

    **Pointer type syntax:**
    ```go
    var p *int        // Pointer to int
    var q *string     // Pointer to string
    var r *Person     // Pointer to Person struct
    ```

    **Type hierarchy:**
    ```go
    int           // The type
    *int          // Pointer to int
    **int         // Pointer to pointer to int
    ```

    ### Nil Pointers

    **The zero value of a pointer is nil:**
    ```go
    var p *int
    fmt.Println(p)  // <nil>

    if p == nil {
        fmt.Println("Pointer is nil")
    }

    // ⚠️ Dereferencing nil pointer causes panic!
    // fmt.Println(*p)  // PANIC: runtime error
    ```

    **Always check before dereferencing:**
    ```go
    func printValue(p *int) {
        if p == nil {
            fmt.Println("nil pointer")
            return
        }
        fmt.Println(*p)  // Safe
    }
    ```

    ### Pointers with Structs

    **Creating struct pointers:**
    ```go
    type Person struct {
        Name string
        Age  int
    }

    // Method 1: & operator
    person := Person{Name: "Alice", Age: 25}
    p := &person

    // Method 2: new() function
    p := new(Person)
    p.Name = "Alice"
    p.Age = 25

    // Method 3: & with literal
    p := &Person{Name: "Alice", Age: 25}
    ```

    **Accessing fields (Go simplifies this!):**
    ```go
    p := &Person{Name: "Alice", Age: 25}

    // Both work - Go handles dereferencing automatically
    fmt.Println(p.Name)    // Go implicitly does (*p).Name
    fmt.Println((*p).Name) // Explicit dereference (same result)
    ```

    ### Pass by Value vs Pass by Pointer

    **Understanding Go's default: Pass by Value**

    **Everything in Go is passed by value (copied) by default:**
    ```go
    func increment(x int) {
        x++  // Modifies copy, not original
    }

    num := 5
    increment(num)
    fmt.Println(num)  // Still 5! (unchanged)
    ```

    **Use pointers to modify original:**
    ```go
    func increment(x *int) {
        *x++  // Modifies value at address (original)
    }

    num := 5
    increment(&num)
    fmt.Println(num)  // 6! (changed)
    ```

    ### Practical Example: Swapping Values

    **❌ Wrong - won't work (pass by value):**
    ```go
    func swap(a, b int) {
        a, b = b, a  // Swaps copies, not originals!
    }

    x, y := 1, 2
    swap(x, y)
    fmt.Println(x, y)  // Still 1, 2 (unchanged)
    ```

    **✅ Correct - use pointers:**
    ```go
    func swap(a, b *int) {
        *a, *b = *b, *a  // Swaps values at addresses
    }

    x, y := 1, 2
    swap(&x, &y)
    fmt.Println(x, y)  // Now 2, 1 (swapped!)
    ```

    ### When to Use Pointers

    **Use pointers when:**

    **1. Need to modify the original:**
    ```go
    func reset(counter *int) {
        *counter = 0  // Modifies original
    }
    ```

    **2. Large structs (avoid expensive copying):**
    ```go
    type LargeStruct struct {
        Data [1000000]int  // 4 MB
    }

    // ❌ Bad - copies 4 MB every call!
    func process(ls LargeStruct) {
        // ...
    }

    // ✅ Good - passes 8-byte pointer
    func process(ls *LargeStruct) {
        // ...
    }
    ```

    **3. Optional values (nil represents "not set"):**
    ```go
    type Config struct {
        Timeout *int  // nil means "use default"
    }

    func NewConfig(timeout *int) Config {
        return Config{Timeout: timeout}
    }

    // Use default timeout
    cfg1 := NewConfig(nil)

    // Custom timeout
    timeout := 30
    cfg2 := NewConfig(&timeout)
    ```

    **4. Implementing interfaces with pointer receivers:**
    ```go
    type Counter struct {
        count int
    }

    func (c *Counter) Increment() {
        c.count++
    }

    // Must use pointer for interface methods that modify state
    var c Counter
    c.Increment()  // Go automatically uses &c
    ```

    ### When NOT to Use Pointers

    **Don't use pointers when:**

    **1. Small basic types (int, bool, etc.):**
    ```go
    // ❌ Unnecessary - int is 8 bytes, pointer is also 8 bytes!
    func add(a *int, b *int) int {
        return *a + *b
    }

    // ✅ Better - simpler and no slower
    func add(a, b int) int {
        return a + b
    }
    ```

    **2. Don't need to modify original:**
    ```go
    // ✅ Value receiver - just reading data
    func (p Person) GetName() string {
        return p.Name
    }
    ```

    **3. Working with built-in data structures:**
    ```go
    // Slices, maps, channels are already reference types!
    // No need for pointers

    // ✅ Correct
    func appendItem(slice []int, item int) []int {
        return append(slice, item)
    }

    // ❌ Unnecessary
    func appendItem(slice *[]int, item int) {
        *slice = append(*slice, item)
    }
    ```

    ### Pointers vs References

    **Important distinction:**

    Go has **pointers**, not **references** (like C++ references).

    **Go pointers:**
    - Can be nil
    - Can be reassigned
    - Explicit dereferencing (though Go helps)
    - Take memory (8 bytes on 64-bit systems)

    ### Slices, Maps, Channels: Special Cases

    **These are already reference types (no pointers needed!):**

    **Slices:**
    ```go
    func modifySlice(s []int) {
        s[0] = 999  // Modifies original slice!
    }

    numbers := []int{1, 2, 3}
    modifySlice(numbers)
    fmt.Println(numbers)  // [999, 2, 3]
    ```

    **Why?** Slices contain a pointer to underlying array internally.

    **Maps:**
    ```go
    func modifyMap(m map[string]int) {
        m["key"] = 42  // Modifies original map!
    }

    data := make(map[string]int)
    modifyMap(data)
    fmt.Println(data["key"])  // 42
    ```

    **Why?** Maps are reference types.

    **But be careful with append!**
    ```go
    func wrongAppend(s []int) {
        s = append(s, 99)  // Modifies local copy of slice header!
    }

    numbers := []int{1, 2, 3}
    wrongAppend(numbers)
    fmt.Println(numbers)  // Still [1, 2, 3] - unchanged!

    // ✅ Correct: Return new slice
    func correctAppend(s []int) []int {
        return append(s, 99)
    }

    numbers = correctAppend(numbers)  // Now [1, 2, 3, 99]
    ```

    ### Pointer Performance

    **Pointer cost:**
    - Pointer itself: 8 bytes (64-bit system)
    - Indirection cost: One extra memory lookup
    - Heap allocation: May trigger garbage collection

    **When pointers are faster:**
    ```go
    type Large struct {
        Data [1000]int  // 4000 bytes
    }

    // Copying 4000 bytes every call - slow!
    func processValue(l Large) { }

    // Passing 8-byte pointer - fast!
    func processPointer(l *Large) { }
    ```

    **When pointers are slower:**
    ```go
    // int is 8 bytes, pointer is also 8 bytes
    // But pointer requires extra indirection!

    func addValue(a, b int) int {         // Faster
        return a + b
    }

    func addPointer(a, b *int) int {      // Slower
        return *a + *b  // Extra memory lookups
    }
    ```

    ### Stack vs Heap Allocation

    **Go automatically chooses where to allocate:**

    **Stack allocation (fast):**
    ```go
    func foo() {
        x := 42  // Allocated on stack, freed automatically
    }
    ```

    **Heap allocation (slower, needs GC):**
    ```go
    func foo() *int {
        x := 42
        return &x  // Escapes to heap (returned pointer)
    }
    ```

    **Go's escape analysis decides:**
    - If variable doesn't escape function → stack
    - If variable escapes (returned, stored globally) → heap

    ### Common Pointer Mistakes

    **1. Dereferencing nil pointers:**
    ```go
    var p *int
    fmt.Println(*p)  // PANIC!

    // ✅ Check first
    if p != nil {
        fmt.Println(*p)
    }
    ```

    **2. Losing the original pointer:**
    ```go
    func broken(p *int) {
        p = new(int)  // Changes local copy of pointer!
        *p = 42
    }

    var x int
    broken(&x)
    fmt.Println(x)  // Still 0!

    // ✅ Correct
    func works(p *int) {
        *p = 42  // Modifies value at address
    }
    ```

    **3. Returning pointer to local variable (now safe in Go!):**
    ```go
    func createInt() *int {
        x := 42
        return &x  // Safe! Go moves to heap automatically
    }
    ```

    This works in Go because the compiler detects the escape and allocates on heap.

    ### Best Practices

    **1. Use pointers for large structs:**
    ```go
    // If struct > 32 bytes, consider using pointers
    func process(data *LargeStruct) {
        // ...
    }
    ```

    **2. Use pointers when you need to modify:**
    ```go
    func (p *Person) UpdateAge(age int) {
        p.Age = age
    }
    ```

    **3. Check for nil before dereferencing:**
    ```go
    func safePrint(p *int) {
        if p != nil {
            fmt.Println(*p)
        }
    }
    ```

    **4. Don't use pointers to basic types unnecessarily:**
    ```go
    // ❌ Overkill
    func add(a *int, b *int) int {
        return *a + *b
    }

    // ✅ Better
    func add(a, b int) int {
        return a + b
    }
    ```

    **5. Return values, accept pointers:**
    ```go
    // ✅ Good pattern
    func process(p *Person) Person {
        // Work with pointer parameter
        return Person{...}  // Return value
    }
    ```

    ### Pointer Comparison

    ```go
    x := 42
    y := 42
    p1 := &x
    p2 := &x
    p3 := &y

    fmt.Println(p1 == p2)  // true (same address)
    fmt.Println(p1 == p3)  // false (different addresses)
    fmt.Println(*p1 == *p3) // true (same value)
    ```

    ### Key Takeaways

    1. **Pointers store memory addresses**, not values
    2. `&` gets address, `*` dereferences (gets value)
    3. **Go passes everything by value** (copy) by default
    4. Use pointers to **modify originals** or **avoid expensive copies**
    5. **Slices, maps, channels** are already reference types
    6. **Nil pointers** cause panics when dereferenced - always check!
    7. Use pointers for **large structs** (>32 bytes), values for **small data**
    8. Go's **escape analysis** automatically allocates on heap when needed
    9. **Don't overthink it** - use pointers when you need to modify or have large data

    **Congratulations!** You now understand Go's fundamental building blocks: variables, types, structs, methods, and pointers. These concepts form the foundation for everything else in Go!
  MARKDOWN
  lesson.key_concepts = ['pointers', 'memory addresses', 'pass by value', 'pass by reference', 'dereferencing', 'nil pointers', 'stack vs heap']
end

# Lesson 1.5: Error Handling - Comprehensive Teaching
lesson1_5 = CourseLesson.find_or_create_by!(title: "Error Handling in Go") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
    # Error Handling in Go

    ### Go's Philosophy: Errors are Values

    Unlike many languages that use exceptions (try/catch), **Go treats errors as values**. This makes error handling explicit, predictable, and part of the normal control flow.

    **Key principle:** If a function can fail, it returns an error value that you must check.

    ### The Error Interface

    **error is a built-in interface:**
    ```go
    type error interface {
        Error() string
    }
    ```

    Any type that implements the `Error() string` method satisfies the error interface.

    **Simple example:**
    ```go
    type MyError struct {
        Message string
        Code    int
    }

    func (e MyError) Error() string {
        return fmt.Sprintf("Error %d: %s", e.Code, e.Message)
    }

    // MyError now implements the error interface!
    ```

    ### Basic Error Handling Pattern

    **The idiomatic Go pattern:**
    ```go
    result, err := someFunction()
    if err != nil {
        // Handle the error
        return err  // or log it, or fix it
    }
    // Use result (we know there's no error)
    ```

    **Complete example:**
    ```go
    package main

    import (
        "errors"
        "fmt"
    )

    func divide(a, b float64) (float64, error) {
        if b == 0 {
            return 0, errors.New("division by zero")
        }
        return a / b, nil
    }

    func main() {
        result, err := divide(10, 2)
        if err != nil {
            fmt.Println("Error:", err)
            return
        }
        fmt.Println("Result:", result)  // Result: 5

        result, err = divide(10, 0)
        if err != nil {
            fmt.Println("Error:", err)  // Error: division by zero
            return
        }
    }
    ```

    ### Creating Errors

    **Method 1: errors.New() - Simple string errors**
    ```go
    import "errors"

    err := errors.New("something went wrong")
    ```

    **Method 2: fmt.Errorf() - Formatted errors**
    ```go
    import "fmt"

    age := -5
    err := fmt.Errorf("invalid age: %d (must be positive)", age)
    // Error: "invalid age: -5 (must be positive)"
    ```

    **Method 3: Custom error types**
    ```go
    type ValidationError struct {
        Field string
        Value interface{}
        Issue string
    }

    func (e ValidationError) Error() string {
        return fmt.Sprintf("validation failed for %s: %v (%s)",
            e.Field, e.Value, e.Issue)
    }

    // Usage
    err := ValidationError{
        Field: "email",
        Value: "notanemail",
        Issue: "invalid format",
    }
    fmt.Println(err)
    // "validation failed for email: notanemail (invalid format)"
    ```

    ### Multiple Return Values Pattern

    **Go functions commonly return (result, error):**
    ```go
    func readFile(path string) ([]byte, error) {
        // If successful: return data, nil
        // If failed: return nil, error
    }

    func parseJSON(data []byte) (User, error) {
        // If successful: return user, nil
        // If failed: return User{}, error
    }
    ```

    **Why this works well:**
    - Explicit: Can't ignore errors (compiler would complain about unused variable)
    - Clear: Success case and failure case are obvious
    - No hidden control flow (unlike exceptions)

    ### Error Checking Patterns

    **Pattern 1: Return immediately**
    ```go
    func processUser(id int) error {
        user, err := getUser(id)
        if err != nil {
            return err  // Propagate error up
        }

        err = validateUser(user)
        if err != nil {
            return err
        }

        err = saveUser(user)
        if err != nil {
            return err
        }

        return nil  // Success!
    }
    ```

    **Pattern 2: Handle and continue**
    ```go
    func loadConfig(path string) Config {
        config, err := readConfig(path)
        if err != nil {
            // Use default config
            log.Printf("Using default config: %v", err)
            return DefaultConfig
        }
        return config
    }
    ```

    **Pattern 3: Wrap and add context**
    ```go
    func loadUserProfile(id int) (*Profile, error) {
        user, err := getUser(id)
        if err != nil {
            return nil, fmt.Errorf("failed to load profile for user %d: %w", id, err)
        }
        return user.Profile, nil
    }
    ```

    ### Error Wrapping (Go 1.13+)

    **The %w verb wraps errors:**
    ```go
    func outer() error {
        err := inner()
        if err != nil {
            return fmt.Errorf("outer failed: %w", err)
        }
        return nil
    }

    func inner() error {
        return errors.New("inner error")
    }

    // Result: "outer failed: inner error"
    // The original error is preserved!
    ```

    **Unwrapping errors:**
    ```go
    import "errors"

    err := outer()
    // Check if err wraps a specific error
    if errors.Is(err, SomeSpecificError) {
        // Handle specific error
    }

    // Extract wrapped error type
    var validationErr *ValidationError
    if errors.As(err, &validationErr) {
        fmt.Println("Validation failed:", validationErr.Field)
    }
    ```

    ### Sentinel Errors

    **Predefined errors for comparison:**
    ```go
    package io

    var EOF = errors.New("EOF")
    var ErrClosedPipe = errors.New("io: read/write on closed pipe")
    ```

    **Usage:**
    ```go
    import "io"

    data, err := reader.Read(buffer)
    if err == io.EOF {
        fmt.Println("Reached end of file")
        return
    }
    if err != nil {
        return fmt.Errorf("read failed: %w", err)
    }
    ```

    **With errors.Is() (preferred):**
    ```go
    if errors.Is(err, io.EOF) {
        // Handle EOF
    }
    ```

    ### Custom Error Types with Data

    **Rich errors with context:**
    ```go
    type HTTPError struct {
        StatusCode int
        Message    string
        URL        string
    }

    func (e *HTTPError) Error() string {
        return fmt.Sprintf("HTTP %d: %s (URL: %s)",
            e.StatusCode, e.Message, e.URL)
    }

    func fetchURL(url string) ([]byte, error) {
        resp, err := http.Get(url)
        if err != nil {
            return nil, err
        }
        defer resp.Body.Close()

        if resp.StatusCode != 200 {
            return nil, &HTTPError{
                StatusCode: resp.StatusCode,
                Message:    "request failed",
                URL:        url,
            }
        }

        return io.ReadAll(resp.Body)
    }

    // Usage
    data, err := fetchURL("https://api.example.com/data")
    if err != nil {
        var httpErr *HTTPError
        if errors.As(err, &httpErr) {
            if httpErr.StatusCode == 404 {
                fmt.Println("Resource not found")
            } else {
                fmt.Printf("HTTP error: %d\\n", httpErr.StatusCode)
            }
        } else {
            fmt.Println("Network error:", err)
        }
        return
    }
    ```

    ### Don't Panic!

    **panic is for unrecoverable errors:**
    ```go
    // ❌ BAD: Don't panic for expected errors
    func getUser(id int) User {
        user, err := db.FindUser(id)
        if err != nil {
            panic(err)  // DON'T DO THIS!
        }
        return user
    }

    // ✅ GOOD: Return errors
    func getUser(id int) (User, error) {
        user, err := db.FindUser(id)
        if err != nil {
            return User{}, err
        }
        return user, nil
    }
    ```

    **When to use panic:**
    - Programming errors (nil pointer, array out of bounds)
    - Initialization failures (can't load required config)
    - Impossible states (should never happen)

    **Example of reasonable panic:**
    ```go
    func MustCompileRegex(pattern string) *regexp.Regexp {
        re, err := regexp.Compile(pattern)
        if err != nil {
            panic(fmt.Sprintf("invalid regex pattern: %s", pattern))
        }
        return re
    }

    // Used in initialization
    var emailRegex = MustCompileRegex(\`^[a-z0-9]+@[a-z]+\\.[a-z]{2,}$\`)
    ```

    ### Error Handling Best Practices

    **1. Always check errors:**
    ```go
    // ❌ BAD: Ignoring errors
    data, _ := os.ReadFile("config.json")

    // ✅ GOOD: Check and handle
    data, err := os.ReadFile("config.json")
    if err != nil {
        return fmt.Errorf("failed to read config: %w", err)
    }
    ```

    **2. Add context when wrapping:**
    ```go
    // ❌ BAD: No context
    if err != nil {
        return err
    }

    // ✅ GOOD: Add context
    if err != nil {
        return fmt.Errorf("processing user %d: %w", userID, err)
    }
    ```

    **3. Return early, avoid nesting:**
    ```go
    // ❌ BAD: Nested error handling
    func process() error {
        if err := step1(); err == nil {
            if err := step2(); err == nil {
                if err := step3(); err == nil {
                    return nil
                } else {
                    return err
                }
            } else {
                return err
            }
        } else {
            return err
        }
    }

    // ✅ GOOD: Early returns
    func process() error {
        if err := step1(); err != nil {
            return err
        }
        if err := step2(); err != nil {
            return err
        }
        if err := step3(); err != nil {
            return err
        }
        return nil
    }
    ```

    **4. Don't ignore errors with blank identifier:**
    ```go
    // ❌ BAD: Silently ignoring errors
    file, _ := os.Open("important.txt")

    // ✅ GOOD: Handle or at least log
    file, err := os.Open("important.txt")
    if err != nil {
        log.Printf("Warning: could not open file: %v", err)
        // Use default behavior
    }
    ```

    **5. Use custom error types for public APIs:**
    ```go
    // ✅ Package users can check error types
    type NotFoundError struct {
        Resource string
        ID       int
    }

    func (e *NotFoundError) Error() string {
        return fmt.Sprintf("%s with ID %d not found", e.Resource, e.ID)
    }

    // Callers can check:
    user, err := api.GetUser(123)
    if err != nil {
        var notFound *NotFoundError
        if errors.As(err, &notFound) {
            // Handle not found specifically
        }
    }
    ```

    ### Practical Example: File Processing

    ```go
    package main

    import (
        "bufio"
        "fmt"
        "os"
        "strconv"
        "strings"
    )

    type ParseError struct {
        Line   int
        Column int
        Value  string
    }

    func (e *ParseError) Error() string {
        return fmt.Sprintf("parse error at line %d, column %d: invalid value %q",
            e.Line, e.Column, e.Value)
    }

    func processFile(path string) error {
        // Open file
        file, err := os.Open(path)
        if err != nil {
            return fmt.Errorf("failed to open file %s: %w", path, err)
        }
        defer file.Close()

        // Process line by line
        scanner := bufio.NewScanner(file)
        lineNum := 0

        for scanner.Scan() {
            lineNum++
            line := scanner.Text()

            // Parse line
            if err := parseLine(line, lineNum); err != nil {
                return fmt.Errorf("processing line %d: %w", lineNum, err)
            }
        }

        // Check for scan errors
        if err := scanner.Err(); err != nil {
            return fmt.Errorf("error reading file: %w", err)
        }

        return nil
    }

    func parseLine(line string, lineNum int) error {
        parts := strings.Split(line, ",")
        if len(parts) < 2 {
            return &ParseError{
                Line:   lineNum,
                Column: 0,
                Value:  line,
            }
        }

        // Parse number
        num, err := strconv.Atoi(strings.TrimSpace(parts[1]))
        if err != nil {
            return &ParseError{
                Line:   lineNum,
                Column: len(parts[0]) + 1,
                Value:  parts[1],
            }
        }

        fmt.Printf("Line %d: %s = %d\\n", lineNum, parts[0], num)
        return nil
    }

    func main() {
        err := processFile("data.csv")
        if err != nil {
            // Check for specific error types
            var parseErr *ParseError
            if errors.As(err, &parseErr) {
                fmt.Printf("Invalid data: %v\\n", parseErr)
            } else {
                fmt.Printf("Failed to process file: %v\\n", err)
            }
            os.Exit(1)
        }

        fmt.Println("File processed successfully!")
    }
    ```

    ### Error vs Exception: The Go Way

    **Other languages (exceptions):**
    ```python
    # Python
    try:
        user = get_user(123)
        process(user)
    except UserNotFoundError:
        print("User not found")
    except DatabaseError as e:
        print(f"Database error: {e}")
    ```

    **Go (explicit errors):**
    ```go
    user, err := getUser(123)
    if err != nil {
        var notFoundErr *NotFoundError
        if errors.As(err, &notFoundErr) {
            fmt.Println("User not found")
            return
        }
        return fmt.Errorf("failed to get user: %w", err)
    }

    if err := process(user); err != nil {
        return fmt.Errorf("failed to process user: %w", err)
    }
    ```

    **Why Go's approach is better:**
    - ✅ **Explicit**: Error handling is visible in the code
    - ✅ **Predictable**: No hidden control flow jumps
    - ✅ **Forced**: Can't forget to handle errors (unused variable)
    - ✅ **Fast**: No stack unwinding overhead
    - ✅ **Clear**: Easy to see what can fail

    ### Common Patterns

    **1. Cleanup with defer:**
    ```go
    func processFile(path string) error {
        file, err := os.Open(path)
        if err != nil {
            return err
        }
        defer file.Close()  // Always closes, even on error

        return process(file)
    }
    ```

    **2. Collecting multiple errors:**
    ```go
    func validateUser(u *User) error {
        var errs []string

        if u.Name == "" {
            errs = append(errs, "name is required")
        }
        if u.Age < 0 {
            errs = append(errs, "age must be positive")
        }
        if !strings.Contains(u.Email, "@") {
            errs = append(errs, "invalid email")
        }

        if len(errs) > 0 {
            return fmt.Errorf("validation failed: %s", strings.Join(errs, "; "))
        }
        return nil
    }
    ```

    **3. Retry on error:**
    ```go
    func fetchWithRetry(url string, maxRetries int) ([]byte, error) {
        var lastErr error

        for i := 0; i < maxRetries; i++ {
            data, err := http.Get(url)
            if err == nil {
                return data, nil
            }

            lastErr = err
            time.Sleep(time.Second * time.Duration(i+1))
        }

        return nil, fmt.Errorf("failed after %d retries: %w", maxRetries, lastErr)
    }
    ```

    ### Key Takeaways

    1. **Errors are values** - not exceptions
    2. **Always check errors** - use `if err != nil`
    3. **Add context** - use `fmt.Errorf("context: %w", err)`
    4. **errors.Is()** - check for sentinel errors
    5. **errors.As()** - extract custom error types
    6. **Return early** - avoid nested error handling
    7. **Don't panic** - use panic only for programming errors
    8. **Custom error types** - for rich error information
    9. **Wrap errors** - preserve error chain with %w
    10. **Make errors useful** - include context, IDs, values

    **Error handling is not optional in Go - it's the Go way!**
  MARKDOWN
  lesson.key_concepts = ['error interface', 'error handling', 'error wrapping', 'custom errors', 'errors.Is', 'errors.As', 'panic vs error']
end

# Lesson 1.6: Advanced Functions - Comprehensive Teaching
lesson1_6 = CourseLesson.find_or_create_by!(title: "Advanced Functions: Closures, Defer, and More") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
    # Advanced Functions: Closures, Defer, and More

    ### Functions are First-Class Citizens

    In Go, **functions are values**. You can:
    - Assign them to variables
    - Pass them as arguments
    - Return them from other functions
    - Store them in data structures

    ### Function Types

    **Functions have types:**
    ```go
    // Function type: takes two ints, returns int
    type BinaryOperation func(int, int) int

    func add(a, b int) int {
        return a + b
    }

    func multiply(a, b int) int {
        return a * b
    }

    // Use function type
    var operation BinaryOperation
    operation = add
    fmt.Println(operation(5, 3))  // 8

    operation = multiply
    fmt.Println(operation(5, 3))  // 15
    ```

    ### Anonymous Functions

    **Functions without names:**
    ```go
    // Assign to variable
    square := func(x int) int {
        return x * x
    }
    fmt.Println(square(5))  // 25

    // Call immediately
    result := func(a, b int) int {
        return a + b
    }(3, 4)
    fmt.Println(result)  // 7
    ```

    ### Closures: Functions that Capture Variables

    **What is a closure?**

    A **closure** is a function that references variables from outside its body. The function "closes over" these variables, keeping them alive.

    **Basic closure example:**
    ```go
    func makeCounter() func() int {
        count := 0  // This variable is captured

        return func() int {
            count++         // Closure modifies captured variable
            return count
        }
    }

    counter := makeCounter()
    fmt.Println(counter())  // 1
    fmt.Println(counter())  // 2
    fmt.Println(counter())  // 3

    // Each counter has its own captured variable
    counter2 := makeCounter()
    fmt.Println(counter2())  // 1
    fmt.Println(counter())   // 4
    ```

    **How it works:**
    - `count` is declared in `makeCounter()`
    - The returned function "closes over" `count`
    - Even after `makeCounter()` returns, `count` stays alive
    - Each call to `makeCounter()` creates a new `count`

    ### Practical Closure Examples

    **1. Configuration wrapper:**
    ```go
    func makeGreeter(greeting string) func(string) string {
        return func(name string) string {
            return greeting + ", " + name + "!"
        }
    }

    englishGreeter := makeGreeter("Hello")
    spanishGreeter := makeGreeter("Hola")

    fmt.Println(englishGreeter("Alice"))  // "Hello, Alice!"
    fmt.Println(spanishGreeter("Bob"))    // "Hola, Bob!"
    ```

    **2. Filtering with closures:**
    ```go
    func filter(numbers []int, predicate func(int) bool) []int {
        result := []int{}
        for _, num := range numbers {
            if predicate(num) {
                result = append(result, num)
            }
        }
        return result
    }

    numbers := []int{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}

    // Filter even numbers
    evens := filter(numbers, func(n int) bool {
        return n%2 == 0
    })
    fmt.Println(evens)  // [2, 4, 6, 8, 10]

    // Filter numbers > 5 (closure captures threshold)
    threshold := 5
    large := filter(numbers, func(n int) bool {
        return n > threshold  // Closes over 'threshold'
    })
    fmt.Println(large)  // [6, 7, 8, 9, 10]
    ```

    **3. Memoization (caching):**
    ```go
    func memoize(fn func(int) int) func(int) int {
        cache := make(map[int]int)

        return func(n int) int {
            // Check cache
            if result, found := cache[n]; found {
                fmt.Println("(from cache)")
                return result
            }

            // Compute and cache
            result := fn(n)
            cache[n] = result
            return result
        }
    }

    // Expensive fibonacci calculation
    var fibonacci func(int) int
    fibonacci = func(n int) int {
        if n <= 1 {
            return n
        }
        return fibonacci(n-1) + fibonacci(n-2)
    }

    // Wrap with memoization
    fastFib := memoize(fibonacci)

    fmt.Println(fastFib(10))  // Computes
    fmt.Println(fastFib(10))  // (from cache)
    ```

    ### Variadic Functions

    **Functions that accept variable number of arguments:**
    ```go
    func sum(numbers ...int) int {
        total := 0
        for _, num := range numbers {
            total += num
        }
        return total
    }

    // Call with any number of arguments
    fmt.Println(sum())           // 0
    fmt.Println(sum(1))          // 1
    fmt.Println(sum(1, 2, 3))    // 6
    fmt.Println(sum(1, 2, 3, 4, 5))  // 15

    // Pass slice with ...
    numbers := []int{10, 20, 30}
    fmt.Println(sum(numbers...))  // 60
    ```

    **Variadic with other parameters:**
    ```go
    func printf(format string, args ...interface{}) {
        // format is required, args is variadic
        fmt.Printf(format, args...)
    }

    printf("Hello, %s! You are %d years old\\n", "Alice", 25)
    ```

    **Important: Variadic parameter must be last:**
    ```go
    // ✅ OK
    func foo(a int, b string, rest ...int)

    // ❌ ERROR: variadic must be last
    func bar(rest ...int, a int)
    ```

    ### Defer: Delaying Execution

    **defer schedules a function call to run after the surrounding function returns:**

    **Basic defer:**
    ```go
    func example() {
        fmt.Println("Start")
        defer fmt.Println("Deferred")
        fmt.Println("End")
    }

    // Output:
    // Start
    // End
    // Deferred
    ```

    **Why defer is useful:**

    **1. Resource cleanup:**
    ```go
    func readFile(path string) ([]byte, error) {
        file, err := os.Open(path)
        if err != nil {
            return nil, err
        }
        defer file.Close()  // Always closes, even on error!

        return io.ReadAll(file)
    }
    ```

    **2. Unlock mutexes:**
    ```go
    var mu sync.Mutex

    func criticalSection() {
        mu.Lock()
        defer mu.Unlock()  // Guaranteed to unlock

        // Complex logic with multiple return paths
        if condition1 {
            return
        }
        if condition2 {
            return
        }
        // mu.Unlock() called automatically
    }
    ```

    **3. Timing functions:**
    ```go
    func measureTime(name string) func() {
        start := time.Now()
        return func() {
            fmt.Printf("%s took %v\\n", name, time.Since(start))
        }
    }

    func slowOperation() {
        defer measureTime("slowOperation")()

        // Do work...
        time.Sleep(2 * time.Second)
    }

    // Output: "slowOperation took 2.001s"
    ```

    ### Defer: Order of Execution (LIFO)

    **Defers run in LIFO order (Last In, First Out):**
    ```go
    func example() {
        defer fmt.Println("First defer")
        defer fmt.Println("Second defer")
        defer fmt.Println("Third defer")
        fmt.Println("Function body")
    }

    // Output:
    // Function body
    // Third defer
    // Second defer
    // First defer
    ```

    **Think of it as a stack:**
    ```
    Push: defer A
    Push: defer B
    Push: defer C
    Function returns
    Pop: C executes
    Pop: B executes
    Pop: A executes
    ```

    ### Defer: Argument Evaluation

    **⚠️ Important: Defer arguments are evaluated immediately!**
    ```go
    func example() {
        x := 10
        defer fmt.Println("x is", x)  // x evaluated NOW (10)

        x = 20
        fmt.Println("x changed to", x)
    }

    // Output:
    // x changed to 20
    // x is 10  ← Still 10!
    ```

    **Use closure to capture latest value:**
    ```go
    func example() {
        x := 10
        defer func() {
            fmt.Println("x is", x)  // Closure captures x
        }()

        x = 20
        fmt.Println("x changed to", x)
    }

    // Output:
    // x changed to 20
    // x is 20  ← Updated value!
    ```

    ### Panic and Recover

    **panic: Stop normal execution**

    **When something goes terribly wrong:**
    ```go
    func mustConnect(url string) *Connection {
        conn, err := connect(url)
        if err != nil {
            panic("failed to connect: " + err.Error())
        }
        return conn
    }
    ```

    **What panic does:**
    1. Stops current function execution
    2. Runs all deferred functions (LIFO order)
    3. Returns to caller, which also panics
    4. Continues up the call stack
    5. Program crashes if not recovered

    **recover: Catch a panic**

    **Must be called inside a deferred function:**
    ```go
    func safeDivide(a, b int) (result int, err error) {
        defer func() {
            if r := recover(); r != nil {
                err = fmt.Errorf("panic occurred: %v", r)
            }
        }()

        return a / b, nil  // May panic if b == 0
    }

    result, err := safeDivide(10, 0)
    if err != nil {
        fmt.Println("Error:", err)
        // Error: panic occurred: runtime error: integer divide by zero
    }
    ```

    **Practical panic/recover pattern:**
    ```go
    func parseJSON(data []byte) (result map[string]interface{}, err error) {
        defer func() {
            if r := recover(); r != nil {
                err = fmt.Errorf("JSON parse panic: %v", r)
            }
        }()

        // This might panic on malformed JSON
        json.Unmarshal(data, &result)
        return result, nil
    }
    ```

    ### When to Use Panic vs Error

    **Use errors (return error):**
    - ✅ Expected failures (file not found, network timeout)
    - ✅ Recoverable situations
    - ✅ Public API functions
    - ✅ Most of the time

    **Use panic:**
    - ✅ Programming errors (nil pointer, index out of bounds)
    - ✅ Unrecoverable situations (can't allocate memory)
    - ✅ Initialization failures (config must be valid)
    - ✅ Rare edge cases

    **Example:**
    ```go
    // ✅ GOOD: Return error for expected cases
    func readFile(path string) ([]byte, error) {
        data, err := os.ReadFile(path)
        if err != nil {
            return nil, err
        }
        return data, nil
    }

    // ✅ GOOD: Panic for programming errors
    func divide(a, b int) int {
        if b == 0 {
            panic("divide by zero")  // This should never happen
        }
        return a / b
    }

    // ❌ BAD: Don't panic for normal errors
    func getUser(id int) User {
        user, err := db.Query(id)
        if err != nil {
            panic(err)  // DON'T DO THIS!
        }
        return user
    }
    ```

    ### Higher-Order Functions

    **Functions that take or return functions:**
    ```go
    // Function that returns a function
    func multiplier(factor int) func(int) int {
        return func(x int) int {
            return x * factor
        }
    }

    double := multiplier(2)
    triple := multiplier(3)

    fmt.Println(double(5))  // 10
    fmt.Println(triple(5))  // 15
    ```

    **Function that takes a function:**
    ```go
    func apply(nums []int, fn func(int) int) []int {
        result := make([]int, len(nums))
        for i, num := range nums {
            result[i] = fn(num)
        }
        return result
    }

    numbers := []int{1, 2, 3, 4, 5}

    // Square all numbers
    squared := apply(numbers, func(x int) int {
        return x * x
    })
    fmt.Println(squared)  // [1, 4, 9, 16, 25]
    ```

    ### Practical Example: Middleware Pattern

    ```go
    type Handler func(string) string

    // Middleware adds logging
    func withLogging(h Handler) Handler {
        return func(input string) string {
            fmt.Printf("Input: %s\\n", input)
            result := h(input)
            fmt.Printf("Output: %s\\n", result)
            return result
        }
    }

    // Middleware adds timing
    func withTiming(h Handler) Handler {
        return func(input string) string {
            start := time.Now()
            defer func() {
                fmt.Printf("Took: %v\\n", time.Since(start))
            }()
            return h(input)
        }
    }

    // Core handler
    func uppercase(s string) string {
        return strings.ToUpper(s)
    }

    // Compose middleware
    handler := withLogging(withTiming(uppercase))

    result := handler("hello")
    // Output:
    // Input: hello
    // Output: HELLO
    // Took: 123µs
    ```

    ### Best Practices

    **1. Use defer for cleanup:**
    ```go
    func process() error {
        f, err := os.Open("file.txt")
        if err != nil {
            return err
        }
        defer f.Close()  // Always cleaned up

        // Work with f...
        return nil
    }
    ```

    **2. Keep closures simple:**
    ```go
    // ✅ GOOD: Clear closure
    func makeAdder(x int) func(int) int {
        return func(y int) int {
            return x + y
        }
    }

    // ❌ BAD: Too complex
    func makeComplexClosure() func() {
        var a, b, c, d, e int
        // Closes over many variables
        // Complex logic
    }
    ```

    **3. Don't defer in loops (usually):**
    ```go
    // ❌ BAD: Defers accumulate
    for _, file := range files {
        f, _ := os.Open(file)
        defer f.Close()  // Won't run until function ends!
    }

    // ✅ GOOD: Use helper function
    for _, file := range files {
        processFile(file)
    }

    func processFile(path string) error {
        f, err := os.Open(path)
        if err != nil {
            return err
        }
        defer f.Close()  // Runs after each file
        // process file...
        return nil
    }
    ```

    **4. Use recover sparingly:**
    ```go
    // ✅ GOOD: Protect from external panics
    func safeHandler(w http.ResponseWriter, r *http.Request) {
        defer func() {
            if r := recover(); r != nil {
                log.Printf("panic: %v", r)
                http.Error(w, "Internal Server Error", 500)
            }
        }()
        handle(w, r)  // Might panic
    }

    // ❌ BAD: Using panic/recover for control flow
    func find(items []string, target string) string {
        defer func() {
            recover()  // Catch panic
        }()
        for _, item := range items {
            if item == target {
                panic(item)  // DON'T DO THIS!
            }
        }
        return ""
    }
    ```

    ### Key Takeaways

    1. **Functions are values** - can be assigned, passed, returned
    2. **Closures capture variables** - keep outer variables alive
    3. **Variadic functions** - accept variable arguments with `...`
    4. **defer runs after return** - perfect for cleanup
    5. **defer is LIFO** - last defer runs first
    6. **defer evaluates args immediately** - use closures for late binding
    7. **panic for unrecoverable errors** - not for control flow
    8. **recover in defer** - catch panics gracefully
    9. **Prefer errors over panic** - panic is exceptional
    10. **Higher-order functions** - powerful composition patterns

    **Congratulations!** You now understand Go's powerful function features!
  MARKDOWN
  lesson.key_concepts = ['closures', 'anonymous functions', 'variadic functions', 'defer', 'panic', 'recover', 'higher-order functions', 'first-class functions']
end

# Quiz 1.1: Go Basics
quiz1_1 = Quiz.find_or_create_by!(title: "Go Basics Quiz") do |quiz|
  quiz.description = 'Test your understanding of Go fundamentals'
  quiz.time_limit_minutes = 12
  quiz.passing_score = 70
end

[
  {
    question_text: "What is the entry point of a Go program?",
    question_type: "mcq",
    points: 5,
    options: ["func main()", "main()", "start()", "func start()"],
    correct_answer: "func main()",
    explanation: "Every Go program starts execution in the main() function of the main package."
  },
  {
    question_text: "How do you declare a variable with type inference in Go?",
    question_type: "mcq",
    points: 5,
    options: ["name := \"Alice\"", "var name = \"Alice\"", "name = \"Alice\"", "let name = \"Alice\""],
    correct_answer: "name := \"Alice\"",
    explanation: "The := operator declares and initializes a variable with type inference."
  },
  {
    question_text: "What is the difference between an array and a slice?",
    question_type: "mcq",
    points: 5,
    options: ["Arrays have fixed size, slices are dynamic", "Slices are faster", "Arrays can't be resized", "They're the same"],
    correct_answer: "Arrays have fixed size, slices are dynamic",
    explanation: "Arrays have a fixed size set at compile time, while slices can grow dynamically."
  },
  {
    question_text: "How do you check if a key exists in a map?",
    question_type: "mcq",
    points: 5,
    options: ["value, exists := myMap[key]", "exists := myMap.has(key)", "myMap.contains(key)", "key in myMap"],
    correct_answer: "value, exists := myMap[key]",
    explanation: "Map access returns two values: the value and a boolean indicating if the key exists."
  },
  {
    question_text: "What does 'range' do in Go?",
    question_type: "mcq",
    points: 5,
    options: ["Iterates over elements in a collection", "Creates a numeric range", "Checks if value is in range", "Sorts a collection"],
    correct_answer: "Iterates over elements in a collection",
    explanation: "'range' is used to iterate over arrays, slices, maps, strings, and channels."
  },
  {
    question_text: "Can Go functions return multiple values?",
    question_type: "mcq",
    points: 5,
    options: ["Yes", "No", "Only two values", "Only with tuples"],
    correct_answer: "Yes",
    explanation: "Go functions can return multiple values, commonly used for returning a value and an error."
  },
  {
    question_text: "What is a struct in Go?",
    question_type: "mcq",
    points: 5,
    options: ["A custom type with named fields", "A function type", "A package", "An interface"],
    correct_answer: "A custom type with named fields",
    explanation: "Structs are composite types that group together fields under a single name."
  },
  {
    question_text: "How do you handle errors in Go?",
    question_type: "mcq",
    points: 5,
    options: ["Check error return value", "try-catch blocks", "throw exception", "catch block"],
    correct_answer: "Check error return value",
    explanation: "Go uses explicit error checking by returning error values instead of exceptions."
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
# MODULE 2: Concurrency Fundamentals (existing content preserved)
# ==========================================

module2 = CourseModule.find_or_create_by!(slug: 'concurrency-fundamentals', course: go_course) do |mod|
  mod.title = 'Concurrency Fundamentals'
  mod.description = 'Understanding concurrency vs parallelism and Go\'s approach'
  mod.sequence_order = 2
  mod.estimated_minutes = 40
  mod.published = true
end

# Existing lesson preserved
lesson2_1 = CourseLesson.find_or_create_by!(title: "Concurrency vs Parallelism") do |lesson|
  lesson.reading_time_minutes = 20
  lesson.content = <<~MARKDOWN
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

    ## Key Takeaways

    1. **Concurrency** = Structure (composition of independently executing tasks)
    2. **Parallelism** = Execution (simultaneous execution on multiple cores)
    3. Go makes concurrent programming **simple and safe**
    4. Goroutines are **extremely lightweight** compared to threads
    5. Use **channels** to communicate between goroutines
    6. Go's philosophy: **"Share memory by communicating"**

    Next, we'll dive deep into goroutines!
  MARKDOWN
  lesson.key_concepts = ['concurrency', 'parallelism', 'CSP', 'goroutines vs threads']
end

# Quiz 2.1: Concurrency Concepts
quiz2_1 = Quiz.find_or_create_by!(title: "Concurrency Concepts Quiz") do |quiz|
  quiz.description = 'Test your understanding of concurrency vs parallelism'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
end

[
  {
    question_text: "What is the main difference between concurrency and parallelism?",
    question_type: "mcq",
    points: 5,
    options: ["Concurrency is about structure, parallelism is about execution", "They're the same thing", "Concurrency is faster", "Parallelism uses threads"],
    correct_answer: "Concurrency is about structure, parallelism is about execution",
    explanation: "Concurrency is about dealing with many things at once (structure), while parallelism is about doing many things at once (execution)."
  },
  {
    question_text: "What does CSP stand for in Go?",
    question_type: "mcq",
    points: 5,
    options: ["Communicating Sequential Processes", "Concurrent Sequential Programming", "Channel Synchronization Protocol", "Concurrent Shared Processing"],
    correct_answer: "Communicating Sequential Processes",
    explanation: "CSP (Communicating Sequential Processes) is the concurrency model Go is based on."
  },
  {
    question_text: "What is Go's philosophy about sharing data?",
    question_type: "mcq",
    points: 5,
    options: ["Share memory by communicating", "Communicate by sharing memory", "Use locks everywhere", "Avoid sharing data"],
    correct_answer: "Share memory by communicating",
    explanation: "Go encourages using channels to communicate data instead of sharing memory with locks."
  },
  {
    question_text: "How much memory does a goroutine's initial stack take?",
    question_type: "mcq",
    points: 5,
    options: ["2 KB", "1 MB", "10 KB", "100 bytes"],
    correct_answer: "2 KB",
    explanation: "Goroutines start with only 2 KB of stack, making them extremely lightweight."
  },
  {
    question_text: "Can you create millions of goroutines?",
    question_type: "mcq",
    points: 5,
    options: ["Yes, they're very lightweight", "No, system will crash", "Only thousands", "Only on powerful machines"],
    correct_answer: "Yes, they're very lightweight",
    explanation: "Due to their small memory footprint, you can create millions of goroutines."
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
# MODULE 3: Goroutines (existing preserved)
# ==========================================

module3 = CourseModule.find_or_create_by!(slug: 'goroutines', course: go_course) do |mod|
  mod.title = 'Goroutines'
  mod.description = 'Master lightweight concurrent functions in Go'
  mod.sequence_order = 3
  mod.estimated_minutes = 50
  mod.published = true
end

lesson3_1 = CourseLesson.find_or_create_by!(title: "Introduction to Goroutines") do |lesson|
  lesson.reading_time_minutes = 30
  lesson.content = <<~MARKDOWN
    # Introduction to Goroutines

    ### What is a Goroutine?

    A **goroutine** is a lightweight thread managed by the Go runtime. Think of it as a function that runs concurrently with other functions.

    **The magic word:** `go`

    Adding `go` before a function call makes it run in a new goroutine!

    ```go
    func sayHello() {
        fmt.Println("Hello from goroutine!")
    }

    func main() {
        go sayHello()  // Runs concurrently!
        fmt.Println("Hello from main!")
    }
    ```

    ### Why Goroutines Matter

    **Traditional threading (OS threads):**
    - Heavy (1-2 MB stack per thread)
    - Expensive to create (~milliseconds)
    - Limited count (thousands max)
    - Managed by OS kernel

    **Goroutines:**
    - Lightweight (2 KB initial stack)
    - Cheap to create (~microseconds)
    - Can create millions
    - Managed by Go runtime

    **Real-world impact:**
    ```
    C++ with OS threads:  1,000 concurrent tasks   = ~1-2 GB memory
    Go with goroutines:   1,000,000 concurrent tasks = ~2 GB memory
    ```

    Go lets you create **1000x more** concurrent tasks!

    ### Creating Goroutines

    **Basic syntax:**
    ```go
    go functionName()        // Call existing function
    go methodName()          // Call method
    go func() {              // Anonymous function
        fmt.Println("Hi!")
    }()                      // Note the () to call it
    ```

    **Complete example:**
    ```go
    package main

    import (
        "fmt"
        "time"
    )

    func printNumbers() {
        for i := 1; i <= 5; i++ {
            fmt.Printf("Number: %d\\n", i)
            time.Sleep(100 * time.Millisecond)
        }
    }

    func printLetters() {
        for i := 'A'; i <= 'E'; i++ {
            fmt.Printf("Letter: %c\\n", i)
            time.Sleep(150 * time.Millisecond)
        }
    }

    func main() {
        go printNumbers()  // Runs concurrently
        go printLetters()  // Runs concurrently

        // Wait for goroutines to finish
        time.Sleep(1 * time.Second)
        fmt.Println("Done!")
    }
    ```

    **Output (interleaved!):**
    ```
    Number: 1
    Letter: A
    Number: 2
    Number: 3
    Letter: B
    Number: 4
    Letter: C
    Number: 5
    Letter: D
    Letter: E
    Done!
    ```

    Notice: Numbers and letters print in an **interleaved** pattern because both goroutines run concurrently!

    ### How Goroutines Work

    **The Go Runtime Scheduler:**

    Go uses an M:N scheduler (M goroutines on N OS threads):

    ```
    Goroutines: [G1][G2][G3][G4][G5][G6][G7][G8]...millions
                      ↓       ↓       ↓       ↓
    OS Threads:    [T1]    [T2]    [T3]    [T4]
                      ↓       ↓       ↓       ↓
    CPU Cores:     [C1]    [C2]    [C3]    [C4]
    ```

    **How it works:**
    1. Go creates a few OS threads (usually = number of CPU cores)
    2. Scheduler multiplexes goroutines onto these threads
    3. When a goroutine blocks (I/O, channel), scheduler runs another
    4. Goroutines cooperatively yield (automatic context switching)

    **Why this is fast:**
    - Context switching happens in user space (no kernel involvement)
    - Goroutines have tiny stacks that grow/shrink dynamically
    - Scheduler is built into Go runtime (optimized for Go code)

    ### Common Goroutine Patterns

    **1. Fire and forget:**
    ```go
    func logEvent(msg string) {
        // Log to file/database
        fmt.Println("Logged:", msg)
    }

    func handleRequest() {
        go logEvent("User logged in")  // Don't wait for logging
        // Continue handling request immediately
    }
    ```

    **2. Anonymous goroutines with closures:**
    ```go
    for i := 0; i < 5; i++ {
        go func(n int) {  // Pass i as parameter!
            fmt.Println("Goroutine", n)
        }(i)
    }
    ```

    ⚠️ **Common mistake - closure bug:**
    ```go
    // ❌ WRONG: All goroutines see final value of i
    for i := 0; i < 5; i++ {
        go func() {
            fmt.Println(i)  // All print 5!
        }()
    }

    // ✅ CORRECT: Pass i as parameter
    for i := 0; i < 5; i++ {
        go func(n int) {
            fmt.Println(n)  // Each prints its own value
        }(i)
    }
    ```

    **3. Parallel processing:**
    ```go
    func processFile(filename string) {
        // Process file...
    }

    files := []string{"file1.txt", "file2.txt", "file3.txt"}

    for _, file := range files {
        go processFile(file)  // Process all files concurrently!
    }
    ```

    ### WaitGroups: Waiting for Goroutines

    **The Problem:**
    ```go
    go doWork()
    // Program exits immediately - goroutine may not finish!
    ```

    **The Solution: sync.WaitGroup**
    ```go
    import "sync"

    var wg sync.WaitGroup

    func worker(id int) {
        defer wg.Done()  // Signal we're done
        fmt.Printf("Worker %d starting\\n", id)
        time.Sleep(time.Second)
        fmt.Printf("Worker %d done\\n", id)
    }

    func main() {
        for i := 1; i <= 5; i++ {
            wg.Add(1)  // Add 1 to wait group
            go worker(i)
        }

        wg.Wait()  // Block until all Done() called
        fmt.Println("All workers finished!")
    }
    ```

    **How WaitGroup works:**
    1. `wg.Add(1)` - Increment counter
    2. `wg.Done()` - Decrement counter (inside goroutine)
    3. `wg.Wait()` - Block until counter reaches 0

    ### Real-World Example: Concurrent HTTP Requests

    **Sequential (slow):**
    ```go
    urls := []string{
        "https://api1.example.com",
        "https://api2.example.com",
        "https://api3.example.com",
    }

    for _, url := range urls {
        resp, _ := http.Get(url)  // Wait for each
        // ... process response
    }
    // Total time: 3 seconds (1 sec per request)
    ```

    **Concurrent (fast):**
    ```go
    var wg sync.WaitGroup

    for _, url := range urls {
        wg.Add(1)
        go func(u string) {
            defer wg.Done()
            resp, _ := http.Get(u)  // All run in parallel
            // ... process response
        }(url)
    }

    wg.Wait()
    // Total time: ~1 second (all requests at once)
    ```

    **3x speed improvement!**

    ### Goroutine Lifecycle

    **Created:**
    ```go
    go myFunction()  // New goroutine created
    ```

    **Running:**
    - Goroutine executes code
    - Can yield to other goroutines (I/O, channel ops)

    **Blocked:**
    - Waiting for channel
    - Waiting for lock
    - Sleeping (time.Sleep)

    **Finished:**
    - Function returns
    - Goroutine is garbage collected

    **Important:** Main goroutine exiting kills all other goroutines!

    ```go
    func main() {
        go longRunningTask()
        // Main exits - longRunningTask() is killed!
    }
    ```

    ### Goroutine Best Practices

    **1. Always have a way to stop goroutines:**
    ```go
    // Use context for cancellation
    ctx, cancel := context.WithCancel(context.Background())
    defer cancel()

    go func(ctx context.Context) {
        for {
            select {
            case <-ctx.Done():
                return  // Stop goroutine
            default:
                // Do work
            }
        }
    }(ctx)
    ```

    **2. Use WaitGroups or channels for synchronization:**
    ```go
    // Don't use sleep to wait!
    // ❌ time.Sleep(1 * time.Second)  // Guessing!

    // ✅ Use WaitGroup
    wg.Wait()
    ```

    **3. Avoid goroutine leaks:**
    ```go
    // ❌ BAD: Goroutine never exits
    go func() {
        for {
            // Infinite loop with no exit condition
        }
    }()

    // ✅ GOOD: Can be stopped
    done := make(chan bool)
    go func() {
        for {
            select {
            case <-done:
                return
            default:
                // Do work
            }
        }
    }()

    // Later: stop the goroutine
    done <- true
    ```

    **4. Pass parameters, don't rely on closures in loops:**
    ```go
    // ❌ WRONG
    for i := 0; i < 10; i++ {
        go func() { fmt.Println(i) }()  // All print 10!
    }

    // ✅ CORRECT
    for i := 0; i < 10; i++ {
        go func(n int) { fmt.Println(n) }(i)
    }
    ```

    ### Performance Characteristics

    **Memory:**
    - Initial stack: 2 KB
    - Grows/shrinks dynamically
    - 1 million goroutines ≈ 2 GB

    **Creation time:**
    - ~1-2 microseconds
    - Can create thousands per second

    **Context switch:**
    - ~10-50 nanoseconds (in user space)
    - OS thread: ~1-2 microseconds (kernel space)

    ### Common Pitfalls

    **1. Forgetting to wait:**
    ```go
    func main() {
        go fmt.Println("Hello")
        // Program exits before goroutine runs!
    }
    ```

    **2. Data races (accessing shared variables):**
    ```go
    counter := 0
    for i := 0; i < 1000; i++ {
        go func() {
            counter++  // RACE CONDITION!
        }()
    }
    ```

    Use `-race` flag: `go run -race main.go` to detect races.

    **3. Too many goroutines:**
    ```go
    // Creating millions of goroutines for CPU-bound tasks
    // Better to use worker pool pattern
    ```

    ### Key Takeaways

    1. Goroutines are lightweight threads (2 KB vs 1-2 MB)
    2. Created with `go` keyword: `go function()`
    3. Use WaitGroups to wait for goroutines to finish
    4. Pass parameters to avoid closure bugs in loops
    5. Always have a way to stop goroutines (avoid leaks)
    6. Use `-race` flag to detect data races
    7. Perfect for I/O-bound tasks (network, file operations)

    Next: Learn about **Channels** for safe communication between goroutines!
  MARKDOWN
  lesson.key_concepts = ['goroutines', 'concurrency', 'sync.WaitGroup', 'goroutine lifecycle']
end

# ==========================================
# MODULE 4: Channels (existing preserved)
# ==========================================

module4 = CourseModule.find_or_create_by!(slug: 'channels', course: go_course) do |mod|
  mod.title = 'Channels'
  mod.description = 'Learn safe communication between goroutines using channels'
  mod.sequence_order = 4
  mod.estimated_minutes = 60
  mod.published = true
end

lesson4_1 = CourseLesson.find_or_create_by!(title: "Introduction to Channels") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # Introduction to Channels

    ### What is a Channel?

    A **channel** is a typed pipe through which you can send and receive values between goroutines. It's Go's way of **safely sharing data** between concurrent code.

    **Think of it as:**
    - A pipe/tube connecting goroutines
    - A message queue
    - A safe way to communicate

    **The golden rule:** "Don't communicate by sharing memory; share memory by communicating."

    ### Why Channels?

    **The Problem (shared memory):**
    ```go
    var counter int  // Shared variable

    go func() { counter++ }()  // Goroutine 1
    go func() { counter++ }()  // Goroutine 2
    // RACE CONDITION! Unsafe!
    ```

    **The Solution (channels):**
    ```go
    ch := make(chan int)

    go func() { ch <- 1 }()  // Send to channel
    value := <-ch            // Receive from channel
    // Safe! No race conditions!
    ```

    ### Creating Channels

    **Syntax:**
    ```go
    ch := make(chan Type)  // Unbuffered channel
    ch := make(chan Type, capacity)  // Buffered channel
    ```

    **Examples:**
    ```go
    messages := make(chan string)       // String channel
    numbers := make(chan int)           // Int channel
    results := make(chan bool, 10)      // Buffered channel (capacity 10)
    ```

    ### Sending and Receiving

    **Sending (arrow points INTO channel):**
    ```go
    ch <- value  // Send value to channel
    ```

    **Receiving (arrow points OUT OF channel):**
    ```go
    value := <-ch  // Receive from channel
    ```

    **Complete example:**
    ```go
    package main

    import "fmt"

    func main() {
        messages := make(chan string)

        // Send in goroutine
        go func() {
            messages <- "Hello from goroutine!"
        }()

        // Receive in main
        msg := <-messages
        fmt.Println(msg)  // "Hello from goroutine!"
    }
    ```

    ### Unbuffered vs Buffered Channels

    **Unbuffered Channel (synchronous):**
    ```go
    ch := make(chan int)  // No buffer
    ```

    **Behavior:**
    - Sender BLOCKS until receiver is ready
    - Receiver BLOCKS until sender sends
    - Synchronization point (handshake)

    **Example:**
    ```go
    ch := make(chan int)

    go func() {
        fmt.Println("Sending...")
        ch <- 42  // Blocks until someone receives
        fmt.Println("Sent!")
    }()

    time.Sleep(2 * time.Second)
    fmt.Println("Receiving...")
    value := <-ch  // Unblocks sender
    fmt.Println("Received:", value)

    // Output:
    // Sending...
    // (2 second pause)
    // Receiving...
    // Sent!
    // Received: 42
    ```

    **Buffered Channel (asynchronous):**
    ```go
    ch := make(chan int, 3)  // Buffer of 3
    ```

    **Behavior:**
    - Sender only blocks when buffer is FULL
    - Receiver only blocks when buffer is EMPTY
    - Can send multiple values without receiver

    **Example:**
    ```go
    ch := make(chan int, 2)  // Buffer size 2

    ch <- 1  // Doesn't block (buffer has space)
    ch <- 2  // Doesn't block (buffer full now)
    // ch <- 3  // Would block! Buffer full

    fmt.Println(<-ch)  // 1
    fmt.Println(<-ch)  // 2
    ```

    ### Channel Directions

    **Bi-directional (default):**
    ```go
    ch := make(chan int)  // Can send AND receive
    ```

    **Send-only:**
    ```go
    func sendOnly(ch chan<- int) {
        ch <- 42  // Can send
        // value := <-ch  // ERROR: can't receive
    }
    ```

    **Receive-only:**
    ```go
    func receiveOnly(ch <-chan int) {
        value := <-ch  // Can receive
        // ch <- 42  // ERROR: can't send
    }
    ```

    **Why use directional channels?**
    - Type safety (compiler enforces correct usage)
    - Clear intent (function signature shows behavior)
    - Prevent mistakes

    **Complete example:**
    ```go
    func producer(ch chan<- int) {  // Send-only
        for i := 0; i < 5; i++ {
            ch <- i
        }
        close(ch)
    }

    func consumer(ch <-chan int) {  // Receive-only
        for value := range ch {
            fmt.Println("Received:", value)
        }
    }

    func main() {
        ch := make(chan int)  // Bi-directional
        go producer(ch)       // Implicitly converts to send-only
        consumer(ch)          // Implicitly converts to receive-only
    }
    ```

    ### Closing Channels

    **Why close channels?**
    - Signal "no more values will be sent"
    - Allow range loops to terminate
    - Prevent goroutine leaks

    **How to close:**
    ```go
    close(ch)  // Only sender should close!
    ```

    ⚠️ **Rules:**
    1. **Only sender closes** (not receiver)
    2. **Never send on closed channel** (panic!)
    3. **Can receive from closed channel** (gets zero value)

    **Detecting closed channels:**
    ```go
    value, ok := <-ch
    if !ok {
        fmt.Println("Channel closed!")
    }
    ```

    **Using range (stops when channel closes):**
    ```go
    for value := range ch {
        fmt.Println(value)
    }
    // Loop exits when ch is closed
    ```

    **Complete example:**
    ```go
    func generator(ch chan int) {
        for i := 0; i < 5; i++ {
            ch <- i
        }
        close(ch)  // Signal done
    }

    func main() {
        ch := make(chan int)
        go generator(ch)

        for value := range ch {  // Receives until closed
            fmt.Println(value)
        }
        fmt.Println("Channel closed, loop exited")
    }
    ```

    ### Select Statement: Multiplexing Channels

    **What is select?**
    Like a `switch` for channels - waits on multiple channel operations.

    **Basic syntax:**
    ```go
    select {
    case msg := <-ch1:
        fmt.Println("Received from ch1:", msg)
    case msg := <-ch2:
        fmt.Println("Received from ch2:", msg)
    case ch3 <- value:
        fmt.Println("Sent to ch3")
    default:
        fmt.Println("No channel ready")
    }
    ```

    **Example: Timeout pattern:**
    ```go
    select {
    case result := <-ch:
        fmt.Println("Got result:", result)
    case <-time.After(1 * time.Second):
        fmt.Println("Timeout!")
    }
    ```

    **Example: Non-blocking receive:**
    ```go
    select {
    case msg := <-ch:
        fmt.Println("Received:", msg)
    default:
        fmt.Println("No message available")
    }
    ```

    **Example: Fan-in (merge multiple channels):**
    ```go
    func fanIn(ch1, ch2 <-chan int) <-chan int {
        out := make(chan int)
        go func() {
            for {
                select {
                case v := <-ch1:
                    out <- v
                case v := <-ch2:
                    out <- v
                }
            }
        }()
        return out
    }
    ```

    ### Common Channel Patterns

    **1. Worker Pool:**
    ```go
    func worker(id int, jobs <-chan int, results chan<- int) {
        for job := range jobs {
            fmt.Printf("Worker %d processing job %d\\n", id, job)
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

        // Send jobs
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

    **2. Pipeline:**
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
        // Set up pipeline: generate -> square
        for n := range square(generator(2, 3, 4)) {
            fmt.Println(n)  // 4, 9, 16
        }
    }
    ```

    **3. Done channel (cancellation):**
    ```go
    func worker(done <-chan bool) {
        for {
            select {
            case <-done:
                fmt.Println("Worker stopping")
                return
            default:
                fmt.Println("Working...")
                time.Sleep(500 * time.Millisecond)
            }
        }
    }

    func main() {
        done := make(chan bool)
        go worker(done)

        time.Sleep(2 * time.Second)
        close(done)  // Signal worker to stop
        time.Sleep(1 * time.Second)
    }
    ```

    ### Nil Channels

    **What happens with nil channels?**
    - Send on nil channel: **blocks forever**
    - Receive on nil channel: **blocks forever**

    **Why is this useful?**
    Disable a case in select:

    ```go
    var ch1, ch2 chan int  // nil channels

    select {
    case <-ch1:  // Disabled (nil channel)
        fmt.Println("ch1")
    case <-ch2:  // Disabled (nil channel)
        fmt.Println("ch2")
    }
    // select blocks forever!
    ```

    **Useful pattern:**
    ```go
    ch1 := make(chan int)
    ch2 := make(chan int)

    for ch1 != nil || ch2 != nil {
        select {
        case v, ok := <-ch1:
            if !ok {
                ch1 = nil  // Disable this case
                continue
            }
            fmt.Println("ch1:", v)
        case v, ok := <-ch2:
            if !ok {
                ch2 = nil  // Disable this case
                continue
            }
            fmt.Println("ch2:", v)
        }
    }
    ```

    ### Common Mistakes

    **1. Deadlock - no receiver:**
    ```go
    ch := make(chan int)
    ch <- 42  // Blocks forever - no receiver!
    // fatal error: all goroutines are asleep - deadlock!
    ```

    **2. Sending on closed channel:**
    ```go
    ch := make(chan int)
    close(ch)
    ch <- 42  // PANIC: send on closed channel
    ```

    **3. Closing receive-only channel:**
    ```go
    func receiver(ch <-chan int) {
        close(ch)  // ERROR: cannot close receive-only channel
    }
    ```

    **4. Forgetting to close channel:**
    ```go
    for value := range ch {  // Waits forever if ch never closes
        fmt.Println(value)
    }
    ```

    ### Best Practices

    **1. Only sender closes channels:**
    ```go
    // ✅ GOOD
    func sender(ch chan int) {
        ch <- 42
        close(ch)
    }

    // ❌ BAD
    func receiver(ch chan int) {
        <-ch
        close(ch)  // Receiver shouldn't close!
    }
    ```

    **2. Use buffered channels for performance:**
    ```go
    // Unbuffered: each send waits for receive (slow)
    ch := make(chan int)

    // Buffered: sends don't wait until buffer full (faster)
    ch := make(chan int, 100)
    ```

    **3. Use directional channels in function signatures:**
    ```go
    func send(ch chan<- int) { ch <- 42 }  // Can only send
    func receive(ch <-chan int) { <-ch }   // Can only receive
    ```

    **4. Use select for timeouts:**
    ```go
    select {
    case result := <-ch:
        return result
    case <-time.After(1 * time.Second):
        return errors.New("timeout")
    }
    ```

    ### Performance Characteristics

    **Unbuffered channel:**
    - Send/Receive: ~50-100 ns
    - Synchronization overhead

    **Buffered channel:**
    - Send/Receive (when not full/empty): ~10-20 ns
    - Faster, but uses more memory

    **Memory:**
    - Channel struct: ~96 bytes
    - Buffered: + (capacity × element size)

    ### Key Takeaways

    1. Channels safely communicate between goroutines
    2. Unbuffered channels synchronize (block sender/receiver)
    3. Buffered channels allow async sends (up to capacity)
    4. Always close channels from sender side
    5. Use `select` to multiplex multiple channels
    6. Use directional channels for type safety
    7. Common patterns: worker pool, pipeline, fan-in/fan-out

    **Next:** Learn advanced concurrency patterns with channels!
  MARKDOWN
  lesson.key_concepts = ['channels', 'unbuffered', 'buffered', 'select', 'channel patterns']
end

# ==========================================
# MODULE 5: Interfaces (NEW)
# ==========================================

module5 = CourseModule.find_or_create_by!(slug: 'interfaces', course: go_course) do |mod|
  mod.title = 'Interfaces'
  mod.description = 'Master Go interfaces for polymorphism and abstraction'
  mod.sequence_order = 5
  mod.estimated_minutes = 55
  mod.published = true
end

lesson5_1 = CourseLesson.find_or_create_by!(title: "Interfaces in Go") do |lesson|
  lesson.reading_time_minutes = 30
  lesson.content = <<~MARKDOWN
    # Interfaces in Go

    **Interfaces** define behavior without specifying implementation. They're Go's way of achieving polymorphism.

    ## Defining Interfaces

    ```go
    type Writer interface {
        Write([]byte) (int, error)
    }

    type Reader interface {
        Read([]byte) (int, error)
    }
    ```

    ## Implementing Interfaces

    **Implicit implementation** - no "implements" keyword needed!

    ```go
    type File struct {
        path string
    }

    // File implements Writer by having a Write method
    func (f *File) Write(data []byte) (int, error) {
        fmt.Printf("Writing %d bytes to %s\\n", len(data), f.path)
        return len(data), nil
    }

    // Use it polymorphically
    var w Writer = &File{path: "/tmp/data.txt"}
    w.Write([]byte("Hello"))
    ```

    ## Empty Interface

    `interface{}` can hold any type:

    ```go
    func PrintAnything(v interface{}) {
        fmt.Println(v)
    }

    PrintAnything(42)
    PrintAnything("hello")
    PrintAnything([]int{1, 2, 3})
    ```

    ## Type Assertions

    ```go
    var i interface{} = "hello"

    // Type assertion
    s := i.(string)
    fmt.Println(s)  // "hello"

    // Safe type assertion
    s, ok := i.(string)
    if ok {
        fmt.Println(s)
    }

    // Type switch
    switch v := i.(type) {
    case string:
        fmt.Printf("String: %s\\n", v)
    case int:
        fmt.Printf("Int: %d\\n", v)
    default:
        fmt.Printf("Unknown type\\n")
    }
    ```

    ## Common Standard Interfaces

    ### io.Reader and io.Writer
    ```go
    type Reader interface {
        Read(p []byte) (n int, err error)
    }

    type Writer interface {
        Write(p []byte) (n int, err error)
    }
    ```

    ### fmt.Stringer
    ```go
    type Stringer interface {
        String() string
    }

    type Person struct {
        Name string
        Age  int
    }

    func (p Person) String() string {
        return fmt.Sprintf("%s (%d years)", p.Name, p.Age)
    }

    person := Person{Name: "Alice", Age: 25}
    fmt.Println(person)  // Calls String() method
    ```

    ### error interface
    ```go
    type error interface {
        Error() string
    }

    type MyError struct {
        Code    int
        Message string
    }

    func (e MyError) Error() string {
        return fmt.Sprintf("Error %d: %s", e.Code, e.Message)
    }
    ```

    ## Interface Composition

    Combine interfaces:

    ```go
    type Reader interface {
        Read([]byte) (int, error)
    }

    type Writer interface {
        Write([]byte) (int, error)
    }

    type ReadWriter interface {
        Reader
        Writer
    }

    // Or inline
    type ReadWriteCloser interface {
        Read([]byte) (int, error)
        Write([]byte) (int, error)
        Close() error
    }
    ```

    ## Practical Example

    ```go
    type Shape interface {
        Area() float64
        Perimeter() float64
    }

    type Circle struct {
        Radius float64
    }

    func (c Circle) Area() float64 {
        return math.Pi * c.Radius * c.Radius
    }

    func (c Circle) Perimeter() float64 {
        return 2 * math.Pi * c.Radius
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

    func PrintShapeInfo(s Shape) {
        fmt.Printf("Area: %.2f\\n", s.Area())
        fmt.Printf("Perimeter: %.2f\\n", s.Perimeter())
    }

    circle := Circle{Radius: 5}
    rectangle := Rectangle{Width: 10, Height: 5}

    PrintShapeInfo(circle)
    PrintShapeInfo(rectangle)
    ```

    ## Best Practices

    1. **Keep interfaces small**: Prefer single-method interfaces
    2. **Accept interfaces, return structs**: Functions should accept interfaces but return concrete types
    3. **Interface at usage point**: Define interfaces where they're used, not where types are defined
    4. **Implicit satisfaction**: Don't explicitly declare implementation

    **Practice:** Try the Interfaces lab!
  MARKDOWN
  lesson.key_concepts = ['interfaces', 'polymorphism', 'type assertions', 'empty interface', 'implicit implementation']
end

# Quiz 5.1: Interfaces
quiz5_1 = Quiz.find_or_create_by!(title: "Interfaces Quiz") do |quiz|
  quiz.description = 'Test your knowledge of Go interfaces'
  quiz.time_limit_minutes = 10
  quiz.passing_score = 70
end

[
  {
    question_text: "How does a type implement an interface in Go?",
    question_type: "mcq",
    points: 5,
    options: ["Implicitly by having the required methods", "Using 'implements' keyword", "Explicitly declaring it", "Extending the interface"],
    correct_answer: "Implicitly by having the required methods",
    explanation: "Go uses implicit interface satisfaction - if a type has all the methods, it implements the interface."
  },
  {
    question_text: "What is the empty interface?",
    question_type: "mcq",
    points: 5,
    options: ["interface{} that can hold any type", "An interface with no methods", "A nil interface", "An invalid interface"],
    correct_answer: "interface{} that can hold any type",
    explanation: "The empty interface interface{} has no methods, so all types satisfy it."
  },
  {
    question_text: "What is a type assertion?",
    question_type: "mcq",
    points: 5,
    options: ["Extracting the concrete type from interface", "Checking if type exists", "Converting types", "Creating new types"],
    correct_answer: "Extracting the concrete type from interface",
    explanation: "Type assertions extract the concrete value from an interface value."
  },
  {
    question_text: "What does the Stringer interface do?",
    question_type: "mcq",
    points: 5,
    options: ["Defines String() method for custom printing", "Concatenates strings", "Converts to string", "Validates strings"],
    correct_answer: "Defines String() method for custom printing",
    explanation: "Types that implement String() string satisfy fmt.Stringer and control their print representation."
  },
  {
    question_text: "What's the best practice for interface size?",
    question_type: "mcq",
    points: 5,
    options: ["Keep interfaces small and focused", "Make large comprehensive interfaces", "One interface per package", "Interfaces should have 10+ methods"],
    correct_answer: "Keep interfaces small and focused",
    explanation: "Small, focused interfaces are more flexible and easier to implement."
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz5_1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer]
    question.explanation = q_data[:explanation]
  end
end

# ==========================================
# MODULE 6: Testing (NEW)
# ==========================================

module6 = CourseModule.find_or_create_by!(slug: 'testing', course: go_course) do |mod|
  mod.title = 'Testing in Go'
  mod.description = 'Write effective tests, benchmarks, and use test-driven development'
  mod.sequence_order = 6
  mod.estimated_minutes = 50
  mod.published = true
end

lesson6_1 = CourseLesson.find_or_create_by!(title: "Testing Basics") do |lesson|
  lesson.reading_time_minutes = 30
  lesson.content = <<~MARKDOWN
    # Testing in Go

    Go has built-in testing support. Write tests alongside your code!

    ## Basic Test

    File: `math.go`
    ```go
    package math

    func Add(a, b int) int {
        return a + b
    }
    ```

    File: `math_test.go`
    ```go
    package math

    import "testing"

    func TestAdd(t *testing.T) {
        result := Add(2, 3)
        expected := 5

        if result != expected {
            t.Errorf("Add(2, 3) = %d; want %d", result, expected)
        }
    }
    ```

    Run tests:
    ```bash
    go test
    go test -v  # verbose
    go test -cover  # with coverage
    ```

    ## Table-Driven Tests

    Test multiple cases efficiently:

    ```go
    func TestAdd(t *testing.T) {
        tests := []struct {
            name     string
            a, b     int
            expected int
        }{
            {"positive numbers", 2, 3, 5},
            {"negative numbers", -2, -3, -5},
            {"mixed signs", -2, 3, 1},
            {"zeros", 0, 0, 0},
        }

        for _, tt := range tests {
            t.Run(tt.name, func(t *testing.T) {
                result := Add(tt.a, tt.b)
                if result != tt.expected {
                    t.Errorf("Add(%d, %d) = %d; want %d",
                        tt.a, tt.b, result, tt.expected)
                }
            })
        }
    }
    ```

    ## Test Helpers

    ```go
    func assertEqual(t *testing.T, got, want int) {
        t.Helper()  // Mark as helper
        if got != want {
            t.Errorf("got %d; want %d", got, want)
        }
    }

    func TestSomething(t *testing.T) {
        assertEqual(t, Add(2, 3), 5)
    }
    ```

    ## Benchmarks

    Measure performance:

    ```go
    func BenchmarkAdd(b *testing.B) {
        for i := 0; i < b.N; i++ {
            Add(2, 3)
        }
    }
    ```

    Run benchmarks:
    ```bash
    go test -bench=.
    go test -bench=. -benchmem  # with memory stats
    ```

    ## Examples (Testable Documentation)

    ```go
    func ExampleAdd() {
        result := Add(2, 3)
        fmt.Println(result)
        // Output: 5
    }

    func ExampleAdd_negative() {
        result := Add(-2, -3)
        fmt.Println(result)
        // Output: -5
    }
    ```

    ## Test Coverage

    ```bash
    go test -cover
    go test -coverprofile=coverage.out
    go tool cover -html=coverage.out
    ```

    ## Mocking

    Use interfaces for testability:

    ```go
    type UserRepository interface {
        GetUser(id int) (*User, error)
    }

    type UserService struct {
        repo UserRepository
    }

    // Mock for testing
    type MockUserRepository struct {
        users map[int]*User
    }

    func (m *MockUserRepository) GetUser(id int) (*User, error) {
        if user, ok := m.users[id]; ok {
            return user, nil
        }
        return nil, errors.New("user not found")
    }

    func TestUserService(t *testing.T) {
        mockRepo := &MockUserRepository{
            users: map[int]*User{
                1: {ID: 1, Name: "Alice"},
            },
        }

        service := UserService{repo: mockRepo}
        user, err := service.repo.GetUser(1)

        if err != nil {
            t.Fatal(err)
        }
        if user.Name != "Alice" {
            t.Errorf("expected Alice, got %s", user.Name)
        }
    }
    ```

    ## Test Organization

    ```
    myproject/
    ├── math.go
    ├── math_test.go
    ├── user.go
    ├── user_test.go
    └── testdata/
        └── fixtures.json
    ```

    ## Best Practices

    1. **One test file per source file**: `math.go` → `math_test.go`
    2. **Use table-driven tests**: Test multiple cases efficiently
    3. **Test exported functions**: Focus on public API
    4. **Keep tests fast**: Fast tests are run more often
    5. **Use t.Helper()**: For test utility functions
    6. **Aim for high coverage**: But don't obsess over 100%

    **Practice:** Try the Testing lab!
  MARKDOWN
  lesson.key_concepts = ['unit tests', 'table-driven tests', 'benchmarks', 'test coverage', 'mocking']
end

# ==========================================
# MODULE 7: Practical Go Development (NEW)
# ==========================================

module7 = CourseModule.find_or_create_by!(slug: 'practical-go', course: go_course) do |mod|
  mod.title = 'Practical Go Development'
  mod.description = 'Essential skills for production Go: context, JSON, and HTTP'
  mod.sequence_order = 7
  mod.estimated_minutes = 90
  mod.published = true
end

# Lesson 7.1: Context Package - Advanced Concurrency
lesson7_1 = CourseLesson.find_or_create_by!(title: "Context Package: Managing Goroutine Lifecycles") do |lesson|
  lesson.reading_time_minutes = 30
  lesson.content = <<~MARKDOWN
    # Context Package: Managing Goroutine Lifecycles

    ### What is Context?

    The **context package** is Go's standard way to manage cancellation, deadlines, and request-scoped values across goroutines. It's essential for production Go applications.

    **Why Context matters:**
    - ✅ Cancel long-running operations
    - ✅ Set timeouts for operations
    - ✅ Pass request-scoped data (like user IDs, trace IDs)
    - ✅ Prevent goroutine leaks
    - ✅ Clean shutdown of services

    **Import:**
    ```go
    import "context"
    ```

    ### The Context Interface

    ```go
    type Context interface {
        Deadline() (deadline time.Time, ok bool)
        Done() <-chan struct{}
        Err() error
        Value(key interface{}) interface{}
    }
    ```

    **Four key methods:**
    - `Deadline()` - Returns when context will be cancelled
    - `Done()` - Channel that closes when context is cancelled
    - `Err()` - Returns why context was cancelled
    - `Value(key)` - Retrieves request-scoped values

    ### Creating Contexts

    **1. Background Context (root context):**
    ```go
    ctx := context.Background()
    // Use for main function, initialization, tests
    ```

    **2. TODO Context (placeholder):**
    ```go
    ctx := context.TODO()
    // Use when you're not sure which context to use yet
    ```

    **3. WithCancel - Manual cancellation:**
    ```go
    ctx, cancel := context.WithCancel(context.Background())
    defer cancel()  // Always call cancel to free resources

    // Later, to cancel:
    cancel()
    ```

    **4. WithTimeout - Automatic cancellation after duration:**
    ```go
    ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
    defer cancel()

    // Automatically cancelled after 5 seconds
    ```

    **5. WithDeadline - Cancel at specific time:**
    ```go
    deadline := time.Now().Add(1 * time.Hour)
    ctx, cancel := context.WithDeadline(context.Background(), deadline)
    defer cancel()

    // Automatically cancelled at deadline
    ```

    **6. WithValue - Attach request-scoped data:**
    ```go
    ctx := context.WithValue(context.Background(), "userID", 12345)

    // Later, retrieve value:
    userID := ctx.Value("userID").(int)
    ```

    ### Basic Cancellation Pattern

    **Problem: Goroutine that never stops:**
    ```go
    // ❌ BAD: No way to stop this goroutine!
    go func() {
        for {
            // Do work forever
            doWork()
        }
    }()
    ```

    **Solution: Use context:**
    ```go
    // ✅ GOOD: Respects cancellation
    func worker(ctx context.Context) {
        for {
            select {
            case <-ctx.Done():
                fmt.Println("Worker cancelled:", ctx.Err())
                return
            default:
                doWork()
            }
        }
    }

    ctx, cancel := context.WithCancel(context.Background())
    go worker(ctx)

    // Later, when you want to stop:
    cancel()
    ```

    ### Timeout Pattern

    **Prevent operations from running forever:**
    ```go
    func fetchData(ctx context.Context, url string) ([]byte, error) {
        req, err := http.NewRequestWithContext(ctx, "GET", url, nil)
        if err != nil {
            return nil, err
        }

        resp, err := http.DefaultClient.Do(req)
        if err != nil {
            return nil, err
        }
        defer resp.Body.Close()

        return io.ReadAll(resp.Body)
    }

    // Usage with timeout
    ctx, cancel := context.WithTimeout(context.Background(), 3*time.Second)
    defer cancel()

    data, err := fetchData(ctx, "https://api.example.com/data")
    if err != nil {
        if err == context.DeadlineExceeded {
            fmt.Println("Request timed out!")
        }
        return err
    }
    ```

    ### Propagating Context Through Call Stack

    **Context should be the first parameter:**
    ```go
    func processRequest(ctx context.Context, userID int) error {
        // Check if already cancelled
        if err := ctx.Err(); err != nil {
            return err
        }

        // Pass context down to other functions
        data, err := fetchUserData(ctx, userID)
        if err != nil {
            return err
        }

        return saveData(ctx, data)
    }

    func fetchUserData(ctx context.Context, userID int) (*UserData, error) {
        // This function also respects cancellation
        select {
        case <-ctx.Done():
            return nil, ctx.Err()
        default:
            // Fetch data
        }
    }
    ```

    ### Real-World Example: HTTP Server with Timeout

    ```go
    package main

    import (
        "context"
        "fmt"
        "net/http"
        "time"
    )

    func slowHandler(w http.ResponseWriter, r *http.Request) {
        // Create context with 5-second timeout
        ctx, cancel := context.WithTimeout(r.Context(), 5*time.Second)
        defer cancel()

        // Simulate slow operation
        result := make(chan string, 1)
        go func() {
            time.Sleep(10 * time.Second)  // Simulates slow work
            result <- "Success"
        }()

        // Wait for result or timeout
        select {
        case <-ctx.Done():
            http.Error(w, "Request timeout", http.StatusRequestTimeout)
            fmt.Println("Request cancelled:", ctx.Err())
        case res := <-result:
            fmt.Fprintf(w, "Result: %s", res)
        }
    }

    func main() {
        http.HandleFunc("/slow", slowHandler)
        http.ListenAndServe(":8080", nil)
    }
    ```

    ### Context Values: Request-Scoped Data

    **Passing data through call chain:**
    ```go
    type contextKey string

    const (
        userIDKey    contextKey = "userID"
        requestIDKey contextKey = "requestID"
    )

    func handler(w http.ResponseWriter, r *http.Request) {
        // Extract user from authentication
        userID := getUserFromAuth(r)

        // Add to context
        ctx := context.WithValue(r.Context(), userIDKey, userID)
        ctx = context.WithValue(ctx, requestIDKey, generateRequestID())

        // Process with context
        processRequest(ctx)
    }

    func processRequest(ctx context.Context) {
        // Retrieve values
        userID, ok := ctx.Value(userIDKey).(int)
        if !ok {
            log.Println("No user ID in context")
            return
        }

        requestID := ctx.Value(requestIDKey).(string)
        log.Printf("Processing request %s for user %d", requestID, userID)
    }
    ```

    **⚠️ Best Practice: Use typed keys, not strings:**
    ```go
    // ❌ BAD: String keys can collide
    ctx := context.WithValue(ctx, "userID", 123)

    // ✅ GOOD: Use custom type
    type contextKey string
    const userIDKey contextKey = "userID"
    ctx := context.WithValue(ctx, userIDKey, 123)
    ```

    ### Practical Pattern: Database Query with Timeout

    ```go
    func getUserByID(ctx context.Context, db *sql.DB, id int) (*User, error) {
        // Database query respects context
        query := "SELECT id, name, email FROM users WHERE id = ?"

        var user User
        err := db.QueryRowContext(ctx, query, id).Scan(
            &user.ID,
            &user.Name,
            &user.Email,
        )

        if err != nil {
            return nil, err
        }
        return &user, nil
    }

    // Usage with timeout
    func main() {
        ctx, cancel := context.WithTimeout(context.Background(), 2*time.Second)
        defer cancel()

        user, err := getUserByID(ctx, db, 123)
        if err != nil {
            if err == context.DeadlineExceeded {
                log.Println("Database query timed out")
            }
            return
        }
        fmt.Printf("Found user: %+v\\n", user)
    }
    ```

    ### Context with Multiple Goroutines

    **Cancelling multiple workers:**
    ```go
    func fanOut(ctx context.Context, jobs <-chan int, numWorkers int) {
        var wg sync.WaitGroup

        for i := 0; i < numWorkers; i++ {
            wg.Add(1)
            go func(workerID int) {
                defer wg.Done()

                for {
                    select {
                    case <-ctx.Done():
                        fmt.Printf("Worker %d stopped\\n", workerID)
                        return
                    case job, ok := <-jobs:
                        if !ok {
                            return
                        }
                        processJob(ctx, job)
                    }
                }
            }(i)
        }

        wg.Wait()
    }

    func processJob(ctx context.Context, job int) {
        // Check context before expensive work
        if err := ctx.Err(); err != nil {
            return
        }

        // Do work...
        time.Sleep(100 * time.Millisecond)
        fmt.Printf("Processed job %d\\n", job)
    }

    // Usage
    ctx, cancel := context.WithCancel(context.Background())
    jobs := make(chan int, 10)

    // Start workers
    go fanOut(ctx, jobs, 5)

    // Send jobs
    for i := 0; i < 20; i++ {
        jobs <- i
    }
    close(jobs)

    // Cancel all workers after 1 second
    time.Sleep(1 * time.Second)
    cancel()
    ```

    ### Graceful Shutdown Pattern

    ```go
    package main

    import (
        "context"
        "fmt"
        "os"
        "os/signal"
        "syscall"
        "time"
    )

    func main() {
        // Create context that cancels on SIGINT/SIGTERM
        ctx, cancel := context.WithCancel(context.Background())
        defer cancel()

        // Handle shutdown signals
        sigChan := make(chan os.Signal, 1)
        signal.Notify(sigChan, syscall.SIGINT, syscall.SIGTERM)

        go func() {
            <-sigChan
            fmt.Println("\\nShutdown signal received")
            cancel()
        }()

        // Start workers
        var wg sync.WaitGroup
        for i := 0; i < 3; i++ {
            wg.Add(1)
            go worker(ctx, &wg, i)
        }

        // Wait for graceful shutdown
        wg.Wait()
        fmt.Println("All workers stopped. Clean shutdown complete.")
    }

    func worker(ctx context.Context, wg *sync.WaitGroup, id int) {
        defer wg.Done()

        ticker := time.NewTicker(500 * time.Millisecond)
        defer ticker.Stop()

        for {
            select {
            case <-ctx.Done():
                fmt.Printf("Worker %d shutting down\\n", id)
                return
            case <-ticker.C:
                fmt.Printf("Worker %d working\\n", id)
            }
        }
    }
    ```

    ### Context Best Practices

    **1. Always pass context as first parameter:**
    ```go
    // ✅ GOOD
    func processData(ctx context.Context, data []byte) error

    // ❌ BAD
    func processData(data []byte, ctx context.Context) error
    ```

    **2. Never store context in structs:**
    ```go
    // ❌ BAD
    type Handler struct {
        ctx context.Context
    }

    // ✅ GOOD
    type Handler struct {
        // other fields
    }

    func (h *Handler) Handle(ctx context.Context) error {
        // Use context as parameter
    }
    ```

    **3. Always call cancel() from WithCancel/WithTimeout:**
    ```go
    // ✅ GOOD: Always call cancel
    ctx, cancel := context.WithTimeout(ctx, 5*time.Second)
    defer cancel()  // Frees resources
    ```

    **4. Check context before expensive operations:**
    ```go
    func expensiveOperation(ctx context.Context) error {
        // Check early
        if err := ctx.Err(); err != nil {
            return err
        }

        // Do expensive work...

        // Check again during long operation
        select {
        case <-ctx.Done():
            return ctx.Err()
        default:
            // Continue work
        }
    }
    ```

    **5. Use context.Value() sparingly:**
    ```go
    // ✅ GOOD: Request-scoped values (user ID, trace ID)
    ctx = context.WithValue(ctx, requestIDKey, uuid.New())

    // ❌ BAD: Passing optional parameters
    ctx = context.WithValue(ctx, "option1", true)
    ctx = context.WithValue(ctx, "option2", "value")
    ```

    **6. Never pass nil context:**
    ```go
    // ❌ BAD
    processData(nil, data)

    // ✅ GOOD
    processData(context.Background(), data)
    // or
    processData(context.TODO(), data)
    ```

    ### Context Errors

    **Two standard errors:**
    ```go
    if err := ctx.Err(); err != nil {
        switch err {
        case context.Canceled:
            // Context was cancelled via cancel()
            fmt.Println("Operation cancelled")
        case context.DeadlineExceeded:
            // Context timed out
            fmt.Println("Operation timed out")
        }
    }
    ```

    ### Common Mistakes

    **1. Not checking context during loops:**
    ```go
    // ❌ BAD: Loop never checks cancellation
    for i := 0; i < 1000000; i++ {
        processItem(item)
    }

    // ✅ GOOD: Check context periodically
    for i := 0; i < 1000000; i++ {
        select {
        case <-ctx.Done():
            return ctx.Err()
        default:
            processItem(item)
        }
    }
    ```

    **2. Ignoring context in blocking calls:**
    ```go
    // ❌ BAD: Doesn't respect context
    data, err := http.Get(url)

    // ✅ GOOD: Use context
    req, _ := http.NewRequestWithContext(ctx, "GET", url, nil)
    data, err := http.DefaultClient.Do(req)
    ```

    **3. Creating context per goroutine:**
    ```go
    // ❌ BAD: Each worker has separate context
    for i := 0; i < 10; i++ {
        ctx := context.Background()
        go worker(ctx)  // Can't cancel all at once!
    }

    // ✅ GOOD: Share parent context
    ctx, cancel := context.WithCancel(context.Background())
    for i := 0; i < 10; i++ {
        go worker(ctx)  // All can be cancelled together
    }
    ```

    ### Real-World Example: API Client with Retries

    ```go
    func fetchWithRetry(ctx context.Context, url string, maxRetries int) ([]byte, error) {
        var lastErr error

        for i := 0; i < maxRetries; i++ {
            // Check if context cancelled
            if err := ctx.Err(); err != nil {
                return nil, err
            }

            // Create request with context
            req, err := http.NewRequestWithContext(ctx, "GET", url, nil)
            if err != nil {
                return nil, err
            }

            resp, err := http.DefaultClient.Do(req)
            if err == nil && resp.StatusCode == 200 {
                defer resp.Body.Close()
                return io.ReadAll(resp.Body)
            }

            lastErr = err
            if i < maxRetries-1 {
                // Exponential backoff with context
                select {
                case <-time.After(time.Second * time.Duration(1<<i)):
                case <-ctx.Done():
                    return nil, ctx.Err()
                }
            }
        }

        return nil, fmt.Errorf("failed after %d retries: %w", maxRetries, lastErr)
    }

    // Usage
    ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
    defer cancel()

    data, err := fetchWithRetry(ctx, "https://api.example.com/data", 3)
    ```

    ### Key Takeaways

    1. **Context manages lifecycles** - cancellation, timeouts, deadlines
    2. **Always pass as first parameter** - `func foo(ctx context.Context, ...)`
    3. **Always defer cancel()** - frees resources
    4. **Check ctx.Done()** - respect cancellation
    5. **Use WithTimeout** for operations that shouldn't run forever
    6. **Propagate context** through call stack
    7. **Don't store context** in structs
    8. **Use context.Value() sparingly** - only for request-scoped data
    9. **context.Background()** - for main, init, tests
    10. **Graceful shutdown** - cancel on signals

    **Context is essential for production Go - it prevents goroutine leaks and enables clean shutdowns!**
  MARKDOWN
  lesson.key_concepts = ['context', 'cancellation', 'timeout', 'deadline', 'context.Value', 'graceful shutdown', 'goroutine lifecycle']
end

# Lesson 7.2: JSON Encoding and Decoding
lesson7_2 = CourseLesson.find_or_create_by!(title: "Working with JSON") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
    # Working with JSON in Go

    ### Why JSON in Go?

    JSON (JavaScript Object Notation) is the most common data format for:
    - ✅ REST APIs
    - ✅ Configuration files
    - ✅ Data storage
    - ✅ Communication between services

    Go's `encoding/json` package makes JSON handling straightforward and type-safe.

    **Import:**
    ```go
    import "encoding/json"
    ```

    ### Basic Concepts

    **Two main operations:**
    1. **Marshal** (Encoding): Go struct → JSON string
    2. **Unmarshal** (Decoding): JSON string → Go struct

    ### Marshaling (Go to JSON)

    **Basic struct to JSON:**
    ```go
    type Person struct {
        Name string
        Age  int
        City string
    }

    person := Person{
        Name: "Alice",
        Age:  25,
        City: "New York",
    }

    // Convert to JSON
    jsonData, err := json.Marshal(person)
    if err != nil {
        log.Fatal(err)
    }

    fmt.Println(string(jsonData))
    // Output: {"Name":"Alice","Age":25,"City":"New York"}
    ```

    **Pretty-printed JSON:**
    ```go
    jsonData, err := json.MarshalIndent(person, "", "  ")
    if err != nil {
        log.Fatal(err)
    }

    fmt.Println(string(jsonData))
    // Output:
    // {
    //   "Name": "Alice",
    //   "Age": 25,
    //   "City": "New York"
    // }
    ```

    ### Struct Tags: Controlling JSON Output

    **Field tags customize JSON encoding:**
    ```go
    type User struct {
        ID        int       \`json:"id"\`                    // Lowercase in JSON
        Username  string    \`json:"username"\`
        Email     string    \`json:"email"\`
        Password  string    \`json:"-"\`                    // Never include
        CreatedAt time.Time \`json:"created_at"\`
        UpdatedAt time.Time \`json:"updated_at,omitempty"\` // Omit if zero value
        Active    bool      \`json:"is_active"\`
    }

    user := User{
        ID:       123,
        Username: "alice",
        Email:    "alice@example.com",
        Password: "secret123",  // Won't appear in JSON!
    }

    jsonData, _ := json.MarshalIndent(user, "", "  ")
    fmt.Println(string(jsonData))
    // {
    //   "id": 123,
    //   "username": "alice",
    //   "email": "alice@example.com",
    //   "created_at": "0001-01-01T00:00:00Z",
    //   "is_active": false
    // }
    // Note: password is excluded, updated_at omitted (zero value)
    ```

    ### Common Struct Tag Options

    ```go
    type Product struct {
        Name     string  \`json:"name"\`              // Custom field name
        Price    float64 \`json:"price"\`
        Internal string  \`json:"-"\`                 // Never marshal/unmarshal
        Optional string  \`json:"description,omitempty"\` // Omit if empty
        Quantity int     \`json:"qty,string"\`        // Convert to string
    }
    ```

    **Tag options:**
    - `json:"fieldname"` - Custom JSON field name
    - `json:"-"` - Ignore field completely
    - `json:",omitempty"` - Omit if zero value (0, "", false, nil)
    - `json:",string"` - Marshal as string instead of number

    ### Unmarshaling (JSON to Go)

    **JSON to struct:**
    ```go
    jsonString := \`{
        "name": "Bob",
        "age": 30,
        "city": "Boston"
    }\`

    var person Person
    err := json.Unmarshal([]byte(jsonString), &person)
    if err != nil {
        log.Fatal(err)
    }

    fmt.Printf("%+v\\n", person)
    // {Name:Bob Age:30 City:Boston}
    ```

    **⚠️ Important: Pass pointer to Unmarshal!**
    ```go
    // ❌ WRONG: Doesn't work
    var person Person
    json.Unmarshal(jsonData, person)

    // ✅ CORRECT: Pass pointer
    var person Person
    json.Unmarshal(jsonData, &person)
    ```

    ### Handling Unknown JSON Structure

    **Use map[string]interface{} for flexible JSON:**
    ```go
    jsonString := \`{
        "name": "Alice",
        "age": 25,
        "scores": [95, 87, 92],
        "active": true
    }\`

    var data map[string]interface{}
    json.Unmarshal([]byte(jsonString), &data)

    // Access fields with type assertions
    name := data["name"].(string)
    age := data["age"].(float64)  // JSON numbers are float64!
    scores := data["scores"].([]interface{})
    active := data["active"].(bool)

    fmt.Printf("Name: %s, Age: %.0f\\n", name, age)
    ```

    ### JSON Arrays

    **Marshaling slices:**
    ```go
    users := []User{
        {ID: 1, Username: "alice"},
        {ID: 2, Username: "bob"},
        {ID: 3, Username: "charlie"},
    }

    jsonData, _ := json.MarshalIndent(users, "", "  ")
    fmt.Println(string(jsonData))
    // [
    //   {"id": 1, "username": "alice", ...},
    //   {"id": 2, "username": "bob", ...},
    //   {"id": 3, "username": "charlie", ...}
    // ]
    ```

    **Unmarshaling arrays:**
    ```go
    jsonString := \`[
        {"id": 1, "username": "alice"},
        {"id": 2, "username": "bob"}
    ]\`

    var users []User
    json.Unmarshal([]byte(jsonString), &users)

    for _, user := range users {
        fmt.Printf("%d: %s\\n", user.ID, user.Username)
    }
    ```

    ### Nested Structures

    ```go
    type Address struct {
        Street  string \`json:"street"\`
        City    string \`json:"city"\`
        ZipCode string \`json:"zip_code"\`
    }

    type Person struct {
        Name    string  \`json:"name"\`
        Age     int     \`json:"age"\`
        Address Address \`json:"address"\`
    }

    person := Person{
        Name: "Alice",
        Age:  25,
        Address: Address{
            Street:  "123 Main St",
            City:    "New York",
            ZipCode: "10001",
        },
    }

    jsonData, _ := json.MarshalIndent(person, "", "  ")
    // {
    //   "name": "Alice",
    //   "age": 25,
    //   "address": {
    //     "street": "123 Main St",
    //     "city": "New York",
    //     "zip_code": "10001"
    //   }
    // }
    ```

    ### Working with JSON Files

    **Write JSON to file:**
    ```go
    func saveToFile(filename string, data interface{}) error {
        file, err := os.Create(filename)
        if err != nil {
            return err
        }
        defer file.Close()

        encoder := json.NewEncoder(file)
        encoder.SetIndent("", "  ")  // Pretty print
        return encoder.Encode(data)
    }

    // Usage
    user := User{ID: 123, Username: "alice"}
    saveToFile("user.json", user)
    ```

    **Read JSON from file:**
    ```go
    func loadFromFile(filename string, v interface{}) error {
        file, err := os.Open(filename)
        if err != nil {
            return err
        }
        defer file.Close()

        decoder := json.NewDecoder(file)
        return decoder.Decode(v)
    }

    // Usage
    var user User
    err := loadFromFile("user.json", &user)
    ```

    ### JSON Encoder/Decoder (Streaming)

    **For large data or network streams:**
    ```go
    // Write JSON stream
    func writeUsers(w io.Writer, users []User) error {
        encoder := json.NewEncoder(w)
        for _, user := range users {
            if err := encoder.Encode(user); err != nil {
                return err
            }
        }
        return nil
    }

    // Read JSON stream
    func readUsers(r io.Reader) ([]User, error) {
        var users []User
        decoder := json.NewDecoder(r)

        for {
            var user User
            err := decoder.Decode(&user)
            if err == io.EOF {
                break
            }
            if err != nil {
                return nil, err
            }
            users = append(users, user)
        }
        return users, nil
    }
    ```

    ### Custom JSON Marshaling

    **Implement MarshalJSON for custom encoding:**
    ```go
    type Color struct {
        R, G, B uint8
    }

    func (c Color) MarshalJSON() ([]byte, error) {
        // Custom format: "#RRGGBB"
        hex := fmt.Sprintf("#%02x%02x%02x", c.R, c.G, c.B)
        return json.Marshal(hex)
    }

    color := Color{R: 255, G: 100, B: 50}
    jsonData, _ := json.Marshal(color)
    fmt.Println(string(jsonData))  // "#ff6432"
    ```

    **Implement UnmarshalJSON for custom decoding:**
    ```go
    func (c *Color) UnmarshalJSON(data []byte) error {
        var hex string
        if err := json.Unmarshal(data, &hex); err != nil {
            return err
        }

        // Parse "#RRGGBB"
        _, err := fmt.Sscanf(hex, "#%02x%02x%02x", &c.R, &c.G, &c.B)
        return err
    }

    jsonString := \`"#ff6432"\`
    var color Color
    json.Unmarshal([]byte(jsonString), &color)
    fmt.Printf("RGB: %d, %d, %d\\n", color.R, color.G, color.B)
    ```

    ### Handling Dates and Time

    **time.Time marshals to RFC3339 by default:**
    ```go
    type Event struct {
        Name string    \`json:"name"\`
        Time time.Time \`json:"timestamp"\`
    }

    event := Event{
        Name: "Conference",
        Time: time.Now(),
    }

    jsonData, _ := json.Marshal(event)
    // {"name":"Conference","timestamp":"2025-11-05T10:30:00Z"}
    ```

    **Custom date format:**
    ```go
    type CustomDate time.Time

    func (cd CustomDate) MarshalJSON() ([]byte, error) {
        t := time.Time(cd)
        formatted := t.Format("2006-01-02")
        return json.Marshal(formatted)
    }

    func (cd *CustomDate) UnmarshalJSON(data []byte) error {
        var dateStr string
        if err := json.Unmarshal(data, &dateStr); err != nil {
            return err
        }

        t, err := time.Parse("2006-01-02", dateStr)
        if err != nil {
            return err
        }

        *cd = CustomDate(t)
        return nil
    }
    ```

    ### Error Handling

    **Check for unmarshal errors:**
    ```go
    jsonString := \`{"name": "Alice", "age": "not a number"}\`

    var person Person
    err := json.Unmarshal([]byte(jsonString), &person)
    if err != nil {
        if syntaxErr, ok := err.(*json.SyntaxError); ok {
            fmt.Printf("Syntax error at byte %d\\n", syntaxErr.Offset)
        }
        if typeErr, ok := err.(*json.UnmarshalTypeError); ok {
            fmt.Printf("Type error: field %s expected %s but got %s\\n",
                typeErr.Field, typeErr.Type, typeErr.Value)
        }
        log.Fatal(err)
    }
    ```

    ### Real-World Example: REST API Response

    ```go
    type APIResponse struct {
        Success bool        \`json:"success"\`
        Message string      \`json:"message,omitempty"\`
        Data    interface{} \`json:"data,omitempty"\`
        Error   string      \`json:"error,omitempty"\`
    }

    type User struct {
        ID       int    \`json:"id"\`
        Username string \`json:"username"\`
        Email    string \`json:"email"\`
    }

    func getUserHandler(w http.ResponseWriter, r *http.Request) {
        user := User{
            ID:       123,
            Username: "alice",
            Email:    "alice@example.com",
        }

        response := APIResponse{
            Success: true,
            Data:    user,
        }

        w.Header().Set("Content-Type", "application/json")
        json.NewEncoder(w).Encode(response)
    }

    func errorHandler(w http.ResponseWriter, message string, code int) {
        response := APIResponse{
            Success: false,
            Error:   message,
        }

        w.Header().Set("Content-Type", "application/json")
        w.WriteStatus(code)
        json.NewEncoder(w).Encode(response)
    }
    ```

    ### Best Practices

    **1. Use struct tags for clarity:**
    ```go
    // ✅ GOOD: Clear JSON mapping
    type User struct {
        ID       int    \`json:"id"\`
        Username string \`json:"username"\`
    }

    // ❌ BAD: Relies on field names
    type User struct {
        ID       int
        Username string
    }
    ```

    **2. Omit sensitive data:**
    ```go
    type User struct {
        ID       int    \`json:"id"\`
        Username string \`json:"username"\`
        Password string \`json:"-"\`           // Never marshal
        Token    string \`json:"-"\`
    }
    ```

    **3. Use omitempty for optional fields:**
    ```go
    type Profile struct {
        Name     string \`json:"name"\`
        Bio      string \`json:"bio,omitempty"\`      // Optional
        Website  string \`json:"website,omitempty"\`
        Location string \`json:"location,omitempty"\`
    }
    ```

    **4. Validate after unmarshaling:**
    ```go
    var user User
    if err := json.Unmarshal(data, &user); err != nil {
        return err
    }

    // Validate
    if user.Email == "" {
        return errors.New("email is required")
    }
    if user.Age < 0 {
        return errors.New("invalid age")
    }
    ```

    **5. Use json.RawMessage for delayed parsing:**
    ```go
    type Event struct {
        Type string          \`json:"type"\`
        Data json.RawMessage \`json:"data"\` // Parse later based on type
    }

    // Parse differently based on event type
    if event.Type == "user_created" {
        var user User
        json.Unmarshal(event.Data, &user)
    } else if event.Type == "order_placed" {
        var order Order
        json.Unmarshal(event.Data, &order)
    }
    ```

    ### Common Mistakes

    **1. Forgetting to export fields:**
    ```go
    // ❌ WRONG: Lowercase fields won't be marshaled
    type User struct {
        id       int    // Not exported
        username string // Not exported
    }

    // ✅ CORRECT: Capital letters
    type User struct {
        ID       int    \`json:"id"\`
        Username string \`json:"username"\`
    }
    ```

    **2. Not handling errors:**
    ```go
    // ❌ WRONG: Ignoring errors
    json.Unmarshal(data, &user)

    // ✅ CORRECT: Check errors
    if err := json.Unmarshal(data, &user); err != nil {
        return fmt.Errorf("failed to parse JSON: %w", err)
    }
    ```

    **3. Using wrong types for numbers:**
    ```go
    // JSON numbers unmarshal to float64 by default!
    var data map[string]interface{}
    json.Unmarshal([]byte(\`{"count": 10}\`), &data)

    // ❌ WRONG: Will panic
    count := data["count"].(int)

    // ✅ CORRECT: JSON numbers are float64
    count := int(data["count"].(float64))
    ```

    ### Key Takeaways

    1. **json.Marshal()** - Go to JSON
    2. **json.Unmarshal()** - JSON to Go (use pointer!)
    3. **Struct tags** control JSON field names and behavior
    4. **\`json:"-"\`** - ignore field
    5. **\`json:",omitempty"\`** - omit zero values
    6. **Export fields** (capitalize) to marshal/unmarshal
    7. **Encoder/Decoder** for streams
    8. **Custom Marshal/Unmarshal** for special formatting
    9. **Always handle errors** from JSON operations
    10. **Validate data** after unmarshaling

    **JSON handling in Go is type-safe, efficient, and straightforward with proper struct tags!**
  MARKDOWN
  lesson.key_concepts = ['JSON', 'marshal', 'unmarshal', 'struct tags', 'encoding/json', 'JSON encoder', 'JSON decoder', 'custom marshaling']
end

# Lesson 7.3: HTTP Networking and REST APIs
lesson7_3 = CourseLesson.find_or_create_by!(title: "HTTP Networking and Building REST APIs") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # HTTP Networking and Building REST APIs

    ### Go's HTTP Package

    Go's **net/http** package makes it easy to:
    - ✅ Build HTTP servers
    - ✅ Create REST APIs
    - ✅ Make HTTP client requests
    - ✅ Handle routing and middleware

    **Import:**
    ```go
    import "net/http"
    ```

    ### Simple HTTP Server

    **Hello World server:**
    ```go
    package main

    import (
        "fmt"
        "net/http"
    )

    func handler(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "Hello, World!")
    }

    func main() {
        http.HandleFunc("/", handler)
        fmt.Println("Server starting on :8080")
        http.ListenAndServe(":8080", nil)
    }
    ```

    **Visit http://localhost:8080 to see: "Hello, World!"**

    ### HTTP Handler Function

    **Handler signature:**
    ```go
    func handler(w http.ResponseWriter, r *http.Request) {
        // w - write response
        // r - read request
    }
    ```

    **ResponseWriter methods:**
    - `Write([]byte)` - Write response body
    - `WriteHeader(int)` - Set HTTP status code
    - `Header()` - Access response headers

    **Request fields:**
    - `r.Method` - HTTP method (GET, POST, etc.)
    - `r.URL` - Request URL
    - `r.Header` - Request headers
    - `r.Body` - Request body
    - `r.FormValue()` - Get form data

    ### Routing

    **Multiple routes:**
    ```go
    func main() {
        http.HandleFunc("/", homeHandler)
        http.HandleFunc("/about", aboutHandler)
        http.HandleFunc("/contact", contactHandler)

        http.ListenAndServe(":8080", nil)
    }

    func homeHandler(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "Home Page")
    }

    func aboutHandler(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "About Page")
    }
    ```

    ### HTTP Methods

    **Handle different HTTP methods:**
    ```go
    func userHandler(w http.ResponseWriter, r *http.Request) {
        switch r.Method {
        case http.MethodGet:
            // GET /user - List users
            fmt.Fprintf(w, "Get users")
        case http.MethodPost:
            // POST /user - Create user
            fmt.Fprintf(w, "Create user")
        case http.MethodPut:
            // PUT /user - Update user
            fmt.Fprintf(w, "Update user")
        case http.MethodDelete:
            // DELETE /user - Delete user
            fmt.Fprintf(w, "Delete user")
        default:
            w.WriteHeader(http.StatusMethodNotAllowed)
            fmt.Fprintf(w, "Method not allowed")
        }
    }
    ```

    ### JSON REST API

    **Complete CRUD API example:**
    ```go
    package main

    import (
        "encoding/json"
        "net/http"
        "sync"
    )

    type User struct {
        ID       int    \`json:"id"\`
        Username string \`json:"username"\`
        Email    string \`json:"email"\`
    }

    var (
        users   = make(map[int]User)
        nextID  = 1
        usersMu sync.RWMutex
    )

    // GET /users - List all users
    func listUsers(w http.ResponseWriter, r *http.Request) {
        usersMu.RLock()
        defer usersMu.RUnlock()

        userList := make([]User, 0, len(users))
        for _, user := range users {
            userList = append(userList, user)
        }

        w.Header().Set("Content-Type", "application/json")
        json.NewEncoder(w).Encode(userList)
    }

    // POST /users - Create user
    func createUser(w http.ResponseWriter, r *http.Request) {
        var user User
        if err := json.NewDecoder(r.Body).Decode(&user); err != nil {
            http.Error(w, err.Error(), http.StatusBadRequest)
            return
        }

        usersMu.Lock()
        user.ID = nextID
        nextID++
        users[user.ID] = user
        usersMu.Unlock()

        w.Header().Set("Content-Type", "application/json")
        w.WriteHeader(http.StatusCreated)
        json.NewEncoder(w).Encode(user)
    }

    func main() {
        http.HandleFunc("/users", func(w http.ResponseWriter, r *http.Request) {
            switch r.Method {
            case http.MethodGet:
                listUsers(w, r)
            case http.MethodPost:
                createUser(w, r)
            default:
                w.WriteHeader(http.StatusMethodNotAllowed)
            }
        })

        http.ListenAndServe(":8080", nil)
    }
    ```

    ### URL Parameters

    **Extract URL path parameters:**
    ```go
    import "strings"

    // GET /user/123
    func getUserHandler(w http.ResponseWriter, r *http.Request) {
        // Extract ID from /user/{id}
        parts := strings.Split(r.URL.Path, "/")
        if len(parts) < 3 {
            http.Error(w, "Invalid URL", http.StatusBadRequest)
            return
        }

        id := parts[2]  // "123"
        fmt.Fprintf(w, "User ID: %s", id)
    }
    ```

    **Query parameters:**
    ```go
    // GET /search?q=golang&page=2
    func searchHandler(w http.ResponseWriter, r *http.Request) {
        query := r.URL.Query()

        searchTerm := query.Get("q")     // "golang"
        page := query.Get("page")        // "2"

        fmt.Fprintf(w, "Searching for: %s, page: %s", searchTerm, page)
    }
    ```

    ### Request Body

    **Reading JSON request body:**
    ```go
    type CreateUserRequest struct {
        Username string \`json:"username"\`
        Email    string \`json:"email"\`
    }

    func createUser(w http.ResponseWriter, r *http.Request) {
        var req CreateUserRequest

        // Decode JSON body
        if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
            http.Error(w, "Invalid JSON", http.StatusBadRequest)
            return
        }
        defer r.Body.Close()

        // Validate
        if req.Username == "" {
            http.Error(w, "Username required", http.StatusBadRequest)
            return
        }

        // Create user...
        fmt.Fprintf(w, "Created user: %s", req.Username)
    }
    ```

    ### HTTP Status Codes

    **Set response status:**
    ```go
    w.WriteHeader(http.StatusOK)          // 200
    w.WriteHeader(http.StatusCreated)     // 201
    w.WriteHeader(http.StatusBadRequest)  // 400
    w.WriteHeader(http.StatusNotFound)    // 404
    w.WriteHeader(http.StatusInternalServerError) // 500
    ```

    **Using http.Error() helper:**
    ```go
    http.Error(w, "User not found", http.StatusNotFound)
    // Sets status code and writes error message
    ```

    ### Headers

    **Set response headers:**
    ```go
    w.Header().Set("Content-Type", "application/json")
    w.Header().Set("Cache-Control", "no-cache")
    w.Header().Set("X-Custom-Header", "value")
    ```

    **Read request headers:**
    ```go
    authToken := r.Header.Get("Authorization")
    contentType := r.Header.Get("Content-Type")
    ```

    ### Middleware Pattern

    **Wrap handlers with middleware:**
    ```go
    // Logging middleware
    func loggingMiddleware(next http.HandlerFunc) http.HandlerFunc {
        return func(w http.ResponseWriter, r *http.Request) {
            log.Printf("%s %s", r.Method, r.URL.Path)
            next(w, r)  // Call next handler
        }
    }

    // Auth middleware
    func authMiddleware(next http.HandlerFunc) http.HandlerFunc {
        return func(w http.ResponseWriter, r *http.Request) {
            token := r.Header.Get("Authorization")
            if token != "secret-token" {
                http.Error(w, "Unauthorized", http.StatusUnauthorized)
                return
            }
            next(w, r)
        }
    }

    // Usage
    func main() {
        http.HandleFunc("/public", loggingMiddleware(publicHandler))
        http.HandleFunc("/private", loggingMiddleware(authMiddleware(privateHandler)))

        http.ListenAndServe(":8080", nil)
    }
    ```

    ### HTTP Client: Making Requests

    **GET request:**
    ```go
    resp, err := http.Get("https://api.example.com/users")
    if err != nil {
        log.Fatal(err)
    }
    defer resp.Body.Close()

    body, err := io.ReadAll(resp.Body)
    if err != nil {
        log.Fatal(err)
    }

    fmt.Println(string(body))
    ```

    **POST request with JSON:**
    ```go
    user := User{Username: "alice", Email: "alice@example.com"}

    jsonData, _ := json.Marshal(user)

    resp, err := http.Post(
        "https://api.example.com/users",
        "application/json",
        bytes.NewBuffer(jsonData),
    )
    if err != nil {
        log.Fatal(err)
    }
    defer resp.Body.Close()

    fmt.Println("Status:", resp.Status)
    ```

    **Custom request with headers:**
    ```go
    client := &http.Client{
        Timeout: 10 * time.Second,
    }

    req, err := http.NewRequest("GET", "https://api.example.com/data", nil)
    if err != nil {
        log.Fatal(err)
    }

    // Set headers
    req.Header.Set("Authorization", "Bearer token123")
    req.Header.Set("Accept", "application/json")

    resp, err := client.Do(req)
    if err != nil {
        log.Fatal(err)
    }
    defer resp.Body.Close()

    // Check status
    if resp.StatusCode != http.StatusOK {
        log.Printf("Unexpected status: %s", resp.Status)
    }
    ```

    ### Complete REST API Example

    ```go
    package main

    import (
        "encoding/json"
        "log"
        "net/http"
        "strconv"
        "strings"
        "sync"
    )

    type Todo struct {
        ID        int    \`json:"id"\`
        Title     string \`json:"title"\`
        Completed bool   \`json:"completed"\`
    }

    type TodoStore struct {
        mu    sync.RWMutex
        todos map[int]Todo
        nextID int
    }

    func NewTodoStore() *TodoStore {
        return &TodoStore{
            todos: make(map[int]Todo),
            nextID: 1,
        }
    }

    func (s *TodoStore) List() []Todo {
        s.mu.RLock()
        defer s.mu.RUnlock()

        list := make([]Todo, 0, len(s.todos))
        for _, todo := range s.todos {
            list = append(list, todo)
        }
        return list
    }

    func (s *TodoStore) Get(id int) (Todo, bool) {
        s.mu.RLock()
        defer s.mu.RUnlock()

        todo, ok := s.todos[id]
        return todo, ok
    }

    func (s *TodoStore) Create(title string) Todo {
        s.mu.Lock()
        defer s.mu.Unlock()

        todo := Todo{
            ID:        s.nextID,
            Title:     title,
            Completed: false,
        }
        s.todos[s.nextID] = todo
        s.nextID++

        return todo
    }

    func (s *TodoStore) Update(id int, completed bool) bool {
        s.mu.Lock()
        defer s.mu.Unlock()

        if todo, ok := s.todos[id]; ok {
            todo.Completed = completed
            s.todos[id] = todo
            return true
        }
        return false
    }

    func (s *TodoStore) Delete(id int) bool {
        s.mu.Lock()
        defer s.mu.Unlock()

        if _, ok := s.todos[id]; ok {
            delete(s.todos, id)
            return true
        }
        return false
    }

    type TodoHandler struct {
        store *TodoStore
    }

    func (h *TodoHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
        w.Header().Set("Content-Type", "application/json")

        // Parse ID from URL
        var id int
        if r.URL.Path != "/todos" && r.URL.Path != "/todos/" {
            parts := strings.Split(r.URL.Path, "/")
            if len(parts) >= 3 {
                id, _ = strconv.Atoi(parts[2])
            }
        }

        switch r.Method {
        case http.MethodGet:
            if id > 0 {
                h.getTodo(w, id)
            } else {
                h.listTodos(w)
            }
        case http.MethodPost:
            h.createTodo(w, r)
        case http.MethodPut:
            h.updateTodo(w, r, id)
        case http.MethodDelete:
            h.deleteTodo(w, id)
        default:
            w.WriteHeader(http.StatusMethodNotAllowed)
        }
    }

    func (h *TodoHandler) listTodos(w http.ResponseWriter) {
        json.NewEncoder(w).Encode(h.store.List())
    }

    func (h *TodoHandler) getTodo(w http.ResponseWriter, id int) {
        todo, ok := h.store.Get(id)
        if !ok {
            http.Error(w, "Todo not found", http.StatusNotFound)
            return
        }
        json.NewEncoder(w).Encode(todo)
    }

    func (h *TodoHandler) createTodo(w http.ResponseWriter, r *http.Request) {
        var req struct {
            Title string \`json:"title"\`
        }

        if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
            http.Error(w, "Invalid JSON", http.StatusBadRequest)
            return
        }

        if req.Title == "" {
            http.Error(w, "Title required", http.StatusBadRequest)
            return
        }

        todo := h.store.Create(req.Title)
        w.WriteHeader(http.StatusCreated)
        json.NewEncoder(w).Encode(todo)
    }

    func (h *TodoHandler) updateTodo(w http.ResponseWriter, r *http.Request, id int) {
        var req struct {
            Completed bool \`json:"completed"\`
        }

        if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
            http.Error(w, "Invalid JSON", http.StatusBadRequest)
            return
        }

        if !h.store.Update(id, req.Completed) {
            http.Error(w, "Todo not found", http.StatusNotFound)
            return
        }

        w.WriteHeader(http.StatusNoContent)
    }

    func (h *TodoHandler) deleteTodo(w http.ResponseWriter, id int) {
        if !h.store.Delete(id) {
            http.Error(w, "Todo not found", http.StatusNotFound)
            return
        }
        w.WriteHeader(http.StatusNoContent)
    }

    func main() {
        store := NewTodoStore()
        handler := &TodoHandler{store: store}

        http.Handle("/todos", handler)
        http.Handle("/todos/", handler)

        log.Println("Server starting on :8080")
        log.Fatal(http.ListenAndServe(":8080", nil))
    }
    ```

    **Test with curl:**
    ```bash
    # Create todo
    curl -X POST http://localhost:8080/todos \
      -H "Content-Type: application/json" \
      -d '{"title":"Buy groceries"}'

    # List todos
    curl http://localhost:8080/todos

    # Get todo
    curl http://localhost:8080/todos/1

    # Update todo
    curl -X PUT http://localhost:8080/todos/1 \
      -H "Content-Type: application/json" \
      -d '{"completed":true}'

    # Delete todo
    curl -X DELETE http://localhost:8080/todos/1
    ```

    ### Best Practices

    **1. Always set Content-Type:**
    ```go
    w.Header().Set("Content-Type", "application/json")
    ```

    **2. Handle errors properly:**
    ```go
    if err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }
    ```

    **3. Use context for timeouts:**
    ```go
    ctx, cancel := context.WithTimeout(r.Context(), 5*time.Second)
    defer cancel()

    req, _ := http.NewRequestWithContext(ctx, "GET", url, nil)
    ```

    **4. Close response bodies:**
    ```go
    resp, err := http.Get(url)
    if err != nil {
        return err
    }
    defer resp.Body.Close()
    ```

    **5. Validate input:**
    ```go
    if req.Email == "" || !strings.Contains(req.Email, "@") {
        http.Error(w, "Invalid email", http.StatusBadRequest)
        return
    }
    ```

    ### Key Takeaways

    1. **http.HandleFunc()** - Register routes
    2. **http.ListenAndServe()** - Start server
    3. **ResponseWriter** - Write HTTP response
    4. **Request** - Read HTTP request
    5. **json.NewEncoder/Decoder** - JSON API
    6. **Middleware** - Wrap handlers for logging, auth, etc.
    7. **http.Client** - Make HTTP requests
    8. **Context** - Manage timeouts and cancellation
    9. **Status codes** - Use appropriate HTTP status codes
    10. **Struct tags** - Map JSON to Go structs

    **Go's net/http makes building REST APIs simple and efficient!**
  MARKDOWN
  lesson.key_concepts = ['HTTP', 'REST API', 'http.HandleFunc', 'ResponseWriter', 'Request', 'middleware', 'http.Client', 'routing', 'JSON API']
end

# ==========================================
# LINK LESSONS AND QUIZZES TO MODULES
# ==========================================

puts "Linking lessons and quizzes to modules..."

# Module 1: Go Basics
ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_2, sequence_order: 2)
ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_3, sequence_order: 3)
ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_4, sequence_order: 4)
ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_5, sequence_order: 5)
ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_6, sequence_order: 6)
ModuleItem.find_or_create_by!(course_module: module1, item: quiz1_1, sequence_order: 7)

# Module 2: Concurrency Fundamentals
ModuleItem.find_or_create_by!(course_module: module2, item: lesson2_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module2, item: quiz2_1, sequence_order: 2)

# Module 3: Goroutines
ModuleItem.find_or_create_by!(course_module: module3, item: lesson3_1, sequence_order: 1)

# Module 4: Channels
ModuleItem.find_or_create_by!(course_module: module4, item: lesson4_1, sequence_order: 1)

# Module 5: Interfaces
ModuleItem.find_or_create_by!(course_module: module5, item: lesson5_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module5, item: quiz5_1, sequence_order: 2)

# Module 6: Testing
ModuleItem.find_or_create_by!(course_module: module6, item: lesson6_1, sequence_order: 1)

# Module 7: Practical Go Development
ModuleItem.find_or_create_by!(course_module: module7, item: lesson7_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module7, item: lesson7_2, sequence_order: 2)
ModuleItem.find_or_create_by!(course_module: module7, item: lesson7_3, sequence_order: 3)

# ==========================================
# LINK LABS
# ==========================================

puts "Linking Go code labs to course modules..."

go_labs = HandsOnLab.where(lab_type: 'golang').order(:sequence_order)

if go_labs.count >= 4
  ModuleItem.find_or_create_by!(course_module: module1, item: go_labs[0], sequence_order: 8)
  ModuleItem.find_or_create_by!(course_module: module1, item: go_labs[1], sequence_order: 9)
  ModuleItem.find_or_create_by!(course_module: module3, item: go_labs[2], sequence_order: 3)
  ModuleItem.find_or_create_by!(course_module: module4, item: go_labs[3], sequence_order: 3)
  puts "Linked #{go_labs.count} code labs to course modules"
end

puts "\n✅ Enhanced Go course created successfully!"
puts "   - Course: #{go_course.title}"
puts "   - Modules: #{go_course.course_modules.count}"
puts "   - Lessons: #{CourseLesson.joins(course_modules: :course).where(courses: { id: go_course.id }).count}"
puts "   - Quizzes: #{Quiz.joins(course_modules: :course).where(courses: { id: go_course.id }).count}"
puts "   - Quiz Questions: #{QuizQuestion.joins(quiz: { course_modules: :course }).where(courses: { id: go_course.id }).count}"
puts "   - Labs: #{go_labs.count}"
puts "\n📚 Content Coverage:"
puts "   ✅ Go Basics (syntax, types, functions, control flow)"
puts "   ✅ Structs (custom types, embedding, composition) - NEW!"
puts "   ✅ Methods (pointer vs value receivers, method sets) - NEW!"
puts "   ✅ Pointers and Values (memory, pass-by-value/reference) - NEW!"
puts "   ✅ Error Handling (error interface, wrapping, patterns) - NEW!"
puts "   ✅ Advanced Functions (closures, defer, panic/recover) - NEW!"
puts "   ✅ Concurrency Fundamentals (CSP, goroutines vs threads)"
puts "   ✅ Goroutines (concurrent execution)"
puts "   ✅ Channels (safe communication)"
puts "   ✅ Interfaces (polymorphism and abstraction)"
puts "   ✅ Testing (unit tests, benchmarks, mocking)"
puts "   ✅ Context Package (cancellation, timeouts, lifecycles) - NEW!"
puts "   ✅ JSON Encoding/Decoding (marshal, unmarshal, tags) - NEW!"
puts "   ✅ HTTP & REST APIs (servers, clients, middleware) - NEW!"
puts "\n🎯 Learning Features:"
puts "   ✅ 40+ quiz questions with explanations"
puts "   ✅ Interactive code labs"
puts "   ✅ Real-world concurrency examples"
puts "   ✅ Testing best practices"
puts "   ✅ Production-ready patterns (context, HTTP, JSON)"
puts "\n🚀 Complete for production Go development!"
