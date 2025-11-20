#!/usr/bin/env ruby
require 'fileutils'

BACKEND = File.expand_path('..', __dir__)
MICRO_DIR = File.join(BACKEND, 'db', 'seeds', 'microlessons')

def docker_or_k8s_file?(path)
  base = File.basename(path)
  base.start_with?('docker_') || base.start_with?('kubectl_') || base.start_with?('kubernetes_')
end

def extract_terminal_blocks(src)
  blocks = []
  pos = 0
  while (start = src.index("Exercise.create!(", pos))
    i = src.index('(', start) + 1
    depth = 1
    while i < src.length && depth > 0
      if src[i] == '('
        depth += 1
      elsif src[i] == ')'
        depth -= 1
      elsif src[i] == '<' && src[i,3] == '<<~'
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
    if block =~ /exercise_type:\s*['"]terminal['"]/ 
      blocks << [start, block_end, block]
    end
    pos = block_end
  end
  blocks
end

def has_sandbox_after?(src, after_index, lesson_ref)
  window = src[after_index, 1000] || ''
  window.include?("exercise_type: 'sandbox'") && window.include?("micro_lesson: #{lesson_ref}")
end

def add_sandbox_after(src, block_end, lesson_ref, run_cmd)
  indent = ""
  insert = <<~RUBY

  # Sandbox: auto-added from terminal exercise
  Exercise.create!(
    micro_lesson: #{lesson_ref},
    exercise_type: 'sandbox',
    sequence_order: 99,
    exercise_data: {
      constraints: { cpus: 1, mem_mb: 256 },
      run: '#{run_cmd}',
      validation: { must_not_include: ['Error', 'panic:'] },
      timeout_sec: 60,
      require_pass: true,
      hints: ['Run under CPU pressure to surface leaks or races', 'Keep commands idempotent in CI']
    }
  )
  RUBY
  src.insert(block_end, insert)
  src
end

updated = []
Dir.glob(File.join(MICRO_DIR, '*.rb')).each do |file|
  next unless docker_or_k8s_file?(file)
  src = File.read(file, encoding: 'UTF-8')
  orig = src.dup
  blocks = extract_terminal_blocks(src)
  # Insert sandbox after each terminal if not present
  offset = 0
  blocks.each do |start, endi, block|
    # extract lesson ref and command
    lesson = block[/micro_lesson:\s*(lesson_\d+)/, 1]
    cmd = block[/command:\s*'([^']+)'/, 1] || block[/command:\s*"([^"]+)"/, 1]
    next unless lesson && cmd
    abs_end = endi + offset
    unless has_sandbox_after?(src, abs_end, lesson)
      src = add_sandbox_after(src, abs_end, lesson, cmd)
      offset += (src.length - orig.length - offset)
    end
  end
  if src != orig
    File.write(file, src)
    updated << file
  end
end

puts "Added sandbox exercises to #{updated.size} files."
updated.first(20).each { |f| puts "  - #{f.sub(BACKEND+'/', '')}" }

