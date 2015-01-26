class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @upcoming_core_assignments = current_user.core_assignments
    @upcoming_noncore_assignments = current_user.non_core_assignments
    @latest_announcements = current_user.latest_announcements(5)
    @teams = current_user.teams
  end
end
