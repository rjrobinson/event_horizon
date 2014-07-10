require "rails_helper"

describe SubmissionsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:assignment) { FactoryGirl.create(:assignment) }

  describe "POST create" do
    context "as an authenticated user" do
      it "redirects after successful create" do
        session[:user_id] = user.id
        post :create, assignment_id: assignment.id,
                      submission: { body: "1 + 2 == 4" }

        expect(Submission.count).to eq(1)
        expect(response).to redirect_to(submission_path(Submission.first))
      end
    end

    context "as a guest" do
      it "redirects without saving" do
        post :create, assignment_id: assignment.id,
                      submission: { body: "1 + 2 == 4" }

        expect(Submission.count).to eq(0)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET show" do
    it "allows access to the submitting user" do
      submission = FactoryGirl.create(:submission_with_source, user: user)
      session[:user_id] = user.id

      get :show, id: submission.id
      expect(response).to be_success
    end

    it "allows access to instructors" do
      instructor = FactoryGirl.create(:instructor)
      session[:user_id] = instructor.id

      submission = FactoryGirl.create(:submission)

      get :show, id: submission.id
      expect(response).to be_success
    end

    it "avoids showing other user submissions" do
      other_user_submission = FactoryGirl.create(:submission_with_source)
      session[:user_id] = user.id

      expect { get :show, id: other_user_submission.id }.
        to raise_error(ActionController::RoutingError)
    end
  end
end
