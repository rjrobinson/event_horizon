require "rails_helper"

describe CommentNotifier do
  let(:notifier) { CommentNotifier.new }

  describe "#perform" do
    it "notifies the owner of the submission" do
      comment = FactoryGirl.create(:comment)
      notifier.perform(comment.id)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    it "doesn't email if commenter is the submitter" do
      submission = FactoryGirl.create(:submission)
      comment = FactoryGirl.create(:comment,
        user: submission.user,
        submission: submission)

      notifier.perform(comment.id)
      expect(ActionMailer::Base.deliveries.count).to eq(0)
    end
  end
end
