require "rails_helper"

feature "comment on submission", focus: true do
  context "as an instructor" do
    let(:instructor) { FactoryGirl.create(:instructor) }

    before :each do
      sign_in_as(instructor)
    end

    scenario "comment on submission in general" do
      submission = FactoryGirl.create(:submission)

      visit submission_path(submission)

      fill_in "Comment", with: "Needs more cow-bell."
      click_button "Submit"

      expect(page).to have_content("Comment saved.")
      expect(page).to have_content("#{instructor.username} commented")
      expect(page).to have_content("Needs more cow-bell.")
    end
  end
end
