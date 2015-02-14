class QuestionCommentsController < ApplicationController
  def create
    @question = Question.find(params[:question_id]).decorate
    @comment = @question.question_comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to question_path(@question), info: "Comment saved."
    else
      flash[:alert] = "Failed to save comment"
      redirect_to question_path(@question)
    end
  end

  private

  def comment_params
    params.require(:question_comment).permit(:body)
  end
end
