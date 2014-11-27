class Announcement < ActiveRecord::Base
  belongs_to :team

  # validates :team, presence: true
  # validates :lesson, presence: true
  # validates :required, inclusion: [true, false]
  # validates :due_on, presence: true
end
