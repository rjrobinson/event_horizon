class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment
  has_many :comments

  validates :user, presence: true
  validates :assignment, presence: true
  validates :body, presence: true

  def inline_comments
    comments.where("line_number IS NOT NULL")
  end
end
