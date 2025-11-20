namespace :adaptive do
  desc "Backfill quiz question metadata for adaptive learning"
  task backfill_metadata: :environment do
    puts "🔄 Backfilling quiz question metadata..."
    
    # Map difficulty_level to IRT difficulty scale
    difficulty_map = {
      'easy' => -1.0,
      'medium' => 0.0,
      'hard' => 1.0
    }
    
    # Infer topics from quiz titles and question text
    topic_keywords = {
      'container' => ['container', 'docker run', 'image', 'dockerfile'],
      'deployment' => ['deployment', 'deploy', 'rollout', 'replica'],
      'service' => ['service', 'expose', 'clusterip', 'nodeport'],
      'networking' => ['network', 'dns', 'ingress', 'cni'],
      'storage' => ['volume', 'pvc', 'pv', 'storageclass'],
      'security' => ['rbac', 'secret', 'security', 'role', 'permission'],
      'pod' => ['pod', 'kubectl run', 'exec'],
      'scheduling' => ['schedule', 'affinity', 'taint', 'toleration'],
      'config' => ['configmap', 'env', 'secret'],
      'observability' => ['log', 'probe', 'monitor', 'debug']
    }
    
    # Map topics to skill dimensions
    topic_to_dimension = {
      'container' => 'docker_basics',
      'deployment' => 'k8s_basics',
      'service' => 'k8s_basics',
      'networking' => 'networking',
      'storage' => 'storage',
      'security' => 'security',
      'pod' => 'k8s_basics',
      'scheduling' => 'k8s_advanced',
      'config' => 'k8s_basics',
      'observability' => 'observability'
    }
    
    updated_count = 0
    skipped_count = 0
    
    QuizQuestion.find_each do |question|
      changes = {}
      
      # Set difficulty from difficulty_level if not set
      if question.difficulty == 0.0 && question.difficulty_level.present?
        changes[:difficulty] = difficulty_map[question.difficulty_level] || 0.0
      end
      
      # Infer topic if not set
      if question.topic.blank?
        text = "#{question.question_text} #{question.explanation}".downcase
        
        detected_topic = topic_keywords.find do |topic, keywords|
          keywords.any? { |keyword| text.include?(keyword) }
        end&.first
        
        changes[:topic] = detected_topic if detected_topic
      end
      
      # Infer skill_dimension from topic if not set
      if question.skill_dimension.blank? && question.topic.present?
        changes[:skill_dimension] = topic_to_dimension[question.topic]
      elsif question.skill_dimension.blank? && changes[:topic]
        changes[:skill_dimension] = topic_to_dimension[changes[:topic]]
      end
      
      # Infer from quiz context if still missing
      if question.skill_dimension.blank?
        quiz = question.quiz
        if quiz&.title
          quiz_text = quiz.title.downcase
          if quiz_text.include?('docker') || quiz_text.include?('dca')
            changes[:skill_dimension] = 'docker_basics'
          elsif quiz_text.include?('cka')
            changes[:skill_dimension] = 'k8s_advanced'
          elsif quiz_text.include?('ckad')
            changes[:skill_dimension] = 'k8s_basics'
          elsif quiz_text.include?('cks')
            changes[:skill_dimension] = 'security'
          else
            changes[:skill_dimension] = 'general'
          end
        end
      end
      
      if changes.any?
        question.update_columns(changes)
        updated_count += 1
        print '.' if updated_count % 10 == 0
      else
        skipped_count += 1
      end
    end
    
    puts "\n✅ Backfill complete!"
    puts "   Updated: #{updated_count} questions"
    puts "   Skipped: #{skipped_count} questions"
    
    # Show distribution
    puts "\n📊 Distribution:"
    puts "   By skill_dimension:"
    QuizQuestion.group(:skill_dimension).count.each do |dim, count|
      puts "     - #{dim || 'null'}: #{count}"
    end
    
    puts "\n   By topic:"
    QuizQuestion.group(:topic).count.sort_by { |_, count| -count }.first(10).each do |topic, count|
      puts "     - #{topic || 'null'}: #{count}"
    end
    
    puts "\n   By difficulty:"
    QuizQuestion.group(:difficulty).count.sort.each do |diff, count|
      puts "     - #{diff}: #{count}"
    end
  end
end

