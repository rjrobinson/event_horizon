class RatingsController < ApplicationController
  def create
    @lesson = Lesson.find_by!(slug: params[:lesson_slug])
    @rating = @lesson.ratings.build(rating_params)
    @rating.user = current_user

    if @rating.save
      flash[:success] = "Rating saved."
      redirect_to @lesson
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:clarity, :helpfulness, :comment)
  end
end
