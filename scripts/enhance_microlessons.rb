#!/usr/bin/env ruby
require 'fileutils'

ROOT = File.expand_path('../..', __dir__)
MICRO_DIR = File.join(ROOT, 'db', 'seeds', 'microlessons')

def enhance_file(path)
  src = File.read(path)
  changed = false

  # Simple pass: walk each Exercise.create! block and insert missing gating/validation
  pos = 0
  out = ""
  while (start = src.index('Exercise.create!(', pos))
    out << src[pos...start]
    # find end of call by parenthesis matching
    i = src.index('(', start) + 1
    depth = 1
    while i < src.length && depth > 0
      if src[i] == '('
        depth += 1
      elsif src[i] == ')'
        depth -= 1
      elsif src[i] == '<' && src[i,3] == '<<~'
        # skip heredoc body
        m = src[i..(i+50)].match(/<<~(\w+)/)
        if m
          token = m[1]
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
      i += 1
    end
    block_end = i
    block = src[start...block_end]

    type = block[/exercise_type:\s*'([^']+)'/, 1] || block[/exercise_type:\s*"([^"]+)"/, 1]
    # Ensure require_pass present inside exercise_data
    if (edx = block.index('exercise_data: {'))
      # Insert require_pass if absent in next 400 chars
      unless block[edx, 500].to_s.include?('require_pass:')
        insert_at = edx + 'exercise_data: {'.length
        block.insert(insert_at, "\n    require_pass: true,")
        changed = true
      end
      # For terminal/sandbox: add validation and timeout_sec defaults if missing nearby
      if %w[terminal sandbox].include?(type)
        unless block[edx, 600].to_s.include?('validation:')
          insert_at = edx + 'exercise_data: {'.length
          block.insert(insert_at, "\n    validation: { must_not_include: ['Error', 'panic:'] },")
          changed = true
        end
        unless block[edx, 600].to_s.include?('timeout_sec:')
          insert_at = edx + 'exercise_data: {'.length
          block.insert(insert_at, "\n    timeout_sec: 60,")
          changed = true
        end
      end
    end

    out << block
    pos = block_end
  end
  out << src[pos..-1]

  if changed
    File.write(path, out)
    return true
  end
  false
end

updated = []
Dir.glob(File.join(MICRO_DIR, '*.rb')).each do |file|
  next unless File.file?(file)
  if enhance_file(file)
    updated << file
  end
end

puts "Enhanced #{updated.size} microlesson files."
updated.each { |f| puts "  - #{f.sub(ROOT+'/', '')}" }
