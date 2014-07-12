require "rails_helper"

describe Assignment do
  let(:assignment) { FactoryGirl.create(:assignment) }

  describe ".search" do
    let!(:foo) do
      FactoryGirl.create(:assignment,
                         title: "Blah",
                         body: "i like pizza")
    end

    let!(:bar) do
      FactoryGirl.create(:assignment,
                         title: "Shazbot",
                         body: "Ruby sure is fun.")
    end

    let!(:baz) do
      FactoryGirl.create(:assignment,
                         title: "Mr. Grumblecat",
                         body: "Ruby gems and fiddle sticks.")
    end

    it "searches by title" do
      expect(Assignment.search("blah")).to eq([foo])
    end

    it "searches by body" do
      expect(Assignment.search("ruby")).to eq([bar, baz])
    end

    it "ignores order of query terms" do
      expect(Assignment.search("stick fiddle")).to eq([baz])
    end
  end

  describe ".parse" do
    let(:sample_filepath) do
      Rails.root.join("spec/data/sample_assignment.md")
    end

    let(:sample_file) { File.read(sample_filepath) }
    let(:assignment) { Assignment.parse(sample_file) }

    it "reads title from header" do
      expect(assignment[:title]).to eq("Sample Assignment")
    end

    it "reads the slug from the header" do
      expect(assignment[:slug]).to eq("sample-assignment")
    end

    it "removes header from the body" do
      expect(assignment[:body]).
        to eq("\n\n# Blah Blah\n\nSomething goes here.\n")
    end
  end
end
