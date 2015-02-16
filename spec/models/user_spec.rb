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

      user.first_name = "Tony"
      user.last_name = "Montana"
      user.save!

      expect(user.token).to eq(original_token)
    end
  end

  context "requiring launch pass" do
    it "is required if I authenticate via github and I have connected" do
      user = FactoryGirl.create(:github_identity).user
      FactoryGirl.create(:launch_pass_identity, user: user)
      expect(user.require_launch_pass?({
        'provider' => 'github'
      })).to be(true)
    end

    it "is not required if I have only authenticated via github" do
      user = FactoryGirl.create(:github_identity).user
      expect(user.require_launch_pass?({
        'provider' => 'github'
      })).to be(false)
    end

    it "is not required if I authenticate via launch pass and I'm connected" do
      user = FactoryGirl.create(:launch_pass_identity).user
      expect(user.require_launch_pass?({
        'provider' => 'launch_pass'
      })).to be(false)
    end
  end
end
