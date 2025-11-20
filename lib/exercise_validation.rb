module ExerciseValidation
  Result = Struct.new(:pass, :messages)

  # rules: {
  #   must_include: [String|Regexp, ...],
  #   must_not_include: [String|Regexp, ...]
  # }
  def self.validate(output, rules = {})
    messages = []
    pass = true
    out = output.to_s

    Array(rules[:must_include]).each do |pattern|
      if pattern.is_a?(Regexp)
        unless out.match?(pattern)
          pass = false
          messages << "Missing required pattern: #{pattern.inspect}"
        end
      else
        unless out.include?(pattern.to_s)
          pass = false
          messages << "Missing required text: #{pattern}"
        end
      end
    end

    Array(rules[:must_not_include]).each do |pattern|
      if pattern.is_a?(Regexp)
        if out.match?(pattern)
          pass = false
          messages << "Forbidden pattern present: #{pattern.inspect}"
        end
      else
        if out.include?(pattern.to_s)
          pass = false
          messages << "Forbidden text present: #{pattern}"
        end
      end
    end

    Result.new(pass, messages)
  end
end

