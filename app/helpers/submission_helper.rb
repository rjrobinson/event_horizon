module SubmissionHelper
  def render_submission(submission)
    if !submission.files.empty?
      CodeRenderer.new(submission.files.first.body, "ruby", submission.inline_comments).
        to_html.html_safe
    end
  end
end
