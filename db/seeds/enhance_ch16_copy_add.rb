# Enhance Chapter 16: COPY and ADD

puts "Enhancing Chapter 16: COPY and ADD..."

unit = InteractiveLearningUnit.find_by!(slug: "codesprout-dockerfile-copy-add")

concept_text = <<-'MARKDOWN'
**Dockerfile COPY and ADD Instructions** 📁

COPY and ADD transfer files from your build context into the Docker image. Knowing the difference is crucial for the DCA exam!

### The COPY Instruction

**COPY** copies files/directories from build context to the image.

**Syntax:**
```dockerfile
COPY [--chown=<user>:<group>] <src>... <dest>
```

**Examples:**
```dockerfile
COPY app.py /app/
COPY ./src /app/src
COPY file1.txt file2.txt /app/
COPY --chown=www-data:www-data index.html /var/www/html/
```

### The ADD Instruction

**ADD** is like COPY but with superpowers (which you often don't want!).

**ADD can do 2 extra things:**

**1. Download files from URLs:**
```dockerfile
ADD https://example.com/file.tar.gz /tmp/
```

**2. Auto-extract tar archives:**
```dockerfile
ADD app.tar.gz /app/
# Automatically extracts to /app/
```

### COPY vs ADD: When to Use What?

**✅ PREFER COPY for clarity:**
```dockerfile
COPY requirements.txt /app/
COPY . /app/
```

**✅ Use ADD only when needed:**
```dockerfile
ADD https://github.com/user/repo/archive/v1.0.tar.gz /tmp/
ADD myapp.tar.gz /opt/myapp/
```

**DCA Exam Tip:** Always prefer COPY unless you specifically need ADD's features!

### Common Patterns

**Pattern 1: Copy application code**
```dockerfile
FROM python:3.11-slim
WORKDIR /app

# Copy requirements first (for caching)
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy code after (changes more often)
COPY . .
```

**Pattern 2: Copy with ownership**
```dockerfile
FROM nginx:alpine
COPY --chown=www-data:www-data ./html /usr/share/nginx/html
```

### Build Context Matters!

Only files in the build context can be copied:

**Project structure:**
```
myproject/
├── Dockerfile
├── app/
│   └── main.py
└── ../other-project/
    └── lib.py  ← CANNOT access this!
```

**In Dockerfile:**
```dockerfile
COPY app/ /app/              # ✅ Works
COPY ../other-project/ /     # ❌ ERROR
```

### Using .dockerignore

Exclude files from build context:

**.dockerignore:**
```
node_modules/
.git/
*.log
.env
__pycache__/
```

**Why this matters:**
- Faster builds
- Smaller images
- Security (don't copy secrets)

### Caching Optimization

**❌ BAD - Breaks cache:**
```dockerfile
COPY . /app/
RUN pip install -r requirements.txt
```

**✅ GOOD - Dependencies cached:**
```dockerfile
COPY requirements.txt /app/
RUN pip install -r requirements.txt
COPY . /app/
```

### DCA Exam Focus

**You must understand:**
1. **COPY is preferred** over ADD
2. **ADD auto-extracts** tar archives
3. **ADD can download** from URLs
4. **Build context** determines what can be copied
5. **.dockerignore** excludes files
6. **Copy order affects caching**

### Common Errors

**"COPY failed: no source files"**
- File doesn't exist in build context
- Check path relative to Dockerfile

**"forbidden path outside the build context"**
- Trying to copy from parent directory
- Solution: Run build from correct directory

### Try it!

Create .dockerignore:
```
secrets.txt
.git/
```

**Dockerfile:**
```dockerfile
FROM python:3.11-slim
COPY . /app/
RUN ls -la /app/
```

Build and notice excluded files!
MARKDOWN

unit.update!(
  concept_explanation: concept_text,
  command_to_learn: "COPY, ADD",
  command_variations: ["COPY src dest", "COPY --chown=user:group", "ADD url dest"],
  practice_hints: [
    "Prefer COPY over ADD for clarity",
    "ADD auto-extracts tar files and can download URLs",
    "Copy dependencies before code for better caching",
    "Use .dockerignore to exclude unnecessary files"
  ]
)

puts "✅ Chapter 16 enhanced successfully!"
