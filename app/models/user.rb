class User < ActiveRecord::Base
  has_many :submissions, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :team_memberships, dependent: :destroy
  has_many :teams, through: :team_memberships
  has_many :assignments, through: :teams
  has_many :announcements, through: :teams
  has_many :assigned_lessons, through: :assignments, source: :lesson
  has_many :answers
  has_many :questions
  has_many :announcement_receipts
  has_many :question_queues

  has_many :identities,
    dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :token, presence: true
  validates :role, presence: true, inclusion: { in: ["member", "admin"] }

  before_validation :ensure_authentication_token

  def name
    [first_name, last_name].join(" ").strip
  end

  def to_param
    username
  end

  def ensure_authentication_token
    if token.blank?
      self.token = SecureRandom.urlsafe_base64
    end
  end

  def admin?
    role == "admin"
  end

  def has_completed_lesson?(lesson)
    lesson.submissions.has_submission_from?(self)
  end

  def belongs_to_org?(organization, oauth_token)
    if organization.nil? || organization.empty?
      true
    else
      github_orgs(oauth_token).any? { |org| org["login"] == organization }
    end
  end

  def calendars
    result = []
    teams.each do |team|
      result << team.calendar if team.calendar
    end
    result.uniq
  end

  def latest_announcements(count)
    announcements.
      joins("LEFT JOIN announcement_receipts ON announcements.id = announcement_receipts.announcement_id AND announcement_receipts.user_id = #{id}").
      where("announcement_receipts.id IS NULL").
      order(created_at: :desc).limit(count)
  end

  def core_assignments
     assignments.where(required: true).order(due_on: :asc)
  end

  def non_core_assignments
     assignments.where(required: false).order(due_on: :asc)
  end

  private

  def github_orgs(token)
    JSON.parse(Net::HTTP.get(github_orgs_url(token)))
  end

  def github_orgs_url(token)
    URI("https://api.github.com/users/#{username}/orgs?access_token=#{token}")
  end
end
