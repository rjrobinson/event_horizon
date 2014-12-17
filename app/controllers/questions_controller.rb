class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(create_params)
    @question.user = current_user
    @question.save

    if @question.save
      flash[:info] = "Question saved."
      redirect_to question_path(@question)
    else
      flash[:alert] = "Failed to save question."
      render :new
    end
  end

  def update
    question = Question.find(params[:id])
    question.update(update_params)

    flash[:info] = "Answer has been accepted."
    redirect_to question_path(question)
  end

  private

  def create_params
    params.require(:question).permit(:title, :body)
  end

  def update_params
    params.require(:question).permit(:accepted_answer_id)
  end
end
