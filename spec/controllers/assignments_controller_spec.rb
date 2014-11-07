require "rails_helper"

describe AssignmentsController do
  describe "GET show" do
    it "prevents non-admin users from viewing assignments" do
      user = FactoryGirl.create(:user)
      assignment = FactoryGirl.create(:assignment)

      session[:user_id] = user.id

      expect do
        get :show, id: assignment.id
      end.to raise_error(ActionController::RoutingError)
    end
  end
end
