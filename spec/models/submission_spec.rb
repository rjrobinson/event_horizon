require "rails_helper"

describe Submission do

  let(:submission) { FactoryGirl.create(:submission) }

  describe "#inline_comments" do
    it "selects comments with line numbers" do
      general_comment =
        FactoryGirl.create(:comment, submission: submission, line_number: nil)
      inline_comment =
        FactoryGirl.create(:comment, submission: submission, line_number: 1)

      expect(submission.inline_comments).to include(inline_comment)
      expect(submission.inline_comments).to_not include(general_comment)
    end
  end

end
