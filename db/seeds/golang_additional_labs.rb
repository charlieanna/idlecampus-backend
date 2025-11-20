# Additional Go Labs and Linking Script

puts "\n🔧 Linking existing Go code labs to course modules and adding new practice labs..."

go_course = Course.find_by(slug: 'golang-fundamentals')
unless go_course
  puts "⚠️ Go course not found (golang-fundamentals). Skipping."
  return
end

# Helper to fetch module by slug
def mod_for(course, slug)
  course.course_modules.find_by(slug: slug)
end

mod_basics      = mod_for(go_course, 'go-basics')
mod_concurrency = mod_for(go_course, 'concurrency-fundamentals')
mod_goroutines  = mod_for(go_course, 'goroutines')
mod_channels    = mod_for(go_course, 'channels')
mod_interfaces  = mod_for(go_course, 'interfaces')
mod_testing     = mod_for(go_course, 'testing')
mod_practical   = mod_for(go_course, 'practical-go')

# Link existing 6 code labs if present
titles_to_modules = {
  'Go Slices and Arrays'        => mod_basics,
  'Go Maps and Data Structures' => mod_basics,
  'Go Concurrency Basics'       => mod_concurrency || mod_goroutines,
  'Go Error Handling'           => mod_practical || mod_testing,
  'Go Structs and Methods'      => mod_practical || mod_interfaces,
  'Go Maps - Word Counter'      => mod_basics
}

titles_to_modules.each_with_index do |(title, course_module), idx|
  next unless course_module
  lab = HandsOnLab.find_by(title: title, lab_type: 'golang')
  next unless lab

  ModuleItem.find_or_create_by!(course_module: course_module, item: lab) do |mi|
    mi.sequence_order = (idx + 1) * 2
    mi.required = true
  end
end

# Add three new focused labs if they don't exist

# Lab 7: Interfaces & Dependency Injection
lab7 = HandsOnLab.find_or_create_by!(title: 'Go Interfaces & Dependency Injection') do |lab|
  lab.description = 'Refactor to interfaces defined at the consumer; inject fakes to unit test behavior.'
  lab.lab_type = 'golang'
  lab.lab_format = 'code_editor'
  lab.programming_language = 'golang'
  lab.difficulty = 'medium'
  lab.estimated_minutes = 25
  lab.points_reward = 150
  lab.max_attempts = 10
  lab.time_limit_seconds = 10
  lab.memory_limit_mb = 256
  lab.allowed_imports = ['fmt']
  lab.starter_code = <<~GOLANG
    package main

    import "fmt"

    // BEFORE: concrete dependency
    type HTTPClient struct{}
    func (c HTTPClient) Get(url string) string { return "status:200" }

    // Refactor: define a small interface at the consumer and inject.
    // Write tests with a fake client.

    func FetchStatus(url string) string {
        client := HTTPClient{}
        return client.Get(url)
    }

    func main() { fmt.Println(FetchStatus("https://example.com")) }
  GOLANG
  lab.solution_code = <<~GOLANG
    package main

    import "fmt"

    type Getter interface{ Get(string) string }

    type HTTPClient struct{}
    func (c HTTPClient) Get(url string) string { return "status:200" }

    func FetchStatusWith(client Getter, url string) string { return client.Get(url) }

    func main(){ fmt.Println(FetchStatusWith(HTTPClient{}, "https://example.com")) }
  GOLANG
  lab.test_cases = [
    { description: 'Inject fake client', expected_output: 'status:200', hidden: false }
  ]
  lab.learning_objectives = [
    'Define small interfaces at the consumer',
    'Inject fakes for testing',
    'Decouple from concrete dependencies'
  ]
  lab.is_active = true
end

if mod_interfaces
  ModuleItem.find_or_create_by!(course_module: mod_interfaces, item: lab7) do |mi|
    mi.sequence_order = 12
    mi.required = true
  end
end

# Lab 8: Channel Patterns (select/timeouts/cancellation)
lab8 = HandsOnLab.find_or_create_by!(title: 'Go Channels: Select & Timeouts') do |lab|
  lab.description = 'Practice select with multiple channels, timeouts, and cancellation signaling via done channels.'
  lab.lab_type = 'golang'
  lab.lab_format = 'code_editor'
  lab.programming_language = 'golang'
  lab.difficulty = 'hard'
  lab.estimated_minutes = 30
  lab.points_reward = 200
  lab.max_attempts = 10
  lab.time_limit_seconds = 10
  lab.memory_limit_mb = 256
  lab.allowed_imports = ['fmt', 'time']
  lab.starter_code = <<~GOLANG
    package main

    import (
        "fmt"
        "time"
    )

    // WaitForFirst returns the first value received, or "timeout" if none arrives in time.
    func WaitForFirst(c1, c2 <-chan string, timeout time.Duration) string {
        // TODO: use select with time.After
        return ""
    }

    func main(){
        c1 := make(chan string, 1)
        go func(){ time.Sleep(50*time.Millisecond); c1 <- "A" }()
        fmt.Println( WaitForFirst(c1, nil, 100*time.Millisecond) )
    }
  GOLANG
  lab.solution_code = <<~GOLANG
    package main

    import (
        "fmt"
        "time"
    )

    func WaitForFirst(c1, c2 <-chan string, timeout time.Duration) string {
        select{
        case v := <-c1: return v
        case v := <-c2: return v
        case <-time.After(timeout): return "timeout"
        }
    }

    func main(){
        c1 := make(chan string, 1)
        go func(){ time.Sleep(50*time.Millisecond); c1 <- "A" }()
        fmt.Println( WaitForFirst(c1, nil, 100*time.Millisecond) )
    }
  GOLANG
  lab.test_cases = [
    { description: 'First channel wins', expected_output: 'A', hidden: false },
    { description: 'Timeout path', expected_output: 'timeout', hidden: false }
  ]
  lab.learning_objectives = [
    'Use select with multiple cases',
    'Implement timeouts with time.After',
    'Design cancellation with done channels'
  ]
  lab.is_active = true
end

if mod_channels
  ModuleItem.find_or_create_by!(course_module: mod_channels, item: lab8) do |mi|
    mi.sequence_order = 12
    mi.required = true
  end
end

# Lab 9: Table-Driven Tests & Benchmarks
lab9 = HandsOnLab.find_or_create_by!(title: 'Go Tests: Table-Driven & Benchmarks') do |lab|
  lab.description = 'Write table-driven tests with subtests and add a micro-benchmark with -bench and -benchmem.'
  lab.lab_type = 'golang'
  lab.lab_format = 'code_editor'
  lab.programming_language = 'golang'
  lab.difficulty = 'medium'
  lab.estimated_minutes = 25
  lab.points_reward = 150
  lab.max_attempts = 10
  lab.time_limit_seconds = 10
  lab.memory_limit_mb = 256
  lab.allowed_imports = ['testing']
  lab.starter_code = <<~GOLANG
    package main

    // Reverse returns the reversed string.
    func Reverse(s string) string {
        // TODO: implement
        return s
    }
  GOLANG
  lab.solution_code = <<~GOLANG
    package main

    func Reverse(s string) string {
        r := []rune(s)
        for i, j := 0, len(r)-1; i < j; i, j = i+1, j-1 {
            r[i], r[j] = r[j], r[i]
        }
        return string(r)
    }
  GOLANG
  lab.test_cases = [
    { description: 'Basic reverse', expected_output: '', hidden: false }
  ]
  lab.learning_objectives = [
    'Implement table-driven tests with subtests',
    'Add benchmark and run with -bench',
    'Interpret basic benchmark output'
  ]
  lab.is_active = true
end

if mod_testing
  ModuleItem.find_or_create_by!(course_module: mod_testing, item: lab9) do |mi|
    mi.sequence_order = 12
    mi.required = true
  end
end

puts "✅ Linked Go labs and added new practice labs (interfaces, channels, tests)."

