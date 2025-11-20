# Format Issue Fix Summary

## The Problem

When you gave the prompts to the AI agent, it reported:
> "Skips missing seed files and reports files without InteractiveLearningUnit blocks"

## Root Cause

The backend seed files use **two different formats**:

### Format 1: InteractiveLearningUnit (Legacy - ~20 files)
```ruby
InteractiveLearningUnit.find_or_create_by!(slug: 'docker-ps') do |u|
  u.title = "Docker PS Command"
  u.content = "..."
end
```

**Used by:**
- `docker_*_units.rb` (Docker course files)
- `golang_concurrency_units.rb`

### Format 2: Course/CourseModule/Lesson (Current - ~140+ files)
```ruby
course = Course.find_or_create_by!(slug: 'python') do |c|
  c.title = 'Python Programming'
end

lesson = Lesson.find_or_create_by!(slug: 'variables') do |l|
  l.title = 'Variables'
  l.content = "..."
end
```

**Used by:**
- `python_course.rb`
- `golang_course.rb`
- `kubernetes_complete_guide.rb`
- `aws_course_complete.rb`
- Most other `*_course.rb` files

## The Fix

I've updated the prompts to handle **both formats**:

### Files Updated:

1. ✅ **UNIVERSAL_TEMPLATE.txt** - Now includes format detection instructions
2. ✅ **SEED_FILE_FORMATS.md** - Complete guide to both formats
3. ✅ **Python prompt (#11)** - Specifies Course/Lesson format
4. ✅ **Golang prompt (#12)** - Notes mixed format (both types)
5. ✅ **Kubernetes prompt (#02)** - Specifies CourseLesson format

### What Changed:

All prompts now include this section:

```markdown
# IMPORTANT: INPUT FORMAT

The attached seed files may use different formats:
- **Format 1**: InteractiveLearningUnit.find_or_create_by! (legacy)
- **Format 2**: Course/CourseModule/Lesson.find_or_create_by! (current)

**Process BOTH formats**. Extract content from Lesson blocks OR
InteractiveLearningUnit blocks, whichever is present in the file.
```

## How to Use Fixed Prompts

### For Docker Course:
```
✓ Files use InteractiveLearningUnit format
✓ Prompt works as-is
```

### For Python/Golang/Kubernetes:
```
✓ Files use Course/Lesson format
✓ Updated prompts now specify this
✓ AI will look for Lesson blocks instead of InteractiveLearningUnit
```

### For Mixed Courses (like Golang):
```
✓ Some files use InteractiveLearningUnit
✓ Some files use Course/Lesson
✓ Prompt instructs AI to handle both
```

## Testing Recommendation

Try the updated prompts with these courses first:

1. **Docker** - Uses InteractiveLearningUnit (Format 1)
   - Should work perfectly
   - 9 seed files with consistent format

2. **Python** - Uses Course/Lesson (Format 2)
   - Now explicitly handles this format
   - 4 seed files

3. **Golang** - Mixed formats
   - Tests both format detection
   - 9 seed files (8 Course/Lesson + 1 InteractiveLearningUnit)

## Result

The AI agent should now:
- ✅ Recognize both seed file formats
- ✅ Extract content from either structure
- ✅ Not skip files due to format mismatch
- ✅ Generate MicroLesson output from any input format
