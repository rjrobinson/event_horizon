require "rails_helper"

feature "assignment status is displayed on dashboard", %q{

  As a Horizon user,
  I would like to see the status of my submissions
  So that I am aware of what assignments I have left to do.

} do

  scenario "user completes assignment" do
    team_membership = FactoryGirl.create(:team_membership)
    user = team_membership.user
    assignment = FactoryGirl.create(:assignment,
      team: team_membership.team)
    submission = FactoryGirl.create(:submission,
      lesson: assignment.lesson, user: team_membership.user)

    sign_in_as submission.user
    visit dashboard_path
    expect(page).to have_content("submitted")
  end

  scenario "admin reviews assignment" do
    team_membership = FactoryGirl.create(:team_membership)
    user = team_membership.user
    assignment = FactoryGirl.create(:assignment,
      team: team_membership.team)
    submission = FactoryGirl.create(:submission,
      lesson: assignment.lesson, user: team_membership.user)

    admin = FactoryGirl.create(:user, role: "admin")
    comment = FactoryGirl.create(:comment, user: admin, submission: submission)

    sign_in_as submission.user
    visit dashboard_path
    expect(page).to have_content("reviewed")
  end

end
