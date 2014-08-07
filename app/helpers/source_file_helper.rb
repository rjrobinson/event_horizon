module SourceFileHelper
  def render_source_file(file)
    CodeRenderer.new(file.body, "ruby", []).to_html.html_safe
  end
end
