class Assignment < ActiveRecord::Base
  belongs_to :team
  belongs_to :lesson

  validates :team, presence: true
  validates :lesson, presence: true
  validates :required, inclusion: [true, false]
  validates :due_on, presence: true
end
