class Course < ActiveRecord::Base
  belongs_to :creator, class_name: "User"

  validates :creator, presence: true
  validates :title, presence: true
end
