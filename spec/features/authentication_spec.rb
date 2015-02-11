require "rails_helper"

feature "guest creates account" do
  context "new user" do
    scenario "successful sign up" do
      OmniAuth.config.mock_auth[:github] = {
        "provider" => "github",
        "uid" => "123456",
        "info" => {
          "nickname" => "boblob",
          "email" => "bob@example.com",
          "name" => "Bob Loblaw"
        },
        "credentials" => {
          "token" => "12345"
        }
      }

      visit root_path

      click_link "Sign In With GitHub"

      expect(page).to have_content("Successfully signed in as boblob")
      expect(page).to have_content("Signed in as boblob")
      expect(page).to have_link("Sign Out", href: session_path)

      expect(User.count).to eq(1)
    end

    scenario "failure to sign up with invalid credentials" do
      OmniAuth.config.mock_auth[:github] = :invalid_credentials

      visit root_path

      click_link "Sign In With GitHub"

      expect(page).to have_content("Unable to sign in.")
      expect(page).to have_link("Sign In With GitHub", new_session_path)
      expect(User.count).to eq(0)
    end
  end

  context "existing user" do
    let(:user) { FactoryGirl.create(:user) }
    let(:identity) { user.identities.first }

    before :each do
      OmniAuth.config.mock_auth[:github] = {
        "provider" => identity.provider,
        "uid" => identity.uid,
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

    scenario "update user attributes from github" do
      OmniAuth.config.mock_auth[:github]["info"]["name"] = "Gary Laser Eyes"

      visit root_path
      click_link "Sign In With GitHub"

      visit user_path(user)
      expect(page).to have_content("Gary Laser Eyes")
    end
  end
end
