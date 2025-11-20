#!/usr/bin/env ruby
require 'fileutils'
require 'json'

BACKEND = File.expand_path('..', __dir__)
SEEDS_DIR = File.join(BACKEND, 'db', 'seeds', 'microlessons')
FRONTEND_DATA_DIR = File.join(File.expand_path('../..', BACKEND), 'frontend', 'src', 'data', 'microlessons')

FileUtils.mkdir_p(FRONTEND_DATA_DIR)

def read_file(path)
  File.read(path, encoding: 'UTF-8')
end

def extract_module_slug(src)
  m = src.match(/CourseModule\.find_by\(slug:\s*'([^']+)'\)/) || src.match(/CourseModule\.find_by\(slug:\s*"([^"]+)"\)/)
  m && m[1]
end

def extract_lessons(src)
  lessons = []
  pos = 0
  while (idx = src.index(/lesson_\d+\s*=\s*MicroLesson\.create!\(/, pos))
    # capture lesson variable name
    var = src[idx..(idx+30)].match(/(lesson_\d+)\s*=/)[1]
    # parse block parentheses
    i = src.index('(', idx) + 1
    depth = 1
    while i < src.length && depth > 0
      if src[i] == '('
        depth += 1
      elsif src[i] == ')'
        depth -= 1
      elsif src[i] == '<' && src[i,3] == '<<~'
        token_m = src[i..(i+50)].match(/<<~(\w+)/)
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
      i += 1
    end
    block = src[idx...i]
    title = block[/title:\s*"([^"]*)"/, 1] || block[/title:\s*'([^']*)'/, 1]
    seq = (block[/sequence_order:\s*(\d+)/, 1] || '0').to_i
    diff = block[/difficulty:\s*'([^']*)'/, 1] || block[/difficulty:\s*"([^"]*)"/, 1]
    # content heredoc
    content = nil
    if (cidx = block.index('content:'))
      tail = block[cidx..-1]
      if tail =~ /content:\s*<<~(\w+)/
        # cheap heredoc extraction: reuse same helper as parsing loop
        token = tail.match(/<<~(\w+)/)[1]
        start = tail.index("\n", tail.index('<<~')) + 1
        # find terminator line
        content_lines = []
        tail[start..-1].each_line do |ln|
          break if ln.strip == token
          content_lines << ln
        end
        content = content_lines.join
      else
        content = tail[/content:\s*"([^"]*)"/m, 1] || tail[/content:\s*'([^']*)'/m, 1]
      end
    end
    lessons << { var: var, title: title, sequence_order: seq, difficulty: diff, content: content, exercises: [] }
    pos = i
  end
  lessons
end

def extract_exercises(src)
  exs = []
  pos = 0
  while (idx = src.index(/Exercise\.create!\(/, pos))
    # parse call block
    i = src.index('(', idx) + 1
    depth = 1
    while i < src.length && depth > 0
      if src[i] == '('
        depth += 1
      elsif src[i] == ')'
        depth -= 1
      elsif src[i] == '<' && src[i,3] == '<<~'
        token_m = src[i..(i+50)].match(/<<~(\w+)/)
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
      i += 1
    end
    block = src[idx...i]
    lesson_ref = block[/micro_lesson:\s*(lesson_\d+)/, 1]
    etype = block[/exercise_type:\s*'([^']+)'/, 1] || block[/exercise_type:\s*"([^"]+)"/, 1]
    order = (block[/sequence_order:\s*(\d+)/, 1] || '1').to_i
    # sanitize public data
    data = {}
    # hints
    if (m = block.match(/hints:\s*\[(.*?)\]/m))
      arr = m[1].scan(/"([^"]*)"|'([^']*)'/).map { |a,b| a || b }
      data['hints'] = arr unless arr.empty?
    end
    case etype
    when 'mcq'
      q = block[/question:\s*"([^"]*)"/m, 1] || block[/question:\s*'([^']*)'/m, 1]
      opts = []
      if (m = block.match(/options:\s*\[(.*?)\]/m))
        opts = m[1].scan(/"([^"]*)"|'([^']*)'/).map { |a,b| a || b }
      end
      exp = block[/explanation:\s*"([^"]*)"/m, 1] || block[/explanation:\s*'([^']*)'/m, 1]
      data['question'] = q
      data['options'] = opts
      data['explanation'] = exp if exp
    when 'short_answer'
      q = block[/question:\s*"([^"]*)"/m, 1] || block[/question:\s*'([^']*)'/m, 1]
      data['question'] = q
    when 'terminal'
      cmd = block[/command:\s*"([^"]*)"/m, 1] || block[/command:\s*'([^']*)'/m, 1]
      desc = block[/description:\s*"([^"]*)"/m, 1] || block[/description:\s*'([^']*)'/m, 1]
      data['command'] = cmd if cmd
      data['description'] = desc if desc
    when 'sandbox'
      run = block[/run:\s*"([^"]*)"/m, 1] || block[/run:\s*'([^']*)'/m, 1]
      desc = block[/description:\s*"([^"]*)"/m, 1] || block[/description:\s*'([^']*)'/m, 1]
      data['run'] = run if run
      data['description'] = desc if desc
    when 'code'
      # files
      if (m = block.match(/files:\s*\[(.*?)\]/m))
        files = m[1].scan(/"([^"]*)"|'([^']*)'/).map { |a,b| a || b }
        data['files'] = files unless files.empty?
      end
      # starter_code heredoc(s)
      if (m = block.match(/starter_code:\s*<<~(\w+)/))
        token = m[1]
        start = block.index("\n", block.index('starter_code:')) + 1
        content_lines = []
        block[start..-1].each_line do |ln|
          break if ln.strip == token
          content_lines << ln
        end
        data['starter_code'] = content_lines.join
      end
    end
    exs << { lesson_ref: lesson_ref, exercise_type: etype, sequence_order: order, public_data: data }
    pos = i
  end
  exs
end

def build_bundle(path)
  src = read_file(path)
  slug = extract_module_slug(src) || File.basename(path, '.rb')
  lessons = extract_lessons(src)
  exs = extract_exercises(src)
  # attach exercises to lessons by var ref
  lessons.each do |l|
    l[:exercises] = exs.select { |e| e[:lesson_ref] == l[:var] }.sort_by { |e| e[:sequence_order] }
    l.delete(:var)
  end
  {
    module_slug: slug,
    lessons: lessons.sort_by { |l| l[:sequence_order] }
  }
end

bundles = []
Dir.glob(File.join(SEEDS_DIR, '*.rb')).each do |file|
  bundle = build_bundle(file)
  bundles << { module_slug: bundle[:module_slug], file: File.basename(file) }
  out_path = File.join(FRONTEND_DATA_DIR, "#{bundle[:module_slug]}.json")
  File.write(out_path, JSON.pretty_generate(bundle))
  puts "Exported #{bundle[:module_slug]} -> #{out_path}"
end

# Write an index file
index_path = File.join(FRONTEND_DATA_DIR, 'index.json')
File.write(index_path, JSON.pretty_generate({ modules: bundles }))
puts "\nWrote index: #{index_path}"

