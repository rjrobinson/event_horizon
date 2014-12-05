require "rails_helper"

feature "announcements" do
  context "as a team member" do
    let(:team) { FactoryGirl.create(:team) }
    let(:team_member) { FactoryGirl.create(:team_membership, team: team) }

    before :each do
      sign_in_as(team_member.user)
    end

    scenario "view latest announcements on dashboard" do
      old_announcements = FactoryGirl.create_list(:announcement, 2, team: team, created_at: 1.day.ago)
      recent_announcements = FactoryGirl.create_list(:announcement, 5, team: team)

      visit dashboard_path

      recent_announcements.each do |announcement|
        expect(page).to have_content(announcement.title)
      end

      old_announcements.each do |announcement|
        expect(page).to_not have_content(announcement.title)
      end
    end

    scenario "view announcements on team page" do
      announcements = FactoryGirl.create_list(:announcement, 5, team: team)

      visit team_path(team)

      announcements.each do |announcement|
        expect(page).to have_content(announcement.title)
      end
    end
  end

  context "as an admin" do
    scenario "create a new announcement"
    scenario "fail to create a new announcement"
    scenario "remove an existing announcement"
  end
end
