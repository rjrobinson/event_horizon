require "rails_helper"

RSpec.describe Calendar, type: :model do
  it { should have_many(:teams) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:cid) }
end
