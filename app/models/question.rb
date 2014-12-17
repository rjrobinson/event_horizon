class Question < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :title, length: { in: 10..150 }
  validates :body, length: { in: 10..10000 }
end
