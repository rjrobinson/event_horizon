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
    expect(page).to have_content("0 answers")
  end

  scenario "view a single question with answers" do
    question = FactoryGirl.create(:question)
    answers = FactoryGirl.create_list(:answer, 3, question: question)

    visit question_path(question)

    answers.each do |answer|
      expect(page).to have_content(answer.body)
    end
  end

  scenario "show accepted answer first" do
    question = FactoryGirl.create(:question)
    unaccepted_answer = FactoryGirl.create(:answer, question: question)
    accepted_answer = FactoryGirl.create(:answer, question: question)

    question.accepted_answer = accepted_answer
    question.save!

    visit question_path(question)
    expect(page).to order_text(accepted_answer.body, unaccepted_answer.body)
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

    scenario "submit an answer successfully" do
      question = FactoryGirl.create(:question)

      visit question_path(question)

      fill_in "Answer", with: "You need to reticulate the splines."
      click_button "Submit Answer"

      expect(page).to have_content("Answer saved.")
      expect(page).to have_content("You need to reticulate the splines.")
      expect(page).to have_content("#{user.username} answered")

      expect(Answer.count).to eq(1)
    end

    scenario "display error when submitting a blank answer" do
      question = FactoryGirl.create(:question)

      visit question_path(question)
      click_button "Submit Answer"

      expect(page).to have_content("Failed to save answer.")
      expect(Answer.count).to eq(0)
    end

    scenario "accept an answer" do
      question = FactoryGirl.create(:question, user: user)
      answer = FactoryGirl.create(:answer, question: question)

      visit question_path(question)

      click_button "Accept Answer"

      expect(page).to have_content("Your question has been updated.")
      expect(page).to have_content("accepted answer")

      question.reload
      expect(question.accepted_answer).to eq(answer)
    end

    scenario "edit question" do
      question = FactoryGirl.create(:question, user: user)

      visit question_path(question)

      click_on "Edit Question"

      title = "How strong is gravity at the event horizon?"
      body = "A complete description of event horizons is
        expected to, at minimum, require a theory of quantum gravity. One such
        candidate theory is M-theory. Another such candidate theory is loop
        quantum gravity."

      fill_in "Title", with: title
      fill_in "Body", with: body

      click_button "Update Question"

      expect(page).to have_content("Your question has been updated.")
      expect(page).to have_content(title)
      expect(page).to have_content(body)
    end

    scenario "edit answer", focus: true do
      question = FactoryGirl.create(:question, user: user)
      answer = FactoryGirl.create(:answer, question: question)

      visit question_path(question)

      click_on "Edit Answer"

      body = "No. A complete description of event horizons is not
      expected to, at minimum, require a theory of quantum gravity."

      fill_in "Answer", with: body

      click_button "Update Answer"

      expect(page).to have_content("Your answer has been updated.")
      expect(page).to have_content(body)
    end

    scenario "delete question"
    scenario "delete answer"
    scenario "un-accept an answer"
    scenario "change accepted answer"
    scenario "comment on a question"
    scenario "comment on an answer"

    scenario "only original asker can accept answer" do
      question = FactoryGirl.create(:question)
      answer = FactoryGirl.create(:answer, question: question)

      visit question_path(question)
      expect(page).to_not have_button("Accept Answer")
    end
  end
end
