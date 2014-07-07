require "rails_helper"

describe CommentsController do
  let(:submission) { FactoryGirl.create(:submission) }

  describe "POST create" do
    it "allows submission owner to comment" do
      session[:user_id] = submission.user.id
      post :create, submission_id: submission.id, comment: { body: "foo" }

      expect(Comment.count).to eq(1)
      expect(response).to redirect_to(submission_path(Submission.first))
    end

    it "prevents other users from commenting" do
      new_user = FactoryGirl.create(:user)
      session[:user_id] = new_user.id

      expect{
        post :create, submission_id: submission.id, comment: { body: "foo" }
      }.to raise_error(ActionController::RoutingError)

      expect(Comment.count).to eq(0)
    end

    it "prevents unauthorized users from commenting" do
      post :create, submission_id: submission.id, comment: { body: "foo" }

      expect(response).to be_a_redirect
      expect(Comment.count).to eq(0)
    end
  end
end
