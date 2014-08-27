class CommentMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)

  def new_comment(comment)
    @comment = comment
    @commenter = comment.user
    @submitter = comment.submission.user

    if @commenter != @submitter
      mail(
        to: @submitter.email,
        subject: "#{@commenter.username} commented on your submission.")
    end
  end
end
