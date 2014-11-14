class CommentNotifier
  include Sidekiq::Worker

  def perform(comment_id)
    comment = Comment.pending.find_by(id: comment_id)

    if !comment.nil?
      pending_comments = pending_comments_for(comment.submission)

      if pending_comments.any?
        deliver(comment.submission, pending_comments)
      end
    end
  end

  def pending_comments_for(submission)
    submission.comments.pending.where("user_id != ?", submission.user_id)
  end

  def deliver(submission, comments)
    CommentMailer.new_comments(submission, comments).deliver
    comments.update_all(delivered: true)
  end
end
