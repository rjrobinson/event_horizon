require "markdown_renderer"

class CodeRenderer
  attr_reader :source, :filename, :language, :comments

  def initialize(source, filename, language, comments = [])
    @source = source
    @filename = filename
    @language = language
    @comments = comments
  end

  def to_html
    "<table class=\"code-block highlight\">" +
      "<caption class=\"code-filename\">#{filename}</caption>" +
      "<tbody>" +
      html_code_with_comments +
      "</tbody></table>"
  end

  private

  def html_code_with_comments
    lines_with_comments.join("\n")
  end

  def lines_with_comments
    sorted_comments = inline_comments.sort_by do |comment|
      -comment.line_number
    end

    html_lines = lines

    sorted_comments.each do |comment|
      html_lines.insert(comment.line_number, format_comment(comment))
    end

    html_lines
  end

  def format_comment(comment)
    "<tr class=\"code-comment-inline\"><td colspan=\"2\"><div class=\"code-comment-header\"><span class=\"code-username\">#{comment.user.username}</span> commented on <span class=\"code-timestamp\">#{comment.created_at}</span></div><div class=\"code-comment-body\">#{comment.body}</div></td></tr>"
  end

  def inline_comments
    comments.select { |comment| comment.line_number <= line_count }
  end

  def line_count
    lines.length
  end

  def lines
    if language == "no-highlight"
      unnumbered_lines
    else
      numbered_lines
    end
  end

  def unnumbered_lines
    html_code.split("\n")
  end

  def numbered_lines
    unnumbered_lines.each_with_index.map do |line, index|
      line_no = index + 1
      "<tr class=\"code-line\" data-line-no=\"#{line_no}\"><td class=\"code-line-no\">#{line_no}</td><td class=\"code-line-body\">#{line}</td></tr>"
    end
  end

  def html_code
    @html_code ||= formatter.format(lexer.lex(source)).
      gsub("<pre><code class=\"highlight\">", "").
      gsub("</code></pre>", "")
  end

  def lexer
    @lexer ||= Rouge::Lexer.find_fancy(language, source) || Rouge::Lexers::PlainText
  end

  def formatter
    @formatter ||= Rouge::Formatters::HTML.new
  end

  def markdown_renderer
    @markdown_renderer ||= Redcarpet::Markdown.new(
      MarkdownRenderer,
      fenced_code_blocks: true)
  end

  def render_markdown(content)
    markdown_renderer.render(content)
  end
end
