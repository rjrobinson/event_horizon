require "rails_helper"

feature "update submission" do
  context "as a member" do
    let(:user) { FactoryGirl.create(:user) }
    let(:submission) { FactoryGirl.create(:submission_with_file, user: user) }

    before :each do
      sign_in_as(user)
    end

    scenario "make submission public" do
      visit submission_path(submission)

      click_button "Make Public"

      expect(page).to have_content("Submission updated.")

      submission.reload
      expect(submission.public).to eq(true)
    end

    scenario "my submission defaults as private" do

      submission = FactoryGirl.create(:submission, user: user)

      visit submission_path(submission)

      within("#public") do
        expect(page).to have_content("false")
      end
    end

    scenario "make my submission public" do
      submission = FactoryGirl.create(:submission, user: user, public: true)

      visit submission_path(submission)

      within("#public") do
        expect(page).to have_content("true")
      end
    end

    scenario "make my submission public, then private again" do
      submission = FactoryGirl.create(:submission, user: user, public: true)

      visit submission_path(submission)

      within("#public") do
        expect(page).to have_content("true")
      end

      click_button "Make Private"

      within("#public") do
        expect(page).to have_content("false")
      end
    end
  end
end
