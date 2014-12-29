class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, except: [:show]

  def edit
    @team = Team.find(params[:id])
    @users = User.all
    @team_membership = TeamMembership.new
  end

  def update
    @team = Team.find(params[:id])
    @team.team_memberships.destroy_all
    @team.users << User.find(params[:user_ids])
    redirect_to @team, notice: "#{@team.name.capitalize} was successfully updated."
  end

  def index
    @teams = Team.order(name: :asc)
  end

  def show
    @team = Team.find(params[:id])
  end
end
