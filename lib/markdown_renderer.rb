require "code_renderer"

class MarkdownRenderer < Redcarpet::Render::HTML
  def block_code(code, language)
    CodeRenderer.render(code, language)
  end
end
