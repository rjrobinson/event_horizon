require "base64"

module AuthenticationHelper
  def sign_in_as(user)
    identity = user.identities.first
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

    visit root_path
    click_link "Sign In With GitHub"
  end

  def set_auth_headers_for(user)
    credentials = Base64.strict_encode64("#{user.username}:#{user.token}")
    request.env["HTTP_AUTHORIZATION"] = "Basic #{credentials}"
  end
end
