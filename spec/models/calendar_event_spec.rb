require "rails_helper"

RSpec.describe CalendarEvent, type: :model do
  it { should belong_to(:calendar) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:from) }
  it { should validate_presence_of(:to) }
end
