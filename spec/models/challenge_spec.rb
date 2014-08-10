require "rails_helper"

describe Challenge do
  describe ".import" do
    let(:challenge_dir) { Rails.root.join("spec/data/sample-challenge") }

    it "creates a challenge from the given directory" do
      challenge = Challenge.import!(challenge_dir)

      expect(challenge.title).to eq("Sample Challenge")
      expect(challenge.slug).to eq("sample-challenge")
      expect(challenge.body).to include("# Blah Blah")
      expect(challenge.archive_url).to be_present
    end

    it "updates a challenge if it already exists" do
      existing = FactoryGirl.create(:challenge,
                                    slug: "sample-challenge",
                                    title: "foo")

      challenge = Challenge.import!(challenge_dir)

      expect(challenge.title).to eq("Sample Challenge")
      expect(challenge.slug).to eq("sample-challenge")

      expect(challenge.id).to eq(existing.id)
      expect(Challenge.count).to eq(1)
    end
  end
end
