class SessionsController < ApplicationController
  def new
    redirect_to "/auth/github"
  end

  def create
    user = User.find_or_create_from_omniauth(auth_hash)
    session[:user_id] = user.id
    redirect_to root_path
  end

  def failure
    redirect_to root_path, notice: "Unable to sign in."
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end
end
