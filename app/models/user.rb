class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :provider, presence: true

  def self.find_or_create_from_omniauth(auth)
    account_keys = { uid: auth["uid"], provider: auth["provider"] }

    User.find_or_create_by(account_keys) do |user|
      user.email = auth["info"]["email"]
      user.username = auth["info"]["nickname"]
      user.name = auth["info"]["name"]
    end
  end
end
