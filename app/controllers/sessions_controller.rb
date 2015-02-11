class SessionsController < ApplicationController
  def new
    redirect_to "/auth/github"
  end

  def create
    identity = Identity.find_or_create_from_omniauth(auth_hash)
    user = identity.user

    if user.persisted? && user.belongs_to_org?(organization, omniauth_token)
      session[:user_id] = user.id
      flash[:success] = "Successfully signed in as #{user.username}."
    else
      error_message = "Unable to sign up."

      if user.email.nil?
        # This is a common issue with GitHub OAuth so include a custom message
        # if a user cannot sign up because their e-mail is missing.
        error_message += " No public e-mail associated with GitHub account."
      end

      flash[:alert] = error_message
    end

    redirect_to_back_or_root
  end

  def destroy
    session[:user_id] = nil
    flash[:info] = "Signed out successfully."
    redirect_to root_path
  end

  def failure
    flash[:alert] = "Unable to sign in."
    redirect_to_back_or_root
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end

  def omniauth_token
    auth_hash["credentials"]["token"]
  end

  def organization
    ENV["GITHUB_ORG"]
  end
end
