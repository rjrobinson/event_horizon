class PerceptionProblemOption < ActiveRecord::Base
  belongs_to :perception_problem

  validates :perception_problem, presence: true
  validates :body, presence: true, length: { maximum: 5000 }
  validates :correct, inclusion: { in: [true, false] }
end
