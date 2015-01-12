class PerceptionProblem < ActiveRecord::Base
  has_many :options, class_name: "PerceptionProblemOption"
  has_many :answers, class_name: "PerceptionProblemAnswer"

  validates :prompt, presence: true, length: { maximum: 5000 }

  def self.random
    order("RANDOM()").first
  end
end
