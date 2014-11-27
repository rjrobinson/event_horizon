class AssignmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, except: [:index]

  def index
    @team = Team.find(params[:team_id])
    @assignment = Assignment.new
  end

  def create
    binding.pry
    @team = Team.find(params[:team_id])
    @assignment = @team.assignments.build(assignment_params)

    if @assignment.save
      flash[:info] = "Added assignment for #{@assignment.lesson.title}."
      redirect_to team_assignments_path(@team)
    else
      flash[:alert] = "Failed to add assignment."
      render :index
    end
  end

  def show
    @assignment = Assignment.find(params[:id])
  end

  private

  def assignment_params
    params.require(:assignment).permit(:lesson_id, :due_on, :required)
  end
end
