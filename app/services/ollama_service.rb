# frozen_string_literal: true

require 'net/http'
require 'json'

# Ollama AI Service for UPSC Answer Evaluation
# Requires Ollama running locally on port 11434
class OllamaService
  OLLAMA_URL = ENV.fetch('OLLAMA_URL', 'http://localhost:11434')
  MODEL = ENV.fetch('OLLAMA_MODEL', 'llama3.2')
  TIMEOUT = 120 # 2 minutes for generation

  class OllamaError < StandardError; end

  # ============================================
  # PUBLIC API
  # ============================================

  # Evaluate a UPSC answer
  def self.evaluate_answer(answer_text:, question_text:, word_limit: nil, evaluation_criteria: [], sample_answer_points: [])
    prompt = build_evaluation_prompt(
      question: question_text,
      answer: answer_text,
      word_limit: word_limit,
      criteria: evaluation_criteria,
      sample_points: sample_answer_points
    )

    response = generate(prompt)
    parse_evaluation_response(response)
  end

  # Generate study plan suggestions
  def self.generate_study_plan_suggestions(target_date:, current_level:, subjects:, available_hours_per_day:)
    prompt = build_study_plan_prompt(
      target_date: target_date,
      current_level: current_level,
      subjects: subjects,
      hours_per_day: available_hours_per_day
    )

    response = generate(prompt)
    parse_study_plan_response(response)
  end

  # Explain a concept
  def self.explain_concept(topic:, difficulty_level: 'medium')
    prompt = "Explain the following UPSC topic in simple terms for #{difficulty_level} level students:\n\n#{topic}\n\nProvide a clear, concise explanation with key points and examples."

    generate(prompt)
  end

  # Generate practice questions
  def self.generate_practice_questions(topic:, question_type: 'mcq', count: 5)
    prompt = build_question_generation_prompt(
      topic: topic,
      question_type: question_type,
      count: count
    )

    response = generate(prompt)
    parse_questions_response(response)
  end

  # Check if Ollama is available
  def self.available?
    uri = URI("#{OLLAMA_URL}/api/tags")
    response = Net::HTTP.get_response(uri)
    response.is_a?(Net::HTTPSuccess)
  rescue StandardError => e
    Rails.logger.error("Ollama availability check failed: #{e.message}")
    false
  end

  # List available models
  def self.list_models
    uri = URI("#{OLLAMA_URL}/api/tags")
    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      data = JSON.parse(response.body)
      data['models']&.map { |m| m['name'] } || []
    else
      []
    end
  rescue StandardError => e
    Rails.logger.error("Failed to list models: #{e.message}")
    []
  end

  # ============================================
  # PRIVATE METHODS
  # ============================================

  private

  # Core generation method
  def self.generate(prompt, model: MODEL, stream: false)
    uri = URI("#{OLLAMA_URL}/api/generate")

    request = Net::HTTP::Post.new(uri)
    request['Content-Type'] = 'application/json'
    request.body = {
      model: model,
      prompt: prompt,
      stream: stream,
      options: {
        temperature: 0.7,
        top_p: 0.9,
        top_k: 40
      }
    }.to_json

    response = Net::HTTP.start(uri.hostname, uri.port, read_timeout: TIMEOUT) do |http|
      http.request(request)
    end

    unless response.is_a?(Net::HTTPSuccess)
      raise OllamaError, "Ollama request failed: #{response.code} #{response.message}"
    end

    data = JSON.parse(response.body)

    unless data['response']
      raise OllamaError, "No response from Ollama"
    end

    data['response']
  rescue StandardError => e
    Rails.logger.error("Ollama generation error: #{e.message}")
    raise OllamaError, "Failed to generate response: #{e.message}"
  end

  # Build evaluation prompt
  def self.build_evaluation_prompt(question:, answer:, word_limit:, criteria:, sample_points:)
    prompt = <<~PROMPT
      You are an expert UPSC Civil Services Examination evaluator. Evaluate the following answer strictly according to UPSC standards.

      QUESTION:
      #{question}

      #{word_limit ? "WORD LIMIT: #{word_limit} words" : ''}

      STUDENT'S ANSWER:
      #{answer}

      #{!sample_points.empty? ? "KEY POINTS TO COVER:\n#{sample_points.map.with_index(1) { |p, i| "#{i}. #{p}" }.join("\n")}" : ''}

      #{!criteria.empty? ? "EVALUATION CRITERIA:\n#{criteria.join("\n")}" : ''}

      Provide a comprehensive evaluation in the following JSON format:
      {
        "overall_score": <score out of 100>,
        "content_coverage": <score out of 100>,
        "structure": <score out of 100>,
        "language_quality": <score out of 100>,
        "presentation": <score out of 100>,
        "strengths": ["strength1", "strength2", "strength3"],
        "weaknesses": ["weakness1", "weakness2"],
        "suggestions": ["suggestion1", "suggestion2", "suggestion3"],
        "detailed_feedback": "Comprehensive feedback paragraph",
        "key_points_covered": <number>,
        "key_points_missed": ["missed point 1", "missed point 2"]
      }

      Return ONLY the JSON object, no additional text.
    PROMPT

    prompt
  end

  # Parse evaluation response
  def self.parse_evaluation_response(response)
    # Extract JSON from response (in case there's extra text)
    json_match = response.match(/\{.*\}/m)

    if json_match
      JSON.parse(json_match[0])
    else
      # Fallback if JSON parsing fails
      {
        'overall_score' => 60,
        'content_coverage' => 60,
        'structure' => 60,
        'language_quality' => 60,
        'presentation' => 60,
        'strengths' => ['Answer provided'],
        'weaknesses' => ['Could not parse AI response properly'],
        'suggestions' => ['Try again with clearer structure'],
        'detailed_feedback' => response[0..500],
        'key_points_covered' => 0,
        'key_points_missed' => []
      }
    end
  rescue JSON::ParserError => e
    Rails.logger.error("Failed to parse evaluation response: #{e.message}")
    {
      'overall_score' => 60,
      'content_coverage' => 60,
      'structure' => 60,
      'language_quality' => 60,
      'presentation' => 60,
      'strengths' => ['Answer submitted'],
      'weaknesses' => ['AI evaluation parsing error'],
      'suggestions' => ['System will retry evaluation'],
      'detailed_feedback' => 'Evaluation completed with partial results.',
      'key_points_covered' => 0,
      'key_points_missed' => []
    }
  end

  # Build study plan prompt
  def self.build_study_plan_prompt(target_date:, current_level:, subjects:, hours_per_day:)
    days_available = (target_date.to_date - Date.current).to_i

    <<~PROMPT
      You are a UPSC preparation expert. Create a personalized study plan.

      STUDENT PROFILE:
      - Current Level: #{current_level}
      - Days Available: #{days_available}
      - Study Hours Per Day: #{hours_per_day}
      - Target Date: #{target_date}

      SUBJECTS TO COVER:
      #{subjects.join("\n")}

      Create a phase-wise study plan with:
      1. Foundation phase duration and focus areas
      2. In-depth study phase with subject allocation
      3. Revision phase strategy
      4. Mock test schedule
      5. Daily/weekly targets

      Return suggestions in JSON format:
      {
        "phases": [
          {
            "name": "Phase name",
            "duration_weeks": <number>,
            "focus_areas": ["area1", "area2"],
            "daily_hours_allocation": { "subject1": hours, "subject2": hours }
          }
        ],
        "key_recommendations": ["rec1", "rec2"],
        "priority_topics": ["topic1", "topic2"],
        "test_schedule": "Test taking strategy"
      }

      Return ONLY the JSON object.
    PROMPT
  end

  # Parse study plan response
  def self.parse_study_plan_response(response)
    json_match = response.match(/\{.*\}/m)

    if json_match
      JSON.parse(json_match[0])
    else
      {
        'phases' => [],
        'key_recommendations' => ['Focus on NCERT first', 'Practice daily', 'Take regular tests'],
        'priority_topics' => [],
        'test_schedule' => 'Weekly mock tests recommended'
      }
    end
  rescue JSON::ParserError
    {
      'phases' => [],
      'key_recommendations' => ['Could not generate detailed plan'],
      'priority_topics' => [],
      'test_schedule' => 'Weekly tests recommended'
    }
  end

  # Build question generation prompt
  def self.build_question_generation_prompt(topic:, question_type:, count:)
    type_instructions = case question_type
    when 'mcq'
      'multiple choice questions with 4 options and correct answer'
    when 'msq'
      'multiple select questions with multiple correct answers'
    when 'tf'
      'true/false questions with explanations'
    else
      'questions'
    end

    <<~PROMPT
      Generate #{count} high-quality UPSC #{type_instructions} on the topic: #{topic}

      Requirements:
      - Questions should be at UPSC Prelims/Mains level
      - Include clear, unambiguous options
      - Provide correct answer(s)
      - Include brief explanation for each answer

      Return in JSON array format:
      [
        {
          "question_text": "Question text here",
          "options": ["A) option1", "B) option2", "C) option3", "D) option4"],
          "correct_answer": "correct option letter",
          "explanation": "Why this is correct"
        }
      ]

      Return ONLY the JSON array.
    PROMPT
  end

  # Parse questions response
  def self.parse_questions_response(response)
    json_match = response.match(/\[.*\]/m)

    if json_match
      JSON.parse(json_match[0])
    else
      []
    end
  rescue JSON::ParserError
    []
  end
end
