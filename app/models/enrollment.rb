class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  validates :user, presence: true, uniqueness: { scope: :course }
  validates :course, presence: true
  validates :role, presence: true, inclusion: {
    in: ["instructor", "student"]
  }
end
