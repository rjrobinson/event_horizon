class PerceptionProblemAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :perception_problem
  belongs_to :perception_problem_option

  validates :user, presence: true
  validates :perception_problem, presence: true
  validates :perception_problem_option, presence: true

  def correct?
    perception_problem_option.correct?
  end
end
