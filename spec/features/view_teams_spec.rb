require "rails_helper"

feature "view teams" do
  scenario "list users in a team" do
    team = FactoryGirl.create(:team)
    members = FactoryGirl.create_list(:team_membership, 3, team: team)

    visit team_path(team)

    expect(page).to have_content(team.name)

    members.each do |member|
      user = member.user
      expect(page).to have_link(user.username, href: user_path(user))
    end
  end
end
