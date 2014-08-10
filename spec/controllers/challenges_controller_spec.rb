require "rails_helper"

describe ChallengesController do
  context "api" do
    render_views

    describe "GET index" do
      it "lists just the challenge name and slug" do
        challenges = FactoryGirl.create_list(:challenge, 3)

        get :index, format: :json
        result = JSON.parse(response.body)

        challenges.each do |challenge|
          challenge_info = {
            "title" => challenge.title,
            "slug" => challenge.slug
          }

          expect(result["challenges"]).to include(challenge_info)
        end
      end
    end

    describe "GET show" do
      it "includes the challenge details" do
        challenge = FactoryGirl.create(:challenge)

        get :show, slug: challenge.slug, format: :json
        result = JSON.parse(response.body)

        expect(result["challenge"]["title"]).to eq(challenge.title)
        expect(result["challenge"]["body"]).to eq(challenge.body)
        expect(result["challenge"]["archive_url"]).to eq(challenge.archive.url)
      end
    end
  end
end
