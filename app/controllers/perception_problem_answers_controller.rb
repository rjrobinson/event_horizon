class PerceptionProblemAnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @perception_problem = PerceptionProblem.find(params[:perception_problem_id])
    @perception_problem_answer = @perception_problem.answers.build(answer_params)
    @perception_problem_answer.user = current_user

    if @perception_problem_answer.save
      flash[:success] = "Answer submitted."
      redirect_to perception_problem_path(@perception_problem)
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
