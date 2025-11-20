#!/usr/bin/env ruby

# Executes prompt files in backend/prompts by:
# - Extracting referenced seed files
# - Parsing InteractiveLearningUnit definitions from those seeds
# - Generating microlesson seed files with MicroLesson + Exercise records
#
# Usage:
#   ruby backend/scripts/execute_prompts.rb

require 'fileutils'

BACKEND_DIR = File.expand_path('..', __dir__)
PROMPTS_DIR = File.join(BACKEND_DIR, 'prompts')
SEEDS_DIR = File.join(BACKEND_DIR, 'db', 'seeds')
OUTPUT_DIR = File.join(SEEDS_DIR, 'microlessons')

FileUtils.mkdir_p(OUTPUT_DIR)

FILENAME_ALIASES = {
  'organic/module_02_to_05_core.rb' => 'organic/modules_02_to_05_core.rb'
}

# Force module slugs for known formula packs
MODULE_SLUG_OVERRIDES = {
  'iit_jee/iit_jee_organic_chemistry_formulas.rb' => 'organic-formula-drills',
  'iit_jee/iit_jee_physical_chemistry_formulas.rb' => 'physical-formula-drills',
  'iit_jee_mathematics_formulas.rb' => 'formula-drills'
}

def list_prompt_files
  files = Dir.glob(File.join(PROMPTS_DIR, '**', '*_prompt.txt'))
  # Exclude any templates or non-course files just in case
  files.reject { |p| File.basename(p) == 'UNIVERSAL_TEMPLATE.txt' }.sort
end

def extract_seed_files_from_prompt(path)
  paths = []
  content = File.read(path, encoding: 'UTF-8')
  content.each_line do |line|
    # lines typically start with the checkbox char or dash
    if line.strip.start_with?('□ ')
      rel = line.strip.sub(/^□\s+/, '')
      # normalize any leading ./ or spaces
      rel = rel.strip
      paths << rel unless rel.empty?
    end
  end
  paths.uniq
end

# Very small helper to safely scan a heredoc starting at idx (at <<~TOKEN)
def extract_heredoc(src, start_idx)
  m = src.match(/<<~(\w+)/, start_idx)
  return [nil, nil] unless m
  token = m[1]
  # content starts right after the first newline following <<~TOKEN
  hdr_end = src.index("\n", m.end(0))
  return [nil, nil] unless hdr_end
  # find terminator line that equals token on its own line (with optional indentation)
  term_rx = /^\s*#{Regexp.escape(token)}\s*$/
  lines = src[(hdr_end + 1)..-1].split("\n", -1)
  content_lines = []
  term_line_index = nil
  lines.each_with_index do |ln, i|
    if ln =~ term_rx
      term_line_index = i
      break
    else
      content_lines << ln
    end
  end
  return [nil, nil] unless term_line_index
  content = content_lines.join("\n")
  # calculate absolute end index in src
  # start was hdr_end+1; end offset is term_line_index lines forward plus the line content length and newline
  consumed = content_lines.map { |l| l.length + 1 }.sum
  end_idx = (hdr_end + 1) + consumed + lines[term_line_index].length
  [content, end_idx]
end

def parse_string_array(block_str, attr)
  rx = /\b#{Regexp.escape(attr)}\s*=\s*\[(.*?)\]/m
  m = block_str.match(rx)
  return [] unless m
  inner = m[1]
  inner.scan(/'([^']*)'/).flatten
end

def parse_quiz_options(block_str)
  rx = /\bquiz_options\s*=\s*\[(.*?)\]/m
  m = block_str.match(rx)
  return { options: [], correct_index: nil } unless m
  inner = m[1]
  options = []
  correct_idx = nil
  inner.scan(/\{\s*text:\s*'([^']*)'\s*,\s*correct:\s*(true|false)\s*\}/).each_with_index do |(text, correct), i|
    options << text
    correct_idx = i if correct == 'true' && correct_idx.nil?
  end
  { options: options, correct_index: correct_idx }
end

def parse_block_attributes(block_str, var)
  unit = {}
  v = Regexp.escape(var)
  unit[:title] = block_str[/\b#{v}\.title\s*=\s*'([^']*)'/, 1]

  # concept_explanation can be heredoc or single quoted string
  if (idx = block_str.index("#{var}.concept_explanation"))
    # slice from position to end
    tail = block_str[idx..-1]
    if tail =~ /#{v}\.concept_explanation\s*=\s*<<~(\w+)/
      content, _end_idx = extract_heredoc(tail, 0)
      unit[:concept_explanation] = content
    else
      unit[:concept_explanation] = tail[/#{v}\.concept_explanation\s*=\s*'([^']*)'/, 1]
    end
  end

  # Some seeds use `content` instead of concept_explanation
  if unit[:concept_explanation].nil?
    if (idx2 = block_str.index("#{var}.content"))
      tail2 = block_str[idx2..-1]
      if tail2 =~ /#{v}\.content\s*=\s*<<~(\w+)/
        content2, _end2 = extract_heredoc(tail2, 0)
        unit[:concept_explanation] = content2
      else
        unit[:concept_explanation] = tail2[/#{v}\.content\s*=\s*'([^']*)'/, 1]
      end
    end
  end

  unit[:command_to_learn] = block_str[/\b#{v}\.command_to_learn\s*=\s*'([^']*)'/, 1]
  unit[:command_variations] = parse_string_array(block_str, "#{var}.command_variations")
  unit[:practice_hints]     = parse_string_array(block_str, "#{var}.practice_hints")
  unit[:scenario]           = block_str[/\b#{v}\.scenario_narrative\s*=\s*'([^']*)'/, 1]
  unit[:problem]            = block_str[/\b#{v}\.problem_statement\s*=\s*'([^']*)'/, 1]
  unit[:difficulty]         = block_str[/\b#{v}\.difficulty_level\s*=\s*'([^']*)'/, 1]
  unit[:estimated_minutes]  = (block_str[/\b#{v}\.estimated_minutes\s*=\s*(\d+)/, 1] || '2').to_i
  unit[:sequence_order]     = (block_str[/\b#{v}\.sequence_order\s*=\s*(\d+)/, 1] || '0').to_i
  unit[:category]           = block_str[/\b#{v}\.category\s*=\s*'([^']*)'/, 1]
  unit[:quiz_question_text] = block_str[/\b#{v}\.quiz_question_text\s*=\s*'([^']*)'/, 1]
  unit[:quiz_explanation]   = block_str[/\b#{v}\.quiz_explanation\s*=\s*'([^']*)'/, 1]
  qo = parse_quiz_options(block_str)
  unit[:quiz_options]       = qo[:options]
  unit[:quiz_correct_index] = qo[:correct_index]
  unit[:concept_tags]       = parse_string_array(block_str, "#{var}.concept_tags")

  # Some seeds use `quiz_questions` array of hashes
  if unit[:quiz_options].empty? && !block_str.match(/\b#{v}\.quiz_questions\s*=\s*\[/m).nil?
    qq_m = block_str.match(/\b#{v}\.quiz_questions\s*=\s*\[(.*?)\]\s*/m)
    if qq_m
      first_q = qq_m[1]
      qtext = first_q[/question:\s*"([^"]*)"/, 1] || first_q[/question:\s*'([^']*)'/, 1]
      opts_block = first_q[/options:\s*\[(.*?)\]/m, 1]
      opts = []
      if opts_block
        opts = opts_block.scan(/"([^"]*)"|'([^']*)'/).map { |a, b| a || b }
      end
      correct_idx = first_q[/correct_answer:\s*(\d+)/, 1]
      explanation = first_q[/explanation:\s*"([^"]*)"/, 1] || first_q[/explanation:\s*'([^']*)'/, 1]
      unit[:quiz_question_text] = qtext if qtext
      unit[:quiz_options] = opts unless opts.empty?
      unit[:quiz_correct_index] = correct_idx.to_i if correct_idx
      unit[:quiz_explanation] = explanation if explanation
    end
  end
  unit
end

def extract_blocks_for(seed_source, anchor)
  blocks = []
  pos = 0
  while (s = seed_source.index(anchor, pos))
    do_pos = seed_source.index('do |', s)
    break unless do_pos
    var_match = seed_source[do_pos..(do_pos + 50)].match(/do \|([a-zA-Z_][a-zA-Z0-9_]*)\|/)
    var = var_match ? var_match[1] : 'u'
    i = do_pos
    depth = 1
    block_end = nil
    while i < seed_source.length
      # Handle heredoc skipping
      if seed_source[i] == '<' && seed_source[i, 3] == '<<~'
        token_m = seed_source[i..(i + 50)].match(/<<~(\w+)/)
        if token_m
          token = token_m[1]
          i = seed_source.index("\n", i) || i
          i += 1
          term_rx = /^\s*#{Regexp.escape(token)}\s*$/
          while i < seed_source.length
            nl = seed_source.index("\n", i) || seed_source.length
            line = seed_source[i...nl]
            if line =~ term_rx
              i = nl + 1
              break
            else
              i = nl + 1
            end
          end
          next
        end
      end

      # Count nested do/end at code level
      if seed_source[i, 4] == ' do '
        depth += 1
      elsif seed_source[i, 3] == 'end'
        depth -= 1
        if depth == 0
          block_end = i + 3
          break
        end
      end
      i += 1
    end
    break unless block_end
    block_str = seed_source[do_pos...block_end]
    blocks << [block_str, var]
    pos = block_end + 1
  end
  blocks
end

def parse_interactive_units(seed_source)
  units = []
  # Format 1: InteractiveLearningUnit
  extract_blocks_for(seed_source, 'InteractiveLearningUnit.find_or_create_by!').each do |block_str, var|
    units << parse_block_attributes(block_str, var)
  end
  # Format 2: CourseLesson / Lesson
  [
    'CourseLesson.find_or_create_by!',
    'Lesson.find_or_create_by!'
  ].each do |anchor|
    extract_blocks_for(seed_source, anchor).each do |block_str, var|
      units << parse_block_attributes(block_str, var)
    end
  end

  # Format 2 (non-block): CourseLesson.create!/Lesson.create!
  extract_create_calls(seed_source, 'CourseLesson').each do |args_str|
    u = parse_lesson_hash_attributes(args_str)
    units << u if u
  end
  extract_create_calls(seed_source, 'Lesson').each do |args_str|
    u = parse_lesson_hash_attributes(args_str)
    units << u if u
  end

  # Format 3: Quiz/QuizQuestion-only seeds
  units.concat(parse_quiz_questions(seed_source))
  # Format 4: Named formula arrays (Organic/Math formulas)
  units.concat(parse_formula_arrays(seed_source))
  # Prefer module slug from seed if present
  mod_slug = extract_module_slug(seed_source)
  if mod_slug
    units.each { |u| u[:category] ||= mod_slug }
  end
  units
end

# Extract argument substrings for calls like: CourseLesson.create!( ... )
def extract_create_calls(src, klass)
  results = []
  anchor = "#{klass}.create!("
  pos = 0
  while (s = src.index(anchor, pos))
    i = s + anchor.length
    depth = 1
    args_start = i
    while i < src.length
      if src[i] == '<' && src[i, 3] == '<<~'
        # Skip heredoc until terminator line
        # Capture token
        token_m = src[i..(i + 50)].match(/<<~(\w+)/)
        if token_m
          token = token_m[1]
          # Move to next line after <<~TOKEN
          i = src.index("\n", i) || i
          i += 1
          # Find terminator line
          term_rx = /^\s*#{Regexp.escape(token)}\s*$/
          while i < src.length
            nl = src.index("\n", i) || src.length
            line = src[i...nl]
            if line =~ term_rx
              i = nl + 1
              break
            else
              i = nl + 1
            end
          end
          next
        end
      end

      case src[i]
      when '(' then depth += 1
      when ')' then depth -= 1
      end
      i += 1
      if depth == 0
        args_str = src[args_start...(i - 1)]
        results << args_str
        break
      end
    end
    pos = i
  end
  results
end

def extract_module_slug(src)
  # Look for explicit CourseModule slug definitions
  if (m = src.match(/CourseModule\.find_or_create_by!\s*\(\s*slug:\s*'([^']*)'/) ||
           src.match(/CourseModule\.find_or_create_by!\s*\(\s*slug:\s*"([^"]*)"/) ||
           src.match(/course_modules\.find_or_create_by!\s*\(\s*slug:\s*'([^']*)'/) ||
           src.match(/course_modules\.find_or_create_by!\s*\(\s*slug:\s*"([^"]*)"/))
    return m[1]
  end
  if (m = src.match(/CourseModule\.create!\s*\(.*?slug:\s*'([^']*)'/m) ||
           src.match(/CourseModule\.create!\s*\(.*?slug:\s*"([^"]*)"/m) ||
           src.match(/course_modules\.create!\s*\(.*?slug:\s*'([^']*)'/m) ||
           src.match(/course_modules\.create!\s*\(.*?slug:\s*"([^"]*)"/m))
    return m[1]
  end
  nil
end

def parse_formula_arrays(seed_source)
  units = []
  # Specific known arrays in seeds
  arrays = {
    name_formula: [
      'functional_formulas',
      'organic_compounds'
    ],
    prompt_answer: [
      'diff_formulas',
      'int_formulas'
    ]
  }

  arrays[:name_formula].each do |var|
    if (arr_str = extract_array_literal(seed_source, var))
      extract_objects_from_array(arr_str).each do |obj|
        name = obj[/\bname:\s*"([^"]*)"/, 1] || obj[/\bname:\s*'([^']*)'/, 1]
        formula = obj[/\bformula:\s*"([^"]*)"/, 1] || obj[/\bformula:\s*'([^']*)'/, 1]
        alt = obj[/\balternate:\s*"([^"]*)"/, 1] || obj[/\balternate:\s*'([^']*)'/, 1]
        next unless name && formula
        ans = alt && !alt.empty? ? "#{formula}|#{alt}" : formula
        units << {
          title: name,
          concept_explanation: "#{name} has the formula #{formula}",
          practice_hints: [
            'Recall the general form first.',
            'Check subscripts and grouping.',
            'Compare with common variants.'
          ],
          concept_tags: [],
          difficulty: 'medium',
          estimated_minutes: 2,
          sequence_order: 0,
          category: nil,
          sa_question: "What is the formula for #{name}?",
          sa_answer: ans
        }
      end
    end
  end

  arrays[:prompt_answer].each do |var|
    if (arr_str = extract_array_literal(seed_source, var))
      extract_objects_from_array(arr_str).each do |obj|
        name = obj[/\bname:\s*"([^"]*)"/, 1] || obj[/\bname:\s*'([^']*)'/, 1]
        prompt = obj[/\bprompt:\s*"([^"]*)"/, 1] || obj[/\bprompt:\s*'([^']*)'/, 1]
        answer = obj[/\banswer:\s*"([^"]*)"/, 1] || obj[/\banswer:\s*'([^']*)'/, 1]
        next unless prompt && answer
        title = name ? "#{name} — Drill" : 'Formula Drill'
        units << {
          title: title,
          concept_explanation: nil,
          practice_hints: [
            'Recall the base rule.',
            'Substitute symbols carefully.',
            'Simplify to standard form.'
          ],
          concept_tags: name ? [name] : [],
          difficulty: 'medium',
          estimated_minutes: 2,
          sequence_order: 0,
          category: nil,
          sa_question: name ? "#{name}: #{prompt}" : prompt,
          sa_answer: answer
        }
      end
    end
  end

  units
end

def extract_array_literal(src, var_name)
  start = src.index(/\b#{Regexp.escape(var_name)}\s*=\s*\[/)
  return nil unless start
  i = src.index('[', start)
  depth = 1
  i += 1
  arr_start = i
  while i < src.length
    case src[i]
    when '['
      depth += 1
    when ']'
      depth -= 1
      if depth == 0
        return src[arr_start...(i)]
      end
    when '<'
      if src[i, 3] == '<<~'
        # skip heredoc bodies inside strings if any (unlikely here)
        token_m = src[i..(i + 50)].match(/<<~(\w+)/)
        if token_m
          token = token_m[1]
          i = src.index("\n", i) || i
          i += 1
          term_rx = /^\s*#{Regexp.escape(token)}\s*$/
          while i < src.length
            nl = src.index("\n", i) || src.length
            line = src[i...nl]
            if line =~ term_rx
              i = nl + 1
              break
            else
              i = nl + 1
            end
          end
          next
        end
      end
    end
    i += 1
  end
  nil
end

def extract_objects_from_array(array_body)
  objs = []
  i = 0
  depth = 0
  start = nil
  while i < array_body.length
    ch = array_body[i]
    if ch == '{'
      depth += 1
      start = i if depth == 1
    elsif ch == '}'
      depth -= 1
      if depth == 0 && start
        objs << array_body[start..i]
        start = nil
      end
    end
    i += 1
  end
  objs
end

def parse_lesson_hash_attributes(args_str)
  unit = {}
  # title: '...' or "..."
  unit[:title] = args_str[/\btitle:\s*"([^"]*)"/, 1] || args_str[/\btitle:\s*'([^']*)'/, 1]

  # content heredoc or quoted
  if (idx = args_str.index('content:'))
    tail = args_str[idx..-1]
    if tail =~ /content:\s*<<~(\w+)/
      content, _end = extract_heredoc(tail, tail.index('<<~'))
      unit[:concept_explanation] = content
    else
      unit[:concept_explanation] = tail[/content:\s*"([^"]*)"/, 1] || tail[/content:\s*'([^']*)'/, 1]
    end
  end

  # key concepts (optional) as hints/key points
  if args_str =~ /key_concepts:\s*(JSON\.generate\(|\[)/m
    # Try to capture bracket array content
    arr = nil
    if (m = args_str.match(/key_concepts:\s*\[(.*?)\]/m))
      raw = m[1]
      arr = raw.scan(/"([^"]*)"|'([^']*)'/).map { |a, b| a || b }
    elsif (m = args_str.match(/key_concepts:\s*JSON\.generate\((\[.*?\])\)/m))
      raw = m[1]
      arr = raw.scan(/"([^"]*)"|'([^']*)'/).map { |a, b| a || b }
    end
    unit[:concept_tags] = arr if arr && !arr.empty?
  end

  # difficulty
  unit[:difficulty] = 'easy'
  unit[:estimated_minutes] = 2
  unit[:sequence_order] = 0
  unit[:category] = nil
  unit[:command_to_learn] = nil
  unit[:practice_hints] = nil
  unit[:quiz_options] = []
  unit[:quiz_question_text] = nil
  unit
end

# Parse quizzes and their questions into units
def parse_quiz_questions(seed_source)
  units = []

  # Helper: map quiz variable -> quiz title
  quiz_title_by_var = {}
  [
    'Quiz.find_or_create_by!',
    'Quiz.create!'
  ].each do |anchor|
    extract_call_args(seed_source, anchor).each do |args_str, _end_idx|
      # Try to find preceding variable assignment for this call
      # Look back up to 100 chars before anchor for 'var = Quiz...'
      # Since extract_call_args doesn't return positions, we skip capturing var here.
      # We'll resolve quiz title per question via 'quiz: var' and ignore title if unknown.
      title = args_str[/\btitle:\s*"([^"]*)"/, 1] || args_str[/\btitle:\s*'([^']*)'/, 1]
      # Best effort only; actual binding per question done from 'quiz:' in question args
    end
  end

  # Process QuizQuestion calls with block (find_or_create_by!/create!)
  ['QuizQuestion.find_or_create_by!', 'QuizQuestion.create!'].each do |anchor|
    extract_blocks_with_args(seed_source, anchor).each do |args_str, block_str, _var|
      # Single question via args hash
      if args_str.strip.start_with?('[')
        # Array of hashes in args not expected with a block, ignore here
      else
        q = parse_question_hash(args_str)
        enrich_question_from_block!(q, block_str)
        units << unit_from_question(q) if q
      end
    end
  end

  # Process QuizQuestion.create!/find_or_create_by! calls without block (array or hash args)
  [
    'QuizQuestion.create!',
    'QuizQuestion.find_or_create_by!'
  ].each do |anchor|
    extract_call_args(seed_source, anchor).each do |args_str, _end_idx|
      next if args_str.include?(' do |') # skip ones handled by block extractor
      if args_str.strip.start_with?('[')
        # Array of question hashes
        parse_question_array(args_str).each { |q| units << unit_from_question(q) }
      else
        q = parse_question_hash(args_str)
        units << unit_from_question(q) if q
      end
    end
  end

  units = units.compact
  # Drop any units that still contain Ruby interpolation placeholders
  units.reject do |u|
    contains_interpolation?(u[:title]) ||
      contains_interpolation?(u[:concept_explanation]) ||
      contains_interpolation?(u[:quiz_question_text]) ||
      contains_interpolation?(u[:sa_question]) ||
      contains_interpolation?(u[:sa_answer])
  end
end

def unit_from_question(q)
  q
end

def contains_interpolation?(s)
  s.is_a?(String) && s.include?('#{')
end

def parse_question_array(array_str)
  items = []
  # Extract each top-level { ... } object in the array
  i = array_str.index('[') + 1
  depth = 0
  start = nil
  while i < array_str.length
    ch = array_str[i]
    if ch == '{'
      depth += 1
      start = i if depth == 1
    elsif ch == '}'
      depth -= 1
      if depth == 0 && start
        obj = array_str[start..i]
        items << parse_question_hash(obj)
        start = nil
      end
    end
    i += 1
  end
  items.compact
end

def parse_question_hash(hash_str)
  return nil unless hash_str
  quiz_var = hash_str[/\bquiz:\s*(\w+)/, 1]
  question_text = hash_str[/\bquestion_text:\s*"([^"]*)"/, 1] || hash_str[/\bquestion_text:\s*'([^']*)'/, 1]
  question_text ||= hash_str[/\bquestion:\s*"([^"]*)"/, 1] || hash_str[/\bquestion:\s*'([^']*)'/, 1]
  qtype = hash_str[/\bquestion_type:\s*"([^"]*)"/, 1] || hash_str[/\bquestion_type:\s*'([^']*)'/, 1]
  explanation = hash_str[/\bexplanation:\s*"([^"]*)"/m, 1] || hash_str[/\bexplanation:\s*'([^']*)'/m, 1]
  topic = hash_str[/\btopic:\s*"([^"]*)"/, 1] || hash_str[/\btopic:\s*'([^']*)'/, 1]
  difficulty_level = hash_str[/\bdifficulty_level:\s*"([^"]*)"/, 1] || hash_str[/\bdifficulty_level:\s*'([^']*)'/, 1]
  diff_num = hash_str[/\bdifficulty:\s*([-\d\.]+)/, 1]
  options = []
  correct_idx = nil
  # Parse options array
  if (m = hash_str.match(/\boptions:\s*\[(.*?)\]/m))
    inner = m[1]
    inner.scan(/\{\s*text:\s*"([^"]*)"\s*,\s*correct:\s*(true|false)\s*\}|\{\s*text:\s*'([^']*)'\s*,\s*correct:\s*(true|false)\s*\}/).each do |a|
      text = a[0] || a[2]
      corr = a[1] || a[3]
      options << text
      correct_idx = options.length - 1 if corr == 'true'
    end
  end
  correct_answer = hash_str[/\bcorrect_answer:\s*"([^"]*)"/, 1] || hash_str[/\bcorrect_answer:\s*'([^']*)'/, 1]

  # Map numeric difficulty to easy/medium/hard if string not provided
  diff = if difficulty_level
           difficulty_level.downcase
         elsif diff_num
           v = diff_num.to_f
           if v < -0.1
             'easy'
           elsif v < 0.5
             'medium'
           else
             'hard'
           end
         else
           'medium'
         end

  {
    title: (topic && !topic.empty?) ? "#{topic} — Practice" : (question_text || 'Practice Question'),
    concept_explanation: explanation,
    command_to_learn: nil,
    practice_hints: [
      'Re-read the question carefully.',
      'Recall the relevant formula or rule.',
      'Review the explanation once you answer.'
    ],
    concept_tags: topic ? [topic] : [],
    difficulty: diff,
    estimated_minutes: 2,
    sequence_order: 0,
    category: nil,
    quiz_question_text: (qtype == 'mcq') ? question_text : nil,
    quiz_options: (qtype == 'mcq') ? options : [],
    quiz_correct_index: (qtype == 'mcq') ? (correct_idx || 0) : nil,
    quiz_explanation: explanation,
    sa_question: (qtype != 'mcq') ? question_text : nil,
    sa_answer: (qtype != 'mcq') ? (correct_answer || '') : nil
  }
end

def enrich_question_from_block!(q, block_str)
  return unless q && block_str
  # Override type if set in block
  if (m = block_str.match(/question_type\s*=\s*'([^']*)'|question_type\s*=\s*"([^"]*)"/))
    t = m[1] || m[2]
    if t == 'mcq'
      q[:sa_question] = nil
      q[:sa_answer] = nil
    else
      q[:sa_question] ||= q[:quiz_question_text]
      q[:quiz_question_text] = nil
      q[:quiz_options] = []
      q[:quiz_correct_index] = nil
    end
  end
  # Explanation
  if (m = block_str.match(/explanation\s*=\s*"([^"]*)"/m) || block_str.match(/explanation\s*=\s*'([^']*)'/m))
    q[:quiz_explanation] ||= m[1]
    q[:concept_explanation] ||= m[1]
  end
  # Options in block
  if (m = block_str.match(/options\s*=\s*\[(.*?)\]/m))
    inner = m[1]
    opts = []
    corr_idx = nil
    inner.scan(/\{\s*text:\s*"([^"]*)"\s*,\s*correct:\s*(true|false)\s*\}|\{\s*text:\s*'([^']*)'\s*,\s*correct:\s*(true|false)\s*\}/).each do |a|
      text = a[0] || a[2]
      corr = a[1] || a[3]
      opts << text
      corr_idx = opts.length - 1 if corr == 'true'
    end
    unless opts.empty?
      q[:quiz_question_text] ||= q[:sa_question]
      q[:sa_question] = nil
      q[:sa_answer] = nil
      q[:quiz_options] = opts
      q[:quiz_correct_index] = corr_idx || 0
    end
  end
  # Correct answer in block (for non-mcq)
  if (m = block_str.match(/correct_answer\s*=\s*"([^"]*)"/) || block_str.match(/correct_answer\s*=\s*'([^']*)'/))
    q[:sa_answer] ||= m[1]
  end
  # Topic
  if (m = block_str.match(/topic\s*=\s*"([^"]*)"/) || block_str.match(/topic\s*=\s*'([^']*)'/))
    topic = m[1]
    q[:concept_tags] = [topic]
    q[:title] = "#{topic} — Practice"
  end
end

# Extract call arguments for a given anchor (e.g., 'QuizQuestion.create!')
def extract_call_args(src, anchor)
  results = []
  pos = 0
  while (s = src.index(anchor, pos))
    i = s + anchor.length
    # skip whitespace
    i += 1 while i < src.length && src[i] =~ /\s/
    unless src[i] == '('
      pos = s + anchor.length
      next
    end
    depth = 1
    i += 1
    args_start = i
    while i < src.length
      if src[i] == '<' && src[i, 3] == '<<~'
        token_m = src[i..(i + 50)].match(/<<~(\w+)/)
        if token_m
          token = token_m[1]
          i = src.index("\n", i) || i
          i += 1
          term_rx = /^\s*#{Regexp.escape(token)}\s*$/
          while i < src.length
            nl = src.index("\n", i) || src.length
            line = src[i...nl]
            if line =~ term_rx
              i = nl + 1
              break
            else
              i = nl + 1
            end
          end
          next
        end
      end
      case src[i]
      when '(' then depth += 1
      when ')' then depth -= 1
      end
      i += 1
      if depth == 0
        args_str = src[args_start...(i - 1)]
        results << [args_str, i]
        break
      end
    end
    pos = i
  end
  results
end

# Extract args and block for calls like: Anchor(...) do |var| ... end
def extract_blocks_with_args(src, anchor)
  results = []
  pos = 0
  while (s = src.index(anchor, pos))
    # Get args first
    args_list = extract_call_args(src, anchor)
    # Find the one whose end index is just before the next ' do |'
    # Simplify: find next 'do |' after s
    do_pos = src.index(' do |', s)
    break unless do_pos
    # Get args by taking the last args tuple whose end <= do_pos
    args_str = nil
    args_list.each do |a_str, end_i|
      if end_i <= do_pos
        args_str = a_str
      end
    end
    # Now capture the block
    var_match = src[do_pos..(do_pos + 50)].match(/do \|([a-zA-Z_][a-zA-Z0-9_]*)\|/)
    var = var_match ? var_match[1] : 'v'
    i = do_pos
    depth = 1
    block_end = nil
    while i < src.length
      if src[i] == '<' && src[i, 3] == '<<~'
        token_m = src[i..(i + 50)].match(/<<~(\w+)/)
        if token_m
          token = token_m[1]
          i = src.index("\n", i) || i
          i += 1
          term_rx = /^\s*#{Regexp.escape(token)}\s*$/
          while i < src.length
            nl = src.index("\n", i) || src.length
            line = src[i...nl]
            if line =~ term_rx
              i = nl + 1
              break
            else
              i = nl + 1
            end
          end
          next
        end
      end
      if src[i, 4] == ' do '
        depth += 1
      elsif src[i, 3] == 'end'
        depth -= 1
        if depth == 0
          block_end = i + 3
          break
        end
      end
      i += 1
    end
    break unless block_end
    block_str = src[(do_pos + 1)...(block_end - 3)]
    results << [args_str || '', block_str, var]
    pos = block_end + 1
  end
  results
end

def derive_module_slug(file_basename, units)
  # Prefer category from units if present
  cat = units.map { |u| u[:category] }.compact.first
  return cat unless cat.nil? || cat.empty?
  # Derive from file name: e.g. docker_containers_units -> docker-containers
  name = file_basename.sub(/_units$/, '').sub(/_course$/, '')
  name.tr('_', '-').downcase
end

def sanitize_array_literal(arr)
  return '[]' if arr.nil? || arr.empty?
  '[' + arr.map { |s| s.to_s.gsub("'", %q(\')) }.map { |s| "'#{s}'" }.join(', ') + ']'
end

def build_markdown(unit)
  title = unit[:title] || 'Microlesson'
  md = []
  md << "# #{title} 🚀"
  if unit[:concept_explanation] && !unit[:concept_explanation].strip.empty?
    md << unit[:concept_explanation].strip
  else
    md << "## What is this?\nA concise explanation of the concept."
  end
  if unit[:command_to_learn]
    md << "## Syntax/Command"
    md << "```bash\n#{unit[:command_to_learn]}\n```"
  end
  example = (unit[:command_variations] || [])[0]
  if example
    md << "## Example"
    md << "```bash\n#{example}\n```"
  end
  key_points = unit[:practice_hints]
  if key_points && !key_points.empty?
    md << "## Key Points"
    key_points.first(3).each { |kp| md << "- #{kp}" }
  elsif unit[:concept_tags] && !unit[:concept_tags].empty?
    md << "## Key Points"
    unit[:concept_tags].first(3).each { |kp| md << "- #{kp}" }
  end
  md.join("\n\n")
end

def generate_microlesson_file(seed_path, units)
  basename = File.basename(seed_path, '.rb')
  rel_seed = seed_path.sub(SEEDS_DIR + '/', '')
  module_slug = MODULE_SLUG_OVERRIDES[rel_seed]
  module_slug ||= derive_module_slug(basename, units)
  out_name = "#{basename}_microlessons.rb"
  out_path = File.join(OUTPUT_DIR, out_name)

  lines = []
  human_name = module_slug.tr('-', ' ').split.map(&:capitalize).join(' ')
  lines << "# AUTO-GENERATED from #{File.basename(seed_path)}"
  lines << "puts \"Creating Microlessons for #{human_name}...\""
  lines << ""
  lines << "module_var = CourseModule.find_by(slug: '#{module_slug}')"
  lines << ""

  units.sort_by { |u| u[:sequence_order] }.each_with_index do |u, idx|
    seq = idx + 1
    title = (u[:title] || "Lesson #{seq}").gsub('"', '\\"')
    difficulty = (u[:difficulty] || 'easy').downcase
    difficulty = 'easy' unless %w[easy medium hard].include?(difficulty)
    key_concepts = sanitize_array_literal(u[:concept_tags] || [])
    content_md = build_markdown(u)
    lines << "# === MICROLESSON #{seq}: #{title} ==="
    lines << "lesson_#{seq} = MicroLesson.create!("
    lines << "  course_module: module_var,"
    lines << "  title: '#{title.gsub("'", %q(\\'))}',"
    lines << "  content: <<~MARKDOWN,"
    lines << content_md
    lines << "  MARKDOWN"
    lines << "  sequence_order: #{seq},"
    lines << "  estimated_minutes: 2,"
    lines << "  difficulty: '#{difficulty}',"
    lines << "  key_concepts: #{key_concepts},"
    lines << "  prerequisite_ids: []"
    lines << ")"
    lines << ""

    # Terminal exercise
    if u[:command_to_learn]
      hints = u[:practice_hints] && !u[:practice_hints].empty? ? u[:practice_hints].first(3) : [
        'Recall the main command.',
        'Check required flags or arguments.',
        "Use: #{u[:command_to_learn]}"
      ]
      hints_literal = sanitize_array_literal(hints)
      desc = u[:problem] || u[:scenario] || "Practice the command: #{u[:command_to_learn]}"
      lines << "# Exercise #{seq}.1: Terminal"
      lines << "Exercise.create!("
      lines << "  micro_lesson: lesson_#{seq},"
      lines << "  exercise_type: 'terminal',"
      lines << "  sequence_order: 1,"
      lines << "  exercise_data: {"
      lines << "    command: '#{u[:command_to_learn].gsub("'", %q(\\'))}',"
      lines << "    description: '#{desc.gsub("'", %q(\\'))}',"
      lines << "    difficulty: '#{difficulty}',"
      lines << "    hints: #{hints_literal}"
      lines << "  }"
      lines << ")"
      lines << ""
    end

    # MCQ exercise
    if u[:quiz_question_text] && u[:quiz_options] && !u[:quiz_options].empty?
      options_literal = sanitize_array_literal(u[:quiz_options])
      correct_idx = u[:quiz_correct_index] || 0
      explanation = u[:quiz_explanation] || 'Review the concept explanation above.'
      lines << "# Exercise #{seq}.2: MCQ"
      lines << "Exercise.create!("
      lines << "  micro_lesson: lesson_#{seq},"
      lines << "  exercise_type: 'mcq',"
      lines << "  sequence_order: 2,"
      lines << "  exercise_data: {"
      lines << "    question: '#{u[:quiz_question_text].gsub("'", %q(\\'))}',"
      lines << "    options: #{options_literal},"
      lines << "    correct_answer: #{correct_idx},"
      lines << "    explanation: '#{explanation.gsub("'", %q(\\'))}',"
      lines << "    difficulty: '#{difficulty}'"
      lines << "  }"
      lines << ")"
      lines << ""
    elsif u[:sa_question]
      # Short answer/numerical exercise
      hints = u[:practice_hints] && !u[:practice_hints].empty? ? u[:practice_hints].first(3) : [
        'Identify the formula or rule needed.',
        'Work through the steps carefully.',
        'Double-check units and simplify.'
      ]
      hints_literal = sanitize_array_literal(hints)
      explanation = u[:quiz_explanation] || u[:concept_explanation] || ''
      lines << "# Exercise #{seq}.2: Short Answer"
      lines << "Exercise.create!("
      lines << "  micro_lesson: lesson_#{seq},"
      lines << "  exercise_type: 'short_answer',"
      lines << "  sequence_order: 2,"
      lines << "  exercise_data: {"
      lines << "    question: '#{u[:sa_question].gsub("'", %q(\\'))}',"
      lines << "    answer: '#{(u[:sa_answer] || '').gsub("'", %q(\\'))}',"
      lines << "    explanation: '#{explanation.gsub("'", %q(\\'))}',"
      lines << "    difficulty: '#{difficulty}',"
      lines << "    hints: #{hints_literal}"
      lines << "  }"
      lines << ")"
      lines << ""
    end
  end

  lines << "puts \"\u2713 Created #{units.length} microlessons for #{human_name}\""
  lines << ""

  File.write(out_path, lines.join("\n"))
  out_path
end

def execute_prompt(prompt_path)
  rel_seeds = extract_seed_files_from_prompt(prompt_path)
  return { generated: [], missing: [], errors: [] } if rel_seeds.empty?

  generated = []
  missing = []
  errors = []

  rel_seeds.each do |rel|
    actual_rel = FILENAME_ALIASES.fetch(rel, rel)
    seed_path = File.join(SEEDS_DIR, actual_rel)
    unless File.exist?(seed_path)
      missing << rel
      next
    end
    begin
      src = File.read(seed_path, encoding: 'UTF-8')
      units = parse_interactive_units(src)
      if units.empty?
        errors << "No InteractiveLearningUnit blocks found in #{actual_rel}"
        next
      end
      out = generate_microlesson_file(seed_path, units)
      generated << { seed: actual_rel, out: out, count: units.length }
    rescue => e
      errors << "Error processing #{actual_rel}: #{e.class}: #{e.message}"
    end
  end

  { generated: generated, missing: missing, errors: errors }
end

def main
  prompt_files = list_prompt_files
  if prompt_files.empty?
  puts "No prompt files found under #{PROMPTS_DIR}"
    exit 0
  end
  grand_total = 0
  summary = []
  prompt_files.each do |pp|
    result = execute_prompt(pp)
    next if result[:generated].empty? && result[:missing].empty? && result[:errors].empty?
    result[:generated].each do |g|
      grand_total += g[:count]
      summary << "Generated: #{g[:out]} (from #{g[:seed]}) – #{g[:count]} lessons"
    end
    result[:missing].each do |m|
      summary << "Missing seed file referenced by #{pp.sub(BACKEND_DIR + '/', '')}: #{m}"
    end
    result[:errors].each do |err|
      summary << "Error: #{err}"
    end
  end

  puts "\n=== Generation Summary ==="
  puts summary.join("\n")
  puts "\nTotal microlessons parsed: #{grand_total}"
  puts "Output directory: #{OUTPUT_DIR}"
end

main if __FILE__ == $0
