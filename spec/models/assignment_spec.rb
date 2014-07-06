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

end
