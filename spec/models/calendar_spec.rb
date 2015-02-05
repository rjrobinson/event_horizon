require "rails_helper"

RSpec.describe Calendar, type: :model do
  it { should have_many(:teams) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:cid) }

  context "Storing/Retrieving with Redis", vcr: true  do

    let(:redis) { Redis.new }
    let(:calendar) { FactoryGirl.build(:calendar) }

    after(:each) do
      redis.flushdb
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
