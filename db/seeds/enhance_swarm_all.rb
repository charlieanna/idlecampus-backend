# Enhance Docker Swarm Chapters 42-49

puts "=" * 80
puts "Enhancing Docker Swarm Chapters 42-49..."
puts "=" * 80

swarm_chapters = [
  {
    slug: "codesprout-swarm-init-join",
    num: 42,
    command: "docker swarm init/join",
    title: "Initializing and Joining a Swarm",
    content: <<-'MD'
**Initializing and Joining a Docker Swarm** 🐝

Swarm is Docker's native clustering solution - critical 25% of DCA exam!

### What is Docker Swarm?

**Native clustering and orchestration for Docker:**
- Multiple Docker hosts → Single cluster
- Deploy services across hosts
- Load balancing
- High availability
- Self-healing

### Initializing a Swarm

**Create swarm manager:**
```bash
docker swarm init
```

**Output:**
```
Swarm initialized: current node (abc123) is now a manager.

To add a worker to this swarm, run:
    docker swarm join --token SWMTKN-1-xxx 192.168.1.100:2377

To add a manager to this swarm, run:
    docker swarm join-token manager
```

**With specific IP:**
```bash
docker swarm init --advertise-addr 192.168.1.100
```

### Joining a Swarm

**As worker:**
```bash
docker swarm join --token SWMTKN-1-xxx 192.168.1.100:2377
```

**As manager:**
```bash
# Get manager token on existing manager
docker swarm join-token manager

# Join as manager
docker swarm join --token SWMTKN-1-yyy 192.168.1.100:2377
```

### Swarm Tokens

**View worker token:**
```bash
docker swarm join-token worker
```

**View manager token:**
```bash
docker swarm join-token manager
```

**Rotate tokens (security):**
```bash
docker swarm join-token --rotate worker
docker swarm join-token --rotate manager
```

### DCA Exam Focus

Must know:
1. **docker swarm init** creates cluster
2. **join-token** for adding nodes
3. **Manager vs worker** nodes
4. **--advertise-addr** for specific IP
5. **Quorum** for manager nodes

### Swarm Roles

**Manager:**
- Orchestration
- Scheduling
- Maintains cluster state
- Should be odd number (3, 5, 7)

**Worker:**
- Run containers
- No orchestration role
- Can be promoted to manager

### Try it!

```bash
# Initialize swarm
docker swarm init

# Check status
docker info | grep Swarm

# View nodes
docker node ls

# Leave swarm (for testing)
docker swarm leave --force
```
    MD
  },
  {
    slug: "codesprout-swarm-nodes",
    num: 43,
    command: "docker node ls/inspect",
    title: "Managing Swarm Nodes",
    content: <<-'MD'
**Managing Docker Swarm Nodes** 🖥️

Node management is critical for maintaining Swarm clusters!

### Listing Nodes

**View all nodes:**
```bash
docker node ls
```

**Output:**
```
ID            HOSTNAME   STATUS    AVAILABILITY   MANAGER STATUS
abc123 *      manager1   Ready     Active         Leader
def456        worker1    Ready     Active         
ghi789        worker2    Ready     Active
```

**Columns:**
- ID: Node identifier
- HOSTNAME: Node name
- STATUS: Ready/Down
- AVAILABILITY: Active/Pause/Drain
- MANAGER STATUS: Leader/Reachable/-

### Inspecting Nodes

**View node details:**
```bash
docker node inspect NODE_ID
docker node inspect self  # Current node
```

**Get specific info:**
```bash
docker node inspect --pretty NODE_ID
```

### Node Availability

**Drain (remove containers):**
```bash
docker node update --availability drain worker1
# Stops scheduling new tasks
# Moves existing tasks to other nodes
```

**Pause (keep containers):**
```bash
docker node update --availability pause worker1
# Stops scheduling new tasks
# Keeps existing tasks running
```

**Active (normal):**
```bash
docker node update --availability active worker1
```

### Promoting/Demoting Nodes

**Promote worker to manager:**
```bash
docker node promote worker1
```

**Demote manager to worker:**
```bash
docker node demote manager2
```

### DCA Exam Focus

Must know:
1. **docker node ls** lists all nodes
2. **Availability:** active/pause/drain
3. **drain** moves tasks to other nodes
4. **promote/demote** changes role
5. **Manager quorum** needs majority

### Node Labels

**Add labels:**
```bash
docker node update --label-add env=production worker1
docker node update --label-add ssd=true worker2
```

**Use in service constraints:**
```bash
docker service create \
  --constraint 'node.labels.ssd==true' \
  postgres
# Runs only on nodes with ssd=true label
```

### Removing Nodes

**Leave swarm (on node):**
```bash
docker swarm leave
```

**Remove node (on manager):**
```bash
docker node rm worker1
# Node must leave first or be down
```

### Try it!

```bash
# View nodes
docker node ls

# Inspect current node
docker node inspect self

# Add label
docker node update --label-add env=dev self

# Check label
docker node inspect self | grep Labels
```
    MD
  },
  {
    slug: "codesprout-swarm-service-create",
    num: 44,
    command: "docker service create",
    title: "Creating Swarm Services",
    content: <<-'MD'
**Creating Docker Swarm Services** 🚀

Services are the core of Swarm orchestration - essential for DCA!

### docker service create

**Create service:**
```bash
docker service create --name web nginx
```

**With replicas:**
```bash
docker service create \
  --name web \
  --replicas 3 \
  nginx
# Runs 3 replicas across swarm
```

### Publishing Ports

**Ingress mode (default):**
```bash
docker service create \
  --name web \
  --publish 80:80 \
  nginx
# Accessible on ANY swarm node port 80
```

**Host mode:**
```bash
docker service create \
  --name web \
  --publish mode=host,published=80,target=80 \
  nginx
# Only accessible on nodes running the service
```

### Service Constraints

**Run on specific nodes:**
```bash
docker service create \
  --name db \
  --constraint 'node.role==manager' \
  postgres
# Runs only on manager nodes

docker service create \
  --name app \
  --constraint 'node.labels.ssd==true' \
  myapp
# Runs only on nodes with ssd=true label
```

### Environment Variables

**Set environment:**
```bash
docker service create \
  --name api \
  --env NODE_ENV=production \
  --env DB_HOST=postgres \
  myapi
```

### Volumes and Mounts

**Named volume:**
```bash
docker service create \
  --name db \
  --mount source=pgdata,target=/var/lib/postgresql/data \
  postgres
```

**Bind mount:**
```bash
docker service create \
  --name web \
  --mount type=bind,source=/host/html,target=/usr/share/nginx/html \
  nginx
```

### DCA Exam Focus

Must know:
1. **docker service create** creates services
2. **--replicas** sets instance count
3. **--publish** exposes ports (ingress by default)
4. **--constraint** controls placement
5. **Services vs containers** difference

### Listing and Inspecting Services

**List services:**
```bash
docker service ls
```

**Inspect service:**
```bash
docker service inspect web
docker service inspect --pretty web
```

**View service tasks:**
```bash
docker service ps web
```

### Updating Services

**Update image:**
```bash
docker service update --image nginx:1.25 web
```

**Update replicas:**
```bash
docker service update --replicas 5 web
```

### Try it!

```bash
# Create service
docker service create \
  --name testweb \
  --replicas 2 \
  --publish 8080:80 \
  nginx:alpine

# List services
docker service ls

# View tasks
docker service ps testweb

# Access service
curl localhost:8080

# Remove
docker service rm testweb
```
    MD
  },
  {
    slug: "codesprout-swarm-service-scale",
    num: 45,
    command: "docker service scale",
    title: "Scaling Swarm Services",
    content: <<-'MD'
**Scaling Docker Swarm Services** 📈

Dynamic scaling is a key advantage of Swarm orchestration!

### docker service scale

**Scale a service:**
```bash
docker service scale web=5
# Scales web service to 5 replicas
```

**Scale multiple services:**
```bash
docker service scale web=5 api=3 worker=10
```

### Viewing Replicas

**Check current scale:**
```bash
docker service ls
```

**Output:**
```
NAME    REPLICAS   IMAGE         PORTS
web     5/5        nginx:alpine  *:80->80/tcp
```

**View task distribution:**
```bash
docker service ps web
```

### Replicated vs Global Services

**Replicated (default):**
```bash
docker service create --replicas 3 nginx
# Runs 3 replicas across swarm
```

**Global (one per node):**
```bash
docker service create --mode global monitoring
# Runs 1 replica on EVERY node
```

**Use global for:**
- Monitoring agents
- Log collectors
- Node utilities

### Automatic Load Balancing

**Swarm routing mesh:**
```
Request to ANY node:80
    ↓
Swarm ingress network
    ↓
Load balanced to replicas
```

**All nodes route to service!**

### DCA Exam Focus

Must know:
1. **docker service scale** changes replicas
2. **Replicated vs global** modes
3. **Routing mesh** load balances
4. **Service VIP** for internal load balancing
5. **Can scale to zero** (pause service)

### Placement Preferences

**Spread across labels:**
```bash
docker service create \
  --replicas 6 \
  --placement-pref spread=node.labels.zone \
  web
# Distributes across different zones
```

### Auto-scaling Limitations

**Swarm doesn't auto-scale by default**
- Manual scaling only
- Can use external tools (e.g., Prometheus + custom scripts)
- Consider Kubernetes for advanced auto-scaling

### Try it!

```bash
# Create service
docker service create --name web --replicas 2 nginx:alpine

# Scale up
docker service scale web=5
docker service ps web  # See 5 tasks

# Scale down
docker service scale web=1
docker service ps web  # See 1 running, 4 shutdown

# Remove
docker service rm web
```
    MD
  },
  {
    slug: "codesprout-swarm-stack-deploy",
    num: 46,
    command: "docker stack deploy",
    title: "Deploying Stacks in Swarm",
    content: <<-'MD'
**Deploying Stacks in Docker Swarm** 📚

Stacks deploy multi-service apps to Swarm - like Compose for clusters!

### What is a Stack?

**Stack = Multiple services deployed as one unit**

Like docker-compose but for Swarm:
- Uses docker-compose.yml (v3+)
- Deploys to swarm cluster
- Manages services, networks, volumes

### docker stack deploy

**Deploy stack:**
```bash
docker stack deploy -c docker-compose.yml mystack
```

**Stack compose file (v3):**
```yaml
version: "3.8"

services:
  web:
    image: nginx:alpine
    ports:
      - "80:80"
    deploy:
      replicas: 3
  
  api:
    image: myapi:latest
    deploy:
      replicas: 2

networks:
  default:
    driver: overlay
```

### Stack Management Commands

**List stacks:**
```bash
docker stack ls
```

**List stack services:**
```bash
docker stack services mystack
```

**List stack tasks:**
```bash
docker stack ps mystack
```

**Remove stack:**
```bash
docker stack rm mystack
```

### Deploy Configuration

**deploy: section (Swarm-specific):**
```yaml
services:
  web:
    image: nginx
    deploy:
      replicas: 3
      update_config:
        parallelism: 1
        delay: 10s
      restart_policy:
        condition: on-failure
      placement:
        constraints:
          - node.role==worker
```

### Overlay Networks

**Swarm creates overlay networks automatically:**
```yaml
networks:
  frontend:
    driver: overlay
  backend:
    driver: overlay
```

**Enables multi-host networking!**

### DCA Exam Focus

Must know:
1. **docker stack deploy** deploys multi-service apps
2. **Requires Swarm mode**
3. **Uses compose file v3+**
4. **deploy: section** for Swarm configs
5. **Overlay networks** for multi-host

### Stack vs Compose

**Compose (single host):**
```bash
docker compose up
# For development
```

**Stack (swarm cluster):**
```bash
docker stack deploy -c compose.yml app
# For production clustering
```

### Complete Stack Example

```yaml
version: "3.8"

services:
  web:
    image: nginx:alpine
    ports:
      - "80:80"
    networks:
      - frontend
    deploy:
      replicas: 2
  
  api:
    image: myapi:1.0
    networks:
      - frontend
      - backend
    deploy:
      replicas: 3
  
  db:
    image: postgres:15
    networks:
      - backend
    volumes:
      - db-data:/var/lib/postgresql/data
    deploy:
      placement:
        constraints:
          - node.role==manager

networks:
  frontend:
    driver: overlay
  backend:
    driver: overlay

volumes:
  db-data:
```

### Try it!

```yaml
# stack.yml
version: "3.8"
services:
  web:
    image: nginx:alpine
    ports:
      - "8080:80"
    deploy:
      replicas: 2
```

```bash
# Deploy
docker stack deploy -c stack.yml test

# Check services
docker stack services test

# Check tasks
docker stack ps test

# Remove
docker stack rm test
```
    MD
  },
  {
    slug: "codesprout-swarm-rolling-updates",
    num: 47,
    command: "docker service update",
    title: "Rolling Updates and Rollbacks",
    content: <<-'MD'
**Rolling Updates and Rollbacks in Swarm** 🔄

Zero-downtime updates are critical for production Swarm clusters!

### docker service update

**Update service image:**
```bash
docker service update --image nginx:1.25 web
```

**Rolling update happens automatically:**
1. Update one replica
2. Verify it's healthy
3. Update next replica
4. Repeat until all updated

### Update Configuration

**Control update behavior:**
```yaml
deploy:
  update_config:
    parallelism: 2        # Update 2 at a time
    delay: 10s            # Wait 10s between batches
    failure_action: rollback  # Rollback on failure
    monitor: 5s           # Monitor period
    max_failure_ratio: 0.3    # Fail if 30% fail
```

**Command line:**
```bash
docker service update \
  --update-parallelism 2 \
  --update-delay 10s \
  --update-failure-action rollback \
  --image nginx:1.25 \
  web
```

### Rollback

**Manual rollback:**
```bash
docker service rollback web
# Reverts to previous configuration
```

**Automatic rollback:**
```yaml
deploy:
  update_config:
    failure_action: rollback
```

**If update fails, automatically rolls back!**

### Viewing Update Progress

**Watch update:**
```bash
docker service ps web
```

**Shows:**
- New tasks starting
- Old tasks shutting down
- Update progress

### DCA Exam Focus

Must know:
1. **docker service update** updates services
2. **Rolling update** default behavior
3. **--update-parallelism** controls batch size
4. **docker service rollback** reverts changes
5. **failure_action: rollback** for automatic rollback

### Update Strategies

**Recreate (all at once):**
```yaml
deploy:
  update_config:
    parallelism: 0  # All at once
```

**One at a time (safest):**
```yaml
deploy:
  update_config:
    parallelism: 1
    delay: 30s
```

**Batched (faster):**
```yaml
deploy:
  update_config:
    parallelism: 5
    delay: 10s
```

### Rollback Configuration

**Configure rollback behavior:**
```yaml
deploy:
  rollback_config:
    parallelism: 2
    delay: 5s
    failure_action: pause
    monitor: 10s
```

### Common Updates

**Update image:**
```bash
docker service update --image myapp:2.0 app
```

**Update environment:**
```bash
docker service update --env-add NEW_VAR=value app
```

**Update replicas:**
```bash
docker service update --replicas 5 app
```

**Update ports:**
```bash
docker service update --publish-add 8080:80 app
```

### Try it!

```bash
# Create service
docker service create \
  --name web \
  --replicas 3 \
  nginx:1.24

# Update to newer version
docker service update --image nginx:1.25 web

# Watch progress
watch docker service ps web

# Rollback
docker service rollback web

# Remove
docker service rm web
```
    MD
  },
  {
    slug: "codesprout-swarm-secrets",
    num: 48,
    command: "docker secret create",
    title: "Managing Secrets in Swarm",
    content: <<-'MD'
**Managing Secrets in Docker Swarm** 🔐

Secure secret management is essential for production Swarm clusters!

### What are Swarm Secrets?

**Encrypted storage for sensitive data:**
- Passwords
- API keys
- Certificates
- SSH keys

**Benefits:**
- Encrypted at rest
- Encrypted in transit
- Only available to services that need them
- Never written to disk in containers

### Creating Secrets

**From file:**
```bash
echo "mypassword" | docker secret create db_password -
# or
docker secret create db_password password.txt
```

**From stdin:**
```bash
echo "sk_live_abc123" | docker secret create api_key -
```

### Using Secrets in Services

**Grant secret to service:**
```bash
docker service create \
  --name api \
  --secret db_password \
  --secret api_key \
  myapi:latest
```

**Inside container:**
```bash
# Secrets mounted at:
/run/secrets/db_password
/run/secrets/api_key

# Read secret:
cat /run/secrets/db_password
```

### Secret Configuration

**Custom target path:**
```bash
docker service create \
  --secret source=db_password,target=/app/config/db_pass \
  myapi
```

**Specify mode (permissions):**
```bash
docker service create \
  --secret source=api_key,target=/app/key,mode=0400 \
  myapi
```

### Stack with Secrets

**Compose file:**
```yaml
version: "3.8"

services:
  api:
    image: myapi:latest
    secrets:
      - db_password
      - api_key

secrets:
  db_password:
    external: true
  api_key:
    external: true
```

**Create secrets first:**
```bash
echo "pass123" | docker secret create db_password -
echo "key456" | docker secret create api_key -
docker stack deploy -c stack.yml app
```

### Managing Secrets

**List secrets:**
```bash
docker secret ls
```

**Inspect secret:**
```bash
docker secret inspect db_password
# Shows metadata, NOT the actual secret value!
```

**Remove secret:**
```bash
docker secret rm db_password
# Must not be in use by any service
```

### DCA Exam Focus

Must know:
1. **docker secret create** creates secrets
2. **Secrets encrypted** at rest and in transit
3. **Mounted at /run/secrets/** in containers
4. **--secret flag** grants access
5. **Only for Swarm mode** (not standalone containers)

### Best Practices

**✅ DO:**
```bash
# Use secrets for sensitive data
echo "$DB_PASSWORD" | docker secret create db_pass -

# Rotate secrets regularly
docker secret create db_pass_v2 -
docker service update --secret-rm db_pass --secret-add db_pass_v2 api

# Limit access
docker service create --secret db_pass api  # Only api gets it
```

**❌ DON'T:**
```bash
# Don't use environment variables for secrets
docker service create --env DB_PASS=secret123 api  # Visible!

# Don't commit secrets to git
git add password.txt  # ❌ BAD!
```

### Rotating Secrets

**Update secret:**
```bash
# Create new secret
echo "newpassword" | docker secret create db_password_v2 -

# Update service
docker service update \
  --secret-rm db_password \
  --secret-add db_password_v2 \
  api

# Remove old secret
docker secret rm db_password
```

### Try it!

```bash
# Create secret
echo "supersecret" | docker secret create test_secret -

# Create service with secret
docker service create \
  --name testsvc \
  --secret test_secret \
  alpine sleep 1000

# View in container
docker exec $(docker ps -q -f name=testsvc) cat /run/secrets/test_secret

# Clean up
docker service rm testsvc
docker secret rm test_secret
```
    MD
  },
  {
    slug: "codesprout-swarm-troubleshooting",
    num: 49,
    command: "Swarm debugging",
    title: "Troubleshooting Docker Swarm",
    content: <<-'MD'
**Troubleshooting Docker Swarm** 🔧

Debugging Swarm issues is critical for production operations!

### Common Issues and Solutions

**1. Service not starting**

**Check service:**
```bash
docker service ps SERVICE --no-trunc
# Shows full error messages
```

**Common causes:**
- Image not found
- Resource constraints
- Constraint not met
- Health check failing

**2. Can't reach service**

**Check:**
```bash
# Verify service is running
docker service ls

# Check published ports
docker service inspect SERVICE | grep PublishedPort

# Check ingress network
docker network inspect ingress
```

**3. Node not joining**

**Check firewall:**
```bash
# Required ports:
# 2377/tcp - cluster management
# 7946/tcp/udp - node communication
# 4789/udp - overlay network
```

### Diagnostic Commands

**View service logs:**
```bash
docker service logs SERVICE
docker service logs --follow SERVICE
docker service logs --tail 100 SERVICE
```

**Inspect service:**
```bash
docker service inspect --pretty SERVICE
```

**View tasks:**
```bash
docker service ps SERVICE
docker service ps SERVICE --no-trunc  # Full errors
```

**Node health:**
```bash
docker node ls
docker node inspect NODE
```

### Manager Quorum Issues

**Lost quorum:**
```
3 managers → 1 fails → Quorum maintained (2/3)
3 managers → 2 fail → Quorum LOST (1/3)
```

**Force new cluster (DANGER):**
```bash
docker swarm init --force-new-cluster
# Only on healthy manager!
# Recreates cluster from this node
```

### DCA Exam Focus

Must know:
1. **docker service logs** views service logs
2. **docker service ps** shows task states
3. **--no-trunc** shows full error messages
4. **Manager quorum** needs majority
5. **Required ports** for Swarm

### Network Debugging

**Check overlay network:**
```bash
docker network ls
docker network inspect NETWORK
```

**Test connectivity:**
```bash
# From one service to another
docker exec CONTAINER ping SERVICE_NAME
```

**Verify DNS:**
```bash
docker exec CONTAINER nslookup SERVICE_NAME
```

### Resource Constraints

**Check node resources:**
```bash
docker node inspect NODE | grep Resources
```

**Service won't schedule if:**
- Not enough CPU
- Not enough memory
- Constraints not met

**Solution:**
```bash
# Reduce resource requirements
docker service update \
  --reserve-cpu 0.5 \
  --reserve-memory 512M \
  SERVICE

# Or add more nodes
```

### Common Error Messages

**"No suitable node"**
- All nodes drained/paused
- Constraints can't be met
- Not enough resources

**"Task failed"**
- Container exited
- Health check failed
- Resource limit exceeded

**"Pending"**
- Waiting for resources
- Waiting for image pull
- Constraint not satisfied

### Try it!

```bash
# Create problematic service
docker service create \
  --name broken \
  --constraint 'node.labels.nonexistent==true' \
  nginx
# Won't schedule - no node has that label

# Troubleshoot
docker service ps broken --no-trunc
# Shows: "no suitable node"

# Fix
docker service update --constraint-rm 'node.labels.nonexistent==true' broken

# Verify
docker service ps broken

# Clean up
docker service rm broken
```
    MD
  }
]

swarm_chapters.each do |ch|
  puts "\nChapter #{ch[:num]}: #{ch[:title]}"
  unit = InteractiveLearningUnit.find_by!(slug: ch[:slug])
  unit.update!(
    concept_explanation: ch[:content],
    command_to_learn: ch[:command],
    command_variations: ["docker swarm init", "docker service create", "docker service scale", "docker stack deploy"],
    practice_hints: [
      "Docker Swarm provides native clustering and orchestration",
      "Services can be scaled dynamically across the cluster",
      "Swarm automatically load-balances requests across replicas",
      "Secrets provide secure credential management in Swarm"
    ]
  )
  puts "✅ Enhanced"
end

puts "\n" + "=" * 80
puts "🎉 ALL DOCKER SWARM CHAPTERS COMPLETE (42-49)!"
puts "=" * 80
