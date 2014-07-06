class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :submission

  validates :user, presence: true
  validates :submission, presence: true
  validates :body, presence: true
end
