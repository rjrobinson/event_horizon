module SubmissionHelper
  def render_code(code, language)
    CodeRenderer.render(code, language).html_safe
  end
end
