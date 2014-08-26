require "rails_helper"

describe SubmissionsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:challenge) { FactoryGirl.create(:challenge) }

  context "api" do
    describe "POST create" do
      context "with valid authentication" do
        it "successfully stores the submission" do
          set_auth_headers_for(user)
          post :create, challenge_slug: challenge.slug,
                        submission: { body: "1 + 2 == 4" },
                        format: :json

          expect(Submission.count).to eq(1)
          expect(response).to be_success
        end
      end

      context "with no authentication" do
        it "fails to save the submission" do
          post :create, challenge_slug: challenge.slug,
                        submission: { body: "1 + 2 == 4" },
                        format: :json

          expect(Submission.count).to eq(0)
        end
      end
    end
  end

  context "web request" do
    describe "POST create" do
      context "as an authenticated user" do
        it "redirects after successful create" do
          session[:user_id] = user.id
          post :create, challenge_slug: challenge.slug,
                        submission: { body: "1 + 2 == 4" }

          expect(Submission.count).to eq(1)
          expect(response).to redirect_to(submission_path(Submission.first))
        end
      end

      context "as a guest" do
        it "redirects without saving" do
          post :create, challenge_slug: challenge.slug,
                        submission: { body: "1 + 2 == 4" }

          expect(Submission.count).to eq(0)
          expect(response).to redirect_to(root_path)
        end
      end
    end

    describe "GET show" do
      it "allows access to the submitting user" do
        submission = FactoryGirl.create(:submission, user: user)
        session[:user_id] = user.id

        get :show, id: submission.id
        expect(response).to be_success
      end

      it "allows access to admins" do
        admin = FactoryGirl.create(:admin)
        session[:user_id] = admin.id

        submission = FactoryGirl.create(:submission)

        get :show, id: submission.id
        expect(response).to be_success
      end

      it "avoids showing other user submissions" do
        other_user_submission = FactoryGirl.create(:submission)
        session[:user_id] = user.id

        expect { get :show, id: other_user_submission.id }.
          to raise_error(ActionController::RoutingError)
      end
    end
  end
end
