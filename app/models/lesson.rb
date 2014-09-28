class Lesson < ActiveRecord::Base
  self.inheritance_column = :_type_disabled

  has_many :submissions

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :body, presence: true

  mount_uploader :archive, LessonUploader

  def to_param
    slug
  end

  def submissions_viewable_by(user)
    if user.admin?
      submissions
    else
      if submissions.has_submission_from?(user)
        submissions.where("user_id = ? OR public = true", user.id)
      else
        submissions.none
      end
    end
  end

  def self.search(query)
    where("searchable @@ plainto_tsquery(?)", query)
  end
end
