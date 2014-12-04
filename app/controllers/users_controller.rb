class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find_by!(username: params[:username])
    @count = Comment.where(user_id: @user.id).count
  end
end
