require 'rails_helper'

feature 'Admin can add users to specific teams' do
  scenario 'auth admin succesfully adds uesr to team' do
    user = FactoryGirl.create(:user)
    team = FactoryGirl.create(:team)
    admin = FactoryGirl.create(:admin)
    sign_in_as(admin)

    visit edit_team_path(team)

    check 'Add' # going to need to figure out proper way to click check
    click_on 'Update team'

    expect(page).to have_content("Users successfully added to #{team.name}.")
    expect(page).to have_content(user.username)
  end
end
