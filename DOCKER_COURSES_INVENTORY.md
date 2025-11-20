# Complete Docker Course Inventory

## Docker Course Architecture

You have **2 levels** of Docker courses (simplified from 3):

### 1. **Consolidated Structured Course** (Recommended for Learning)
Located in `db/seeds/consolidated_courses/`:

**`docker-fundamentals`** - 42 lessons organized into 4 modules
- **Module 1: Introduction to Docker** (4 lessons)
  - docker-ps (listing containers)
  - docker-run (creating/starting)
  - docker-stop (stopping gracefully)
  - docker-rm (removing containers)

- **Module 2: Working with Containers** (20 lessons)
  - docker-container-ls, create, start, stop, restart
  - docker-container-kill, rm, prune
  - docker-container-exec, logs, inspect
  - docker-container-wait, pause, unpause
  - docker-cp, diff, export, stats, top, update
  - docker-port, rename

- **Module 3: Docker Images & Dockerfiles** (11 lessons)
  - docker-images, pull, build, tag, push
  - docker-rmi, image-ls, image-rm
  - docker-image-inspect, image-prune
  - docker-history

- **Module 4: Data Persistence with Volumes** (7 lessons)
  - docker-volume-create, list, inspect
  - docker-volume-remove, prune
  - docker-run-with-volumes
  - bind-mounts-vs-volumes

**Total: 42 comprehensive lessons**

### 2. **Individual Command Collections** (Reference Library)
Located in `db/seeds/converted_microlessons/`:

- **docker-basics** (4 lessons) - Core commands
- **docker-containers** (20 lessons) - All container operations
- **docker-images** (11 lessons) - Image management
- **docker-networks** (7 lessons) - Networking
- **docker-volumes** (7 lessons) - Data persistence
- **docker-compose** (4 lessons) - Multi-container apps (for local dev)
- **docker-security** (3 lessons) - Security best practices

**Total: 56 granular command-level lessons**

## Advanced Docker Course
Located in `db/seeds/consolidated_courses/`:

**`docker-advanced`** - For experienced users (7 hours)
- Advanced networking and custom networks (2 hours)
- Multi-container orchestration with Docker Compose (3 hours)
- Security hardening and best practices (2 hours)

## ~~Removed Course~~
~~`docker_complete_enhanced`~~ - **REMOVED** ❌
- Was a 7-lesson beginner quickstart
- Removed to avoid confusion
- Use `docker-fundamentals` instead

## Exercise Structure ✅
Each Docker lesson includes:
- **1 terminal exercise** per command (hands-on practice)
- **MCQ exercises** for theory/concepts
- **No reflection/checkpoint** (removed ~14 from Docker courses)

Example terminal exercise:
```yaml
- type: terminal
  problem_statement: "Execute an interactive bash shell in 'my-container'"
  command: "docker container exec -it my-container bash"
  hints:
    - 'Shell: docker container exec -it <name> bash'
```

## Recommendation for Students

**New to Docker?** → Start with **`docker-fundamentals`** (42 lessons)
- Structured learning path
- 10 hours estimated time
- Organized into logical modules
- Comprehensive coverage

**Need quick reference?** → Use **individual collections**
- Command-by-command reference
- Quick lookup for specific commands
- Detailed syntax and examples

**Already know Docker?** → Try **`docker-advanced`**
- Advanced networking and custom networks
- Multi-container apps with Docker Compose
- Security hardening for production
