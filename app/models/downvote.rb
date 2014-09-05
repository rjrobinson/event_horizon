class Downvote < ActiveRecord::Base
  belongs_to :user
  belongs_to :submission

  validates :user, presence: true
  validates :submission, presence: true
  validates :value, presence: true, inclusion: [1, -1]
end
