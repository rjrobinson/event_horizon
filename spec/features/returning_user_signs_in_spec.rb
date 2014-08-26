require "rails_helper"

feature "returning user signs in" do

  let(:user) { FactoryGirl.create(:user) }

  before :each do
    OmniAuth.config.mock_auth[:github] = {
      "provider" => user.provider,
      "uid" => user.uid,
      "info" => {
        "nickname" => user.username,
        "email" => user.email,
        "name" => user.name
      },
      "credentials" => {
        "token" => "12345"
      }
    }
  end

  scenario "sign in with github credentials" do
    visit root_path
    click_link "Sign In With GitHub"

    expect(page).to have_content("Signed in as #{user.username}")
    expect(page).to have_link("Sign Out", session_path)

    expect(User.count).to eq(1)
  end

  scenario "sign out" do
    visit root_path
    click_link "Sign In With GitHub"

    expect(page).to have_content("Signed in as #{user.username}")

    click_link "Sign Out"

    expect(page).to_not have_content("Signed in as #{user.username}")
    expect(page).to have_content("Signed out successfully.")
  end

end
