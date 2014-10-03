class Rating < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :user

  validates :lesson, presence: true
  validates :user, presence: true, uniqueness: { scope: :lesson }
  validates :comment, length: { maximum: 5000 }

  validates :helpfulness, presence: true, numericality: {
    greater_than_or_equal_to: 1, less_than_or_equal_to: 5
  }

  validates :clarity, presence: true, numericality: {
    greater_than_or_equal_to: 1, less_than_or_equal_to: 5
  }
end
