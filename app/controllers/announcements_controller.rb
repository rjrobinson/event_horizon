class AnnouncementsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, except: [:index]

  def index

    @team = Team.find(params[:team_id])
    @announcement = Announcement.new
  end

  def create
    @team = Team.find(params[:team_id])
    @announcement = @team.announcements.build(announcement_params)

    if @announcement.save
      flash[:info] = "Added announcement."
      redirect_to team_assignments_path(@team)
    else
      flash[:alert] = "Failed to add assignment."
      render :index
    end
  end

  def show
    @announcement = Announcement.find(params[:id])
  end

  private

  def announcement_params
    params.require(:announcement).permit(:title, :description)
  end
end
