class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment

  validates :assignment, presence: true
  validates :user, presence: true
  validates :user, uniqueness: { scope: :assignment }
  validates :comment, length: { maximum: 5000 }
  validates :helpfulness, presence: true, numericality: {
    greater_than_or_equal_to: 1, less_than_or_equal_to: 5
  }
  validates :clarity, presence: true, numericality: {
    greater_than_or_equal_to: 1, less_than_or_equal_to: 5
  }
end
