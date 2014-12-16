class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    @question.save

    flash[:info] = "Question saved."
    redirect_to question_path(@question)
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
