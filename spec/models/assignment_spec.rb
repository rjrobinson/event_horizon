require "rails_helper"

describe Assignment do

  describe ".parse" do
    let(:sample_filepath) { Rails.root.join("spec/data/sample_assignment.md") }
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
