class CalendarEvent < ActiveRecord::Base
  validates :title, presence: true
  validates :from, presence: true
  validates :to, presence: true

  def self.recent
    where(from: 1.day.ago..1.day.from_now)
  end
end
