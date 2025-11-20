# GraphQL API Development Course
puts "Creating GraphQL API Development Course..."

graphql_course = Course.find_or_create_by!(slug: 'graphql-api-development') do |course|
  course.title = 'GraphQL API Development'
  course.description = 'Build modern, flexible APIs with GraphQL'
  course.difficulty_level = 'intermediate'
  course.published = true
  course.sequence_order = 29
  course.estimated_hours = 22
  course.learning_objectives = JSON.generate([
    "Understand GraphQL vs REST",
    "Design GraphQL schemas",
    "Implement queries, mutations, and subscriptions",
    "Optimize with DataLoader",
    "Secure GraphQL APIs",
    "Deploy production GraphQL services"
  ])
end

puts "Created course: #{graphql_course.title}"

# ==========================================
# MODULE 1: GraphQL Fundamentals
# ==========================================

module1 = CourseModule.find_or_create_by!(slug: 'graphql-fundamentals', course: graphql_course) do |mod|
  mod.title = 'GraphQL Fundamentals'
  mod.description = 'GraphQL basics, schema design, types, and resolvers'
  mod.sequence_order = 1
  mod.estimated_minutes = 90
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Understand GraphQL vs REST differences",
    "Write GraphQL schemas using SDL",
    "Define queries, mutations, and types",
    "Implement resolvers with context and arguments"
  ])
end

lesson1_1 = CourseLesson.find_or_create_by!(title: "GraphQL Basics and Schema Design") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # GraphQL Basics and Schema Design

    **GraphQL** is a query language for APIs and a runtime for executing those queries. Developed by Facebook in 2012 and open-sourced in 2015.

    ## GraphQL vs REST

    ### REST Approach

    ```javascript
    // Get user info - requires 3 requests
    GET /users/123
    {
      "id": 123,
      "name": "Alice",
      "email": "alice@example.com"
    }

    GET /users/123/posts
    [
      {"id": 1, "title": "First Post"},
      {"id": 2, "title": "Second Post"}
    ]

    GET /users/123/followers
    [
      {"id": 456, "name": "Bob"},
      {"id": 789, "name": "Charlie"}
    ]

    // Problem: 3 round trips, over-fetching, under-fetching
    ```

    ### GraphQL Approach

    ```graphql
    # Single request - get exactly what you need
    query {
      user(id: 123) {
        name
        email
        posts {
          title
        }
        followers {
          name
        }
      }
    }

    # Response - single request!
    {
      "data": {
        "user": {
          "name": "Alice",
          "email": "alice@example.com",
          "posts": [
            {"title": "First Post"},
            {"title": "Second Post"}
          ],
          "followers": [
            {"name": "Bob"},
            {"name": "Charlie"}
          ]
        }
      }
    }
    ```

    ### Key Differences

    | Feature | REST | GraphQL |
    |---------|------|---------|
    | **Endpoints** | Multiple endpoints | Single endpoint |
    | **Data fetching** | Fixed response | Client specifies exact data |
    | **Over-fetching** | Common | Never |
    | **Under-fetching** | Common (N+1) | Solved with careful schema |
    | **Versioning** | /v1, /v2 | Schema evolution |
    | **Documentation** | Separate (Swagger) | Built-in (introspection) |
    | **Caching** | HTTP caching | Requires implementation |

    ## Schema Definition Language (SDL)

    GraphQL uses a **strongly-typed schema** to define your API.

    ### Basic Types

    ```graphql
    # Scalar types (built-in)
    Int       # Signed 32-bit integer
    Float     # Signed double-precision float
    String    # UTF-8 character sequence
    Boolean   # true or false
    ID        # Unique identifier (serialized as String)

    # Custom scalar
    scalar Date
    scalar DateTime
    scalar JSON
    ```

    ### Object Types

    ```graphql
    # User type
    type User {
      id: ID!              # ! means non-nullable (required)
      name: String!
      email: String!
      age: Int
      isActive: Boolean!
      createdAt: DateTime!
      posts: [Post!]!      # Array of posts (array and items non-null)
      followers: [User!]   # Array can be null, but items can't
    }

    # Post type
    type Post {
      id: ID!
      title: String!
      content: String!
      author: User!        # Relationship to User
      published: Boolean!
      tags: [String!]!
      createdAt: DateTime!
      updatedAt: DateTime!
    }

    # Comment type
    type Comment {
      id: ID!
      text: String!
      author: User!
      post: Post!
      createdAt: DateTime!
    }
    ```

    ### Query Type

    **Entry point for reading data**

    ```graphql
    type Query {
      # Get single user by ID
      user(id: ID!): User

      # Get all users (with pagination)
      users(limit: Int, offset: Int): [User!]!

      # Search users
      searchUsers(query: String!): [User!]!

      # Get single post
      post(id: ID!): Post

      # Get all posts (with filters)
      posts(
        authorId: ID
        published: Boolean
        limit: Int
        offset: Int
      ): [Post!]!

      # Get current logged-in user
      me: User
    }
    ```

    ### Mutation Type

    **Entry point for modifying data**

    ```graphql
    type Mutation {
      # User mutations
      createUser(input: CreateUserInput!): User!
      updateUser(id: ID!, input: UpdateUserInput!): User!
      deleteUser(id: ID!): Boolean!

      # Post mutations
      createPost(input: CreatePostInput!): Post!
      updatePost(id: ID!, input: UpdatePostInput!): Post!
      deletePost(id: ID!): Boolean!
      publishPost(id: ID!): Post!

      # Comment mutations
      addComment(postId: ID!, text: String!): Comment!
      deleteComment(id: ID!): Boolean!
    }
    ```

    ### Input Types

    **Used for complex arguments**

    ```graphql
    input CreateUserInput {
      name: String!
      email: String!
      age: Int
      password: String!
    }

    input UpdateUserInput {
      name: String
      email: String
      age: Int
    }

    input CreatePostInput {
      title: String!
      content: String!
      tags: [String!]
      published: Boolean
    }

    input UpdatePostInput {
      title: String
      content: String
      tags: [String!]
      published: Boolean
    }
    ```

    ### Enums

    ```graphql
    enum Role {
      ADMIN
      MODERATOR
      USER
      GUEST
    }

    enum PostStatus {
      DRAFT
      PUBLISHED
      ARCHIVED
    }

    type User {
      id: ID!
      name: String!
      role: Role!
    }

    type Post {
      id: ID!
      title: String!
      status: PostStatus!
    }
    ```

    ### Interfaces

    **Abstract type that other types can implement**

    ```graphql
    interface Node {
      id: ID!
      createdAt: DateTime!
      updatedAt: DateTime!
    }

    type User implements Node {
      id: ID!
      createdAt: DateTime!
      updatedAt: DateTime!
      name: String!
      email: String!
    }

    type Post implements Node {
      id: ID!
      createdAt: DateTime!
      updatedAt: DateTime!
      title: String!
      content: String!
    }

    # Query using interface
    type Query {
      node(id: ID!): Node
    }
    ```

    ### Unions

    **Type that could be one of several types**

    ```graphql
    union SearchResult = User | Post | Comment

    type Query {
      search(query: String!): [SearchResult!]!
    }

    # Client query with fragments
    query {
      search(query: "graphql") {
        ... on User {
          name
          email
        }
        ... on Post {
          title
          content
        }
        ... on Comment {
          text
          author { name }
        }
      }
    }
    ```

    ## Complete Blog API Schema Example

    ```graphql
    # Scalars
    scalar DateTime
    scalar JSON

    # Enums
    enum Role {
      ADMIN
      MODERATOR
      USER
    }

    enum PostStatus {
      DRAFT
      PUBLISHED
      ARCHIVED
    }

    # Types
    type User {
      id: ID!
      name: String!
      email: String!
      role: Role!
      avatar: String
      bio: String
      posts: [Post!]!
      comments: [Comment!]!
      followers: [User!]!
      following: [User!]!
      createdAt: DateTime!
      updatedAt: DateTime!
    }

    type Post {
      id: ID!
      title: String!
      content: String!
      excerpt: String
      status: PostStatus!
      author: User!
      tags: [String!]!
      comments: [Comment!]!
      likes: Int!
      viewCount: Int!
      createdAt: DateTime!
      updatedAt: DateTime!
      publishedAt: DateTime
    }

    type Comment {
      id: ID!
      text: String!
      author: User!
      post: Post!
      parent: Comment          # For nested comments
      replies: [Comment!]!
      createdAt: DateTime!
      updatedAt: DateTime!
    }

    # Input types
    input CreateUserInput {
      name: String!
      email: String!
      password: String!
      avatar: String
      bio: String
    }

    input UpdateUserInput {
      name: String
      email: String
      avatar: String
      bio: String
    }

    input CreatePostInput {
      title: String!
      content: String!
      excerpt: String
      tags: [String!]
      status: PostStatus
    }

    input UpdatePostInput {
      title: String
      content: String
      excerpt: String
      tags: [String!]
      status: PostStatus
    }

    # Queries
    type Query {
      # User queries
      me: User
      user(id: ID!): User
      users(limit: Int = 10, offset: Int = 0): [User!]!

      # Post queries
      post(id: ID!): Post
      posts(
        authorId: ID
        status: PostStatus
        tag: String
        limit: Int = 10
        offset: Int = 0
      ): [Post!]!
      searchPosts(query: String!): [Post!]!

      # Comment queries
      comment(id: ID!): Comment
      comments(postId: ID!, limit: Int = 20): [Comment!]!
    }

    # Mutations
    type Mutation {
      # Authentication
      register(input: CreateUserInput!): AuthPayload!
      login(email: String!, password: String!): AuthPayload!
      logout: Boolean!

      # User mutations
      updateUser(input: UpdateUserInput!): User!
      deleteUser: Boolean!
      followUser(userId: ID!): User!
      unfollowUser(userId: ID!): User!

      # Post mutations
      createPost(input: CreatePostInput!): Post!
      updatePost(id: ID!, input: UpdatePostInput!): Post!
      deletePost(id: ID!): Boolean!
      likePost(id: ID!): Post!
      unlikePost(id: ID!): Post!

      # Comment mutations
      addComment(postId: ID!, text: String!, parentId: ID): Comment!
      updateComment(id: ID!, text: String!): Comment!
      deleteComment(id: ID!): Boolean!
    }

    # Subscriptions (real-time)
    type Subscription {
      postCreated: Post!
      commentAdded(postId: ID!): Comment!
      userJoined: User!
    }

    type AuthPayload {
      token: String!
      user: User!
    }
    ```

    ## Resolvers with Context and Arguments

    Resolvers are functions that return data for each field.

    ### Basic Resolver Structure

    ```javascript
    // resolver function signature
    fieldName: (parent, args, context, info) => {
      // parent: result from parent resolver
      // args: field arguments
      // context: shared data (db, user, etc.)
      // info: query metadata
    }
    ```

    ### Query Resolvers

    ```javascript
    const resolvers = {
      Query: {
        // Simple resolver
        me: (parent, args, context) => {
          // context contains authenticated user
          if (!context.user) {
            throw new Error('Not authenticated');
          }
          return context.db.users.findById(context.user.id);
        },

        // Resolver with arguments
        user: async (parent, args, context) => {
          const { id } = args;
          return await context.db.users.findById(id);
        },

        // Resolver with multiple arguments
        posts: async (parent, args, context) => {
          const { authorId, status, tag, limit, offset } = args;

          let query = context.db.posts;

          if (authorId) {
            query = query.where({ authorId });
          }
          if (status) {
            query = query.where({ status });
          }
          if (tag) {
            query = query.whereJsonContains('tags', tag);
          }

          return await query
            .limit(limit)
            .offset(offset)
            .orderBy('createdAt', 'desc');
        },

        // Search resolver
        searchPosts: async (parent, args, context) => {
          const { query } = args;
          return await context.db.posts
            .where('title', 'like', `%${query}%`)
            .orWhere('content', 'like', `%${query}%`)
            .limit(20);
        }
      }
    };
    ```

    ### Mutation Resolvers

    ```javascript
    const resolvers = {
      Mutation: {
        // Create user
        createUser: async (parent, args, context) => {
          const { input } = args;
          const { name, email, password } = input;

          // Hash password
          const hashedPassword = await bcrypt.hash(password, 10);

          // Create user
          const user = await context.db.users.create({
            name,
            email,
            password: hashedPassword
          });

          return user;
        },

        // Update user (with auth check)
        updateUser: async (parent, args, context) => {
          if (!context.user) {
            throw new Error('Not authenticated');
          }

          const { input } = args;
          const userId = context.user.id;

          const user = await context.db.users.update(userId, input);
          return user;
        },

        // Create post
        createPost: async (parent, args, context) => {
          if (!context.user) {
            throw new Error('Not authenticated');
          }

          const { input } = args;
          const post = await context.db.posts.create({
            ...input,
            authorId: context.user.id,
            status: input.status || 'DRAFT'
          });

          return post;
        },

        // Like post (idempotent)
        likePost: async (parent, args, context) => {
          if (!context.user) {
            throw new Error('Not authenticated');
          }

          const { id } = args;

          // Check if already liked
          const existing = await context.db.likes.findOne({
            userId: context.user.id,
            postId: id
          });

          if (!existing) {
            await context.db.likes.create({
              userId: context.user.id,
              postId: id
            });

            // Increment like count
            await context.db.posts.increment('likes', { id });
          }

          return await context.db.posts.findById(id);
        },

        // Add comment
        addComment: async (parent, args, context) => {
          if (!context.user) {
            throw new Error('Not authenticated');
          }

          const { postId, text, parentId } = args;

          const comment = await context.db.comments.create({
            text,
            authorId: context.user.id,
            postId,
            parentId
          });

          // Publish to subscription
          context.pubsub.publish('COMMENT_ADDED', {
            commentAdded: comment,
            postId
          });

          return comment;
        }
      }
    };
    ```

    ### Field Resolvers

    **Resolve nested fields**

    ```javascript
    const resolvers = {
      // Field resolvers for User type
      User: {
        // Resolve user's posts
        posts: async (parent, args, context) => {
          // parent is the User object
          return await context.db.posts.where({ authorId: parent.id });
        },

        // Resolve user's followers
        followers: async (parent, args, context) => {
          const followers = await context.db.follows
            .where({ followingId: parent.id })
            .select('followerId');

          const userIds = followers.map(f => f.followerId);
          return await context.db.users.whereIn('id', userIds);
        },

        // Resolve user's following
        following: async (parent, args, context) => {
          const following = await context.db.follows
            .where({ followerId: parent.id })
            .select('followingId');

          const userIds = following.map(f => f.followingId);
          return await context.db.users.whereIn('id', userIds);
        }
      },

      // Field resolvers for Post type
      Post: {
        // Resolve post's author
        author: async (parent, args, context) => {
          return await context.db.users.findById(parent.authorId);
        },

        // Resolve post's comments
        comments: async (parent, args, context) => {
          return await context.db.comments
            .where({ postId: parent.id })
            .orderBy('createdAt', 'asc');
        },

        // Generate excerpt if not stored
        excerpt: (parent) => {
          if (parent.excerpt) return parent.excerpt;
          return parent.content.substring(0, 200) + '...';
        }
      },

      // Field resolvers for Comment type
      Comment: {
        author: async (parent, args, context) => {
          return await context.db.users.findById(parent.authorId);
        },

        post: async (parent, args, context) => {
          return await context.db.posts.findById(parent.postId);
        },

        // Nested comments
        replies: async (parent, args, context) => {
          return await context.db.comments
            .where({ parentId: parent.id })
            .orderBy('createdAt', 'asc');
        },

        parent: async (parent, args, context) => {
          if (!parent.parentId) return null;
          return await context.db.comments.findById(parent.parentId);
        }
      }
    };
    ```

    ### Context Object

    ```javascript
    // Apollo Server setup with context
    const { ApolloServer } = require('apollo-server');
    const jwt = require('jsonwebtoken');

    const server = new ApolloServer({
      typeDefs,
      resolvers,
      context: async ({ req }) => {
        // Get token from header
        const token = req.headers.authorization || '';

        // Verify token and get user
        let user = null;
        if (token) {
          try {
            const decoded = jwt.verify(
              token.replace('Bearer ', ''),
              process.env.JWT_SECRET
            );
            user = await db.users.findById(decoded.userId);
          } catch (err) {
            // Invalid token
          }
        }

        // Return context object (available in all resolvers)
        return {
          db,           // Database instance
          user,         // Authenticated user (or null)
          pubsub,       // For subscriptions
          loaders: {    // DataLoaders (see next lesson)
            user: userLoader,
            post: postLoader
          }
        };
      }
    });

    server.listen().then(({ url }) => {
      console.log(`🚀 Server ready at ${url}`);
    });
    ```

    ## Client Queries

    ### Query Examples

    ```graphql
    # Get user with posts
    query GetUser($id: ID!) {
      user(id: $id) {
        id
        name
        email
        posts {
          id
          title
          excerpt
          createdAt
        }
      }
    }

    # Variables
    {
      "id": "123"
    }

    # Get posts with filters
    query GetPosts($authorId: ID, $status: PostStatus, $limit: Int) {
      posts(authorId: $authorId, status: $status, limit: $limit) {
        id
        title
        excerpt
        author {
          name
          avatar
        }
        tags
        likes
        createdAt
      }
    }

    # Get post with nested comments
    query GetPost($id: ID!) {
      post(id: $id) {
        id
        title
        content
        author {
          name
          avatar
        }
        comments {
          id
          text
          author {
            name
          }
          replies {
            id
            text
            author {
              name
            }
          }
        }
      }
    }
    ```

    ### Mutation Examples

    ```graphql
    # Create post
    mutation CreatePost($input: CreatePostInput!) {
      createPost(input: $input) {
        id
        title
        content
        status
        createdAt
      }
    }

    # Variables
    {
      "input": {
        "title": "Getting Started with GraphQL",
        "content": "GraphQL is amazing...",
        "tags": ["graphql", "api"],
        "status": "PUBLISHED"
      }
    }

    # Add comment
    mutation AddComment($postId: ID!, $text: String!) {
      addComment(postId: $postId, text: $text) {
        id
        text
        author {
          name
        }
        createdAt
      }
    }

    # Like post
    mutation LikePost($id: ID!) {
      likePost(id: $id) {
        id
        likes
      }
    }
    ```

    ### Fragments

    ```graphql
    # Define reusable fragment
    fragment UserInfo on User {
      id
      name
      email
      avatar
    }

    fragment PostInfo on Post {
      id
      title
      excerpt
      createdAt
      author {
        ...UserInfo
      }
    }

    # Use fragments
    query GetFeed {
      posts(limit: 10) {
        ...PostInfo
        comments {
          id
          text
          author {
            ...UserInfo
          }
        }
      }
    }
    ```

    **Next**: We'll explore advanced GraphQL patterns including pagination, DataLoader, and subscriptions.
  MARKDOWN
  lesson.key_concepts = ['GraphQL', 'schema', 'SDL', 'queries', 'mutations', 'resolvers', 'types', 'REST comparison']
end

ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_1) do |item|
  item.sequence_order = 1
  item.required = true
end

quiz1 = Quiz.find_or_create_by!(title: "GraphQL Fundamentals Quiz") do |quiz|
  quiz.description = 'Test your understanding of GraphQL basics and schema design'
  quiz.time_limit_minutes = 15
  quiz.passing_score = 70
  quiz.max_attempts = 3
end

[
  {
    question_text: "What is the main advantage of GraphQL over REST?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "Client can request exactly the data it needs in a single request", correct: true },
      { text: "GraphQL is faster than REST", correct: false },
      { text: "GraphQL doesn't require a database", correct: false },
      { text: "GraphQL is easier to learn", correct: false }
    ]),
    explanation: "GraphQL allows clients to request exactly the data they need in a single request, avoiding over-fetching and under-fetching issues common in REST APIs.",
    difficulty_level: "easy"
  },
  {
    question_text: "What does the exclamation mark (!) mean in a GraphQL schema?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "The field is non-nullable (required)", correct: true },
      { text: "The field is unique", correct: false },
      { text: "The field is indexed", correct: false },
      { text: "The field is deprecated", correct: false }
    ]),
    explanation: "In GraphQL schemas, the exclamation mark (!) indicates that a field is non-nullable, meaning it must always have a value.",
    difficulty_level: "easy"
  },
  {
    question_text: "What are the four parameters available in a GraphQL resolver function?",
    question_type: "fill_blank",
    points: 15,
    correct_answer: "parent, args, context, info|parent args context info",
    explanation: "GraphQL resolver functions receive four parameters: parent (result from parent resolver), args (field arguments), context (shared data like db, user), and info (query metadata).",
    difficulty_level: "medium"
  },
  {
    question_text: "True or False: In GraphQL, mutations should be used for reading data.",
    question_type: "true_false",
    points: 5,
    correct_answer: "false",
    explanation: "Queries are used for reading data, while mutations are used for modifying data (create, update, delete operations).",
    difficulty_level: "easy"
  },
  {
    question_text: "Which GraphQL type is used to define complex arguments for mutations?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "Input types", correct: true },
      { text: "Object types", correct: false },
      { text: "Scalar types", correct: false },
      { text: "Interface types", correct: false }
    ]),
    explanation: "Input types are specifically designed for passing complex arguments to mutations and queries in GraphQL.",
    difficulty_level: "medium"
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer] if q_data[:correct_answer]
    question.explanation = q_data[:explanation]
    question.difficulty_level = q_data[:difficulty_level]
  end
end

ModuleItem.find_or_create_by!(course_module: module1, item: quiz1) do |item|
  item.sequence_order = 2
  item.required = true
end

puts "  ✅ Created module: #{module1.title}"

# ==========================================
# MODULE 2: Advanced GraphQL
# ==========================================

module2 = CourseModule.find_or_create_by!(slug: 'graphql-advanced', course: graphql_course) do |mod|
  mod.title = 'Advanced GraphQL'
  mod.description = 'Pagination, DataLoader, authentication, subscriptions'
  mod.sequence_order = 2
  mod.estimated_minutes = 110
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Implement cursor-based pagination",
    "Solve N+1 queries with DataLoader",
    "Add authentication and authorization",
    "Implement real-time subscriptions"
  ])
end

lesson2_1 = CourseLesson.find_or_create_by!(title: "Advanced GraphQL Patterns") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # Advanced GraphQL Patterns

    ## Pagination

    Pagination is essential for handling large datasets efficiently.

    ### Offset-Based Pagination

    **Simple but has limitations**

    ```graphql
    type Query {
      posts(limit: Int = 10, offset: Int = 0): [Post!]!
    }

    # Client query
    query {
      # Page 1
      posts(limit: 10, offset: 0) {
        id
        title
      }

      # Page 2
      posts(limit: 10, offset: 10) {
        id
        title
      }
    }
    ```

    **Resolver:**

    ```javascript
    const resolvers = {
      Query: {
        posts: async (parent, args, context) => {
          const { limit, offset } = args;
          return await context.db.posts
            .limit(limit)
            .offset(offset)
            .orderBy('createdAt', 'desc');
        }
      }
    };
    ```

    **Problems:**
    - ❌ Inconsistent results if data changes between pages
    - ❌ Can't efficiently "jump to page X"
    - ❌ Performance degrades with large offsets

    ### Cursor-Based Pagination (Relay Specification)

    **Industry standard for GraphQL**

    ```graphql
    # Relay connection pattern
    type PostConnection {
      edges: [PostEdge!]!
      pageInfo: PageInfo!
      totalCount: Int!
    }

    type PostEdge {
      cursor: String!
      node: Post!
    }

    type PageInfo {
      hasNextPage: Boolean!
      hasPreviousPage: Boolean!
      startCursor: String
      endCursor: String
    }

    type Query {
      posts(
        first: Int
        after: String
        last: Int
        before: String
      ): PostConnection!
    }
    ```

    **Client query:**

    ```graphql
    # Get first 10 posts
    query {
      posts(first: 10) {
        edges {
          cursor
          node {
            id
            title
            createdAt
          }
        }
        pageInfo {
          hasNextPage
          endCursor
        }
        totalCount
      }
    }

    # Get next 10 posts using cursor
    query {
      posts(first: 10, after: "Y3Vyc29yOjEw") {
        edges {
          cursor
          node {
            id
            title
          }
        }
        pageInfo {
          hasNextPage
          endCursor
        }
      }
    }
    ```

    **Resolver implementation:**

    ```javascript
    const { fromGlobalId, toGlobalId } = require('graphql-relay');

    const resolvers = {
      Query: {
        posts: async (parent, args, context) => {
          const { first, after, last, before } = args;

          let query = context.db.posts.orderBy('createdAt', 'desc');

          // Decode cursor
          if (after) {
            const { id } = fromGlobalId(after);
            query = query.where('id', '<', id);
          }

          if (before) {
            const { id } = fromGlobalId(before);
            query = query.where('id', '>', id);
          }

          // Fetch one extra to determine hasNextPage
          const limit = first || last || 10;
          const posts = await query.limit(limit + 1);

          const hasNextPage = posts.length > limit;
          const edges = posts.slice(0, limit).map(post => ({
            cursor: toGlobalId('Post', post.id),
            node: post
          }));

          const totalCount = await context.db.posts.count();

          return {
            edges,
            pageInfo: {
              hasNextPage,
              hasPreviousPage: !!after,
              startCursor: edges[0]?.cursor,
              endCursor: edges[edges.length - 1]?.cursor
            },
            totalCount
          };
        }
      }
    };
    ```

    ## DataLoader for N+1 Problem

    **The N+1 Problem:**

    ```graphql
    query {
      posts {           # 1 query to get posts
        title
        author {        # N queries (one per post) - BAD!
          name
        }
      }
    }
    ```

    **Without DataLoader:**

    ```javascript
    const resolvers = {
      Post: {
        author: async (parent, args, context) => {
          // This runs for EACH post - N+1 queries!
          return await context.db.users.findById(parent.authorId);
        }
      }
    };

    // Query execution:
    // SELECT * FROM posts;                    -- 1 query
    // SELECT * FROM users WHERE id = 1;       -- N queries
    // SELECT * FROM users WHERE id = 2;
    // SELECT * FROM users WHERE id = 3;
    // ... (one query per post)
    ```

    ### DataLoader Solution

    **Batches and caches requests**

    ```javascript
    const DataLoader = require('dataloader');

    // Create DataLoader
    const createUserLoader = (db) => {
      return new DataLoader(async (userIds) => {
        console.log('Batch loading users:', userIds);

        // Single query for all users!
        const users = await db.users.whereIn('id', userIds);

        // Return users in same order as userIds
        const userMap = new Map(users.map(u => [u.id, u]));
        return userIds.map(id => userMap.get(id));
      });
    };

    // Context setup
    const server = new ApolloServer({
      typeDefs,
      resolvers,
      context: () => ({
        db,
        loaders: {
          user: createUserLoader(db)  // New loader per request
        }
      })
    });

    // Use DataLoader in resolver
    const resolvers = {
      Post: {
        author: async (parent, args, context) => {
          // DataLoader batches these calls!
          return await context.loaders.user.load(parent.authorId);
        }
      }
    };

    // Now executes as:
    // SELECT * FROM posts;                           -- 1 query
    // SELECT * FROM users WHERE id IN (1, 2, 3, ...); -- 1 batched query
    ```

    ### DataLoader for Multiple Relations

    ```javascript
    // Create loaders for different entities
    const createLoaders = (db) => ({
      user: new DataLoader(async (ids) => {
        const users = await db.users.whereIn('id', ids);
        const userMap = new Map(users.map(u => [u.id, u]));
        return ids.map(id => userMap.get(id));
      }),

      post: new DataLoader(async (ids) => {
        const posts = await db.posts.whereIn('id', ids);
        const postMap = new Map(posts.map(p => [p.id, p]));
        return ids.map(id => postMap.get(id));
      }),

      // Batch load posts by author
      postsByAuthor: new DataLoader(async (authorIds) => {
        const posts = await db.posts.whereIn('authorId', authorIds);

        // Group by authorId
        const postsByAuthor = new Map();
        authorIds.forEach(id => postsByAuthor.set(id, []));
        posts.forEach(post => {
          postsByAuthor.get(post.authorId).push(post);
        });

        return authorIds.map(id => postsByAuthor.get(id));
      }),

      // Batch load comments by post
      commentsByPost: new DataLoader(async (postIds) => {
        const comments = await db.comments.whereIn('postId', postIds);

        const commentsByPost = new Map();
        postIds.forEach(id => commentsByPost.set(id, []));
        comments.forEach(comment => {
          commentsByPost.get(comment.postId).push(comment);
        });

        return postIds.map(id => commentsByPost.get(id));
      })
    });

    // Use in resolvers
    const resolvers = {
      User: {
        posts: async (parent, args, context) => {
          return await context.loaders.postsByAuthor.load(parent.id);
        }
      },

      Post: {
        author: async (parent, args, context) => {
          return await context.loaders.user.load(parent.authorId);
        },

        comments: async (parent, args, context) => {
          return await context.loaders.commentsByPost.load(parent.id);
        }
      },

      Comment: {
        author: async (parent, args, context) => {
          return await context.loaders.user.load(parent.authorId);
        },

        post: async (parent, args, context) => {
          return await context.loaders.post.load(parent.postId);
        }
      }
    };
    ```

    ## Authentication and Authorization

    ### Authentication (Who are you?)

    ```javascript
    const jwt = require('jsonwebtoken');
    const bcrypt = require('bcrypt');

    const resolvers = {
      Mutation: {
        // Register
        register: async (parent, args, context) => {
          const { input } = args;
          const { email, password, name } = input;

          // Check if user exists
          const existing = await context.db.users.findOne({ email });
          if (existing) {
            throw new Error('User already exists');
          }

          // Hash password
          const hashedPassword = await bcrypt.hash(password, 10);

          // Create user
          const user = await context.db.users.create({
            email,
            name,
            password: hashedPassword,
            role: 'USER'
          });

          // Generate JWT token
          const token = jwt.sign(
            { userId: user.id, email: user.email },
            process.env.JWT_SECRET,
            { expiresIn: '7d' }
          );

          return {
            token,
            user
          };
        },

        // Login
        login: async (parent, args, context) => {
          const { email, password } = args;

          // Find user
          const user = await context.db.users.findOne({ email });
          if (!user) {
            throw new Error('Invalid credentials');
          }

          // Verify password
          const valid = await bcrypt.compare(password, user.password);
          if (!valid) {
            throw new Error('Invalid credentials');
          }

          // Generate token
          const token = jwt.sign(
            { userId: user.id, email: user.email },
            process.env.JWT_SECRET,
            { expiresIn: '7d' }
          );

          return {
            token,
            user
          };
        }
      }
    };

    // Context with authentication
    const server = new ApolloServer({
      typeDefs,
      resolvers,
      context: async ({ req }) => {
        const token = req.headers.authorization?.replace('Bearer ', '');

        let user = null;
        if (token) {
          try {
            const decoded = jwt.verify(token, process.env.JWT_SECRET);
            user = await db.users.findById(decoded.userId);
          } catch (err) {
            // Invalid token - user remains null
          }
        }

        return {
          db,
          user,
          loaders: createLoaders(db)
        };
      }
    });
    ```

    ### Authorization (What can you do?)

    **Method 1: In resolvers**

    ```javascript
    const resolvers = {
      Query: {
        me: (parent, args, context) => {
          if (!context.user) {
            throw new Error('Not authenticated');
          }
          return context.user;
        }
      },

      Mutation: {
        updatePost: async (parent, args, context) => {
          const { id, input } = args;

          // Check authentication
          if (!context.user) {
            throw new Error('Not authenticated');
          }

          // Check authorization
          const post = await context.db.posts.findById(id);
          if (!post) {
            throw new Error('Post not found');
          }

          if (post.authorId !== context.user.id && context.user.role !== 'ADMIN') {
            throw new Error('Not authorized to update this post');
          }

          return await context.db.posts.update(id, input);
        },

        deleteUser: async (parent, args, context) => {
          // Only admins can delete users
          if (!context.user || context.user.role !== 'ADMIN') {
            throw new Error('Not authorized');
          }

          const { id } = args;
          await context.db.users.delete(id);
          return true;
        }
      }
    };
    ```

    **Method 2: Directive-based (cleaner)**

    ```graphql
    directive @auth on FIELD_DEFINITION
    directive @hasRole(role: Role!) on FIELD_DEFINITION

    type Query {
      me: User @auth
      adminDashboard: AdminData @hasRole(role: ADMIN)
    }

    type Mutation {
      updatePost(id: ID!, input: UpdatePostInput!): Post! @auth
      deleteUser(id: ID!): Boolean! @hasRole(role: ADMIN)
    }
    ```

    ```javascript
    const { SchemaDirectiveVisitor } = require('apollo-server');
    const { defaultFieldResolver } = require('graphql');

    class AuthDirective extends SchemaDirectiveVisitor {
      visitFieldDefinition(field) {
        const { resolve = defaultFieldResolver } = field;

        field.resolve = async function (...args) {
          const context = args[2];

          if (!context.user) {
            throw new Error('Not authenticated');
          }

          return resolve.apply(this, args);
        };
      }
    }

    class HasRoleDirective extends SchemaDirectiveVisitor {
      visitFieldDefinition(field) {
        const { resolve = defaultFieldResolver } = field;
        const { role } = this.args;

        field.resolve = async function (...args) {
          const context = args[2];

          if (!context.user) {
            throw new Error('Not authenticated');
          }

          if (context.user.role !== role) {
            throw new Error(\`Requires \${role} role\`);
          }

          return resolve.apply(this, args);
        };
      }
    }

    const server = new ApolloServer({
      typeDefs,
      resolvers,
      schemaDirectives: {
        auth: AuthDirective,
        hasRole: HasRoleDirective
      }
    });
    ```

    ## Error Handling

    ### Custom Error Classes

    ```javascript
    class AuthenticationError extends Error {
      constructor(message) {
        super(message);
        this.extensions = {
          code: 'UNAUTHENTICATED'
        };
      }
    }

    class ForbiddenError extends Error {
      constructor(message) {
        super(message);
        this.extensions = {
          code: 'FORBIDDEN'
        };
      }
    }

    class ValidationError extends Error {
      constructor(message, field) {
        super(message);
        this.extensions = {
          code: 'BAD_USER_INPUT',
          field
        };
      }
    }

    // Use in resolvers
    const resolvers = {
      Mutation: {
        createPost: async (parent, args, context) => {
          if (!context.user) {
            throw new AuthenticationError('You must be logged in');
          }

          const { input } = args;

          if (!input.title || input.title.length < 3) {
            throw new ValidationError(
              'Title must be at least 3 characters',
              'title'
            );
          }

          return await context.db.posts.create({
            ...input,
            authorId: context.user.id
          });
        }
      }
    };
    ```

    ### Error Response

    ```json
    {
      "errors": [
        {
          "message": "Title must be at least 3 characters",
          "extensions": {
            "code": "BAD_USER_INPUT",
            "field": "title"
          },
          "path": ["createPost"]
        }
      ],
      "data": {
        "createPost": null
      }
    }
    ```

    ## File Uploads

    ```graphql
    scalar Upload

    type Mutation {
      uploadAvatar(file: Upload!): User!
      uploadPostImage(postId: ID!, file: Upload!): String!
    }
    ```

    ```javascript
    const { createWriteStream } = require('fs');
    const path = require('path');
    const { v4: uuid } = require('uuid');

    const resolvers = {
      Mutation: {
        uploadAvatar: async (parent, args, context) => {
          if (!context.user) {
            throw new AuthenticationError('Not authenticated');
          }

          const { file } = args;
          const { createReadStream, filename, mimetype } = await file;

          // Validate file type
          if (!mimetype.startsWith('image/')) {
            throw new ValidationError('File must be an image');
          }

          // Generate unique filename
          const uniqueFilename = \`\${uuid()}\${path.extname(filename)}\`;
          const filepath = path.join(__dirname, 'uploads', uniqueFilename);

          // Save file
          await new Promise((resolve, reject) => {
            createReadStream()
              .pipe(createWriteStream(filepath))
              .on('finish', resolve)
              .on('error', reject);
          });

          // Update user avatar
          const avatarUrl = \`/uploads/\${uniqueFilename}\`;
          const user = await context.db.users.update(context.user.id, {
            avatar: avatarUrl
          });

          return user;
        }
      }
    };
    ```

    ## Subscriptions for Real-Time Data

    **WebSocket-based real-time updates**

    ```graphql
    type Subscription {
      postCreated: Post!
      commentAdded(postId: ID!): Comment!
      messageReceived(chatId: ID!): Message!
      userTyping(chatId: ID!): User!
    }
    ```

    ### Server Setup

    ```javascript
    const { ApolloServer } = require('apollo-server-express');
    const { PubSub } = require('graphql-subscriptions');
    const { createServer } = require('http');
    const express = require('express');

    const pubsub = new PubSub();

    const resolvers = {
      Subscription: {
        postCreated: {
          subscribe: () => pubsub.asyncIterator(['POST_CREATED'])
        },

        commentAdded: {
          subscribe: (parent, args) => {
            const { postId } = args;
            return pubsub.asyncIterator([\`COMMENT_ADDED_\${postId}\`]);
          }
        }
      },

      Mutation: {
        createPost: async (parent, args, context) => {
          const { input } = args;

          const post = await context.db.posts.create({
            ...input,
            authorId: context.user.id
          });

          // Publish to subscribers
          pubsub.publish('POST_CREATED', {
            postCreated: post
          });

          return post;
        },

        addComment: async (parent, args, context) => {
          const { postId, text } = args;

          const comment = await context.db.comments.create({
            postId,
            text,
            authorId: context.user.id
          });

          // Publish to subscribers of this specific post
          pubsub.publish(\`COMMENT_ADDED_\${postId}\`, {
            commentAdded: comment
          });

          return comment;
        }
      }
    };

    // Express app
    const app = express();
    const httpServer = createServer(app);

    const server = new ApolloServer({
      typeDefs,
      resolvers,
      context: ({ req, connection }) => {
        // HTTP context
        if (req) {
          return { db, user: req.user, pubsub };
        }
        // WebSocket context
        if (connection) {
          return { db, user: connection.context.user, pubsub };
        }
      },
      subscriptions: {
        onConnect: async (connectionParams) => {
          // Authenticate WebSocket connection
          if (connectionParams.authToken) {
            const user = await validateToken(connectionParams.authToken);
            return { user };
          }
          throw new Error('Missing auth token');
        }
      }
    });

    server.applyMiddleware({ app });
    server.installSubscriptionHandlers(httpServer);

    httpServer.listen(4000, () => {
      console.log(\`Server ready at http://localhost:4000\${server.graphqlPath}\`);
      console.log(\`Subscriptions ready at ws://localhost:4000\${server.subscriptionsPath}\`);
    });
    ```

    ### Client Usage

    ```javascript
    import { ApolloClient, InMemoryCache, split } from '@apollo/client';
    import { WebSocketLink } from '@apollo/client/link/ws';
    import { getMainDefinition } from '@apollo/client/utilities';
    import { HttpLink } from '@apollo/client';

    // HTTP link for queries and mutations
    const httpLink = new HttpLink({
      uri: 'http://localhost:4000/graphql',
      headers: {
        authorization: \`Bearer \${token}\`
      }
    });

    // WebSocket link for subscriptions
    const wsLink = new WebSocketLink({
      uri: 'ws://localhost:4000/graphql',
      options: {
        reconnect: true,
        connectionParams: {
          authToken: token
        }
      }
    });

    // Split based on operation type
    const link = split(
      ({ query }) => {
        const definition = getMainDefinition(query);
        return (
          definition.kind === 'OperationDefinition' &&
          definition.operation === 'subscription'
        );
      },
      wsLink,
      httpLink
    );

    const client = new ApolloClient({
      link,
      cache: new InMemoryCache()
    });

    // Subscribe to new comments
    const subscription = gql\`
      subscription OnCommentAdded($postId: ID!) {
        commentAdded(postId: $postId) {
          id
          text
          author {
            name
            avatar
          }
          createdAt
        }
      }
    \`;

    client.subscribe({
      query: subscription,
      variables: { postId: '123' }
    }).subscribe({
      next: ({ data }) => {
        console.log('New comment:', data.commentAdded);
        // Update UI with new comment
      },
      error: (err) => console.error('Subscription error:', err)
    });
    ```

    **Next**: We'll explore production GraphQL with Apollo Server, TypeScript, caching, and performance optimization.
  MARKDOWN
  lesson.key_concepts = ['pagination', 'cursors', 'DataLoader', 'N+1 problem', 'authentication', 'authorization', 'subscriptions', 'file uploads']
end

ModuleItem.find_or_create_by!(course_module: module2, item: lesson2_1) do |item|
  item.sequence_order = 1
  item.required = true
end

quiz2 = Quiz.find_or_create_by!(title: "Advanced GraphQL Quiz") do |quiz|
  quiz.description = 'Test your understanding of advanced GraphQL patterns'
  quiz.time_limit_minutes = 20
  quiz.passing_score = 70
  quiz.max_attempts = 3
end

[
  {
    question_text: "What problem does DataLoader solve in GraphQL?",
    question_type: "mcq",
    points: 15,
    options: JSON.generate([
      { text: "The N+1 query problem by batching and caching database requests", correct: true },
      { text: "Authentication issues", correct: false },
      { text: "Schema validation errors", correct: false },
      { text: "Subscription performance", correct: false }
    ]),
    explanation: "DataLoader solves the N+1 query problem by batching multiple database requests into a single query and caching results within a single request.",
    difficulty_level: "medium"
  },
  {
    question_text: "Which pagination approach is recommended for GraphQL APIs?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "Cursor-based pagination (Relay specification)", correct: true },
      { text: "Offset-based pagination", correct: false },
      { text: "Page number pagination", correct: false },
      { text: "Random access pagination", correct: false }
    ]),
    explanation: "Cursor-based pagination (Relay specification) is the industry standard for GraphQL as it handles data changes between pages and provides better performance.",
    difficulty_level: "medium"
  },
  {
    question_text: "True or False: GraphQL subscriptions use WebSockets for real-time communication.",
    question_type: "true_false",
    points: 5,
    correct_answer: "true",
    explanation: "GraphQL subscriptions use WebSocket connections to enable real-time, bidirectional communication between client and server.",
    difficulty_level: "easy"
  },
  {
    question_text: "What is the difference between authentication and authorization?",
    question_type: "mcq",
    points: 15,
    options: JSON.generate([
      { text: "Authentication verifies who you are, authorization determines what you can do", correct: true },
      { text: "They are the same thing", correct: false },
      { text: "Authorization verifies who you are, authentication determines what you can do", correct: false },
      { text: "Authentication is for queries, authorization is for mutations", correct: false }
    ]),
    explanation: "Authentication verifies the identity of a user (who you are), while authorization determines what actions they are permitted to perform (what you can do).",
    difficulty_level: "medium"
  },
  {
    question_text: "In cursor-based pagination, what does the PageInfo type provide?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "Information about next/previous pages and cursors", correct: true },
      { text: "The total number of pages", correct: false },
      { text: "The current page number", correct: false },
      { text: "User authentication status", correct: false }
    ]),
    explanation: "PageInfo provides metadata about pagination including hasNextPage, hasPreviousPage, startCursor, and endCursor to navigate through results.",
    difficulty_level: "medium"
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz2, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer] if q_data[:correct_answer]
    question.explanation = q_data[:explanation]
    question.difficulty_level = q_data[:difficulty_level]
  end
end

ModuleItem.find_or_create_by!(course_module: module2, item: quiz2) do |item|
  item.sequence_order = 2
  item.required = true
end

puts "  ✅ Created module: #{module2.title}"

# ==========================================
# MODULE 3: GraphQL in Production
# ==========================================

module3 = CourseModule.find_or_create_by!(slug: 'graphql-production', course: graphql_course) do |mod|
  mod.title = 'GraphQL in Production'
  mod.description = 'Apollo Server, TypeScript, caching, performance, monitoring'
  mod.sequence_order = 3
  mod.estimated_minutes = 120
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Set up production Apollo Server",
    "Implement GraphQL with TypeScript",
    "Apply caching strategies",
    "Implement rate limiting and query complexity",
    "Monitor GraphQL performance"
  ])
end

lesson3_1 = CourseLesson.find_or_create_by!(title: "Production GraphQL") do |lesson|
  lesson.reading_time_minutes = 30
  lesson.content = <<~MARKDOWN
    # Production GraphQL

    ## Apollo Server Setup

    Apollo Server is the industry-standard GraphQL server for Node.js.

    ### Basic Production Setup

    ```javascript
    const { ApolloServer } = require('apollo-server-express');
    const express = require('express');
    const helmet = require('helmet');
    const cors = require('cors');
    const compression = require('compression');
    const { createServer } = require('http');

    const app = express();

    // Security middleware
    app.use(helmet({
      contentSecurityPolicy: false,
      crossOriginEmbedderPolicy: false
    }));

    // CORS
    app.use(cors({
      origin: process.env.ALLOWED_ORIGINS?.split(',') || '*',
      credentials: true
    }));

    // Compression
    app.use(compression());

    // Health check endpoint
    app.get('/health', (req, res) => {
      res.json({ status: 'healthy', timestamp: new Date().toISOString() });
    });

    // Create Apollo Server
    const server = new ApolloServer({
      typeDefs,
      resolvers,
      context: async ({ req }) => ({
        db,
        user: req.user,
        loaders: createLoaders(db)
      }),

      // Production settings
      introspection: process.env.NODE_ENV !== 'production',
      playground: process.env.NODE_ENV !== 'production',

      // Error handling
      formatError: (error) => {
        // Log error
        console.error('GraphQL Error:', error);

        // Don't expose internal errors in production
        if (process.env.NODE_ENV === 'production') {
          // Remove stack traces
          delete error.extensions?.exception;
        }

        return error;
      },

      // Performance monitoring
      plugins: [
        {
          requestDidStart() {
            const start = Date.now();
            return {
              willSendResponse({ response }) {
                const duration = Date.now() - start;
                console.log(\`Query took \${duration}ms\`);
              }
            };
          }
        }
      ]
    });

    server.applyMiddleware({ app, path: '/graphql' });

    const httpServer = createServer(app);
    server.installSubscriptionHandlers(httpServer);

    const PORT = process.env.PORT || 4000;
    httpServer.listen(PORT, () => {
      console.log(\`🚀 Server ready at http://localhost:\${PORT}\${server.graphqlPath}\`);
      console.log(\`🔌 Subscriptions ready at ws://localhost:\${PORT}\${server.subscriptionsPath}\`);
    });
    ```

    ## GraphQL with TypeScript

    ### Type-Safe Schema

    ```typescript
    // types.ts
    export interface User {
      id: string;
      name: string;
      email: string;
      role: Role;
      createdAt: Date;
      updatedAt: Date;
    }

    export interface Post {
      id: string;
      title: string;
      content: string;
      authorId: string;
      published: boolean;
      createdAt: Date;
      updatedAt: Date;
    }

    export enum Role {
      ADMIN = 'ADMIN',
      USER = 'USER',
      MODERATOR = 'MODERATOR'
    }

    export interface Context {
      db: Database;
      user: User | null;
      loaders: {
        user: DataLoader<string, User>;
        post: DataLoader<string, Post>;
      };
    }

    export interface CreatePostInput {
      title: string;
      content: string;
      tags?: string[];
      published?: boolean;
    }
    ```

    ### Type-Safe Resolvers

    ```typescript
    import { IResolvers } from '@graphql-tools/utils';
    import { Context, User, Post, CreatePostInput } from './types';

    export const resolvers: IResolvers<any, Context> = {
      Query: {
        me: (parent, args, context): User | null => {
          return context.user;
        },

        user: async (
          parent,
          args: { id: string },
          context
        ): Promise<User | null> => {
          return await context.loaders.user.load(args.id);
        },

        posts: async (
          parent,
          args: { limit?: number; offset?: number },
          context
        ): Promise<Post[]> => {
          const limit = args.limit || 10;
          const offset = args.offset || 0;

          return await context.db.posts
            .limit(limit)
            .offset(offset)
            .orderBy('createdAt', 'desc');
        }
      },

      Mutation: {
        createPost: async (
          parent,
          args: { input: CreatePostInput },
          context
        ): Promise<Post> => {
          if (!context.user) {
            throw new Error('Not authenticated');
          }

          const { input } = args;
          const post = await context.db.posts.create({
            ...input,
            authorId: context.user.id,
            published: input.published ?? false
          });

          return post;
        }
      },

      // Field resolvers with types
      User: {
        posts: async (parent: User, args, context): Promise<Post[]> => {
          return await context.db.posts.where({ authorId: parent.id });
        }
      },

      Post: {
        author: async (parent: Post, args, context): Promise<User> => {
          return await context.loaders.user.load(parent.authorId);
        }
      }
    };
    ```

    ### Code Generation

    **Use GraphQL Code Generator for automatic type generation**

    ```bash
    npm install -D @graphql-codegen/cli @graphql-codegen/typescript @graphql-codegen/typescript-resolvers
    ```

    ```yaml
    # codegen.yml
    schema: "./schema.graphql"
    generates:
      ./src/generated/graphql.ts:
        plugins:
          - typescript
          - typescript-resolvers
        config:
          contextType: "../types#Context"
          mappers:
            User: "../types#User"
            Post: "../types#Post"
    ```

    ```bash
    # Generate types
    npx graphql-codegen
    ```

    ## Caching Strategies

    ### Response Caching

    ```javascript
    const { ApolloServer } = require('apollo-server-express');
    const responseCachePlugin = require('apollo-server-plugin-response-cache');
    const { RedisCache } = require('apollo-server-cache-redis');

    const server = new ApolloServer({
      typeDefs,
      resolvers,
      cache: new RedisCache({
        host: process.env.REDIS_HOST,
        port: process.env.REDIS_PORT
      }),
      plugins: [
        responseCachePlugin({
          // Cache by session ID
          sessionId: (requestContext) => {
            return requestContext.request.http?.headers.get('session-id') || null;
          }
        })
      ]
    });
    ```

    **Add cache hints to schema:**

    ```graphql
    type Query {
      # Cache for 60 seconds
      posts: [Post!]! @cacheControl(maxAge: 60)

      # Cache for 300 seconds, public
      publicPosts: [Post!]! @cacheControl(maxAge: 300, scope: PUBLIC)

      # Don't cache
      me: User @cacheControl(maxAge: 0)
    }

    type Post @cacheControl(maxAge: 60) {
      id: ID!
      title: String!
      # Override parent cache
      viewCount: Int! @cacheControl(maxAge: 10)
    }
    ```

    ### Persisted Queries

    **Reduce bandwidth and improve security**

    ```javascript
    const { ApolloServer } = require('apollo-server-express');
    const { createPersistedQueryLink } = require('@apollo/client/link/persisted-queries');

    const server = new ApolloServer({
      typeDefs,
      resolvers,
      persistedQueries: {
        cache: new RedisCache({
          host: process.env.REDIS_HOST
        })
      }
    });

    // Client setup
    import { createPersistedQueryLink } from '@apollo/client/link/persisted-queries';
    import { sha256 } from 'crypto-hash';

    const link = createPersistedQueryLink({ sha256 }).concat(httpLink);

    const client = new ApolloClient({
      link,
      cache: new InMemoryCache()
    });

    // First request: sends full query + hash
    // Subsequent requests: sends only hash (smaller payload)
    ```

    ## Query Complexity and Rate Limiting

    ### Query Complexity

    **Prevent expensive queries**

    ```javascript
    const { createComplexityLimitRule } = require('graphql-validation-complexity');

    const server = new ApolloServer({
      typeDefs,
      resolvers,
      validationRules: [
        createComplexityLimitRule(1000, {
          onCost: (cost) => {
            console.log('Query cost:', cost);
          },
          formatErrorMessage: (cost) => {
            return \`Query too complex: \${cost}. Maximum allowed: 1000\`;
          }
        })
      ]
    });
    ```

    **Assign costs to fields:**

    ```graphql
    type Query {
      user(id: ID!): User       # Cost: 1
      users: [User!]!           # Cost: 10 (returns multiple)
    }

    type User {
      id: ID!                   # Cost: 0
      name: String!             # Cost: 0
      posts: [Post!]!           # Cost: 10 (N+1 potential)
      followers: [User!]!       # Cost: 10
    }

    # This query would have high cost:
    query {
      users {                   # 10
        posts {                 # 10 × users
          author {              # 1 × posts × users
            followers {         # 10 × posts × users
              posts {           # 10 × followers × posts × users
                title
              }
            }
          }
        }
      }
    }
    ```

    ### Rate Limiting

    ```javascript
    const { RateLimiterRedis } = require('rate-limiter-flexible');
    const Redis = require('ioredis');

    const redisClient = new Redis({
      host: process.env.REDIS_HOST,
      port: process.env.REDIS_PORT
    });

    const rateLimiter = new RateLimiterRedis({
      storeClient: redisClient,
      points: 100,        // Number of requests
      duration: 60,       // Per 60 seconds
      blockDuration: 60   // Block for 60 seconds if exceeded
    });

    const server = new ApolloServer({
      typeDefs,
      resolvers,
      context: async ({ req }) => {
        const ip = req.ip || req.connection.remoteAddress;

        try {
          await rateLimiter.consume(ip);
        } catch (error) {
          throw new Error('Too many requests. Please try again later.');
        }

        return { db, user: req.user };
      }
    });
    ```

    ### Field-Level Rate Limiting

    ```javascript
    const { shield, rule } = require('graphql-shield');

    const isAuthenticated = rule({ cache: 'contextual' })(
      async (parent, args, context) => {
        return context.user !== null;
      }
    );

    const rateLimit = rule({ cache: 'contextual' })(
      async (parent, args, context) => {
        const key = \`rate_limit:\${context.user?.id || context.ip}\`;

        try {
          await rateLimiter.consume(key);
          return true;
        } catch {
          return new Error('Rate limit exceeded');
        }
      }
    );

    const permissions = shield({
      Query: {
        me: isAuthenticated,
        searchPosts: rateLimit  // Rate limit search
      },
      Mutation: {
        createPost: isAuthenticated,
        uploadAvatar: rateLimit  // Rate limit uploads
      }
    });

    const server = new ApolloServer({
      typeDefs,
      resolvers,
      middlewares: [permissions]
    });
    ```

    ## Schema Stitching and Federation

    ### Schema Stitching (Legacy)

    **Combine multiple GraphQL schemas**

    ```javascript
    const { stitchSchemas } = require('@graphql-tools/stitch');

    // User service
    const userSchema = makeExecutableSchema({
      typeDefs: `
        type User {
          id: ID!
          name: String!
        }
        type Query {
          user(id: ID!): User
        }
      `,
      resolvers: userResolvers
    });

    // Post service
    const postSchema = makeExecutableSchema({
      typeDefs: `
        type Post {
          id: ID!
          title: String!
          authorId: ID!
        }
        type Query {
          post(id: ID!): Post
        }
      `,
      resolvers: postResolvers
    });

    // Stitch schemas together
    const stitchedSchema = stitchSchemas({
      subschemas: [
        { schema: userSchema },
        { schema: postSchema }
      ]
    });
    ```

    ### Apollo Federation (Modern)

    **Microservices architecture for GraphQL**

    ```javascript
    // User service (subgraph)
    const { ApolloServer, gql } = require('apollo-server');
    const { buildFederatedSchema } = require('@apollo/federation');

    const typeDefs = gql\`
      type User @key(fields: "id") {
        id: ID!
        name: String!
        email: String!
      }

      extend type Post @key(fields: "id") {
        id: ID! @external
        author: User
      }

      type Query {
        user(id: ID!): User
      }
    \`;

    const resolvers = {
      User: {
        __resolveReference(user) {
          return getUserById(user.id);
        }
      },
      Post: {
        author(post) {
          return { __typename: 'User', id: post.authorId };
        }
      }
    };

    const server = new ApolloServer({
      schema: buildFederatedSchema([{ typeDefs, resolvers }])
    });

    // Post service (subgraph)
    const typeDefs = gql\`
      type Post @key(fields: "id") {
        id: ID!
        title: String!
        content: String!
        authorId: ID!
      }

      type Query {
        post(id: ID!): Post
        posts: [Post!]!
      }
    \`;

    // Gateway (combines subgraphs)
    const { ApolloGateway } = require('@apollo/gateway');

    const gateway = new ApolloGateway({
      serviceList: [
        { name: 'users', url: 'http://localhost:4001/graphql' },
        { name: 'posts', url: 'http://localhost:4002/graphql' }
      ]
    });

    const server = new ApolloServer({ gateway });
    ```

    ## Monitoring and Performance

    ### Apollo Studio

    ```javascript
    const { ApolloServer } = require('apollo-server');

    const server = new ApolloServer({
      typeDefs,
      resolvers,
      plugins: [
        require('apollo-server-core').ApolloServerPluginUsageReporting({
          sendVariableValues: { all: true },
          sendHeaders: { all: true }
        })
      ]
    });

    // Set APOLLO_KEY environment variable
    // Metrics sent to Apollo Studio automatically
    ```

    ### Custom Metrics

    ```javascript
    const prometheus = require('prom-client');

    // Define metrics
    const queryDuration = new prometheus.Histogram({
      name: 'graphql_query_duration_ms',
      help: 'GraphQL query duration in milliseconds',
      labelNames: ['operation_name']
    });

    const queryErrors = new prometheus.Counter({
      name: 'graphql_query_errors_total',
      help: 'Total GraphQL query errors',
      labelNames: ['operation_name', 'error_type']
    });

    const server = new ApolloServer({
      typeDefs,
      resolvers,
      plugins: [
        {
          requestDidStart(requestContext) {
            const start = Date.now();
            const operationName = requestContext.request.operationName;

            return {
              willSendResponse() {
                const duration = Date.now() - start;
                queryDuration.observe({ operation_name: operationName }, duration);
              },

              didEncounterErrors(requestContext) {
                const { errors } = requestContext;
                errors.forEach(error => {
                  queryErrors.inc({
                    operation_name: operationName,
                    error_type: error.extensions?.code || 'UNKNOWN'
                  });
                });
              }
            };
          }
        }
      ]
    });

    // Prometheus metrics endpoint
    app.get('/metrics', async (req, res) => {
      res.set('Content-Type', prometheus.register.contentType);
      res.end(await prometheus.register.metrics());
    });
    ```

    ### Query Performance Logging

    ```javascript
    const server = new ApolloServer({
      typeDefs,
      resolvers,
      plugins: [
        {
          requestDidStart() {
            return {
              executionDidStart() {
                return {
                  willResolveField({ info }) {
                    const start = Date.now();
                    return () => {
                      const duration = Date.now() - start;
                      if (duration > 100) {  // Log slow resolvers
                        console.warn(
                          \`Slow resolver: \${info.parentType}.\${info.fieldName} took \${duration}ms\`
                        );
                      }
                    };
                  }
                };
              }
            };
          }
        }
      ]
    });
    ```

    ## Production Best Practices

    ### 1. Security

    ```javascript
    // Disable introspection in production
    introspection: process.env.NODE_ENV !== 'production',

    // Depth limiting
    const depthLimit = require('graphql-depth-limit');
    validationRules: [depthLimit(5)],

    // Query whitelisting (persisted queries only)
    persistedQueries: {
      ttl: 900
    },

    // Disable playground in production
    playground: false,

    // CORS
    cors: {
      origin: process.env.ALLOWED_ORIGINS.split(','),
      credentials: true
    }
    ```

    ### 2. Performance

    ```javascript
    // DataLoader for all relations
    loaders: createLoaders(db),

    // Response caching
    cache: new RedisCache(),

    // Query complexity limits
    validationRules: [complexityLimit(1000)],

    // Connection pooling
    db: new Pool({
      max: 20,
      idleTimeoutMillis: 30000
    })
    ```

    ### 3. Error Handling

    ```javascript
    formatError: (error) => {
      // Log all errors
      logger.error('GraphQL Error:', {
        message: error.message,
        path: error.path,
        code: error.extensions?.code
      });

      // Don't expose internals in production
      if (process.env.NODE_ENV === 'production') {
        if (error.message.includes('database')) {
          return new Error('Internal server error');
        }
      }

      return error;
    }
    ```

    ### 4. Monitoring

    - **Apollo Studio** for query analytics
    - **Prometheus** for metrics
    - **DataDog/New Relic** for APM
    - **Sentry** for error tracking
    - **CloudWatch/Grafana** for infrastructure

    ### 5. Documentation

    ```graphql
    """
    Represents a user in the system
    """
    type User {
      """
      Unique user identifier
      """
      id: ID!

      """
      User's display name
      """
      name: String!

      """
      User's email address (private, only visible to user)
      """
      email: String!
    }

    type Query {
      """
      Get a user by ID
      @param id - The user's unique identifier
      @returns User object or null if not found
      """
      user(id: ID!): User
    }
    ```

    ## Complete Production Example

    ```javascript
    require('dotenv').config();
    const { ApolloServer } = require('apollo-server-express');
    const express = require('express');
    const helmet = require('helmet');
    const compression = require('compression');
    const { createServer } = require('http');
    const { RedisCache } = require('apollo-server-cache-redis');
    const depthLimit = require('graphql-depth-limit');
    const { createComplexityLimitRule } = require('graphql-validation-complexity');

    const app = express();

    // Middleware
    app.use(helmet());
    app.use(compression());
    app.use(express.json());

    // Health check
    app.get('/health', (req, res) => {
      res.json({ status: 'healthy' });
    });

    // Apollo Server
    const server = new ApolloServer({
      typeDefs,
      resolvers,
      cache: new RedisCache({
        host: process.env.REDIS_HOST,
        port: process.env.REDIS_PORT
      }),
      context: async ({ req }) => ({
        db,
        user: req.user,
        loaders: createLoaders(db)
      }),
      introspection: process.env.NODE_ENV !== 'production',
      playground: process.env.NODE_ENV !== 'production',
      validationRules: [
        depthLimit(5),
        createComplexityLimitRule(1000)
      ],
      formatError: (error) => {
        console.error(error);
        if (process.env.NODE_ENV === 'production') {
          delete error.extensions?.exception;
        }
        return error;
      }
    });

    server.applyMiddleware({ app });

    const httpServer = createServer(app);
    server.installSubscriptionHandlers(httpServer);

    const PORT = process.env.PORT || 4000;
    httpServer.listen(PORT, () => {
      console.log(\`🚀 Server ready at http://localhost:\${PORT}\${server.graphqlPath}\`);
    });
    ```

    **Congratulations!** You now have the knowledge to build production-ready GraphQL APIs with best practices for performance, security, and scalability.
  MARKDOWN
  lesson.key_concepts = ['Apollo Server', 'TypeScript', 'caching', 'rate limiting', 'query complexity', 'federation', 'monitoring', 'production']
end

ModuleItem.find_or_create_by!(course_module: module3, item: lesson3_1) do |item|
  item.sequence_order = 1
  item.required = true
end

quiz3 = Quiz.find_or_create_by!(title: "Production GraphQL Quiz") do |quiz|
  quiz.description = 'Test your understanding of production GraphQL practices'
  quiz.time_limit_minutes = 20
  quiz.passing_score = 70
  quiz.max_attempts = 3
end

[
  {
    question_text: "What is the purpose of query complexity limits in GraphQL?",
    question_type: "mcq",
    points: 15,
    options: JSON.generate([
      { text: "Prevent expensive queries from overloading the server", correct: true },
      { text: "Make queries faster", correct: false },
      { text: "Improve security", correct: false },
      { text: "Enable caching", correct: false }
    ]),
    explanation: "Query complexity limits prevent clients from executing overly expensive queries that could overload the server by assigning costs to fields and limiting total query cost.",
    difficulty_level: "medium"
  },
  {
    question_text: "Which Apollo feature is recommended for microservices architecture?",
    question_type: "mcq",
    points: 15,
    options: JSON.generate([
      { text: "Apollo Federation", correct: true },
      { text: "Schema stitching", correct: false },
      { text: "DataLoader", correct: false },
      { text: "Subscriptions", correct: false }
    ]),
    explanation: "Apollo Federation is the modern approach for building microservices architecture with GraphQL, allowing multiple subgraphs to be composed into a single graph.",
    difficulty_level: "hard"
  },
  {
    question_text: "True or False: Introspection should be disabled in production for security.",
    question_type: "true_false",
    points: 10,
    correct_answer: "true",
    explanation: "Introspection should be disabled in production to prevent attackers from discovering your entire schema structure, which could reveal sensitive information about your API.",
    difficulty_level: "medium"
  },
  {
    question_text: "What does persisted queries help with in GraphQL?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "Reduces bandwidth by sending only query hash instead of full query", correct: true },
      { text: "Speeds up database queries", correct: false },
      { text: "Enables subscriptions", correct: false },
      { text: "Improves authentication", correct: false }
    ]),
    explanation: "Persisted queries allow clients to send a hash of the query instead of the full query string, reducing bandwidth and improving security by allowing only pre-approved queries.",
    difficulty_level: "medium"
  },
  {
    question_text: "Which caching strategy should be used for GraphQL field results?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "Response caching with cache control directives", correct: true },
      { text: "Database query caching only", correct: false },
      { text: "Browser caching only", correct: false },
      { text: "No caching needed", correct: false }
    ]),
    explanation: "GraphQL response caching with @cacheControl directives allows fine-grained control over caching at the field level, enabling efficient caching strategies.",
    difficulty_level: "medium"
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz3, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer] if q_data[:correct_answer]
    question.explanation = q_data[:explanation]
    question.difficulty_level = q_data[:difficulty_level]
  end
end

ModuleItem.find_or_create_by!(course_module: module3, item: quiz3) do |item|
  item.sequence_order = 2
  item.required = true
end

puts "  ✅ Created module: #{module3.title}"

puts "\n✅ GraphQL API Development Course Created!"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
puts "📚 Course: #{graphql_course.title}"
puts "📖 Modules: #{graphql_course.course_modules.count}"
puts "📝 Comprehensive content with Apollo Server, TypeScript, and production patterns"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
