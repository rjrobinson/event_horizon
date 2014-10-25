require "rails_helper"

feature "view teams" do
  let(:team) { FactoryGirl.create(:team) }

  context "as a user" do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as(user)
    end

    scenario "list users in a team" do
      members = FactoryGirl.create_list(:team_membership, 3, team: team)

      visit team_path(team)

      expect(page).to have_content(team.name)

      members.each do |member|
        user = member.user
        expect(page).to have_link(user.username, href: user_path(user))
      end
    end
  end

  context "as an admin" do
    let(:admin) { FactoryGirl.create(:admin) }

    before :each do
      sign_in_as(admin)
    end

    scenario "view list of teams" do
      teams = FactoryGirl.create_list(:team, 3)

      visit teams_path

      teams.each do |team|
        expect(page).to have_link(team.name, href: team_path(team))
      end
    end
  end

  context "as a guest" do
    scenario "require authentication to view teams" do
      visit team_path(team)

      expect(page).to have_content("You need to sign in before continuing.")
      expect(page).to_not have_content(team.name)
    end
  end
end
