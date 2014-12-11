class LessonsController < ApplicationController
  def index
    if params[:query]
      @lessons = Lesson.search(params[:query])
    else
      @lessons = Lesson.order(:position)
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
