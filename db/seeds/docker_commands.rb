# Docker Commands Seed Data for DCA Exam Preparation
# Categories: basics, images, containers, networks, volumes, registry, security, swarm, compose

puts "🐳 Seeding Docker Commands for DCA Exam..."

docker_commands = [
  # BASICS - Container Operations (High Frequency)
  {
    command: "docker run -d nginx",
    explanation: "Run nginx container in detached mode (background)",
    difficulty: "easy",
    category: "basics",
    exam_frequency: 10,
    certification_exam: "DCA",
    variations: ["docker run -d -p 8080:80 nginx", "docker run -d --name web nginx"],
    flags: { "-d" => "detached mode", "-p" => "port mapping", "--name" => "container name" },
    use_cases: "Deploy web server in background",
    gotchas: "Container runs in background, use docker logs to see output"
  },
  {
    command: "docker ps",
    explanation: "List all running containers",
    difficulty: "easy",
    category: "basics",
    exam_frequency: 10,
    certification_exam: "DCA",
    variations: ["docker ps -a", "docker ps -q"],
    flags: { "-a" => "all containers", "-q" => "quiet mode (IDs only)" },
    use_cases: "Check running containers, troubleshooting",
    gotchas: "Without -a flag, only shows running containers"
  },
  {
    command: "docker stop <container>",
    explanation: "Gracefully stop a running container (sends SIGTERM)",
    difficulty: "easy",
    category: "basics",
    exam_frequency: 9,
    certification_exam: "DCA",
    variations: ["docker stop $(docker ps -q)", "docker stop container1 container2"],
    flags: { "-t" => "timeout before killing" },
    use_cases: "Graceful container shutdown",
    gotchas: "Waits 10 seconds before forcing kill with SIGKILL"
  },
  {
    command: "docker start <container>",
    explanation: "Start a stopped container",
    difficulty: "easy",
    category: "basics",
    exam_frequency: 9,
    certification_exam: "DCA",
    variations: ["docker start -a <container>"],
    flags: { "-a" => "attach to container output" },
    use_cases: "Restart existing container",
    gotchas: "Cannot change configuration of existing container"
  },
  {
    command: "docker restart <container>",
    explanation: "Restart a container (stop + start)",
    difficulty: "easy",
    category: "basics",
    exam_frequency: 8,
    certification_exam: "DCA",
    variations: ["docker restart -t 30 <container>"],
    flags: { "-t" => "timeout before killing" },
    use_cases: "Apply configuration changes, troubleshooting",
    gotchas: "Uses same timeout as stop command"
  },
  {
    command: "docker rm <container>",
    explanation: "Remove a stopped container",
    difficulty: "easy",
    category: "basics",
    exam_frequency: 9,
    certification_exam: "DCA",
    variations: ["docker rm -f <container>", "docker rm $(docker ps -aq)"],
    flags: { "-f" => "force remove running container", "-v" => "remove volumes" },
    use_cases: "Clean up stopped containers",
    gotchas: "Cannot remove running container without -f flag"
  },
  {
    command: "docker logs <container>",
    explanation: "Fetch logs from a container",
    difficulty: "easy",
    category: "basics",
    exam_frequency: 10,
    certification_exam: "DCA",
    variations: ["docker logs -f <container>", "docker logs --tail 100 <container>"],
    flags: { "-f" => "follow log output", "--tail" => "number of lines from end", "--since" => "show logs since timestamp" },
    use_cases: "Debugging, monitoring application output",
    gotchas: "Only works with json-file and journald log drivers"
  },
  {
    command: "docker exec -it <container> bash",
    explanation: "Execute interactive bash shell in running container",
    difficulty: "easy",
    category: "basics",
    exam_frequency: 10,
    certification_exam: "DCA",
    variations: ["docker exec <container> ls /app", "docker exec -u root <container> bash"],
    flags: { "-i" => "interactive", "-t" => "allocate TTY", "-u" => "user" },
    use_cases: "Debugging, inspecting container filesystem",
    gotchas: "Container must be running, bash must be installed"
  },
  {
    command: "docker inspect <container>",
    explanation: "Display detailed information about container in JSON format",
    difficulty: "easy",
    category: "basics",
    exam_frequency: 9,
    certification_exam: "DCA",
    variations: ["docker inspect --format='{{.State.Status}}' <container>"],
    flags: { "--format" => "format output using Go template" },
    use_cases: "Get container IP, environment variables, volumes",
    gotchas: "Returns JSON array, use --format for specific fields"
  },

  # IMAGES - Building and Managing (High Frequency)
  {
    command: "docker build -t myapp:v1 .",
    explanation: "Build image from Dockerfile in current directory with tag",
    difficulty: "medium",
    category: "images",
    exam_frequency: 10,
    certification_exam: "DCA",
    variations: ["docker build -t myapp:latest -f Dockerfile.prod .", "docker build --no-cache -t myapp:v1 ."],
    flags: { "-t" => "name and tag", "-f" => "Dockerfile path", "--no-cache" => "don't use cache" },
    use_cases: "Create custom application images",
    gotchas: "Dot (.) specifies build context, affects COPY/ADD commands"
  },
  {
    command: "docker pull nginx:alpine",
    explanation: "Download nginx alpine image from Docker Hub",
    difficulty: "easy",
    category: "images",
    exam_frequency: 9,
    certification_exam: "DCA",
    variations: ["docker pull redis:6.2", "docker pull gcr.io/my-project/image:tag"],
    flags: { "-a" => "download all tags", "--platform" => "specify platform" },
    use_cases: "Download base images, application dependencies",
    gotchas: "Defaults to :latest if no tag specified"
  },
  {
    command: "docker push myrepo/myapp:v1",
    explanation: "Upload image to Docker registry",
    difficulty: "easy",
    category: "registry",
    exam_frequency: 9,
    certification_exam: "DCA",
    variations: ["docker push localhost:5000/myapp:v1"],
    flags: { "--all-tags" => "push all tags" },
    use_cases: "Share images, CI/CD deployment",
    gotchas: "Must login to registry first with docker login"
  },
  {
    command: "docker images",
    explanation: "List all local Docker images",
    difficulty: "easy",
    category: "images",
    exam_frequency: 10,
    certification_exam: "DCA",
    variations: ["docker images -a", "docker images --filter dangling=true"],
    flags: { "-a" => "show all images", "-q" => "quiet mode", "--filter" => "filter output" },
    use_cases: "Check available images, verify builds",
    gotchas: "Doesn't show intermediate layers without -a"
  },
  {
    command: "docker rmi <image>",
    explanation: "Remove one or more images",
    difficulty: "easy",
    category: "images",
    exam_frequency: 8,
    certification_exam: "DCA",
    variations: ["docker rmi -f <image>", "docker rmi $(docker images -q)"],
    flags: { "-f" => "force removal", "--no-prune" => "don't delete untagged parents" },
    use_cases: "Clean up disk space, remove old images",
    gotchas: "Cannot remove images used by containers"
  },
  {
    command: "docker tag myapp:v1 myrepo/myapp:latest",
    explanation: "Create a new tag for existing image",
    difficulty: "easy",
    category: "images",
    exam_frequency: 8,
    certification_exam: "DCA",
    variations: ["docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]"],
    flags: {},
    use_cases: "Prepare images for registry push, versioning",
    gotchas: "Both tags point to same image ID"
  },
  {
    command: "docker history <image>",
    explanation: "Show the history of an image (layers)",
    difficulty: "medium",
    category: "images",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker history --no-trunc <image>"],
    flags: { "--no-trunc" => "don't truncate output", "-q" => "quiet mode" },
    use_cases: "Understand image layers, optimize builds",
    gotchas: "Shows layers in reverse chronological order"
  },
  {
    command: "docker save -o myapp.tar myapp:v1",
    explanation: "Save image to tar archive file",
    difficulty: "medium",
    category: "images",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker save myapp:v1 | gzip > myapp.tar.gz"],
    flags: { "-o" => "output file" },
    use_cases: "Backup images, transfer without registry",
    gotchas: "Preserves layers and tags"
  },
  {
    command: "docker load -i myapp.tar",
    explanation: "Load image from tar archive",
    difficulty: "medium",
    category: "images",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker load < myapp.tar"],
    flags: { "-i" => "input file", "-q" => "suppress load output" },
    use_cases: "Restore images, import from backup",
    gotchas: "Restores with original tags"
  },

  # CONTAINERS - Advanced Operations
  {
    command: "docker run -d -p 8080:80 --name web nginx",
    explanation: "Run container with port mapping and custom name",
    difficulty: "easy",
    category: "containers",
    exam_frequency: 10,
    certification_exam: "DCA",
    variations: ["docker run -d -p 8080:80 -p 8443:443 nginx"],
    flags: { "-p" => "publish port", "--name" => "container name" },
    use_cases: "Expose web services on specific ports",
    gotchas: "Host port must be available"
  },
  {
    command: "docker run -d -v /host/path:/container/path nginx",
    explanation: "Run container with bind mount volume",
    difficulty: "medium",
    category: "volumes",
    exam_frequency: 9,
    certification_exam: "DCA",
    variations: ["docker run -d -v myvolume:/data nginx", "docker run -d -v /host:/container:ro nginx"],
    flags: { "-v" => "volume mount", ":ro" => "read-only" },
    use_cases: "Persist data, share files between host and container",
    gotchas: "Bind mounts require absolute paths"
  },
  {
    command: "docker run -d --env MY_VAR=value nginx",
    explanation: "Run container with environment variable",
    difficulty: "easy",
    category: "containers",
    exam_frequency: 9,
    certification_exam: "DCA",
    variations: ["docker run -d --env-file .env nginx", "docker run -d -e VAR1=val1 -e VAR2=val2 nginx"],
    flags: { "--env" => "set environment variable", "--env-file" => "read from file" },
    use_cases: "Configuration management, pass secrets",
    gotchas: "Environment variables visible in inspect output"
  },
  {
    command: "docker run -d --restart unless-stopped nginx",
    explanation: "Run container with restart policy",
    difficulty: "medium",
    category: "containers",
    exam_frequency: 8,
    certification_exam: "DCA",
    variations: ["docker run -d --restart always nginx", "docker run -d --restart on-failure:3 nginx"],
    flags: { "--restart" => "restart policy (no|on-failure|always|unless-stopped)" },
    use_cases: "Ensure high availability, automatic recovery",
    gotchas: "unless-stopped won't restart if manually stopped"
  },
  {
    command: "docker run -d --memory 512m --cpus 1.5 nginx",
    explanation: "Run container with resource limits",
    difficulty: "medium",
    category: "containers",
    exam_frequency: 9,
    certification_exam: "DCA",
    variations: ["docker run -d --memory 1g --memory-reservation 512m nginx"],
    flags: { "--memory" => "memory limit", "--cpus" => "CPU limit", "--memory-swap" => "swap limit" },
    use_cases: "Resource management, prevent container from consuming all resources",
    gotchas: "Requires swap accounting enabled on host"
  },
  {
    command: "docker stats",
    explanation: "Display live stream of container resource usage statistics",
    difficulty: "easy",
    category: "containers",
    exam_frequency: 8,
    certification_exam: "DCA",
    variations: ["docker stats --no-stream", "docker stats <container>"],
    flags: { "--no-stream" => "disable streaming", "--format" => "format output" },
    use_cases: "Monitor container performance, resource usage",
    gotchas: "Shows real-time stats, press Ctrl+C to exit"
  },
  {
    command: "docker top <container>",
    explanation: "Display running processes inside container",
    difficulty: "easy",
    category: "containers",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker top <container> aux"],
    flags: {},
    use_cases: "Troubleshoot container processes",
    gotchas: "Output format depends on host ps command"
  },
  {
    command: "docker cp <container>:/path/file.txt ./local/",
    explanation: "Copy files between container and host",
    difficulty: "medium",
    category: "containers",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker cp ./local/file.txt <container>:/path/"],
    flags: { "-L" => "follow symlinks" },
    use_cases: "Extract logs, copy configuration files",
    gotchas: "Works on stopped containers too"
  },
  {
    command: "docker port <container>",
    explanation: "List port mappings for container",
    difficulty: "easy",
    category: "containers",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker port <container> 80"],
    flags: {},
    use_cases: "Check which host port maps to container port",
    gotchas: "Only shows published ports"
  },
  {
    command: "docker rename old_name new_name",
    explanation: "Rename a container",
    difficulty: "easy",
    category: "containers",
    exam_frequency: 5,
    certification_exam: "DCA",
    variations: [],
    flags: {},
    use_cases: "Fix naming mistakes, reorganize containers",
    gotchas: "Container can be running or stopped"
  },
  {
    command: "docker wait <container>",
    explanation: "Block until container stops, then print exit code",
    difficulty: "medium",
    category: "containers",
    exam_frequency: 5,
    certification_exam: "DCA",
    variations: ["docker wait container1 container2"],
    flags: {},
    use_cases: "Scripting, wait for container completion",
    gotchas: "Blocks until container exits"
  },
  {
    command: "docker attach <container>",
    explanation: "Attach to running container's STDIN, STDOUT, STDERR",
    difficulty: "medium",
    category: "containers",
    exam_frequency: 6,
    certification_exam: "DCA",
    variations: ["docker attach --no-stdin <container>"],
    flags: { "--no-stdin" => "don't attach STDIN", "--sig-proxy" => "proxy signals" },
    use_cases: "View container output, interact with process",
    gotchas: "Detach with Ctrl+P, Ctrl+Q (Ctrl+C stops container)"
  },
  {
    command: "docker diff <container>",
    explanation: "Inspect changes to files or directories on container filesystem",
    difficulty: "medium",
    category: "containers",
    exam_frequency: 6,
    certification_exam: "DCA",
    variations: [],
    flags: {},
    use_cases: "Debug filesystem changes, understand container modifications",
    gotchas: "Shows A (added), D (deleted), C (changed)"
  },
  {
    command: "docker commit <container> myimage:v2",
    explanation: "Create new image from container's changes",
    difficulty: "medium",
    category: "images",
    exam_frequency: 6,
    certification_exam: "DCA",
    variations: ["docker commit -m 'message' -a 'author' <container> myimage:v2"],
    flags: { "-m" => "commit message", "-a" => "author", "-p" => "pause container" },
    use_cases: "Save container state, create custom images",
    gotchas: "Better to use Dockerfile for reproducibility"
  },

  # NETWORKS - Networking (High Frequency)
  {
    command: "docker network create my-network",
    explanation: "Create a new Docker network",
    difficulty: "easy",
    category: "networks",
    exam_frequency: 9,
    certification_exam: "DCA",
    variations: ["docker network create --driver bridge my-network", "docker network create --subnet 172.20.0.0/16 my-network"],
    flags: { "--driver" => "network driver", "--subnet" => "subnet", "--gateway" => "gateway" },
    use_cases: "Isolate containers, custom networking",
    gotchas: "Default driver is bridge"
  },
  {
    command: "docker network ls",
    explanation: "List all Docker networks",
    difficulty: "easy",
    category: "networks",
    exam_frequency: 9,
    certification_exam: "DCA",
    variations: ["docker network ls --filter driver=bridge"],
    flags: { "--filter" => "filter output", "-q" => "quiet mode" },
    use_cases: "View available networks, troubleshooting",
    gotchas: "Shows bridge, host, none by default"
  },
  {
    command: "docker network inspect my-network",
    explanation: "Display detailed information about network",
    difficulty: "medium",
    category: "networks",
    exam_frequency: 8,
    certification_exam: "DCA",
    variations: ["docker network inspect --format='{{.IPAM.Config}}' my-network"],
    flags: { "--format" => "format output" },
    use_cases: "Get network configuration, find connected containers",
    gotchas: "Shows containers, subnet, gateway, driver"
  },
  {
    command: "docker network connect my-network <container>",
    explanation: "Connect container to network",
    difficulty: "medium",
    category: "networks",
    exam_frequency: 8,
    certification_exam: "DCA",
    variations: ["docker network connect --ip 172.20.0.10 my-network <container>"],
    flags: { "--ip" => "IPv4 address", "--alias" => "network-scoped alias" },
    use_cases: "Add container to additional network, multi-network setup",
    gotchas: "Container can connect to multiple networks"
  },
  {
    command: "docker network disconnect my-network <container>",
    explanation: "Disconnect container from network",
    difficulty: "medium",
    category: "networks",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker network disconnect -f my-network <container>"],
    flags: { "-f" => "force disconnect" },
    use_cases: "Isolate container, troubleshooting",
    gotchas: "Cannot disconnect from default bridge"
  },
  {
    command: "docker network rm my-network",
    explanation: "Remove one or more networks",
    difficulty: "easy",
    category: "networks",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker network rm $(docker network ls -q)"],
    flags: {},
    use_cases: "Clean up unused networks",
    gotchas: "Cannot remove network with connected containers"
  },
  {
    command: "docker run -d --network my-network nginx",
    explanation: "Run container connected to specific network",
    difficulty: "easy",
    category: "networks",
    exam_frequency: 9,
    certification_exam: "DCA",
    variations: ["docker run -d --network host nginx"],
    flags: { "--network" => "network to connect to" },
    use_cases: "Container networking, service communication",
    gotchas: "Network must exist before starting container"
  },
  {
    command: "docker network prune",
    explanation: "Remove all unused networks",
    difficulty: "easy",
    category: "networks",
    exam_frequency: 6,
    certification_exam: "DCA",
    variations: ["docker network prune -f"],
    flags: { "-f" => "don't prompt for confirmation", "--filter" => "filter networks" },
    use_cases: "Clean up disk space, maintenance",
    gotchas: "Only removes networks not connected to containers"
  },

  # VOLUMES - Data Management (High Frequency)
  {
    command: "docker volume create my-volume",
    explanation: "Create a new volume",
    difficulty: "easy",
    category: "volumes",
    exam_frequency: 9,
    certification_exam: "DCA",
    variations: ["docker volume create --driver local my-volume", "docker volume create --label env=prod my-volume"],
    flags: { "--driver" => "volume driver", "--label" => "metadata", "--opt" => "driver options" },
    use_cases: "Persistent data storage, database volumes",
    gotchas: "Volumes persist after container removal"
  },
  {
    command: "docker volume ls",
    explanation: "List all volumes",
    difficulty: "easy",
    category: "volumes",
    exam_frequency: 9,
    certification_exam: "DCA",
    variations: ["docker volume ls --filter dangling=true"],
    flags: { "--filter" => "filter output", "-q" => "quiet mode" },
    use_cases: "Check available volumes, find unused volumes",
    gotchas: "Dangling volumes are not attached to containers"
  },
  {
    command: "docker volume inspect my-volume",
    explanation: "Display detailed information about volume",
    difficulty: "medium",
    category: "volumes",
    exam_frequency: 8,
    certification_exam: "DCA",
    variations: ["docker volume inspect --format='{{.Mountpoint}}' my-volume"],
    flags: { "--format" => "format output" },
    use_cases: "Get volume path, check configuration",
    gotchas: "Shows mountpoint on host filesystem"
  },
  {
    command: "docker volume rm my-volume",
    explanation: "Remove one or more volumes",
    difficulty: "easy",
    category: "volumes",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker volume rm $(docker volume ls -q)"],
    flags: { "-f" => "force removal" },
    use_cases: "Clean up disk space, remove unused volumes",
    gotchas: "Cannot remove volumes in use by containers"
  },
  {
    command: "docker volume prune",
    explanation: "Remove all unused volumes",
    difficulty: "easy",
    category: "volumes",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker volume prune -f"],
    flags: { "-f" => "don't prompt", "--filter" => "filter volumes" },
    use_cases: "Clean up disk space, maintenance",
    gotchas: "Removes all volumes not attached to containers"
  },
  {
    command: "docker run -d --mount source=my-volume,target=/data nginx",
    explanation: "Run container with volume using mount syntax",
    difficulty: "medium",
    category: "volumes",
    exam_frequency: 8,
    certification_exam: "DCA",
    variations: ["docker run -d --mount type=bind,source=/host/path,target=/container/path nginx"],
    flags: { "--mount" => "mount configuration", "type" => "bind|volume|tmpfs", "readonly" => "read-only" },
    use_cases: "Modern volume mounting, explicit configuration",
    gotchas: "More verbose but clearer than -v flag"
  },

  # REGISTRY - Image Distribution
  {
    command: "docker login",
    explanation: "Log in to Docker registry",
    difficulty: "easy",
    category: "registry",
    exam_frequency: 8,
    certification_exam: "DCA",
    variations: ["docker login -u username -p password registry.example.com"],
    flags: { "-u" => "username", "-p" => "password", "--password-stdin" => "read password from stdin" },
    use_cases: "Authenticate to push/pull private images",
    gotchas: "Credentials stored in ~/.docker/config.json"
  },
  {
    command: "docker logout",
    explanation: "Log out from Docker registry",
    difficulty: "easy",
    category: "registry",
    exam_frequency: 6,
    certification_exam: "DCA",
    variations: ["docker logout registry.example.com"],
    flags: {},
    use_cases: "Remove stored credentials",
    gotchas: "Defaults to Docker Hub if no registry specified"
  },
  {
    command: "docker search nginx",
    explanation: "Search Docker Hub for images",
    difficulty: "easy",
    category: "registry",
    exam_frequency: 6,
    certification_exam: "DCA",
    variations: ["docker search --filter stars=100 nginx", "docker search --limit 10 nginx"],
    flags: { "--filter" => "filter results", "--limit" => "max results", "--no-trunc" => "don't truncate" },
    use_cases: "Find public images, discover alternatives",
    gotchas: "Only searches Docker Hub by default"
  },

  # SWARM - Orchestration (High Frequency for DCA)
  {
    command: "docker swarm init",
    explanation: "Initialize a swarm (create manager node)",
    difficulty: "medium",
    category: "swarm",
    exam_frequency: 10,
    certification_exam: "DCA",
    variations: ["docker swarm init --advertise-addr 192.168.1.100"],
    flags: { "--advertise-addr" => "advertised address", "--listen-addr" => "listen address" },
    use_cases: "Create Docker Swarm cluster, orchestration",
    gotchas: "Node becomes manager, outputs join token for workers"
  },
  {
    command: "docker swarm join --token <token> <manager-ip>:2377",
    explanation: "Join node to swarm as worker",
    difficulty: "medium",
    category: "swarm",
    exam_frequency: 9,
    certification_exam: "DCA",
    variations: ["docker swarm join --token <token> --advertise-addr 192.168.1.101 <manager>:2377"],
    flags: { "--token" => "join token", "--advertise-addr" => "advertised address" },
    use_cases: "Add worker nodes to cluster",
    gotchas: "Port 2377 is default for swarm management"
  },
  {
    command: "docker service create --name web --replicas 3 nginx",
    explanation: "Create a service with 3 replicas",
    difficulty: "medium",
    category: "swarm",
    exam_frequency: 10,
    certification_exam: "DCA",
    variations: ["docker service create --name web -p 8080:80 --replicas 3 nginx"],
    flags: { "--replicas" => "number of tasks", "-p" => "publish port", "--name" => "service name" },
    use_cases: "Deploy scalable services, high availability",
    gotchas: "Service runs on swarm, not single node"
  },
  {
    command: "docker service ls",
    explanation: "List all services in swarm",
    difficulty: "easy",
    category: "swarm",
    exam_frequency: 9,
    certification_exam: "DCA",
    variations: ["docker service ls --filter name=web"],
    flags: { "--filter" => "filter services", "-q" => "quiet mode" },
    use_cases: "View deployed services, monitoring",
    gotchas: "Only works on manager nodes"
  },
  {
    command: "docker service ps <service>",
    explanation: "List tasks of service",
    difficulty: "easy",
    category: "swarm",
    exam_frequency: 9,
    certification_exam: "DCA",
    variations: ["docker service ps --filter desired-state=running <service>"],
    flags: { "--filter" => "filter tasks", "--no-trunc" => "don't truncate" },
    use_cases: "Check service distribution, troubleshoot failures",
    gotchas: "Shows which nodes are running tasks"
  },
  {
    command: "docker service scale <service>=5",
    explanation: "Scale service to 5 replicas",
    difficulty: "medium",
    category: "swarm",
    exam_frequency: 9,
    certification_exam: "DCA",
    variations: ["docker service scale web=3 api=5"],
    flags: {},
    use_cases: "Increase/decrease service capacity",
    gotchas: "Can scale multiple services at once"
  },
  {
    command: "docker service update --image nginx:alpine <service>",
    explanation: "Update service with new image (rolling update)",
    difficulty: "medium",
    category: "swarm",
    exam_frequency: 8,
    certification_exam: "DCA",
    variations: ["docker service update --env-add KEY=VALUE <service>"],
    flags: { "--image" => "update image", "--env-add" => "add env var", "--rollback" => "rollback update" },
    use_cases: "Deploy updates without downtime",
    gotchas: "Rolling update by default, configurable with --update-* flags"
  },
  {
    command: "docker service rm <service>",
    explanation: "Remove service from swarm",
    difficulty: "easy",
    category: "swarm",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker service rm service1 service2"],
    flags: {},
    use_cases: "Clean up services, teardown",
    gotchas: "Removes all tasks of service"
  },
  {
    command: "docker service logs <service>",
    explanation: "Fetch logs of service or task",
    difficulty: "medium",
    category: "swarm",
    exam_frequency: 8,
    certification_exam: "DCA",
    variations: ["docker service logs -f <service>", "docker service logs --tail 100 <service>"],
    flags: { "-f" => "follow logs", "--tail" => "number of lines", "--since" => "since timestamp" },
    use_cases: "Debug service issues, monitor output",
    gotchas: "Aggregates logs from all tasks"
  },
  {
    command: "docker node ls",
    explanation: "List all nodes in swarm",
    difficulty: "easy",
    category: "swarm",
    exam_frequency: 9,
    certification_exam: "DCA",
    variations: ["docker node ls --filter role=manager"],
    flags: { "--filter" => "filter nodes", "-q" => "quiet mode" },
    use_cases: "Check cluster health, node status",
    gotchas: "Shows manager and worker nodes"
  },
  {
    command: "docker node inspect <node>",
    explanation: "Display detailed information about node",
    difficulty: "medium",
    category: "swarm",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker node inspect --format='{{.Status.State}}' <node>"],
    flags: { "--format" => "format output" },
    use_cases: "Get node details, troubleshoot",
    gotchas: "Shows availability, state, resources"
  },
  {
    command: "docker node update --availability drain <node>",
    explanation: "Drain node (stop scheduling new tasks)",
    difficulty: "medium",
    category: "swarm",
    exam_frequency: 8,
    certification_exam: "DCA",
    variations: ["docker node update --availability active <node>"],
    flags: { "--availability" => "active|pause|drain", "--label-add" => "add label" },
    use_cases: "Maintenance, graceful shutdown",
    gotchas: "Existing tasks are rescheduled on other nodes"
  },
  {
    command: "docker node promote <node>",
    explanation: "Promote worker node to manager",
    difficulty: "medium",
    category: "swarm",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker node promote node1 node2"],
    flags: {},
    use_cases: "Increase manager redundancy",
    gotchas: "Requires quorum of managers to function"
  },
  {
    command: "docker node demote <node>",
    explanation: "Demote manager node to worker",
    difficulty: "medium",
    category: "swarm",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker node demote node1 node2"],
    flags: {},
    use_cases: "Reduce manager count, rebalance",
    gotchas: "Must maintain at least 1 manager"
  },
  {
    command: "docker stack deploy -c docker-compose.yml myapp",
    explanation: "Deploy stack from compose file",
    difficulty: "medium",
    category: "swarm",
    exam_frequency: 9,
    certification_exam: "DCA",
    variations: ["docker stack deploy -c compose1.yml -c compose2.yml myapp"],
    flags: { "-c" => "compose file", "--prune" => "prune services", "--resolve-image" => "query registry" },
    use_cases: "Deploy multi-service applications",
    gotchas: "Uses version 3+ compose file format"
  },
  {
    command: "docker stack ls",
    explanation: "List all stacks",
    difficulty: "easy",
    category: "swarm",
    exam_frequency: 8,
    certification_exam: "DCA",
    variations: [],
    flags: {},
    use_cases: "View deployed stacks",
    gotchas: "Shows number of services per stack"
  },
  {
    command: "docker stack ps <stack>",
    explanation: "List tasks in stack",
    difficulty: "easy",
    category: "swarm",
    exam_frequency: 8,
    certification_exam: "DCA",
    variations: ["docker stack ps --filter desired-state=running <stack>"],
    flags: { "--filter" => "filter tasks", "--no-trunc" => "don't truncate" },
    use_cases: "Monitor stack deployment, troubleshoot",
    gotchas: "Shows all tasks across all services"
  },
  {
    command: "docker stack rm <stack>",
    explanation: "Remove stack",
    difficulty: "easy",
    category: "swarm",
    exam_frequency: 8,
    certification_exam: "DCA",
    variations: [],
    flags: {},
    use_cases: "Teardown applications, cleanup",
    gotchas: "Removes all services and networks in stack"
  },
  {
    command: "docker stack services <stack>",
    explanation: "List services in stack",
    difficulty: "easy",
    category: "swarm",
    exam_frequency: 8,
    certification_exam: "DCA",
    variations: ["docker stack services --filter name=web <stack>"],
    flags: { "--filter" => "filter services", "-q" => "quiet mode" },
    use_cases: "View stack services, monitoring",
    gotchas: "Shows replicas and ports"
  },
  {
    command: "docker secret create my-secret secret.txt",
    explanation: "Create secret from file",
    difficulty: "medium",
    category: "security",
    exam_frequency: 8,
    certification_exam: "DCA",
    variations: ["echo 'password' | docker secret create my-secret -"],
    flags: { "-l" => "labels" },
    use_cases: "Securely store passwords, certificates",
    gotchas: "Secrets are encrypted at rest and in transit"
  },
  {
    command: "docker secret ls",
    explanation: "List all secrets",
    difficulty: "easy",
    category: "security",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker secret ls --filter name=my"],
    flags: { "--filter" => "filter secrets", "-q" => "quiet mode" },
    use_cases: "View available secrets",
    gotchas: "Cannot view secret values after creation"
  },
  {
    command: "docker secret inspect <secret>",
    explanation: "Display detailed information about secret",
    difficulty: "medium",
    category: "security",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker secret inspect --format='{{.CreatedAt}}' <secret>"],
    flags: { "--format" => "format output" },
    use_cases: "Check secret metadata",
    gotchas: "Does not show secret data"
  },
  {
    command: "docker secret rm <secret>",
    explanation: "Remove secret",
    difficulty: "easy",
    category: "security",
    exam_frequency: 6,
    certification_exam: "DCA",
    variations: [],
    flags: {},
    use_cases: "Clean up secrets, rotate credentials",
    gotchas: "Cannot remove secrets in use by services"
  },
  {
    command: "docker config create my-config config.txt",
    explanation: "Create config from file",
    difficulty: "medium",
    category: "swarm",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["echo 'data' | docker config create my-config -"],
    flags: { "-l" => "labels" },
    use_cases: "Store non-sensitive configuration",
    gotchas: "Configs are not encrypted like secrets"
  },
  {
    command: "docker config ls",
    explanation: "List all configs",
    difficulty: "easy",
    category: "swarm",
    exam_frequency: 6,
    certification_exam: "DCA",
    variations: ["docker config ls --filter name=my"],
    flags: { "--filter" => "filter configs", "-q" => "quiet mode" },
    use_cases: "View available configs",
    gotchas: "Similar to secrets but for non-sensitive data"
  },

  # COMPOSE - Multi-Container Applications
  {
    command: "docker-compose up -d",
    explanation: "Start all services defined in docker-compose.yml in detached mode",
    difficulty: "easy",
    category: "compose",
    exam_frequency: 9,
    certification_exam: "DCA",
    variations: ["docker-compose up -d --build", "docker-compose -f custom.yml up -d"],
    flags: { "-d" => "detached mode", "--build" => "build images before starting", "-f" => "compose file" },
    use_cases: "Start multi-container applications",
    gotchas: "Uses docker-compose.yml by default"
  },
  {
    command: "docker-compose down",
    explanation: "Stop and remove containers, networks created by up",
    difficulty: "easy",
    category: "compose",
    exam_frequency: 9,
    certification_exam: "DCA",
    variations: ["docker-compose down -v", "docker-compose down --rmi all"],
    flags: { "-v" => "remove volumes", "--rmi" => "remove images (all|local)" },
    use_cases: "Teardown application, cleanup",
    gotchas: "Does not remove volumes by default"
  },
  {
    command: "docker-compose ps",
    explanation: "List containers started by compose",
    difficulty: "easy",
    category: "compose",
    exam_frequency: 8,
    certification_exam: "DCA",
    variations: ["docker-compose ps -a"],
    flags: { "-a" => "show all containers", "-q" => "quiet mode" },
    use_cases: "Check service status",
    gotchas: "Only shows containers managed by this compose file"
  },
  {
    command: "docker-compose logs",
    explanation: "View output from containers",
    difficulty: "easy",
    category: "compose",
    exam_frequency: 8,
    certification_exam: "DCA",
    variations: ["docker-compose logs -f web", "docker-compose logs --tail 100"],
    flags: { "-f" => "follow logs", "--tail" => "number of lines" },
    use_cases: "Debug applications, monitor output",
    gotchas: "Shows logs from all services unless specified"
  },
  {
    command: "docker-compose exec <service> bash",
    explanation: "Execute command in running service container",
    difficulty: "easy",
    category: "compose",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker-compose exec -T web sh -c 'echo test'"],
    flags: { "-T" => "disable TTY", "-u" => "user" },
    use_cases: "Debug services, run commands",
    gotchas: "Service must be running"
  },
  {
    command: "docker-compose build",
    explanation: "Build or rebuild services",
    difficulty: "easy",
    category: "compose",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker-compose build --no-cache web"],
    flags: { "--no-cache" => "don't use cache", "--pull" => "pull newer base images" },
    use_cases: "Rebuild images after code changes",
    gotchas: "Only builds services with 'build' defined"
  },
  {
    command: "docker-compose restart <service>",
    explanation: "Restart service containers",
    difficulty: "easy",
    category: "compose",
    exam_frequency: 6,
    certification_exam: "DCA",
    variations: ["docker-compose restart"],
    flags: { "-t" => "timeout before killing" },
    use_cases: "Apply configuration changes, troubleshoot",
    gotchas: "Restarts all services if none specified"
  },
  {
    command: "docker-compose scale web=3",
    explanation: "Scale service to specified number of containers",
    difficulty: "medium",
    category: "compose",
    exam_frequency: 6,
    certification_exam: "DCA",
    variations: ["docker-compose scale web=3 api=2"],
    flags: {},
    use_cases: "Horizontal scaling of services",
    gotchas: "Deprecated in favor of docker-compose up --scale"
  },

  # SYSTEM - Maintenance and Information
  {
    command: "docker system df",
    explanation: "Show docker disk usage",
    difficulty: "easy",
    category: "basics",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker system df -v"],
    flags: { "-v" => "verbose output" },
    use_cases: "Check disk space used by Docker",
    gotchas: "Shows images, containers, volumes, build cache"
  },
  {
    command: "docker system prune",
    explanation: "Remove unused data (containers, networks, images, cache)",
    difficulty: "easy",
    category: "basics",
    exam_frequency: 8,
    certification_exam: "DCA",
    variations: ["docker system prune -a", "docker system prune --volumes"],
    flags: { "-a" => "remove all unused images", "--volumes" => "prune volumes", "-f" => "no confirmation" },
    use_cases: "Clean up disk space, maintenance",
    gotchas: "Very aggressive cleanup, be careful in production"
  },
  {
    command: "docker system info",
    explanation: "Display system-wide information",
    difficulty: "easy",
    category: "basics",
    exam_frequency: 8,
    certification_exam: "DCA",
    variations: ["docker info"],
    flags: { "--format" => "format output" },
    use_cases: "Check Docker version, configuration, storage driver",
    gotchas: "Shows swarm status, plugins, runtime"
  },
  {
    command: "docker version",
    explanation: "Show Docker version information",
    difficulty: "easy",
    category: "basics",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker version --format '{{.Server.Version}}'"],
    flags: { "--format" => "format output" },
    use_cases: "Verify installation, check compatibility",
    gotchas: "Shows client and server versions"
  },
  {
    command: "docker events",
    explanation: "Get real-time events from server",
    difficulty: "medium",
    category: "basics",
    exam_frequency: 6,
    certification_exam: "DCA",
    variations: ["docker events --filter event=start", "docker events --since '2023-01-01'"],
    flags: { "--filter" => "filter events", "--since" => "show events since timestamp", "--until" => "until timestamp" },
    use_cases: "Monitor Docker activity, debugging",
    gotchas: "Streams events in real-time, Ctrl+C to exit"
  },

  # ADDITIONAL HIGH-FREQUENCY COMMANDS
  {
    command: "docker run -d --health-cmd='curl -f http://localhost/ || exit 1' nginx",
    explanation: "Run container with health check",
    difficulty: "medium",
    category: "containers",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker run -d --health-interval=30s --health-retries=3 nginx"],
    flags: { "--health-cmd" => "health check command", "--health-interval" => "interval", "--health-retries" => "retries" },
    use_cases: "Monitor container health, automatic restart",
    gotchas: "Health status shown in docker ps"
  },
  {
    command: "docker update --restart unless-stopped <container>",
    explanation: "Update container configuration without recreating",
    difficulty: "medium",
    category: "containers",
    exam_frequency: 6,
    certification_exam: "DCA",
    variations: ["docker update --memory 1g --cpus 2 <container>"],
    flags: { "--restart" => "restart policy", "--memory" => "memory limit", "--cpus" => "CPU limit" },
    use_cases: "Change resource limits, restart policy",
    gotchas: "Limited set of updatable properties"
  },
  {
    command: "docker pause <container>",
    explanation: "Pause all processes in container",
    difficulty: "easy",
    category: "containers",
    exam_frequency: 5,
    certification_exam: "DCA",
    variations: [],
    flags: {},
    use_cases: "Temporarily freeze container, save resources",
    gotchas: "Uses cgroup freezer, not SIGSTOP"
  },
  {
    command: "docker unpause <container>",
    explanation: "Resume all processes in paused container",
    difficulty: "easy",
    category: "containers",
    exam_frequency: 5,
    certification_exam: "DCA",
    variations: [],
    flags: {},
    use_cases: "Resume paused container",
    gotchas: "Container must be in paused state"
  },
  {
    command: "docker container prune",
    explanation: "Remove all stopped containers",
    difficulty: "easy",
    category: "containers",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker container prune -f", "docker container prune --filter until=24h"],
    flags: { "-f" => "no confirmation", "--filter" => "filter containers" },
    use_cases: "Clean up disk space, maintenance",
    gotchas: "Only removes stopped containers"
  },
  {
    command: "docker image prune",
    explanation: "Remove unused images",
    difficulty: "easy",
    category: "images",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker image prune -a", "docker image prune --filter until=24h"],
    flags: { "-a" => "remove all unused", "--filter" => "filter images", "-f" => "no confirmation" },
    use_cases: "Free up disk space, cleanup",
    gotchas: "Without -a, only removes dangling images"
  },
  {
    command: "docker export <container> > backup.tar",
    explanation: "Export container filesystem as tar archive",
    difficulty: "medium",
    category: "containers",
    exam_frequency: 5,
    certification_exam: "DCA",
    variations: ["docker export -o backup.tar <container>"],
    flags: { "-o" => "output file" },
    use_cases: "Backup container filesystem, migration",
    gotchas: "Exports filesystem only, not image layers"
  },
  {
    command: "docker import backup.tar myimage:v1",
    explanation: "Import tarball to create filesystem image",
    difficulty: "medium",
    category: "images",
    exam_frequency: 5,
    certification_exam: "DCA",
    variations: ["cat backup.tar | docker import - myimage:v1"],
    flags: { "-c" => "apply Dockerfile instruction", "-m" => "commit message" },
    use_cases: "Restore from export, create base images",
    gotchas: "Creates single layer image"
  },
  {
    command: "docker kill <container>",
    explanation: "Kill running container by sending SIGKILL",
    difficulty: "easy",
    category: "containers",
    exam_frequency: 6,
    certification_exam: "DCA",
    variations: ["docker kill -s SIGTERM <container>"],
    flags: { "-s" => "signal to send" },
    use_cases: "Force stop unresponsive container",
    gotchas: "More aggressive than docker stop"
  },
  {
    command: "docker run --rm -it alpine sh",
    explanation: "Run container and automatically remove when it exits",
    difficulty: "easy",
    category: "containers",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker run --rm -v $(pwd):/work alpine ls /work"],
    flags: { "--rm" => "automatically remove", "-i" => "interactive", "-t" => "TTY" },
    use_cases: "Temporary containers, testing, scripts",
    gotchas: "Container and volumes are removed on exit"
  },
  {
    command: "docker run -d --log-driver json-file --log-opt max-size=10m nginx",
    explanation: "Run container with logging configuration",
    difficulty: "medium",
    category: "containers",
    exam_frequency: 6,
    certification_exam: "DCA",
    variations: ["docker run -d --log-driver syslog --log-opt syslog-address=tcp://192.168.0.1:514 nginx"],
    flags: { "--log-driver" => "logging driver", "--log-opt" => "logging options" },
    use_cases: "Manage log file size, centralized logging",
    gotchas: "Log drivers: json-file, syslog, journald, etc."
  },
  {
    command: "docker service create --mode global nginx",
    explanation: "Create service with global mode (one task per node)",
    difficulty: "medium",
    category: "swarm",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker service create --mode global --constraint node.role==worker nginx"],
    flags: { "--mode" => "replicated|global", "--constraint" => "placement constraint" },
    use_cases: "Monitoring agents, logging collectors",
    gotchas: "Runs exactly one task on each node"
  },
  {
    command: "docker service create --constraint node.labels.env==prod nginx",
    explanation: "Create service with node constraint",
    difficulty: "medium",
    category: "swarm",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker service create --constraint node.role==worker nginx"],
    flags: { "--constraint" => "placement constraint" },
    use_cases: "Control service placement, resource isolation",
    gotchas: "Constraints: node.labels, node.role, node.hostname, etc."
  },
  {
    command: "docker service create --publish published=8080,target=80 nginx",
    explanation: "Create service with published port using long syntax",
    difficulty: "medium",
    category: "swarm",
    exam_frequency: 7,
    certification_exam: "DCA",
    variations: ["docker service create --publish published=8080,target=80,protocol=tcp,mode=ingress nginx"],
    flags: { "--publish" => "publish port", "mode" => "ingress|host" },
    use_cases: "Expose services, load balancing",
    gotchas: "Ingress mode uses routing mesh"
  },
  {
    command: "docker node update --label-add env=prod <node>",
    explanation: "Add label to node",
    difficulty: "medium",
    category: "swarm",
    exam_frequency: 6,
    certification_exam: "DCA",
    variations: ["docker node update --label-rm env <node>"],
    flags: { "--label-add" => "add label", "--label-rm" => "remove label" },
    use_cases: "Node categorization, constraint-based scheduling",
    gotchas: "Labels used in service constraints"
  },
  {
    command: "docker swarm leave",
    explanation: "Leave swarm",
    difficulty: "easy",
    category: "swarm",
    exam_frequency: 6,
    certification_exam: "DCA",
    variations: ["docker swarm leave --force"],
    flags: { "--force" => "force leave even if manager" },
    use_cases: "Remove node from cluster, decommission",
    gotchas: "Manager must use --force, maintain quorum"
  },
  {
    command: "docker trust sign myimage:v1",
    explanation: "Sign image with Docker Content Trust",
    difficulty: "hard",
    category: "security",
    exam_frequency: 5,
    certification_exam: "DCA",
    variations: [],
    flags: {},
    use_cases: "Image verification, secure supply chain",
    gotchas: "Requires DOCKER_CONTENT_TRUST=1 environment variable"
  },
  {
    command: "docker plugin install <plugin>",
    explanation: "Install a plugin",
    difficulty: "hard",
    category: "basics",
    exam_frequency: 4,
    certification_exam: "DCA",
    variations: ["docker plugin install --grant-all-permissions <plugin>"],
    flags: { "--grant-all-permissions" => "grant all permissions", "--disable" => "install but don't enable" },
    use_cases: "Extend Docker functionality, custom volume drivers",
    gotchas: "Plugins run as separate processes"
  },
  {
    command: "docker context create remote --docker host=tcp://remote:2376",
    explanation: "Create context for remote Docker daemon",
    difficulty: "hard",
    category: "basics",
    exam_frequency: 5,
    certification_exam: "DCA",
    variations: ["docker context create remote --docker host=ssh://user@remote"],
    flags: { "--docker" => "Docker endpoint configuration" },
    use_cases: "Manage multiple Docker hosts, remote management",
    gotchas: "Use docker context use <context> to switch"
  }
]

# Create Docker Commands
docker_commands.each_with_index do |cmd_data, index|
  begin
    docker_cmd = DockerCommand.find_or_initialize_by(command: cmd_data[:command])
    docker_cmd.assign_attributes(cmd_data)
    
    if docker_cmd.save
      print "."
    else
      puts "\n❌ Failed to create: #{cmd_data[:command]}"
      puts "   Errors: #{docker_cmd.errors.full_messages.join(', ')}"
    end
  rescue => e
    puts "\n❌ Error on #{cmd_data[:command]}: #{e.message}"
  end
  
  # Progress indicator every 10 commands
  if (index + 1) % 10 == 0
    puts " #{index + 1}/#{docker_commands.length}"
  end
end

puts "\n\n✅ Docker Commands Seeding Complete!"
puts "   Total commands: #{DockerCommand.count}"
puts "   By difficulty:"
puts "     - Easy: #{DockerCommand.where(difficulty: 'easy').count}"
puts "     - Medium: #{DockerCommand.where(difficulty: 'medium').count}"
puts "     - Hard: #{DockerCommand.where(difficulty: 'hard').count}"
puts "   By category:"
DockerCommand.group(:category).count.each do |category, count|
  puts "     - #{category.capitalize}: #{count}"
end
puts "   High frequency (8+): #{DockerCommand.where('exam_frequency >= ?', 8).count}"
puts "\n🎓 DCA Exam Ready! 🐳"