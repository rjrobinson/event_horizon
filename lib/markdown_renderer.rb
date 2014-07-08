require "code_renderer"

class MarkdownRenderer < Redcarpet::Render::HTML
  def block_code(code, language)
    CodeRenderer.new(code, language).to_html
  end
end
