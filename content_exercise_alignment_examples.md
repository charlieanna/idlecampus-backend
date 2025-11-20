# Content-Exercise Alignment Analysis

## Good Example: concurrency-vs-parallelism.yml

**Lesson Content Covers:**
- Definition of concurrency vs parallelism
- Go's concurrency model (CSP)
- Goroutines vs OS threads
- When to use concurrency

**MCQ Question:**
"Concurrency means..."

**Options:**
1. Structuring a program to handle multiple tasks by interleaving progress ✓
2. Running multiple tasks strictly at the same time on multiple CPUs
3. Using threads instead of goroutines
4. Using time.Sleep to coordinate

**Alignment:** GOOD - Question directly tests the core concept from the lesson

**Missing:** Explanation field to help students understand why option 1 is correct

---

## Bad Example: introduction-to-cryptography.yml

**Lesson Content Covers:**
- CIA Triad (Confidentiality, Integrity, Availability)
- Symmetric encryption (AES, ChaCha20, 3DES)
- Asymmetric encryption (RSA, ECDSA, Ed25519)
- Hashing (SHA-256, SHA-512, bcrypt)
- Practical applications

**MCQ Question:**
"Which statement is correct for this topic?"

**Options:**
A, B, C, D (placeholders)

**Alignment:** TERRIBLE - No actual question, no actual options, no testing of concepts

**What it SHOULD be:**
Question: "Which encryption method would you use to encrypt a large file for storage?"
Options:
1. AES-256 symmetric encryption ✓
2. RSA-2048 asymmetric encryption
3. SHA-256 hashing
4. bcrypt password hashing

Explanation: "AES-256 is the correct choice because symmetric encryption is fast and efficient for large amounts of data. RSA is too slow for large files, and SHA-256/bcrypt are one-way hash functions that cannot be reversed to recover the original data."

---

## Bad Example: lesson-10.yml (AWS Lambda)

**Lesson Content Covers:**
- Lambda function basics
- Supported runtimes (Python, Node.js, Java, Go, etc.)
- Common triggers (API Gateway, S3, DynamoDB, CloudWatch)
- Lambda pricing model
- Best practices for cold starts, timeouts, error handling

**MCQ Question:**
"Which statement is correct for this topic?"

**Options:**
A, B, C, D (placeholders)

**Objectives Listed:**
- Apply least privilege
- Design policies
- Harden auth & keys

**Alignment:** TERRIBLE - Generic question, placeholder options, AND objectives don't match content!

**What it SHOULD be:**
Question: "What is the maximum execution time for an AWS Lambda function?"
Options:
1. 3 seconds
2. 5 minutes
3. 15 minutes ✓
4. 1 hour

Explanation: "AWS Lambda functions have a maximum execution time of 15 minutes. This makes Lambda ideal for short-lived, event-driven tasks but unsuitable for long-running processes that would be better served by EC2 or ECS."

Objectives should be:
- Create Lambda functions with appropriate configurations
- Choose optimal triggers for different use cases
- Implement error handling and monitoring

---

## Pattern Analysis

### Files with GOOD content but BAD exercises:
- Most Docker lessons have excellent, detailed content about commands
- Security lessons have comprehensive cryptography explanations
- Go lessons have thorough code examples
- ALL have placeholder/generic exercises that don't test the content

### Files with Content-Objective Mismatch:
- Many files have objectives like "Apply least privilege", "Design policies", "Harden auth & keys"
- These seem to be copy-pasted from security-focused templates
- They don't match lessons about Docker commands, Python setup, or Indian economy

### Files with Good Starter MCQs (need explanations):
1. concurrency-vs-parallelism.yml
2. docker-compose-up-start-multi-container-applications.yml
3. docker-pull-download-images-from-registry.yml
4. docker-push-upload-images-to-registry.yml
5. docker-run-creating-and-starting-containers.yml
6. docker-update-update-container-configuration.yml
7. network-commands.yml

These 7 files are 90% done - they just need explanation fields added!

---

## Recommendations for Exercise Creation

### For Docker Command Lessons:
**Question Types:**
- What does flag X do?
- Which command accomplishes Y?
- What's the difference between X and Y?

**Example:**
Question: "In 'docker run -p 8080:80 nginx', which port is on the host machine?"
Options:
1. 8080 ✓
2. 80
3. Both 8080 and 80
4. Neither, ports are internal only
5. The question is invalid syntax

Explanation: "Port 8080 is the host port (left side). The format is HOST:CONTAINER, so traffic to localhost:8080 forwards to port 80 inside the container."

### For Cryptography Lessons:
**Question Types:**
- Which algorithm for which use case?
- Security properties and trade-offs
- When to use symmetric vs asymmetric

**Example:**
Question: "Why should you NEVER use MD5 for password hashing?"
Options:
1. MD5 is broken and vulnerable to collision attacks ✓
2. MD5 is too slow for production use
3. MD5 only works with passwords under 16 characters
4. MD5 requires a secret key that users don't have

Explanation: "MD5 is cryptographically broken with known collision attacks. For passwords, use purpose-built algorithms like bcrypt or Argon2 that include salting and are designed to be computationally expensive."

### For Go Concurrency Lessons:
**Question Types:**
- Goroutines vs threads
- Channel usage patterns
- Race condition identification

**Example:**
Question: "What is the main advantage of goroutines over OS threads?"
Options:
1. Goroutines are managed by the Go runtime and are extremely lightweight (2KB vs 1-2MB) ✓
2. Goroutines run faster than threads
3. Goroutines prevent all race conditions automatically
4. Goroutines don't need the CPU to execute

Explanation: "Goroutines have tiny 2KB initial stacks compared to OS threads' 1-2MB stacks, allowing millions of goroutines in the same memory that holds thousands of threads. They're scheduled by the Go runtime, making creation and context switching very cheap."

---

## Summary

**Content Quality:** HIGH (Most lessons have excellent, detailed content)
**Exercise Quality:** LOW (Nearly all exercises are generic placeholders)
**Content-Exercise Alignment:** VERY LOW (Exercises don't test what content teaches)

**Effort Required:** ~30 hours to fix all exercises
**Priority:** High - Exercises are critical for learning effectiveness
**Quick Wins:** 7 files just need explanation fields added (~40 minutes)
