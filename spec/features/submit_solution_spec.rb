require "rails_helper"

feature "submit solution" do
  let(:challenge) { FactoryGirl.create(:challenge) }

  context "as a signed in user" do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as(user)
    end

    scenario "successfully complete submission form" do
      visit challenge_path(challenge)

      click_link "Submit Solution"

      fill_in "Solution", with: "2 + 2 == 5"
      click_button "Submit"

      expect(page).to have_content("Solution submitted.")
      expect(Submission.count).to eq(1)

      submission = Submission.first
      expect(submission.user).to eq(user)
      expect(submission.challenge).to eq(challenge)
    end

    let(:sample_archive) do
      Rails.root.join("spec/data/one_file.tar.gz")
    end

    scenario "upload archive containing solution" do
      visit new_challenge_submission_path(challenge)

      attach_file "Archive", sample_archive
      click_button "Upload"

      expect(page).to have_content("Solution submitted.")
      expect(Submission.count).to eq(1)

      submission = Submission.first
      expect(submission.user).to eq(user)
      expect(submission.challenge).to eq(challenge)
    end

    scenario "redisplay form with errors on blank submission" do
      visit challenge_path(challenge)

      click_link "Submit Solution"
      click_button "Submit"

      expect(page).to have_content("The solution couldn't be submitted.")
      expect(Submission.count).to eq(0)
    end
  end

  context "as a guest" do
    scenario "cannot access the submission form" do
      visit new_challenge_submission_path(challenge)

      expect(page).to have_content("You need to sign in before continuing.")
      expect(page).to_not have_content("New Submission")
    end
  end
end
