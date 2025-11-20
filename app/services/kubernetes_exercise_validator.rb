class KubernetesExerciseValidator
  # Kubernetes command validator for kubectl practice micros
  # Input: user_command (String), spec (Hash)
  # Spec keys (all optional):
  #   :base_command => String or [String]
  #   :required_flags => [String]
  #   :requires_argument => true/false
  #   :required_resource => String (e.g., 'pods', 'deployments')
  #   :required_name => String
  #   :require_success => true/false
  # Returns: { valid: Boolean, message: String }
  # Supports both signatures:
  #   validate(user_command, spec)
  #   validate(user_command, _result, spec)
  def self.validate(*args)
    user_command = args[0]
    # Second arg might be result hash (from execute) or spec directly
    result = args.length == 3 ? args[1] : nil
    spec = args.length == 3 ? (args[2] || {}) : (args[1] || {})
    
    cmd = (user_command || '').strip
    return failure('Please enter a command.') if cmd.empty?

    tokens = shell_split(cmd)
    return failure('Invalid command format.') if tokens.empty?
    
    # Check if kubectl is available (graceful handling)
    if result && result[:output]&.include?('command not found')
      return failure('kubectl is not installed. Install kubectl to practice Kubernetes commands.')
    end
    
    # Handle cluster connection errors gracefully
    if result && result[:output]
      if result[:output].include?('connection refused') || 
         result[:output].include?('Unable to connect') ||
         result[:output].include?('The connection to the server') ||
         result[:output].include?('no such host')
        return failure('No Kubernetes cluster detected. Start minikube or connect to a cluster to practice kubectl commands.')
      end
    end
    
    # Check if command actually succeeded if require_success is set
    if spec[:require_success] && result
      unless result[:success]
        # Extract helpful error from output
        error_hint = if result[:output] =~ /not found|NotFound/i
                      "Resource not found. Check if the resource exists with 'kubectl get <resource>'"
                    elsif result[:output] =~ /invalid|unknown flag/i
                      "Invalid flag. Check kubectl syntax - flags use single dash (e.g., -n not --namespace)"
                    elsif result[:output] =~ /forbidden|unauthorized/i
                      "Permission denied. You may need cluster admin access."
                    elsif result[:output]
                      "Command failed: #{result[:output].split("\n").first}"
                    else
                      "Command failed to execute. Check your syntax."
                    end
        return failure(error_hint)
      end
    end

    # Base command (supports multiple acceptable forms)
    if spec[:base_command]
      accepted = Array(spec[:base_command])
      unless accepted.any? { |base| tokens.first(accepted_base_word_count(base)) == base.split }
        return failure("Start with: #{accepted.join(' or ')}")
      end
    end

    # Required flags (presence anywhere)
    if spec[:required_flags]&.any?
      missing = spec[:required_flags].reject do |flag|
        # Check for exact match
        next true if tokens.include?(flag)
        
        # Check for flag with value (e.g., "-o wide" should match "-o wide" or "-o=wide")
        if flag.include?(' ')
          flag_parts = flag.split(' ', 2)
          flag_name = flag_parts[0]
          flag_value = flag_parts[1]
          
          # Check if flag_name exists and next token is flag_value
          flag_index = tokens.find_index { |t| t == flag_name || t.start_with?(flag_name) }
          if flag_index
            # Check if next token is the value, or if flag is combined like "-o=wide"
            next_token = tokens[flag_index + 1]
            combined_flag = tokens[flag_index]
            
            next true if next_token == flag_value
            next true if combined_flag == "#{flag_name}=#{flag_value}"
            next true if combined_flag.start_with?("#{flag_name}=") && combined_flag.end_with?(flag_value)
          end
        else
          # Simple flag (no value) - check if it exists or starts with it
          next true if tokens.any? { |t| t == flag || t.start_with?(flag) }
        end
        
        false
      end
      return failure("Missing required flag(s): #{missing.join(', ')}") if missing.any?
    end

    # Requires argument (e.g., resource type or name)
    if spec[:requires_argument]
      # crude check: at least 3 tokens (e.g., kubectl get pods)
      return failure('Missing required argument (e.g., resource type or name).') if tokens.size < 3
    end

    # Resource checks
    if spec[:required_resource]
      unless tokens.any? { |t| t == spec[:required_resource] }
        return failure("Use resource type: #{spec[:required_resource]}")
      end
    end

    if spec[:required_name]
      unless tokens.any? { |t| t == spec[:required_name] }
        return failure("Use resource name: #{spec[:required_name]}")
      end
    end

    # Get story-aware success message
    success_msg = get_story_message(cmd, spec, result) || 'Looks good!'
    success(success_msg)
  rescue => e
    failure("Validation error: #{e.message}")
  end
  
  def self.get_story_message(command, spec, result)
    # Provide contextual success messages based on the command
    if command.include?('kubectl get pods')
      if result && result[:output]&.include?('No resources found')
        "Perfect! You checked for pods. The cluster is empty right now - no pods are running yet."
      else
        "Excellent! You can see the list of pods running in your cluster. Notice the STATUS and READY columns?"
      end
    elsif command.include?('kubectl get deployments')
      "Great! You're viewing deployments. These manage your pod replicas."
    elsif command.include?('kubectl get services')
      "Nice! Services expose your pods to network traffic."
    elsif command.include?('kubectl get nodes')
      "Excellent! These are the worker machines in your cluster."
    elsif command.include?('kubectl describe')
      "Perfect! The describe command shows detailed information. Scroll through to see events and configuration."
    elsif command.include?('kubectl logs')
      if command.include?('-f')
        "Great! Streaming logs in real-time. Press Ctrl+C to stop."
      else
        "Perfect! These are the container logs. Helpful for debugging!"
      end
    elsif command.include?('kubectl exec')
      if command.include?('bash') || command.include?('sh')
        "Success! You're now inside the pod's container. Try 'ls' or 'pwd'!"
      else
        "Nice! Command executed inside the pod."
      end
    elsif command.include?('kubectl apply')
      "Excellent! Configuration applied to the cluster. Use 'kubectl get' to verify."
    elsif command.include?('kubectl create')
      "Perfect! Resource created successfully. Check it with 'kubectl get'."
    elsif command.include?('kubectl delete')
      "Done! Resource deleted. It may take a moment to fully terminate."
    elsif command.include?('kubectl scale')
      "Great! Scaling command sent. Watch with 'kubectl get pods' to see replicas change."
    elsif command.include?('kubectl port-forward')
      "Success! Port forwarding active. Access your app at localhost:PORT"
    elsif command.include?('kubectl config')
      "Perfect! Cluster configuration updated."
    end
  end

  def self.shell_split(command)
    # Basic split on whitespace; good enough for simple training commands
    command.scan(/(?:"[^"]*"|'[^']*'|\S)+/)
  end

  def self.accepted_base_word_count(base)
    base.split.size
  end

  def self.failure(message)
    { valid: false, message: message }
  end

  def self.success(message)
    { valid: true, message: message }
  end
end