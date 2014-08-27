class CommentMailer < ActionMailer::Base
  def new_comment_email(comment)
    email = comment.submission.user.email

    mail(to: email, subject: "blah.")
  end
end
