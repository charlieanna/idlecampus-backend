class CourseGeneratorService
  def initialize(tag_name, site_name = 'stackoverflow')
    @tag_name = tag_name
    @site_name = site_name
    @site_ports = {
      'stackoverflow' => '5006',
      'softwareengineering' => '5007',
      'cs' => '5004'
    }
  end

  def generate_course
    # Fetch posts for the tag
    posts = fetch_tag_posts

    # Categorize posts by difficulty and topic
    categorized = categorize_posts(posts)

    # Build learning modules
    modules = build_learning_modules(categorized)

    # Create prerequisite graph
    prerequisite_graph = build_prerequisite_graph(modules)

    # Generate final course structure
    {
      title: "Learn #{@tag_name.capitalize} - A Stack Exchange Curriculum",
      description: "Master #{@tag_name} through real Q&As from the community",
      total_questions: posts.length,
      estimated_hours: estimate_learning_time(modules),
      modules: modules,
      prerequisite_graph: prerequisite_graph,
      learning_path: generate_learning_path(modules, prerequisite_graph)
    }
  end

  private

  def fetch_tag_posts
    port = @site_ports[@site_name]
    url = URI.parse("http://localhost:#{port}/posts/#{@tag_name}?sort_by=score&limit=200")

    http = Net::HTTP.new(url.host, url.port)
    http.read_timeout = 30
    http.open_timeout = 10

    request = Net::HTTP::Get.new(url.request_uri, { 'Accept' => 'application/json' })
    response = http.request(request)

    posts = JSON.parse(response.body)['posts'] || []

    # Enrich posts with additional metadata
    posts.map do |post|
      post['difficulty_score'] = calculate_difficulty(post)
      post['importance_score'] = calculate_importance(post)
      post['concepts'] = extract_concepts(post)
      post
    end
  rescue => e
    Rails.logger.error "Error fetching posts: #{e.message}"
    []
  end

  def calculate_difficulty(post)
    # Higher difficulty for posts with:
    # - More inlinks (complex topics referenced by many)
    # - Lower acceptance rate
    # - More complex code samples

    in_degree = post['in_degree'] || 0
    score = post['score'] || 0
    answer_count = post['answer_count'] || 0

    # Normalize difficulty to 1-5 scale
    difficulty = 1

    difficulty += 1 if in_degree > 10
    difficulty += 1 if in_degree > 50
    difficulty += 1 if answer_count > 5  # Many answers suggest complexity
    difficulty += 1 if post['title']&.downcase&.include?('advanced')

    [difficulty, 5].min
  end

  def calculate_importance(post)
    # Important posts have high scores and many references
    score = post['score'] || 0
    in_degree = post['in_degree'] || 0
    out_degree = post['out_degree'] || 0
    views = post['view_count'] || 0

    # Weight different factors
    (score * 0.4 + in_degree * 0.3 + out_degree * 0.1 + (views / 1000) * 0.2).round
  end

  def extract_concepts(post)
    # Extract key concepts from title and tags
    concepts = []

    title = post['title']&.downcase || ''
    tags = post['tags'] || []

    # Common Go concepts to look for
    concept_keywords = {
      'basics' => ['hello world', 'install', 'setup', 'getting started', 'first program'],
      'variables' => ['variable', 'declaration', 'const', 'type', 'zero value'],
      'functions' => ['function', 'func', 'method', 'return', 'parameter'],
      'control_flow' => ['if', 'else', 'for', 'loop', 'switch', 'case'],
      'data_structures' => ['array', 'slice', 'map', 'struct', 'interface'],
      'pointers' => ['pointer', 'reference', 'dereference', '&', '*'],
      'concurrency' => ['goroutine', 'channel', 'select', 'sync', 'concurrent', 'parallel'],
      'error_handling' => ['error', 'panic', 'recover', 'defer'],
      'packages' => ['package', 'import', 'module', 'dependency'],
      'testing' => ['test', 'testing', 'benchmark', 'unit test'],
      'web' => ['http', 'server', 'api', 'rest', 'json'],
      'database' => ['database', 'sql', 'orm', 'query'],
      'advanced' => ['reflection', 'unsafe', 'cgo', 'assembly', 'optimization']
    }

    concept_keywords.each do |concept, keywords|
      if keywords.any? { |kw| title.include?(kw) || tags.include?(kw) }
        concepts << concept
      end
    end

    concepts.empty? ? ['general'] : concepts
  end

  def categorize_posts(posts)
    categories = {
      'beginner' => [],
      'intermediate' => [],
      'advanced' => []
    }

    posts.each do |post|
      case post['difficulty_score']
      when 1..2
        categories['beginner'] << post
      when 3..4
        categories['intermediate'] << post
      else
        categories['advanced'] << post
      end
    end

    # Sort each category by importance
    categories.each do |level, posts|
      categories[level] = posts.sort_by { |p| -p['importance_score'] }
    end

    categories
  end

  def build_learning_modules(categorized)
    modules = []

    # Module 1: Fundamentals
    beginner_posts = categorized['beginner']
    if beginner_posts.any?
      modules << {
        id: 'module_1',
        title: "#{@tag_name.capitalize} Fundamentals",
        description: "Core concepts and basic syntax",
        difficulty: 'beginner',
        estimated_hours: beginner_posts.length * 0.5,
        topics: group_by_concepts(beginner_posts.first(20)),
        total_questions: [beginner_posts.length, 20].min
      }
    end

    # Module 2: Core Concepts
    intermediate_basics = categorized['intermediate'].select do |p|
      (p['concepts'] & ['data_structures', 'functions', 'control_flow']).any?
    end
    if intermediate_basics.any?
      modules << {
        id: 'module_2',
        title: "Core #{@tag_name.capitalize} Concepts",
        description: "Data structures, functions, and program flow",
        difficulty: 'intermediate',
        estimated_hours: intermediate_basics.length * 0.75,
        topics: group_by_concepts(intermediate_basics.first(25)),
        total_questions: [intermediate_basics.length, 25].min,
        prerequisites: ['module_1']
      }
    end

    # Module 3: Concurrency (for Go specifically)
    if @tag_name.downcase == 'go' || @tag_name.downcase == 'golang'
      concurrency_posts = (categorized['intermediate'] + categorized['advanced']).select do |p|
        p['concepts'].include?('concurrency')
      end
      if concurrency_posts.any?
        modules << {
          id: 'module_3',
          title: "Concurrency in #{@tag_name.capitalize}",
          description: "Goroutines, channels, and concurrent patterns",
          difficulty: 'intermediate',
          estimated_hours: concurrency_posts.length * 1.0,
          topics: group_by_concepts(concurrency_posts.first(20)),
          total_questions: [concurrency_posts.length, 20].min,
          prerequisites: ['module_2']
        }
      end
    end

    # Module 4: Practical Applications
    practical_posts = (categorized['intermediate'] + categorized['advanced']).select do |p|
      (p['concepts'] & ['web', 'database', 'testing']).any?
    end
    if practical_posts.any?
      modules << {
        id: 'module_4',
        title: "Building Real Applications",
        description: "Web servers, databases, and testing",
        difficulty: 'intermediate-advanced',
        estimated_hours: practical_posts.length * 1.0,
        topics: group_by_concepts(practical_posts.first(25)),
        total_questions: [practical_posts.length, 25].min,
        prerequisites: ['module_2']
      }
    end

    # Module 5: Advanced Topics
    advanced_posts = categorized['advanced']
    if advanced_posts.any?
      modules << {
        id: 'module_5',
        title: "Advanced #{@tag_name.capitalize}",
        description: "Performance, optimization, and advanced patterns",
        difficulty: 'advanced',
        estimated_hours: advanced_posts.length * 1.5,
        topics: group_by_concepts(advanced_posts.first(20)),
        total_questions: [advanced_posts.length, 20].min,
        prerequisites: ['module_3', 'module_4'].compact
      }
    end

    modules
  end

  def group_by_concepts(posts)
    grouped = {}

    posts.each do |post|
      post['concepts'].each do |concept|
        grouped[concept] ||= []
        grouped[concept] << {
          id: post['id'],
          title: post['title'],
          url: "https://stackoverflow.com/q/#{post['id']}",
          score: post['score'],
          difficulty: post['difficulty_score'],
          importance: post['importance_score'],
          in_links: post['in_degree'],
          out_links: post['out_degree']
        }
      end
    end

    # Sort questions within each concept by importance
    grouped.each do |concept, questions|
      grouped[concept] = questions.sort_by { |q| -q[:importance] }.first(10)
    end

    grouped
  end

  def build_prerequisite_graph(modules)
    graph = {}

    modules.each do |mod|
      graph[mod[:id]] = {
        prerequisites: mod[:prerequisites] || [],
        leads_to: []
      }
    end

    # Build reverse relationships
    graph.each do |mod_id, data|
      data[:prerequisites].each do |prereq|
        graph[prereq][:leads_to] << mod_id if graph[prereq]
      end
    end

    graph
  end

  def generate_learning_path(modules, prerequisite_graph)
    # Generate an optimal learning path using topological sort
    path = []
    visited = Set.new
    temp_mark = Set.new

    def visit(mod_id, modules, graph, visited, temp_mark, path)
      return if visited.include?(mod_id)

      if temp_mark.include?(mod_id)
        # Cycle detected, skip
        return
      end

      temp_mark.add(mod_id)

      # Visit prerequisites first
      graph[mod_id][:prerequisites].each do |prereq|
        visit(prereq, modules, graph, visited, temp_mark, path)
      end

      temp_mark.delete(mod_id)
      visited.add(mod_id)

      module_data = modules.find { |m| m[:id] == mod_id }
      path << {
        module_id: mod_id,
        title: module_data[:title],
        estimated_hours: module_data[:estimated_hours]
      } if module_data
    end

    modules.each do |mod|
      visit(mod[:id], modules, prerequisite_graph, visited, temp_mark, path)
    end

    path
  end

  def estimate_learning_time(modules)
    modules.sum { |m| m[:estimated_hours] }.round(1)
  end
end