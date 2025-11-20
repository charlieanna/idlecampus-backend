class BackfillQuizQuestionMetadata < ActiveRecord::Migration[6.0]
  def up
    # Map difficulty_level to IRT difficulty scale
    difficulty_map = { 'easy' => -1.0, 'medium' => 0.0, 'hard' => 1.0 }
    
    # Infer topic and skill_dimension from quiz context
    QuizQuestion.find_each do |question|
      # Set difficulty from difficulty_level if present
      if question.difficulty_level.present?
        question.update_column(:difficulty, difficulty_map[question.difficulty_level] || 0.0)
      end
      
      # Infer topic from quiz title (simplified)
      quiz = question.quiz
      inferred_topic = infer_topic_from_quiz(quiz)
      inferred_dimension = infer_dimension_from_quiz(quiz)
      
      question.update_columns(
        topic: inferred_topic,
        skill_dimension: inferred_dimension
      )
    end
  end
  
  def down
    # No-op: keep metadata even on rollback
  end
  
  private
  
  def infer_topic_from_quiz(quiz)
    return nil unless quiz
    
    title = quiz.title.downcase
    
    # Docker topics
    return 'containers' if title.include?('container')
    return 'images' if title.include?('image') || title.include?('dockerfile')
    return 'networking' if title.include?('network') || title.include?('port')
    return 'volumes' if title.include?('volume') || title.include?('storage')
    return 'compose' if title.include?('compose')
    return 'security' if title.include?('security')
    return 'registry' if title.include?('registry')
    
    # K8s topics
    return 'pods' if title.include?('pod')
    return 'deployments' if title.include?('deploy') || title.include?('rollout')
    return 'services' if title.include?('service') || title.include?('endpoint')
    return 'ingress' if title.include?('ingress')
    return 'configmaps' if title.include?('configmap')
    return 'secrets' if title.include?('secret')
    return 'rbac' if title.include?('rbac') || title.include?('role')
    return 'scheduling' if title.include?('scheduling') || title.include?('affinity')
    return 'storage' if title.include?('pv') || title.include?('storage')
    return 'troubleshooting' if title.include?('troubleshoot') || title.include?('debug')
    
    'general'
  end
  
  def infer_dimension_from_quiz(quiz)
    return nil unless quiz
    
    title = quiz.title.downcase
    
    # Docker dimensions
    return 'docker_basics' if title.include?('container') || title.include?('image')
    return 'docker_networking' if title.include?('network') || title.include?('port')
    return 'docker_security' if title.include?('security') && !title.include?('kubernetes')
    return 'docker_compose' if title.include?('compose')
    return 'docker_advanced' if title.include?('swarm') || title.include?('registry')
    
    # K8s dimensions  
    return 'k8s_basics' if title.include?('pod') || title.include?('architecture')
    return 'k8s_workloads' if title.include?('deploy') || title.include?('job') || title.include?('stateful')
    return 'k8s_networking' if title.include?('service') || title.include?('ingress') || title.include?('network')
    return 'k8s_storage' if title.include?('pv') || title.include?('storage')
    return 'k8s_security' if title.include?('rbac') || title.include?('security')
    return 'k8s_administration' if title.include?('cluster') || title.include?('etcd') || title.include?('maintenance')
    
    'general'
  end
end
