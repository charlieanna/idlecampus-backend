# Progressive Flow Seed Data
# Creates 3 learning tracks, 61 challenges, 5 levels per challenge, and prerequisite dependencies

puts "🌱 Starting Progressive Flow seed data..."

# ============================================================================
# STEP 1: Create Learning Tracks
# ============================================================================
puts "\n📚 Creating Learning Tracks..."

tracks = {
  fundamentals: ProgressiveLearningTrack.find_or_create_by!(slug: 'fundamentals') do |t|
    t.title = 'Fundamentals'
    t.description = 'Master the basics of distributed systems design with 15 foundational challenges'
    t.difficulty_level = 'fundamentals'
    t.estimated_hours = 30
    t.order_index = 1
    t.is_active = true
    t.prerequisites = []
    t.metadata = {
      icon: '🎯',
      color: '#3B82F6',
      learning_outcomes: [
        'Understand basic system components',
        'Design simple distributed systems',
        'Handle basic scalability requirements'
      ]
    }
  end,
  
  concepts: ProgressiveLearningTrack.find_or_create_by!(slug: 'concepts') do |t|
    t.title = 'Core Concepts'
    t.description = 'Apply advanced patterns and concepts with 24 intermediate challenges'
    t.difficulty_level = 'concepts'
    t.estimated_hours = 60
    t.order_index = 2
    t.is_active = true
    t.prerequisites = []
    t.metadata = {
      icon: '🧩',
      color: '#8B5CF6',
      learning_outcomes: [
        'Apply design patterns effectively',
        'Optimize for performance and cost',
        'Handle complex data flows'
      ]
    }
  end,
  
  systems: ProgressiveLearningTrack.find_or_create_by!(slug: 'systems') do |t|
    t.title = 'Real-World Systems'
    t.description = 'Build production-grade systems with 22 advanced challenges'
    t.difficulty_level = 'systems'
    t.estimated_hours = 80
    t.order_index = 3
    t.is_active = true
    t.prerequisites = []
    t.metadata = {
      icon: '🏗️',
      color: '#EF4444',
      learning_outcomes: [
        'Design enterprise-scale systems',
        'Handle multi-region deployments',
        'Optimize for all NFRs simultaneously'
      ]
    }
  end
}

puts "   ✓ Created #{tracks.count} learning tracks"

# ============================================================================
# STEP 2: Define 61 Challenges with Metadata
# ============================================================================
puts "\n🎯 Creating Challenges..."

challenge_definitions = [
  # ========== FUNDAMENTALS TRACK (15 challenges) ==========
  {
    slug: 'tinyurl',
    title: 'TinyURL - URL Shortener',
    description: 'Design a URL shortening service like bit.ly',
    category: 'api',
    track: :fundamentals,
    order_in_track: 1,
    difficulty_base: 'beginner',
    xp_base: 500,
    estimated_minutes: 45,
    prerequisites: [],
    ddia_concepts: ['hashing', 'base62-encoding', 'key-generation'],
    tags: ['url-shortening', 'hashing', 'apis', 'beginner-friendly'],
    metadata: {
      real_world_examples: ['bit.ly', 'tinyurl.com', 'goo.gl'],
      key_concepts: ['Hash functions', 'Base62 encoding', 'Collision handling']
    }
  },
  {
    slug: 'pastebin',
    title: 'Pastebin - Code Sharing',
    description: 'Design a text/code sharing service',
    category: 'storage',
    track: :fundamentals,
    order_in_track: 2,
    difficulty_base: 'beginner',
    xp_base: 550,
    estimated_minutes: 50,
    prerequisites: ['tinyurl'],
    ddia_concepts: ['object-storage', 'ttl', 'access-patterns'],
    tags: ['storage', 'expiration', 'sharing'],
    metadata: {
      real_world_examples: ['pastebin.com', 'GitHub Gist'],
      key_concepts: ['Object storage', 'TTL policies', 'Access control']
    }
  },
  {
    slug: 'rate_limiter',
    title: 'API Rate Limiter',
    description: 'Design a rate limiting system for APIs',
    category: 'reliability',
    track: :fundamentals,
    order_in_track: 3,
    difficulty_base: 'beginner',
    xp_base: 600,
    estimated_minutes: 55,
    prerequisites: ['tinyurl'],
    ddia_concepts: ['token-bucket', 'sliding-window', 'distributed-rate-limiting'],
    tags: ['rate-limiting', 'throttling', 'api-protection'],
    metadata: {
      real_world_examples: ['Cloudflare', 'AWS API Gateway'],
      key_concepts: ['Token bucket', 'Sliding window', 'Redis counters']
    }
  },
  {
    slug: 'web_crawler',
    title: 'Web Crawler',
    description: 'Design a distributed web crawling system',
    category: 'queue',
    track: :fundamentals,
    order_in_track: 4,
    difficulty_base: 'beginner',
    xp_base: 650,
    estimated_minutes: 60,
    prerequisites: ['tinyurl', 'pastebin'],
    ddia_concepts: ['bfs', 'url-frontier', 'politeness', 'deduplication'],
    tags: ['crawling', 'queues', 'distributed-systems'],
    metadata: {
      real_world_examples: ['Googlebot', 'Bing crawler'],
      key_concepts: ['URL frontier', 'Politeness policy', 'Duplicate detection']
    }
  },
  {
    slug: 'cdn_basic',
    title: 'Content Delivery Network (Basic)',
    description: 'Design a basic CDN for static content',
    category: 'cdn',
    track: :fundamentals,
    order_in_track: 5,
    difficulty_base: 'beginner',
    xp_base: 700,
    estimated_minutes: 65,
    prerequisites: ['tinyurl'],
    ddia_concepts: ['edge-caching', 'cache-invalidation', 'origin-pull'],
    tags: ['cdn', 'caching', 'static-content'],
    metadata: {
      real_world_examples: ['Cloudflare', 'Akamai', 'CloudFront'],
      key_concepts: ['Edge locations', 'Cache invalidation', 'Origin pull']
    }
  },
  {
    slug: 'key_value_store',
    title: 'Distributed Key-Value Store',
    description: 'Design a distributed NoSQL key-value database',
    category: 'database',
    track: :fundamentals,
    order_in_track: 6,
    difficulty_base: 'intermediate',
    xp_base: 800,
    estimated_minutes: 70,
    prerequisites: ['rate_limiter'],
    ddia_concepts: ['consistent-hashing', 'replication', 'partitioning'],
    tags: ['nosql', 'distributed-systems', 'storage'],
    metadata: {
      real_world_examples: ['DynamoDB', 'Redis', 'Cassandra'],
      key_concepts: ['Consistent hashing', 'Replication', 'CAP theorem']
    }
  },
  {
    slug: 'unique_id_generator',
    title: 'Unique ID Generator',
    description: 'Design a distributed unique ID generation system',
    category: 'general',
    track: :fundamentals,
    order_in_track: 7,
    difficulty_base: 'intermediate',
    xp_base: 750,
    estimated_minutes: 60,
    prerequisites: ['key_value_store'],
    ddia_concepts: ['snowflake', 'uuid', 'distributed-coordination'],
    tags: ['id-generation', 'distributed-systems'],
    metadata: {
      real_world_examples: ['Twitter Snowflake', 'Instagram IDs'],
      key_concepts: ['Snowflake algorithm', 'Clock synchronization', 'Uniqueness guarantees']
    }
  },
  {
    slug: 'notification_system',
    title: 'Notification System',
    description: 'Design a multi-channel notification delivery system',
    category: 'messaging',
    track: :fundamentals,
    order_in_track: 8,
    difficulty_base: 'intermediate',
    xp_base: 850,
    estimated_minutes: 75,
    prerequisites: ['rate_limiter', 'web_crawler'],
    ddia_concepts: ['push-notifications', 'message-queues', 'fanout'],
    tags: ['notifications', 'messaging', 'real-time'],
    metadata: {
      real_world_examples: ['Firebase Cloud Messaging', 'AWS SNS'],
      key_concepts: ['Push vs Pull', 'Message queues', 'Delivery guarantees']
    }
  },
  {
    slug: 'autocomplete',
    title: 'Search Autocomplete',
    description: 'Design a real-time search suggestion system',
    category: 'search',
    track: :fundamentals,
    order_in_track: 9,
    difficulty_base: 'intermediate',
    xp_base: 800,
    estimated_minutes: 70,
    prerequisites: ['key_value_store'],
    ddia_concepts: ['trie', 'prefix-search', 'caching'],
    tags: ['search', 'trie', 'autocomplete'],
    metadata: {
      real_world_examples: ['Google Search', 'Amazon search'],
      key_concepts: ['Trie data structure', 'Prefix matching', 'Query caching']
    }
  },
  {
    slug: 'news_feed',
    title: 'News Feed System',
    description: 'Design a social media news feed',
    category: 'general',
    track: :fundamentals,
    order_in_track: 10,
    difficulty_base: 'intermediate',
    xp_base: 900,
    estimated_minutes: 80,
    prerequisites: ['notification_system'],
    ddia_concepts: ['fanout-on-write', 'fanout-on-read', 'timeline-ranking'],
    tags: ['social-media', 'feeds', 'ranking'],
    metadata: {
      real_world_examples: ['Facebook News Feed', 'Twitter Timeline'],
      key_concepts: ['Fanout strategies', 'Ranking algorithms', 'Real-time updates']
    }
  },
  {
    slug: 'chat_system',
    title: 'Chat System',
    description: 'Design a real-time messaging application',
    category: 'messaging',
    track: :fundamentals,
    order_in_track: 11,
    difficulty_base: 'intermediate',
    xp_base: 850,
    estimated_minutes: 75,
    prerequisites: ['notification_system'],
    ddia_concepts: ['websockets', 'message-ordering', 'presence'],
    tags: ['chat', 'real-time', 'messaging'],
    metadata: {
      real_world_examples: ['WhatsApp', 'Slack', 'Discord'],
      key_concepts: ['WebSockets', 'Message ordering', 'Online presence']
    }
  },
  {
    slug: 'file_storage',
    title: 'Cloud File Storage',
    description: 'Design a file storage and sync service',
    category: 'storage',
    track: :fundamentals,
    order_in_track: 12,
    difficulty_base: 'intermediate',
    xp_base: 950,
    estimated_minutes: 85,
    prerequisites: ['key_value_store', 'notification_system'],
    ddia_concepts: ['block-storage', 'chunking', 'deduplication', 'versioning'],
    tags: ['storage', 'file-sync', 'versioning'],
    metadata: {
      real_world_examples: ['Dropbox', 'Google Drive', 'OneDrive'],
      key_concepts: ['File chunking', 'Delta sync', 'Conflict resolution']
    }
  },
  {
    slug: 'task_scheduler',
    title: 'Distributed Task Scheduler',
    description: 'Design a distributed cron-like job scheduler',
    category: 'queue',
    track: :fundamentals,
    order_in_track: 13,
    difficulty_base: 'intermediate',
    xp_base: 900,
    estimated_minutes: 80,
    prerequisites: ['key_value_store'],
    ddia_concepts: ['task-queues', 'priority-queues', 'distributed-locking'],
    tags: ['scheduling', 'distributed-systems', 'queues'],
    metadata: {
      real_world_examples: ['Airflow', 'Kubernetes CronJobs'],
      key_concepts: ['Priority queues', 'Distributed locking', 'Fault tolerance']
    }
  },
  {
    slug: 'url_shortener_advanced',
    title: 'URL Shortener (Advanced)',
    description: 'Enterprise-grade URL shortener with analytics',
    category: 'api',
    track: :fundamentals,
    order_in_track: 14,
    difficulty_base: 'advanced',
    xp_base: 1000,
    estimated_minutes: 90,
    prerequisites: ['tinyurl', 'rate_limiter', 'key_value_store'],
    ddia_concepts: ['analytics', 'geolocation', 'abuse-prevention'],
    tags: ['url-shortening', 'analytics', 'advanced'],
    metadata: {
      real_world_examples: ['Bitly Business', 'Rebrandly'],
      key_concepts: ['Click analytics', 'Custom domains', 'Abuse detection']
    }
  },
  {
    slug: 'api_gateway',
    title: 'API Gateway',
    description: 'Design a scalable API gateway',
    category: 'api',
    track: :fundamentals,
    order_in_track: 15,
    difficulty_base: 'advanced',
    xp_base: 1100,
    estimated_minutes: 95,
    prerequisites: ['rate_limiter', 'notification_system'],
    ddia_concepts: ['routing', 'load-balancing', 'authentication', 'throttling'],
    tags: ['api-gateway', 'routing', 'security'],
    metadata: {
      real_world_examples: ['Kong', 'AWS API Gateway', 'Nginx'],
      key_concepts: ['Request routing', 'Authentication', 'Rate limiting']
    }
  },

  # ========== CONCEPTS TRACK (24 challenges) ==========
  {
    slug: 'instagram',
    title: 'Instagram - Photo Sharing',
    description: 'Design a photo-sharing social network',
    category: 'general',
    track: :concepts,
    order_in_track: 1,
    difficulty_base: 'intermediate',
    xp_base: 1200,
    estimated_minutes: 100,
    prerequisites: ['news_feed', 'file_storage'],
    ddia_concepts: ['image-processing', 'cdn', 'social-graph'],
    tags: ['social-media', 'images', 'feeds'],
    metadata: {
      real_world_examples: ['Instagram', 'Pinterest'],
      key_concepts: ['Image CDN', 'Feed generation', 'Social graph']
    }
  },
  {
    slug: 'twitter',
    title: 'Twitter - Microblogging',
    description: 'Design a microblogging platform',
    category: 'general',
    track: :concepts,
    order_in_track: 2,
    difficulty_base: 'intermediate',
    xp_base: 1250,
    estimated_minutes: 105,
    prerequisites: ['instagram'],
    ddia_concepts: ['timeline-generation', 'hashtags', 'trending'],
    tags: ['social-media', 'real-time', 'trending'],
    metadata: {
      real_world_examples: ['Twitter', 'Mastodon'],
      key_concepts: ['Timeline generation', 'Hashtag indexing', 'Trending algorithms']
    }
  },
  {
    slug: 'facebook',
    title: 'Facebook - Social Network',
    description: 'Design a comprehensive social networking platform',
    category: 'general',
    track: :concepts,
    order_in_track: 3,
    difficulty_base: 'advanced',
    xp_base: 1400,
    estimated_minutes: 120,
    prerequisites: ['twitter'],
    ddia_concepts: ['graph-database', 'friend-suggestions', 'privacy'],
    tags: ['social-media', 'graph', 'privacy'],
    metadata: {
      real_world_examples: ['Facebook', 'LinkedIn'],
      key_concepts: ['Graph database', 'Friend suggestions', 'Privacy controls']
    }
  },
  {
    slug: 'whatsapp',
    title: 'WhatsApp - Messaging',
    description: 'Design an end-to-end encrypted messaging app',
    category: 'messaging',
    track: :concepts,
    order_in_track: 4,
    difficulty_base: 'intermediate',
    xp_base: 1200,
    estimated_minutes: 100,
    prerequisites: ['chat_system'],
    ddia_concepts: ['end-to-end-encryption', 'group-chat', 'media-sharing'],
    tags: ['messaging', 'encryption', 'real-time'],
    metadata: {
      real_world_examples: ['WhatsApp', 'Signal'],
      key_concepts: ['E2E encryption', 'Group messaging', 'Media delivery']
    }
  },
  {
    slug: 'youtube',
    title: 'YouTube - Video Streaming',
    description: 'Design a video sharing and streaming platform',
    category: 'streaming',
    track: :concepts,
    order_in_track: 5,
    difficulty_base: 'advanced',
    xp_base: 1500,
    estimated_minutes: 130,
    prerequisites: ['instagram', 'cdn_basic'],
    ddia_concepts: ['video-encoding', 'adaptive-bitrate', 'cdn'],
    tags: ['video', 'streaming', 'cdn'],
    metadata: {
      real_world_examples: ['YouTube', 'Vimeo'],
      key_concepts: ['Video transcoding', 'Adaptive streaming', 'Content delivery']
    }
  },
  {
    slug: 'netflix',
    title: 'Netflix - VOD Streaming',
    description: 'Design a video-on-demand streaming service',
    category: 'streaming',
    track: :concepts,
    order_in_track: 6,
    difficulty_base: 'advanced',
    xp_base: 1600,
    estimated_minutes: 140,
    prerequisites: ['youtube'],
    ddia_concepts: ['content-recommendation', 'multi-region-cdn', 'drm'],
    tags: ['streaming', 'recommendation', 'cdn'],
    metadata: {
      real_world_examples: ['Netflix', 'Disney+', 'Prime Video'],
      key_concepts: ['Recommendation engine', 'Multi-region CDN', 'DRM']
    }
  },
  {
    slug: 'uber',
    title: 'Uber - Ride Sharing',
    description: 'Design a ride-sharing platform',
    category: 'general',
    track: :concepts,
    order_in_track: 7,
    difficulty_base: 'advanced',
    xp_base: 1500,
    estimated_minutes: 130,
    prerequisites: ['notification_system', 'key_value_store'],
    ddia_concepts: ['geospatial-indexing', 'real-time-matching', 'surge-pricing'],
    tags: ['geospatial', 'real-time', 'matching'],
    metadata: {
      real_world_examples: ['Uber', 'Lyft'],
      key_concepts: ['Geospatial indexing', 'Ride matching', 'Dynamic pricing']
    }
  },
  {
    slug: 'airbnb',
    title: 'Airbnb - Marketplace',
    description: 'Design a vacation rental marketplace',
    category: 'general',
    track: :concepts,
    order_in_track: 8,
    difficulty_base: 'advanced',
    xp_base: 1450,
    estimated_minutes: 125,
    prerequisites: ['instagram', 'autocomplete'],
    ddia_concepts: ['search-ranking', 'booking-system', 'payment-processing'],
    tags: ['marketplace', 'search', 'booking'],
    metadata: {
      real_world_examples: ['Airbnb', 'Booking.com'],
      key_concepts: ['Search ranking', 'Booking calendar', 'Payment flows']
    }
  },
  {
    slug: 'ticketmaster',
    title: 'Ticketmaster - Ticketing',
    description: 'Design an event ticketing system',
    category: 'general',
    track: :concepts,
    order_in_track: 9,
    difficulty_base: 'advanced',
    xp_base: 1400,
    estimated_minutes: 120,
    prerequisites: ['key_value_store', 'rate_limiter'],
    ddia_concepts: ['inventory-management', 'distributed-locking', 'payment-processing'],
    tags: ['ticketing', 'inventory', 'locking'],
    metadata: {
      real_world_examples: ['Ticketmaster', 'Eventbrite'],
      key_concepts: ['Inventory management', 'Pessimistic locking', 'Fraud prevention']
    }
  },
  {
    slug: 'yelp',
    title: 'Yelp - Local Business',
    description: 'Design a local business review platform',
    category: 'search',
    track: :concepts,
    order_in_track: 10,
    difficulty_base: 'intermediate',
    xp_base: 1300,
    estimated_minutes: 110,
    prerequisites: ['autocomplete', 'instagram'],
    ddia_concepts: ['geospatial-search', 'ranking-algorithm', 'review-aggregation'],
    tags: ['search', 'geospatial', 'reviews'],
    metadata: {
      real_world_examples: ['Yelp', 'Google Maps'],
      key_concepts: ['Proximity search', 'Review ranking', 'Business indexing']
    }
  },
  {
    slug: 'linkedin',
    title: 'LinkedIn - Professional Network',
    description: 'Design a professional networking platform',
    category: 'general',
    track: :concepts,
    order_in_track: 11,
    difficulty_base: 'advanced',
    xp_base: 1350,
    estimated_minutes: 115,
    prerequisites: ['facebook'],
    ddia_concepts: ['connection-graph', 'job-matching', 'recommendation-engine'],
    tags: ['social-network', 'graph', 'recommendation'],
    metadata: {
      real_world_examples: ['LinkedIn'],
      key_concepts: ['Professional graph', 'Job recommendations', 'Skill endorsements']
    }
  },
  {
    slug: 'reddit',
    title: 'Reddit - Discussion Forum',
    description: 'Design a large-scale discussion forum',
    category: 'general',
    track: :concepts,
    order_in_track: 12,
    difficulty_base: 'intermediate',
    xp_base: 1250,
    estimated_minutes: 105,
    prerequisites: ['twitter'],
    ddia_concepts: ['voting-system', 'comment-threading', 'content-moderation'],
    tags: ['forum', 'voting', 'moderation'],
    metadata: {
      real_world_examples: ['Reddit', 'Hacker News'],
      key_concepts: ['Vote aggregation', 'Threaded comments', 'Content ranking']
    }
  },
  {
    slug: 'stackoverflow',
    title: 'Stack Overflow - Q&A Platform',
    description: 'Design a technical Q&A community',
    category: 'general',
    track: :concepts,
    order_in_track: 13,
    difficulty_base: 'intermediate',
    xp_base: 1200,
    estimated_minutes: 100,
    prerequisites: ['reddit'],
    ddia_concepts: ['reputation-system', 'search-ranking', 'tag-system'],
    tags: ['qa', 'reputation', 'search'],
    metadata: {
      real_world_examples: ['Stack Overflow', 'Quora'],
      key_concepts: ['Reputation system', 'Full-text search', 'Tag clustering']
    }
  },
  {
    slug: 'spotify',
    title: 'Spotify - Music Streaming',
    description: 'Design a music streaming service',
    category: 'streaming',
    track: :concepts,
    order_in_track: 14,
    difficulty_base: 'advanced',
    xp_base: 1450,
    estimated_minutes: 125,
    prerequisites: ['youtube'],
    ddia_concepts: ['audio-streaming', 'playlist-management', 'collaborative-filtering'],
    tags: ['streaming', 'music', 'recommendation'],
    metadata: {
      real_world_examples: ['Spotify', 'Apple Music'],
      key_concepts: ['Audio streaming', 'Playlist algorithms', 'Music recommendations']
    }
  },
  {
    slug: 'dropbox',
    title: 'Dropbox - Cloud Storage',
    description: 'Design an advanced file sync and share service',
    category: 'storage',
    track: :concepts,
    order_in_track: 15,
    difficulty_base: 'advanced',
    xp_base: 1400,
    estimated_minutes: 120,
    prerequisites: ['file_storage'],
    ddia_concepts: ['delta-sync', 'conflict-resolution', 'version-control'],
    tags: ['storage', 'sync', 'versioning'],
    metadata: {
      real_world_examples: ['Dropbox', 'Box'],
      key_concepts: ['Delta sync', 'Conflict resolution', 'Version history']
    }
  },
  {
    slug: 'gmail',
    title: 'Gmail - Email Service',
    description: 'Design a scalable email service',
    category: 'messaging',
    track: :concepts,
    order_in_track: 16,
    difficulty_base: 'advanced',
    xp_base: 1500,
    estimated_minutes: 130,
    prerequisites: ['chat_system', 'autocomplete'],
    ddia_concepts: ['email-protocols', 'spam-filtering', 'search-indexing'],
    tags: ['email', 'messaging', 'search'],
    metadata: {
      real_world_examples: ['Gmail', 'Outlook'],
      key_concepts: ['Email protocols', 'Spam detection', 'Email search']
    }
  },
  {
    slug: 'slack',
    title: 'Slack - Team Collaboration',
    description: 'Design a team communication platform',
    category: 'messaging',
    track: :concepts,
    order_in_track: 17,
    difficulty_base: 'advanced',
    xp_base: 1350,
    estimated_minutes: 115,
    prerequisites: ['whatsapp', 'chat_system'],
    ddia_concepts: ['channels', 'threads', 'integrations', 'search'],
    tags: ['collaboration', 'messaging', 'channels'],
    metadata: {
      real_world_examples: ['Slack', 'Microsoft Teams'],
      key_concepts: ['Channel architecture', 'Message threading', 'App integrations']
    }
  },
  {
    slug: 'zoom',
    title: 'Zoom - Video Conferencing',
    description: 'Design a video conferencing platform',
    category: 'streaming',
    track: :concepts,
    order_in_track: 18,
    difficulty_base: 'advanced',
    xp_base: 1550,
    estimated_minutes: 135,
    prerequisites: ['youtube', 'chat_system'],
    ddia_concepts: ['webrtc', 'sfu', 'recording', 'real-time-communication'],
    tags: ['video', 'real-time', 'conferencing'],
    metadata: {
      real_world_examples: ['Zoom', 'Google Meet'],
      key_concepts: ['WebRTC', 'SFU architecture', 'Cloud recording']
    }
  },
  {
    slug: 'amazon',
    title: 'Amazon - E-commerce',
    description: 'Design a large-scale e-commerce platform',
    category: 'general',
    track: :concepts,
    order_in_track: 19,
    difficulty_base: 'advanced',
    xp_base: 1600,
    estimated_minutes: 140,
    prerequisites: ['airbnb', 'autocomplete'],
    ddia_concepts: ['product-catalog', 'inventory', 'cart-system', 'order-processing'],
    tags: ['e-commerce', 'inventory', 'payments'],
    metadata: {
      real_world_examples: ['Amazon', 'eBay'],
      key_concepts: ['Product catalog', 'Inventory management', 'Order fulfillment']
    }
  },
  {
    slug: 'google_docs',
    title: 'Google Docs - Collaborative Editor',
    description: 'Design a real-time collaborative document editor',
    category: 'general',
    track: :concepts,
    order_in_track: 20,
    difficulty_base: 'advanced',
    xp_base: 1500,
    estimated_minutes: 130,
    prerequisites: ['dropbox', 'chat_system'],
    ddia_concepts: ['operational-transform', 'crdt', 'conflict-resolution'],
    tags: ['collaboration', 'real-time', 'editor'],
    metadata: {
      real_world_examples: ['Google Docs', 'Notion'],
      key_concepts: ['Operational transform', 'CRDTs', 'Presence awareness']
    }
  },
  {
    slug: 'github',
    title: 'GitHub - Version Control',
    description: 'Design a distributed version control platform',
    category: 'general',
    track: :concepts,
    order_in_track: 21,
    difficulty_base: 'advanced',
    xp_base: 1450,
    estimated_minutes: 125,
    prerequisites: ['dropbox', 'stackoverflow'],
    ddia_concepts: ['git-protocol', 'pull-requests', 'ci-cd'],
    tags: ['version-control', 'collaboration', 'ci-cd'],
    metadata: {
      real_world_examples: ['GitHub', 'GitLab'],
      key_concepts: ['Git operations', 'Pull requests', 'CI/CD pipelines']
    }
  },
  {
    slug: 'tiktok',
    title: 'TikTok - Short Video',
    description: 'Design a short-form video platform',
    category: 'streaming',
    track: :concepts,
    order_in_track: 22,
    difficulty_base: 'advanced',
    xp_base: 1550,
    estimated_minutes: 135,
    prerequisites: ['youtube', 'instagram'],
    ddia_concepts: ['recommendation-algorithm', 'video-processing', 'viral-content'],
    tags: ['video', 'recommendation', 'social'],
    metadata: {
      real_world_examples: ['TikTok', 'Instagram Reels'],
      key_concepts: ['Feed algorithm', 'Video effects', 'Viral mechanics']
    }
  },
  {
    slug: 'twitch',
    title: 'Twitch - Live Streaming',
    description: 'Design a live video streaming platform',
    category: 'streaming',
    track: :concepts,
    order_in_track: 23,
    difficulty_base: 'advanced',
    xp_base: 1600,
    estimated_minutes: 140,
    prerequisites: ['youtube', 'chat_system'],
    ddia_concepts: ['live-streaming', 'low-latency', 'chat-integration'],
    tags: ['streaming', 'live', 'chat'],
    metadata: {
      real_world_examples: ['Twitch', 'YouTube Live'],
      key_concepts: ['Live streaming', 'Low latency', 'Interactive chat']
    }
  },
  {
    slug: 'payment_system',
    title: 'Payment System',
    description: 'Design a secure payment processing system',
    category: 'general',
    track: :concepts,
    order_in_track: 24,
    difficulty_base: 'advanced',
    xp_base: 1650,
    estimated_minutes: 145,
    prerequisites: ['amazon', 'ticketmaster'],
    ddia_concepts: ['transactions', 'idempotency', 'reconciliation', 'pci-compliance'],
    tags: ['payments', 'transactions', 'security'],
    metadata: {
      real_world_examples: ['Stripe', 'PayPal', 'Square'],
      key_concepts: ['Transaction processing', 'Idempotency', 'Payment reconciliation']
    }
  },

  # ========== SYSTEMS TRACK (22 challenges) ==========
  {
    slug: 'google_search',
    title: 'Google Search Engine',
    description: 'Design a web-scale search engine',
    category: 'search',
    track: :systems,
    order_in_track: 1,
    difficulty_base: 'advanced',
    xp_base: 1800,
    estimated_minutes: 150,
    prerequisites: ['web_crawler', 'autocomplete'],
    ddia_concepts: ['inverted-index', 'pagerank', 'distributed-search'],
    tags: ['search', 'indexing', 'ranking'],
    metadata: {
      real_world_examples: ['Google Search', 'Bing'],
      key_concepts: ['Inverted index', 'PageRank', 'Query processing']
    }
  },
  {
    slug: 'google_maps',
    title: 'Google Maps',
    description: 'Design a mapping and navigation service',
    category: 'general',
    track: :systems,
    order_in_track: 2,
    difficulty_base: 'advanced',
    xp_base: 1900,
    estimated_minutes: 160,
    prerequisites: ['uber', 'yelp'],
    ddia_concepts: ['spatial-indexing', 'routing-algorithms', 'map-rendering'],
    tags: ['maps', 'geospatial', 'routing'],
    metadata: {
      real_world_examples: ['Google Maps', 'Apple Maps'],
      key_concepts: ['Spatial indexing', 'Routing algorithms', 'Map tiles']
    }
  },
  {
    slug: 'distributed_cache',
    title: 'Distributed Cache System',
    description: 'Design an enterprise distributed caching layer',
    category: 'caching',
    track: :systems,
    order_in_track: 3,
    difficulty_base: 'advanced',
    xp_base: 1700,
    estimated_minutes: 145,
    prerequisites: ['key_value_store', 'cdn_basic'],
    ddia_concepts: ['cache-coherence', 'eviction-policies', 'sharding'],
    tags: ['caching', 'distributed-systems', 'performance'],
    metadata: {
      real_world_examples: ['Memcached', 'Redis Cluster'],
      key_concepts: ['Cache coherence', 'Eviction policies', 'Hot keys']
    }
  },
  {
    slug: 'elasticsearch',
    title: 'Elasticsearch - Search Platform',
    description: 'Design a distributed search and analytics engine',
    category: 'search',
    track: :systems,
    order_in_track: 4,
    difficulty_base: 'advanced',
    xp_base: 1750,
    estimated_minutes: 150,
    prerequisites: ['google_search', 'key_value_store'],
    ddia_concepts: ['lucene', 'sharding', 'relevance-scoring'],
    tags: ['search', 'analytics', 'distributed'],
    metadata: {
      real_world_examples: ['Elasticsearch', 'Solr'],
      key_concepts: ['Lucene indexing', 'Relevance scoring', 'Aggregations']
    }
  },
  {
    slug: 'kafka',
    title: 'Apache Kafka - Messaging',
    description: 'Design a distributed event streaming platform',
    category: 'streaming',
    track: :systems,
    order_in_track: 5,
    difficulty_base: 'advanced',
    xp_base: 1850,
    estimated_minutes: 155,
    prerequisites: ['notification_system', 'task_scheduler'],
    ddia_concepts: ['event-streaming', 'log-compaction', 'consumer-groups'],
    tags: ['messaging', 'streaming', 'event-driven'],
    metadata: {
      real_world_examples: ['Apache Kafka', 'Pulsar'],
      key_concepts: ['Event streaming', 'Partitioning', 'Consumer groups']
    }
  },
  {
    slug: 'cassandra',
    title: 'Apache Cassandra - Database',
    description: 'Design a distributed wide-column database',
    category: 'database',
    track: :systems,
    order_in_track: 6,
    difficulty_base: 'advanced',
    xp_base: 1800,
    estimated_minutes: 150,
    prerequisites: ['key_value_store'],
    ddia_concepts: ['wide-column', 'tunable-consistency', 'gossip-protocol'],
    tags: ['database', 'nosql', 'distributed'],
    metadata: {
      real_world_examples: ['Cassandra', 'ScyllaDB'],
      key_concepts: ['Wide-column model', 'Tunable consistency', 'Gossip protocol']
    }
  },
  {
    slug: 'mongodb',
    title: 'MongoDB - Document Database',
    description: 'Design a distributed document database',
    category: 'database',
    track: :systems,
    order_in_track: 7,
    difficulty_base: 'advanced',
    xp_base: 1750,
    estimated_minutes: 145,
    prerequisites: ['key_value_store'],
    ddia_concepts: ['document-model', 'replication', 'sharding'],
    tags: ['database', 'nosql', 'documents'],
    metadata: {
      real_world_examples: ['MongoDB', 'CouchDB'],
      key_concepts: ['Document model', 'Replica sets', 'Sharding']
    }
  },
  {
    slug: 'prometheus',
    title: 'Prometheus - Monitoring',
    description: 'Design a time-series monitoring system',
    category: 'general',
    track: :systems,
    order_in_track: 8,
    difficulty_base: 'advanced',
    xp_base: 1700,
    estimated_minutes: 140,
    prerequisites: ['kafka', 'elasticsearch'],
    ddia_concepts: ['time-series', 'metrics-collection', 'alerting'],
    tags: ['monitoring', 'time-series', 'observability'],
    metadata: {
      real_world_examples: ['Prometheus', 'Datadog'],
      key_concepts: ['Time-series storage', 'Pull-based metrics', 'Alert rules']
    }
  },
  {
    slug: 'distributed_lock',
    title: 'Distributed Lock Service',
    description: 'Design a distributed coordination service',
    category: 'general',
    track: :systems,
    order_in_track: 9,
    difficulty_base: 'advanced',
    xp_base: 1650,
    estimated_minutes: 135,
    prerequisites: ['key_value_store', 'task_scheduler'],
    ddia_concepts: ['consensus', 'leader-election', 'zookeeper'],
    tags: ['distributed-systems', 'coordination', 'locking'],
    metadata: {
      real_world_examples: ['ZooKeeper', 'etcd', 'Consul'],
      key_concepts: ['Consensus algorithms', 'Leader election', 'Watch mechanism']
    }
  },
  {
    slug: 'load_balancer',
    title: 'Load Balancer',
    description: 'Design a layer 7 load balancing system',
    category: 'reliability',
    track: :systems,
    order_in_track: 10,
    difficulty_base: 'advanced',
    xp_base: 1700,
    estimated_minutes: 140,
    prerequisites: ['api_gateway', 'rate_limiter'],
    ddia_concepts: ['load-balancing-algorithms', 'health-checks', 'session-affinity'],
    tags: ['load-balancing', 'high-availability', 'infrastructure'],
    metadata: {
      real_world_examples: ['HAProxy', 'Nginx', 'AWS ELB'],
      key_concepts: ['LB algorithms', 'Health checks', 'Session persistence']
    }
  },
  {
    slug: 'api_rate_limiter_advanced',
    title: 'Distributed Rate Limiter',
    description: 'Design an enterprise-grade distributed rate limiting system',
    category: 'reliability',
    track: :systems,
    order_in_track: 11,
    difficulty_base: 'advanced',
    xp_base: 1650,
    estimated_minutes: 135,
    prerequisites: ['rate_limiter', 'distributed_cache'],
    ddia_concepts: ['distributed-rate-limiting', 'redis-lua', 'sliding-window-log'],
    tags: ['rate-limiting', 'distributed-systems', 'redis'],
    metadata: {
      real_world_examples: ['Cloudflare', 'Kong'],
      key_concepts: ['Distributed counters', 'Lua scripts', 'Multi-tier limits']
    }
  },
  {
    slug: 'sharding_system',
    title: 'Database Sharding System',
    description: 'Design an auto-sharding database system',
    category: 'database',
    track: :systems,
    order_in_track: 12,
    difficulty_base: 'advanced',
    xp_base: 1800,
    estimated_minutes: 150,
    prerequisites: ['cassandra', 'mongodb'],
    ddia_concepts: ['sharding-strategies', 'rebalancing', 'hot-spots'],
    tags: ['database', 'sharding', 'scaling'],
    metadata: {
      real_world_examples: ['Vitess', 'CockroachDB'],
      key_concepts: ['Sharding strategies', 'Rebalancing', 'Hot spot mitigation']
    }
  },
  {
    slug: 'multi_region_deployment',
    title: 'Multi-Region Deployment',
    description: 'Design a multi-region active-active system',
    category: 'reliability',
    track: :systems,
    order_in_track: 13,
    difficulty_base: 'advanced',
    xp_base: 1900,
    estimated_minutes: 160,
    prerequisites: ['distributed_cache', 'load_balancer'],
    ddia_concepts: ['active-active', 'conflict-resolution', 'global-load-balancing'],
    tags: ['multi-region', 'high-availability', 'disaster-recovery'],
    metadata: {
      real_world_examples: ['AWS Global Accelerator', 'Cloudflare'],
      key_concepts: ['Active-active replication', 'Global LB', 'Conflict resolution']
    }
  },
  {
    slug: 'disaster_recovery',
    title: 'Disaster Recovery System',
    description: 'Design a comprehensive DR and backup system',
    category: 'reliability',
    track: :systems,
    order_in_track: 14,
    difficulty_base: 'advanced',
    xp_base: 1850,
    estimated_minutes: 155,
    prerequisites: ['multi_region_deployment', 'dropbox'],
    ddia_concepts: ['backup-strategies', 'rto-rpo', 'failover'],
    tags: ['disaster-recovery', 'backup', 'high-availability'],
    metadata: {
      real_world_examples: ['AWS Backup', 'Veeam'],
      key_concepts: ['Backup strategies', 'RTO/RPO', 'Automated failover']
    }
  },
  {
    slug: 'service_mesh',
    title: 'Service Mesh',
    description: 'Design a microservices communication layer',
    category: 'general',
    track: :systems,
    order_in_track: 15,
    difficulty_base: 'advanced',
    xp_base: 1800,
    estimated_minutes: 150,
    prerequisites: ['load_balancer', 'api_gateway'],
    ddia_concepts: ['sidecar-proxy', 'traffic-management', 'observability'],
    tags: ['microservices', 'service-mesh', 'infrastructure'],
    metadata: {
      real_world_examples: ['Istio', 'Linkerd'],
      key_concepts: ['Sidecar pattern', 'Traffic splitting', 'mTLS']
    }
  },
  {
    slug: 'log_aggregation',
    title: 'Log Aggregation System',
    description: 'Design a distributed logging platform',
    category: 'general',
    track: :systems,
    order_in_track: 16,
    difficulty_base: 'advanced',
    xp_base: 1750,
    estimated_minutes: 145,
    prerequisites: ['kafka', 'elasticsearch'],
    ddia_concepts: ['log-shipping', 'log-parsing', 'retention-policies'],
    tags: ['logging', 'observability', 'analytics'],
    metadata: {
      real_world_examples: ['ELK Stack', 'Splunk'],
      key_concepts: ['Log shipping', 'Parsing', 'Index management']
    }
  },
  {
    slug: 'tracing_system',
    title: 'Distributed Tracing',
    description: 'Design a distributed request tracing system',
    category: 'general',
    track: :systems,
    order_in_track: 17,
    difficulty_base: 'advanced',
    xp_base: 1700,
    estimated_minutes: 140,
    prerequisites: ['prometheus', 'log_aggregation'],
    ddia_concepts: ['trace-context', 'sampling', 'span-storage'],
    tags: ['tracing', 'observability', 'performance'],
    metadata: {
      real_world_examples: ['Jaeger', 'Zipkin'],
      key_concepts: ['Trace context', 'Sampling strategies', 'Span analysis']
    }
  },
  {
    slug: 'cicd_pipeline',
    title: 'CI/CD Pipeline',
    description: 'Design a continuous integration and deployment system',
    category: 'general',
    track: :systems,
    order_in_track: 18,
    difficulty_base: 'advanced',
    xp_base: 1750,
    estimated_minutes: 145,
    prerequisites: ['github', 'task_scheduler'],
    ddia_concepts: ['build-automation', 'artifact-storage', 'deployment-strategies'],
    tags: ['ci-cd', 'automation', 'devops'],
    metadata: {
      real_world_examples: ['Jenkins', 'GitHub Actions'],
      key_concepts: ['Build pipelines', 'Artifact management', 'Blue-green deployment']
    }
  },
  {
    slug: 'container_orchestration',
    title: 'Container Orchestration',
    description: 'Design a container orchestration platform',
    category: 'general',
    track: :systems,
    order_in_track: 19,
    difficulty_base: 'advanced',
    xp_base: 1900,
    estimated_minutes: 160,
    prerequisites: ['service_mesh', 'cicd_pipeline'],
    ddia_concepts: ['scheduling', 'auto-scaling', 'self-healing'],
    tags: ['containers', 'kubernetes', 'orchestration'],
    metadata: {
      real_world_examples: ['Kubernetes', 'Docker Swarm'],
      key_concepts: ['Pod scheduling', 'Auto-scaling', 'Self-healing']
    }
  },
  {
    slug: 'data_warehouse',
    title: 'Data Warehouse',
    description: 'Design a cloud data warehouse for analytics',
    category: 'database',
    track: :systems,
    order_in_track: 20,
    difficulty_base: 'advanced',
    xp_base: 1850,
    estimated_minutes: 155,
    prerequisites: ['elasticsearch', 'sharding_system'],
    ddia_concepts: ['columnar-storage', 'query-optimization', 'materialized-views'],
    tags: ['analytics', 'data-warehouse', 'olap'],
    metadata: {
      real_world_examples: ['Snowflake', 'BigQuery'],
      key_concepts: ['Columnar storage', 'Query optimization', 'Data partitioning']
    }
  },
  {
    slug: 'ml_platform',
    title: 'Machine Learning Platform',
    description: 'Design an ML training and inference platform',
    category: 'general',
    track: :systems,
    order_in_track: 21,
    difficulty_base: 'advanced',
    xp_base: 1950,
    estimated_minutes: 165,
    prerequisites: ['data_warehouse', 'container_orchestration'],
    ddia_concepts: ['model-training', 'feature-store', 'model-serving'],
    tags: ['machine-learning', 'ml-ops', 'ai'],
    metadata: {
      real_world_examples: ['SageMaker', 'Vertex AI'],
      key_concepts: ['Model training', 'Feature engineering', 'Model serving']
    }
  },
  {
    slug: 'recommendation_engine',
    title: 'Recommendation Engine',
    description: 'Design a personalized recommendation system',
    category: 'general',
    track: :systems,
    order_in_track: 22,
    difficulty_base: 'advanced',
    xp_base: 1900,
    estimated_minutes: 160,
    prerequisites: ['ml_platform', 'netflix'],
    ddia_concepts: ['collaborative-filtering', 'content-based-filtering', 'hybrid-approaches'],
    tags: ['recommendation', 'machine-learning', 'personalization'],
    metadata: {
      real_world_examples: ['Netflix recommendations', 'Amazon product suggestions'],
      key_concepts: ['Collaborative filtering', 'Content-based filtering', 'Real-time personalization']
    }
  }
]

puts "   ✓ Defined #{challenge_definitions.length} challenges"

# ============================================================================
# STEP 3: Create Challenges and Challenge Levels
# ============================================================================
puts "\n🎯 Creating challenges with 5 levels each..."

challenge_definitions.each_with_index do |def_hash, index|
  track = tracks[def_hash[:track]]
  
  challenge = ProgressiveChallenge.find_or_create_by!(slug: def_hash[:slug]) do |c|
    c.title = def_hash[:title]
    c.description = def_hash[:description]
    c.category = def_hash[:category]
    c.progressive_learning_track = track
    c.order_in_track = def_hash[:order_in_track]
    c.difficulty_base = def_hash[:difficulty_base]
    c.xp_base = def_hash[:xp_base]
    c.estimated_minutes = def_hash[:estimated_minutes]
    c.prerequisites = []  # Will be set after all challenges are created
    c.tags = def_hash[:tags]
    c.ddia_concepts = def_hash[:ddia_concepts]
    c.is_active = true
    c.metadata = def_hash[:metadata]
  end
  
  # Create 5 levels for this challenge
  level_definitions = [
    {
      level_number: 1,
      level_name: 'Connectivity',
      description: 'Build basic connectivity and satisfy core functional requirements',
      xp_multiplier: 1.0,
      requirements_focus: 'Basic architecture and component connections',
      hints_count: 3
    },
    {
      level_number: 2,
      level_name: 'Capacity',
      description: 'Handle scale and meet performance requirements under normal load',
      xp_multiplier: 1.5,
      requirements_focus: 'Load handling and basic scaling',
      hints_count: 3
    },
    {
      level_number: 3,
      level_name: 'Optimization',
      description: 'Optimize for better performance, lower latency, and cost efficiency',
      xp_multiplier: 2.0,
      requirements_focus: 'Performance optimization and cost reduction',
      hints_count: 4
    },
    {
      level_number: 4,
      level_name: 'Resilience',
      description: 'Ensure resilience and handle failures gracefully with high availability',
      xp_multiplier: 2.5,
      requirements_focus: 'Fault tolerance and disaster recovery',
      hints_count: 4
    },
    {
      level_number: 5,
      level_name: 'Excellence',
      description: 'Perfect implementation with all NFRs optimized and production-ready',
      xp_multiplier: 3.0,
      requirements_focus: 'Production excellence and all NFRs',
      hints_count: 5
    }
  ]
  
  level_definitions.each do |level_def|
    ProgressiveChallengeLevel.find_or_create_by!(
      progressive_challenge_id: challenge.id,
      level_number: level_def[:level_number]
    ) do |level|
      level.level_name = level_def[:level_name]
      level.description = level_def[:description]
      
      # Calculate XP reward based on challenge difficulty and level
      difficulty_multiplier = case def_hash[:difficulty_base]
      when 'beginner' then 1.0
      when 'intermediate' then 1.5
      when 'advanced' then 2.0
      else 1.0
      end
      
      base_level_xp = [50, 75, 100, 150, 200][level_def[:level_number] - 1]
      level.xp_reward = (base_level_xp * difficulty_multiplier * level_def[:xp_multiplier]).to_i
      
      # Requirements vary by level
      level.requirements = {
        focus: level_def[:requirements_focus],
        test_categories: case level_def[:level_number]
        when 1 then ['functional']
        when 2 then ['functional', 'performance']
        when 3 then ['performance', 'scalability']
        when 4 then ['reliability', 'availability']
        when 5 then ['cost', 'optimization', 'all_nfrs']
        end
      }
      
      # Test cases (simplified for seed data - real tests would come from frontend)
      level.test_cases = {
        count: level_def[:level_number] * 2,
        types: level.requirements[:test_categories]
      }
      
      # Passing criteria
      level.passing_criteria = {
        min_score: 60,
        required_components: level_def[:level_number] + 2,
        max_latency_ms: [1000, 500, 200, 100, 50][level_def[:level_number] - 1],
        min_availability: [0.9, 0.95, 0.99, 0.999, 0.9999][level_def[:level_number] - 1]
      }
      
      # Hints (generic for now)
      level.hints = (1..level_def[:hints_count]).map do |h|
        "Hint #{h}: Consider #{level_def[:requirements_focus].downcase}"
      end
      
      level.solution_approach = "Approach for #{level_def[:level_name]}: Focus on #{level_def[:requirements_focus]}"
      level.estimated_minutes = 10 + (level_def[:level_number] * 5)
    end
  end
  
  print "." if (index + 1) % 10 == 0
end

puts "\n   ✓ Created #{ProgressiveChallenge.count} challenges with #{ProgressiveChallengeLevel.count} levels"

# ============================================================================
# STEP 4: Set Up Prerequisites
# ============================================================================
puts "\n🔗 Setting up prerequisite dependencies..."

# Build prerequisite map
prerequisite_map = challenge_definitions.each_with_object({}) do |def_hash, map|
  map[def_hash[:slug]] = def_hash[:prerequisites]
end

# Update challenges with prerequisite IDs
challenge_definitions.each do |def_hash|
  challenge = ProgressiveChallenge.find_by!(slug: def_hash[:slug])
  prereq_ids = def_hash[:prerequisites].map do |prereq_slug|
    prereq_challenge = ProgressiveChallenge.find_by(slug: prereq_slug)
    prereq_challenge&.id
  end.compact
  
  challenge.update!(prerequisites: prereq_ids)
end

puts "   ✓ Set up #{prerequisite_map.values.flatten.count} prerequisite relationships"

# ============================================================================
# STEP 5: Create Sample Achievements
# ============================================================================
puts "\n🏆 Creating achievements..."

achievements = [
  {
    slug: 'first_steps',
    name: 'First Steps',
    description: 'Complete your first challenge',
    icon_url: '🎯',
    category: 'milestone',
    rarity: 'common',
    xp_reward: 50,
    criteria: { challenges_completed: 1 }
  },
  {
    slug: 'streak_7',
    name: '7 Day Streak',
    description: 'Practice for 7 consecutive days',
    icon_url: '🔥',
    category: 'streak',
    rarity: 'common',
    xp_reward: 100,
    criteria: { streak_days: 7 }
  },
  {
    slug: 'fundamentals_master',
    name: 'Fundamentals Master',
    description: 'Complete all fundamentals track challenges',
    icon_url: '🎓',
    category: 'mastery',
    rarity: 'rare',
    xp_reward: 500,
    criteria: { track_completed: 'fundamentals' }
  },
  {
    slug: 'perfectionist',
    name: 'Perfectionist',
    description: 'Score 100% on any level',
    icon_url: '💯',
    category: 'performance',
    rarity: 'rare',
    xp_reward: 200,
    criteria: { perfect_score: true }
  },
  {
    slug: 'speedrun',
    name: 'Speedrun',
    description: 'Complete a challenge in under 30 minutes',
    icon_url: '⚡',
    category: 'speed',
    rarity: 'epic',
    xp_reward: 300,
    criteria: { time_under_minutes: 30 }
  },
  {
    slug: 'legend',
    name: 'Legend',
    description: 'Reach level 50',
    icon_url: '👑',
    category: 'milestone',
    rarity: 'legendary',
    xp_reward: 1000,
    criteria: { user_level: 50 }
  }
]

achievements.each do |ach|
  ProgressiveAchievement.find_or_create_by!(slug: ach[:slug]) do |a|
    a.name = ach[:name]
    a.description = ach[:description]
    a.icon_url = ach[:icon_url]
    a.category = ach[:category]
    a.rarity = ach[:rarity]
    a.xp_reward = ach[:xp_reward]
    a.criteria = ach[:criteria]
    a.is_active = true
  end
end

puts "   ✓ Created #{ProgressiveAchievement.count} achievements"

# ============================================================================
# STEP 6: Create Skills
# ============================================================================
puts "\n🌳 Creating skill tree..."

skills = [
  {
    slug: 'caching',
    name: 'Caching Strategies',
    description: 'Master various caching patterns and policies',
    category: 'performance',
    parent: nil
  },
  {
    slug: 'distributed_systems',
    name: 'Distributed Systems',
    description: 'Design scalable distributed architectures',
    category: 'architecture',
    parent: nil
  },
  {
    slug: 'database_design',
    name: 'Database Design',
    description: 'Optimize data models and queries',
    category: 'data',
    parent: nil
  },
  {
    slug: 'api_design',
    name: 'API Design',
    description: 'Create robust and scalable APIs',
    category: 'architecture',
    parent: nil
  },
  {
    slug: 'reliability',
    name: 'Reliability Engineering',
    description: 'Build fault-tolerant systems',
    category: 'operations',
    parent: nil
  }
]

skills.each do |skill_def|
  ProgressiveSkill.find_or_create_by!(slug: skill_def[:slug]) do |s|
    s.name = skill_def[:name]
    s.description = skill_def[:description]
    s.category = skill_def[:category]
    s.parent_skill_id = nil  # Simplified for now
    s.prerequisites = []
    s.max_level = 5
    s.xp_per_level = 100
  end
end

puts "   ✓ Created #{ProgressiveSkill.count} skills"

# ============================================================================
# Summary
# ============================================================================
puts "\n" + "="*80
puts "✅ Progressive Flow Seed Data Complete!"
puts "="*80
puts "📊 Summary:"
puts "   - Learning Tracks: #{ProgressiveLearningTrack.count}"
puts "   - Challenges: #{ProgressiveChallenge.count}"
puts "   - Challenge Levels: #{ProgressiveChallengeLevel.count}"
puts "   - Achievements: #{ProgressiveAchievement.count}"
puts "   - Skills: #{ProgressiveSkill.count}"
puts ""
puts "🎯 Track Distribution:"
tracks.each do |key, track|
  count = ProgressiveChallenge.where(progressive_learning_track_id: track.id).count
  puts "   - #{track.title}: #{count} challenges"
end
puts ""
puts "🔗 Prerequisites: #{ProgressiveChallenge.where.not(prerequisites: []).count} challenges have prerequisites"
puts ""
puts "💡 Next Steps:"
puts "   1. Verify: rails console → ProgressiveChallenge.count"
puts "   2. Test API: GET /api/v1/progressive/challenges"
puts "="*80