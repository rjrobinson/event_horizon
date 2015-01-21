class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    # refactor to create methods
    @upcoming_core_assignments = current_user.core_assignments
    @upcoming_noncore_assignments = current_user.non_core_assignments
    @announcements = current_user.announcements.order(created_at: :desc).limit(5)
    @latest_announcements = current_user.latest_announcements(5)
    @teams = current_user.teams
  end
end
