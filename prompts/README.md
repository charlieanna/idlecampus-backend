# Microlesson Generator Prompts

Complete system for converting IdleCampus seed files into microlesson format using AI.

## 📚 What's Available

**45 courses** across 6 categories ready for conversion:
- 🐳 **DevOps & Infrastructure**: Docker, Kubernetes, Linux, PostgreSQL, Git, AWS, etc. (10 courses)
- 💻 **Programming**: Python, Golang, JavaScript, TypeScript, Rust, React, etc. (9 courses)
- 🔬 **IIT JEE**: Chemistry (Inorganic, Organic, Physical) + Mathematics (7 subjects, 15 modules)
- 🏗️ **Software Engineering**: System Design, Microservices, Design Patterns, etc. (12 courses)
- 📊 **Data Science**: Machine Learning, Pandas/NumPy (2 courses)
- 💼 **Interview Prep**: Coding Interviews, Data Structures & Algorithms (2 courses)

## 🚀 Quick Start

### Option 1: Use Existing Prompts (3 courses ready)

**Best for: Docker, Kubernetes, Linux**

```bash
# 1. Choose course
cat devops/01_docker_course_prompt.txt

# 2. Copy entire prompt

# 3. Open GPT-5 Pro (or Claude with file access)

# 4. Paste prompt

# 5. Attach files listed in prompt from:
#    idlecampus/backend/db/seeds/

# 6. Send

# 7. Save each generated output file
```

**Available prompts:**
- ✅ `devops/01_docker_course_prompt.txt` (9 modules)
- ✅ `devops/02_kubernetes_course_prompt.txt` (4 files)
- ✅ `devops/03_linux_course_prompt.txt` (1 file)

### Option 2: Use Universal Template (All other courses)

**Best for: Any of the remaining 42 courses**

```bash
# 1. Find your course in MASTER_COURSE_INDEX.md
#    Example: Course #20 - IIT JEE Inorganic Chemistry

# 2. Note the files to attach:
#    - iit_jee/iit_jee_inorganic_chemistry.rb
#    - inorganic/inorganic_interactive_units.rb
#    - [... 7 more files]

# 3. Copy UNIVERSAL_TEMPLATE.txt

# 4. Replace placeholders:
#    [COURSE NAME] → "IIT JEE - Inorganic Chemistry"
#    [file1.rb] → actual file names

# 5. Paste into GPT-5 Pro

# 6. Attach all files from idlecampus/backend/db/seeds/

# 7. Send

# 8. Save generated outputs
```

## 📋 Files in This Directory

```
prompts/
├── README.md                      # This file
├── MASTER_COURSE_INDEX.md         # All 45 courses with file lists
├── UNIVERSAL_TEMPLATE.txt         # Reusable template for any course
│
├── devops/
│   ├── 01_docker_course_prompt.txt     # ✅ Ready
│   ├── 02_kubernetes_course_prompt.txt # ✅ Ready
│   └── 03_linux_course_prompt.txt      # ✅ Ready
│
├── programming/
│   └── (use UNIVERSAL_TEMPLATE.txt for these)
│
├── iit_jee/
│   └── (use UNIVERSAL_TEMPLATE.txt for these)
│
├── software_engineering/
│   └── (use UNIVERSAL_TEMPLATE.txt for these)
│
├── data_science/
│   └── (use UNIVERSAL_TEMPLATE.txt for these)
│
└── interview_prep/
    └── (use UNIVERSAL_TEMPLATE.txt for these)
```

## 📖 Detailed Usage Guide

### Step-by-Step: Converting a Course

#### Example: Converting PostgreSQL Course

**Step 1: Look up course**
```bash
cat MASTER_COURSE_INDEX.md
# Find: Course #4 - PostgreSQL
# Files: postgresql_course.rb, postgresql_lessons.rb
```

**Step 2: Prepare prompt**
```bash
cp UNIVERSAL_TEMPLATE.txt my_postgresql_prompt.txt
# Edit and replace:
# COURSE NAME: PostgreSQL Fundamentals
# FILES TO ATTACH:
# □ postgresql_course.rb
# □ postgresql_lessons.rb
```

**Step 3: Generate**
- Copy edited prompt
- Open GPT-5 Pro
- Paste prompt
- Attach both files
- Send

**Step 4: Save outputs**
GPT generates:
- `postgresql_fundamentals_microlessons.rb`
- `postgresql_advanced_microlessons.rb`

Save these to: `idlecampus/backend/db/seeds/microlessons/`

**Step 5: Run in Rails**
```ruby
# In Rails console or rake task
rails db:seed:microlessons:postgresql
```

### What the AI Generates

For each seed file, you'll get:

```ruby
# Complete microlesson seed file with:
# - Very small microlessons (1 concept, 2-3 min)
# - 1-4 exercises per microlesson
# - Progressive hints (3 per exercise)
# - Inferred prerequisites
# - Proper Ruby syntax
# - Ready to run
```

### Example Output Structure

```ruby
# === MICROLESSON 1 ===
lesson_1 = MicroLesson.create!(
  title: 'Docker Run Basics',
  content: <<~MARKDOWN,
    # Docker Run Basics 🚀
    [Clear explanation with examples]
  MARKDOWN
  difficulty: 'easy',
  estimated_minutes: 2,
  key_concepts: ['docker run', 'containers'],
  prerequisite_ids: []
)

# Terminal Exercise
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'terminal',
  exercise_data: {
    command: 'docker run hello-world',
    hints: ['Use docker', 'Add run subcommand', 'docker run hello-world']
  }
)

# MCQ Exercise
Exercise.create!(
  micro_lesson: lesson_1,
  exercise_type: 'mcq',
  exercise_data: {
    question: 'What does docker run do?',
    options: [...],
    correct_answer: 0,
    explanation: '...'
  }
)
```

## 🎯 Conversion Rules

The AI follows these rules:

### Microlesson Size
- **1 concept** per microlesson
- **2-3 minutes** estimated time
- Split by: commands, features, or logical sub-concepts

### Exercise Count
- Easy: 1-2 exercises
- Medium: 2-3 exercises
- Hard: 3-4 exercises

### Exercise Types
- **terminal**: CLI commands (Docker, Kubernetes, Linux, Git, etc.)
- **mcq**: Multiple choice with 4 options
- **code**: Programming challenges (Python, JavaScript, etc.)

### Progressive Hints
Each exercise has 3 hints:
1. **Hint 1**: Gentle nudge (for 2nd attempt)
2. **Hint 2**: More specific guidance (for 3rd attempt)
3. **Hint 3**: Nearly the full answer (for 4th attempt)

### Prerequisites
- Analyzed from content
- First lesson: no prerequisites
- Sequential: previous lesson
- Advanced: multiple if needed

## 📊 Progress Tracking

```
Total Courses: 45
├── ✅ Ready (3): Docker, Kubernetes, Linux
└── ⚙️  Use Template (42): All others
```

## 💡 Tips

### Best Practices
1. **Process one course at a time** - Easier to review
2. **Review AI output** - Edit exercises if needed
3. **Test in Rails** - Run seed file before deploying
4. **Save originals** - Keep backup of AI output

### Common Issues

**Problem: Module slug not found**
```ruby
# AI might not know the slug
# You can edit manually:
module_var = CourseModule.find_by(slug: 'correct-slug')
```

**Problem: Too many microlessons**
```ruby
# Merge related ones or adjust AI prompt:
# "Generate maximum 15 microlessons for this module"
```

**Problem: Exercises too easy/hard**
```ruby
# Edit the exercise_data:
# Change hints, questions, or add more exercises
```

## 🔧 Customization

### Want different output format?

Edit `UNIVERSAL_TEMPLATE.txt` to change:
- Markdown structure
- Exercise types
- Number of hints
- Difficulty distribution

### Want to add new exercise types?

Add to template:
```ruby
exercise_type: 'scenario',  # New type
exercise_data: {
  scenario: '...',
  tasks: ['...'],
  evaluation: '...'
}
```

## 📞 Need Help?

1. Check `MASTER_COURSE_INDEX.md` for file lists
2. Use `UNIVERSAL_TEMPLATE.txt` for any course
3. Review existing prompts in `devops/` for examples
4. Edit generated output as needed

## 🎉 Next Steps

After generating microlessons:

1. **Frontend Integration**
   - Export to TypeScript format
   - Add to `courses.ts`
   - Test in UI

2. **Backend Setup**
   - Create MicroLesson and Exercise models
   - Run migrations
   - Seed database

3. **Testing**
   - Verify prerequisites work
   - Test hint progression
   - Check exercise difficulty

---

**Ready to convert your first course?**

Start with Docker (already has full prompt) or use the universal template for any other course!
