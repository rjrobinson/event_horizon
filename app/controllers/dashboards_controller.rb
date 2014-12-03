class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @upcoming_assignments = current_user.assignments.order(due_on: :asc)
  end
end
