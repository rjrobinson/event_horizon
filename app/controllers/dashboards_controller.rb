class DashboardsController < ApplicationController
  def show
    binding.pry
    @upcoming_assignments = current_user.assignments.order(due_on: :asc)
    @announcements = current_user.announcements.order(created_at: :desc)
  end
end
