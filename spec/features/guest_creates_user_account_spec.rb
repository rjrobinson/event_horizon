require "rails_helper"

feature "guest creates account" do
  scenario "successful sign up with valid github credentials" do
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
    expect(page).to have_link("Sign Out", session_path)

    expect(User.count).to eq(1)
  end

  scenario "failure to sign up when missing email" do
    OmniAuth.config.mock_auth[:github] = {
      "provider" => "github",
      "uid" => "123456",
      "info" => {
        "nickname" => "boblob"
      },
      "credentials" => {
        "token" => "12345"
      }
    }

    visit root_path

    click_link "Sign In With GitHub"

    expect(page).to have_content("Unable to sign up.")
    expect(page).to have_content(
      "No public e-mail associated with GitHub account.")

    expect(page).to_not have_content("Signed in as boblob")
    expect(User.count).to eq(0)
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
