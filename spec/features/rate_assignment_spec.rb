require "rails_helper"

feature "rate assignment" do
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

    scenario "successfully update existing rating" do
      FactoryGirl.create(:rating,
                         assignment: assignment,
                         user: user,
                         helpfulness: 3,
                         clarity: 1,
                         comment: "So-so.")

      visit assignment_path(assignment)
      expect(page).to have_content("So-so.")

      fill_in "Additional comments (optional)", with: "Much better."
      within(:css, "#clarity") { choose("5") }
      click_button "Rate Assignment"

      expect(page).to have_content("Rating updated.")
      expect(assignment.ratings.count).to eq(1)

      rating = assignment.ratings.first
      expect(rating.comment).to eq("Much better.")
      expect(rating.clarity).to eq(5)
      expect(rating.helpfulness).to eq(3)
    end

    scenario "fail to update existing rating" do
      FactoryGirl.create(:rating,
                         assignment: assignment,
                         user: user,
                         comment: "So-so.")

      visit assignment_path(assignment)
      long_comment = "a" * 10_000

      fill_in "Additional comments (optional)", with: long_comment
      click_button "Rate Assignment"

      expect(page).to have_content("Rating could not be updated.")
      expect(assignment.ratings.first.comment).to eq("So-so.")
    end
  end

  context "as a guest" do
    scenario "the rating form is hidden" do
      visit assignment_path(assignment)
      expect(page).to_not have_content("Rate this assignment")
    end
  end
end
