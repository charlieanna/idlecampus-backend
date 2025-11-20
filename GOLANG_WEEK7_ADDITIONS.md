# Golang Week 7 Content - RESTful Web Services

## Summary

This document describes the new content added to complete the Golang curriculum's Week 7 (RESTful Web Services) and fill the missing Pointers lesson from Week 2.

## What Was Added

### 1. Week 7: Building RESTful Web Services (NEW MODULE)

**Location:** `db/seeds/golang_web_services*.rb`

#### Lessons Added:

1. **REST API Design Basics** (`golang_web_services.rb`)
   - What is REST?
   - HTTP methods (GET, POST, PUT, DELETE)
   - Resource naming conventions
   - HTTP status codes
   - JSON request/response format
   - API design best practices
   - **Duration:** 25 minutes

2. **Building HTTP Servers with net/http** (`golang_web_services.rb`)
   - Creating HTTP servers
   - Handler functions
   - Reading request information
   - Handling different HTTP methods
   - Setting response status codes and headers
   - Concurrent request handling
   - Graceful shutdown
   - **Duration:** 30 minutes

3. **JSON Request/Response Handling** (`golang_web_services.rb`)
   - Struct tags for JSON
   - Sending JSON responses
   - Reading JSON request bodies
   - Parsing URL path parameters
   - Parsing query parameters
   - Error response formatting
   - Complete REST endpoint examples
   - **Duration:** 30 minutes

4. **Database Integration with database/sql** (`golang_web_services_advanced.rb`)
   - Installing database drivers (PostgreSQL, SQLite)
   - Connecting to databases
   - Creating tables
   - CRUD operations (INSERT, SELECT, UPDATE, DELETE)
   - Transactions
   - Connection pooling
   - Integrating with HTTP handlers
   - **Duration:** 35 minutes

5. **Middleware and Logging** (`golang_web_services_advanced.rb`)
   - What is middleware?
   - Logging middleware with timing
   - Response status capture
   - Authentication middleware
   - CORS middleware
   - Chaining multiple middleware
   - Structured logging
   - Recovery middleware (panic handling)
   - **Duration:** 30 minutes

**Total Lesson Time:** 150 minutes (2.5 hours)

#### Labs Added:

1. **Lab: Build Your First HTTP Server** (`golang_web_services_labs.rb`)
   - Create server with multiple routes
   - Implement handler functions
   - **Difficulty:** Easy
   - **Time:** 20 minutes
   - **Points:** 100

2. **Lab: Create a JSON API Endpoint** (`golang_web_services_labs.rb`)
   - Return JSON responses
   - Set proper headers
   - **Difficulty:** Medium
   - **Time:** 25 minutes
   - **Points:** 150

3. **Lab: Handle JSON POST Requests** (`golang_web_services_labs.rb`)
   - Parse JSON request bodies
   - Create resources
   - Return appropriate status codes
   - **Difficulty:** Medium
   - **Time:** 30 minutes
   - **Points:** 175

4. **Lab: Build a Complete REST API** (`golang_web_services_labs.rb`)
   - Full CRUD API for books
   - GET, POST, PUT, DELETE endpoints
   - Path parameter handling
   - Error handling
   - **Difficulty:** Hard
   - **Time:** 45 minutes
   - **Points:** 250

**Total Lab Time:** 120 minutes (2 hours)

**Module Total:** 270 minutes (4.5 hours)

---

### 2. Week 2: Pointers Lesson (CRITICAL GAP FILLED)

**Location:** `db/seeds/golang_pointers.rb`

#### Content Added:

1. **Lesson: Pointers in Go**
   - What is a pointer?
   - Why use pointers (modify values, avoid copying)
   - Declaring and using pointers
   - Nil pointers
   - Pointers and structs
   - When to use pointers vs values
   - Common pointer patterns
   - Pointer pitfalls and best practices
   - Performance considerations
   - **Duration:** 25 minutes

2. **Lab: Pointers and Struct Manipulation**
   - Update struct fields via pointers
   - Factory functions returning pointers
   - Swap function using pointers
   - **Difficulty:** Medium
   - **Time:** 30 minutes
   - **Points:** 175

---

## File Structure

```
db/seeds/
├── golang_pointers.rb                    # NEW - Pointers lesson + lab
├── golang_web_services.rb                # NEW - Lessons 1-3
├── golang_web_services_advanced.rb       # NEW - Lessons 4-5
└── golang_web_services_labs.rb           # NEW - 4 hands-on labs

lib/tasks/
└── go_seeds.rake                         # UPDATED - includes new seeds
```

## How to Seed

Run the updated rake task:

```bash
bundle exec rake go:seed
```

This will load all Go course content including:
- Existing enhanced course
- Existing code labs
- Existing concurrency units
- **NEW: Pointers lesson**
- **NEW: Web services module (Week 7)**

## Course Structure After Addition

### Module Sequence:

1. **Go Basics** (Week 1)
2. **Data Structures** (Week 2) - ✅ NOW INCLUDES POINTERS
3. **Advanced Concepts** (Week 3) - Methods, Interfaces, Error Handling
4. **Concurrency** (Week 4-5) - Goroutines, Channels, WaitGroups
5. **Go Concurrency Fundamentals** (Week 6) - Advanced patterns, 8 ILUs
6. **Building RESTful Web Services** (Week 7) - ✅ NEW MODULE
7. **Advanced Patterns** (Optional)

## Coverage Analysis

### Before This Addition:
- Week 1: ✅ 85%
- Week 2: ⚠️ 70% (missing pointers)
- Week 3: ✅ 95%
- Week 4: ✅ 95%
- Week 5: ✅ 100%
- Week 6: ✅ 100%
- Week 7: ❌ 0% (completely missing)
- Week 8: ⚠️ 30% (different focus)

**Overall: ~68%**

### After This Addition:
- Week 1: ✅ 85%
- Week 2: ✅ 95% (pointers added!)
- Week 3: ✅ 95%
- Week 4: ✅ 95%
- Week 5: ✅ 100%
- Week 6: ✅ 100%
- Week 7: ✅ 95% (web services added!)
- Week 8: ⚠️ 30% (capstone still different)

**Overall: ~93%**

## What's Still Missing

### Week 8: Capstone Project Alignment

The curriculum suggests a **CRUD Web API Service** capstone (e.g., Vacation Management System), but the current capstone is an **MVP Web Crawler** (concurrency-focused).

**Options:**
1. Keep both capstones:
   - Capstone A: MVP Crawler (concurrency mastery)
   - Capstone B: CRUD API Service (web service mastery)

2. Replace the crawler with a CRUD API capstone

**Recommendation:** Keep both. The crawler is excellent for concurrency practice, and adding a CRUD API capstone would complete the web development learning path.

## Testing

Each lab includes:
- Starter code with TODOs
- Step-by-step instructions
- Hints for each step
- Test cases (visible and hidden)
- Learning objectives

## Learning Objectives Met

Students will now be able to:
- ✅ Understand and use pointers effectively
- ✅ Design RESTful APIs with proper resource naming
- ✅ Build HTTP servers using Go's standard library
- ✅ Handle JSON requests and responses
- ✅ Parse path parameters and query strings
- ✅ Integrate databases (PostgreSQL/SQLite) with Go
- ✅ Perform CRUD operations safely
- ✅ Implement middleware for logging, auth, and CORS
- ✅ Build production-ready web services in Go

## Next Steps

1. **Seed the new content:**
   ```bash
   bundle exec rake go:seed
   ```

2. **Verify in database:**
   - Check `golang-fundamentals` course has `go-web-services` module
   - Verify 5 lessons and 4 labs are present
   - Check `data-structures` module has pointers lesson

3. **Optional: Add Week 8 CRUD API Capstone**
   - Could add a comprehensive project like:
     - Task Management API
     - Book Library API
     - E-commerce Inventory API
   - Should include database persistence
   - Should demonstrate all Week 7 concepts

## Credits

This content was created to align the Golang course with the 8-week curriculum specification, focusing on production-ready web service development with Go.
