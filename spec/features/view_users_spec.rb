require "rails_helper"

feature "view users" do
  context "as a user" do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      sign_in_as(user)
    end

    scenario "view auth settings on own page" do
      visit user_path(user)
      expect(page).to have_content(user.token)
    end

    scenario "cannot view auth token for other user" do
      other_user = FactoryGirl.create(:user)

      visit user_path(other_user)
      expect(page).to_not have_content(other_user.token)
    end
  end

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

    scenario "cannot view auth tokens for other user" do
      other_user = FactoryGirl.create(:user)

      visit user_path(other_user)
      expect(page).to_not have_content(other_user.token)
    end
  end
end
