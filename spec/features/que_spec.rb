require 'rails_helper'

feature 'Queue Index' do
  let(:team) { FactoryGirl.create(:team, name: 'Spring 2015') }

  context 'As a Experience Engineer' do
    let(:ee) { FactoryGirl.create(:admin) }

    before do
      FactoryGirl.create(:team_membership, user: ee, team: team)
    end

    scenario 'I can view a Queue per team from my team index page' do
      sign_in_as ee
      visit teams_path
      within "#team_#{team.id}" do
        click_on 'Question Queue'
      end
      expect(page).to have_content('Question Queue for Spring 2015')
    end
  end

  context 'As an Student' do
    let(:student) { FactoryGirl.create(:user) }

    before do
      FactoryGirl.create(:team_membership, user: student, team: team)
    end

    scenario 'I can view a Queue per team on my dashboard' do
      sign_in_as student
      visit dashboard_path
      click_on 'Spring 2015 Question Queue'
      expect(page).to have_content('Question Queue for Spring 2015')
    end
  end
end
