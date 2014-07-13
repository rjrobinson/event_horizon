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
        expect(page).to have_link(user.username, user_path(user))
      end
    end

    scenario "view submissions for a single user" do
      user = FactoryGirl.create(:user)
      submissions = FactoryGirl.create_list(:submission, 2, user: user)

      visit user_path(user)

      submissions.each do |submission|
        expect(page).to have_link_href(submission_path(submission))
      end
    end
  end
end
