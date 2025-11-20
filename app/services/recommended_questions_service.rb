class RecommendedQuestionsService
  def initialize(user_id)
    @user_id = user_id
  end

  def call
    user = User.find_by(id: @user_id)
    return [] unless user

    answered_questions, user_tags = fetch_answered_questions_and_calculate_tag_weights(@user_id)
    related_tags_map = prefetch_related_tags(user_tags)
    all_related_tags = collect_all_related_tags(related_tags_map)
    all_questions = Question.tagged_with(all_related_tags)

    recommended_questions = calculate_recommendations(user_tags, related_tags_map, all_questions)
    sort_and_take_top(recommended_questions)
  end

  private

  # Extracted methods
  def prefetch_related_tags(user_tags)
    user_tags.keys.each_with_object({}) do |tag, map|
      map[tag] = related_tags(tag)
    end
  end

  def collect_all_related_tags(related_tags_map)
    related_tags_map.values.flatten.map { |related_tag| related_tag[:name] }
  end

  def calculate_recommendations(user_tags, related_tags_map, all_questions)
    user_tags.each do |tag, weight|
      related_tags_map[tag].each do |related_tag|
        # Filtering questions that have the related tags
        questions_with_related_tag = all_questions.select { |q| q.tagged_with?([tag, related_tag[:name]]) }
  
        questions_with_related_tag.each do |question|
          score = score_question(question, user_tags) # Your scoring logic
          recommended_questions << { question: question, score: score }
        end
      end
    end
    return recommended_questions
  end

  def sort_and_take_top(recommended_questions)
    recommended_questions.sort_by! { |rec| -rec[:score] }
    recommended_questions.take(10)
  end
end
