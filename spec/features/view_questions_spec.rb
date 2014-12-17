require "rails_helper"

feature "view questions" do
  scenario "list newest questions" do
    questions = FactoryGirl.create_list(:question, 3)

    visit "/questions"

    questions.each do |question|
      expect(page).to have_content(question.title)
    end
  end
end
