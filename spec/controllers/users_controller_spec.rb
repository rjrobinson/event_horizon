require "rails_helper"

describe UsersController do
  let(:user) { FactoryGirl.create(:user) }

  describe "GET show" do
    it "prevents access for non-admin users" do
      other_user = FactoryGirl.create(:user)

      session[:user_id] = user.id
      expect { get :show, id: other_user.id }.
        to raise_error(ActionController::RoutingError)
    end
  end

  describe "GET index" do
    it "prevents access for non-admin users" do
      session[:user_id] = user.id
      expect { get :index }.to raise_error(ActionController::RoutingError)
    end
  end
end
