require "rails_helper"

feature "view dashboard" do
  context "as a user" do
    let(:user) { FactoryGirl.create(:user) }
    let(:team) { FactoryGirl.create(:team) }

    before :each do
      FactoryGirl.create(:team_membership, user: user, team: team)
      sign_in_as(user)
    end

    scenario "show upcoming assignments" do
      assignment = FactoryGirl.create(:assignment, team: team)

      visit dashboard_path

      expect(page).to have_content(assignment.lesson.title)
    end
  end
end
