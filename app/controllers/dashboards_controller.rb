class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @announcements = current_user.announcements.order(created_at: :desc).limit(5)
    @upcoming_assignments = current_user.assignments.order(due_on: :asc)
    @calendar_events = Calendar.events(current_user.calendars)
  end
end
