# AUTO-GENERATED from rust_programming_course.rb
puts "Creating Microlessons for Rust Ownership Basics..."

module_var = CourseModule.find_by(slug: 'rust-ownership-basics')

# === MICROLESSON 1: Lesson 1 ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 1',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Ownership and Borrowing in Rust

    **Ownership** is Rust's most unique feature, enabling memory safety without garbage collection.

    ## The Three Rules of Ownership

    1. Each value has an **owner**
    2. There can only be **one owner** at a time
    3. When the owner goes out of scope, the value is **dropped**

    ## Memory Safety Without GC

    ```rust
    fn main() {
        let s1 = String::from("hello");
        let s2 = s1;  // s1 MOVED to s2

        // println!("{}", s1);  // ERROR: s1 no longer valid
        println!("{}", s2);  // OK
    }
    ```

    **What happened?**
    - `s1` owned the String
    - Ownership transferred (moved) to `s2`
    - `s1` is no longer valid
    - No double-free possible!

    ## Stack vs Heap

    ### Stack (Copy types)
    ```rust
    let x = 5;
    let y = x;  // COPY (not move)
    println!("{}, {}", x, y);  // Both valid
    ```

    Types that implement `Copy`:
    - Integers, floats, booleans
    - Characters
    - Tuples (if all elements are Copy)
    - Arrays (if elements are Copy)

    ### Heap (Move types)
    ```rust
    let s1 = String::from("hello");
    let s2 = s1;  // MOVE (not copy)
    // s1 no longer valid
    ```

    ## Borrowing

    **References let you refer to a value without taking ownership**

    ### Immutable References

    ```rust
    fn main() {
        let s1 = String::from("hello");

        let len = calculate_length(&s1);  // Borrow s1

        println!("Length of '{}' is {}", s1, len);  // s1 still valid!
    }

    fn calculate_length(s: &String) -> usize {
        s.len()  // Can read but not modify
    }
    ```

    **The `&` symbol creates a reference (borrow)**

    ### Mutable References

    ```rust
    fn main() {
        let mut s = String::from("hello");

        change(&mut s);  // Mutable borrow

        println!("{}", s);  // "hello, world"
    }

    fn change(s: &mut String) {
        s.push_str(", world");  // Can modify
    }
    ```

    ## Borrowing Rules

    **At any given time, you can have EITHER:**
    1. One mutable reference, OR
    2. Any number of immutable references

    **This prevents data races at compile time!**

    ### Valid Borrows

    ```rust
    let mut s = String::from("hello");

    // Multiple immutable borrows OK
    let r1 = &s;
    let r2 = &s;
    println!("{} and {}", r1, r2);  // OK

    // Mutable borrow after immutable borrows end
    let r3 = &mut s;  // OK - r1, r2 no longer used
    ```

    ### Invalid Borrows

    ```rust
    let mut s = String::from("hello");

    let r1 = &s;        // Immutable borrow
    let r2 = &mut s;    // ERROR: can't have mutable with immutable

    println!("{}, {}", r1, r2);
    ```

    ```rust
    let mut s = String::from("hello");

    let r1 = &mut s;  // First mutable borrow
    let r2 = &mut s;  // ERROR: only one mutable borrow allowed

    println!("{}, {}", r1, r2);
    ```

    ## Dangling References

    **Rust prevents dangling pointers at compile time:**

    ```rust
    fn dangle() -> &String {  // ERROR: missing lifetime
        let s = String::from("hello");
        &s  // s goes out of scope, reference would dangle!
    }  // s dropped here

    // Fix: Return owned value
    fn no_dangle() -> String {
        let s = String::from("hello");
        s  // Ownership moves to caller
    }
    ```

    ## Lifetimes

    **Annotations that tell Rust how long references are valid**

    ### Lifetime Syntax

    ```rust
    fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
        if x.len() > y.len() {
            x
        } else {
            y
        }
    }
    ```

    **The `'a` annotation says:** "All references must live at least as long as `'a`"

    ### Why Lifetimes?

    ```rust
    fn main() {
        let string1 = String::from("long string");
        let result;

        {
            let string2 = String::from("xyz");
            result = longest(string1.as_str(), string2.as_str());
        }  // string2 dropped here

        // println!("{}", result);  // ERROR: result might reference string2
    }
    ```

    ### Lifetime Elision

    **Common patterns where lifetimes are inferred:**

    ```rust
    // Explicit lifetime
    fn first_word<'a>(s: &'a str) -> &'a str {
        &s[..1]
    }

    // Elided (compiler infers)
    fn first_word(s: &str) -> &str {
        &s[..1]
    }
    ```

    ## Ownership Patterns

    ### Clone (Deep Copy)

    ```rust
    let s1 = String::from("hello");
    let s2 = s1.clone();  // Explicit deep copy

    println!("{}, {}", s1, s2);  // Both valid
    ```

    ### Move Semantics with Functions

    ```rust
    fn takes_ownership(s: String) {
        println!("{}", s);
    }  // s dropped here

    fn main() {
        let s = String::from("hello");
        takes_ownership(s);
        // println!("{}", s);  // ERROR: s moved
    }
    ```

    ### Return Ownership

    ```rust
    fn gives_ownership() -> String {
        String::from("hello")  // Ownership moves to caller
    }

    fn main() {
        let s = gives_ownership();  // s receives ownership
        println!("{}", s);
    }
    ```

    ## Slices

    **References to a contiguous sequence**

    ### String Slices

    ```rust
    let s = String::from("hello world");

    let hello = &s[0..5];   // "hello"
    let world = &s[6..11];  // "world"

    // Shorthand
    let hello = &s[..5];    // Start from 0
    let world = &s[6..];    // To end
    let all = &s[..];       // Entire string
    ```

    ### Array Slices

    ```rust
    let a = [1, 2, 3, 4, 5];

    let slice = &a[1..3];  // [2, 3]
    ```

    ## Smart Pointers

    ### Box<T> - Heap Allocation

    ```rust
    let b = Box::new(5);  // Allocate on heap
    println!("b = {}", b);
    ```

    ### Rc<T> - Reference Counting

    ```rust
    use std::rc::Rc;

    let a = Rc::new(5);
    let b = Rc::clone(&a);  // Increment reference count
    let c = Rc::clone(&a);

    println!("count = {}", Rc::strong_count(&a));  // 3
    ```

    ### RefCell<T> - Interior Mutability

    ```rust
    use std::cell::RefCell;

    let data = RefCell::new(5);
    *data.borrow_mut() += 1;  // Runtime borrowing check
    println!("{}", data.borrow());  // 6
    ```

    ## Common Patterns

    ### Builder Pattern with Ownership

    ```rust
    struct Config {
        host: String,
        port: u16,
    }

    impl Config {
        fn new() -> Self {
            Self {
                host: String::from("localhost"),
                port: 8080,
            }
        }

        fn host(mut self, host: String) -> Self {
            self.host = host;
            self  // Return ownership
        }

        fn port(mut self, port: u16) -> Self {
            self.port = port;
            self
        }
    }

    // Usage
    let config = Config::new()
        .host(String::from("example.com"))
        .port(3000);
    ```

    **Next**: We'll explore Rust's powerful type system and pattern matching!
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 2: Lesson 2 ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 2',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Ownership and Borrowing in Rust

    **Ownership** is Rust's most unique feature, enabling memory safety without garbage collection.

    ## The Three Rules of Ownership

    1. Each value has an **owner**
    2. There can only be **one owner** at a time
    3. When the owner goes out of scope, the value is **dropped**

    ## Memory Safety Without GC

    ```rust
    fn main() {
        let s1 = String::from("hello");
        let s2 = s1;  // s1 MOVED to s2

        // println!("{}", s1);  // ERROR: s1 no longer valid
        println!("{}", s2);  // OK
    }
    ```

    **What happened?**
    - `s1` owned the String
    - Ownership transferred (moved) to `s2`
    - `s1` is no longer valid
    - No double-free possible!

    ## Stack vs Heap

    ### Stack (Copy types)
    ```rust
    let x = 5;
    let y = x;  // COPY (not move)
    println!("{}, {}", x, y);  // Both valid
    ```

    Types that implement `Copy`:
    - Integers, floats, booleans
    - Characters
    - Tuples (if all elements are Copy)
    - Arrays (if elements are Copy)

    ### Heap (Move types)
    ```rust
    let s1 = String::from("hello");
    let s2 = s1;  // MOVE (not copy)
    // s1 no longer valid
    ```

    ## Borrowing

    **References let you refer to a value without taking ownership**

    ### Immutable References

    ```rust
    fn main() {
        let s1 = String::from("hello");

        let len = calculate_length(&s1);  // Borrow s1

        println!("Length of '{}' is {}", s1, len);  // s1 still valid!
    }

    fn calculate_length(s: &String) -> usize {
        s.len()  // Can read but not modify
    }
    ```

    **The `&` symbol creates a reference (borrow)**

    ### Mutable References

    ```rust
    fn main() {
        let mut s = String::from("hello");

        change(&mut s);  // Mutable borrow

        println!("{}", s);  // "hello, world"
    }

    fn change(s: &mut String) {
        s.push_str(", world");  // Can modify
    }
    ```

    ## Borrowing Rules

    **At any given time, you can have EITHER:**
    1. One mutable reference, OR
    2. Any number of immutable references

    **This prevents data races at compile time!**

    ### Valid Borrows

    ```rust
    let mut s = String::from("hello");

    // Multiple immutable borrows OK
    let r1 = &s;
    let r2 = &s;
    println!("{} and {}", r1, r2);  // OK

    // Mutable borrow after immutable borrows end
    let r3 = &mut s;  // OK - r1, r2 no longer used
    ```

    ### Invalid Borrows

    ```rust
    let mut s = String::from("hello");

    let r1 = &s;        // Immutable borrow
    let r2 = &mut s;    // ERROR: can't have mutable with immutable

    println!("{}, {}", r1, r2);
    ```

    ```rust
    let mut s = String::from("hello");

    let r1 = &mut s;  // First mutable borrow
    let r2 = &mut s;  // ERROR: only one mutable borrow allowed

    println!("{}, {}", r1, r2);
    ```

    ## Dangling References

    **Rust prevents dangling pointers at compile time:**

    ```rust
    fn dangle() -> &String {  // ERROR: missing lifetime
        let s = String::from("hello");
        &s  // s goes out of scope, reference would dangle!
    }  // s dropped here

    // Fix: Return owned value
    fn no_dangle() -> String {
        let s = String::from("hello");
        s  // Ownership moves to caller
    }
    ```

    ## Lifetimes

    **Annotations that tell Rust how long references are valid**

    ### Lifetime Syntax

    ```rust
    fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
        if x.len() > y.len() {
            x
        } else {
            y
        }
    }
    ```

    **The `'a` annotation says:** "All references must live at least as long as `'a`"

    ### Why Lifetimes?

    ```rust
    fn main() {
        let string1 = String::from("long string");
        let result;

        {
            let string2 = String::from("xyz");
            result = longest(string1.as_str(), string2.as_str());
        }  // string2 dropped here

        // println!("{}", result);  // ERROR: result might reference string2
    }
    ```

    ### Lifetime Elision

    **Common patterns where lifetimes are inferred:**

    ```rust
    // Explicit lifetime
    fn first_word<'a>(s: &'a str) -> &'a str {
        &s[..1]
    }

    // Elided (compiler infers)
    fn first_word(s: &str) -> &str {
        &s[..1]
    }
    ```

    ## Ownership Patterns

    ### Clone (Deep Copy)

    ```rust
    let s1 = String::from("hello");
    let s2 = s1.clone();  // Explicit deep copy

    println!("{}, {}", s1, s2);  // Both valid
    ```

    ### Move Semantics with Functions

    ```rust
    fn takes_ownership(s: String) {
        println!("{}", s);
    }  // s dropped here

    fn main() {
        let s = String::from("hello");
        takes_ownership(s);
        // println!("{}", s);  // ERROR: s moved
    }
    ```

    ### Return Ownership

    ```rust
    fn gives_ownership() -> String {
        String::from("hello")  // Ownership moves to caller
    }

    fn main() {
        let s = gives_ownership();  // s receives ownership
        println!("{}", s);
    }
    ```

    ## Slices

    **References to a contiguous sequence**

    ### String Slices

    ```rust
    let s = String::from("hello world");

    let hello = &s[0..5];   // "hello"
    let world = &s[6..11];  // "world"

    // Shorthand
    let hello = &s[..5];    // Start from 0
    let world = &s[6..];    // To end
    let all = &s[..];       // Entire string
    ```

    ### Array Slices

    ```rust
    let a = [1, 2, 3, 4, 5];

    let slice = &a[1..3];  // [2, 3]
    ```

    ## Smart Pointers

    ### Box<T> - Heap Allocation

    ```rust
    let b = Box::new(5);  // Allocate on heap
    println!("b = {}", b);
    ```

    ### Rc<T> - Reference Counting

    ```rust
    use std::rc::Rc;

    let a = Rc::new(5);
    let b = Rc::clone(&a);  // Increment reference count
    let c = Rc::clone(&a);

    println!("count = {}", Rc::strong_count(&a));  // 3
    ```

    ### RefCell<T> - Interior Mutability

    ```rust
    use std::cell::RefCell;

    let data = RefCell::new(5);
    *data.borrow_mut() += 1;  // Runtime borrowing check
    println!("{}", data.borrow());  // 6
    ```

    ## Common Patterns

    ### Builder Pattern with Ownership

    ```rust
    struct Config {
        host: String,
        port: u16,
    }

    impl Config {
        fn new() -> Self {
            Self {
                host: String::from("localhost"),
                port: 8080,
            }
        }

        fn host(mut self, host: String) -> Self {
            self.host = host;
            self  // Return ownership
        }

        fn port(mut self, port: u16) -> Self {
            self.port = port;
            self
        }
    }

    // Usage
    let config = Config::new()
        .host(String::from("example.com"))
        .port(3000);
    ```

    **Next**: We'll explore Rust's powerful type system and pattern matching!
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 2 microlessons for Rust Ownership Basics"
