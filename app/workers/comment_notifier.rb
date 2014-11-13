class CommentNotifier
  include Sidekiq::Worker

  def perform(comment_id)
    comment = Comment.find(comment_id)
    CommentMailer.new_comment(comment).deliver
  end
end
