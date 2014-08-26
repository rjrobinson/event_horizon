class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @submission = Submission.find(params[:submission_id])
    if @submission.user != current_user && !current_user.admin?
      not_found
    end

    @comment = @submission.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html do
          flash[:info] = "Comment saved."
          redirect_to @submission
        end

        format.json do
          render :show
        end
      else
        format.html { render "submissions/show" }
        format.json do
          render json: @comment.errors, status: :unprocessable_entity
        end
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :line_number, :source_file_id)
  end
end
