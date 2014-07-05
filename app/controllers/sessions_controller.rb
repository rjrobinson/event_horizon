class SessionsController < ApplicationController
  def new
    redirect_to "/auth/github"
  end

  def create
    user = User.find_or_create_from_omniauth(auth_hash)
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:info] = "Signed out successfully."
    redirect_to root_path
  end

  def failure
    flash[:alert] = "Unable to sign in."
    redirect_to root_path
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end
end
