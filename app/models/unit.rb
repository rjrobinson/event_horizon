class Unit < ActiveRecord::Base
  validates :name, presence: true
  validates :description, length: { maximum: 1000 }
end
