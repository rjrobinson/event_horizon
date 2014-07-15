class CoursesController < ApplicationController
  before_action :authorize_admin!, except: [:index, :show]
  before_action :authenticate_user!

  def index
    if current_user.admin?
      @courses = Course.all
    else
      @courses = current_user.courses
    end
  end

  def show
    if current_user.admin?
      @course = Course.find_by(id: params[:id])
    else
      @course = current_user.courses.find_by(id: params[:id])
    end

    @course || not_found
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.creator = current_user

    if @course.save
      flash[:success] = "New course created."
      redirect_to course_path(@course)
    else
      render :new
    end
  end

  private

  def course_params
    params.require(:course).permit(:title)
  end
end
