# New Courses Seed Data - System Design, AWS, Envoy, PostgreSQL, Networking
puts "🌱 Seeding New Courses..."

# ========================================
# COURSE 1: System Design & Back-of-Envelope Calculations
# ========================================

system_design_course = Course.create!(
  title: "System Design & Back-of-Envelope Calculations",
  slug: "system-design-fundamentals",
  description: "Master system design interviews and architecture decisions through practical back-of-envelope calculations and real-world scenarios.",
  difficulty_level: "intermediate",
  estimated_hours: 25,
  certification_track: nil,
  published: true,
  sequence_order: 3,
  learning_objectives: JSON.generate([
    "Master back-of-envelope calculation techniques",
    "Estimate capacity, QPS, bandwidth, and storage requirements",
    "Design scalable systems for millions of users",
    "Understand trade-offs in distributed system design",
    "Prepare for system design interviews"
  ]),
  prerequisites: JSON.generate([
    "Basic understanding of web applications",
    "Familiarity with databases",
    "Understanding of networking concepts"
  ])
)

puts "🏗️ Created course: #{system_design_course.title}"

# Module 1: Estimation Fundamentals
sd_module1 = system_design_course.course_modules.create!(
  title: "Estimation Fundamentals",
  slug: "estimation-fundamentals",
  description: "Learn the basics of back-of-envelope calculations for system design",
  sequence_order: 1,
  estimated_minutes: 180,
  published: true,
  learning_objectives: JSON.generate([
    "Understand powers of 2 and data size units",
    "Calculate storage requirements",
    "Estimate bandwidth and QPS"
  ])
)

# ========================================
# COURSE 2: AWS Cloud Architecture
# ========================================

aws_course = Course.create!(
  title: "AWS Cloud Architecture",
  slug: "aws-cloud-architecture",
  description: "Build production-ready cloud infrastructure on AWS. Master compute, storage, networking, and serverless services through hands-on labs.",
  difficulty_level: "intermediate",
  estimated_hours: 30,
  certification_track: "AWS Solutions Architect",
  published: true,
  sequence_order: 4,
  learning_objectives: JSON.generate([
    "Design highly available AWS architectures",
    "Master EC2, S3, VPC, and Lambda services",
    "Implement security best practices",
    "Configure auto-scaling and load balancing",
    "Prepare for AWS Solutions Architect certification"
  ]),
  prerequisites: JSON.generate([
    "Basic cloud computing concepts",
    "Understanding of networking",
    "Linux command line familiarity"
  ])
)

puts "☁️ Created course: #{aws_course.title}"

# Module 1: AWS Fundamentals
aws_module1 = aws_course.course_modules.create!(
  title: "AWS Fundamentals & IAM",
  slug: "aws-fundamentals",
  description: "Introduction to AWS services, regions, and Identity Access Management",
  sequence_order: 1,
  estimated_minutes: 200,
  published: true,
  learning_objectives: JSON.generate([
    "Understand AWS global infrastructure",
    "Master IAM users, roles, and policies",
    "Configure AWS CLI and credentials"
  ])
)

# Module 2: Compute Services
aws_module2 = aws_course.course_modules.create!(
  title: "Compute Services - EC2 and Lambda",
  slug: "compute-services",
  description: "Master AWS compute options from virtual machines to serverless functions",
  sequence_order: 2,
  estimated_minutes: 240,
  published: true,
  learning_objectives: JSON.generate([
    "Launch and manage EC2 instances",
    "Deploy serverless Lambda functions",
    "Understand compute pricing models"
  ])
)

# Module 3: Storage Services
aws_module3 = aws_course.course_modules.create!(
  title: "Storage Services - S3, EBS, and EFS",
  slug: "storage-services",
  description: "Learn AWS storage solutions for objects, blocks, and files",
  sequence_order: 3,
  estimated_minutes: 220,
  published: true,
  learning_objectives: JSON.generate([
    "Master S3 bucket management and policies",
    "Configure EBS volumes for EC2",
    "Implement EFS for shared file storage"
  ])
)

# ========================================
# COURSE 3: Envoy Proxy Mastery
# ========================================

envoy_course = Course.create!(
  title: "Envoy Proxy Mastery",
  slug: "envoy-proxy-mastery",
  description: "Master the modern service mesh and API gateway. Learn load balancing, traffic management, and observability with Envoy.",
  difficulty_level: "advanced",
  estimated_hours: 20,
  certification_track: nil,
  published: true,
  sequence_order: 5,
  learning_objectives: JSON.generate([
    "Configure Envoy as API gateway and service mesh",
    "Implement advanced load balancing strategies",
    "Master circuit breaking and outlier detection",
    "Configure TLS termination and mTLS",
    "Implement observability with metrics and tracing"
  ]),
  prerequisites: JSON.generate([
    "Strong understanding of HTTP/HTTPS",
    "Microservices architecture knowledge",
    "Docker and containerization experience"
  ])
)

puts "🔀 Created course: #{envoy_course.title}"

# Module 1: Envoy Fundamentals
envoy_module1 = envoy_course.course_modules.create!(
  title: "Envoy Fundamentals",
  slug: "envoy-fundamentals",
  description: "Introduction to Envoy architecture, listeners, and clusters",
  sequence_order: 1,
  estimated_minutes: 180,
  published: true,
  learning_objectives: JSON.generate([
    "Understand Envoy architecture",
    "Configure listeners and routes",
    "Set up basic HTTP proxying"
  ])
)

# Module 2: Load Balancing
envoy_module2 = envoy_course.course_modules.create!(
  title: "Load Balancing and Health Checks",
  slug: "load-balancing",
  description: "Master load balancing algorithms and active health checking",
  sequence_order: 2,
  estimated_minutes: 200,
  published: true,
  learning_objectives: JSON.generate([
    "Configure Round Robin, Least Request, and Random load balancing",
    "Implement active and passive health checks",
    "Configure connection pooling"
  ])
)

# ========================================
# COURSE 4: PostgreSQL Database Mastery
# ========================================

postgresql_course = Course.create!(
  title: "PostgreSQL Database Mastery",
  slug: "postgresql-mastery",
  description: "Master PostgreSQL from fundamentals to advanced optimization. Learn SQL, indexing, transactions, and query tuning.",
  difficulty_level: "intermediate",
  estimated_hours: 28,
  certification_track: nil,
  published: true,
  sequence_order: 6,
  learning_objectives: JSON.generate([
    "Master SQL queries and database design",
    "Optimize queries with indexes and EXPLAIN",
    "Implement transactions and maintain data integrity",
    "Use advanced features like CTEs and window functions",
    "Tune PostgreSQL for production workloads"
  ]),
  prerequisites: JSON.generate([
    "Basic SQL knowledge",
    "Understanding of relational databases",
    "Command line familiarity"
  ])
)

puts "🐘 Created course: #{postgresql_course.title}"

# Module 1: PostgreSQL Basics
pg_module1 = postgresql_course.course_modules.create!(
  title: "PostgreSQL Fundamentals",
  slug: "postgresql-fundamentals",
  description: "Learn PostgreSQL basics, data types, and CRUD operations",
  sequence_order: 1,
  estimated_minutes: 180,
  published: true,
  learning_objectives: JSON.generate([
    "Install and configure PostgreSQL",
    "Master basic SQL queries",
    "Understand PostgreSQL data types"
  ])
)

# Module 2: Schema Design
pg_module2 = postgresql_course.course_modules.create!(
  title: "Schema Design and Normalization",
  slug: "schema-design",
  description: "Design efficient database schemas with proper normalization",
  sequence_order: 2,
  estimated_minutes: 200,
  published: true,
  learning_objectives: JSON.generate([
    "Apply normalization principles",
    "Design relationships with foreign keys",
    "Implement constraints for data integrity"
  ])
)

# Module 3: Query Optimization
pg_module3 = postgresql_course.course_modules.create!(
  title: "Query Optimization and Indexing",
  slug: "query-optimization",
  description: "Master indexes and query performance tuning",
  sequence_order: 3,
  estimated_minutes: 240,
  published: true,
  learning_objectives: JSON.generate([
    "Create and manage indexes",
    "Use EXPLAIN ANALYZE for query planning",
    "Optimize slow queries"
  ])
)

# ========================================
# COURSE 5: Networking Fundamentals
# ========================================

networking_course = Course.create!(
  title: "Networking Fundamentals",
  slug: "networking-fundamentals",
  description: "Master networking from TCP/IP to BGP through hands-on packet analysis and configuration labs.",
  difficulty_level: "intermediate",
  estimated_hours: 26,
  certification_track: nil,
  published: true,
  sequence_order: 7,
  learning_objectives: JSON.generate([
    "Understand TCP/IP protocol stack",
    "Master DNS resolution and configuration",
    "Analyze network packets with tcpdump",
    "Configure routing and traffic shaping",
    "Understand BGP and internet routing"
  ]),
  prerequisites: JSON.generate([
    "Basic understanding of computer networks",
    "Linux command line knowledge",
    "Familiarity with IP addresses"
  ])
)

puts "🌐 Created course: #{networking_course.title}"

# Module 1: TCP/IP Fundamentals
net_module1 = networking_course.course_modules.create!(
  title: "TCP/IP Protocol Stack",
  slug: "tcp-ip-fundamentals",
  description: "Deep dive into TCP/IP protocols and packet structure",
  sequence_order: 1,
  estimated_minutes: 200,
  published: true,
  learning_objectives: JSON.generate([
    "Understand OSI and TCP/IP models",
    "Analyze TCP three-way handshake",
    "Work with IP addressing and subnetting"
  ])
)

# Module 2: DNS
net_module2 = networking_course.course_modules.create!(
  title: "DNS and Name Resolution",
  slug: "dns-fundamentals",
  description: "Master DNS hierarchy, records, and resolution process",
  sequence_order: 2,
  estimated_minutes: 180,
  published: true,
  learning_objectives: JSON.generate([
    "Understand DNS hierarchy and delegation",
    "Query A, MX, TXT, and other DNS records",
    "Configure DNS servers"
  ])
)

# Module 3: Advanced Networking
net_module3 = networking_course.course_modules.create!(
  title: "Routing and Traffic Control",
  slug: "routing-traffic-control",
  description: "Master routing protocols and quality of service",
  sequence_order: 3,
  estimated_minutes: 240,
  published: true,
  learning_objectives: JSON.generate([
    "Configure static and dynamic routing",
    "Implement traffic shaping with tc",
    "Understand BGP fundamentals"
  ])
)

puts "\n✅ New Courses Seeding Complete!"
puts "   Courses created:"
puts "     - System Design & Back-of-Envelope Calculations"
puts "     - AWS Cloud Architecture"
puts "     - Envoy Proxy Mastery"
puts "     - PostgreSQL Database Mastery"
puts "     - Networking Fundamentals"
puts "\n🎓 Ready for Learning!"
