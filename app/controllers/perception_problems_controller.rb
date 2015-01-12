class PerceptionProblemsController < ApplicationController
  def index
    @problems = PerceptionProblem.all
  end

  def show
    @problem = PerceptionProblem.find(params[:id])
    @answer = PerceptionProblemAnswer.new
  end

  def random
    @problem = PerceptionProblem.random
    @answer = PerceptionProblemAnswer.new
    render :show
  end
end
