class AnswerCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find(question_id)
    @answer = @question.answers.find(params[:answer_id])
    @comment = @answer.answer_comments.new(answer_params)
    @comment.user = current_user
    if @comment.save!
      redirect_to question_path(@question), info: "Comment saved."
    else
      redirect_to question_path(@question), alert: "Failed to save comment"
    end
  end

  def destroy
    comment = current_user.answer_comments.find(params[:id])
    comment.destroy
    redirect_to question_path(comment.answer.question),
      info: "Your comment has been deleted"
  end

  private

  def question_id
    params[:answer_comment][:question_id]
  end

  def answer_params
    params.require(:answer_comment).permit(:body)
  end
end
