# Enhance Docker Compose Chapters 35-41

puts "=" * 80
puts "Enhancing Docker Compose Chapters 35-41..."
puts "=" * 80

compose_chapters = [
  {
    slug: "codesprout-compose-basics",
    num: 35,
    command: "docker-compose.yml",
    title: "Introduction to Docker Compose",
    content: <<-'MD'
**Introduction to Docker Compose** 🎼

Docker Compose manages multi-container applications - essential for DCA!

### What is Docker Compose?

**Tool for defining and running multi-container Docker applications.**

**Without Compose (tedious):**
```bash
docker network create myapp-network
docker run -d --name db --network myapp-network postgres
docker run -d --name redis --network myapp-network redis
docker run -d --name api --network myapp-network -p 3000:3000 myapi
```

**With Compose (simple):**
```yaml
# docker-compose.yml
services:
  db:
    image: postgres
  redis:
    image: redis
  api:
    image: myapi
    ports:
      - "3000:3000"
```

```bash
docker compose up
# Starts everything!
```

### docker-compose.yml Structure

**Basic structure:**
```yaml
version: "3.8"

services:
  service1:
    image: nginx
  service2:
    image: postgres

networks:
  default:

volumes:
  data:
```

### Real Example

**Web application:**
```yaml
version: "3.8"

services:
  web:
    image: nginx:alpine
    ports:
      - "80:80"
    volumes:
      - ./html:/usr/share/nginx/html
    depends_on:
      - api

  api:
    build: ./api
    environment:
      - DB_HOST=db
    depends_on:
      - db

  db:
    image: postgres:15
    volumes:
      - dbdata:/var/lib/postgresql/data
    environment:
      - POSTGRES_PASSWORD=secret

volumes:
  dbdata:
```

### DCA Exam Focus

Must know:
1. **docker-compose.yml** defines services
2. **services, networks, volumes** sections
3. **docker compose up** starts stack
4. **Automatic network** creation
5. **Service name** = DNS hostname

### Compose Commands

```bash
docker compose up          # Start all services
docker compose up -d       # Start in background
docker compose down        # Stop and remove
docker compose ps          # List services
docker compose logs        # View logs
```

### Try it!

```yaml
# docker-compose.yml
version: "3.8"
services:
  web:
    image: nginx:alpine
    ports:
      - "8080:80"
```

```bash
docker compose up -d
curl localhost:8080
docker compose down
```
    MD
  },
  {
    slug: "codesprout-compose-up-down",
    num: 36,
    command: "docker compose up/down",
    title: "Starting and Stopping Services",
    content: <<-'MD'
**Starting and Stopping Docker Compose Services** ⚡

Master compose lifecycle commands for the DCA exam!

### docker compose up

**Start all services:**
```bash
docker compose up
# Foreground mode (shows logs)

docker compose up -d
# Detached mode (background)
```

**What it does:**
1. Creates network (if needed)
2. Creates volumes (if needed)
3. Builds images (if build: specified)
4. Starts containers in dependency order

**Options:**
```bash
docker compose up -d                # Background
docker compose up --build           # Force rebuild images
docker compose up --no-deps web     # Start web without dependencies
docker compose up --scale api=3     # Scale api to 3 instances
```

### docker compose down

**Stop and remove all:**
```bash
docker compose down
```

**What it removes:**
- ✅ Containers
- ✅ Networks
- ❌ Volumes (by default)
- ❌ Images

**Options:**
```bash
docker compose down -v              # Remove volumes too
docker compose down --rmi all       # Remove images too
docker compose down --remove-orphans # Remove containers for services not in compose file
```

### docker compose stop/start

**Stop without removing:**
```bash
docker compose stop
# Containers stopped but not removed

docker compose start
# Restart stopped containers
```

### docker compose restart

**Restart services:**
```bash
docker compose restart
# Restart all services

docker compose restart api
# Restart specific service
```

### DCA Exam Focus

Must know:
1. **up** creates and starts
2. **down** stops and removes
3. **-d for detached** mode
4. **-v to remove volumes**
5. **stop vs down** difference

### Service Dependencies

**depends_on ensures order:**
```yaml
services:
  web:
    image: nginx
    depends_on:
      - api
  api:
    image: myapi
    depends_on:
      - db
  db:
    image: postgres
```

**Startup order:** db → api → web

### Try it!

```yaml
# docker-compose.yml
version: "3.8"
services:
  web:
    image: nginx:alpine
  db:
    image: postgres:15
    environment:
      - POSTGRES_PASSWORD=secret
```

```bash
# Start
docker compose up -d
docker compose ps

# Stop
docker compose down

# Start and remove volumes
docker compose down -v
```
    MD
  },
  {
    slug: "codesprout-compose-services-networks",
    num: 37,
    command: "services and networks in compose",
    title: "Services and Networks in Compose",
    content: <<-'MD'
**Services and Networks in Docker Compose** 🌐

Multi-service networking is critical for DCA Orchestration!

### Service Definitions

**Service = container specification:**
```yaml
services:
  web:
    image: nginx:alpine
    container_name: my-web
    restart: always
    ports:
      - "80:80"
```

**Service from build:**
```yaml
services:
  api:
    build:
      context: ./api
      dockerfile: Dockerfile
    image: myapi:latest
```

### Automatic Networking

**Compose creates default network automatically:**
```yaml
services:
  web:
    image: nginx
  api:
    image: myapi
# Both on same network!
# web can reach api by name: curl http://api
```

### Custom Networks

**Define multiple networks:**
```yaml
version: "3.8"

services:
  web:
    image: nginx
    networks:
      - frontend
  
  api:
    image: myapi
    networks:
      - frontend
      - backend
  
  db:
    image: postgres
    networks:
      - backend

networks:
  frontend:
  backend:
```

**Result:**
- web → api ✅
- api → db ✅
- web → db ❌ (isolated!)

### Network Configuration

**Specify driver and options:**
```yaml
networks:
  custom:
    driver: bridge
    driver_opts:
      com.docker.network.bridge.name: custom_bridge
    ipam:
      config:
        - subnet: 172.25.0.0/16
```

### Service Discovery

**Services accessible by name:**
```yaml
services:
  web:
    image: nginx
  api:
    image: myapi
    environment:
      - DB_HOST=postgres
  postgres:
    image: postgres:15
```

**Inside api container:**
```bash
ping postgres  # Works!
curl http://web  # Works!
```

### DCA Exam Focus

Must know:
1. **Service name** = hostname
2. **Automatic network** creation
3. **Multiple networks** for isolation
4. **networks:** key in services
5. **External networks** with external: true

### Try it!

```yaml
# docker-compose.yml
version: "3.8"
services:
  web:
    image: nginx:alpine
  test:
    image: alpine
    command: sh -c "ping -c 3 web"

# Run:
docker compose up test
# Shows ping to web works!
```
    MD
  },
  {
    slug: "codesprout-compose-volumes",
    num: 38,
    command: "volumes in compose",
    title: "Volumes in Docker Compose",
    content: <<-'MD'
**Volumes in Docker Compose** 💾

Persistent data in Compose is critical for databases and stateful services!

### Named Volumes

**Define and use:**
```yaml
version: "3.8"

services:
  db:
    image: postgres:15
    volumes:
      - pgdata:/var/lib/postgresql/data

volumes:
  pgdata:
```

**Creates volume automatically on `docker compose up`**

### Bind Mounts

**Mount host directory:**
```yaml
services:
  web:
    image: nginx
    volumes:
      - ./html:/usr/share/nginx/html
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
```

### Volume Syntax

**Short syntax:**
```yaml
volumes:
  - /host/path:/container/path
  - volume-name:/container/path
  - /container/path  # Anonymous volume
```

**Long syntax:**
```yaml
volumes:
  - type: bind
    source: ./html
    target: /usr/share/nginx/html
  - type: volume
    source: data
    target: /data
    volume:
      nocopy: true
```

### Volume Configuration

**Specify driver and options:**
```yaml
volumes:
  dbdata:
    driver: local
    driver_opts:
      type: nfs
      o: addr=192.168.1.100,rw
      device: ":/exported/path"
```

### External Volumes

**Use existing volume:**
```yaml
volumes:
  existing-data:
    external: true
```

**Must exist before `docker compose up`:**
```bash
docker volume create existing-data
docker compose up
```

### DCA Exam Focus

Must know:
1. **volumes:** at top level defines volumes
2. **volumes:** in services uses them
3. **Bind mounts** with ./paths
4. **external: true** for pre-existing volumes
5. **Anonymous vs named** volumes

### Common Patterns

**Development:**
```yaml
services:
  app:
    build: .
    volumes:
      - ./src:/app/src  # Live code reload
      - node_modules:/app/node_modules  # Preserve deps
```

**Production:**
```yaml
services:
  db:
    image: postgres:15
    volumes:
      - pgdata:/var/lib/postgresql/data
      - ./backups:/backups:ro

volumes:
  pgdata:
```

### Try it!

```yaml
# docker-compose.yml
version: "3.8"
services:
  web:
    image: nginx:alpine
    volumes:
      - webdata:/usr/share/nginx/html

volumes:
  webdata:
```

```bash
docker compose up -d
docker compose exec web sh -c "echo '<h1>Test</h1>' > /usr/share/nginx/html/index.html"
curl localhost:80
docker compose down
docker volume ls  # webdata still exists!
docker volume rm webdata
```
    MD
  },
  {
    slug: "codesprout-compose-environment",
    num: 39,
    command: "environment variables in compose",
    title: "Environment Variables in Compose",
    content: <<-'MD'
**Environment Variables in Docker Compose** 🔧

Environment configuration is critical for DCA exam!

### environment: Directive

**Set environment variables:**
```yaml
services:
  api:
    image: myapi
    environment:
      - NODE_ENV=production
      - DB_HOST=postgres
      - DB_PORT=5432
```

**Or dictionary format:**
```yaml
environment:
  NODE_ENV: production
  DB_HOST: postgres
  DB_PORT: 5432
```

### .env File

**Create .env file:**
```bash
# .env
POSTGRES_PASSWORD=secret
API_VERSION=1.0
```

**Use in compose:**
```yaml
services:
  db:
    image: postgres:15
    environment:
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
  api:
    image: myapi:${API_VERSION}
```

**Automatic .env loading:**
```bash
docker compose up
# Reads .env automatically
```

### env_file Directive

**Load from file:**
```yaml
services:
  api:
    image: myapi
    env_file:
      - common.env
      - production.env
```

**common.env:**
```
DB_HOST=postgres
DB_PORT=5432
```

### Variable Substitution

**In compose file:**
```yaml
services:
  web:
    image: nginx:${NGINX_VERSION:-alpine}
    # Uses $NGINX_VERSION or "alpine" default
    ports:
      - "${WEB_PORT:-80}:80"
```

### DCA Exam Focus

Must know:
1. **environment:** sets variables
2. **.env file** loaded automatically
3. **${VAR}** syntax for substitution
4. **${VAR:-default}** for defaults
5. **env_file:** loads from file

### Security Best Practices

**✅ DO:**
```yaml
# Don't commit .env
# .gitignore:
.env
*.env

# Use .env.example as template
# .env.example:
POSTGRES_PASSWORD=changeme
API_KEY=your-api-key-here
```

**❌ DON'T:**
```yaml
# Don't hardcode secrets
environment:
  - API_KEY=sk_live_abc123  # ❌ Exposed in repo!
```

### Environment Priority

**1. Compose file**
**2. Environment**
**3. .env file**
**4. Dockerfile ENV**

### Try it!

**.env:**
```
DB_PASSWORD=secret123
```

**docker-compose.yml:**
```yaml
version: "3.8"
services:
  db:
    image: postgres:15
    environment:
      - POSTGRES_PASSWORD=${DB_PASSWORD}
```

```bash
docker compose up -d
docker compose exec db env | grep POSTGRES_PASSWORD
```
    MD
  },
  {
    slug: "codesprout-compose-build",
    num: 40,
    command: "docker compose build",
    title: "Building Images with Compose",
    content: <<-'MD'
**Building Images with Docker Compose** 🏗️

Building images in Compose workflows is important for DCA!

### build: Directive

**Build from Dockerfile:**
```yaml
services:
  api:
    build: ./api
    # Looks for ./api/Dockerfile
```

**Specify dockerfile:**
```yaml
services:
  api:
    build:
      context: ./api
      dockerfile: Dockerfile.dev
```

### Build Arguments

**Pass build args:**
```yaml
services:
  api:
    build:
      context: .
      args:
        NODE_VERSION: 18
        BUILD_DATE: 2025-01-15
```

**Dockerfile:**
```dockerfile
ARG NODE_VERSION
FROM node:${NODE_VERSION}

ARG BUILD_DATE
LABEL build_date=${BUILD_DATE}
```

### docker compose build

**Build images:**
```bash
docker compose build
# Builds all services with build: defined

docker compose build api
# Build specific service

docker compose build --no-cache
# Force rebuild without cache
```

### Build and Start

**Build then start:**
```bash
docker compose up --build
# Builds images if needed, then starts
```

### Image Naming

**Tag built image:**
```yaml
services:
  api:
    build: ./api
    image: myapi:1.0
    # Builds and tags as myapi:1.0
```

### DCA Exam Focus

Must know:
1. **build:** specifies build context
2. **docker compose build** builds images
3. **--build flag** on up command
4. **args:** passes build arguments
5. **image:** tags built image

### Multi-stage in Compose

**Development vs Production:**
```yaml
services:
  app-dev:
    build:
      context: .
      target: development
  
  app-prod:
    build:
      context: .
      target: production
```

**Dockerfile:**
```dockerfile
FROM node:18 AS development
# Dev dependencies

FROM node:18-alpine AS production
# Minimal production
```

### Try it!

**Dockerfile:**
```dockerfile
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/
```

**docker-compose.yml:**
```yaml
version: "3.8"
services:
  web:
    build: .
    image: myweb:latest
    ports:
      - "8080:80"
```

```bash
docker compose build
docker compose up -d
curl localhost:8080
docker compose down --rmi all
```
    MD
  },
  {
    slug: "codesprout-compose-override",
    num: 41,
    command: "docker-compose.override.yml",
    title: "Compose Override Files",
    content: <<-'MD'
**Docker Compose Override Files** 📝

Override files enable environment-specific configurations - key for DCA!

### docker-compose.override.yml

**Automatically loaded if exists:**
```bash
# These files are merged:
1. docker-compose.yml (base)
2. docker-compose.override.yml (auto-loaded)
```

**Base (docker-compose.yml):**
```yaml
version: "3.8"
services:
  web:
    image: nginx:alpine
```

**Override (docker-compose.override.yml):**
```yaml
version: "3.8"
services:
  web:
    ports:
      - "8080:80"
    volumes:
      - ./html:/usr/share/nginx/html
```

**Result:** Merged configuration with both files!

### Multiple Compose Files

**Specify files explicitly:**
```bash
docker compose -f docker-compose.yml -f docker-compose.prod.yml up
```

**Order matters (later files override earlier):**
```bash
# development.yml overrides base.yml
docker compose -f base.yml -f development.yml up
```

### Environment-Specific Files

**Structure:**
```
docker-compose.yml              # Base
docker-compose.override.yml     # Local dev (auto)
docker-compose.prod.yml         # Production
docker-compose.test.yml         # Testing
```

**Development (automatic):**
```bash
docker compose up
# Uses base + override
```

**Production:**
```bash
docker compose -f docker-compose.yml -f docker-compose.prod.yml up
```

### Override Examples

**Development override:**
```yaml
# docker-compose.override.yml
version: "3.8"
services:
  api:
    volumes:
      - ./src:/app/src  # Live reload
    environment:
      - DEBUG=true
```

**Production:**
```yaml
# docker-compose.prod.yml
version: "3.8"
services:
  api:
    restart: always
    logging:
      driver: syslog
```

### DCA Exam Focus

Must know:
1. **override.yml** loaded automatically
2. **-f flag** specifies files
3. **Later files override earlier**
4. **Merge behavior** for configs
5. **Environment-specific** configurations

### Override Behavior

**Values are replaced:**
```yaml
# base
image: nginx:1.25

# override
image: nginx:alpine
# Result: nginx:alpine
```

**Lists are merged:**
```yaml
# base
ports:
  - "80:80"

# override
ports:
  - "443:443"
# Result: Both ports!
```

### Try it!

**docker-compose.yml:**
```yaml
version: "3.8"
services:
  web:
    image: nginx:alpine
```

**docker-compose.override.yml:**
```yaml
version: "3.8"
services:
  web:
    ports:
      - "8080:80"
    command: sh -c "echo 'Override!' && nginx -g 'daemon off;'"
```

```bash
# Uses both files
docker compose up -d

# Check merged config
docker compose config

# Don't use override
docker compose -f docker-compose.yml up -d

docker compose down
```
    MD
  }
]

compose_chapters.each do |ch|
  puts "\nChapter #{ch[:num]}: #{ch[:title]}"
  unit = InteractiveLearningUnit.find_by!(slug: ch[:slug])
  unit.update!(
    concept_explanation: ch[:content],
    command_to_learn: ch[:command],
    command_variations: ["docker compose up", "docker compose down", "docker compose ps", "docker compose logs"],
    practice_hints: [
      "docker-compose.yml defines multi-container applications",
      "docker compose up starts all services",
      "Services can reach each other by service name",
      "Use volumes: section to persist data"
    ]
  )
  puts "✅ Enhanced"
end

puts "\n" + "=" * 80
puts "🎉 ALL DOCKER COMPOSE CHAPTERS COMPLETE (35-41)!"
puts "=" * 80
