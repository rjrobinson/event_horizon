require "rails_helper"

feature "vote on submission", focus: true do
  let(:challenge) { FactoryGirl.create(:challenge) }

  context "as a user" do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as(user)
    end

    let!(:my_submission) do
      FactoryGirl.create(:submission, challenge: challenge, user: user)
    end

    scenario "upvote another user's submission" do
      submission = FactoryGirl
        .create(:submission, challenge: challenge, public: true)

      visit submission_path(submission)

      expect(page).to have_content("Was this submission helpful to you?")

      within("#vote-helpful") do
        click_button("Yes")
      end

      expect(page).to have_content("Thanks for voting!")
      expect(submission.votes.count).to eq(1)
    end

    scenario "downvote submission" do
      submission = FactoryGirl
        .create(:submission, challenge: challenge, public: true)

      visit submission_path(submission)

      expect(page).to have_content("Was this submission helpful to you?")

      within("#vote-helpful") do
        click_button("No")
      end

      expect(page).to have_content("Thanks for voting!")
      expect(submission.downvotes.count).to eq(1)
    end

    scenario "update vote if already voted" do
      submission = FactoryGirl
        .create(:submission, challenge: challenge, public: true)
      FactoryGirl.create(:vote, user: user, submission: submission)

      expect(submission.votes).to eq(1)
      expect(submission.downvotes).to eq(0)

      visit submission_path(submission)

      within("#vote-helpful") do
        click_button "No"
      end

      expect(submission.votes.count).to eq(0)
      expect(submission.downvotes.count).to eq(1)
    end

    scenario "can't vote on own submission" do
      visit submission_path(my_submission)
      expect(page).to_not have_content("Was this submission helpful to you?")
    end

    scenario "can't vote on unauthorized submissions"
    end
end
