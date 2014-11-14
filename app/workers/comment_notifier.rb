class CommentNotifier
  include Sidekiq::Worker

  def perform(comment_id)
    comment = Comment.find(comment_id)

    if comment.user_id != comment.submission.user_id
      CommentMailer.new_comments(comment.submission, [comment]).deliver
    end
  end
end
