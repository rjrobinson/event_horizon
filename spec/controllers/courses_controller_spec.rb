require "rails_helper"

describe CoursesController do
  let(:user) { FactoryGirl.create(:user) }

  describe "GET new" do
    it "prevents access for non-admin users" do
      session[:user_id] = user.id
      expect { get :new }.to raise_error(ActionController::RoutingError)
    end
  end

  describe "POST create" do
    it "prevents access for non-admin users" do
      session[:user_id] = user.id
      expect { post :create, course: { title: "foobar" } }.
        to raise_error(ActionController::RoutingError)
    end
  end
end
