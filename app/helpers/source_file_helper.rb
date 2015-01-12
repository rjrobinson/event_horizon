module SourceFileHelper
  def render_source_file(file)
    renderer = SourceRenderer.new(file)
    renderer.to_html.html_safe
  end
end
