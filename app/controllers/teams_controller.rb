class TeamsController < ApplicationController
  before_action :authenticate_user!

  def show
    @team = Team.find(params[:id])
  end
end
