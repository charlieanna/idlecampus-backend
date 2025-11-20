# AUTO-GENERATED from golang_concurrency_units.rb
puts "Creating Microlessons for Concurrency..."

module_var = CourseModule.find_by(slug: 'concurrency')

# === MICROLESSON 1: Fan-out/Fan-in Pipeline ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Fan-out/Fan-in Pipeline',
  content: <<~MARKDOWN,
# Fan-out/Fan-in Pipeline 🚀

Build a simple fetch→parse→store pipeline using a bounded worker pool. Practice channel handoff and fan-in aggregation.

## Why it matters
- Bounded concurrency prevents resource exhaustion and keeps latency predictable.
- Clear ownership of closing channels avoids deadlocks and panics.

## Mental model
Producer → [N workers] → Aggregator (fan-in). The aggregator owns the output channel and closes it once all workers finish.

## Invariants
- Output channel closes once (after all workers return)
- No sends after close, no goroutine leaks on early exit
- Backpressure exists at the input queue

## Common failure modes
- Double closing the output channel (panic)
- Workers blocked forever on send (aggregator not reading)
- Goroutine leaks (no ctx cancellation)

## Quick snippet
```go
var wg sync.WaitGroup
out := make(chan T)
for i := 0; i < n; i++ {
  wg.Add(1)
  go func() {
    defer wg.Done()
    for v := range in {
      select {
      case <-ctx.Done():
        return
      case out <- process(v):
      }
    }
  }()
}
go func() { wg.Wait(); close(out) }()
```

## Validate
Run the pipeline tests in examples/go-concurrency-capstone.

```bash
go test ./examples/go-concurrency-capstone/internal/pipeline -run TestPipeline_ProcessesURLs -race
```

## Key Points
- Use a single input channel to feed workers
- Aggregate completion via WaitGroup and close the fan-in channel when done
- Keep stages small and testable (Fetcher, Parser, Store interfaces)
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 1.1: Terminal
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {
    command: 'go test ./examples/go-concurrency-capstone/internal/pipeline -run TestPipeline_ProcessesURLs -race',
    description: 'Run pipeline test with race detector to validate fan-in correctness.',
    difficulty: 'easy',
    require_pass: true,
    cwd: '.',
    timeout_sec: 60,
    validation: {
      must_include: ['PASS'],
      must_not_include: ['DATA RACE', 'panic:']
    },
    hints: [
      'Aggregator closes output exactly once after workers finish.',
      'Workers must respect ctx.Done() to avoid leaks.',
      'Keep stages small and testable (Fetcher, Parser, Store interfaces).'
    ]
  }
)

# Exercise 1.2: MCQ
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    question: 'Who is responsible for closing the fan-in output channel?',
    options: [
      'The aggregator goroutine after all workers finish',
      'Each worker after it sends its last result',
      'The producer when it closes the input',
      'Nobody; channels close themselves'
    ],
    correct_answer: 0,
    explanation: 'Only the owner (aggregator) should close out; workers must never close a shared channel.',
    difficulty: 'easy',
    require_pass: true
  }
)

# Exercise 1.3: Code
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'code',
  sequence_order: 3,
  exercise_data: {
    require_pass: true,
    files: ['examples/go-concurrency-capstone/internal/pipeline/merge.go'],
    starter_code: <<~GO,
      package pipeline
      import (
        "context"
        "sync"
      )
      // fanIn merges multiple input channels into a single output and closes it when done.
      func fanIn[T any](ctx context.Context, inputs ...<-chan T) <-chan T {
        out := make(chan T)
        // TODO: implement with WaitGroup; respect ctx cancellation; close(out) exactly once.
        _ = inputs
        go func() { close(out) }()
        return out
      }
    GO
    tests: {
      run: 'go test ./examples/go-concurrency-capstone/internal/pipeline -run TestFanIn -race -count=1',
      visible: ['TestFanIn_Basic'],
      hidden: ['TestFanIn_Cancel', 'TestFanIn_NoLeak']
    },
    require_pass: true,
    hints: [
      'Spawn one goroutine per input; forward until input closes or ctx cancels.',
      'Use a WaitGroup and close(out) after wg.Wait().',
      'Select on ctx.Done() to avoid leaks when downstream cancels.'
    ]
  }
)

# Exercise 1.4: Sandbox
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'sandbox',
  sequence_order: 4,
  exercise_data: {
    timeout_sec: 60,
    setup: 'echo Running with 1 CPU to stress backpressure',
    constraints: { cpus: 1, mem_mb: 256 },
    run: 'GOMAXPROCS=1 go test ./examples/go-concurrency-capstone/internal/pipeline -run TestPipeline_ProcessesURLs -race -count=1',
    validation: { must_include: ['PASS'], must_not_include: ['DATA RACE'] },
    require_pass: true,
    hints: [
      'Bounded worker count prevents runaway goroutines under CPU pressure.',
      'Watch for timeouts or leaks when CPU is constrained.'
    ]
  }
)

# === MICROLESSON 2: Refactor to Interfaces & Make It Idiomatic ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Refactor to Interfaces & Make It Idiomatic',
  content: <<~MARKDOWN,
# Refactor to Interfaces & Make It Idiomatic 🚀

Extract interfaces for components (Fetcher, Parser, Store) and inject dependencies for testability.

## Why it matters
- Enables mocking/fakes, faster tests, and clear boundaries.
- Reduces coupling and clarifies ownership of behavior.

## Idioms
- Define interfaces at the consumer; keep them small (1–2 methods).
- Prefer constructor injection; avoid global vars; no stutter in names.

## Example
```go
type Fetcher interface { Fetch(ctx context.Context, url string) ([]byte, error) }
type Parser  interface { Parse(ctx context.Context, b []byte) (Item, error) }
```

## Validate
```bash
go test ./examples/go-concurrency-capstone/... -race -count=1
```

## Key Points
- Keep interfaces small (one or two methods)
- Define interfaces at the consumer side
- Use table-driven tests and fakes to validate behavior
  MARKDOWN
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 2.1: Terminal
Exercise.create!(
  micro_lesson: lesson_2,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {
    command: 'go test ./examples/go-concurrency-capstone/... -race -count=1',
    description: 'Run full test suite with race detector after refactor.',
    difficulty: 'easy',
    require_pass: true,
    timeout_sec: 90,
    validation: { must_include: ['PASS'], must_not_include: ['DATA RACE'] },
    hints: ['Keep interfaces small (one or two methods)', 'Define interfaces at the consumer side', 'Use table-driven tests and fakes to validate behavior']
  }
)

# Exercise 2.2: MCQ
Exercise.create!(
  micro_lesson: lesson_2,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    question: 'Where should you define a small interface in Go?',
    options: [
      'At the consumer package that needs the behavior',
      'In a global shared interfaces package',
      'At the concrete implementation package',
      'In main only'
    ],
    correct_answer: 0,
    explanation: 'Consumers define the minimal behavior they require; implementations conform to it.',
    difficulty: 'easy',
    require_pass: true
  }
)

# Exercise 2.3: Code
Exercise.create!(
  micro_lesson: lesson_2,
  exercise_type: 'code',
  sequence_order: 3,
  exercise_data: {
    require_pass: true,
    files: ['examples/go-concurrency-capstone/internal/pipeline/fetcher.go'],
    starter_code: <<~GO,
      package pipeline
      import "context"
      // TODO: Define a small Fetcher interface and refactor callers to accept it.
      // Write a fake fetcher in _test.go and inject via constructor for tests.
      type httpFetcher struct{}
      func (h httpFetcher) Fetch(ctx context.Context, url string) ([]byte, error) { return nil, nil }
    GO
    tests: {
      run: 'go test ./examples/go-concurrency-capstone/internal/pipeline -run TestFetcher_Interface -race -count=1',
      visible: ['TestFetcher_Interface'],
      hidden: ['TestFetcher_Timeout', 'TestFetcher_ErrorPath']
    },
    require_pass: true,
    hints: ['Define minimal interface at consumer', 'Inject fake in tests', 'Keep names idiomatic (no stutter)']
  }
)

# === MICROLESSON 3: Worker Pool Basics: Goroutines + Channels ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Worker Pool Basics: Goroutines + Channels',
  content: <<~MARKDOWN,
# Worker Pool Basics: Goroutines + Channels 🚀

Build a bounded worker pool that reads from a channel, processes jobs, and signals completion.

## Mental model
Fixed number of workers compete for work; producer closes jobs when done; a coordinator waits for workers and then closes results.

## Invariants
- No worker closes a shared channel
- WaitGroup count matches spawned workers
- No goroutine leaks on early shutdown

## Validate
```bash
go test ./examples/go-concurrency-capstone/... -run TestFrontier_Deduplicates -race
```

## Key Points
- Prefer a fixed number of workers pulling from a jobs channel
- Use sync.WaitGroup to wait for worker completion
- Close the jobs channel to signal completion to workers
  MARKDOWN
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 3.1: Terminal
Exercise.create!(
  micro_lesson: lesson_3,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {
    command: 'go test ./examples/go-concurrency-capstone/... -run TestFrontier_Deduplicates -race',
    description: 'Run frontier deduplication test with race detector.',
    difficulty: 'easy',
    require_pass: true,
    timeout_sec: 60,
    validation: { must_include: ['PASS'], must_not_include: ['panic:', 'DATA RACE'] },
    hints: ['Prefer a fixed number of workers pulling from a jobs channel', 'Use sync.WaitGroup to wait for worker completion', 'Close the jobs channel to signal completion to workers']
  }
)

# Exercise 3.2: MCQ
Exercise.create!(
  micro_lesson: lesson_3,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    question: 'Which pattern bounds concurrency without spawning unbounded goroutines?',
    options: ['Fixed-size worker pool reading from a channel', 'Launching a goroutine per job with no limit', 'Busy-waiting with for { } loops', 'Using time.Sleep between spawns'],
    correct_answer: 0,
    explanation: 'A worker pool bounds concurrency via a fixed number of goroutines consuming from a channel.',
    difficulty: 'easy',
    require_pass: true
  }
)

# Exercise 3.3: Code
Exercise.create!(
  micro_lesson: lesson_3,
  exercise_type: 'code',
  sequence_order: 3,
  exercise_data: {
    require_pass: true,
    files: ['examples/go-concurrency-capstone/internal/pool/pool.go'],
    starter_code: <<~GO,
      package pool
      import "sync"
      // TODO: Implement a fixed-size worker pool processing jobs from a channel.
      // Ensure no double-close and no leaks.
      type Job func() error
      func Run(n int, jobs <-chan Job) <-chan error {
        // implement
        return nil
      }
    GO
    tests: {
      run: 'go test ./examples/go-concurrency-capstone/internal/pool -run TestPool_Basic -race -count=1',
      visible: ['TestPool_Basic'],
      hidden: ['TestPool_NoLeak', 'TestPool_CloseOrdering']
    },
    require_pass: true,
    hints: ['Spawn n workers; range over jobs; collect errors; close results after wg.Wait()']
  }
)

# Exercise 3.4: Sandbox
Exercise.create!(
  micro_lesson: lesson_3,
  exercise_type: 'sandbox',
  sequence_order: 4,
  exercise_data: {
    timeout_sec: 60,
    constraints: { cpus: 1 },
    run: 'GOMAXPROCS=1 go test ./examples/go-concurrency-capstone/internal/pool -run TestPool_Basic -race -count=1',
    validation: { must_include: ['PASS'] },
    require_pass: true,
    hints: ['Use backpressure via channel and fixed worker count']
  }
)

# === MICROLESSON 4: Contexts & Cancellation ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Contexts & Cancellation',
  content: <<~MARKDOWN,
# Contexts & Cancellation 🚀

Pass context.Context through fetch and pipeline stages to enable timeouts and cancellation.

## Rules
- Context is the first param; do not store it; pass it down.
- Check `ctx.Done()` in loops/selects; return early on cancellation.
- Prefer `errgroup.Group` when spawning sibling goroutines.

## Validate
```bash
go test ./examples/go-concurrency-capstone/internal/pipeline -race
```

## Key Points
- Accept context in public APIs and forward it downstream
- Select on ctx.Done() in long-running operations
- Return early on cancellation; propagate errors up
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 4.1: Terminal
Exercise.create!(
  micro_lesson: lesson_4,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {
    command: 'go test ./examples/go-concurrency-capstone/internal/pipeline -race',
    description: 'Run pipeline tests with race detector to verify graceful cancellation.',
    difficulty: 'medium',
    require_pass: true,
    timeout_sec: 60,
    validation: { must_include: ['PASS'], must_not_include: ['goroutine leak', 'DATA RACE'] },
    hints: ['Accept context in public APIs and forward it downstream', 'Select on ctx.Done() in long-running operations', 'Return early on cancellation; propagate errors up']
  }
)

# Exercise 4.2: MCQ
Exercise.create!(
  micro_lesson: lesson_4,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    question: 'What is the idiomatic way to propagate cancellation in Go?',
    options: ['Pass context.Context as the first parameter', 'Use a global boolean flag', 'Use panic and recover', 'Kill goroutines with runtime.Kill'],
    correct_answer: 0,
    explanation: 'Idiomatic Go passes context.Context as the first parameter and checks ctx.Done() to cancel work.',
    difficulty: 'medium',
    require_pass: true
  }
)

# Exercise 4.3: Code
Exercise.create!(
  micro_lesson: lesson_4,
  exercise_type: 'code',
  sequence_order: 3,
  exercise_data: {
    require_pass: true,
    files: ['examples/go-concurrency-capstone/internal/pipeline/worker.go'],
    starter_code: <<~GO,
      package pipeline
      import "context"
      // TODO: Respect ctx cancellation inside a long-running loop.
      func work(ctx context.Context, in <-chan Item, out chan<- Item) {
        for v := range in {
          // implement select on ctx.Done() and forward or return
          _ = v
        }
      }
    GO
    tests: {
      run: 'go test ./examples/go-concurrency-capstone/internal/pipeline -run TestWorker_Cancel -race -count=1',
      visible: ['TestWorker_Cancel'],
      hidden: ['TestWorker_NoLeak']
    },
    require_pass: true,
    hints: ['Check ctx.Done() in select', 'Return on cancel to avoid leaks']
  }
)

# === MICROLESSON 5: Race Hunt: Detect and Fix Data Races ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Race Hunt: Detect and Fix Data Races',
  content: <<~MARKDOWN,
# Race Hunt: Detect and Fix Data Races 🚀

Use the Go race detector to find data races in concurrent code. Reproduce the race using the UnsafeStore example, then refactor to a safe version (mutex or channel-based) and confirm a clean `-race` run.

## Strategy
- Identify shared state; choose ownership via channel or protection via mutex.
- Add tests that increase contention (more goroutines, loops) to make races reproducible.

## Validate
```bash
go test ./examples/go-concurrency-capstone/internal/racey -run TestRace_Reproduce -race -count=1
```

## Key Points
- Shared mutable state needs synchronization
- Prefer channels to share ownership, or guard with sync.Mutex
- Race detector failure will fail tests; keep running until it is clean
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 5.1: Terminal
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {
    command: 'go test ./examples/go-concurrency-capstone/internal/racey -run TestRace_Reproduce -race -count=1',
    description: 'Reproduce and then eliminate a data race using the race detector.',
    difficulty: 'medium',
    require_pass: true,
    timeout_sec: 60,
    validation: { must_include: ['PASS'], must_not_include: ['DATA RACE'] },
    hints: ['Shared mutable state needs synchronization', 'Prefer channels to share ownership, or guard with sync.Mutex', 'Race detector failure will fail tests; keep running until it is clean']
  }
)

# Exercise 5.2: MCQ
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    question: 'Which option eliminates a write-write data race?',
    options: ['Guard writes with a sync.Mutex', 'Add time.Sleep to stagger goroutines', 'Increase GOMAXPROCS', 'Ignore the race if tests pass'],
    correct_answer: 0,
    explanation: 'Add proper synchronization (Mutex) or redesign to avoid shared state via channels.',
    difficulty: 'medium',
    require_pass: true
  }
)

# Exercise 5.3: Code
Exercise.create!(
  micro_lesson: lesson_5,
  exercise_type: 'code',
  sequence_order: 3,
  exercise_data: {
    require_pass: true,
    files: ['examples/go-concurrency-capstone/internal/racey/store.go'],
    starter_code: <<~GO,
      package racey
      // TODO: Fix the data race by introducing a mutex or channel ownership.
      type Store struct{ m map[string]int }
      func (s *Store) Inc(k string) { s.m[k]++ }
      func (s *Store) Get(k string) int { return s.m[k] }
    GO
    tests: {
      run: 'go test ./examples/go-concurrency-capstone/internal/racey -run TestRace_Fixed -race -count=1',
      visible: ['TestRace_Fixed'],
      hidden: ['TestRace_Heavy']
    },
    require_pass: true,
    hints: ['Guard shared map with sync.Mutex', 'Or funnel all access through a single owner goroutine']
  }
)

# === MICROLESSON 6: Deadlock Hunt: Diagnose Lock-Order Inversion ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Deadlock Hunt: Diagnose Lock-Order Inversion',
  content: <<~MARKDOWN,
# Deadlock Hunt: Diagnose Lock-Order Inversion 🚀

Reproduce a deadlock caused by inconsistent lock ordering. Then fix by enforcing a global lock order or using a channel-based redesign.

## Mental model
Deadlock arises from a cycle in the wait‑for graph; consistent global lock order breaks cycles.

## Validate
```bash
go test ./examples/go-concurrency-capstone/internal/deadlock -run TestDeadlock_Reproduce -timeout 2s -count=1
```

## Key Points
- Always acquire multiple locks in a consistent global order
- Reduce lock scope; avoid holding locks while calling out
- Consider redesign: pipeline via channels over shared locks
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 6.1: Terminal
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'terminal',
  sequence_order: 1,
  exercise_data: {
    command: 'go test ./examples/go-concurrency-capstone/internal/deadlock -run TestDeadlock_Reproduce -timeout 2s -count=1',
    description: 'Reproduce deadlock; then fix and prove test completes under timeout.',
    difficulty: 'medium',
    require_pass: true,
    timeout_sec: 10,
    validation: { must_include: ['PASS'], must_not_include: ['fatal error: all goroutines are asleep'] },
    hints: ['Always acquire multiple locks in a consistent global order', 'Reduce lock scope; avoid holding locks while calling out', 'Consider redesign: pipeline via channels over shared locks']
  }
)

# Exercise 6.2: MCQ
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'mcq',
  sequence_order: 2,
  exercise_data: {
    question: 'What prevents lock-order inversion deadlocks?',
    options: ['Consistently acquiring locks in the same global order', 'Increasing timeouts', 'Using defer with all locks', 'Adding more goroutines'],
    correct_answer: 0,
    explanation: 'A strict global lock order prevents cycles in the wait-for graph, avoiding deadlocks.',
    difficulty: 'medium',
    require_pass: true
  }
)

# Exercise 6.3: Code
Exercise.create!(
  micro_lesson: lesson_6,
  exercise_type: 'code',
  sequence_order: 3,
  exercise_data: {
    require_pass: true,
    files: ['examples/go-concurrency-capstone/internal/deadlock/locks.go'],
    starter_code: <<~GO,
      package deadlock
      import "sync"
      var A, B sync.Mutex
      func Foo() {
        // TODO: enforce global lock order or eliminate shared locks via channel
        A.Lock(); defer A.Unlock()
        B.Lock(); defer B.Unlock()
      }
      func Bar() {
        B.Lock(); defer B.Unlock()
        A.Lock(); defer A.Unlock()
      }
    GO
    tests: {
      run: 'go test ./examples/go-concurrency-capstone/internal/deadlock -run TestDeadlock_Fixed -timeout 2s -count=1',
      visible: ['TestDeadlock_Fixed'],
      hidden: ['TestDeadlock_Stress']
    },
    require_pass: true,
    hints: ['Acquire in A->B order everywhere', 'Or replace locks with channel pipeline']
  }
)

puts "✓ Created 6 microlessons for Concurrency"

# === MICROLESSON 7: Rate Limiter: Channel Semaphore ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'Rate Limiter: Channel Semaphore',
  content: <<~MARKDOWN,
# Rate Limiter: Channel Semaphore 🚀

Use a buffered channel as a semaphore to limit concurrent requests. Acquire by sending a token; release by receiving.

## Mental model
`sem := make(chan struct{}, N)` provides N slots. Each worker `sem <- struct{}{}` before work; `defer func(){ <-sem }()` after.

## Validate
Write tests that spawn M goroutines; assert at most N run at once.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# Exercise 7.1: Code (semaphore limiter)
Exercise.create!(
  micro_lesson: lesson_7,
  exercise_type: 'code',
  sequence_order: 1,
  exercise_data: {
    files: ['examples/go-concurrency-capstone/internal/limit/limit.go','examples/go-concurrency-capstone/internal/limit/limit_test.go'],
    starter_code: <<~GO,
      package limit
      import (
        "sync"
      )
      // RunLimited runs f for each item in items with at most n concurrent executions.
      func RunLimited[T any](n int, items []T, f func(T)) {
        // TODO: implement using a buffered channel as a semaphore
        var wg sync.WaitGroup
        _ = wg
        _ = items
        _ = f
      }
    GO
    tests: {
      run: 'cd examples/go-concurrency-capstone && (go mod init example.com/cap >/dev/null 2>&1 || true) && go test ./internal/limit -run TestRunLimited -race -count=1',
      visible: ['TestRunLimited'],
      hidden: ['TestRunLimited_MaxConcurrency']
    },
    require_pass: true,
    hints: ['sem := make(chan struct{}, n)', 'Acquire: sem <- struct{}{}', 'Release: <-sem in defer', 'Use WaitGroup to join']
  }
)
