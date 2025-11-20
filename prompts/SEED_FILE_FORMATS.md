# Seed File Format Guide

## Two Formats in Use

The backend seed files use **two different formats**. The prompts should handle both.

### Format 1: InteractiveLearningUnit (Legacy)

Used by:
- `docker_*_units.rb` files
- `golang_concurrency_units.rb`
- Some older seed files

Structure:
```ruby
InteractiveLearningUnit.find_or_create_by!(slug: 'docker-containers-ls') do |u|
  u.course_module = containers_module
  u.title = "Docker Container List Command"
  u.content_type = 'mixed'
  u.content = <<~MARKDOWN
    # Docker ps Command
    ...
  MARKDOWN
  u.command = "docker ps"
  u.expected_output = "..."
end
```

### Format 2: Course/CourseModule/Lesson (Current)

Used by:
- `python_course.rb`
- `golang_course.rb`
- `kubernetes_complete_guide.rb`
- `aws_course_complete.rb`
- Most `*_course.rb` files

Structure:
```ruby
course = Course.find_or_create_by!(slug: 'python-fundamentals') do |c|
  c.title = 'Python Programming'
  ...
end

module1 = CourseModule.find_or_create_by!(slug: 'python-basics', course: course) do |m|
  m.title = 'Python Basics'
  ...
end

lesson = Lesson.find_or_create_by!(course_module: module1, slug: 'variables') do |l|
  l.title = 'Variables in Python'
  l.content = <<~MARKDOWN
    # Python Variables
    ...
  MARKDOWN
end
```

## Instructions for AI Generation

When processing seed files:

1. **Check the format** by looking at the models used:
   - If file contains `InteractiveLearningUnit.find_or_create_by` → Format 1
   - If file contains `Lesson.find_or_create_by` or `CourseLesson.find_or_create_by` → Format 2

2. **Extract content from both formats**:
   - Format 1: Get content from `u.content`, `u.command`, `u.expected_output`
   - Format 2: Get content from `l.content`, `l.markdown`, lesson structure

3. **Generate MicroLesson output** regardless of input format:
   ```ruby
   MicroLesson.create!(
     title: "...",
     content: "...",
     # ... microlesson fields
   )

   Exercise.create!(
     micro_lesson: lesson_1,
     exercise_type: "terminal",
     exercise_data: {...}
   )
   ```

## Common Issues

### "Skips missing seed files"
- **Cause**: File paths in prompt don't match actual file names
- **Solution**: Verify file names exist in `db/seeds/` directory

### "Files without InteractiveLearningUnit blocks"
- **Cause**: Seed file uses Format 2 (Course/Lesson) instead of Format 1
- **Solution**: Process both formats - extract content regardless of structure

## Recommendation

Update prompts to include this note:

```
# IMPORTANT: Input Format
The attached seed files may use one of two formats:
1. InteractiveLearningUnit (legacy)
2. Course/CourseModule/Lesson (current)

Process BOTH formats. Extract the lesson content, commands, and exercises
regardless of which model structure is used in the input files.
```
