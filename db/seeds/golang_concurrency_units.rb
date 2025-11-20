# Go Concurrency Teaching Units & Lab A (Capstone MVP)

puts "\n🚀 Seeding Go Concurrency Units & Lab..."

# Ensure course exists
go_course = Course.find_or_create_by!(slug: 'golang-fundamentals') do |course|
  course.title = 'Go Programming Fundamentals'
  course.description = 'Master Go programming with focus on concurrency, testing, and production readiness'
  course.difficulty_level = 'intermediate'
  course.published = true
  course.sequence_order = 2
  course.estimated_hours = 35
end

# Module: Go Concurrency Fundamentals
concurrency_mod = CourseModule.find_or_create_by!(course: go_course, slug: 'go-concurrency-fundamentals') do |mod|
  mod.title = 'Go Concurrency Fundamentals'
  mod.description = 'Goroutines, channels, worker pools, fan-out/fan-in pipelines, and cancellation'
  mod.sequence_order = 5
  mod.estimated_minutes = 180
  mod.published = true
  mod.learning_objectives = [
    'Launch goroutines safely and understand scheduling basics',
    'Use channels to coordinate work and implement worker pools',
    'Build a fan-out/fan-in pipeline and reason about backpressure',
    'Use context for timeouts and cancellation'
  ]
end

# ILU 1: Worker Pool Basics
ilu1 = InteractiveLearningUnit.find_or_create_by!(slug: 'go-worker-pool-basics') do |u|
  u.title = 'Worker Pool Basics: Goroutines + Channels'
  u.concept_explanation = <<~MD
    Build a bounded worker pool that reads from a channel, processes jobs, and signals completion.
    Goals: avoid unbounded goroutines, use WaitGroup, and close channels correctly.
    Verify correctness with the provided tests in examples/go-concurrency-capstone.
  MD
  # Command points students to run tests with race detector
  u.command_to_learn = 'go test ./examples/go-concurrency-capstone/... -run TestFrontier_Deduplicates -race'
  u.practice_hints = [
    'Prefer a fixed number of workers pulling from a jobs channel',
    'Use sync.WaitGroup to wait for worker completion',
    'Close the jobs channel to signal completion to workers',
    'Avoid writing to a closed channel'
  ]
  u.quiz_question_text = 'Which pattern bounds concurrency without spawning unbounded goroutines?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Fixed-size worker pool reading from a channel', correct: true },
    { text: 'Launching a goroutine per job with no limit', correct: false },
    { text: 'Busy-waiting with for { } loops', correct: false },
    { text: 'Using time.Sleep between spawns', correct: false }
  ]
  u.quiz_correct_answer = 'Fixed-size worker pool reading from a channel'
  u.quiz_explanation = 'A worker pool bounds concurrency via a fixed number of goroutines consuming from a channel.'
  u.estimated_minutes = 8
  u.sequence_order = 1
  u.category = 'concurrency'
  u.difficulty_level = 'easy'
  u.published = true
end

# ILU 2: Fan-out/Fan-in Pipeline
ilu2 = InteractiveLearningUnit.find_or_create_by!(slug: 'go-pipeline-fanout') do |u|
  u.title = 'Fan-out/Fan-in Pipeline'
  u.concept_explanation = <<~MD
    Build a simple fetch→parse→store pipeline using a bounded worker pool. Practice channel handoff and fan-in aggregation.
    Validate with pipeline tests in examples/go-concurrency-capstone.
  MD
  u.command_to_learn = 'go test ./examples/go-concurrency-capstone/internal/pipeline -run TestPipeline_ProcessesURLs -race'
  u.practice_hints = [
    'Use a single input channel to feed workers',
    'Aggregate completion via WaitGroup and close the fan-in channel when done',
    'Keep stages small and testable (Fetcher, Parser, Store interfaces)'
  ]
  u.quiz_question_text = 'What does fan-in mean in a Go pipeline?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Multiple workers send results into a single channel', correct: true },
    { text: 'One goroutine spawns many others', correct: false },
    { text: 'Merging slices with append', correct: false },
    { text: 'Using sync.Map to share state', correct: false }
  ]
  u.quiz_correct_answer = 'Multiple workers send results into a single channel'
  u.quiz_explanation = 'Fan-in merges outputs from multiple goroutines into a single channel for downstream processing.'
  u.estimated_minutes = 10
  u.sequence_order = 2
  u.category = 'concurrency'
  u.difficulty_level = 'medium'
  u.published = true
end

# ILU 3: Contexts & Cancellation (starter guidance; implemented progressively)
ilu3 = InteractiveLearningUnit.find_or_create_by!(slug: 'go-context-cancellation') do |u|
  u.title = 'Contexts & Cancellation'
  u.concept_explanation = <<~MD
    Pass context.Context through fetch and pipeline stages to enable timeouts and cancellation.
    Use context.WithTimeout to cap runtime; ensure goroutines exit promptly when ctx.Done() fires.
  MD
  u.command_to_learn = 'go test ./examples/go-concurrency-capstone/internal/pipeline -race'
  u.practice_hints = [
    'Accept context in public APIs and forward it downstream',
    'Select on ctx.Done() in long-running operations',
    'Return early on cancellation; propagate errors up'
  ]
  u.quiz_question_text = 'What is the idiomatic way to propagate cancellation in Go?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Pass context.Context as the first parameter', correct: true },
    { text: 'Use a global boolean flag', correct: false },
    { text: 'Use panic and recover', correct: false },
    { text: 'Kill goroutines with runtime.Kill', correct: false }
  ]
  u.quiz_correct_answer = 'Pass context.Context as the first parameter'
  u.quiz_explanation = 'Idiomatic Go passes context.Context as the first parameter and checks ctx.Done() to cancel work.'
  u.estimated_minutes = 8
  u.sequence_order = 3
  u.category = 'concurrency'
  u.difficulty_level = 'medium'
  u.published = true
end

# Link ILUs to module
[[ilu1, 1], [ilu2, 2], [ilu3, 3]].each do |ilu, order|
  ModuleInteractiveUnit.find_or_create_by!(course_module: concurrency_mod, interactive_learning_unit: ilu) do |miu|
    miu.sequence_order = order
    miu.required = true
  end
end

# ILU 4: Race Hunt
ilu4 = InteractiveLearningUnit.find_or_create_by!(slug: 'go-race-hunt') do |u|
  u.title = 'Race Hunt: Detect and Fix Data Races'
  u.concept_explanation = <<~MD
    Use the Go race detector to find data races in concurrent code. Reproduce the race using the UnsafeStore example,
    then refactor to a safe version (mutex or channel-based) and confirm a clean -race run.
  MD
  u.command_to_learn = 'go test ./examples/go-concurrency-capstone/internal/racey -run TestRace_Reproduce -race -count=1'
  u.practice_hints = [
    'Shared mutable state needs synchronization',
    'Prefer channels to share ownership, or guard with sync.Mutex',
    'Race detector failure will fail tests; keep running until it is clean'
  ]
  u.quiz_question_text = 'Which option eliminates a write-write data race?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Guard writes with a sync.Mutex', correct: true },
    { text: 'Add time.Sleep to stagger goroutines', correct: false },
    { text: 'Increase GOMAXPROCS', correct: false },
    { text: 'Ignore the race if tests pass', correct: false }
  ]
  u.quiz_correct_answer = 'Guard writes with a sync.Mutex'
  u.quiz_explanation = 'Add proper synchronization (Mutex) or redesign to avoid shared state via channels.'
  u.estimated_minutes = 8
  u.sequence_order = 4
  u.category = 'concurrency'
  u.difficulty_level = 'medium'
  u.published = true
end

# ILU 5: Deadlock Hunt
ilu5 = InteractiveLearningUnit.find_or_create_by!(slug: 'go-deadlock-hunt') do |u|
  u.title = 'Deadlock Hunt: Diagnose Lock-Order Inversion'
  u.concept_explanation = <<~MD
    Reproduce a deadlock caused by inconsistent lock ordering. Then fix by enforcing a global lock order or
    using finer-grained design. Validate by running tests with a short timeout and ensuring completion.
  MD
  u.command_to_learn = 'go test ./examples/go-concurrency-capstone/internal/deadlock -run TestDeadlock_Reproduce -timeout 2s -count=1'
  u.practice_hints = [
    'Always acquire multiple locks in a consistent global order',
    'Reduce lock scope; avoid holding locks while calling out',
    'Consider redesign: pipeline via channels over shared locks'
  ]
  u.quiz_question_text = 'What prevents lock-order inversion deadlocks?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'Consistently acquiring locks in the same global order', correct: true },
    { text: 'Increasing timeouts', correct: false },
    { text: 'Using defer with all locks', correct: false },
    { text: 'Adding more goroutines', correct: false }
  ]
  u.quiz_correct_answer = 'Consistently acquiring locks in the same global order'
  u.quiz_explanation = 'A strict global lock order prevents cycles in the wait-for graph, avoiding deadlocks.'
  u.estimated_minutes = 8
  u.sequence_order = 5
  u.category = 'concurrency'
  u.difficulty_level = 'medium'
  u.published = true
end

# ILU 6: Interfaces & Idiomatic Go
ilu6 = InteractiveLearningUnit.find_or_create_by!(slug: 'go-interfaces-idiomatic') do |u|
  u.title = 'Refactor to Interfaces & Make It Idiomatic'
  u.concept_explanation = <<~MD
    Extract interfaces for components (Fetcher, Parser, Store) and inject dependencies for testability.
    Clean up names, avoid stutter, prefer small interfaces, and ensure unit tests use fakes.
  MD
  u.command_to_learn = 'go test ./examples/go-concurrency-capstone/... -race -count=1'
  u.practice_hints = [
    'Keep interfaces small (one or two methods)',
    'Define interfaces at the consumer side',
    'Use table-driven tests and fakes to validate behavior'
  ]
  u.quiz_question_text = 'Where should interfaces typically live for testability?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'At the consumer (package that uses the dependency)', correct: true },
    { text: 'Only in the provider package', correct: false },
    { text: 'In a global shared package', correct: false },
    { text: "Interfaces are unnecessary in Go", correct: false }
  ]
  u.quiz_correct_answer = 'At the consumer (package that uses the dependency)'
  u.quiz_explanation = 'Defining interfaces at the consumer makes code easier to test with fakes.'
  u.estimated_minutes = 7
  u.sequence_order = 6
  u.category = 'design'
  u.difficulty_level = 'medium'
  u.published = true
end

# ILU 7: Table-Driven Tests & Benchmarks
ilu7 = InteractiveLearningUnit.find_or_create_by!(slug: 'go-tests-benchmarks') do |u|
  u.title = 'Table-Driven Tests & Benchmarks'
  u.concept_explanation = <<~MD
    Convert ad-hoc tests into table-driven tests with subtests. Add a micro-benchmark to measure
    link extraction performance. Run with -bench and -benchmem.
  MD
  u.command_to_learn = 'go test ./examples/go-concurrency-capstone/internal/parse -bench=. -benchmem -run ^$'
  u.practice_hints = [
    'Use []struct{name, input, want} and t.Run for subtests',
    'Reset benchmark timers after setup',
    'Keep benchmarks deterministic and side-effect free'
  ]
  u.quiz_question_text = 'How do you run only benchmarks in a package?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: 'go test -bench=. -run ^$', correct: true },
    { text: 'go test -run Bench', correct: false },
    { text: 'go bench ./...', correct: false },
    { text: 'go test -onlyBench', correct: false }
  ]
  u.quiz_correct_answer = 'go test -bench=. -run ^$'
  u.quiz_explanation = 'The -bench flag selects benchmarks; -run ^$ prevents running tests.'
  u.estimated_minutes = 6
  u.sequence_order = 7
  u.category = 'testing'
  u.difficulty_level = 'easy'
  u.published = true
end

# ILU 8: Error Handling Patterns
ilu8 = InteractiveLearningUnit.find_or_create_by!(slug: 'go-error-handling-patterns') do |u|
  u.title = 'Error Handling: Sentinel, Wrapping, Is/As'
  u.concept_explanation = <<~MD
    Refactor repository methods to wrap sentinel errors and use errors.Is/As in callers.
    Compare fmt.Errorf with %%w vs %%v; understand how errors.As binds concrete types.
  MD
  u.command_to_learn = 'go test -tags exercise ./examples/go-concurrency-capstone/internal/errors -run .'
  u.practice_hints = [
    'Wrap sentinel errors with fmt.Errorf("...: %w", ErrSentinel)',
    'Use errors.Is for classification, errors.As to extract concrete types',
    'Preserve context in error messages while enabling classification'
  ]
  u.quiz_question_text = 'Which formatting verb enables error wrapping?'
  u.quiz_question_type = 'mcq'
  u.quiz_options = [
    { text: '%w', correct: true },
    { text: '%v', correct: false },
    { text: '%+v', correct: false },
    { text: '%q', correct: false }
  ]
  u.quiz_correct_answer = '%w'
  u.quiz_explanation = 'Use %w in fmt.Errorf to wrap an error for use with errors.Is/As.'
  u.estimated_minutes = 7
  u.sequence_order = 8
  u.category = 'error-handling'
  u.difficulty_level = 'medium'
  u.published = true
end

# Link ILUs 4-8 to the module
[[ilu4, 4], [ilu5, 5], [ilu6, 6], [ilu7, 7], [ilu8, 8]].each do |ilu, order|
  ModuleInteractiveUnit.find_or_create_by!(course_module: concurrency_mod, interactive_learning_unit: ilu) do |miu|
    miu.sequence_order = order
    miu.required = true
  end
end

# Lab A: MVP Crawler
lab_a = HandsOnLab.find_or_create_by!(title: 'Go Concurrency Capstone: MVP Crawler') do |lab|
  lab.description = 'Assemble a bounded worker-pool pipeline to fetch N URLs and store summaries. Must pass -race.'
  lab.lab_type = 'golang'
  lab.lab_format = 'code_editor'
  lab.programming_language = 'golang'
  lab.difficulty = 'medium'
  lab.estimated_minutes = 30
  lab.points_reward = 200
  lab.is_active = true
  lab.time_limit_seconds = 10
  lab.memory_limit_mb = 256
  # sequence_order is managed on the ModuleItem that links this lab to a module
  lab.starter_code = <<~GOLANG
    package main

    import "fmt"

    func main() {
        // TODO: Implement crawler pipeline in your workspace repo.
        // This starter ensures the lab compiles/runs in the code editor environment.
        fmt.Println("go-concurrency-capstone-ready")
    }
  GOLANG
  lab.scenario_narrative = <<~MD
    Build the first milestone of the crawler capstone. Given a set of seed URLs, fetch pages concurrently with a bounded pool
    and store page summaries (URL, bytes, links). Ensure the pipeline is -race clean and respects a global timeout.
  MD
  lab.steps = [
    {
      step_number: 1,
      title: 'Run the starter tests',
      instruction: 'Run `go test ./examples/go-concurrency-capstone/... -race -count=1`',
      command: 'go test ./examples/go-concurrency-capstone/... -race -count=1',
      hint: 'Start by ensuring the skeleton compiles and basic tests pass.'
    },
    {
      step_number: 2,
      title: 'Assemble the pipeline',
      instruction: 'Wire frontier → fetch → parse → store, using a fixed-size worker pool',
      command: 'go test ./examples/go-concurrency-capstone/internal/pipeline -run TestPipeline_ProcessesURLs -race',
      hint: 'Use sync.WaitGroup and close channels correctly to avoid leaks.'
    },
    {
      step_number: 3,
      title: 'Timeout and cancellation',
      instruction: 'Add context.WithTimeout in pipeline.Run and ensure workers exit on ctx.Done()',
      command: 'go test ./examples/go-concurrency-capstone/internal/pipeline -race',
      hint: 'Select on ctx.Done() in long operations and return early.'
    }
  ]
  lab.learning_objectives = [
    'Implement bounded concurrency with worker pools',
    'Compose a basic fan-out/fan-in pipeline',
    'Make code race-free under the Go race detector'
  ]
  lab.allowed_imports = []
  lab.is_active = true
end

# Attach lab to the module
ModuleItem.find_or_create_by!(course_module: concurrency_mod, item: lab_a) do |mi|
  mi.sequence_order = 20
  mi.required = true
end

puts "✅ Go Concurrency units and Lab A seeded: module=#{concurrency_mod.slug}"
