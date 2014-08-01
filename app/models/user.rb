class User < ActiveRecord::Base
  has_many :submissions
  has_many :ratings
  has_many :enrollments
  has_many :courses, through: :enrollments

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :provider, presence: true
  validates :token, presence: true
  validates :role, presence: true, inclusion: {
    in: ["member", "instructor", "admin"]
  }

  before_validation :ensure_authentication_token

  def self.find_or_create_from_omniauth(auth)
    account_keys = { uid: auth["uid"], provider: auth["provider"] }

    User.find_or_create_by(account_keys) do |user|
      user.email = auth["info"]["email"]
      user.username = auth["info"]["nickname"]
      user.name = auth["info"]["name"]
    end
  end

  def ensure_authentication_token
    if token.blank?
      self.token = SecureRandom.urlsafe_base64
    end
  end

  def instructor?
    role == "instructor"
  end

  def admin?
    role == "admin"
  end
end
