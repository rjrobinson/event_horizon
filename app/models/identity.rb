class Identity < ActiveRecord::Base
  belongs_to :user

  validates :user,
    presence: true

  validates :uid,
    presence: true,
    uniqueness: { scope: :provider }

  validates :provider,
    presence: true,
    inclusion: { in: ['github', 'launch_pass'] }

  def self.find_or_create_from_omniauth(auth)
    account_keys = { uid: auth["uid"], provider: auth["provider"] }

    identity = find_or_initialize_by(account_keys)
    identity.user ||= User.new
    identity.user.email = auth["info"]["email"]
    identity.user.username = auth["info"]["nickname"]
    identity.user.name = auth["info"]["name"]
    identity.user.save!
    identity.save!
    identity
  end

end
