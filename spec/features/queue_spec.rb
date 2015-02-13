require 'rails_helper'

feature 'Queue Index' do
  let(:team) { FactoryGirl.create(:team, name: 'Spring 2015') }
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

  scenario "I can take a Question through the Question Queue" do
    student = FactoryGirl.create(:user)
    FactoryGirl.create(:team_membership, user: student, team: team)
    question = FactoryGirl.create(:question, user: student, title: 'What is the meaning to life?')

    sign_in_as ee
    visit question_path(question)
    click_on "Let's Talk!"

    visit team_question_queues_path(team)
    expect(page).to have_content(student.name)
    expect(page).to have_content('What is the meaning to life?')

    click_on "I'm on it!"
    expect(page).to have_content(ee.name)
    expect(page).to have_content("We Solved It!")

    click_on "We Solved It!"
    expect(page).not_to have_content("We Solved It!")
    expect(page).not_to have_content(question.title)
  end

  scenario "I can tag a question as a No Show to move it to the bottom of the queue" do
    student = FactoryGirl.create(:user)
    FactoryGirl.create(:team_membership, user: student, team: team)
    question = FactoryGirl.create(:question, user: student, title: 'What is the meaning to life?')
    qq = FactoryGirl.create(:question_queue, question: question, team: team)

    student2 = FactoryGirl.create(:user)
    FactoryGirl.create(:team_membership, user: student2, team: team)
    question2 = FactoryGirl.create(:question, user: student2, title: 'Why does my postgresql not work????')
    FactoryGirl.create(:question_queue, question: question2, team: team)

    sign_in_as ee
    visit team_question_queues_path(team)

    expect(page.body.index('What is the meaning to life')).to be < page.body.index('Why does my postgresql not work')
    within("#queue_#{qq.id}") do
      click_on "No Show"
    end
    expect(page.body.index('Why does my postgresql not work')).to be < page.body.index('What is the meaning to life')

    visit questions_path
    expect(page).to have_content("Queued")
  end

  scenario "3 no shows marks a question as done" do
    student = FactoryGirl.create(:user)
    FactoryGirl.create(:team_membership, user: student, team: team)
    question = FactoryGirl.create(:question, user: student, title: 'What is the meaning to life?')
    FactoryGirl.create(:question_queue, question: question, team: team)

    sign_in_as ee
    visit team_question_queues_path(team)
    click_on "No Show"
    click_on "No Show"
    click_on "No Show"
    expect(page).to_not have_content('What is the meaning to life?')
  end
end
