require "rails_helper"

RSpec.describe Calendar, type: :model do
  pending
  it { should have_many(:teams) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:cid) }

  describe "cid validation" do
    subject { FactoryGirl.create(:calendar) }
    it { should validate_uniqueness_of(:cid) }
  end

  context "Storing/Retrieving with Redis", :vcr do
    let(:redis) { Redis.new }
    let(:calendar) do
      FactoryGirl.create(:calendar, cid: ENV["DEFAULT_GOOGLE_CALENDAR_ID"])
    end

    before(:each) do
      time = DateTime.parse("2015/02/09 17:10 -0500")
      Timecop.travel(time)
    end

    after(:each) do
      redis.flushdb
      Timecop.return
    end

    it "stores events in Redis after a call to events" do
      calendar.events_json
      expect(redis.keys).to include(calendar.cid)
    end

    it "retrieves events from Redis if they exist" do
      fake_event_data = ["FAKE EVENT DATA"].to_json
      redis.set(calendar.cid, fake_event_data)
      expect(calendar.events_json).to eq(JSON.parse(fake_event_data))
    end
  end
end
