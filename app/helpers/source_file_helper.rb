module SourceFileHelper
  def render_source_file(file)
    language = File.extname(file.filename)[1..-1]
    CodeRenderer.new(file.body, language, file.comments).to_html.html_safe
  end
end
