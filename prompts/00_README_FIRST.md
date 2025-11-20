# ⚠️ IMPORTANT: Read This First!

## Which File Should You Use?

### ✅ Use Course-Specific Prompts (01-45)

**These are ready to use right now:**

```
devops/
  01_docker_course_prompt.txt           ✓ Ready
  02_kubernetes_course_prompt.txt       ✓ Ready
  03_linux_course_prompt.txt            ✓ Ready
  ...

programming/
  11_python_prompt.txt                  ✓ Ready
  12_golang_prompt.txt                  ✓ Ready
  13_javascript_node.js_prompt.txt      ✓ Ready
  ...

(All 45 course prompts are ready to use)
```

### 🚫 DO NOT Use These Files Directly

**These are TEMPLATES and DOCUMENTATION:**

- `UNIVERSAL_TEMPLATE.txt` - Template with placeholders ❌
- `README.md` - Documentation
- `QUICK_START.md` - Guide
- `MASTER_COURSE_INDEX.md` - Reference
- `SEED_FILE_FORMATS.md` - Technical guide
- `FORMAT_FIX_SUMMARY.md` - Technical notes

**Why?** Template files contain placeholders like `[file1.rb]` which will cause errors:
```
❌ "Missing seed file [file1.rb]"
❌ "Missing seed file [file2.rb]"
```

## How to Use a Course Prompt

### Step 1: Choose Your Course
Look in the appropriate directory:
- DevOps courses → `devops/`
- Programming → `programming/`
- IIT JEE → `iit_jee/`
- Software Engineering → `software_engineering/`
- Data Science → `data_science/`
- Interview Prep → `interview_prep/`
- Other → `other/`

### Step 2: Open the Prompt File
Example: `programming/11_python_prompt.txt`

You'll see:
```
=======================================
MICROLESSON GENERATOR - PYTHON PROGRAMMING
=======================================

STEP 1: ATTACH THESE FILES
□ python_course.rb
□ python_course_enhanced.rb
□ python_advanced_course.rb
□ python_code_labs.rb

STEP 2: PASTE THIS PROMPT
[Full prompt text...]
```

### Step 3: Follow the Instructions
1. Attach the seed files listed in STEP 1
2. Copy the prompt from STEP 2
3. Paste into GPT-5 Pro
4. Generate microlessons

## Common Errors & Fixes

### Error: "Missing seed file [file1.rb]"
**Cause:** You used `UNIVERSAL_TEMPLATE.txt` directly
**Fix:** Use a course-specific prompt (01-45) instead

### Error: "Files without InteractiveLearningUnit blocks"
**Cause:** Seed file uses Course/Lesson format, not InteractiveLearningUnit
**Fix:** This is now handled automatically. The prompts have been updated to process both formats.

### Error: "Skips missing seed files"
**Cause:** Seed file names in prompt don't exist in db/seeds/
**Fix:**
1. Check actual file names in `idlecampus/backend/db/seeds/`
2. Verify they match what's listed in the prompt
3. Update prompt if file names have changed

## Quick Reference

**Total Prompts:** 45
**All Complete:** ✅
**All Ready to Use:** ✅

**Need Help?** Check:
- `README.md` - Full usage guide
- `QUICK_START.md` - Fast start guide
- `MASTER_COURSE_INDEX.md` - All 45 courses listed
