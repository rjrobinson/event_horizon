require "rails_helper"

feature "vote on submission", focus: true do
  let(:challenge) { FactoryGirl.create(:challenge) }

  context "as a user" do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as(user)
    end

    scenario "upvote submission" do
      submission = FactoryGirl
        .create(:submission, challenge: challenge, public: true)
      FactoryGirl.create(:submission, challenge: challenge, user: user)

      visit submission_path(submission)

      expect(page).to have_content("Was this submission helpful to you?")

      within("#vote-helpful") do
        click_button("Yes")
      end

      expect(page).to have_content("You have marked this submission as helpful")
      expect(submission.up_votes.count).to eq(1)
    end

    scenario "downvote"
    scenario "clear vote"
    scenario "can't vote on own submission"
    scenario "can't vote on unauthorized submissions"
  end
end
