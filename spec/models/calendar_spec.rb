require "rails_helper"

RSpec.describe Calendar, type: :model do
  it { should have_many(:calendar_events) }
  it { should have_many(:events) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:cid) }
end
