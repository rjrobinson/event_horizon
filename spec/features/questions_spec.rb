require "rails_helper"

feature "questions" do
  scenario "view the newest questions" do
    questions = FactoryGirl.create_list(:question, 3)

    visit questions_path

    expect(page).to have_content("Newest Questions")

    questions.each do |question|
      expect(page).to have_link(question.title, href: question_path(question))
    end
  end

  scenario "view unanswered questions"

  scenario "view a question with no answers" do
    question = FactoryGirl.create(:question)
    visit question_path(question)

    expect(page).to have_content(question.title)
    expect(page).to have_content(question.body)
    expect(page).to have_content("There are no answers yet.")
  end

  scenario "view a single question with answers" do
    question = FactoryGirl.create(:question)
    answers = FactoryGirl.create_list(:answer, 3, question: question)

    visit question_path(question)

    answers.each do |answer|
      expect(page).to have_content(answer.body)
    end
  end

  context "as a member" do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as(user)
    end

    scenario "submit a valid question" do
      visit new_question_path

      fill_in "Title", with: "What's for lunch?"
      fill_in "Body", with: "Please, no more Dumpling Cafe."

      click_button "Ask Question"

      expect(page).to have_content("Question saved.")

      expect(Question.count).to eq(1)
      expect(page).to have_content("What's for lunch?")
      expect(page).to have_content("Please, no more Dumpling Cafe.")
    end

    scenario "submit an invalid question" do
      visit new_question_path
      click_button "Ask Question"

      expect(page).to have_content("Failed to save question.")
      expect(Question.count).to eq(0)
    end

    scenario "answer a question" do
      question = FactoryGirl.create(:question)

      visit question_path(question)

      fill_in "Answer", with: "You need to reticulate the splines."
      click_button "Submit Answer"

      expect(page).to have_content("Answer saved.")
      expect(page).to have_content("You need to reticulate the splines.")
      expect(page).to have_content("#{user.username} answered")

      expect(Answer.count).to eq(1)
    end

    scenario "comment on a question"
    scenario "comment on an answer"
    scenario "accept an answer"
  end
end
