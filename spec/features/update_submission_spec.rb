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
  end
end
