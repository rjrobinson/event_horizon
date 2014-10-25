class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, except: [:show]

  def index
    @teams = Team.order(name: :asc)
  end

  def show
    @team = Team.find(params[:id])
  end
end
