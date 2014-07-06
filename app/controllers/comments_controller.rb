class CommentsController < ApplicationController
  def create
    @submission = Submission.find(params[:submission_id])
    @comment = @submission.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:info] = "Comment saved."
      redirect_to @submission
    else
      render "submissions/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
