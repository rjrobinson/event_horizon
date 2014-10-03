require "rails_helper"

feature "rate lesson" do
  let(:lesson) { FactoryGirl.create(:lesson) }

  context "as a member" do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as(user)
    end

    scenario "rate new lesson" do
      visit lesson_path(lesson)

      within(:css, "#helpfulness") { choose("4") }
      within(:css, "#clarity") { choose("2") }
      fill_in "Additional comments (optional)", with: "So-so."

      click_button "Rate Lesson"

      expect(page).to have_content("Rating saved.")
      expect(lesson.ratings.count).to eq(1)

      rating = lesson.ratings.first
      expect(rating.comment).to eq("So-so.")
      expect(rating.helpfulness).to eq(4)
      expect(rating.clarity).to eq(2)
      expect(rating.user).to eq(user)
    end
  end
end
