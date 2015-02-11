require 'rails_helper'

feature 'viewing questions in the Queue' do
  let(:team) { FactoryGirl.create(:team, name: 'Spring 2015') }
  let(:student) { FactoryGirl.create(:user) }
  let(:ee) { FactoryGirl.create(:user, name: 'Joe Shoe') }

  before do
    FactoryGirl.create(:team_membership, user: student, team: team)
  end

  scenario 'I can view a Queue per team on my dashboard' do
    sign_in_as student
    visit dashboard_path
    click_on 'Spring 2015 Question Queue'
    expect(page).to have_content('Question Queue for Spring 2015')
  end

  scenario 'I can see Question Queue status on Questions' do
    question1 = FactoryGirl.create(:question)
    question2 = FactoryGirl.create(:question)
    question3 = FactoryGirl.create(:question)
    FactoryGirl.create(:question_queue, question: question1, status: 'done')
    FactoryGirl.create(:question_queue, question: question2, status: 'open')
    FactoryGirl.create(:question_queue, user: ee, question: question3, status: 'in-progress')

    visit questions_path
    expect(page).to have_content("Queued")
    expect(page).to have_content("Assigned to Joe Shoe")
    expect(page).to have_content("Done")
  end
end
