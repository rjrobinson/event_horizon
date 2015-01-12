class PerceptionProblem < ActiveRecord::Base
  has_many :options, class_name: "PerceptionProblemOption"

  validates :prompt, presence: true, length: { maximum: 5000 }
end
