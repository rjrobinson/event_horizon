class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :submission

  validates :user, presence: true
  validates :submission, presence: true
  validates :body, presence: true
  validates :line_number,
            numericality: { greater_than_or_equal_to: 0 },
            allow_nil: true
end
