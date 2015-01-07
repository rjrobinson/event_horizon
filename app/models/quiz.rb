class Quiz < ActiveRecord::Base
  belongs_to :unit

  validates :unit, presence: true
  validates :name, presence: true
  validates :description, length: { maximum: 1000 }
end
