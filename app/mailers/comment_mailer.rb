class CommentMailer < ActionMailer::Base
  def new_comment_email(comment)
    commenter = comment.user
    submitter = comment.submission.user

    if commenter != submitter
      mail(to: submitter.email, subject: "blah.")
    end
  end
end
