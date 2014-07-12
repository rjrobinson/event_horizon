class AssignmentsController < ApplicationController
  def index
    if params[:query]
      @assignments = Assignment.search(params[:query])
    else
      @assignments = Assignment.all
    end
  end

  def show
    @assignment = Assignment.find_by!(slug: params[:slug])
    @rating = Rating.new
  end
end
