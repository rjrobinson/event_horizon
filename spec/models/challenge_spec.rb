require "rails_helper"

describe Challenge do
  describe ".parse" do
    let(:sample_filepath) do
      Rails.root.join("spec/data/sample_challenge.md")
    end

    let(:sample_file) { File.read(sample_filepath) }
    let(:challenge) { Challenge.parse(sample_file) }

    it "reads title from header" do
      expect(challenge[:title]).to eq("Sample Challenge")
    end

    it "reads the slug from the header" do
      expect(challenge[:slug]).to eq("sample-challenge")
    end

    it "removes header from the body" do
      expect(challenge[:body]).
        to eq("\n\n# Blah Blah\n\nSomething goes here.\n")
    end
  end
end
