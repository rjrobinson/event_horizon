require 'rails_helper'

feature 'Queue Index' do
  let(:team) { FactoryGirl.create(:team, name: 'Spring 2015') }

  context 'As a Experience Engineer' do
    let(:ee) { FactoryGirl.create(:admin, name: 'Joe Shoe') }

    before(:each) do
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

    scenario "I can add a student to the Queue" do
      student = FactoryGirl.create(:user)
      FactoryGirl.create(:team_membership, user: student, team: team)
      question = FactoryGirl.create(:question, user: student, title: 'What is the meaning to life?')

      visit questions_path
      click_on question.title
      click_on "Let's Talk!"

      visit team_question_queues_path(team)
      expect(page).to have_content(student.name)
      expect(page).to have_content('What is the meaning to life?')
    end

    scenario "I can own a Question Queue by saying I'm on it" do
      student = FactoryGirl.create(:user)
      FactoryGirl.create(:team_membership, user: student, team: team)
      question = FactoryGirl.create(:question, user: student, title: 'What is the meaning to life?')

      sign_in_as ee
      visit questions_path
      click_on question.title
      click_on "Let's Talk!"

      visit team_question_queues_path(team)
      click_on "I'm on it!"

      expect(page).to have_content(ee.name)
      expect(page).to have_content("We Solved It!")
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
