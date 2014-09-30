class LessonsController < ApplicationController
  def index
    if params[:query]
      @lessons = Lesson.search(params[:query])
    else
      @lessons = Lesson.order(:position)
    end
  end

  def show
    @lesson = Lesson.find_by!(slug: params[:slug])
  end
end
