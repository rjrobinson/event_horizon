class User < ActiveRecord::Base
  def self.find_or_create_from_omniauth(auth)
    account_keys = { uid: auth["uid"], provider: auth["provider"] }

    User.find_or_create_by(account_keys) do |user|
      user.email = auth["info"]["email"]
      user.username = auth["info"]["nickname"]
      user.name = auth["info"]["name"]
    end
  end
end
