# Course Management Architecture

## Overview

This document defines the architecture and workflows for managing courses going forward after the consolidation initiative.

---

## Current State (After Consolidation)

### Directory Structure

```
db/seeds/
├── converted_microlessons/          # Original structure (102 courses)
│   ├── git-fundamentals/
│   │   ├── manifest.yml            # Old-style course manifest
│   │   └── microlessons/
│   │       ├── lesson-1.yml
│   │       ├── git-branching-strategies.yml
│   │       └── ...
│   ├── docker-introduction/
│   ├── kubernetes-fundamentals/
│   └── ...
│
└── consolidated_courses/            # New structure (9 courses)
    ├── devops-essentials/
    │   └── manifest.yml            # References lessons from original structure
    ├── docker-fundamentals/
    ├── kubernetes-complete/
    └── ...
```

### Key Facts

- **102 original courses** in `converted_microlessons/`
- **9 consolidated courses** in `consolidated_courses/`
- Consolidated manifests **reference** original lesson files (don't duplicate)
- Lesson content remains in original locations
- Consolidation reduced 61 courses → 9 professional courses

---

## Architecture Decision: Two-Phase Approach

### Phase 1: Current (Reference-Based) ✅ **CURRENT**

**Structure:**
- Lesson files stay in `converted_microlessons/`
- Consolidated manifests in `consolidated_courses/` reference lessons by slug
- Both structures coexist

**Pros:**
- ✅ No data migration needed
- ✅ Backward compatible
- ✅ Can iterate on consolidation without moving files
- ✅ Original structure preserved for reference

**Cons:**
- ❌ Two directories to maintain
- ❌ Confusing for new developers
- ❌ Lesson files scattered across many directories

### Phase 2: Future (Self-Contained) 🎯 **RECOMMENDED**

**Structure:**
- Each consolidated course has its own `microlessons/` directory
- All lesson files moved into their course directory
- Old structure deprecated/removed

```
db/seeds/courses/                    # Renamed for clarity
├── devops-essentials/
│   ├── manifest.yml
│   └── microlessons/
│       ├── lesson-1.yml
│       ├── git-branching-strategies.yml
│       ├── cicd-lesson-1.yml
│       └── ...
├── docker-fundamentals/
│   ├── manifest.yml
│   └── microlessons/
│       ├── docker-ps-listing.yml
│       └── ...
└── ...
```

**Pros:**
- ✅ Clear, self-contained structure
- ✅ Each course is a complete package
- ✅ Easy to understand and navigate
- ✅ Follows modern best practices

**Cons:**
- ❌ Requires file migration
- ❌ Breaking change for existing code

---

## Recommended Workflow: Going Forward

### Strategy: Hybrid Approach

**For Existing Consolidated Courses:**
- Keep current reference-based structure (Phase 1)
- Add new lessons to appropriate `converted_microlessons/` directories
- Update consolidated manifests to reference new lessons

**For New Courses:**
- Create directly in self-contained structure (Phase 2)
- Start fresh with `db/seeds/courses/` directory
- Gradually migrate old courses as they're updated

---

## Workflows

### 1. Adding a New Lesson to Existing Consolidated Course

**Example: Add new Kubernetes lesson**

```bash
# 1. Create lesson file in original location
cat > db/seeds/converted_microlessons/kubernetes-fundamentals/microlessons/k8s-secrets.yml <<EOF
slug: k8s-secrets
title: Kubernetes Secrets Management
difficulty: intermediate
sequence_order: 25
estimated_minutes: 20
key_concepts:
  - Secrets
  - ConfigMaps
  - Environment variables
content_md: |
  # Kubernetes Secrets

  Learn to manage sensitive data in Kubernetes...

exercises:
  - type: mcq
    sequence_order: 1
    question: "What is a Kubernetes Secret?"
    # ...
EOF

# 2. Update consolidated manifest
# Edit: db/seeds/consolidated_courses/kubernetes-complete/manifest.yml
# Add 'k8s-secrets' to appropriate module's lessons array

# 3. Commit
git add db/seeds/converted_microlessons/kubernetes-fundamentals/microlessons/k8s-secrets.yml
git add db/seeds/consolidated_courses/kubernetes-complete/manifest.yml
git commit -m "feat(kubernetes): add Kubernetes Secrets lesson"
```

### 2. Creating a New Consolidated Course

**Option A: Reference-Based (Current Standard)**

```bash
# 1. Create lesson files in converted_microlessons/
mkdir -p db/seeds/converted_microlessons/python-fundamentals/microlessons

# 2. Add lessons
cat > db/seeds/converted_microlessons/python-fundamentals/microlessons/python-basics.yml <<EOF
slug: python-basics
title: Python Basics
# ...
EOF

# 3. Create consolidated manifest
mkdir -p db/seeds/consolidated_courses/python-fundamentals
cat > db/seeds/consolidated_courses/python-fundamentals/manifest.yml <<EOF
---
course:
  slug: python-fundamentals
  title: Python Fundamentals
  description: Learn Python programming from basics to OOP
  estimated_hours: 12
  level: beginner
  prerequisites:
    - Basic programming concepts
  learning_outcomes:
    - Write Python programs
    - Understand Python syntax
  tags:
    - python
    - programming
    - beginner
  related_courses:
    - go-fundamentals
  recommended_next: python-advanced

modules:
  - slug: python-basics
    title: Python Basics
    description: Variables, data types, control flow
    order: 1
    estimated_hours: 3
    lessons:
      - python-basics
      - python-data-types
      - python-control-flow
EOF

# 4. Commit
git add db/seeds/converted_microlessons/python-fundamentals/
git add db/seeds/consolidated_courses/python-fundamentals/
git commit -m "feat(python): add Python Fundamentals course"
```

**Option B: Self-Contained (Recommended for New Courses)**

```bash
# 1. Create self-contained course structure
mkdir -p db/seeds/courses/python-fundamentals/microlessons

# 2. Create manifest
cat > db/seeds/courses/python-fundamentals/manifest.yml <<EOF
---
course:
  slug: python-fundamentals
  title: Python Fundamentals
  # ... (same as above)

modules:
  - slug: python-basics
    # ...
    lessons:
      - python-basics
EOF

# 3. Create lessons in course directory
cat > db/seeds/courses/python-fundamentals/microlessons/python-basics.yml <<EOF
slug: python-basics
title: Python Basics
# ...
EOF

# 4. Commit
git add db/seeds/courses/python-fundamentals/
git commit -m "feat(python): add Python Fundamentals course (self-contained)"
```

### 3. Modifying an Existing Lesson

```bash
# 1. Find lesson file
find db/seeds/converted_microlessons -name "git-branching-strategies.yml"

# 2. Edit the file
vim db/seeds/converted_microlessons/git-fundamentals/microlessons/git-branching-strategies.yml

# 3. Commit (no manifest changes needed if just updating content)
git add db/seeds/converted_microlessons/git-fundamentals/microlessons/git-branching-strategies.yml
git commit -m "fix(git): clarify rebase explanation in branching lesson"
```

### 4. Reorganizing a Consolidated Course

```bash
# Example: Split large module into two modules

# 1. Edit consolidated manifest
vim db/seeds/consolidated_courses/kubernetes-complete/manifest.yml

# 2. Reorganize modules:
# OLD:
#   - slug: kubernetes-fundamentals
#     lessons: [pod-basics, deployments, services, volumes, configmaps, secrets]
#
# NEW:
#   - slug: kubernetes-fundamentals
#     lessons: [pod-basics, deployments, services]
#   - slug: kubernetes-configuration
#     lessons: [volumes, configmaps, secrets]

# 3. Commit
git add db/seeds/consolidated_courses/kubernetes-complete/manifest.yml
git commit -m "refactor(kubernetes): split fundamentals module into two"
```

---

## Migration Strategy: Cleaning Up Old Structure

### Recommended Approach: Gradual Migration

**Timeline: 3-6 months**

#### Phase 1: Preparation (Week 1-2)

1. **Audit unconsolidated courses**
   ```bash
   # List courses not yet consolidated
   # Create: scripts/list_unconsolidated_courses.rb
   ```

2. **Document ownership**
   - Identify which lessons belong to which consolidated courses
   - Create mapping file

3. **Backup everything**
   ```bash
   git tag backup-pre-migration-$(date +%Y%m%d)
   git push origin --tags
   ```

#### Phase 2: Create Migration Script (Week 3-4)

```ruby
#!/usr/bin/env ruby
# scripts/migrate_course_to_self_contained.rb

require 'yaml'
require 'fileutils'

# Usage: ruby scripts/migrate_course_to_self_contained.rb devops-essentials

course_slug = ARGV[0]
raise "Usage: #{$0} <course-slug>" unless course_slug

# Read consolidated manifest
manifest_path = "db/seeds/consolidated_courses/#{course_slug}/manifest.yml"
manifest = YAML.load_file(manifest_path)

# Create new structure
new_course_dir = "db/seeds/courses/#{course_slug}"
FileUtils.mkdir_p("#{new_course_dir}/microlessons")

# Copy manifest
FileUtils.cp(manifest_path, "#{new_course_dir}/manifest.yml")

# Find and copy all lesson files
manifest['modules'].each do |mod|
  mod['lessons'].each do |lesson_slug|
    # Search for lesson file in converted_microlessons
    lesson_files = Dir.glob("db/seeds/converted_microlessons/*/microlessons/#{lesson_slug}.yml")

    if lesson_files.empty?
      puts "⚠️  Lesson not found: #{lesson_slug}"
      next
    end

    lesson_file = lesson_files.first
    dest = "#{new_course_dir}/microlessons/#{lesson_slug}.yml"

    FileUtils.cp(lesson_file, dest)
    puts "✓ Copied #{lesson_slug}.yml"
  end
end

puts "\n✓ Migration complete for #{course_slug}"
puts "  New location: #{new_course_dir}"
puts "\nNext steps:"
puts "1. Review migrated course"
puts "2. Test manifest references"
puts "3. Commit: git add #{new_course_dir} && git commit"
```

#### Phase 3: Migrate Course by Course (Week 5-12)

**Priority Order:**
1. Start with newest/cleanest courses (Git, Docker, Kubernetes)
2. Then chemistry courses
3. Then Linux/DevOps
4. Finally remaining unconsolidated courses

**Per-Course Migration:**
```bash
# 1. Run migration script
ruby scripts/migrate_course_to_self_contained.rb devops-essentials

# 2. Review
ls -la db/seeds/courses/devops-essentials/microlessons/

# 3. Test (update course loader to check new location first)
ruby scripts/validate_course.rb devops-essentials

# 4. Commit
git add db/seeds/courses/devops-essentials
git commit -m "migrate(devops): move to self-contained structure"

# 5. Update course loader
# (keep backward compatibility for now)

# 6. Deploy and test

# 7. After successful deployment, mark old files as deprecated
echo "DEPRECATED: Moved to db/seeds/courses/devops-essentials" > \
  db/seeds/consolidated_courses/devops-essentials/DEPRECATED.txt
```

#### Phase 4: Update Course Loader (Week 13-14)

```ruby
# app/services/course_loader.rb

class CourseLoader
  # Load course from new structure (preferred)
  # Fall back to old structure for backward compatibility

  def self.load_course(slug)
    # Try new structure first
    new_path = Rails.root.join('db/seeds/courses', slug, 'manifest.yml')
    return load_from_path(new_path) if File.exist?(new_path)

    # Fall back to consolidated_courses
    old_path = Rails.root.join('db/seeds/consolidated_courses', slug, 'manifest.yml')
    return load_from_path(old_path) if File.exist?(old_path)

    raise "Course not found: #{slug}"
  end

  def self.load_lesson(course_slug, lesson_slug)
    # Try new structure first (lessons in course directory)
    new_path = Rails.root.join('db/seeds/courses', course_slug, 'microlessons', "#{lesson_slug}.yml")
    return load_from_path(new_path) if File.exist?(new_path)

    # Fall back to old structure (lessons in converted_microlessons)
    pattern = Rails.root.join('db/seeds/converted_microlessons', '*', 'microlessons', "#{lesson_slug}.yml")
    matches = Dir.glob(pattern)
    return load_from_path(matches.first) if matches.any?

    raise "Lesson not found: #{lesson_slug}"
  end
end
```

#### Phase 5: Deprecate Old Structure (Week 15-16)

```bash
# 1. After all courses migrated, rename old directory
mv db/seeds/converted_microlessons db/seeds/DEPRECATED_converted_microlessons

# 2. Add deprecation notice
cat > db/seeds/DEPRECATED_converted_microlessons/README.md <<EOF
# DEPRECATED

This directory structure has been deprecated as of $(date +%Y-%m-%d).

All courses have been migrated to the new self-contained structure:
- db/seeds/courses/

Do not add new content here.

This directory will be removed in 3 months ($(date -d "+3 months" +%Y-%m-%d)).
EOF

# 3. Update .gitignore to warn
echo "" >> .gitignore
echo "# Deprecated - do not add files here" >> .gitignore
echo "db/seeds/DEPRECATED_converted_microlessons/" >> .gitignore

# 4. Commit
git add .
git commit -m "chore: deprecate old microlessons structure"
```

#### Phase 6: Final Cleanup (Month 4-6)

After 3 months of the new structure working:

```bash
# 1. Verify no code references old structure
grep -r "converted_microlessons" app/ lib/ config/

# 2. Remove deprecated directories
rm -rf db/seeds/DEPRECATED_converted_microlessons/
rm -rf db/seeds/consolidated_courses/

# 3. Commit
git add .
git commit -m "chore: remove deprecated course structures"

# 4. Update documentation
# Remove all references to old structure
```

---

## Course Manifest Schema (New Standard)

```yaml
---
course:
  slug: course-slug-name                    # Unique identifier
  title: Course Display Title               # User-facing name
  description: Brief course description     # 1-2 sentences
  estimated_hours: 10                       # Total course duration
  level: beginner|intermediate|advanced     # Difficulty

  # Optional metadata
  exam_prep:                                # For exam-focused courses
    - JEE Advanced
    - AWS Certified Solutions Architect
  certification_prep:                       # For certification courses
    - CKA
    - CKAD

  prerequisites:                            # What students need first
    - Basic programming
    - Course: linux-shell-fundamentals

  learning_outcomes:                        # What students will learn
    - Build Docker containers
    - Deploy to production

  tags:                                     # For search/filtering
    - docker
    - devops
    - containers

  related_courses:                          # Cross-references
    - kubernetes-complete
    - aws-cloud-fundamentals

  recommended_next: kubernetes-complete     # Learning path

modules:
  - slug: module-identifier
    title: Module Display Name
    description: What this module covers
    order: 1                                # Display order
    estimated_hours: 3

    lessons:                                # Lesson slugs
      - lesson-1
      - lesson-2
      - lesson-3

    # Optional
    prerequisites:
      - Previous module slug
    learning_outcomes:
      - Specific outcomes for this module
```

---

## Validation Scripts

### 1. Validate Course Manifest

```ruby
#!/usr/bin/env ruby
# scripts/validate_course.rb

require 'yaml'

course_slug = ARGV[0]
raise "Usage: #{$0} <course-slug>" unless course_slug

# Load manifest
manifest_path = "db/seeds/courses/#{course_slug}/manifest.yml"
manifest = YAML.load_file(manifest_path)

errors = []

# Validate course metadata
course = manifest['course']
errors << "Missing course.slug" unless course['slug']
errors << "Missing course.title" unless course['title']
errors << "Missing course.estimated_hours" unless course['estimated_hours']

# Validate modules
manifest['modules'].each do |mod|
  errors << "Module missing slug: #{mod}" unless mod['slug']
  errors << "Module missing lessons: #{mod['slug']}" unless mod['lessons']

  # Validate lessons exist
  mod['lessons'].each do |lesson_slug|
    lesson_path = "db/seeds/courses/#{course_slug}/microlessons/#{lesson_slug}.yml"
    unless File.exist?(lesson_path)
      errors << "Lesson file not found: #{lesson_slug} (#{lesson_path})"
    end
  end
end

if errors.any?
  puts "❌ Validation failed for #{course_slug}:"
  errors.each { |e| puts "  - #{e}" }
  exit 1
else
  puts "✓ Course #{course_slug} is valid"
end
```

### 2. Find Orphaned Lessons

```ruby
#!/usr/bin/env ruby
# scripts/find_orphaned_lessons.rb

require 'yaml'

# Find all lesson files
all_lessons = Dir.glob("db/seeds/courses/*/microlessons/*.yml").map do |path|
  File.basename(path, '.yml')
end.to_set

# Find all referenced lessons
referenced_lessons = Set.new
Dir.glob("db/seeds/courses/*/manifest.yml").each do |manifest_path|
  manifest = YAML.load_file(manifest_path)
  manifest['modules'].each do |mod|
    mod['lessons'].each { |slug| referenced_lessons << slug }
  end
end

# Find orphans
orphaned = all_lessons - referenced_lessons

if orphaned.any?
  puts "⚠️  Found #{orphaned.size} orphaned lessons:"
  orphaned.each { |slug| puts "  - #{slug}" }
else
  puts "✓ No orphaned lessons found"
end
```

---

## Recommendations

### Immediate Actions (This Week)

1. **Adopt hybrid approach**
   - Keep current consolidated courses in reference-based structure
   - Create new courses in self-contained structure (`db/seeds/courses/`)

2. **Create validation scripts**
   - Implement `scripts/validate_course.rb`
   - Run in CI/CD pipeline

3. **Document workflow**
   - Add this document to repository
   - Share with team

### Short-term (Next Month)

1. **Create migration script**
   - Implement `scripts/migrate_course_to_self_contained.rb`
   - Test on one course

2. **Migrate 1-2 courses**
   - Start with Git Fundamentals or Docker
   - Validate everything works

3. **Update course loader**
   - Add fallback logic for backward compatibility

### Medium-term (3-6 Months)

1. **Migrate all consolidated courses**
   - One course per week
   - Thorough testing after each migration

2. **Deprecate old structure**
   - Rename directories with DEPRECATED prefix
   - Add warnings

3. **Clean up**
   - Remove deprecated directories after 3 months

### Long-term (6+ Months)

1. **New structure is standard**
   - All courses in `db/seeds/courses/`
   - Old structure removed

2. **Consolidate remaining courses**
   - 102 original courses → target 15-20 final courses
   - Continue consolidation initiative

---

## FAQ

### Q: Can I still add lessons to the old structure?

**A:** Yes, during the transition period. Add lessons to `converted_microlessons/` and reference them in consolidated manifests. But for new courses, use the self-contained structure in `db/seeds/courses/`.

### Q: What if a lesson is shared across multiple courses?

**A:** Two options:
1. **Duplicate the lesson** (preferred) - Each course is self-contained
2. **Shared lessons directory** - Create `db/seeds/courses/shared/microlessons/` for truly shared content

### Q: How do I know which structure a course uses?

**A:** Check the manifest location:
- `db/seeds/consolidated_courses/<slug>/manifest.yml` = Reference-based (Phase 1)
- `db/seeds/courses/<slug>/manifest.yml` = Self-contained (Phase 2)

### Q: What about unconsolidated courses (the other 93)?

**A:** Three options:
1. **Consolidate** - Group related courses (recommended)
2. **Standalone** - Keep as individual course if it makes sense
3. **Deprecate** - Remove if outdated or low quality

### Q: Do I need to update database seeds?

**A:** Yes. Update `db/seeds.rb` or create new `db/seeds/courses_loader.rb` to:
1. Read manifests from appropriate location
2. Load lesson files from appropriate location
3. Create Course, Module, and Lesson records in database

---

## Summary

**Current State:**
- ✅ 9 consolidated courses with manifests
- ✅ Lessons in original locations (reference-based)
- ✅ Both structures coexist

**Recommended Path Forward:**
1. **New courses** → Self-contained structure (`db/seeds/courses/`)
2. **Existing courses** → Keep as-is, gradually migrate
3. **3-6 month transition** → All courses migrated
4. **Old structure** → Deprecated, then removed

**Key Principle:** Maintain backward compatibility during transition, but move toward clean, self-contained course structure.
