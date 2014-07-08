require "rails_helper"

feature "student submits solution" do

  let(:assignment) { FactoryGirl.create(:assignment) }

  context "as a signed in user" do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as(user)
    end

    scenario "successfully complete submission form" do
      visit assignment_path(assignment)

      click_link "Submit Solution"

      fill_in "Solution", with: "2 + 2 == 5"
      click_button "Submit"

      expect(page).to have_content("Solution submitted.")
      expect(page).to have_content("2 + 2 == 5")

      expect(Submission.count).to eq(1)

      submission = Submission.first
      expect(submission.user).to eq(user)
      expect(submission.assignment).to eq(assignment)
      expect(submission.files.count).to eq(1)
    end

    scenario "redisplay form with errors on blank submission" do
      visit assignment_path(assignment)

      click_link "Submit Solution"
      click_button "Submit"

      expect(page).to have_content("The solution couldn't be submitted.")
      expect(page).to have_content("can't be blank")
      expect(Submission.count).to eq(0)
    end
  end

  context "as a guest" do
    scenario "cannot access the submission form" do
      visit new_assignment_submission_path(assignment)

      expect(page).to have_content("You need to sign in before continuing.")
      expect(page).to_not have_content("New Submission")
    end
  end

end
