class QuestionComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  validates :body, presence: true
  validates :user_id, presence: true
end
