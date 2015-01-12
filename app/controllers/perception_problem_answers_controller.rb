class PerceptionProblemAnswersController < ApplicationController
  before_action :authenticate_user!

  def show
    @answer = current_user.perception_problem_answers.find(params[:id])
  end

  def create
    @problem = PerceptionProblem.find(params[:perception_problem_id])
    @answer = @problem.answers.build(answer_params)
    @answer.user = current_user

    if @answer.save
      flash[:success] = "Answer submitted."
      redirect_to perception_problem_answer_path(@answer)
    else
      flash[:alert] = "Sorry, we couldn't save your answer at this time."
      render "perception_problems/show"
    end
  end

  private

  def answer_params
    params.require(:perception_problem_answer).permit(:perception_problem_option_id)
  end
end
