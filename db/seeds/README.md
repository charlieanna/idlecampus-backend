# Database Seeds

This directory contains seed data for the IdleCampus backend, organized by course category.

## Directory Structure

```
db/seeds/
├── cat/                          # CAT (MBA) entrance exam courses
│   └── cat_quantitative_ability.rb
├── gre/                          # GRE graduate exam courses
│   └── gre_quantitative_reasoning.rb
├── iit_jee/                      # IIT JEE engineering entrance exam courses
│   ├── iit_jee_inorganic_chemistry.rb
│   ├── iit_jee_organic_chemistry_formulas.rb
│   └── iit_jee_physical_chemistry_formulas.rb
├── converted_microlessons/       # YAML-based courses (new format)
│   ├── course-name/
│   │   ├── manifest.yml          # Course and module metadata
│   │   └── microlessons/
│   │       ├── lesson-1.yml
│   │       └── lesson-2.yml
│   └── ...
├── docker_complete_enhanced/     # Enhanced Docker courses (YAML)
└── (other seed files)
```

## Seeding Options

### 1. Seed Everything (Default)

Run all seed files in order:

```bash
rails db:seed
```

or

```bash
rake db:seed
```

### 2. Seed by Course Category

Seed all courses in a specific category:

```bash
# Seed all CAT courses
rails db:seed:cat

# Seed all GRE courses
rails db:seed:gre

# Seed all IIT JEE courses
rails db:seed:iit_jee
```

### 3. Seed Individual Courses

Seed a specific course:

```bash
# CAT Courses
rails db:seed:cat:quantitative_ability

# GRE Courses
rails db:seed:gre:quantitative_reasoning

# IIT JEE Courses
rails db:seed:iit_jee:inorganic_chemistry
rails db:seed:iit_jee:organic_chemistry
rails db:seed:iit_jee:physical_chemistry
```

### 4. Manual Seed File Loading

Load a specific seed file directly:

```bash
rails runner "load Rails.root.join('db/seeds/cat/cat_quantitative_ability.rb')"
```

## Course Contents

### CAT (MBA Entrance Exam)
- **Quantitative Ability** (80 questions, 16 lessons)
  - Module 1: Number Systems & Arithmetic
  - Module 2: Algebra
  - Module 3: Geometry & Mensuration
  - Module 4: Modern Mathematics

### GRE (Graduate Entrance Exam)
- **Quantitative Reasoning** (80 questions, 16 lessons)
  - Module 1: Arithmetic
  - Module 2: Algebra
  - Module 3: Geometry
  - Module 4: Data Analysis

### IIT JEE (Engineering Entrance Exam)
- **Inorganic Chemistry**
- **Organic Chemistry Formulas**
- **Physical Chemistry Formulas**

## Adding New Courses

### 1. Create Course Directory (if needed)

```bash
mkdir -p db/seeds/new_exam_category
```

### 2. Add Seed File

Create your seed file in the appropriate directory:
```
db/seeds/new_exam_category/course_name.rb
```

### 3. Update `db/seeds.rb`

Add the new file to the `seed_files` array:

```ruby
seed_files = [
  # ... existing files ...
  'new_exam_category/course_name.rb'
]
```

### 4. Create Rake Task (Optional)

Add tasks to `lib/tasks/seed_courses.rake`:

```ruby
namespace :db do
  namespace :seed do
    desc "Seed all NEW_CATEGORY courses"
    task new_category: :environment do
      puts "🌱 Seeding NEW_CATEGORY courses..."
      load_seed_directory('new_category')
      puts "✅ NEW_CATEGORY courses seeded successfully!"
    end

    namespace :new_category do
      desc "Seed specific course"
      task course_name: :environment do
        puts "🌱 Seeding Course Name..."
        load_seed_file('new_category/course_name.rb')
        puts "✅ Course Name seeded successfully!"
      end
    end
  end
end
```

## YAML-Based Courses (NEW)

Starting from 2025, we support YAML-based course definitions for easier content management and version control.

### Why YAML?

- **Separation of Concerns**: Content creators can edit YAML without touching Ruby code
- **Better Version Control**: Smaller, focused diffs for each microlesson
- **Human-Readable**: Easy to read and edit without programming knowledge
- **Validation**: Built-in schema validation before import
- **Portability**: Platform-agnostic format

### YAML Course Structure

Each YAML-based course consists of:

1. **manifest.yml** - Course metadata and module structure
2. **microlessons/** - Directory containing individual lesson YAML files

Example:
```
db/seeds/converted_microlessons/docker-basics/
├── manifest.yml
└── microlessons/
    ├── docker-ps.yml
    ├── docker-run.yml
    └── docker-stop.yml
```

### Working with YAML Courses

#### List Available YAML Courses

```bash
rake courses:yaml:list
```

#### Validate YAML Courses

Validate all YAML courses:
```bash
rake courses:yaml:validate
```

Validate a specific course:
```bash
rake courses:yaml:validate_course[docker-basics]
```

#### Import YAML Courses

Import all YAML courses:
```bash
rake courses:yaml:import
```

Import a specific course:
```bash
rake courses:yaml:import_course[docker-basics]
```

Or use the standard seed command (imports all courses including YAML):
```bash
rails db:seed
```

#### Create a New YAML Course

Generate a course template:
```bash
rake courses:yaml:generate_template[my-course-slug]
```

This creates:
- `db/seeds/converted_microlessons/my-course-slug/manifest.yml`
- `db/seeds/converted_microlessons/my-course-slug/microlessons/lesson-1-slug.yml`

### YAML File Format

#### manifest.yml

```yaml
course:
  slug: docker-basics
  title: Docker Basics
  description: Learn fundamental Docker commands
  estimated_hours: 4
  level: beginner  # beginner, intermediate, or advanced

modules:
- slug: docker-essentials
  title: Docker Essentials
  description: Core Docker commands
  lessons:
  - docker-ps
  - docker-run
  - docker-stop
```

#### microlesson YAML

```yaml
slug: docker-ps
title: Docker PS - List Containers
sequence_order: 1
estimated_minutes: 5
difficulty: easy
key_concepts:
- docker-ps
- container-listing

content_md: |
  # Docker PS Command

  ## What is docker ps?
  Lists running containers...

  ## Syntax
  ```bash
  docker ps
  ```

exercises:
- type: terminal
  sequence_order: 1
  command: docker ps
  description: List running containers
  hints:
  - Use -a to see all containers
  timeout_sec: 60
  require_pass: true

- type: mcq
  sequence_order: 2
  question: What does 'docker ps' show by default?
  options:
  - Running containers only
  - All containers
  - Stopped containers only
  correct_answer_index: 0
  require_pass: true

objectives:
- Understand docker ps command
- List running containers
```

### Supported Entity Types

#### Microlessons
Small, focused learning units with exercises (2-5 minutes each)

#### Course Lessons
Full lessons with rich content, videos, and reading time

#### Labs
Hands-on practice exercises:
- **terminal** - CLI-based labs
- **code_editor** - Programming challenges
- **hybrid** - Combined terminal + code

#### Quizzes
Module-level assessments with multiple question types

### Supported Exercise Types (in Microlessons)

- **terminal** - Command-line exercises with validation
- **mcq** - Multiple choice questions
- **short_answer** - Text-based answers
- **coding** - Code challenges with test cases
- **sql** - SQL query exercises
- **reflection** - Reflection prompts
- **checkpoint** - Knowledge checkpoints

### Validation Rules

The validator checks:
- ✅ Required fields (slug, title)
- ✅ Valid slug format (lowercase, hyphens only)
- ✅ Difficulty levels (easy/medium/hard)
- ✅ Exercise structure and types
- ✅ MCQ correct answer indices
- ✅ YAML syntax

### Converting Ruby Seeds to YAML

To convert existing Ruby seed files to YAML:

1. Extract course, module, and lesson data
2. Generate manifest.yml with course structure
3. Create individual microlesson YAML files
4. Validate with `rake courses:yaml:validate_course[course-name]`
5. Import with `rake courses:yaml:import_course[course-name]`

### Migration Notes

- YAML courses are loaded via `yaml_course_loader.rb` in `db/seeds.rb`
- Validator is located at `lib/validators/course_yaml_validator.rb`
- Rake tasks are in `lib/tasks/yaml_courses.rake`
- Both Ruby and YAML approaches are currently supported

### Advanced Features

#### Dry-Run Mode

Preview what would be imported without actually creating database records:

```bash
DRY_RUN=true rake courses:yaml:import
```

This shows:
- List of courses that would be imported
- Number of items per course
- Total statistics

Perfect for:
- Testing YAML changes
- Reviewing before production import
- CI/CD validation pipelines

#### Frontend TypeScript Generator

Generate TypeScript data files from YAML courses for frontend applications:

```bash
# Generate for all courses
rake courses:yaml:generate_typescript

# Generate for specific course
rake courses:yaml:generate_typescript_course[kubernetes-complete]

# Custom output directory
OUTPUT_DIR=/path/to/frontend/src/data rake courses:yaml:generate_typescript
```

Generated files include:
- TypeScript interfaces for all entity types
- Fully typed course data
- camelCase property names (JavaScript convention)
- Auto-generated documentation headers

Example generated file:
```typescript
// frontend/src/data/courses/kubernetes-complete.ts
export interface CourseMetadata {
  slug: string;
  title: string;
  level?: 'beginner' | 'intermediate' | 'advanced';
}

export interface Microlesson {
  slug: string;
  title: string;
  durationMinutes?: number;
  exercises?: Exercise[];
}

export const courseData: CourseData = {
  meta: {
    slug: "kubernetes-complete",
    title: "Kubernetes Complete Guide",
    level: "intermediate"
  },
  modules: [...]
};
```

Benefits:
- Single source of truth (YAML)
- Type-safe frontend code
- Automated builds in CI/CD
- Consistent data across backend and frontend

## Troubleshooting

### YAML Course Issues

#### Validation Errors

If validation fails:
```bash
rake courses:yaml:validate_course[course-name]
```

Common errors:
- **Invalid slug format**: Use lowercase letters, numbers, and hyphens only
- **Missing required fields**: Ensure slug and title are present
- **Invalid exercise type**: Use supported types (terminal, mcq, short_answer, etc.)
- **MCQ answer index out of range**: Ensure correct_answer_index matches options array

#### Import Failures

If import fails:
```bash
# Check validation first
rake courses:yaml:validate_course[course-name]

# Try importing with verbose output
rake courses:yaml:import_course[course-name]
```

Check Rails logs for detailed error messages:
```bash
tail -f log/development.log
```

#### YAML Syntax Errors

Use a YAML validator or linter:
```bash
# Install yamllint
pip install yamllint

# Validate YAML syntax
yamllint db/seeds/converted_microlessons/course-name/manifest.yml
```

### Ruby Seed Issues

### Issue: "File not found"

Make sure you're running the command from the Rails root directory, and that the seed file exists:

```bash
ls -la db/seeds/cat/
```

### Issue: Database errors

Reset the database before seeding:

```bash
rails db:reset
rails db:seed:cat
```

### Issue: Want to re-seed a specific course

Drop and recreate just that course's data, or use the reset tasks if available:

```bash
# Example for resetting courses
rails reset:courses
rails db:seed:cat:quantitative_ability
```

## List Available Seed Tasks

To see all available seed tasks:

```bash
rails -T db:seed
```

or

```bash
rake -T db:seed
```

## Notes

- Seed files are idempotent - they use `find_or_create_by!` to avoid duplicates
- The main `db/seeds.rb` file loads all seeds in a specific order
- Individual seed tasks allow you to load only what you need during development
- All courses include detailed teaching content, practice questions, and remediation mappings
