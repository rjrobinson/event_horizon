require "rails_helper"

describe SubmissionExtractor do
  let(:extractor) { SubmissionExtractor.new }

  describe "#perform" do
    it "extracts a single source file" do
      submission = FactoryGirl.create(:submission)
      extractor.perform(submission.id)
      expect(submission.files.count).to eq(1)
    end

    it "extracts multiple source files" do
      submission = FactoryGirl.create(:submission_with_two_file_archive)
      extractor.perform(submission.id)
      expect(submission.files.count).to eq(2)
    end
  end
end
