class CodeRenderer
  attr_reader :source, :language, :comments

  def initialize(source, language, comments = [])
    @source = source
    @language = language
    @comments = comments
  end

  def to_html
    "<div class='code-block'>" +
      "<pre><code class='highlight #{language}'>" +
      html_code_with_comments +
      "</code></pre></div>"
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
    "<div class='inline-comment comment'><div class='user'>" +
      "#{comment.user.username} commented" +
      "</div><div class='body'>#{comment.body}</div></div>"
  end

  def inline_comments
    comments.select { |comment| comment.line_number <= line_count }
  end

  def line_count
    lines.length
  end

  def lines
    html_code.split("\n")
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
end
