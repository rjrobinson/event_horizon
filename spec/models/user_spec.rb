require "rails_helper"

describe User do
  describe ".find_or_create_from_omniauth" do
    let(:uid) { "123456" }
    let(:provider) { "github" }

    let(:auth_hash) do
      {
        "provider" => provider,
        "uid" => uid,
        "info" => {
          "nickname" => "boblob",
          "email" => "bob@example.com",
          "name" => "Bob Loblaw"
        }
      }
    end

    it "creates a new user" do
      user = User.find_or_create_from_omniauth(auth_hash)

      expect(user.uid).to eq(uid)
      expect(user.provider).to eq(provider)

      expect(user.email).to eq("bob@example.com")
      expect(user.username).to eq("boblob")
      expect(user.name).to eq("Bob Loblaw")

      expect(User.count).to eq(1)
    end

    it "finds an existing user" do
      FactoryGirl.create(:user, uid: uid, provider: provider)

      user = User.find_or_create_from_omniauth(auth_hash)
      expect(user.uid).to eq(uid)

      expect(User.count).to eq(1)
    end
  end
end
