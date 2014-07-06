module AuthenticationHelper
  def sign_in_as(user)
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
end
