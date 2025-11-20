# Concurrency Programming Course - Based on StackExchange Demand
puts "Creating Concurrency Programming Course..."

# Create Concurrency Course
concurrency_course = Course.find_or_create_by!(slug: 'concurrency-programming') do |course|
  course.title = 'Concurrency Programming Fundamentals'
  course.description = 'Master concurrent programming with threads, locks, semaphores, and race condition prevention across multiple languages'
  course.difficulty_level = 'intermediate'
  course.certification_track = nil
  course.published = true
  course.sequence_order = 10
  course.estimated_hours = 30
  course.learning_objectives = JSON.generate([
    "Understand concurrency vs parallelism fundamentals",
    "Master mutexes, semaphores, and locks",
    "Identify and prevent race conditions and deadlocks",
    "Implement thread-safe data structures",
    "Use atomic operations and memory barriers",
    "Apply concurrency patterns across languages"
  ])
  course.prerequisites = JSON.generate([
    "Basic programming knowledge in any language",
    "Understanding of operating system concepts"
  ])
end

puts "Created course: #{concurrency_course.title}"

# ==========================================
# MODULE 1: Concurrency Fundamentals
# ==========================================

module1 = CourseModule.find_or_create_by!(slug: 'concurrency-fundamentals', course: concurrency_course) do |mod|
  mod.title = 'Concurrency Fundamentals'
  mod.description = 'Understand the core concepts of concurrent programming'
  mod.sequence_order = 1
  mod.estimated_minutes = 90
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Distinguish concurrency from parallelism",
    "Understand processes vs threads",
    "Learn about thread lifecycle and scheduling"
  ])
end

lesson1_1 = CourseLesson.find_or_create_by!(title: "Concurrency vs Parallelism") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
    # Concurrency vs Parallelism

    Understanding the difference between concurrency and parallelism is fundamental to writing efficient multi-threaded programs.

    ## Definitions

    **Concurrency**: Multiple tasks making progress by interleaving their execution. Tasks don't necessarily run simultaneously.

    **Parallelism**: Multiple tasks executing simultaneously on multiple CPU cores.

    ### Key Analogy
    - **Concurrency**: One chef multitasking between multiple dishes (switching context)
    - **Parallelism**: Multiple chefs each cooking a different dish simultaneously

    ## Why Concurrency?

    1. **Responsiveness**: Keep UI responsive while background work happens
    2. **Resource Utilization**: Don't waste time waiting for I/O
    3. **Modularity**: Separate concerns into independent tasks
    4. **Scalability**: Handle more requests with same resources

    ## Processes vs Threads

    ### Process
    - Independent execution unit
    - Own memory space
    - Heavy context switching
    - Isolated (safer but slower communication)

    ### Thread
    - Lightweight execution unit within a process
    - Shared memory space
    - Fast context switching
    - Shared state (faster but needs synchronization)

    ```python
    # Python example: Process vs Thread
    import multiprocessing
    import threading

    # Process - separate memory
    def worker_process(n):
        print(f"Process {n} running")

    # Thread - shared memory
    def worker_thread(n):
        print(f"Thread {n} running")

    # Creating processes
    p = multiprocessing.Process(target=worker_process, args=(1,))

    # Creating threads
    t = threading.Thread(target=worker_thread, args=(1,))
    ```

    ## Thread States

    1. **New**: Thread created but not started
    2. **Runnable**: Ready to run, waiting for CPU
    3. **Running**: Executing on CPU
    4. **Blocked**: Waiting for lock/resource
    5. **Terminated**: Finished execution

    ## Common Concurrency Challenges

    1. **Race Conditions**: Multiple threads accessing shared data
    2. **Deadlocks**: Threads waiting for each other indefinitely
    3. **Starvation**: Thread never gets CPU time
    4. **Livelocks**: Threads actively responding but not progressing

    **Next**: We'll explore how to handle these challenges with synchronization primitives.
  MARKDOWN
  lesson.key_concepts = ['concurrency', 'parallelism', 'processes', 'threads', 'context switching']
end

# Link lesson to module
ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_1) do |item|
  item.sequence_order = 1
  item.required = true
end

quiz1 = Quiz.find_or_create_by!(title: "Concurrency Fundamentals Quiz") do |quiz|
  quiz.description = 'Test your understanding of concurrency basics'
  quiz.time_limit_minutes = 15
  quiz.passing_score = 70
  quiz.max_attempts = 3
end

[
  {
    question_text: "What is the main difference between concurrency and parallelism?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "Concurrency is about structure, parallelism is about execution", correct: true },
      { text: "They are the same thing", correct: false },
      { text: "Concurrency requires multiple CPUs, parallelism doesn't", correct: false },
      { text: "Parallelism is always faster than concurrency", correct: false }
    ]),
    explanation: "Concurrency is about dealing with multiple tasks at once (structure), while parallelism is about doing multiple tasks at once (execution).",
    difficulty_level: "medium"
  },
  {
    question_text: "Which is lighter weight: a process or a thread?",
    question_type: "mcq",
    points: 5,
    options: JSON.generate([
      { text: "Thread", correct: true },
      { text: "Process", correct: false },
      { text: "They have the same weight", correct: false },
      { text: "Depends on the operating system", correct: false }
    ]),
    explanation: "Threads are lighter weight because they share memory space with other threads in the same process, while processes have separate memory spaces.",
    difficulty_level: "easy"
  },
  {
    question_text: "What happens when a thread is in a 'Blocked' state?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "It's waiting for a lock or resource", correct: true },
      { text: "It's being executed on the CPU", correct: false },
      { text: "It has finished execution", correct: false },
      { text: "It has just been created", correct: false }
    ]),
    explanation: "A blocked thread is waiting for a resource (like a lock, I/O, or another thread) before it can continue execution.",
    difficulty_level: "easy"
  },
  {
    question_text: "True or False: Concurrency always improves performance.",
    question_type: "true_false",
    points: 5,
    correct_answer: "false",
    explanation: "Concurrency doesn't always improve performance. Context switching overhead, synchronization costs, and poor design can make concurrent programs slower than sequential ones.",
    difficulty_level: "medium"
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer] if q_data[:correct_answer]
    question.explanation = q_data[:explanation]
    question.difficulty_level = q_data[:difficulty_level]
  end
end

ModuleItem.find_or_create_by!(course_module: module1, item: quiz1) do |item|
  item.sequence_order = 2
  item.required = true
end

puts "  ✅ Created module: #{module1.title}"

# ==========================================
# MODULE 2: Mutexes and Locks
# ==========================================

module2 = CourseModule.find_or_create_by!(slug: 'mutexes-locks', course: concurrency_course) do |mod|
  mod.title = 'Mutexes and Locks'
  mod.description = 'Master mutual exclusion and critical sections'
  mod.sequence_order = 2
  mod.estimated_minutes = 120
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Understand mutual exclusion principles",
    "Use mutexes to protect shared data",
    "Differentiate between locks types",
    "Implement lock-free algorithms"
  ])
end

lesson2_1 = CourseLesson.find_or_create_by!(title: "Introduction to Mutexes") do |lesson|
  lesson.reading_time_minutes = 30
  lesson.content = <<~MARKDOWN
    # Introduction to Mutexes

    A **mutex** (mutual exclusion) is a synchronization primitive that prevents multiple threads from simultaneously accessing shared resources.

    ## The Problem: Race Conditions

    Without synchronization, multiple threads accessing shared data can cause unpredictable results:

    ```python
    # Python example: Race condition
    counter = 0

    def increment():
        global counter
        for _ in range(1000000):
            counter += 1  # NOT ATOMIC!

    # Two threads incrementing counter
    t1 = threading.Thread(target=increment)
    t2 = threading.Thread(target=increment)
    t1.start(); t2.start()
    t1.join(); t2.join()

    print(counter)  # Expected: 2000000, Actual: ???
    ```

    **Why?** The operation `counter += 1` consists of three steps:
    1. Read current value
    2. Add 1
    3. Write back

    Threads can interleave these steps, causing lost updates.

    ## The Solution: Mutex

    ```python
    import threading

    counter = 0
    lock = threading.Lock()

    def increment():
        global counter
        for _ in range(1000000):
            with lock:  # Acquire lock
                counter += 1  # Critical section
            # Lock released automatically

    # Now counter will be exactly 2000000
    ```

    ## Mutex Operations

    ### Lock/Acquire
    - Requests exclusive access
    - Blocks if another thread holds the lock
    - Proceeds when lock becomes available

    ### Unlock/Release
    - Releases exclusive access
    - Allows waiting threads to acquire

    ## Critical Section

    Code between lock and unlock is the **critical section** - only one thread can execute it at a time.

    **Best Practice**: Keep critical sections as short as possible!

    ## Language-Specific Implementations

    ### Python
    ```python
    lock = threading.Lock()
    with lock:
        # critical section
        shared_data += 1
    ```

    ### Java
    ```java
    synchronized(object) {
        // critical section
        sharedData++;
    }
    ```

    ### C++
    ```cpp
    std::mutex mtx;
    std::lock_guard<std::mutex> lock(mtx);
    sharedData++;
    ```

    ### Go
    ```go
    var mu sync.Mutex
    mu.Lock()
    sharedData++
    mu.Unlock()
    ```

    ### Rust
    ```rust
    let mutex = Mutex::new(0);
    let mut data = mutex.lock().unwrap();
    *data += 1;
    ```

    ## Types of Locks

    ### 1. Reentrant Lock (Recursive Mutex)
    - Same thread can acquire multiple times
    - Must release same number of times

    ```python
    lock = threading.RLock()  # Reentrant lock

    def outer():
        with lock:
            inner()  # OK - same thread

    def inner():
        with lock:  # Reacquire by same thread
            pass
    ```

    ### 2. Read-Write Lock
    - Multiple readers OR one writer
    - Improves performance for read-heavy workloads

    ```python
    from threading import RLock

    class ReadWriteLock:
        def __init__(self):
            self.readers = 0
            self.lock = RLock()

        def acquire_read(self):
            with self.lock:
                self.readers += 1

        def acquire_write(self):
            self.lock.acquire()
    ```

    ### 3. Spin Lock
    - Busy-waits instead of blocking
    - Good for very short critical sections
    - Wastes CPU but avoids context switch

    ## Common Pitfalls

    ### 1. Forgetting to Unlock
    ```python
    # BAD
    lock.acquire()
    do_something()  # If this raises exception, lock never released!
    lock.release()

    # GOOD
    with lock:  # Automatically releases even on exception
        do_something()
    ```

    ### 2. Lock Ordering (can cause deadlock)
    ```python
    # Thread 1
    with lock_a:
        with lock_b:
            pass

    # Thread 2 (WRONG ORDER)
    with lock_b:  # Deadlock possible!
        with lock_a:
            pass
    ```

    ### 3. Holding Locks Too Long
    ```python
    # BAD - long operation in critical section
    with lock:
        result = expensive_calculation()  # Others wait!
        shared_data = result

    # GOOD - minimize critical section
    result = expensive_calculation()  # Outside lock
    with lock:
        shared_data = result  # Quick!
    ```

    ## Performance Considerations

    1. **Lock Contention**: Many threads competing for same lock = slower
    2. **Granularity**: Fine-grained locks = more concurrency but more overhead
    3. **Lock-Free Alternatives**: Atomic operations can be faster

    **Next**: We'll explore deadlocks and how to prevent them.
  MARKDOWN
  lesson.key_concepts = ['mutex', 'lock', 'critical section', 'race condition', 'reentrant lock', 'read-write lock']
end

ModuleItem.find_or_create_by!(course_module: module2, item: lesson2_1) do |item|
  item.sequence_order = 1
  item.required = true
end

quiz2 = Quiz.find_or_create_by!(title: "Mutexes and Locks Quiz") do |quiz|
  quiz.description = 'Test your knowledge of mutexes and synchronization'
  quiz.time_limit_minutes = 20
  quiz.passing_score = 70
  quiz.max_attempts = 3
end

[
  {
    question_text: "Why is the operation 'counter++' not atomic?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "It consists of read, modify, and write operations", correct: true },
      { text: "It's too slow", correct: false },
      { text: "It uses too much memory", correct: false },
      { text: "It only works with single threads", correct: false }
    ]),
    explanation: "counter++ is not atomic because it involves three separate operations: reading the current value, incrementing it, and writing it back. These operations can be interleaved between threads.",
    difficulty_level: "medium"
  },
  {
    question_text: "What is the purpose of a critical section?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "Code that only one thread can execute at a time", correct: true },
      { text: "Code that must run very fast", correct: false },
      { text: "Code that handles errors", correct: false },
      { text: "Code that runs on multiple CPUs", correct: false }
    ]),
    explanation: "A critical section is a region of code that accesses shared resources and must be executed by only one thread at a time to prevent race conditions.",
    difficulty_level: "easy"
  },
  {
    question_text: "What type of lock allows multiple readers but only one writer?",
    question_type: "fill_blank",
    points: 10,
    correct_answer: "read-write lock|reader-writer lock|RWLock",
    explanation: "A read-write lock (also called reader-writer lock) allows multiple threads to read simultaneously, but only one thread to write exclusively.",
    difficulty_level: "medium"
  },
  {
    question_text: "True or False: A reentrant lock allows the same thread to acquire it multiple times.",
    question_type: "true_false",
    points: 5,
    correct_answer: "true",
    explanation: "A reentrant (recursive) lock allows the same thread to acquire it multiple times, as long as it releases it the same number of times.",
    difficulty_level: "easy"
  },
  {
    question_text: "What is the main disadvantage of a spin lock?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "It wastes CPU cycles busy-waiting", correct: true },
      { text: "It's too slow", correct: false },
      { text: "It doesn't prevent race conditions", correct: false },
      { text: "It can't be used with multiple threads", correct: false }
    ]),
    explanation: "Spin locks busy-wait, continuously checking if the lock is available, which wastes CPU cycles. They're only efficient for very short critical sections.",
    difficulty_level: "medium"
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz2, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer] if q_data[:correct_answer]
    question.explanation = q_data[:explanation]
    question.difficulty_level = q_data[:difficulty_level]
  end
end

ModuleItem.find_or_create_by!(course_module: module2, item: quiz2) do |item|
  item.sequence_order = 2
  item.required = true
end

puts "  ✅ Created module: #{module2.title}"

# ==========================================
# MODULE 3: Semaphores
# ==========================================

module3 = CourseModule.find_or_create_by!(slug: 'semaphores', course: concurrency_course) do |mod|
  mod.title = 'Semaphores'
  mod.description = 'Control access with counting and binary semaphores'
  mod.sequence_order = 3
  mod.estimated_minutes = 100
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Understand semaphore concepts",
    "Differentiate binary and counting semaphores",
    "Solve producer-consumer problems",
    "Implement resource pools"
  ])
end

lesson3_1 = CourseLesson.find_or_create_by!(title: "Understanding Semaphores") do |lesson|
  lesson.reading_time_minutes = 25
  lesson.content = <<~MARKDOWN
    # Understanding Semaphores

    A **semaphore** is a synchronization primitive that controls access to a shared resource through a counter.

    ## What is a Semaphore?

    Think of a semaphore as a bouncer at a club with a counter:
    - Counter tracks available "permits"
    - Threads can acquire permits (decreasing counter)
    - Threads release permits when done (increasing counter)
    - If no permits available, thread waits

    ## Types of Semaphores

    ### 1. Binary Semaphore (0 or 1)
    - Similar to a mutex
    - Only one permit available
    - Values: 0 (locked) or 1 (unlocked)

    ### 2. Counting Semaphore (0 to N)
    - Multiple permits available
    - Limits concurrent access to N threads
    - Good for resource pools

    ## Semaphore Operations

    ### Wait/Acquire/P (Proberen - Dutch for "try")
    ```python
    semaphore.acquire()  # Decrement counter, block if 0
    ```

    ### Signal/Release/V (Verhogen - Dutch for "increment")
    ```python
    semaphore.release()  # Increment counter, wake waiting thread
    ```

    ## Python Examples

    ### Binary Semaphore (Mutex-like)
    ```python
    from threading import Semaphore

    semaphore = Semaphore(1)  # Only 1 permit

    def critical_section():
        semaphore.acquire()
        try:
            # Only one thread here at a time
            shared_data += 1
        finally:
            semaphore.release()
    ```

    ### Counting Semaphore (Connection Pool)
    ```python
    # Limit to 5 concurrent database connections
    db_pool = Semaphore(5)

    def database_query():
        db_pool.acquire()  # Get connection
        try:
            result = db.execute("SELECT ...")
            return result
        finally:
            db_pool.release()  # Return connection

    # 6th thread will wait until one of first 5 finishes
    ```

    ### Producer-Consumer Pattern
    ```python
    from threading import Semaphore, Thread
    from queue import Queue

    # Semaphores for synchronization
    empty_slots = Semaphore(10)  # Buffer has 10 slots
    filled_slots = Semaphore(0)   # Initially no items
    buffer = Queue(maxsize=10)

    def producer():
        for i in range(100):
            item = f"item-{i}"
            empty_slots.acquire()  # Wait for empty slot
            buffer.put(item)
            filled_slots.release()  # Signal item available

    def consumer():
        for _ in range(100):
            filled_slots.acquire()  # Wait for item
            item = buffer.get()
            empty_slots.release()  # Signal slot empty
            process(item)
    ```

    ## Semaphore vs Mutex

    | Feature | Mutex | Semaphore |
    |---------|-------|-----------|
    | Counter | Binary (0/1) | Can be N |
    | Ownership | Thread that locks must unlock | Any thread can signal |
    | Use Case | Protect critical section | Resource counting, signaling |
    | Can track owner | Yes | No |

    ## Classic Problems

    ### 1. Bounded Buffer (Producer-Consumer)
    - Producers add items to buffer
    - Consumers remove items from buffer
    - Buffer has limited capacity
    - Use two semaphores: empty and full

    ### 2. Readers-Writers
    - Multiple readers can read simultaneously
    - Writers need exclusive access
    - Prevent reader/writer or writer/writer conflicts

    ### 3. Dining Philosophers
    - N philosophers alternate thinking and eating
    - Need two forks to eat
    - Prevent deadlock (all grab left fork)

    ## Implementation in Different Languages

    ### Java
    ```java
    Semaphore semaphore = new Semaphore(3);

    semaphore.acquire();
    try {
        // Critical section
    } finally {
        semaphore.release();
    }
    ```

    ### C++ (C++20)
    ```cpp
    #include <semaphore>

    std::counting_semaphore<10> semaphore(3);

    semaphore.acquire();
    // Critical section
    semaphore.release();
    ```

    ### Go (using buffered channel as semaphore)
    ```go
    semaphore := make(chan struct{}, 3)

    // Acquire
    semaphore <- struct{}{}

    // Critical section

    // Release
    <-semaphore
    ```

    ## Common Patterns

    ### Throttling Concurrent Operations
    ```python
    # Limit to 10 concurrent API requests
    api_semaphore = Semaphore(10)

    async def make_request(url):
        async with api_semaphore:
            response = await http_client.get(url)
            return response
    ```

    ### Signaling Between Threads
    ```python
    # Thread A signals Thread B to continue
    signal = Semaphore(0)

    def thread_a():
        prepare_data()
        signal.release()  # Signal ready

    def thread_b():
        signal.acquire()  # Wait for signal
        process_data()
    ```

    ## Pitfalls to Avoid

    1. **Forgetting to Release**: Always use try-finally or context managers
    2. **Releasing Too Many Times**: Can allow more threads than intended
    3. **Deadlock**: Careful with multiple semaphores
    4. **Priority Inversion**: Low-priority thread holds semaphore needed by high-priority thread

    **Next**: We'll explore deadlocks in depth and learn prevention strategies.
  MARKDOWN
  lesson.key_concepts = ['semaphore', 'binary semaphore', 'counting semaphore', 'producer-consumer', 'resource pool']
end

ModuleItem.find_or_create_by!(course_module: module3, item: lesson3_1) do |item|
  item.sequence_order = 1
  item.required = true
end

quiz3 = Quiz.find_or_create_by!(title: "Semaphores Quiz") do |quiz|
  quiz.description = 'Test your understanding of semaphores'
  quiz.time_limit_minutes = 20
  quiz.passing_score = 70
  quiz.max_attempts = 3
end

[
  {
    question_text: "What is the main difference between a mutex and a semaphore?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "Semaphores can have multiple permits, mutexes are binary", correct: true },
      { text: "Mutexes are faster than semaphores", correct: false },
      { text: "Semaphores can only be used in Java", correct: false },
      { text: "There is no difference", correct: false }
    ]),
    explanation: "While mutexes are binary (locked or unlocked), semaphores can have multiple permits allowing N threads to access a resource concurrently.",
    difficulty_level: "medium"
  },
  {
    question_text: "In a counting semaphore initialized with value 5, how many threads can acquire it before others must wait?",
    question_type: "fill_blank",
    points: 10,
    correct_answer: "5|five",
    explanation: "A counting semaphore with initial value 5 has 5 permits, so 5 threads can acquire it before the 6th thread must wait.",
    difficulty_level: "easy"
  },
  {
    question_text: "What happens when you call acquire() on a semaphore with no available permits?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "The thread blocks and waits until a permit is available", correct: true },
      { text: "An exception is thrown immediately", correct: false },
      { text: "The semaphore value becomes negative", correct: false },
      { text: "The program crashes", correct: false }
    ]),
    explanation: "When acquire() is called on a semaphore with no permits, the calling thread blocks and waits until another thread calls release().",
    difficulty_level: "easy"
  },
  {
    question_text: "True or False: Unlike mutexes, any thread can release a semaphore, not just the one that acquired it.",
    question_type: "true_false",
    points: 5,
    correct_answer: "true",
    explanation: "Semaphores don't track ownership. Any thread can call release(), which is useful for signaling patterns but requires careful programming.",
    difficulty_level: "medium"
  },
  {
    question_text: "Which semaphore pattern is best for limiting concurrent database connections?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "Counting semaphore", correct: true },
      { text: "Binary semaphore", correct: false },
      { text: "Mutex", correct: false },
      { text: "Spin lock", correct: false }
    ]),
    explanation: "A counting semaphore is perfect for connection pools because it can limit access to N concurrent connections.",
    difficulty_level: "medium"
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz3, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer] if q_data[:correct_answer]
    question.explanation = q_data[:explanation]
    question.difficulty_level = q_data[:difficulty_level]
  end
end

ModuleItem.find_or_create_by!(course_module: module3, item: quiz3) do |item|
  item.sequence_order = 2
  item.required = true
end

puts "  ✅ Created module: #{module3.title}"

# ==========================================
# MODULE 4: Race Conditions and Deadlocks
# ==========================================

module4 = CourseModule.find_or_create_by!(slug: 'race-conditions-deadlocks', course: concurrency_course) do |mod|
  mod.title = 'Race Conditions and Deadlocks'
  mod.description = 'Identify, prevent, and debug concurrency problems'
  mod.sequence_order = 4
  mod.estimated_minutes = 120
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Detect race conditions in code",
    "Understand deadlock conditions",
    "Apply deadlock prevention strategies",
    "Use tools to debug concurrency issues"
  ])
end

lesson4_1 = CourseLesson.find_or_create_by!(title: "Race Conditions Explained") do |lesson|
  lesson.reading_time_minutes = 30
  lesson.content = <<~MARKDOWN
    # Race Conditions Explained

    A **race condition** occurs when the behavior of code depends on the relative timing or interleaving of multiple threads.

    ## What is a Race Condition?

    When multiple threads access shared data and at least one modifies it, without proper synchronization, you have a race condition.

    ### Classic Example: Bank Account

    ```python
    class BankAccount:
        def __init__(self):
            self.balance = 1000

        def withdraw(self, amount):
            # RACE CONDITION!
            if self.balance >= amount:  # Check
                time.sleep(0.001)  # Simulate processing
                self.balance -= amount  # Modify
                return True
            return False

    account = BankAccount()

    # Two threads try to withdraw $600 each
    def thread1():
        account.withdraw(600)

    def thread2():
        account.withdraw(600)

    # Possible outcome: balance = -200 (overdraft!)
    ```

    **What happened?**
    1. Thread 1 checks balance (1000 >= 600) ✓
    2. Thread 2 checks balance (1000 >= 600) ✓
    3. Thread 1 withdraws: balance = 400
    4. Thread 2 withdraws: balance = -200 ❌

    ## Types of Race Conditions

    ### 1. Check-Then-Act
    ```python
    # BAD: Race between check and act
    if x == None:
        x = create_expensive_object()
    ```

    ### 2. Read-Modify-Write
    ```python
    # BAD: Non-atomic increment
    counter += 1  # Read, add, write (3 operations!)
    ```

    ### 3. Lost Update
    ```python
    # BAD: Second write overwrites first
    # Thread 1
    x = x + 1

    # Thread 2
    x = x + 2  # Might read old value of x
    ```

    ## Fixing Race Conditions

    ### Solution 1: Mutual Exclusion (Mutex)
    ```python
    class BankAccount:
        def __init__(self):
            self.balance = 1000
            self.lock = threading.Lock()

        def withdraw(self, amount):
            with self.lock:  # Only one thread at a time
                if self.balance >= amount:
                    self.balance -= amount
                    return True
                return False
    ```

    ### Solution 2: Atomic Operations
    ```python
    import threading

    # Use atomic operations when possible
    counter = 0
    lock = threading.Lock()

    # Instead of this:
    def increment_unsafe():
        global counter
        counter += 1

    # Use atomic with lock:
    def increment_safe():
        global counter
        with lock:
            counter += 1
    ```

    ### Solution 3: Thread-Local Storage
    ```python
    import threading

    # Each thread has its own copy
    local_data = threading.local()

    def process():
        local_data.counter = 0  # Thread-safe
        local_data.counter += 1  # No race condition
    ```

    ## Detecting Race Conditions

    ### 1. Code Review
    Look for:
    - Shared mutable state
    - Missing synchronization
    - Check-then-act patterns
    - Multiple operations on shared data

    ### 2. Testing
    ```python
    # Stress test with many threads
    def stress_test():
        threads = []
        for i in range(100):
            t = threading.Thread(target=increment)
            threads.append(t)
            t.start()

        for t in threads:
            t.join()

        assert counter == 100, f"Race condition! Counter = {counter}"
    ```

    ### 3. Tools
    - **Python**: threading sanitizer, `sys.settrace()`
    - **Java**: ThreadSanitizer, FindBugs
    - **C++**: ThreadSanitizer (TSan), Helgrind (Valgrind)
    - **Go**: race detector (`go run -race`)

    ## Deadlocks

    A **deadlock** occurs when threads wait for each other indefinitely, preventing progress.

    ### Deadlock Conditions (All 4 must be present)

    1. **Mutual Exclusion**: Resources can't be shared
    2. **Hold and Wait**: Thread holds resources while waiting for more
    3. **No Preemption**: Resources can't be forcibly taken
    4. **Circular Wait**: Circular chain of threads waiting for each other

    ### Classic Deadlock Example

    ```python
    lock_a = threading.Lock()
    lock_b = threading.Lock()

    def thread1():
        with lock_a:
            time.sleep(0.001)
            with lock_b:  # Waiting for lock_b
                print("Thread 1")

    def thread2():
        with lock_b:
            time.sleep(0.001)
            with lock_a:  # Waiting for lock_a
                print("Thread 2")

    # Deadlock! Thread 1 has A, wants B
    #           Thread 2 has B, wants A
    ```

    ## Deadlock Prevention Strategies

    ### 1. Lock Ordering
    Always acquire locks in the same order:
    ```python
    # GOOD: Both threads acquire in same order
    def thread1():
        with lock_a:
            with lock_b:
                pass

    def thread2():
        with lock_a:  # Same order as thread1
            with lock_b:
                pass
    ```

    ### 2. Timeout and Retry
    ```python
    def acquire_with_timeout():
        while True:
            if lock_a.acquire(timeout=1.0):
                try:
                    if lock_b.acquire(timeout=1.0):
                        try:
                            # Critical section
                            pass
                        finally:
                            lock_b.release()
                        break  # Success
                    else:
                        # Timeout, retry
                        continue
                finally:
                    lock_a.release()
    ```

    ### 3. Try-Lock
    ```python
    def try_acquire():
        while True:
            lock_a.acquire()
            if lock_b.acquire(blocking=False):  # Try without blocking
                try:
                    # Got both locks
                    pass
                finally:
                    lock_b.release()
                    lock_a.release()
                break
            else:
                lock_a.release()  # Release and retry
                time.sleep(0.001)  # Back off
    ```

    ### 4. Single Lock
    Use one lock for all related resources:
    ```python
    # Instead of lock_a and lock_b, use one lock
    master_lock = threading.Lock()

    def thread1():
        with master_lock:
            # Access both resources
            pass
    ```

    ### 5. Lock-Free Data Structures
    Use atomic operations instead of locks:
    ```python
    from queue import Queue  # Thread-safe, lock-free

    queue = Queue()
    queue.put(item)  # Thread-safe
    item = queue.get()  # Thread-safe
    ```

    ## Livelock

    Threads are actively responding but not progressing:

    ```python
    # Livelock example: Two threads continuously defer to each other
    def polite_thread1():
        while True:
            if not thread2_active:
                do_work()
                break
            time.sleep(0.001)  # Wait for thread2

    def polite_thread2():
        while True:
            if not thread1_active:
                do_work()
                break
            time.sleep(0.001)  # Wait for thread1

    # Both keep deferring, no progress!
    ```

    ## Starvation

    A thread never gets resources due to scheduling or priority:

    ```python
    # Low-priority thread never gets lock
    # because high-priority threads keep acquiring it
    ```

    ## Best Practices

    1. **Minimize Shared State**: Less sharing = fewer race conditions
    2. **Use High-Level Constructs**: Queues, semaphores, etc.
    3. **Lock Ordering**: Establish and follow lock hierarchies
    4. **Keep Critical Sections Short**: Reduce lock contention
    5. **Test Thoroughly**: Use stress tests and race detectors
    6. **Document Locking Policy**: Make lock orders explicit

    **Next**: We'll explore atomic operations and memory ordering.
  MARKDOWN
  lesson.key_concepts = ['race condition', 'deadlock', 'livelock', 'starvation', 'lock ordering', 'atomic operations']
end

ModuleItem.find_or_create_by!(course_module: module4, item: lesson4_1) do |item|
  item.sequence_order = 1
  item.required = true
end

quiz4 = Quiz.find_or_create_by!(title: "Race Conditions and Deadlocks Quiz") do |quiz|
  quiz.description = 'Test your knowledge of concurrency problems'
  quiz.time_limit_minutes = 25
  quiz.passing_score = 70
  quiz.max_attempts = 3
end

[
  {
    question_text: "What is a race condition?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "When program behavior depends on the timing of thread execution", correct: true },
      { text: "When two threads try to run as fast as possible", correct: false },
      { text: "When a program has a performance problem", correct: false },
      { text: "When threads compete for CPU time", correct: false }
    ]),
    explanation: "A race condition occurs when the correctness of a program depends on the relative timing or interleaving of multiple threads accessing shared data.",
    difficulty_level: "easy"
  },
  {
    question_text: "How many conditions must be present for a deadlock to occur?",
    question_type: "fill_blank",
    points: 10,
    correct_answer: "4|four",
    explanation: "All four conditions must be present simultaneously for deadlock: mutual exclusion, hold and wait, no preemption, and circular wait.",
    difficulty_level: "medium"
  },
  {
    question_text: "What is the recommended strategy to prevent deadlocks when using multiple locks?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "Always acquire locks in the same order", correct: true },
      { text: "Acquire locks randomly", correct: false },
      { text: "Never use more than one lock", correct: false },
      { text: "Use as many locks as possible", correct: false }
    ]),
    explanation: "Lock ordering is a key deadlock prevention strategy. If all threads acquire locks in the same order, circular wait is impossible.",
    difficulty_level: "medium"
  },
  {
    question_text: "True or False: A livelock is when threads are actively running but not making progress.",
    question_type: "true_false",
    points: 5,
    correct_answer: "true",
    explanation: "In a livelock, threads are not blocked (like in deadlock) but keep changing state in response to each other without making progress.",
    difficulty_level: "easy"
  },
  {
    question_text: "Which type of race condition occurs with 'counter++'?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "Read-Modify-Write", correct: true },
      { text: "Check-Then-Act", correct: false },
      { text: "Write-Write conflict", correct: false },
      { text: "Dead code", correct: false }
    ]),
    explanation: "counter++ is a read-modify-write race condition because it involves three non-atomic operations: reading the value, incrementing it, and writing it back.",
    difficulty_level: "medium"
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz4, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer] if q_data[:correct_answer]
    question.explanation = q_data[:explanation]
    question.difficulty_level = q_data[:difficulty_level]
  end
end

ModuleItem.find_or_create_by!(course_module: module4, item: quiz4) do |item|
  item.sequence_order = 2
  item.required = true
end

puts "  ✅ Created module: #{module4.title}"

# ==========================================
# MODULE 5: Atomic Operations & Memory Models
# ==========================================

module5 = CourseModule.find_or_create_by!(slug: 'atomic-operations-memory', course: concurrency_course) do |mod|
  mod.title = 'Atomic Operations & Memory Models'
  mod.description = 'Low-level concurrency with atomic operations and memory ordering'
  mod.sequence_order = 5
  mod.estimated_minutes = 110
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Understand atomic operations",
    "Learn memory ordering and barriers",
    "Use compare-and-swap (CAS)",
    "Implement lock-free data structures"
  ])
end

lesson5_1 = CourseLesson.find_or_create_by!(title: "Atomic Operations") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # Atomic Operations

    **Atomic operations** execute as a single, indivisible unit - they either complete fully or not at all, with no visible intermediate states.

    ## Why Atomic Operations?

    Locks have overhead:
    - Context switching
    - Thread blocking
    - Cache coherency traffic

    Atomic operations provide synchronization without locks!

    ## Common Atomic Operations

    ### 1. Load and Store
    ```python
    # Python (using ctypes)
    import ctypes

    value = ctypes.c_int(0)
    # Atomic load
    current = value.value
    # Atomic store
    value.value = 42
    ```

    ### 2. Fetch-and-Add
    ```cpp
    // C++
    #include <atomic>

    std::atomic<int> counter{0};

    // Atomically adds 1 and returns old value
    int old = counter.fetch_add(1);

    // Atomically adds 1 and returns new value
    int new_val = ++counter;
    ```

    ### 3. Compare-and-Swap (CAS)
    Most powerful atomic operation!

    ```cpp
    // C++: CAS
    std::atomic<int> value{10};

    int expected = 10;
    int desired = 20;

    // If value == expected, set value = desired
    // Returns true if successful
    bool success = value.compare_exchange_strong(expected, desired);

    if (success) {
        // value is now 20
    } else {
        // value wasn't 10, expected now contains actual value
    }
    ```

    ### 4. Test-and-Set
    ```cpp
    // Used for spin locks
    std::atomic_flag flag = ATOMIC_FLAG_INIT;

    // Atomically set to true, return old value
    while (flag.test_and_set()) {
        // Spin until we get the flag
    }

    // Critical section

    flag.clear();  // Release
    ```

    ## Lock-Free Counter Example

    ### Without Atomics (WRONG)
    ```python
    # NOT thread-safe!
    counter = 0

    def increment():
        global counter
        counter += 1  # Race condition!
    ```

    ### With Lock (SAFE but SLOW)
    ```python
    counter = 0
    lock = threading.Lock()

    def increment():
        global counter
        with lock:  # Overhead!
            counter += 1
    ```

    ### With Atomics (SAFE and FAST)
    ```cpp
    // C++
    std::atomic<int> counter{0};

    void increment() {
        counter.fetch_add(1);  // Lock-free, thread-safe!
    }
    ```

    ```java
    // Java
    import java.util.concurrent.atomic.AtomicInteger;

    AtomicInteger counter = new AtomicInteger(0);

    void increment() {
        counter.incrementAndGet();  // Lock-free!
    }
    ```

    ```go
    // Go
    import "sync/atomic"

    var counter int64

    func increment() {
        atomic.AddInt64(&counter, 1)  // Lock-free!
    }
    ```

    ## Memory Ordering

    Modern CPUs reorder instructions for performance. This can break concurrent code!

    ### The Problem
    ```cpp
    // Thread 1
    data = 42;
    ready = true;

    // Thread 2
    if (ready) {
        print(data);  // Might print 0!
    }
    ```

    **Why?** CPU might reorder to:
    ```cpp
    // Reordered by CPU!
    ready = true;  // Moved up
    data = 42;     // Moved down
    ```

    ### Memory Ordering Guarantees

    1. **Relaxed**: No ordering guarantees (fastest)
    2. **Acquire**: Loads after this can't move before it
    3. **Release**: Stores before this can't move after it
    4. **AcqRel**: Both acquire and release
    5. **SeqCst**: Sequential consistency (slowest, safest)

    ```cpp
    // C++ with memory ordering
    std::atomic<int> data{0};
    std::atomic<bool> ready{false};

    // Thread 1
    data.store(42, std::memory_order_relaxed);
    ready.store(true, std::memory_order_release);  // Barrier

    // Thread 2
    if (ready.load(std::memory_order_acquire)) {  // Barrier
        int value = data.load(std::memory_order_relaxed);
        // Guaranteed to see data = 42
    }
    ```

    ## Lock-Free Stack Example

    ```cpp
    template<typename T>
    class LockFreeStack {
    private:
        struct Node {
            T data;
            Node* next;
        };
        std::atomic<Node*> head{nullptr};

    public:
        void push(T value) {
            Node* new_node = new Node{value, nullptr};

            // CAS loop
            new_node->next = head.load();
            while (!head.compare_exchange_weak(new_node->next, new_node)) {
                // If CAS fails, new_node->next updated with current head
                // Try again
            }
        }

        bool pop(T& result) {
            Node* old_head = head.load();

            // CAS loop
            while (old_head != nullptr) {
                Node* new_head = old_head->next;
                if (head.compare_exchange_weak(old_head, new_head)) {
                    result = old_head->data;
                    delete old_head;
                    return true;
                }
                // If CAS fails, old_head updated, try again
            }

            return false;  // Stack was empty
        }
    };
    ```

    ## ABA Problem

    A subtle bug in lock-free algorithms:

    ```
    1. Thread 1 reads A from head
    2. Thread 2 changes A to B
    3. Thread 3 changes B back to A
    4. Thread 1's CAS succeeds (sees A) but structure might be corrupted!
    ```

    **Solution**: Use tagged pointers or generation counters:
    ```cpp
    struct TaggedPointer {
        Node* ptr;
        unsigned int tag;
    };
    ```

    ## When to Use Atomics

    ✅ **Use atomics when:**
    - Simple counters or flags
    - Performance critical
    - Lock-free algorithms

    ❌ **Use locks when:**
    - Complex critical sections
    - Multiple operations need to be atomic together
    - Easier to reason about correctness

    ## Platform-Specific Atomics

    ### Python (Limited support)
    ```python
    # Python's GIL provides some atomicity
    # But explicit locks recommended
    ```

    ### Java
    ```java
    import java.util.concurrent.atomic.*;

    AtomicInteger counter = new AtomicInteger();
    AtomicBoolean flag = new AtomicBoolean();
    AtomicReference<String> ref = new AtomicReference<>();
    ```

    ### C++
    ```cpp
    #include <atomic>

    std::atomic<int> x;
    std::atomic<bool> flag;
    std::atomic<MyClass*> ptr;
    ```

    ### Rust
    ```rust
    use std::sync::atomic::{AtomicI32, Ordering};

    let counter = AtomicI32::new(0);
    counter.fetch_add(1, Ordering::SeqCst);
    ```

    ## Performance Considerations

    - **Atomics are faster than locks** for simple operations
    - **But slower than non-atomic** operations
    - **Memory ordering matters**: Relaxed < Acquire/Release < SeqCst
    - **Contention still affects** performance

    **Best practice**: Measure before optimizing!

    **Next**: We'll explore concurrency patterns and best practices.
  MARKDOWN
  lesson.key_concepts = ['atomic operations', 'compare-and-swap', 'memory ordering', 'lock-free', 'ABA problem']
end

ModuleItem.find_or_create_by!(course_module: module5, item: lesson5_1) do |item|
  item.sequence_order = 1
  item.required = true
end

quiz5 = Quiz.find_or_create_by!(title: "Atomic Operations Quiz") do |quiz|
  quiz.description = 'Test your understanding of atomic operations'
  quiz.time_limit_minutes = 20
  quiz.passing_score = 70
  quiz.max_attempts = 3
end

[
  {
    question_text: "What makes an operation 'atomic'?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "It executes as a single indivisible unit with no intermediate states", correct: true },
      { text: "It's very fast", correct: false },
      { text: "It uses locks", correct: false },
      { text: "It only works on single cores", correct: false }
    ]),
    explanation: "An atomic operation is indivisible - it either completes fully or not at all, with no observable intermediate states.",
    difficulty_level: "easy"
  },
  {
    question_text: "What does CAS stand for in concurrent programming?",
    question_type: "fill_blank",
    points: 10,
    correct_answer: "compare-and-swap|compare and swap",
    explanation: "CAS (Compare-And-Swap) is a fundamental atomic operation that compares a value with an expected value and swaps it with a new value if they match.",
    difficulty_level: "easy"
  },
  {
    question_text: "Why do CPUs reorder instructions?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "For performance optimization", correct: true },
      { text: "To make programming harder", correct: false },
      { text: "To save memory", correct: false },
      { text: "They don't reorder instructions", correct: false }
    ]),
    explanation: "CPUs reorder instructions to maximize performance through techniques like out-of-order execution and pipelining, but this can affect concurrent programs.",
    difficulty_level: "medium"
  },
  {
    question_text: "True or False: Atomic operations are always faster than using locks.",
    question_type: "true_false",
    points: 5,
    correct_answer: "false",
    explanation: "While atomics are often faster for simple operations, they can be slower than locks in high-contention scenarios, and aren't suitable for complex critical sections.",
    difficulty_level: "medium"
  },
  {
    question_text: "What is the ABA problem in lock-free algorithms?",
    question_type: "mcq",
    points: 15,
    options: JSON.generate([
      { text: "When a value changes from A to B and back to A, fooling a CAS operation", correct: true },
      { text: "When three threads compete for the same resource", correct: false },
      { text: "When two values are equal", correct: false },
      { text: "When atomics are misaligned in memory", correct: false }
    ]),
    explanation: "The ABA problem occurs when a value changes from A to B and back to A between a read and CAS, causing the CAS to succeed even though the data structure may have changed.",
    difficulty_level: "hard"
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz5, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer] if q_data[:correct_answer]
    question.explanation = q_data[:explanation]
    question.difficulty_level = q_data[:difficulty_level]
  end
end

ModuleItem.find_or_create_by!(course_module: module5, item: quiz5) do |item|
  item.sequence_order = 2
  item.required = true
end

puts "  ✅ Created module: #{module5.title}"

# ==========================================
# SUMMARY
# ==========================================

puts "\n✅ Concurrency Programming Course Created!"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
puts "📚 Course: #{concurrency_course.title}"
puts "📖 Modules: #{concurrency_course.course_modules.count}"
puts "❓ Quizzes: #{Quiz.where(id: concurrency_course.course_modules.flat_map { |m| m.module_items.where(item_type: 'Quiz').pluck(:item_id) }).count}"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
