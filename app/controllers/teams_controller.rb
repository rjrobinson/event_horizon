class TeamsController < ApplicationController
  before_action :authenticate_user!

  def index
    @teams = Team.order(name: :asc)
  end

  def show
    @team = Team.find(params[:id])
  end
end
