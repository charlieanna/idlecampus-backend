# Quick Start Guide - Microlesson Generation

## ✅ What's Been Created

```
Upscexamadaptivelearning/prompts/
├── README.md                           # Complete usage guide
├── QUICK_START.md                      # This file
├── MASTER_COURSE_INDEX.md              # All 45 courses listed
├── UNIVERSAL_TEMPLATE.txt              # Works for any course
│
├── devops/
│   ├── 01_docker_course_prompt.txt     # ✅ 9 modules
│   ├── 02_kubernetes_course_prompt.txt # ✅ 4 files
│   └── 03_linux_course_prompt.txt      # ✅ 1 file
│
└── [programming, iit_jee, software_engineering, etc.]
    └── Use UNIVERSAL_TEMPLATE.txt for these
```

## 🚀 Generate Microlessons for Docker (Right Now!)

**Most complete course - Start here:**

```bash
# 1. Copy the Docker prompt
cat prompts/devops/01_docker_course_prompt.txt | pbcopy

# 2. Open GPT-5 Pro (or Claude)

# 3. Paste the prompt

# 4. Attach these 9 files from idlecampus/backend/db/seeds/:
#    □ docker_containers_units.rb
#    □ docker_images_units.rb
#    □ docker_volumes_units.rb
#    □ docker_networks_units.rb
#    □ docker_compose_units.rb
#    □ docker_security_units.rb
#    □ docker_registry_units.rb
#    □ docker_swarm_units.rb
#    □ docker_basics_units.rb

# 5. Send

# 6. GPT generates 9 complete microlesson files!
```

**What you'll get:**
- ~60-70 microlessons
- ~120-140 exercises
- All with progressive hints
- Prerequisites linked
- Ready to use

## 🔬 Generate IIT JEE Chemistry (Second Example)

**For courses not in devops/ folder:**

```bash
# 1. Look up course #20 in MASTER_COURSE_INDEX.md
#    IIT JEE - Inorganic Chemistry
#    Files: [9 files listed]

# 2. Copy UNIVERSAL_TEMPLATE.txt

# 3. Edit top section:
#    COURSE NAME: "IIT JEE - Inorganic Chemistry"
#    FILES TO ATTACH:
#    □ iit_jee/iit_jee_inorganic_chemistry.rb
#    □ inorganic/inorganic_interactive_units.rb
#    □ [... 7 more files]

# 4. Paste into GPT-5 Pro

# 5. Attach all 9 files

# 6. Send

# 7. Save generated outputs
```

## 📊 All 45 Courses Available

| Category | Count | Status |
|----------|-------|--------|
| DevOps | 10 | 3 ready, 7 use template |
| Programming | 9 | Use template |
| IIT JEE | 7 subjects | Use template |
| Software Engineering | 12 | Use template |
| Data Science | 2 | Use template |
| Interview Prep | 2 | Use template |
| **Total** | **45** | **3 ready + 42 template** |

See `MASTER_COURSE_INDEX.md` for complete list with file names.

## 💡 How It Works

1. **You**: Copy prompt + attach seed files → GPT-5 Pro
2. **AI**: Reads files → Splits into microlessons → Generates exercises
3. **You**: Save outputs as Ruby seed files
4. **Rails**: Run seed files → Database populated

## 🎯 What AI Generates

```ruby
# Very small microlessons (1 concept, 2-3 min)
lesson_1 = MicroLesson.create!(
  title: 'Docker Run Basics',
  content: <<~MARKDOWN,
    # Docker Run Basics 🚀
    [Clear explanation + examples + key points]
  MARKDOWN
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: ['docker run'],
  prerequisite_ids: []
)

# Multiple exercises per lesson
Exercise.create!(
  exercise_type: 'terminal',
  exercise_data: {
    command: 'docker run hello-world',
    hints: [
      'Use docker command',
      'Add run and image name',
      'docker run hello-world'
    ]
  }
)
```

## 🔥 Pro Tips

### Start with Docker
- Most comprehensive (9 modules)
- Prompt already created
- Great example to learn from

### Then do IIT JEE Chemistry
- Important for your use case
- Multiple modules
- Good practice with template

### Batch process
- Do 3-4 courses in one GPT session
- Copy-paste outputs efficiently
- Review later

### Save everything
- Keep AI outputs
- Easy to regenerate if needed
- Iterate and improve

## 📁 Where to Save Outputs

```bash
# Save generated files to:
idlecampus/backend/db/seeds/microlessons/

# Example:
docker_containers_microlessons.rb
docker_images_microlessons.rb
...
iit_jee_inorganic_chemistry_microlessons.rb
...
```

## ⚡ Need Help?

1. **Full guide**: See `README.md`
2. **Course list**: See `MASTER_COURSE_INDEX.md`
3. **Template**: See `UNIVERSAL_TEMPLATE.txt`
4. **Examples**: See `devops/01_docker_course_prompt.txt`

---

**Ready? Start with Docker prompt in `devops/01_docker_course_prompt.txt`! 🚀**
