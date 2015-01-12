class PerceptionProblemsController < ApplicationController
  def index
    @problems = PerceptionProblem.all
  end
end
