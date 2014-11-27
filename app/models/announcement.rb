class Announcement < ActiveRecord::Base
  belongs_to :team

  validates :team, presence: true
  validates :title, presence: true
  validates :description, presence: true
end
