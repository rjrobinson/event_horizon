require "rails_helper"

describe Submission do
  let(:submission) { FactoryGirl.create(:submission) }

  describe "#body=" do
    it "stores the contents as a single file in an archive" do
      submission = FactoryGirl.build(:submission)
      submission.body = "2 + 2 == 5"
      submission.save!

      contents = read_file_from_gzipped_archive(
        submission.archive.path, "file001")
      expect(contents).to eq("2 + 2 == 5")
    end
  end

  describe "#inline_comments" do
    let(:source_file) do
      FactoryGirl.create(:source_file, submission: submission)
    end

    it "selects comments with line numbers" do
      general_comment =
        FactoryGirl.create(:comment, submission: submission, line_number: nil)
      inline_comment =
        FactoryGirl.create(:comment,
                           submission: submission,
                           line_number: 1,
                           source_file: source_file)

      expect(submission.inline_comments).to include(inline_comment)
      expect(submission.inline_comments).to_not include(general_comment)
    end
  end

  describe "#extract_source_files" do
    let(:submission) { FactoryGirl.build(:submission) }

    around(:each) do |test|
      Dir.mktmpdir do |tmpdir|
        FileUtils.cp(source_archive, tmpdir)
        @archive = File.join(tmpdir, File.basename(source_archive))

        test.run
      end
    end

    context "for a single file" do
      let(:source_archive) { Rails.root.join("spec/data/one_file.tar.gz") }

      it "extracts a single file" do
        submission.extract_source_files(@archive)

        expect(submission.files.length).to eq(1)

        file = submission.files.first
        expect(file.body).to eq("puts \"hello, world\"\n")
        expect(file.filename).to eq("example.rb")
      end
    end

    context "for multiple files" do
      let(:source_archive) { Rails.root.join("spec/data/two_files.tar.gz") }

      it "extracts a single file" do
        submission.extract_source_files(@archive)

        expect(submission.files.length).to eq(2)

        filenames = submission.files.map { |file| file.filename }

        expect(filenames).to include("one.rb")
        expect(filenames).to include("two.rb")
      end
    end
  end
end
