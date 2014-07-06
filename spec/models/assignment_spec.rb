require "rails_helper"

describe Assignment do

  let(:assignment) { FactoryGirl.create(:assignment) }

  describe ".parse" do
    let(:sample_filepath) do
      Rails.root.join("spec/support/data/sample_assignment.md")
    end

    let(:sample_file) { File.read(sample_filepath) }
    let(:assignment) { Assignment.parse(sample_file) }

    it "reads title from header" do
      expect(assignment[:title]).to eq("Sample Assignment")
    end

    it "removes header from the body" do
      expect(assignment[:body]).
        to eq("\n\n# Blah Blah\n\nSomething goes here.\n")
    end
  end

  describe "#submissions_viewable_by" do
    let(:instructor) { FactoryGirl.create(:instructor) }

    it "shows all submissions to instructors" do
      submissions = FactoryGirl.
        create_list(:submission, 3, assignment: assignment)

      viewable = assignment.submissions_viewable_by(instructor)

      expect(viewable.length).to eq(submissions.length)
      submissions.each do |submission|
        expect(viewable).to include(submission)
      end
    end

    it "hides other user submissions from students" do
      submission_a = FactoryGirl.create(:submission, assignment: assignment)
      submission_b = FactoryGirl.create(:submission, assignment: assignment)

      expect(assignment.submissions_viewable_by(submission_a.user)).
        to eq([submission_a])
      expect(assignment.submissions_viewable_by(submission_b.user)).
        to eq([submission_b])
    end
  end

end
