class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, except: [:show]

  def edit
    @team = Team.find(params[:id])
    @users = User.all  # refactor to get proper users
  end

  def update
    @team = Team.find(params[:id])
    @team.users << User.find(params[:user_ids])
    redirect_to @team, notice: "Users successfully added to #{@team.name}."
  end

  def index
    @teams = Team.order(name: :asc)
  end

  def show
    @team = Team.find(params[:id])
  end
end
