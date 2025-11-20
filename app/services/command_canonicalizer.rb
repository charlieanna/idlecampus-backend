\n# Service to canonicalize Docker and Kubernetes commands\n# Maps variations to standard canonical keys for consistent mastery tracking\nclass CommandCanonicalizer\n  # Docker command patterns and their canonical forms\n  DOCKER_PATTERNS = {\n    # Container operations\n    'docker_run' => [\n      /^docker\\s+run\\b/i,\n      /^docker\\s+container\\s+run\\b/i\n    ],\n    'docker_ps' => [\n      /^docker\\s+ps\\b/i,\n      /^docker\\s+container\\s+ls\\b/i,\n      /^docker\\s+container\\s+list\\b/i\n    ],\n    'docker_stop' => [\n      /^docker\\s+stop\\b/i,\n      /^docker\\s+container\\s+stop\\b/i\n    ],\n    'docker_rm' => [\n      /^docker\\s+rm\\b/i,\n      /^docker\\s+container\\s+rm\\b/i,\n      /^docker\\s+container\\s+remove\\b/i\n    ],\n    'docker_exec' => [\n      /^docker\\s+exec\\b/i,\n      /^docker\\s+container\\s+exec\\b/i\n    ],\n    'docker_logs' => [\n      /^docker\\s+logs\\b/i,\n      /^docker\\s+container\\s+logs\\b/i\n    ],\n    'docker_inspect' => [\n      /^docker\\s+inspect\\b/i,\n      /^docker\\s+container\\s+inspect\\b/i\n    ],\n    \n    # Image operations\n    'docker_build' => [\n      /^docker\\s+build\\b/i,\n      /^docker\\s+image\\s+build\\b/i\n    ],\n    'docker_pull' => [\n      /^docker\\s+pull\\b/i,\n      /^docker\\s+image\\s+pull\\b/i\n    ],\n    'docker_push' => [\n      /^docker\\s+push\\b/i,\n      /^docker\\s+image\\s+push\\b/i\n    ],\n    'docker_images' => [\n      /^docker\\s+images\\b/i,\n      /^docker\\s+image\\s+ls\\b/i,\n      /^docker\\s+image\\s+list\\b/i\n    ],\n    'docker_rmi' => [\n      /^docker\\s+rmi\\b/i,\n      /^docker\\s+image\\s+rm\\b/i,\n      /^docker\\s+image\\s+remove\\b/i\n    ],\n    'docker_tag' => [\n      /^docker\\s+tag\\b/i,\n      /^docker\\s+image\\s+tag\\b/i\n    ],\n    \n    # Volume operations\n    'docker_volume_create' => [\n      /^docker\\s+volume\\s+create\\b/i\n    ],\n    'docker_volume_ls' => [\n      /^docker\\s+volume\\s+ls\\b/i,\n      /^docker\\s+volume\\s+list\\b/i\n    ],\n    'docker_volume_rm' => [\n      /^docker\\s+volume\\s+rm\\b/i,\n      /^docker\\s+volume\\s+remove\\b/i\n    ],\n    \n    # Network operations\n    'docker_network_create' => [\n      /^docker\\s+network\\s+create\\b/i\n    ],\n    'docker_network_ls' => [\n      /^docker\\s+network\\s+ls\\b/i,\n      /^docker\\s+network\\s+list\\b/i\n    ],\n    'docker_network_rm' => [\n      /^docker\\s+network\\s+rm\\b/i,\n      /^docker\\s+network\\s+remove\\b/i\n    ],\n    \n    # Docker Compose\n    'docker_compose_up' => [\n      /^docker-compose\\s+up\\b/i,\n      /^docker\\s+compose\\s+up\\b/i\n    ],\n    'docker_compose_down' => [\n      /^docker-compose\\s+down\\b/i,\n      /^docker\\s+compose\\s+down\\b/i\n    ],\n    'docker_compose_build' => [\n      /^docker-compose\\s+build\\b/i,\n      /^docker\\s+compose\\s+build\\b/i\n    ],\n    'docker_compose_ps' => [\n      /^docker-compose\\s+ps\\b/i,\n      /^docker\\s+compose\\s+ps\\b/i\n    ]\n  }.freeze\n  \n  # Kubernetes command patterns and their canonical forms\n  KUBERNETES_PATTERNS = {\n    # Pod operations\n    'kubectl_get_pods' => [\n      /^kubectl\\s+get\\s+pods?\\b/i,\n      /^kubectl\\s+get\\s+po\\b/i\n    ],\n    'kubectl_describe_pod' => [\n      /^kubectl\\s+describe\\s+pods?\\b/i,\n      /^kubectl\\s+describe\\s+po\\b/i\n    ],\n    'kubectl_delete_pod' => [\n      /^kubectl\\s+delete\\s+pods?\\b/i,\n      /^kubectl\\s+delete\\s+po\\b/i\n    ],\n    'kubectl_logs' => [\n      /^kubectl\\s+logs\\b/i\n    ],\n    'kubectl_exec' => [\n      /^kubectl\\s+exec\\b/i\n    ],\n    'kubectl_port_forward' => [\n      /^kubectl\\s+port-forward\\b/i\n    ],\n    \n    # Deployment operations\n    'kubectl_create_deployment' => [\n      /^kubectl\\s+create\\s+deployment\\b/i,\n      /^kubectl\\s+create\\s+deploy\\b/i\n    ],\n    'kubectl_get_deployments' => [\n      /^kubectl\\s+get\\s+deployments?\\b/i,\n      /^kubectl\\s+get\\s+deploy\\b/i\n    ],\n    'kubectl_scale' => [\n      /^kubectl\\s+scale\\b/i\n    ],\n    'kubectl_rollout' => [\n      /^kubectl\\s+rollout\\b/i\n    ],\n    'kubectl_set_image' => [\n      /^kubectl\\s+set\\s+image\\b/i\n    ],\n    \n    # Service operations\n    'kubectl_expose' => [\n      /^kubectl\\s+expose\\b/i\n    ],\n    'kubectl_get_services' => [\n      /^kubectl\\s+get\\s+services?\\b/i,\n      /^kubectl\\s+get\\s+svc\\b/i\n    ],\n    \n    # ConfigMap/Secret operations\n    'kubectl_create_configmap' => [\n      /^kubectl\\s+create\\s+configmap\\b/i,\n      /^kubectl\\s+create\\s+cm\\b/i\n    ],\n    'kubectl_create_secret' => [\n      /^kubectl\\s+create\\s+secret\\b/i\n    ],\n    \n    # General operations\n    'kubectl_apply' => [\n      /^kubectl\\s+apply\\b/i\n    ],\n    'kubectl_get' => [\n      /^kubectl\\s+get\\b/i\n    ],\n    'kubectl_describe' => [\n      /^kubectl\\s+describe\\b/i\n    ],\n    'kubectl_delete' => [\n      /^kubectl\\s+delete\\b/i\n    ],\n    'kubectl_edit' => [\n      /^kubectl\\s+edit\\b/i\n    ]\n  }.freeze\n  \n  # Combine all patterns\n  ALL_PATTERNS = DOCKER_PATTERNS.merge(KUBERNETES_PATTERNS).freeze\n  \n  class << self\n    # Canonicalize a command string to its standard form\n    # @param command [String] The raw command string\n    # @return [String, nil] The canonical command key or nil if not recognized\n    def canonicalize(command)\n      return nil if command.blank?\n      \n      # Clean up the command\n      cleaned = command.strip.downcase\n      \n      # Try to match against all patterns\n      ALL_PATTERNS.each do |canonical_key, patterns|\n        patterns.each do |pattern|\n          return canonical_key if cleaned.match?(pattern)\n        end\n      end\n      \n      # If no pattern matches, try to extract a basic canonical form\n      extract_basic_canonical(cleaned)\n    end\n    \n    # Get the category for a canonical command\n    # @param canonical_command [String] The canonical command key\n    # @return [String] The category (docker, kubernetes, docker-compose)\n    def category(canonical_command)\n      return nil if canonical_command.blank?\n      \n      case canonical_command\n      when /^docker_compose_/\n        'docker-compose'\n      when /^docker_/\n        'docker'\n      when /^kubectl_/\n        'kubernetes'\n      else\n        'other'\n      end\n    end\n    \n    # Get human-readable label for canonical command\n    # @param canonical_command [String] The canonical command key\n    # @return [String] Human-readable label\n    def label(canonical_command)\n      return '' if canonical_command.blank?\n      \n      canonical_command\n        .gsub('_', ' ')\n        .gsub('docker compose', 'docker-compose')\n        .gsub('kubectl', 'kubectl')\n        .split(' ')\n        .map(&:capitalize)\n        .join(' ')\n    end\n    \n    # Get all canonical commands for a category\n    # @param category [String] The category to filter by\n    # @return [Array<String>] Array of canonical command keys\n    def commands_for_category(category)\n      case category\n      when 'docker'\n        DOCKER_PATTERNS.keys - commands_for_category('docker-compose')\n      when 'docker-compose'\n        DOCKER_PATTERNS.keys.select { |k| k.start_with?('docker_compose_') }\n      when 'kubernetes'\n        KUBERNETES_PATTERNS.keys\n      else\n        []\n      end\n    end\n    \n    # Check if a command is valid/recognized\n    # @param command [String] The raw command string\n    # @return [Boolean] true if command is recognized\n    def valid?(command)\n      canonicalize(command).present?\n    end\
    
    # Extract required commands from text (for parsing lessons)
    # @param text [String] Text containing commands
    # @return [Array<String>] Array of canonical command keys found
    def extract_commands(text)
      return [] if text.blank?
      
      commands = []
      
      # Look for code blocks or commands in backticks
      code_blocks = text.scan(/`([^`]+)`/)
      code_blocks.flatten.each do |block|
        canonical = canonicalize(block)
        commands << canonical if canonical
      end
      
      # Look for command patterns in regular text
      lines = text.split("\n")
      lines.each do |line|
        # Skip if line doesn't look like it contains a command
        next unless line.match?(/docker|kubectl/i)
        
        # Try to extract command from the line
        canonical = canonicalize(line)
        commands << canonical if canonical
      end
      
      commands.uniq
    end
    
    # Get examples for a canonical command
    # @param canonical_command [String] The canonical command key
    # @return [Array<String>] Example command strings
    def examples(canonical_command)
      case canonical_command
      when 'docker_run'
        ['docker run nginx', 'docker run -d -p 80:80 nginx', 'docker container run --name web nginx']
      when 'docker_ps'
        ['docker ps', 'docker ps -a', 'docker container ls']
      when 'docker_build'
        ['docker build -t myapp .', 'docker build -f Dockerfile.prod -t myapp:latest .']
      when 'kubectl_get_pods'
        ['kubectl get pods', 'kubectl get po -n default', 'kubectl get pods --all-namespaces']
      when 'kubectl_apply'
        ['kubectl apply -f deployment.yaml', 'kubectl apply -f ./k8s/', 'kubectl apply -f https://example.com/manifest.yaml']
      else
        []
      end
    end
    
    private
    
    # Extract a basic canonical form when no pattern matches
    # @param command [String] The cleaned command string
    # @return [String, nil] Basic canonical form or nil
    def extract_basic_canonical(command)
      # Try to extract the base command structure
      parts = command.split(/\s+/)
      return nil if parts.empty?
      
      # Handle docker commands
      if parts[0] == 'docker'
        if parts[1] && parts[2]
          # docker <resource> <action> format
          return "docker_#{parts[1]}_#{parts[2]}"
        elsif parts[1]
          # docker <action> format
          return "docker_#{parts[1]}"
        end
      end
      
      # Handle kubectl commands
      if parts[0] == 'kubectl'
        if parts[1] && parts[2]
          # kubectl <action> <resource> format
          return "kubectl_#{parts[1]}_#{parts[2]}"
        elsif parts[1]
          # kubectl <action> format
          return "kubectl_#{parts[1]}"
        end
      end
      
      # Handle docker-compose commands
      if parts[0] == 'docker-compose' || (parts[0] == 'docker' && parts[1] == 'compose')
        action = parts[0] == 'docker-compose' ? parts[1] : parts[2]
        return "docker_compose_#{action}" if action
      end
      
      nil
    end
  end
end