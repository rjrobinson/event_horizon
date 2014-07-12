class RatingsController < ApplicationController
  def create
    @assignment = Assignment.find_by!(slug: params[:assignment_slug])
    @rating = @assignment.ratings.build(rating_params)
    @rating.user = current_user

    if @rating.save
      flash[:success] = "Rating saved."
      redirect_to assignment_path(@assignment)
    else
      flash[:alert] = "Rating could not be saved."
      render "assignments/show"
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:helpfulness, :clarity, :comment)
  end
end
