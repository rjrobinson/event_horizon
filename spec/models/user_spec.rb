require "rails_helper"

describe User do
  it { should have_many(:identities).dependent(:destroy) }

  describe "token authentication" do
    it "generates a random token when first saving" do
      user = FactoryGirl.build(:user)
      expect(user.token).to eq(nil)

      user.save!
      expect(user.token).to_not eq(nil)
    end

    it "does not change token when updating a user" do
      user = FactoryGirl.create(:user)
      original_token = user.token

      user.name = "Tony Montana"
      user.save!

      expect(user.token).to eq(original_token)
    end
  end
end
