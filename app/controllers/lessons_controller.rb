class LessonsController < ApplicationController
  def index
    if user_signed_in?
      @lessons = Lesson.visible_for(current_user)
    else
      @lessons = Lesson.public
    end

    if params[:query]
      @lessons = @lessons.search(params[:query])
    else
      @lessons = @lessons.order(:position)
    end

    if params[:submittable] == "1"
      @lessons = @lessons.submittable
    end

    if params[:type]
      @lessons = @lessons.type(params[:type])
    end
  end

  def show
    @lesson = Lesson.find_by!(slug: params[:slug])
    @rating = @lesson.ratings.find_or_initialize_by(user: current_user)
  end
end
