require "rails_helper"

RSpec.describe GoogleCalendarAdapter, { focus: true, vcr: true } do
  describe "#fetch_events" do
    let(:calendar) { GoogleCalendarAdapter.new(ENV["DEFAULT_CALENDAR_ID"]) }

    before(:each) do
      Timecop.travel(Time.parse("2015/02/05 10:00"))
    end

    it "should return a hash of events" do
      expect(calendar.fetch_events).to be_a Hash
    end
  end
end
