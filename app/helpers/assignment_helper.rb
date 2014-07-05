module AssignmentHelper
  def render_markdown(content)
    renderer.render(content).html_safe
  end

  def renderer
    @renderer ||= Redcarpet::Markdown.new(
      MarkdownRenderer,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true)
  end
end
