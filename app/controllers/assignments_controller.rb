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

    if user_signed_in?
      @rating = current_user.ratings.
        find_or_initialize_by(assignment: @assignment)
    end
  end
end
