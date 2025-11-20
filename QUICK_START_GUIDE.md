# Quick Start Guide: Course Management

Quick reference for common course management tasks after consolidation.

---

## Common Tasks

### 1. Add New Lesson to Existing Course

```bash
# Example: Add new Git lesson to DevOps Essentials

# Step 1: Create lesson file
vim db/seeds/converted_microlessons/git-fundamentals/microlessons/git-hooks.yml

# Step 2: Update consolidated manifest
vim db/seeds/consolidated_courses/devops-essentials/manifest.yml
# Add 'git-hooks' to version-control-git module's lessons array

# Step 3: Validate
ruby scripts/validate_course.rb devops-essentials

# Step 4: Commit
git add db/seeds/converted_microlessons/git-fundamentals/microlessons/git-hooks.yml
git add db/seeds/consolidated_courses/devops-essentials/manifest.yml
git commit -m "feat(git): add Git hooks lesson"
git push -u origin <branch-name>
```

### 2. Create New Consolidated Course

```bash
# Example: Create Python Fundamentals course

# Step 1: Create lesson files
mkdir -p db/seeds/converted_microlessons/python-basics/microlessons
vim db/seeds/converted_microlessons/python-basics/microlessons/python-intro.yml
vim db/seeds/converted_microlessons/python-basics/microlessons/python-variables.yml
# ... more lessons

# Step 2: Create consolidated manifest
mkdir -p db/seeds/consolidated_courses/python-fundamentals
vim db/seeds/consolidated_courses/python-fundamentals/manifest.yml

# Step 3: Use this template:
cat > db/seeds/consolidated_courses/python-fundamentals/manifest.yml <<'EOF'
---
course:
  slug: python-fundamentals
  title: Python Fundamentals
  description: Learn Python programming from basics to advanced concepts
  estimated_hours: 15
  level: beginner
  prerequisites:
    - Basic computer skills
  learning_outcomes:
    - Write Python programs
    - Understand Python syntax and data structures
  tags:
    - python
    - programming
  related_courses:
    - go-fundamentals
  recommended_next: python-advanced

modules:
  - slug: python-basics
    title: Python Basics
    description: Introduction to Python
    order: 1
    estimated_hours: 4
    lessons:
      - python-intro
      - python-variables
      # ... more lessons
EOF

# Step 4: Validate
ruby scripts/validate_course.rb python-fundamentals

# Step 5: Commit
git add db/seeds/converted_microlessons/python-basics/
git add db/seeds/consolidated_courses/python-fundamentals/
git commit -m "feat(python): add Python Fundamentals course"
git push -u origin <branch-name>
```

### 3. Validate a Course

```bash
# Validate course structure and lesson references
ruby scripts/validate_course.rb devops-essentials

# Expected output:
# ✅ Course is valid! No errors or warnings.
```

### 4. List Unconsolidated Courses

```bash
# See which original courses haven't been consolidated yet
ruby scripts/list_unconsolidated_courses.rb

# Shows:
# - Unconsolidated courses by category
# - Progress percentage
# - Recommendations for grouping
```

### 5. Migrate Course to Self-Contained Structure

```bash
# (Future: When ready to migrate from reference-based to self-contained)

# Step 1: Dry run (see what would happen)
ruby scripts/migrate_course_to_self_contained.rb devops-essentials --dry-run

# Step 2: Perform migration
ruby scripts/migrate_course_to_self_contained.rb devops-essentials

# Step 3: Validate migrated course
ruby scripts/validate_course.rb devops-essentials

# Step 4: Commit
git add db/seeds/courses/devops-essentials/
git commit -m "migrate(devops): move to self-contained structure"
```

### 6. Edit Existing Lesson

```bash
# Find lesson file
find db/seeds/converted_microlessons -name "git-branching-strategies.yml"

# Edit
vim db/seeds/converted_microlessons/git-fundamentals/microlessons/git-branching-strategies.yml

# Validate (optional)
ruby scripts/validate_course.rb devops-essentials

# Commit (no manifest change needed)
git add db/seeds/converted_microlessons/git-fundamentals/microlessons/git-branching-strategies.yml
git commit -m "fix(git): clarify fast-forward merge explanation"
git push -u origin <branch-name>
```

### 7. Reorganize Course Modules

```bash
# Example: Split large module into two

# Edit manifest
vim db/seeds/consolidated_courses/kubernetes-complete/manifest.yml

# Change:
# OLD:
#   - slug: kubernetes-advanced
#     lessons: [scaling, monitoring, rbac, networking, policies]
#
# NEW:
#   - slug: kubernetes-operations
#     lessons: [scaling, monitoring, rbac]
#   - slug: kubernetes-security
#     lessons: [networking, policies]

# Validate
ruby scripts/validate_course.rb kubernetes-complete

# Commit
git add db/seeds/consolidated_courses/kubernetes-complete/manifest.yml
git commit -m "refactor(k8s): split advanced module into operations and security"
git push -u origin <branch-name>
```

---

## File Locations

### Current Structure (Phase 1)

```
db/seeds/
├── converted_microlessons/          # Lesson files (source of truth)
│   ├── <original-course-slug>/
│   │   ├── manifest.yml            # Old manifest (mostly unused)
│   │   └── microlessons/
│   │       └── *.yml               # Lesson files
│   └── ...
│
└── consolidated_courses/            # New consolidated manifests
    └── <consolidated-course-slug>/
        └── manifest.yml            # References lessons by slug
```

### Future Structure (Phase 2)

```
db/seeds/
└── courses/                         # Self-contained courses
    └── <course-slug>/
        ├── manifest.yml
        └── microlessons/
            └── *.yml               # All lessons in one place
```

---

## Lesson File Template

```yaml
slug: lesson-slug-name                 # Unique identifier (kebab-case)
title: Lesson Display Title            # User-facing title
difficulty: easy|intermediate|hard     # Difficulty level
sequence_order: 1                      # Order within course
estimated_minutes: 15                  # Time to complete
key_concepts:                          # Main topics covered
  - Concept 1
  - Concept 2
prerequisites:                         # Required prior lessons
  - lesson-1
content_md: |
  # Lesson Title

  Introduction paragraph...

  ## Section 1

  Content here...

  ### Subsection

  More content...

  ```bash
  # Code example
  git commit -m "message"
  ```

  ## Section 2

  More content...

exercises:
  - type: mcq
    sequence_order: 1
    question: "What is...?"
    options:
      - "Option A"
      - "Option B (correct)"
      - "Option C"
      - "Option D"
    correct_answer: "Option B (correct)"
    explanation: "Detailed explanation of why B is correct..."
    require_pass: true

  - type: mcq
    sequence_order: 2
    # ... more exercises
```

---

## Manifest Template

```yaml
---
course:
  slug: course-slug-name
  title: Course Display Title
  description: Brief 1-2 sentence description
  estimated_hours: 10
  level: beginner|intermediate|advanced

  # Optional
  exam_prep:
    - JEE Advanced
    - AWS Certified Solutions Architect
  certification_prep:
    - CKA
    - CKAD

  prerequisites:
    - Basic knowledge requirement
    - Another course slug (optional)

  learning_outcomes:
    - What students will learn
    - Specific skills gained

  tags:
    - tag1
    - tag2
    - tag3

  related_courses:
    - related-course-1
    - related-course-2

  recommended_next: next-course-slug

modules:
  - slug: module-slug
    title: Module Display Name
    description: What this module covers
    order: 1
    estimated_hours: 3

    lessons:
      - lesson-slug-1
      - lesson-slug-2
      - lesson-slug-3

    # Optional
    prerequisites:
      - previous-module-slug
```

---

## Validation Checklist

Before committing:

- [ ] Lesson files exist in correct location
- [ ] Lesson slugs match filenames (without .yml)
- [ ] Manifest references lessons correctly
- [ ] All required fields present (slug, title, description, etc.)
- [ ] Module order is sequential (1, 2, 3...)
- [ ] Estimated hours are reasonable
- [ ] Tags are descriptive and useful
- [ ] Run validation script: `ruby scripts/validate_course.rb <slug>`

---

## Git Workflow

```bash
# 1. Create branch
git checkout -b claude/<description>-<session-id>

# 2. Make changes
# ... create/edit files ...

# 3. Validate
ruby scripts/validate_course.rb <course-slug>

# 4. Stage changes
git add <files>

# 5. Commit with clear message
git commit -m "type(scope): description"
# Types: feat, fix, refactor, chore, docs

# 6. Push
git push -u origin <branch-name>
```

---

## Help and Documentation

- **Full architecture guide**: `COURSE_MANAGEMENT_ARCHITECTURE.md`
- **Consolidation summaries**:
  - `DOCKER_K8S_CONSOLIDATION_SUMMARY.md`
  - `CHEMISTRY_CONSOLIDATION_SUMMARY.md`
  - `LINUX_DEVOPS_CONSOLIDATION_SUMMARY.md`
  - `COMPLETE_COURSE_CONSOLIDATION_SUMMARY.md`
- **Scripts**:
  - `scripts/validate_course.rb` - Validate course structure
  - `scripts/list_unconsolidated_courses.rb` - Find unconsolidated courses
  - `scripts/migrate_course_to_self_contained.rb` - Migrate to new structure

---

## Common Issues

### Issue: "Lesson file not found"

**Problem**: Manifest references lesson that doesn't exist

**Solution**:
```bash
# Find where lesson should be
ls db/seeds/converted_microlessons/*/microlessons/ | grep <lesson-slug>

# Create lesson if needed
vim db/seeds/converted_microlessons/<course>/microlessons/<lesson-slug>.yml

# Or remove from manifest if obsolete
vim db/seeds/consolidated_courses/<course>/manifest.yml
```

### Issue: "YAML parse error"

**Problem**: Invalid YAML syntax

**Solution**:
```bash
# Check YAML syntax
ruby -ryaml -e "YAML.load_file('<file>')"

# Common issues:
# - Missing quotes around strings with special chars
# - Incorrect indentation (use spaces, not tabs)
# - Unclosed quotes or brackets
```

### Issue: "Duplicate module order"

**Problem**: Two modules have same order number

**Solution**:
```bash
# Edit manifest
vim db/seeds/consolidated_courses/<course>/manifest.yml

# Ensure each module has unique order: 1, 2, 3, 4...
```

---

## Tips

1. **Validate early, validate often** - Run validation script before committing
2. **Small commits** - Commit each lesson/change separately for easier review
3. **Descriptive messages** - Explain what and why in commit messages
4. **Test lessons** - Review content for quality and accuracy
5. **Use templates** - Copy existing high-quality lessons as templates
6. **Cross-reference** - Link related courses in metadata
7. **Consistent naming** - Use kebab-case for slugs
8. **Document decisions** - Add comments in manifests for unusual choices

---

## Getting Help

1. Read `COURSE_MANAGEMENT_ARCHITECTURE.md` for detailed architecture
2. Review existing consolidated courses as examples
3. Run validation scripts for immediate feedback
4. Check consolidation summary documents for patterns
5. Look at recent Git commits for workflow examples

---

*Last updated: 2025-11-09*
