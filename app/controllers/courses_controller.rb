class CoursesController < ApplicationController
  before_action :authorize_admin!, except: [:index, :show]
  before_action :authenticate_user!

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
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
