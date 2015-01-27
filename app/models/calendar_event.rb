class CalendarEvent < ActiveRecord::Base
  validates :title, presence: true
  validates :from, presence: true
  validates :to, presence: true

  def self.recent
    today = Time.now.beginning_of_day
    tomorrow = (today + 1.day).end_of_day
    where(from: today..tomorrow)
  end
end
