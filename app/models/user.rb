class User < ActiveRecord::Base
  has_many :submissions
  has_many :ratings
  has_many :enrollments
  has_many :courses, through: :enrollments
  has_many :votes

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :provider, presence: true
  validates :token, presence: true
  validates :role, presence: true, inclusion: {
    in: ["member", "admin"]
  }

  before_validation :ensure_authentication_token

  def to_param
    username
  end

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

  def admin?
    role == "admin"
  end

  def has_completed_challenge?(challenge)
    challenge.submissions.has_submission_from?(self)
  end

  def belongs_to_org?(organization, oauth_token)
    if organization.nil? || organization.empty?
      true
    else
      github_orgs(oauth_token).any? { |org| org["login"] == organization }
    end
  end

  private

  def github_orgs(token)
    JSON.parse(Net::HTTP.get(github_orgs_url(token)))
  end

  def github_orgs_url(token)
    URI("https://api.github.com/users/#{username}/orgs?access_token=#{token}")
  end
end
