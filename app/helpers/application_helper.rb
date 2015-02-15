module ApplicationHelper
  def format_datetime(time)
    time.strftime("%B %e, %Y at %l:%M:%S %p")
  end

  def render_safe_markdown(content)
    Markdown.render_safe(content).html_safe
  end

  def render_markdown(content)
    Markdown.render(content).html_safe
  end
end
