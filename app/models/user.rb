class User < ActiveRecord::Base
  has_many :submissions
  has_many :ratings

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :provider, presence: true
  validates :role, presence: true, inclusion: {
    in: ["member", "instructor", "admin"]
  }

  def self.find_or_create_from_omniauth(auth)
    account_keys = { uid: auth["uid"], provider: auth["provider"] }

    User.find_or_create_by(account_keys) do |user|
      user.email = auth["info"]["email"]
      user.username = auth["info"]["nickname"]
      user.name = auth["info"]["name"]
    end
  end

  def instructor?
    role == "instructor"
  end
end
