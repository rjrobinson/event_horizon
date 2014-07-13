require "rails_helper"

feature "view users" do
  context "as an admin" do
    let(:admin) { FactoryGirl.create(:admin) }

    before :each do
      sign_in_as(admin)
    end

    scenario "view list of registered users" do
      users = FactoryGirl.create_list(:user, 3)

      visit users_path

      users.each do |user|
        expect(page).to have_content(user.username)
      end
    end
  end
end
