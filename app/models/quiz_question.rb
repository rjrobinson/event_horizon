class QuizQuestion < ActiveRecord::Base
  belongs_to :quiz

  validates :quiz, presence: true
  validates :prompt, presence: true, length: { maximum: 5000 }
end
