# System Design & Back-of-Envelope Calculation Labs
# Learn to design scalable systems through hands-on calculations and architecture

puts "🏗️ Seeding System Design Hands-On Labs..."

system_design_labs = [
  # BEGINNER LABS (1-5)
  {
    title: "Back-of-Envelope: Calculate Storage for 1M Users",
    description: "Learn fundamental capacity planning by calculating storage requirements for a user database",
    difficulty: "easy",
    estimated_minutes: 20,
    lab_type: "system-design",
    category: "capacity-planning",
    certification_exam: nil,
    learning_objectives: "Master basic capacity estimation, understand storage calculations, learn to use Python for calculations",
    prerequisites: ["Basic math knowledge", "Understanding of data sizes (KB, MB, GB)"],
    steps: [
      {
        step_number: 1,
        title: "Create calculation script",
        instruction: "Create a Python script to calculate storage needs",
        expected_command: "cat > calc.py << 'EOF'\n# Storage calculator\nusers = 1_000_000\navg_profile_size_kb = 5\ntotal_storage_mb = (users * avg_profile_size_kb) / 1024\nprint(f\"Total storage: {total_storage_mb:.2f} MB ({total_storage_mb/1024:.2f} GB)\")\nEOF",
        validation: "test -f calc.py"
      },
      {
        step_number: 2,
        title: "Run calculation",
        instruction: "Execute the storage calculation",
        expected_command: "python3 calc.py",
        validation: "python3 calc.py | grep 'Total storage'"
      },
      {
        step_number: 3,
        title: "Add database overhead",
        instruction: "Calculate with 20% database overhead",
        expected_command: "cat >> calc.py << 'EOF'\noverhead_factor = 1.2\nwith_overhead = total_storage_mb * overhead_factor\nprint(f\"With 20% overhead: {with_overhead:.2f} MB ({with_overhead/1024:.2f} GB)\")\nEOF",
        validation: "grep overhead calc.py"
      },
      {
        step_number: 4,
        title: "Calculate growth projection",
        instruction: "Add 3-year growth projection at 50% annual growth",
        expected_command: "python3 -c \"storage_gb = 4.88; year3 = storage_gb * (1.5**3); print(f'Year 3 projection: {year3:.2f} GB')\"",
        validation: "python3 -c \"print('Year 3 projection: 16.47 GB')\" | grep 'Year 3'"
      },
      {
        step_number: 5,
        title: "Cleanup",
        instruction: "Remove calculation files",
        expected_command: "rm calc.py",
        validation: "test ! -f calc.py"
      }
    ],
    validation_rules: {
      calculation_correct: "storage calculation must be accurate",
      overhead_included: "database overhead accounted for",
      growth_projected: "future capacity estimated"
    },
    success_criteria: "Successfully calculate storage requirements with growth projections",
    environment_image: "python:3.11-alpine",
    required_tools: ["python3"],
    max_attempts: 5,
    points_reward: 150,
    is_active: true
  },

  {
    title: "Estimate Daily Active Users (DAU) to QPS",
    description: "Convert business metrics to technical requirements by calculating queries per second",
    difficulty: "easy",
    estimated_minutes: 25,
    lab_type: "system-design",
    category: "capacity-planning",
    certification_exam: nil,
    learning_objectives: "Understand QPS calculations, learn traffic patterns, master peak load estimation",
    prerequisites: ["Basic understanding of web applications"],
    steps: [
      {
        step_number: 1,
        title: "Define baseline metrics",
        instruction: "Create Python script with DAU and average requests per user",
        expected_command: "cat > qps_calc.py << 'EOF'\ndau = 10_000_000  # 10M daily active users\navg_requests_per_user = 20\ntotal_daily_requests = dau * avg_requests_per_user\nprint(f\"Total daily requests: {total_daily_requests:,}\")\nEOF",
        validation: "test -f qps_calc.py"
      },
      {
        step_number: 2,
        title: "Calculate average QPS",
        instruction: "Calculate average queries per second",
        expected_command: "python3 -c \"total = 10_000_000 * 20; qps = total / (24*60*60); print(f'Average QPS: {qps:.2f}')\"",
        validation: "python3 -c \"qps = 200_000_000 / 86400; print(f'{qps:.2f}')\" | grep '2314'"
      },
      {
        step_number: 3,
        title: "Calculate peak QPS",
        instruction: "Estimate peak QPS using 3x multiplier for traffic spikes",
        expected_command: "python3 -c \"avg_qps = 2314.81; peak_qps = avg_qps * 3; print(f'Peak QPS: {peak_qps:.2f}')\"",
        validation: "python3 -c \"peak = 2314.81 * 3; print(f'{peak:.2f}')\" | grep '6944'"
      },
      {
        step_number: 4,
        title: "Calculate required servers",
        instruction: "If each server handles 500 QPS, how many servers needed for peak?",
        expected_command: "python3 -c \"import math; peak_qps = 6944.43; servers = math.ceil(peak_qps / 500); print(f'Servers needed: {servers}')\"",
        validation: "python3 -c \"import math; print(f'Servers needed: {math.ceil(6944.43/500)}')\" | grep '14'"
      },
      {
        step_number: 5,
        title: "Cleanup",
        instruction: "Remove calculation files",
        expected_command: "rm qps_calc.py",
        validation: "test ! -f qps_calc.py"
      }
    ],
    validation_rules: {
      qps_calculated: "QPS correctly calculated from DAU",
      peak_estimated: "peak load properly estimated",
      server_count: "server capacity planned"
    },
    success_criteria: "Successfully convert business metrics to infrastructure requirements",
    environment_image: "python:3.11-alpine",
    required_tools: ["python3"],
    max_attempts: 5,
    points_reward: 200,
    is_active: true
  },

  {
    title: "Design a URL Shortener - Data Model",
    description: "Design the database schema for a URL shortening service like bit.ly",
    difficulty: "easy",
    estimated_minutes: 30,
    lab_type: "system-design",
    category: "data-modeling",
    certification_exam: nil,
    learning_objectives: "Learn data modeling, understand ID generation strategies, design for scale",
    prerequisites: ["Basic database knowledge"],
    steps: [
      {
        step_number: 1,
        title: "Create schema definition",
        instruction: "Define URLs table with id, original_url, short_code, created_at",
        expected_command: "cat > schema.sql << 'EOF'\nCREATE TABLE urls (\n  id BIGINT PRIMARY KEY,\n  original_url TEXT NOT NULL,\n  short_code VARCHAR(10) UNIQUE NOT NULL,\n  created_at TIMESTAMP DEFAULT NOW()\n);\nEOF",
        validation: "test -f schema.sql && grep 'short_code' schema.sql"
      },
      {
        step_number: 2,
        title: "Calculate short code space",
        instruction: "Calculate possible combinations for 7-character alphanumeric codes",
        expected_command: "python3 -c \"chars = 62; length = 7; combinations = chars ** length; print(f'Possible codes: {combinations:,} (~{combinations/1e9:.1f}B)')\"",
        validation: "python3 -c \"print(f'{62**7:,}')\" | grep '3521614606208'"
      },
      {
        step_number: 3,
        title: "Add analytics table",
        instruction: "Create table to track URL clicks",
        expected_command: "cat >> schema.sql << 'EOF'\n\nCREATE TABLE clicks (\n  id BIGINT PRIMARY KEY,\n  url_id BIGINT REFERENCES urls(id),\n  clicked_at TIMESTAMP DEFAULT NOW(),\n  ip_address INET,\n  user_agent TEXT\n);\nEOF",
        validation: "grep 'clicks' schema.sql"
      },
      {
        step_number: 4,
        title: "Add indexes",
        instruction: "Create indexes for fast lookups",
        expected_command: "cat >> schema.sql << 'EOF'\n\nCREATE INDEX idx_short_code ON urls(short_code);\nCREATE INDEX idx_clicks_url ON clicks(url_id);\nEOF",
        validation: "grep 'CREATE INDEX' schema.sql | wc -l | grep '2'"
      },
      {
        step_number: 5,
        title: "Cleanup",
        instruction: "Remove schema file",
        expected_command: "rm schema.sql",
        validation: "test ! -f schema.sql"
      }
    ],
    validation_rules: {
      schema_defined: "complete database schema",
      space_calculated: "ID space properly estimated",
      indexes_added: "performance optimizations included"
    },
    success_criteria: "Design scalable database schema for URL shortener",
    environment_image: "python:3.11-alpine",
    required_tools: ["python3"],
    max_attempts: 5,
    points_reward: 250,
    is_active: true
  },

  {
    title: "Bandwidth Calculation for Video Streaming",
    description: "Calculate bandwidth requirements for a video streaming platform",
    difficulty: "medium",
    estimated_minutes: 30,
    lab_type: "system-design",
    category: "capacity-planning",
    certification_exam: nil,
    learning_objectives: "Understand bandwidth calculations, CDN requirements, video bitrates",
    prerequisites: ["Understanding of network bandwidth concepts"],
    steps: [
      {
        step_number: 1,
        title: "Define video specifications",
        instruction: "Create calculator for different video qualities",
        expected_command: "cat > bandwidth.py << 'EOF'\n# Video bitrates (Mbps)\nqualities = {\n  '480p': 1.5,\n  '720p': 4.0,\n  '1080p': 8.0,\n  '4K': 25.0\n}\nprint('Video Quality Bitrates:')\nfor quality, bitrate in qualities.items():\n  print(f'{quality}: {bitrate} Mbps')\nEOF",
        validation: "test -f bandwidth.py && python3 bandwidth.py | grep '1080p'"
      },
      {
        step_number: 2,
        title: "Calculate concurrent viewers bandwidth",
        instruction: "Calculate total bandwidth for 10,000 concurrent 1080p streams",
        expected_command: "python3 -c \"viewers = 10000; bitrate_mbps = 8.0; total_gbps = (viewers * bitrate_mbps) / 1000; print(f'Total bandwidth: {total_gbps:.1f} Gbps')\"",
        validation: "python3 -c \"print(f'Total bandwidth: {(10000*8.0)/1000:.1f} Gbps')\" | grep '80.0 Gbps'"
      },
      {
        step_number: 3,
        title: "Calculate monthly data transfer",
        instruction: "Calculate data transfer if average session is 30 minutes, 1M users/day",
        expected_command: "python3 -c \"users_day = 1_000_000; session_min = 30; bitrate_mbps = 8.0; gb_per_user = (bitrate_mbps * session_min * 60) / 8 / 1024; monthly_pb = (gb_per_user * users_day * 30) / 1024; print(f'Monthly transfer: {monthly_pb:.2f} PB')\"",
        validation: "python3 -c \"gb = (8.0*30*60)/8/1024; print(f'{(gb*1_000_000*30)/1024:.2f}')\" | grep -E '[0-9]+\\.[0-9]+'"
      },
      {
        step_number: 4,
        title: "Calculate CDN cost estimate",
        instruction: "Estimate cost at $0.08/GB",
        expected_command: "python3 -c \"monthly_gb = 1757812.5; cost = monthly_gb * 0.08; print(f'Estimated monthly CDN cost: ${cost:,.2f}')\"",
        validation: "python3 -c \"print('CDN cost')\" | grep 'cost'"
      },
      {
        step_number: 5,
        title: "Cleanup",
        instruction: "Remove calculation files",
        expected_command: "rm bandwidth.py",
        validation: "test ! -f bandwidth.py"
      }
    ],
    validation_rules: {
      bandwidth_calculated: "concurrent bandwidth estimated",
      transfer_calculated: "monthly data transfer computed",
      costs_estimated: "CDN costs projected"
    },
    success_criteria: "Successfully estimate bandwidth and cost for video streaming platform",
    environment_image: "python:3.11-alpine",
    required_tools: ["python3"],
    max_attempts: 5,
    points_reward: 300,
    is_active: true
  },

  {
    title: "Design Twitter Feed - Load Balancing Strategy",
    description: "Design load balancing for Twitter-like feed generation",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "system-design",
    category: "architecture",
    certification_exam: nil,
    learning_objectives: "Understand load balancing strategies, caching layers, read/write patterns",
    prerequisites: ["Understanding of distributed systems"],
    steps: [
      {
        step_number: 1,
        title: "Calculate read vs write ratio",
        instruction: "Estimate read/write ratio for Twitter (1000 reads per 1 write)",
        expected_command: "cat > twitter_design.md << 'EOF'\n# Twitter Feed System Design\n\n## Traffic Pattern\n- Read/Write Ratio: 1000:1\n- Reads: Feed queries, timeline loads\n- Writes: New tweets, likes, retweets\nEOF",
        validation: "test -f twitter_design.md && grep '1000:1' twitter_design.md"
      },
      {
        step_number: 2,
        title: "Design cache layer",
        instruction: "Document Redis caching strategy",
        expected_command: "cat >> twitter_design.md << 'EOF'\n\n## Caching Strategy\n- Cache Layer: Redis\n- Cache user feeds (hot data)\n- TTL: 30 minutes\n- Cache hit ratio target: 90%\nEOF",
        validation: "grep 'Redis' twitter_design.md"
      },
      {
        step_number: 3,
        title: "Calculate cache memory needed",
        instruction: "Calculate Redis memory for 10M active users, 100 tweets per feed, 1KB per tweet",
        expected_command: "python3 -c \"users = 10_000_000; tweets_per_feed = 100; kb_per_tweet = 1; total_gb = (users * tweets_per_feed * kb_per_tweet) / (1024*1024); print(f'Cache memory needed: {total_gb:.2f} GB')\"",
        validation: "python3 -c \"print(f'{(10_000_000*100*1)/(1024*1024):.2f}')\" | grep -E '[0-9]+\\.[0-9]+'"
      },
      {
        step_number: 4,
        title: "Design database sharding",
        instruction: "Document sharding strategy by user ID",
        expected_command: "cat >> twitter_design.md << 'EOF'\n\n## Database Sharding\n- Shard by user_id (consistent hashing)\n- 100 shards for horizontal scaling\n- Read replicas for each shard\n- Master-slave replication\nEOF",
        validation: "grep 'shards' twitter_design.md"
      },
      {
        step_number: 5,
        title: "Cleanup",
        instruction: "Remove design document",
        expected_command: "rm twitter_design.md",
        validation: "test ! -f twitter_design.md"
      }
    ],
    validation_rules: {
      ratio_calculated: "read/write ratio analyzed",
      caching_designed: "cache strategy documented",
      sharding_planned: "database partitioning designed"
    },
    success_criteria: "Design complete load balancing and caching strategy",
    environment_image: "python:3.11-alpine",
    required_tools: ["python3"],
    max_attempts: 5,
    points_reward: 400,
    is_active: true
  },

  # ADVANCED LABS
  {
    title: "Design Distributed Rate Limiter",
    description: "Design a distributed rate limiting system using token bucket algorithm",
    difficulty: "hard",
    estimated_minutes: 45,
    lab_type: "system-design",
    category: "architecture",
    certification_exam: nil,
    learning_objectives: "Understand rate limiting algorithms, distributed systems coordination, Redis patterns",
    prerequisites: ["Advanced distributed systems knowledge", "Redis experience"],
    steps: [
      {
        step_number: 1,
        title: "Document token bucket algorithm",
        instruction: "Create design document for rate limiter",
        expected_command: "cat > rate_limiter.md << 'EOF'\n# Distributed Rate Limiter Design\n\n## Token Bucket Algorithm\n- Bucket capacity: 100 tokens\n- Refill rate: 10 tokens/second\n- Each request consumes 1 token\n- Reject when bucket empty\nEOF",
        validation: "test -f rate_limiter.md && grep 'Token Bucket' rate_limiter.md"
      },
      {
        step_number: 2,
        title: "Implement token bucket in Python",
        instruction: "Create simplified token bucket implementation",
        expected_command: "cat > token_bucket.py << 'EOF'\nimport time\n\nclass TokenBucket:\n    def __init__(self, capacity, refill_rate):\n        self.capacity = capacity\n        self.tokens = capacity\n        self.refill_rate = refill_rate\n        self.last_refill = time.time()\n    \n    def consume(self, tokens=1):\n        self._refill()\n        if self.tokens >= tokens:\n            self.tokens -= tokens\n            return True\n        return False\n    \n    def _refill(self):\n        now = time.time()\n        elapsed = now - self.last_refill\n        new_tokens = elapsed * self.refill_rate\n        self.tokens = min(self.capacity, self.tokens + new_tokens)\n        self.last_refill = now\n\nbucket = TokenBucket(100, 10)\nprint(f'Initial tokens: {bucket.tokens}')\nprint(f'Consume 5: {bucket.consume(5)}')\nprint(f'Remaining: {bucket.tokens}')\nEOF",
        validation: "test -f token_bucket.py && python3 token_bucket.py | grep 'Consume'"
      },
      {
        step_number: 3,
        title: "Calculate distributed coordination overhead",
        instruction: "Estimate Redis operations per second for 1M requests/sec",
        expected_command: "python3 -c \"requests_per_sec = 1_000_000; redis_ops_per_request = 2; total_redis_ops = requests_per_sec * redis_ops_per_request; print(f'Redis ops/sec needed: {total_redis_ops:,}')\"",
        validation: "python3 -c \"print(f'{1_000_000*2:,}')\" | grep '2,000,000'"
      },
      {
        step_number: 4,
        title: "Design Redis Cluster setup",
        instruction: "Document Redis cluster configuration",
        expected_command: "cat >> rate_limiter.md << 'EOF'\n\n## Redis Cluster Configuration\n- 12 Redis nodes (6 master + 6 replicas)\n- Consistent hashing by user_id\n- Lua scripts for atomic operations\n- ~200K ops/sec per node capacity\nEOF",
        validation: "grep 'Redis Cluster' rate_limiter.md"
      },
      {
        step_number: 5,
        title: "Cleanup",
        instruction: "Remove implementation files",
        expected_command: "rm rate_limiter.md token_bucket.py",
        validation: "test ! -f rate_limiter.md"
      }
    ],
    validation_rules: {
      algorithm_documented: "rate limiting algorithm explained",
      implementation_working: "token bucket implemented",
      scaling_calculated: "distributed system capacity planned"
    },
    success_criteria: "Design and implement distributed rate limiting system",
    environment_image: "python:3.11-alpine",
    required_tools: ["python3"],
    max_attempts: 3,
    points_reward: 500,
    is_active: true
  }
]

# Create System Design Labs
system_design_labs.each_with_index do |lab_data, index|
  begin
    lab = HandsOnLab.find_or_initialize_by(title: lab_data[:title])
    lab.assign_attributes(lab_data)

    if lab.save
      print "."
    else
      puts "\n❌ Failed to create: #{lab_data[:title]}"
      puts "   Errors: #{lab.errors.full_messages.join(', ')}"
    end
  rescue => e
    puts "\n❌ Error on #{lab_data[:title]}: #{e.message}"
  end

  if (index + 1) % 5 == 0
    puts " #{index + 1}/#{system_design_labs.length}"
  end
end

puts "\n\n✅ System Design Hands-On Labs Seeding Complete!"
puts "   Total labs: #{HandsOnLab.where(lab_type: 'system-design').count}"
puts "   By difficulty:"
puts "     - Easy (Beginner): #{HandsOnLab.where(lab_type: 'system-design', difficulty: 'easy').count}"
puts "     - Medium (Intermediate): #{HandsOnLab.where(lab_type: 'system-design', difficulty: 'medium').count}"
puts "     - Hard (Advanced): #{HandsOnLab.where(lab_type: 'system-design', difficulty: 'hard').count}"
puts "\n🏗️ Ready for System Design Learning!"
