require "rails_helper"

describe TeamsController do
  describe "GET index" do
    it "prevents non-admin users from viewing list of teams" do
      user = FactoryGirl.create(:user)
      session[:user_id] = user.id

      expect { get :index }.to raise_error(ActionController::RoutingError)
    end
  end
end
