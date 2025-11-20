module MarkdownHelper
  # Minimal Markdown renderer (headings, lists, code fences, inline code, links, bold/italic)
  # Safe by default: escapes HTML in content before injecting into tags.
  def render_markdown(text)
    return ''.html_safe unless text.present?

    require 'erb'
    esc = ERB::Util.method(:html_escape)

    lines = text.to_s.split("\n", -1)
    html = +""
    in_code = false
    code_lang = nil
    code_buf = []
    list_stack = [] # :ul or :ol

    # helpers
    slugify = ->(s) { s.downcase.gsub(/[^a-z0-9\s-]/, '').strip.gsub(/\s+/, '-')[0,80] }
    close_lists = -> {
      until list_stack.empty?
        tag = list_stack.pop
        html << "</#{tag}>\n"
      end
    }

    lines.each do |raw_line|
      line = raw_line.rstrip

      # Code fence start/end
      if line.strip.start_with?('```')
        if in_code
          # close fence
          html << "<pre><code#{code_lang ? " class=\"language-#{esc.call(code_lang)}\"" : ''}>#{esc.call(code_buf.join("\n"))}\n</code></pre>\n"
          code_buf.clear
          in_code = false
          code_lang = nil
        else
          close_lists.call
          in_code = true
          code_lang = line.strip[3..-1].to_s.strip.presence
        end
        next
      end

      if in_code
        code_buf << raw_line
        next
      end

      # Blank line: close lists and add spacing
      if line.strip.empty?
        close_lists.call
        html << "\n"
        next
      end

      # Headings
      if line =~ /^(#{'#'*6}|#{'#'*5}|#{'#'*4}|#{'#'*3}|#{'#'*2}|#)\s+(.*)$/
        close_lists.call
        level = $1.length
        text_part = $2
        id = slugify.call(text_part)
        html << "<h#{level} id=\"#{esc.call(id)}\">#{inline_format(text_part, esc)}</h#{level}>\n"
        next
      end

      # Ordered list item
      if line =~ /^\s*\d+\.\s+(.*)$/
        unless list_stack.last == :ol
          close_lists.call if list_stack.any? && list_stack.last != :ol
          html << "<ol>\n"
          list_stack << :ol
        end
        html << "  <li>#{inline_format($1, esc)}</li>\n"
        next
      end

      # Unordered list item
      if line =~ /^\s*[-*]\s+(.*)$/
        unless list_stack.last == :ul
          close_lists.call if list_stack.any? && list_stack.last != :ul
          html << "<ul>\n"
          list_stack << :ul
        end
        html << "  <li>#{inline_format($1, esc)}</li>\n"
        next
      end

      # Paragraph
      close_lists.call if list_stack.any?
      html << "<p>#{inline_format(line, esc)}</p>\n"
    end

    # close any open structures
    if in_code
      html << "<pre><code>#{esc.call(code_buf.join("\n"))}\n</code></pre>\n"
    end
    html << "</#{list_stack.pop}>\n" while list_stack.any?

    html.html_safe
  end

  private
  # Inline formatting: code, bold, italic, links. Content must be escaped first.
  def inline_format(text, esc)
    s = esc.call(text.to_s)
    # Links [text](url)
    s = s.gsub(/\[(.*?)\]\((https?:[^\)\s]+)\)/) { %Q{<a href="#{$2}" target="_blank" rel="noopener">#{$1}</a>} }
    # Bold **text**
    s = s.gsub(/\*\*(.+?)\*\*/) { "<strong>#{$1}</strong>" }
    # Italic *text*
    s = s.gsub(/(?<!\*)\*(?!\*)(.+?)(?<!\*)\*(?!\*)/) { "<em>#{$1}</em>" }
    # Inline code `code`
    s = s.gsub(/`([^`]+)`/) { "<code>#{$1}</code>" }
    s
  end
end

