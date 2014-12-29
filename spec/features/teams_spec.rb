require 'rails_helper'

feature 'Admin can update users to specific teams' do
  let(:admin) { FactoryGirl.create(:admin) }
  before(:each) do
    sign_in_as(admin)
  end

  scenario 'auth admin succesfully adds user to team' do
    user = FactoryGirl.create(:user)
    team = FactoryGirl.create(:team)

    visit edit_team_path(team)

    find(:css, "input[value='#{user.id}']").set(true)
    click_on 'Add to team'

    expect(page).to have_content("Users successfully added to #{team.name}.")
    expect(page).to have_content(user.username)
    expect(team.reload.users).to include(user)
  end

  scenario 'auth admin can remove users from a team' do
    team = FactoryGirl.create(:team)
    visit edit_team_path(team)

  end

  scenario 'user is being added to team they already are in, admin gets notified', focus: true do
    team_membership = FactoryGirl.create(:team_membership)
    visit edit_team_path(team_membership.team)

    find(:css, "input[value='#{team_membership.user.id}']").set(true)
    click_on 'Add to team'

    expect(page).to have_content("#{team_membership.user} is already on that team")
  end
end
