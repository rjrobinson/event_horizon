class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @upcoming_assignments = current_user.assignments.order(due_on: :asc)
    @announcements = current_user.announcements.order(created_at: :desc).limit(5)
    @latest_announcements = current_user.latest_announcements(5)
    @teams = current_user.teams
  end
end
