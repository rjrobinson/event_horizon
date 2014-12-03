require "rails_helper"

feature "assignment status is displayed on dashboard", %q{

  As a Horizon user,
  I would like to see the status of my submissions
  So that I am aware of what assignments I have left to do.

} do

  let(:user) { FactoryGirl.create(:user_with_assignment_submission) }
  let(:admin) { FactoryGirl.create(:admin) }

  before(:each) do
    sign_in_as user
  end

  scenario "user completes assignment" do
    visit dashboard_path

    within("td.submitted") do
      expect(page).to have_content("yes")
    end
  end

  scenario "user submission has not been reviewed" do
    visit dashboard_path

    within("td.reviewed") do
      expect(page).to have_content("no")
    end
  end

  scenario "user comments on a submission, not counted as reviewed" do
    user_comment = FactoryGirl.create(:comment, user: user,
      submission: user.submissions.first)

    visit dashboard_path

    within("td.reviewed") do
      expect(page).to have_content("no")
    end
  end

  scenario "admin reviews assignment" do
    admin_comment = FactoryGirl.create(:comment, user: admin,
      submission: user.submissions.first)

    visit dashboard_path

    within("td.reviewed") do
      expect(page).to have_content("yes")
    end
  end

end
