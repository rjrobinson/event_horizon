class Question < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, length: { in: 10..200 }
  validates :body, presence: true, length: { in: 15..10000 }
  validates :user, presence: true
end
