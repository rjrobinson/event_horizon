require "rails_helper"

describe Submission do

  let(:submission) { FactoryGirl.create(:submission_with_source) }

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

  describe "#extract_source_files" do
    let(:submission) { FactoryGirl.build(:submission) }
    let(:source_archive) do
      Rails.root.join("spec/data/one_file.tar.gz")
    end

    around(:each) do |test|
      Dir.mktmpdir do |tmpdir|
        FileUtils.cp(source_archive, tmpdir)
        @archive = File.join(tmpdir, File.basename(source_archive))

        test.run
      end
    end

    it "extracts a single file" do
      submission.extract_source_files(@archive)

      expect(submission.files.length).to eq(1)

      file = submission.files.first
      expect(file.body).to eq("puts \"hello, world\"\n")
      expect(file.filename).to eq("example.rb")
    end
  end

end
