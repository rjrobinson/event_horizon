module SubmissionHelper
  def render_submission(submission)
    CodeRenderer.new(submission.body, "ruby", submission.inline_comments).
      to_html.html_safe
  end
end
