require "rails_helper"

feature "student submits solution" do

  let(:user) { FactoryGirl.create(:user) }

  before :each do
    OmniAuth.config.mock_auth[:github] = {
      "provider" => user.provider,
      "uid" => user.uid,
      "info" => {
        "nickname" => user.username,
        "email" => user.email,
        "name" => user.name
      }
    }

    visit root_path
    click_link "Sign In With GitHub"
  end

  scenario "successfully complete submission form" do
    assignment = FactoryGirl.create(:assignment)

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
  end

end
