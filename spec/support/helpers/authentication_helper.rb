require "base64"

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

  def set_auth_headers_for(user)
    credentials = Base64.strict_encode64("#{user.username}:#{user.token}")
    request.env["HTTP_AUTHORIZATION"] = "Basic #{credentials}"
  end
end
