class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @submission = Submission.find(params[:submission_id])
    if @submission.user != current_user && !current_user.instructor?
      not_found
    end

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
    params.require(:comment).permit(:body, :line_number, :source_file_id)
  end
end
