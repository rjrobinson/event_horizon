class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  protected

  include SessionHelper

  def authenticate_user!
    authenticate_via_headers || authenticate_via_session
  end

  def authorize_admin!
    if !user_signed_in? || !current_user.admin?
      not_found
    end
  end

  def not_found
    raise ActionController::RoutingError.new("Not Found")
  end

  def unauthorized!
    render status: :unauthorized
  end

  private

  def authenticate_via_headers
    authenticate_with_http_basic do |username, token|
      user = User.find_by(username: username)

      if !user.nil? && token == user.token
        set_current_user(user)
      else
        request_http_basic_authentication
      end
    end
  end

  def authenticate_via_session
    if !user_signed_in?
      flash[:info] = "You need to sign in before continuing."
      redirect_to root_path
    end
  end
end
