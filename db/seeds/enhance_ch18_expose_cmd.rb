# Enhance Chapter 18: EXPOSE and CMD

puts "Enhancing Chapter 18: EXPOSE and CMD..."

unit = InteractiveLearningUnit.find_by!(slug: "codesprout-dockerfile-expose-cmd")

concept_text = <<-'MARKDOWN'
**Dockerfile EXPOSE and CMD Instructions** 🚢

EXPOSE documents ports, CMD sets the default command. Critical for the DCA exam!

### The EXPOSE Instruction

**EXPOSE** documents which ports the container listens on - it does NOT actually publish them!

**Syntax:**
```dockerfile
EXPOSE <port> [<port>/<protocol>...]
```

**Examples:**
```dockerfile
FROM nginx:alpine

# Document that nginx listens on port 80
EXPOSE 80

# Multiple ports
EXPOSE 80 443

# Specify protocol
EXPOSE 8080/tcp
EXPOSE 53/udp
```

**Critical DCA Concept:**
```dockerfile
EXPOSE 80  # This is DOCUMENTATION ONLY!
```

**To actually publish ports:**
```bash
docker run -p 8080:80 myapp
# Maps host port 8080 to container port 80
```

### Why Use EXPOSE?

**1. Documentation:**
- Tells users which ports the app uses
- Self-documenting Dockerfile

**2. Inter-container communication:**
- Other containers can see exposed ports
- Useful in Docker networks

**3. Random port mapping:**
```bash
docker run -P myapp
# -P (capital P) publishes ALL exposed ports to random host ports
```

### The CMD Instruction

**CMD** sets the default command to run when the container starts.

**Three forms:**

**1. Exec form (PREFERRED):**
```dockerfile
CMD ["executable", "param1", "param2"]
CMD ["nginx", "-g", "daemon off;"]
```

**2. Shell form:**
```dockerfile
CMD command param1 param2
CMD nginx -g daemon off;
```

**3. As default params to ENTRYPOINT:**
```dockerfile
ENTRYPOINT ["python", "app.py"]
CMD ["--port", "8000"]
```

### Exec Form vs Shell Form

**❌ Shell form:**
```dockerfile
CMD python app.py
```
- Runs as `/bin/sh -c "python app.py"`
- Creates unnecessary shell process (PID 1 is shell, not your app)
- Signal handling issues (SIGTERM goes to shell, not app)

**✅ Exec form:**
```dockerfile
CMD ["python", "app.py"]
```
- Runs directly as executable
- Your app is PID 1
- Proper signal handling
- **DCA exam: Always prefer exec form!**

### Only ONE CMD

**❌ Multiple CMDs (only last one counts):**
```dockerfile
FROM python:3.11-slim
CMD ["python", "test.py"]
CMD ["python", "app.py"]      # ← Only this one executes!
CMD ["python", "other.py"]    # ← This is ignored!
```

**✅ One CMD:**
```dockerfile
FROM python:3.11-slim
CMD ["python", "app.py"]
```

### CMD Can Be Overridden

**Dockerfile:**
```dockerfile
FROM alpine:3.18
CMD ["echo", "Hello from Dockerfile"]
```

**Running:**
```bash
# Uses CMD from Dockerfile
docker run myapp
# Output: Hello from Dockerfile

# Override CMD
docker run myapp echo "Different message"
# Output: Different message

# Override with shell
docker run myapp sh -c "echo Custom && ls"
```

### Common Patterns

**Pattern 1: Web server**
```dockerfile
FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY html/ /usr/share/nginx/html/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

**Pattern 2: Python Flask app**
```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .

EXPOSE 5000
CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]
```

**Pattern 3: Node.js app**
```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .

EXPOSE 3000
CMD ["node", "server.js"]
```

### CMD vs ENTRYPOINT

**CMD alone:**
```dockerfile
CMD ["python", "app.py"]
```
- Easily overridden
- Use for default command

**ENTRYPOINT + CMD:**
```dockerfile
ENTRYPOINT ["python", "app.py"]
CMD ["--port", "8000"]
```
- ENTRYPOINT is the main command
- CMD provides default arguments
- Running `docker run myapp --port 9000` overrides CMD only

### DCA Exam Focus

**You must know:**
1. **EXPOSE is documentation** - doesn't publish ports
2. **Use -p to actually publish** ports
3. **Exec form preferred** over shell form
4. **Only last CMD counts** if multiple defined
5. **CMD can be overridden** at runtime
6. **-P publishes all exposed ports** to random host ports

### Common Mistakes

**Mistake 1: Thinking EXPOSE publishes ports**
```dockerfile
FROM nginx:alpine
EXPOSE 80  # This does NOT publish the port!
```
**Fix:** Use `docker run -p 80:80` to publish

**Mistake 2: Using shell form**
```dockerfile
CMD python app.py  # ❌ Shell wrapper
```
**Fix:** `CMD ["python", "app.py"]`

**Mistake 3: Multiple CMDs**
```dockerfile
CMD ["service", "nginx", "start"]
CMD ["python", "app.py"]  # Only this runs!
```
**Fix:** Use one CMD or combine in a script

### Testing EXPOSE and CMD

**Dockerfile:**
```dockerfile
FROM python:3.11-slim

WORKDIR /app

# Create simple web server
RUN echo 'from http.server import HTTPServer, SimpleHTTPRequestHandler\nHTTPServer(("0.0.0.0", 8000), SimpleHTTPRequestHandler).serve_forever()' > server.py

EXPOSE 8000
CMD ["python", "server.py"]
```

**Build and test:**
```bash
# Build
docker build -t test-expose-cmd .

# Run with -P (random port)
docker run -d -P --name test1 test-expose-cmd
docker port test1  # See random port mapping

# Run with -p (specific port)
docker run -d -p 8080:8000 --name test2 test-expose-cmd
curl localhost:8080  # Should work

# Override CMD
docker run test-expose-cmd python -c "print('Overridden!')"
```

### Real-World Example

**Multi-service Dockerfile:**
```dockerfile
FROM node:18-alpine

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm ci --only=production

# Copy application
COPY . .

# Document all ports used
EXPOSE 3000       # Main web server
EXPOSE 3001       # Admin panel
EXPOSE 9090       # Metrics endpoint

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
  CMD node healthcheck.js || exit 1

# Default command
CMD ["node", "server.js"]
```

**Running:**
```bash
# Production
docker run -p 80:3000 -p 8080:3001 myapp

# Development (override CMD)
docker run -p 3000:3000 myapp npm run dev
```

### Try it!

Create this Dockerfile:
```dockerfile
FROM alpine:3.18
EXPOSE 8080
CMD ["sh", "-c", "echo 'Server starting on port 8080' && sleep infinity"]
```

**Test EXPOSE:**
```bash
docker build -t expose-test .

# -P maps EXPOSE ports to random host ports
docker run -d -P --name test expose-test
docker port test

# Check what port was assigned
docker ps
```

**Test CMD override:**
```bash
docker run expose-test echo "I overrode the CMD!"
```
MARKDOWN

unit.update!(
  concept_explanation: concept_text,
  command_to_learn: "EXPOSE, CMD",
  command_variations: ["EXPOSE 80", "CMD [\"cmd\", \"arg\"]", "CMD command arg"],
  practice_hints: [
    "EXPOSE is documentation only - use -p to publish ports",
    "Prefer exec form CMD over shell form",
    "Only the last CMD in a Dockerfile is used",
    "CMD can be overridden at runtime with docker run arguments"
  ]
)

puts "✅ Chapter 18 enhanced successfully!"
