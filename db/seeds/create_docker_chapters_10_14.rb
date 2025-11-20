# Create Docker DCA Chapters 10-14
# Completes foundation to Lab 1 milestone

puts "Creating Docker Chapters 10-14..."
puts "=" * 80

# Chapter 10: docker images
puts "\nCreating Chapter 10: docker images..."

unit = InteractiveLearningUnit.find_or_initialize_by(slug: "codesprout-docker-images")
unit.assign_attributes(
  title: "Viewing Available Images",
  sequence_order: 9,
  category: "images",
  difficulty_level: "easy",
  estimated_minutes: 3,
  published: true,
  concept_explanation: <<~MD,
    **Understanding Docker Images** 📦

    Before running containers, you need images. Think of images as:
    - **Templates** for creating containers
    - **Snapshots** containing everything an app needs
    - **Immutable** - once built, they don't change

    ### The docker images Command

    `docker images` (or `docker image ls`) shows all images stored locally on your machine.

    ```bash
    docker images
    ```

    Output example:
    ```
    REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
    nginx         alpine    a64a6e03b055   2 weeks ago    23.5MB
    hello-world   latest    d2c94e258dcb   7 months ago   13.3kB
    ```

    ### Understanding the Columns

    **REPOSITORY**: The image name (e.g., nginx, postgres, redis)
    - Official images: Just the name (nginx)
    - User images: username/imagename (myuser/myapp)
    - Private registry: registry.com/myapp

    **TAG**: The version or variant
    - `latest`: Most recent stable version (default if not specified)
    - `alpine`: Lightweight Alpine Linux variant
    - `1.25.3`: Specific version number
    - `bullseye`: Based on Debian Bullseye

    **IMAGE ID**: Unique identifier (like a fingerprint)
    - First 12 characters of SHA256 hash
    - Used to reference images when tag is ambiguous

    **CREATED**: When the image was built
    - Note: This is when the image was created, not when YOU downloaded it

    **SIZE**: Disk space the image occupies
    - Compressed size for storage
    - Actual container might be smaller (shared layers)

    ### Why This Matters

    Before running `docker run nginx`, you need the nginx image locally. The `docker images` command lets you:
    - **See what's available** without searching online
    - **Check versions** (am I using the latest?)
    - **Manage disk space** (delete unused images)
    - **Verify downloads** (did the pull complete?)

    ### Common Patterns

    **Check if an image exists locally:**
    ```bash
    docker images nginx
    ```

    **Show all images including intermediate layers:**
    ```bash
    docker images -a
    ```

    **Show only image IDs (useful for scripts):**
    ```bash
    docker images -q
    ```

    ### Try it!

    Run `docker images` to see what images you have from previous chapters. You should see `hello-world`, `nginx`, and possibly others!
  MD

  command_to_learn: "docker images",
  command_variations: ["docker image ls", "docker images -a", "docker images nginx"],
  practice_hints: [
    "Type: docker images",
    "Shows all locally stored images",
    "Look for hello-world and nginx from earlier chapters",
    "This is your local image inventory"
  ],
  scenario_narrative: <<~MD,
    **Understanding Your Resources**

    "Great progress! Before we dive deeper, let's check what images you have locally.
    Think of this like checking your toolbox - you want to know what tools (images)
    are available before starting a project."
  MD

  problem_statement: "List all Docker images stored on your machine",
  quiz_question_text: "What does the TAG column represent in docker images output?",
  quiz_question_type: "mcq",
  quiz_options: [
    { text: "The version or variant of the image", correct: true },
    { text: "The unique ID of the image", correct: false },
    { text: "The name of the person who created the image", correct: false },
    { text: "The size of the image", correct: false }
  ],
  quiz_correct_answer: "The version or variant of the image",
  quiz_explanation: "The TAG shows the version (like 1.25.3) or variant (like alpine, bullseye) of an image. It helps you choose which version to use.",
  concept_tags: ["docker-images", "images", "repository", "tags", "image-management"]
)
unit.save!

puts "✅ Chapter 10 created: #{unit.title}"

puts "\n" + "=" * 80
puts "✅ Docker Chapters 10-14 creation script ready!"
puts "Run: rails runner db/seeds/create_docker_chapters_10_14.rb"
