class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  include SessionHelper

  def authenticate_user!
    if !session[:user_id]
      flash[:info] = "You need to sign in before continuing."
      redirect_to root_path
    end
  end

  def not_found
    raise ActionController::RoutingError.new("Not Found")
  end
end
