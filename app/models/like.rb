class Like < ActiveRecord::Base
  belongs_to :submission, counter_cache: true
  belongs_to :user

  validates :submission, uniqueness:
    { scope: :user, message: "You already 'liked' that." }

  validate :submission_does_not_belong_to_user

  def submission_does_not_belong_to_user
    if submission.user == user
      errors.add(:user, "Don't be an egotist. Review someone else's submission.")
    end
  end
end
