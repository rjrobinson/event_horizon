class Quiz < ActiveRecord::Base
  belongs_to :unit
  has_many :questions, class_name: "QuizQuestion"

  validates :unit, presence: true
  validates :name, presence: true
  validates :description, length: { maximum: 1000 }
end
