# Test UI Rendering of Enhanced Content

puts "=" * 80
puts "TESTING UI CONTENT RENDERING"
puts "=" * 80

# Test how the render_formatted_explanation method handles our Markdown content

class TestRenderer
  def self.render_formatted_explanation(text)
    return '' if text.blank?
    formatted = text.dup

    # Normalize inline numbered lists
    formatted.gsub!(/\s(\d+)[\.)]\s+/) { "\n#{$1}) " }

    # Section icons
    section_icons = {
      'Your Mission' => '🎯',
      'DCA Exam Tip' => '📝',
      'Why this matters' => '💎'
    }
    formatted.gsub!(/\*\*([^*]+?):\*\*/) do
      section_name = $1
      icon = section_icons[section_name] || '▸'
      "<span class='section-icon'>#{icon}</span><strong>#{section_name}:</strong>"
    end

    # Headings
    formatted.gsub!(/^###\s+(.+)$/i, '<h4 class="explanation-subhead">\1</h4>')
    formatted.gsub!(/^##\s+(.+)$/i, '<h3 class="explanation-head">\1</h3>')
    formatted.gsub!(/^#\s+(.+)$/i, '<h2 class="explanation-headline">\1</h2>')

    # Fenced code blocks
    formatted.gsub!(/```(\w+)?[ \t]*\n?([\s\S]*?)```/m) do
      lang = ($1 || '').strip
      code = ($2 || '').to_s.strip
      "<pre class='code-block'><code>#{code}</code></pre>"
    end

    # Bold and inline code
    formatted.gsub!(/\*\*(.+?)\*\*/, '<strong>\1</strong>')
    formatted.gsub!(/(?<!`)`([^\n`]+)`(?!`)/, '<code class="inline-code">\1</code>')

    # Lists
    formatted.gsub!(/^(\d+)[\.)]\s+(.+)$/, '<p class="explanation-point"><span class="point-index">\1)</span> \2</p>')
    formatted.gsub!(/^-\s+(.+)$/, '<p class="explanation-point">\1</p>')

    formatted
  end
end

# Test with sample from enhanced content
sample_text = <<~MD
**Dockerfile FROM and RUN Instructions** 🏗️

Every Dockerfile starts with `FROM` and typically uses `RUN` to execute commands. These are the foundation of custom image building.

### The FROM Instruction

**FROM** specifies the base image to build upon.

**Syntax:**
```dockerfile
FROM <image>[:<tag>] [AS <name>]
```

**Examples:**
```dockerfile
FROM ubuntu:22.04
FROM python:3.11-alpine
```

**Key Points:**
- Must be the **first instruction** (except ARG)
- Sets the base layer for your image
MD

puts "\n1. Testing Markdown to HTML Rendering"
puts "-" * 80

rendered = TestRenderer.render_formatted_explanation(sample_text)

puts "\nOriginal Markdown (first 300 chars):"
puts sample_text[0..300]

puts "\nRendered HTML (first 500 chars):"
puts rendered[0..500]

puts "\nChecking for proper rendering:"
puts "  ✅ Headings: #{rendered.include?('<h4') ? 'Present' : '❌ Missing'}"
puts "  ✅ Bold text: #{rendered.include?('<strong>') ? 'Present' : '❌ Missing'}"
puts "  ✅ Inline code: #{rendered.include?('<code class="inline-code">') ? 'Present' : '❌ Missing'}"
puts "  ✅ Code blocks: #{rendered.include?('<pre class=') ? 'Present' : '❌ Missing'}"
puts "  ✅ Lists: #{rendered.include?('explanation-point') ? 'Present' : '❌ Missing'}"

puts "\n" + "=" * 80
puts "2. Testing with Real Database Content"
puts "-" * 80

# Get a sample chapter
chapter = InteractiveLearningUnit.find_by(slug: "codesprout-dockerfile-from-run")

if chapter
  content = chapter.concept_explanation

  puts "Chapter: #{chapter.title}"
  puts "Content length: #{content.length} characters"
  puts ""

  # Sample first 500 chars
  puts "First 500 chars of stored content:"
  puts content[0..500]
  puts ""

  # Check markdown elements are present
  puts "Markdown elements in database:"
  puts "  Has ### headings: #{content.include?('###') ? '✅' : '❌'}"
  puts "  Has **bold**: #{content.include?('**') ? '✅' : '❌'}"
  puts "  Has `code`: #{content.include?('`') ? '✅' : '❌'}"
  puts "  Has ```blocks```: #{content.include?('```') ? '✅' : '❌'}"
  puts "  Has bullet lists: #{content.include?("\n- ") ? '✅' : '❌'}"

  # Render it
  rendered = TestRenderer.render_formatted_explanation(content)

  puts "\nRendered HTML elements:"
  puts "  Has <h4> headings: #{rendered.include?('<h4') ? '✅' : '❌'}"
  puts "  Has <strong>: #{rendered.include?('<strong>') ? '✅' : '❌'}"
  puts "  Has <code>: #{rendered.include?('<code') ? '✅' : '❌'}"
  puts "  Has <pre>: #{rendered.include?('<pre') ? '✅' : '❌'}"

  puts "\nSample rendered HTML (first 800 chars):"
  puts rendered[0..800]
else
  puts "❌ Chapter not found!"
end

puts "\n" + "=" * 80
puts "3. UI Component Test"
puts "-" * 80

# Check what gets displayed in the UI
micro = DockerContentLibrary.get_first_micro_for_chapter("codesprout-dockerfile-from-run")

if micro
  puts "✅ Micro lesson found!"
  puts "   ID: #{micro[:id]}"
  puts "   Title: #{micro[:content][:title]}"
  puts "   Has explanation: #{micro[:content][:explanation].present? ? 'Yes' : 'No'}"

  if micro[:content][:explanation].present?
    expl = micro[:content][:explanation]
    puts "   Explanation length: #{expl.length} chars"
    puts "   First 400 chars:"
    puts "   #{expl[0..400]}"
  end
else
  puts "❌ Micro lesson not found!"
end

puts "\n" + "=" * 80
puts "✅ UI RENDERING TEST COMPLETE"
puts "=" * 80
