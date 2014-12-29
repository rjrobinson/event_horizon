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
    click_on 'Update team'

    expect(page).to have_content("#{team.name.capitalize} was successfully updated.")
    expect(page).to have_content(user.username)
    expect(team.reload.users).to include(user)
  end

  # scenario 'auth admin can remove users from a team', focus: true do
  #   team_membership = FactoryGirl.create(:team_membership)
  #   visit edit_team_path(team_membership.team)
  #
  #   find(:css, "input[value='#{team_membership.user.id}']").set(false)
  #   click_on 'Update team'
  #
  #   expect(page).to have_content("#{team_membership.team.name.capitalize} was successfully updated.")
  # end
end
