# Enhance Chapter 15: FROM and RUN

puts "Enhancing Chapter 15: FROM and RUN..."

unit = InteractiveLearningUnit.find_by!(slug: "codesprout-dockerfile-from-run")

# Build the concept explanation as a regular string
concept_text = <<-'MARKDOWN'
**Dockerfile FROM and RUN Instructions** 🏗️

Every Dockerfile starts with `FROM` and typically uses `RUN` to execute commands. These are the foundation of custom image building.

### The FROM Instruction

**FROM** specifies the base image to build upon.

**Syntax:**
```dockerfile
FROM <image>[:<tag>] [AS <name>]
```

**Examples:**
```dockerfile
FROM ubuntu:22.04
FROM python:3.11-alpine
FROM node:18 AS builder
```

**Key Points:**
- Must be the **first instruction** (except ARG)
- Sets the base layer for your image
- Choose based on what you need pre-installed

### Choosing a Base Image

**Option 1: Minimal (Alpine)**
```dockerfile
FROM alpine:3.18    # ~5MB
```
✅ Smallest size
❌ Uses musl libc (compatibility issues possible)

**Option 2: Slim Variants**
```dockerfile
FROM python:3.11-slim    # ~120MB
```
✅ Smaller than full image
✅ Good compatibility

**Option 3: Full Images**
```dockerfile
FROM ubuntu:22.04    # ~77MB base
```
✅ Everything included
❌ Larger size

### The RUN Instruction

**RUN** executes commands during the build process.

**Two forms:**

**1. Shell form:**
```dockerfile
RUN apt-get update && apt-get install -y curl
```

**2. Exec form:**
```dockerfile
RUN ["apt-get", "install", "-y", "curl"]
```

### RUN Best Practices

**❌ BAD - Multiple layers:**
```dockerfile
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y wget
RUN rm -rf /var/lib/apt/lists/*
```

**✅ GOOD - Single layer:**
```dockerfile
RUN apt-get update \
    && apt-get install -y \
        curl \
        wget \
    && rm -rf /var/lib/apt/lists/*
```

### Layer Caching (Critical!)

Each `RUN` creates a layer. Docker caches layers:

```dockerfile
FROM python:3.11-slim
RUN apt-get update        # Layer 1 (cached)
RUN pip install django    # Layer 2 (cached)
COPY app.py /app/         # Layer 3 (rebuilds if app.py changes)
```

### DCA Exam Focus

**You must know:**
1. FROM must be first instruction
2. Combining RUN commands reduces layers
3. Shell form vs exec form differences
4. Cleaning up in same RUN layer
5. --no-cache flags to reduce image size

### Try it!

Create a Dockerfile:
```dockerfile
FROM alpine:3.18
RUN apk add --no-cache curl
RUN curl --version
```

Build it:
```bash
docker build -t test-from-run .
```
MARKDOWN

unit.update!(
  concept_explanation: concept_text,
  command_to_learn: "FROM, RUN",
  command_variations: ["FROM image:tag", "RUN command", "RUN [\"cmd\", \"arg\"]"],
  practice_hints: [
    "FROM must be the first instruction",
    "Combine multiple RUN commands with && to reduce layers",
    "Clean up in the same RUN command",
    "Use --no-cache flags to reduce image size"
  ]
)

puts "✅ Chapter 15 enhanced successfully!"
