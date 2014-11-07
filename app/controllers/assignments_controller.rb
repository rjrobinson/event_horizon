class AssignmentsController < ApplicationController
  before_action :authorize_admin!

  def show
    @assignment = Assignment.find(params[:id])
  end
end
