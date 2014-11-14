class CommentMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)

  def subject(comment_count, lesson)
    if comment_count == 1
      "There is 1 new comment on your #{lesson.title} submission."
    else
      "There are #{comment_count} new comments on your #{lesson.title} submission."
    end
  end

  def new_comments(submission, comments)
    @submission = submission
    @comments = comments

    mail(
      to: @submission.user.email,
      subject: subject(comments.length, submission.lesson))
  end
end
