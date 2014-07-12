require "rails_helper"

feature "rate assignment", focus: true do
  let(:assignment) { FactoryGirl.create(:assignment) }

  context "as an authenticated user" do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as(user)
    end

    scenario "successfully submit new rating" do
      visit assignment_path(assignment)

      within(:css, "#helpfulness") { choose("4") }
      within(:css, "#clarity") { choose("2") }
      fill_in "Additional comments (optional)", with: "So-so."
      click_button "Rate Assignment"

      expect(page).to have_content("Rating saved.")
      expect(assignment.ratings.count).to eq(1)

      rating = assignment.ratings.first
      expect(rating.comment).to eq("So-so.")
      expect(rating.helpfulness).to eq(4)
      expect(rating.clarity).to eq(2)
      expect(rating.user).to eq(user)
    end

    scenario "fail to fill out rating form" do
      visit assignment_path(assignment)
      click_button "Rate Assignment"

      expect(page).to have_content("Rating could not be saved.")
      expect(assignment.ratings.count).to eq(0)
    end
  end

  context "as a guest" do
    scenario "the rating form is hidden" do
      visit assignment_path(assignment)
      expect(page).to_not have_content("Rate this assignment")
    end
  end
end
