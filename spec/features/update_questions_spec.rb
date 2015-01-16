require "rails_helper"

feature "modifying questions" do
  context "as a member" do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as(user)
    end

    scenario "delete question" do
      question = FactoryGirl.create(:question, user: user)
      visit question_path(question)

      click_on "Delete question"
      expect(page).to have_content("Successfully deleted question")
      expect(page).to_not have_content(question.title)
    end
    scenario "un-accept an answer"
    scenario "change accepted answer"
  end
end
