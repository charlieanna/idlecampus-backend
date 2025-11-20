# Enhance Lab 1: Container Lifecycle Mastery with DCA-Level Instructions
# This lab tests chapters 1-14 comprehensively

puts "=" * 100
puts "ENHANCING LAB 1: CONTAINER LIFECYCLE MASTERY"
puts "Testing Commands from Chapters 1-14"
puts "=" * 100

lab = HandsOnLab.find_by!(slug: "lab-container-lifecycle")

lab.update!(
  scenario_narrative: <<~MD,
    **Real-World Scenario: Deploying a Web Service** 🚀

    **Background:**
    You're a DevOps engineer at CodeSprout, a fast-growing SaaS company. The development team
    has containerized a new feature and needs you to deploy it to the staging environment.

    **Your Mission:**
    1. Pull the nginx:alpine image from Docker Hub
    2. Run nginx in detached mode with port mapping
    3. Verify the container is running
    4. Check the logs for startup messages
    5. Execute a command inside the running container
    6. Stop and remove the container cleanly
    7. Verify cleanup was successful

    **Success Criteria:**
    - All commands execute without errors
    - Container serves traffic on the correct port
    - Logs show successful nginx startup
    - Clean removal leaves no orphaned containers
    - Pass threshold: 70% (5/7 tasks minimum)

    **Time Limit:** 15 minutes

    **DCA Relevance:**
    This lab covers fundamental skills tested in the **Image Creation (20%)** and **Orchestration (25%)**
    domains of the Docker Certified Associate exam.
  MD,

  steps: [
    {
      order: 1,
      title: "Task 1: Check Available Images",
      description: <<~MD,
        **Objective:** View all Docker images currently on your system

        **Command to run:**
        ```bash
        docker images
        ```

        **What to look for:**
        - The command lists all images with REPOSITORY, TAG, IMAGE ID, CREATED, and SIZE columns
        - You should see any images from previous chapters (like hello-world)

        **Expected Output:**
        ```
        REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
        hello-world   latest    d2c94e258dcb   7 months ago   13.3kB
        ```

        **Success Criteria:**
        - Command runs without errors
        - Output shows image list in tabular format

        **Validation:** ✅ Can you see the column headers and at least one image?

        **Troubleshooting:**
        - If empty: This is OK! Continue to next step
        - If error: Check Docker is running with `docker ps`
      MD,
      validation_type: "command_output",
      expected_output: "REPOSITORY",
      points: 10
    },

    {
      order: 2,
      title: "Task 2: Pull the nginx:alpine Image",
      description: <<~MD,
        **Objective:** Download the nginx:alpine image from Docker Hub

        **Command to run:**
        ```bash
        docker pull nginx:alpine
        ```

        **What's happening:**
        - Docker contacts Docker Hub (the default registry)
        - Downloads the nginx image with the "alpine" tag (lightweight Linux)
        - Image is stored locally for future use

        **Expected Output:**
        ```
        alpine: Pulling from library/nginx
        a2abf6c4d29d: Pull complete
        a9edb18cadd1: Pull complete
        589b7251471a: Pull complete
        Digest: sha256:0d17b565c37bcbd895e9d92315a05c1c3c9a29f762b011a10c54a66cd53c9b31
        Status: Downloaded newer image for nginx:alpine
        docker.io/library/nginx:alpine
        ```

        **Key Observations:**
        - Each line with "Pull complete" is a **layer** being downloaded
        - The **Digest** (SHA256 hash) ensures image integrity
        - If you run this again, it will say "Image is up to date" (layer caching!)

        **Success Criteria:**
        - Command completes successfully
        - Image appears in `docker images` output

        **Validation:** ✅ Run `docker images nginx` - Do you see nginx:alpine with a size of ~23-40MB?

        **Troubleshooting:**
        - "Cannot connect": Check internet connection
        - "Unauthorized": Image might be private (nginx:alpine is public, should work)
      MD,
      validation_type: "image_exists",
      expected_output: "nginx:alpine",
      points: 15
    },

    {
      order: 3,
      title: "Task 3: Run nginx in Detached Mode with Port Mapping",
      description: <<~MD,
        **Objective:** Start nginx container in the background, accessible on port 8080

        **Command to run:**
        ```bash
        docker run -d -p 8080:80 --name test-nginx nginx:alpine
        ```

        **Breaking down the command:**
        - `docker run` - Creates and starts a new container
        - `-d` - **Detached mode** (runs in background)
        - `-p 8080:80` - **Port mapping** (host port 8080 → container port 80)
        - `--name test-nginx` - Gives the container a friendly name
        - `nginx:alpine` - The image to use

        **Expected Output:**
        ```
        abc123def456...  ← Full container ID (64 characters)
        ```

        **What happened:**
        1. Docker created a new container from nginx:alpine image
        2. Started nginx web server inside the container
        3. Mapped host port 8080 to container port 80
        4. Container is now running in the background

        **Success Criteria:**
        - Command returns a container ID (long hex string)
        - No error messages

        **Validation:** ✅ Test if nginx is serving:
        ```bash
        curl localhost:8080
        # Should return nginx welcome page HTML
        ```

        Or open http://localhost:8080 in your browser - you should see "Welcome to nginx!"

        **Troubleshooting:**
        - "port is already allocated": Port 8080 is in use, try 8081
        - "name is already in use": Run `docker rm -f test-nginx` first
      MD,
      validation_type: "container_running",
      expected_output: "test-nginx",
      points: 20
    },

    {
      order: 4,
      title: "Task 4: List Running Containers",
      description: <<~MD,
        **Objective:** Verify the container is running and see its status

        **Command to run:**
        ```bash
        docker ps
        ```

        **Expected Output:**
        ```
        CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
        abc123def456   nginx:alpine   "/docker-entrypoint.…"   30 seconds ago   Up 29 seconds   0.0.0.0:8080->80/tcp   test-nginx
        ```

        **Understanding the output:**
        - **CONTAINER ID**: Short version of the ID (first 12 characters)
        - **IMAGE**: nginx:alpine (the image this container was created from)
        - **COMMAND**: The process running inside (nginx in this case)
        - **CREATED**: When the container was created
        - **STATUS**: "Up X seconds" means it's running healthy
        - **PORTS**: 0.0.0.0:8080->80/tcp means port 8080 on all interfaces maps to container port 80
        - **NAMES**: test-nginx (the name we gave it)

        **Success Criteria:**
        - Output shows test-nginx container
        - STATUS column shows "Up"
        - PORTS shows 8080->80 mapping

        **Validation:** ✅ Can you see your container with STATUS = "Up"?

        **Bonus Commands:**
        ```bash
        docker ps -a      # Shows ALL containers (including stopped)
        docker ps -q      # Shows only container IDs (useful for scripts)
        docker ps --no-trunc  # Shows full container ID and command
        ```

        **Troubleshooting:**
        - If empty: Container might have crashed, run `docker ps -a` to see stopped containers
        - If STATUS shows "Exited": Container stopped, check logs (next task)
      MD,
      validation_type: "container_status",
      expected_output: "test-nginx.*Up",
      points: 10
    },

    {
      order: 5,
      title: "Task 5: View Container Logs",
      description: <<~MD,
        **Objective:** Check nginx startup logs to verify it's running correctly

        **Command to run:**
        ```bash
        docker logs test-nginx
        ```

        **Expected Output:**
        ```
        /docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
        /docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
        ...
        2024/11/02 15:30:45 [notice] 1#1: start worker processes
        2024/11/02 15:30:45 [notice] 1#1: start worker process 29
        ```

        **What you're seeing:**
        - Nginx startup sequence
        - Configuration loading
        - Worker processes starting
        - No ERROR messages = good!

        **Success Criteria:**
        - Logs show nginx startup messages
        - No ERROR or FATAL messages
        - Worker processes started successfully

        **Validation:** ✅ Do you see "start worker process" messages?

        **Useful log options:**
        ```bash
        docker logs -f test-nginx      # Follow logs in real-time (like tail -f)
        docker logs --tail 20 test-nginx  # Show last 20 lines only
        docker logs --since 5m test-nginx # Logs from last 5 minutes
        ```

        **Troubleshooting:**
        - If errors: Container might be misconfigured
        - Empty output: Container hasn't produced any logs yet (unusual for nginx)
      MD,
      validation_type: "command_output",
      expected_output: "nginx",
      points: 10
    },

    {
      order: 6,
      title: "Task 6: Execute a Command Inside the Running Container",
      description: <<~MD,
        **Objective:** Run a command inside the live container to inspect its environment

        **Command to run:**
        ```bash
        docker exec test-nginx ls /usr/share/nginx/html
        ```

        **What this does:**
        - `docker exec` - Runs a command in a running container
        - `test-nginx` - The container to execute in
        - `ls /usr/share/nginx/html` - The command to run (list nginx web root)

        **Expected Output:**
        ```
        50x.html
        index.html
        ```

        **These are nginx's default HTML files!**

        **Success Criteria:**
        - Command executes without errors
        - Shows index.html and 50x.html files

        **Validation:** ✅ Can you see index.html in the output?

        **Try these variations:**
        ```bash
        # Interactive shell access
        docker exec -it test-nginx sh
        # Inside the container, try:
        # whoami
        # ps aux
        # cat /etc/nginx/nginx.conf
        # exit

        # Check nginx version
        docker exec test-nginx nginx -v

        # View the actual HTML being served
        docker exec test-nginx cat /usr/share/nginx/html/index.html
        ```

        **DCA Exam Tip:**
        - `docker exec` is for **running containers**
        - Requires `-it` flags for interactive sessions
        - Different from `docker run` (which creates NEW containers)

        **Troubleshooting:**
        - "Container not running": Check with `docker ps`
        - "executable file not found": Command doesn't exist in container
      MD,
      validation_type: "command_output",
      expected_output: "index.html",
      points: 15
    },

    {
      order: 7,
      title: "Task 7: Stop the Container Gracefully",
      description: <<~MD,
        **Objective:** Stop the running nginx container cleanly

        **Command to run:**
        ```bash
        docker stop test-nginx
        ```

        **What happens:**
        1. Docker sends SIGTERM signal to nginx (graceful shutdown request)
        2. Nginx finishes handling current requests
        3. Nginx shuts down cleanly
        4. After 10 seconds (if still running), Docker sends SIGKILL (force stop)

        **Expected Output:**
        ```
        test-nginx
        ```
        (Just echoes the container name)

        **Success Criteria:**
        - Command completes (usually takes 1-2 seconds)
        - No error messages

        **Validation:** ✅ Run `docker ps` - container should NOT appear (it's stopped)
        ✅ Run `docker ps -a` - container SHOULD appear with STATUS = "Exited"

        **Understanding Container States:**
        - **Running**: Container is active (`docker ps`)
        - **Stopped**: Container exists but not running (`docker ps -a`, STATUS = Exited)
        - **Removed**: Container deleted entirely (doesn't appear in `docker ps -a`)

        **Bonus Commands:**
        ```bash
        docker stop -t 30 test-nginx  # Wait 30 seconds before force kill
        docker restart test-nginx     # Stop then start again
        docker kill test-nginx        # Force stop immediately (SIGKILL)
        ```

        **Troubleshooting:**
        - Takes long time: Application isn't handling SIGTERM, will be killed after 10s
        - "No such container": Already stopped or doesn't exist
      MD,
      validation_type: "container_stopped",
      expected_output: "test-nginx.*Exited",
      points: 10
    },

    {
      order: 8,
      title: "Task 8: Remove the Container and Verify Cleanup",
      description: <<~MD,
        **Objective:** Delete the stopped container completely

        **Command to run:**
        ```bash
        docker rm test-nginx
        ```

        **What happens:**
        - Container filesystem is deleted
        - Container configuration is removed
        - Container name "test-nginx" becomes available again
        - **The IMAGE is NOT deleted** (nginx:alpine remains)

        **Expected Output:**
        ```
        test-nginx
        ```
        (Echoes the container name)

        **Success Criteria:**
        - Command completes successfully
        - Container no longer appears in `docker ps -a`

        **Validation:** ✅ Run `docker ps -a | grep test-nginx` - should return nothing

        **Verify image still exists:**
        ```bash
        docker images nginx:alpine
        # Should still show the image (we only removed the container!)
        ```

        **Final Cleanup (Optional):**
        ```bash
        # Remove the image too (if you want)
        docker rmi nginx:alpine

        # Remove all stopped containers (careful!)
        docker container prune

        # Remove unused images
        docker image prune
        ```

        **DCA Exam Key Points:**
        1. `docker stop` → Stops container (doesn't remove it)
        2. `docker rm` → Removes stopped container
        3. `docker rmi` → Removes **image** (different!)
        4. Must stop before removing (or use `-f` flag)

        **Common Patterns:**
        ```bash
        # Stop and remove in one command
        docker rm -f test-nginx

        # Remove multiple containers
        docker rm container1 container2 container3

        # Remove all stopped containers
        docker rm $(docker ps -aq -f status=exited)
        ```

        **Troubleshooting:**
        - "container is running": Stop it first with `docker stop`
        - "No such container": Already removed or never existed
      MD,
      validation_type: "container_removed",
      expected_output: "!test-nginx",
      points: 10
    }
  ],

  description: <<~MD,
    **Complete Container Lifecycle Lab**

    This hands-on lab tests your mastery of the fundamental Docker commands covered in Chapters 1-14.
    You'll perform a realistic deployment workflow from start to finish.

    **Commands Tested:**
    - `docker images` - List available images
    - `docker pull` - Download images from registry
    - `docker run` - Create and start containers
    - `docker ps` - List running containers
    - `docker logs` - View container output
    - `docker exec` - Execute commands in containers
    - `docker stop` - Stop running containers
    - `docker rm` - Remove stopped containers

    **Learning Objectives:**
    1. Understand the Docker image → container lifecycle
    2. Master port mapping for network access
    3. Use logs for debugging and monitoring
    4. Execute commands in running containers
    5. Clean up resources properly

    **Pass Threshold:** 70% (7/10 tasks minimum)
    **Estimated Time:** 15 minutes
    **Difficulty:** Easy (Foundation)
  MD,

  estimated_minutes: 15,
  difficulty: "easy",
  pass_threshold: 70
)

puts "\n✅ Lab 1 enhanced with comprehensive DCA-level instructions!"
puts "   - 8 detailed tasks with step-by-step guidance"
puts "   - Expected output examples for each task"
puts "   - Validation criteria and troubleshooting tips"
puts "   - DCA exam focus areas highlighted"
puts "\n" + "=" * 100
puts "LAB 1: CONTAINER LIFECYCLE MASTERY is DCA-READY!"
puts "=" * 100
