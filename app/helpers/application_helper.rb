module ApplicationHelper
  def format_datetime(time)
    time.strftime("%B %e, %Y at %l:%M:%S %p")
  end

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
