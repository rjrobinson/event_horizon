class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  validates :user, presence: true, uniqueness: { scope: :course }
  validates :course, presence: true
end
