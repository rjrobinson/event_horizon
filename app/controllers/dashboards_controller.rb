class DashboardsController < ApplicationController
  def show
    @upcoming_assignments = current_user.assignments.order(due_on: :asc)
  end
end